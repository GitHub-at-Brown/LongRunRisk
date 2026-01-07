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
	TestID -> "[uncondE] First moment of pi returns mup"
]

TestCreate[
	uncondE[$sg[t], $modNRC],
	Esg,
	{},
	TestID -> "[uncondE] First moment of sg returns Esg"
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
	TestID -> "[uncondE] Second moment of pi matches analytical formula"
]

TestCreate[
	simplifiesZeroQ[
		uncondE[$sg[t]^2, $modNRC] -
		(Esg^2 + phig^2 / (1 - rhog^2))
	],
	True,
	{},
	TestID -> "[uncondE] Second moment of sg matches analytical formula"
]

TestCreate[
	simplifiesZeroQ[uncondE[$pi[t] $sg[t], $modNRC] - (Esg mup)],
	True,
	{},
	TestID -> "[uncondE] Cross-moment pi*sg equals product of means"
]


(* ::Subsection:: *)
(*uncondE - Wealth-Consumption Ratio*)


TestCreate[
	Simplify[uncondE[$wc[t], $modNRC]],
	$A[0],
	{},
	TestID -> "[uncondE] Wealth-consumption ratio in NRC returns A[0]"
]

TestCreate[
	Simplify[uncondE[$wc[t], $modBY]],
	$A[0],
	{},
	TestID -> "[uncondE] Wealth-consumption ratio in BY returns A[0]"
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
	TestID -> "[uncondVar] Variance of pi matches analytical formula"
]

TestCreate[
	simplifiesZeroQ[uncondVar[$sg[t], $modNRC] - phig^2 / (1 - rhog^2)],
	True,
	{},
	TestID -> "[uncondVar] Variance of sg matches analytical formula"
]


(* ::Subsection:: *)
(*uncondCov - Covariance Tests*)


TestCreate[
	simplifiesZeroQ[uncondCov[$pi[t], $sg[t], $modNRC]],
	True,
	{},
	TestID -> "[uncondCov] Covariance of pi and sg is zero"
]


(* ::Subsection:: *)
(*uncondCorr - Correlation Tests*)


TestCreate[
	Simplify[uncondCorr[$pi[t], $pi[t], $modNRC]],
	1,
	{},
	TestID -> "[uncondCorr] Self-correlation of pi returns one"
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
	TestID -> "[evNoEps] pi*eps product is commutative"
]

TestCreate[
	With[{ev = $evNoEps, model = $modNRC, vars = $stateVarsNoEps},
		ev[$pi[t] $sg[t - 1], model, vars] ===
		ev[$sg[t - 1] $pi[t], model, vars]
	],
	True,
	{},
	TestID -> "[evNoEps] pi*sg lagged product is commutative"
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - Passthrough Tests*)


TestCreate[
	$evNoEps[$pi[t], $modNRC, $stateVarsNoEps],
	$pi[t],
	{},
	TestID -> "[evNoEps] Single pi passes through unchanged"
]

TestCreate[
	$evNoEps[$pi[t] $sg[t], $modNRC, $stateVarsNoEps],
	$pi[t] $sg[t],
	{},
	TestID -> "[evNoEps] Same-time pi*sg passes through unchanged"
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - Future Shock Tests*)


TestCreate[
	$evNoEps[$pi[t] eps["pi"][t + 1], $modNRC, $stateVarsNoEps],
	$pi[t] eps["pi"][1 + t],
	{},
	TestID -> "[evNoEps] Future shock in product is preserved"
]


(* ::Subsection:: *)
(*evNoEpsStateVarsProduct - Non-State Variable Handling*)


TestCreate[
	$evNoEps[$pi[t] foo[t - 1], $modNRC, $stateVarsNoEps],
	$pi[t] foo[t - 1],
	{},
	TestID -> "[evNoEps] Non-state variable foo is preserved in product"
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
	TestID -> "[evNoEps] Irrelevant state variables do not affect result"
]

TestCreate[
	$evNoEps[$pi[t], $modNRC, Append[$stateVarsNoEps, irrelevantVar]],
	$pi[t],
	{},
	TestID -> "[evNoEps] Single pi with irrelevant var passes through"
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
	TestID -> "[evNoEps] Shock symbols maintain correct Shocks context"
]


(* ::Subsection:: *)
(*Time Lag Verification*)


TestCreate[
	With[{result = $evNoEps[$pi[t] $sg[t - 1], $modNRC, $stateVarsNoEps]},
		FreeQ[result, _Symbol?(MatchQ[SymbolName[#], "pi"] &)[t]]
	],
	True,
	{},
	TestID -> "[evNoEps] pi[t] with lagged sg substitutes pi to earlier time"
]

TestCreate[
	With[{result = $evNoEps[$pi[t] $sg[t - 1], $modNRC, $stateVarsNoEps]},
		Not@FreeQ[result, _Symbol?(MatchQ[SymbolName[#], "sg"] &)[t - 1]]
	],
	True,
	{},
	TestID -> "[evNoEps] Lagged sg[t-1] is preserved in result"
]


(* ::Subsection:: *)
(*Wealth-Consumption and Price-Dividend Coefficient Tests*)


TestCreate[
	$evNoEps[$wc[t] eps["pi"][t - 1], $modNRC, $stateVarsNoEps],
	$wc[t] eps["pi"][-1 + t],
	{},
	TestID -> "[evNoEps] wc*eps lagged product is preserved"
]

TestCreate[
	With[{result = $evNoEps[$wc[t] eps["pi"][t], $modNRC, {$wc}]},
		Coefficient[result, $pi[t - 1]] === rhop $A[1] eps["pi"][t]
	],
	True,
	{},
	TestID -> "[evNoEps] wc*eps coefficient of pi[t-1] is correct"
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
	TestID -> "[evNoEps] A coefficient maintains correct Private context"
]

TestCreate[
	$evNoEps[$pd[t, i] eps["pi"][t - 1], $modNRC, $stateVarsNoEps],
	$pd[t, i] eps["pi"][-1 + t],
	{},
	TestID -> "[evNoEps] pd*eps lagged product is preserved"
]


(* ::Subsection:: *)
(*Tests Needing Refactoring*)
(*TODO: The following tests exist in docs/test-files/ComputeUnconditionalExpectations.wlt*)
(*      and need to be refactored to use TestCreate with semantic TestIDs*)


(*
   createSystem Tests (Long Tests - require longTest=True)
   =======================================================
   Original Location: docs/test-files/ComputeUnconditionalExpectations.wlt

   TestID: ComputeUnconditionalExpectations_20260103-OBY80L
   Description: Tests createSystem internal function for orders 1-4
   - Validates nameRules structure and content
   - Validates system equations structure
   - Validates unknowns list
   - Validates solution consistency with system equations

   TestID: ComputeUnconditionalExpectations_20260103-HS5V50
   Description: Validates solved values match analytical formulas
   - pi1 (first moment of pi)
   - sg1 (first moment of sg)
   - pi2 (second moment of pi)
   - sg2 (second moment of sg)
   - pi1sg1 (cross moment)

   TestID: ComputeUnconditionalExpectations_20260103-N1A9JC
   Description: Verifies all solutions evaluate to numbers with NRC parameters
   - All nameRules values should be numeric after parameter substitution


   Extended uncondE Tests (Long Tests)
   ===================================
   Original Location: docs/test-files/ComputeUnconditionalExpectations.wlt

   TestID: ComputeUnconditionalExpectations_20260103-HY9B6Z
   Description: Comprehensive uncondE tests including:

   Wealth-consumption ratio tests:
   - uncondE[wc[t], modNRC] === A[0]
   - uncondE[wc[t], modBY] === A[0]

   Higher moment factorization:
   - uncondE[pi[t]^3 * sg[t], modNRC] factorization property
   - uncondE[pi[t]^3 * sg[t], modNRC] analytical formula verification

   Consumption growth tests:
   - uncondE[dc[t], modNRC] === muc
   - uncondE[dc[t]^2, modNRC] analytical formula
   - uncondE[pi[t] * dc[t], modNRC] analytical formula
   - uncondE[sg[t] * dc[t], modNRC] === muc * Esg

   Autocovariance tests:
   - uncondE[sg[t] * sg[t+1], modNRC] autocovariance formula
   - uncondE[sg[t] * sg[t-1], modNRC] autocovariance formula
   - uncondE[pi[t] * pi[t+1], modNRC] autocovariance formula
   - uncondE[pi[t] * pi[t-1], modNRC] autocovariance formula

   Cross-moment tests:
   - uncondE[pi[t] * sg[t+1], modNRC] cross-moment
   - uncondE[pi[t-1] * dc[t], modNRC] lagged cross-moment


   evNoEpsStateVarsProduct Extended Tests
   ======================================
   Original Location: docs/test-files/ComputeUnconditionalExpectations.wlt

   TestID: ComputeUnconditionalExpectations_20260103-9UJQ9B
   Description: Comprehensive evNoEpsStateVarsProduct tests
   - Commutativity: pi[t] * eps["pi"][t-1] vs eps["pi"][t-1] * pi[t]
   - Single variable passthrough: pi[t]
   - Same-time products: pi[t] * sg[t]
   - Lagged products with substitution: pi[t-1] * sg[t]
   - Shock products with substitution: pi[t] * eps["pi"][t]
   - Future shocks preserved: pi[t] * eps["pi"][t+1]
   - Non-state variable dd handling
   - dd as state variable expansion
   - Additional commutativity checks

   TestID: ComputeUnconditionalExpectations_20260103-KP8SCE
   Description: Shock context verification for complex products with dd variable
   - Verifies eps symbols maintain correct Shocks` context

   TestID: ComputeUnconditionalExpectations_20260103-QVZAKT
   Description: Time lag verification tests
   - pi[t] * sg[t-1] removes pi[t], preserves sg[t-1]
   - Sum expressions pi[t] * sg[t-1] + pi[t-1] * sg[t] substitution behavior

   TestID: ComputeUnconditionalExpectations_20260103-Q9QZME
   Description: Non-state variable preservation
   - pi[t] * foo[t-1] preserves foo
   - Future shock factorization: eps["pi"][t+1] * eps["pi"][t] * pi[t]

   TestID: ComputeUnconditionalExpectations_20260103-OGD12F
   Description: Irrelevant variable handling
   - Adding myVariable or dd doesn't affect result
   - Single pi with irrelevant var
   - anotherIrrelevantVar handling

   TestID: ComputeUnconditionalExpectations_20260103-1LGRKM
   Description: FreeQ tests for dd variable interactions
   - Various combinations of pi, dd, eps at different time indices
   - uncondEStep tests for dc * sg products

   TestID: ComputeUnconditionalExpectations_20260103-7CMLD8
   Description: wc and pd coefficient tests
   - wc[t] * eps["pi"][t-1] product preservation
   - wc[t] * eps["pi"][t] coefficient extraction
   - A coefficient context verification (multiple scenarios)
   - pd[t,i] * eps["pi"][t-1] product preservation
   - pd[t,i] * eps["pi"][t] coefficient extraction
   - B coefficient context verification (multiple scenarios)


   REFACTORING NOTES:
   ==================
   - The createSystem tests require the internal Private` function to be accessible
   - Consider splitting the large bundled tests into individual TestCreate calls
   - Extended uncondE tests cover important autocovariance and cross-moment functionality
   - evNoEpsStateVarsProduct tests should be split by functionality (commutativity, passthrough, context, etc.)
   - Many tests in the original file use Apply[And, {...}] pattern - each assertion should be a separate test

   To run the original tests, execute:
   TestReport @ FileNameJoin[{$PackageDirectory, "docs", "test-files", "ComputeUnconditionalExpectations.wlt"}]
*)


End[]
EndTestSection[]
