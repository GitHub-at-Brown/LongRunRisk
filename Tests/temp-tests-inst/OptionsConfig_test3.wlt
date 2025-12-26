

(* === Shared State Setup === *)
(* Load OptionsConfig via Get with relative path *)
	With[{
		testDir = DirectoryName[$TestFileName],
		packageRoot = DirectoryName[DirectoryName[$TestFileName]]
	},
		Get[FileNameJoin[{packageRoot, "Kernel", "Tools", "OptionsConfig.wl"}]];
	];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	AllTrue[{"Symbolic", "Compile", "Numerical", "Moments", "Parallel", "Build"},
		KeyExistsQ[config, #] &
	],
	True,
	TestID -> "defaultConfig-Has-All-Subsystems@@Tests/OptionsConfig.wlt:21,1-28,2"
]

