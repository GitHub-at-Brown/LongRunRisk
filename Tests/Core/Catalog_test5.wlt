BeginTestSection["Catalog"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`Catalog`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

VerificationTest[
	Apply[And,
		Map[NumberQ,
			Flatten[
				Map[
					Function[
						Part[FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["parameters"], 1;;, 2] //. FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["parameters"]
					],
					Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models
				]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20251223-TQC5UV@@Tests/Core/Catalog_test5.wlt:6,1-25,2"
]

End[]
EndTestSection[]
