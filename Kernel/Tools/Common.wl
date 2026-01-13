(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`Common`"]


(* ::Subsection:: *)
(*Public symbols*)


print;
LRRResource;
inheritUsageMessages;
requirePacletRoot;
requireManifest;
compareModelsAgainstManifest;
validateArtifact;
extractStageOptions;
executePhase;


(* ::Subsubsection:: *)
(*Usage*)


print::usage = "print[msg] writes msg to $Output using WriteString.";

(* Shared resource messages - single source of truth for resource-related errors *)
LRRResource::noroot = "Could not locate paclet root directory.";
LRRResource::nocat = "Catalog file not found at `1`.";
LRRResource::nomodel = "Model `1` not found in catalog.";
LRRResource::nomanifest = "Manifest file not found or could not be loaded from `1`.";
LRRResource::versionMismatch = "Version mismatch: catalog `1` vs manifest `2`.";

inheritUsageMessages::usage = "inheritUsageMessages[symbols, replacements] creates usage messages for private symbols by transforming public symbol usage strings.";
requirePacletRoot::usage = "requirePacletRoot[findPacletRoot] returns the paclet root or issues LRRResource::noroot and returns $Failed.";
requireManifest::usage = "requireManifest[path, loadManifestSafe] loads a manifest file, issuing LRRResource::nomanifest on failure.";
compareModelsAgainstManifest::usage = "compareModelsAgainstManifest[current, saved] returns <|\"Changed\"->..., \"New\"->..., \"Removed\"->...|>.";
validateArtifact::usage = "validateArtifact[path, validator] returns <|\"Valid\"->bool, \"Reason\"->...|>.";
extractStageOptions::usage = "extractStageOptions[opts, stages] returns an Association mapping each stage function to its filtered options.";
executePhase::usage = "executePhase[name, models, executor] executes a build phase and returns structured results with timing.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*print*)


print // Options = {
	"Verbose" -> "CI",
	"Memory" -> False,
	"Prefix" -> None
};


print[msg_String, opts : OptionsPattern[{print}]] := With[
	{
		verbose = OptionValue["Verbose"],
		showMemory = OptionValue["Memory"],
		prefix = OptionValue["Prefix"]
	},
	Module[{shouldPrint, output},
		shouldPrint = Which[
			verbose === "CI", Environment["CI"] === "true",
			verbose === True, True,
			True, False
		];

		If[!shouldPrint, Return[Null]];

		output = StringJoin[
			If[StringQ[prefix], prefix <> " ", ""],
			msg,
			If[showMemory, formatMemoryInfo[], ""]
		];

		WriteString[First@$Output, output <> "\n"]
	]
]


(* ::Subsection:: *)
(*Helper functions*)


(* ::Subsubsection:: *)
(*wolframKernelMemoryGB*)


wolframKernelMemoryGB[] := If[$OperatingSystem === "Windows",
	Missing["NotAvailable"],
	Module[{raw, kb},
		raw = Quiet @ Import["!ps -axo rss,comm | grep -i '[W]olframKernel' | awk '{sum+=$1} END {print sum}'", "String"];
		kb = Quiet @ Check[ToExpression @ StringTrim[raw], $Failed];
		If[NumberQ[kb], N[kb / 1024.^2], Missing["NotAvailable"]]
	]
]


(* ::Subsubsection:: *)
(*formatMemoryInfo*)


formatMemoryInfo[] := Module[{mem = MemoryInUse[], memGB, kernelGB},
	memGB = mem / 1024.^3;
	kernelGB = wolframKernelMemoryGB[];
	StringJoin[
		" | Wolfram Memory: ", ToString @ NumberForm[memGB, {4, 2}], " GB",
		" | Physical RAM: ", If[MissingQ[kernelGB], "N/A", ToString @ NumberForm[kernelGB, {4, 2}] <> " GB"]
	]
]


(* ::Subsection:: *)
(*DRY Utility Functions*)


(* 2a. inheritUsageMessages - creates usage messages for private symbols *)
(* Automatically adds SymbolName@sym -> SymbolName@symNew replacement *)
(* extraReplacements are additional string replacements to apply *)
(* Uses direct = assignment to avoid duplicate rules on package reload *)
inheritUsageMessages[symbols_List, extraReplacements_List] :=
	Function[sym,
		With[{symNew = Symbol @ StringDrop[SymbolName @ sym, -2]},
			If[StringQ[MessageName[sym, "usage"]],
				MessageName[symNew, "usage"] = StringReplace[
					Information[sym, "Usage"],
					Join[{SymbolName @ sym -> SymbolName @ symNew}, extraReplacements]
				]
			]
		],
		HoldAll
	] @@@ (Hold /@ Symbol /@ symbols)


(* 2b. requirePacletRoot - wrapper for findPacletRoot with error handling *)
(* Takes findPacletRoot as argument to avoid circular dependency *)
requirePacletRoot[findPacletRootFn_] := Module[{root},
	root = findPacletRootFn[];
	If[root === $Failed, Message[LRRResource::noroot]];
	root
]


(* 2c. requireManifest - wrapper for loadManifestSafe with error handling *)
(* Takes loadManifestSafe as argument to avoid circular dependency *)
requireManifest[path_String, loadManifestSafeFn_] := Module[{manifest},
	manifest = loadManifestSafeFn[path];
	If[manifest === $Failed, Message[LRRResource::nomanifest, path]];
	manifest
]


(* 2d. compareModelsAgainstManifest - shared hash comparison logic *)
(* Preserves catalog order for Changed/New, manifest order for Removed *)
compareModelsAgainstManifest[current_Association, saved_Association] := Module[
	{currentKeys, savedKeys, changedModels, newModels, removedModels},
	currentKeys = Keys[current];
	savedKeys = Keys[saved];

	(* Preserve current/catalog order for Changed and New *)
	changedModels = Select[currentKeys, KeyExistsQ[saved, #] && current[#] =!= saved[#] &];
	newModels = Select[currentKeys, !KeyExistsQ[saved, #] &];
	(* Preserve saved/manifest order for Removed *)
	removedModels = Select[savedKeys, !KeyExistsQ[current, #] &];

	<|"Changed" -> changedModels, "New" -> newModels, "Removed" -> removedModels|>
]


(* 2e. validateArtifact - generic file validation wrapper *)
validateArtifact[path_String, validator_Function] := Module[{result},
	If[!FileExistsQ[path], Return[<|"Valid" -> False, "Reason" -> "FileNotFound"|>]];
	result = validator[path];
	<|"Valid" -> result, "Reason" -> If[result, None, "ValidationFailed"]|>
]


(* 2f. extractStageOptions - multi-stage option extraction *)
extractStageOptions[opts_List, stages_List] :=
	AssociationMap[FilterRules[opts, Options[#]] &, stages]


(* 2g. executePhase - standardized phase execution with timing *)
executePhase[name_String, models_List, executor_] := Module[
	{startTime, results},
	startTime = AbsoluteTime[];
	results = Map[executor, models];
	<|
		"Phase" -> name,
		"Models" -> Length[models],
		"Duration" -> AbsoluteTime[] - startTime,
		"Results" -> results
	|>
]


(* ::Section:: *)
(*End package*)


End[] (*"`Private`"*)


EndPackage[]
