BeginTestSection["Catalog"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`"
	,
	Null
	,
	{}
	,
	TestID->"Catalog_20230409-598F6N"
]


VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`"]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230409-YYVPTB"
]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`"
	,
	Null
	,
	{}
	,
	TestID->"Catalog_20230409-N228LX"
]


VerificationTest[
	!SameQ[Names @ "*models", {}]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230409-PS5NCW"
]


VerificationTest[
	Map[StringQ, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]
	,
	{True, True, True, True, True, True, True, True, True, True, True, True, True, True, True}
	,
	{}
	,
	TestID->"Catalog_20230409-GXUDGX"
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
	TestID->"Catalog_20230409-E25615"
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
	TestID->"Catalog_20230409-Q3CWK6"
]


VerificationTest[
	FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"]["stateVars"]
	,
	{x @ t, sx @ t}
	,
	{}
	,
	TestID->"Catalog_20230409-EDGEQC"
]


VerificationTest[
	Map[MemberQ[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], #]&, {"BY", "BKY"}]
	,
	{True, True}
	,
	{}
	,
	TestID->"Catalog_20230409-NC720E"
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
	TestID->"Catalog_20230409-U482S1"
]


EndTestSection[]
