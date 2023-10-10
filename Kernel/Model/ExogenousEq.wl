(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"]


(* ::Subsection:: *)
(*Public symbols*)


(*public symbols declared here that end in "eq" define exogenous variables*)
xeq::usage = "xeq[t] gives the exogenous dynamics of long-run risk.";
pieq::usage = "pieq[t] gives the exogenous dynamics of inflation.";
pibareq::usage = "pibareq[t] gives the exogenous dynamics of expected inflation.";
dceq::usage = "dceq[t] gives the exogenous dynamics of real consumption growth.";
sgeq::usage = "sgeq[t] gives the exogenous dynamics of the nominal-real covariance (NRC).";
sxeq::usage = "sxeq[t] gives the exogenous dynamics of stochastic volatility of long-run risk.";
sceq::usage = "sceq[t] gives the exogenous dynamics of stochastic volatility of real consumption growth.";
speq::usage = "speq[t] gives the exogenous dynamics of long-run risk stochastic volatility of inflation.";
ddeq::usage = "ddeq[t,i] gives the exogenous dynamics of real dividend growth for stock i.";


(*globals to share across packages*)
$exogenousVars=SortBy[Select[Names[$Context<>"*"],Not[StringStartsQ[#,"$"]]&],PositionIndex[{"xeq","pieq","pibareq","dceq","sgeq","sxeq","sceq","speq","ddeq"}]];(*SortBy have exogenous variables in a given canonical order*)
$exogenousVarsStocks={"ddeq"};
$exogenousVarsNoStocks=SortBy[Complement[$exogenousVars,$exogenousVarsStocks],PositionIndex[$exogenousVars]];


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"]
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"]


(* ::Subsection:: *)
(*Private symbols*)


(*declare private symbols for exogenous variables that are the same as the public symbols but do not end in "eq"*)
$exogenousVarsPrivate = ((StringDrop[#,-2]&) /@ $exogenousVars)
Symbol/@ $exogenousVarsPrivate;
(*inherit usage message*)
Function[sym,
	With[
		{
			symNew=Symbol@StringDrop[SymbolName@sym,-2]
		},
		AppendTo[
			Messages[symNew],
			HoldPattern[MessageName[symNew,"usage"]]:>StringReplace[
				Information[sym,"Usage"],
				{
					SymbolName@sym->SymbolName@symNew,
					"gives"->"represents",
					"the exogenous dynamics of"->""
				}
			]/;StringQ[MessageName[sym,"usage"]]
		];
	];
	,
	HoldAll
]@@@(Hold /@ Symbol /@ $exogenousVars);


(*make index variables be maintained as exact integers, rather than being converted by N to approximate numbers*)
SetAttributes[$exogenousVarsPrivate,NHoldAll]


(* ::Subsection:: *)
(*Exogenous processes*)


(* ::Subsubsection:: *)
(*Long-run risk*)


xeq[t_]:=
	rhox x[t-1]+rhoxpbar * (pibar[t-1]-mupbar)+
	phix Sqrt[sx[t-1]+Esx^2] eps["x"][t] +
	phixc Sqrt[sc[t-1]+Esc^2] eps["dc"][t] 


(* ::Subsubsection:: *)
(*Inflation*)


pieq[t_]:=
	mup+
	rhoppbar * (pibar[t-1]-mupbar)+
	rhop * (pi[t-1]-mup)+
	phip eps["pi"][t]+
	xip eps["pi"][t-1]+
	phipc Sqrt[sc[t-1]+Esc^2] eps["dc"][t]+
	phipx Sqrt[sx[t-1]+Esx^2] eps["x"][t] +
	phipcx Sqrt[sc[t-1]+Esc^2] eps["x"][t] +
	phipp Sqrt[sp[t-1]+Esp^2] eps["pi"][t]+
	phipxp Sqrt[sx[t-1]+Esx^2] eps["pi"][t]


(* ::Subsubsection:: *)
(*Expected inflation*)


pibareq[t_]:= 
	mupbar+
	rhopbar * (pibar[t-1]-mupbar)+ 
	rhopbarx x[t-1]+
	phipbarp eps["pi"][t]+
	phipbarc Sqrt[sc[t-1]+Esc^2] eps["dc"][t]+ 
	phipbarx Sqrt[sx[t-1]+Esx^2] eps["x"][t]+
	phipbarcx Sqrt[sc[t-1]+Esc^2] eps["x"][t]+
	phipbarpb Sqrt[sp[t-1]+Esp^2] eps["pibar"][t]+
	phipbarxb Sqrt[sx[t-1]+Esx^2] eps["pibar"][t]+
	phipbarxp Sqrt[sx[t-1]+Esx^2] eps["pi"][t]


(* ::Subsubsection:: *)
(*Real consumption growth*)


dceq[t_]:= 
	muc+
	rhocx x[t-1]+
	rhocp * (pi[t-1]-mup)+
	phic eps["dc"][t]+
	phicp eps["pi"][t]+
	phicsp sg[t-1] eps["pi"][t]+
	xic sg[t-2] eps["pi"][t-1] + 
	phics Sqrt[sx[t-1]+Esx^2] eps["x"][t]+
	phicx Sqrt[sx[t-1]+Esx^2] eps["dc"][t]+
	phicc Sqrt[sc[t-1]+Esc^2] eps["dc"][t]+
	phicpc Sqrt[sp[t-1]+Esp^2] eps["dc"][t]+
	phicpp Sqrt[sp[t-1]+Esp^2] eps["pi"][t]


(* ::Subsubsection:: *)
(*Nominal - real covariance (NRC)*)


sgeq[t_]:= 
	Esg + 
	rhog * (sg[t-1]-Esg)+
	rhogp (pi[t-1]-mup)+
	rhogpbar (pibar[t-1]-mupbar)+
	phig eps["sg"][t]


(* ::Subsubsection:: *)
(*Stochastic volatility of long-run risk*)


sxeq[t_]:= 
	vx sx[t-1]+
	phisxs eps["sx"][t]


(* ::Subsubsection:: *)
(*Stochastic volatility of consumption growth*)


sceq[t_]:= 
	vc sc[t-1]+
	phiscv eps["sc"][t]


(* ::Subsubsection:: *)
(*Stochastic volatility of inflation*)


speq[t_]:= 
	vp sp[t-1]+
	vpp * (pi[t-1]-mup)+
	vppbar * (pibar[t-1]-mupbar)+
	phispw eps["sp"][t]  


(* ::Subsubsection:: *)
(*Real dividend growth for stock i*)


ddeq[t_,i_]:= 
	mud[i]+
	rhodx[i]x[t-1]+
	rhodp[i] * (pi[t-1]-mup)+ 
	phidc[i] eps["dc"][t]+ 
	phidp[i] eps["pi"][t]+
	phidsp[i] sg[t-1]eps["pi"][t]+
	xid[i] sg[t-2] eps["pi"][t-1]+
	phids[i] Sqrt[sx[t-1]+Esx^2] eps["x"][t]+
	phidxc[i] Sqrt[sx[t-1]+Esx^2] eps["dc"][t]+
	phidcc[i] Sqrt[sc[t-1]+Esc^2] eps["dc"][t]+ 
	phidpc[i] Sqrt[sp[t-1]+Esp^2] eps["dc"][t]+
	phidpp[i] Sqrt[sp[t-1]+Esp^2] eps["pi"][t]+
	phidxd[i] Sqrt[sx[t-1]+Esx^2] eps["dd"][t,i]+ 
	phidcd[i] Sqrt[sc[t-1]+Esc^2] eps["dd"][t,i] +
	phidpd[i] Sqrt[sp[t-1]+Esp^2] eps["dd"][t,i]


(* ::Section:: *)
(*End package*)


End[](*"`Private`"*)


EndPackage[]
