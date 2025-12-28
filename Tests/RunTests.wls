#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Aggregate runner for automated test suites.
   Skips interactive notebooks and CI test generators.
   Exports JUnit XML and JSON reports for CI artifact upload.
   Emulates PacletCICD TestPaclet output for GitHub Actions integration. *)

Module[
  {
    testsRoot, pacletRoot, buildDir, ignoreDirs, verbose, specificFiles,
    allTestFiles, testFiles, report,
    totalPassed, totalFailed, totalAborted, totalTests,
    exportJUnitXML, exportJSONReport, testResults,
    isGitHubActions, ghOutput, ghSummary, setGHOutput, writeGHSummary
  },

  Needs["MUnit`"];

  (* Detect GitHub Actions environment *)
  isGitHubActions = StringQ[Environment["GITHUB_ACTIONS"]];
  ghOutput = Environment["GITHUB_OUTPUT"];
  ghSummary = Environment["GITHUB_STEP_SUMMARY"];

  (* Helper to set GitHub Actions output variables *)
  setGHOutput[name_String, value_] := If[
    isGitHubActions && StringQ[ghOutput],
    With[{stream = OpenAppend[ghOutput]},
      WriteString[stream, name <> "=" <> ToString[value] <> "\n"];
      Close[stream];
    ]
  ];

  (* Helper to write GitHub Actions step summary *)
  writeGHSummary[markdown_String] := If[
    isGitHubActions && StringQ[ghSummary],
    With[{stream = OpenAppend[ghSummary]},
      WriteString[stream, markdown];
      Close[stream];
    ]
  ];

  testsRoot = DirectoryName[$InputFileName];

  pacletRoot = testsRoot;
  While[! FileExistsQ@FileNameJoin[{pacletRoot, "PacletInfo.wl"}] && pacletRoot =!= DirectoryName[pacletRoot],
    pacletRoot = DirectoryName[pacletRoot]
  ];

  If[! FileExistsQ@FileNameJoin[{pacletRoot, "PacletInfo.wl"}],
    Print["::error::Could not locate PacletInfo.wl"];
    Quit[1];
  ];

  PacletDirectoryLoad[pacletRoot];

  (* Create build directory for test artifacts *)
  buildDir = FileNameJoin[{pacletRoot, "build", "test-results"}];
  If[!DirectoryQ[buildDir], CreateDirectory[buildDir]];

  ignoreDirs = {"InteractiveTests", "GenerateCITests"};

  verbose = MemberQ[$ScriptCommandLine, "--verbose" | "-v"];
  specificFiles = Select[$ScriptCommandLine, StringEndsQ[#, ".wlt"] &];

  allTestFiles = Sort @ FileNames["*.wlt", testsRoot, Infinity];
  allTestFiles = Select[allTestFiles, FreeQ[FileNameSplit[#], Alternatives @@ ignoreDirs] &];

  testFiles = If[specificFiles =!= {},
    Module[{resolved},
      resolved = Replace[specificFiles, f_ :> If[FileExistsQ[f], f, FileNameJoin[{testsRoot, f}]], {1}];
      Select[resolved, FileExistsQ]
    ],
    allTestFiles
  ];

  testFiles = Select[testFiles, FreeQ[FileNameSplit[#], Alternatives @@ ignoreDirs] &];

  If[testFiles === {},
    Print["No .wlt tests found outside ignored directories: ", StringRiffle[ignoreDirs, ", "]];
    Quit[1];
  ];

  report = TestReport[testFiles, "ProgressReporting" -> verbose];

  totalPassed = report["TestsSucceededCount"];
  totalFailed = report["TestsFailedCount"];
  totalAborted = Replace[report["TestsAbortedCount"], _Missing -> 0];
  totalTests = totalPassed + totalFailed + totalAborted;

  Print["Total: ", totalTests, ", Passed: ", totalPassed, ", Failed: ", totalFailed, ", Aborted: ", totalAborted,
    " (" <> ToString[NumberForm[100.0 * totalPassed / Max[1, totalTests], {4, 1}]] <> "%)"];

  (* Export JUnit XML for GitHub Actions integration *)
  exportJUnitXML[rep_, file_] := Module[
    {results, testcases, xml, totalTime},
    results = Values[rep["TestResults"]];
    totalTime = Total[Replace[#["AbsoluteTimeUsed"], _Missing -> 0] & /@ results];
    testcases = Map[
      Function[{tr},
        With[{
          name = Replace[tr["TestID"], _Missing -> "unknown"],
          time = Replace[tr["AbsoluteTimeUsed"], _Missing -> 0],
          outcome = tr["Outcome"]
        },
          XMLElement["testcase", {
            "name" -> ToString[name],
            "time" -> ToString[time],
            "classname" -> "LongRunRisk"
          },
            Switch[outcome,
              "Failure",
              {XMLElement["failure", {"message" -> "Test failed"}, {ToString[tr["ActualOutput"]]}]},
              "MessagesFailure",
              {XMLElement["failure", {"message" -> "Unexpected messages"}, {ToString[tr["ActualMessages"]]}]},
              "Error",
              {XMLElement["error", {"message" -> "Test error"}, {}]},
              _,
              {}
            ]
          ]
        ]
      ],
      results
    ];
    xml = XMLElement["testsuites", {}, {
      XMLElement["testsuite", {
        "name" -> "LongRunRisk",
        "tests" -> ToString[Length[results]],
        "failures" -> ToString[rep["TestsFailedCount"]],
        "errors" -> ToString[Replace[rep["TestsAbortedCount"], _Missing -> 0]],
        "time" -> ToString[totalTime]
      }, testcases]
    }];
    Export[file, xml, "XML"]
  ];

  (* Export JSON summary *)
  exportJSONReport[rep_, file_] := Module[
    {results, summary, details},
    results = Values[rep["TestResults"]];
    summary = <|
      "totalTests" -> Length[results],
      "passed" -> rep["TestsSucceededCount"],
      "failed" -> rep["TestsFailedCount"],
      "aborted" -> Replace[rep["TestsAbortedCount"], _Missing -> 0],
      "successRate" -> N[100 * rep["TestsSucceededCount"] / Max[1, Length[results]]],
      "timestamp" -> DateString["ISODateTime"]
    |>;
    details = Map[
      <|
        "testID" -> Replace[#["TestID"], _Missing -> "unknown"],
        "outcome" -> #["Outcome"],
        "time" -> Replace[#["AbsoluteTimeUsed"], _Missing -> 0]
      |> &,
      results
    ];
    Export[file, <|"summary" -> summary, "tests" -> details|>, "JSON"]
  ];

  (* Export artifacts *)
  Print["Exporting test artifacts to: ", buildDir];
  exportJUnitXML[report, FileNameJoin[{buildDir, "junit.xml"}]];
  exportJSONReport[report, FileNameJoin[{buildDir, "test-report.json"}]];
  Print["Artifacts exported successfully"];

  (* Set GitHub Actions output variables *)
  setGHOutput["tests_total", totalTests];
  setGHOutput["tests_passed", totalPassed];
  setGHOutput["tests_failed", totalFailed];
  setGHOutput["tests_aborted", totalAborted];
  setGHOutput["success_rate", ToString[NumberForm[100.0 * totalPassed / Max[1, totalTests], {5, 2}]]];

  (* Generate GitHub Actions step summary *)
  Module[{summaryMD, statusIcon, failedTests, successRate},
    successRate = 100.0 * totalPassed / Max[1, totalTests];
    statusIcon = If[totalFailed == 0 && totalAborted == 0, ":white_check_mark:", ":x:"];

    summaryMD = StringJoin[
      "## ", statusIcon, " Test Results\n\n",
      "| Metric | Count |\n",
      "|--------|-------|\n",
      "| Total Tests | ", ToString[totalTests], " |\n",
      "| :white_check_mark: Passed | ", ToString[totalPassed], " |\n",
      "| :x: Failed | ", ToString[totalFailed], " |\n",
      "| :warning: Aborted | ", ToString[totalAborted], " |\n",
      "| Success Rate | ", ToString[NumberForm[successRate, {5, 1}]], "% |\n\n"
    ];

    (* Add failed test details *)
    If[totalFailed > 0,
      failedTests = Select[Values[report["TestResults"]], #["Outcome"] =!= "Success" &];
      summaryMD = summaryMD <> "<details>\n<summary>:x: Failed Tests (" <> ToString[Length[failedTests]] <> ")</summary>\n\n";
      summaryMD = summaryMD <> "| Test ID | Outcome |\n|---------|--------|\n";
      Scan[
        Function[{tr},
          summaryMD = summaryMD <> "| `" <> ToString[Replace[tr["TestID"], _Missing -> "unknown"]] <>
            "` | " <> ToString[tr["Outcome"]] <> " |\n"
        ],
        Take[failedTests, UpTo[50]]
      ];
      If[Length[failedTests] > 50,
        summaryMD = summaryMD <> "\n*...and " <> ToString[Length[failedTests] - 50] <> " more*\n"
      ];
      summaryMD = summaryMD <> "\n</details>\n";
    ];

    writeGHSummary[summaryMD];
  ];

  (* Print failure details to console *)
  If[totalFailed > 0,
    Module[{failedTests},
      failedTests = Select[Values[report["TestResults"]], #["Outcome"] === "Failure" &];
      Print["\n=== Failed Tests ==="];
      Scan[
        Function[{tr},
          With[{testID = Replace[tr["TestID"], _Missing -> "unknown"]},
            (* Use GitHub Actions error annotation format *)
            If[isGitHubActions,
              Print["::error title=Test Failed::", testID],
              Print["  ", testID]
            ]
          ]
        ],
        Take[failedTests, UpTo[10]]
      ];
      If[Length[failedTests] > 10,
        Print["  ... and ", Length[failedTests] - 10, " more"]
      ];
    ]
  ];

  If[totalFailed > 0 || totalAborted > 0,
    Quit[1],
    Quit[0]
  ];
];
