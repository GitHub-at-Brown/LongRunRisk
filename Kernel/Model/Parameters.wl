(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`Model`Parameters`"]


(*preferences*)
	delta::usage = ""
	psi::usage = ""
	gamma::usage = ""
	theta::usage = ""
(*long-run risk*)
	rhox::usage = ""
	rhoxpbar::usage = ""
	phix::usage = ""
	phixc::usage = ""
(*inflation*)
	mup::usage = ""
	rhoppbar::usage = ""
	rhop::usage = ""
	phip::usage = ""
	xip::usage = ""
	phipc::usage = ""
	phipx::usage = ""
	phipcx::usage = ""
	phipp::usage = ""
	phipxp::usage = ""
(*expected inflation*)
	mupbar::usage = ""
	rhopbar::usage = ""
	rhopbarx::usage = ""
	phipbarp::usage = ""
	phipbarc::usage = ""
	phipbarx::usage = ""
	phipbarcx::usage = ""
	phipbarpb::usage = ""
	phipbarxb::usage = ""
	phipbarxp::usage = ""
(*real consumption growth*)
	muc::usage = ""
	rhocx::usage = ""
	rhocp::usage = ""
	phic::usage = ""
	phicp::usage = ""
	phicsp::usage = ""
	xic::usage = ""
	phics::usage = ""
	phicx::usage = ""
	phicc::usage = ""
	phicpc::usage = ""
	phicpp::usage = ""
(*nominal-real covariance (NRC)*)
	Esg::usage = ""
	rhog::usage = ""
	phig::usage = ""
(*stochastic volatility of long-run risk*)
	Esx::usage = ""
	vx::usage = ""
	phisxs::usage = ""
(*stochastic volatility of consumption growth*)
	Esc::usage = ""
	vc::usage = ""
	phiscv::usage = ""
(*stochastic volatility of inflation*)
	Esp::usage = ""
	vp::usage = ""
	vpp::usage = ""
	vppbar::usage = ""
	phispw::usage = ""	
(*real dividend growth*)
	mud::usage = ""
	rhodx::usage = ""
	rhodp::usage = ""
	phidc::usage = ""
	phidp::usage = ""
	phidsp::usage = ""
	xid::usage = ""
	phids::usage = ""
	phidxc::usage = ""
	phidcc::usage = ""
	phidpc::usage = ""
	phidpp::usage = ""
	phidxd::usage = ""
	phidcd::usage = ""
	phidpd::usage = ""
	taugd::usage = ""


(*globals to share across packages*)
$parameters=Select[Names[$Context<>"*"],Not[StringStartsQ[#,"$"]]&];


Begin["`Private`"]


(* assumptions on parameters *)
	paramAssumptions::usage = "modelAssumptions"
	
	paramAssumptions = 
	(*preferences*)delta>0 && delta<1 && psi>0 && gamma>0 && theta!=0 &&
	(*process for x*)rhox>-1 && rhox<1 && 
	(*process for pi*) rhop>-1 && rhop<1 && 
	(*process for pibar*)rhopbar>-1 && rhopbar<1 && 
	(*process for sg*)rhog>-1 && rhog<1 &&
	(*process for sx*)vx>-1 && vx<1 && Esx>=0 && phisxs>=0 &&
	(*process for sc*)vc>-1 && vc<1 && Esc>=0 && phiscv>=0 &&
	(*process for sp*)vp>-1 && vp<1 && Esp>=0 && phispw>=0;


End[](*"`Private`"*)


EndPackage[]
