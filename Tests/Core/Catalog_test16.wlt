BeginTestSection["Catalog"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`Catalog`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

VerificationTest[
	Apply[And,
		Flatten[
			Map[
				Function[
					If[KeyExistsQ[FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo @ #, "initialGuess"],
						{
							If[
								KeyExistsQ[FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo[#]["initialGuess"], "Ewc"],
								VectorQ["Ewc" /. FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo[#]["initialGuess"]],
								True
							],
							If[
								KeyExistsQ[FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo[#]["initialGuess"], "Epd"],
								ArrayQ["Epd" /. FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo[#]["initialGuess"], 2],
								True
							]
						},
						True
					]
				],
				Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20251223-IJ59KY@@Tests/Catalog.wlt:304,1-335,2"
]

End[]
EndTestSection[]
