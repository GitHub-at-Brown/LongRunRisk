

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
	TestID -> "OptionsConfig-Load@@Tests/OptionsConfig.wlt:1,1-12,2"
]

