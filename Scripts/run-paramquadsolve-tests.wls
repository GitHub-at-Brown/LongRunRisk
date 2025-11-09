#!/usr/bin/env wolframscript
(* Robust runner for ParamQuadSolve .wlt tests in a single kernel *)

Module[{start, d, pacletRoot, files, results = <||>, statuses, anyFail = False},
  (* Locate repo/paclet root by walking up to PacletInfo.wl *)
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d], d = DirectoryName[d]];
  pacletRoot = d;

  PacletDirectoryLoad[pacletRoot];

  files = Sort@FileNames["*.wlt", FileNameJoin[{pacletRoot, "Tests", "ParamQuadSolve"}], Infinity];
  Print["Found ", Length[files], " files\n"]; 

  Do[
    Module[{r, ok, name = FileNameTake[f]},
      r = TimeConstrained[TestReport[f], 120, $TimedOut];
      Which[
        r === $TimedOut,
          Print[name, ": TIMEOUT"]; anyFail = True; results[name] = "TIMEOUT",
        Head[r] === TestReportObject && TrueQ[r["AllTestsSucceeded"]],
          Print[name, ": PASS"]; results[name] = "PASS",
        Head[r] === TestReportObject,
          Print[name, ": FAIL"]; results[name] = "FAIL"; anyFail = True,
        True,
          Print[name, ": FAIL (no report)"]; results[name] = "FAIL"; anyFail = True
      ];
      (* keep memory reasonable between runs *)
      ClearSystemCache[];
    ],
    {f, files}
  ];

  Print["\nSummary:"];
  KeyValueMap[Print[#1, ": ", #2] &, results];

  If[anyFail, Exit[1], Exit[0]]
]
