(* ::Package:: *)

(* ::Section:: *)
(*Kernel/ComputationalEngine/ComputeConditionalExpectations.wl Tests*)


BeginTestSection["Kernel/ComputationalEngine/ComputeConditionalExpectations.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`"]

(* Needs["FernandoDuarte`LongRunRisk`"]; *)
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];

(* ::Subsection:: *)
(*Load Test Helpers*)


Scan[Get @ FileNameJoin[{DirectoryName[$TestFileName, #], "Common.wl"}] &, {2, 1}];


(* ::Subsection:: *)
(*Test Setup*)

(* Model for testing - NRC model with inflation dynamics *)
$testModel = $models["NRC"];

(* State variable symbols *)
$pi = FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi;
$dc = FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc;
$sg = FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg;
$dd = FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd;

(* Endogenous symbols *)
$A = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A;
$R = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`R;

(* Private function *)
$lagStateVarst = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst;


(* ::Subsection:: *)
(*Context Verification Tests*)


(* Test: Package context is on ContextPath *)
TestCreate[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"],
	True,
	{},
	TestID -> "ComputeConditionalExpectations-Context-OnContextPath"
]

(* Test: Private functions are accessible via full qualification *)
TestCreate[
	Head[$lagStateVarst] === Symbol,
	True,
	{},
	TestID -> "ComputeConditionalExpectations-PrivateFunctions-Accessible"
]


(* ::Subsection:: *)
(*ev - Basic Expectation Tests*)


(* Test: Expectation of shock times inflation equals shock loading parameter *)
TestCreate[
	ev[eps["pi"][t+1] $pi[t+1], t-1, $testModel] === phip,
	True,
	{},
	TestID -> "ev-ShockTimesInflation-EqualsPhip"
]


(* ::Subsection:: *)
(*ev - Product Expectations Tests*)


(* Test: Dividend and inflation product expectation *)
TestCreate[
	Simplify[ev[$dd[t+1,i] $pi[t+1], t, $testModel] -
		((mup + rhop($pi[t]-mup) + xip eps["pi"][t])*(mud[i] + rhodp[i]($pi[t]-mup) + xid[i] $sg[t-1] eps["pi"][t]))] === 0,
	True,
	{},
	TestID -> "ev-DividendInflationProduct-Simplifies"
]

(* Test: Dividend and consumption product expectation *)
TestCreate[
	Simplify[ev[$dd[t+1,i] $dc[t+1], t, $testModel] -
		((mud[i] + rhodp[i]($pi[t]-mup) + xid[i] $sg[t-1] eps["pi"][t])*(muc + rhocp($pi[t]-mup) + xic $sg[t-1] eps["pi"][t]) + phic phidc[i])] === 0,
	True,
	{},
	TestID -> "ev-DividendConsumptionProduct-Simplifies"
]

(* Test: Three-term product: volatility, consumption, and inflation *)
TestCreate[
	Simplify[ev[$sg[t+3] $dc[t+2] $pi[t+1], t, $testModel] -
		((Esg + rhog^3 ($sg[t]-Esg))*((mup + rhop($pi[t]-mup) + xip eps["pi"][t])*(muc + rhocp rhop($pi[t]-mup) + rhocp xip eps["pi"][t]) + rhocp phip^2 + xic phip $sg[t]))] === 0,
	True,
	{},
	TestID -> "ev-VolatilityConsumptionInflation-Simplifies"
]

(* Test: Inflation squared expectation *)
TestCreate[
	Simplify[ev[$pi[t+2] $pi[t+1], t, $testModel] -
		((mup + rhop($pi[t]-mup) + xip eps["pi"][t])*(mup + rhop^2 ($pi[t]-mup) + rhop xip eps["pi"][t]) + rhop phip^2 + xip phip)] === 0,
	True,
	{},
	TestID -> "ev-InflationSquared-Simplifies"
]


(* ::Subsection:: *)
(*ev - Consumption and Inflation Cross-Expectations Tests*)


(* Test: Consumption and inflation at t+1 information *)
TestCreate[
	Simplify[ev[$dc[t+2] $pi[t+1], t+1, $testModel] - $pi[t+1] ev[$dc[t+2], t+1, $testModel]] === 0,
	True,
	{},
	TestID -> "ev-ConsumptionInflation-AtTPlus1Info"
]

(* Test: Consumption and inflation at t information *)
TestCreate[
	Simplify[ev[$dc[t+2] $pi[t+1], t, $testModel] -
		((mup + rhop($pi[t]-mup) + xip eps["pi"][t])*(muc + rhocp rhop($pi[t]-mup) + rhocp xip eps["pi"][t]) + rhocp phip^2 + xic phip $sg[t])] === 0,
	True,
	{},
	TestID -> "ev-ConsumptionInflation-AtTInfo"
]

(* Test: Same-period consumption and inflation *)
TestCreate[
	Simplify[ev[$dc[t+1] $pi[t+1], t, $testModel] -
		(mup + rhop($pi[t]-mup) + xip eps["pi"][t])*(muc + rhocp($pi[t]-mup) + xic $sg[t-1] eps["pi"][t])] === 0,
	True,
	{},
	TestID -> "ev-ConsumptionInflation-SamePeriod"
]

(* Test: Known consumption-inflation at time t *)
TestCreate[
	Simplify[ev[$dc[t] $pi[t], t, $testModel] -
		$pi[t]*(muc + rhocp($pi[t-1]-mup) + xic $sg[t-2] eps["pi"][t-1] + phic eps["dc"][t])] === 0,
	True,
	{},
	TestID -> "ev-ConsumptionInflation-KnownAtT"
]

(* Test: Known consumption-inflation at time t-1 *)
TestCreate[
	Simplify[ev[$dc[t-1] $pi[t-1], t, $testModel] -
		$pi[t-1]*(muc + rhocp($pi[t-2]-mup) + xic $sg[t-3] eps["pi"][t-2] + phic eps["dc"][t-1])] === 0,
	True,
	{},
	TestID -> "ev-ConsumptionInflation-KnownAtTMinus1"
]


(* ::Subsection:: *)
(*ev - Volatility State Variable Tests*)


(* Test: Volatility products at various lags - recursive form *)
TestCreate[
	Simplify[ev[$sg[t+2] $sg[t+1]^2, t, $testModel] -
		((1-rhog) Esg ev[$sg[t+1]^2, t, $testModel] + rhog ev[$sg[t+1]^3, t, $testModel])] === 0,
	True,
	{},
	TestID -> "ev-VolatilityProduct-RecursiveForm"
]

(* Test: Volatility products - expanded form *)
TestCreate[
	Simplify[ev[$sg[t+2] $sg[t+1]^2, t, $testModel] -
		((1-rhog) Esg ((Esg + rhog($sg[t]-Esg))^2 + phig^2) + rhog((Esg + rhog($sg[t]-Esg))^3 + 3 phig^2 (Esg + rhog($sg[t]-Esg))))] === 0,
	True,
	{},
	TestID -> "ev-VolatilityProduct-ExpandedForm"
]

(* Test: Volatility cross-products t+2 and t+1 *)
TestCreate[
	Simplify[ev[$sg[t+2] $sg[t+1], t, $testModel] -
		((Esg + rhog^2 ($sg[t]-Esg))*(Esg + rhog($sg[t]-Esg)) + rhog phig^2)] === 0,
	True,
	{},
	TestID -> "ev-VolatilityCross-TPlus2TPlus1"
]

(* Test: Volatility cross-products t+3 and t+1 *)
TestCreate[
	Simplify[ev[$sg[t+3] $sg[t+1], t, $testModel] -
		((Esg + rhog^3 ($sg[t]-Esg))*(Esg + rhog($sg[t]-Esg)) + rhog^2 phig^2)] === 0,
	True,
	{},
	TestID -> "ev-VolatilityCross-TPlus3TPlus1"
]

(* Test: Volatility and inflation product *)
TestCreate[
	Simplify[ev[$sg[t+1] $pi[t+1], t, $testModel] -
		((Esg + rhog($sg[t]-Esg))*(mup + rhop($pi[t]-mup) + xip eps["pi"][t]))] === 0,
	True,
	{},
	TestID -> "ev-VolatilityInflation-Product"
]

(* Test: Known volatility-inflation at t *)
TestCreate[
	Simplify[ev[$sg[t] $pi[t], t, $testModel] - $sg[t] $pi[t]] === 0,
	True,
	{},
	TestID -> "ev-VolatilityInflation-KnownAtT"
]

(* Test: Known volatility-inflation at t-1 *)
TestCreate[
	Simplify[ev[$sg[t-1] $pi[t-1], t, $testModel] - $sg[t-1] $pi[t-1]] === 0,
	True,
	{},
	TestID -> "ev-VolatilityInflation-KnownAtTMinus1"
]


(* ::Subsection:: *)
(*ev - Volatility Squared Expectations Tests*)


(* Test: Volatility squared at t+1 given t *)
TestCreate[
	Simplify[ev[$sg[t+1]^2, t, $testModel] - ((Esg + rhog($sg[t]-Esg))^2 + phig^2)] === 0,
	True,
	{},
	TestID -> "ev-VolatilitySquared-TPlus1GivenT"
]

(* Test: Volatility squared at t given t (known) *)
TestCreate[
	Simplify[ev[$sg[t]^2, t, $testModel] - $sg[t]^2] === 0,
	True,
	{},
	TestID -> "ev-VolatilitySquared-Known"
]

(* Test: Volatility squared at t+1 given t-1 *)
TestCreate[
	Simplify[ev[$sg[t+1]^2, t-1, $testModel] - ((Esg + rhog^2 ($sg[t-1]-Esg))^2 + (rhog^2+1) phig^2)] === 0,
	True,
	{},
	TestID -> "ev-VolatilitySquared-TPlus1GivenTMinus1"
]

(* Test: Volatility squared at t+1 given t-2 *)
TestCreate[
	Simplify[ev[$sg[t+1]^2, t-2, $testModel] - ((Esg + rhog^3 ($sg[t-2]-Esg))^2 + (rhog^4+rhog^2+1) phig^2)] === 0,
	True,
	{},
	TestID -> "ev-VolatilitySquared-TPlus1GivenTMinus2"
]


(* ::Subsection:: *)
(*ev - First Moment Expectations Tests*)


(* Test: Volatility first moment at t+1 given t *)
TestCreate[
	Simplify[ev[$sg[t+1], t, $testModel] - (Esg + rhog($sg[t]-Esg))] === 0,
	True,
	{},
	TestID -> "ev-VolatilityFirst-TPlus1GivenT"
]

(* Test: Volatility first moment at t (known) *)
TestCreate[
	Simplify[ev[$sg[t], t, $testModel] - $sg[t]] === 0,
	True,
	{},
	TestID -> "ev-VolatilityFirst-Known"
]

(* Test: Volatility first moment at t+1 given t-1 *)
TestCreate[
	Simplify[ev[$sg[t+1], t-1, $testModel] - (Esg + rhog^2 ($sg[t-1]-Esg))] === 0,
	True,
	{},
	TestID -> "ev-VolatilityFirst-TPlus1GivenTMinus1"
]

(* Test: Consumption first moment at t+1 given t-1 *)
TestCreate[
	Simplify[ev[$dc[t+1], t-1, $testModel] - (muc + rhocp rhop($pi[t-1]-mup) + rhocp xip eps["pi"][t-1])] === 0,
	True,
	{},
	TestID -> "ev-ConsumptionFirst-TPlus1GivenTMinus1"
]

(* Test: Consumption first moment at t given t-1 *)
TestCreate[
	Simplify[ev[$dc[t], t-1, $testModel] - (muc + rhocp($pi[t-1]-mup) + xic $sg[t-2] eps["pi"][t-1])] === 0,
	True,
	{},
	TestID -> "ev-ConsumptionFirst-TGivenTMinus1"
]


(* ::Subsection:: *)
(*ev - Shock-Inflation Expectations Tests*)


(* Test: Future shock times future inflation (independent) *)
TestCreate[
	Simplify[ev[eps["pi"][t+2] $pi[t+1], t-1, $testModel]] === 0,
	True,
	{},
	TestID -> "ev-ShockInflation-FutureIndependent"
]

(* Test: Current shock times future inflation *)
TestCreate[
	Simplify[ev[eps["pi"][t+1] $pi[t+1], t-1, $testModel] - phip] === 0,
	True,
	{},
	TestID -> "ev-ShockInflation-CurrentShock"
]

(* Test: Past shock times future inflation *)
TestCreate[
	Simplify[ev[eps["pi"][t] $pi[t+1], t-1, $testModel] - (rhop phip + xip)] === 0,
	True,
	{},
	TestID -> "ev-ShockInflation-PastShock"
]

(* Test: Known shock times future inflation *)
TestCreate[
	Simplify[ev[eps["pi"][t-1] $pi[t+1], t-1, $testModel] -
		((mup + rhop^2 ($pi[t-1]-mup) + rhop xip eps["pi"][t-1]) eps["pi"][t-1])] === 0,
	True,
	{},
	TestID -> "ev-ShockInflation-KnownShock"
]


(* ::Subsection:: *)
(*ev - Inflation at Different Information Sets Tests*)


(* Test: Inflation at t+2 given t+2 (known) *)
TestCreate[
	Simplify[ev[$pi[t+2], t+2, $testModel] - $pi[t+2]] === 0,
	True,
	{},
	TestID -> "ev-Inflation-TPlus2Known"
]

(* Test: Inflation at t+2 given t+1 *)
TestCreate[
	Simplify[ev[$pi[t+2], t+1, $testModel] - (mup + rhop($pi[t+1]-mup) + xip eps["pi"][t+1])] === 0,
	True,
	{},
	TestID -> "ev-Inflation-TPlus2GivenTPlus1"
]

(* Test: Inflation at t+2 given t *)
TestCreate[
	Simplify[ev[$pi[t+2], t, $testModel] - (mup + rhop^2 ($pi[t]-mup) + rhop xip eps["pi"][t])] === 0,
	True,
	{},
	TestID -> "ev-Inflation-TPlus2GivenT"
]

(* Test: Inflation at t+2 given t-1 *)
TestCreate[
	Simplify[ev[$pi[t+2], t-1, $testModel] - (mup + rhop^3 ($pi[t-1]-mup) + rhop^2 xip eps["pi"][t-1])] === 0,
	True,
	{},
	TestID -> "ev-Inflation-TPlus2GivenTMinus1"
]

(* Test: Inflation at t+2 given t-2 *)
TestCreate[
	Simplify[ev[$pi[t+2], t-2, $testModel] - (mup + rhop^4 ($pi[t-2]-mup) + rhop^3 xip eps["pi"][t-2])] === 0,
	True,
	{},
	TestID -> "ev-Inflation-TPlus2GivenTMinus2"
]


(* ::Subsection:: *)
(*ev - Second Moment Expectations Tests*)


(* Test: Inflation squared second moment *)
TestCreate[
	Simplify[ev[$pi[t+1]^2, t, $testModel] - ((mup + rhop($pi[t]-mup) + xip eps["pi"][t])^2 + phip^2)] === 0,
	True,
	{},
	TestID -> "ev-SecondMoment-InflationSquared"
]

(* Test: Consumption squared second moment *)
TestCreate[
	Simplify[ev[$dc[t+1]^2, t, $testModel] - ((muc + rhocp($pi[t]-mup) + xic $sg[t-1] eps["pi"][t])^2 + phic^2)] === 0,
	True,
	{},
	TestID -> "ev-SecondMoment-ConsumptionSquared"
]

(* Test: Volatility squared second moment *)
TestCreate[
	Simplify[ev[$sg[t+1]^2, t, $testModel] - ((Esg + rhog($sg[t]-Esg))^2 + phig^2)] === 0,
	True,
	{},
	TestID -> "ev-SecondMoment-VolatilitySquared"
]

(* Test: Dividend squared second moment *)
TestCreate[
	Simplify[ev[$dd[t+1,i]^2, t, $testModel] - ((mud[i] + rhodp[i]($pi[t]-mup) + xid[i] $sg[t-1] eps["pi"][t])^2 + phidc[i]^2)] === 0,
	True,
	{},
	TestID -> "ev-SecondMoment-DividendSquared"
]


(* ::Subsection:: *)
(*var - Conditional Variance Tests*)


(* Test: Inflation variance *)
TestCreate[
	Simplify[var[$pi[t+1], t, $testModel] - phip^2] === 0,
	True,
	{},
	TestID -> "var-Inflation-EqualsPhipSquared"
]

(* Test: Consumption variance *)
TestCreate[
	Simplify[var[$dc[t+1], t, $testModel] - phic^2] === 0,
	True,
	{},
	TestID -> "var-Consumption-EqualsPhicSquared"
]

(* Test: Volatility variance *)
TestCreate[
	Simplify[var[$sg[t+1], t, $testModel] - phig^2] === 0,
	True,
	{},
	TestID -> "var-Volatility-EqualsPhigSquared"
]

(* Test: Dividend variance *)
TestCreate[
	Simplify[var[$dd[t+1,i], t, $testModel] - phidc[i]^2] === 0,
	True,
	{},
	TestID -> "var-Dividend-EqualsPhidcSquared"
]


(* ::Subsection:: *)
(*ev - Law of Iterated Expectations Tests*)


(* Test: LIE for inflation *)
TestCreate[
	Simplify[ev[$pi[t+1], t-1, $testModel] - ev[ev[$pi[t+1], t, $testModel], t-1, $testModel]] === 0,
	True,
	{},
	TestID -> "ev-LIE-Inflation"
]

(* Test: LIE for consumption *)
TestCreate[
	Simplify[ev[$dc[t+1], t-1, $testModel] - ev[ev[$dc[t+1], t, $testModel], t-1, $testModel]] === 0,
	True,
	{},
	TestID -> "ev-LIE-Consumption"
]

(* Test: LIE for volatility *)
TestCreate[
	Simplify[ev[$sg[t+1], t-1, $testModel] - ev[ev[$sg[t+1], t, $testModel], t-1, $testModel]] === 0,
	True,
	{},
	TestID -> "ev-LIE-Volatility"
]

(* Test: LIE for dividend *)
TestCreate[
	Simplify[ev[$dd[t+1,i], t-1, $testModel] - ev[ev[$dd[t+1,i], t, $testModel], t-1, $testModel]] === 0,
	True,
	{},
	TestID -> "ev-LIE-Dividend"
]

(* Test: LIE for inflation-consumption product *)
TestCreate[
	Simplify[ev[$pi[t+1] $dc[t+1], t-1, $testModel] - ev[ev[$pi[t+1] $dc[t+1], t, $testModel], t-1, $testModel]] === 0,
	True,
	{},
	TestID -> "ev-LIE-InflationConsumptionProduct"
]

(* Test: LIE for consumption-volatility product *)
TestCreate[
	Simplify[ev[$dc[t+1] $sg[t+1], t-1, $testModel] - ev[ev[$dc[t+1] $sg[t+1], t, $testModel], t-1, $testModel]] === 0,
	True,
	{},
	TestID -> "ev-LIE-ConsumptionVolatilityProduct"
]

(* Test: LIE for volatility squared *)
TestCreate[
	Simplify[ev[$sg[t+1]^2, t-1, $testModel] - ev[ev[$sg[t+1]^2, t, $testModel], t-1, $testModel]] === 0,
	True,
	{},
	TestID -> "ev-LIE-VolatilitySquared"
]

(* Test: LIE for dividend t+2 *)
TestCreate[
	Simplify[ev[$dd[t+2,i], t-1, $testModel] - ev[ev[$dd[t+2,i], t, $testModel], t-1, $testModel]] === 0,
	True,
	{},
	TestID -> "ev-LIE-DividendTPlus2"
]


(* ::Subsection:: *)
(*ev - Martingale Property Tests*)


(* Test: State variable times future shock - inflation *)
TestCreate[
	ev[$pi[t] eps["pi"][t+1], t-1, $testModel] === 0 && ev[ev[$pi[t] eps["pi"][t+1], t, $testModel], t-1, $testModel] === 0,
	True,
	{},
	TestID -> "ev-Martingale-InflationTimesShock"
]

(* Test: State variable times future shock - consumption shock *)
TestCreate[
	ev[$pi[t] eps["dc"][t+1], t-1, $testModel] === 0 && ev[ev[$pi[t] eps["dc"][t+1], t, $testModel], t-1, $testModel] === 0,
	True,
	{},
	TestID -> "ev-Martingale-InflationTimesConsumptionShock"
]

(* Test: State variable times future shock - volatility *)
TestCreate[
	ev[$sg[t] eps["pi"][t+1], t-1, $testModel] === 0 && ev[ev[$sg[t] eps["pi"][t+1], t, $testModel], t-1, $testModel] === 0,
	True,
	{},
	TestID -> "ev-Martingale-VolatilityTimesShock"
]

(* Test: Martingale property for shock squared - inflation *)
TestCreate[
	ev[$pi[t], t-1, $testModel] === ev[$pi[t] eps["pi"][t+1]^2, t-1, $testModel],
	True,
	{},
	TestID -> "ev-Martingale-InflationShockSquared"
]

(* Test: Martingale property for shock squared - volatility *)
TestCreate[
	ev[$sg[t], t-1, $testModel] === ev[$sg[t] eps["pi"][t+1]^2, t-1, $testModel],
	True,
	{},
	TestID -> "ev-Martingale-VolatilityShockSquared"
]

(* Test: Martingale property for shock squared - consumption *)
TestCreate[
	ev[$dc[t], t-1, $testModel] === ev[$dc[t] eps["pi"][t+1]^2, t-1, $testModel],
	True,
	{},
	TestID -> "ev-Martingale-ConsumptionShockSquared"
]

(* Test: Martingale property for shock squared - dividend *)
TestCreate[
	ev[$dd[t,i], t-1, $testModel] === ev[$dd[t,i] eps["pi"][t+1]^2, t-1, $testModel],
	True,
	{},
	TestID -> "ev-Martingale-DividendShockSquared"
]


(* ::Subsection:: *)
(*ev - Context Handling Tests*)


(* Test: Variable context invariance *)
TestCreate[
	Module[{result1, result2, result3},
		result1 = ev[$pi[t+1], t, $testModel];
		result2 = ev[foo`pi[t+1], t, $testModel];
		result3 = (ev[foo`pi[foo`t+1], foo`t, $testModel] /. foo`t -> t);
		result1 === result2 === result3
	],
	True,
	{},
	TestID -> "ev-Context-VariableInvariance"
]

(* Test: Time index context sensitivity *)
TestCreate[
	ev[$pi[foo`t+1], t, $testModel] === FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1+foo`t],
	True,
	{},
	TestID -> "ev-Context-TimeIndexSensitivity"
]


(* ::Subsection:: *)
(*lagStateVarst - Basic Functionality Tests*)


(* Test: Basic expansion of pi[t] conditioning on t-1 *)
TestCreate[
	$lagStateVarst[$pi[t], t-1, $testModel] === (
		mup +
		rhop (-mup + $pi[-1+t]) +
		xip eps["pi"][-1+t] +
		phip eps["pi"][t]
	),
	True,
	{},
	TestID -> "lagStateVarst-BasicExpansion-InflationTMinus1"
]

(* Test: Time-shift consistency *)
TestCreate[
	$lagStateVarst[$pi[t+1], t, $testModel] === ($lagStateVarst[$pi[t], t-1, $testModel] /. t -> t+1),
	True,
	{},
	TestID -> "lagStateVarst-TimeShift-Consistency"
]

(* Test: Product expressions with shocks *)
TestCreate[
	$lagStateVarst[$pi[t] eps["pi"][t+2], t, $testModel] === $pi[t] eps["pi"][2+t],
	True,
	{},
	TestID -> "lagStateVarst-ProductWithShock-Preserved"
]


(* ::Subsection:: *)
(*lagStateVarst - Parameter Handling Tests*)


(* Test: Parameters remain unchanged - delta *)
TestCreate[
	$lagStateVarst[delta, t-1, $testModel] === delta,
	True,
	{},
	TestID -> "lagStateVarst-Parameter-DeltaUnchanged"
]

(* Test: Parameters remain unchanged - A[0] *)
TestCreate[
	$lagStateVarst[$A[0], t-1, $testModel] === $A[0],
	True,
	{},
	TestID -> "lagStateVarst-Parameter-A0Unchanged"
]

(* Test: Parameters remain unchanged - R[-1+m][0] *)
TestCreate[
	$lagStateVarst[$R[-1+m][0], t-1, $testModel] === $R[-1+m][0],
	True,
	{},
	TestID -> "lagStateVarst-Parameter-RUnchanged"
]


(* ::Subsection:: *)
(*lagStateVarst - Equilibrium Variable Tests*)


(* Test: Does not evaluate with pieq *)
TestCreate[
	$lagStateVarst[pieq[t,m], t+1, $testModel] === pieq[t,m],
	True,
	{},
	TestID -> "lagStateVarst-Equilibrium-PieqUnchanged"
]

(* Test: Does not evaluate with wceq *)
TestCreate[
	$lagStateVarst[wceq[t], t+1, $testModel] === wceq[t],
	True,
	{},
	TestID -> "lagStateVarst-Equilibrium-WceqUnchanged"
]


(* ::Subsection:: *)
(*lagStateVarst - Listable Property Tests*)


(* Test: Listable property for state variables *)
TestCreate[
	$lagStateVarst[{$pi[t], $sg[t], $dc[t]}, t-1, $testModel] ===
		{$lagStateVarst[$pi[t], t-1, $testModel], $lagStateVarst[$sg[t], t-1, $testModel], $lagStateVarst[$dc[t], t-1, $testModel]},
	True,
	{},
	TestID -> "lagStateVarst-Listable-StateVariables"
]


(* ::Subsection:: *)
(*lagStateVarst - Context Handling Tests*)


(* Test: Context handling - foo`pi equals pi *)
TestCreate[
	$lagStateVarst[foo`pi[t], t-1, $testModel] === $lagStateVarst[$pi[t], t-1, $testModel],
	True,
	{},
	TestID -> "lagStateVarst-Context-FooPiEqualsPi"
]

(* Test: Context handling - products with different contexts *)
TestCreate[
	$lagStateVarst[foo`pi[t] $pi[t], t-1, $testModel] === $lagStateVarst[foo`pi[t]^2, t-1, $testModel] === $lagStateVarst[$pi[t]^2, t-1, $testModel],
	True,
	{},
	TestID -> "lagStateVarst-Context-ProductEquivalence"
]

(* Test: Context handling - mixed context products *)
TestCreate[
	$lagStateVarst[foo`pi[t] eps["pi"][t] bar`delta, t-1, $testModel] === $lagStateVarst[$pi[t] foo`eps["pi"][t] delta, t-1, $testModel],
	True,
	{},
	TestID -> "lagStateVarst-Context-MixedProducts"
]

(* Test: Context handling for conditional time *)
TestCreate[
	$lagStateVarst[$pi[foo`t], t-1, $testModel] === $pi[foo`t],
	True,
	{},
	TestID -> "lagStateVarst-Context-ConditionalTimeIndexed"
]

(* Test: Context handling - time substitution equivalence *)
TestCreate[
	$lagStateVarst[$pi[t], t-1, $testModel] === ($lagStateVarst[$pi[foo`t], foo`t-1, $testModel] /. foo`t -> t),
	True,
	{},
	TestID -> "lagStateVarst-Context-TimeSubstitutionEquivalence"
]


End[]
EndTestSection[]
