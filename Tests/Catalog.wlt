BeginTestSection["Catalog"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`"
	,
	Null
	,
	{}
	,
	TestID->"Catalog_20230415-O5SYS6"
]


VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`"]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230415-Z1XY80"
]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`"
	,
	Null
	,
	{}
	,
	TestID->"Catalog_20230415-75CEP6"
]


VerificationTest[
	!SameQ[Names @ "*models", {}]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230415-OU7EMA"
]


VerificationTest[
	Map[StringQ, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]
	,
	{True, True, True, True, True, True, True, True, True, True, True, True, True, True, True}
	,
	{}
	,
	TestID->"Catalog_20230415-NYR54B"
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
		True, True, True, True, True, True, True, True, True, True, True, True
	}
	,
	{}
	,
	TestID->"Catalog_20230415-NSW847"
]


VerificationTest[
	Map[NumberQ,
		Flatten[
			Map[
				Function[
					Values[FilterRules[FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["parameters"], Except[gamma | theta]]]
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
	TestID->"Catalog_20230415-C16HFL"
]


VerificationTest[
	FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"]["stateVars"]
	,
	{x @ t, sx @ t}
	,
	{}
	,
	TestID->"Catalog_20230415-V9KZ88"
]


VerificationTest[
	Map[MemberQ[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], #]&, {"BY", "BKY"}]
	,
	{True, True}
	,
	{}
	,
	TestID->"Catalog_20230415-YNYG75"
]


VerificationTest[
	Flatten[
		{
			Head @ FernandoDuarte`LongRunRisk`Model`Catalog`models,
			Map[Function @ Head @ FernandoDuarte`LongRunRisk`Model`Catalog`models @ #, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]
		}
	]
	,
	{
		Association, Association, Association, Association, Association, Association,
		Association, Association, Association, Association, Association, Association,
		Association, Association, Association, Association
	}
	,
	{}
	,
	TestID->"Catalog_20230415-QGC35Z"
]


EndTestSection[]
