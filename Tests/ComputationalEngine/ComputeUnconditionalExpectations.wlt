(* ::Package:: *)

(* ::Section:: *)
(*Kernel/ComputationalEngine/ComputeUnconditionalExpectations.wl Tests*)


BeginTestSection["Kernel/ComputationalEngine/ComputeUnconditionalExpectations.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];

(* ::Subsection:: *)
(*Load Test Helpers*)


Get @ FileNameJoin[{DirectoryName[$TestFileName, 2], "TestHelpers.wl"}];
Get @ FileNameJoin[{DirectoryName[$TestFileName, 1], "CETestHelpers.wl"}];


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
	TestID -> "[uncondE] First moment of pi returns mup",
	MetaInformation -> <|"Category" -> "extended"|>
]

TestCreate[
	uncondE[$sg[t], $modNRC],
	Esg,
	{},
	TestID -> "[uncondE] First moment of sg returns Esg",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[uncondE] Second moment of pi matches analytical formula",
	MetaInformation -> <|"Category" -> "extended"|>
]

TestCreate[
	simplifiesZeroQ[
		uncondE[$sg[t]^2, $modNRC] -
		(Esg^2 + phig^2 / (1 - rhog^2))
	],
	True,
	{},
	TestID -> "[uncondE] Second moment of sg matches analytical formula",
	MetaInformation -> <|"Category" -> "extended"|>
]

TestCreate[
	simplifiesZeroQ[uncondE[$pi[t] $sg[t], $modNRC] - (Esg mup)],
	True,
	{},
	TestID -> "[uncondE] Cross-moment pi*sg equals product of means",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*uncondE - Wealth-Consumption Ratio*)


TestCreate[
	Simplify[uncondE[$wc[t], $modNRC]],
	$A[0],
	{},
	TestID -> "[uncondE] Wealth-consumption ratio in NRC returns A[0]",
	MetaInformation -> <|"Category" -> "extended"|>
]

TestCreate[
	Simplify[uncondE[$wc[t], $modBY]],
	$A[0],
	{},
	TestID -> "[uncondE] Wealth-consumption ratio in BY returns A[0]",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[uncondVar] Variance of pi matches analytical formula",
	MetaInformation -> <|"Category" -> "extended"|>
]

TestCreate[
	simplifiesZeroQ[uncondVar[$sg[t], $modNRC] - phig^2 / (1 - rhog^2)],
	True,
	{},
	TestID -> "[uncondVar] Variance of sg matches analytical formula",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*uncondCov - Covariance Tests*)


TestCreate[
	simplifiesZeroQ[uncondCov[$pi[t], $sg[t], $modNRC]],
	True,
	{},
	TestID -> "[uncondCov] Covariance of pi and sg is zero",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*uncondCorr - Correlation Tests*)


TestCreate[
	Simplify[uncondCorr[$pi[t], $pi[t], $modNRC]],
	1,
	{},
	TestID -> "[uncondCorr] Self-correlation of pi returns one",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[evNoEps] pi*eps product is commutative",
	MetaInformation -> <|"Category" -> "extended"|>
]

TestCreate[
	With[{ev = $evNoEps, model = $modNRC, vars = $stateVarsNoEps},
		ev[$pi[t] $sg[t - 1], model, vars] ===
		ev[$sg[t - 1] $pi[t], model, vars]
	],
	True,
	{},
	TestID -> "[evNoEps] pi*sg lagged product is commutative",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - Passthrough Tests*)


TestCreate[
	$evNoEps[$pi[t], $modNRC, $stateVarsNoEps],
	$pi[t],
	{},
	TestID -> "[evNoEps] Single pi passes through unchanged",
	MetaInformation -> <|"Category" -> "extended"|>
]

TestCreate[
	$evNoEps[$pi[t] $sg[t], $modNRC, $stateVarsNoEps],
	$pi[t] $sg[t],
	{},
	TestID -> "[evNoEps] Same-time pi*sg passes through unchanged",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - Future Shock Tests*)


TestCreate[
	$evNoEps[$pi[t] eps["pi"][t + 1], $modNRC, $stateVarsNoEps],
	$pi[t] eps["pi"][1 + t],
	{},
	TestID -> "[evNoEps] Future shock in product is preserved",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - Non-State Variable Handling*)


TestCreate[
	$evNoEps[$pi[t] foo[t - 1], $modNRC, $stateVarsNoEps],
	$pi[t] foo[t - 1],
	{},
	TestID -> "[evNoEps] Non-state variable foo is preserved in product",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[evNoEps] Irrelevant state variables do not affect result",
	MetaInformation -> <|"Category" -> "extended"|>
]

TestCreate[
	$evNoEps[$pi[t], $modNRC, Append[$stateVarsNoEps, irrelevantVar]],
	$pi[t],
	{},
	TestID -> "[evNoEps] Single pi with irrelevant var passes through",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[evNoEps] Shock symbols maintain correct Shocks context",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*Time Lag Verification*)


TestCreate[
	With[{result = $evNoEps[$pi[t] $sg[t - 1], $modNRC, $stateVarsNoEps]},
		FreeQ[result, _Symbol?(MatchQ[SymbolName[#], "pi"] &)[t]]
	],
	True,
	{},
	TestID -> "[evNoEps] pi[t] with lagged sg substitutes pi to earlier time",
	MetaInformation -> <|"Category" -> "extended"|>
]

TestCreate[
	With[{result = $evNoEps[$pi[t] $sg[t - 1], $modNRC, $stateVarsNoEps]},
		Not@FreeQ[result, _Symbol?(MatchQ[SymbolName[#], "sg"] &)[t - 1]]
	],
	True,
	{},
	TestID -> "[evNoEps] Lagged sg[t-1] is preserved in result",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*Wealth-Consumption and Price-Dividend Coefficient Tests*)


TestCreate[
	$evNoEps[$wc[t] eps["pi"][t - 1], $modNRC, $stateVarsNoEps],
	$wc[t] eps["pi"][-1 + t],
	{},
	TestID -> "[evNoEps] wc*eps lagged product is preserved",
	MetaInformation -> <|"Category" -> "extended"|>
]

TestCreate[
	With[{result = $evNoEps[$wc[t] eps["pi"][t], $modNRC, {$wc}]},
		Coefficient[result, $pi[t - 1]] === rhop $A[1] eps["pi"][t]
	],
	True,
	{},
	TestID -> "[evNoEps] wc*eps coefficient of pi[t-1] is correct",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[evNoEps] A coefficient maintains correct Private context",
	MetaInformation -> <|"Category" -> "extended"|>
]

TestCreate[
	$evNoEps[$pd[t, i] eps["pi"][t - 1], $modNRC, $stateVarsNoEps],
	$pd[t, i] eps["pi"][-1 + t],
	{},
	TestID -> "[evNoEps] pd*eps lagged product is preserved",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - Lagged Product Substitution Tests*)


(* Test: lagged pi*sg substitutes pi to earlier time *)
TestCreate[
	With[{result = ExpandAll[$evNoEps[$pi[t - 1] $sg[t], $modNRC, $stateVarsNoEps]]},
		ExpandAll[result] === ExpandAll[
			(Esg $pi[t - 1] + rhog $pi[t - 1] $sg[t - 1] + phig $pi[t - 1] eps["sg"][t]) -
			Esg rhog $pi[t - 1]
		]
	],
	True,
	{},
	TestID -> "[evNoEps] Lagged pi times sg substitutes correctly",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: pi*eps at same time expands with shock terms *)
TestCreate[
	With[{result = ExpandAll[$evNoEps[$pi[t] eps["pi"][t], $modNRC, $stateVarsNoEps]]},
		ExpandAll[result] === ExpandAll[
			(mup eps["pi"][t] + rhop $pi[t - 1] eps["pi"][t] +
			xip eps["pi"][t - 1] eps["pi"][t] + phip eps["pi"][t]^2) -
			mup rhop eps["pi"][t]
		]
	],
	True,
	{},
	TestID -> "[evNoEps] pi times same-time eps expands with shock terms",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - Non-State Variable dd Tests*)


(* Test: eps*dd with dd not in stateVars passes through *)
TestCreate[
	ExpandAll[$evNoEps[eps["pi"][t] $dd[t, i], $modNRC, $stateVarsNoEps]],
	ExpandAll[$dd[t, i] eps["pi"][t]],
	{},
	TestID -> "[evNoEps] eps times dd passes through when dd not state var",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: eps*dd with dd as state var expands fully *)
TestCreate[
	With[{result = ExpandAll[$evNoEps[eps["pi"][t] $dd[t, i], $modNRC, Append[$stateVarsNoEps, $dd]]]},
		ExpandAll[result] === ExpandAll[
			(mud[i] eps["pi"][t] + rhodp[i] $pi[t - 1] eps["pi"][t] +
			phidc[i] eps["dc"][t] eps["pi"][t] + xid[i] $sg[t - 2] eps["pi"][t - 1] eps["pi"][t]) -
			mup rhodp[i] eps["pi"][t]
		]
	],
	True,
	{},
	TestID -> "[evNoEps] eps times dd with dd as state var expands fully",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - Shock Context Tests with dd*)


(* Test: shock context in pi*dd*eps product *)
TestCreate[
	With[{result = $evNoEps[$pi[t - 1] $dd[t, i] eps["pi"][t - 1], $modNRC, Append[$stateVarsNoEps, $dd]]},
		AllTrue[
			Cases[result, x_Symbol?(MatchQ[SymbolName[#], "eps"] &)[__][__, ___] :> Context@x, Infinity],
			# === "FernandoDuarte`LongRunRisk`Model`Shocks`" &
		]
	],
	True,
	{},
	TestID -> "[evNoEps] Shock context preserved in pi*dd*eps product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: shock context in complex pi*dd*eps*eps product *)
TestCreate[
	With[{result = $evNoEps[$pi[t - 1] $dd[t, i] eps["pi"][t] eps["pi"][t - 1], $modNRC, Append[$stateVarsNoEps, $dd]]},
		AllTrue[
			Cases[result, x_Symbol?(MatchQ[SymbolName[#], "eps"] &)[__][__, ___] :> Context@x, Infinity],
			# === "FernandoDuarte`LongRunRisk`Model`Shocks`" &
		]
	],
	True,
	{},
	TestID -> "[evNoEps] Shock context preserved in pi*dd*eps*eps product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: shock context in pi*sg*dd*eps product *)
TestCreate[
	With[{result = $evNoEps[$pi[t - 1] $sg[t] $dd[t, i] eps["pi"][t - 1], $modNRC, Append[$stateVarsNoEps, $dd]]},
		AllTrue[
			Cases[result, x_Symbol?(MatchQ[SymbolName[#], "eps"] &)[__][__, ___] :> Context@x, Infinity],
			# === "FernandoDuarte`LongRunRisk`Model`Shocks`" &
		]
	],
	True,
	{},
	TestID -> "[evNoEps] Shock context preserved in pi*sg*dd*eps product",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - Sum Expression Tests*)


(* Test: sum expression removes pi[t] terms *)
TestCreate[
	With[{result = $evNoEps[$pi[t] $sg[t - 1] + $pi[t - 1] $sg[t], $modNRC, $stateVarsNoEps]},
		FreeQ[result, _Symbol?(MatchQ[SymbolName[#], "pi"] &)[t]]
	],
	True,
	{},
	TestID -> "[evNoEps] Sum expression removes pi[t] terms",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: sum expression removes sg[t] terms *)
TestCreate[
	With[{result = $evNoEps[$pi[t] $sg[t - 1] + $pi[t - 1] $sg[t], $modNRC, $stateVarsNoEps]},
		FreeQ[result, _Symbol?(MatchQ[SymbolName[#], "sg"] &)[t]]
	],
	True,
	{},
	TestID -> "[evNoEps] Sum expression removes sg[t] terms",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: sum expression preserves pi[t-1] terms *)
TestCreate[
	With[{result = $evNoEps[$pi[t] $sg[t - 1] + $pi[t - 1] $sg[t], $modNRC, $stateVarsNoEps]},
		Not@FreeQ[result, _Symbol?(MatchQ[SymbolName[#], "pi"] &)[t - 1]]
	],
	True,
	{},
	TestID -> "[evNoEps] Sum expression preserves pi[t-1] terms",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: sum expression preserves sg[t-1] terms *)
TestCreate[
	With[{result = $evNoEps[$pi[t] $sg[t - 1] + $pi[t - 1] $sg[t], $modNRC, $stateVarsNoEps]},
		Not@FreeQ[result, _Symbol?(MatchQ[SymbolName[#], "sg"] &)[t - 1]]
	],
	True,
	{},
	TestID -> "[evNoEps] Sum expression preserves sg[t-1] terms",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - Future Shock Factorization*)


(* Test: future shock factors out of product *)
TestCreate[
	ExpandAll[$evNoEps[eps["pi"][t + 1] eps["pi"][t] $pi[t], $modNRC, $stateVarsNoEps]],
	ExpandAll[eps["pi"][t + 1] $evNoEps[eps["pi"][t] $pi[t], $modNRC, $stateVarsNoEps]],
	{},
	TestID -> "[evNoEps] Future shock factors out of product",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - Irrelevant Variable in Product Tests*)


(* Test: anotherIrrelevantVar preserves pi*sg structure *)
TestCreate[
	$evNoEps[anotherIrrelevantVar $pi[t] $sg[t], $modNRC, Append[$stateVarsNoEps, anotherIrrelevantVar]],
	anotherIrrelevantVar $pi[t] $sg[t],
	{},
	TestID -> "[evNoEps] Irrelevant var preserves pi*sg structure",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - FreeQ Tests for dd Interactions*)


(* Test: dd[t,i] substituted when dd in stateVars with lagged pi *)
TestCreate[
	FreeQ[
		$evNoEps[$pi[t - 1] $dd[t, i], $modNRC, Append[$stateVarsNoEps, $dd]],
		_Symbol?(MatchQ[SymbolName[#], "dd"] &)[t, i]
	],
	True,
	{},
	TestID -> "[evNoEps] dd[t,i] substituted when dd in stateVars with lagged pi",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: pi[t] substituted when with lagged dd *)
TestCreate[
	FreeQ[
		$evNoEps[$pi[t] $dd[t - 1, i], $modNRC, Append[$stateVarsNoEps, $dd]],
		_Symbol?(MatchQ[SymbolName[#], "pi"] &)[t]
	],
	True,
	{},
	TestID -> "[evNoEps] pi[t] substituted when with lagged dd",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: dd[t-1,i] preserved when lagged *)
TestCreate[
	FreeQ[
		$evNoEps[$pi[t - 1] $dd[t, i] eps["pi"][t - 1], $modNRC, Append[$stateVarsNoEps, $dd]],
		_Symbol?(MatchQ[SymbolName[#], "dd"] &)[t - 1, i]
	],
	True,
	{},
	TestID -> "[evNoEps] dd[t-1,i] not present in result with dd as stateVar",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: eps["pi"][t-1] preserved in result *)
TestCreate[
	Not@FreeQ[
		$evNoEps[$pi[t - 1] $dd[t, i] eps["pi"][t - 1], $modNRC, Append[$stateVarsNoEps, $dd]],
		_Symbol?(MatchQ[SymbolName[#], "eps"] &)["pi"][t - 1]
	],
	True,
	{},
	TestID -> "[evNoEps] eps[pi][t-1] preserved in complex product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: pi[t,i] pattern not in result *)
TestCreate[
	FreeQ[
		$evNoEps[$pi[t] $dd[t - 1, i] eps["pi"][t - 1], $modNRC, Append[$stateVarsNoEps, $dd]],
		_Symbol?(MatchQ[SymbolName[#], "pi"] &)[t, i]
	],
	True,
	{},
	TestID -> "[evNoEps] pi[t,i] pattern not in result",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: dd[t-1,i] preserved with eps["dd"] shock *)
TestCreate[
	FreeQ[
		$evNoEps[$pi[t - 1] $dd[t, i] eps["dd"][t - 1, i], $modNRC, Append[$stateVarsNoEps, $dd]],
		_Symbol?(MatchQ[SymbolName[#], "dd"] &)[t - 1, i]
	],
	True,
	{},
	TestID -> "[evNoEps] dd[t-1,i] pattern not in result with eps[dd] shock",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: eps["dd"][t-1,i] preserved in result *)
TestCreate[
	Not@FreeQ[
		$evNoEps[$pi[t - 1] $dd[t, i] eps["dd"][t - 1, i], $modNRC, Append[$stateVarsNoEps, $dd]],
		_Symbol?(MatchQ[SymbolName[#], "eps"] &)["dd"][t - 1, i]
	],
	True,
	{},
	TestID -> "[evNoEps] eps[dd][t-1,i] preserved in result",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: pi[t] substituted in pi*dd*eps["dd"] product *)
TestCreate[
	FreeQ[
		$evNoEps[$pi[t] $dd[t - 1, i] eps["dd"][t - 1, i], $modNRC, Append[$stateVarsNoEps, $dd]],
		_Symbol?(MatchQ[SymbolName[#], "pi"] &)[t]
	],
	True,
	{},
	TestID -> "[evNoEps] pi[t] substituted in pi*dd*eps[dd] product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: pi symbol present somewhere in result *)
TestCreate[
	Not@FreeQ[
		$evNoEps[$pi[t] $dd[t - 1, i] eps["dd"][t - 1, i], $modNRC, Append[$stateVarsNoEps, $dd]],
		_Symbol?(MatchQ[SymbolName[#], "pi"] &)[_]
	],
	True,
	{},
	TestID -> "[evNoEps] pi symbol present in result at some time",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*uncondEStep - dc*sg Tests*)


(* Test: uncondEStep dc*sg removes dc symbol *)
TestCreate[
	FreeQ[
		$uncondEStep[$dc[t - 1] $sg[t], $modNRC],
		_Symbol?(MatchQ[SymbolName[#], "dc"] &),
		Infinity
	],
	True,
	{},
	TestID -> "[uncondEStep] dc*sg product removes dc symbol",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: uncondEStep dc*sg removes pi[t] *)
TestCreate[
	FreeQ[
		$uncondEStep[$dc[t - 1] $sg[t], $modNRC],
		_Symbol?(MatchQ[SymbolName[#], "pi"] &)[t],
		Infinity
	],
	True,
	{},
	TestID -> "[uncondEStep] dc*sg product removes pi[t]",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - pd Coefficient Tests*)


(* Test: pd*eps coefficient of pi[t-1] is correct *)
TestCreate[
	With[{result = $evNoEps[$pd[t, i] eps["pi"][t], $modNRC, {$pd}]},
		Coefficient[result, $pi[t - 1]] === rhop $B[i][1] eps["pi"][t]
	],
	True,
	{},
	TestID -> "[evNoEps] pd*eps coefficient of pi[t-1] is correct",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - B Coefficient Context Tests*)


(* Test: A and B coefficients in A*B*pd*eps product have correct context *)
TestCreate[
	With[{result = $evNoEps[$A[0] $B[i][1] $pd[t, i] eps["pi"][t - 1], $modNRC, $stateVarsNoEps]},
		AllTrue[
			Cases[result, x_Symbol?(MatchQ[SymbolName[#], "A"] &)[_] :> Context@x, Infinity],
			# === "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`" &
		]
	],
	True,
	{},
	TestID -> "[evNoEps] A coefficient maintains context in A*B*pd*eps product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: B coefficient in A*B*pd*eps product has correct context *)
TestCreate[
	With[{result = $evNoEps[$A[0] $B[i][1] $pd[t, i] eps["pi"][t - 1], $modNRC, $stateVarsNoEps]},
		AllTrue[
			Cases[result, x_Symbol?(MatchQ[SymbolName[#], "B"] &)[_][_] :> Context@x, Infinity],
			# === "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`" &
		]
	],
	True,
	{},
	TestID -> "[evNoEps] B coefficient maintains context in A*B*pd*eps product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: A coefficient in A*B*pd*eps with pd as stateVar has correct context *)
TestCreate[
	With[{result = $evNoEps[$A[0] $B[i][1] $pd[t, i] eps["pi"][t - 1], $modNRC, {$pd}]},
		AllTrue[
			Cases[result, x_Symbol?(MatchQ[SymbolName[#], "A"] &)[_] :> Context@x, Infinity],
			# === "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`" &
		]
	],
	True,
	{},
	TestID -> "[evNoEps] A coefficient maintains context with pd as stateVar",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: B coefficient in A*B*pd*eps with pd as stateVar has correct context *)
TestCreate[
	With[{result = $evNoEps[$A[0] $B[i][1] $pd[t, i] eps["pi"][t - 1], $modNRC, {$pd}]},
		AllTrue[
			Cases[result, x_Symbol?(MatchQ[SymbolName[#], "B"] &)[_][_] :> Context@x, Infinity],
			# === "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`" &
		]
	],
	True,
	{},
	TestID -> "[evNoEps] B coefficient maintains context with pd as stateVar",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*uncondE - Higher Moment Factorization Tests*)


(* Test: Third moment of pi times sg factors as product *)
TestCreate[
	simplifiesZeroQ[
		uncondE[$pi[t]^3, $modNRC] uncondE[$sg[t], $modNRC] -
		uncondE[$pi[t]^3 $sg[t], $modNRC]
	],
	True,
	{},
	TestID -> "[uncondE] Third moment of pi times sg factors as product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Third moment of pi times sg analytical formula *)
TestCreate[
	simplifiesZeroQ[
		uncondE[$pi[t]^3 $sg[t], $modNRC] -
		Esg mup (mup^2 - 3 (phip^2 + 2 phip rhop xip + xip^2) / (rhop^2 - 1))
	],
	True,
	{},
	TestID -> "[uncondE] Third moment of pi times sg matches analytical formula",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*uncondE - Consumption Growth Tests*)


(* Test: First moment of dc returns muc *)
TestCreate[
	Simplify[uncondE[$dc[t], $modNRC]],
	muc,
	{},
	TestID -> "[uncondE] First moment of dc returns muc",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Second moment of dc matches analytical formula *)
TestCreate[
	simplifiesZeroQ[
		uncondE[$dc[t]^2, $modNRC] -
		(muc^2 + phic^2 + 2 Esg phip rhocp xic +
		xic^2 (Esg^2 + phig^2 / (1 - rhog^2)) +
		rhocp^2 (phip^2 + 2 phip rhop xip + xip^2) / (1 - rhop^2))
	],
	True,
	{},
	TestID -> "[uncondE] Second moment of dc matches analytical formula",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Cross-moment pi*dc matches analytical formula *)
TestCreate[
	simplifiesZeroQ[
		uncondE[$pi[t] $dc[t], $modNRC] -
		(muc mup + rhocp xip phip + xic rhop phip Esg + xic xip Esg +
		rhocp rhop (xip^2 + 2 rhop xip phip + phip^2) / (1 - rhop^2))
	],
	True,
	{},
	TestID -> "[uncondE] Cross-moment pi*dc matches analytical formula",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Cross-moment sg*dc equals muc*Esg *)
TestCreate[
	simplifiesZeroQ[uncondE[$sg[t] $dc[t], $modNRC] - muc Esg],
	True,
	{},
	TestID -> "[uncondE] Cross-moment sg*dc equals muc times Esg",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*uncondE - Autocovariance Tests*)


(* Test: sg autocovariance at lag 1 forward *)
TestCreate[
	simplifiesZeroQ[
		uncondE[$sg[t] $sg[t + 1], $modNRC] -
		(Esg^2 + rhog / (1 - rhog^2) phig^2)
	],
	True,
	{},
	TestID -> "[uncondE] sg autocovariance at lag 1 forward matches formula",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: sg autocovariance at lag 1 backward *)
TestCreate[
	simplifiesZeroQ[
		uncondE[$sg[t] $sg[t - 1], $modNRC] -
		(Esg^2 + rhog / (1 - rhog^2) phig^2)
	],
	True,
	{},
	TestID -> "[uncondE] sg autocovariance at lag 1 backward matches formula",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: pi autocovariance at lag 1 forward *)
TestCreate[
	simplifiesZeroQ[
		uncondE[$pi[t] $pi[t + 1], $modNRC] -
		(mup^2 + phip xip + rhop (phip^2 + 2 rhop xip phip + xip^2) / (1 - rhop^2))
	],
	True,
	{},
	TestID -> "[uncondE] pi autocovariance at lag 1 forward matches formula",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: pi autocovariance at lag 1 backward *)
TestCreate[
	simplifiesZeroQ[
		uncondE[$pi[t] $pi[t - 1], $modNRC] -
		(mup^2 + phip xip + rhop (phip^2 + 2 rhop xip phip + xip^2) / (1 - rhop^2))
	],
	True,
	{},
	TestID -> "[uncondE] pi autocovariance at lag 1 backward matches formula",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*uncondE - Cross-Moment at Different Times*)


(* Test: pi[t]*sg[t+1] equals Esg*mup *)
TestCreate[
	simplifiesZeroQ[uncondE[$pi[t] $sg[t + 1], $modNRC] - Esg mup],
	True,
	{},
	TestID -> "[uncondE] Cross-moment pi[t]*sg[t+1] equals Esg*mup",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: lagged cross-moment pi[t-1]*dc[t] matches formula *)
TestCreate[
	simplifiesZeroQ[
		uncondE[$pi[t - 1] $dc[t], $modNRC] -
		(muc mup + Esg phip xic +
		rhocp (phip^2 + 2 phip rhop xip + xip^2) / (1 - rhop^2))
	],
	True,
	{},
	TestID -> "[uncondE] Lagged cross-moment pi[t-1]*dc[t] matches formula",
	MetaInformation -> <|"Category" -> "extended"|>
]


End[]
EndTestSection[]
