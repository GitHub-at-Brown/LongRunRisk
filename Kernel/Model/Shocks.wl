(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`Model`Shocks`"]


(* rules that define the distribution of exogenous shocks *)
rulesE::usage = "rulesE[t]"
	
(* exogenous shocks *)
eps::usage = "Shocks"


(*globals to share across packages*)
$shocks=Select[Names[$Context<>"*"],Not[StringStartsQ[#,"$"]]&];


Begin["`Private`"]


Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"]


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

(* distribution of exogenous shocks *)
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


End[](*"`Private`"*)


EndPackage[]
