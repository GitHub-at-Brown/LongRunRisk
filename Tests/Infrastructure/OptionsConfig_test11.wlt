

(* === Shared State Setup === *)
(* Load OptionsConfig via Get with relative path *)
	Module[{testFile = $TestFileName, packageRoot},
	packageRoot = testFile;
	While[
		packageRoot =!= DirectoryName[packageRoot] && 
			!FileExistsQ[FileNameJoin[{packageRoot, "PacletInfo.wl"}]],
		packageRoot = DirectoryName[packageRoot]
	];
	If[!FileExistsQ[FileNameJoin[{packageRoot, "PacletInfo.wl"}]],
		Throw["Cannot find PacletInfo.wl starting from " <> testFile]
	];
	Get[FileNameJoin[{packageRoot, "Kernel", "Tools", "OptionsConfig.wl"}]]
];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"PdEquations" -> "AB",
		"FromScratch" -> True
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"NumKernels" -> 4
	}];
	config["Parallel"]["NumKernels"],
	4,
	TestID -> "normalizeConfig-Legacy-NumKernels@@Tests/Infrastructure/OptionsConfig_test11.wlt:41,1-48,2"
]

