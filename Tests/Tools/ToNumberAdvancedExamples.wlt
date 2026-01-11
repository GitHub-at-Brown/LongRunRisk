(* ::Package:: *)

(* ::Section:: *)
(*ToNum Advanced Examples Tests*)

BeginTestSection["ToNum Advanced Examples Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`ToNumberAdvanced`"]

Needs["FernandoDuarte`LongRunRisk`Tools`ToNumber`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];

(* ::Subsection:: *)
(*Load Test Helpers*)

Get @ FileNameJoin[{DirectoryName[$TestFileName, 2], "TestHelpers.wl"}];
Get @ FileNameJoin[{DirectoryName[$TestFileName, 1], "ToolsTestHelpers.wl"}];

(* ::Subsection:: *)
(*Test Helpers*)

(* Returns True if evaluation of expr returns $Aborted *)
SetAttributes[checkAbrt, HoldAll];
checkAbrt[expr_] := TrueQ @ Quiet @ CheckAbort[expr, True];


(* ::Subsection:: *)
(*ToNum Advanced Examples Tests*)

TestCreate[
	Module[{baseRules, overrideRules, gammaBase, gammaOverride}, baseRules = ToNum["Rules", $modBY]; overrideRules = ToNum["Rules", $modBY, {gamma -> 15.}]; gammaBase = Cases[baseRules, HoldPattern[gamma -> v_] :> v, Infinity]; gammaOverride = Cases[overrideRules, HoldPattern[gamma -> v_] :> v, Infinity]; Length[gammaBase] > 0 && Length[gammaOverride] > 0 && First[gammaBase] != First[gammaOverride]],
	True,
	{},
	TestID -> "[ToNum] Single parameter override changes output rules"
]

TestCreate[
	Module[{baseRules, multiOverride}, baseRules = ToNum["Rules", $modBY]; multiOverride = ToNum["Rules", $modBY, {gamma -> 12., psi -> 2.5}]; multiOverride =!= baseRules],
	True,
	{},
	TestID -> "[ToNum] Multiple parameter override changes output rules"
]

TestCreate[
	Module[{exprTest, baseExprValue, overrideExprValue}, exprTest = A[0] + A[1]; baseExprValue = ToNum[exprTest, $modBY]; overrideExprValue = ToNum[exprTest, $modBY, {gamma -> 20.}]; NumericQ[baseExprValue] && NumericQ[overrideExprValue] && baseExprValue != overrideExprValue],
	True,
	{},
	TestID -> "[ToNum] Parameter override affects expression evaluation"
]

TestCreate[
	checkAbrt[ToNum["Rules", $modBY, {invalidParameterName -> 1.}]],
	True,
	{},
	TestID -> "[ToNum] Invalid parameter name aborts"
]

TestCreate[
	Module[{stringKeyResult}, stringKeyResult = CheckAbort[ToNum["Rules", $modBY, {"gamma" -> 15.}], $Aborted]; stringKeyResult === $Aborted || FailureQ[stringKeyResult]],
	True,
	{Rest::normal, Rest::normal, processNewParameters::subsetparam},
	TestID -> "[ToNum] String keys for parameters fail"
]

TestCreate[
	Module[{largeExpr, largeResult}, largeExpr = Sum[A[i], {i, 0, 2}] + B[1][0] + B[1][1] + B[1][2]; largeResult = ToNum[largeExpr, $modBY]; NumericQ[largeResult] &&  !FailureQ[largeResult]],
	True,
	{},
	TestID -> "[ToNum] Complex expression evaluates to numeric"
]

TestCreate[
	FailureQ[ToNum["Rules", $modBY, "ReturnAllSolutions" -> "true"]],
	True,
	{toNum::badreturnall},
	TestID -> "[ToNum] ReturnAllSolutions string value fails"
]

TestCreate[
	FailureQ[ToNum["Rules", $modBY, "ReturnAllSolutions" -> 1]],
	True,
	{toNum::badreturnall},
	TestID -> "[ToNum] ReturnAllSolutions integer value fails"
]

TestCreate[
	AllTrue[Values[$testModels], MatchQ[ToNum["Rules", #1], {__Rule}] & ],
	True,
	{},
	TestID -> "[ToNum] All models produce valid flat rules"
]

TestCreate[
	AllTrue[Values[$testModels], MatchQ[ToNum["Rules", #1, "ReturnAllSolutions" -> True], {__Association}] & ],
	True,
	{},
	TestID -> "[ToNum] All models produce valid hierarchical solutions"
]

TestCreate[
	AllTrue[Values[$testModels], NumericQ[ToNum[A[0], #1]] & ],
	True,
	{},
	TestID -> "[ToNum] A[0] is numeric for all models"
]

TestCreate[
	$modBY["numStocks"],
	1,
	{},
	TestID -> "[Model] BY has 1 stock"
]

TestCreate[
	$modBKY["numStocks"],
	1,
	{},
	TestID -> "[Model] BKY has 1 stock"
]

TestCreate[
	$modNRC["numStocks"],
	3,
	{},
	TestID -> "[Model] NRC has 3 stocks"
]

TestCreate[
	Length[$modDES["stateVars"][t]],
	7,
	{},
	TestID -> "[Model] DES has 7 state variables"
]

TestCreate[
	AllTrue[Select[Values[$testModels], #1["numStocks"] > 0 & ], NumericQ[ToNum[B[1][0], #1]] & ],
	True,
	{},
	TestID -> "[ToNum] B[1][0] is numeric for all models with stocks"
]

TestCreate[
	Module[{expr, result}, expr = A[0] + 2*A[1] + 3*A[2]; result = ToNum[expr, $modNRC]; NumericQ[result]],
	True,
	{},
	TestID -> "[ToNum] Multiple A terms evaluate to numeric"
]

TestCreate[
	Module[{expr, result}, expr = B[1][0] + B[1][1] + B[1][2]; result = ToNum[expr, $modNRC]; NumericQ[result]],
	True,
	{},
	TestID -> "[ToNum] Multiple B terms evaluate to numeric"
]

TestCreate[
	Module[{expr, result}, expr = A[0] + A[1] + B[1][0] + B[1][1]; result = ToNum[expr, $modNRC]; NumericQ[result]],
	True,
	{},
	TestID -> "[ToNum] Mixed A and B terms evaluate to numeric"
]

TestCreate[
	Module[{expr, result}, expr = Sum[A[i], {i, 0, 2}] + Sum[B[1][j], {j, 0, 2}]; result = ToNum[expr, $modNRC]; NumericQ[result]],
	True,
	{},
	TestID -> "[ToNum] Summation expressions evaluate to numeric"
]

End[]
EndTestSection[]
