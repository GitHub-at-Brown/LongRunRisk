(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"]


(* ::Subsection:: *)
(*Public symbols*)


(* ::Subsubsection:: *)
(*Usage*)


wceq::usage = "wceq[t] gives the log wealth-consumption ratio at time t.";
pdeq::usage = "pdeq[t, i] gives the log price-dividend ratio of stock i at time t.";
bondeq::usage = "bondeq[t, m] gives the log price of a real m -month maturity discount (zero-coupon) riskless bond at time t.";
nombondeq::usage = "nombondeq[t, m] gives the log price of a nominal m -month maturity discount (zero-coupon) riskless bond at time t.";
sdfeq::usage = "sdfeq[t] gives the (real) stochastic discount factor at time t.";
nomsdfeq::usage = "nomsdfeq[t] gives the nominal stochastic discount factor at time t.";
retceq::usage = "retceq[t] gives the return for the asset that pays consumption as dividends each period.";
reteq::usage = "reteq[t, i] gives the return for stock i. Stock i is defined as the asset that pays dividends ddeq[i].";
kappa1eq::usage = "kappa1eq[mu] is the Campbell-Shiller approximation constant kappa1=Exp[ mu ]/(Exp[ mu ]-1) where mu is the unconditional mean of the log of the approximated variable.";
kappa0eq::usage = "kappa0eq[mu] is the Campbell-Shiller approximation constant kappa0=-Log[Exp[ mu ]-1]+Ewc Exp[ mu ]/(Exp[ mu ]-1) where mu is the unconditional mean of the log of the approximated variable.";
excretceq::usage = "excretceq[t] gives the return for the asset that pays consumption as dividends each period in excess of the risk-free rate.";
excreteq::usage = "excreteq[t, i] gives the return for stock i in excess of the risk-free rate.";
bondyieldeq::usage = "bondyieldeq[t, m] gives the log yield of a real m -month maturity discount (zero-coupon) riskless bond at time t.";
nombondyieldeq::usage = "nombondyieldeq[t, m] gives the log yield of a nominal m -month maturity discount (zero-coupon) riskless bond at time t.";
bondfweq::usage = "bondfweq[t, m] gives the real log forward rate at time t for riskless loansbetween times t + m -1 and t + m."<>"\n"<>
				  "bondfweq[t, m, h] gives the real log forward rate at time t for riskless loansbetween times t + m - h and t + m.";
nombondfweq::usage = "nombondfweq[t, m] gives the nominal log forward rate at time t for riskless loans between times t + m - 1 and t + m."<>"\n"<>
					 "nombondfweq[t, m, h] gives the nominal log forward rate at time t for riskless loans between times t + m - h and t + m.";
bondreteq::usage = "bondreteq[t, m] gives the log holding period return from buying a real m -month maturity discount (zero-coupon) riskless bond at time t -1 and selling it as an (m - 1)-month maturity bond at time t."<>"\n"<>
				   "bondreteq[t, m, h] gives the log h - period return from buying a real m -month maturity discount (zero-coupon) riskless bond at time t - h and selling it as an (m - h)-month maturity bond at time t.";
nombondreteq::usage = "nombondreteq[t, m] gives the log holding period return from buying a nominal m -month maturity discount (zero-coupon) riskless bond at time t -1 and selling it as an (m -1)-month maturity bond at time t."<>"\n"<>
					  "nombondreteq[t, m, h] gives the log h - period return from buying a nominal m -month maturity discount (zero-coupon) riskless bond at time t - h and selling it as an (m - h)-month maturity bond at time t.";
bondfwspreadeq::usage = "bondfwspreadeq[t, m] gives the real log forward rate at time t for riskless loans between times t + m -1 and t + m, in excess of the one-period risk-free rate."<>"\n"<>
						"bondfwspreadeq[t, m, h] gives the real log forward rate at time t for riskless loans between times t + m - h and t + m, in excess of the h - period risk-free rate earned by investing in an h-month maturity real discount (zero-coupon) riskless bond between times t and t + h.";
nombondfwspreadeq::usage = "nombondfwspreadeq[t, m] gives the nominal log forward rate at time t for riskless loans between times t + m -1 and t + m, in excess of the one-period nominal risk-free rate."<>"\n"<>
						   "nombondfwspreadeq[t, m, h] gives the nominal log forward rate at time t for riskless loans between times t + m - h and t + m, in excess of the h - period risk-free rate earned by investing in an h-month maturity nominal discount (zero-coupon) riskless bond between times t and t + h.";
bondexcreteq::usage = "bondexcreteq[t, m] gives the log holding period excess return from buying a real m -month maturity discount (zero-coupon) riskless bond at time t -1 and selling it as an (m -1)-month maturity riskless bond at time t, in excess of the one-period risk-free rate."<>"\n"<>
				  	"bondexcreteq[t, m, h] gives the log h - period excess return from buying a real m -month maturity discount (zero-coupon) riskless bond at time t - h and selling it as an (m - h)-month maturity riskless bond at time t, in excess of the h - period risk-free rate earned by investing in an h-month maturity real discount (zero-coupon) riskless bond between times t - h and t.";
nombondexcreteq::usage = "nombondexcreteq[t, m] gives the log holding period excess return from buying a nominal m -month maturity discount (zero-coupon) riskless bond at time t -1 and selling it as an (m -1)-month maturity riskless bond at time t, in excess of the one-period nominal risk-free rate."<>"\n"<>
						 "nombondexcreteq[t, m, h] gives the log h - period excess return from buying a nominal m -month maturity discount (zero-coupon) riskless bond at time t - h and selling it as an (m - h)-month maturity riskless bond at time t, in excess of the h - period risk-free rate earned by investing in an h-month maturity nominal discount (zero-coupon) riskless bond between times t - h and t.";
rfeq::usage = "rfeq[t] gives the one-period real risk-free rate at time t for loans between t and t + 1."<>"\n"<>
			  "rfeq[t, h] gives the h - period real risk-free rate at time t for loans between t and t + h. rfeq[t, h] is the same as bondyield[t, h].";
nomrfeq::usage = "nomrfeq[t] gives the one-period nominal risk-free rate at time t for loans between t and t + 1."<>"\n"<>
				 "nomrfeq[t, h] gives the h - period nominal risk-free rate at time t for loans between t and t + h. nomrfeq[t, h] is the same as nombondyield[t, h].";


(* ::Subsubsection::Closed:: *)
(*Shared global symbols*)


$endogenousVars=SortBy[Select[Names[$Context<>"*"],Not[StringStartsQ[#,"$"]]&],PositionIndex[{"wceq","pdeq","bondeq","nombondeq"}]];(*SortBy have exogenous variables in a given canonical order*)


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];
Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
$ContextPath=AppendTo[
	$ContextPath,
	"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"
];


(* ::Subsection:: *)
(*Private symbols that have the same name as public symbols but do not end in "eq"*)


(*declare symbols*)
$endogenousVarsPrivate = ((StringDrop[#,-2]&) /@ $endogenousVars)
Symbol/@ $endogenousVarsPrivate;


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
					"gives"->"represents"
				}
			]/;StringQ[MessageName[sym,"usage"]]
		];
	];
	,
	HoldAll
]@@@(Hold /@ Symbol /@ $endogenousVars);


(*make index variables be maintained as exact integers, rather than being converted by N to approximate numbers*)
SetAttributes[$endogenousVarsPrivate,NHoldAll]


(* ::Subsection:: *)
(*time variable*)


t::usage = "t denotes time.";


(* ::Subsection:: *)
(*wceq, pdeq, bondeq, nombondeq*)


(*the wealth-consumption ratio, the price-dividend ratios for stocks and bond prices are linear in stateVars*)
wceq /: stateVars_Function[wceq] := ({t_} :> linearInStateVars[stateVars[t],A])/. dv
pdeq /: stateVars_Function[pdeq] := ({t_,i_}:>linearInStateVars[stateVars[t],B[i]])/. dv
bondeq /: stateVars_Function[bondeq] := ({t_,m_}:>linearInStateVars[stateVars[t],R[m]])/. dv
nombondeq /: stateVars_Function[nombondeq] := ({t_,m_}:>linearInStateVars[stateVars[t],P[m]])/. dv


(* ::Subsubsection:: *)
(*linearInStateVars*)


linearInStateVars[stateVars_,coeff_]:= Module[
	{
		stateVarsWith1=Prepend[stateVars,1],
		coeffs=Table[coeff[j],{j,0,Length[stateVars]}]
	},	
		Dot[coeffs,stateVarsWith1]
]
dv=DownValues@linearInStateVars;


(* ::Subsection:: *)
(*Log stochastic discount factor*)


sdfeq[t_] := theta Log[delta]-(theta/psi)dc[t]+(theta-1)retc[t]
nomsdfeq[t_] := sdf[t]-pi[t]


(* ::Subsection:: *)
(*Return on wealth and stocks*)


(*campbell-shiller approximation for returns as in Bansal Yaron*)
retceq[t_] := kappa0[Ewc] + kappa1[Ewc] wc[t]-wc[t-1]+dc[t]
reteq[t_,i_] := kappa0[Epd[i]] + kappa1[Epd[i]]pd[t,i]-pd[t-1,i]+dd[t,i]
kappa1eq[mu_] := Exp[mu]/(Exp[mu]+1)
kappa0eq[mu_] := Log[Exp[mu]+1]-kappa1eq[mu]*mu

(*campbell-shiller approximation for returns as in Koijen, Lustig, Van Nieuwerburgh and Verdelhan*)
(*
retceq[t_] := kappa0[Ewc]+wc[t]-kappa1[Ewc] wc[t-1]+dc[t]
reteq[t_,i_] := kappa0[Epd[i]]+pd[t,i]-kappa1[Epd[i]] pd[t-1,i]+dd[t,i]
kappa1eq[mu_] := Exp[mu]/(Exp[mu]-1)
kappa0eq[mu_] := -Log[Exp[mu]-1]+kappa1eq[mu]mu
*)

(*excess returns*)
excretceq[t_] := retc[t]-rf[t]
excreteq[t_,i_] := ret[t,i]-rf[t]


(* ::Subsection:: *)
(*Bonds*)


(*bond yields*)
bondyieldeq[t_,m_] := -(1/m) bond[t,m]
nombondyieldeq[t_,m_] := -(1/m) nombond[t,m]

(*log forward rate*)
bondfweq[t_,m_,h_:1] := bond[t,m-h]-bond[t,m] 
nombondfweq[t_,m_,h_:1] := nombond[t,m-h]-nombond[t,m]

(*bond returns*)
bondreteq[t_,m_,h_:1] := bond[t,m-h]-bond[t-h,m]
nombondreteq[t_,m_,h_:1] := nombond[t,m-h]-nombond[t-h,m]

(*log forward rate spread*)
bondfwspreadeq[t_,m_,h_:1] := bondfw[t,m,h]-bondyield[t,h] 
nombondfwspreadeq[t_,m_,h_:1] := nombondfw[t,m,h]-nombondyield[t,h]

(*excess bond returns*)
bondexcreteq[t_,m_,h_:1] := bondret[t,m,h]-bondyield[t-h,h]
nombondexcreteq[t_,m_,h_:1] := nombondret[t,m,h]-nombondyield[t-h,h]

(*risk free rates*)
rfeq[t_,h_:1] := bondyield[t,h]
nomrfeq[t_,h_:1] := nombondyield[t,h]


(* ::Subsection:: *)
(*Symbols for coefficients of wealth-consumption ratio, price-dividend ratio, real and nominal bond prices*)


coefwc = Cases[UpValues[wceq], HoldPattern[linearInStateVars[_,x_]]:>x,Infinity][[1]];
coefpd = Cases[UpValues[pdeq], HoldPattern[linearInStateVars[_,x_[i__]]]:>x[_],Infinity][[1]];
coefb = Cases[UpValues[bondeq], HoldPattern[linearInStateVars[_,x_[m__]]]:>x[_],Infinity][[1]];
coefnb = Cases[UpValues[nombondeq], HoldPattern[linearInStateVars[_,x_[m__]]]:>x[_],Infinity][[1]];

(*make index variables be maintained as exact integers, rather than being converted by N to approximate numbers*)
(*SetAttributes[Evaluate@coefwc,NHoldAll]*)

(*make index variable be exact integer rather than approximate number, e.g., A[0.] and N[A[0]] both return A[0]*)
(*wc has one index*)
coefwc[j_/;InexactNumberQ[j]]:=coefwc[IntegerPart@j];
N[coefwc[j_/;InexactNumberQ[j]]]:=coefwc[IntegerPart@j];
		
(*pd, b, nb have two indices*)	
Do[
	Block[{j,k},
		With[{hc=Head@c},
			(*blank first argument and inexact number second argument*)
			c[k_/;InexactNumberQ[k]]:=(c[IntegerPart@k]);
			
			(*any first argument and inexact number second argument*)
			hc[j_][k_/;InexactNumberQ[k]]:=hc[j][IntegerPart@k];
			
			(*inexact first argument and any second argument *)
			hc[j_/;InexactNumberQ[j]][k_]:=hc[IntegerPart@j][k];
			
			(*hc[j][k] behaves as having NHoldAll in both j and k*)
			hc[j_/;InexactNumberQ[j]][k_/;InexactNumberQ[k]]:=hc[IntegerPart@j][IntegerPart@k];
			N[hc[j_/;InexactNumberQ[j]][k_/;InexactNumberQ[k]]]:=hc[IntegerPart@j][IntegerPart@k]
		](*With*)
	](*Block*)
	,
	{c,{coefpd,coefb,coefnb}}
](*Do*)


(* ::Subsection:: *)
(*Assumptions*)


endogEqAssumptions=
	(*coefficients of wc*)Element[coefwc,Reals]  && coefwc[0]>0 && Ewc>0 &&
	(*coefficients of pd*)Element[coefpd,Reals] && coefpd[0]>0 && Epd[_]>0 &&
	(*coefficients of real bond prices*)Element[coefb,Reals] && 
	(*coefficients of nominal bond prices*)Element[coefnb,Reals] &&
	(*linearization constants*)kappa0[__]>0 && kappa0[_]<1 && kappa1[__]>0 && kappa1[__]<1;


(* ::Section::Closed:: *)
(*End package*)


End[](*"`Private`"*)


EndPackage[]
