(* ::Package:: *)

(* ::Section:: *)
(*Kernel/Tools/TimeAggregation.wl Tests*)


BeginTestSection["Kernel/Tools/TimeAggregation.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`"]

Needs["FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"];

(* ::Subsection:: *)
(*Load Test Helpers*)


Get[FileNameJoin[{DirectoryName[$TestFileName, 2], "Common.wl"}]];


(* ::Subsection:: *)
(*Private Symbol References*)


(* Reference private symbols for testing *)
$g = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g;
$timeSeriesVector = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`timeSeriesVector;
$gt = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`gt;


(* ::Subsection:: *)
(*Context Loading Tests*)


(* Test: Context is on $ContextPath *)
TestCreate[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"],
	True,
	{},
	TestID -> "TimeAggregation-Context-OnContextPath"
]

(* Test: Public symbol growth is accessible *)
TestCreate[
	NameQ["FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth"],
	True,
	{},
	TestID -> "growth-Export-IsPublic"
]


(* ::Subsection:: *)
(*growth - Basic Identity Tests*)


(* Test: growth with default parameters returns identity *)
TestCreate[
	growth[dc, t] === dc[t],
	True,
	{},
	TestID -> "growth-DefaultParams-ReturnsIdentity"
]

(* Test: growth with explicit defaults returns identity *)
TestCreate[
	growth[dc, t, "TimeAggregation" -> 1, "numPeriods" -> 1] === dc[t],
	True,
	{},
	TestID -> "growth-ExplicitDefaults-ReturnsIdentity"
]


(* ::Subsection:: *)
(*growth - Tent-Shaped Coefficients Tests*)


(* Test: TimeAggregation=3 produces tent-shaped coefficients *)
TestCreate[
	growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1] ===
		1/3 (dc[-4 + t] + 2 dc[-3 + t] + 3 dc[-2 + t] + 2 dc[-1 + t] + dc[t]),
	True,
	{},
	TestID -> "growth-TimeAgg3-TentShapedCoefficients"
]

(* Test: TimeAggregation=12 produces correct coefficient pattern *)
(* Uses mathematical equivalence rather than structural matching for robustness *)
TestCreate[
	Module[{result, expected},
		result = growth[dc, t, "TimeAggregation" -> 12, "numPeriods" -> 1];
		(* Expected tent-shaped coefficients: 1/12, 2/12, ..., 11/12, 1, 11/12, ..., 1/12 *)
		expected = Sum[Min[j + 1, 23 - j]/12 * dc[t - j], {j, 0, 22}];
		PossibleZeroQ[Simplify[result - expected]]
	],
	True,
	{},
	TestID -> "growth-TimeAgg12-CoefficientPattern"
]


(* ::Subsection:: *)
(*growth - v0 Expansion Tests*)


(* Test: Constant v0 with 6 arguments yields expected result *)
TestCreate[
	Module[{result, expected},
		result = growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1,
			"v0" -> Function[{t, j, h, k, v, im}, 0.0015]];
		expected = 0.` + 0.3328334585207629` dc[-4 + t] + 0.6661665418542368` dc[-3 + t] +
			dc[-2 + t] + 0.6671665414792372` dc[-1 + t] + 0.33383345814576315` dc[t];
		(* Test with tolerance for numerical equality *)
		Chop[result - expected, 10^-10] === 0
	],
	True,
	{},
	TestID -> "growth-ConstantV0-NumericalResult"
]

(* Test: v0 as function of h with h=3 excludes h12 symbol *)
TestCreate[
	FreeQ[growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1,
		"v0" -> Function[{t, j, h, k, v, im}, If[h == 12, h12, hnot12]]], h12],
	True,
	{},
	TestID -> "growth-V0FunctionOfH-H3ExcludesH12"
]

(* Test: v0 as function of h with h=12 excludes hnot12 symbol *)
TestCreate[
	FreeQ[growth[dc, t, "TimeAggregation" -> 12, "numPeriods" -> 1,
		"v0" -> Function[{t, j, h, k, v, im}, If[h == 12, h12, hnot12]]], hnot12],
	True,
	{},
	TestID -> "growth-V0FunctionOfH-H12ExcludesHnot12"
]


(* ::Subsection:: *)
(*growth - Constant Term Tests*)


(* Test: v0 independent of j gives constant term 0 *)
TestCreate[
	Module[{result},
		result = Coefficient[growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1,
			"v0" -> Function[{t, j, h, k, v, im}, -1/(h + 1)]] /. dc[__] -> dcX, dcX, 0];
		0 === Simplify[result]
	],
	True,
	{},
	TestID -> "growth-V0IndepOfJ-ConstantTermZero"
]

(* Test: v0 independent of j with numPeriods=3 gives constant term 0 *)
TestCreate[
	Module[{result},
		result = Coefficient[growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 3,
			"v0" -> Function[{t, j, h, k, v, im}, h^2]] /. dc[__] -> dcX, dcX, 0];
		0 === Simplify[result]
	],
	True,
	{},
	TestID -> "growth-V0SquaredH-ConstantTermZero"
]

(* Test: v0 dependent on j may have non-zero constant term *)
TestCreate[
	Module[{result},
		result = Coefficient[growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 3,
			"v0" -> Function[{t, j, h, k, v, im}, j]] /. dc[__] -> dcX, dcX, 0];
		0 =!= N[result]
	],
	True,
	{},
	TestID -> "growth-V0DependsOnJ-ConstantTermNonZero"
]


(* ::Subsection:: *)
(*growth - Variable Type v0 Tests*)


(* Test: v0 responds to dc variable type *)
TestCreate[
	Not@FreeQ[growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1,
		"v0" -> Function[{t, j, h, k, v, im}, If[v === dc, Edc, 0]]], Edc],
	True,
	{},
	TestID -> "growth-V0VarType-DcUsesEdc"
]

(* Test: v0 with pi variable does not use Edc *)
TestCreate[
	FreeQ[growth[pi, t, "TimeAggregation" -> 3, "numPeriods" -> 1,
		"v0" -> Function[{t, j, h, k, v, im}, If[v === dc, Edc, 0]]], Edc],
	True,
	{},
	TestID -> "growth-V0VarType-PiExcludesEdc"
]

(* Test: v0 responds to dd variable type *)
TestCreate[
	Not@FreeQ[growth[dd, t, i, "TimeAggregation" -> 12, "numPeriods" -> 1,
		"v0" -> Function[{t, j, h, k, v, im}, If[v === dd, Edd, 0]]], Edd],
	True,
	{},
	TestID -> "growth-V0VarType-DdUsesEdd"
]

(* Test: v0 with dc variable does not use Edd *)
TestCreate[
	FreeQ[growth[dc, t, "TimeAggregation" -> 12, "numPeriods" -> 1,
		"v0" -> Function[{t, j, h, k, v, im}, If[v === dd, Edd, 0]]], Edd],
	True,
	{},
	TestID -> "growth-V0VarType-DcExcludesEdd"
]


(* ::Subsection:: *)
(*growth - Order Parameter Tests*)


(* Test: Order=0 produces no dc terms *)
TestCreate[
	FreeQ[Expand@growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 0], dc[__]],
	True,
	{},
	TestID -> "growth-Order0-NoDcTerms"
]

(* Test: Order=1 produces max power 1 *)
TestCreate[
	Max@Cases[Expand@growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 1],
		coef_. *dc[__]^p_. :> p] === 1,
	True,
	{},
	TestID -> "growth-Order1-MaxPower1"
]

(* Test: Order=2 produces max power 2 *)
TestCreate[
	Max@Cases[Expand@growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 2],
		coef_. *dc[__]^p_. :> p] === 2,
	True,
	{},
	TestID -> "growth-Order2-MaxPower2"
]

(* Test: Order=3 produces max power 3 *)
TestCreate[
	Max@Cases[Expand@growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 3],
		coef_. *dc[__]^p_. :> p] === 3,
	True,
	{},
	TestID -> "growth-Order3-MaxPower3"
]

(* Test: Order parameter with indexed variable dd *)
TestCreate[
	FreeQ[Expand@growth[dd, t, i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 0], dd[__, i]],
	True,
	{},
	TestID -> "growth-Order0Indexed-NoDdTerms"
]

(* Test: Order=1 with indexed variable dd *)
TestCreate[
	Max@Cases[Expand@growth[dd, t, i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 1],
		coef_. *dd[__, i]^p_. :> p] === 1,
	True,
	{},
	TestID -> "growth-Order1Indexed-MaxPower1"
]


(* ::Subsection:: *)
(*gt - Basic Tests*)


(* Test: gt with default parameters *)
TestCreate[
	$gt[dc, t] === dc[t],
	True,
	{},
	TestID -> "gt-DefaultParams-ReturnsIdentity"
]

(* Test: gt with list form options *)
TestCreate[
	Module[{result, expected},
		result = $gt[dc, t, {"TimeAggregation" -> 3, "numPeriods" -> 2}];
		expected = dc[-5 + t] + dc[-4 + t] + dc[-3 + t] + dc[-2 + t] + dc[-1 + t] + dc[t] -
			Log[1 + E^(-dc[-7 + t] - dc[-6 + t]) + E^-dc[-6 + t]] +
			Log[1 + E^(-dc[-1 + t] - dc[t]) + E^-dc[t]];
		result === expected
	],
	True,
	{},
	TestID -> "gt-ListFormOptions-CorrectResult"
]

(* Test: gt with indexed variable dd *)
TestCreate[
	Module[{result, expected},
		result = $gt[dd, t, i, {"TimeAggregation" -> 3, "numPeriods" -> 2}];
		expected = dd[-5 + t, i] + dd[-4 + t, i] + dd[-3 + t, i] + dd[-2 + t, i] + dd[-1 + t, i] + dd[t, i] -
			Log[1 + E^(-dd[-7 + t, i] - dd[-6 + t, i]) + E^-dd[-6 + t, i]] +
			Log[1 + E^(-dd[-1 + t, i] - dd[t, i]) + E^-dd[t, i]];
		result === expected
	],
	True,
	{},
	TestID -> "gt-IndexedVariable-CorrectResult"
]


(* ::Subsection:: *)
(*gt - Stock Variable Tests*)


(* Test: gt with Variable->Stock returns identity *)
TestCreate[
	$gt[dc, t, "Variable" -> "Stock"] === dc[t],
	True,
	{},
	TestID -> "gt-StockDefault-ReturnsIdentity"
]

(* Test: gt with Variable->Stock and TimeAggregation=3 *)
TestCreate[
	$gt[dc, t, "TimeAggregation" -> 3, "Variable" -> "Stock"] === dc[-2 + t] + dc[-1 + t] + dc[t],
	True,
	{},
	TestID -> "gt-StockTimeAgg3-SimpleSum"
]

(* Test: gt with indexed variable and Variable->Stock *)
TestCreate[
	$gt[dd, t, i, {"numPeriods" -> 2}, "Variable" -> "Stock"] === dd[-1 + t, i] + dd[t, i],
	True,
	{},
	TestID -> "gt-StockIndexed-NumPeriods2"
]

(* Test: gt with combined options for Stock *)
TestCreate[
	Module[{result, expected},
		result = $gt[dc, t, {"TimeAggregation" -> 3, "numPeriods" -> 2}, "Variable" -> "Stock"];
		expected = dc[-5 + t] + dc[-4 + t] + dc[-3 + t] + dc[-2 + t] + dc[-1 + t] + dc[t];
		result === expected
	],
	True,
	{},
	TestID -> "gt-StockCombinedOptions-SimpleSum"
]


(* ::Subsection:: *)
(*g - Basic timeSeriesVector Tests*)


(* Test: g with timeSeriesVector for flow variables *)
TestCreate[
	Module[{result, expected},
		result = $g[$timeSeriesVector[dc, t, "TimeAggregation" -> 3], 3];
		expected = dc[-2 + t] + dc[-1 + t] + dc[t] -
			Log[1 + E^(-dc[-4 + t] - dc[-3 + t]) + E^-dc[-3 + t]] +
			Log[1 + E^(-dc[-1 + t] - dc[t]) + E^-dc[t]];
		result === expected
	],
	True,
	{},
	TestID -> "g-TimeSeriesVectorFlow-CorrectResult"
]

(* Test: g with numPeriods option *)
TestCreate[
	$g[$timeSeriesVector[dc, t, "numPeriods" -> 1], 1, 1] === dc[t],
	True,
	{},
	TestID -> "g-NumPeriods1-ReturnsIdentity"
]


(* ::Subsection:: *)
(*g - Unevaluated for Wrong Length Tests*)


(* Test: g returns unevaluated for wrong vector length *)
TestCreate[
	$g[$timeSeriesVector[dc, t], 3] ===
		FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{dc[t]}, 3],
	True,
	{},
	TestID -> "g-WrongVectorLength-ReturnsUnevaluated"
]

(* Test: g with truncated vector returns unevaluated *)
TestCreate[
	$g[$timeSeriesVector[dc, t, "TimeAggregation" -> 3][[;; -2]], 3] ===
		FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[
			{dc[t], dc[-1 + t], dc[-2 + t], dc[-3 + t]}, 3],
	True,
	{},
	TestID -> "g-TruncatedVector-ReturnsUnevaluated"
]


(* ::Subsection:: *)
(*g - Variable Stock Tests*)


(* Test: g with Variable->Stock returns simple sum *)
TestCreate[
	$g[$timeSeriesVector[dc, t, "TimeAggregation" -> 3], 3, "Variable" -> "Stock"] ===
		dc[-2 + t] + dc[-1 + t] + dc[t],
	True,
	{},
	TestID -> "g-Stock-SimpleSum"
]

(* Test: g with truncated vector for Stock *)
TestCreate[
	$g[$timeSeriesVector[dc, t, "TimeAggregation" -> 3][[;; 3]], 3, "Variable" -> "Stock"] ===
		dc[-2 + t] + dc[-1 + t] + dc[t],
	True,
	{},
	TestID -> "g-StockTruncated-SimpleSum"
]


(* ::Subsection:: *)
(*g - Indexed Variable Tests*)


(* Test: g with dd variable (indexed) *)
TestCreate[
	$g[$timeSeriesVector[dd, t, i], 1] === dd[t, i],
	True,
	{},
	TestID -> "g-IndexedDefault-ReturnsIdentity"
]

(* Test: g with indexed variable and TimeAggregation *)
TestCreate[
	Module[{result, expected},
		result = $g[$timeSeriesVector[dd, t, i, "TimeAggregation" -> 3], 3];
		expected = dd[-2 + t, i] + dd[-1 + t, i] + dd[t, i] -
			Log[1 + E^(-dd[-4 + t, i] - dd[-3 + t, i]) + E^-dd[-3 + t, i]] +
			Log[1 + E^(-dd[-1 + t, i] - dd[t, i]) + E^-dd[t, i]];
		result === expected
	],
	True,
	{},
	TestID -> "g-IndexedTimeAgg3-CorrectResult"
]


(* ::Subsection:: *)
(*g - Bond Returns Tests*)


(* Test: g with bondret variable *)
TestCreate[
	Module[{result, expected},
		result = $g[$timeSeriesVector[bondret, t, m, "TimeAggregation" -> 3], 3];
		expected = bondret[-2 + t, m] + bondret[-1 + t, m] + bondret[t, m] -
			Log[1 + E^(-bondret[-4 + t, m] - bondret[-3 + t, m]) + E^-bondret[-3 + t, m]] +
			Log[1 + E^(-bondret[-1 + t, m] - bondret[t, m]) + E^-bondret[t, m]];
		result === expected
	],
	True,
	{},
	TestID -> "g-BondRetTimeAgg3-CorrectResult"
]

(* Test: g with bondret numPeriods *)
TestCreate[
	$g[$timeSeriesVector[bondret, t, m, "numPeriods" -> 1], 1, 1] === bondret[t, m],
	True,
	{},
	TestID -> "g-BondRetNumPeriods1-ReturnsIdentity"
]


(* ::Subsection:: *)
(*timeSeriesVector - Basic Tests*)


(* Test: timeSeriesVector with defaults *)
TestCreate[
	$timeSeriesVector[dc, t] === {dc[t]},
	True,
	{},
	TestID -> "timeSeriesVector-Default-SingleElement"
]

(* Test: timeSeriesVector with TimeAggregation=3 *)
TestCreate[
	$timeSeriesVector[dc, t, "TimeAggregation" -> 3] ===
		{dc[t], dc[-1 + t], dc[-2 + t], dc[-3 + t], dc[-4 + t]},
	True,
	{},
	TestID -> "timeSeriesVector-TimeAgg3-FiveElements"
]

(* Test: timeSeriesVector with numPeriods=6 *)
TestCreate[
	$timeSeriesVector[dc, t, "numPeriods" -> 6] ===
		{dc[t], dc[-1 + t], dc[-2 + t], dc[-3 + t], dc[-4 + t], dc[-5 + t]},
	True,
	{},
	TestID -> "timeSeriesVector-NumPeriods6-SixElements"
]

(* Test: timeSeriesVector with combined options has correct length *)
TestCreate[
	Length[$timeSeriesVector[dc, t, {"TimeAggregation" -> 12, "numPeriods" -> 3}]] === 47,
	True,
	{},
	TestID -> "timeSeriesVector-CombinedOptions-47Elements"
]

(* Test: timeSeriesVector list and rule forms equivalent *)
TestCreate[
	$timeSeriesVector[dc, t, {"TimeAggregation" -> 12, "numPeriods" -> 3}] ===
		$timeSeriesVector[dc, t, "TimeAggregation" -> 12, "numPeriods" -> 3],
	True,
	{},
	TestID -> "timeSeriesVector-ListRuleEquivalent-SameResult"
]


End[]
EndTestSection[]
