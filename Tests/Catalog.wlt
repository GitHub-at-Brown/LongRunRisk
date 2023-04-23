BeginTestSection["Catalog"] 
Begin["Catalog`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
	Needs @ "FernandoDuarte`LongRunRisk`Model`ProcessModels`";
	,
	Null
	,
	{}
	,
	TestID->"Catalog_20230423-9JN9HA"
]
VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Catalog`"], MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`ProcessModels`"]}]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230423-31C8FH"
]
VerificationTest[
	!SameQ[Names @ "*processModels", {}]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230423-V8L12A"
]
VerificationTest[
	Apply[And, Map[StringQ, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230423-G32QXB"
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
	TestID->"Catalog_20230423-FI0L41"
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
	TestID->"Catalog_20230423-XODBHV"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"]["stateVars"]
	,
	{Catalog`x @ Catalog`t, Catalog`sx @ Catalog`t}
	,
	{}
	,
	TestID->"Catalog_20230423-EA4MTP"
]
VerificationTest[
	Apply[And, Map[MemberQ[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], #]&, {"BY", "BKY"}]]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20230423-FD5OLO"
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
	TestID->"Catalog_20230423-BEMS1C"
]
VerificationTest[
	Catalog`SetSymbolsContext[
		Block[{Catalog`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[FernandoDuarte`LongRunRisk`Model`Catalog`models]["NRC"], $Context = "ProcessModels`"},
			{Catalog`SetSymbolsContext[Catalog`pi[Catalog`t]] /. Catalog`model["exogenousEq"]}
		]
	]
	,
	Catalog`SetSymbolsContext[
		{
			Catalog`SetSymbolsContext[
				Plus[Catalog`mup,
					Plus[Catalog`rhop * (Catalog`pi[Catalog`t - 1] - Catalog`mup),
						(Catalog`xip * Catalog`eps["p"][Catalog`t - 1]) + Catalog`phip * Catalog`eps["p"][Catalog`t]
					]
				]
			]
		}
	]
	,
	{}
	,
	TestID->"Catalog_20230423-G7WAWY"
] 
End[]
EndTestSection[]
