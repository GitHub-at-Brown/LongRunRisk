(* ::Package:: *)

(* ::Section:: *)
(*Kernel/Model/ExogenousEq.wl Tests*)


BeginTestSection["Kernel/Model/ExogenousEq.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`"]

Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];

(* ::Subsection:: *)
(*Load Test Helpers*)


Get @ FileNameJoin[{DirectoryName[$TestFileName, 2], "TestHelpers.wl"}];
Get @ FileNameJoin[{DirectoryName[$TestFileName, 1], "ModelTestHelpers.wl"}];


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

(* Test: Symbol dd is in the correct Private context *)
TestCreate[
	Context[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd],
	"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`",
	{},
	TestID -> "dd-Context-InPrivate"
]


(* ::Subsection:: *)
(*Exogenous Variables - Context Test*)
TestCreate[
	Values@verifySymbolContext[$exogenousVars],
	{True,True,True,True},
	{},
	TestID -> "$exogenousVars-verifySymbolContext-InCorrectContext"
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
