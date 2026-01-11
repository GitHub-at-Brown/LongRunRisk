(* ::Package:: *)

(* ::Section:: *)
(*ToNum Advanced Examples Tests*)


BeginTestSection["ToNum Advanced Examples Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Docs`ToNumAdvancedExamples`"]

Needs["FernandoDuarte`LongRunRisk`Tools`ToNumber`"];


(* ::Subsection:: *)
(*Load Test Helpers*)


Get @ FileNameJoin[{DirectoryName[$TestFileName, 3], "Tests", "TestHelpers.wl"}];


(* ::Subsection:: *)
(*Local Test Helpers*)


(* Returns True if evaluation of expr returns $Aborted *)
SetAttributes[checkAbrt, HoldAll];
checkAbrt[expr_] := TrueQ @ Quiet @ CheckAbort[expr, True];


(* ::Subsection:: *)
(*Parameter Override Tests*)


(* Test: Override a single parameter and verify it changes in the output rules *)
TestCreate[
	Module[{baseRules, overrideRules, gammaBase, gammaOverride},
		baseRules = ToNum["Rules", $modBY];
		overrideRules = ToNum["Rules", $modBY, {gamma -> 15.0}];
		gammaBase = Cases[baseRules, HoldPattern[gamma -> v_] :> v, Infinity];
		gammaOverride = Cases[overrideRules, HoldPattern[gamma -> v_] :> v, Infinity];
		Length[gammaBase] > 0 && Length[gammaOverride] > 0 && First[gammaBase] != First[gammaOverride]
	],
	True,
	{},
	TestID -> "[ToNum] Single parameter override changes output rules"
]

(* Test: Override multiple parameters simultaneously *)
TestCreate[
	Module[{baseRules, multiOverride},
		baseRules = ToNum["Rules", $modBY];
		multiOverride = ToNum["Rules", $modBY, {gamma -> 12.0, psi -> 2.5}];
		multiOverride =!= baseRules
	],
	True,
	{},
	TestID -> "[ToNum] Multiple parameter override changes output rules"
]

(* Test: Use parameter overrides when evaluating expressions *)
TestCreate[
	Module[{exprTest, baseExprValue, overrideExprValue},
		exprTest = A[0] + A[1];
		baseExprValue = ToNum[exprTest, $modBY];
		overrideExprValue = ToNum[exprTest, $modBY, {gamma -> 20.0}];
		NumericQ[baseExprValue] && NumericQ[overrideExprValue] && baseExprValue != overrideExprValue
	],
	True,
	{},
	TestID -> "[ToNum] Parameter override affects expression evaluation"
]


(* ::Subsection:: *)
(*Invalid Parameter Tests*)


(* Test: Invalid parameter name should abort *)
TestCreate[
	checkAbrt[ToNum["Rules", $modBY, {invalidParameterName -> 1.0}]],
	True,
	{},
	TestID -> "[ToNum] Invalid parameter name aborts"
]

(* Test: String keys for parameters should fail *)
TestCreate[
	Module[{stringKeyResult},
		stringKeyResult = CheckAbort[
			ToNum["Rules", $modBY, {"gamma" -> 15.0}],
			$Aborted
		];
		stringKeyResult === $Aborted || FailureQ[stringKeyResult]
	],
	True,
	{},
	TestID -> "[ToNum] String keys for parameters fail"
]


(* ::Subsection:: *)
(*Complex Expression Tests*)


(* Test: Complex expression combining multiple terms across different state variables *)
TestCreate[
	Module[{largeExpr, largeResult},
		largeExpr = Sum[A[i], {i, 0, 2}] + B[1][0] + B[1][1] + B[1][2];
		largeResult = ToNum[largeExpr, $modBY];
		NumericQ[largeResult] && !FailureQ[largeResult]
	],
	True,
	{},
	TestID -> "[ToNum] Complex expression evaluates to numeric"
]


(* ::Subsection:: *)
(*ReturnAllSolutions Option Tests*)


(* Test: Invalid string value for ReturnAllSolutions option should fail *)
TestCreate[
	FailureQ[ToNum["Rules", $modBY, "ReturnAllSolutions" -> "true"]],
	True,
	{},
	TestID -> "[ToNum] ReturnAllSolutions string value fails"
]

(* Test: Invalid integer value for ReturnAllSolutions option should fail *)
TestCreate[
	FailureQ[ToNum["Rules", $modBY, "ReturnAllSolutions" -> 1]],
	True,
	{},
	TestID -> "[ToNum] ReturnAllSolutions integer value fails"
]


(* ::Subsection:: *)
(*Cross-Model Tests*)


(* Test: All models produce valid flat rules *)
TestCreate[
	AllTrue[Values[$testModels], MatchQ[ToNum["Rules", #], {__Rule}] &],
	True,
	{},
	TestID -> "[ToNum] All models produce valid flat rules"
]

(* Test: All models produce valid hierarchical solutions with ReturnAllSolutions *)
TestCreate[
	AllTrue[Values[$testModels], MatchQ[ToNum["Rules", #, "ReturnAllSolutions" -> True], {__Association}] &],
	True,
	{},
	TestID -> "[ToNum] All models produce valid hierarchical solutions"
]

(* Test: A[0] evaluates to numeric for all models *)
TestCreate[
	AllTrue[Values[$testModels], NumericQ[ToNum[A[0], #]] &],
	True,
	{},
	TestID -> "[ToNum] A[0] is numeric for all models"
]


(* ::Subsection:: *)
(*Model-Specific Tests*)


(* Test: BY model has 1 stock *)
TestCreate[
	$modBY["numStocks"],
	1,
	{},
	TestID -> "[Model] BY has 1 stock"
]

(* Test: BKY model has 2 stocks *)
TestCreate[
	$modBKY["numStocks"],
	2,
	{},
	TestID -> "[Model] BKY has 2 stocks"
]

(* Test: NRC model has 3 stocks *)
TestCreate[
	$modNRC["numStocks"],
	3,
	{},
	TestID -> "[Model] NRC has 3 stocks"
]

(* Test: DES model has 7 state variables *)
TestCreate[
	Length[$modDES["stateVars"]],
	7,
	{},
	TestID -> "[Model] DES has 7 state variables"
]


(* ::Subsection:: *)
(*B-Expression Tests*)


(* Test: B[1][0] is numeric for all models with stocks *)
TestCreate[
	AllTrue[
		Select[Values[$testModels], #["numStocks"] > 0 &],
		NumericQ[ToNum[B[1][0], #]] &
	],
	True,
	{},
	TestID -> "[ToNum] B[1][0] is numeric for all models with stocks"
]


(* ::Subsection:: *)
(*Combined Expression Tests*)


(* Test: Multiple A terms evaluate to numeric *)
TestCreate[
	Module[{expr, result},
		expr = A[0] + 2*A[1] + 3*A[2];
		result = ToNum[expr, $modNRC];
		NumericQ[result]
	],
	True,
	{},
	TestID -> "[ToNum] Multiple A terms evaluate to numeric"
]

(* Test: Multiple B terms evaluate to numeric *)
TestCreate[
	Module[{expr, result},
		expr = B[1][0] + B[1][1] + B[1][2];
		result = ToNum[expr, $modNRC];
		NumericQ[result]
	],
	True,
	{},
	TestID -> "[ToNum] Multiple B terms evaluate to numeric"
]

(* Test: Mixed A and B terms evaluate to numeric *)
TestCreate[
	Module[{expr, result},
		expr = A[0] + A[1] + B[1][0] + B[1][1];
		result = ToNum[expr, $modNRC];
		NumericQ[result]
	],
	True,
	{},
	TestID -> "[ToNum] Mixed A and B terms evaluate to numeric"
]

(* Test: Summation expressions evaluate to numeric *)
TestCreate[
	Module[{expr, result},
		expr = Sum[A[i], {i, 0, 2}] + Sum[B[1][j], {j, 0, 2}];
		result = ToNum[expr, $modNRC];
		NumericQ[result]
	],
	True,
	{},
	TestID -> "[ToNum] Summation expressions evaluate to numeric"
]

End[]
EndTestSection[]
