BeginTestSection["Catalog"] 
Begin["Catalog`"]
VerificationTest[
	Get @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
	Needs @ "FernandoDuarte`LongRunRisk`Model`ProcessModels`";
	Needs @ "PacletizedResourceFunctions`";
	,
	Null
	,
	{}
	,
	TestID->"Catalog_20230430-5B0DZE"
]
VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Catalog`"], MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`ProcessModels`"]}]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230430-CGYW9A"
]
VerificationTest[
	!SameQ[Names @ "*processModels", {}]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230430-XEO7BX"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Model`Catalog`models = PacletizedResourceFunctions`SetSymbolsContext @ FernandoDuarte`LongRunRisk`Model`Catalog`models;
	Apply[And, Map[StringQ, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230430-2XB46L"
]
VerificationTest[
	Apply[And,
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
	]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230430-7Y5QR3"
]
VerificationTest[
	Apply[And,
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
	]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230430-746FXB"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"]["stateVars"]
	,
	{Catalog`x @ Catalog`t, Catalog`sx @ Catalog`t}
	,
	{}
	,
	TestID->"Catalog_20230430-PTW6QX"
]
VerificationTest[
	Apply[And, Map[MemberQ[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], #]&, {"BY", "BKY"}]]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230430-7GZ4W5"
]
VerificationTest[
	Apply[And,
		Map[AssociationQ,
			Flatten[
				{
					Head @ FernandoDuarte`LongRunRisk`Model`Catalog`models,
					Map[Function @ Head @ FernandoDuarte`LongRunRisk`Model`Catalog`models @ #, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]
				}
			]
		]
	]
	,
	False
	,
	{}
	,
	TestID->"Catalog_20230430-BUOGJB"
]
VerificationTest[
	PacletizedResourceFunctions`SetSymbolsContext[
		Block[{Catalog`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[FernandoDuarte`LongRunRisk`Model`Catalog`models]["NRC"], $Context = "ProcessModels`"},
			{PacletizedResourceFunctions`SetSymbolsContext[Catalog`pi[Catalog`t]] /. Catalog`model["exogenousEq"]}
		]
	]
	,
	{Catalog`pi @ Catalog`t}
	,
	{}
	,
	TestID->"Catalog_20230430-BC1D0D"
] 
End[]
EndTestSection[]
