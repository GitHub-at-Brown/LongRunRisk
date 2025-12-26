

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
	TestID -> "splitConfig-FindRootOptions-Custom-PrecisionGoal@@Tests/OptionsConfig.wlt:368,1-377,2"
]

