BeginTestSection["NiceOutput"]
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`"]

(* Load a package to find paclet root *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];
On[General::shdw];

FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest = False;
Needs @ "FernandoDuarte`LongRunRisk`Tools`NiceOutput`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"];

(* === Shared State Setup === *)
FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp = If[
		FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest, FernandoDuarte`LongRunRisk`Models, KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC", "DES", "NRCStochVol"}]
	];
FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp @ "BY";
FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBKY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp @ "BKY";
FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRC = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp @ "NRC";
FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modDES = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp @ "DES";
FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRCStochVol = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp @ "NRCStochVol";

FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`myModelsInfo = PacletizedResourceFunctions`SetSymbolsContext @ FernandoDuarte`LongRunRisk`Tools`NiceOutput`info @ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp;

VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`justBY = <|"BY" -> FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]|>;
	FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY = PacletizedResourceFunctions`SetSymbolsContext @ FernandoDuarte`LongRunRisk`Tools`NiceOutput`info @ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`justBY;
	FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`newBY = <|"myModel" -> FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]|>;
	FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY = PacletizedResourceFunctions`SetSymbolsContext @ FernandoDuarte`LongRunRisk`Tools`NiceOutput`info @ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`newBY;
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY[[1, 1, 1, 1]], "BY"],
			SameQ[
				PacletizedResourceFunctions`SetSymbolsContext[
					FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY[[1, 1, 1, 2, 1, 4, 1, 1, 2, 1, 1, 1, 1]]
				],
				PacletizedResourceFunctions`SetSymbolsContext @ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`x @ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`t
			],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY[[1, 1, 1, 1]], "BY"],
			SameQ[
				PacletizedResourceFunctions`SetSymbolsContext[
					FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY[[1, 1, 1, 2, 1, 4, 1, 1, 2, 1, 1, 1, 1]]
				],
				PacletizedResourceFunctions`SetSymbolsContext @ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`x @ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`t
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20251223-WJET5C@@Tests/NiceOutput.wlt:121,1-150,2"
]

$ContextPath = DeleteCases[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"];

End[]
EndTestSection[]
