(* ::Package:: *)

(* ::Section:: *)
(*Kernel/Model/EndogenousEq.wl Tests*)


BeginTestSection["Kernel/Model/EndogenousEq.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`"]

Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];

(* ::Subsection:: *)
(*Load Test Helpers*)


Scan[Get @ FileNameJoin[{DirectoryName[$TestFileName, #], "Common.wl"}] &, {2, 1}];


(* ::Subsection:: *)
(*Symbol Existence Tests*)


(* Test: pdeq symbol exists and can be found *)
TestCreate[
	Names["*pdeq"] =!= {},
	True,
	{},
	TestID -> "pdeq-Existence-CanBeFound"
]


(* ::Subsection:: *)
(*$endogenousVars - Context Tests*)


(* Test: Symbols used in endogenous equations are in correct contexts *)
Module[{ctx, specs},
	ctx = "FernandoDuarte`LongRunRisk`Model`";
	specs = {
		(* Exogenous variables like x[t], pi[t] should be in ExogenousEq`Private` *)
		<|"type" -> "functionHead", "names" -> StringDrop[$exogenousVars, -2],
		  "context" -> "ExogenousEq`Private`", "id" -> "ExogenousVars"|>,

		(* Shock symbol eps (curried as eps["pi"][t]) should be in Shocks` *)
		<|"type" -> "curriedHead", "names" -> {"eps"},
		  "context" -> "Shocks`", "id" -> "Shocks"|>,

		(* Parameters should be in Parameters` *)
		<|"type" -> "bareSymbol", "names" -> $parameters,
		  "context" -> "Parameters`", "id" -> "Parameters"|>,

		(* Endogenous variables like wc[t], pd[t] should be in EndogenousEq`Private` *)
		<|"type" -> "functionHead", "names" -> StringDrop[$endogenousVars, -2],
		  "context" -> "EndogenousEq`Private`", "id" -> "EndogenousVars"|>
	};
	Map[
		Function[spec,
			TestCreate[
				verifySymbolContext[$endogenousVars, spec["type"], spec["names"], ctx <> spec["context"]],
				True,
				{},
				TestID -> "$endogenousVars-" <> spec["id"] <> "-InCorrectContext"
			]
		],
		specs
	]
]


(* ::Subsection:: *)
(*Context Isolation Tests*)


(* Test: Bond yield functions preserve context isolation for t and m arguments *)
With[{
	funcs = {bondyieldeq, nombondyieldeq},
	argSpecs = {
		<|"fooArgs" -> {foo`t, m}, "sym" -> t, "id" -> "TArgument"|>,
		<|"fooArgs" -> {t, foo`m}, "sym" -> m, "id" -> "MArgument"|>
	}
},
	Flatten @ Outer[
		Function[{func, argSpec},
			TestCreate[
				contextIsolationQ[func, {t, m}, argSpec["fooArgs"], argSpec["sym"]],
				True,
				{},
				TestID -> SymbolName[func] <> "-ContextIsolation-" <> argSpec["id"]
			]
		],
		funcs,
		argSpecs,
		1
	]
]


(* ::Subsection:: *)
(*Default Argument Tests*)


(* Test: Default values for optional arguments work correctly *)
TestCreate[
	And[
		bondfweq[t, m] === bondfweq[t, m, 1],
		bondreteq[t, m] === bondreteq[t, m, 1],
		bondfwspreadeq[t, m] === bondfwspreadeq[t, m, 1],
		bondexcreteq[t, m] === bondexcreteq[t, m, 1],
		
		nombondfweq[t, m] === nombondfweq[t, m, 1],
		nombondreteq[t, m] === nombondreteq[t, m, 1],
		nombondfwspreadeq[t, m] === nombondfwspreadeq[t, m, 1],
		nombondexcreteq[t, m] === nombondexcreteq[t, m, 1]
	],
	True,
	{},
	TestID -> "BondFunctions-DefaultArguments-DefaultToOne"
]


(* ::Subsection:: *)
(*Formula Logic Tests*)


(* Test: bondyieldeq uses private bond symbol correctly *)
TestCreate[
	And[
		bondyieldeq[t, m] === -(1/m) FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[t, m],
		nombondyieldeq[t, m] === -(1/m) FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nombond[t, m]
	],
	True,
	{},
	TestID -> "BondYieldFunctions-Definition-UsePrivateSymbols"
]

(* Test: bondfweq definition uses bond price difference *)
TestCreate[
	And[
		bondfweq[t, m, h] === FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[t, m - h] -
			FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[t, m],
		nombondfweq[t, m, h] === FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nombond[t, m - h] -
			FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nombond[t, m]
	],
	True,
	{},
	TestID -> "ForwardEqFunctions-Definition-MatchFormula"
]

(* Test: rfeq and nomrfeq use private yield symbols correctly *)
TestCreate[
	Module[{bondyield, nombondyield},
		bondyield = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondyield;
		nombondyield = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nombondyield;
		And[
			rfeq[t] === bondyield[t, 1],
			rfeq[t, h] === bondyield[t, h],

			nomrfeq[t] === nombondyield[t, 1],
			nomrfeq[t, h] === nombondyield[t, h]
		]
	],
	True,
	{},
	TestID -> "RiskFreeEqFunctions-Definition-UsePrivateYields"
]


(* ::Subsection:: *)
(*Coefficient Index Tests*)


(* Test: Coefficient indices remain exact when given inexact input *)
With[{
	ctx = "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`",
	specs = {
		(* A[0.] -> A[0], A[1.] -> A[1] *)
		<|"name" -> "A", "indices" -> {{0}, {1}}|>,
		
		(* B[0.][0.] -> B[0][0], B[1.][1.] -> B[1][1], B[0.][j] -> B[0][j], B[j][1.] -> B[j][1] *)
		<|"name" -> "B", "indices" -> {{0, 0}, {1, 1}, {0, j}, {j, 1}}|>,
		
		(* R[0.][1.] -> R[0][1], R[1.][2.] -> R[1][2], R[0.][j] -> R[0][j], R[j][1.] -> R[j][1] *)
		<|"name" -> "R", "indices" -> {{0, 1}, {1, 2}, {0, j}, {j, 1}}|>,
		
		(* P[0.][1.] -> P[0][1], P[1.][2.] -> P[1][2], P[0.][j] -> P[0][j], P[j][1.] -> P[j][1] *)
		<|"name" -> "P", "indices" -> {{0, 1}, {1, 2}, {0, j}, {j, 1}}|>
	}
},
	Map[
		Function[spec,
			TestCreate[
				coefficientIndicesExactQ[Symbol[ctx <> spec["name"]], spec],
				True,
				{},
				TestID -> "Coefficient" <> spec["name"] <> "-InexactInput-IndicesRemainExact"
			]
		],
		specs
	]
]


End[]
EndTestSection[]
