#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Aggregate runner for automated test suites.
   Skips interactive notebooks and CI test generators.
   Exports JUnit XML and JSON reports for CI artifact upload. *)

Module[
  {
    testsRoot, pacletRoot, buildDir, ignoreDirs, verbose, specificFiles,
    allTestFiles, testFiles, report,
    totalPassed, totalFailed, totalAborted, totalTests,
    exportJUnitXML, exportJSONReport, testResults
  },

  Needs["MUnit`"];

  testsRoot = DirectoryName[$InputFileName];

  pacletRoot = testsRoot;
  While[! FileExistsQ@FileNameJoin[{pacletRoot, "PacletInfo.wl"}] && pacletRoot =!= DirectoryName[pacletRoot],
    pacletRoot = DirectoryName[pacletRoot]
  ];

  If[! FileExistsQ@FileNameJoin[{pacletRoot, "PacletInfo.wl"}],
    Print["Could not locate PacletInfo.wl"];
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

  (* Print failure details if any *)
  If[totalFailed > 0,
    Module[{failedTests},
      failedTests = Select[Values[report["TestResults"]], #["Outcome"] === "Failure" &];
      Print["\n=== Failed Tests ==="];
      Scan[
        Print["  ", Replace[#["TestID"], _Missing -> "unknown"]] &,
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
