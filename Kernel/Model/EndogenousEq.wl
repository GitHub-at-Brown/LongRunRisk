(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"]


(* public symbols *)
wceq::usage = "wceq[t] gives the log wealth-consumption ratio at time t.";

pdeq::usage = "pdeq[t,i] gives the log price-dividend ratio of stock i at time t.";

bondeq::usage = "bondeq[t,m] gives the log price of a real m-month maturity discount \
	(zero-coupon) riskless bond at time t."; 
nombondeq::usage = "nombondeq[t,m] gives the log price of a nominal m-month maturity discount \
	(zero-coupon) riskless bond at time t."; 

bondyieldeq::usage = "bondyieldeq[t,m] gives the log yield of a real m-month \
	maturity discount (zero-coupon) riskless bond at time t."; 
nombondyieldeq::usage = "nombondyieldeq[t,m] gives the log yield of a nominal m-month \
	maturity discount (zero-coupon) riskless bond at time t."; 

bondfweq::usage = "bondfweq[t,m,h] gives the real log forward rate at time t for riskless loans \
	between times t+m-h and t+m."
nombondfweq::usage = "nombondfweq[t,m,h] gives the nominal log forward rate at time t for riskless loans \
	between times t+m-h and t+m."

bondreteq::usage = "bondreteq[t,m,h] gives the log h-period return from buying a real \
	m-month maturity discount (zero-coupon) riskless bond at time t-h and selling it as an (m-h)-month \
	maturity bond at time t.";
nombondreteq::usage = "nombondreteq[t,m,h] gives the log h-period return from buying a nominal \
	m-month maturity discount (zero-coupon) riskless bond at time t-h and selling it as an (m-h)-month \
	maturity bond at time t.";

bondfwspreadeq::usage = "bondfwspreadeq[t,m,h] gives the real log forward rate at time t for riskless loans \
	between times t+m-h and t+m, in excess of the h-period risk-free rate earned by investing in an \
	h-month maturity real discount (zero-coupon) riskless bond between times t and t+h."
nombondfwspreadeq::usage = "nombondfwspreadeq[t,m,h] gives the nominal log forward rate at time t for riskless loans \
	between times t+m-h and t+m, in excess of the h-period risk-free rate earned by investing in an \
	h-month maturity nominal discount (zero-coupon) riskless bond between times t and t+h."

bondexcreteq::usage = "bondexcreteq[t,m,h] gives the log h-period excess return from buying a real \
	m-month maturity discount (zero-coupon) riskless bond at time t-h and selling it as an (m-h)-month \
	maturity riskless bond at time t, in excess of the h-period risk-free rate earned by investing in an \
	h-month maturity real discount (zero-coupon) riskless bond between times t-h and t.";
nombondexcreteq::usage = "nombondexcreteq[t,m,h] gives the log h-period excess return from buying a nominal \
	m-month maturity discount (zero-coupon) riskless bond at time t-h and selling it as an (m-h)-month \
	maturity riskless bond at time t, in excess of the h-period risk-free rate earned by investing in an \
	h-month maturity nominal discount (zero-coupon) riskless bond between times t-h and t.";

sdfeq::usage = "sdfeq[t] gives the (real) stochastic discount factor at time t."; 
nomsdfeq::usage = "nomsdfeq[t] gives the nominal stochastic discount factor at time t."; 

retceq::usage = 
   "retceq[t] gives the return for the asset that pays consumption as dividends each period."; 
reteq::usage = 
   "reteq[t,i] gives the return for stock i. Stock i is defined as the asset that pays dividends ddeq[i]."; 
   
rfeq::usage = "rfeq[t] gives the one-period real risk-free rate at time t for loans between t and t+1. /
	rfeq[t,h] gives the h-period real risk-free rate at time t for loans between t and t+h./
	rfeq[t,h] is the same as bondyield[t,h]";
nomrfeq::usage = "nomrfeq[t] gives the one-period nominal risk-free rate at time t for loans between t and t+1. /
	nomrfeq[t,h] gives the h-period nominal risk-free rate at time t for loans between t and t+h./
	nomrfeq[t,h] is the same as nombondyield[t,h]";

excretceq::usage = 
   "excretceq[t] gives the return for the asset that pays consumption as dividends each period \
	in excess of the risk-free rate."; 
excreteq::usage = 
   "excreteq[t,i] gives the return for stock i in excess of the risk-free rate."; 

kappa1eq::usage = "kappa1eq[Epd] is the Campbell-Shiller approximation constant \
	\!\(\*SubscriptBox[\(\[Kappa]\), \(1\)]\)=Exp[Epd]/(Exp[Epd]-1) where Epd is the unconditional mean of \
	the log price dividend ratio of the corresponding asset.";
kappa0eq::usage = "kappa0eq[Epd] is the Campbell-Shiller approximation constant \
	\!\(\*SubscriptBox[\(\[Kappa]\), \(0\)]\)=-Log[Exp[Epd]-1]+Epd Exp[Epd]/(Exp[Epd]-1) where Epd is the \
	unconditional mean of the log price dividend ratio of the corresponding asset."; 

eulereq::usage = "eulereq[x[t],s] or eulereq[x[t,i],s] gives the Euler equation for (real) \
	return x[t] or x[t,i] conditional on time s."; 
nomeulereq::usage = "nomeulereq[x[t],s] or nomeulereq[x[t,i],s]  gives the Euler equation for \
	nominal return x[t] or x[t,i] conditional on time s.";


(*wc::usage = "wc[t] expands to wceq[t] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 

pd::usage = "pd[t,i] expands to pdeq[t,i] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 

bond::usage = "bond[t,m] expands to bondeq[t,m] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 
nombond::usage = "nombond[t,m]  expands to nombondeq[t,m] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 

bondyield::usage = "bondyield[t,m]  expands to bondyieldeq[t,m] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 
nombondyield::usage = "nombondyield[t,m] expands to nombondyieldeq[t,m] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 

bondfw::usage = "bondfw[t,m,h] expands to bondfweq[t,m,h] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 
nombondfw::usage = "nombondfw[t,m,h]  expands to nombondfweq[t,m,h] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 

bondret::usage = "bondret[t,m,h]  expands to bondreteq[t,m,h] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 
nombondret::usage = "nombondret[t,m,h]  expands to nombondreteq[t,m,h] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 

bondfwspread::usage = "bondfwspread[t,m,h]  expands to bondfwspreadeq[t,m,h] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 
nombondfwspread::usage = "nombondfwspread[t,m,h] expands to nombondfwspreadeq[t,m,h] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 

bondexcret::usage = "bondexcret[t,m,h] expands to bondexcreteq[t,m,h] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 
nombondexcret::usage = "nombondexcret[t,m,h]  expands to nombondexcreteq[t,m,h] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 

sdf::usage = "sdf[t]  expands to sdfeq[t] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 
nomsdf::usage = "nomsdf[t]  expands to nomsdfeq[t] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 

retc::usage = 
   "retc[t]  expands to retceq[t] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 
ret::usage = 
   "ret[t,i]  expands to reteq[t,i] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 

excretc::usage = 
   "excretc[t] expands to excretceq[t] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 
excret::usage = 
   "excret[t,i] expands to excreteq[t,i] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 
   
rf::usage = "rf[t] and rf[t,h] expand to rfeq[t] and rfeq[t,h] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 
nomrf::usage = "nomrf[t] and nomrf[t,h] expand to nomrfeq[t] and nomrfeq[t,h] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 

kappa1::usage = "kappa1[Epd]  expands to kappa1eq[Epd] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 
kappa0::usage = "kappa0[Epd]  expands to kappa0eq[Epd] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 

euler::usage = "euler[x[t],s] expands to eulereq[x[t],s] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc."; 
nomeuler::usage = "nomeuler[x[t],s]  expands to nomeulereq[x[t],s] inside operators like ev, var, cov,
uncondE, uncondVar, uncondCov, etc.";*)


Begin["`Private`"]


<<FernandoDuarte`LongRunRisk`Model`Parameters`;
<<FernandoDuarte`LongRunRisk`Model`Shocks`;
<<FernandoDuarte`LongRunRisk`Model`ExogenousEq`;


(* conjecture the wealth-consumption ratio is linear in stateVars *)
wceq[t_] := Dot[Table[Subscript[A,m],{m,0,Length[stateVars[t]]}],Prepend[stateVars[t],1]]


(* conjecture price-dividend ratios for stocks and bond prices are a linear function of the same variables that determine the wealth-consumption ratio *)
(*change D in pd since it is a mathematica symbol*)
pdeq[t_,i_] := Module[{s},wc[t] /. {Subscript[A, s___]:>Subscript[D, s][i]}]
bondeq[t_,m_] := Module[{s},-wc[t] /. {Subscript[A, s___]:>Subscript[R, s][m]}]
nombondeq[t_,m_] := Module[{s},-wc[t] /. {Subscript[A, s___]:>Subscript[P, s][m]}]


(* define bond yields *)
bondyieldeq[t_,m_]=-(1/m) bond[t,m]
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
retceq[t_]=Subscript[\[Kappa], 0]+Subscript[\[Kappa], 1]wc[t]-wc[t-1]+dc[t]
reteq[t_,i_]=Subscript[\[Kappa],0,m][i]+Subscript[\[Kappa],1,m][i]pd[t,i]-pd[t-1,i]+dd[t,i]
kappa1eq[mu_]=Exp[mu]/(Exp[mu]+1)
kappa0eq[mu_]=Log[Exp[mu]+1]-kappa1eq[mu]mu

(* campbell-shiller approximation for returns from Koijen, Lustig, Van Nieuwerburgh and Verdelhan *)
(*retceq[t_]:=Subscript[\[Kappa], 0]+wc[t]-Subscript[\[Kappa], 1]wc[t-1]+dc[t];
reteq[t_,i_]:=Subscript[\[Kappa],0,m][i]+pd[t,i]-Subscript[\[Kappa],1,m][i]pd[t-1,i]+dd[t,i];
kappa1eq[mu_]:=Exp[mu]/(Exp[mu]-1);
kappa0eq[mu_]:=-Log[Exp[mu]-1]+kappa1eq[mu]mu;*)

excretceq[t_]=retc[t]-rf[t]
excreteq[t_,i_]=ret[t,i]-rf[t]


assumptions=
	(*coefficients of wc*)Element[Subscript[A, s___],Reals]  && 
	(*coefficients of pd*)Element[Subscript[D, s___][i___],Reals] && 
	(*coefficients of real bond prices*)Element[Subscript[R, s___][n___],Reals] && 
	(*coefficients of nominal bond prices*)Element[Subscript[P, s___][n___],Reals] && 

	(*linearization constants*)
	Subscript[\[Kappa], 0]>0 && Subscript[\[Kappa], 0]<1 && 
	Subscript[\[Kappa], 1]>0&& Subscript[\[Kappa], 1]<1 && 
	Subscript[\[Kappa],0,m][i___]>0 && Subscript[\[Kappa],0,m][i___]<1 && 
	Subscript[\[Kappa],1,m][i___]>0&& Subscript[\[Kappa],1,m][i___]<1;


End[](*"`Private`"*)
EndPackage[]
