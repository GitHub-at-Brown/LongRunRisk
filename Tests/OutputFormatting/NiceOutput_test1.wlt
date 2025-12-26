BeginTestSection["NiceOutput"]
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`"]

(* Load a package to find paclet root *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];
On[General::shdw];

FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest = False;
Needs @ "FernandoDuarte`LongRunRisk`Tools`NiceOutput`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"];

VerificationTest[
	Module[{pacletFile, pacletRoot},
		pacletFile = FindFile["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];
		pacletRoot = If[StringQ[pacletFile],
			DirectoryName[pacletFile, 3],
			If[StringQ[$InputFileName] && $InputFileName =!= "",
				DirectoryName[$InputFileName, 2],
				Directory[]
			]
		];
		FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`distributedPaclet = FileNameJoin[{
			pacletRoot, "Resources", "PacletizedResourceFunctions.paclet"
		}];
		If[FileExistsQ[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`distributedPaclet],
			PacletInstall[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`distributedPaclet, "IgnoreVersion" -> True];
		];
		True
	]
	,
	True
	,
	{}
	,
	TestID->"NiceOutput_20251223-0M5X2B@@Tests/NiceOutput.wlt:9,1-33,2"
]

$ContextPath = DeleteCases[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"];

End[]
EndTestSection[]
