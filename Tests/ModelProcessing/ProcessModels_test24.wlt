BeginTestSection["ProcessModels"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`"]

Needs @ "FernandoDuarte`LongRunRisk`";
	Needs @ "FernandoDuarte`LongRunRisk`Model`ProcessModels`";
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest = False;

(* === Shared State Setup === *)
FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest = If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest, FernandoDuarte`LongRunRisk`Model`Catalog`models, KeyTake[FernandoDuarte`LongRunRisk`Model`Catalog`models, {"BY", "BKY", "NRC"}]];
FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP = If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest, FernandoDuarte`LongRunRisk`Models, KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC"}]];

FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC = FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP @ "NRC";

VerificationTest[
	If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest,
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBY = FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest @ "BY";
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBKY = FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest @ "BKY";
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBKYP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[<|"BKY" -> FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBKY|>];
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBYP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[<|"BY" -> FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBY|>];
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModels = <|"myModel" -> FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBKY, "BY" -> FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBY|>;
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsSameName = <|"BY" -> FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBY|>;
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsRename = <|"myModel" -> FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBY|>;
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModels;
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsSameNameP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsSameName;
		FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsRenameP = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsRename;
		Apply[And,
			{
				Function[
					SameQ[
						Function[KeyDrop[#, "coeffsSolution"]][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsP @ "myModel"],
						KeyDrop[#, "coeffsSolution"]
					]
				][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBKYP @ "BKY"],
				Function[
					SameQ[
						Function[KeyDrop[#, "coeffsSolution"]][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsP @ "BY"],
						KeyDrop[#, "coeffsSolution"]
					]
				][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBYP @ "BY"],
				Function[
					SameQ[
						Function[KeyDrop[#, "coeffsSolution"]][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsSameNameP @ "BY"],
						KeyDrop[#, "coeffsSolution"]
					]
				][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBYP @ "BY"],
				Function[
					SameQ[
						Function[KeyDrop[#, "coeffsSolution"]][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`newModelsRenameP @ "myModel"],
						KeyDrop[#, "coeffsSolution"]
					]
				][FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelBYP @ "BY"]
			}
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-35DRFS@@Tests/ProcessModels.wlt:1239,1-1287,2"
]

End[]
EndTestSection[]
