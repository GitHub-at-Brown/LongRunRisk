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
	TestID->"ProcessModels_20230423-VN6E9J"
]
VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Catalog`"], MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`ProcessModels`"]}]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230423-33YU84"
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
	TestID->"ProcessModels_20230423-067LMQ"
]
VerificationTest[
	Apply[And, Map[StringQ, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230423-U36TUO"
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
	TestID->"ProcessModels_20230423-P1RA97"
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
	TestID->"ProcessModels_20230423-J7XNGO"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"]["stateVars"]
	,
	{ProcessModels`x @ ProcessModels`t, ProcessModels`sx @ ProcessModels`t}
	,
	{}
	,
	TestID->"ProcessModels_20230423-UNNTW4"
]
VerificationTest[
	Apply[And, Map[MemberQ[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], #]&, {"BY", "BKY"}]]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230423-SZN3DS"
]
VerificationTest[
	AllTrue[FernandoDuarte`LongRunRisk`Model`Catalog`models, AssociationQ]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230423-BKEF3V"
]
VerificationTest[
	AllTrue[Map[FernandoDuarte`LongRunRisk`Model`Catalog`models[#]&, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models], AssociationQ]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230423-IGKT8B"
]
VerificationTest[
	Get @ "PacletizedResourceFunctions`";
	!SameQ[Names @ "*SetSymbolsContext", {}]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230423-UZ7IWK"
]
VerificationTest[
	PacletizedResourceFunctions`SetSymbolsContext[
		Block[{ProcessModels`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[FernandoDuarte`LongRunRisk`Model`Catalog`models]["NRC"], $Context = "ProcessModels`"},
			SameQ[{PacletizedResourceFunctions`SetSymbolsContext[ProcessModels`pi[ProcessModels`t]] /. ProcessModels`model["exogenousEq"]},
				{
					Plus[ProcessModels`mup,
						Plus[ProcessModels`rhop * (ProcessModels`pi[ProcessModels`t - 1] - ProcessModels`mup),
							(ProcessModels`xip * ProcessModels`eps["p"][ProcessModels`t - 1]) + ProcessModels`phip * ProcessModels`eps["p"][ProcessModels`t]
						]
					]
				}
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230423-Y3GDZ8"
]
VerificationTest[
	PacletizedResourceFunctions`SetSymbolsContext[
		Block[{ProcessModels`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[FernandoDuarte`LongRunRisk`Model`Catalog`models]["BY"], $Context = "ProcessModels`"},
			SameQ[{PacletizedResourceFunctions`SetSymbolsContext[ProcessModels`wc[ProcessModels`t]] /. ProcessModels`model["endogenousEq"]},
				{ProcessModels`A[0] + (ProcessModels`A[2] * ProcessModels`sx[ProcessModels`t]) + ProcessModels`A[1] * ProcessModels`x[ProcessModels`t]}
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230423-BP0OFQ"
]
VerificationTest[
	PacletizedResourceFunctions`SetSymbolsContext[
		Block[{ProcessModels`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[FernandoDuarte`LongRunRisk`Model`Catalog`models]["BY"], $Context = "ProcessModels`"},
			SameQ[{PacletizedResourceFunctions`SetSymbolsContext[ProcessModels`pd[ProcessModels`t, ProcessModels`i]] /. ProcessModels`model["endogenousEq"]},
				{
					Plus[ProcessModels`B[ProcessModels`i][0],
						(ProcessModels`B[ProcessModels`i][2] * ProcessModels`sx[ProcessModels`t]) + ProcessModels`B[ProcessModels`i][1] * ProcessModels`x[ProcessModels`t]
					]
				}
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230423-IXHI7U"
]
VerificationTest[
	PacletizedResourceFunctions`SetSymbolsContext[
		Block[{ProcessModels`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[FernandoDuarte`LongRunRisk`Model`Catalog`models]["NRC"], $Context = "ProcessModels`"},
			SameQ[
				{PacletizedResourceFunctions`SetSymbolsContext[ProcessModels`bondexcret[ProcessModels`t, ProcessModels`m]] /. ProcessModels`model["endogenousEq"]},
				{ProcessModels`bondret[ProcessModels`t, ProcessModels`m, 1] - ProcessModels`bondyield[ProcessModels`t - 1, 1]}
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230423-WOI760"
]
VerificationTest[
	PacletizedResourceFunctions`SetSymbolsContext[
		Block[
			{
				ProcessModels`modelsP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ FernandoDuarte`LongRunRisk`Model`Catalog`models,
				ProcessModels`modelBY = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[FernandoDuarte`LongRunRisk`Model`Catalog`models]["BY"],
				ProcessModels`modelBKY = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[FernandoDuarte`LongRunRisk`Model`Catalog`models]["BKY"],
				ProcessModels`newModels, ProcessModels`newModelsP, $Context = "ProcessModels`"
			},
			ProcessModels`newModels = <|"myModel" -> ProcessModels`modelBKY, "BY" -> ProcessModels`modelBY|>;
			ProcessModels`newModelsP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ ProcessModels`newModels;
			Apply[And,
				{
					SameQ[ProcessModels`newModelsP @ "myModel", ProcessModels`modelsP @ "BKY"],
					SameQ[ProcessModels`newModelsP @ "BY", ProcessModels`modelsP @ "BY"]
				}
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230423-OWN0DS"
] 
End[]
EndTestSection[]
