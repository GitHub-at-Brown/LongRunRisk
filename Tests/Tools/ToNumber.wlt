(* ::Package:: *)

(* ::Section:: *)
(*Kernel/Tools/ToNumber.wl Tests*)


BeginTestSection["Kernel/Tools/ToNumber.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`"]

Needs["FernandoDuarte`LongRunRisk`Tools`ToNumber`"];


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
	TestID -> "processNewParameters-EqualParameters-ValuesAreNumbers"
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
	TestID -> "processNewParameters-EqualParameters-KeysMatchByName"
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
	TestID -> "processNewParameters-EqualParameters-KeysMatchWithContext"
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
	TestID -> "processNewParameters-EqualParameters-KeysAreSubset"
]

(* Test: When old and new parameters are equal, does not abort *)
TestCreate[
	With[{p = $baseParams, newP = $baseParams},
		Not @ checkAbrt[processNewParameters[newP, p]]
	],
	True,
	{},
	TestID -> "processNewParameters-EqualParameters-DoesNotAbort"
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
	TestID -> "processNewParameters-SubsetParameters-ValuesAreNumbers"
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
	TestID -> "processNewParameters-SubsetParameters-KeysMatchNewByName"
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
	TestID -> "processNewParameters-SubsetParameters-KeysInCorrectContext"
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
	TestID -> "processNewParameters-EmptyParameters-ReturnsEmptyList"
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
	TestID -> "processNewParameters-NotSubset-Aborts"
]

(* Test: When new parameters are NOT a subset, issues subsetparam message *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`phip -> 3}},
		checkMsg[processNewParameters[newP, p],
			FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::subsetparam]
	],
	True,
	{},
	TestID -> "processNewParameters-NotSubset-IssuesSubsetparamMessage"
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
	TestID -> "processNewParameters-PsiEqualsOne-Aborts"
]

(* Test: psi=1 issues psi message *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1}},
		checkMsg[processNewParameters[newP, p],
			FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::psi]
	],
	True,
	{},
	TestID -> "processNewParameters-PsiEqualsOne-IssuesPsiMessage"
]

(* Test: psi=1. (numeric) also aborts *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1.}},
		checkAbrt[processNewParameters[newP, p]]
	],
	True,
	{},
	TestID -> "processNewParameters-PsiEqualsOneNumeric-Aborts"
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
	TestID -> "processNewParameters-AllThreeExactTheta-DoesNotAbort"
]

(* Test: When all three {gamma, psi, theta} provided and theta exactly correct, values are numbers *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`gamma -> 10, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> (1 - FernandoDuarte`LongRunRisk`Model`Parameters`gamma)/(1 - 1/FernandoDuarte`LongRunRisk`Model`Parameters`psi), FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1.5`}},
		AllTrue[Values @ processNewParameters[newP, p], NumberQ]
	],
	True,
	{},
	TestID -> "processNewParameters-AllThreeExactTheta-ValuesAreNumbers"
]

(* Test: When theta is NOT exactly correct, issues param message *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`gamma -> 10, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> 3.23`, FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1.5`}},
		checkMsg[processNewParameters[newP, p],
			FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::param]
	],
	True,
	{},
	TestID -> "processNewParameters-ThetaNotExact-IssuesParamMessage"
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
	TestID -> "processNewParameters-ThetaNotExact-RecalculatesCorrectly"
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
	TestID -> "processNewParameters-SolveForGamma-ValuesAreNumbers"
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
	TestID -> "processNewParameters-SolveForGamma-CorrectValue"
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
	TestID -> "processNewParameters-SolveForTheta-CorrectValue"
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
	TestID -> "processNewParameters-SolveForPsi-CorrectValue"
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
	TestID -> "processNewParameters-ThetaAlone-Aborts"
]

(* Test: theta provided without gamma or psi issues theta message *)
TestCreate[
	With[{p = $baseParams, newP = {FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.9, FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 1, FernandoDuarte`LongRunRisk`Model`Parameters`theta -> 1.}},
		checkMsg[processNewParameters[newP, p],
			FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::theta]
	],
	True,
	{},
	TestID -> "processNewParameters-ThetaAlone-IssuesThetaMessage"
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
	TestID -> "processNewParameters-ContextPreservation-NewContextsDontMatch"
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
	TestID -> "processNewParameters-ContextPreservation-ProcContextsMatchOld"
]


End[]
EndTestSection[]
