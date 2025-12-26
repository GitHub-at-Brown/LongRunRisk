

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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"NumKernels" -> 4
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FindRootOptions" -> {MaxIterations -> 50}
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"maxMomentsLagsToCreate" -> 10
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"PdEquations" -> "AB"
	}];

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];
	config["Numerical"]["MaxMaturity"],
	12,
	TestID -> "normalizeConfig-Preserves-Defaults-2@@Tests/OptionsConfig.wlt:124,1-131,2"
]

