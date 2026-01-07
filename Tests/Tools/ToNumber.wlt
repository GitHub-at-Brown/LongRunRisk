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

(* Test: When old and new parameters are equal, does not abort *)
TestCreate[
	With[{p = $baseParams, newP = $baseParams},
		Not @ checkAbrt[processNewParameters[newP, p]]
	],
	True,
	{},
	TestID -> "[processNewParameters] Equal parameters do not abort"
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


(* Test: When new parameters are NOT a subset, aborts *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`phip -> 3}},
		checkAbrt[processNewParameters[newP, p]]
	],
	True,
	{},
	TestID -> "[processNewParameters] Non-subset parameters abort"
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


(* Test: psi=1 in new parameters aborts *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1}},
		checkAbrt[processNewParameters[newP, p]]
	],
	True,
	{},
	TestID -> "[processNewParameters] psi=1 aborts"
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

(* Test: psi=1. (numeric) also aborts *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1.}},
		checkAbrt[processNewParameters[newP, p]]
	],
	True,
	{},
	TestID -> "[processNewParameters] psi=1.0 numeric aborts"
]


(* ::Subsection:: *)
(*processNewParameters - Gamma Psi Theta Relationship Tests*)


(* Test: When all three {gamma, psi, theta} provided and theta exactly correct, does not abort *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`gamma -> 10, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> (1 - FernandoDuarte`LongRunRisk`Model`Parameters`gamma)/(1 - 1/FernandoDuarte`LongRunRisk`Model`Parameters`psi), FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1.5`}},
		Not @ checkAbrt[processNewParameters[newP, p]]
	],
	True,
	{},
	TestID -> "[processNewParameters] Exact gamma-psi-theta triple does not abort"
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


(* Test: theta provided without gamma or psi aborts *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> 1.}},
		checkAbrt[processNewParameters[newP, p]]
	],
	True,
	{},
	TestID -> "[processNewParameters] Theta alone without gamma or psi aborts"
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
stateVars = $modNRC["stateVars"];
numModel = Join[
	Thread[stateVars -> 1.],
	{
		FernandoDuarte`LongRunRisk`Model`Shocks`eps[_][_] -> 1.,
		FernandoDuarte`LongRunRisk`Model`Shocks`eps[_][_, _] -> 1.,
		mu -> 2.,
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

(* Test: Pass initial guess for coefficients *)
TestCreate[
	With[{exprNewParam = uncondE[wc[t]], guessCoeffsSolution = {A[0] -> 4.6}},
		AllTrue[{
			exprNewParam // toNum[$modNRC, {}, guessCoeffsSolution] //. numModel,
			toNum[exprNewParam, $modNRC, {}, guessCoeffsSolution] //. numModel,
			toEquation[exprNewParam, $modNRC] //. toNum["Rules", $modNRC, {}, guessCoeffsSolution] //. numModel
		}, NumericQ]
	],
	True,
	{},
	TestID -> "[toNum] Initial guess for coefficients evaluates to numbers"
]

(* Test: Pass both new parameters and initial guess *)
TestCreate[
	With[{newParameters = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.99}, exprNewParam = uncondE[wc[t]], guessCoeffsSolution = {A[0] -> 4.6}},
		AllTrue[{
			exprNewParam // toNum[$modNRC, newParameters, guessCoeffsSolution] //. numModel,
			toNum[exprNewParam, $modNRC, newParameters, guessCoeffsSolution] //. numModel,
			toEquation[exprNewParam, $modNRC] //. toNum["Rules", $modNRC, newParameters, guessCoeffsSolution] //. numModel
		}, NumericQ]
	],
	True,
	{},
	TestID -> "[toNum] Parameters with initial guess evaluate to numbers"
]

(* Test: New parameters, guess, and options combined *)
TestCreate[
	With[{
		newParameters = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.99},
		exprNewParam = uncondE[wc[t]],
		guessCoeffsSolution = {A[0] -> 4.6},
		optNewParam = {"initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>, MaxIterations -> 100}
	},
		AllTrue[{
			exprNewParam // toNum[$modNRC, newParameters, Sequence @@ optNewParam] //. numModel,
			exprNewParam // toNum[$modNRC, {}, guessCoeffsSolution, Sequence @@ optNewParam] //. numModel,
			exprNewParam // toNum[$modNRC, newParameters, guessCoeffsSolution, Sequence @@ optNewParam] //. numModel
		}, NumericQ]
	],
	True,
	{},
	TestID -> "[toNum] Parameters, guess, and options combined evaluate"
]


(* ::Subsection:: *)
(*Association Handling Tests*)


(* Test: toNum handles Associations via curried form *)
TestCreate[
	With[{tn = toNum[$modNRC]},
		(tn[<|"Key" -> wc[t]|>] // Values // AllTrue[#, NumericQ]&) //. numModel
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
(*Tests Needing Refactoring*)
(*TODO: The following test reference was copied from docs/test-files/ToNumber.wlt and needs refactoring*)
(*      to use TestCreate with semantic TestIDs and to be split into smaller, focused tests*)


(*
   Large Integration Test: Multi-Model toNum Validation
   =====================================================
   Original TestID: ToNumber_20260103-2BVV55@@Tests/ToNumber.wlt:24,1-786,2
   Original Location: docs/test-files/ToNumber.wlt lines 24-786 (762 lines)

   DESCRIPTION:
   This test iterates over multiple models (BY, BKY, NRC, DES, NRCStochVol when longTest=True)
   and validates that all the following produce numeric results:

   Functions tested:
   - toNum (curried form, expression form, "Rules" form)
   - uncondE, uncondVar, uncondCov, uncondCorr (unconditional expectations)
   - ev, var, cov, corr (conditional expectations)

   Options tested:
   - maxMaturity -> 6
   - "FindRootOptions" -> {MaxIterations -> 100}
   - MaxIterations -> 100
   - "initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>
   - "PrintResidualsNorm" -> True
   - "CheckResiduals" -> True with various "Tol" values
   - "RecurrenceTableOptions" -> {"DependentVariables" -> Automatic}
   - DependentVariables -> Automatic

   Parameter handling tested:
   - newParameters = {delta -> 0.99}
   - guessCoeffsSolution = {A[0] -> 4.6}
   - Combined parameters, guesses, and options

   Expression types tested:
   - wc[t], pd[t,i], bond[t,m], nombond[t,m], bondexcret[t,m], bondfw[t,m]
   - bondfwspread[t,m], bondret[t,m], bondyield[t,m], excretc[t], excret[t,i]
   - kappa0[mu], kappa1[mu], nombondexcret[t,m], nombondfw[t,m], nombondfwspread[t,m]
   - nombondret[t,m], nombondyield[t,m], nomrf[t], nomsdf[t], retc[t], ret[t,i]
   - rf[t], sdf[t], pi[t], dc[t]
   - growth[dc, t, "TimeAggregation" -> 2, "numPeriods" -> 1]
   - growth[dd, t, 1, "TimeAggregation" -> 2]
   - AA * dc[t+1] * excret[t, 1]
   - AA * excret[t, 1] + BB * nombondyield[t, 2]

   REFACTORING NOTES:
   - This 762-line test should be split into ~20-30 smaller focused tests
   - Each model could be tested separately
   - Each function group (uncond*, cond*) should be separate tests
   - Options should be tested individually
   - See docs/test-files/ToNumber.wlt for the complete original implementation

   To run the original test, execute:
   TestReport @ FileNameJoin[{$PackageDirectory, "docs", "test-files", "ToNumber.wlt"}]
*)


End[]
EndTestSection[]
