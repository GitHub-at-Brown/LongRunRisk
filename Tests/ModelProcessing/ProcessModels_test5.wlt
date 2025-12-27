BeginTestSection["ProcessModels"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`"]

Needs @ "FernandoDuarte`LongRunRisk`";
	Needs @ "FernandoDuarte`LongRunRisk`Model`ProcessModels`";
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest = False;

(* === Shared State Setup === *)
FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest = If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest, FernandoDuarte`LongRunRisk`Model`Catalog`models, KeyTake[FernandoDuarte`LongRunRisk`Model`Catalog`models, {"BY", "BKY", "NRC"}]];
FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP = If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest, FernandoDuarte`LongRunRisk`Models, KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC"}]];

VerificationTest[
	Apply[And,
		Map[StringQ,
			Flatten[
				Map[
					Function @ {
						FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["name"],
						FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["shortname"],
						FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["bibRef"],
						FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["desc"],
						FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["exogenousVars"],
						FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousVars"]
					},
					Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
				]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-SXLDZY@@Tests/ProcessModels.wlt:79,1-103,2"
]

End[]
EndTestSection[]
