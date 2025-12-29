#!/usr/bin/env wolframscript
(* ::Package:: *)

(*
  Profile.wls - Profile LongRunRisk code with Instrumentation package

  Usage:
    wolframscript Scripts/Profile.wls -code 'ToNum["Rules", myModel, params]'
    wolframscript Scripts/Profile.wls -file path/to/script.wl
    wolframscript Scripts/Profile.wls -help

  Options:
    -code <expr>       Wolfram Language expression to profile
    -file <path>       File containing code to profile
    -setup <expr>      Setup code to run before profiling (e.g., variable definitions)
    -profile-setup     Include setup and package loading in profiling (default: exclude)
    -time-findroot     Track FindRoot calls with timing (workaround for System functions)
    -output <dir>      Output directory for reports (default: build/profiling)
    -help              Show this help message
*)

(* --- Parse command line arguments --- *)
$args = Rest[$ScriptCommandLine];

parseArgs[args_List] := Module[{result, i, key, val},
  result = <|
    "Code" -> None,
    "File" -> None,
    "Setup" -> None,
    "Output" -> None,
    "ProfileSetup" -> False,
    "TimeFindRoot" -> False,
    "Help" -> False
  |>;

  i = 1;
  While[i <= Length[args],
    key = args[[i]];
    Which[
      key === "-help" || key === "--help" || key === "-h",
        result["Help"] = True; i++,

      key === "-profile-setup",
        result["ProfileSetup"] = True; i++,

      key === "-time-findroot",
        result["TimeFindRoot"] = True; i++,

      key === "-code" && i < Length[args],
        result["Code"] = args[[i + 1]]; i += 2,

      key === "-file" && i < Length[args],
        result["File"] = args[[i + 1]]; i += 2,

      key === "-setup" && i < Length[args],
        result["Setup"] = args[[i + 1]]; i += 2,

      key === "-output" && i < Length[args],
        result["Output"] = args[[i + 1]]; i += 2,

      True,
        (* Assume bare argument is code *)
        If[result["Code"] === None,
          result["Code"] = key
        ];
        i++
    ]
  ];
  result
];

$options = parseArgs[$args];

(* --- Show help --- *)
If[$options["Help"] || ($options["Code"] === None && $options["File"] === None),
  Print["
Profile.wls - Profile LongRunRisk code with Instrumentation package

Usage:
  wolframscript Scripts/Profile.wls -code '<expr>'
  wolframscript Scripts/Profile.wls -file <path>

Options:
  -code <expr>       Wolfram Language expression to profile
  -file <path>       File containing code to profile
  -setup <expr>      Setup code to run before profiling (excluded from profiling by default)
  -profile-setup     Include setup and package loading in profiling
  -time-findroot     Track FindRoot calls with timing (System functions can't be instrumented)
  -output <dir>      Output directory for reports (default: build/profiling)
  -help              Show this help message

Examples:
  # Profile a simple expression
  wolframscript Scripts/Profile.wls -code 'Table[i^2, {i, 1000}]'

  # Profile with setup code (setup excluded from profiling)
  wolframscript Scripts/Profile.wls \\
    -setup 'myModel = Models[\"BansalYaron\"]; params = <||>' \\
    -code 'ToNum[\"Rules\", myModel, params]'

  # Include setup in profiling
  wolframscript Scripts/Profile.wls -profile-setup \\
    -setup 'myModel = Models[\"BansalYaron\"]' \\
    -code 'ToNum[\"Rules\", myModel, params]'

  # Profile code from a file
  wolframscript Scripts/Profile.wls -file Scripts/my-benchmark.wl

  # Include FindRoot timing (System functions can't be instrumented directly)
  wolframscript Scripts/Profile.wls -time-findroot \\
    -setup 'myModel = Models[\"BansalYaron\"]; params = <||>' \\
    -code 'ToNum[\"Rules\", myModel, params]'
"];
  Exit[0]
];

(* --- Configuration --- *)
$pacletRoot = DirectoryName[DirectoryName[$InputFileName]];
$buildDir = If[$options["Output"] =!= None,
  $options["Output"],
  FileNameJoin[{$pacletRoot, "build", "profiling"}]
];
$instrumentedDir = FileNameJoin[{$buildDir, "instrumented"}];

print[a___] := WriteString["stdout", a, "\n"];

print["LongRunRisk Profiler"];
print["===================="];
print["Paclet root: ", $pacletRoot];
print["Output directory: ", $buildDir];

(* --- Setup directories --- *)
If[DirectoryQ[$instrumentedDir],
  DeleteDirectory[$instrumentedDir, DeleteContents -> True]
];
CreateDirectory[$buildDir, CreateIntermediateDirectories -> True];

(* --- Load Instrumentation --- *)
print["\nLoading Instrumentation package..."];
Needs["Instrumentation`"];

(* --- Instrument the paclet --- *)
print["Instrumenting paclet (this may take a moment)..."];

ProfileInstrument[
  FileNameJoin[{$pacletRoot, "Kernel"}],
  FileNameJoin[{$instrumentedDir, "Kernel"}]
];

(* Copy PacletInfo.wl so instrumented code can be loaded as a paclet *)
CopyFile[
  FileNameJoin[{$pacletRoot, "PacletInfo.wl"}],
  FileNameJoin[{$instrumentedDir, "PacletInfo.wl"}]
];

(* Copy Resources if exists *)
If[DirectoryQ[FileNameJoin[{$pacletRoot, "Resources"}]],
  CopyDirectory[
    FileNameJoin[{$pacletRoot, "Resources"}],
    FileNameJoin[{$instrumentedDir, "Resources"}]
  ]
];

(* --- Load instrumented version --- *)
print["Loading instrumented paclet..."];
PacletDirectoryUnload[$pacletRoot];
PacletDirectoryLoad[$instrumentedDir];

$setupCode = $options["Setup"];
$profileSetup = $options["ProfileSetup"];

(*
  Two modes:
  1. Default: Load package and run setup OUTSIDE ProfileEvaluate (not profiled)
     - Only the target code is profiled
     - Cleaner results focused on your code
  2. -profile-setup: Load package and run setup INSIDE ProfileEvaluate
     - Package initialization and setup are also profiled
     - Useful for understanding full execution flow
*)

If[!$profileSetup,
  (* Default: run Needs and setup outside profiling *)
  print["Loading package (not profiled)..."];
  Needs["FernandoDuarte`LongRunRisk`"];

  If[$setupCode =!= None,
    print["Running setup code (not profiled)..."];
    Check[
      ToExpression[$setupCode],
      print["Error in setup code: ", $setupCode];
      Exit[1]
    ]
  ];
];

(* --- Determine code to profile --- *)
$codeToProfile = Which[
  $options["Code"] =!= None,
    $options["Code"],
  $options["File"] =!= None,
    If[!FileExistsQ[$options["File"]],
      print["Error: File not found: ", $options["File"]];
      Exit[1]
    ];
    ReadString[$options["File"]],
  True,
    print["Error: No code specified"];
    Exit[1]
];

print["\nCode to profile:"];
print["  ", StringTake[$codeToProfile, UpTo[200]],
  If[StringLength[$codeToProfile] > 200, "...", ""]];

(* --- Build expression to profile --- *)
$fullCode = If[$profileSetup,
  (* Include Needs + setup + code all inside ProfileEvaluate *)
  StringJoin[
    "Needs[\"FernandoDuarte`LongRunRisk`\"];\n",
    If[$setupCode =!= None, $setupCode <> ";\n", ""],
    $codeToProfile
  ],
  (* Only profile the target code *)
  $codeToProfile
];

(* --- Setup FindRoot timing if requested --- *)
$findRootTimings = {};
$timeFindRoot = $options["TimeFindRoot"];
$originalFindRootDownValues = {};

If[$timeFindRoot,
  print["\nFindRoot timing enabled - wrapping System`FindRoot..."];
  (* Save original FindRoot DownValues and create timing wrapper *)
  Unprotect[FindRoot];
  $originalFindRootDownValues = DownValues[FindRoot];

  (* Clear and define wrapper that uses Internal`InheritedBlock *)
  DownValues[FindRoot] = {
    HoldPattern[FindRoot[args___]] :> Module[{result, time},
      {time, result} = AbsoluteTiming[
        Internal`InheritedBlock[{FindRoot},
          Unprotect[FindRoot];
          DownValues[FindRoot] = $originalFindRootDownValues;
          Protect[FindRoot];
          FindRoot[args]
        ]
      ];
      AppendTo[$findRootTimings, <|
        "Time" -> time,
        "Args" -> Short[{args}, 2]
      |>];
      result
    ]
  };
  Protect[FindRoot];
];

(* --- Run profiling --- *)
print["\nRunning profiling (this may be slow due to instrumentation overhead)..."];
If[$profileSetup,
  print["Note: Package loading and setup ARE included in profiling."],
  print["Note: Only target code is profiled (use -profile-setup to include setup)."]
];
If[$timeFindRoot,
  print["Note: FindRoot calls are being timed separately."]
];
$startTime = AbsoluteTime[];

{$result, $profileData} = ProfileEvaluate[
  ToExpression[$fullCode]
];

$elapsed = AbsoluteTime[] - $startTime;
print["Profiling completed in ", Round[$elapsed, 0.1], " seconds"];

(* --- Check result --- *)
If[!MatchQ[$profileData, _Instrumentation`ProfileData],
  print["Warning: ProfileEvaluate did not return valid ProfileData"];
  print["Result type: ", Head[$profileData]];
  print["Expression result: ", Short[$result, 3]];
  Exit[1]
];

(* --- Process profiling data --- *)
print["\nProcessing profiling data..."];
$reportData = ProfileProcess[$profileData];

(* --- Save report data --- *)
$reportFile = FileNameJoin[{$buildDir, "profile-data.mx"}];
Export[$reportFile, $reportData];
print["Report data saved to: ", $reportFile];

(* --- Helper: format time with natural units --- *)
(* Input is in MICROSECONDS from Instrumentation package *)
(* Shows seconds for >= 0.01s, minutes for >= 60s *)
formatTime[microseconds_?NumericQ] := Module[{seconds = microseconds / 1000000.},
  Which[
    seconds < 0.01,     ToString[Round[seconds * 1000, 0.1]] <> " ms",
    seconds < 60,       ToString[Round[seconds, 0.001]] <> " s",
    seconds < 3600,     ToString[Round[seconds / 60, 0.01]] <> " min",
    True,               ToString[Round[seconds / 3600, 0.01]] <> " h"
  ]
];

(* --- Extract and sort profiling data --- *)
print["\n=== Profiling Summary (sorted by self-time) ===\n"];

(* Extract data from ProfileReportData - structure is ProfileReportData[{counts, selfTimes, totalTimes, <||>}] *)
$dataList = $reportData[[1]];

If[ListQ[$dataList] && Length[$dataList] >= 3,
  $counts = $dataList[[1]];
  $selfTimes = $dataList[[2]];
  $totalTimes = $dataList[[3]];

  If[AssociationQ[$counts] && AssociationQ[$selfTimes] && AssociationQ[$totalTimes],
    (* Build entries with all timing data *)
    $entries = KeyValueMap[
      Function[{key, count},
        <|
          "Name" -> ToString[key[[1]]],
          "File" -> FileNameTake[key[[2]], -2],
          "Line" -> key[[3]],
          "Count" -> count,
          "SelfTime" -> Lookup[$selfTimes, Key[key], 0],
          "TotalTime" -> Lookup[$totalTimes, Key[key], 0]
        |>
      ],
      $counts
    ];

    (* Filter out entries with zero time and sort by self-time descending *)
    $sorted = ReverseSortBy[
      Select[$entries, #["SelfTime"] > 0 || #["TotalTime"] > 0 &],
      #["SelfTime"] &
    ];

    If[Length[$sorted] > 0,
      (* Print top entries *)
      $topN = Min[30, Length[$sorted]];
      print[StringPadRight["Function", 40], " ",
            StringPadLeft["Self Time", 12], " ",
            StringPadLeft["Total Time", 12], " ",
            StringPadLeft["Calls", 8], " ",
            "Location"];
      print[StringJoin[Table["-", 100]]];

      Do[
        With[{row = $sorted[[i]]},
          print[
            StringPadRight[StringTake[row["Name"], UpTo[38]], 40], " ",
            StringPadLeft[formatTime[row["SelfTime"]], 12], " ",
            StringPadLeft[formatTime[row["TotalTime"]], 12], " ",
            StringPadLeft[ToString[row["Count"]], 8], " ",
            row["File"], ":", ToString[row["Line"]]
          ]
        ],
        {i, $topN}
      ];

      If[Length[$sorted] > $topN,
        print["\n... and ", Length[$sorted] - $topN, " more entries (see full report)"]
      ];

      (* Export sorted data as CSV - convert microseconds to seconds *)
      $csvFile = FileNameJoin[{$buildDir, "profile-summary.csv"}];
      Export[$csvFile,
        Prepend[
          Map[{#["Name"], #["File"], #["Line"], #["SelfTime"]/1000000., #["TotalTime"]/1000000., #["Count"]} &, $sorted],
          {"Function", "File", "Line", "SelfTime_sec", "TotalTime_sec", "Calls"}
        ],
        "CSV"
      ];
      print["\nCSV summary saved to: ", $csvFile];
    ,
      print["No functions with timing data recorded."];
      print["The profiled code may have executed too quickly or no instrumented functions were called."];
    ];
  ,
    print["ProfileReportData associations not in expected format."];
    print["Use the interactive ProfileReport notebook for detailed analysis."];
  ];
,
  print["ProfileReportData structure not in expected format."];
  print["Use the interactive ProfileReport notebook for detailed analysis."];
];

(* --- Report FindRoot timings if enabled --- *)
(* Helper for FindRoot timing (in seconds from AbsoluteTiming) *)
(* Shows seconds for >= 0.01s, minutes for >= 60s *)
formatTimeSeconds[seconds_?NumericQ] := Which[
  seconds < 0.01,     ToString[Round[seconds * 1000, 0.1]] <> " ms",
  seconds < 60,       ToString[Round[seconds, 0.001]] <> " s",
  seconds < 3600,     ToString[Round[seconds / 60, 0.01]] <> " min",
  True,               ToString[Round[seconds / 3600, 0.01]] <> " h"
];

If[$timeFindRoot && Length[$findRootTimings] > 0,
  print["\n=== FindRoot Timing Summary ===\n"];
  Module[{totalTime, sortedTimings, topN},
    totalTime = Total[$findRootTimings[[All, "Time"]]];
    print["Total FindRoot calls: ", Length[$findRootTimings]];
    print["Total FindRoot time: ", formatTimeSeconds[totalTime]];
    print["Average per call: ", formatTimeSeconds[totalTime / Length[$findRootTimings]]];

    (* Sort by time descending and show top calls *)
    sortedTimings = ReverseSortBy[$findRootTimings, #["Time"] &];
    topN = Min[10, Length[sortedTimings]];

    print["\nTop ", topN, " FindRoot calls by time:"];
    print[StringPadLeft["Time", 12], "  Arguments"];
    print[StringJoin[Table["-", 60]]];

    Do[
      With[{entry = sortedTimings[[i]]},
        print[
          StringPadLeft[formatTimeSeconds[entry["Time"]], 12], "  ",
          ToString[entry["Args"]]
        ]
      ],
      {i, topN}
    ];

    (* Export FindRoot timings *)
    $findRootFile = FileNameJoin[{$buildDir, "findroot-timings.csv"}];
    Export[$findRootFile,
      Prepend[
        Map[{#["Time"], ToString[#["Args"]]} &, sortedTimings],
        {"Time_sec", "Arguments"}
      ],
      "CSV"
    ];
    print["\nFindRoot timings saved to: ", $findRootFile];
  ];
,
  If[$timeFindRoot,
    print["\nNo FindRoot calls were made during profiling."]
  ]
];

(* --- Restore original FindRoot --- *)
If[$timeFindRoot,
  Unprotect[FindRoot];
  DownValues[FindRoot] = $originalFindRootDownValues;
  Protect[FindRoot];
];

(* --- Generate interactive report notebook --- *)
print["\nGenerating interactive report..."];

$notebookFile = FileNameJoin[{$buildDir, "ProfileReport.nb"}];

(* Try to generate notebook, handle headless mode *)
Quiet[
  Check[
    UsingFrontEnd[
      $reportNotebook = ProfileReport[$reportData];
      NotebookSave[$reportNotebook, $notebookFile];
      NotebookClose[$reportNotebook];
      print["Report notebook saved: ", $notebookFile];
    ],
    print["Note: Running headless - notebook generation skipped."];
    print["To view the report, run in a Mathematica notebook:"];
    print["  Needs[\"Instrumentation`\"];"];
    print["  reportData = Import[\"", $reportFile, "\"];"];
    print["  ProfileReport[reportData]"];
  ],
  {FrontEndObject::notavail}
];

print["\nProfiling complete!"];
print["Data saved to: ", $reportFile];
