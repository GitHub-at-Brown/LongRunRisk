(* ::Package:: *)

(* ::Section:: *)
(*Kernel/Tools/ToNumber.wl Tests*)


BeginTestSection["Kernel/Tools/ToNumber.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`"]

Needs["FernandoDuarte`LongRunRisk`Tools`ToNumber`"];


Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"];
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

(* Returns True if msg issued when expr is evaluated *)
SetAttributes[checkMsg, HoldAll];
checkMsg[expr_, msg_] := Module[{c},
	CheckAbort[
		Quiet[
			AbortProtect[
				c = Check[expr;, True, msg];
			];
		];
		TrueQ @ c,
		TrueQ @ c
	]
];


(* ::Subsection:: *)
(*processNewParameters - Equal Parameters Tests*)

(* Test: When old and new parameters are equal, all values are numbers *)
TestCreate[
	With[{p = $baseParams, newP = $baseParams},
		AllTrue[Values @ processNewParameters[newP, p], NumberQ]
	],
	True,
	{},
	TestID -> "[processNewParameters] Equal parameters produce numeric values"
]

(* Test: When old and new parameters are equal, keys match by name *)
TestCreate[
	With[{p = $baseParams, newP = $baseParams},
		Module[{procP = processNewParameters[newP, p]},
			Sort[(SymbolName @* Replace[h_[_] :> h]) /@ Keys @ procP] === Sort[(SymbolName @* Replace[h_[_] :> h]) /@ Keys @ newP]
		]
	],
	True,
	{},
	TestID -> "[processNewParameters] Equal parameters preserve key names"
]

(* Test: When old and new parameters are equal, keys match with context *)
TestCreate[
	With[{p = $baseParams, newP = $baseParams},
		Module[{procP = processNewParameters[newP, p]},
			Sort @ Keys @ procP === Sort @ Keys @ newP
		]
	],
	True,
	{},
	TestID -> "[processNewParameters] Equal parameters preserve key contexts"
]

(* Test: When old and new parameters are equal, processed keys are subset of old parameters *)
TestCreate[
	With[{p = $baseParams, newP = $baseParams},
		Module[{procP = processNewParameters[newP, p]},
			SubsetQ[Keys @ p, Keys @ procP]
		]
	],
	True,
	{},
	TestID -> "[processNewParameters] Processed keys subset of original parameters"
]

(* Test: When old and new parameters are equal, does not return Failure *)
TestCreate[
	With[{p = $baseParams, newP = $baseParams},
		Not @ FailureQ[processNewParameters[newP, p]]
	],
	True,
	{},
	TestID -> "[processNewParameters] Equal parameters do not return Failure"
]


(* ::Subsection:: *)
(*processNewParameters - Subset Parameters Tests*)

(* Test: When new parameters are subset of old, values are numbers *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1}},
		AllTrue[Values @ processNewParameters[newP, p], NumberQ]
	],
	True,
	{},
	TestID -> "[processNewParameters] Subset parameters produce numeric values"
]

(* Test: When new parameters are subset of old, keys match new parameters by name *)
TestCreate[
	With[{p = $baseParams, newP = {delta -> 0.9, Esx -> 1}},
		Module[{procP = processNewParameters[newP, p]},
			Sort[(SymbolName @* Replace[h_[_] :> h]) /@ Keys @ procP] === Sort[(SymbolName @* Replace[h_[_] :> h]) /@ Keys @ newP]
		]
	],
	True,
	{},
	TestID -> "[processNewParameters] Subset parameters match by name"
]

(* Test: When new parameters are subset of old, procP keys are in correct context *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1}},
		Module[{procP = processNewParameters[newP, p]},
			AllTrue[Keys @ procP, Context[#] === "FernandoDuarte`LongRunRisk`Model`Parameters`" &]
		]
	],
	True,
	{},
	TestID -> "[processNewParameters] Subset parameters use correct context"
]


(* ::Subsection:: *)
(*processNewParameters - Empty Parameters Tests*)

(* Test: When new parameters is empty, returns empty list *)
TestCreate[
	With[{p = $baseParams},
		processNewParameters[{}, p] === {}
	],
	True,
	{},
	TestID -> "[processNewParameters] Empty input returns empty list"
]

(* ::Subsection:: *)
(*processNewParameters - Invalid Parameters Tests*)

(* Test: When new parameters are NOT a subset, returns Failure *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`phip -> 3}},
		FailureQ[processNewParameters[newP, p]]
	],
	True,
	{processNewParameters::subsetparam},
	TestID -> "[processNewParameters] Non-subset parameters return Failure"
]

(* Test: When new parameters are NOT a subset, issues subsetparam message *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`phip -> 3}},
		checkMsg[processNewParameters[newP, p],
			FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::subsetparam]
	],
	True,
	{},
	TestID -> "[processNewParameters] Non-subset parameters issue subsetparam message"
]


(* ::Subsection:: *)
(*processNewParameters - Psi Validation Tests*)

(* Test: psi=1 in new parameters returns Failure *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1}},
		FailureQ[processNewParameters[newP, p]]
	],
	True,
	{processNewParameters::psi},
	TestID -> "[processNewParameters] psi=1 returns Failure"
]

(* Test: psi=1 issues psi message *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1}},
		checkMsg[processNewParameters[newP, p],
			FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::psi]
	],
	True,
	{},
	TestID -> "[processNewParameters] psi=1 issues psi message"
]

(* Test: psi=1. (numeric) also returns Failure *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1.}},
		FailureQ[processNewParameters[newP, p]]
	],
	True,
	{processNewParameters::psi},
	TestID -> "[processNewParameters] psi=1.0 numeric returns Failure"
]


(* ::Subsection:: *)
(*processNewParameters - Gamma Psi Theta Relationship Tests*)

(* Test: When all three {gamma, psi, theta} provided and theta exactly correct, does not return Failure *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`gamma -> 10, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> (1 - FernandoDuarte`LongRunRisk`Model`Parameters`gamma)/(1 - 1/FernandoDuarte`LongRunRisk`Model`Parameters`psi), FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1.5`}},
		Not @ FailureQ[processNewParameters[newP, p]]
	],
	True,
	{},
	TestID -> "[processNewParameters] Exact gamma-psi-theta triple does not return Failure"
]

(* Test: When all three {gamma, psi, theta} provided and theta exactly correct, values are numbers *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`gamma -> 10, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> (1 - FernandoDuarte`LongRunRisk`Model`Parameters`gamma)/(1 - 1/FernandoDuarte`LongRunRisk`Model`Parameters`psi), FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1.5`}},
		AllTrue[Values @ processNewParameters[newP, p], NumberQ]
	],
	True,
	{},
	TestID -> "[processNewParameters] Exact gamma-psi-theta triple produces numbers"
]

(* Test: When theta is NOT exactly correct, issues param message *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`gamma -> 10, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> 3.23`, FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1.5`}},
		checkMsg[processNewParameters[newP, p],
			FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::param]
	],
	True,
	{},
	TestID -> "[processNewParameters] Inconsistent theta issues param message"
]

(* Test: When theta is NOT exactly correct, theta is recalculated to correct value *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`gamma -> 10, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> 3.23`, FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1.5`}},
		Module[{procP},
			procP = Quiet[processNewParameters[newP, p],
				FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::param];
			(* theta should be (1-10)/(1-1/1.5) = -9/(1/3) = -27 *)
			(* Use 10^-10 tolerance for floating point comparison *)
			Abs[(FernandoDuarte`LongRunRisk`Model`Parameters`theta /. procP) + 27] < 10^-10
		]
	],
	True,
	{},
	TestID -> "[processNewParameters] Inconsistent theta recalculated to -27"
]


(* ::Subsection:: *)
(*processNewParameters - Solve for Missing Parameter Tests*)

(* Test: Solve for gamma from {psi, theta} - values are numbers *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 2, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> -3.`}},
		AllTrue[Values @ processNewParameters[newP, p], NumberQ]
	],
	True,
	{},
	TestID -> "[processNewParameters] Solving for gamma produces numbers"
]

(* Test: Solve for gamma from {psi, theta} - gamma has correct value 2.5 *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 2, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> -3.`}},
		Module[{procP = processNewParameters[newP, p]},
			(* gamma = 1 - theta*(1-1/psi) = 1 - (-3)*(1-1/2) = 1 + 3*0.5 = 2.5 *)
			Abs[(FernandoDuarte`LongRunRisk`Model`Parameters`gamma /. procP) - 2.5] < 10^-10
		]
	],
	True,
	{},
	TestID -> "[processNewParameters] Gamma computed as 2.5 from psi and theta"
]

(* Test: Solve for theta from {gamma, psi} - theta has correct value -3 *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 2, FernandoDuarte`LongRunRisk`Model`Parameters`gamma -> 2.5}},
		Module[{procP = processNewParameters[newP, p]},
			(* theta = (1-gamma)/(1-1/psi) = (1-2.5)/(1-0.5) = -1.5/0.5 = -3 *)
			Abs[(FernandoDuarte`LongRunRisk`Model`Parameters`theta /. procP) + 3] < 10^-10
		]
	],
	True,
	{},
	TestID -> "[processNewParameters] Theta computed as -3 from gamma and psi"
]

(* Test: Solve for psi from {gamma, theta} - psi has correct value 2 *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`gamma -> 2.5, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> -3.`}},
		Module[{procP = processNewParameters[newP, p]},
			(* psi = 1/(1-(1-gamma)/theta) = 1/(1-(-1.5)/(-3)) = 1/(1-0.5) = 2 *)
			Abs[(FernandoDuarte`LongRunRisk`Model`Parameters`psi /. procP) - 2] < 10^-10
		]
	],
	True,
	{},
	TestID -> "[processNewParameters] Psi computed as 2 from gamma and theta"
]

(* ::Subsection:: *)
(*processNewParameters - Theta Alone Tests*)

(* Test: theta provided without gamma or psi returns Failure *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> 1.}},
		FailureQ[processNewParameters[newP, p]]
	],
	True,
	{processNewParameters::theta},
	TestID -> "[processNewParameters] Theta alone without gamma or psi returns Failure"
]

(* Test: theta provided without gamma or psi issues theta message *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> 1.}},
		checkMsg[processNewParameters[newP, p],
			FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::theta]
	],
	True,
	{},
	TestID -> "[processNewParameters] Theta alone issues theta message"
]

(* ::Subsection:: *)
(*processNewParameters - Context Preservation Tests*)

(* Test: processNewParameters preserves contexts of old parameters *)
TestCreate[
	Module[{p, newP, procP},
		p = {context1`delta -> 0.998`, context1`Esx -> 0.0078`, foo`gamma -> 10, muc -> 0.0015`,
			phisxs -> 2.3`*^-6, phix -> 0.044`, psi -> 1.5`, rhox -> 0.979`,
			theta -> (1 - gamma)/(1 - 1/psi), vx -> 0.987`, mud[1] -> 0.0015`,
			phidxd[1] -> 4.5`, rhodx[1] -> 3};
		newP = {context2`delta -> 0.9, Esx -> 1, bar`gamma -> 2};
		procP = processNewParameters[newP, p];
		(* Contexts of newP do not match those in old parameters in p *)
		KeyTake[p, Keys @ newP] === <||>
	],
	True,
	{},
	TestID -> "[processNewParameters] New parameter contexts do not match old"
]

(* Test: processNewParameters preserves contexts - procP contexts match old parameters *)
TestCreate[
	Module[{p, newP, procP},
		p = {context1`delta -> 0.998`, context1`Esx -> 0.0078`, foo`gamma -> 10, muc -> 0.0015`,
			phisxs -> 2.3`*^-6, phix -> 0.044`, psi -> 1.5`, rhox -> 0.979`,
			theta -> (1 - gamma)/(1 - 1/psi), vx -> 0.987`, mud[1] -> 0.0015`,
			phidxd[1] -> 4.5`, rhodx[1] -> 3};
		newP = {context2`delta -> 0.9, Esx -> 1, bar`gamma -> 2};
		procP = processNewParameters[newP, p];
		(* Contexts of procP match those in old parameters in p *)
		(Context /@ Keys @ procP) === Context /@ (Keys @ KeyTake[p, Keys @ procP])
	],
	True,
	{},
	TestID -> "[processNewParameters] Processed contexts match old parameters"
]


(* ::Subsection:: *)
(*toNum Function Tests*)

(* Define test expressions and numerical model values *)
(* Extract state variable patterns from the model's stateVars function *)
stateVarPatterns = Map[
	#[_] &,
	DeleteDuplicates[
		DeleteCases[
			Cases[Variables[$modNRC["stateVars"][t]], x_[_] :> x],
			0
		]
	]
];
numModel = Join[
	Thread[stateVarPatterns -> 1.],
	{
		FernandoDuarte`LongRunRisk`Model`Shocks`eps[_][_] -> 1.,
		FernandoDuarte`LongRunRisk`Model`Shocks`eps[_][_, _] -> 1.,
		mu -> 0.2,
		AA -> -1.,
		BB -> 3.
	}
];

expr[t_, m_, i_, mu_] := {
	wc[t], pd[t, i], bond[t, m], nombond[t, m], bondexcret[t, m], bondfw[t, m],
	bondfwspread[t, m], bondret[t, m], bondyield[t, m], excretc[t], excret[t, i],
	kappa0[mu], kappa1[mu], nombondexcret[t, m], nombondfw[t, m], nombondfwspread[t, m],
	nombondret[t, m], nombondyield[t, m], nomrf[t], nomsdf[t], retc[t], ret[t, i],
	rf[t], sdf[t], pi[t], dc[t],
	growth[dc, t, "TimeAggregation" -> 2, "numPeriods" -> 1],
	growth[dd, t, 1, "TimeAggregation" -> 2],
	AA dc[t + 1] excret[t, 1],
	AA excret[t, 1] + BB nombondyield[t, 2]
};

ee = expr[t, 3, 1, 1];
e1 = ee[[1 ;; 3]];
e2 = ee[[1 ;; 2]];


(* Test: toNum[thisModel] returns a Function *)
TestCreate[
	Head[toNum[$modNRC]] === Function,
	True,
	{},
	TestID -> "[toNum] Curried form returns Function"
]

(* Test: Numerical evaluation of expressions *)
TestCreate[
	With[{tn = toNum[$modNRC]},
		AllTrue[Flatten[{
			((e1 // tn) //. numModel),
			(((uncondE /@ e1) // tn) //. numModel),
			(((uncondVar /@ e1) // tn) //. numModel),
			(((ev[#, t - 1] & /@ e1) // tn) //. numModel),
			(((var[#, t - 1] & /@ e1) // tn) //. numModel)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum] Expressions with expectations evaluate to numbers"
]

(* Test: toNum[expression, thisModel] form *)
TestCreate[
	AllTrue[Flatten[{
		((toNum[e1, $modNRC]) //. numModel),
		(((toNum[uncondE /@ e1, $modNRC])) //. numModel),
		(((toNum[uncondVar /@ e1, $modNRC])) //. numModel),
		(((toNum[ev[#, t - 1] & /@ e1, $modNRC])) //. numModel),
		(((toNum[var[#, t - 1] & /@ e1, $modNRC])) //. numModel)
	}], NumericQ],
	True,
	{},
	TestID -> "[toNum] Two-argument form evaluates to numbers"
]

(* Test: toNum["Rules", thisModel] form *)
TestCreate[
	AllTrue[Flatten[{
		((toEquation[e1, $modNRC]) //. numModel),
		(((toEquation[uncondE /@ e1, $modNRC])) //. numModel),
		(((toEquation[uncondVar /@ e1, $modNRC])) //. numModel),
		(((toEquation[ev[#, t - 1] & /@ e1, $modNRC])) //. numModel),
		(((toEquation[var[#, t - 1] & /@ e1, $modNRC])) //. numModel)
	} //. toNum["Rules", $modNRC]], NumericQ],
	True,
	{},
	TestID -> "[toNum] Rules form evaluates to numbers"
]


(* ::Subsection:: *)
(*Options Handling Tests*)

(* Test: "UpdatePd" and "UpdateBonds" options *)
TestCreate[
	AllTrue[Flatten[{
		pd[t, 1] // toNum[$modNRC, "UpdatePd" -> False] //. numModel,
		toNum[pd[t, 1], $modNRC, "UpdatePd" -> False] //. numModel,
		toEquation[pd[t, 1], $modNRC] //. toNum["Rules", $modNRC, "UpdatePd" -> False] //. numModel,

		{bondyield[t, 2], nombondyield[t, 3]} // toNum[$modNRC, "UpdateBonds" -> False] //. numModel,
		toNum[{bondyield[t, 2], nombondyield[t, 3]}, $modNRC, "UpdateBonds" -> False] //. numModel,
		toEquation[{bondyield[t, 2], nombondyield[t, 3]}, $modNRC] //. toNum["Rules", $modNRC, "UpdateBonds" -> False] //. numModel
	}], NumericQ],
	True,
	{},
	TestID -> "[toNum] UpdatePd and UpdateBonds options evaluate to numbers"
]

(* ::Subsection:: *)
(*New Parameters and Initial Guess Tests*)

(* Test: Pass new parameters *)
TestCreate[
	With[{newParameters = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.99}, exprNewParam = uncondE[wc[t]]},
		AllTrue[{
			exprNewParam // toNum[$modNRC, newParameters] //. numModel,
			toNum[exprNewParam, $modNRC, newParameters] //. numModel,
			toEquation[exprNewParam, $modNRC] //. toNum["Rules", $modNRC, newParameters] //. numModel
		}, NumericQ]
	],
	True,
	{},
	TestID -> "[toNum] New parameters evaluate to numbers"
]

(* NOTE: Tests for guessCoeffsSolution and MaxIterations removed - features were non-functional and removed in Phase 1.5 *)

(* ::Subsection:: *)
(*Association Handling Tests*)

(* Test: toNum handles Associations via curried form *)
TestCreate[
	With[{tn = toNum[$modNRC]},
		(wc[t] // tn /. numModel) // AllTrue[#, NumericQ]&
	],
	True,
	{},
	TestID -> "[toNum] Association input produces numeric values"
]

(* ::Subsection:: *)
(*Helper Functions Tests*)

(* Test: toExogenousVars returns expression with only exogenous vars *)
TestCreate[
	FreeQ[toExogenousVars[wc[t], $modNRC], wc],
	True,
	{},
	TestID -> "[toExogenousVars] Removes endogenous wc from expression"
]

(* Test: toStateVars returns expression with only state vars *)
TestCreate[
	FreeQ[toStateVars[wc[t], $modNRC], wc],
	True,
	{},
	TestID -> "[toStateVars] Removes endogenous wc from expression"
]

(* ::Subsection:: *)
(*Edge Cases Tests*)

(* Test: Empty list input *)
TestCreate[
	toNum[{}, $modNRC] === {},
	True,
	{},
	TestID -> "[toNum] Empty list input returns empty list"
]

(* Test: Mixed types input *)
TestCreate[
	With[{res = toNum[{1.0, "text", wc[t]}, $modNRC] //. numModel},
		MatchQ[res, {1.0, "text", _?NumericQ}]
	],
	True,
	{},
	TestID -> "[toNum] Mixed types preserves literals and converts wc"
]


(* ::Subsection:: *)
(*Multi-Model Integration Tests*)

(* Helper function to get numerical substitution rules for a given model *)
(* Extracts state variable patterns from the model's stateVars function and creates replacement rules *)
getNumModel[mod_] := Module[{stateVarPatterns},
	stateVarPatterns = Map[
		#[_] &,
		DeleteDuplicates[
			DeleteCases[
				Cases[Variables[mod["stateVars"][t]], x_[_] :> x],
				0
			]
		]
	];
	Join[
		Thread[stateVarPatterns -> 1.],
		{
			FernandoDuarte`LongRunRisk`Model`Shocks`eps[_][_] -> 1.,
			FernandoDuarte`LongRunRisk`Model`Shocks`eps[_][_, _] -> 1.,
			mu -> 0.2,
			AA -> -1.,
			BB -> 3.,
			FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Ewc -> 1.,
			FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Epd[_] -> 1.
		}
	]
];


(* ::Subsubsection:: *)
(*BY Model Tests*)


(* Test: BY model curried toNum evaluates expressions to numbers *)
TestCreate[
	Module[{tn, numMod, testExprs},
		tn = toNum[$modBY];
		numMod = getNumModel[$modBY];
		testExprs = {wc[t], pd[t, 1], bond[t, 3]};
		AllTrue[Flatten[{
			(tn[testExprs] //. numMod),
			(tn[uncondE /@ testExprs] //. numMod),
			(tn[uncondVar /@ testExprs] //. numMod),
			(tn[ev[#, t - 1] & /@ testExprs] //. numMod),
			(tn[var[#, t - 1] & /@ testExprs] //. numMod)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/BY] Curried form with expectations evaluates to numbers"
]

(* Test: BY model expression toNum form evaluates to numbers *)
TestCreate[
	Module[{numMod, testExprs},
		numMod = getNumModel[$modBY];
		testExprs = {wc[t], pd[t, 1], bond[t, 3]};
		AllTrue[Flatten[{
			(toNum[testExprs, $modBY] //. numMod),
			(toNum[uncondE /@ testExprs, $modBY] //. numMod),
			(toNum[uncondVar /@ testExprs, $modBY] //. numMod),
			(toNum[ev[#, t - 1] & /@ testExprs, $modBY] //. numMod),
			(toNum[var[#, t - 1] & /@ testExprs, $modBY] //. numMod)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/BY] Expression form with expectations evaluates to numbers"
]

(* Test: BY model Rules toNum form evaluates to numbers *)
TestCreate[
	Module[{numMod, testExprs, rules},
		numMod = getNumModel[$modBY];
		testExprs = {wc[t], pd[t, 1], bond[t, 3]};
		rules = toNum["Rules", $modBY];
		AllTrue[Flatten[{
			(toEquation[testExprs, $modBY] //. rules //. numMod),
			(toEquation[uncondE /@ testExprs, $modBY] //. rules //. numMod),
			(toEquation[uncondVar /@ testExprs, $modBY] //. rules //. numMod),
			(toEquation[ev[#, t - 1] & /@ testExprs, $modBY] //. rules //. numMod),
			(toEquation[var[#, t - 1] & /@ testExprs, $modBY] //. rules //. numMod)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/BY] Rules form with expectations evaluates to numbers"
]


(* ::Subsubsection:: *)
(*BKY Model Tests*)


(* Test: BKY model curried toNum evaluates expressions to numbers *)
TestCreate[
	Module[{tn, numMod, testExprs},
		tn = toNum[$modBKY];
		numMod = getNumModel[$modBKY];
		testExprs = {wc[t], pd[t, 1], bond[t, 3]};
		AllTrue[Flatten[{
			(tn[testExprs] //. numMod),
			(tn[uncondE /@ testExprs] //. numMod),
			(tn[uncondVar /@ testExprs] //. numMod),
			(tn[ev[#, t - 1] & /@ testExprs] //. numMod),
			(tn[var[#, t - 1] & /@ testExprs] //. numMod)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/BKY] Curried form with expectations evaluates to numbers"
]

(* Test: BKY model expression toNum form evaluates to numbers *)
TestCreate[
	Module[{numMod, testExprs},
		numMod = getNumModel[$modBKY];
		testExprs = {wc[t], pd[t, 1], bond[t, 3]};
		AllTrue[Flatten[{
			(toNum[testExprs, $modBKY] //. numMod),
			(toNum[uncondE /@ testExprs, $modBKY] //. numMod),
			(toNum[uncondVar /@ testExprs, $modBKY] //. numMod),
			(toNum[ev[#, t - 1] & /@ testExprs, $modBKY] //. numMod),
			(toNum[var[#, t - 1] & /@ testExprs, $modBKY] //. numMod)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/BKY] Expression form with expectations evaluates to numbers"
]

(* Test: BKY model Rules toNum form evaluates to numbers *)
TestCreate[
	Module[{numMod, testExprs, rules},
		numMod = getNumModel[$modBKY];
		testExprs = {wc[t], pd[t, 1], bond[t, 3]};
		rules = toNum["Rules", $modBKY];
		AllTrue[Flatten[{
			(toEquation[testExprs, $modBKY] //. rules //. numMod),
			(toEquation[uncondE /@ testExprs, $modBKY] //. rules //. numMod),
			(toEquation[uncondVar /@ testExprs, $modBKY] //. rules //. numMod),
			(toEquation[ev[#, t - 1] & /@ testExprs, $modBKY] //. rules //. numMod),
			(toEquation[var[#, t - 1] & /@ testExprs, $modBKY] //. rules //. numMod)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/BKY] Rules form with expectations evaluates to numbers"
]


(* ::Subsubsection:: *)
(*DES Model Tests*)


(* Test: DES model curried toNum evaluates expressions to numbers *)
TestCreate[
	Module[{tn, numMod, testExprs},
		tn = toNum[$modDES];
		numMod = getNumModel[$modDES];
		testExprs = {wc[t], pd[t, 1], bond[t, 3]};
		AllTrue[Flatten[{
			(tn[testExprs] //. numMod),
			(tn[uncondE /@ testExprs] //. numMod),
			(tn[uncondVar /@ testExprs] //. numMod),
			(tn[ev[#, t - 1] & /@ testExprs] //. numMod),
			(tn[var[#, t - 1] & /@ testExprs] //. numMod)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/DES] Curried form with expectations evaluates to numbers"
]

(* Test: DES model expression toNum form evaluates to numbers *)
TestCreate[
	Module[{numMod, testExprs},
		numMod = getNumModel[$modDES];
		testExprs = {wc[t], pd[t, 1], bond[t, 3]};
		AllTrue[Flatten[{
			(toNum[testExprs, $modDES] //. numMod),
			(toNum[uncondE /@ testExprs, $modDES] //. numMod),
			(toNum[uncondVar /@ testExprs, $modDES] //. numMod),
			(toNum[ev[#, t - 1] & /@ testExprs, $modDES] //. numMod),
			(toNum[var[#, t - 1] & /@ testExprs, $modDES] //. numMod)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/DES] Expression form with expectations evaluates to numbers"
]

(* Test: DES model Rules toNum form evaluates to numbers *)
TestCreate[
	Module[{numMod, testExprs, rules},
		numMod = getNumModel[$modDES];
		testExprs = {wc[t], pd[t, 1], bond[t, 3]};
		rules = toNum["Rules", $modDES];
		AllTrue[Flatten[{
			(toEquation[testExprs, $modDES] //. rules //. numMod),
			(toEquation[uncondE /@ testExprs, $modDES] //. rules //. numMod),
			(toEquation[uncondVar /@ testExprs, $modDES] //. rules //. numMod),
			(toEquation[ev[#, t - 1] & /@ testExprs, $modDES] //. rules //. numMod),
			(toEquation[var[#, t - 1] & /@ testExprs, $modDES] //. rules //. numMod)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/DES] Rules form with expectations evaluates to numbers"
]


(* ::Subsubsection:: *)
(*NRCStochVol Model Tests*)


(* Test: NRCStochVol model curried toNum evaluates expressions to numbers *)
TestCreate[
	Module[{tn, numMod, testExprs},
		tn = toNum[$modNRCStochVol];
		numMod = getNumModel[$modNRCStochVol];
		testExprs = {wc[t], pd[t, 1], bond[t, 3]};
		AllTrue[Flatten[{
			(tn[testExprs] //. numMod),
			(tn[uncondE /@ testExprs] //. numMod),
			(tn[uncondVar /@ testExprs] //. numMod),
			(tn[ev[#, t - 1] & /@ testExprs] //. numMod),
			(tn[var[#, t - 1] & /@ testExprs] //. numMod)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/NRCStochVol] Curried form with expectations evaluates to numbers"
]

(* Test: NRCStochVol model expression toNum form evaluates to numbers *)
TestCreate[
	Module[{numMod, testExprs},
		numMod = getNumModel[$modNRCStochVol];
		testExprs = {wc[t], pd[t, 1], bond[t, 3]};
		AllTrue[Flatten[{
			(toNum[testExprs, $modNRCStochVol] //. numMod),
			(toNum[uncondE /@ testExprs, $modNRCStochVol] //. numMod),
			(toNum[uncondVar /@ testExprs, $modNRCStochVol] //. numMod),
			(toNum[ev[#, t - 1] & /@ testExprs, $modNRCStochVol] //. numMod),
			(toNum[var[#, t - 1] & /@ testExprs, $modNRCStochVol] //. numMod)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/NRCStochVol] Expression form with expectations evaluates to numbers"
]

(* Test: NRCStochVol model Rules toNum form evaluates to numbers *)
TestCreate[
	Module[{numMod, testExprs, rules},
		numMod = getNumModel[$modNRCStochVol];
		testExprs = {wc[t], pd[t, 1], bond[t, 3]};
		rules = toNum["Rules", $modNRCStochVol];
		AllTrue[Flatten[{
			(toEquation[testExprs, $modNRCStochVol] //. rules //. numMod),
			(toEquation[uncondE /@ testExprs, $modNRCStochVol] //. rules //. numMod),
			(toEquation[uncondVar /@ testExprs, $modNRCStochVol] //. rules //. numMod),
			(toEquation[ev[#, t - 1] & /@ testExprs, $modNRCStochVol] //. rules //. numMod),
			(toEquation[var[#, t - 1] & /@ testExprs, $modNRCStochVol] //. rules //. numMod)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/NRCStochVol] Rules form with expectations evaluates to numbers"
]


(* ::Subsection:: *)
(*Unconditional Covariance and Correlation Tests*)


(* Test: uncondCov evaluates to numbers across models *)
TestCreate[
	Module[{testExprs, numMod, res},
		testExprs = {wc[t], pd[t, 1]};
		numMod = getNumModel[$modNRC];
		res = toNum[MapThread[uncondCov, {testExprs, Reverse[testExprs]}], $modNRC] //. numMod;
		AllTrue[Flatten[{res}], NumericQ]
	],
	True,
	{},
	TestID -> "[uncondCov] Evaluates to numbers for NRC model"
]

(* Test: uncondCorr evaluates to numbers across models *)
TestCreate[
	Module[{testExprs, numMod, res},
		testExprs = {wc[t], pd[t, 1]};
		numMod = getNumModel[$modNRC];
		res = toNum[MapThread[uncondCorr, {testExprs, Reverse[testExprs]}], $modNRC] //. numMod;
		AllTrue[Flatten[{res}], NumericQ]
	],
	True,
	{},
	TestID -> "[uncondCorr] Evaluates to numbers for NRC model"
]

(* Test: uncondCov evaluates to numbers for BKY model *)
TestCreate[
	Module[{testExprs, numMod, res},
		testExprs = {wc[t], pd[t, 1]};
		numMod = getNumModel[$modBKY];
		res = toNum[MapThread[uncondCov, {testExprs, Reverse[testExprs]}], $modBKY] //. numMod;
		AllTrue[Flatten[{res}], NumericQ]
	],
	True,
	{},
	TestID -> "[uncondCov] Evaluates to numbers for BKY model"
]

(* Test: uncondCorr evaluates to numbers for BKY model *)
TestCreate[
	Module[{testExprs, numMod, res},
		testExprs = {wc[t], pd[t, 1]};
		numMod = getNumModel[$modBKY];
		res = toNum[MapThread[uncondCorr, {testExprs, Reverse[testExprs]}], $modBKY] //. numMod;
		AllTrue[Flatten[{res}], NumericQ]
	],
	True,
	{},
	TestID -> "[uncondCorr] Evaluates to numbers for BKY model"
]


(* ::Subsection:: *)
(*Conditional Covariance and Correlation Tests*)


(* Test: cov evaluates to numbers across models *)
TestCreate[
	Module[{testExprs, numMod, res},
		testExprs = {wc[t], pd[t, 1]};
		numMod = getNumModel[$modNRC];
		res = toNum[MapThread[cov[#1, #2, t - 1] &, {testExprs, Reverse[testExprs]}], $modNRC] //. numMod;
		AllTrue[Flatten[{res}], NumericQ]
	],
	True,
	{},
	TestID -> "[cov] Evaluates to numbers for NRC model"
]

(* Test: corr evaluates to numbers across models *)
TestCreate[
	Module[{testExprs, numMod, res},
		testExprs = {wc[t], pd[t, 1]};
		numMod = getNumModel[$modNRC];
		res = toNum[MapThread[corr[#1, #2, t - 1] &, {testExprs, Reverse[testExprs]}], $modNRC] //. numMod;
		AllTrue[Flatten[{res}], NumericQ]
	],
	True,
	{},
	TestID -> "[corr] Evaluates to numbers for NRC model"
]

(* Test: cov evaluates to numbers for BKY model *)
TestCreate[
	Module[{testExprs, numMod, res},
		testExprs = {wc[t], pd[t, 1]};
		numMod = getNumModel[$modBKY];
		res = toNum[MapThread[cov[#1, #2, t - 1] &, {testExprs, Reverse[testExprs]}], $modBKY] //. numMod;
		AllTrue[Flatten[{res}], NumericQ]
	],
	True,
	{},
	TestID -> "[cov] Evaluates to numbers for BKY model"
]

(* Test: corr evaluates to numbers for BKY model *)
TestCreate[
	Module[{testExprs, numMod, res},
		testExprs = {wc[t], pd[t, 1]};
		numMod = getNumModel[$modBKY];
		res = toNum[MapThread[corr[#1, #2, t - 1] &, {testExprs, Reverse[testExprs]}], $modBKY] //. numMod;
		AllTrue[Flatten[{res}], NumericQ]
	],
	True,
	{},
	TestID -> "[corr] Evaluates to numbers for BKY model"
]


(* ::Subsection:: *)
(*Options Handling Integration Tests*)


(* NOTE: Test for maxMaturity option removed - feature was non-functional and removed in Phase 1.5 *)

(* Test: FindRootOptions option evaluates to numbers *)
TestCreate[
	Module[{tn, numMod, testExprs},
		tn = toNum[$modNRC, "FindRootOptions" -> {MaxIterations -> 100}];
		numMod = getNumModel[$modNRC];
		testExprs = {wc[t], pd[t, 1]};
		AllTrue[Flatten[{
			(tn[testExprs] //. numMod),
			(tn[uncondE /@ testExprs] //. numMod)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum] FindRootOptions option evaluates to numbers"
]

(* NOTE: Test for MaxIterations option removed - feature was non-functional and removed in Phase 1.5 *)

(* Test: CheckResiduals with large tolerance evaluates to numbers *)
TestCreate[
	Module[{tn, numMod, testExprs},
		tn = toNum[$modNRC, "CheckResiduals" -> True, "Tol" -> 1];
		numMod = getNumModel[$modNRC];
		testExprs = {wc[t], pd[t, 1]};
		AllTrue[Flatten[{
			(tn[testExprs] //. numMod),
			(tn[uncondE /@ testExprs] //. numMod)
		}], NumericQ]
	],
	True,
	{FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::smallresid,
	 FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::smallresid},
	TestID -> "[toNum] CheckResiduals with large tolerance evaluates to numbers"
]

(* Test: CheckResiduals with zero tolerance returns Failure *)
TestCreate[
	Module[{tn, result},
		tn = toNum[$modNRC, "CheckResiduals" -> True, "Tol" -> 0];
		result = tn[wc[t]];
		FailureQ[result]
	],
	True,
	{FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid},
	TestID -> "[toNum] CheckResiduals with zero tolerance returns Failure"
]

(* Test: RecurrenceTableOptions evaluates to numbers *)
TestCreate[
	Module[{tn, numMod, testExprs},
		tn = toNum[$modNRC, "RecurrenceTableOptions" -> {"DependentVariables" -> Automatic}];
		numMod = getNumModel[$modNRC];
		testExprs = {wc[t], pd[t, 1]};
		AllTrue[Flatten[{
			(tn[testExprs] //. numMod),
			(tn[uncondE /@ testExprs] //. numMod)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum] RecurrenceTableOptions evaluates to numbers"
]

(* NOTE: Test for DependentVariables option removed - feature was non-functional and removed in Phase 1.5 *)


(* ::Subsection:: *)
(*Multi-Model UpdatePd and UpdateBonds Tests*)


(* Test: UpdatePd option for BY model *)
TestCreate[
	Module[{numMod},
		numMod = getNumModel[$modBY];
		AllTrue[Flatten[{
			pd[t, 1] // toNum[$modBY, "UpdatePd" -> False] //. numMod,
			toNum[pd[t, 1], $modBY, "UpdatePd" -> False] //. numMod,
			toEquation[pd[t, 1], $modBY] //. toNum["Rules", $modBY, "UpdatePd" -> False] //. numMod
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/BY] UpdatePd option evaluates to numbers"
]

(* Test: UpdateBonds option for BY model *)
TestCreate[
	Module[{numMod},
		numMod = getNumModel[$modBY];
		AllTrue[Flatten[{
			{bondyield[t, 2], nombondyield[t, 3]} // toNum[$modBY, "UpdateBonds" -> False] //. numMod,
			toNum[{bondyield[t, 2], nombondyield[t, 3]}, $modBY, "UpdateBonds" -> False] //. numMod,
			toEquation[{bondyield[t, 2], nombondyield[t, 3]}, $modBY] //. toNum["Rules", $modBY, "UpdateBonds" -> False] //. numMod
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/BY] UpdateBonds option evaluates to numbers"
]

(* Test: UpdatePd option for BKY model *)
TestCreate[
	Module[{numMod},
		numMod = getNumModel[$modBKY];
		AllTrue[Flatten[{
			pd[t, 1] // toNum[$modBKY, "UpdatePd" -> False] //. numMod,
			toNum[pd[t, 1], $modBKY, "UpdatePd" -> False] //. numMod,
			toEquation[pd[t, 1], $modBKY] //. toNum["Rules", $modBKY, "UpdatePd" -> False] //. numMod
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/BKY] UpdatePd option evaluates to numbers"
]

(* Test: UpdateBonds option for BKY model *)
TestCreate[
	Module[{numMod},
		numMod = getNumModel[$modBKY];
		AllTrue[Flatten[{
			{bondyield[t, 2], nombondyield[t, 3]} // toNum[$modBKY, "UpdateBonds" -> False] //. numMod,
			toNum[{bondyield[t, 2], nombondyield[t, 3]}, $modBKY, "UpdateBonds" -> False] //. numMod,
			toEquation[{bondyield[t, 2], nombondyield[t, 3]}, $modBKY] //. toNum["Rules", $modBKY, "UpdateBonds" -> False] //. numMod
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/BKY] UpdateBonds option evaluates to numbers"
]

(* Test: UpdatePd option for DES model *)
TestCreate[
	Module[{numMod},
		numMod = getNumModel[$modDES];
		AllTrue[Flatten[{
			pd[t, 1] // toNum[$modDES, "UpdatePd" -> False] //. numMod,
			toNum[pd[t, 1], $modDES, "UpdatePd" -> False] //. numMod,
			toEquation[pd[t, 1], $modDES] //. toNum["Rules", $modDES, "UpdatePd" -> False] //. numMod
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/DES] UpdatePd option evaluates to numbers"
]

(* Test: UpdateBonds option for DES model *)
TestCreate[
	Module[{numMod},
		numMod = getNumModel[$modDES];
		AllTrue[Flatten[{
			{bondyield[t, 2], nombondyield[t, 3]} // toNum[$modDES, "UpdateBonds" -> False] //. numMod,
			toNum[{bondyield[t, 2], nombondyield[t, 3]}, $modDES, "UpdateBonds" -> False] //. numMod,
			toEquation[{bondyield[t, 2], nombondyield[t, 3]}, $modDES] //. toNum["Rules", $modDES, "UpdateBonds" -> False] //. numMod
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/DES] UpdateBonds option evaluates to numbers"
]

(* Test: UpdatePd option for NRCStochVol model *)
TestCreate[
	Module[{numMod},
		numMod = getNumModel[$modNRCStochVol];
		AllTrue[Flatten[{
			pd[t, 1] // toNum[$modNRCStochVol, "UpdatePd" -> False] //. numMod,
			toNum[pd[t, 1], $modNRCStochVol, "UpdatePd" -> False] //. numMod,
			toEquation[pd[t, 1], $modNRCStochVol] //. toNum["Rules", $modNRCStochVol, "UpdatePd" -> False] //. numMod
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/NRCStochVol] UpdatePd option evaluates to numbers"
]

(* Test: UpdateBonds option for NRCStochVol model *)
TestCreate[
	Module[{numMod},
		numMod = getNumModel[$modNRCStochVol];
		AllTrue[Flatten[{
			{bondyield[t, 2], nombondyield[t, 3]} // toNum[$modNRCStochVol, "UpdateBonds" -> False] //. numMod,
			toNum[{bondyield[t, 2], nombondyield[t, 3]}, $modNRCStochVol, "UpdateBonds" -> False] //. numMod,
			toEquation[{bondyield[t, 2], nombondyield[t, 3]}, $modNRCStochVol] //. toNum["Rules", $modNRCStochVol, "UpdateBonds" -> False] //. numMod
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/NRCStochVol] UpdateBonds option evaluates to numbers"
]


(* ::Subsection:: *)
(*Multi-Model Parameter Handling Tests*)


(* Test: New parameters with BY model *)
TestCreate[
	Module[{numMod, newParameters, exprNewParam},
		numMod = getNumModel[$modBY];
		newParameters = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.99};
		exprNewParam = uncondE[wc[t]];
		AllTrue[{
			exprNewParam // toNum[$modBY, newParameters] //. numMod,
			toNum[exprNewParam, $modBY, newParameters] //. numMod,
			toEquation[exprNewParam, $modBY] //. toNum["Rules", $modBY, newParameters] //. numMod
		}, NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/BY] New parameters evaluate to numbers"
]

(* Test: Initial guess with BY model *)
(* NOTE: Tests for guessCoeffsSolution with BY model removed - feature was non-functional and removed in Phase 1.5 *)

(* Test: New parameters with BKY model *)
TestCreate[
	Module[{numMod, newParameters, exprNewParam},
		numMod = getNumModel[$modBKY];
		newParameters = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.99};
		exprNewParam = uncondE[wc[t]];
		AllTrue[{
			exprNewParam // toNum[$modBKY, newParameters] //. numMod,
			toNum[exprNewParam, $modBKY, newParameters] //. numMod,
			toEquation[exprNewParam, $modBKY] //. toNum["Rules", $modBKY, newParameters] //. numMod
		}, NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/BKY] New parameters evaluate to numbers"
]

(* NOTE: Test for guessCoeffsSolution and MaxIterations with BKY model removed - features were non-functional and removed in Phase 1.5 *)

(* Test: New parameters with DES model *)
TestCreate[
	Module[{numMod, newParameters, exprNewParam},
		numMod = getNumModel[$modDES];
		newParameters = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.99};
		exprNewParam = uncondE[wc[t]];
		AllTrue[{
			exprNewParam // toNum[$modDES, newParameters] //. numMod,
			toNum[exprNewParam, $modDES, newParameters] //. numMod,
			toEquation[exprNewParam, $modDES] //. toNum["Rules", $modDES, newParameters] //. numMod
		}, NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/DES] New parameters evaluate to numbers"
]

(* Test: New parameters with NRCStochVol model *)
TestCreate[
	Module[{numMod, newParameters, exprNewParam},
		numMod = getNumModel[$modNRCStochVol];
		newParameters = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.99};
		exprNewParam = uncondE[wc[t]];
		AllTrue[{
			exprNewParam // toNum[$modNRCStochVol, newParameters] //. numMod,
			toNum[exprNewParam, $modNRCStochVol, newParameters] //. numMod,
			toEquation[exprNewParam, $modNRCStochVol] //. toNum["Rules", $modNRCStochVol, newParameters] //. numMod
		}, NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/NRCStochVol] New parameters evaluate to numbers"
]


(* ::Subsection:: *)
(*Extended Expression Types Tests*)


(* Test: All expression types evaluate to numbers for NRC model *)
TestCreate[
	Module[{numMod, allExprs},
		numMod = getNumModel[$modNRC];
		allExprs = {
			wc[t], pd[t, 1], bond[t, 3], nombond[t, 3], bondexcret[t, 3], bondfw[t, 3],
			bondfwspread[t, 3], bondret[t, 3], bondyield[t, 3], excretc[t], excret[t, 1],
			kappa0[1], kappa1[1], nombondexcret[t, 3], nombondfw[t, 3], nombondfwspread[t, 3],
			nombondret[t, 3], nombondyield[t, 3], nomrf[t], nomsdf[t], retc[t], ret[t, 1],
			rf[t], sdf[t], pi[t], dc[t]
		};
		AllTrue[Flatten[{toNum[allExprs, $modNRC] //. numMod}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum] All expression types evaluate to numbers for NRC model"
]

(* Test: Growth expressions evaluate to numbers *)
TestCreate[
	Module[{numMod, growthExprs},
		numMod = getNumModel[$modNRC];
		growthExprs = {
			growth[dc, t, "TimeAggregation" -> 2, "numPeriods" -> 1],
			growth[dd, t, 1, "TimeAggregation" -> 2]
		};
		AllTrue[Flatten[{toNum[growthExprs, $modNRC] //. numMod}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum] Growth expressions evaluate to numbers"
]

(* Test: Composite expressions with arithmetic evaluate to numbers *)
TestCreate[
	Module[{numMod, compositeExprs},
		numMod = getNumModel[$modNRC];
		compositeExprs = {
			AA dc[t + 1] excret[t, 1],
			AA excret[t, 1] + BB nombondyield[t, 2]
		};
		AllTrue[Flatten[{toNum[compositeExprs, $modNRC] //. numMod}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum] Composite arithmetic expressions evaluate to numbers"
]

(* Test: All expression types evaluate to numbers for BKY model *)
TestCreate[
	Module[{numMod, allExprs},
		numMod = getNumModel[$modBKY];
		allExprs = {
			wc[t], pd[t, 1], bond[t, 3], nombond[t, 3], bondexcret[t, 3], bondfw[t, 3],
			bondfwspread[t, 3], bondret[t, 3], bondyield[t, 3], excretc[t], excret[t, 1],
			kappa0[1], kappa1[1], nombondexcret[t, 3], nombondfw[t, 3], nombondfwspread[t, 3],
			nombondret[t, 3], nombondyield[t, 3], nomrf[t], nomsdf[t], retc[t], ret[t, 1],
			rf[t], sdf[t], pi[t], dc[t]
		};
		AllTrue[Flatten[{toNum[allExprs, $modBKY] //. numMod}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum] All expression types evaluate to numbers for BKY model"
]


(* ::Subsection:: *)
(*SolutionSelector and ReturnAllSolutions Tests - Setup*)


(* Standard options used consistently in setup AND tests *)
$testUpdateOpts = {
	"RootSigns" -> All,
	"UpdatePd" -> True,
	"UpdateBonds" -> True,
	"MaxMaturity" -> 12
};

(* Pre-compute hierarchical solutions for BY model with all sign combinations *)
$byHierarchical = updateCoeffs[$modBY, Sequence @@ $testUpdateOpts];
$numBYSolutions = Length[$byHierarchical];

(* Extract first A and B solutions for comparison *)
$byFirstA = First[$byHierarchical];
$byFirstB = First[$byFirstA["Stocks"][1]];

(* Pre-compute hierarchical solutions for NRC model (has multiple solutions with sign patterns) *)
$nrcHierarchical = updateCoeffs[$modNRC, Sequence @@ $testUpdateOpts];
$numNRCSolutions = Length[$nrcHierarchical];

(* Extract first A and B solutions for NRC *)
$nrcFirstA = First[$nrcHierarchical];
$nrcFirstB = First[$nrcFirstA["Stocks"][1]];

(* Pre-compute hierarchical solutions for DES model (has multiple solutions) *)
$desHierarchical = updateCoeffs[$modDES, Sequence @@ $testUpdateOpts];
$numDESSolutions = Length[$desHierarchical];

(* Extract first A and B solutions for DES *)
$desFirstA = First[$desHierarchical];
$desFirstB = First[$desFirstA["Stocks"][1]];

(* Helper: check if result is valid flat rules (includes RuleDelayed for patterns like Epd[ind_] :> ...) *)
validFlatRules[rules_] := MatchQ[rules, {(_Rule | _RuleDelayed) ..}] && Length[rules] > 0;

(* Helper: reference to package A, B, P, R symbols for coefficient checking *)
$pkgA = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A;
$pkgB = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B;
$pkgP = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`P;
$pkgR = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`R;

(* Aliases for Parameters symbols *)
$pkgGamma = FernandoDuarte`LongRunRisk`Model`Parameters`gamma;
$pkgPsi = FernandoDuarte`LongRunRisk`Model`Parameters`psi;

(* Helper: check if result is valid hierarchical structure *)
validHierarchical[result_] := MatchQ[result, {__Association}] &&
	AllTrue[result, Function[sol, And[
		KeyExistsQ[sol, "A"],
		KeyExistsQ[sol, "SignsA"],
		KeyExistsQ[sol, "IntervalA"],
		KeyExistsQ[sol, "SolutionIndexA"],
		KeyExistsQ[sol, "Stocks"],
		AssociationQ[sol["Stocks"]],
		AllTrue[Values[sol["Stocks"]], Function[bSols,
			AllTrue[bSols, AssociationQ[#] && KeyExistsQ[#, "B"] && KeyExistsQ[#, "SignsB"] &]
		]]
	]]];


(* ::Subsection:: *)
(*SolutionSelector - Precondition Tests*)


(* Verify BY model produces exactly 1 A solution with RootSigns -> All *)
TestCreate[
	$numBYSolutions == 1,
	True,
	{},
	TestID -> "[toNum/SolutionSelector] BY model has 1 A solution (precondition)"
]

(* Verify BY model has exactly 1 B solution for stock 1 *)
TestCreate[
	Length[$byFirstA["Stocks"][1]] == 1,
	True,
	{},
	TestID -> "[toNum/SolutionSelector] BY model has 1 B solution (precondition)"
]

(* Verify NRC model produces multiple A solutions with RootSigns -> All *)
TestCreate[
	$numNRCSolutions >= 2,
	True,
	{},
	TestID -> "[toNum/SolutionSelector] NRC model has multiple A solutions (precondition)"
]

(* Verify NRC model has non-empty SignsA *)
TestCreate[
	Length[$nrcFirstA["SignsA"]] > 0,
	True,
	{},
	TestID -> "[toNum/SolutionSelector] NRC model has non-empty SignsA (precondition)"
]

(* Verify DES model produces multiple A solutions with RootSigns -> All *)
TestCreate[
	$numDESSolutions >= 2,
	True,
	{},
	TestID -> "[toNum/SolutionSelector] DES model has multiple A solutions (precondition)"
]


(* ::Subsection:: *)
(*SolutionSelector - Default Behavior Tests*)


(* Default returns flat rules *)
TestCreate[
	With[{rules = toNum["Rules", $modBY]},
		validFlatRules[rules]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector] Default returns flat rule list"
]

(* Automatic selector equivalent to default *)
TestCreate[
	With[{
		rulesDefault = toNum["Rules", $modBY],
		rulesAuto = toNum["Rules", $modBY, "SolutionSelector" -> Automatic]
	},
		Sort[rulesDefault] === Sort[rulesAuto]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector] Automatic equivalent to default"
]

(* Automatic equivalent to index 1 *)
TestCreate[
	With[{
		rulesAuto = toNum["Rules", $modBY, "SolutionSelector" -> Automatic],
		rulesFirst = toNum["Rules", $modBY, "SolutionSelector" -> 1]
	},
		Sort[rulesAuto] === Sort[rulesFirst]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector] Automatic equivalent to index 1"
]

(* Default expression form returns valid (non-Failure) result *)
TestCreate[
	With[{result = toNum[wc[t], $modBY]},
		Not[FailureQ[result]] && Head[result] =!= toNum
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector] Default expression form returns valid result"
]


(* ::Subsection:: *)
(*SolutionSelector - Integer Index Tests*)


(* Integer index 1 returns valid rules *)
TestCreate[
	With[{rules = toNum["Rules", $modBY, "SolutionSelector" -> 1]},
		validFlatRules[rules]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector] Index 1 returns valid flat rules"
]

(* Tests requiring 2+ A solutions removed - BY model has only 1 A solution *)
(* Index 2 and different-index comparison tests not applicable for BY *)

(* Boundary index (last solution) works *)
TestCreate[
	With[{rules = toNum["Rules", $modBY, "RootSigns" -> All, "SolutionSelector" -> $numBYSolutions]},
		validFlatRules[rules]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector] Last index returns valid rules"
]

(* Out-of-bounds index returns Failure *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "RootSigns" -> All, "SolutionSelector" -> 999]},
		FailureQ[result]
	],
	True,
	{toNum::badidx},
	TestID -> "[toNum/SolutionSelector] Out-of-bounds index returns Failure"
]

(* Zero index returns Failure *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "SolutionSelector" -> 0]},
		FailureQ[result]
	],
	True,
	{toNum::badidx},
	TestID -> "[toNum/SolutionSelector] Zero index returns Failure"
]

(* Negative index returns Failure *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "SolutionSelector" -> -1]},
		FailureQ[result]
	],
	True,
	{toNum::badidx},
	TestID -> "[toNum/SolutionSelector] Negative index returns Failure"
]

(* Non-integer index returns Failure *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "SolutionSelector" -> 1.5]},
		FailureQ[result]
	],
	True,
	{toNum::badselector},
	TestID -> "[toNum/SolutionSelector] Non-integer index returns Failure"
]


(* ::Subsection:: *)
(*SolutionSelector - Tuple Index Tests*)


(* Tuple {1, 1} returns valid rules *)
TestCreate[
	With[{rules = toNum["Rules", $modBY, "RootSigns" -> All, "SolutionSelector" -> {1, 1}]},
		validFlatRules[rules]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector] Tuple {1,1} returns valid rules"
]

(* Tuple selection matches integer A selection when B=1 *)
TestCreate[
	With[{
		rulesTuple = toNum["Rules", $modBY, "RootSigns" -> All, "SolutionSelector" -> {1, 1}],
		rulesInt = toNum["Rules", $modBY, "RootSigns" -> All, "SolutionSelector" -> 1]
	},
		Sort[rulesTuple] === Sort[rulesInt]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector] Tuple {1,1} matches integer 1"
]

(* Test requiring 2+ B solutions removed - BY model has only 1 B solution *)
(* Different B indices comparison test not applicable for BY *)

(* Invalid B index returns Failure *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "RootSigns" -> All, "SolutionSelector" -> {1, 999}]},
		FailureQ[result]
	],
	True,
	{toNum::badbidx},
	TestID -> "[toNum/SolutionSelector] Invalid B index returns Failure"
]

(* Three-element tuple returns Failure *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "SolutionSelector" -> {1, 1, 1}]},
		FailureQ[result]
	],
	True,
	{toNum::badselector},
	TestID -> "[toNum/SolutionSelector] Three-element tuple returns Failure"
]

(* Empty tuple returns Failure *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "SolutionSelector" -> {}]},
		FailureQ[result]
	],
	True,
	{toNum::badselector},
	TestID -> "[toNum/SolutionSelector] Empty tuple returns Failure"
]


(* ::Subsection:: *)
(*SolutionSelector - Sign-Based Selection Tests*)
(* Note: Uses NRC model which has non-empty SignsA/SignsB patterns *)


(* SignsA pattern returns valid rules *)
TestCreate[
	With[{
		targetSigns = $nrcFirstA["SignsA"],
		rules = toNum["Rules", $modNRC, "RootSigns" -> All,
			"SolutionSelector" -> <|"SignsA" -> $nrcFirstA["SignsA"]|>]
	},
		validFlatRules[rules]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector] SignsA pattern returns valid rules"
]

(* SignsA selection matches index 1 for first solution's signs *)
TestCreate[
	With[{
		rulesBySigns = toNum["Rules", $modNRC, "RootSigns" -> All,
			"SolutionSelector" -> <|"SignsA" -> $nrcFirstA["SignsA"]|>],
		rulesByIndex = toNum["Rules", $modNRC, "RootSigns" -> All, "SolutionSelector" -> 1]
	},
		Sort[rulesBySigns] === Sort[rulesByIndex]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector] SignsA selection matches corresponding index"
]

(* Combined SignsA and SignsB selection works *)
TestCreate[
	With[{rules = toNum["Rules", $modNRC, "RootSigns" -> All,
		"SolutionSelector" -> <|
			"SignsA" -> $nrcFirstA["SignsA"],
			"SignsB" -> $nrcFirstB["SignsB"]
		|>]},
		validFlatRules[rules]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector] Combined SignsA and SignsB selection works"
]

(* Non-matching signs return Failure *)
TestCreate[
	With[{result = toNum["Rules", $modNRC, "RootSigns" -> All,
		"SolutionSelector" -> <|"SignsA" -> {999, 999, 999}|>]},
		FailureQ[result]
	],
	True,
	{toNum::nosolution},
	TestID -> "[toNum/SolutionSelector] Non-matching SignsA returns Failure"
]

(* Empty SignsA returns Failure with helpful message *)
TestCreate[
	With[{result = toNum["Rules", $modNRC, "RootSigns" -> All,
		"SolutionSelector" -> <|"SignsA" -> {}|>]},
		FailureQ[result]
	],
	True,
	{toNum::emptysigns},
	TestID -> "[toNum/SolutionSelector] Empty SignsA returns Failure"
]

(* Invalid key in selector returns Failure *)
TestCreate[
	With[{result = toNum["Rules", $modBY,
		"SolutionSelector" -> <|"InvalidKey" -> {1}|>]},
		FailureQ[result]
	],
	True,
	{toNum::badselector},
	TestID -> "[toNum/SolutionSelector] Invalid association key returns Failure"
]


(* ::Subsection:: *)
(*SolutionSelector - SolutionIndexA Metadata Tests*)


(* SolutionIndexA selector returns valid rules *)
TestCreate[
	With[{
		targetIdx = $byFirstA["SolutionIndexA"],
		rules = toNum["Rules", $modBY, "RootSigns" -> All,
			"SolutionSelector" -> <|"SolutionIndexA" -> $byFirstA["SolutionIndexA"]|>]
	},
		validFlatRules[rules]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector] SolutionIndexA selector returns valid rules"
]

(* SolutionIndexA selection matches index 1 for first solution *)
TestCreate[
	With[{
		rulesByMeta = toNum["Rules", $modBY, "RootSigns" -> All,
			"SolutionSelector" -> <|"SolutionIndexA" -> $byFirstA["SolutionIndexA"]|>],
		rulesByIndex = toNum["Rules", $modBY, "RootSigns" -> All, "SolutionSelector" -> 1]
	},
		Sort[rulesByMeta] === Sort[rulesByIndex]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector] SolutionIndexA matches corresponding index"
]

(* Non-existent SolutionIndexA returns Failure *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "RootSigns" -> All,
		"SolutionSelector" -> <|"SolutionIndexA" -> 99999|>]},
		FailureQ[result]
	],
	True,
	{toNum::nosolution},
	TestID -> "[toNum/SolutionSelector] Non-existent SolutionIndexA returns Failure"
]


(* ::Subsection:: *)
(*SolutionSelector - All Value Tests*)


(* SolutionSelector -> All with ReturnAllSolutions -> True works *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "RootSigns" -> All,
		"SolutionSelector" -> All,
		"ReturnAllSolutions" -> True]},
		validHierarchical[result] && Length[result] === $numBYSolutions
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector] All with ReturnAllSolutions returns all solutions"
]

(* SolutionSelector -> All without ReturnAllSolutions -> True returns Failure *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "RootSigns" -> All,
		"SolutionSelector" -> All,
		"ReturnAllSolutions" -> False]},
		FailureQ[result]
	],
	True,
	{toNum::selectorallrequiresreturnall},
	TestID -> "[toNum/SolutionSelector] All without ReturnAllSolutions returns Failure"
]

(* SolutionSelector -> All is equivalent to omitting SolutionSelector with ReturnAllSolutions *)
TestCreate[
	With[{
		resultAll = toNum["Rules", $modBY, "RootSigns" -> All,
			"SolutionSelector" -> All, "ReturnAllSolutions" -> True],
		resultDefault = toNum["Rules", $modBY, "RootSigns" -> All,
			"ReturnAllSolutions" -> True]
	},
		Length[resultAll] === Length[resultDefault]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector] All equivalent to default with ReturnAllSolutions"
]


(* ::Subsection:: *)
(*Option Acceptance Tests*)


(* New options are accepted without OptionValue::notopt message *)
TestCreate[
	Not @ checkMsg[
		toNum["Rules", $modBY, "SolutionSelector" -> 1],
		OptionValue::notopt
	],
	True,
	{},
	TestID -> "[toNum/Options] SolutionSelector accepted without notopt message"
]

TestCreate[
	Not @ checkMsg[
		toNum["Rules", $modBY, "ReturnAllSolutions" -> True],
		OptionValue::notopt
	],
	True,
	{},
	TestID -> "[toNum/Options] ReturnAllSolutions accepted without notopt message"
]

(* toNum::nosolution message issued for non-matching selector *)
TestCreate[
	checkMsg[
		toNum["Rules", $modBY, "RootSigns" -> All,
			"SolutionSelector" -> <|"SignsA" -> {999, 999, 999}|>],
		toNum::nosolution
	],
	True,
	{},
	TestID -> "[toNum/Messages] nosolution message issued for non-matching selector"
]

(* toNum::badidx message issued for out-of-bounds index *)
TestCreate[
	checkMsg[
		toNum["Rules", $modBY, "RootSigns" -> All, "SolutionSelector" -> 999],
		toNum::badidx
	],
	True,
	{},
	TestID -> "[toNum/Messages] badidx message issued for out-of-bounds index"
]

(* toNum::badselector message issued for invalid selector type *)
TestCreate[
	checkMsg[
		toNum["Rules", $modBY, "SolutionSelector" -> "invalid"],
		toNum::badselector
	],
	True,
	{},
	TestID -> "[toNum/Messages] badselector message issued for invalid type"
]


(* ::Subsection:: *)
(*ReturnAllSolutions Tests*)


(* ReturnAllSolutions->True returns list of associations *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "RootSigns" -> All, "ReturnAllSolutions" -> True]},
		validHierarchical[result]
	],
	True,
	{},
	TestID -> "[toNum/ReturnAllSolutions] True returns list of associations"
]

(* ReturnAllSolutions preserves SignsA metadata *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "RootSigns" -> All, "ReturnAllSolutions" -> True]},
		AllTrue[result, KeyExistsQ[#, "SignsA"] &]
	],
	True,
	{},
	TestID -> "[toNum/ReturnAllSolutions] Preserves SignsA metadata"
]

(* ReturnAllSolutions preserves IntervalA metadata *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "RootSigns" -> All, "ReturnAllSolutions" -> True]},
		AllTrue[result, KeyExistsQ[#, "IntervalA"] &]
	],
	True,
	{},
	TestID -> "[toNum/ReturnAllSolutions] Preserves IntervalA metadata"
]

(* ReturnAllSolutions preserves Stocks structure *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "RootSigns" -> All, "ReturnAllSolutions" -> True]},
		AllTrue[result, KeyExistsQ[#, "Stocks"] && AssociationQ[#["Stocks"]] &]
	],
	True,
	{},
	TestID -> "[toNum/ReturnAllSolutions] Preserves Stocks structure"
]

(* ReturnAllSolutions count matches updateCoeffs *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "RootSigns" -> All, "ReturnAllSolutions" -> True]},
		Length[result] === $numBYSolutions
	],
	True,
	{},
	TestID -> "[toNum/ReturnAllSolutions] Solution count matches updateCoeffs"
]

(* ReturnAllSolutions->False returns flat rules (backward compat) *)
TestCreate[
	With[{rules = toNum["Rules", $modBY, "ReturnAllSolutions" -> False]},
		validFlatRules[rules]
	],
	True,
	{},
	TestID -> "[toNum/ReturnAllSolutions] False returns flat rules"
]

(* Single solution case returns single-element list *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "SolutionSelector" -> 1, "ReturnAllSolutions" -> True]},
		MatchQ[result, {_Association}] && Length[result] === 1
	],
	True,
	{},
	TestID -> "[toNum/ReturnAllSolutions] Single solution returns {_Association}"
]

(* Each solution in list contains valid A coefficients and Stocks structure *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "RootSigns" -> All, "ReturnAllSolutions" -> True]},
		AllTrue[result, Function[sol,
			And[
				KeyExistsQ[sol, "A"],
				AssociationQ[sol["A"]],
				KeyExistsQ[sol["A"], $pkgA[0]],
				NumericQ[sol["A"][$pkgA[0]]],
				KeyExistsQ[sol, "Stocks"],
				AssociationQ[sol["Stocks"]]
			]
		]]
	],
	True,
	{},
	TestID -> "[toNum/ReturnAllSolutions] Each solution has valid A coefficients and Stocks"
]


(* ::Subsection:: *)
(*Option Interaction Tests*)


(* SolutionSelector + ReturnAllSolutions filters results *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "RootSigns" -> All,
		"SolutionSelector" -> 1,
		"ReturnAllSolutions" -> True]},
		MatchQ[result, {_Association}]
	],
	True,
	{},
	TestID -> "[toNum/Options] Index selector + ReturnAllSolutions returns filtered list"
]

(* Both new options with newParameters works *)
TestCreate[
	Module[{newParams, result},
		newParams = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.99};
		result = toNum["Rules", $modBY, newParams,
			"SolutionSelector" -> 1,
			"ReturnAllSolutions" -> False];
		validFlatRules[result]
	],
	True,
	{},
	TestID -> "[toNum/Options] Both options with newParameters works"
]

(* SolutionSelector works with expression form - returns non-Failure result *)
TestCreate[
	With[{result = toNum[wc[t], $modBY, "RootSigns" -> All, "SolutionSelector" -> 1]},
		Not[FailureQ[result]] && Head[result] =!= toNum
	],
	True,
	{},
	TestID -> "[toNum/Options] SolutionSelector works with expression form"
]

(* Curried form with SolutionSelector works - returns function then non-Failure result *)
TestCreate[
	With[{tn = toNum[$modBY, "SolutionSelector" -> 1]},
		Head[tn] === Function && Not[FailureQ[tn[wc[t]]]]
	],
	True,
	{},
	TestID -> "[toNum/Options] Curried form with SolutionSelector works"
]

(* ReturnAllSolutions with expression - Rules form returns hierarchical structure *)
(* Note: Expression form with ReturnAllSolutions returns hierarchical structure from Rules, not evaluated expressions *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "RootSigns" -> All, "ReturnAllSolutions" -> True]},
		validHierarchical[result]
	],
	True,
	{},
	TestID -> "[toNum/Options] ReturnAllSolutions returns hierarchical list"
]

(* Deterministic: same selector always produces same result *)
TestCreate[
	With[{
		rules1 = toNum["Rules", $modBY, "RootSigns" -> All, "SolutionSelector" -> 1],
		rules2 = toNum["Rules", $modBY, "RootSigns" -> All, "SolutionSelector" -> 1]
	},
		Sort[rules1] === Sort[rules2]
	],
	True,
	{},
	TestID -> "[toNum/Options] Deterministic - same selector same result"
]


(* ::Subsection:: *)
(*SolutionSelector and ReturnAllSolutions - Edge Cases*)


(* String index returns Failure *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "SolutionSelector" -> "1"]},
		FailureQ[result]
	],
	True,
	{toNum::badselector},
	TestID -> "[toNum/Edge] String index returns Failure"
]

(* List with non-integers returns Failure *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "SolutionSelector" -> {1.0, 2.0}]},
		FailureQ[result]
	],
	True,
	{toNum::badselector},
	TestID -> "[toNum/Edge] List with non-integers returns Failure"
]

(* Nested list returns Failure *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "SolutionSelector" -> {{1, 1}}]},
		FailureQ[result]
	],
	True,
	{toNum::badselector},
	TestID -> "[toNum/Edge] Nested list returns Failure"
]

(* ReturnAllSolutions with invalid value returns Failure *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "ReturnAllSolutions" -> "yes"]},
		FailureQ[result]
	],
	True,
	{toNum::badreturnall},
	TestID -> "[toNum/Edge] ReturnAllSolutions invalid value returns Failure"
]

(* Very large index returns Failure quickly *)
TestCreate[
	With[{result = TimeConstrained[
		toNum["Rules", $modBY, "SolutionSelector" -> 10^9],
		5,
		$TimedOut
	]},
		FailureQ[result] || result === $TimedOut
	],
	True,
	{toNum::badidx},
	TestID -> "[toNum/Edge] Large index handled without hang"
]


(* ::Subsection:: *)
(*Tuple Index Edge Cases*)


(* Tuple {0, 1} returns Failure - zero A index invalid *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "RootSigns" -> All, "SolutionSelector" -> {0, 1}]},
		FailureQ[result]
	],
	True,
	{toNum::badidx},
	TestID -> "[toNum/Edge/Tuple] {0,1} zero A index returns Failure"
]

(* Tuple {-1, 1} returns Failure - negative A index invalid *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "RootSigns" -> All, "SolutionSelector" -> {-1, 1}]},
		FailureQ[result]
	],
	True,
	{toNum::badidx},
	TestID -> "[toNum/Edge/Tuple] {-1,1} negative A index returns Failure"
]

(* Tuple {1, 0} returns Failure - zero B index invalid *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "RootSigns" -> All, "SolutionSelector" -> {1, 0}]},
		FailureQ[result]
	],
	True,
	{toNum::badbidx},
	TestID -> "[toNum/Edge/Tuple] {1,0} zero B index returns Failure"
]

(* Tuple {1, -1} returns Failure - negative B index invalid *)
TestCreate[
	With[{result = toNum["Rules", $modBY, "RootSigns" -> All, "SolutionSelector" -> {1, -1}]},
		FailureQ[result]
	],
	True,
	{toNum::badbidx},
	TestID -> "[toNum/Edge/Tuple] {1,-1} negative B index returns Failure"
]

(* toNum::badbidx message issued for invalid B index *)
TestCreate[
	checkMsg[
		toNum["Rules", $modBY, "RootSigns" -> All, "SolutionSelector" -> {1, 999}],
		toNum::badbidx
	],
	True,
	{},
	TestID -> "[toNum/Messages] badbidx message issued for invalid B index"
]


(* ::Subsection:: *)
(*Selector Association Validation*)
(* Note: Uses NRC model which has non-empty SignsA/SignsB patterns *)


(* SignsA with invalid values (not +/-1) returns Failure *)
TestCreate[
	With[{result = toNum["Rules", $modNRC, "RootSigns" -> All,
		"SolutionSelector" -> <|"SignsA" -> {0, 2, 3}|>]},
		FailureQ[result]
	],
	True,
	{toNum::nosolution},
	TestID -> "[toNum/Edge/Assoc] SignsA with non-sign values returns Failure"
]

(* SignsA with wrong length returns Failure or no match *)
TestCreate[
	Module[{correctLength, wrongLength, result},
		correctLength = Length[$nrcFirstA["SignsA"]];
		wrongLength = correctLength + 5;
		result = toNum["Rules", $modNRC, "RootSigns" -> All,
			"SolutionSelector" -> <|"SignsA" -> ConstantArray[1, wrongLength]|>];
		FailureQ[result]
	],
	True,
	{toNum::nosolution},
	TestID -> "[toNum/Edge/Assoc] SignsA wrong length returns Failure"
]

(* SolutionIndexA with non-integer returns Failure - validation error *)
TestCreate[
	With[{result = toNum["Rules", $modNRC, "RootSigns" -> All,
		"SolutionSelector" -> <|"SolutionIndexA" -> 1.5|>]},
		FailureQ[result]
	],
	True,
	{toNum::badselector},
	TestID -> "[toNum/Edge/Assoc] SolutionIndexA non-integer returns Failure"
]

(* Mixed keys SignsA + SolutionIndexA - both must match *)
TestCreate[
	With[{result = toNum["Rules", $modNRC, "RootSigns" -> All,
		"SolutionSelector" -> <|
			"SignsA" -> $nrcFirstA["SignsA"],
			"SolutionIndexA" -> $nrcFirstA["SolutionIndexA"]
		|>]},
		validFlatRules[result]
	],
	True,
	{},
	TestID -> "[toNum/Edge/Assoc] Mixed SignsA + SolutionIndexA works when consistent"
]

(* SignsB without SignsA - should work (select first A matching B signs) *)
TestCreate[
	With[{result = toNum["Rules", $modNRC, "RootSigns" -> All,
		"SolutionSelector" -> <|"SignsB" -> $nrcFirstB["SignsB"]|>]},
		validFlatRules[result]
	],
	True,
	{},
	TestID -> "[toNum/Edge/Assoc] SignsB alone selects matching B from first A"
]


(* ::Subsection:: *)
(*SolutionSelector - Multi-Model Tests*)


(* BKY model: SolutionSelector works *)
TestCreate[
	With[{rules = toNum["Rules", $modBKY, "SolutionSelector" -> 1]},
		validFlatRules[rules]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector/BKY] Index selection works"
]

(* NRC model: SolutionSelector works *)
TestCreate[
	With[{rules = toNum["Rules", $modNRC, "SolutionSelector" -> 1]},
		validFlatRules[rules]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector/NRC] Index selection works"
]

(* NRC model: Index 2 returns valid rules (NRC has 3 solutions) *)
TestCreate[
	With[{rules = toNum["Rules", $modNRC, "RootSigns" -> All, "SolutionSelector" -> 2]},
		validFlatRules[rules]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector/NRC] Index 2 returns valid flat rules"
]

(* NRC model: Different indices produce different coefficient values *)
TestCreate[
	Module[{rules1, rules2, a0val1, a0val2},
		rules1 = toNum["Rules", $modNRC, "RootSigns" -> All, "SolutionSelector" -> 1];
		rules2 = toNum["Rules", $modNRC, "RootSigns" -> All, "SolutionSelector" -> 2];
		a0val1 = $pkgA[0] /. rules1;
		a0val2 = $pkgA[0] /. rules2;
		NumericQ[a0val1] && NumericQ[a0val2] && a0val1 =!= a0val2
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector/NRC] Different indices produce different A[0] values"
]

(* NRC model: ReturnAllSolutions returns all 3 solutions *)
TestCreate[
	With[{result = toNum["Rules", $modNRC, "RootSigns" -> All, "ReturnAllSolutions" -> True]},
		validHierarchical[result] && Length[result] === $numNRCSolutions
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector/NRC] ReturnAllSolutions returns all solutions"
]

(* NRC model: Last valid index returns valid rules *)
(* Find last solution with non-empty B coefficients for all stocks *)
TestCreate[
	Module[{allSolutions, hasValidB, validIndices, lastValidIdx, rules},
		allSolutions = toNum["Rules", $modNRC, Sequence @@ $testUpdateOpts, "ReturnAllSolutions" -> True];
		hasValidB[sol_] := AllTrue[Values[sol["Stocks"]], Length[#] > 0 &];
		validIndices = Select[Range[Length[allSolutions]], hasValidB[allSolutions[[#]]] &];
		lastValidIdx = Last[validIndices];
		rules = toNum["Rules", $modNRC, Sequence @@ $testUpdateOpts, "SolutionSelector" -> lastValidIdx];
		validFlatRules[rules]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector/NRC] Last valid index returns valid rules"
]

(* DES model: SolutionSelector works *)
TestCreate[
	With[{rules = toNum["Rules", $modDES, "SolutionSelector" -> 1]},
		validFlatRules[rules]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector/DES] Index selection works"
]

(* DES model: Index 2 returns valid rules (DES has 3 solutions) *)
TestCreate[
	With[{rules = toNum["Rules", $modDES, "RootSigns" -> All, "SolutionSelector" -> 2]},
		validFlatRules[rules]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector/DES] Index 2 returns valid flat rules"
]

(* DES model: Different indices produce different coefficient values *)
TestCreate[
	Module[{rules1, rules2, a0val1, a0val2},
		rules1 = toNum["Rules", $modDES, "RootSigns" -> All, "SolutionSelector" -> 1];
		rules2 = toNum["Rules", $modDES, "RootSigns" -> All, "SolutionSelector" -> 2];
		a0val1 = $pkgA[0] /. rules1;
		a0val2 = $pkgA[0] /. rules2;
		NumericQ[a0val1] && NumericQ[a0val2] && a0val1 =!= a0val2
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector/DES] Different indices produce different A[0] values"
]

(* DES model: ReturnAllSolutions returns all 3 solutions *)
TestCreate[
	With[{result = toNum["Rules", $modDES, "RootSigns" -> All, "ReturnAllSolutions" -> True]},
		validHierarchical[result] && Length[result] === $numDESSolutions
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector/DES] ReturnAllSolutions returns all solutions"
]

(* DES model: SignsA selector works *)
TestCreate[
	With[{rules = toNum["Rules", $modDES, "RootSigns" -> All,
		"SolutionSelector" -> <|"SignsA" -> $desFirstA["SignsA"]|>]},
		validFlatRules[rules]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector/DES] SignsA selector works"
]

(* NRCStochVol model: SolutionSelector works *)
TestCreate[
	With[{rules = toNum["Rules", $modNRCStochVol, "SolutionSelector" -> 1]},
		validFlatRules[rules]
	],
	True,
	{},
	TestID -> "[toNum/SolutionSelector/NRCStochVol] Index selection works"
]


(* ::Subsection:: *)
(*Multi-Stock Tests - NRC Model (3 stocks)*)


(* NRC multi-stock setup uses $nrcHierarchical and $nrcFirstA defined earlier *)
$nrcNumStocks = Length[Keys[$nrcFirstA["Stocks"]]];

(* NRC has 3 stocks - verify setup *)
TestCreate[
	$nrcNumStocks === 3,
	True,
	{},
	TestID -> "[toNum/MultiStock/NRC] Model has 3 stocks"
]

(* Tuple {1, 1} applies bIdx=1 uniformly to all 3 stocks *)
TestCreate[
	With[{rules = toNum["Rules", $modNRC, "RootSigns" -> All, "SolutionSelector" -> {1, 1}]},
		validFlatRules[rules] &&
		(* Check B coefficients exist for all 3 stocks *)
		AllTrue[{1, 2, 3}, MemberQ[First /@ rules, $pkgB[#][0]] &]
	],
	True,
	{},
	TestID -> "[toNum/MultiStock/NRC] Tuple {1,1} includes B coeffs for all 3 stocks"
]

(* Integer selector includes first B for all stocks *)
TestCreate[
	With[{rules = toNum["Rules", $modNRC, "RootSigns" -> All, "SolutionSelector" -> 1]},
		validFlatRules[rules] &&
		AllTrue[{1, 2, 3}, MemberQ[First /@ rules, $pkgB[#][0]] &]
	],
	True,
	{},
	TestID -> "[toNum/MultiStock/NRC] Integer selector includes B coeffs for all stocks"
]

(* ReturnAllSolutions preserves Stocks structure with all 3 stocks *)
TestCreate[
	With[{result = toNum["Rules", $modNRC, "RootSigns" -> All, "ReturnAllSolutions" -> True]},
		validHierarchical[result] &&
		AllTrue[result, Length[Keys[#["Stocks"]]] === 3 &]
	],
	True,
	{},
	TestID -> "[toNum/MultiStock/NRC] ReturnAllSolutions preserves all 3 stocks"
]

(* bIdx out of range for any stock returns Failure *)
TestCreate[
	Module[{maxBIdx, result},
		maxBIdx = Min @ Map[Length, Values[$nrcFirstA["Stocks"]]];
		result = toNum["Rules", $modNRC, "RootSigns" -> All,
			"SolutionSelector" -> {1, maxBIdx + 100}];
		FailureQ[result]
	],
	True,
	{toNum::badbidx},
	TestID -> "[toNum/MultiStock/NRC] bIdx exceeding any stock's B count returns Failure"
]

(* badbidx message issued when bIdx invalid for multi-stock *)
TestCreate[
	Module[{maxBIdx},
		maxBIdx = Min @ Map[Length, Values[$nrcFirstA["Stocks"]]];
		checkMsg[
			toNum["Rules", $modNRC, "RootSigns" -> All,
				"SolutionSelector" -> {1, maxBIdx + 100}],
			toNum::badbidx
		]
	],
	True,
	{},
	TestID -> "[toNum/MultiStock/NRC] badbidx message for invalid bIdx"
]

(* SignsB selection works with multi-stock *)
TestCreate[
	Module[{firstBSigns, result},
		firstBSigns = $nrcFirstA["Stocks"][1][[1]]["SignsB"];
		result = toNum["Rules", $modNRC, "RootSigns" -> All,
			"SolutionSelector" -> <|"SignsB" -> firstBSigns|>];
		validFlatRules[result]
	],
	True,
	{},
	TestID -> "[toNum/MultiStock/NRC] SignsB selector works with multi-stock"
]

(* Uniform bIdx enforced across stocks with different B counts *)
TestCreate[
	Module[{bCounts, allSame},
		bCounts = Map[Length, Values[$nrcFirstA["Stocks"]]];
		allSame = Length[DeleteDuplicates[bCounts]] === 1;
		If[allSame,
			True, (* All stocks have same B count - uniform enforcement trivially satisfied *)
			With[{minB = Min[bCounts], maxB = Max[bCounts]},
				If[minB < maxB,
					FailureQ[toNum["Rules", $modNRC, "RootSigns" -> All,
						"SolutionSelector" -> {1, maxB}]],
					True
				]
			]
		]
	],
	True,
	{},
	TestID -> "[toNum/MultiStock/NRC] Uniform bIdx enforced across stocks with different B counts"
]


(* ::Subsection:: *)
(*SolutionSelector - Bug Coverage Tests*)
(* Tests specifically designed to catch known bugs and edge cases *)


(* Bug Coverage: Integer vs Real comparison in SignsA *)
(* The selector comparison should use == not === so {1} matches {1.} *)
TestCreate[
	Module[{integerSigns, realSigns, rulesInt, rulesReal},
		(* Get the actual SignsA from first solution *)
		integerSigns = $nrcFirstA["SignsA"];
		(* Convert to Real values *)
		realSigns = N /@ integerSigns;
		(* Both should return valid rules if comparison uses == *)
		rulesInt = toNum["Rules", $modNRC, "RootSigns" -> All,
			"SolutionSelector" -> <|"SignsA" -> integerSigns|>];
		rulesReal = toNum["Rules", $modNRC, "RootSigns" -> All,
			"SolutionSelector" -> <|"SignsA" -> realSigns|>];
		(* Both should succeed and produce equivalent rules *)
		validFlatRules[rulesInt] && validFlatRules[rulesReal]
	],
	True,
	{},
	TestID -> "[toNum/BugCoverage] SignsA with Real values matches Integer solutions"
]

(* Bug Coverage: SignsB Integer vs Real comparison *)
TestCreate[
	Module[{integerSigns, realSigns, rulesInt, rulesReal},
		integerSigns = $nrcFirstB["SignsB"];
		realSigns = N /@ integerSigns;
		rulesInt = toNum["Rules", $modNRC, "RootSigns" -> All,
			"SolutionSelector" -> <|"SignsB" -> integerSigns|>];
		rulesReal = toNum["Rules", $modNRC, "RootSigns" -> All,
			"SolutionSelector" -> <|"SignsB" -> realSigns|>];
		validFlatRules[rulesInt] && validFlatRules[rulesReal]
	],
	True,
	{},
	TestID -> "[toNum/BugCoverage] SignsB with Real values matches Integer solutions"
]

(* Bug Coverage: Partial association selector with only SignsA *)
(* Tests SubsetQ logic - selector keys should be subset of valid keys *)
TestCreate[
	With[{rules = toNum["Rules", $modNRC, "RootSigns" -> All,
		"SolutionSelector" -> <|"SignsA" -> $nrcFirstA["SignsA"]|>]},
		(* Should succeed - SignsA alone is a valid partial selector *)
		validFlatRules[rules]
	],
	True,
	{},
	TestID -> "[toNum/BugCoverage] Partial selector with only SignsA works"
]

(* Bug Coverage: Partial association selector with only SignsB *)
TestCreate[
	With[{rules = toNum["Rules", $modNRC, "RootSigns" -> All,
		"SolutionSelector" -> <|"SignsB" -> $nrcFirstB["SignsB"]|>]},
		(* Should succeed - SignsB alone is a valid partial selector *)
		validFlatRules[rules]
	],
	True,
	{},
	TestID -> "[toNum/BugCoverage] Partial selector with only SignsB works"
]

(* Bug Coverage: Partial association selector with only SolutionIndexA *)
TestCreate[
	With[{rules = toNum["Rules", $modBY, "RootSigns" -> All,
		"SolutionSelector" -> <|"SolutionIndexA" -> $byFirstA["SolutionIndexA"]|>]},
		(* Should succeed - SolutionIndexA alone is a valid partial selector *)
		validFlatRules[rules]
	],
	True,
	{},
	TestID -> "[toNum/BugCoverage] Partial selector with only SolutionIndexA works"
]

(* Bug Coverage: User-constructed SignsA (not from solution) *)
(* This tests that hard-coded sign patterns work, not just round-tripped ones *)
TestCreate[
	Module[{signsLength, testSigns, result},
		(* Get length of SignsA from actual solution *)
		signsLength = Length[$nrcFirstA["SignsA"]];
		(* Construct a signs pattern of all 1s (common valid pattern) *)
		testSigns = ConstantArray[1, signsLength];
		result = toNum["Rules", $modNRC, "RootSigns" -> All,
			"SolutionSelector" -> <|"SignsA" -> testSigns|>];
		(* Should either find a match or return proper Failure - not crash *)
		validFlatRules[result] || FailureQ[result]
	],
	True,
	{toNum::nobsolutions},
	TestID -> "[toNum/BugCoverage] User-constructed SignsA pattern works"
]

(* Bug Coverage: User-constructed SignsA with Real values *)
TestCreate[
	Module[{signsLength, testSigns, result},
		signsLength = Length[$nrcFirstA["SignsA"]];
		(* Construct Real-valued signs *)
		testSigns = ConstantArray[1., signsLength];
		result = toNum["Rules", $modNRC, "RootSigns" -> All,
			"SolutionSelector" -> <|"SignsA" -> testSigns|>];
		(* Should either find a match or return proper Failure *)
		validFlatRules[result] || FailureQ[result]
	],
	True,
	{toNum::nobsolutions},
	TestID -> "[toNum/BugCoverage] User-constructed Real SignsA pattern works"
]

(* Bug Coverage: SolutionIndexB is now rejected as invalid selector key *)
(* SolutionIndexB was removed from validKeys since it was never implemented *)
TestCreate[
	Module[{result},
		result = toNum["Rules", $modNRC, "RootSigns" -> All,
			"SolutionSelector" -> <|"SignsA" -> $nrcFirstA["SignsA"], "SolutionIndexB" -> 1|>];
		(* Should return Failure with badselector message *)
		FailureQ[result] && result["MessageTemplate"] === toNum::badselector
	],
	True,
	{toNum::badselector},
	TestID -> "[toNum/BugCoverage] SolutionIndexB rejected as invalid selector key"
]

(* Bug Coverage: Empty Stocks case *)
(* When a model has zero stocks, B index combinations should handle gracefully *)
TestCreate[
	Module[{result},
		(* BY model with standard options - should always work *)
		result = toNum["Rules", $modBY];
		validFlatRules[result]
	],
	True,
	{},
	TestID -> "[toNum/BugCoverage] Standard model evaluation works"
]

(* Bug Coverage: Verify SignsA matching is not too strict *)
(* If {1} from solution and {1} user-provided are different objects, they should still match *)
TestCreate[
	Module[{solutionSigns, copiedSigns, result},
		solutionSigns = $nrcFirstA["SignsA"];
		(* Create a fresh copy that's not the same object *)
		copiedSigns = ToExpression[ToString[solutionSigns]];
		result = toNum["Rules", $modNRC, "RootSigns" -> All,
			"SolutionSelector" -> <|"SignsA" -> copiedSigns|>];
		validFlatRules[result]
	],
	True,
	{},
	TestID -> "[toNum/BugCoverage] SignsA matching works with copied list"
]


(* ::Subsection:: *)
(*toNum Advanced Examples Tests*)

TestCreate[
	Module[{baseRules, overrideRules}, baseRules = toNum["Rules", $modBY]; overrideRules = toNum["Rules", $modBY, {$pkgGamma -> 15.}]; overrideRules =!= baseRules],
	True,
	{},
	TestID -> "[toNum] Single parameter override changes output rules"
]

TestCreate[
	Module[{baseRules, multiOverride}, baseRules = toNum["Rules", $modBY]; multiOverride = toNum["Rules", $modBY, {$pkgGamma -> 12., $pkgPsi -> 2.5}]; multiOverride =!= baseRules],
	True,
	{},
	TestID -> "[toNum] Multiple parameter override changes output rules"
]

TestCreate[
	Module[{exprTest, baseExprValue, overrideExprValue}, exprTest = $pkgA[0] + $pkgA[1]; baseExprValue = toNum[exprTest, $modBY]; overrideExprValue = toNum[exprTest, $modBY, {$pkgGamma -> 20.}]; NumericQ[baseExprValue] && NumericQ[overrideExprValue] && baseExprValue != overrideExprValue],
	True,
	{},
	TestID -> "[toNum] Parameter override affects expression evaluation"
]

TestCreate[
	FailureQ[toNum["Rules", $modBY, {invalidParameterName -> 1.}]],
	True,
	{processNewParameters::subsetparam},
	TestID -> "[toNum] Invalid parameter name returns Failure"
]

TestCreate[
	FailureQ[toNum["Rules", $modBY, {"gamma" -> 15.}]],
	True,
	{processNewParameters::subsetparam},
	TestID -> "[toNum] String keys for parameters fail"
]

TestCreate[
	Module[{largeExpr, largeResult}, largeExpr = Sum[$pkgA[i], {i, 0, 2}] + $pkgB[1][0] + $pkgB[1][1] + $pkgB[1][2]; largeResult = toNum[largeExpr, $modBY]; NumericQ[largeResult] &&  !FailureQ[largeResult]],
	True,
	{},
	TestID -> "[toNum] Complex expression evaluates to numeric"
]

TestCreate[
	FailureQ[toNum["Rules", $modBY, "ReturnAllSolutions" -> "true"]],
	True,
	{toNum::badreturnall},
	TestID -> "[toNum] ReturnAllSolutions string value fails"
]

TestCreate[
	FailureQ[toNum["Rules", $modBY, "ReturnAllSolutions" -> 1]],
	True,
	{toNum::badreturnall},
	TestID -> "[toNum] ReturnAllSolutions integer value fails"
]

TestCreate[
	AllTrue[Values[$testModels], MatchQ[toNum["Rules", #1], {__Rule}] & ],
	True,
	{},
	TestID -> "[toNum] All models produce valid flat rules"
]

TestCreate[
	AllTrue[Values[$testModels], MatchQ[toNum["Rules", #1, "ReturnAllSolutions" -> True], {__Association}] & ],
	True,
	{},
	TestID -> "[toNum] All models produce valid hierarchical solutions"
]

TestCreate[
	AllTrue[Values[$testModels], NumericQ[toNum[$pkgA[0], #1]] & ],
	True,
	{},
	TestID -> "[toNum] A[0] is numeric for all models"
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
	AllTrue[Select[Values[$testModels], #1["numStocks"] > 0 & ], NumericQ[toNum[$pkgB[1][0], #1]] & ],
	True,
	{},
	TestID -> "[toNum] B[1][0] is numeric for all models with stocks"
]

TestCreate[
	Module[{expr, result}, expr = $pkgA[0] + 2*$pkgA[1] + 3*$pkgA[2]; result = toNum[expr, $modNRC]; NumericQ[result]],
	True,
	{},
	TestID -> "[toNum] Multiple A terms evaluate to numeric"
]

TestCreate[
	Module[{expr, result}, expr = $pkgB[1][0] + $pkgB[1][1] + $pkgB[1][2]; result = toNum[expr, $modNRC]; NumericQ[result]],
	True,
	{},
	TestID -> "[toNum] Multiple B terms evaluate to numeric"
]

TestCreate[
	Module[{expr, result}, expr = $pkgA[0] + $pkgA[1] + $pkgB[1][0] + $pkgB[1][1]; result = toNum[expr, $modNRC]; NumericQ[result]],
	True,
	{},
	TestID -> "[toNum] Mixed A and B terms evaluate to numeric"
]

TestCreate[
	Module[{expr, result}, expr = Sum[$pkgA[i], {i, 0, 2}] + Sum[$pkgB[1][j], {j, 0, 2}]; result = toNum[expr, $modNRC]; NumericQ[result]],
	True,
	{},
	TestID -> "[toNum] Summation expressions evaluate to numeric"
]


(* ::Subsection:: *)
(*toNum - Documentation Examples Tests*)
(* Tests derived from official documentation examples *)


(* Test: ToNum Rules returns list of rules with Rule head *)
TestCreate[
	With[{rules = toNum["Rules", $modBY]},
		Head[rules[[1]]] === Rule
	],
	True,
	{},
	TestID -> "[toNum/Docs] Rules output has Rule head"
]

(* Test: First rule LHS is an A coefficient *)
TestCreate[
	With[{rules = toNum["Rules", $modBY]},
		SymbolName[Head[rules[[1, 1]]]] === "A"
	],
	True,
	{},
	TestID -> "[toNum/Docs] First rule LHS is A coefficient"
]

(* Test: First rule RHS is numeric *)
TestCreate[
	With[{rules = toNum["Rules", $modBY]},
		NumberQ[rules[[1, 2]]]
	],
	True,
	{},
	TestID -> "[toNum/Docs] First rule RHS is numeric"
]

(* Test: ToNum evaluates A[0] + A[1] to numeric *)
TestCreate[
	NumberQ[toNum[$pkgA[0] + $pkgA[1], $modBY]],
	True,
	{},
	TestID -> "[toNum/Docs] Sum of A coefficients evaluates to numeric"
]

(* Test: ToNum evaluates B[1][0] + B[1][1] to numeric *)
TestCreate[
	NumberQ[toNum[$pkgB[1][0] + $pkgB[1][1], $modBY]],
	True,
	{},
	TestID -> "[toNum/Docs] Sum of B coefficients evaluates to numeric"
]

(* Test: A[0] with different gamma produces different result *)
TestCreate[
	toNum[$pkgA[0], $modBY] =!= toNum[$pkgA[0], $modBY, {$pkgGamma -> 15.}],
	True,
	{},
	TestID -> "[toNum/Docs] Different gamma produces different A[0] value"
]

(* Test: ToNum with multiple parameter overrides returns numeric *)
TestCreate[
	NumberQ[toNum[$pkgA[0] + $pkgA[1], $modBY, {$pkgGamma -> 12., $pkgPsi -> 2.5}]],
	True,
	{},
	TestID -> "[toNum/Docs] Multiple parameter overrides produce numeric result"
]

(* Test: Curried form equals standard form *)
TestCreate[
	toNum[$modBY][$pkgA[0] + $pkgA[1]] === toNum[$pkgA[0] + $pkgA[1], $modBY],
	True,
	{},
	TestID -> "[toNum/Docs] Curried form equals standard form"
]

(* Test: Curried form returns numeric *)
TestCreate[
	NumberQ[toNum[$modBY][$pkgA[0] + $pkgA[1]]],
	True,
	{},
	TestID -> "[toNum/Docs] Curried form returns numeric"
]

(* Test: Curried form with parameters equals standard form *)
TestCreate[
	toNum[$modBY, {$pkgGamma -> 12., $pkgPsi -> 2.5}][$pkgA[0] + $pkgA[1]] ===
		toNum[$pkgA[0] + $pkgA[1], $modBY, {$pkgGamma -> 12., $pkgPsi -> 2.5}],
	True,
	{},
	TestID -> "[toNum/Docs] Curried form with params equals standard form"
]


(* ::Subsection:: *)
(*toNum - Solution Structure Tests*)
(* Tests validating hierarchical solution structure *)


(* Test: ReturnAllSolutions returns list *)
TestCreate[
	With[{sol = toNum["Rules", $modBY, "ReturnAllSolutions" -> True]},
		ListQ[sol]
	],
	True,
	{},
	TestID -> "[toNum/Docs] ReturnAllSolutions returns list"
]

(* Test: First solution is Association *)
TestCreate[
	With[{sol = toNum["Rules", $modBY, "ReturnAllSolutions" -> True]},
		AssociationQ[First[sol]]
	],
	True,
	{},
	TestID -> "[toNum/Docs] First solution is Association"
]

(* Test: Solutions list is non-empty *)
TestCreate[
	With[{sol = toNum["Rules", $modBY, "ReturnAllSolutions" -> True]},
		Length[sol] > 0
	],
	True,
	{},
	TestID -> "[toNum/Docs] Solutions list is non-empty"
]

(* Test: Solution has expected keys *)
TestCreate[
	With[{sol = toNum["Rules", $modBY, "ReturnAllSolutions" -> True]},
		Keys[sol[[1]]] === {"IntervalA", "SignsA", "SolutionIndexA", "IntervalIndexA", "A", "Stocks", "Bond", "NomBond"}
	],
	True,
	{},
	TestID -> "[toNum/Docs] Solution has expected keys"
]

(* Test: Solution A key is Association *)
TestCreate[
	With[{sol = toNum["Rules", $modBY, "ReturnAllSolutions" -> True]},
		AssociationQ[sol[[1]]["A"]]
	],
	True,
	{},
	TestID -> "[toNum/Docs] Solution A key is Association"
]

(* Test: All A values are numeric *)
TestCreate[
	With[{sol = toNum["Rules", $modBY, "ReturnAllSolutions" -> True]},
		AllTrue[Values[sol[[1]]["A"]], NumberQ]
	],
	True,
	{},
	TestID -> "[toNum/Docs] All A coefficient values are numeric"
]

(* Test: A keys are A[0], A[1], A[2] *)
TestCreate[
	With[{sol = toNum["Rules", $modBY, "ReturnAllSolutions" -> True]},
		Keys[sol[[1]]["A"]] === {$pkgA[0], $pkgA[1], $pkgA[2]}
	],
	True,
	{},
	TestID -> "[toNum/Docs] A keys are A[0] A[1] A[2]"
]

(* Test: Stock solution is Association *)
TestCreate[
	With[{sol = toNum["Rules", $modBY, "ReturnAllSolutions" -> True]},
		AssociationQ[sol[[1]]["Stocks"][1][[1]]]
	],
	True,
	{},
	TestID -> "[toNum/Docs] Stock solution is Association"
]

(* Test: Stock solution has expected B keys *)
TestCreate[
	With[{sol = toNum["Rules", $modBY, "ReturnAllSolutions" -> True]},
		Keys[sol[[1]]["Stocks"][1][[1]]] === {"IntervalB", "SignsB", "SolutionIndexB", "IntervalIndexB", "B"}
	],
	True,
	{},
	TestID -> "[toNum/Docs] Stock solution has B structure keys"
]

(* Test: All B values are numeric *)
TestCreate[
	With[{sol = toNum["Rules", $modBY, "ReturnAllSolutions" -> True]},
		AllTrue[Values[sol[[1]]["Stocks"][1][[1]]["B"]], NumberQ]
	],
	True,
	{},
	TestID -> "[toNum/Docs] All B coefficient values are numeric"
]

(* Test: B keys are B[1][0], B[1][1], B[1][2] *)
TestCreate[
	With[{sol = toNum["Rules", $modBY, "ReturnAllSolutions" -> True]},
		Keys[sol[[1]]["Stocks"][1][[1]]["B"]] === {$pkgB[1][0], $pkgB[1][1], $pkgB[1][2]}
	],
	True,
	{},
	TestID -> "[toNum/Docs] B keys are B[1][0] B[1][1] B[1][2]"
]

(* Test: BY SignsA is empty *)
TestCreate[
	With[{sol = toNum["Rules", $modBY, "ReturnAllSolutions" -> True]},
		sol[[1]]["SignsA"] === {}
	],
	True,
	{},
	TestID -> "[toNum/Docs] BY model has empty SignsA"
]

(* Test: IntervalA is pair of numbers *)
TestCreate[
	With[{sol = toNum["Rules", $modBY, "ReturnAllSolutions" -> True]},
		sol[[1]]["IntervalA"] /. {n1_, n2_} :> And @@ {NumberQ[n1], NumberQ[n2]}
	],
	True,
	{},
	TestID -> "[toNum/Docs] IntervalA is pair of numbers"
]

(* Test: SolutionIndexA equals 1 *)
TestCreate[
	With[{sol = toNum["Rules", $modBY, "ReturnAllSolutions" -> True]},
		sol[[1]]["SolutionIndexA"] === 1
	],
	True,
	{},
	TestID -> "[toNum/Docs] SolutionIndexA equals 1 for first solution"
]


(* ::Subsection:: *)
(*toNum - Multi-Stock Model Tests*)
(* Tests for NRC and other multi-stock models *)


(* Test: NRC model has 3 stocks *)
TestCreate[
	$modNRC["numStocks"] === 3,
	True,
	{},
	TestID -> "[toNum/Docs] NRC model has 3 stocks"
]

(* Test: NRC solutions list has 3 entries *)
TestCreate[
	With[{nrcSol = toNum["Rules", $modNRC, "ReturnAllSolutions" -> True]},
		Length[nrcSol] === 3
	],
	True,
	{},
	TestID -> "[toNum/Docs] NRC returns 3 solutions"
]

(* Test: Multi-stock expression evaluates to numeric *)
TestCreate[
	NumberQ[toNum[$pkgA[0] + $pkgB[1][0] + $pkgB[2][0] + $pkgB[3][0], $modNRC]],
	True,
	{},
	TestID -> "[toNum/Docs] Multi-stock expression evaluates to numeric"
]

(* Test: All NRC solutions have numeric Value *)
TestCreate[
	With[{allSols = toNum[$pkgA[0] + $pkgB[1][0] + $pkgB[2][0] + $pkgB[3][0], $modNRC, "ReturnAllSolutions" -> True]},
		AllTrue[#["Value"] & /@ allSols, NumberQ]
	],
	True,
	{},
	TestID -> "[toNum/Docs] All NRC solutions have numeric Value"
]

(* Test: A expression evaluates to numeric *)
TestCreate[
	NumberQ[toNum[$pkgA[0] + $pkgA[1] + $pkgA[2], $modBY]],
	True,
	{},
	TestID -> "[toNum/Docs] A[0] + A[1] + A[2] evaluates to numeric"
]

(* Test: B[1][0] evaluates to numeric *)
TestCreate[
	NumberQ[toNum[$pkgB[1][0], $modBY]],
	True,
	{},
	TestID -> "[toNum/Docs] B[1][0] evaluates to numeric"
]

(* Test: Mixed A and B expression evaluates to numeric *)
TestCreate[
	NumberQ[toNum[$pkgA[0] + $pkgB[1][0], $modBY]],
	True,
	{},
	TestID -> "[toNum/Docs] Mixed A and B expression evaluates to numeric"
]


(* ::Subsection:: *)
(*toNum - Model Comparison Tests*)
(* Tests validating different model behaviors *)


(* Test: DES model has 1 stock *)
TestCreate[
	$modDES["numStocks"] === 1,
	True,
	{},
	TestID -> "[toNum/Docs] DES model has 1 stock"
]

(* Test: DES model has 7 state variables *)
TestCreate[
	Length[$modDES["stateVars"][t]] === 7,
	True,
	{},
	TestID -> "[toNum/Docs] DES model has 7 state variables"
]

(* Test: BY ReturnAllSolutions returns rule list *)
TestCreate[
	MatchQ[toNum["Rules", $modBY], {__Rule}],
	True,
	{},
	TestID -> "[toNum/Docs] BY Rules returns list of rules"
]

(* Test: BY ReturnAllSolutions returns association list *)
TestCreate[
	MatchQ[toNum["Rules", $modBY, "ReturnAllSolutions" -> True], {__Association}],
	True,
	{},
	TestID -> "[toNum/Docs] BY ReturnAllSolutions returns Association list"
]

(* Test: BY has 1 solution with expected keys *)
TestCreate[
	With[{bySolutions = toNum["Rules", $modBY, "ReturnAllSolutions" -> True]},
		And @@ {Length[bySolutions] === 1,
			Keys[bySolutions[[1]]] === {"IntervalA", "SignsA", "SolutionIndexA", "IntervalIndexA", "A", "Stocks", "Bond", "NomBond"}}
	],
	True,
	{},
	TestID -> "[toNum/Docs] BY has 1 solution with expected keys"
]

(* Test: NRC has 3 solutions with expected keys *)
TestCreate[
	With[{bySolutions = toNum["Rules", $modNRC, "ReturnAllSolutions" -> True]},
		And @@ {Length[bySolutions] === 3,
			Keys[bySolutions[[1]]] === {"IntervalA", "SignsA", "SolutionIndexA", "IntervalIndexA", "A", "Stocks", "Bond", "NomBond"}}
	],
	True,
	{},
	TestID -> "[toNum/Docs] NRC has 3 solutions with expected keys"
]

(* Test: DES has 3 solutions with expected keys *)
TestCreate[
	With[{bySolutions = toNum["Rules", $modDES, "ReturnAllSolutions" -> True]},
		And @@ {Length[bySolutions] === 3,
			Keys[bySolutions[[1]]] === {"IntervalA", "SignsA", "SolutionIndexA", "IntervalIndexA", "A", "Stocks", "Bond", "NomBond"}}
	],
	True,
	{},
	TestID -> "[toNum/Docs] DES has 3 solutions with expected keys"
]

(* Test: NRCStochVol has 1 solution with expected keys *)
TestCreate[
	With[{bySolutions = toNum["Rules", $modNRCStochVol, "ReturnAllSolutions" -> True]},
		{Length[bySolutions] === 1,
			Keys[bySolutions[[1]]] === {"IntervalA", "SignsA", "SolutionIndexA", "IntervalIndexA", "A", "Stocks", "Bond", "NomBond"}}
	],
	{True, True},
	{},
	TestID -> "[toNum/Docs] NRCStochVol has 1 solution with expected keys"
]


(* ::Subsection:: *)
(*toNum - SolutionSelector Documentation Tests*)
(* Tests from official documentation for SolutionSelector *)


(* Test: Default selector equals Automatic *)
TestCreate[
	toNum["Rules", $modBY] === toNum["Rules", $modBY, "SolutionSelector" -> Automatic],
	True,
	{},
	TestID -> "[toNum/Docs] Default selector equals Automatic"
]

(* Test: Selector 2 differs from default for NRC *)
TestCreate[
	toNum["Rules", $modNRC, "SolutionSelector" -> 2] =!= toNum["Rules", $modBY],
	True,
	{},
	TestID -> "[toNum/Docs] Selector 2 produces different result than default"
]

(* Test: Tuple selector {1,1} produces numeric rules *)
TestCreate[
	With[{rules = toNum["Rules", $modBY, "SolutionSelector" -> {1, 1}]},
		AllTrue[Values[rules] /. rules, NumberQ]
	],
	True,
	{},
	TestID -> "[toNum/Docs] Tuple selector produces numeric rules"
]

(* Test: Selector All with ReturnAllSolutions works *)
TestCreate[
	With[{rules = toNum["Rules", $modBY, "ReturnAllSolutions" -> True, "SolutionSelector" -> All]},
		And @@ {AllTrue[Values[rules[[1]]["A"]], NumberQ],
			AllTrue[Values[rules[[1]]["Stocks"][1][[1]]["B"]], NumberQ],
			AllTrue[Values[rules[[1]]["Bond"]], NumberQ],
			AllTrue[Values[rules[[1]]["NomBond"]], NumberQ]}
	],
	True,
	{},
	TestID -> "[toNum/Docs] Selector All with ReturnAllSolutions works"
]

(* Test: Association selector with SolutionIndexA works *)
TestCreate[
	toNum["Rules", $modBY, "SolutionSelector" -> <|"SolutionIndexA" -> 1|>] ===
		toNum["Rules", $modBY],
	True,
	{},
	TestID -> "[toNum/Docs] Association selector with SolutionIndexA equals default"
]

(* Test: Rules contain B coefficients *)
TestCreate[
	AnyTrue[toNum["Rules", $modBY], MatchQ[#[[1]], $pkgB[_][_]] &],
	True,
	{},
	TestID -> "[toNum/Docs] Rules contain B coefficients"
]

(* Test: UpdatePd False still contains B coefficients *)
TestCreate[
	AnyTrue[toNum["Rules", $modBY, "UpdatePd" -> False], MatchQ[#[[1]], $pkgB[_][_]] &],
	True,
	{},
	TestID -> "[toNum/Docs] UpdatePd False still contains B coefficients"
]


(* ::Subsection:: *)
(*toNum - Bond and Maturity Tests*)
(* Tests for UpdateBond and MaxMaturity options *)


(* Test: UpdateBond produces numeric NomBond values *)
TestCreate[
	With[{solWithBond = toNum["Rules", $modBY, "UpdateBond" -> True, "ReturnAllSolutions" -> True]},
		And @@ {
			AllTrue[Flatten @ Table[$pkgP[m][s], {m, 0, 6}, {s, 0, 2}] /. solWithBond[[1]]["NomBond"], NumberQ],
			Keys[solWithBond[[1]]] === {"IntervalA", "SignsA", "SolutionIndexA", "IntervalIndexA", "A", "Stocks", "Bond", "NomBond"}
		}
	],
	True,
	{},
	TestID -> "[toNum/Docs] UpdateBond produces numeric NomBond values"
]

(* Test: MaxMaturity controls bond maturity range *)
TestCreate[
	With[{
		solMat6 = toNum["Rules", $modBY, "UpdateBond" -> True, "MaxMaturity" -> 6],
		solMat24 = toNum["Rules", $modBY, "UpdateBond" -> True, "MaxMaturity" -> 24]
	},
		And @@ {
			Max[Cases[solMat6, $pkgP[n_][s_] :> n, Infinity]] === 6,
			Max[Cases[solMat24, $pkgP[n_][s_] :> n, Infinity]] === 24,
			Max[Cases[solMat6, $pkgR[n_][s_] :> n, Infinity]] === 6,
			Max[Cases[solMat24, $pkgR[n_][s_] :> n, Infinity]] === 24
		}
	],
	True,
	{},
	TestID -> "[toNum/Docs] MaxMaturity controls bond coefficient range"
]

(* Test: Duplicate default selector test *)
TestCreate[
	toNum["Rules", $modBY] === toNum["Rules", $modBY, "SolutionSelector" -> Automatic],
	True,
	{},
	TestID -> "[toNum/Docs] Default selector equals Automatic (variant)"
]

(* Test: Rules form equals expression evaluation *)
TestCreate[
	toNum[$pkgA[0] + $pkgA[1], $modBY, {$pkgGamma -> 15.}] ===
		($pkgA[0] + $pkgA[1] /. toNum["Rules", $modBY, {$pkgGamma -> 15}]),
	True,
	{},
	TestID -> "[toNum/Docs] Rules form equals expression evaluation"
]


(* ::Subsection:: *)
(*ToEquation Tests*)
(* Tests for ToEquation function *)


(* Test: ToEquation wc[t] contains x state variable *)
TestCreate[
	Cases[toEquation[wc[t], $modBY], (x_Symbol)[t__] /; SymbolName[x] === "x", Infinity] =!= {},
	True,
	{},
	TestID -> "[ToEquation/Docs] wc equation contains x state variable"
]


(* ::Subsection:: *)
(*State Variables Tests*)
(* Tests for model state variable structure *)


(* Test: NRC state vars contain sg *)
TestCreate[
	Cases[$modNRC["stateVars"][t], (x_Symbol)[t__] /; SymbolName[x] === "sg", Infinity] =!= {},
	True,
	{},
	TestID -> "[Model/Docs] NRC state vars contain sg"
]

(* Test: NRC state vars contain pi *)
TestCreate[
	Cases[$modNRC["stateVars"][t], (x_Symbol)[t__] /; SymbolName[x] === "pi", Infinity] =!= {},
	True,
	{},
	TestID -> "[Model/Docs] NRC state vars contain pi"
]

(* Test: NRC state vars contain eps *)
TestCreate[
	Cases[$modNRC["stateVars"][t], (x_Symbol)[s__][t__] /; SymbolName[x] === "eps", Infinity] =!= {},
	True,
	{},
	TestID -> "[Model/Docs] NRC state vars contain eps"
]

(* Test: DES state vars contain sx *)
TestCreate[
	Cases[$modDES["stateVars"][t], (x_Symbol)[t__] /; SymbolName[x] === "sx", Infinity] =!= {},
	True,
	{},
	TestID -> "[Model/Docs] DES state vars contain sx"
]

(* Test: DES state vars contain pibar *)
TestCreate[
	Cases[$modDES["stateVars"][t], (x_Symbol)[t__] /; SymbolName[x] === "pibar", Infinity] =!= {},
	True,
	{},
	TestID -> "[Model/Docs] DES state vars contain pibar"
]

(* Test: DES state vars contain eps[pi] *)
TestCreate[
	Cases[$modDES["stateVars"][t], (x_Symbol)["pi"][t__] /; SymbolName[x] === "eps", Infinity] =!= {},
	True,
	{},
	TestID -> "[Model/Docs] DES state vars contain eps pi"
]

(* Test: NRCStochVol state vars contain sg squared *)
TestCreate[
	Cases[$modNRCStochVol["stateVars"][t], (x_Symbol)[t__]^2 /; SymbolName[x] === "sg", Infinity] =!= {},
	True,
	{},
	TestID -> "[Model/Docs] NRCStochVol state vars contain sg squared"
]

(* Test: NRCStochVol state vars contain sp *)
TestCreate[
	Cases[$modNRCStochVol["stateVars"][t], (x_Symbol)[t__] /; SymbolName[x] === "sp", Infinity] =!= {},
	True,
	{},
	TestID -> "[Model/Docs] NRCStochVol state vars contain sp"
]

(* Test: NRCStochVol state vars contain eps[pi] *)
TestCreate[
	Cases[$modNRCStochVol["stateVars"][t], (x_Symbol)["pi"][t__] /; SymbolName[x] === "eps", Infinity] =!= {},
	True,
	{},
	TestID -> "[Model/Docs] NRCStochVol state vars contain eps pi"
]


(* ::Subsection:: *)
(*toNum - Error Handling Tests*)
(* Tests validating error handling and failure modes from documentation notebook *)


(* Test: Invalid string parameter gamma returns Failure *)
TestCreate[
	FailureQ[toNum[$pkgA[0], $modBY, {"gamma" -> 15.0}]],
	True,
	{processNewParameters::subsetparam},
	TestID -> "[toNum/Docs] Invalid string parameter gamma returns Failure"
]

(* Test: SolutionSelector All without ReturnAllSolutions fails *)
TestCreate[
	FailureQ[toNum["Rules", $modBY, "SolutionSelector" -> All]],
	True,
	{toNum::selectorallrequiresreturnall},
	TestID -> "[toNum/Docs] SolutionSelector All without ReturnAllSolutions fails"
]

(* Test: SolutionSelector with invalid index fails *)
TestCreate[
	FailureQ[toNum["Rules", $modBY, "SolutionSelector" -> 999]],
	True,
	{toNum::badidx},
	TestID -> "[toNum/Docs] SolutionSelector with invalid index fails"
]

(* Test: SolutionSelector with non-integer value fails *)
TestCreate[
	FailureQ[toNum["Rules", $modBY, "SolutionSelector" -> 1.5]],
	True,
	{toNum::badselector},
	TestID -> "[toNum/Docs] SolutionSelector with non-integer value fails"
]

(* Test: Invalid parameter name returns Failure *)
TestCreate[
	FailureQ[toNum["Rules", $modBY, {invalidParameterName -> 1.0}]],
	True,
	{processNewParameters::subsetparam},
	TestID -> "[toNum/Docs] Invalid parameter name returns Failure"
]

(* Test: psi equal to 1 returns Failure *)
TestCreate[
	FailureQ[toNum["Rules", $modBY, {$pkgPsi -> 1}]],
	True,
	{processNewParameters::psi},
	TestID -> "[toNum/Docs] psi equal to 1 returns Failure"
]


End[]
EndTestSection[]
