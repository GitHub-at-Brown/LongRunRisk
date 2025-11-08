(* Test runner: executes all .wls tests in this folder (except itself) *)

Module[{testsDir, files},
  testsDir = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  files = Select[Sort@FileNames["*.wls", testsDir], FileBaseName[#] =!= "run-all" &];
  Print["Running ", Length[files], " test file(s) in ", testsDir, "...\n"];
  Do[
    Print["==> ", FileNameTake[f]];
    Get[f];
    , {f, files}
  ];
  Print["\nAll tests finished."];
]
