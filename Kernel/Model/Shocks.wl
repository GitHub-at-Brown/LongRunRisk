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
		shockNames={"x","dc","pi","pibar","sg","sx","sc","sp"}
	},

	{
		eps["dc"][t]*eps["dd"][t,i_]:>taugd[i],
		eps[var_][t]/;MemberQ[shockNames,var]:>0,
		eps["dd"][t,i_]:>0,
		eps[var_][t]^p_Integer/;MemberQ[shockNames,var]:>Expectation[y^p,y\[Distributed]NormalDistribution[0,1]],
		eps["dd"][t,i_]^p_Integer:>Expectation[y^p,y\[Distributed]NormalDistribution[0,1]]
	}	
]


End[](*"`Private`"*)


EndPackage[]
