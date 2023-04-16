BeginTestSection["Catalog"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`"
	,
	Null
	,
	{}
	,
	TestID->"Catalog_20230415-FSE6IB"
]


VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Catalog`"]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230415-MNMVCC"
]


VerificationTest[
	!SameQ[Names @ "*models", {}]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230415-E94TOA"
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
	TestID->"Catalog_20230415-O5G4JV"
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
	TestID->"Catalog_20230415-7OOG66"
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
	TestID->"Catalog_20230415-ENDY4I"
]


VerificationTest[
	FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"]["stateVars"]
	,
	{x @ t, sx @ t}
	,
	{}
	,
	TestID->"Catalog_20230415-JD6T1C"
]


VerificationTest[
	Map[MemberQ[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], #]&, {"BY", "BKY"}]
	,
	{True, True}
	,
	{}
	,
	TestID->"Catalog_20230415-SETP4B"
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
		Association, Association, Association, Association, Association
	}
	,
	{}
	,
	TestID->"Catalog_20230415-1MUCGN"
]


VerificationTest[
	$ContextPath = Cases[$ContextPath, Except @ "FernandoDuarte`LongRunRisk`Model`Catalog`"];
	,
	Null
	,
	{}
	,
	TestID->"Catalog_20230415-L0M5OM"
]


EndTestSection[]
