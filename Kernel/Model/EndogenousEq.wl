(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"]


(* public symbols *)
wceq::usage = "wceq[t] gives the log wealth-consumption ratio at time t."

pdeq::usage = "pdeq[t,i] gives the log price-dividend ratio of stock i at time t."

bondeq::usage = "bondeq[t,m] gives the log price of a real m-month maturity discount \
	(zero-coupon) riskless bond at time t."
nombondeq::usage = "nombondeq[t,m] gives the log price of a nominal m-month maturity discount \
	(zero-coupon) riskless bond at time t."

bondyieldeq::usage = "bondyieldeq[t,m] gives the log yield of a real m-month \
	maturity discount (zero-coupon) riskless bond at time t."
nombondyieldeq::usage = "nombondyieldeq[t,m] gives the log yield of a nominal m-month \
	maturity discount (zero-coupon) riskless bond at time t."

bondfweq::usage = "bondfweq[t,m,h] gives the real log forward rate at time t for riskless loans \
	between times t+m-h and t+m."
nombondfweq::usage = "nombondfweq[t,m,h] gives the nominal log forward rate at time t for riskless loans \
	between times t+m-h and t+m."

bondreteq::usage = "bondreteq[t,m,h] gives the log h-period return from buying a real \
	m-month maturity discount (zero-coupon) riskless bond at time t-h and selling it as an (m-h)-month \
	maturity bond at time t."
nombondreteq::usage = "nombondreteq[t,m,h] gives the log h-period return from buying a nominal \
	m-month maturity discount (zero-coupon) riskless bond at time t-h and selling it as an (m-h)-month \
	maturity bond at time t."

bondfwspreadeq::usage = "bondfwspreadeq[t,m,h] gives the real log forward rate at time t for riskless loans \
	between times t+m-h and t+m, in excess of the h-period risk-free rate earned by investing in an \
	h-month maturity real discount (zero-coupon) riskless bond between times t and t+h."
nombondfwspreadeq::usage = "nombondfwspreadeq[t,m,h] gives the nominal log forward rate at time t for riskless loans \
	between times t+m-h and t+m, in excess of the h-period risk-free rate earned by investing in an \
	h-month maturity nominal discount (zero-coupon) riskless bond between times t and t+h."

bondexcreteq::usage = "bondexcreteq[t,m,h] gives the log h-period excess return from buying a real \
	m-month maturity discount (zero-coupon) riskless bond at time t-h and selling it as an (m-h)-month \
	maturity riskless bond at time t, in excess of the h-period risk-free rate earned by investing in an \
	h-month maturity real discount (zero-coupon) riskless bond between times t-h and t."
nombondexcreteq::usage = "nombondexcreteq[t,m,h] gives the log h-period excess return from buying a nominal \
	m-month maturity discount (zero-coupon) riskless bond at time t-h and selling it as an (m-h)-month \
	maturity riskless bond at time t, in excess of the h-period risk-free rate earned by investing in an \
	h-month maturity nominal discount (zero-coupon) riskless bond between times t-h and t."

sdfeq::usage = "sdfeq[t] gives the (real) stochastic discount factor at time t."
nomsdfeq::usage = "nomsdfeq[t] gives the nominal stochastic discount factor at time t."

retceq::usage = 
   "retceq[t] gives the return for the asset that pays consumption as dividends each period."
reteq::usage = 
   "reteq[t,i] gives the return for stock i. Stock i is defined as the asset that pays dividends ddeq[i]."
   
rfeq::usage = "rfeq[t] gives the one-period real risk-free rate at time t for loans between t and t+1. /
	rfeq[t,h] gives the h-period real risk-free rate at time t for loans between t and t+h./
	rfeq[t,h] is the same as bondyield[t,h]"
nomrfeq::usage = "nomrfeq[t] gives the one-period nominal risk-free rate at time t for loans between t and t+1. /
	nomrfeq[t,h] gives the h-period nominal risk-free rate at time t for loans between t and t+h./
	nomrfeq[t,h] is the same as nombondyield[t,h]"

excretceq::usage = 
   "excretceq[t] gives the return for the asset that pays consumption as dividends each period \
	in excess of the risk-free rate."
excreteq::usage = 
   "excreteq[t,i] gives the return for stock i in excess of the risk-free rate."

kappa1eq::usage = "kappa1eq[Ewc] is the Campbell-Shiller approximation constant \
	\!\(\*SubscriptBox[\(\[Kappa]\), \(1\)]\)=Exp[Ewc]/(Exp[Ewc]-1) where Ewc is the unconditional mean of \
	the log wealth consumption ratio."
kappa0eq::usage = "kappa0eq[Epd] is the Campbell-Shiller approximation constant \
	\!\(\*SubscriptBox[\(\[Kappa]\), \(0\)]\)=-Log[Exp[Ewc]-1]+Ewc Exp[Ewc]/(Exp[Ewc]-1) where Ewc is the \
	unconditional mean of the the log wealth consumption ratio."

kappa1meq::usage = "kappa1meq[i][Epd] is the Campbell-Shiller approximation constant \
	\!\(\*SubscriptBox[\(\[Kappa]\), m, \(1\)]\)=Exp[Epd]/(Exp[Epd]-1) where Epd is the unconditional mean of \
	the log price dividend ratio of asset i."
kappa0meq::usage = "kappa0meq[i][Epd] is the Campbell-Shiller approximation constant \
	\!\(\*SubscriptBox[\(\[Kappa]\), m, \(0\)]\)=-Log[Exp[Epd]-1]+Epd Exp[Epd]/(Exp[Epd]-1) where Epd is the \
	unconditional mean of the log price dividend ratio of asset i."
	
eulereq::usage = "eulereq[x[t],s] or eulereq[x[t,i],s] gives the Euler equation for (real) \
	return x[t] or x[t,i] conditional on time s."
nomeulereq::usage = "nomeulereq[x[t],s] or nomeulereq[x[t,i],s]  gives the Euler equation for \
	nominal return x[t] or x[t,i] conditional on time s."


$endogenousVars=SortBy[Select[Names[$Context<>"*"],Not[StringStartsQ[#,"$"]]&],PositionIndex[{"wceq","pdeq","bondeq","nombondeq"}]];(*SortBy have exogenous variables in a given canonical order*)


Begin["`Private`"]


(*Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];
Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];*)


(* conjecture the wealth-consumption ratio is linear in stateVars *)
(*wceq[t_] := Dot[Table[Subscript[A,m],{m,0,Length[stateVars]}],Prepend[stateVars,1]]*)


(* conjecture price-dividend ratios for stocks and bond prices are a linear function of the same variables that determine the wealth-consumption ratio *)

linearInStateVars[stateVars_,coeff_]:= Module[
	{
		n=Length[stateVars],
		stateVarsWith1=Prepend[stateVars,1],
		coeffs=Table[coeff[j],{j,0,Length[stateVars]}]
	},	
		Dot[coeffs,stateVarsWith1]
]
dv=DownValues@linearInStateVars;


wceq /: stateVars_List[wceq] := ({t_}:>linearInStateVars[stateVars,A])/. dv
pdeq /: stateVars_List[pdeq] := ({t_,i_}:>linearInStateVars[stateVars,B[i]])/. dv
bondeq /: stateVars_List[bondeq] := ({t_,m_}:>linearInStateVars[stateVars,R[m]])/. dv
nombondeq /: stateVars_List[nombondeq] := ({t_,m_}:>linearInStateVars[stateVars,P[m]])/. dv

(*wceq[stateVars_] := Function@@(Evaluate@stateVars[wceq])/. dv
pdeq[stateVars_] := Function@@(Evaluate@stateVars[pdeq])/. dv
bondeq[stateVars_] := Function@@(Evaluate@stateVars[bondeq])/. dv
nombondeq[stateVars_] := Function@@(Evaluate@stateVars[nombondeq])/. dv*)


(* define bond yields *)
bondyieldeq[t_,m_]= -(1/m) bond[t,m]
nombondyieldeq[t_,m_]=-(1/m) nombond[t,m]

(* define log forward rate *)
bondfweq[t_,m_,h_:1]=bond[t,m-h]-bond[t,m] 
nombondfweq[t_,m_,h_:1]=nombond[t,m-h]-nombond[t,m]

(* define bond returns *)
bondreteq[t_,m_,h_:1]=bond[t,m-h]-bond[t-h,m]
nombondreteq[t_,m_,h_:1]=nombond[t,m-h]-nombond[t-h,m]

(* define log forward rate spread *)
bondfwspreadeq[t_,m_,h_:1]=bondfw[t,m,h]-bondyield[t,h] 
nombondfwspreadeq[t_,m_,h_:1]=nombond[t,m,h]-nombondyield[t,h]

(* define excess bond returns *)
bondexcreteq[t_,m_,h_:1]=bondret[t,m,h]-bondyield[t-h,h]
nombondexcreteq[t_,m_,h_:1]=nombondret[t,m,h]-nombondyield[t-h,h]

(* stochastic discount factor *)
sdfeq[t_]=theta Log[delta]-(theta/psi)dc[t]+(theta-1)retc[t]
nomsdfeq[t_]=sdf[t]-pi[t]

(* Euler equation *)
eulereq[x_[t_,i___],s_]:= ev[sdf[t],s]+(1/2)var[sdf[t],s]+ev[x[t,i],s]+(1/2)var[x[t,i],s]+cov[sdf[t],x[t,i],s] 
nomeulereq[x_[t_,i___],s_]:= ev[nomsdf[t],s]+(1/2)var[nomsdf[t],s]+ev[x[t,i],s]+(1/2)var[x[t,i],s]+cov[nomsdf[t],x[t,i],s] 

rfeq[t_,h_:1]=bondyield[t,h]
nomrfeq[t_,h_:1]=nombondyield[t,h]

(* campbell-shiller approximation for returns from Bansal Yaron *)
retceq[t_]=kappa0+kappa1 wc[t]-wc[t-1]+dc[t]
reteq[t_,i_]=kappa0m[i]+kappa1m[i]pd[t,i]-pd[t-1,i]+dd[t,i]
kappa1eq[mu_]=Exp[mu]/(Exp[mu]+1)
kappa0eq[mu_]=Log[Exp[mu]+1]-kappa1eq[mu]mu

(* campbell-shiller approximation for returns from Koijen, Lustig, Van Nieuwerburgh and Verdelhan *)
(*retceq[t_]:=kappa0+wc[t]-kappa1 wc[t-1]+dc[t];
reteq[t_,i_]:=kappa0m[i]+pd[t,i]-kappa1m[i]pd[t-1,i]+dd[t,i];
kappa1eq[mu_]:=Exp[mu]/(Exp[mu]-1);
kappa0eq[mu_]:=-Log[Exp[mu]-1]+kappa1eq[mu]mu;*)

excretceq[t_]=retc[t]-rf[t]
excreteq[t_,i_]=ret[t,i]-rf[t]


coefwc=Cases[UpValues[wceq],linearInStateVars[_,x_]->x,Infinity][[1]];
coefpd=Cases[UpValues[pdeq],linearInStateVars[_,x_]->x,Infinity][[1]];
coefb=Cases[UpValues[bondeq],linearInStateVars[_,x_]->x,Infinity][[1]];
coefnb=Cases[UpValues[nombondeq],linearInStateVars[_,x_]->x,Infinity][[1]];

endogEqAssumptions=
	(*coefficients of wc*)Element[Subscript[coefwc, ___],Reals]  && 
	(*coefficients of pd*)Element[Subscript[coefpd, ___][___],Reals] && 
	(*coefficients of real bond prices*)Element[Subscript[coefb, ___][___],Reals] && 
	(*coefficients of nominal bond prices*)Element[Subscript[coefnb, ___][___],Reals] && 
	(*linearization constants*)kappa0>0 && kappa0<1 && 
	kappa1>0&& kappa1<1 && 
	kappa0m[___]>0  && kappa0m[___]<1 && 
	kappa1m[___]>0&& kappa1m[___]<1



End[](*"`Private`"*)


EndPackage[]
