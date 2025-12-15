(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`Tools`PipelineMonitor`"];

checkModels::usage = "checkModels[] checks for Catalog.wl changes and offers to build updated models.
Returns Null if no changes, $Failed on error, or the build result if user confirms.";

Begin["`Private`"];

Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];

(* Main entry point *)
checkModels[] := Module[
	{config, changes, status, shortnames, catalogModels},

	(* Guard against parallel/subkernel contexts *)
	If[TrueQ[$ParallelEvaluationEnvironment] || $KernelID =!= 0,
		Return[Null]
	];

	(* Load config *)
	config = loadConfig[];
	If[Lookup[config, "PipelineMonitorEnabled", True] === False,
		Return[Null]
	];

	(* Check for changes using public API *)
	changes = FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogForUI[];

	(* Handle failures gracefully *)
	If[changes === $Failed,
		If[$Notebooks =!= True,
			Print["checkModels: Could not check catalog. Check for syntax errors."],
			MessageDialog["Could not check catalog. Check Catalog.wl for syntax errors."]
		];
		Return[$Failed]
	];

	(* No changes case *)
	If[changes["Changed"] === {} && changes["New"] === {} && changes["Removed"] === {},
		Return[Null]
	];

	(* Get catalog to map keys to shortnames *)
	catalogModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[];

	(* Get pipeline status for changed/new models *)
	shortnames = Map[
		catalogModels[#]["shortname"] &,
		Join[changes["Changed"], changes["New"]]
	];

	status = FernandoDuarte`LongRunRisk`Tools`ManageResources`getModelPipelineStatus[shortnames];

	(* Handle validation errors *)
	If[!TrueQ[changes["Validation"]["Valid"]],
		showValidationErrors[changes["Validation"]];
		Return[$Failed]
	];

	(* Show report and prompt for build *)
	showPipelineReport[changes, status, shortnames]
];

(* Config loading - robust with fallbacks for all platforms *)
loadConfig[] := Module[{home, configFile, config},
	(* $HomeDirectory is cross-platform in Wolfram Language *)
	home = $HomeDirectory;
	(* Fallbacks: HOME (Unix/macOS), USERPROFILE (Windows) *)
	If[!StringQ[home], home = Environment["HOME"]];
	If[!StringQ[home], home = Environment["USERPROFILE"]];
	If[!StringQ[home], Return[<||>]];

	configFile = FileNameJoin[{home, ".longrunrisk", "config.wl"}];
	If[!FileExistsQ[configFile], Return[<||>]];

	config = Quiet[Check[Get[configFile], <||>]];
	If[!AssociationQ[config], Return[<||>]];
	config
];

openOrCreateConfigFile[] := Module[{home, file, defaults, create},
	(* $HomeDirectory is cross-platform in Wolfram Language *)
	home = $HomeDirectory;
	(* Fallbacks: HOME (Unix/macOS), USERPROFILE (Windows) *)
	If[!StringQ[home], home = Environment["HOME"]];
	If[!StringQ[home], home = Environment["USERPROFILE"]];
	If[!StringQ[home],
		MessageDialog["Could not determine your home directory."];
		Return[Null]
	];

	file = FileNameJoin[{home, ".longrunrisk", "config.wl"}];
	defaults = Association[
		"PipelineMonitorEnabled" -> True,
		"AutoReformat" -> True,
		"ShowDialogs" -> True
	];

	If[FileExistsQ[file],
		NotebookOpen[file],
		create = ChoiceDialog[
			Column[{
				"Config file not found:",
				Style[file, "Program"],
				"Create it now?"
			}],
			WindowTitle -> "LongRunRisk Configuration"
		];
		If[TrueQ[create],
			CreateDirectory[DirectoryName[file], CreateIntermediateDirectories -> True];
			Put[defaults, file];
			NotebookOpen[file]
		]
	];

	Null
];

(* Pipeline report and build prompt *)
showPipelineReport[changes_, status_, shortnames_] := Module[
	{dialogResult, buildResult, grid},

	(* Build status grid *)
	grid = formatStatusGrid[status];

	If[$Notebooks =!= True,
		(* Terminal mode *)
		showTerminalReport[changes, status, shortnames],

		(* Notebook mode: use DialogInput for value return *)
		dialogResult = DialogInput[
			Column[{
				Style["Catalog Changes Detected", "Title", 16, Bold],
				Style[DateString[], "Subtitle", Gray],
				"",
				formatChangeSummary[changes],
				"",
				Style["Pipeline Status:", Bold],
				Pane[grid, ImageSize -> {500, 150}, Scrollbars -> {False, Automatic}],
				"",
				Row[{
					Button["Build Now", DialogReturn["Build"]],
					Spacer[20],
					DefaultButton["Cancel", DialogReturn["Cancel"]]
				}, Alignment -> Center]
			}, Spacings -> 1],
			WindowTitle -> "LongRunRisk Pipeline Monitor"
		];

		(* Check result and run build *)
		If[dialogResult === "Build",
			PrintTemporary["Building models: ", shortnames, "..."];
			(* Pass SHORTNAMES to buildModels *)
			buildResult = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels[
				"Models" -> shortnames
			];
			If[buildResult === $Failed,
				MessageDialog["Build failed. Check messages for details."],
				MessageDialog["Build completed successfully.\n\nReload the paclet to use updated models."]
			];
			buildResult,
			(* User canceled *)
			Null
		]
	]
];

(* Terminal output with fully qualified command *)
showTerminalReport[changes_, status_, shortnames_] := Module[{},
	Print[""];
	Print["=== LongRunRisk: Catalog Changes Detected ==="];
	Print[""];

	If[changes["New"] =!= {},
		Print["New models: ", StringRiffle[changes["New"], ", "]]];
	If[changes["Changed"] =!= {},
		Print["Changed models: ", StringRiffle[changes["Changed"], ", "]]];
	If[changes["Removed"] =!= {},
		Print["Removed models: ", StringRiffle[changes["Removed"], ", "]]];
	If[TrueQ[changes["FirstRun"]],
		Print["(First run - no previous manifest)"]];

	Print[""];
	Print["Pipeline Status:"];
	printStatusTable[status];

	Print[""];
	Print["To build these models, run:"];
	(* Fully qualified command *)
	Print["  Needs[\"FernandoDuarte`LongRunRisk`Tools`ManageResources`\"];"];
	Print["  FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels[\"Models\" -> ", ToString[shortnames, InputForm], "]"];
];

(* Status icon - uses Position for robustness *)
statusIcon[stage_String, currentStage_String] := Module[
	{stageOrder, stageIdx, currentIdx, pos},
	stageOrder = {"Symbolic", "Compile", "Numerical", "Moments", "UpToDate"};
	pos = Position[stageOrder, stage];
	stageIdx = If[pos === {}, 6, pos[[1, 1]]];
	pos = Position[stageOrder, currentStage];
	currentIdx = If[pos === {}, 6, pos[[1, 1]]];
	Which[
		stageIdx < currentIdx,
			If[$Notebooks =!= True, "[OK]", Style["\[Checkmark]", Darker@Green, Bold]],
		stageIdx == currentIdx,
			If[$Notebooks =!= True, "[>>]", Style["\[RightArrow]", Orange, Bold]],
		True,
			If[$Notebooks =!= True, "[ ]", Style["\[FilledCircle]", Gray]]
	]
];

formatStatusGrid[status_Association] := Grid[
	Prepend[
		KeyValueMap[
			{#1,
			 statusIcon["Symbolic", #2["MainStage"]],
			 statusIcon["Compile", #2["MainStage"]],
			 statusIcon["Numerical", #2["MainStage"]],
			 statusIcon["Moments", #2["MainStage"]],
			 #2["MainStage"],
			 #2["Reason"]} &,
			status
		],
		Style[#, Bold] & /@ {"Model", "Sym", "Comp", "Num", "Mom", "Next", "Reason"}
	],
	Frame -> All, FrameStyle -> GrayLevel[0.7],
	Background -> {None, {LightGray, {White}}},
	Alignment -> Left
];

printStatusTable[status_Association] := Module[{},
	Print["| Model     | Sym  | Comp | Num  | Mom  | Next       | Reason    |"];
	Print["|-----------|------|------|------|------|------------|-----------|"];
	KeyValueMap[
		Print["| ", StringPadRight[#1, 9], " | ",
			StringPadRight[statusIcon["Symbolic", #2["MainStage"]], 4], " | ",
			StringPadRight[statusIcon["Compile", #2["MainStage"]], 4], " | ",
			StringPadRight[statusIcon["Numerical", #2["MainStage"]], 4], " | ",
			StringPadRight[statusIcon["Moments", #2["MainStage"]], 4], " | ",
			StringPadRight[#2["MainStage"], 10], " | ",
			StringPadRight[#2["Reason"], 9], " |"] &,
		status
	]
];

formatChangeSummary[changes_Association] := Column[{
	If[changes["New"] =!= {},
		Row[{Style["New models: ", Bold], StringRiffle[changes["New"], ", "]}],
		Nothing],
	If[changes["Changed"] =!= {},
		Row[{Style["Changed models: ", Bold], StringRiffle[changes["Changed"], ", "]}],
		Nothing],
	If[changes["Removed"] =!= {},
		Row[{Style["Removed models: ", Bold, Red], StringRiffle[changes["Removed"], ", "]}],
		Nothing],
	If[TrueQ[changes["FirstRun"]],
		Style["(First run - initializing)", Italic, Gray],
		Nothing]
}, Spacings -> 0.3];

showValidationErrors[validation_Association] := Module[{},
	If[$Notebooks =!= True,
		Print[""];
		Print["=== VALIDATION ERRORS ==="];
		KeyValueMap[
			Function[{model, result},
				If[!TrueQ[result["Valid"]],
					Print["Model: ", model];
					Scan[Print["  - ", #["Type"], ": ", #["Message"]] &, result["Errors"]]
				]
			],
			validation["Results"]
		];
		Print[""];
		Print["Please correct errors in Catalog.wl and call checkModels[] again."],

		(* Notebook mode *)
		MessageDialog[
			Column[{
				Style["Validation Errors", Bold, Red, 14],
				"",
				Column[
					KeyValueMap[
						Function[{model, result},
							If[!TrueQ[result["Valid"]],
								Column[{
									Style[model, Bold],
									Column[Style["  - " <> #["Type"], Gray] & /@ result["Errors"]]
								}],
								Nothing
							]
						],
						validation["Results"]
					]
				],
				"",
				"Please correct errors in Catalog.wl and call checkModels[] again."
			}],
			WindowTitle -> "Validation Errors"
		]
	]
];

End[];

EndPackage[];
