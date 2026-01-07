(* ::Package:: *)

(* ::Section:: *)
(*Kernel/ComputationalEngine/CreateEulerEq.wl Tests*)


BeginTestSection["Kernel/ComputationalEngine/CreateEulerEq.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`"]

(* Needs["FernandoDuarte`LongRunRisk`"]; *)
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];

(* ::Subsection:: *)
(*Load Test Helpers*)


Get @ FileNameJoin[{DirectoryName[$TestFileName, 2], "TestHelpers.wl"}];
Get @ FileNameJoin[{DirectoryName[$TestFileName, 1], "CETestHelpers.wl"}];


(* ::Subsection:: *)
(*Test Fixtures*)


$mods = {$modBY, $modNRC, $modDES};

(* Compute Euler equations for all models *)
$eeAll = With[{t = $t},
	Function[model, {
		eulereq[$retc[t + 1], t, model],
		eulereq[$ret[t + 1, j], t, model],
		eulereq[$bondret[t + 1, m], t, model],
		nomeulereq[$nombondret[t + 1, m], t, model]
	}] /@ $mods
];

(* Coefficient extractors *)
$coeffWcAll = With[{t = $t},
	Function[model,
		Table[$coefwc[i], {i, Length[model["stateVars"][t]]}]
	] /@ $mods
];

$coeffPdAll = With[{t = $t},
	Function[model,
		Table[$coefpd[i], {i, Length[model["stateVars"][t]]}]
	] /@ $mods
];

$coeffBondAll = With[{t = $t},
	Function[model,
		Table[$coefb[i], {i, Length[model["stateVars"][t]]}]
	] /@ $mods
];

$coeffNomBondAll = With[{t = $t},
	Function[model,
		Table[$coefnb[i], {i, Length[model["stateVars"][t]]}]
	] /@ $mods
];


(* ::Subsection:: *)
(*eulereq - Symbol Existence Tests*)


(* Test: eulereq symbol can be found *)
TestCreate[
	Names["*eulereq"] =!= {},
	True,
	{},
	TestID -> "eulereq-Symbol-Exists"
]


(* ::Subsection:: *)
(*eulereq - Linearity Tests*)


(* Test: Euler equations are linear in state variables *)
(* Helper to extract state variable expressions including powers from a model *)
(* Pattern _Symbol[t]^p_. matches both Symbol[t] and Symbol[t]^power *)
getStateVarExpressions[model_, t_] := DeleteDuplicates @ Cases[
	model["stateVars"][t],
	_Symbol[t]^_.,
	Infinity
];

TestCreate[
	With[{t = $t},
		AllTrue[
			Flatten @ {
				Function[ee, Max @ Keys @ CoefficientRules[ee, getStateVarExpressions[$modBY, t]] == 1] /@ $eeAll[[1]],
				Function[ee, Max @ Keys @ CoefficientRules[ee, getStateVarExpressions[$modNRC, t]] == 1] /@ $eeAll[[2]],
				Function[ee, Max @ Keys @ CoefficientRules[ee, getStateVarExpressions[$modDES, t]] == 1] /@ $eeAll[[3]]
			},
			TrueQ
		]
	],
	True,
	{},
	TestID -> "eulereq-AllModels-LinearInStateVars"
]


(* ::Subsection:: *)
(*eulereq - Coefficient Presence Tests*)


(* Test: Euler equations contain all expected wc coefficients *)
TestCreate[
	AllTrue[
		Flatten @ Table[
			Not @ FreeQ[$eeAll[[n, 1]], #] & /@ $coeffWcAll[[n]],
			{n, Length[$mods]}
		],
		TrueQ
	],
	True,
	{},
	TestID -> "eulereq-AllModels-ContainsWcCoeffs"
]

(* Test: Euler equations contain all expected pd coefficients *)
TestCreate[
	AllTrue[
		Flatten @ Table[
			Not @ FreeQ[$eeAll[[n, 2]], #] & /@ $coeffPdAll[[n]],
			{n, Length[$mods]}
		],
		TrueQ
	],
	True,
	{},
	TestID -> "eulereq-AllModels-ContainsPdCoeffs"
]

(* Test: Euler equations contain all expected bond coefficients *)
TestCreate[
	AllTrue[
		Flatten @ Table[
			Not @ FreeQ[$eeAll[[n, 3]], #] & /@ $coeffBondAll[[n]],
			{n, Length[$mods]}
		],
		TrueQ
	],
	True,
	{},
	TestID -> "eulereq-AllModels-ContainsBondCoeffs"
]

(* Test: Nominal Euler equations contain all expected nombond coefficients *)
TestCreate[
	AllTrue[
		Flatten @ Table[
			Not @ FreeQ[$eeAll[[n, 4]], #] & /@ $coeffNomBondAll[[n]],
			{n, Length[$mods]}
		],
		TrueQ
	],
	True,
	{},
	TestID -> "nomeulereq-AllModels-ContainsNomBondCoeffs"
]


(* ::Subsection:: *)
(*findEulerEqConstants - Equation Count Tests*)


(* Test: Number of equations equals number of state variables plus one for retc *)
TestCreate[
	With[{t = $t},
		AllTrue[$mods, Function[model,
			Count[
				Cases[First @ findEulerEqConstants[$retc[t], model], 0 == x__ :> True],
				True
			] === Length[model["stateVars"][t]] + 1
		]]
	],
	True,
	{},
	TestID -> "findEulerEqConstants-Retc-EquationCount"
]

(* Test: Number of equations equals number of state variables plus one for ret *)
TestCreate[
	With[{t = $t},
		AllTrue[$mods, Function[model,
			Count[
				Cases[First @ findEulerEqConstants[$ret[t, j], model], 0 == x__ :> True],
				True
			] === Length[model["stateVars"][t]] + 1
		]]
	],
	True,
	{},
	TestID -> "findEulerEqConstants-Ret-EquationCount"
]

(* Test: Number of equations equals number of state variables plus one for bondret *)
TestCreate[
	With[{t = $t},
		AllTrue[$mods, Function[model,
			Count[
				Cases[First @ findEulerEqConstants[$bondret[t, m], model], 0 == x__ :> True],
				True
			] === Length[model["stateVars"][t]] + 1
		]]
	],
	True,
	{},
	TestID -> "findEulerEqConstants-Bondret-EquationCount"
]

(* Test: Number of equations equals number of state variables plus one for nombondret *)
TestCreate[
	With[{t = $t},
		AllTrue[$mods, Function[model,
			Count[
				Cases[First @ findEulerEqConstants[$nombondret[t, m], model, True], 0 == x__ :> True],
				True
			] === Length[model["stateVars"][t]] + 1
		]]
	],
	True,
	{},
	TestID -> "findEulerEqConstants-Nombondret-EquationCount"
]


(* ::Subsection:: *)
(*findEulerEqConstants - Time Independence Tests*)


(* Test: Equations for coefficients do not contain time variable t for retc *)
TestCreate[
	With[{t = $t},
		AllTrue[$mods, FreeQ[findEulerEqConstants[$retc[t], #], t] &]
	],
	True,
	{},
	TestID -> "findEulerEqConstants-Retc-TimeIndependent"
]

(* Test: Equations for coefficients do not contain time variable t for ret *)
TestCreate[
	With[{t = $t},
		AllTrue[$mods, FreeQ[findEulerEqConstants[$ret[t, j], #], t] &]
	],
	True,
	{},
	TestID -> "findEulerEqConstants-Ret-TimeIndependent"
]

(* Test: Equations for coefficients do not contain time variable t for bondret *)
TestCreate[
	With[{t = $t},
		AllTrue[$mods, FreeQ[findEulerEqConstants[$bondret[t, m], #], t] &]
	],
	True,
	{},
	TestID -> "findEulerEqConstants-Bondret-TimeIndependent"
]

(* Test: Equations for coefficients do not contain time variable t for nombondret *)
TestCreate[
	With[{t = $t},
		AllTrue[$mods, FreeQ[findEulerEqConstants[$nombondret[t, m], #, True], t] &]
	],
	True,
	{},
	TestID -> "findEulerEqConstants-Nombondret-TimeIndependent"
]


(* ::Subsection:: *)
(*findEulerEqConstants - Time Invariance Tests*)


(* Test: Equations are time-invariant for retc *)
TestCreate[
	With[{t = $t},
		(findEulerEqConstants[$retc[t], #] & /@ $mods) ===
		(findEulerEqConstants[$retc[t + 1], #] & /@ $mods)
	],
	True,
	{},
	TestID -> "findEulerEqConstants-Retc-TimeInvariant"
]

(* Test: Equations are time-invariant for ret *)
TestCreate[
	With[{t = $t},
		(findEulerEqConstants[$ret[t, j], #] & /@ $mods) ===
		(findEulerEqConstants[$ret[t + 1, j], #] & /@ $mods)
	],
	True,
	{},
	TestID -> "findEulerEqConstants-Ret-TimeInvariant"
]

(* Test: Equations are time-invariant for bondret *)
TestCreate[
	With[{t = $t},
		(findEulerEqConstants[$bondret[t, m], #] & /@ $mods) ===
		(findEulerEqConstants[$bondret[t + 1, m], #] & /@ $mods)
	],
	True,
	{},
	TestID -> "findEulerEqConstants-Bondret-TimeInvariant"
]

(* Test: Equations are time-invariant for nombondret *)
TestCreate[
	With[{t = $t},
		(findEulerEqConstants[$nombondret[t, m], #, True] & /@ $mods) ===
		(findEulerEqConstants[$nombondret[t + 1, m], #, True] & /@ $mods)
	],
	True,
	{},
	TestID -> "findEulerEqConstants-Nombondret-TimeInvariant"
]


(* ::Subsection:: *)
(*findEulerEqConstants - Unknown Context Tests*)


(* Test: Unknowns in Euler equation are in EndogenousEq Private context *)
TestCreate[
	With[{t = $t},
		Module[{allContexts},
			allContexts = DeleteDuplicates @ Flatten @ {
				Map[
					Context[Evaluate[#]] &,
					Flatten @ ((Flatten @ Rest @ findEulerEqConstants[$retc[t], #])[[;; , 0]] & /@ $mods)
				],
				Map[
					Context[Evaluate[#]] &,
					Flatten @ ((Flatten @ Rest @ findEulerEqConstants[$ret[t, j], #])[[;; , 0, 0]] & /@ $mods)
				],
				Map[
					Context[Evaluate[#]] &,
					Flatten @ ((Flatten @ Rest @ findEulerEqConstants[$bondret[t, m], #])[[;; , 0, 0]] & /@ $mods)
				],
				Map[
					Context[Evaluate[#]] &,
					Flatten @ ((Flatten @ Rest @ findEulerEqConstants[$nombondret[t, m], #, True])[[;; , 0, 0]] & /@ $mods)
				]
			};
			allContexts === {"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"}
		]
	],
	True,
	{},
	TestID -> "findEulerEqConstants-Unknowns-ContextScope"
]


(* ::Subsection:: *)
(*findEulerEqConstants - Numeric Evaluation Tests*)


(* Helper for numeric evaluation test *)
checkNumericBoolean[mod_, t_] := Module[{e0, e1, e2, e3, e0p, e1p, e2p, e3p},
	e0 = findEulerEqConstants[$retc[t], mod];
	e1 = findEulerEqConstants[$ret[t, 1], mod];
	e2 = findEulerEqConstants[$bondret[t, m], mod];
	e3 = findEulerEqConstants[$nombondret[t, m], mod, True];
	e0p = Join[
		Normal @ mod["parameters"],
		Thread[e0[[2]] -> 4],
		{FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Ewc -> 4}
	];
	e1p = Join[e0p, {
		FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd[_] -> 4,
		FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Epd[_] -> 4
	}];
	e2p = Join[e0p, {
		FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb[m_] -> 4
	}];
	e3p = Join[e0p, {
		FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb[m_] -> 4
	}];
	{e0[[1]] /. e0p, e1[[1]] /. e1p, e2[[1]] /. e2p, e3[[1]] /. e3p}
];

(* Test: Each equation evaluates to True or False when evaluated numerically *)
TestCreate[
	With[{t = $t},
		AllTrue[$mods, Function[model,
			AllTrue[Flatten @ checkNumericBoolean[model, t], BooleanQ]
		]]
	],
	True,
	{},
	TestID -> "findEulerEqConstants-AllModels-NumericEvalToBoolean"
]


End[]
EndTestSection[]
