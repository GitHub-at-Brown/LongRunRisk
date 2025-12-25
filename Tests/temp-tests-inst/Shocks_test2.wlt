BeginTestSection["Shocks"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`Shocks`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`Shocks`";

VerificationTest[
	!SameQ[Names @ "*rulesE", {}]
	,
	True
	,
	{}
	,
	TestID->"Shocks_20251223-HL1LFB@@Tests/Shocks.wlt:22,1-30,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
