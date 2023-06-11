(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Model`Parameters`"]


(* ::Subsection:: *)
(*Public symbols*)


(*preferences*)
	delta::usage = "Description of parameter (needs to be added).";
	psi::usage = "Description of parameter (needs to be added).";
	gamma::usage = "Description of parameter (needs to be added).";
	theta::usage = "Description of parameter (needs to be added).";
(*long-run risk*)
	rhox::usage = "Description of parameter (needs to be added).";
	rhoxpbar::usage = "Description of parameter (needs to be added).";
	phix::usage = "Description of parameter (needs to be added).";
	phixc::usage = "Description of parameter (needs to be added).";
(*inflation*)
	mup::usage = "Description of parameter (needs to be added).";
	rhoppbar::usage = "Description of parameter (needs to be added).";
	rhop::usage = "Description of parameter (needs to be added).";
	phip::usage = "Description of parameter (needs to be added).";
	xip::usage = "Description of parameter (needs to be added).";
	phipc::usage = "Description of parameter (needs to be added).";
	phipx::usage = "Description of parameter (needs to be added).";
	phipcx::usage = "Description of parameter (needs to be added).";
	phipp::usage = "Description of parameter (needs to be added).";
	phipxp::usage = "Description of parameter (needs to be added).";
(*expected inflation*)
	mupbar::usage = "Description of parameter (needs to be added).";
	rhopbar::usage = "Description of parameter (needs to be added).";
	rhopbarx::usage = "Description of parameter (needs to be added).";
	phipbarp::usage = "Description of parameter (needs to be added).";
	phipbarc::usage = "Description of parameter (needs to be added).";
	phipbarx::usage = "Description of parameter (needs to be added).";
	phipbarcx::usage = "Description of parameter (needs to be added).";
	phipbarpb::usage = "Description of parameter (needs to be added).";
	phipbarxb::usage = "Description of parameter (needs to be added).";
	phipbarxp::usage = "Description of parameter (needs to be added).";
(*real consumption growth*)
	muc::usage = "Description of parameter (needs to be added).";
	rhocx::usage = "Description of parameter (needs to be added).";
	rhocp::usage = "Description of parameter (needs to be added).";
	phic::usage = "Description of parameter (needs to be added).";
	phicp::usage = "Description of parameter (needs to be added).";
	phicsp::usage = "Description of parameter (needs to be added).";
	xic::usage = "Description of parameter (needs to be added).";
	phics::usage = "Description of parameter (needs to be added).";
	phicx::usage = "Description of parameter (needs to be added).";
	phicc::usage = "Description of parameter (needs to be added).";
	phicpc::usage = "Description of parameter (needs to be added).";
	phicpp::usage = "Description of parameter (needs to be added).";
(*nominal-real covariance (NRC)*)
	Esg::usage = "Description of parameter (needs to be added).";
	rhog::usage = "Description of parameter (needs to be added).";
	phig::usage = "Description of parameter (needs to be added).";
(*stochastic volatility of long-run risk*)
	Esx::usage = "Description of parameter (needs to be added).";
	vx::usage = "Description of parameter (needs to be added).";
	phisxs::usage = "Description of parameter (needs to be added).";
(*stochastic volatility of consumption growth*)
	Esc::usage = "Description of parameter (needs to be added).";
	vc::usage = "Description of parameter (needs to be added).";
	phiscv::usage = "Description of parameter (needs to be added).";
(*stochastic volatility of inflation*)
	Esp::usage = "Description of parameter (needs to be added).";
	vp::usage = "Description of parameter (needs to be added).";
	vpp::usage = "Description of parameter (needs to be added).";
	vppbar::usage = "Description of parameter (needs to be added).";
	phispw::usage = "Description of parameter (needs to be added).";	
(*real dividend growth*)
	mud::usage = "Description of parameter (needs to be added).";
	rhodx::usage = "Description of parameter (needs to be added).";
	rhodp::usage = "Description of parameter (needs to be added).";
	phidc::usage = "Description of parameter (needs to be added).";
	phidp::usage = "Description of parameter (needs to be added).";
	phidsp::usage = "Description of parameter (needs to be added).";
	xid::usage = "Description of parameter (needs to be added).";
	phids::usage = "Description of parameter (needs to be added).";
	phidxc::usage = "Description of parameter (needs to be added).";
	phidcc::usage = "Description of parameter (needs to be added).";
	phidpc::usage = "Description of parameter (needs to be added).";
	phidpp::usage = "Description of parameter (needs to be added).";
	phidxd::usage = "Description of parameter (needs to be added).";
	phidcd::usage = "Description of parameter (needs to be added).";
	phidpd::usage = "Description of parameter (needs to be added).";
	taugd::usage = "Description of parameter (needs to be added).";


(*globals to share across packages*)
$parameters=Select[Names[$Context<>"*"],Not[StringStartsQ[#,"$"]]&];


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Assumptions on parameters*)


paramAssumptions = 
	(*preferences*)delta>0 && delta<1 && psi>0 && gamma>0 && theta!=0 &&
	(*process for x*)rhox>-1 && rhox<1 && 
	(*process for pi*) rhop>-1 && rhop<1 && 
	(*process for pibar*)rhopbar>-1 && rhopbar<1 && 
	(*process for sg*)rhog>-1 && rhog<1 &&
	(*process for sx*)vx>-1 && vx<1 && Esx>=0 && phisxs>=0 &&
	(*process for sc*)vc>-1 && vc<1 && Esc>=0 && phiscv>=0 &&
	(*process for sp*)vp>-1 && vp<1 && Esp>=0 && phispw>=0;


(* ::Section:: *)
(*End package*)


End[](*"`Private`"*)


EndPackage[]
