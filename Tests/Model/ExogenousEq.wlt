(* ::Package:: *)

(* ::Section:: *)
(*Kernel/Model/ExogenousEq.wl Tests*)


BeginTestSection["Kernel/Model/ExogenousEq.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`"]

Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];

(* ::Subsection:: *)
(*Load Test Helpers*)


Scan[Get @ FileNameJoin[{DirectoryName[$TestFileName, #], "Common.wl"}] &, {2, 1}];


(* ::Subsection:: *)
(*xeq - Symbol Existence Tests*)


(* Test: xeq symbol exists *)
TestCreate[
	NameQ["FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq"],
	True,
	{},
	TestID -> "xeq-Existence-SymbolDefined"
]


(* ::Subsection:: *)
(*$exogenousVars - Structure Tests*)


(* Test: $exogenousVars is a non-empty list *)
TestCreate[
	ListQ[$exogenousVars] && Length[$exogenousVars] > 0,
	True,
	{},
	TestID -> "$exogenousVars-Structure-IsNonEmptyList"
]

(* Test: $exogenousVars contains expected canonical order *)
TestCreate[
	$exogenousVars,
	{"xeq", "pieq", "pibareq", "dceq", "sgeq", "sxeq", "sceq", "speq", "ddeq"},
	{},
	TestID -> "$exogenousVars-Contents-CanonicalOrder"
]

(* Test: $exogenousVarsStocks and $exogenousVarsNoStocks are disjoint and cover $exogenousVars *)
TestCreate[
	Sort[Join[$exogenousVarsStocks, $exogenousVarsNoStocks]] === Sort[$exogenousVars] &&
	Intersection[$exogenousVarsStocks, $exogenousVarsNoStocks] === {},
	True,
	{},
	TestID -> "$exogenousVars-Subsets-DisjointAndComplete"
]


(* ::Subsection:: *)
(*Exogenous Variables - Context Tests*)


(* Test: Symbol dc exists in Private context *)
TestCreate[
	NameQ["FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc"],
	True,
	{},
	TestID -> "dc-Existence-InPrivateContext"
]

(* Test: Symbol dd exists in Private context *)
TestCreate[
	NameQ["FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd"],
	True,
	{},
	TestID -> "dd-Existence-InPrivateContext"
]

(* Test: Symbol dc is in the correct Private context *)
TestCreate[
	Context[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc],
	"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`",
	{},
	TestID -> "dc-Context-InPrivate"
]

(* Test: Symbol dd is in the correct Private context *)
TestCreate[
	Context[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd],
	"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`",
	{},
	TestID -> "dd-Context-InPrivate"
]


(* ::Subsection:: *)
(*Exogenous Variables - Context Test*)


(* Test: All exogenous variables are in Private context *)
TestCreate[
	verifySymbolContext[$exogenousVars, "functionHead", StringDrop[$exogenousVars, -2],
		"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],
	True,
	{},
	TestID -> "$exogenousVars-Context-AllInPrivate"
]


(* ::Subsection:: *)
(*Shocks - Context Tests*)


(* Test: All shocks are in Shocks context *)
TestCreate[
	verifySymbolContext[$exogenousVars, "curriedHead", {"eps"},
		"FernandoDuarte`LongRunRisk`Model`Shocks`"],
	True,
	{},
	TestID -> "eps-Context-AllInShocks"
]


(* ::Subsection:: *)
(*Parameters - Context Tests*)


(* Test: All parameters are in Parameters context *)
TestCreate[
	verifySymbolContext[$exogenousVars, "bareSymbol", $parameters,
		"FernandoDuarte`LongRunRisk`Model`Parameters`"],
	True,
	{},
	TestID -> "parameters-Context-AllInParameters"
]


(* ::Subsection:: *)
(*Context Isolation Tests*)


(* Test: xeq preserves context isolation for t argument *)
TestCreate[
	contextIsolationQ[xeq, {t}, {foo`t}, t],
	True,
	{},
	TestID -> "xeq-ContextIsolation-TArgument"
]


End[]
EndTestSection[]
