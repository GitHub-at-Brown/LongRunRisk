#!/usr/bin/env wolframscript
(* ::Package:: *)

(* Test inventory script - captures current option defaults before refactoring *)

Print["=== LongRunRisk Options Inventory ===\n"];

Needs["FernandoDuarte`LongRunRisk`"];

Print["Loading package..."];
Print["Context: ", $Context];
Print["ContextPath includes LongRunRisk: ", MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`*"]];
Print[""];

(* Helper to print options nicely *)
printOptions[sym_Symbol] := Module[{opts, name},
  name = SymbolName[sym];
  opts = Options[sym];
  If[opts === {},
    Print[name, ": No options defined"],
    Print[name, ":"];
    Scan[Print["  ", #] &, opts];
    Print[""];
  ]
];

printOptions[str_String, sym_Symbol] := Module[{opts},
  opts = Options[sym];
  If[opts === {},
    Print[str, ": No options defined"],
    Print[str, ":"];
    Scan[Print["  ", #] &, opts];
    Print[""];
  ]
];

(* === Entry Points === *)
Print["=== Entry Point Functions ===\n"];

printOptions["buildModels", FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels];
printOptions["buildModelsParallel", FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModelsParallel];
printOptions["yieldCurve", FernandoDuarte`LongRunRisk`Tools`NicePlots`yieldCurve];

(* === Computational Engine === *)
Print["=== Computational Engine Functions ===\n"];

printOptions["updateCoeffsSol", FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffsSol];
printOptions["updateCoeffs", FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs];
printOptions["checks", FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`checks];
printOptions["solveND", FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`solveND];
printOptions["getStartingValues", FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`getStartingValues];

printOptions["createDatabase", FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`createDatabase];
printOptions["uncondCovLongExo", FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`uncondCovLongExo];

printOptions["paramQuadSolve", FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve];
printOptions["simplifyWithDummySubstitution", FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`simplifyWithDummySubstitution];

(* === Model Functions === *)
Print["=== Model Processing Functions ===\n"];

printOptions["simplifyCoeffsSystem", FernandoDuarte`LongRunRisk`Model`ProcessModels`simplifyCoeffsSystem];
printOptions["solveCoeffsSystem", FernandoDuarte`LongRunRisk`Model`ProcessModels`solveCoeffsSystem];
printOptions["tryTransforms", FernandoDuarte`LongRunRisk`Model`ProcessModels`tryTransforms];

(* === Tools === *)
Print["=== Tool Functions ===\n"];

printOptions["buildKernel", FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel];
printOptions["bindUnary", FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary];
printOptions["findRootInterval", FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval];
printOptions["fastRoot", FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot];
printOptions["scanAndSolve", FernandoDuarte`LongRunRisk`Tools`FindRootOptim`scanAndSolve];
printOptions["extractIntervalsFromReduce", FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce];

printOptions["growth", FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth];
printOptions["g", FernandoDuarte`LongRunRisk`Tools`TimeAggregation`g];
printOptions["timeSeriesVector", FernandoDuarte`LongRunRisk`Tools`TimeAggregation`timeSeriesVector];

printOptions["visualizeCoeffs", FernandoDuarte`LongRunRisk`Tools`VisualizeCoeffs`visualizeCoeffs];
printOptions["checkModels", FernandoDuarte`LongRunRisk`Tools`PipelineMonitor`checkModels];

(* === Check for addCoeffsSolution options === *)
Print["=== Critical: addCoeffsSolution Options Check ===\n"];

Module[{addCoeffsSolutionSym},
  addCoeffsSolutionSym = ToExpression["FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution", StandardForm, Unevaluated];
  If[Head[addCoeffsSolutionSym] === Symbol,
    printOptions["addCoeffsSolution", addCoeffsSolutionSym],
    Print["addCoeffsSolution: Symbol not found"]
  ];
];

Print["\n=== Inventory Complete ==="];
