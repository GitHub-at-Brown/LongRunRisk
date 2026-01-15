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
	TestID -> "[ev] Package context is on ContextPath",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Private functions are accessible via full qualification *)
TestCreate[
	Head[$lagStateVarst] === Symbol,
	True,
	{},
	TestID -> "[lagStateVarst] Private function is accessible via symbol",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*ev - Basic Expectation Tests*)


(* Test: Expectation of shock times inflation equals shock loading parameter *)
TestCreate[
	ev[eps["pi"][t+1] $pi[t+1], t-1, $testModel] === phip,
	True,
	{},
	TestID -> "[ev] Shock times inflation at t+1 given t-1 equals phip",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*ev - Product Expectations Tests*)


(* Test: Dividend and inflation product expectation *)
TestCreate[
	simplifiesZeroQ[ev[$dd[t+1,i] $pi[t+1], t, $testModel] -
		((mup + rhop($pi[t]-mup) + xip eps["pi"][t])*(mud[i] + rhodp[i]($pi[t]-mup) + xid[i] $sg[t-1] eps["pi"][t]))],
	True,
	{},
	TestID -> "[ev] Dividend-inflation product simplifies correctly",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Dividend and consumption product expectation *)
TestCreate[
	simplifiesZeroQ[ev[$dd[t+1,i] $dc[t+1], t, $testModel] -
		((mud[i] + rhodp[i]($pi[t]-mup) + xid[i] $sg[t-1] eps["pi"][t])*(muc + rhocp($pi[t]-mup) + xic $sg[t-1] eps["pi"][t]) + phic phidc[i])],
	True,
	{},
	TestID -> "[ev] Dividend-consumption product simplifies correctly",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Three-term product: volatility, consumption, and inflation *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+3] $dc[t+2] $pi[t+1], t, $testModel] -
		((Esg + rhog^3 ($sg[t]-Esg))*((mup + rhop($pi[t]-mup) + xip eps["pi"][t])*(muc + rhocp rhop($pi[t]-mup) + rhocp xip eps["pi"][t]) + rhocp phip^2 + xic phip $sg[t]))],
	True,
	{},
	TestID -> "[ev] Volatility-consumption-inflation triple product simplifies",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Inflation squared expectation *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+2] $pi[t+1], t, $testModel] -
		((mup + rhop($pi[t]-mup) + xip eps["pi"][t])*(mup + rhop^2 ($pi[t]-mup) + rhop xip eps["pi"][t]) + rhop phip^2 + xip phip)],
	True,
	{},
	TestID -> "[ev] Inflation squared product simplifies correctly",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*ev - Consumption and Inflation Cross-Expectations Tests*)


(* Test: Consumption and inflation at t+1 information *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t+2] $pi[t+1], t+1, $testModel] - $pi[t+1] ev[$dc[t+2], t+1, $testModel]],
	True,
	{},
	TestID -> "[ev] Consumption-inflation factors with t+1 information",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Consumption and inflation at t information *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t+2] $pi[t+1], t, $testModel] -
		((mup + rhop($pi[t]-mup) + xip eps["pi"][t])*(muc + rhocp rhop($pi[t]-mup) + rhocp xip eps["pi"][t]) + rhocp phip^2 + xic phip $sg[t])],
	True,
	{},
	TestID -> "[ev] Consumption-inflation simplifies given t information",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Same-period consumption and inflation *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t+1] $pi[t+1], t, $testModel] -
		(mup + rhop($pi[t]-mup) + xip eps["pi"][t])*(muc + rhocp($pi[t]-mup) + xic $sg[t-1] eps["pi"][t])],
	True,
	{},
	TestID -> "[ev] Same-period consumption-inflation simplifies correctly",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Known consumption-inflation at time t *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t] $pi[t], t, $testModel] -
		$pi[t]*(muc + rhocp($pi[t-1]-mup) + xic $sg[t-2] eps["pi"][t-1] + phic eps["dc"][t])],
	True,
	{},
	TestID -> "[ev] Known consumption-inflation at t equals product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Known consumption-inflation at time t-1 *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t-1] $pi[t-1], t, $testModel] -
		$pi[t-1]*(muc + rhocp($pi[t-2]-mup) + xic $sg[t-3] eps["pi"][t-2] + phic eps["dc"][t-1])],
	True,
	{},
	TestID -> "[ev] Known consumption-inflation at t-1 equals product",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*ev - Volatility State Variable Tests*)


(* Test: Volatility products at various lags - recursive form *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+2] $sg[t+1]^2, t, $testModel] -
		((1-rhog) Esg ev[$sg[t+1]^2, t, $testModel] + rhog ev[$sg[t+1]^3, t, $testModel])],
	True,
	{},
	TestID -> "[ev] Volatility product satisfies recursive form",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility products - expanded form *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+2] $sg[t+1]^2, t, $testModel] -
		((1-rhog) Esg ((Esg + rhog($sg[t]-Esg))^2 + phig^2) + rhog((Esg + rhog($sg[t]-Esg))^3 + 3 phig^2 (Esg + rhog($sg[t]-Esg))))],
	True,
	{},
	TestID -> "[ev] Volatility product satisfies expanded form",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility cross-products t+2 and t+1 *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+2] $sg[t+1], t, $testModel] -
		((Esg + rhog^2 ($sg[t]-Esg))*(Esg + rhog($sg[t]-Esg)) + rhog phig^2)],
	True,
	{},
	TestID -> "[ev] Volatility cross-product at t+2 and t+1 simplifies",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility cross-products t+3 and t+1 *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+3] $sg[t+1], t, $testModel] -
		((Esg + rhog^3 ($sg[t]-Esg))*(Esg + rhog($sg[t]-Esg)) + rhog^2 phig^2)],
	True,
	{},
	TestID -> "[ev] Volatility cross-product at t+3 and t+1 simplifies",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility and inflation product *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1] $pi[t+1], t, $testModel] -
		((Esg + rhog($sg[t]-Esg))*(mup + rhop($pi[t]-mup) + xip eps["pi"][t]))],
	True,
	{},
	TestID -> "[ev] Volatility-inflation product simplifies correctly",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Known volatility-inflation at t *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t] $pi[t], t, $testModel] - $sg[t] $pi[t]],
	True,
	{},
	TestID -> "[ev] Known volatility-inflation at t equals product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Known volatility-inflation at t-1 *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t-1] $pi[t-1], t, $testModel] - $sg[t-1] $pi[t-1]],
	True,
	{},
	TestID -> "[ev] Known volatility-inflation at t-1 equals product",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*ev - Volatility Squared Expectations Tests*)


(* Test: Volatility squared at t+1 given t *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1]^2, t, $testModel] - ((Esg + rhog($sg[t]-Esg))^2 + phig^2)],
	True,
	{},
	TestID -> "[ev] Volatility squared at t+1 given t simplifies",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility squared at t given t (known) *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t]^2, t, $testModel] - $sg[t]^2],
	True,
	{},
	TestID -> "[ev] Known volatility squared equals value squared",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility squared at t+1 given t-1 *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1]^2, t-1, $testModel] - ((Esg + rhog^2 ($sg[t-1]-Esg))^2 + (rhog^2+1) phig^2)],
	True,
	{},
	TestID -> "[ev] Volatility squared at t+1 given t-1 simplifies",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility squared at t+1 given t-2 *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1]^2, t-2, $testModel] - ((Esg + rhog^3 ($sg[t-2]-Esg))^2 + (rhog^4+rhog^2+1) phig^2)],
	True,
	{},
	TestID -> "[ev] Volatility squared at t+1 given t-2 simplifies",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*ev - First Moment Expectations Tests*)


(* Test: Volatility first moment at t+1 given t *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1], t, $testModel] - (Esg + rhog($sg[t]-Esg))],
	True,
	{},
	TestID -> "[ev] Volatility at t+1 given t uses AR(1) formula",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility first moment at t (known) *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t], t, $testModel] - $sg[t]],
	True,
	{},
	TestID -> "[ev] Known volatility at t equals value",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility first moment at t+1 given t-1 *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1], t-1, $testModel] - (Esg + rhog^2 ($sg[t-1]-Esg))],
	True,
	{},
	TestID -> "[ev] Volatility at t+1 given t-1 uses two-step AR(1)",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Consumption first moment at t+1 given t-1 *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t+1], t-1, $testModel] - (muc + rhocp rhop($pi[t-1]-mup) + rhocp xip eps["pi"][t-1])],
	True,
	{},
	TestID -> "[ev] Consumption at t+1 given t-1 simplifies correctly",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Consumption first moment at t given t-1 *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t], t-1, $testModel] - (muc + rhocp($pi[t-1]-mup) + xic $sg[t-2] eps["pi"][t-1])],
	True,
	{},
	TestID -> "[ev] Consumption at t given t-1 simplifies correctly",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*ev - Shock-Inflation Expectations Tests*)


(* Test: Future shock times future inflation (independent) *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t+2] $pi[t+1], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] Future shock times past inflation equals zero",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Current shock times future inflation *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t+1] $pi[t+1], t-1, $testModel] - phip],
	True,
	{},
	TestID -> "[ev] Current shock times same inflation equals phip",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Past shock times future inflation *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t+1], t-1, $testModel] - (rhop phip + xip)],
	True,
	{},
	TestID -> "[ev] Past shock times future inflation gives loading",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Known shock times future inflation *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t-1] $pi[t+1], t-1, $testModel] -
		((mup + rhop^2 ($pi[t-1]-mup) + rhop xip eps["pi"][t-1]) eps["pi"][t-1])],
	True,
	{},
	TestID -> "[ev] Known shock times future inflation factors out",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*ev - Inflation at Different Information Sets Tests*)


(* Test: Inflation at t+2 given t+2 (known) *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+2], t+2, $testModel] - $pi[t+2]],
	True,
	{},
	TestID -> "[ev] Known inflation at t+2 equals value",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Inflation at t+2 given t+1 *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+2], t+1, $testModel] - (mup + rhop($pi[t+1]-mup) + xip eps["pi"][t+1])],
	True,
	{},
	TestID -> "[ev] Inflation at t+2 given t+1 uses AR(1) formula",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Inflation at t+2 given t *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+2], t, $testModel] - (mup + rhop^2 ($pi[t]-mup) + rhop xip eps["pi"][t])],
	True,
	{},
	TestID -> "[ev] Inflation at t+2 given t uses two-step AR(1)",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Inflation at t+2 given t-1 *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+2], t-1, $testModel] - (mup + rhop^3 ($pi[t-1]-mup) + rhop^2 xip eps["pi"][t-1])],
	True,
	{},
	TestID -> "[ev] Inflation at t+2 given t-1 uses three-step AR(1)",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Inflation at t+2 given t-2 *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+2], t-2, $testModel] - (mup + rhop^4 ($pi[t-2]-mup) + rhop^3 xip eps["pi"][t-2])],
	True,
	{},
	TestID -> "[ev] Inflation at t+2 given t-2 uses four-step AR(1)",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*ev - Second Moment Expectations Tests*)


(* Test: Inflation squared second moment *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+1]^2, t, $testModel] - ((mup + rhop($pi[t]-mup) + xip eps["pi"][t])^2 + phip^2)],
	True,
	{},
	TestID -> "[ev] Inflation squared second moment includes phip^2",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Consumption squared second moment *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t+1]^2, t, $testModel] - ((muc + rhocp($pi[t]-mup) + xic $sg[t-1] eps["pi"][t])^2 + phic^2)],
	True,
	{},
	TestID -> "[ev] Consumption squared second moment includes phic^2",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility squared second moment *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1]^2, t, $testModel] - ((Esg + rhog($sg[t]-Esg))^2 + phig^2)],
	True,
	{},
	TestID -> "[ev] Volatility squared second moment includes phig^2",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Dividend squared second moment *)
TestCreate[
	simplifiesZeroQ[ev[$dd[t+1,i]^2, t, $testModel] - ((mud[i] + rhodp[i]($pi[t]-mup) + xid[i] $sg[t-1] eps["pi"][t])^2 + phidc[i]^2)],
	True,
	{},
	TestID -> "[ev] Dividend squared second moment includes phidc^2",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*var - Conditional Variance Tests*)


(* Test: Inflation variance *)
TestCreate[
	simplifiesZeroQ[var[$pi[t+1], t, $testModel] - phip^2],
	True,
	{},
	TestID -> "[var] Inflation variance equals phip squared",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Consumption variance *)
TestCreate[
	simplifiesZeroQ[var[$dc[t+1], t, $testModel] - phic^2],
	True,
	{},
	TestID -> "[var] Consumption variance equals phic squared",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility variance *)
TestCreate[
	simplifiesZeroQ[var[$sg[t+1], t, $testModel] - phig^2],
	True,
	{},
	TestID -> "[var] Volatility variance equals phig squared",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Dividend variance *)
TestCreate[
	simplifiesZeroQ[var[$dd[t+1,i], t, $testModel] - phidc[i]^2],
	True,
	{},
	TestID -> "[var] Dividend variance equals phidc squared",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*ev - Law of Iterated Expectations Tests*)


(* Test: LIE for inflation *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+1], t-1, $testModel] - ev[ev[$pi[t+1], t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] Law of iterated expectations holds for inflation",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: LIE for consumption *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t+1], t-1, $testModel] - ev[ev[$dc[t+1], t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] Law of iterated expectations holds for consumption",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: LIE for volatility *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1], t-1, $testModel] - ev[ev[$sg[t+1], t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] Law of iterated expectations holds for volatility",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: LIE for dividend *)
TestCreate[
	simplifiesZeroQ[ev[$dd[t+1,i], t-1, $testModel] - ev[ev[$dd[t+1,i], t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] Law of iterated expectations holds for dividend",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: LIE for inflation-consumption product *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+1] $dc[t+1], t-1, $testModel] - ev[ev[$pi[t+1] $dc[t+1], t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] LIE holds for inflation-consumption product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: LIE for consumption-volatility product *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t+1] $sg[t+1], t-1, $testModel] - ev[ev[$dc[t+1] $sg[t+1], t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] LIE holds for consumption-volatility product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: LIE for volatility squared *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1]^2, t-1, $testModel] - ev[ev[$sg[t+1]^2, t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] LIE holds for volatility squared",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: LIE for dividend t+2 *)
TestCreate[
	simplifiesZeroQ[ev[$dd[t+2,i], t-1, $testModel] - ev[ev[$dd[t+2,i], t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] LIE holds for dividend at t+2",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*ev - Martingale Property Tests*)


(* Test: State variable times future shock - inflation *)
TestCreate[
	ev[$pi[t] eps["pi"][t+1], t-1, $testModel] === 0 && ev[ev[$pi[t] eps["pi"][t+1], t, $testModel], t-1, $testModel] === 0,
	True,
	{},
	TestID -> "[ev] Inflation times future shock has martingale property",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: State variable times future shock - consumption shock *)
TestCreate[
	ev[$pi[t] eps["dc"][t+1], t-1, $testModel] === 0 && ev[ev[$pi[t] eps["dc"][t+1], t, $testModel], t-1, $testModel] === 0,
	True,
	{},
	TestID -> "[ev] Inflation times future dc-shock has martingale property",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: State variable times future shock - volatility *)
TestCreate[
	ev[$sg[t] eps["pi"][t+1], t-1, $testModel] === 0 && ev[ev[$sg[t] eps["pi"][t+1], t, $testModel], t-1, $testModel] === 0,
	True,
	{},
	TestID -> "[ev] Volatility times future shock has martingale property",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Martingale property for shock squared - inflation *)
TestCreate[
	ev[$pi[t], t-1, $testModel] === ev[$pi[t] eps["pi"][t+1]^2, t-1, $testModel],
	True,
	{},
	TestID -> "[ev] Shock squared preserves inflation expectation",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Martingale property for shock squared - volatility *)
TestCreate[
	ev[$sg[t], t-1, $testModel] === ev[$sg[t] eps["pi"][t+1]^2, t-1, $testModel],
	True,
	{},
	TestID -> "[ev] Shock squared preserves volatility expectation",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Martingale property for shock squared - consumption *)
TestCreate[
	ev[$dc[t], t-1, $testModel] === ev[$dc[t] eps["pi"][t+1]^2, t-1, $testModel],
	True,
	{},
	TestID -> "[ev] Shock squared preserves consumption expectation",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Martingale property for shock squared - dividend *)
TestCreate[
	ev[$dd[t,i], t-1, $testModel] === ev[$dd[t,i] eps["pi"][t+1]^2, t-1, $testModel],
	True,
	{},
	TestID -> "[ev] Shock squared preserves dividend expectation",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[ev] Context prefix does not affect expectation result",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Time index context sensitivity *)
TestCreate[
	ev[$pi[foo`t+1], t, $testModel] === $pi[1+foo`t],
	True,
	{},
	TestID -> "[ev] Different time symbol in index returns unevaluated",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[lagStateVarst] Inflation at t given t-1 expands correctly",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Time-shift consistency *)
TestCreate[
	$lagStateVarst[$pi[t+1], t, $testModel] === ($lagStateVarst[$pi[t], t-1, $testModel] /. t -> t+1),
	True,
	{},
	TestID -> "[lagStateVarst] Time shift preserves expansion structure",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Product expressions with shocks *)
TestCreate[
	$lagStateVarst[$pi[t] eps["pi"][t+2], t, $testModel] === $pi[t] eps["pi"][2+t],
	True,
	{},
	TestID -> "[lagStateVarst] Product with future shock preserved unchanged",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*lagStateVarst - Parameter Handling Tests*)


(* Test: Parameters remain unchanged - delta *)
TestCreate[
	$lagStateVarst[delta, t-1, $testModel] === delta,
	True,
	{},
	TestID -> "[lagStateVarst] Parameter delta remains unchanged",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Parameters remain unchanged - A[0] *)
TestCreate[
	$lagStateVarst[$A[0], t-1, $testModel] === $A[0],
	True,
	{},
	TestID -> "[lagStateVarst] Parameter A[0] remains unchanged",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Parameters remain unchanged - R[-1+m][0] *)
TestCreate[
	$lagStateVarst[$R[-1+m][0], t-1, $testModel] === $R[-1+m][0],
	True,
	{},
	TestID -> "[lagStateVarst] Parameter R[-1+m][0] remains unchanged",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*lagStateVarst - Equilibrium Variable Tests*)


(* Test: Does not evaluate with pieq *)
TestCreate[
	$lagStateVarst[pieq[t,m], t+1, $testModel] === pieq[t,m],
	True,
	{},
	TestID -> "[lagStateVarst] Equilibrium pieq variable unchanged",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Does not evaluate with wceq *)
TestCreate[
	$lagStateVarst[wceq[t], t+1, $testModel] === wceq[t],
	True,
	{},
	TestID -> "[lagStateVarst] Equilibrium wceq variable unchanged",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*lagStateVarst - Listable Property Tests*)


(* Test: Listable property for state variables *)
TestCreate[
	$lagStateVarst[{$pi[t], $sg[t], $dc[t]}, t-1, $testModel] ===
		{$lagStateVarst[$pi[t], t-1, $testModel], $lagStateVarst[$sg[t], t-1, $testModel], $lagStateVarst[$dc[t], t-1, $testModel]},
	True,
	{},
	TestID -> "[lagStateVarst] Maps over list of state variables",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*lagStateVarst - Context Handling Tests*)


(* Test: Context handling - foo`pi equals pi *)
TestCreate[
	$lagStateVarst[foo`pi[t], t-1, $testModel] === $lagStateVarst[$pi[t], t-1, $testModel],
	True,
	{},
	TestID -> "[lagStateVarst] Context foo`pi treated same as pi",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Context handling - products with different contexts *)
TestCreate[
	$lagStateVarst[foo`pi[t] $pi[t], t-1, $testModel] === $lagStateVarst[foo`pi[t]^2, t-1, $testModel] === $lagStateVarst[$pi[t]^2, t-1, $testModel],
	True,
	{},
	TestID -> "[lagStateVarst] Products with different contexts equivalent",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Context handling - mixed context products *)
TestCreate[
	$lagStateVarst[foo`pi[t] eps["pi"][t] bar`delta, t-1, $testModel] === $lagStateVarst[$pi[t] foo`eps["pi"][t] delta, t-1, $testModel],
	True,
	{},
	TestID -> "[lagStateVarst] Mixed context products expand identically",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Context handling for conditional time *)
TestCreate[
	$lagStateVarst[$pi[foo`t], t-1, $testModel] === $pi[foo`t],
	True,
	{},
	TestID -> "[lagStateVarst] Different time symbol returns unchanged",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Context handling - time substitution equivalence *)
TestCreate[
	$lagStateVarst[$pi[t], t-1, $testModel] === ($lagStateVarst[$pi[foo`t], foo`t-1, $testModel] /. foo`t -> t),
	True,
	{},
	TestID -> "[lagStateVarst] Time substitution produces equivalent result",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*ev - Consumption Expectations at Past Time Points*)


(* Test: Consumption at t-1 conditional on t-1 *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t-1], t-1, $testModel] -
		(muc + rhocp($pi[t-2]-mup) + xic $sg[t-3] eps["pi"][t-2] + phic eps["dc"][t-1])],
	True,
	{},
	TestID -> "[ev] Consumption at t-1 given t-1 simplifies correctly",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Consumption at t-2 conditional on t-1 *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t-2], t-1, $testModel] -
		(muc + rhocp($pi[t-3]-mup) + xic $sg[t-4] eps["pi"][t-3] + phic eps["dc"][t-2])],
	True,
	{},
	TestID -> "[ev] Consumption at t-2 given t-1 equals realized value",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Consumption at t+1 conditional on t *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t+1], t, $testModel] -
		(muc + rhocp($pi[t]-mup) + xic $sg[t-1] eps["pi"][t])],
	True,
	{},
	TestID -> "[ev] Consumption at t+1 given t simplifies correctly",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Consumption at t+1 conditional on t-1 *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t+1], t-1, $testModel] -
		(muc + rhocp rhop($pi[t-1]-mup) + rhocp xip eps["pi"][t-1])],
	True,
	{},
	TestID -> "[ev] Consumption at t+1 given t-1 uses AR(1) inflation",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Consumption at t+1 conditional on t-2 *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t+1], t-2, $testModel] -
		(muc + rhocp rhop^2 ($pi[t-2]-mup) + rhocp rhop xip eps["pi"][t-2])],
	True,
	{},
	TestID -> "[ev] Consumption at t+1 given t-2 uses two-step AR(1)",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*ev - Extended Shock-Inflation Products by Conditioning Time*)


(* ::Subsubsection:: *)
(*Conditioning on t-1*)


(* Test: Future shock times future inflation equals zero *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t+2] $pi[t+1], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] eps[pi][t+2] times pi[t+1] given t-1 equals zero",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Same-time shock times inflation at t+1 equals phip *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t+1] $pi[t+1], t-1, $testModel] - phip],
	True,
	{},
	TestID -> "[ev] eps[pi][t+1] times pi[t+1] given t-1 equals phip",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Past shock times future inflation uses loading *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t+1], t-1, $testModel] - (rhop phip + xip)],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t+1] given t-1 equals rhop*phip+xip",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Known shock times future inflation factors out *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t-1] $pi[t+1], t-1, $testModel] -
		((mup + rhop^2 ($pi[t-1]-mup) + rhop xip eps["pi"][t-1]) eps["pi"][t-1])],
	True,
	{},
	TestID -> "[ev] eps[pi][t-1] times pi[t+1] given t-1 factors",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Earlier known shock times future inflation *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t-2] $pi[t+1], t-1, $testModel] -
		((mup + rhop^2 ($pi[t-1]-mup) + rhop xip eps["pi"][t-1]) eps["pi"][t-2])],
	True,
	{},
	TestID -> "[ev] eps[pi][t-2] times pi[t+1] given t-1 factors",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsubsection:: *)
(*Conditioning on t*)


(* Test: Future shock times future inflation given t *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t+2] $pi[t+1], t, $testModel]],
	True,
	{},
	TestID -> "[ev] eps[pi][t+2] times pi[t+1] given t equals zero",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Same-time shock times inflation given t *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t+1] $pi[t+1], t, $testModel] - phip],
	True,
	{},
	TestID -> "[ev] eps[pi][t+1] times pi[t+1] given t equals phip",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Current shock times future inflation given t *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t+1], t, $testModel] -
		((mup + rhop($pi[t]-mup) + xip eps["pi"][t]) eps["pi"][t])],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t+1] given t uses current value",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Past shock times future inflation given t *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t-1] $pi[t+1], t, $testModel] -
		((mup + rhop($pi[t]-mup) + xip eps["pi"][t]) eps["pi"][t-1])],
	True,
	{},
	TestID -> "[ev] eps[pi][t-1] times pi[t+1] given t factors",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Earlier shock times future inflation given t *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t-2] $pi[t+1], t, $testModel] -
		((mup + rhop($pi[t]-mup) + xip eps["pi"][t]) eps["pi"][t-2])],
	True,
	{},
	TestID -> "[ev] eps[pi][t-2] times pi[t+1] given t factors",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsubsection:: *)
(*Conditioning on t+1*)


(* Test: Future shock times inflation given t+1 *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t+2] $pi[t+1], t+1, $testModel]],
	True,
	{},
	TestID -> "[ev] eps[pi][t+2] times pi[t+1] given t+1 equals zero",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Same-time shock times inflation given t+1 is realized *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t+1] $pi[t+1], t+1, $testModel] - eps["pi"][t+1] $pi[t+1]],
	True,
	{},
	TestID -> "[ev] eps[pi][t+1] times pi[t+1] given t+1 equals product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Past shock times inflation given t+1 is realized *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t+1], t+1, $testModel] - eps["pi"][t] $pi[t+1]],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t+1] given t+1 equals product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Earlier shock times inflation given t+1 is realized *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t-1] $pi[t+1], t+1, $testModel] - eps["pi"][t-1] $pi[t+1]],
	True,
	{},
	TestID -> "[ev] eps[pi][t-1] times pi[t+1] given t+1 equals product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Much earlier shock times inflation given t+1 *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t-2] $pi[t+1], t+1, $testModel] - eps["pi"][t-2] $pi[t+1]],
	True,
	{},
	TestID -> "[ev] eps[pi][t-2] times pi[t+1] given t+1 equals product",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*ev - Shock Times Inflation at Different Target Times*)


(* ::Subsubsection:: *)
(*Target inflation at t+2*)


(* Test: Shock at t times inflation at t+2 given t-2 *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t+2], t-2, $testModel] -
		rhop (rhop phip + xip)],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t+2] given t-2 simplifies",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Shock at t times inflation at t+2 given t-1 *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t+2], t-1, $testModel] -
		rhop (rhop phip + xip)],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t+2] given t-1 simplifies",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Shock at t times inflation at t+2 given t *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t+2], t, $testModel] -
		((mup + rhop^2 ($pi[t]-mup) + rhop xip eps["pi"][t]) eps["pi"][t])],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t+2] given t uses current value",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Shock at t times inflation at t+2 given t+1 *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t+2], t+1, $testModel] -
		((mup + rhop($pi[t+1]-mup) + xip eps["pi"][t+1]) eps["pi"][t])],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t+2] given t+1 simplifies",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsubsection:: *)
(*Target inflation at t+1*)


(* Test: Shock at t times inflation at t+1 given t-2 *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t+1], t-2, $testModel] - (rhop phip + xip)],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t+1] given t-2 equals rhop*phip+xip",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsubsection:: *)
(*Target inflation at t*)


(* Test: Shock at t times inflation at t given t-2 equals phip *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t], t-2, $testModel] - phip],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t] given t-2 equals phip",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Shock at t times inflation at t given t-1 equals phip *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t], t-1, $testModel] - phip],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t] given t-1 equals phip",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Shock at t times inflation at t given t is realized *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t], t, $testModel] - eps["pi"][t] $pi[t]],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t] given t equals product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Shock at t times inflation at t given t+1 is realized *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t], t+1, $testModel] - eps["pi"][t] $pi[t]],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t] given t+1 equals product",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsubsection:: *)
(*Target inflation at past times*)


(* Test: Shock at t times inflation at t-1 given t-2 equals zero *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t-1], t-2, $testModel]],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t-1] given t-2 equals zero",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Shock at t times inflation at t-2 given t-2 equals zero *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t-2], t-2, $testModel]],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t-2] given t-2 equals zero",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Shock at t times inflation at t-1 given t-1 equals zero *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t-1], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t-1] given t-1 equals zero",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Shock at t times inflation at t-2 given t-1 equals zero *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t-2], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t-2] given t-1 equals zero",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Shock at t times inflation at t-1 given t is realized *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t-1], t, $testModel] - eps["pi"][t] $pi[t-1]],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t-1] given t equals product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Shock at t times inflation at t-2 given t is realized *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t-2], t, $testModel] - eps["pi"][t] $pi[t-2]],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t-2] given t equals product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Shock at t times inflation at t-1 given t+1 is realized *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t-1], t+1, $testModel] - eps["pi"][t] $pi[t-1]],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t-1] given t+1 equals product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Shock at t times inflation at t-2 given t+1 is realized *)
TestCreate[
	simplifiesZeroQ[ev[eps["pi"][t] $pi[t-2], t+1, $testModel] - eps["pi"][t] $pi[t-2]],
	True,
	{},
	TestID -> "[ev] eps[pi][t] times pi[t-2] given t+1 equals product",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*ev - First Moment Expectations at Various Information Sets*)


(* Test: Inflation at t+1 given t uses AR(1) *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+1], t, $testModel] -
		(mup + rhop($pi[t]-mup) + xip eps["pi"][t])],
	True,
	{},
	TestID -> "[ev] Inflation at t+1 given t uses AR(1) formula",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Consumption at t+1 given t *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t+1], t, $testModel] -
		(muc + rhocp($pi[t]-mup) + xic $sg[t-1] eps["pi"][t])],
	True,
	{},
	TestID -> "[ev] Consumption at t+1 given t simplifies correctly",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility at t+1 given t *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1], t, $testModel] -
		(Esg + rhog($sg[t]-Esg))],
	True,
	{},
	TestID -> "[ev] Volatility at t+1 given t uses AR(1)",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Dividend at t+1 given t *)
TestCreate[
	simplifiesZeroQ[ev[$dd[t+1,i], t, $testModel] -
		(mud[i] + rhodp[i]($pi[t]-mup) + xid[i] $sg[t-1] eps["pi"][t])],
	True,
	{},
	TestID -> "[ev] Dividend at t+1 given t simplifies correctly",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*ev - Law of Iterated Expectations Extended Tests*)


(* ::Subsubsection:: *)
(*Iterated expectations for state variable products*)


(* Test: Iterated expectations for pi*dc product *)
TestCreate[
	simplifiesZeroQ[ev[$pi[t+1] $dc[t+1], t-1, $testModel] -
		ev[ev[$pi[t+1] $dc[t+1], t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] Iterated expectations hold for pi*dc product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Iterated expectations for dc*sg product *)
TestCreate[
	simplifiesZeroQ[ev[$dc[t+1] $sg[t+1], t-1, $testModel] -
		ev[ev[$dc[t+1] $sg[t+1], t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] Iterated expectations hold for dc*sg product",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Iterated expectations for sg squared *)
TestCreate[
	simplifiesZeroQ[ev[$sg[t+1]^2, t-1, $testModel] -
		ev[ev[$sg[t+1]^2, t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] Iterated expectations hold for sg squared",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Iterated expectations for dd at t+2 *)
TestCreate[
	simplifiesZeroQ[ev[$dd[t+2,i], t-1, $testModel] -
		ev[ev[$dd[t+2,i], t, $testModel], t-1, $testModel]],
	True,
	{},
	TestID -> "[ev] Iterated expectations hold for dd at t+2",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsubsection:: *)
(*State variable times future shock martingale tests*)


(* Test: Inflation times future pi shock equals zero *)
TestCreate[
	ev[$pi[t] eps["pi"][t+1], t-1, $testModel] === 0 &&
	ev[ev[$pi[t] eps["pi"][t+1], t, $testModel], t-1, $testModel] === 0,
	True,
	{},
	TestID -> "[ev] pi[t]*eps[pi][t+1] martingale property holds",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Inflation times future dc shock equals zero *)
TestCreate[
	ev[$pi[t] eps["dc"][t+1], t-1, $testModel] === 0 &&
	ev[ev[$pi[t] eps["dc"][t+1], t, $testModel], t-1, $testModel] === 0,
	True,
	{},
	TestID -> "[ev] pi[t]*eps[dc][t+1] martingale property holds",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Inflation times future sg shock equals zero *)
TestCreate[
	ev[$pi[t] eps["sg"][t+1], t-1, $testModel] === 0 &&
	ev[ev[$pi[t] eps["sg"][t+1], t, $testModel], t-1, $testModel] === 0,
	True,
	{},
	TestID -> "[ev] pi[t]*eps[sg][t+1] martingale property holds",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility times future pi shock equals zero *)
TestCreate[
	ev[$sg[t] eps["pi"][t+1], t-1, $testModel] === 0 &&
	ev[ev[$sg[t] eps["pi"][t+1], t, $testModel], t-1, $testModel] === 0,
	True,
	{},
	TestID -> "[ev] sg[t]*eps[pi][t+1] martingale property holds",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility times future dc shock equals zero *)
TestCreate[
	ev[$sg[t] eps["dc"][t+1], t-1, $testModel] === 0 &&
	ev[ev[$sg[t] eps["dc"][t+1], t, $testModel], t-1, $testModel] === 0,
	True,
	{},
	TestID -> "[ev] sg[t]*eps[dc][t+1] martingale property holds",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility times future sg shock equals zero *)
TestCreate[
	ev[$sg[t] eps["sg"][t+1], t-1, $testModel] === 0 &&
	ev[ev[$sg[t] eps["sg"][t+1], t, $testModel], t-1, $testModel] === 0,
	True,
	{},
	TestID -> "[ev] sg[t]*eps[sg][t+1] martingale property holds",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsubsection:: *)
(*Squared state variable times future shock*)


(* Test: Inflation squared times future pi shock iterated *)
TestCreate[
	ev[$pi[t]^2 eps["pi"][t+2], t-1, $testModel] ===
	ev[ev[$pi[t]^2 eps["pi"][t+2], t, $testModel], t-1, $testModel],
	True,
	{},
	TestID -> "[ev] pi[t]^2*eps[pi][t+2] iterated expectations hold",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Inflation squared times future dc shock iterated *)
TestCreate[
	ev[$pi[t]^2 eps["dc"][t+2], t-1, $testModel] ===
	ev[ev[$pi[t]^2 eps["dc"][t+2], t, $testModel], t-1, $testModel],
	True,
	{},
	TestID -> "[ev] pi[t]^2*eps[dc][t+2] iterated expectations hold",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Inflation squared times future sg shock iterated *)
TestCreate[
	ev[$pi[t]^2 eps["sg"][t+2], t-1, $testModel] ===
	ev[ev[$pi[t]^2 eps["sg"][t+2], t, $testModel], t-1, $testModel],
	True,
	{},
	TestID -> "[ev] pi[t]^2*eps[sg][t+2] iterated expectations hold",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility squared times future pi shock iterated *)
TestCreate[
	ev[$sg[t]^2 eps["pi"][t+2], t-1, $testModel] ===
	ev[ev[$sg[t]^2 eps["pi"][t+2], t, $testModel], t-1, $testModel],
	True,
	{},
	TestID -> "[ev] sg[t]^2*eps[pi][t+2] iterated expectations hold",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility squared times future dc shock iterated *)
TestCreate[
	ev[$sg[t]^2 eps["dc"][t+2], t-1, $testModel] ===
	ev[ev[$sg[t]^2 eps["dc"][t+2], t, $testModel], t-1, $testModel],
	True,
	{},
	TestID -> "[ev] sg[t]^2*eps[dc][t+2] iterated expectations hold",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility squared times future sg shock iterated *)
TestCreate[
	ev[$sg[t]^2 eps["sg"][t+2], t-1, $testModel] ===
	ev[ev[$sg[t]^2 eps["sg"][t+2], t, $testModel], t-1, $testModel],
	True,
	{},
	TestID -> "[ev] sg[t]^2*eps[sg][t+2] iterated expectations hold",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsubsection:: *)
(*Martingale property with squared shocks*)


(* Test: Inflation times pi shock squared uses martingale *)
TestCreate[
	ev[$pi[t], t-1, $testModel] === ev[$pi[t] ev[eps["pi"][t+1]^2, t, $testModel], t-1, $testModel] &&
	ev[$pi[t] eps["pi"][t+1]^2, t-1, $testModel] === ev[ev[$pi[t] eps["pi"][t+1]^2, t, $testModel], t-1, $testModel],
	True,
	{},
	TestID -> "[ev] pi[t]*eps[pi][t+1]^2 martingale holds",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Inflation times sg shock squared uses martingale *)
TestCreate[
	ev[$pi[t], t-1, $testModel] === ev[$pi[t] ev[eps["sg"][t+1]^2, t, $testModel], t-1, $testModel] &&
	ev[$pi[t] eps["sg"][t+1]^2, t-1, $testModel] === ev[ev[$pi[t] eps["sg"][t+1]^2, t, $testModel], t-1, $testModel],
	True,
	{},
	TestID -> "[ev] pi[t]*eps[sg][t+1]^2 martingale holds",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Inflation times dc shock squared uses martingale *)
TestCreate[
	ev[$pi[t], t-1, $testModel] === ev[$pi[t] ev[eps["dc"][t+1]^2, t, $testModel], t-1, $testModel] &&
	ev[$pi[t] eps["dc"][t+1]^2, t-1, $testModel] === ev[ev[$pi[t] eps["dc"][t+1]^2, t, $testModel], t-1, $testModel],
	True,
	{},
	TestID -> "[ev] pi[t]*eps[dc][t+1]^2 martingale holds",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility times pi shock squared uses martingale *)
TestCreate[
	ev[$sg[t], t-1, $testModel] === ev[$sg[t] ev[eps["pi"][t+1]^2, t, $testModel], t-1, $testModel] &&
	ev[$sg[t] eps["pi"][t+1]^2, t-1, $testModel] === ev[ev[$sg[t] eps["pi"][t+1]^2, t, $testModel], t-1, $testModel],
	True,
	{},
	TestID -> "[ev] sg[t]*eps[pi][t+1]^2 martingale holds",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility times sg shock squared uses martingale *)
TestCreate[
	ev[$sg[t], t-1, $testModel] === ev[$sg[t] ev[eps["sg"][t+1]^2, t, $testModel], t-1, $testModel] &&
	ev[$sg[t] eps["sg"][t+1]^2, t-1, $testModel] === ev[ev[$sg[t] eps["sg"][t+1]^2, t, $testModel], t-1, $testModel],
	True,
	{},
	TestID -> "[ev] sg[t]*eps[sg][t+1]^2 martingale holds",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Volatility times dc shock squared uses martingale *)
TestCreate[
	ev[$sg[t], t-1, $testModel] === ev[$sg[t] ev[eps["dc"][t+1]^2, t, $testModel], t-1, $testModel] &&
	ev[$sg[t] eps["dc"][t+1]^2, t-1, $testModel] === ev[ev[$sg[t] eps["dc"][t+1]^2, t, $testModel], t-1, $testModel],
	True,
	{},
	TestID -> "[ev] sg[t]*eps[dc][t+1]^2 martingale holds",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Consumption times pi shock squared uses martingale *)
TestCreate[
	ev[$dc[t], t-1, $testModel] === ev[$dc[t] ev[eps["pi"][t+1]^2, t, $testModel], t-1, $testModel] &&
	ev[$dc[t] eps["pi"][t+1]^2, t-1, $testModel] === ev[ev[$dc[t] eps["pi"][t+1]^2, t, $testModel], t-1, $testModel],
	True,
	{},
	TestID -> "[ev] dc[t]*eps[pi][t+1]^2 martingale holds",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Consumption times sg shock squared uses martingale *)
TestCreate[
	ev[$dc[t], t-1, $testModel] === ev[$dc[t] ev[eps["sg"][t+1]^2, t, $testModel], t-1, $testModel] &&
	ev[$dc[t] eps["sg"][t+1]^2, t-1, $testModel] === ev[ev[$dc[t] eps["sg"][t+1]^2, t, $testModel], t-1, $testModel],
	True,
	{},
	TestID -> "[ev] dc[t]*eps[sg][t+1]^2 martingale holds",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Consumption times dc shock squared uses martingale *)
TestCreate[
	ev[$dc[t], t-1, $testModel] === ev[$dc[t] ev[eps["dc"][t+1]^2, t, $testModel], t-1, $testModel] &&
	ev[$dc[t] eps["dc"][t+1]^2, t-1, $testModel] === ev[ev[$dc[t] eps["dc"][t+1]^2, t, $testModel], t-1, $testModel],
	True,
	{},
	TestID -> "[ev] dc[t]*eps[dc][t+1]^2 martingale holds",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Dividend times pi shock squared uses martingale *)
TestCreate[
	ev[$dd[t,i], t-1, $testModel] === ev[$dd[t,i] ev[eps["pi"][t+1]^2, t, $testModel], t-1, $testModel] &&
	ev[$dd[t,i] eps["pi"][t+1]^2, t-1, $testModel] === ev[ev[$dd[t,i] eps["pi"][t+1]^2, t, $testModel], t-1, $testModel],
	True,
	{},
	TestID -> "[ev] dd[t,i]*eps[pi][t+1]^2 martingale holds",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Dividend times sg shock squared uses martingale *)
TestCreate[
	ev[$dd[t,i], t-1, $testModel] === ev[$dd[t,i] ev[eps["sg"][t+1]^2, t, $testModel], t-1, $testModel] &&
	ev[$dd[t,i] eps["sg"][t+1]^2, t-1, $testModel] === ev[ev[$dd[t,i] eps["sg"][t+1]^2, t, $testModel], t-1, $testModel],
	True,
	{},
	TestID -> "[ev] dd[t,i]*eps[sg][t+1]^2 martingale holds",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Dividend times dc shock squared uses martingale *)
TestCreate[
	ev[$dd[t,i], t-1, $testModel] === ev[$dd[t,i] ev[eps["dc"][t+1]^2, t, $testModel], t-1, $testModel] &&
	ev[$dd[t,i] eps["dc"][t+1]^2, t-1, $testModel] === ev[ev[$dd[t,i] eps["dc"][t+1]^2, t, $testModel], t-1, $testModel],
	True,
	{},
	TestID -> "[ev] dd[t,i]*eps[dc][t+1]^2 martingale holds",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*ev - Extended Context Handling Tests*)


(* Test: Context in expression with different conditioning context *)
TestCreate[
	ev[$pi[foo`t+1], t, $testModel] === $pi[1+foo`t],
	True,
	{},
	TestID -> "[ev] Expression context foo`t differs from conditioning context",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Conditioning on different context *)
TestCreate[
	ev[$pi[t+1], foo`t, $testModel] === $pi[1+t],
	True,
	{},
	TestID -> "[ev] Conditioning on foo`t leaves expression unchanged",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Both expression and conditioning with same non-standard context *)
TestCreate[
	(ev[foo`pi[foo`t+1], foo`t, $testModel] /. foo`t -> t) === ev[$pi[t+1], t, $testModel],
	True,
	{},
	TestID -> "[ev] foo` context in both simplifies same as standard",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Mixed contexts in expression *)
TestCreate[
	ev[foo`pi[bar`t+1], t, $testModel] === $pi[1+bar`t],
	True,
	{},
	TestID -> "[ev] Mixed foo`pi with bar`t simplifies correctly",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Non-standard context expression with another context conditioning *)
TestCreate[
	ev[foo`pi[t+1], bar`t, $testModel] === $pi[1+t],
	True,
	{},
	TestID -> "[ev] foo`pi conditioned on bar`t leaves unchanged",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Three different contexts *)
TestCreate[
	ev[foo`pi[bar`t+1], goo`t, $testModel] === $pi[1+bar`t],
	True,
	{},
	TestID -> "[ev] Three different contexts simplifies correctly",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*lagStateVarst - Two-Step Ahead Expansion Tests*)


(* Test: Inflation at t+1 given t-1 expanded *)
TestCreate[
	$lagStateVarst[$pi[t+1], t-1, $testModel] ===
		(mup + rhop(rhop($pi[t-1]-mup) + xip eps["pi"][t-1] + phip eps["pi"][t]) +
		 xip eps["pi"][t] + phip eps["pi"][1+t]),
	True,
	{},
	TestID -> "[lagStateVarst] Inflation at t+1 given t-1 fully expands",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Recursive structure for inflation *)
TestCreate[
	$lagStateVarst[$pi[t+1], t, $testModel] ===
		($lagStateVarst[$pi[t], t-1, $testModel] /. t -> t+1),
	True,
	{},
	TestID -> "[lagStateVarst] Recursive structure holds for inflation",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*lagStateVarst - Product with Same-Time Shock Tests*)


(* Test: Inflation times shock at same time *)
TestCreate[
	$lagStateVarst[$pi[t] eps["pi"][t], t-1, $testModel] ===
		(eps["pi"][t] (mup + rhop($pi[t-1]-mup) + xip eps["pi"][t-1] + phip eps["pi"][t])),
	True,
	{},
	TestID -> "[lagStateVarst] pi[t]*eps[pi][t] expands inflation",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*lagStateVarst - Extended Context Handling Tests*)


(* Test: Non-standard context with different time symbol *)
TestCreate[
	$lagStateVarst[$pi[foo`t], t-1, $testModel] === $pi[foo`t],
	True,
	{},
	TestID -> "[lagStateVarst] Different time symbol foo`t unchanged",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Product of pi in two contexts equals pi squared *)
TestCreate[
	$lagStateVarst[foo`pi[t] $pi[t], t-1, $testModel] ===
	$lagStateVarst[foo`pi[t]^2, t-1, $testModel] &&
	$lagStateVarst[foo`pi[t]^2, t-1, $testModel] === $lagStateVarst[$pi[t]^2, t-1, $testModel],
	True,
	{},
	TestID -> "[lagStateVarst] foo`pi*pi equals pi^2 expansion",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Product with shock and delta in different contexts *)
TestCreate[
	$lagStateVarst[foo`pi[t] eps["pi"][t] bar`delta, t-1, $testModel] ===
	$lagStateVarst[$pi[t] foo`eps["pi"][t] delta, t-1, $testModel],
	True,
	{},
	TestID -> "[lagStateVarst] Context-mixed product expands equivalently",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*lagStateVarst - Cross-Time Index with Context Tests*)


(* Test: Product with different time variables in contexts *)
TestCreate[
	ExpandAll[$lagStateVarst[$pi[foo`t] $pi[t], foo`t-1, $testModel]] ===
	ExpandAll[$pi[t] $lagStateVarst[$pi[foo`t], foo`t-1, $testModel]],
	True,
	{},
	TestID -> "[lagStateVarst] pi[foo`t]*pi[t] factors out pi[t]",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Past inflation with current in different context *)
TestCreate[
	$lagStateVarst[$pi[foo`t-1] $pi[t], foo`t-1, $testModel] ===
	$pi[foo`t-1] $pi[t],
	True,
	{},
	TestID -> "[lagStateVarst] pi[foo`t-1]*pi[t] given foo`t-1 unchanged",
	MetaInformation -> <|"Category" -> "extended"|>
]


End[]
EndTestSection[]
