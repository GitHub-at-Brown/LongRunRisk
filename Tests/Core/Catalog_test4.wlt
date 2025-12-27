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
	TestID->"Catalog_20251223-OX2LLT@@Tests/Core/Catalog_test4.wlt:6,1-18,2"
]

End[]
EndTestSection[]
