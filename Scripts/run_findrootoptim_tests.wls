#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Find the paclet root (directory containing PacletInfo.wl) *)
pacletRoot = Module[{d = Directory[]},
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
    d = DirectoryName[d]
  ];
  d
];

If[! FileExistsQ@FileNameJoin[{pacletRoot, "PacletInfo.wl"}],
  Print["Could not locate PacletInfo.wl above ", Directory[], ". Exiting."]; Exit[1];
];

(* Load the paclet so private context is available *)
PacletDirectoryLoad[pacletRoot];

tests = FileNames["*.wlt", FileNameJoin[{pacletRoot, "Tests", "FindRootOptim"}]];
If[tests === {},
  Print["No .wlt tests found under Tests/FindRootOptim/."]; Exit[1];
];

report = TestReport[tests];

Print[report];

failures = report["TestsFailed"];
If[IntegerQ[failures] && failures > 0,
  Exit[1],
  Exit[0]
];
