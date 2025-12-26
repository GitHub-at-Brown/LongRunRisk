

(* === Shared State Setup === *)
(* Load OptionsConfig via Get with relative path *)
	With[{
		testDir = DirectoryName[$TestFileName],
		packageRoot = DirectoryName[DirectoryName[$TestFileName]]
	},
		Get[FileNameJoin[{packageRoot, "Kernel", "Tools", "OptionsConfig.wl"}]];
	];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"PdEquations" -> "AB",
		"FromScratch" -> True
	}];
	config["Symbolic"]["PdEquations"],
	"AB",
	TestID -> "normalizeConfig-Legacy-PdEquations@@Tests/OptionsConfig.wlt:67,1-75,2"
]

