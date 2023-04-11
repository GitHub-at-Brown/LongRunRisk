(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage[ "FernandoDuarte`LongRunRisk`TimeAggregation`" ]


(* ::Subsection:: *)
(*Public symbols*)


Growth
f
g
s
timeSeriesVector
gt


(* ::Subsubsection:: *)
(*Usage*)


(* ::Input::Initialization:: *)
Growth::usage = "Growth[variable,t] the growth rate at time t of variable."<>"\n"<>
"Growth[variable,t,i] specify the stock identifier i when variable is a stock-related variable such as dividends."<>"\n"<>
"Growth[variable,t,m] specify the maturity m in months when variable is a bond-related variable such as bond yields."<>"\n"<>"Growth[variable,t,Options] allows options to specify time aggregation periods in months and number of time-aggregated periods over which approximate growth rates are calculated.
Examples:
Growth[variable,t,\"Time aggregation\"->3] gives the growth rate of time-aggregated consumption, with time aggregation done over 3 months.
Growth[variable,t,\"Time aggregation\"->3] gives the growth rate of time-aggregated dividends for stock 1, with time aggregation done over 3 months.
Growth[variable,t,\"Time aggregation\"->12,\"numPeriods\"->2] gives the growth rate over 2 years of time-aggregated consumption, with time aggregation done over 12 months.
"



(* ::Section::Initialization:: *)
(*Code*)


(* ::Subsection::Closed:: *)
(*Private symbols*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Growth*)


Growth//Options = {
	"varkappa"->Function[{t,h,j,v,im},0], (*function to compute the point around which the power series expansion is performed*)
	"order"->1 (*use a power series expansion of order `order` to compute *)
};


(* ::Input::Initialization:: *)
(*for flow variables, do power series expansion for gt*)
Growth[
v_Symbol,(*variable to time-aggregate*)
t_,(*current time period*)
Optional[im:Except@(_Rule|_List),Hold@Sequence[]],(*stock identifier or bond maturity*)
opts:OptionsPattern[{Growth,timeSeriesVector,g}]
] := Module[
{
h=OptionValue["TimeAggregation"],
k=OptionValue["numPeriods"],
n=OptionValue["order"],
v0=OptionValue["varkappa"],
optsgt=FilterRules[{opts},Except[Options[Growth]]],
imR=im//ReleaseHold,
tau,
s
},
Normal[
	  (
ReplaceAll[gt[v, t,im,optsgt],v[t+tau_Integer:0,imR]:>s*(v[t+tau,imR]-v0[t,h,-tau,v,im])+v0[t,h,-tau,v,im]]
) + 
	   O[s]^(n + 1)
]/. s -> 1
]/; (OptionValue["flowVariable"]==True)

(*for stock variables, growth rate is already linear, return gt unchanged*)
Growth[
v_Symbol,(*variable to time-aggregate*)
t_,(*current time period*)
Optional[im:Except@(_Rule|_List),Hold@Sequence[]],(*stock identifier or bond maturity*)
opts:OptionsPattern[{Growth,timeSeriesVector,g}]
] := Module[
{
optsgt=FilterRules[{opts},Except[Options[Growth]]]
},
gt[v, t,im,optsgt]
]/;(OptionValue["flowVariable"]==False)


(* ::Subsubsection::Closed:: *)
(*f*)


(* ::Input::Initialization:: *)
(*if argumenet is not a list, convert to list*)
f[x:__?(!ListQ[##]&)]:=f[{x}]
(*if argumenet is a list*)
f[x_List]:=Module[{h=Length[x]+1,i,j},
Log[
1 + Sum[
Exp[
-Sum[x[[j]], {j, 1, h - i}]],
{i, 1, h - 1}
]
]
];


(* ::Subsubsection::Closed:: *)
(*s*)


(* ::Input::Initialization:: *)
(*if argumenet is not a list, convert to list*)
s[x:__?(!ListQ[##]&)]:=s[{x}]
(*if argumenet is a list*)
s[x_List]:=Plus@@x


(* ::Subsubsection:: *)
(*g*)


g//Options = {
	"flowVariable"->True (*specify if variable is a flow variable ("flowVariable"->True) or a stock variable ("flowVariable"->False)*)
};


(* ::Input::Initialization:: *)
(*if argumenet is not a list, convert to list*)
g[
x:__?(!ListQ[##]&),
h:_Integer?Positive:1,(*time-aggregate over `h` months*)
k:_Integer?Positive:1,(*growth rate is computed over k time-aggregated periods*)
opts:OptionsPattern[g]
]:=g[{x},h,k,opts]
(*if argumenet is a list*)
g[
x_List,
h:_Integer?Positive:1,(*time-aggregate over `h` months*)
k:_Integer?Positive:1, (*growth rate is computed over k time-aggregated periods*)
opts:OptionsPattern[g]
]:=With[
{
flowVariable=OptionValue["flowVariable"],
x1=x[[;;k*h]],(*first k*h months*)
x2=x[[;;h-1]],(*first k-1 months*)
x3=x[[k*h+1;;]] (*months k*h+1 until end*)
},
If[flowVariable,
s[x1]+f[x2]-f[x3],
s[x1]
]
]/;(Length[x]==(1+k)*h-1)

(*if computing growth of a stock variable, allow to pass x with length k*h rather than (1+k)*h-1 *)
g[
x_List,
h:_Integer?Positive:1,(*time-aggregate over `h` months*)
k:_Integer?Positive:1, (*growth rate is computed over k time-aggregated periods*)
opts:OptionsPattern[g]
]:=s[x]/;(Length[x]==k*h)&& (OptionValue["flowVariable"]==False)


(* ::Subsubsection:: *)
(*timeSeriesVector*)


(* ::Input::Initialization:: *)
timeSeriesVector//Options = {
  "TimeAggregation"->1,(*time-aggregate over `h` months*)
	"numPeriods"->1(*compute growth rates/inflation/returns of time-aggregated variables over a number `numPeriods` of time-aggregated periods, i.e., over `numPeriods*h` months*)
};

timeSeriesVector[
variable_Symbol,(*variable to time-aggregate*)
t_,(*current time period*)
Optional[im:Except@(_Rule|_List),Hold@Sequence[]],(*stock identifier or bond maturity*)
opts:OptionsPattern[timeSeriesVector]
]:=Module[
{
h=OptionValue["TimeAggregation"],
k=OptionValue["numPeriods"],
lastPeriod,
tau
},
lastPeriod=(1+k)*h-2;
(*Echo["timeSeries opts"->{opts}];*)
Table[variable[t-tau,im//ReleaseHold],{tau,0,lastPeriod}]

];


(* ::Subsubsection:: *)
(*gt*)


(* ::Input::Initialization:: *)
(*g[timeSeriesVector]*)
gt[
variable_Symbol,(*variable to time-aggregate*)
t_,(*current time period*)
Optional[im:Except@(_Rule|_List),Hold@Sequence[]],(*stock identifier or bond maturity*)
opts:OptionsPattern[{timeSeriesVector,g}]
]:=Module[
{
h=OptionValue["TimeAggregation"],
k=OptionValue["numPeriods"],
optsTs=FilterRules[{opts},Options[timeSeriesVector]],
optsg=FilterRules[{opts},Options[g]]
},
(*Echo["timeSeriesVector"->timeSeriesVector[variable,t,im,optsTs]];
Echo["optsTs"->optsTs];
Echo["Options[timeSeriesVector]"->Options[timeSeriesVector]];
Echo["FilterRules[Options[timeSeriesVector],{opts}]"->FilterRules[Options[timeSeriesVector],{opts}]];
Echo["optsg"->optsg];
Echo["{opts}"->{opts}];
Echo["h"->h];
Echo["k"->k];*)

g[timeSeriesVector[variable,t,im,optsTs],h,k, optsg]
];


(* ::Section:: *)
(*End package*)


End[] (*"`Private`"*)


EndPackage[]
