BeginTestSection["Catalog"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`Catalog`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

VerificationTest[
	Apply[And,
		Map[MatchQ[Association, #]&,
			Flatten[
				{
					Head @ FernandoDuarte`LongRunRisk`Model`Catalog`models,
					Map[Function @ Head @ FernandoDuarte`LongRunRisk`Model`Catalog`models @ #, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]
				}
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20251223-L8VWTP@@Tests/Catalog.wlt:105,1-122,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
