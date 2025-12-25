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
		{
			Apply[And,
				Map[
					Function[
						SameQ[Head @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`notVar @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t,
							Head[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`notVar @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t,
									Normal @ Join[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["exogenousEq"], FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]]
								]
							]
						]
					],
					Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-9GHZX4@@Tests/ProcessModels.wlt:1212,1-1238,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
