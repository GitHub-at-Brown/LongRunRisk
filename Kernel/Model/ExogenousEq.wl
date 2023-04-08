(* ::Package:: *)

(*BeginPackage["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"]*)
BeginPackage["FernandoDuarte`LongRunRisk`"]


(* public symbols *)

(* public symbols here that end in "eq" define exogenous variables *)
	xeq::usage = "x[t]"
	pieq::usage = "pieq[t]"
	pibareq::usage = "pibareq[t]"
	dceq::usage = "dceq[t]"
	sgeq::usage = "sgeq[t]"
	sxeq::usage = "sxeq[t]"
	sceq::usage = "sceq[t]"
	speq::usage = "speq[t]"
	ddeq::usage = "ddeq[t]"

(* public symbols here that end in "eq" define exogenous variables *)
	x::usage = "x[t]"
	pi::usage = "pieq[t]"
	pibar::usage = "pibareq[t]"
	dc::usage = "dceq[t]"
	sg::usage = "sgeq[t]"
	sx::usage = "sxeq[t]"
	sc::usage = "sceq[t]"
	sp::usage = "speq[t]"
	dd::usage = "ddeq[t]"
	
(* parameters *)
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
		
(* assumptions on parameters *)
	modelAssumptions::usage = "modelAssumptions[t]"

(* rules that define the distribution of exogenous shocks *)
	rulesE::usage = "rulesE[t]"
	
(* exogenous shocks *)
	eps::usage = ""



Begin["`Private`"]


(*Exogenous processes*)
(*Long-run risk*)
xeq[t_]:=
	rhox x[t-1]+rhoxpbar * (pibar[t-1]-mupbar)+
	phix Sqrt[sx[t-1]+Esx^2] eps[\[FormalX]][t] +
	phixc Sqrt[sc[t-1]+Esc^2] eps[\[FormalC]][t] 

(*Inflation*)
pieq[t_]:=
	mup+
	rhoppbar * (pibar[t-1]-mupbar)+
	rhop * (pi[t-1]-mup)+
	phip eps[\[FormalP]][t]+
	xip eps[\[FormalP]][t-1]+
	phipc Sqrt[sc[t-1]+Esc^2] eps[\[FormalC]][t]+
	phipx Sqrt[sx[t-1]+Esx^2] eps[\[FormalX]][t] +
	phipcx Sqrt[sc[t-1]+Esc^2] eps[\[FormalX]][t] +
	phipp Sqrt[sp[t-1]+Esp^2] eps[\[FormalP]][t]+
	phipxp Sqrt[sx[t-1]+Esx^2] eps[\[FormalP]][t]

(*Expected inflation*)
pibareq[t_]:= 
	mupbar+
	rhopbar * (pibar[t-1]-mupbar)+ 
	rhopbarx x[t-1]+
	phipbarp eps[\[FormalP]][t]+
	phipbarc Sqrt[sc[t-1]+Esc^2] eps[\[FormalC]][t]+ 
	phipbarx Sqrt[sx[t-1]+Esx^2] eps[\[FormalX]][t]+
	phipbarcx Sqrt[sc[t-1]+Esc^2] eps[\[FormalX]][t]+
	phipbarpb Sqrt[sp[t-1]+Esp^2] eps[\[FormalB]][t]+
	phipbarxb Sqrt[sx[t-1]+Esx^2] eps[\[FormalB]][t]+
	phipbarxp Sqrt[sx[t-1]+Esx^2] eps[\[FormalP]][t]

(*Real consumption growth*)
dceq[t_]:= 
	muc+
	rhocx x[t-1]+
	rhocp * (pi[t-1]-mup)+
	phic eps[\[FormalC]][t]+
	phicp eps[\[FormalP]][t]+
	phicsp sg[t-1] eps[\[FormalP]][t]+
	xic sg[t-2] eps[\[FormalP]][t-1] + 
	phics Sqrt[sx[t-1]+Esx^2] eps[\[FormalX]][t]+
	phicx Sqrt[sx[t-1]+Esx^2] eps[\[FormalC]][t]+
	phicc Sqrt[sc[t-1]+Esc^2] eps[\[FormalC]][t]+
	phicpc Sqrt[sp[t-1]+Esp^2] eps[\[FormalC]][t]+
	phicpp Sqrt[sp[t-1]+Esp^2] eps[\[FormalP]][t]

(*Nominal-real covariance (NRC)*)
sgeq[t_]:= 
	Esg + 
	rhog * (sg[t-1]-Esg)+
	phig eps[\[FormalG]][t] 

(*Stochastic volatility of long-run risk*)
sxeq[t_]:= 
	vx sx[t-1]+
	phisxs eps[\[FormalS]][t]  

(*Stochastic volatility of consumption growth*)
sceq[t_]:= 
	vc sc[t-1]+
	phiscv eps[\[FormalV]][t]  

(*Stochastic volatility of inflation*)
speq[t_]:= 
	vp sp[t-1]+
	vpp * (pi[t-1]-mup)+
	vppbar * (pibar[t-1]-mupbar)+
	phispw eps[\[FormalW]][t]  

(*Real dividend growth for stock i*)
ddeq[t_,i_]:= 
	mud[i]+
	rhodx[i]x[t-1]+
	rhodp[i] * (pi[t-1]-mup)+ 
	phidc[i] eps[\[FormalC]][t]+ 
	phidp[i] eps[\[FormalP]][t]+
	phidsp[i] sg[t-1]eps[\[FormalP]][t]+
	xid[i] sg[t-2] eps[\[FormalP]][t-1]+
	phids[i] Sqrt[sx[t-1]+Esx^2] eps[\[FormalX]][t]+
	phidxc[i] Sqrt[sx[t-1]+Esx^2] eps[\[FormalC]][t]+
	phidcc[i] Sqrt[sc[t-1]+Esc^2] eps[\[FormalC]][t]+ 
	phidpc[i] Sqrt[sp[t-1]+Esp^2] eps[\[FormalC]][t]+
	phidpp[i] Sqrt[sp[t-1]+Esp^2] eps[\[FormalP]][t]+
	phidxd[i] Sqrt[sx[t-1]+Esx^2] eps[\[FormalD]][t,i]+ 
	phidcd[i] Sqrt[sc[t-1]+Esc^2] eps[\[FormalD]][t,i] +
	phidpd[i] Sqrt[sp[t-1]+Esp^2] eps[\[FormalD]][t,i]


(*assumptions*)
modelAssumptions = 
	(*preferences*)delta>0 && delta<1 && gamma>0 && psi>0 && theta!=0  &&
	(*process for x*)rhox>=0 && rhox<1 && Esx>=0 && 
	(*process for pi*)mup>=0 && rhop>=0 && rhop<1 && rhoppbar>=0 && Esc>=0 && 
	(*process for pibar*)mupbar>=0 && rhopbar>=0 && rhopbar<1 && 
	(*process for dc*)muc>=0  && rhog>=0 && rhog<1 && 
	(*process for sx*)vx>=0 && vx<1 && 
	(*process for sc*)vc>=0 && vc<1  && 
	(*process for sp*)Esp>=0 && vp>=0 && vp<1  && 
	(*shocks*)Element[eps[k___][t___], Reals];
	
(* distribution of exogenous shocks *)
(*for a normal distribution, we only need rules for how to compute expectations of products of shocks*)
rulesE[t_]:=With[
	{
		formals={\[FormalX],\[FormalC],\[FormalP],\[FormalB],\[FormalG],\[FormalS],\[FormalV],\[FormalW]}
	},
	{
		eps[\[FormalC]][t]*eps[\[FormalD]][t,i_]:>taugd[i],
		eps[var_][t]/;MemberQ[formals,var]:>0,
		eps[\[FormalD]][t,i_]:>0,
		eps[var_][t]^p_Integer/;MemberQ[formals,var]:>Expectation[y^p,y\[Distributed]NormalDistribution[0,1]],
		eps[\[FormalD]][t,i_]^p_Integer:>Expectation[y^p,y\[Distributed]NormalDistribution[0,1]]
	}
]


End[] (*"`Private`"*)


EndPackage[] (*Package*)
