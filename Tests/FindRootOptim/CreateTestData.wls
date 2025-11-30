#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Script to generate fast binary TestData.mx from TestDataSource.wl *)
(* This is completely self-contained - no external dependencies *)

Module[{testDir, sourceFile, binaryFile, startTime, endTime},
  (* Get test directory *)
  testDir = DirectoryName[$InputFileName];
  sourceFile = FileNameJoin[{testDir, "TestDataSource.wl"}];
  binaryFile = FileNameJoin[{testDir, "TestData.mx"}];

  (* Check source file exists *)
  If[!FileExistsQ[sourceFile],
    Quit[1];
  ];

  (* Load source data *)
  startTime = AbsoluteTime[];
  Get[sourceFile];
  endTime = AbsoluteTime[];

  (* Save as binary *)
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
]
