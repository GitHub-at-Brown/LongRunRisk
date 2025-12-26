BeginTestSection["ProcessModels"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`"]

Needs @ "FernandoDuarte`LongRunRisk`";
	Needs @ "FernandoDuarte`LongRunRisk`Model`ProcessModels`";
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest = False;

(* === Shared State Setup === *)
FernandoDuarte`LongRunRisk`Models = Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest = If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest, FernandoDuarte`LongRunRisk`Model`Catalog`models, KeyTake[FernandoDuarte`LongRunRisk`Model`Catalog`models, {"BY", "BKY", "NRC"}]];
FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP = If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest, FernandoDuarte`LongRunRisk`Models, KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC"}]];

FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC = FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP @ "NRC";

VerificationTest[
	Apply[And,
		Flatten[
			Map[
				Function[
					Map[NumberQ,
						Flatten[
							Map[
								Values,
								{
									Part[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["coeffsSolutionN"], 1, "A"],
									Part[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["coeffsSolutionN"], 1, "Stocks", 1, 1, "B"],
									Part[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["coeffsSolutionN"], 1, "Bond"],
									Part[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["coeffsSolutionN"], 1, "NomBond"]
								}
							]
						]
					]
				],
				Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-JR775W@@Tests/ProcessModels.wlt:1288,1-1317,2"
]

End[]
EndTestSection[]
