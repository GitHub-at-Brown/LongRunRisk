BeginTestSection["ProcessModels"] 
Begin["ProcessModels`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
	Needs @ "FernandoDuarte`LongRunRisk`Model`ProcessModels`";
	,
	Null
	,
	{}
	,
	TestID->"ProcessModels_20230423-2LSFRY"
]
VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Catalog`"], MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`ProcessModels`"]}]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230423-U537GO"
]
VerificationTest[
	Apply[And,
		{
			!SameQ[Names @ "*processModels", {}],
			!SameQ[Names @ "*models", {}]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230423-WXNQV4"
]
VerificationTest[
	Apply[And, Map[StringQ, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230423-5YXMB2"
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
	TestID->"ProcessModels_20230423-3NAMQ6"
]
VerificationTest[
	Apply[And,
		Map[NumberQ,
			Flatten[
				Map[
					Function[
						Values[FilterRules[FernandoDuarte`LongRunRisk`Model`Catalog`models[#]["parameters"], Except[ProcessModels`gamma | ProcessModels`theta]]]
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
	TestID->"ProcessModels_20230423-80VNB5"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"]["stateVars"]
	,
	{ProcessModels`x @ ProcessModels`t, ProcessModels`sx @ ProcessModels`t}
	,
	{}
	,
	TestID->"ProcessModels_20230423-6RXSYE"
]
VerificationTest[
	Apply[And, Map[MemberQ[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], #]&, {"BY", "BKY"}]]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230423-QBOR7P"
]
VerificationTest[
	AllTrue[FernandoDuarte`LongRunRisk`Model`Catalog`models, AssociationQ]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230423-HTSUQ4"
]
VerificationTest[
	AllTrue[Map[FernandoDuarte`LongRunRisk`Model`Catalog`models[#]&, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models], AssociationQ]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230423-7257UB"
]
VerificationTest[
	Get @ "PacletizedResourceFunctions`";
	!SameQ[Names @ "*SetSymbolsContext", {}]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230423-DVXLJO"
]
VerificationTest[
	PacletizedResourceFunctions`SetSymbolsContext[
		Block[{ProcessModels`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[FernandoDuarte`LongRunRisk`Model`Catalog`models]["NRC"], $Context = "ProcessModels`"},
			{PacletizedResourceFunctions`SetSymbolsContext[ProcessModels`pi[ProcessModels`t]] /. ProcessModels`model["exogenousEq"]}
		]
	]
	,
	{
		Plus[ProcessModels`mup,
			Plus[ProcessModels`rhop * (ProcessModels`pi[ProcessModels`t - 1] - ProcessModels`mup),
				(ProcessModels`xip * ProcessModels`eps["p"][ProcessModels`t - 1]) + ProcessModels`phip * ProcessModels`eps["p"][ProcessModels`t]
			]
		]
	}
	,
	{}
	,
	TestID->"ProcessModels_20230423-KMP705"
] 
End[]
EndTestSection[]
