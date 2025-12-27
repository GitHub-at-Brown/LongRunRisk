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
		Map[NumberQ, Map[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["numStocks"]&, Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP]]
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-A7U14Y@@Tests/ProcessModels.wlt:803,1-813,2"
]

End[]
EndTestSection[]
