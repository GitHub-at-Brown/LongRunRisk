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


Get @ FileNameJoin[{DirectoryName[$TestFileName, 2], "TestHelpers.wl"}];
Get @ FileNameJoin[{DirectoryName[$TestFileName, 1], "ModelTestHelpers.wl"}];


(* ::Subsection:: *)
(*Symbol Existence Tests*)


(* Test: pdeq symbol exists and can be found *)
TestCreate[
	Names["*pdeq"] =!= {},
	True,
	{},
	TestID -> "[pdeq] Symbol can be found"
]


(* ::Subsection:: *)
(*$endogenousVars - Context Tests*)


(* Test: Symbols used in endogenous equations are in correct contexts *)
TestCreate[
	Values@verifySymbolContext[$endogenousVars],
	{True,True,True,True},
	{},
	TestID -> "[$endogenousVars] Symbols have correct context"
]



(* ::Subsection:: *)
(*Context Isolation Tests*)


(* Test: Bond yield functions preserve context isolation for t and m arguments *)
Block[{tVar, m},
	With[{
		funcs = {bondyieldeq, nombondyieldeq},
		argSpecs = {
			<|"fooArgs" -> {foo`tVar, m}, "sym" -> tVar, "id" -> "TArgument"|>,
			<|"fooArgs" -> {tVar, foo`m}, "sym" -> m, "id" -> "MArgument"|>
		}
	},
		Flatten @ Outer[
			Function[{func, argSpec},
				TestCreate[
					contextIsolationQ[func, {tVar, m}, argSpec["fooArgs"], argSpec["sym"]],
					True,
					{},
					TestID -> "[" <> SymbolName[func] <> "] Context isolation " <> argSpec["id"]
				]
			],
			funcs,
			argSpecs,
			1
		]
	]
]


(* ::Subsection:: *)
(*Default Argument Tests*)


(* Test: Default values for optional arguments work correctly *)
Block[{tVar, m},
	TestCreate[
		And[
			bondfweq[tVar, m] === bondfweq[tVar, m, 1],
			bondreteq[tVar, m] === bondreteq[tVar, m, 1],
			bondfwspreadeq[tVar, m] === bondfwspreadeq[tVar, m, 1],
			bondexcreteq[tVar, m] === bondexcreteq[tVar, m, 1],

			nombondfweq[tVar, m] === nombondfweq[tVar, m, 1],
			nombondreteq[tVar, m] === nombondreteq[tVar, m, 1],
			nombondfwspreadeq[tVar, m] === nombondfwspreadeq[tVar, m, 1],
			nombondexcreteq[tVar, m] === nombondexcreteq[tVar, m, 1]
		],
		True,
		{},
		TestID -> "[Bond functions] Default arguments default to one"
	]
]


(* ::Subsection:: *)
(*Formula Logic Tests*)


(* Test: bondyieldeq uses private bond symbol correctly *)
Block[{tVar, m},
	TestCreate[
		And[
			bondyieldeq[tVar, m] === -(1/m) FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[tVar, m],
			nombondyieldeq[tVar, m] === -(1/m) FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nombond[tVar, m]
		],
		True,
		{},
		TestID -> "[Bond yield functions] Definitions use private symbols"
	]
]

(* Test: bondfweq definition uses bond price difference *)
Block[{tVar, m, h},
	TestCreate[
		And[
			bondfweq[tVar, m, h] === FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[tVar, m - h] -
				FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[tVar, m],
			nombondfweq[tVar, m, h] === FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nombond[tVar, m - h] -
				FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nombond[tVar, m]
		],
		True,
		{},
		TestID -> "[Forward eq functions] Definitions match formula"
	]
]

(* Test: rfeq and nomrfeq use private yield symbols correctly *)
Block[{tVar, h},
	TestCreate[
		Module[{bondyield, nombondyield},
			bondyield = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondyield;
			nombondyield = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nombondyield;
			And[
				rfeq[tVar] === bondyield[tVar, 1],
				rfeq[tVar, h] === bondyield[tVar, h],

				nomrfeq[tVar] === nombondyield[tVar, 1],
				nomrfeq[tVar, h] === nombondyield[tVar, h]
			]
		],
		True,
		{},
		TestID -> "[Risk free eq functions] Definitions use private yields"
	]
]


(* ::Subsection:: *)
(*Coefficient Index Tests*)


(* Test: Coefficient indices remain exact when given inexact input *)
Block[{j},
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
					TestID -> "[Coefficient " <> spec["name"] <> "] Inexact input indices remain exact"
				]
			],
			specs
		]
	]
]


End[]
EndTestSection[]
