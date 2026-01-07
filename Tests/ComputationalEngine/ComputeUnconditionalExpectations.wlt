(* ::Package:: *)

(* ::Section:: *)
(*Kernel/ComputationalEngine/ComputeUnconditionalExpectations.wl Tests*)


BeginTestSection["Kernel/ComputationalEngine/ComputeUnconditionalExpectations.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];

(* ::Subsection:: *)
(*Load Test Helpers*)


Scan[Get @ FileNameJoin[{DirectoryName[$TestFileName, #], "Common.wl"}] &, {2, 1}];


(* ::Subsection:: *)
(*Test Fixtures*)


(* State variables without shocks *)
$stateVarsNoEps = {$sg, $pi};


(* ::Subsection:: *)
(*uncondE - Basic Expectations*)


TestCreate[
	uncondE[$pi[t], $modNRC],
	mup,
	{},
	TestID -> "uncondE-PiFirstMoment-ReturnsMup"
]

TestCreate[
	uncondE[$sg[t], $modNRC],
	Esg,
	{},
	TestID -> "uncondE-SgFirstMoment-ReturnsEsg"
]


(* ::Subsection:: *)
(*uncondE - Second Moments*)


TestCreate[
	simplifiesZeroQ[
		uncondE[$pi[t]^2, $modNRC] -
		(mup^2 + (xip^2 + 2 rhop xip phip + phip^2) / (1 - rhop^2))
	],
	True,
	{},
	TestID -> "uncondE-PiSquared-MatchesFormula"
]

TestCreate[
	simplifiesZeroQ[
		uncondE[$sg[t]^2, $modNRC] -
		(Esg^2 + phig^2 / (1 - rhog^2))
	],
	True,
	{},
	TestID -> "uncondE-SgSquared-MatchesFormula"
]

TestCreate[
	simplifiesZeroQ[uncondE[$pi[t] $sg[t], $modNRC] - (Esg mup)],
	True,
	{},
	TestID -> "uncondE-PiTimesSg-MatchesProduct"
]


(* ::Subsection:: *)
(*uncondE - Wealth-Consumption Ratio*)


TestCreate[
	Simplify[uncondE[$wc[t], $modNRC]],
	$A[0],
	{},
	TestID -> "uncondE-WcNRC-ReturnsAZero"
]

TestCreate[
	Simplify[uncondE[$wc[t], $modBY]],
	$A[0],
	{},
	TestID -> "uncondE-WcBY-ReturnsAZero"
]


(* ::Subsection:: *)
(*uncondVar - Variance Tests*)


TestCreate[
	simplifiesZeroQ[
		uncondVar[$pi[t], $modNRC] -
		(xip^2 + 2 rhop xip phip + phip^2) / (1 - rhop^2)
	],
	True,
	{},
	TestID -> "uncondVar-Pi-MatchesFormula"
]

TestCreate[
	simplifiesZeroQ[uncondVar[$sg[t], $modNRC] - phig^2 / (1 - rhog^2)],
	True,
	{},
	TestID -> "uncondVar-Sg-MatchesFormula"
]


(* ::Subsection:: *)
(*uncondCov - Covariance Tests*)


TestCreate[
	simplifiesZeroQ[uncondCov[$pi[t], $sg[t], $modNRC]],
	True,
	{},
	TestID -> "uncondCov-PiSg-IsZero"
]


(* ::Subsection:: *)
(*uncondCorr - Correlation Tests*)


TestCreate[
	Simplify[uncondCorr[$pi[t], $pi[t], $modNRC]],
	1,
	{},
	TestID -> "uncondCorr-SelfCorrelation-ReturnsOne"
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - Commutativity Tests*)


TestCreate[
	With[{ev = $evNoEps, model = $modNRC, vars = $stateVarsNoEps},
		ev[$pi[t] eps["pi"][t - 1], model, vars] ===
		ev[eps["pi"][t - 1] $pi[t], model, vars]
	],
	True,
	{},
	TestID -> "evNoEpsStateVarsProduct-PiEps-Commutative"
]

TestCreate[
	With[{ev = $evNoEps, model = $modNRC, vars = $stateVarsNoEps},
		ev[$pi[t] $sg[t - 1], model, vars] ===
		ev[$sg[t - 1] $pi[t], model, vars]
	],
	True,
	{},
	TestID -> "evNoEpsStateVarsProduct-PiSgLagged-Commutative"
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - Passthrough Tests*)


TestCreate[
	$evNoEps[$pi[t], $modNRC, $stateVarsNoEps],
	$pi[t],
	{},
	TestID -> "evNoEpsStateVarsProduct-SinglePi-Passthrough"
]

TestCreate[
	$evNoEps[$pi[t] $sg[t], $modNRC, $stateVarsNoEps],
	$pi[t] $sg[t],
	{},
	TestID -> "evNoEpsStateVarsProduct-PiSgSameTime-Passthrough"
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - Future Shock Tests*)


TestCreate[
	$evNoEps[$pi[t] eps["pi"][t + 1], $modNRC, $stateVarsNoEps],
	$pi[t] eps["pi"][1 + t],
	{},
	TestID -> "evNoEpsStateVarsProduct-FutureShock-Preserved"
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - Non-State Variable Handling*)


TestCreate[
	$evNoEps[$pi[t] foo[t - 1], $modNRC, $stateVarsNoEps],
	$pi[t] foo[t - 1],
	{},
	TestID -> "evNoEpsStateVarsProduct-NonStateVar-Preserved"
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - Irrelevant Variable Tests*)


TestCreate[
	With[{vars1 = Append[$stateVarsNoEps, myVariable], vars2 = Append[$stateVarsNoEps, $dd]},
		$evNoEps[$pi[t] eps["pi"][t - 1], $modNRC, vars1] ===
		$evNoEps[eps["pi"][t - 1] $pi[t], $modNRC, vars2]
	],
	True,
	{},
	TestID -> "evNoEpsStateVarsProduct-IrrelevantVar-NoEffect"
]

TestCreate[
	$evNoEps[$pi[t], $modNRC, Append[$stateVarsNoEps, irrelevantVar]],
	$pi[t],
	{},
	TestID -> "evNoEpsStateVarsProduct-SinglePiWithIrrelevant-Passthrough"
]


(* ::Subsection:: *)
(*Shock Context Verification*)


TestCreate[
	With[{result = $evNoEps[$pi[t - 1] $dd[t, i] eps["pi"][t - 1], $modNRC, Append[$stateVarsNoEps, $dd]]},
		AllTrue[
			Cases[result, x_Symbol?(MatchQ[SymbolName[#], "eps"] &)[__][__, ___] :> Context@x, Infinity],
			# === "FernandoDuarte`LongRunRisk`Model`Shocks`" &
		]
	],
	True,
	{},
	TestID -> "evNoEpsStateVarsProduct-ShockContext-IsCorrect"
]


(* ::Subsection:: *)
(*Time Lag Verification*)


TestCreate[
	With[{result = $evNoEps[$pi[t] $sg[t - 1], $modNRC, $stateVarsNoEps]},
		FreeQ[result, _Symbol?(MatchQ[SymbolName[#], "pi"] &)[t]]
	],
	True,
	{},
	TestID -> "evNoEpsStateVarsProduct-PiWithSgLagged-PiIsLagged"
]

TestCreate[
	With[{result = $evNoEps[$pi[t] $sg[t - 1], $modNRC, $stateVarsNoEps]},
		Not@FreeQ[result, _Symbol?(MatchQ[SymbolName[#], "sg"] &)[t - 1]]
	],
	True,
	{},
	TestID -> "evNoEpsStateVarsProduct-PiWithSgLagged-SgPreserved"
]


(* ::Subsection:: *)
(*Wealth-Consumption and Price-Dividend Coefficient Tests*)


TestCreate[
	$evNoEps[$wc[t] eps["pi"][t - 1], $modNRC, $stateVarsNoEps],
	$wc[t] eps["pi"][-1 + t],
	{},
	TestID -> "evNoEpsStateVarsProduct-WcEpsLagged-ProductPreserved"
]

TestCreate[
	With[{result = $evNoEps[$wc[t] eps["pi"][t], $modNRC, {$wc}]},
		Coefficient[result, $pi[t - 1]] === rhop $A[1] eps["pi"][t]
	],
	True,
	{},
	TestID -> "evNoEpsStateVarsProduct-WcEps-CoefficientCorrect"
]


(* ::Subsection:: *)
(*A and B Coefficient Context Tests*)


TestCreate[
	With[{result = $evNoEps[$A[0] $wc[t] eps["pi"][t - 1], $modNRC, $stateVarsNoEps]},
		AllTrue[
			Cases[result, x_Symbol?(MatchQ[SymbolName[#], "A"] &)[_] :> Context@x, Infinity],
			# === "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`" &
		]
	],
	True,
	{},
	TestID -> "evNoEpsStateVarsProduct-ACoeff-CorrectContext"
]

TestCreate[
	$evNoEps[$pd[t, i] eps["pi"][t - 1], $modNRC, $stateVarsNoEps],
	$pd[t, i] eps["pi"][-1 + t],
	{},
	TestID -> "evNoEpsStateVarsProduct-PdEpsLagged-ProductPreserved"
]


End[]
EndTestSection[]
