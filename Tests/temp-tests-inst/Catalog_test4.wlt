BeginTestSection["Catalog"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`Catalog`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

VerificationTest[
	Apply[And,
		Map[BooleanQ,
			Flatten[Map[{FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["enabled"]}&, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20251223-OX2LLT@@Tests/Catalog.wlt:54,1-66,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
