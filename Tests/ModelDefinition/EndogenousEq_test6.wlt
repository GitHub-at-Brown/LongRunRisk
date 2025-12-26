BeginTestSection["EndogenousEq"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";

VerificationTest[
	Apply[And,
		{
			FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], foo`t],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t],
			FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[foo`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[foo`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], foo`t],
			!SameQ[foo`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m]],
			!SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[foo`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20251223-J1CO3Y@@Tests/EndogenousEq.wlt:122,1-139,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
