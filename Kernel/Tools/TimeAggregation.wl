(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"]


(* ::Subsection:: *)
(*Public symbols*)


growth


(* ::Subsubsection:: *)
(*Usage*)


growth::usage = "growth[variable, t] gives the growth rate at time t of variable."<>"\n"<>
				"growth[variable, t, i] specify the stock identifier i when variable is a stock-related variable such as dividends."<>"\n"<>
				"growth[variable, t, m] specify the maturity m in months when variable is a bond-related variable such as bond yields.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*growth*)


growth//Options = {
	"v0"->Function[{t,j,h,k,v,im},0], (*function to compute the point around which the power series expansion is performed*)
	"Order"->1 (*use a power series expansion of Order `Order` to compute approximation*)
};


(*for flow variables, do power series expansion for gt*)
growth[
	v_Symbol,(*variable to time-aggregate*)
	t_,(*current time period*)
	Optional[im:Except@(_Rule|_List),Hold@Sequence[]],(*stock identifier or bond maturity*)
	opts:OptionsPattern[{growth,timeSeriesVector,g}]
] := Module[
	{
		h=OptionValue["TimeAggregation"],
		k=OptionValue["numPeriods"],
		n=OptionValue["Order"],
		v0=OptionValue["v0"],
		type=OptionValue["Variable"],
		optsgt=FilterRules[{opts},Except[Options[growth]]],
		imR=im//ReleaseHold,
		d,
		v0args,
		flowvar
	},

	v0args[j_]:= Function[Null,v0[##1],Listable]@@{t,j,h,k,v,im}; (*allow v0 to have any number of arguments smaller than the maximum of six*)
	Switch[type,
		"Flow",	
			Normal[
				(
					ReplaceAll[gt[v, t, im, optsgt],v[t+tau_Integer:0,imR]:>d*(v[t+tau,imR]-v0args[-tau])+v0args[-tau]]
				) + O[d]^(n + 1)  //ReleaseHold
			]/. d -> 1,
		"Ratio",
			(*create flow variable in the same context as the variable that has the ratio*)
			flowvar=Switch[
				SymbolName[v],
				"wc",
				Symbol[Context[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`v]<>"dc"],
				"pd",
				Symbol[Context[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`v]<>"dd"]	
			];
			(*must use numPeriods->1 for ratio*)
			optsgt=Normal@Append[Association@optsgt,"numPeriods"->1];
			v[t,imR]-(
				Normal[
					(
						ReplaceAll[gt[flowvar, t, im, optsgt],flowvar[t+tau_Integer:0,imR]:>d*(flowvar[t+tau,imR]-v0args[-tau])+v0args[-tau]]
					) + O[d]^(n + 1)  //ReleaseHold
				]/. d -> 1
			)
	]
]/; ( (OptionValue["Variable"]==="Flow") || (OptionValue["Variable"]==="Ratio"))

(*for stock variables, growth rate is already linear, return gt unchanged*)
growth[
	v_Symbol,(*variable to time-aggregate*)
	t_,(*current time period*)
	Optional[im:Except@(_Rule|_List),Hold@Sequence[]],(*stock identifier or bond maturity*)
	opts:OptionsPattern[{growth,timeSeriesVector,g}]
] := Module[
	{
		optsgt=FilterRules[{opts},Except[Options[growth]]]
	},
	gt[v, t,im,optsgt]
]/;(OptionValue["Variable"]=="Stock")


(* ::Subsubsection:: *)
(*f*)


(*if argumenet is not a list, convert to list*)
f[x:__?(!ListQ[##]&)]:=f[{x}]

(*if argumenet is a list*)
f[x_List]:=Module[{h=Length[x]+1},
	Log[
		1 + Sum[
				Exp[
					-Sum[x[[j]], {j, 1, h - i}]
				],
			{i, 1, h - 1}
		]
	]
];


(* ::Subsubsection:: *)
(*s*)


(*check if list without evaluating it s_?(Function[Null, ListQ[Unevaluated[#]], HoldAll])*)
(*if argumenet is not a list, convert to list*)
s[x:__?(!ListQ[##]&)]:=s[{x}]

(*if argumenet is a list*)
s[x_List]:=Plus@@x


(* ::Subsubsection:: *)
(*g*)


g//Options = {
	"Variable"->"Flow" (*specify if variable is a flow variable ("Variable"->"Flow"), a stock variable ("Variable"->"Stock"), or the ratio of a stock and a flow variable ("Variable"->"Ratio")*)
};


(*if argument is not a list, convert to list*)
g[
	x:__?(!ListQ[##]&),
	h:_Integer?Positive,(*time-aggregate over `h` months*)
	k:_Integer?Positive:1,(*growth rate is computed over k time-aggregated periods*)
	opts:OptionsPattern[g]
]:=g[{x},h,k,opts]

(*if argument is a list*)
(** when computing growth of a stock variable, x must have length k*h **)
g[
	x_List,
	h:_Integer?Positive,(*time-aggregate over `h` months*)
	k:_Integer?Positive:1, (*growth rate is computed over k time-aggregated periods*)
	opts:OptionsPattern[g]
]:=With[
	{
		type=OptionValue["Variable"]
	},
	s[x]
	]/; ((Length[x]==k*h) && (OptionValue["Variable"]==="Stock"))
	
(** when computing growth of a flow variable or time-aggregation of a ratio of a 
stock and a flow variable, x must have length (1+k)*h-1 **)
(** when computing growth of a stock variable, allow length of x to be (1+k)*h-1 
but then evaluate using only first h*k entries of x,
 discarding entries k*h+1, k*h+2, ..., (1+k)*h-1 **)
g[
	x_List,
	h:_Integer?Positive,(*time-aggregate over `h` months*)
	k:_Integer?Positive:1, (*growth rate is computed over k time-aggregated periods*)
	opts:OptionsPattern[g]
]:=With[
	{
		type=OptionValue["Variable"],
		x1=x[[;;k*h]],(*first k*h months*)
		x2=x[[;;h-1]],(*first h-1 months*)
		x3=x[[k*h+1;;]] (*months k*h+1 until end*)
	},
	Switch[type,
		"Flow",
			s[x1]+f[x2]-f[x3],
		"Stock",
			g[x1,h,k,opts],
		"Ratio",
			-f[x2]
	]
]/;(Length[x]==(1+k)*h-1)


(* ::Subsubsection:: *)
(*timeSeriesVector*)


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
		lastPeriod
	},
	lastPeriod=(1+k)*h-2;
	Table[
		variable[t-tau,im//ReleaseHold],
		{tau,0,lastPeriod}
	]
]/; Implies[NumberQ[t],t>=0]


(* ::Subsubsection:: *)
(*gt*)


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
	g[timeSeriesVector[variable,t,im,optsTs],h,k,optsg]
]/; Implies[NumberQ[t],t>=0];


(* ::Section:: *)
(*End package*)


End[] (*"`Private`"*)


EndPackage[]
