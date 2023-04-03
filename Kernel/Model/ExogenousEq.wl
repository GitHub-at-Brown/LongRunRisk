(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"]


(* public symbols *)

(* public symbols here than end in "eq" define exogenous variables *)
xeq::usage = "x[t]"
pieq::usage = "pieq[t]"
pibareq::usage = "pibareq[t]"
dceq::usage = "dceq[t]"
sgeq::usage = "sgeq[t]"
sxeq::usage = "sxeq[t]"
sceq::usage = "sceq[t]"
speq::usage = "speq[t]"
ddeq::usage = "ddeq[t]"

(* other public symbols *)
modelAssumptions::usage = "modelAssumptions[t]"
rulesE::usage = "rulesE[t]"


Begin["`Private`"]


(*Exogenous processes*)
(*Long-run risk*)
xeq[t_]:=
	rhox x[t-1]+rhoxpbar * (pibar[t-1]-mupbar)+
	phix Sqrt[sx[t-1]+Esx^2] Subscript[\[CurlyEpsilon], x][t] +
	phixc Sqrt[sc[t-1]+Esc^2] Subscript[\[CurlyEpsilon],c][t] 

(*Inflation*)
pieq[t_]:=
	mup+
	rhoppbar * (pibar[t-1]-mupbar)+
	rhop * (pi[t-1]-mup)+
	phip Subscript[\[CurlyEpsilon], p][t]+
	xip Subscript[\[CurlyEpsilon], p][t-1]+
	phipc Sqrt[sc[t-1]+Esc^2] Subscript[\[CurlyEpsilon], c][t]+
	phipx Sqrt[sx[t-1]+Esx^2] Subscript[\[CurlyEpsilon], x][t] +
	phipcx Sqrt[sc[t-1]+Esc^2] Subscript[\[CurlyEpsilon], x][t] +
	phipp Sqrt[sp[t-1]+Esp^2] Subscript[\[CurlyEpsilon], p][t]+
	phipxp Sqrt[sx[t-1]+Esx^2] Subscript[\[CurlyEpsilon], p][t]

(*Expected inflation*)
pibareq[t_]:= 
	mupbar+
	rhopbar * (pibar[t-1]-mupbar)+ 
	rhopbarx x[t-1]+
	phipbarp Subscript[\[CurlyEpsilon], p][t]+
	phipbarc Sqrt[sc[t-1]+Esc^2] Subscript[\[CurlyEpsilon], c][t]+ 
	phipbarx Sqrt[sx[t-1]+Esx^2] Subscript[\[CurlyEpsilon], x][t]+
	phipbarcx Sqrt[sc[t-1]+Esc^2] Subscript[\[CurlyEpsilon], x][t]+
	phipbarpb Sqrt[sp[t-1]+Esp^2] Subscript[\[CurlyEpsilon],b][t]+
	phipbarxb Sqrt[sx[t-1]+Esx^2] Subscript[\[CurlyEpsilon],b][t]+
	phipbarxp Sqrt[sx[t-1]+Esx^2] Subscript[\[CurlyEpsilon],p][t]

(*Real consumption growth*)
dceq[t_]:= 
	muc+
	rhocx x[t-1]+
	rhocp * (pi[t-1]-mup)+
	phic Subscript[\[CurlyEpsilon], c][t]+
	phicp Subscript[\[CurlyEpsilon], p][t]+
	phicsp sg[t-1] Subscript[\[CurlyEpsilon], p][t]+
	xic sg[t-2] Subscript[\[CurlyEpsilon], p][t-1] + 
	phics Sqrt[sx[t-1]+Esx^2] Subscript[\[CurlyEpsilon], x][t]+
	phicx Sqrt[sx[t-1]+Esx^2] Subscript[\[CurlyEpsilon], c][t]+
	phicc Sqrt[sc[t-1]+Esc^2] Subscript[\[CurlyEpsilon], c][t]+
	phicpc Sqrt[sp[t-1]+Esp^2] Subscript[\[CurlyEpsilon], c][t]+
	phicpp Sqrt[sp[t-1]+Esp^2] Subscript[\[CurlyEpsilon], p][t]

(*Nominal-real covariance (NRC)*)
sgeq[t_]:= 
	Esg + 
	rhog * (sg[t-1]-Esg)+
	phig Subscript[\[CurlyEpsilon],g][t] 

(*Stochastic volatility of long-run risk*)
sxeq[t_]:= 
	vx sx[t-1]+
	phisxs Subscript[\[CurlyEpsilon], s][t]  

(*Stochastic volatility of consumption growth*)
sceq[t_]:= 
	vc sc[t-1]+
	phiscv Subscript[\[CurlyEpsilon], v][t]  

(*Stochastic volatility of inflation*)
speq[t_]:= 
	vp sp[t-1]+
	vpp * (pi[t-1]-mup)+
	vppbar * (pibar[t-1]-mupbar)+
	phispw Subscript[\[CurlyEpsilon], w][t]  

(*Real dividend growth for stock i*)
ddeq[t_,i_]:= 
	mud[i]+
	rhodx[i]x[t-1]+
	rhodp[i] * (pi[t-1]-mup)+ 
	phidc[i] Subscript[\[CurlyEpsilon], c][t]+ 
	phidp[i] Subscript[\[CurlyEpsilon], p][t]+
	phidsp[i] sg[t-1]Subscript[\[CurlyEpsilon], p][t]+
	xid[i] sg[t-2] Subscript[\[CurlyEpsilon], p][t-1]+
	phids[i] Sqrt[sx[t-1]+Esx^2] Subscript[\[CurlyEpsilon], x][t]+
	phidxc[i] Sqrt[sx[t-1]+Esx^2] Subscript[\[CurlyEpsilon], c][t]+
	phidcc[i] Sqrt[sc[t-1]+Esc^2] Subscript[\[CurlyEpsilon], c][t]+ 
	phidpc[i] Sqrt[sp[t-1]+Esp^2] Subscript[\[CurlyEpsilon], c][t]+
	phidpp[i] Sqrt[sp[t-1]+Esp^2] Subscript[\[CurlyEpsilon], p][t]+
	phidxd[i] Sqrt[sx[t-1]+Esx^2] Subscript[\[CurlyEpsilon], d][t,i]+ 
	phidcd[i] Sqrt[sc[t-1]+Esc^2] Subscript[\[CurlyEpsilon], d][t,i] +
	phidpd[i] Sqrt[sp[t-1]+Esp^2] Subscript[\[CurlyEpsilon], d][t,i]

(*assumptions*)
modelAssumptions = 
	(*process for x*)rhox>=0 && rhox<1 && Esx>=0 && 
	(*process for pi*)mup>=0 && rhop>=0 && rhop<1 && rhoppbar>=0 && Esc>=0 && 
	(*process for pibar*)mupbar>=0 && rhopbar>=0 && rhopbar<1 && 
	(*process for dc*)muc>=0  && rhog>=0 && rhog<1 && 
	(*process for sx*)vx>=0 && vx<1 && 
	(*process for sc*)vc>=0 && vc<1  && 
	(*process for sp*)Esp>=0 && vp>=0 && vp<1  && 
	(*preferences*)theta!=0 && psi>1 && delta>0 && delta<1 && gamma>0 && 
	(*coefficients of wc*)Element[Subscript[A, s___],Reals]  && 
	(*coefficients of pd*)Element[Subscript[D, s___][i___],Reals] && 
	(*coefficients of real bond prices*)Element[Subscript[R, s___][n___],Reals] && 
	(*coefficients of nominal bond prices*)Element[Subscript[P, s___][n___],Reals] && 
	(*shocks*)Element[Subscript[\[CurlyEpsilon], k___][t___],Reals] && 
	(*linearization constants*)
	Subscript[\[Kappa], 0]>0 && Subscript[\[Kappa], 0]<1 && 
	Subscript[\[Kappa], 1]>0&& Subscript[\[Kappa], 1]<1 && 
	Subscript[\[Kappa],0,m][i___]>0 && Subscript[\[Kappa],0,m][i___]<1 && 
	Subscript[\[Kappa],1,m][i___]>0&& Subscript[\[Kappa],1,m][i___]<1;

(* distribution of exogenous shocks *)
(*for a normal distribution, we only need rules for how to compute expectations of products of shocks*)
rulesE[t_]:=Module[{i,p},
	{
		Subscript[\[CurlyEpsilon], c][t]Subscript[\[CurlyEpsilon], d][t,i_]:>taugd[i],
		Subscript[\[CurlyEpsilon], _][t,___]:>0,
		Subscript[\[CurlyEpsilon], _][t,___]^p_Integer:>Expectation[x^p,x\[Distributed]NormalDistribution[0,1]]
	}
]




End[] (*"`Private`"*)
EndPackage[] (*Package*)
