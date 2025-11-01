(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Model`Parameters`"]


(* ::Subsection:: *)
(*Public symbols*)


(* ::Subsubsection:: *)
(*Usage*)


(*preferences*)
	delta::usage = "Discount factor.";
	psi::usage = "Elasticity of intertemporal substitution.";
	gamma::usage = "Risk aversion coefficient.";
	theta::usage = "Defined by \[Theta] := \!\(\*FractionBox[\(1 - \[Gamma]\), \(1 - \*FractionBox[\(1\), \(\[Psi]\)]\)]\).";
(*long-run risk*)
	rhox::usage = "Persistence of long-run risk, AR(1) coefficient.";
	rhoxpbar::usage = "Exposure of long-run risk to lagged expected inflation.";
	phix::usage = "Exposure of long-run risk to stochastic volatility of long-run risk and long-run risk shocks.";
	phixc::usage = "Exposure of long-run risk to stochastic volatility of consumption growth and consumption growth shocks.";
(*inflation*)
	mup::usage = "Mean of inflation rate.";
	rhoppbar::usage = "Exposure of inflation to lagged expected inflation.";
	rhop::usage = "Persistence of inflation, AR(1) coefficient.";
	phip::usage = "Exposure of inflation to inflation shocks.";
	xip::usage = "Exposure of inflation to lagged inflation shocks.";
	phipc::usage = "Exposure of inflation to stochastic volatility of consumption growth and consumption growth shocks.";
	phipx::usage = "Exposure of inflation to stochastic volatility of long-run risk and long-run risk shocks.";
	phipcx::usage = "Exposure of inflation to stochastic volatility of consumption growth and long-run risk shocks.";
	phipp::usage = "Exposure of inflation to stochastic volatility of inflation and inflation shocks.";
	phipxp::usage = "Exposure of inflation to stochastic volatility of long-run risk and inflation shocks.";
(*expected inflation*)
	mupbar::usage = "Mean of expected inflation.";
	rhopbar::usage = "Persistence of expected inflation, AR(1) coefficient.";
	rhopbarx::usage = "Exposure of expected inflation to lagged long-run risk.";
	phipbarp::usage = "Exposure of expected inflation to inflation shocks.";
	phipbarc::usage = "Exposure of expected inflation to stochastic volatility of consumption growth and consumption growth shocks.";
	phipbarx::usage = "Exposure of expected inflation to stochastic volatility of long-run risk and long-run risk shocks.";
	phipbarcx::usage = "Exposure of expected inflation to stochastic volatility of consumption growth and long-run risk shocks.";
	phipbarpb::usage = "Exposure of expected inflation to stochastic volatility of inflation and expected inflation shocks.";
	phipbarxb::usage = "Exposure of expected inflation to stochastic volatility of long-run risk and expected inflation shocks.";
	phipbarxp::usage = "Exposure of expected inflation to stochastic volatility of long-run risk and inflation shocks.";
(*real consumption growth*)
	muc::usage = "Mean of consumption growth.";
	rhocx::usage = "Exposure of consumption growth to lagged long-run risk.";
	rhocp::usage = "Exposure of consumption growth to lagged inflation.";
	rhocpbar::usage = "Exposure of consumption growth to lagged expected inflation.";
	phic::usage = "Exposure of consumption growth to consumption growth shocks.";
	phicp::usage = "Exposure of consumption growth to inflation shocks.";
	phicsp::usage = "Exposure of consumption growth to lagged nominal-real covariance and inflation shocks.";
	xic::usage =  "Exposure of consumption growth to nominal-real covariance two periods ago and lagged inflation shocks.";
	phics::usage = "Exposure of consumption growth to stochastic volatility of long-run risk and long-run risk shocks.";
	phicx::usage = "Exposure of consumption growth to stochastic volatility of long-run risk and consumption growth shocks.";
	phicc::usage = "Exposure of consumption growth to stochastic volatility of consumption growth and consumption growth shocks.";
	phicpc::usage = "Exposure of consumption growth to stochastic volatility of inflation and consumption growth shocks.";
	phicpp::usage = "Exposure of consumption growth to stochastic volatility of inflation and inflation shocks.";
(*nominal-real covariance (NRC)*)
	Esg::usage = "Mean of nominal-real covariance.";
	rhog::usage = "Persistence of nominal-real covariance, AR(1) coefficient.";
	rhogp::usage = "Exposure of nominal-real covariance to lagged inflation.";
	rhogpbar::usage = "Exposure of nominal-real covariance to lagged expected inflation.";
	phig::usage = "Volatility of nominal-real covariance.";
(*stochastic volatility of long-run risk*)
	Esx::usage = "Mean of stochastic volatility of long-run risk.";
	vx::usage = "Persistence of stochastic volatility of long-run risk, AR(1) coefficient.";
	phisxs::usage = "Volatility of stochastic volatility of long-run risk.";
(*stochastic volatility of consumption growth*)
	Esc::usage = "Mean of stochastic volatility of consumption growth.";
	vc::usage = "Persistence of stochastic volatility of consumption growth, AR(1) coefficient.";
	phiscv::usage = "Volatility of stochastic volatility of consumption growth.";
(*stochastic volatility of inflation*)
	Esp::usage = "Mean of stochastic volatility of inflation.";
	vp::usage = "Persistence of stochastic volatility of inflation, AR(1) coefficient.";
	vpp::usage = "Exposure of stochastic volatility of inflation to lagged inflation.";
	vppbar::usage = "Exposure of stochastic volatility of inflation to lagged expected inflation.";
	phispw::usage = "Volatility of stochastic volatility of inflation.";
(*real dividend growth*)
	mud::usage = "Mean of real dividend growth.";
	rhodx::usage = "Exposure of dividend growth to lagged long-run risk.";
	rhodp::usage = "Exposure of dividend growth to lagged inflation.";
	phidc::usage = "Exposure of dividend growth to consumption growth shocks.";
	phidp::usage = "Exposure of dividend growth to inflation shocks.";
	phidsp::usage = "Exposure of dividend growth to lagged nominal-real covariance and inflation shocks.";
	xid::usage = "Exposure of dividend growth to nominal-real covariance two periods ago and lagged inflation shocks.";
	phids::usage = "Exposure of dividend growth to stochastic volatility of long-run risk and long-run risk shocks.";
	phidxc::usage = "Exposure of dividend growth to stochastic volatility of long-run risk and consumption growth shocks.";
	phidcc::usage = "Exposure of dividend growth to stochastic volatility of consumption growth and consumption growth shocks.";
	phidpc::usage = "Exposure of dividend growth to stochastic volatility of inflation and consumption growth shocks.";
	phidpp::usage = "Exposure of dividend growth to stochastic volatility of inflation and inflation shocks.";
	phidxd::usage = "Exposure of dividend growth to stochastic volatility of long-run risk and dividend growth shocks.";
	phidcd::usage = "Exposure of dividend growth to stochastic volatility of consumption growth and dividend growth shocks.";
	phidpd::usage = "Exposure of dividend growth to stochastic volatility of inflation and dividend growth shocks.";
	taugd::usage = "Correlation between shocks to consumption growth and dividend growth.";


(* ::Subsubsection:: *)
(*Shared global symbols*)


(*globals to share across packages*)
$parameters=Select[Names[$Context<>"*"],Not[StringStartsQ[#,"$"]]&];


(* ::Section::Closed:: *)
(*Code*)


Begin["`Private`"]


(*make index variables be maintained as exact integers, rather than being converted by N to approximate numbers*)
SetAttributes[$parameters,NHoldAll]


(*parameters split by categories*)
paramList={
{"Preferences",{delta,psi,gamma,theta}},
{"Long-run risk",{rhox,rhoxpbar,phix,phixc}},
{"Inflation",{mup,rhoppbar,rhop,phip,xip,phipc,phipcx,phipx,phipp,phipxp}},
{"Expected inflation",{mupbar,rhopbar,rhopbarx,phipbarc,phipbarcx,phipbarx,phipbarp,phipbarxb,phipbarpb,phipbarxp}},
{"Real consumption growth",{muc,rhocx,rhocp,phics,phicx,phicc,phicpp,phicpc,phic,phicsp,xic,phicp}},
{"Nominal-real covariance (NRC)",{Esg,rhog,rhogp,rhogpbar,phig}},
{"Stochastic volatility of long-run risk",{Esx,vx,phisxs}},
{"Stochastic volatility of consumption growth",{Esc,vc,phiscv}},
{"Stochastic volatility of inflation",{Esp,vp,vpp,vppbar,phispw}},
{"Real dividend growth",{mud[1],rhodx[1],rhodp[1],phidxd[1],phids[1],phidxc[1],phidpp[1],phidpd[1],phidcc[1],phidpc[1],phidcd[1],phidsp[1],xid[1],phidp[1],phidc[1],taugd[1]}}
};


(* ::Subsection:: *)
(*Assumptions on parameters*)


paramAssumptions = 
	(*preferences*)delta>0 && delta<1 && psi>0 && gamma>0 &&(theta<0||theta>0) &&
	(*process for x*)rhox>-1 && rhox<1 && 
	(*process for pi*) rhop>-1 && rhop<1 && 
	(*process for pibar*)rhopbar>-1 && rhopbar<1 && 
	(*process for sg*)rhog>-1 && rhog<1 &&
	(*process for sx*)vx>-1 && vx<1 && Esx>=0 && phisxs>=0 &&
	(*process for sc*)vc>-1 && vc<1 && Esc>=0 && phiscv>=0 &&
	(*process for sp*)vp>-1 && vp<1 && Esp>=0 && phispw>=0;


(* ::Section::Closed:: *)
(*End package*)


End[](*"`Private`"*)


EndPackage[]
