BeginTestSection["Catalog"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`"
	,
	Null
	,
	{}
	,
	TestID->"Catalog_20230409-1N009Y"
]


VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`"]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230409-DXJURD"
]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`"
	,
	Null
	,
	{}
	,
	TestID->"Catalog_20230409-BS7LY9"
]


VerificationTest[
	!SameQ[Names @ "*models", {}]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230409-SV9YAT"
]


VerificationTest[
	Map[StringQ, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]
	,
	{True, True, True, True, True, True, True, True, True, True, True, True, True, True, True}
	,
	{}
	,
	TestID->"Catalog_20230409-EDEQJ2"
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
	TestID->"Catalog_20230409-B614GG"
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
	TestID->"Catalog_20230409-A2GEFV"
]


VerificationTest[
	FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"]["stateVars"]
	,
	{x @ t, sx @ t}
	,
	{}
	,
	TestID->"Catalog_20230409-O76X3R"
]


VerificationTest[
	Map[MemberQ[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], #]&, {"BY", "BKY"}]
	,
	{True, True}
	,
	{}
	,
	TestID->"Catalog_20230409-94MN6Y"
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
	TestID->"Catalog_20230409-0FE1VR"
]


EndTestSection[]
