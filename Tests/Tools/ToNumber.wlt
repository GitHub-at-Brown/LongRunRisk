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
(* TestCreate[
	With[{p = $baseParams, newP = $baseParams},
		AllTrue[Values @ processNewParameters[newP, p], NumberQ]
	],
	True,
	{},
	TestID -> "[processNewParameters] Equal parameters produce numeric values"
] *)

(* Test: When old and new parameters are equal, keys match by name *)
(* TestCreate[
	With[{p = $baseParams, newP = $baseParams},
		Module[{procP = processNewParameters[newP, p]},
			Sort[(SymbolName @* Replace[h_[_] :> h]) /@ Keys @ procP] === Sort[(SymbolName @* Replace[h_[_] :> h]) /@ Keys @ newP]
		]
	],
	True,
	{},
	TestID -> "[processNewParameters] Equal parameters preserve key names"
] *)

(* Test: When old and new parameters are equal, keys match with context *)
(* TestCreate[
	With[{p = $baseParams, newP = $baseParams},
		Module[{procP = processNewParameters[newP, p]},
			Sort @ Keys @ procP === Sort @ Keys @ newP
		]
	],
	True,
	{},
	TestID -> "[processNewParameters] Equal parameters preserve key contexts"
] *)

(* Test: When old and new parameters are equal, processed keys are subset of old parameters *)
(* TestCreate[
	With[{p = $baseParams, newP = $baseParams},
		Module[{procP = processNewParameters[newP, p]},
			SubsetQ[Keys @ p, Keys @ procP]
		]
	],
	True,
	{},
	TestID -> "[processNewParameters] Processed keys subset of original parameters"
] *)

(* Test: When old and new parameters are equal, does not abort *)
(* TestCreate[
	With[{p = $baseParams, newP = $baseParams},
		Not @ checkAbrt[processNewParameters[newP, p]]
	],
	True,
	{},
	TestID -> "[processNewParameters] Equal parameters do not abort"
] *)


(* ::Subsection:: *)
(*processNewParameters - Subset Parameters Tests*)


(* Test: When new parameters are subset of old, values are numbers *)
(* TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1}},
		AllTrue[Values @ processNewParameters[newP, p], NumberQ]
	],
	True,
	{},
	TestID -> "[processNewParameters] Subset parameters produce numeric values"
] *)

(* Test: When new parameters are subset of old, keys match new parameters by name *)
(* TestCreate[
	With[{p = $baseParams, newP = {delta -> 0.9, Esx -> 1}},
		Module[{procP = processNewParameters[newP, p]},
			Sort[(SymbolName @* Replace[h_[_] :> h]) /@ Keys @ procP] === Sort[(SymbolName @* Replace[h_[_] :> h]) /@ Keys @ newP]
		]
	],
	True,
	{},
	TestID -> "[processNewParameters] Subset parameters match by name"
] *)

(* Test: When new parameters are subset of old, procP keys are in correct context *)
(* TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1}},
		Module[{procP = processNewParameters[newP, p]},
			AllTrue[Keys @ procP, Context[#] === "FernandoDuarte`LongRunRisk`Model`Parameters`" &]
		]
	],
	True,
	{},
	TestID -> "[processNewParameters] Subset parameters use correct context"
] *)


(* ::Subsection:: *)
(*processNewParameters - Empty Parameters Tests*)


(* Test: When new parameters is empty, returns empty list *)
(* TestCreate[
	With[{p = $baseParams},
		processNewParameters[{}, p] === {}
	],
	True,
	{},
	TestID -> "[processNewParameters] Empty input returns empty list"
] *)


(* ::Subsection:: *)
(*processNewParameters - Invalid Parameters Tests*)


(* Test: When new parameters are NOT a subset, aborts *)
(* TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`phip -> 3}},
		checkAbrt[processNewParameters[newP, p]]
	],
	True,
	{},
	TestID -> "[processNewParameters] Non-subset parameters abort"
] *)

(* Test: When new parameters are NOT a subset, issues subsetparam message *)
(* TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`phip -> 3}},
		checkMsg[processNewParameters[newP, p],
			FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::subsetparam]
	],
	True,
	{},
	TestID -> "[processNewParameters] Non-subset parameters issue subsetparam message"
] *)


(* ::Subsection:: *)
(*processNewParameters - Psi Validation Tests*)


(* Test: psi=1 in new parameters aborts *)
(* TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1}},
		checkAbrt[processNewParameters[newP, p]]
	],
	True,
	{},
	TestID -> "[processNewParameters] psi=1 aborts"
] *)

(* Test: psi=1 issues psi message *)
(* TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1}},
		checkMsg[processNewParameters[newP, p],
			FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::psi]
	],
	True,
	{},
	TestID -> "[processNewParameters] psi=1 issues psi message"
] *)

(* Test: psi=1. (numeric) also aborts *)
(* TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1.}},
		checkAbrt[processNewParameters[newP, p]]
	],
	True,
	{},
	TestID -> "[processNewParameters] psi=1.0 numeric aborts"
] *)


(* ::Subsection:: *)
(*processNewParameters - Gamma Psi Theta Relationship Tests*)


(* Test: When all three {gamma, psi, theta} provided and theta exactly correct, does not abort *)
(* TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`gamma -> 10, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> (1 - FernandoDuarte`LongRunRisk`Model`Parameters`gamma)/(1 - 1/FernandoDuarte`LongRunRisk`Model`Parameters`psi), FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1.5`}},
		Not @ checkAbrt[processNewParameters[newP, p]]
	],
	True,
	{},
	TestID -> "[processNewParameters] Exact gamma-psi-theta triple does not abort"
] *)

(* Test: When all three {gamma, psi, theta} provided and theta exactly correct, values are numbers *)
(* TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`gamma -> 10, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> (1 - FernandoDuarte`LongRunRisk`Model`Parameters`gamma)/(1 - 1/FernandoDuarte`LongRunRisk`Model`Parameters`psi), FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1.5`}},
		AllTrue[Values @ processNewParameters[newP, p], NumberQ]
	],
	True,
	{},
	TestID -> "[processNewParameters] Exact gamma-psi-theta triple produces numbers"
] *)

(* Test: When theta is NOT exactly correct, issues param message *)
(* TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`gamma -> 10, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> 3.23`, FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1.5`}},
		checkMsg[processNewParameters[newP, p],
			FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::param]
	],
	True,
	{},
	TestID -> "[processNewParameters] Inconsistent theta issues param message"
] *)

(* Test: When theta is NOT exactly correct, theta is recalculated to correct value *)
(* TestCreate[
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
] *)


(* ::Subsection:: *)
(*processNewParameters - Solve for Missing Parameter Tests*)


(* Test: Solve for gamma from {psi, theta} - values are numbers *)
(* TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 2, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> -3.`}},
		AllTrue[Values @ processNewParameters[newP, p], NumberQ]
	],
	True,
	{},
	TestID -> "[processNewParameters] Solving for gamma produces numbers"
] *)

(* Test: Solve for gamma from {psi, theta} - gamma has correct value 2.5 *)
(* TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 2, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> -3.`}},
		Module[{procP = processNewParameters[newP, p]},
			(* gamma = 1 - theta*(1-1/psi) = 1 - (-3)*(1-1/2) = 1 + 3*0.5 = 2.5 *)
			Abs[(FernandoDuarte`LongRunRisk`Model`Parameters`gamma /. procP) - 2.5] < 10^-10
		]
	],
	True,
	{},
	TestID -> "[processNewParameters] Gamma computed as 2.5 from psi and theta"
] *)

(* Test: Solve for theta from {gamma, psi} - theta has correct value -3 *)
(* TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 2, FernandoDuarte`LongRunRisk`Model`Parameters`gamma -> 2.5}},
		Module[{procP = processNewParameters[newP, p]},
			(* theta = (1-gamma)/(1-1/psi) = (1-2.5)/(1-0.5) = -1.5/0.5 = -3 *)
			Abs[(FernandoDuarte`LongRunRisk`Model`Parameters`theta /. procP) + 3] < 10^-10
		]
	],
	True,
	{},
	TestID -> "[processNewParameters] Theta computed as -3 from gamma and psi"
] *)

(* Test: Solve for psi from {gamma, theta} - psi has correct value 2 *)
(* TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`gamma -> 2.5, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> -3.`}},
		Module[{procP = processNewParameters[newP, p]},
			(* psi = 1/(1-(1-gamma)/theta) = 1/(1-(-1.5)/(-3)) = 1/(1-0.5) = 2 *)
			Abs[(FernandoDuarte`LongRunRisk`Model`Parameters`psi /. procP) - 2] < 10^-10
		]
	],
	True,
	{},
	TestID -> "[processNewParameters] Psi computed as 2 from gamma and theta"
] *)


(* ::Subsection:: *)
(*processNewParameters - Theta Alone Tests*)


(* Test: theta provided without gamma or psi aborts *)
(* TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> 1.}},
		checkAbrt[processNewParameters[newP, p]]
	],
	True,
	{},
	TestID -> "[processNewParameters] Theta alone without gamma or psi aborts"
] *)

(* Test: theta provided without gamma or psi issues theta message *)
(* TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> 1.}},
		checkMsg[processNewParameters[newP, p],
			FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::theta]
	],
	True,
	{},
	TestID -> "[processNewParameters] Theta alone issues theta message"
] *)


(* ::Subsection:: *)
(*processNewParameters - Context Preservation Tests*)


(* Test: processNewParameters preserves contexts of old parameters *)
(* TestCreate[
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
] *)

(* Test: processNewParameters preserves contexts - procP contexts match old parameters *)
(* TestCreate[
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
] *)


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
(* TestCreate[
	Head[toNum[$modNRC]] === Function,
	True,
	{},
	TestID -> "[toNum] Curried form returns Function"
] *)

(* Test: Numerical evaluation of expressions *)
(* TestCreate[
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
] *)

(* Test: toNum[expression, thisModel] form *)
(* TestCreate[
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
] *)

(* Test: toNum["Rules", thisModel] form *)
(* TestCreate[
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
] *)


(* ::Subsection:: *)
(*Options Handling Tests*)


(* Test: "UpdatePd" and "UpdateBonds" options *)
(* TestCreate[
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
] *)


(* ::Subsection:: *)
(*New Parameters and Initial Guess Tests*)


(* Test: Pass new parameters *)
(* TestCreate[
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
] *)

(* Test: Pass initial guess for coefficients *)
(* TestCreate[
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
] *)

(* Test: Pass both new parameters and initial guess *)
(* TestCreate[
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
] *)

(* Test: New parameters, guess, and options combined *)
(* TestCreate[
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
] *)


(* ::Subsection:: *)
(*Association Handling Tests*)


(* Test: toNum handles Associations via curried form *)
(* TestCreate[
	With[{tn = toNum[$modNRC]},
		(wc[t] // tn /. numModel) // AllTrue[#, NumericQ]&
	],
	True,
	{},
	TestID -> "[toNum] Association input produces numeric values"
] *)


(* ::Subsection:: *)
(*Helper Functions Tests*)


(* Test: toExogenousVars returns expression with only exogenous vars *)
(* TestCreate[
	FreeQ[toExogenousVars[wc[t], $modNRC], wc],
	True,
	{},
	TestID -> "[toExogenousVars] Removes endogenous wc from expression"
] *)

(* Test: toStateVars returns expression with only state vars *)
(* TestCreate[
	FreeQ[toStateVars[wc[t], $modNRC], wc],
	True,
	{},
	TestID -> "[toStateVars] Removes endogenous wc from expression"
] *)


(* ::Subsection:: *)
(*Edge Cases Tests*)


(* Test: Empty list input *)
(* TestCreate[
	toNum[{}, $modNRC] === {},
	True,
	{},
	TestID -> "[toNum] Empty list input returns empty list"
] *)

(* Test: Mixed types input *)
(* TestCreate[
	With[{res = toNum[{1.0, "text", wc[t]}, $modNRC] //. numModel},
		MatchQ[res, {1.0, "text", _?NumericQ}]
	],
	True,
	{},
	TestID -> "[toNum] Mixed types preserves literals and converts wc"
] *)


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
			BB -> 3.
		}
	]
];


(* ::Subsubsection:: *)
(*BY Model Tests*)


(* Test: BY model curried toNum evaluates expressions to numbers *)
(* TestCreate[
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
] *)

(* Test: BY model expression toNum form evaluates to numbers *)
(* TestCreate[
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
] *)

(* Test: BY model Rules toNum form evaluates to numbers *)
(* TestCreate[
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
] *)


(* ::Subsubsection:: *)
(*BKY Model Tests*)


(* Test: BKY model curried toNum evaluates expressions to numbers *)
(* TestCreate[
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
] *)

(* Test: BKY model expression toNum form evaluates to numbers *)
(* TestCreate[
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
] *)

(* Test: BKY model Rules toNum form evaluates to numbers *)
(* TestCreate[
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
] *)


(* ::Subsubsection:: *)
(*DES Model Tests*)


(* Test: DES model curried toNum evaluates expressions to numbers *)
(* TestCreate[
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
] *)

(* Test: DES model expression toNum form evaluates to numbers *)
(* TestCreate[
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
] *)

(* Test: DES model Rules toNum form evaluates to numbers *)
(* TestCreate[
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
] *)


(* ::Subsubsection:: *)
(*NRCStochVol Model Tests*)


(* Test: NRCStochVol model curried toNum evaluates expressions to numbers *)
(* TestCreate[
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
] *)

(* Test: NRCStochVol model expression toNum form evaluates to numbers *)
(* TestCreate[
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
] *)

(* Test: NRCStochVol model Rules toNum form evaluates to numbers *)
(* TestCreate[
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
] *)


(* ::Subsection:: *)
(*Unconditional Covariance and Correlation Tests*)


(* Test: uncondCov evaluates to numbers across models *)
(* TestCreate[
	Module[{testExprs, numMod, res},
		testExprs = {wc[t], pd[t, 1]};
		numMod = getNumModel[$modNRC];
		res = toNum[MapThread[uncondCov, {testExprs, Reverse[testExprs]}], $modNRC] //. numMod;
		AllTrue[Flatten[{res}], NumericQ]
	],
	True,
	{},
	TestID -> "[uncondCov] Evaluates to numbers for NRC model"
] *)

(* Test: uncondCorr evaluates to numbers across models *)
(* TestCreate[
	Module[{testExprs, numMod, res},
		testExprs = {wc[t], pd[t, 1]};
		numMod = getNumModel[$modNRC];
		res = toNum[MapThread[uncondCorr, {testExprs, Reverse[testExprs]}], $modNRC] //. numMod;
		AllTrue[Flatten[{res}], NumericQ]
	],
	True,
	{},
	TestID -> "[uncondCorr] Evaluates to numbers for NRC model"
] *)

(* Test: uncondCov evaluates to numbers for BKY model *)
(* TestCreate[
	Module[{testExprs, numMod, res},
		testExprs = {wc[t], pd[t, 1]};
		numMod = getNumModel[$modBKY];
		res = toNum[MapThread[uncondCov, {testExprs, Reverse[testExprs]}], $modBKY] //. numMod;
		AllTrue[Flatten[{res}], NumericQ]
	],
	True,
	{},
	TestID -> "[uncondCov] Evaluates to numbers for BKY model"
] *)

(* Test: uncondCorr evaluates to numbers for BKY model *)
(* TestCreate[
	Module[{testExprs, numMod, res},
		testExprs = {wc[t], pd[t, 1]};
		numMod = getNumModel[$modBKY];
		res = toNum[MapThread[uncondCorr, {testExprs, Reverse[testExprs]}], $modBKY] //. numMod;
		AllTrue[Flatten[{res}], NumericQ]
	],
	True,
	{},
	TestID -> "[uncondCorr] Evaluates to numbers for BKY model"
] *)


(* ::Subsection:: *)
(*Conditional Covariance and Correlation Tests*)


(* Test: cov evaluates to numbers across models *)
(* TestCreate[
	Module[{testExprs, numMod, res},
		testExprs = {wc[t], pd[t, 1]};
		numMod = getNumModel[$modNRC];
		res = toNum[MapThread[cov[#1, #2, t - 1] &, {testExprs, Reverse[testExprs]}], $modNRC] //. numMod;
		AllTrue[Flatten[{res}], NumericQ]
	],
	True,
	{},
	TestID -> "[cov] Evaluates to numbers for NRC model"
] *)

(* Test: corr evaluates to numbers across models *)
(* TestCreate[
	Module[{testExprs, numMod, res},
		testExprs = {wc[t], pd[t, 1]};
		numMod = getNumModel[$modNRC];
		res = toNum[MapThread[corr[#1, #2, t - 1] &, {testExprs, Reverse[testExprs]}], $modNRC] //. numMod;
		AllTrue[Flatten[{res}], NumericQ]
	],
	True,
	{},
	TestID -> "[corr] Evaluates to numbers for NRC model"
] *)

(* Test: cov evaluates to numbers for BKY model *)
(* TestCreate[
	Module[{testExprs, numMod, res},
		testExprs = {wc[t], pd[t, 1]};
		numMod = getNumModel[$modBKY];
		res = toNum[MapThread[cov[#1, #2, t - 1] &, {testExprs, Reverse[testExprs]}], $modBKY] //. numMod;
		AllTrue[Flatten[{res}], NumericQ]
	],
	True,
	{},
	TestID -> "[cov] Evaluates to numbers for BKY model"
] *)

(* Test: corr evaluates to numbers for BKY model *)
(* TestCreate[
	Module[{testExprs, numMod, res},
		testExprs = {wc[t], pd[t, 1]};
		numMod = getNumModel[$modBKY];
		res = toNum[MapThread[corr[#1, #2, t - 1] &, {testExprs, Reverse[testExprs]}], $modBKY] //. numMod;
		AllTrue[Flatten[{res}], NumericQ]
	],
	True,
	{},
	TestID -> "[corr] Evaluates to numbers for BKY model"
] *)


(* ::Subsection:: *)
(*Options Handling Integration Tests*)


(* Test: maxMaturity option evaluates to numbers *)
(* TestCreate[
	Module[{tn, numMod, testExprs},
		tn = toNum[$modNRC, maxMaturity -> 6];
		numMod = getNumModel[$modNRC];
		testExprs = {wc[t], pd[t, 1]};
		AllTrue[Flatten[{
			(tn[testExprs] //. numMod),
			(tn[uncondE /@ testExprs] //. numMod)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum] maxMaturity option evaluates to numbers"
] *)

(* Test: FindRootOptions option evaluates to numbers *)
(* TestCreate[
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
] *)

(* Test: MaxIterations option evaluates to numbers *)
(* TestCreate[
	Module[{tn, numMod, testExprs},
		tn = toNum[$modNRC, MaxIterations -> 100];
		numMod = getNumModel[$modNRC];
		testExprs = {wc[t], pd[t, 1]};
		AllTrue[Flatten[{
			(tn[testExprs] //. numMod),
			(tn[uncondE /@ testExprs] //. numMod)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum] MaxIterations option evaluates to numbers"
] *)

(* Test: initialGuess option evaluates to numbers *)
(* TestCreate[
	Module[{tn, numMod, testExprs},
		tn = toNum[$modNRC, "initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>];
		numMod = getNumModel[$modNRC];
		testExprs = {wc[t], pd[t, 1]};
		AllTrue[Flatten[{
			(tn[testExprs] //. numMod),
			(tn[uncondE /@ testExprs] //. numMod)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum] initialGuess option evaluates to numbers"
] *)

(* Test: Combined initialGuess and MaxIterations options evaluate to numbers *)
(* TestCreate[
	Module[{tn, numMod, testExprs},
		tn = toNum[$modNRC, "initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>, MaxIterations -> 100];
		numMod = getNumModel[$modNRC];
		testExprs = {wc[t], pd[t, 1]};
		AllTrue[Flatten[{
			(tn[testExprs] //. numMod),
			(tn[uncondE /@ testExprs] //. numMod)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum] Combined initialGuess and MaxIterations evaluate to numbers"
] *)

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

(* Test: RecurrenceTableOptions evaluates to numbers *)
(* TestCreate[
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
	{Reduce::inex, Reduce::naqs, FernandoDuarte`LongRunRisk`ComputationalEngine`FindRootOptim`Private`bindUnary::runtime},
	TestID -> "[toNum] RecurrenceTableOptions evaluates to numbers"
] *)

(* Test: DependentVariables option evaluates to numbers *)
(* TestCreate[
	Module[{tn, numMod, testExprs},
		tn = toNum[$modNRC, DependentVariables -> Automatic];
		numMod = getNumModel[$modNRC];
		testExprs = {wc[t], pd[t, 1]};
		AllTrue[Flatten[{
			(tn[testExprs] //. numMod),
			(tn[uncondE /@ testExprs] //. numMod)
		}], NumericQ]
	],
	True,
	{},
	TestID -> "[toNum] DependentVariables option evaluates to numbers"
] *)


(* ::Subsection:: *)
(*Multi-Model UpdatePd and UpdateBonds Tests*)


(* Test: UpdatePd option for BY model *)
(* TestCreate[
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
] *)

(* Test: UpdateBonds option for BY model *)
(* TestCreate[
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
] *)

(* Test: UpdatePd option for BKY model *)
(* TestCreate[
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
] *)

(* Test: UpdateBonds option for BKY model *)
(* TestCreate[
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
] *)

(* Test: UpdatePd option for DES model *)
(* TestCreate[
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
] *)

(* Test: UpdateBonds option for DES model *)
(* TestCreate[
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
] *)

(* Test: UpdatePd option for NRCStochVol model *)
(* TestCreate[
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
] *)

(* Test: UpdateBonds option for NRCStochVol model *)
(* TestCreate[
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
] *)


(* ::Subsection:: *)
(*Multi-Model Parameter Handling Tests*)


(* Test: New parameters with BY model *)
(* TestCreate[
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
] *)

(* Test: Initial guess with BY model *)
(* TestCreate[
	Module[{numMod, exprNewParam, guessCoeffsSolution},
		numMod = getNumModel[$modBY];
		exprNewParam = uncondE[wc[t]];
		guessCoeffsSolution = {A[0] -> 4.6};
		AllTrue[{
			exprNewParam // toNum[$modBY, {}, guessCoeffsSolution] //. numMod,
			toNum[exprNewParam, $modBY, {}, guessCoeffsSolution] //. numMod,
			toEquation[exprNewParam, $modBY] //. toNum["Rules", $modBY, {}, guessCoeffsSolution] //. numMod
		}, NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/BY] Initial guess evaluates to numbers"
] *)

(* Test: Combined new parameters and guess with BY model *)
(* TestCreate[
	Module[{numMod, newParameters, exprNewParam, guessCoeffsSolution},
		numMod = getNumModel[$modBY];
		newParameters = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.99};
		exprNewParam = uncondE[wc[t]];
		guessCoeffsSolution = {A[0] -> 4.6};
		AllTrue[{
			exprNewParam // toNum[$modBY, newParameters, guessCoeffsSolution] //. numMod,
			toNum[exprNewParam, $modBY, newParameters, guessCoeffsSolution] //. numMod,
			toEquation[exprNewParam, $modBY] //. toNum["Rules", $modBY, newParameters, guessCoeffsSolution] //. numMod
		}, NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/BY] Combined parameters and guess evaluate to numbers"
] *)

(* Test: New parameters with BKY model *)
(* TestCreate[
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
] *)

(* Test: Combined parameters, guess, and options with BKY model *)
(* TestCreate[
	Module[{numMod, newParameters, exprNewParam, guessCoeffsSolution},
		numMod = getNumModel[$modBKY];
		newParameters = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.99};
		exprNewParam = uncondE[wc[t]];
		guessCoeffsSolution = {A[0] -> 4.6};
		AllTrue[{
			exprNewParam // toNum[$modBKY, newParameters, guessCoeffsSolution, "initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>, MaxIterations -> 100] //. numMod,
			toNum[exprNewParam, $modBKY, newParameters, guessCoeffsSolution, "initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>, MaxIterations -> 100] //. numMod,
			toEquation[exprNewParam, $modBKY] //. toNum["Rules", $modBKY, newParameters, guessCoeffsSolution, "initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>, MaxIterations -> 100] //. numMod
		}, NumericQ]
	],
	True,
	{},
	TestID -> "[toNum/BKY] Combined parameters, guess, and options evaluate to numbers"
] *)

(* Test: New parameters with DES model *)
(* TestCreate[
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
] *)

(* Test: New parameters with NRCStochVol model *)
(* TestCreate[
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
] *)


(* ::Subsection:: *)
(*Extended Expression Types Tests*)


(* Test: All expression types evaluate to numbers for NRC model *)
(* TestCreate[
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
] *)

(* Test: Growth expressions evaluate to numbers *)
(* TestCreate[
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
] *)

(* Test: Composite expressions with arithmetic evaluate to numbers *)
(* TestCreate[
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
] *)

(* Test: All expression types evaluate to numbers for BKY model *)
(* TestCreate[
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
] *)


End[]
EndTestSection[]
