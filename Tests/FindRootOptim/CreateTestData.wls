#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Script to generate fast binary TestData.mx from TestDataSource.wl *)
(* This is completely self-contained - no external dependencies *)

Module[{testDir, sourceFile, binaryFile, startTime, endTime},
  (* Get test directory *)
  testDir = DirectoryName[$InputFileName];
  sourceFile = FileNameJoin[{testDir, "TestDataSource.wl"}];
  binaryFile = FileNameJoin[{testDir, "TestData.mx"}];

  Print["================================================="];
  Print["Creating Binary Test Data"];
  Print["================================================="];

  (* Check source file exists *)
  If[!FileExistsQ[sourceFile],
    Print["ERROR: TestDataSource.wl not found!"];
    Print["Expected: ", sourceFile];
    Quit[1];
  ];

  Print["Source file: ", sourceFile];
  Print["Source size: ", NumberForm[N[FileByteCount[sourceFile]/1024^2], {5, 2}], " MB"];
  Print[""];

  (* Load source data *)
  Print["Loading source data..."];
  startTime = AbsoluteTime[];
  Get[sourceFile];
  endTime = AbsoluteTime[];
  Print["Loaded in ", NumberForm[endTime - startTime, {4, 2}], " seconds"];
  Print[""];

  (* Save as binary *)
  Print["Saving binary data to: ", binaryFile];
  startTime = AbsoluteTime[];

  DumpSave[binaryFile, {
    (* Equations and expressions *)
    eqA0, eqAB0, exprA, exprAB,
    (* Parameters *)
    modelParams, paramA, paramAB,
    (* Assumptions *)
    assumeA, assumeB, assumeAB,
    (* Conditions *)
    conditionsA, conditionsB, condA, condAB,
    (* Parameter values *)
    paramsA, paramsAB,
    (* Signs *)
    signsA, signsAB, signsAassoc,
    (* Solutions *)
    solA, solAvals, solNA0, solNAB0
  }];

  endTime = AbsoluteTime[];
  Print["Saved in ", NumberForm[endTime - startTime, {4, 2}], " seconds"];
  Print[""];

  (* Report results *)
  Print["================================================="];
  Print["SUCCESS!"];
  Print["================================================="];
  Print["Binary file: ", binaryFile];
  Print["Binary size: ", NumberForm[N[FileByteCount[binaryFile]/1024^2], {5, 2}], " MB"];
  Print["Compression: ", NumberForm[100*(1 - FileByteCount[binaryFile]/FileByteCount[sourceFile]), {4, 1}], "%"];
  Print[""];
  Print["The test file will now load ",
        NumberForm[FileByteCount[sourceFile]/FileByteCount[binaryFile], {4, 1}],
        "x faster!"];
]
