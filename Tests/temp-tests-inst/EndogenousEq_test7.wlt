BeginTestSection["EndogenousEq"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";

VerificationTest[
	Apply[And,
		{
			FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], foo`m],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m],
			FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, foo`m], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, foo`m], foo`m],
			!SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, foo`m]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20251223-5751HS@@Tests/EndogenousEq.wlt:140,1-156,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
