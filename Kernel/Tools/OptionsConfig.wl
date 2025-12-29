(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`OptionsConfig`"];


(* ::Subsection:: *)
(*Public symbols*)


defaultConfig
normalizeConfig
splitConfig
validateConfig
isNormalized
$OptionsConfigWarnings
generateMigrationReport


(* ::Subsection:: *)
(*Usage*)


defaultConfig::usage = "defaultConfig[] returns the default nested configuration Association with all subsystems (Symbolic, Compile, Numerical, Moments, Parallel, Build).";

normalizeConfig::usage = "normalizeConfig[opts] converts legacy flat options to nested config Association, or merges an already-normalized config with defaults.";

splitConfig::usage = "splitConfig[config, subsystem] extracts subsystem options and returns a Sequence of Rules for direct use in OptionsPattern functions. Do NOT apply Sequence @@ to the result.";

validateConfig::usage = "validateConfig[config] validates config structure and issues warnings if $OptionsConfigWarnings is True.";

isNormalized::usage = "isNormalized[config] returns True if config is a normalized config Association with the required subsystem keys.";

$OptionsConfigWarnings::usage = "$OptionsConfigWarnings controls whether to issue warnings for deprecated options or validation issues. Default: False.";

generateMigrationReport::usage = "generateMigrationReport[] returns a report of deprecated options used during the session.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Global state*)


(* Control warnings *)
If[!ValueQ[$OptionsConfigWarnings], $OptionsConfigWarnings = False];

(* Track deprecated options used *)
$DeprecatedOptionsUsed = <||>;


(* ::Subsection:: *)
(*Messages*)


normalizeConfig::deprecated = "Option `1` is deprecated. Use `2` instead.";
normalizeConfig::ambiguous = "Option `1` has different meanings in different contexts. Specify explicitly using config[\"`2`\"][\"`3`\"].";
normalizeConfig::unknown = "Unknown option `1` (ignored).";
validateConfig::invalid = "Invalid config structure: `1`";


(* ::Subsection:: *)
(*Default configuration*)


defaultConfig[] := <|
	"Symbolic" -> <|
		"PdEquations" -> "B",
		"SimplifyOptions" -> {TimeConstraint -> {5, 300}},
		"paramQuadSolveOptions" -> <|
			"DomainOption" -> Reals,
			"Assumptions" -> Automatic,
			"Method" -> Automatic,
			"MonomialOrder" -> Automatic,
			"ValidationOption" -> True,
			"ReturnOption" -> "All",
			"TimeoutOption" -> 600,
			"SimplifyTimeout" -> Automatic,
			"DiagnosticsOption" -> False,
			"OnlyQuadTerms" -> False,
			"SignSymbol" -> Symbol["signA"],
			"GroebnerMemoryFraction" -> 0.5,
			"GroebnerMemoryFloor" -> 1*1024^3,
			"GroebnerMemoryCap" -> 16*1024^3
		|>
	|>,
	"Compile" -> <|
		"CoeffName" -> "A",
		"SignSymbol" -> "signA",
		"PerformanceGoal" -> "Quality",(*"Speed",*)
		"CompileMode" -> "Both",
		"Compiler" -> "Compile",
		"RuntimeOptions" -> Automatic,(*"Speed",*)
		"CompilationTarget" -> "C"
	|>,
	"Numerical" -> <|
		"initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>,
		"FindRoot" -> <|
			"MaxIterations" -> 100,
			"PrecisionGoal" -> Automatic,
			"AccuracyGoal" -> Automatic,
			"WorkingPrecision" -> MachinePrecision,
			"Options" -> {}
		|>,
		"RecurrenceTable" -> <|
			"DependentVariables" -> Automatic,
			"Options" -> {}
		|>,
		"MaxMaturity" -> 12,
		"RootSigns" -> Automatic,
		"Scan" -> <|
			"FastRootOptions" -> {},
			"UnboundedPad" -> 1000,
			"ScanMethod" -> "Grid"
		|>,
		"Signs" -> {},
		"Checks" -> <|
			"PrintResidualsNorm" -> False,
			"CheckResiduals" -> False,
			"Tol" -> 10.^-16
		|>,
		"UpdatePd" -> False,
		"UpdateBond" -> False,
		"UpdateNomBond" -> False,
		"UpdateBonds" -> False,
		"ReduceTimeLimit" -> 5.
	|>,
	"Moments" -> <|
		"maxMomentsLagsToCreate" -> 8,
		"startSequenceAtLag" -> 3,
		"simplifyDownValues" -> False,
		"IterationLimit" -> $IterationLimit/4
	|>,
	"Parallel" -> <|
		"NumKernels" -> Automatic
	|>,
	"Build" -> <|
		"Models" -> All,
		"FromScratch" -> False,
		"CompileJacobians" -> True,
		"CreateMoments" -> True,
		"MaxMaturity" -> 120,
		"FileSuffix" -> "",
		"UpdateManifest" -> True
	|>
|>;


(* ::Subsection:: *)
(*Legacy option mapping*)


(* Maps old flat option names to new nested config paths *)
legacyOptionMap = <|
	"FindRootOptions" -> {"Numerical", "FindRoot", "Options"},
	"RecurrenceTableOptions" -> {"Numerical", "RecurrenceTable", "Options"},
	"NumKernels" -> {"Parallel", "NumKernels"},
	"PdEquations" -> {"Symbolic", "PdEquations"},
	"SimplifyOptions" -> {"Symbolic", "SimplifyOptions"},
	"Compiler" -> {"Compile", "Compiler"},
	"CompileMode" -> {"Compile", "CompileMode"},
	"CoeffName" -> {"Compile", "CoeffName"},
	"PerformanceGoal" -> {"Compile", "PerformanceGoal"},
	"RuntimeOptions" -> {"Compile", "RuntimeOptions"},
	"CompilationTarget" -> {"Compile", "CompilationTarget"},
	"maxMomentsLagsToCreate" -> {"Moments", "maxMomentsLagsToCreate"},
	"startSequenceAtLag" -> {"Moments", "startSequenceAtLag"},
	"simplifyDownValues" -> {"Moments", "simplifyDownValues"},
	"FromScratch" -> {"Build", "FromScratch"},
	"CompileJacobians" -> {"Build", "CompileJacobians"},
	"CreateMoments" -> {"Build", "CreateMoments"},
	"Models" -> {"Build", "Models"},
	"FileSuffix" -> {"Build", "FileSuffix"},
	"UpdateManifest" -> {"Build", "UpdateManifest"},
	"initialGuess" -> {"Numerical", "initialGuess"},
	"RootSigns" -> {"Numerical", "RootSigns"},
	"Signs" -> {"Numerical", "Signs"},
	"UpdatePd" -> {"Numerical", "UpdatePd"},
	"UpdateBond" -> {"Numerical", "UpdateBond"},
	"UpdateNomBond" -> {"Numerical", "UpdateNomBond"},
	"UpdateBonds" -> {"Numerical", "UpdateBonds"},
	"ReduceTimeLimit" -> {"Numerical", "ReduceTimeLimit"}
|>;


(* Context-specific option handling for ambiguous names *)
ambiguousOptions = <|
	"MaxMaturity" -> <|
		"Numerical" -> {"Numerical", "MaxMaturity"},  (* default: 12 *)
		"Build" -> {"Build", "MaxMaturity"}  (* default: 120 *)
	|>,
	"SignSymbol" -> <|
		"Symbolic" -> {"Symbolic", "paramQuadSolveOptions", "SignSymbol"},  (* Symbol form *)
		"Compile" -> {"Compile", "SignSymbol"}  (* String form *)
	|>
|>;


(* ::Subsection:: *)
(*Helper functions*)


(* Recursive merge - CRITICAL for preserving nested defaults *)
mergeNested[assocs_List] := Merge[assocs,
	If[AllTrue[#, AssociationQ], mergeNested[#], Last[#]] &
];


(* Check if config is already normalized *)
(* Use AnyTrue pattern, NOT KeyExistsQ[config, "A"|"B"] which fails *)
isNormalized[config_Association] := AnyTrue[
	{"Symbolic", "Compile", "Numerical", "Build", "Moments", "Parallel"},
	KeyExistsQ[config, #] &
];

isNormalized[_] := False;


(* Record deprecated option usage for migration report *)
recordDeprecation[oldName_String, newPath_List] := (
	If[!KeyExistsQ[$DeprecatedOptionsUsed, oldName],
		$DeprecatedOptionsUsed[oldName] = newPath;
		If[$OptionsConfigWarnings,
			Message[normalizeConfig::deprecated, oldName,
				"config[\"" <> StringRiffle[Most[newPath], "\"][\""] <> "\"][\"" <> Last[newPath] <> "\"]"
			]
		];
	];
);


(* ::Subsection:: *)
(*normalizeConfig implementation*)


(* Pattern 1: Config already normalized - merge with defaults *)
normalizeConfig[config_Association /; isNormalized[config]] :=
	mergeNested[{defaultConfig[], config}];


(* Pattern 2: Legacy flat options - translate to config *)
normalizeConfig[opts_List] := Module[{config = defaultConfig[]},
	(* Translate each legacy option to nested path *)
	Do[
		With[{optName = First[opt], optVal = Last[opt]},
			Which[
				(* Direct mapping *)
				KeyExistsQ[legacyOptionMap, optName],
				config = ReplacePart[config, legacyOptionMap[optName] -> optVal];
				recordDeprecation[optName, legacyOptionMap[optName]],

				(* Ambiguous option - default to most common context *)
				KeyExistsQ[ambiguousOptions, optName],
				Module[{defaultCtx, path},
					(* MaxMaturity defaults to Numerical context, SignSymbol to Symbolic *)
					defaultCtx = If[optName === "MaxMaturity", "Numerical", "Symbolic"];
					path = ambiguousOptions[optName][defaultCtx];
					config = ReplacePart[config, path -> optVal];
					If[$OptionsConfigWarnings,
						Message[normalizeConfig::ambiguous, optName, path[[1]], path[[-1]]]
					];
					recordDeprecation[optName, path];
				],

				(* Unknown option - ignore silently unless warnings enabled *)
				True,
				If[$OptionsConfigWarnings,
					Message[normalizeConfig::unknown, optName]
				]
			]
		],
		{opt, opts}
	];
	config
];


(* Pattern 3: Single rule or sequence of rules *)
normalizeConfig[opts : OptionsPattern[]] := normalizeConfig[Flatten[{opts}]];
normalizeConfig[opt_Rule] := normalizeConfig[{opt}];


(* Pattern 4: Empty *)
normalizeConfig[{}] := defaultConfig[];


(* ::Subsection:: *)
(*splitConfig implementation*)


(* Extract Symbolic subsystem options *)
splitConfig[config_Association, "Symbolic"] := Sequence @@ Flatten[{
	"PdEquations" -> config["Symbolic"]["PdEquations"],
	"SimplifyOptions" -> config["Symbolic"]["SimplifyOptions"],
	"paramQuadSolveOptions" -> config["Symbolic"]["paramQuadSolveOptions"]
}];


(* Extract Compile subsystem options *)
splitConfig[config_Association, "Compile"] := Sequence @@ Flatten[{
	"CoeffName" -> config["Compile"]["CoeffName"],
	"SignSymbol" -> config["Compile"]["SignSymbol"],
	"PerformanceGoal" -> config["Compile"]["PerformanceGoal"],
	"CompileMode" -> config["Compile"]["CompileMode"],
	"Compiler" -> config["Compile"]["Compiler"],
	"RuntimeOptions" -> config["Compile"]["RuntimeOptions"],
	"CompilationTarget" -> config["Compile"]["CompilationTarget"]
}];


(* Extract Numerical subsystem options *)
splitConfig[config_Association, "Numerical"] := Sequence @@ Flatten[{
	"initialGuess" -> config["Numerical"]["initialGuess"],
	"FindRootOptions" -> Join[
		{"MaxIterations" -> config["Numerical"]["FindRoot"]["MaxIterations"]},
		If[config["Numerical"]["FindRoot"]["PrecisionGoal"] =!= Automatic,
			{"PrecisionGoal" -> config["Numerical"]["FindRoot"]["PrecisionGoal"]},
			{}
		],
		If[config["Numerical"]["FindRoot"]["AccuracyGoal"] =!= Automatic,
			{"AccuracyGoal" -> config["Numerical"]["FindRoot"]["AccuracyGoal"]},
			{}
		],
		If[config["Numerical"]["FindRoot"]["WorkingPrecision"] =!= MachinePrecision,
			{"WorkingPrecision" -> config["Numerical"]["FindRoot"]["WorkingPrecision"]},
			{}
		],
		config["Numerical"]["FindRoot"]["Options"]
	],
	"RecurrenceTableOptions" -> Join[
		{"DependentVariables" -> config["Numerical"]["RecurrenceTable"]["DependentVariables"]},
		config["Numerical"]["RecurrenceTable"]["Options"]
	],
	"MaxMaturity" -> config["Numerical"]["MaxMaturity"],
	"RootSigns" -> config["Numerical"]["RootSigns"],
	"Signs" -> config["Numerical"]["Signs"],
	"UpdatePd" -> config["Numerical"]["UpdatePd"],
	"UpdateBond" -> config["Numerical"]["UpdateBond"],
	"UpdateNomBond" -> config["Numerical"]["UpdateNomBond"],
	"UpdateBonds" -> config["Numerical"]["UpdateBonds"],
	"ReduceTimeLimit" -> config["Numerical"]["ReduceTimeLimit"]
}];


(* Extract Moments subsystem options *)
splitConfig[config_Association, "Moments"] := Sequence @@ Flatten[{
	"maxMomentsLagsToCreate" -> config["Moments"]["maxMomentsLagsToCreate"],
	"startSequenceAtLag" -> config["Moments"]["startSequenceAtLag"],
	"simplifyDownValues" -> config["Moments"]["simplifyDownValues"],
	"IterationLimit" -> config["Moments"]["IterationLimit"]
}];


(* Extract Parallel subsystem options *)
splitConfig[config_Association, "Parallel"] := Sequence @@ Flatten[{
	"NumKernels" -> config["Parallel"]["NumKernels"]
}];


(* Extract Build subsystem options *)
splitConfig[config_Association, "Build"] := Sequence @@ Flatten[{
	"Models" -> config["Build"]["Models"],
	"FromScratch" -> config["Build"]["FromScratch"],
	"CompileJacobians" -> config["Build"]["CompileJacobians"],
	"CreateMoments" -> config["Build"]["CreateMoments"],
	"MaxMaturity" -> config["Build"]["MaxMaturity"],
	"FileSuffix" -> config["Build"]["FileSuffix"],
	"UpdateManifest" -> config["Build"]["UpdateManifest"]
}];


(* ::Subsection:: *)
(*validateConfig implementation*)


validateConfig[config_Association] := Module[{valid = True},
	(* Check that all required subsystems are present *)
	If[!AllTrue[{"Symbolic", "Compile", "Numerical", "Moments", "Parallel", "Build"},
		KeyExistsQ[config, #] &],
		If[$OptionsConfigWarnings,
			Message[validateConfig::invalid, "Missing required subsystems"]
		];
		valid = False;
	];

	(* Check that config is an Association *)
	If[!AssociationQ[config],
		If[$OptionsConfigWarnings,
			Message[validateConfig::invalid, "Config must be an Association"]
		];
		valid = False;
	];

	valid
];


validateConfig[_] := (
	If[$OptionsConfigWarnings,
		Message[validateConfig::invalid, "Config must be an Association"]
	];
	False
);


(* ::Subsection:: *)
(*Migration report*)


generateMigrationReport[] := Module[{report},
	If[Length[$DeprecatedOptionsUsed] === 0,
		"No deprecated options used.",
		report = "Deprecated options used:\n";
		KeyValueMap[
			Function[{old, new},
				report = report <> "  " <> old <> " -> config[\"" <>
					StringRiffle[Most[new], "\"][\""] <> "\"][\"" <> Last[new] <> "\"]\n"
			],
			$DeprecatedOptionsUsed
		];
		report
	]
];


(* ::Section:: *)
(*End package*)


End[];


EndPackage[];
