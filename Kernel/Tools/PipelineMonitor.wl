(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`Tools`PipelineMonitor`"];

checkModels::usage = "checkModels[] checks for Catalog.wl changes and incomplete pipelines, and offers to build.
Returns Null if no changes and pipeline is complete, $Failed on error, or the build result if user confirms.
checkModels[\"AutoBuild\" -> True] automatically builds incomplete models without user confirmation.
checkModels[\"AutoBuild\" -> False] disables auto-build even in CI.
With \"AutoBuild\" -> Automatic (default), auto-build is enabled when:
  1. Environment variable LONGRUNRISK_AUTOBUILD is \"true\", \"1\", or \"yes\", OR
  2. Environment variable CI is \"true\" (set by GitHub Actions, Travis, etc.) and not in a notebook.";

Begin["`Private`"];

Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];

Options[checkModels] = {"AutoBuild" -> Automatic};

(* Determine if AutoBuild should be enabled *)
(* Priority: 1. Explicit option, 2. LONGRUNRISK_AUTOBUILD env var, 3. CI detection *)
resolveAutoBuild[opt_] := Which[
	(* Explicit True/False option takes priority *)
	TrueQ[opt], True,
	opt === False, False,
	(* Check LONGRUNRISK_AUTOBUILD env var *)
	MemberQ[{"true", "1", "yes"}, ToLowerCase[ToString[Environment["LONGRUNRISK_AUTOBUILD"]]]],
		True,
	(* Auto-detect CI environment (GitHub Actions, Travis, CircleCI, etc. set CI=true) *)
	MemberQ[{"true", "1"}, ToLowerCase[ToString[Environment["CI"]]]] && $Notebooks =!= True,
		True,
	(* Default: no auto-build *)
	True, False
];

(* Main entry point *)
checkModels[OptionsPattern[]] := With[
	{autoBuild = resolveAutoBuild[OptionValue["AutoBuild"]]},
Module[
	{config, changes, status, shortnames, catalogModels, allStatus, incompleteModels, hasCatalogChanges},

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
			Null,
			MessageDialog["Could not check catalog. Check Catalog.wl for syntax errors."]
		];
		Return[$Failed]
	];

	(* Handle validation errors *)
	If[!TrueQ[changes["Validation"]["Valid"]],
		showValidationErrors[changes["Validation"]];
		Return[$Failed]
	];

	hasCatalogChanges = Not[changes["Changed"] === {} && changes["New"] === {} && changes["Removed"] === {}];

	(* Always check pipeline status for ALL models to detect missing .mx files *)
	allStatus = FernandoDuarte`LongRunRisk`Tools`ManageResources`getModelPipelineStatus[All];

	(* Find models with incomplete pipelines (not UpToDate) *)
	incompleteModels = Keys@Select[allStatus, #["MainStage"] =!= "UpToDate" &];

	(* If no catalog changes AND pipeline is complete, return Null *)
	If[!hasCatalogChanges && incompleteModels === {},
		Return[Null]
	];

	(* Get catalog to map keys to shortnames *)
	catalogModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[];

	(* Determine which models to report on: union of changed/new and incomplete *)
	If[hasCatalogChanges,
		shortnames = DeleteDuplicates@Join[
			Map[catalogModels[#]["shortname"] &, Join[changes["Changed"], changes["New"]]],
			incompleteModels
		],
		(* No catalog changes, just incomplete pipelines *)
		shortnames = incompleteModels;
		(* Mark as "incomplete pipeline" run *)
		changes = <|changes, "IncompletePipeline" -> True|>
	];

	status = FernandoDuarte`LongRunRisk`Tools`ManageResources`getModelPipelineStatus[shortnames];

	(* Show report and prompt for build *)
	showPipelineReport[changes, status, shortnames, autoBuild]
]];

(* Config loading - robust with fallbacks for all platforms *)
configFilePath[] := Module[{userBase},
	userBase = $UserBaseDirectory;
	If[!StringQ[userBase], userBase = $HomeDirectory];
	If[!StringQ[userBase], userBase = Environment["HOME"]];
	If[!StringQ[userBase], userBase = Environment["USERPROFILE"]];
	If[!StringQ[userBase], Return[$Failed]];

	FileNameJoin[{userBase, "ApplicationData", "FernandoDuarte", "LongRunRisk", "config.wl"}]
];

loadConfig[] := Module[{configFile, config},
	configFile = configFilePath[];
	If[configFile === $Failed || !FileExistsQ[configFile], Return[<||>]];

	config = Quiet[Check[Get[configFile], <||>]];
	If[!AssociationQ[config], Return[<||>]];
	config
];

openOrCreateConfigFile[] := Module[{file, defaults, create},
	file = configFilePath[];
	If[file === $Failed,
		MessageDialog["Could not determine your user base directory."];
		Return[Null]
	];

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
showPipelineReport[changes_, status_, shortnames_, autoBuild_:False] := Module[
	{dialogResult, buildResult, grid, title},

	(* AutoBuild mode: skip prompts and build directly *)
	If[TrueQ[autoBuild],
		If[$Notebooks =!= True,
			Null
		];
		buildResult = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels[
			"Models" -> shortnames
		];
		Return[buildResult]
	];

	(* Build status grid *)
	grid = formatStatusGrid[status];

	(* Choose title based on whether it's catalog changes or incomplete pipeline *)
	title = If[TrueQ[changes["IncompletePipeline"]],
		"Incomplete Pipeline Detected",
		"Catalog Changes Detected"
	];

	If[$Notebooks =!= True,
		(* Terminal mode *)
		showTerminalReport[changes, status, shortnames],

		(* Notebook mode: use DialogInput for value return *)
		dialogResult = DialogInput[
			Column[{
				Style[title, "Title", 16, Bold],
				Style[DateString[], "Subtitle", Gray],
				"",
				formatChangeSummary[changes, shortnames],
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
	Null;
	If[TrueQ[changes["IncompletePipeline"]],
		Null,
		Null
	];
	Null;

	If[TrueQ[changes["IncompletePipeline"]],
		Null,
		(* Regular catalog changes *)
		If[changes["New"] =!= {},
			Null];
		If[changes["Changed"] =!= {},
			Null];
		If[changes["Removed"] =!= {},
			Null];
		If[TrueQ[changes["FirstRun"]],
			Null]
	];

	Null;
	Null;
	printStatusTable[status];

	Null;
	Null;
	(* Fully qualified command *)
	Null;
	Null;
];

(* Status icon - uses Position for robustness *)
(* reason parameter determines if this is a catalog-change cascade or artifact-only rebuild *)
statusIcon[stage_String, currentStage_String, reason_String : ""] := Module[
	{stageOrder, stageIdx, currentIdx, pos, catalogChanged},
	stageOrder = {"Symbolic", "Compile", "Numerical", "Moments", "UpToDate"};
	pos = Position[stageOrder, stage];
	stageIdx = If[pos === {}, 6, pos[[1, 1]]];
	pos = Position[stageOrder, currentStage];
	currentIdx = If[pos === {}, 6, pos[[1, 1]]];

	(* Check if this is a catalog-change cascade (full rebuild) or artifact-only (no moments cascade) *)
	catalogChanged = MemberQ[{"catalog changed", "model not in Models.wl"}, reason];

	Which[
		stageIdx < currentIdx,
			If[$Notebooks =!= True, "[OK]", Style["\[Checkmark]", Darker@Green, Bold]],
		stageIdx == currentIdx,
			If[$Notebooks =!= True, "[>>]", Style["\[RightArrow]", Orange, Bold]],
		(* For Moments stage: if artifact-only issue, moments won't be rebuilt - show as valid *)
		stage === "Moments" && !catalogChanged && currentIdx < 4,
			If[$Notebooks =!= True, "[OK]", Style["\[Checkmark]", Darker@Green, Bold]],
		True,
			If[$Notebooks =!= True, "[ ]", Style["\[FilledCircle]", Gray]]
	]
];

formatStatusGrid[status_Association] := Grid[
	Prepend[
		KeyValueMap[
			{#1,
			 statusIcon["Symbolic", #2["MainStage"], #2["Reason"]],
			 statusIcon["Compile", #2["MainStage"], #2["Reason"]],
			 statusIcon["Numerical", #2["MainStage"], #2["Reason"]],
			 statusIcon["Moments", #2["MainStage"], #2["Reason"]],
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
	Null;
	Null;
	KeyValueMap[
		Null &,
		status
	]
];

formatChangeSummary[changes_Association, shortnames_List : {}] := Column[{
	If[TrueQ[changes["IncompletePipeline"]],
		Row[{Style["Models with incomplete pipelines: ", Bold], StringRiffle[shortnames, ", "]}],
		Nothing],
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
		Null;
		Null;
		KeyValueMap[
			Function[{model, result},
				If[!TrueQ[result["Valid"]],
					Null;
					Scan[Null &, result["Errors"]]
				]
			],
			validation["Results"]
		];
		Null;
		Null,

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
