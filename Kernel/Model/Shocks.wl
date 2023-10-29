(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Model`Shocks`"]


(* ::Subsection:: *)
(*Public symbols*)


rulesE
eps


(* ::Subsubsection:: *)
(*Usage*)


rulesE::usage = "rulesE[t] defines the distribution of exogenous shocks by giving replacement rules that compute the unconditional expectation of products of powers of exogenous shocks.";
eps::usage = "Exogenous shocks.";


(*globals to share across packages*)
$shocks=Select[Names[$Context<>"*"],Not[StringStartsQ[#,"$"]]&];


(* ::Section::Closed:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"]


(* ::Subsection:: *)
(*rulesE*)


(*list of exogenous shocks*)
(*
eps["x"]
eps["dc"]
eps["pi"]
eps["pibar"]
eps["sg"]
eps["sx"]
eps["sc"]
eps["sp"]
eps["dd"]
*)

(*distribution of exogenous shocks*)
(*for a normal distribution, we only need rules for how to compute expectations of products of shocks*)
rulesE[t_]:=With[
	{
		shockNames={"x","dc","pi","pibar","sg","sx","sc","sp"},
		epsPattern=(_Symbol?((SymbolName[#]==="eps")&))
	},

	{
		epsPattern["dc"][t]*epsPattern["dd"][t,i_]:>taugd[i],
		epsPattern[var_][t]/;MemberQ[shockNames,var]:>0,
		epsPattern["dd"][t,i_]:>0,
		epsPattern[var_][t]^p_Integer/;MemberQ[shockNames,var]:>Expectation[y^p,y\[Distributed]NormalDistribution[0,1]],
		epsPattern["dd"][t,i_]^p_Integer:>Expectation[y^p,y\[Distributed]NormalDistribution[0,1]]
	}	
]


(*make index variables be maintained as exact integers, rather than being converted by N to approximate numbers*)
SetAttributes[$shocks,NHoldAll]


(* ::Section::Closed:: *)
(*End package*)


End[](*"`Private`"*)


EndPackage[]
