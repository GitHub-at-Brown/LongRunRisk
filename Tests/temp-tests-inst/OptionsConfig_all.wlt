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

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	AssociationQ[config],
	True,
	TestID -> "defaultConfig-Returns-Association@@Tests/OptionsConfig.wlt:14,1-19,2"
]

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	AllTrue[{"Symbolic", "Compile", "Numerical", "Moments", "Parallel", "Build"},
		KeyExistsQ[config, #] &
	],
	True,
	TestID -> "defaultConfig-Has-All-Subsystems@@Tests/OptionsConfig.wlt:21,1-28,2"
]

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	config["Symbolic"]["PdEquations"],
	"B",
	TestID -> "defaultConfig-Symbolic-PdEquations@@Tests/OptionsConfig.wlt:30,1-35,2"
]

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	config["Numerical"]["MaxMaturity"],
	12,
	TestID -> "defaultConfig-Numerical-MaxMaturity@@Tests/OptionsConfig.wlt:37,1-42,2"
]

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	config["Build"]["MaxMaturity"],
	120,
	TestID -> "defaultConfig-Build-MaxMaturity@@Tests/OptionsConfig.wlt:44,1-49,2"
]

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	config["Build"]["FromScratch"],
	False,
	TestID -> "defaultConfig-Build-FromScratch@@Tests/OptionsConfig.wlt:51,1-56,2"
]

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	config["Parallel"]["NumKernels"],
	Automatic,
	TestID -> "defaultConfig-Parallel-NumKernels@@Tests/OptionsConfig.wlt:58,1-63,2"
]

(* Test normalizeConfig with legacy flat options *)

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"PdEquations" -> "AB",
		"FromScratch" -> True
	}];
	config["Symbolic"]["PdEquations"],
	"AB",
	TestID -> "normalizeConfig-Legacy-PdEquations@@Tests/OptionsConfig.wlt:67,1-75,2"
]

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];
	config["Build"]["FromScratch"],
	True,
	TestID -> "normalizeConfig-Legacy-FromScratch@@Tests/OptionsConfig.wlt:77,1-84,2"
]

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"NumKernels" -> 4
	}];
	config["Parallel"]["NumKernels"],
	4,
	TestID -> "normalizeConfig-Legacy-NumKernels@@Tests/OptionsConfig.wlt:86,1-93,2"
]

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FindRootOptions" -> {MaxIterations -> 50}
	}];
	config["Numerical"]["FindRoot"]["Options"],
	{MaxIterations -> 50},
	TestID -> "normalizeConfig-Legacy-FindRootOptions@@Tests/OptionsConfig.wlt:95,1-102,2"
]

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"maxMomentsLagsToCreate" -> 10
	}];
	config["Moments"]["maxMomentsLagsToCreate"],
	10,
	TestID -> "normalizeConfig-Legacy-MaxMomentsLags@@Tests/OptionsConfig.wlt:104,1-111,2"
]

(* Test normalizeConfig preserves defaults for unspecified options *)

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"PdEquations" -> "AB"
	}];
	config["Build"]["FromScratch"],
	False,
	TestID -> "normalizeConfig-Preserves-Defaults-1@@Tests/OptionsConfig.wlt:115,1-122,2"
]

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FromScratch" -> True
	}];
	config["Numerical"]["MaxMaturity"],
	12,
	TestID -> "normalizeConfig-Preserves-Defaults-2@@Tests/OptionsConfig.wlt:124,1-131,2"
]

(* Test normalizeConfig with already-normalized config *)

VerificationTest[
	config1 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
	config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];
	config3["Symbolic"]["PdEquations"],
	"AB",
	TestID -> "normalizeConfig-Already-Normalized-Override@@Tests/OptionsConfig.wlt:135,1-142,2"
]

VerificationTest[
	config2 = <|"Symbolic" -> <|"PdEquations" -> "AB"|>|>;
	config3 = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[config2];
	config3["Build"]["FromScratch"],
	False,
	TestID -> "normalizeConfig-Already-Normalized-Defaults@@Tests/OptionsConfig.wlt:144,1-150,2"
]

(* Test mergeNested helper *)

VerificationTest[
	merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];
	merged["A"]["x"],
	1,
	TestID -> "mergeNested-Preserves-Nested-1@@Tests/OptionsConfig.wlt:154,1-162,2"
]

VerificationTest[
	merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];
	merged["A"]["y"],
	99,
	TestID -> "mergeNested-Overrides-Nested@@Tests/OptionsConfig.wlt:164,1-172,2"
]

VerificationTest[
	merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];
	merged["B"]["z"],
	3,
	TestID -> "mergeNested-Preserves-Other-Keys@@Tests/OptionsConfig.wlt:174,1-182,2"
]

VerificationTest[
	merged = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`mergeNested[{
		<|"A" -> <|"x" -> 1, "y" -> 2|>, "B" -> <|"z" -> 3|>|>,
		<|"A" -> <|"y" -> 99|>, "C" -> <|"w" -> 4|>|>
	}];
	merged["C"]["w"],
	4,
	TestID -> "mergeNested-Adds-New-Keys@@Tests/OptionsConfig.wlt:184,1-192,2"
]

(* Test isNormalized helper *)

VerificationTest[
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`isNormalized[<|
		"Symbolic" -> <||>
	|>],
	True,
	TestID -> "isNormalized-True-Symbolic@@Tests/OptionsConfig.wlt:196,1-202,2"
]

VerificationTest[
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`isNormalized[<|
		"Build" -> <||>
	|>],
	True,
	TestID -> "isNormalized-True-Build@@Tests/OptionsConfig.wlt:204,1-210,2"
]

VerificationTest[
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`isNormalized[<|
		"RandomKey" -> <||>
	|>],
	False,
	TestID -> "isNormalized-False-RandomKey@@Tests/OptionsConfig.wlt:212,1-218,2"
]

VerificationTest[
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`isNormalized[{
		"PdEquations" -> "B"
	}],
	False,
	TestID -> "isNormalized-False-List@@Tests/OptionsConfig.wlt:220,1-226,2"
]

(* Test splitConfig *)

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	symbolicOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Symbolic"]};
	MemberQ[symbolicOpts, "PdEquations" -> "B"],
	True,
	TestID -> "splitConfig-Symbolic-PdEquations@@Tests/OptionsConfig.wlt:230,1-236,2"
]

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};
	MemberQ[buildOpts, "FromScratch" -> False],
	True,
	TestID -> "splitConfig-Build-FromScratch@@Tests/OptionsConfig.wlt:238,1-244,2"
]

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	buildOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Build"]};
	MemberQ[buildOpts, "MaxMaturity" -> 120],
	True,
	TestID -> "splitConfig-Build-MaxMaturity-120@@Tests/OptionsConfig.wlt:246,1-252,2"
]

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};
	MemberQ[numericalOpts, "MaxMaturity" -> 12],
	True,
	TestID -> "splitConfig-Numerical-MaxMaturity-12@@Tests/OptionsConfig.wlt:254,1-260,2"
]

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};
	MatchQ[numericalOpts, {___, "FindRootOptions" -> {___}, ___}],
	True,
	TestID -> "splitConfig-Numerical-FindRootOptions@@Tests/OptionsConfig.wlt:262,1-268,2"
]

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	compileOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Compile"]};
	MemberQ[compileOpts, "Compiler" -> "Compile"],
	True,
	TestID -> "splitConfig-Compile-Compiler@@Tests/OptionsConfig.wlt:270,1-276,2"
]

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	momentsOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Moments"]};
	MemberQ[momentsOpts, "maxMomentsLagsToCreate" -> 8],
	True,
	TestID -> "splitConfig-Moments-MaxLags@@Tests/OptionsConfig.wlt:278,1-284,2"
]

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	parallelOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Parallel"]};
	MemberQ[parallelOpts, "NumKernels" -> Automatic],
	True,
	TestID -> "splitConfig-Parallel-NumKernels@@Tests/OptionsConfig.wlt:286,1-292,2"
]

(* Test validateConfig *)

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`defaultConfig[];
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`validateConfig[config],
	True,
	TestID -> "validateConfig-Default-Valid@@Tests/OptionsConfig.wlt:296,1-301,2"
]

VerificationTest[
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`validateConfig[<|"Symbolic" -> <||>|>],
	False,
	TestID -> "validateConfig-Incomplete-Invalid@@Tests/OptionsConfig.wlt:303,1-307,2"
]

VerificationTest[
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`validateConfig["not an association"],
	False,
	TestID -> "validateConfig-Not-Association-Invalid@@Tests/OptionsConfig.wlt:309,1-313,2"
]

(* Test migration report *)

VerificationTest[
	(* Clear previous state *)
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`$DeprecatedOptionsUsed = <||>;
	report = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`generateMigrationReport[];
	report,
	"No deprecated options used.",
	TestID -> "generateMigrationReport-Empty@@Tests/OptionsConfig.wlt:317,1-324,2"
]

VerificationTest[
	(* Clear and populate *)
	FernandoDuarte`LongRunRisk`Tools`OptionsConfig`Private`$DeprecatedOptionsUsed = <||>;
	(* Trigger deprecation by normalizing *)
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{"FromScratch" -> True}];
	report = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`generateMigrationReport[];
	StringContainsQ[report, "FromScratch"],
	True,
	TestID -> "generateMigrationReport-Has-Entry@@Tests/OptionsConfig.wlt:326,1-335,2"
]

(* Test empty options normalization *)

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{}];
	config["Build"]["FromScratch"],
	False,
	TestID -> "normalizeConfig-Empty-Returns-Defaults@@Tests/OptionsConfig.wlt:339,1-344,2"
]

(* Test single rule normalization *)

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig["PdEquations" -> "AB"];
	config["Symbolic"]["PdEquations"],
	"AB",
	TestID -> "normalizeConfig-Single-Rule@@Tests/OptionsConfig.wlt:348,1-353,2"
]

(* Test that splitConfig returns flat Rules suitable for Sequence @@ *)

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FindRootOptions" -> {MaxIterations -> 75, PrecisionGoal -> 6}
	}];
	numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};
	findRootOpts = "FindRootOptions" /. numericalOpts;
	MemberQ[findRootOpts, MaxIterations -> 75],
	True,
	TestID -> "splitConfig-FindRootOptions-Custom-MaxIterations@@Tests/OptionsConfig.wlt:357,1-366,2"
]

VerificationTest[
	config = FernandoDuarte`LongRunRisk`Tools`OptionsConfig`normalizeConfig[{
		"FindRootOptions" -> {MaxIterations -> 75, PrecisionGoal -> 6}
	}];
	numericalOpts = {FernandoDuarte`LongRunRisk`Tools`OptionsConfig`splitConfig[config, "Numerical"]};
	findRootOpts = "FindRootOptions" /. numericalOpts;
	MemberQ[findRootOpts, PrecisionGoal -> 6],
	True,
	TestID -> "splitConfig-FindRootOptions-Custom-PrecisionGoal@@Tests/OptionsConfig.wlt:368,1-377,2"
]
