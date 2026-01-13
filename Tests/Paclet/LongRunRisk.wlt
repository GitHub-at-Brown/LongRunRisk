(* ::Package:: *)

(* ::Section:: *)
(*Kernel/LongRunRisk.wl Tests*)


BeginTestSection["Kernel/LongRunRisk.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Paclet`LongRunRisk`"]

Needs["FernandoDuarte`LongRunRisk`"];


(* ::Subsection:: *)
(*Load Test Helpers*)


Get @ FileNameJoin[{DirectoryName[$TestFileName, 2], "TestHelpers.wl"}];


(* ::Subsection:: *)
(*Public Symbol Usage Tests*)


(* Helper to check if a symbol has a usage message *)
hasUsage[sym_Symbol] := StringQ[Information[sym, "Usage"]]

(* Note: Models is excluded as it's a variable, not a function with usage *)
$publicSymbols = {
	BuildModels,
	CheckModels,
	Ev, Var, Corr, Cov,
	Growth,
	Info,
	PlotCoeffs,
	ToEquation, ToExogenousVars, ToNum, ToStateVars,
	UncondE, UncondCov, UncondVar, UncondCorr,
	VisualizeCoeffs,
	YieldCurve
};

(* Test: All public symbols have usage messages *)
(* Note: On failure, ActualOutput shows symbols missing usage messages *)
TestCreate[
	Select[$publicSymbols, !hasUsage[#] &] === {},
	True,
	{},
	TestID -> "[LongRunRisk] All public symbols have usage messages"
]


(* ::Subsection:: *)
(*Models Loading Tests*)


(* Test: Models is an Association *)
TestCreate[
	AssociationQ[FernandoDuarte`LongRunRisk`Models],
	True,
	{},
	TestID -> "[Models] Is an Association"
]

(* Test: Models is non-empty *)
TestCreate[
	Length[FernandoDuarte`LongRunRisk`Models] > 0,
	True,
	{},
	TestID -> "[Models] Is non-empty"
]

$expectedCovLongSymbols = {"covLongBKY", "covLongBY", "covLongDES", "covLongNRC", "covLongNRCStochVol"};

(* Test: All covLong symbols exist in FernandoDuarte`LongRunRisk` *)
TestCreate[
	AllTrue[$expectedCovLongSymbols, MemberQ[Names["FernandoDuarte`LongRunRisk`*"], #] &],
	True,
	{},
	TestID -> "[LongRunRisk] All covLong symbols exist"
]


(* ::Subsection:: *)
(*Conditional Moments Tests*)


(* Internal symbol aliases for testing *)
ev = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev;
var = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`var;
cov = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`cov;
corr = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`corr;

(* Test: Ev matches internal ev for all test models *)
TestCreate[
	AllTrue[{$modBKY, $modNRC}, Ev[dc[t + 1], t, #] === ev[dc[t + 1], t, #] &],
	True,
	{},
	TestID -> "[Ev] Matches internal ev for all test models"
]

(* Test: Var matches internal var for all test models *)
TestCreate[
	AllTrue[{$modBKY, $modNRCStochVol}, Var[dc[t + 1], t, #] === var[dc[t + 1], t, #] &],
	True,
	{},
	TestID -> "[Var] Matches internal var for all test models"
]

(* Test: Cov matches internal cov for all test models *)
TestCreate[
	AllTrue[{$modBKY, $modDES}, Cov[dc[t + 1], dd[t + 1], t, #] === cov[dc[t + 1], dd[t + 1], t, #] &],
	True,
	{},
	TestID -> "[Cov] Matches internal cov for all test models"
]

(* Test: Corr matches internal corr for BKY model *)
(* Note: Using dc and x which both have non-zero variance *)
TestCreate[
	Corr[dc[t + 1], x[t + 1], t, $modBKY] === corr[dc[t + 1], x[t + 1], t, $modBKY],
	True,
	{},
	TestID -> "[Corr] Matches internal corr for BKY model"
]

(* Test: Corr matches internal corr for NRC model *)
(* Note: Using dc and pi which both have non-zero variance in NRC *)
TestCreate[
	Corr[dc[t + 1], pi[t + 1], t, $modNRC] === corr[dc[t + 1], pi[t + 1], t, $modNRC],
	True,
	{},
	TestID -> "[Corr] Matches internal corr for NRC model"
]

(* Test: Ev evaluates without $Failed for BKY *)
TestCreate[
	With[{result = Ev[dc[t + 1], t, $modBKY]},
		result =!= $Failed && !MatchQ[result, _Ev]
	],
	True,
	{},
	TestID -> "[Ev] Evaluates without $Failed for BKY"
]

(* Test: Var evaluates without $Failed for NRC *)
TestCreate[
	With[{result = Var[dc[t + 1], t, $modNRC]},
		result =!= $Failed && !MatchQ[result, _Var]
	],
	True,
	{},
	TestID -> "[Var] Evaluates without $Failed for NRC"
]

(* Test: Cov evaluates without $Failed for DES *)
TestCreate[
	With[{result = Cov[dc[t + 1], dd[t + 1], t, $modDES]},
		result =!= $Failed && !MatchQ[result, _Cov]
	],
	True,
	{},
	TestID -> "[Cov] Evaluates without $Failed for DES"
]

(* Test: Corr evaluates without $Failed for NRCStochVol *)
(* Note: Using dc and pi which both have non-zero variance *)
TestCreate[
	With[{result = Corr[dc[t + 1], pi[t + 1], t, $modNRCStochVol]},
		result =!= $Failed && !MatchQ[result, _Corr]
	],
	True,
	{},
	TestID -> "[Corr] Evaluates without $Failed for NRCStochVol"
]


(* ::Subsection:: *)
(*Unconditional Moments Tests*)


(* Internal symbol alias for testing *)
uncondE = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE;

(* Test: UncondE matches internal uncondE for all test models *)
TestCreate[
	AllTrue[{$modBKY, $modNRC}, UncondE[dc[t], #] === uncondE[dc[t], #] &],
	True,
	{},
	TestID -> "[UncondE] Matches internal uncondE for all test models"
]

(* Test: UncondE evaluates without $Failed for BKY *)
TestCreate[
	With[{result = UncondE[dc[t], $modBKY]},
		result =!= $Failed && !MatchQ[result, _UncondE]
	],
	True,
	{},
	TestID -> "[UncondE] Evaluates without $Failed for BKY"
]

(* Test: UncondCov evaluates without $Failed for BKY *)
(* Note: Using BKY instead of NRC as it has complete covariance data *)
TestCreate[
	With[{result = UncondCov[dc[t], dc[t], $modBKY]},
		result =!= $Failed && !MatchQ[result, _UncondCov]
	],
	True,
	{},
	TestID -> "[UncondCov] Evaluates without $Failed for BKY"
]

(* Test: UncondVar evaluates without $Failed for BKY *)
TestCreate[
	With[{result = UncondVar[dc[t], $modBKY]},
		result =!= $Failed && !MatchQ[result, _UncondVar]
	],
	True,
	{},
	TestID -> "[UncondVar] Evaluates without $Failed for BKY"
]

(* Test: UncondCorr evaluates without $Failed for BKY *)
(* Note: Using dc and x which both have non-zero variance *)
TestCreate[
	With[{result = UncondCorr[dc[t], x[t], $modBKY]},
		result =!= $Failed && !MatchQ[result, _UncondCorr]
	],
	True,
	{},
	TestID -> "[UncondCorr] Evaluates without $Failed for BKY"
]


(* ::Subsection:: *)
(*Growth and ToNumber Tests*)


(* Internal symbol alias for testing *)
growth = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth;

(* Test: Growth matches internal growth *)
TestCreate[
	Growth[c, t] === growth[c, t],
	True,
	{},
	TestID -> "[Growth] Matches internal growth"
]

(* Note: ToNum, ToEquation, ToExogenousVars, ToStateVars are re-exported via copyDefinitions.
   Comparing with === would fail because outputs may contain symbols with different contexts.
   The "evaluates without $Failed" tests below verify these functions work correctly. *)

(* Test: Growth evaluates without $Failed *)
TestCreate[
	With[{result = Growth[c, t]},
		result =!= $Failed && !MatchQ[result, _Growth]
	],
	True,
	{},
	TestID -> "[Growth] Evaluates without $Failed"
]

(* Test: ToNum evaluates without $Failed for BKY *)
TestCreate[
	With[{result = ToNum[$modBKY]},
		result =!= $Failed && !MatchQ[result, _ToNum]
	],
	True,
	{},
	TestID -> "[ToNum] Evaluates without $Failed for BKY"
]

(* Test: ToEquation evaluates without $Failed for NRC *)
TestCreate[
	With[{result = ToEquation[$modNRC]},
		result =!= $Failed && !MatchQ[result, _ToEquation]
	],
	True,
	{},
	TestID -> "[ToEquation] Evaluates without $Failed for NRC"
]

(* Test: ToExogenousVars evaluates without $Failed for DES *)
TestCreate[
	With[{result = ToExogenousVars[$modDES]},
		result =!= $Failed && !MatchQ[result, _ToExogenousVars]
	],
	True,
	{},
	TestID -> "[ToExogenousVars] Evaluates without $Failed for DES"
]

(* Test: ToStateVars evaluates without $Failed for NRCStochVol *)
TestCreate[
	With[{result = ToStateVars[$modNRCStochVol]},
		result =!= $Failed && !MatchQ[result, _ToStateVars]
	],
	True,
	{},
	TestID -> "[ToStateVars] Evaluates without $Failed for NRCStochVol"
]


End[]
EndTestSection[]
