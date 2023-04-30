BeginTestSection["ProcessModels"] 
Begin["ProcessModels`"]
VerificationTest[
	Get @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
	Needs @ "FernandoDuarte`LongRunRisk`Model`ProcessModels`";
	Needs @ "PacletizedResourceFunctions`";
	,
	Null
	,
	{}
	,
	TestID->"ProcessModels_20230430-LQGN9L"
]
VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Catalog`"], MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`ProcessModels`"]}]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230430-2VUU3H"
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
	TestID->"ProcessModels_20230430-MM0N2R"
]
VerificationTest[
	ProcessModels`myModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;
	Apply[And, Map[StringQ, Keys @ ProcessModels`myModels]]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230430-6XBRD7"
]
VerificationTest[
	Apply[And,
		Map[StringQ,
			Flatten[
				Map[
					Function @ {
						ProcessModels`myModels[#]["name"],
						ProcessModels`myModels[#]["shortname"],
						ProcessModels`myModels[#]["bibRef"],
						ProcessModels`myModels[#]["desc"]
					},
					Keys @ ProcessModels`myModels
				]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230430-WMC319"
]
VerificationTest[
	Apply[And,
		Map[NumberQ,
			Flatten[
				Map[
					Function[
						Values[
							N[
								Association[ProcessModels`myModels[#]["parameters"]] //. ProcessModels`myModels[#]["parameters"]
							]
						]
					],
					Keys @ ProcessModels`myModels
				]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230430-IM6EQG"
]
VerificationTest[
	PacletizedResourceFunctions`SetSymbolsContext[
		Block[{ProcessModels`model = ProcessModels`myModels @ "BY", $Context = "ProcessModels`"}, ProcessModels`model @ "stateVars"]
	]
	,
	{ProcessModels`x @ ProcessModels`t, ProcessModels`sx @ ProcessModels`t}
	,
	{}
	,
	TestID->"ProcessModels_20230430-E0UA32"
]
VerificationTest[
	Apply[And, Map[MemberQ[Keys[ProcessModels`myModels], #]&, {"BY", "BKY"}]]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230430-AROFNG"
]
VerificationTest[
	AllTrue[ProcessModels`myModels, AssociationQ]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230430-OE90D5"
]
VerificationTest[
	AllTrue[Map[ProcessModels`myModels[#]&, Keys @ ProcessModels`myModels], AssociationQ]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230430-I4KF9P"
]
VerificationTest[
	Get @ "PacletizedResourceFunctions`";
	!SameQ[Names @ "*SetSymbolsContext", {}]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230430-RZRH6P"
]
VerificationTest[
	PacletizedResourceFunctions`SetSymbolsContext[
		Block[{ProcessModels`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[ProcessModels`myModels]["NRC"], $Context = "ProcessModels`"},
			{
				PacletizedResourceFunctions`SetSymbolsContext[ProcessModels`pi[ProcessModels`t] /. PacletizedResourceFunctions`SetSymbolsContext[ProcessModels`model["exogenousEq"]]],
				PacletizedResourceFunctions`SetSymbolsContext[
					Plus[ProcessModels`mup,
						Plus[ProcessModels`rhop * (ProcessModels`pi[ProcessModels`t - 1] - ProcessModels`mup),
							(ProcessModels`xip * ProcessModels`eps["pi"][ProcessModels`t - 1]) + ProcessModels`phip * ProcessModels`eps["pi"][ProcessModels`t]
						]
					]
				]
			}
		]
	]
	,
	{
		Plus[ProcessModels`mup,
			Plus[ProcessModels`rhop * (ProcessModels`pi[ProcessModels`t - 1] - ProcessModels`mup),
				(ProcessModels`xip * ProcessModels`eps["pi"][ProcessModels`t - 1]) + ProcessModels`phip * ProcessModels`eps["pi"][ProcessModels`t]
			]
		],
		Plus[ProcessModels`mup,
			Plus[ProcessModels`rhop * (ProcessModels`pi[ProcessModels`t - 1] - ProcessModels`mup),
				(ProcessModels`xip * ProcessModels`eps["pi"][ProcessModels`t - 1]) + ProcessModels`phip * ProcessModels`eps["pi"][ProcessModels`t]
			]
		]
	}
	,
	{}
	,
	TestID->"ProcessModels_20230430-CNQZU4"
]
VerificationTest[
	PacletizedResourceFunctions`SetSymbolsContext[
		Block[{ProcessModels`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[ProcessModels`myModels]["BY"], $Context = "ProcessModels`"},
			SameQ[{PacletizedResourceFunctions`SetSymbolsContext[ProcessModels`wc[ProcessModels`t] /. ProcessModels`model["endogenousEq"]]},
				{ProcessModels`A[0] + (ProcessModels`A[2] * ProcessModels`sx[ProcessModels`t]) + ProcessModels`A[1] * ProcessModels`x[ProcessModels`t]}
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230430-H47GX8"
]
VerificationTest[
	PacletizedResourceFunctions`SetSymbolsContext[
		Block[{ProcessModels`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[ProcessModels`myModels]["BY"], $Context = "ProcessModels`"},
			SameQ[{PacletizedResourceFunctions`SetSymbolsContext[ProcessModels`pd[ProcessModels`t, ProcessModels`i] /. ProcessModels`model["endogenousEq"]]},
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
	TestID->"ProcessModels_20230430-4WYFNQ"
]
VerificationTest[
	PacletizedResourceFunctions`SetSymbolsContext[
		Block[{ProcessModels`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[ProcessModels`myModels]["NRC"], $Context = "ProcessModels`"},
			SameQ[
				{PacletizedResourceFunctions`SetSymbolsContext[ProcessModels`bondexcret[ProcessModels`t, ProcessModels`m] /. ProcessModels`model["endogenousEq"]]},
				{ProcessModels`bondret[ProcessModels`t, ProcessModels`m, 1] - ProcessModels`bondyield[ProcessModels`t - 1, 1]}
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230430-JWVGH2"
]
VerificationTest[
	PacletizedResourceFunctions`SetSymbolsContext[
		Block[
			{
				ProcessModels`modelsP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ ProcessModels`myModels,
				ProcessModels`modelBY = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[ProcessModels`myModels]["BY"],
				ProcessModels`modelBKY = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[ProcessModels`myModels]["BKY"],
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
	TestID->"ProcessModels_20230430-BJRV99"
] 
End[]
EndTestSection[]
