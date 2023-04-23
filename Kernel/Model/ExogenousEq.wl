(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"]


(* public symbols here that end in "eq" define exogenous variables *)
	xeq::usage = "x[t]"
	pieq::usage = "pieq[t]"
	pibareq::usage = "pibareq[t]"
	dceq::usage = "dceq[t]"
	sgeq::usage = "sgeq[t]"
	sxeq::usage = "sxeq[t]"
	sceq::usage = "sceq[t]"
	speq::usage = "speq[t]"
	ddeq::usage = "ddeq[t,i]"


(*globals to share across packages*)
$exogenousVars=SortBy[Select[Names[$Context<>"*"],Not[StringStartsQ[#,"$"]]&],PositionIndex[{"xeq","pieq","pibareq","dceq","sgeq","sxeq","sceq","speq","ddeq"}]];(*SortBy have exogenous variables in a given canonical order*)
$exogenousVarsStocks={"ddeq"};
$exogenousVarsNoStocks=SortBy[Complement[$exogenousVars,$exogenousVarsStocks],PositionIndex[$exogenousVars]];


Begin["`Private`"]


(*Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"]
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"]*)


(*Exogenous processes*)
(*Long-run risk*)
xeq[t_]=
	rhox x[t-1]+rhoxpbar * (pibar[t-1]-mupbar)+
	phix Sqrt[sx[t-1]+Esx^2] eps["x"][t] +
	phixc Sqrt[sc[t-1]+Esc^2] eps["dc"][t] 

(*Inflation*)
pieq[t_]=
	mup+
	rhoppbar * (pibar[t-1]-mupbar)+
	rhop * (pi[t-1]-mup)+
	phip eps["p"][t]+
	xip eps["p"][t-1]+
	phipc Sqrt[sc[t-1]+Esc^2] eps["dc"][t]+
	phipx Sqrt[sx[t-1]+Esx^2] eps["x"][t] +
	phipcx Sqrt[sc[t-1]+Esc^2] eps["x"][t] +
	phipp Sqrt[sp[t-1]+Esp^2] eps["p"][t]+
	phipxp Sqrt[sx[t-1]+Esx^2] eps["p"][t]

(*Expected inflation*)
pibareq[t_]= 
	mupbar+
	rhopbar * (pibar[t-1]-mupbar)+ 
	rhopbarx x[t-1]+
	phipbarp eps["p"][t]+
	phipbarc Sqrt[sc[t-1]+Esc^2] eps["dc"][t]+ 
	phipbarx Sqrt[sx[t-1]+Esx^2] eps["x"][t]+
	phipbarcx Sqrt[sc[t-1]+Esc^2] eps["x"][t]+
	phipbarpb Sqrt[sp[t-1]+Esp^2] eps["pibar"][t]+
	phipbarxb Sqrt[sx[t-1]+Esx^2] eps["pibar"][t]+
	phipbarxp Sqrt[sx[t-1]+Esx^2] eps["p"][t]

(*Real consumption growth*)
dceq[t_]= 
	muc+
	rhocx x[t-1]+
	rhocp * (pi[t-1]-mup)+
	phic eps["dc"][t]+
	phicp eps["p"][t]+
	phicsp sg[t-1] eps["p"][t]+
	xic sg[t-2] eps["p"][t-1] + 
	phics Sqrt[sx[t-1]+Esx^2] eps["x"][t]+
	phicx Sqrt[sx[t-1]+Esx^2] eps["dc"][t]+
	phicc Sqrt[sc[t-1]+Esc^2] eps["dc"][t]+
	phicpc Sqrt[sp[t-1]+Esp^2] eps["dc"][t]+
	phicpp Sqrt[sp[t-1]+Esp^2] eps["p"][t]

(*Nominal-real covariance (NRC)*)
sgeq[t_]= 
	Esg + 
	rhog * (sg[t-1]-Esg)+
	phig eps["sg"][t]

(*Stochastic volatility of long-run risk*)
sxeq[t_]= 
	vx sx[t-1]+
	phisxs eps["sx"][t]

(*Stochastic volatility of consumption growth*)
sceq[t_]= 
	vc sc[t-1]+
	phiscv eps["sc"][t]

(*Stochastic volatility of inflation*)
speq[t_]= 
	vp sp[t-1]+
	vpp * (pi[t-1]-mup)+
	vppbar * (pibar[t-1]-mupbar)+
	phispw eps["sp"][t]  

(*Real dividend growth for stock i*)
ddeq[t_,i_]= 
	mud[i]+
	rhodx[i]x[t-1]+
	rhodp[i] * (pi[t-1]-mup)+ 
	phidc[i] eps["dc"][t]+ 
	phidp[i] eps["p"][t]+
	phidsp[i] sg[t-1]eps["p"][t]+
	xid[i] sg[t-2] eps["p"][t-1]+
	phids[i] Sqrt[sx[t-1]+Esx^2] eps["x"][t]+
	phidxc[i] Sqrt[sx[t-1]+Esx^2] eps["dc"][t]+
	phidcc[i] Sqrt[sc[t-1]+Esc^2] eps["dc"][t]+ 
	phidpc[i] Sqrt[sp[t-1]+Esp^2] eps["dc"][t]+
	phidpp[i] Sqrt[sp[t-1]+Esp^2] eps["p"][t]+
	phidxd[i] Sqrt[sx[t-1]+Esx^2] eps["dd"][t,i]+ 
	phidcd[i] Sqrt[sc[t-1]+Esc^2] eps["dd"][t,i] +
	phidpd[i] Sqrt[sp[t-1]+Esp^2] eps["dd"][t,i]


End[](*"`Private`"*)


EndPackage[]
