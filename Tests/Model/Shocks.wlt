(* ::Package:: *)

(* ::Section:: *)
(*Kernel/Model/Shocks.wl Tests*)


BeginTestSection["Kernel/Model/Shocks.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Model`Shocks`"]

Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];
Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];

(* ::Subsection:: *)
(*Load Test Helpers*)


Scan[Get @ FileNameJoin[{DirectoryName[$TestFileName, #], "Common.wl"}] &, {2, 1}];


(* ::Subsection:: *)
(*Test Helpers*)


(* Shock names and indices used across tests - wrapped in Block to protect symbolic placeholders *)
$scalarShockNames = {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"};
Block[{i, j, t},
	$stockIndices = {1, i, j};

	(* Cache rulesE[t] to avoid repeated rule construction *)
	$rulesEt = rulesE[t];

	(* All scalar and stock shocks *)
	$allShocks = Join[
		eps[#][t] & /@ $scalarShockNames,
		eps["dd"][t, #] & /@ $stockIndices
	];
];

(* Helper for testing unevaluated expressions *)
unevaluatedQ[expr_] := (expr /. $rulesEt) === expr;


(* ::Subsection:: *)
(*Package Loading Tests*)


(* Test: Context is on $ContextPath after loading *)
TestCreate[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Shocks`"],
	True,
	{},
	TestID -> "Shocks-PackageLoading-ContextOnPath"
]

(* Test: Symbol rulesE should exist *)
TestCreate[
	Not[Names["*rulesE"] === {}],
	True,
	{},
	TestID -> "rulesE-Existence-CanBeFound"
]


(* ::Subsection:: *)
(*Shock Moments Tests (First through Fourth)*)


(* Test: All shocks have zero mean *)
TestCreate[
	($allShocks /. $rulesEt),
	ConstantArray[0, Length[$allShocks]],
	{},
	TestID -> "eps-AllShocks-FirstMomentZero"
]

(* Test: All shocks have variance equal to one *)
TestCreate[
	($allShocks^2 /. $rulesEt),
	ConstantArray[1, Length[$allShocks]],
	{},
	TestID -> "eps-AllShocks-SecondMomentOne"
]

(* Test: All shocks have zero third moment *)
TestCreate[
	($allShocks^3 /. $rulesEt),
	ConstantArray[0, Length[$allShocks]],
	{},
	TestID -> "eps-AllShocks-ThirdMomentZero"
]

(* Test: All shocks have fourth moment equal to three *)
TestCreate[
	($allShocks^4 /. $rulesEt),
	ConstantArray[3, Length[$allShocks]],
	{},
	TestID -> "eps-AllShocks-FourthMomentThree"
]


(* ::Subsection:: *)
(*Shock Independence Tests*)


(* Test: Scalar shocks are pairwise uncorrelated *)
TestCreate[
	AllTrue[
		Subsets[$scalarShockNames, {2}],
		(eps[#[[1]]][t] * eps[#[[2]]][t] /. $rulesEt) === 0 &
	],
	True,
	{},
	TestID -> "eps-ScalarShocks-Uncorrelated"
]

(* Test: Stock shocks are uncorrelated with scalar shocks (except dc) *)
TestCreate[
	AllTrue[
		Tuples[{$stockIndices, DeleteCases[$scalarShockNames, "dc"]}],
		(eps["dd"][t, #[[1]]] * eps[#[[2]]][t] /. $rulesEt) === 0 &
	],
	True,
	{},
	TestID -> "eps-StockShocks-UncorrelatedWithScalars"
]

(* Test: Independence in higher moments (E[x^2 y^2] = 1 for independent shocks) *)
TestCreate[
	(eps["x"][t]^2 * eps["pi"][t]^2 /. $rulesEt),
	1,
	{},
	TestID -> "eps-Independence-HigherMoments"
]


(* ::Subsection:: *)
(*Correlation Structure Tests*)


(* Test: taugd is correlation between shocks to consumption and dividends *)
TestCreate[
	Table[eps["dd"][t, k] * eps["dc"][t], {k, $stockIndices}] /. $rulesEt,
	{taugd[1], taugd[i], taugd[j]},
	{},
	TestID -> "taugd-CorrelationStructure-ConsumptionDividendShocks"
]


(* ::Subsection:: *)
(*Linearity Tests*)


(* Test: Linearity of expectation (requires Expand) *)
TestCreate[
	((eps["x"][t] + eps["pi"][t])^2 // Expand) /. $rulesEt,
	2, (* E[x^2] + E[pi^2] + 2E[x*pi] = 1 + 1 + 0 = 2 *)
	{},
	TestID -> "eps-Linearity-VarianceSum"
]


(* ::Subsection:: *)
(*Rule Application Boundaries - Different Time Tests*)


(* Test: Scalar shocks at different times are not evaluated *)
TestCreate[
	AllTrue[$scalarShockNames, unevaluatedQ[eps[#][t + 1]] &],
	True,
	{},
	TestID -> "rulesE-ScalarShocksDifferentTime-Unevaluated"
]

(* Test: Scalar shocks with symbol (not string) names are not evaluated *)
TestCreate[
	AllTrue[$scalarShockNames, unevaluatedQ[eps[ToExpression @ #][t]] &],
	True,
	{},
	TestID -> "rulesE-ScalarShocksSymbolNames-Unevaluated"
]

(* Test: Stock shocks at different times or with symbol names are not evaluated *)
TestCreate[
	AllTrue[{eps["dd"][t + 1, i], eps[dd][t, i]}, unevaluatedQ],
	True,
	{},
	TestID -> "rulesE-StockShocksDifferentTimeOrSymbol-Unevaluated"
]


(* ::Subsection:: *)
(*Rule Application Boundaries - No Time Argument Tests*)


(* Test: Scalar shocks without time argument are not evaluated *)
TestCreate[
	AllTrue[$scalarShockNames, unevaluatedQ[eps[#]] &],
	True,
	{},
	TestID -> "rulesE-ScalarShocksNoTime-Unevaluated"
]

(* Test: Stock shock without arguments is not evaluated *)
TestCreate[
	unevaluatedQ[eps["dd"]],
	True,
	{},
	TestID -> "rulesE-StockShockNoArgs-Unevaluated"
]


(* ::Subsection:: *)
(*Rule Application Boundaries - Invalid Names Tests*)


(* Invalid shock names for testing *)
$invalidScalarNames = {"xx", "adc", "p", "rhobar", "ssg", "ssx", "sdc", "spi"};
$invalidTimes = {t + 1, t - 1, s, t + h};

(* Test: Invalid scalar shock names are not evaluated *)
TestCreate[
	AllTrue[$invalidScalarNames, unevaluatedQ[eps[#]] &],
	True,
	{},
	TestID -> "rulesE-InvalidScalarShockNames-Unevaluated"
]

(* Test: Invalid stock shock name is not evaluated *)
TestCreate[
	unevaluatedQ[eps["ddd"]],
	True,
	{},
	TestID -> "rulesE-InvalidStockShockName-Unevaluated"
]

(* Test: Invalid scalar shock names with various time arguments are not evaluated *)
TestCreate[
	AllTrue[
		Tuples[{$invalidScalarNames, $invalidTimes}],
		unevaluatedQ[eps[#[[1]]][#[[2]]]] &
	],
	True,
	{},
	TestID -> "rulesE-InvalidScalarShocksWithTime-Unevaluated"
]

(* Test: Stock shocks with various non-matching times are not evaluated *)
TestCreate[
	AllTrue[
		Tuples[{{1, i, j}, $invalidTimes}],
		unevaluatedQ[eps["dd"][#[[2]], #[[1]]]] &
	],
	True,
	{},
	TestID -> "rulesE-StockShocksVariousTimes-Unevaluated"
]


(* ::Subsection:: *)
(*Context Independence Tests*)


(* Test: rulesE works for eps symbols in any context - first moment *)
TestCreate[
	AllTrue[$scalarShockNames, (NewContext`eps[#][t] /. $rulesEt) === 0 &],
	True,
	{},
	TestID -> "rulesE-NewContextScalarShocks-FirstMomentZero"
]

(* Test: rulesE works for stock shocks in any context - first moment *)
TestCreate[
	AllTrue[$stockIndices, (NewContext`eps["dd"][t, #] /. $rulesEt) === 0 &],
	True,
	{},
	TestID -> "rulesE-NewContextStockShocks-FirstMomentZero"
]

(* Test: rulesE works for eps symbols in original package context - second moment *)
TestCreate[
	AllTrue[
		$scalarShockNames,
		(FernandoDuarte`LongRunRisk`Model`Shocks`Private`eps[#][t]^2 /. $rulesEt) === 1 &
	],
	True,
	{},
	TestID -> "rulesE-OriginalContextScalarShocks-SecondMomentOne"
]

(* Test: rulesE works for stock shocks in original package context - second moment *)
TestCreate[
	AllTrue[
		$stockIndices,
		(FernandoDuarte`LongRunRisk`Model`Shocks`Private`eps["dd"][t, #]^2 /. $rulesEt) === 1 &
	],
	True,
	{},
	TestID -> "rulesE-OriginalContextStockShocks-SecondMomentOne"
]


End[]
EndTestSection[]
