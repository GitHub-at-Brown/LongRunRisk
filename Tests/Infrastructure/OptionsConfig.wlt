BeginTestSection["OptionsConfig Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Infrastructure`OptionsConfig`"]

(* --- merged from: OptionsConfig_test1.wlt --- *)
VerificationTest[
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
	Head[FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig],
	Symbol,
	TestID -> "OptionsConfig-Load@@Tests/Infrastructure/OptionsConfig.wlt:5,1-22,2"
]

(* --- merged from: OptionsConfig_test2.wlt --- *)
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

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	AssociationQ[config],
	True,
	TestID -> "defaultConfig-Returns-Association@@Tests/Infrastructure/OptionsConfig.wlt:40,1-45,2"
]

(* --- merged from: OptionsConfig_test3.wlt --- *)
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

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	AllTrue[{"Symbolic", "Compile", "Numerical", "Moments", "Parallel", "Build"},
		KeyExistsQ[config, #] &
	],
	True,
	TestID -> "defaultConfig-Has-All-Subsystems@@Tests/Infrastructure/OptionsConfig.wlt:65,1-72,2"
]

(* --- merged from: OptionsConfig_test4.wlt --- *)
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

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	config["Symbolic"]["PdEquations"],
	"B",
	TestID -> "defaultConfig-Symbolic-PdEquations@@Tests/Infrastructure/OptionsConfig.wlt:94,1-99,2"
]

(* --- merged from: OptionsConfig_test5.wlt --- *)
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

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	config["Numerical"]["MaxMaturity"],
	12,
	TestID -> "defaultConfig-Numerical-MaxMaturity@@Tests/Infrastructure/OptionsConfig.wlt:123,1-128,2"
]

(* --- merged from: OptionsConfig_test6.wlt --- *)
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

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	config["Build"]["MaxMaturity"],
	120,
	TestID -> "defaultConfig-Build-MaxMaturity@@Tests/Infrastructure/OptionsConfig.wlt:154,1-159,2"
]

(* --- merged from: OptionsConfig_test7.wlt --- *)
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

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	config["Build"]["FromScratch"],
	False,
	TestID -> "defaultConfig-Build-FromScratch@@Tests/Infrastructure/OptionsConfig.wlt:187,1-192,2"
]

(* --- merged from: OptionsConfig_test8.wlt --- *)
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

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	config["Parallel"]["NumKernels"],
	Automatic,
	TestID -> "defaultConfig-Parallel-NumKernels@@Tests/Infrastructure/OptionsConfig.wlt:222,1-227,2"
]

(* --- merged from: OptionsConfig_test9.wlt --- *)
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

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"PdEquations" -> "AB",
		"FromScratch" -> True
	}];
	config["Symbolic"]["PdEquations"],
	"AB",
	TestID -> "normalizeConfig-Legacy-PdEquations@@Tests/Infrastructure/OptionsConfig.wlt:259,1-267,2"
]

(* --- merged from: OptionsConfig_test10.wlt --- *)
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

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];
	config["Build"]["FromScratch"],
	True,
	TestID -> "normalizeConfig-Legacy-FromScratch@@Tests/Infrastructure/OptionsConfig.wlt:304,1-311,2"
]

(* --- merged from: OptionsConfig_test11.wlt --- *)
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
	TestID -> "normalizeConfig-Legacy-NumKernels@@Tests/Infrastructure/OptionsConfig.wlt:352,1-359,2"
]

(* --- merged from: OptionsConfig_test12.wlt --- *)
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

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FindRootOptions" -> {MaxIterations -> 50}
	}];
	config["Numerical"]["FindRoot"]["Options"],
	{MaxIterations -> 50},
	TestID -> "normalizeConfig-Legacy-FindRootOptions@@Tests/Infrastructure/OptionsConfig.wlt:404,1-411,2"
]

(* --- merged from: OptionsConfig_test13.wlt --- *)
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

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"maxMomentsLagsToCreate" -> 10
	}];
	config["Moments"]["maxMomentsLagsToCreate"],
	10,
	TestID -> "normalizeConfig-Legacy-MaxMomentsLags@@Tests/Infrastructure/OptionsConfig.wlt:460,1-467,2"
]

(* --- merged from: OptionsConfig_test14.wlt --- *)
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

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"PdEquations" -> "AB"
	}];
	config["Build"]["FromScratch"],
	False,
	TestID -> "normalizeConfig-Preserves-Defaults-1@@Tests/Infrastructure/OptionsConfig.wlt:520,1-527,2"
]

(* --- merged from: OptionsConfig_test15.wlt --- *)
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
	TestID -> "normalizeConfig-Preserves-Defaults-2@@Tests/Infrastructure/OptionsConfig.wlt:584,1-591,2"
]

(* --- merged from: OptionsConfig_test16.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

VerificationTest[
	config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
	config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];
	config3["Symbolic"]["PdEquations"],
	"AB",
	TestID -> "normalizeConfig-Already-Normalized-Override@@Tests/Infrastructure/OptionsConfig.wlt:652,1-659,2"
]

(* --- merged from: OptionsConfig_test17.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

VerificationTest[
	config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
	config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];
	config3["Build"]["FromScratch"],
	False,
	TestID -> "normalizeConfig-Already-Normalized-Defaults@@Tests/Infrastructure/OptionsConfig.wlt:724,1-730,2"
]

(* --- merged from: OptionsConfig_test18.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

VerificationTest[
	merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];
	merged["A"]["x"],
	1,
	TestID -> "mergeNested-Preserves-Nested-1@@Tests/Infrastructure/OptionsConfig.wlt:798,1-806,2"
]

(* --- merged from: OptionsConfig_test19.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

VerificationTest[
	merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];
	merged["A"]["y"],
	99,
	TestID -> "mergeNested-Overrides-Nested@@Tests/Infrastructure/OptionsConfig.wlt:879,1-887,2"
]

(* --- merged from: OptionsConfig_test20.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

VerificationTest[
	merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];
	merged["B"]["z"],
	3,
	TestID -> "mergeNested-Preserves-Other-Keys@@Tests/Infrastructure/OptionsConfig.wlt:965,1-973,2"
]

(* --- merged from: OptionsConfig_test21.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

VerificationTest[
	merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];
	merged["C"]["w"],
	4,
	TestID -> "mergeNested-Adds-New-Keys@@Tests/Infrastructure/OptionsConfig.wlt:1056,1-1064,2"
]

(* --- merged from: OptionsConfig_test22.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

VerificationTest[
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`isNormalized[<|
		"Symbolic" -> <||>
	|>],
	True,
	TestID -> "isNormalized-True-Symbolic@@Tests/Infrastructure/OptionsConfig.wlt:1152,1-1158,2"
]

(* --- merged from: OptionsConfig_test23.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

VerificationTest[
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`isNormalized[<|
		"Build" -> <||>
	|>],
	True,
	TestID -> "isNormalized-True-Build@@Tests/Infrastructure/OptionsConfig.wlt:1246,1-1252,2"
]

(* --- merged from: OptionsConfig_test24.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

VerificationTest[
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`isNormalized[<|
		"RandomKey" -> <||>
	|>],
	False,
	TestID -> "isNormalized-False-RandomKey@@Tests/Infrastructure/OptionsConfig.wlt:1340,1-1346,2"
]

(* --- merged from: OptionsConfig_test25.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

VerificationTest[
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`isNormalized[{
		"PdEquations" -> "B"
	}],
	False,
	TestID -> "isNormalized-False-List@@Tests/Infrastructure/OptionsConfig.wlt:1434,1-1440,2"
]

(* --- merged from: OptionsConfig_test26.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	symbolicOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Symbolic"]};
	MemberQ[symbolicOpts, "PdEquations" -> "B"],
	True,
	TestID -> "splitConfig-Symbolic-PdEquations@@Tests/Infrastructure/OptionsConfig.wlt:1528,1-1534,2"
]

(* --- merged from: OptionsConfig_test27.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
symbolicOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Symbolic"]};

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};
	MemberQ[buildOpts, "FromScratch" -> False],
	True,
	TestID -> "splitConfig-Build-FromScratch@@Tests/Infrastructure/OptionsConfig.wlt:1625,1-1631,2"
]

(* --- merged from: OptionsConfig_test28.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
symbolicOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Symbolic"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};
	MemberQ[buildOpts, "MaxMaturity" -> 120],
	True,
	TestID -> "splitConfig-Build-MaxMaturity-120@@Tests/Infrastructure/OptionsConfig.wlt:1725,1-1731,2"
]

(* --- merged from: OptionsConfig_test29.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
symbolicOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Symbolic"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};
	MemberQ[numericalOpts, "MaxMaturity" -> 12],
	True,
	TestID -> "splitConfig-Numerical-MaxMaturity-12@@Tests/Infrastructure/OptionsConfig.wlt:1828,1-1834,2"
]

(* --- merged from: OptionsConfig_test30.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
symbolicOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Symbolic"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};
	MatchQ[numericalOpts, {___, "FindRootOptions" -> {___}, ___}],
	True,
	TestID -> "splitConfig-Numerical-FindRootOptions@@Tests/Infrastructure/OptionsConfig.wlt:1934,1-1940,2"
]

(* --- merged from: OptionsConfig_test31.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
symbolicOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Symbolic"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	compileOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Compile"]};
	MemberQ[compileOpts, "Compiler" -> "Compile"],
	True,
	TestID -> "splitConfig-Compile-Compiler@@Tests/Infrastructure/OptionsConfig.wlt:2043,1-2049,2"
]

(* --- merged from: OptionsConfig_test32.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
symbolicOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Symbolic"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
compileOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Compile"]};

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	momentsOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Moments"]};
	MemberQ[momentsOpts, "maxMomentsLagsToCreate" -> 8],
	True,
	TestID -> "splitConfig-Moments-MaxLags@@Tests/Infrastructure/OptionsConfig.wlt:2155,1-2161,2"
]

(* --- merged from: OptionsConfig_test33.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
symbolicOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Symbolic"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
compileOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Compile"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
momentsOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Moments"]};

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	parallelOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Parallel"]};
	MemberQ[parallelOpts, "NumKernels" -> Automatic],
	True,
	TestID -> "splitConfig-Parallel-NumKernels@@Tests/Infrastructure/OptionsConfig.wlt:2270,1-2276,2"
]

(* --- merged from: OptionsConfig_test34.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
symbolicOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Symbolic"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
compileOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Compile"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
momentsOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Moments"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
parallelOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Parallel"]};

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`validateConfig[config],
	True,
	TestID -> "validateConfig-Default-Valid@@Tests/Infrastructure/OptionsConfig.wlt:2388,1-2393,2"
]

(* --- merged from: OptionsConfig_test35.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
symbolicOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Symbolic"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
compileOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Compile"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
momentsOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Moments"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
parallelOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Parallel"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

VerificationTest[
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`validateConfig[<|"Symbolic" -> <||>|>],
	False,
	TestID -> "validateConfig-Incomplete-Invalid@@Tests/Infrastructure/OptionsConfig.wlt:2507,1-2511,2"
]

(* --- merged from: OptionsConfig_test36.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
symbolicOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Symbolic"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
compileOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Compile"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
momentsOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Moments"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
parallelOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Parallel"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

VerificationTest[
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`validateConfig["not an association"],
	False,
	TestID -> "validateConfig-Not-Association-Invalid@@Tests/Infrastructure/OptionsConfig.wlt:2625,1-2629,2"
]

(* --- merged from: OptionsConfig_test37.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
symbolicOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Symbolic"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
compileOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Compile"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
momentsOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Moments"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
parallelOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Parallel"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

VerificationTest[
	(* Clear previous state *)
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`$DeprecatedOptionsUsed = <||>;
	report = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`generateMigrationReport[];
	report,
	"No deprecated options used.",
	TestID -> "generateMigrationReport-Empty@@Tests/Infrastructure/OptionsConfig.wlt:2743,1-2750,2"
]

(* --- merged from: OptionsConfig_test38.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
symbolicOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Symbolic"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
compileOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Compile"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
momentsOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Moments"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
parallelOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Parallel"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

(* Clear previous state *)
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`$DeprecatedOptionsUsed = <||>;
report = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`generateMigrationReport[];

VerificationTest[
	(* Clear and populate *)
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`$DeprecatedOptionsUsed = <||>;
	(* Trigger deprecation by normalizing *)
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{"FromScratch" -> True}];
	report = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`generateMigrationReport[];
	StringContainsQ[report, "FromScratch"],
	True,
	TestID -> "generateMigrationReport-Has-Entry@@Tests/Infrastructure/OptionsConfig.wlt:2868,1-2877,2"
]

(* --- merged from: OptionsConfig_test39.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
symbolicOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Symbolic"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
compileOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Compile"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
momentsOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Moments"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
parallelOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Parallel"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

(* Clear previous state *)
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`$DeprecatedOptionsUsed = <||>;
report = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`generateMigrationReport[];

(* Clear and populate *)
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`$DeprecatedOptionsUsed = <||>;
(* Trigger deprecation by normalizing *)
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{"FromScratch" -> True}];
report = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`generateMigrationReport[];

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{}];
	config["Build"]["FromScratch"],
	False,
	TestID -> "normalizeConfig-Empty-Returns-Defaults@@Tests/Infrastructure/OptionsConfig.wlt:3001,1-3006,2"
]

(* --- merged from: OptionsConfig_test40.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
symbolicOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Symbolic"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
compileOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Compile"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
momentsOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Moments"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
parallelOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Parallel"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

(* Clear previous state *)
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`$DeprecatedOptionsUsed = <||>;
report = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`generateMigrationReport[];

(* Clear and populate *)
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`$DeprecatedOptionsUsed = <||>;
(* Trigger deprecation by normalizing *)
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{"FromScratch" -> True}];
report = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`generateMigrationReport[];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{}];

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig["PdEquations" -> "AB"];
	config["Symbolic"]["PdEquations"],
	"AB",
	TestID -> "normalizeConfig-Single-Rule@@Tests/Infrastructure/OptionsConfig.wlt:3132,1-3137,2"
]

(* --- merged from: OptionsConfig_test41.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
symbolicOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Symbolic"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
compileOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Compile"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
momentsOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Moments"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
parallelOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Parallel"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

(* Clear previous state *)
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`$DeprecatedOptionsUsed = <||>;
report = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`generateMigrationReport[];

(* Clear and populate *)
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`$DeprecatedOptionsUsed = <||>;
(* Trigger deprecation by normalizing *)
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{"FromScratch" -> True}];
report = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`generateMigrationReport[];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig["PdEquations" -> "AB"];

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FindRootOptions" -> {MaxIterations -> 75, PrecisionGoal -> 6}
	}];
	numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};
	findRootOpts = "FindRootOptions" /. numericalOpts;
	MemberQ[findRootOpts, MaxIterations -> 75],
	True,
	TestID -> "splitConfig-FindRootOptions-Custom-MaxIterations@@Tests/Infrastructure/OptionsConfig.wlt:3265,1-3274,2"
]

(* --- merged from: OptionsConfig_test42.wlt --- *)
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

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];

config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
symbolicOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Symbolic"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
compileOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Compile"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
momentsOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Moments"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
parallelOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Parallel"]};

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];

(* Clear previous state *)
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`$DeprecatedOptionsUsed = <||>;
report = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`generateMigrationReport[];

(* Clear and populate *)
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`$DeprecatedOptionsUsed = <||>;
(* Trigger deprecation by normalizing *)
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{"FromScratch" -> True}];
report = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`generateMigrationReport[];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{}];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig["PdEquations" -> "AB"];

config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FindRootOptions" -> {MaxIterations -> 75, PrecisionGoal -> 6}
	}];
numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};
findRootOpts = "FindRootOptions" /. numericalOpts;

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FindRootOptions" -> {MaxIterations -> 75, PrecisionGoal -> 6}
	}];
	numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};
	findRootOpts = "FindRootOptions" /. numericalOpts;
	MemberQ[findRootOpts, PrecisionGoal -> 6],
	True,
	TestID -> "splitConfig-FindRootOptions-Custom-PrecisionGoal@@Tests/Infrastructure/OptionsConfig.wlt:3408,1-3417,2"
]

End[]
EndTestSection[]
