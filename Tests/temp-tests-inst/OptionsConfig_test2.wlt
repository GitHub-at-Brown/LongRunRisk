

(* === Shared State Setup === *)
(* Load OptionsConfig via Get with relative path *)
	With[{
		testDir = DirectoryName[$TestFileName],
		packageRoot = DirectoryName[DirectoryName[$TestFileName]]
	},
		Get[FileNameJoin[{packageRoot, "Kernel", "Tools", "OptionsConfig.wl"}]];
	];

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	AssociationQ[config],
	True,
	TestID -> "defaultConfig-Returns-Association@@Tests/OptionsConfig.wlt:14,1-19,2"
]

