BeginTestSection["Catalog"] 
Begin["Catalog`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`"
	,
	Null
	,
	{}
	,
	TestID->"Catalog_20230416-GIB1LI"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Catalog`"]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230416-WRPGRA"
]
VerificationTest[
	!SameQ[Names @ "*models", {}]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230416-O8OJSM"
]
VerificationTest[
	Map[StringQ, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]
	,
	{
		True, True, True, True, True, True, True, True, True, True, True, True,
		True, True, True, True
	}
	,
	{}
	,
	TestID->"Catalog_20230416-5D8ELX"
]
VerificationTest[
	Map[StringQ,
		Flatten[
			Map[
				Function @ {
					FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["name"],
					FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["shortname"],
					FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["bibRef"],
					FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["desc"]
				},
				Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models
			]
		]
	]
	,
	{
		True, True, True, True, True, True, True, True, True, True, True, True,
		True, True, True, True, True, True, True, True, True, True, True, True,
		True, True, True, True, True, True, True, True, True, True, True, True,
		True, True, True, True, True, True, True, True, True, True, True, True,
		True, True, True, True, True, True, True, True, True, True, True, True,
		True, True, True, True
	}
	,
	{}
	,
	TestID->"Catalog_20230416-S22AEX"
]
VerificationTest[
	Map[NumberQ,
		Flatten[
			Map[
				Function[
					Values[FilterRules[FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["parameters"], Except[Catalog`gamma | Catalog`theta]]]
				],
				{"BY", "BKY"}
			]
		]
	]
	,
	{
		True, True, True, True, True, True, True, True, True, True, True, True,
		True, True, True, True, True, True, True, True, True, True, True, True,
		True, True, True, True, True, True, True, True, True, True, True, True,
		True, True, True, True, True, True, True, True, True, True, True, True,
		True, True, True, True, True, True, True, True, True, True, True, True,
		True, True, True, True, True, True, True, True, True, True, True, True,
		True, True, True, True, True, True, True, True, True, True, True, True,
		True, True, True, True, True, True, True, True, True, True, True, True,
		True, True, True, True, True, True, True, True, True, True, True, True,
		True, True, True, True, True, True, True, True, True, True, True, True,
		True, True, True, True, True, True, True, True, True, True, True, True,
		True, True, True, True
	}
	,
	{}
	,
	TestID->"Catalog_20230416-G68E6R"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"]["stateVars"]
	,
	{Catalog`x @ Catalog`t, Catalog`sx @ Catalog`t}
	,
	{}
	,
	TestID->"Catalog_20230416-Q46OWU"
]
VerificationTest[
	Map[MemberQ[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], #]&, {"BY", "BKY"}]
	,
	{True, True}
	,
	{}
	,
	TestID->"Catalog_20230416-AKVU74"
]
VerificationTest[
	Map[AssociationQ,
		Flatten[
			{
				Head @ FernandoDuarte`LongRunRisk`Model`Catalog`models,
				Map[Function @ Head @ FernandoDuarte`LongRunRisk`Model`Catalog`models @ #, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]
			}
		]
	]
	,
	{
		False, False, False, False, False, False, False, False, False, False, False,
		False, False, False, False, False, False
	}
	,
	{}
	,
	TestID->"Catalog_20230416-L0GWU0"
] 
End[]
EndTestSection[]
