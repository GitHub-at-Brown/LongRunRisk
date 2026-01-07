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


Get @ FileNameJoin[{DirectoryName[$TestFileName, 2], "TestHelpers.wl"}];
Get @ FileNameJoin[{DirectoryName[$TestFileName, 1], "CETestHelpers.wl"}];


(* ::Subsection:: *)
(*Test Setup*)

(* Model for testing - NRC model with inflation dynamics *)
$testModel = $modNRC;


(* ::Subsection:: *)
(*Context Verification Tests*)


(* Test: Package context is on ContextPath *)
TestCreate[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"],
	True,
	{},
	TestID -> "[ev] Package context is on ContextPath"
]

(* Test: Private functions are accessible via full qualification *)
TestCreate[
	Head[$lagStateVarst] === Symbol,
	True,
	{},
	TestID -> "[lagStateVarst] Private function is accessible via symbol"
]


(* ::Subsection:: *)
(*ev - Basic Expectation Tests*)


(* Test: Expectation of shock times inflation equals shock loading parameter *)
TestCreate[
	ev[eps["pi"][t+1] $pi[t+1], t-1, $testModel] === phip,
	True,
	{},
	TestID -> "[ev] Shock times inflation at t+1 given t-1 equals phip"
]


(* ::Subsection:: *)
(*ev - Product Expectations Tests*)


(* Test: Dividend and inflation product expectation *)
TestCreate[
	simplifiesZeroQ[ev[$dd[t+1,i] $pi[t+1], t, $testModel] -
		((mup + rhop($pi[t]-mup) + xip eps["pi"][t])*(mud[i] + rhodp[i]($pi[t]-mup) + xid[i] $sg[t-1] eps["pi"][t]))],
	True,
	{},
	TestID -> "[ev] Dividend-inflation product simplifies correctly"
]

(* Test: Dividend and consumption product expectation *)
TestCreate[
	simplifiesZeroQ[ev[$dd[t+1,i] $dc[t+1], t, $testModel] -
		((mud[i] + rhodp[i]($pi[t]-mup) + xid[i] $sg[t-1] eps["pi"][t])*(muc + rhocp($pi[t]-mup) + xic $sg[t-1] eps["pi"][t]) + phic phidc[i])],
	True,
	{},
	TestID -> "[ev] Dividend-consumption product simplifies correctly"
]

(* Test: Three-term product: volatility, consumption, and inflation *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+3] $dc[t+2] $pi[t+1], t, $testModel] -
		((Esg + rhog^3 ($sg[t]-Esg))*((mup + rhop($pi[t]-mup) + xip eps["pi"][t])*(muc + rhocp rhop($pi[t]-mup) + rhocp xip eps["pi"][t]) + rhocp phip^2 + xic phip $sg[t]))],
	True,
	{},
	TestID -> "[ev] Volatility-consumption-inflation triple product simplifies"
]

(* Test: Inflation squared expectation *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+2] $pi[t+1], t, $testModel] -
		((mup + rhop($pi[t]-mup) + xip eps["pi"][t])*(mup + rhop^2 ($pi[t]-mup) + rhop xip eps["pi"][t]) + rhop phip^2 + xip phip)],
	True,
	{},
	TestID -> "[ev] Inflation squared product simplifies correctly"
]


(* ::Subsection:: *)
(*ev - Consumption and Inflation Cross-Expectations Tests*)


(* Test: Consumption and inflation at t+1 information *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t+2] $pi[t+1], t+1, $testModel] - $pi[t+1] ev[$dc[t+2], t+1, $testModel]],
	True,
	{},
	TestID -> "[ev] Consumption-inflation factors with t+1 information"
]

(* Test: Consumption and inflation at t information *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t+2] $pi[t+1], t, $testModel] -
		((mup + rhop($pi[t]-mup) + xip eps["pi"][t])*(muc + rhocp rhop($pi[t]-mup) + rhocp xip eps["pi"][t]) + rhocp phip^2 + xic phip $sg[t])],
	True,
	{},
	TestID -> "[ev] Consumption-inflation simplifies given t information"
]

(* Test: Same-period consumption and inflation *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t+1] $pi[t+1], t, $testModel] -
		(mup + rhop($pi[t]-mup) + xip eps["pi"][t])*(muc + rhocp($pi[t]-mup) + xic $sg[t-1] eps["pi"][t])],
	True,
	{},
	TestID -> "[ev] Same-period consumption-inflation simplifies correctly"
]

(* Test: Known consumption-inflation at time t *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t] $pi[t], t, $testModel] -
		$pi[t]*(muc + rhocp($pi[t-1]-mup) + xic $sg[t-2] eps["pi"][t-1] + phic eps["dc"][t])],
	True,
	{},
	TestID -> "[ev] Known consumption-inflation at t equals product"
]

(* Test: Known consumption-inflation at time t-1 *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t-1] $pi[t-1], t, $testModel] -
		$pi[t-1]*(muc + rhocp($pi[t-2]-mup) + xic $sg[t-3] eps["pi"][t-2] + phic eps["dc"][t-1])],
	True,
	{},
	TestID -> "[ev] Known consumption-inflation at t-1 equals product"
]


(* ::Subsection:: *)
(*ev - Volatility State Variable Tests*)


(* Test: Volatility products at various lags - recursive form *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+2] $sg[t+1]^2, t, $testModel] -
		((1-rhog) Esg ev[$sg[t+1]^2, t, $testModel] + rhog ev[$sg[t+1]^3, t, $testModel])],
	True,
	{},
	TestID -> "[ev] Volatility product satisfies recursive form"
]

(* Test: Volatility products - expanded form *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+2] $sg[t+1]^2, t, $testModel] -
		((1-rhog) Esg ((Esg + rhog($sg[t]-Esg))^2 + phig^2) + rhog((Esg + rhog($sg[t]-Esg))^3 + 3 phig^2 (Esg + rhog($sg[t]-Esg))))],
	True,
	{},
	TestID -> "[ev] Volatility product satisfies expanded form"
]

(* Test: Volatility cross-products t+2 and t+1 *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+2] $sg[t+1], t, $testModel] -
		((Esg + rhog^2 ($sg[t]-Esg))*(Esg + rhog($sg[t]-Esg)) + rhog phig^2)],
	True,
	{},
	TestID -> "[ev] Volatility cross-product at t+2 and t+1 simplifies"
]

(* Test: Volatility cross-products t+3 and t+1 *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+3] $sg[t+1], t, $testModel] -
		((Esg + rhog^3 ($sg[t]-Esg))*(Esg + rhog($sg[t]-Esg)) + rhog^2 phig^2)],
	True,
	{},
	TestID -> "[ev] Volatility cross-product at t+3 and t+1 simplifies"
]

(* Test: Volatility and inflation product *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1] $pi[t+1], t, $testModel] -
		((Esg + rhog($sg[t]-Esg))*(mup + rhop($pi[t]-mup) + xip eps["pi"][t]))],
	True,
	{},
	TestID -> "[ev] Volatility-inflation product simplifies correctly"
]

(* Test: Known volatility-inflation at t *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t] $pi[t], t, $testModel] - $sg[t] $pi[t]],
	True,
	{},
	TestID -> "[ev] Known volatility-inflation at t equals product"
]

(* Test: Known volatility-inflation at t-1 *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t-1] $pi[t-1], t, $testModel] - $sg[t-1] $pi[t-1]],
	True,
	{},
	TestID -> "[ev] Known volatility-inflation at t-1 equals product"
]


(* ::Subsection:: *)
(*ev - Volatility Squared Expectations Tests*)


(* Test: Volatility squared at t+1 given t *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1]^2, t, $testModel] - ((Esg + rhog($sg[t]-Esg))^2 + phig^2)],
	True,
	{},
	TestID -> "[ev] Volatility squared at t+1 given t simplifies"
]

(* Test: Volatility squared at t given t (known) *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t]^2, t, $testModel] - $sg[t]^2],
	True,
	{},
	TestID -> "[ev] Known volatility squared equals value squared"
]

(* Test: Volatility squared at t+1 given t-1 *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1]^2, t-1, $testModel] - ((Esg + rhog^2 ($sg[t-1]-Esg))^2 + (rhog^2+1) phig^2)],
	True,
	{},
	TestID -> "[ev] Volatility squared at t+1 given t-1 simplifies"
]

(* Test: Volatility squared at t+1 given t-2 *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1]^2, t-2, $testModel] - ((Esg + rhog^3 ($sg[t-2]-Esg))^2 + (rhog^4+rhog^2+1) phig^2)],
	True,
	{},
	TestID -> "[ev] Volatility squared at t+1 given t-2 simplifies"
]


(* ::Subsection:: *)
(*ev - First Moment Expectations Tests*)


(* Test: Volatility first moment at t+1 given t *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1], t, $testModel] - (Esg + rhog($sg[t]-Esg))],
	True,
	{},
	TestID -> "[ev] Volatility at t+1 given t uses AR(1) formula"
]

(* Test: Volatility first moment at t (known) *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t], t, $testModel] - $sg[t]],
	True,
	{},
	TestID -> "[ev] Known volatility at t equals value"
]

(* Test: Volatility first moment at t+1 given t-1 *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1], t-1, $testModel] - (Esg + rhog^2 ($sg[t-1]-Esg))],
	True,
	{},
	TestID -> "[ev] Volatility at t+1 given t-1 uses two-step AR(1)"
]

(* Test: Consumption first moment at t+1 given t-1 *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t+1], t-1, $testModel] - (muc + rhocp rhop($pi[t-1]-mup) + rhocp xip eps["pi"][t-1])],
	True,
	{},
	TestID -> "[ev] Consumption at t+1 given t-1 simplifies correctly"
]

(* Test: Consumption first moment at t given t-1 *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t], t-1, $testModel] - (muc + rhocp($pi[t-1]-mup) + xic $sg[t-2] eps["pi"][t-1])],
	True,
	{},
	TestID -> "[ev] Consumption at t given t-1 simplifies correctly"
]


(* ::Subsection:: *)
(*ev - Shock-Inflation Expectations Tests*)


(* Test: Future shock times future inflation (independent) *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t+2] $pi[t+1], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] Future shock times past inflation equals zero"
]

(* Test: Current shock times future inflation *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t+1] $pi[t+1], t-1, $testModel] - phip],
	True,
	{},
	TestID -> "[ev] Current shock times same inflation equals phip"
]

(* Test: Past shock times future inflation *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t+1], t-1, $testModel] - (rhop phip + xip)],
	True,
	{},
	TestID -> "[ev] Past shock times future inflation gives loading"
]

(* Test: Known shock times future inflation *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t-1] $pi[t+1], t-1, $testModel] -
		((mup + rhop^2 ($pi[t-1]-mup) + rhop xip eps["pi"][t-1]) eps["pi"][t-1])],
	True,
	{},
	TestID -> "[ev] Known shock times future inflation factors out"
]


(* ::Subsection:: *)
(*ev - Inflation at Different Information Sets Tests*)


(* Test: Inflation at t+2 given t+2 (known) *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+2], t+2, $testModel] - $pi[t+2]],
	True,
	{},
	TestID -> "[ev] Known inflation at t+2 equals value"
]

(* Test: Inflation at t+2 given t+1 *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+2], t+1, $testModel] - (mup + rhop($pi[t+1]-mup) + xip eps["pi"][t+1])],
	True,
	{},
	TestID -> "[ev] Inflation at t+2 given t+1 uses AR(1) formula"
]

(* Test: Inflation at t+2 given t *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+2], t, $testModel] - (mup + rhop^2 ($pi[t]-mup) + rhop xip eps["pi"][t])],
	True,
	{},
	TestID -> "[ev] Inflation at t+2 given t uses two-step AR(1)"
]

(* Test: Inflation at t+2 given t-1 *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+2], t-1, $testModel] - (mup + rhop^3 ($pi[t-1]-mup) + rhop^2 xip eps["pi"][t-1])],
	True,
	{},
	TestID -> "[ev] Inflation at t+2 given t-1 uses three-step AR(1)"
]

(* Test: Inflation at t+2 given t-2 *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+2], t-2, $testModel] - (mup + rhop^4 ($pi[t-2]-mup) + rhop^3 xip eps["pi"][t-2])],
	True,
	{},
	TestID -> "[ev] Inflation at t+2 given t-2 uses four-step AR(1)"
]


(* ::Subsection:: *)
(*ev - Second Moment Expectations Tests*)


(* Test: Inflation squared second moment *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+1]^2, t, $testModel] - ((mup + rhop($pi[t]-mup) + xip eps["pi"][t])^2 + phip^2)],
	True,
	{},
	TestID -> "[ev] Inflation squared second moment includes phip^2"
]

(* Test: Consumption squared second moment *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t+1]^2, t, $testModel] - ((muc + rhocp($pi[t]-mup) + xic $sg[t-1] eps["pi"][t])^2 + phic^2)],
	True,
	{},
	TestID -> "[ev] Consumption squared second moment includes phic^2"
]

(* Test: Volatility squared second moment *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1]^2, t, $testModel] - ((Esg + rhog($sg[t]-Esg))^2 + phig^2)],
	True,
	{},
	TestID -> "[ev] Volatility squared second moment includes phig^2"
]

(* Test: Dividend squared second moment *)
TestCreate[
	simplifiesZeroQ[ev[$dd[t+1,i]^2, t, $testModel] - ((mud[i] + rhodp[i]($pi[t]-mup) + xid[i] $sg[t-1] eps["pi"][t])^2 + phidc[i]^2)],
	True,
	{},
	TestID -> "[ev] Dividend squared second moment includes phidc^2"
]


(* ::Subsection:: *)
(*var - Conditional Variance Tests*)


(* Test: Inflation variance *)
TestCreate[
	simplifiesZeroQ[var[$pi[t+1], t, $testModel] - phip^2],
	True,
	{},
	TestID -> "[var] Inflation variance equals phip squared"
]

(* Test: Consumption variance *)
TestCreate[
	simplifiesZeroQ[var[$dc[t+1], t, $testModel] - phic^2],
	True,
	{},
	TestID -> "[var] Consumption variance equals phic squared"
]

(* Test: Volatility variance *)
TestCreate[
	simplifiesZeroQ[var[$sg[t+1], t, $testModel] - phig^2],
	True,
	{},
	TestID -> "[var] Volatility variance equals phig squared"
]

(* Test: Dividend variance *)
TestCreate[
	simplifiesZeroQ[var[$dd[t+1,i], t, $testModel] - phidc[i]^2],
	True,
	{},
	TestID -> "[var] Dividend variance equals phidc squared"
]


(* ::Subsection:: *)
(*ev - Law of Iterated Expectations Tests*)


(* Test: LIE for inflation *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+1], t-1, $testModel] - ev[ev[$pi[t+1], t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] Law of iterated expectations holds for inflation"
]

(* Test: LIE for consumption *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t+1], t-1, $testModel] - ev[ev[$dc[t+1], t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] Law of iterated expectations holds for consumption"
]

(* Test: LIE for volatility *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1], t-1, $testModel] - ev[ev[$sg[t+1], t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] Law of iterated expectations holds for volatility"
]

(* Test: LIE for dividend *)
TestCreate[
	simplifiesZeroQ[ev[$dd[t+1,i], t-1, $testModel] - ev[ev[$dd[t+1,i], t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] Law of iterated expectations holds for dividend"
]

(* Test: LIE for inflation-consumption product *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+1] $dc[t+1], t-1, $testModel] - ev[ev[$pi[t+1] $dc[t+1], t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] LIE holds for inflation-consumption product"
]

(* Test: LIE for consumption-volatility product *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t+1] $sg[t+1], t-1, $testModel] - ev[ev[$dc[t+1] $sg[t+1], t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] LIE holds for consumption-volatility product"
]

(* Test: LIE for volatility squared *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1]^2, t-1, $testModel] - ev[ev[$sg[t+1]^2, t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] LIE holds for volatility squared"
]

(* Test: LIE for dividend t+2 *)
TestCreate[
	simplifiesZeroQ[ev[$dd[t+2,i], t-1, $testModel] - ev[ev[$dd[t+2,i], t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] LIE holds for dividend at t+2"
]


(* ::Subsection:: *)
(*ev - Martingale Property Tests*)


(* Test: State variable times future shock - inflation *)
TestCreate[
	ev[$pi[t] eps["pi"][t+1], t-1, $testModel] === 0 && ev[ev[$pi[t] eps["pi"][t+1], t, $testModel], t-1, $testModel] === 0,
	True,
	{},
	TestID -> "[ev] Inflation times future shock has martingale property"
]

(* Test: State variable times future shock - consumption shock *)
TestCreate[
	ev[$pi[t] eps["dc"][t+1], t-1, $testModel] === 0 && ev[ev[$pi[t] eps["dc"][t+1], t, $testModel], t-1, $testModel] === 0,
	True,
	{},
	TestID -> "[ev] Inflation times future dc-shock has martingale property"
]

(* Test: State variable times future shock - volatility *)
TestCreate[
	ev[$sg[t] eps["pi"][t+1], t-1, $testModel] === 0 && ev[ev[$sg[t] eps["pi"][t+1], t, $testModel], t-1, $testModel] === 0,
	True,
	{},
	TestID -> "[ev] Volatility times future shock has martingale property"
]

(* Test: Martingale property for shock squared - inflation *)
TestCreate[
	ev[$pi[t], t-1, $testModel] === ev[$pi[t] eps["pi"][t+1]^2, t-1, $testModel],
	True,
	{},
	TestID -> "[ev] Shock squared preserves inflation expectation"
]

(* Test: Martingale property for shock squared - volatility *)
TestCreate[
	ev[$sg[t], t-1, $testModel] === ev[$sg[t] eps["pi"][t+1]^2, t-1, $testModel],
	True,
	{},
	TestID -> "[ev] Shock squared preserves volatility expectation"
]

(* Test: Martingale property for shock squared - consumption *)
TestCreate[
	ev[$dc[t], t-1, $testModel] === ev[$dc[t] eps["pi"][t+1]^2, t-1, $testModel],
	True,
	{},
	TestID -> "[ev] Shock squared preserves consumption expectation"
]

(* Test: Martingale property for shock squared - dividend *)
TestCreate[
	ev[$dd[t,i], t-1, $testModel] === ev[$dd[t,i] eps["pi"][t+1]^2, t-1, $testModel],
	True,
	{},
	TestID -> "[ev] Shock squared preserves dividend expectation"
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
	TestID -> "[ev] Context prefix does not affect expectation result"
]

(* Test: Time index context sensitivity *)
TestCreate[
	ev[$pi[foo`t+1], t, $testModel] === $pi[1+foo`t],
	True,
	{},
	TestID -> "[ev] Different time symbol in index returns unevaluated"
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
	TestID -> "[lagStateVarst] Inflation at t given t-1 expands correctly"
]

(* Test: Time-shift consistency *)
TestCreate[
	$lagStateVarst[$pi[t+1], t, $testModel] === ($lagStateVarst[$pi[t], t-1, $testModel] /. t -> t+1),
	True,
	{},
	TestID -> "[lagStateVarst] Time shift preserves expansion structure"
]

(* Test: Product expressions with shocks *)
TestCreate[
	$lagStateVarst[$pi[t] eps["pi"][t+2], t, $testModel] === $pi[t] eps["pi"][2+t],
	True,
	{},
	TestID -> "[lagStateVarst] Product with future shock preserved unchanged"
]


(* ::Subsection:: *)
(*lagStateVarst - Parameter Handling Tests*)


(* Test: Parameters remain unchanged - delta *)
TestCreate[
	$lagStateVarst[delta, t-1, $testModel] === delta,
	True,
	{},
	TestID -> "[lagStateVarst] Parameter delta remains unchanged"
]

(* Test: Parameters remain unchanged - A[0] *)
TestCreate[
	$lagStateVarst[$A[0], t-1, $testModel] === $A[0],
	True,
	{},
	TestID -> "[lagStateVarst] Parameter A[0] remains unchanged"
]

(* Test: Parameters remain unchanged - R[-1+m][0] *)
TestCreate[
	$lagStateVarst[$R[-1+m][0], t-1, $testModel] === $R[-1+m][0],
	True,
	{},
	TestID -> "[lagStateVarst] Parameter R[-1+m][0] remains unchanged"
]


(* ::Subsection:: *)
(*lagStateVarst - Equilibrium Variable Tests*)


(* Test: Does not evaluate with pieq *)
TestCreate[
	$lagStateVarst[pieq[t,m], t+1, $testModel] === pieq[t,m],
	True,
	{},
	TestID -> "[lagStateVarst] Equilibrium pieq variable unchanged"
]

(* Test: Does not evaluate with wceq *)
TestCreate[
	$lagStateVarst[wceq[t], t+1, $testModel] === wceq[t],
	True,
	{},
	TestID -> "[lagStateVarst] Equilibrium wceq variable unchanged"
]


(* ::Subsection:: *)
(*lagStateVarst - Listable Property Tests*)


(* Test: Listable property for state variables *)
TestCreate[
	$lagStateVarst[{$pi[t], $sg[t], $dc[t]}, t-1, $testModel] ===
		{$lagStateVarst[$pi[t], t-1, $testModel], $lagStateVarst[$sg[t], t-1, $testModel], $lagStateVarst[$dc[t], t-1, $testModel]},
	True,
	{},
	TestID -> "[lagStateVarst] Maps over list of state variables"
]


(* ::Subsection:: *)
(*lagStateVarst - Context Handling Tests*)


(* Test: Context handling - foo`pi equals pi *)
TestCreate[
	$lagStateVarst[foo`pi[t], t-1, $testModel] === $lagStateVarst[$pi[t], t-1, $testModel],
	True,
	{},
	TestID -> "[lagStateVarst] Context foo`pi treated same as pi"
]

(* Test: Context handling - products with different contexts *)
TestCreate[
	$lagStateVarst[foo`pi[t] $pi[t], t-1, $testModel] === $lagStateVarst[foo`pi[t]^2, t-1, $testModel] === $lagStateVarst[$pi[t]^2, t-1, $testModel],
	True,
	{},
	TestID -> "[lagStateVarst] Products with different contexts equivalent"
]

(* Test: Context handling - mixed context products *)
TestCreate[
	$lagStateVarst[foo`pi[t] eps["pi"][t] bar`delta, t-1, $testModel] === $lagStateVarst[$pi[t] foo`eps["pi"][t] delta, t-1, $testModel],
	True,
	{},
	TestID -> "[lagStateVarst] Mixed context products expand identically"
]

(* Test: Context handling for conditional time *)
TestCreate[
	$lagStateVarst[$pi[foo`t], t-1, $testModel] === $pi[foo`t],
	True,
	{},
	TestID -> "[lagStateVarst] Different time symbol returns unchanged"
]

(* Test: Context handling - time substitution equivalence *)
TestCreate[
	$lagStateVarst[$pi[t], t-1, $testModel] === ($lagStateVarst[$pi[foo`t], foo`t-1, $testModel] /. foo`t -> t),
	True,
	{},
	TestID -> "[lagStateVarst] Time substitution produces equivalent result"
]


(* ::Subsection:: *)
(*Tests Needing Refactoring*)
(*TODO: The following tests exist in docs/test-files/ComputeConditionalExpectations.wlt*)
(*      and need to be refactored to use TestCreate with semantic TestIDs*)


(*
   Bundled Assertion Tests from docs/test-files/ComputeConditionalExpectations.wlt
   ================================================================================
   These tests contain multiple assertions bundled together using Apply[And, {...}]
   and should be split into individual TestCreate calls for better diagnostics.


   TestID: ComputeConditionalExpectations_20260103-L8VFP4
   Location: docs/test-files/ComputeConditionalExpectations.wlt lines 537-1066
   Description: Large bundled test containing:

   Consumption expectations at multiple past time points:
   - ev[dc[t], t-1, modNRC] conditional on t-1
   - ev[dc[t], t-2, modNRC] conditional on t-2
   - ev[dc[t+1], t-2, modNRC] future consumption conditional on t-2

   Model exogenous equation consistency checks:
   - Verification that ev results match model equations
   - Cross-validation of dc, pi, sg expectations with exogenousEq definitions

   Extended shock-inflation product tests with various time indices:
   - eps["pi"][t] * pi[t+k] for k = -2, -1, 0, 1, 2
   - eps["dc"][t] * dc[t+k] products
   - Mixed shock-variable products at different conditioning times


   TestID: ComputeConditionalExpectations_20260103-XEP7ZK
   Location: docs/test-files/ComputeConditionalExpectations.wlt lines 1067-1336
   Description: Extended martingale and shock expectation tests:

   Additional martingale tests with eps["sg"] (sigma/volatility shock):
   - ev[sg[t] * eps["sg"][t+1], t-1, modNRC] === 0
   - ev[pi[t] * eps["sg"][t+1], t-1, modNRC] === 0
   - ev[dc[t] * eps["sg"][t+1], t-1, modNRC] === 0
   - Verification of martingale property: E[X_t | F_{t-1}] = E[E[X_t*eps^2 | F_t] | F_{t-1}]

   Extended state variable times future shock tests:
   - pi[t] x eps["sg"][t+1]: Inflation times future volatility shock
   - sg[t] x eps["dc"][t+1]: Volatility times future consumption shock
   - Cross-shock products: eps["pi"][t] * eps["sg"][t+1]
   - Three-way products: pi[t] * sg[t] * eps["dc"][t+1]


   TestID: ComputeConditionalExpectations_20260103-MMV269
   Location: docs/test-files/ComputeConditionalExpectations.wlt lines 1360-1443
   Description: lagStateVarst extended tests:

   Additional lagStateVarst expansion tests (t+1 given t-1):
   - lagStateVarst[pi[t+1], t-1, modNRC] - two-step ahead expansion
   - lagStateVarst[sg[t+1], t-1, modNRC] - volatility two-step expansion
   - lagStateVarst[dc[t+1], t-1, modNRC] - consumption two-step expansion
   - Verification of recursive structure: lagStateVarst[x[t+1], t-1] = lagStateVarst[lagStateVarst[x[t+1], t], t-1]

   Product with shock at same time index tests:
   - lagStateVarst[pi[t] * eps["pi"][t], t-1, modNRC]
   - lagStateVarst[sg[t] * eps["sg"][t], t-1, modNRC]
   - Verification of shock coefficient extraction

   Extended context handling with multiple different contexts (foo, bar, goo):
   - lagStateVarst[foo`pi[t] * bar`sg[t], t-1, modNRC]
   - lagStateVarst[goo`dc[t] * foo`eps["pi"][t], t-1, modNRC]
   - Verification that context does not affect mathematical result

   Cross-time-index tests with mixed context symbols:
   - lagStateVarst[foo`pi[t] * bar`pi[t-1], t-2, modNRC]
   - lagStateVarst[pi[t] * goo`sg[t-1] * eps["pi"][t-1], t-2, modNRC]
   - Verification of proper substitution across time indices


   REFACTORING NOTES:
   ==================
   - Each bundled test contains 20-50 individual assertions that should be separate tests
   - The L8VFP4 test (529 lines) should be split into ~15-20 tests organized by:
     * Past time conditioning tests
     * Exogenous equation consistency tests
     * Shock-variable product tests by time index
   - The XEP7ZK test (269 lines) should be split into ~10-15 tests organized by:
     * eps["sg"] martingale tests
     * Cross-shock product tests
     * Multi-variable product tests
   - The MMV269 test (83 lines) should be split into ~8-12 tests organized by:
     * Two-step ahead expansion tests
     * Same-time shock product tests
     * Multi-context tests
     * Cross-time-index tests

   To run the original tests, execute:
   TestReport @ FileNameJoin[{$PackageDirectory, "docs", "test-files", "ComputeConditionalExpectations.wlt"}]
*)


End[]
EndTestSection[]
