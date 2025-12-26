

VerificationTest[
	(* Load OptionsConfig via Get with relative path *)
	With[{
		testDir = DirectoryName[$TestFileName],
		packageRoot = DirectoryName[DirectoryName[$TestFileName]]
	},
		Get[FileNameJoin[{packageRoot, "Kernel", "Tools", "OptionsConfig.wl"}]];
	];
	Head[FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig],
	Symbol,
	TestID -> "OptionsConfig-Load@@Tests/OptionsConfig.wlt:1,1-12,2"
]

