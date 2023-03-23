(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`timeAggregation`"];


(* ::Subsection:: *)
(*Public symbols*)


dcagApproxeq
ddagApproxeq
dcagCumGr
ddagCumGr
(*wcAGeq*)
pdAGeq
retcageq
retageq
rfageq
excbondretAGeq
nomExcbondretAGeq


(* ::Subsubsection:: *)
(*Usage*)


dcagApproxeq::usage = "Computes approximation of time-aggregated consumption growth";
ddagApproxeq::usage =  "Computes approximation of time-aggregated dividend growth";
dcagCumGr::usage="dcagCumGr[t,h,numPeriods] computes the cumulative growth rate between `t` and `t+h*numPeriods` for consumption aggregated over `h` months."<>"\n"<>
			"Examples: "<>"\n"<>
			"`dcagCumGr[t,1,1]`  gives consumption growth over one month (between month `t-1` and month `t`) without time aggregation."<>"\n"<>
			"`dcagCumGr[t,1,3]` gives consumption growth over three months (between month `t-1` and month `t+2`) without time aggregation."<>"\n"<>
			"`dcagCumGr[t,12,1]`  gives consumption growth over one year (between `t` minus one year and `t`) for consumption aggregated over 12 months."<>"\n"<>
			"`dcagCumGr[t,12,3]` gives consumption growth over three years (between `t` minus one year and `t` plus two years) for consumption aggregated over 12 months.";
ddagCumGr::usage = "ddagCumGr[t,h,numPeriods,i] computes the cumulative growth rate between t and t+h*numPeriods for dividends of stock i aggregated over h months."<>"\n"<>
			"See examples in `dcagCumGr`";
(*wcAGeq::usage =  "Computes approximation of time-aggregated wealth-consumption ratio. Consumption growth approximated around `mu0` with default value 0.0015.";*)
pdAGeq::usage =  "Computes approximation of time-aggregated price-dividend ratio. Dividend growth approximated around `mu0` with default value 0.0015.";
retcageq::usage =  "Computes approximation of time-aggregated returns on the wealth portfolio (that pays aggregate consumption as dividends)";
retageq::usage = "Computes approximation of time-aggregated stock returns";
rfageq::usage = "Computes approximation of time-aggregated risk-free rate";
excbondretAGeq::usage = "Computes approximation of time-aggregated real bond excess returns";
nomExcbondretAGeq::usage = "Computes approximation of time-aggregated nominal bond excess returns";


CreateItoProcess::usage="CreateItoProcess[s0] creates an Ito process with initial condition s0."<>"\n"<>
						"CreateItoProcess[s0,driver] creates an Ito process with initial condition s0 and noise given by driver."<>"\n"<>
						"CreateItoProcess[s0,fun] creates a function fun of an Ito process. The original Ito process has initial condition s0 while the transformed process has initial condition fun(s0)."<>"\n"<>
						"CreateItoProcess[s0,fun,driver] creates a function fun of an Ito process. The original Ito process has initial condition s0. The new process retured by CreateItoProcess has initial condition fun(s0) and noise given by driver.";
						
														
ChangeItoProcess::usage="ChangeItoProcess[proc,s0] changes the intial condition of the Ito process `proc` to `s0`."<>"\n"<>
						"ChangeItoProcess[proc,fun] applies the function `fun` to the Ito process `proc`."<>"\n"<>
						"ChangeItoProcess[proc,driver] changes the driving process of the noise of the Ito process `proc` to `driver`."<>"\n"<>
						"ChangeItoProcess[proc,fun,driver] applies the function `fun` to the Ito process `proc`, and then changes the noise process to driver.";

ExtractItoProcess::usage="ExtractItoProcess[proc,i] extracts the ith component of the Ito process `proc`.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* pick point around which to linearize *)
varkappa[t_,h_,j_]:=0.0015

(* flow variables like conssumption and dividend growth *) 
agApproxeq[t_,h_Integer?Positive,variable_Symbol,i_:Sequence[]]:=Sum[((j-1)/h) variable[t-2h+j,i],{j,2,h}]+Sum[((h-j+1)/h) variable[t-h+j,i],{j,1,h}];
agCumGr[t_,h_,numPeriods_,variable_Symbol,i_:Sequence[]] := Sum[agApproxeq[t+h*n,h,variable,i],{n,0,numPeriods-1}]

(* wealth-consumption and price-dividend ratios *)
avepsC[h_,muc0_:0.0015] := Log[1 + Sum[ Exp[-Sum[muc0,{j,1,h-q}]],{q,1,h-1}]] + Sum[muc0*Sum[ Exp[-Sum[muc0,{j,1,h-q}]],{q,1,h-k}], {k,1,h-1}] /  (1 + Sum[ Exp[-Sum[muc0,{j,1,h-q}]],{q,1,h-1}]);
epsC[h_,k_,muc0_:0.0015] := Sum[ Exp[-Sum[muc0,{j,1,h-q}]],{q,1,h-k-1}] / (1 + Sum[ Exp[-Sum[muc0,{j,1,h-q}]],{q,1,h-1}]);
wcAGeq[t_,h_,muc0_:0.0015]:= wc[t] - avepsC[h,muc0] + Sum[ epsC[h,q,muc0] * dc[t- q],{q,0,h-2}];

aveps[i_,mud0_:0.0015] := Log[1 + Sum[ Exp[-Sum[ mud0,{j,1,12-q}]],{q,1,12-1}]] + Sum[ mud0*Sum[ Exp[-Sum[ mud0,{j,1,12-q}]],{q,1,12-k}], {k,1,12-1}] /  (1 + Sum[ Exp[-Sum[mud0,{j,1,12-q}]],{q,1,12-1}]);
eps[k_,i_,mud0_:0.0015] := Sum[ Exp[-Sum[mud0,{j,1,12-q}]],{q,1,12-k-1}] / (1 + Sum[ Exp[-Sum[mud0,{j,1,12-q}]],{q,1,12-1}]);
pdAGeq[t_,i_,mud0_:0.0015]:= pd[t,i]   - aveps[i,mud0]  + Sum[ eps[q,i,mud0] * dd[t-q,i],{q,0,12-2}]; 

(*[t_,h_Integer?Positive,variable_Symbol,i_:Sequence[],]*)



(* Time Aggregation Formulae for any variables that are just summed (Annual = Sum(monthly variables)) such as rf or ret) *)
(* Returns *) 
(*retcageq[t_,h_]:= Sum[retc[t-h+j],{j,1,h}];
retageq[t_,h_,i_]:=Sum[ret[t-h+j,i],{j,1,h}];
piageq[t_,h_]:=Sum[pi[t-h+j],{j,1,h}];
rfageq[t_,h_]:=Sum[bondyield[t-h+j,1],{j,1,h}];

excretageq[t_,h_,i_]:=Sum[excreteq[t-h+j,i],{j,1,h}];
bondretAGeq[t_,h_,n_]:= Sum[bondret[t-h+j,n],{j,1,h}];
excbondretAGeq[t_,h_,n_]:= Sum[excbondreteq[t-h+j,n],{j,1,h}];
nomBondretAGeq[t_,h_,n_]:= Sum[nombondret[t-h+j,n],{j,1,h}];
nomExcbondretAGeq[t_,h_,n_]:= Sum[nomExcbondreteq[t-h+j,n],{j,1,h}];*)

excreteq[t_,i_]:=ret[t,i]-bondyield[t,1];
nomExcbondreteq[t_,n_] := nombondret[t,n] - nombondyield[t,1];
excbondreteq[t_,n_] := bondret[t,n] - bondyield[t,1];





timeAggregate//Options = {
	"numPeriods"->1,(*compute growth rates/inflation/returns of time-aggregated variables over `numPeriods`, i.e., over `numPeriods*h` months*)
	"mu0"->0.0015, (*consumption and dividend growth approximated around `mu0` with default value 0.0015*)
	"stock"->Sequence[], (*stock number to identify stock, must be non-empty when `var` is a stock-related variable like dd or pd*)
	"maturity"->Sequence[](*maturity of the bond, must be non-empty when `var` is a bond-related variable like bondret*)
};


(*function to check optional arguments `opts` are valid*)
timeAggregate/:Conditions[timeAggregate,variable_,opts_]:= Module[
	{
		nostock,
		nomaturity,
		stockVars={dd,pd,ret,excret},
		bondVars={bondret,nombondret,excbondret,excnombondret}
	},
	(*nostock==True if stock variable missing stock identifier*)
	nostock=Not[MemberQ[stockVars,var]&&(OptionValue[timeAggregate,opts,stock]===PatternSequence[])];
	(*nomaturity==True if bond variable missing maturity*)
    nomaturity=Not[MemberQ[bondVars,var]&&(OptionValue[timeAggregate,opts,maturity]===PatternSequence[])];
    (*issue message*)
	If[nostock,Message[timeAggregate::nostock,variable]];
	If[nomaturity,Message[timeAggregate::nomat,variable]];
	(*return true if nothing missing*)
	Not[And[nostock,nomaturity]]
]


timeAggregate[
	variable_Symbol,(*variable to time-aggregate*)
	t_,
	h:_Integer?Positive:1,(*time-aggregate over `h` months*)
	opts:OptionsPattern[timeAggregate]
]:=Module[
	{
		H=OptionValue[numPeriods]*h,
		np=OptionValue[numPeriods],
		mu0=OptionValue[mu0],
		i=OptionValue[timeAggregate,opts,stock],
		m=OptionValue[timeAggregate,opts,maturity]
	},	
	Switch[
		variable,
		dc|dd,
		agCumGr[t,h,np,variable,i],
		wc,
		wcAGeq[t,h,mu0],
		pd,
		pdAGeq,
		pi|retc|ret|excret|rf|bondret|nombondret|excbondret|excnombondret,
		Sum[variable[t-H+j,i,m],{j,1,H}],
		_,
		Message[timeAggregate::notfound,variable];
		Failure
	]
]/;Conditions[ChangeItoProcess,variable,opts]


(* ::Text:: *)
(*Next : unify wcAGeq, pdAGeq, generalize using numPeriods to compute*)
(*pd24 = pdAG + pdAGeq[t + 12, i];*)
(*pd36 = pd24 + pdAGeq[t + 24, i];*)
(*pd48 = pd36 + pdAGeq[t + 36, i];*)
(*pd60 = pd48 + pdAGeq[t + 48, i];*)
(*pd72 = pd60 + pdAGeq[t + 60, i]; *)
(**)
(*Next : generalize for *)
(*excret12 = excretageq[t, 12, i];*)
(*excret12lag = excretageq[t - 12, 12, i];*)
(*excret24 = excret12 + excretageq[t + 12, 12, i];*)
(*excret36 = excret24 + excretageq[t + 24, 12, i];*)
(*excret48 = excret36 + excretageq[t + 36, 12, i];*)
(*excret60 = excret48 + excretageq[t + 48, 12, i];*)
(*excret72 = excret60 + excretageq[t + 60, 12, i]; *)
(**)
(**)


timeAggregate::notfound = 
  "There is no method to compute `timeAggregate` for variable `1`.";
timeAggregate::nostock = 
  "Missing stock identifier for variable `1`. Try passing `stock->i` or `stock->1` as an argument to `timeAggregate`";
timeAggregate::nomat = 
  "Missing maturity for variable `1`. Try passing `maturity->n` or `maturity->1` as an argument to `timeAggregate`";


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
