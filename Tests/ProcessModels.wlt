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
	TestID->"ProcessModels_20230422-9N3SZQ"
]
VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Catalog`"], MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`ProcessModels`"]}]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230422-OQEXXP"
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
	TestID->"ProcessModels_20230422-0G96K9"
]
VerificationTest[
	Apply[And, Map[StringQ, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230422-O5W5UZ"
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
	TestID->"ProcessModels_20230422-SGMQL1"
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
	TestID->"ProcessModels_20230422-VHB2PA"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"]["stateVars"]
	,
	{ProcessModels`x @ ProcessModels`t, ProcessModels`sx @ ProcessModels`t}
	,
	{}
	,
	TestID->"ProcessModels_20230422-BIFT7N"
]
VerificationTest[
	Apply[And, Map[MemberQ[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], #]&, {"BY", "BKY"}]]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230422-VQWHQ9"
]
VerificationTest[
	AllTrue[FernandoDuarte`LongRunRisk`Model`Catalog`models, AssociationQ]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230422-ZEO85B"
]
VerificationTest[
	AllTrue[Map[FernandoDuarte`LongRunRisk`Model`Catalog`models[#]&, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models], AssociationQ]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230422-PTX6YT"
]
VerificationTest[
	Block[{ProcessModels`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[FernandoDuarte`LongRunRisk`Model`Catalog`models]["NRC"], $Context = "ProcessModels`"},
		{ProcessModels`pi[ProcessModels`t] /. ProcessModels`model["exogenousEq"]}
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
	TestID->"ProcessModels_20230422-423KYL"
]
VerificationTest[
	Block[{ProcessModels`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[FernandoDuarte`LongRunRisk`Model`Catalog`models]["NRC"], $Context = "ProcessModels`"},
		{(ProcessModels`pi[ProcessModels`t] /. ProcessModels`model["exogenousEq"]) /. ProcessModels`model["exogenousEq"]}
	]
	,
	{
		Plus[ProcessModels`mup,
			Plus[ProcessModels`xip * ProcessModels`eps["p"][ProcessModels`t - 1],
				Plus[
					Times[ProcessModels`rhop,
						Plus[ProcessModels`rhop * (ProcessModels`pi[ProcessModels`t - 2] - ProcessModels`mup),
							(ProcessModels`xip * ProcessModels`eps["p"][ProcessModels`t - 2]) + ProcessModels`phip * ProcessModels`eps["p"][ProcessModels`t - 1]
						]
					],
					ProcessModels`phip * ProcessModels`eps["p"][ProcessModels`t]
				]
			]
		]
	}
	,
	{}
	,
	TestID->"ProcessModels_20230422-T3757Z"
]
VerificationTest[
	Block[{ProcessModels`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[FernandoDuarte`LongRunRisk`Model`Catalog`models]["NRC"], $Context = "ProcessModels`"},
		{ProcessModels`eps["dc"][ProcessModels`t] /. ProcessModels`model["exogenousEq"]}
	]
	,
	{ProcessModels`eps["dc"][ProcessModels`t]}
	,
	{}
	,
	TestID->"ProcessModels_20230422-Q6R5XJ"
]
VerificationTest[
	Block[{ProcessModels`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[FernandoDuarte`LongRunRisk`Model`Catalog`models]["NRC"], $Context = "ProcessModels`"},
		{ProcessModels`dd[ProcessModels`t, ProcessModels`i] /. ProcessModels`model["exogenousEq"]}
	]
	,
	{
		Plus[ProcessModels`mud @ ProcessModels`i,
			Plus[(ProcessModels`pi[ProcessModels`t - 1] - ProcessModels`mup) * ProcessModels`rhodp[ProcessModels`i],
				(ProcessModels`phidc[ProcessModels`i] * ProcessModels`eps["dc"][ProcessModels`t]) + ProcessModels`sg[ProcessModels`t - 2] * ProcessModels`xid[ProcessModels`i] * ProcessModels`eps["p"][ProcessModels`t - 1]
			]
		]
	}
	,
	{}
	,
	TestID->"ProcessModels_20230422-TZE8DL"
]
VerificationTest[
	Block[{ProcessModels`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[FernandoDuarte`LongRunRisk`Model`Catalog`models]["NRC"], $Context = "ProcessModels`"},
		{ProcessModels`wc[ProcessModels`t] /. ProcessModels`model["endogenousEq"]}
	]
	,
	{
		Plus[ProcessModels`A @ 0,
			Plus[ProcessModels`A[1] * (ProcessModels`pi[ProcessModels`t] - ProcessModels`mup),
				Plus[ProcessModels`A[4] * (ProcessModels`sg[ProcessModels`t] - ProcessModels`Esg),
					Plus[
						Times[ProcessModels`A @ 5,
							Subtract[
								(ProcessModels`sg[ProcessModels`t] ^ 2) - (ProcessModels`phig ^ 2) / (1 - ProcessModels`rhog ^ 2),
								ProcessModels`Esg ^ 2
							]
						],
						(ProcessModels`A[3] * ProcessModels`eps["p"][ProcessModels`t]) + ProcessModels`A[2] * ProcessModels`sg[ProcessModels`t - 1] * ProcessModels`eps["p"][ProcessModels`t]
					]
				]
			]
		]
	}
	,
	{}
	,
	TestID->"ProcessModels_20230422-977FKP"
]
VerificationTest[
	Block[{ProcessModels`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[FernandoDuarte`LongRunRisk`Model`Catalog`models]["NRC"], $Context = "ProcessModels`"},
		{ProcessModels`pd[ProcessModels`t, ProcessModels`i] /. ProcessModels`model["endogenousEq"]}
	]
	,
	{
		Plus[ProcessModels`B[ProcessModels`i][0],
			Plus[(ProcessModels`pi[ProcessModels`t] - ProcessModels`mup) * ProcessModels`B[ProcessModels`i][1],
				Plus[(ProcessModels`sg[ProcessModels`t] - ProcessModels`Esg) * ProcessModels`B[ProcessModels`i][4],
					Plus[
						Times[
							Subtract[
								(ProcessModels`sg[ProcessModels`t] ^ 2) - (ProcessModels`phig ^ 2) / (1 - ProcessModels`rhog ^ 2),
								ProcessModels`Esg ^ 2
							],
							ProcessModels`B[ProcessModels`i][5]
						],
						Plus[ProcessModels`sg[ProcessModels`t - 1] * ProcessModels`B[ProcessModels`i][2] * ProcessModels`eps["p"][ProcessModels`t],
							ProcessModels`B[ProcessModels`i][3] * ProcessModels`eps["p"][ProcessModels`t]
						]
					]
				]
			]
		]
	}
	,
	{}
	,
	TestID->"ProcessModels_20230422-INX2G9"
]
VerificationTest[
	Block[{ProcessModels`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[FernandoDuarte`LongRunRisk`Model`Catalog`models]["NRC"], $Context = "ProcessModels`"},
		{ProcessModels`bondexcret[ProcessModels`t, ProcessModels`i] /. ProcessModels`model["endogenousEq"]}
	]
	,
	{ProcessModels`bondret[ProcessModels`t, ProcessModels`i, 1] - ProcessModels`bondyield[ProcessModels`t - 1, 1]}
	,
	{}
	,
	TestID->"ProcessModels_20230422-ISB5GL"
]
VerificationTest[
	Block[{ProcessModels`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[FernandoDuarte`LongRunRisk`Model`Catalog`models]["NRC"], $Context = "ProcessModels`"},
		{
			SameQ[ProcessModels`bondexcret[ProcessModels`t, ProcessModels`i] //. ProcessModels`model["endogenousEq"],
				ProcessModels`bondexcret[ProcessModels`t, ProcessModels`i, 1] //. ProcessModels`model["endogenousEq"]
			]
		}
	]
	,
	{True}
	,
	{}
	,
	TestID->"ProcessModels_20230422-3RHHIG"
]
VerificationTest[
	Block[{ProcessModels`model = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[FernandoDuarte`LongRunRisk`Model`Catalog`models]["NRC"], $Context = "ProcessModels`"},
		Apply[And,
			{
				AllTrue[Map[Head, Keys @ ProcessModels`model @ "exogenousEq"], MatchQ[#, Symbol]&],
				AllTrue[Map[Head, Keys @ ProcessModels`model @ "endogenousEq"], MatchQ[#, Symbol]&]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20230422-4UC8XX"
] 
End[]
EndTestSection[]
