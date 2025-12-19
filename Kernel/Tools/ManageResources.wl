(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];

updateModelManifest::usage = "updateModelManifest[] generates and saves the ModelManifest.wl file.
updateModelManifest[modelsAssoc] computes manifest data from the given models association without writing to disk.";
updateModelManifest::noroot = "Could not locate paclet root directory.";
updateModelManifest::nocat = "Catalog models not found or invalid.";
updateModelManifest::versionmismatch = "PacletInfo.wl version `1` differs from installed paclet version `2`; using PacletInfo.wl version.";

checkCatalogChanges::usage = "checkCatalogChanges[] compares the current Catalog to the saved manifest and reports which models have changed.
checkCatalogChanges[modelsAssoc] compares the given models association against the saved manifest, validates changes, but does not reformat.";
checkCatalogChanges::noroot = "Could not locate paclet root directory.";
checkCatalogChanges::nocat = "Catalog models not found or invalid.";
checkCatalogChanges::nomanifest = "ModelManifest.wl not found. Run updateModelManifest[] first.";
checkCatalogChanges::changed = "The following models have changed and need updating: `1`.";
checkCatalogChanges::newmodels = "New models added to catalog: `1`.";
checkCatalogChanges::removed = "Models removed from catalog: `1`.";

reformatCatalog::usage = "reformatCatalog[] reformats the models section of Catalog.wl using standard formatting, preserving modelsExtraInfo unchanged.";
reformatCatalog::noroot = "Could not locate paclet root directory.";
reformatCatalog::nocat = "Could not locate Catalog.wl or parse its structure.";
reformatCatalog::convfail = "Catalog reformatting failed: `1`";

buildModels::usage = "buildModels[] processes enabled models, compiles functions, computes numerical solutions, and creates moments database.";
buildModels::noroot = "Could not locate paclet root directory.";
buildModels::nocat = "Catalog models not found or invalid.";

buildModelsParallel::usage = "buildModelsParallel[models] runs Symbolic+Compile+Numerical phases in parallel across models, then optionally runs Moments sequentially.
Models is a list of shortnames like {\"BY\", \"NRC\", \"DES\"}.
Options include \"CreateMoments\" (default True) and \"NumKernels\" (default Automatic).";

checkCatalogForUI::usage = "checkCatalogForUI[] checks catalog changes without auto-reformatting.
Returns <|\"Changed\"->{keys}, \"New\"->{keys}, \"Removed\"->{keys}, \"Validation\"->..., \"FirstRun\"->bool|> or $Failed.
Handles first-run case (no manifest) by returning all enabled models as \"New\" with FirstRun->True.";

getModelPipelineStatus::usage = "getModelPipelineStatus[] returns pipeline status for all enabled models.
getModelPipelineStatus[shortnames] returns status for specified models (shortnames or All).
Returns <|shortname -> <|\"MainStage\"->..., \"NeedsJacobians\"->..., \"Reason\"->...|>, ...|> or $Failed.";

Begin["`Private`"];

(* Live catalog loading - tracks file modification time *)
$catalogFile = None;
$catalogMTime = None;
$packageRoot = If[StringQ[$InputFileName], DirectoryName[$InputFileName, 3], None];
$pacletLoaded = False;

getCatalogModels[] := Module[{mtime, root},
  (* Find file path once *)
  If[!StringQ[$catalogFile],
    $catalogFile = FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"];
    If[!StringQ[$catalogFile],
      With[{root = findPacletRoot[]},
        If[StringQ[root],
          $catalogFile = FileNameJoin[{root, "Kernel", "Model", "Catalog.wl"}]
        ]
      ]
    ]
  ];
  root = If[StringQ[$catalogFile], DirectoryName[$catalogFile, 3], None];
  If[StringQ[root], ensurePacletLoaded[root]];

  If[!StringQ[$catalogFile] || !FileExistsQ[$catalogFile], Return[$Failed]];

  (* Check modification time *)
  mtime = FileDate[$catalogFile, "Modification"];

  If[mtime =!= $catalogMTime,
    Get[$catalogFile];
    $catalogMTime = mtime
  ];

  FernandoDuarte`LongRunRisk`Model`Catalog`models
];

(* Simple root finder - uses FindFile on THIS package *)
findPacletRoot[] := Module[{file, root},
  file = Quiet@FindFile["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];

  (* Primary: locate via FindFile (installed paclet or $Path) *)
  root = If[StringQ[file], DirectoryName[file, 3], None];  (* Kernel/Tools/file.wl -> root *)

  (* Fallback: use the path of the currently loaded package file *)
  If[!StringQ[root] && StringQ[$packageRoot], root = $packageRoot];

  (* Fallback: if running from repo root, detect PacletInfo.wl in cwd *)
  If[!StringQ[root],
    With[{cwd = Directory[]},
      If[FileExistsQ[FileNameJoin[{cwd, "PacletInfo.wl"}]],
        root = cwd
      ]
    ]
  ];

  If[StringQ[root] && FileExistsQ[FileNameJoin[{root, "PacletInfo.wl"}]],
    root,
    $Failed
  ]
];

ensurePacletLoaded[root_String] := Module[{},
  If[TrueQ[$pacletLoaded], Return[root]];
  Quiet@Check[PacletDirectoryLoad[root], Null];
  $pacletLoaded = True;
  root
];

(* Simple version getter *)
getVersion[root_String] := Module[
  {infoPath, repoVersion, found, match, matchVersion},

  infoPath = FileNameJoin[{root, "PacletInfo.wl"}];
  repoVersion = Quiet@Check[
    With[{info = Get[infoPath]},
      With[{v = info["Version"]},
        If[StringQ[v], v, None]
      ]
    ],
    None
  ];

  found = PacletFind["FernandoDuarte/LongRunRisk"];
  match = SelectFirst[found,
    Quiet@Check[#["Location"] === root, False] &,
    Missing["NotFound"]
  ];
  matchVersion = Quiet@Check[match["Version"], None];

  If[StringQ[repoVersion] && StringQ[matchVersion] && repoVersion =!= matchVersion,
    Message[updateModelManifest::versionmismatch, repoVersion, matchVersion];
  ];

  Which[
    StringQ[repoVersion], repoVersion,
    StringQ[matchVersion], matchVersion,
    True, "Development"
  ]
];

canonicalize[expr_Association] := KeySort[Map[canonicalize, expr]];
canonicalize[expr_List] := Map[canonicalize, expr];
canonicalize[expr_] := expr;

(* Block $ContextPath to ensure stable hash regardless of loaded packages *)
getCanonicalHash[expr_] := Block[{$ContextPath = {"System`"}},
  Hash[ExportString[canonicalize[expr], "WL"], "SHA256", "HexString"]
];

(* OS-level memory usage (sum of WolframKernel RSS, in GB) *)
wolframKernelMemoryGB[] := Module[{raw, kb},
  raw = Quiet@Import["!ps -axo rss,comm | grep -i '[W]olframKernel' | awk '{sum+=$1} END {print sum}'", "String"];
  kb = Quiet@Check[ToExpression@StringTrim[raw], $Failed];
  If[NumberQ[kb], N[kb/1024.^2], Missing["NotAvailable"]]
];

loadManifestSafe[file_] := Module[{held, data},
  If[!FileExistsQ[file],
    Return[<|
      "PacletVersion" -> "Missing",
      "CatalogHash" -> "",
      "Models" -> <||>,
      "Date" -> ""
    |>]
  ];
  (* Parse without evaluation, then validate shape before releasing *)
  held = Check[ToExpression[Import[file, "Text"], StandardForm, HoldComplete], Return[$Failed]];
  If[!MatchQ[held, HoldComplete[_Association]], Return[$Failed]];
  If[!MatchQ[held, HoldComplete[<|
      "PacletVersion" -> _String,
      "CatalogHash"   -> _String,
      "Models"        -> _Association,
      "Date"          -> _String
    |>]], Return[$Failed]];
  data = held /. HoldComplete[x_] :> x;
  If[!VectorQ[Values[data["Models"]], StringQ], Return[$Failed]];
  data
];

(* No-argument version: reads from catalog, writes to disk *)
updateModelManifest[] := Module[
  {root, manifestFile, catalogModels, catalogHash, modelHashes, version, manifestData},

  (* Find root *)
  root = findPacletRoot[];
  If[root === $Failed, Message[updateModelManifest::noroot]; Return[$Failed]];

  (* Build manifest path *)
  manifestFile = FileNameJoin[{root, "Resources", "ModelManifest.wl"}];
  Quiet[CreateDirectory[DirectoryName[manifestFile]], {CreateDirectory::eexist}];

  (* Get catalog (live reload if file changed) *)
  catalogModels = getCatalogModels[];
  If[!AssociationQ[catalogModels], Message[updateModelManifest::nocat]; Return[$Failed]];

  (* Compute hashes *)
  catalogHash = getCanonicalHash[catalogModels];
  modelHashes = Map[getCanonicalHash, catalogModels];

  (* Get version *)
  version = getVersion[root];

  (* Build and save *)
  manifestData = <|
    "PacletVersion" -> version,
    "CatalogHash" -> catalogHash,
    "Models" -> modelHashes,
    "Date" -> DateString["ISODateTime"]
  |>;

  Put[manifestData, manifestFile];
  manifestData
];

(* Association argument version: computes manifest from provided models, does not write to disk *)
updateModelManifest[modelsAssoc_Association] := Module[
  {root, catalogHash, modelHashes, version, manifestData},

  (* Find root for version info *)
  root = findPacletRoot[];
  version = If[root === $Failed, "Unknown", getVersion[root]];

  (* Compute hashes from provided association *)
  catalogHash = getCanonicalHash[modelsAssoc];
  modelHashes = Map[getCanonicalHash, modelsAssoc];

  (* Build manifest data (no file writes) *)
  manifestData = <|
    "PacletVersion" -> version,
    "CatalogHash" -> catalogHash,
    "Models" -> modelHashes,
    "Date" -> DateString["ISODateTime"]
  |>;

  manifestData
];

checkCatalogChanges[] := Module[
  {root, manifestFile, savedManifest, catalogModels, currentCatalogHash,
   savedCatalogHash, savedModelHashes, currentModelHashes,
   changedModels, newModels, removedModels, modelsToValidate, validationResult},

  (* Find root *)
  root = findPacletRoot[];
  If[root === $Failed, Message[checkCatalogChanges::noroot]; Return[$Failed]];

  (* Load manifest *)
  manifestFile = FileNameJoin[{root, "Resources", "ModelManifest.wl"}];
  If[!FileExistsQ[manifestFile],
    Message[checkCatalogChanges::nomanifest];
    Return[$Failed]
  ];
  savedManifest = loadManifestSafe[manifestFile];
  If[savedManifest === $Failed,
    Message[checkCatalogChanges::nomanifest];
    Return[$Failed]
  ];

  (* Get catalog (live reload if file changed) *)
  catalogModels = getCatalogModels[];
  If[!AssociationQ[catalogModels], Message[checkCatalogChanges::nocat]; Return[$Failed]];

  (* Quick check: compare catalog hash *)
  currentCatalogHash = getCanonicalHash[catalogModels];
  savedCatalogHash = savedManifest["CatalogHash"];

  If[currentCatalogHash === savedCatalogHash,
    (* No changes - return silently *)
    Return[Null]
  ];

  (* Catalog has changed - identify which models *)
  savedModelHashes = savedManifest["Models"];
  currentModelHashes = Map[getCanonicalHash, catalogModels];

  (* Find changed models (exist in both, hash differs) *)
  changedModels = Select[
    Keys[KeyTake[currentModelHashes, Keys[savedModelHashes]]],
    currentModelHashes[#] =!= savedModelHashes[#] &
  ];

  (* Find new models (in current but not saved) *)
  newModels = Complement[Keys[currentModelHashes], Keys[savedModelHashes]];

  (* Find removed models (in saved but not current) *)
  removedModels = Complement[Keys[savedModelHashes], Keys[currentModelHashes]];

  If[changedModels =!= {},
    Message[checkCatalogChanges::changed, StringRiffle[changedModels, ", "]]
  ];

  If[newModels =!= {},
    Message[checkCatalogChanges::newmodels, StringRiffle[newModels, ", "]]
  ];

  If[removedModels =!= {},
    Message[checkCatalogChanges::removed, StringRiffle[removedModels, ", "]]
  ];

  (* Validate changed and new models *)
  modelsToValidate = Join[changedModels, newModels];
  validationResult = If[modelsToValidate =!= {},
    Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
    FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog[
      KeyTake[catalogModels, modelsToValidate]
    ],
    <|"Valid" -> True, "Results" -> <||>, "InvalidModels" -> {}, "TotalErrors" -> 0|>
  ];

  (* auto-reformat only if there were valid changes *)
  If[(changedModels =!= {} || newModels =!= {}) && TrueQ[validationResult["Valid"]],
    reformatCatalog[]
  ];

  <|
    "Changed" -> changedModels,
    "New" -> newModels,
    "Removed" -> removedModels,
    "Validation" -> validationResult
  |>
];

(* Association argument version: compares provided models against manifest on disk, no reformatting *)
checkCatalogChanges[modelsAssoc_Association] := Module[
  {root, manifestFile, savedManifest, currentCatalogHash,
   savedCatalogHash, savedModelHashes, currentModelHashes,
   changedModels, newModels, removedModels, modelsToValidate, validationResult},

  (* Find root *)
  root = findPacletRoot[];
  If[root === $Failed, Message[checkCatalogChanges::noroot]; Return[$Failed]];

  (* Load manifest *)
  manifestFile = FileNameJoin[{root, "Resources", "ModelManifest.wl"}];
  If[!FileExistsQ[manifestFile],
    Message[checkCatalogChanges::nomanifest];
    Return[$Failed]
  ];
  savedManifest = loadManifestSafe[manifestFile];
  If[savedManifest === $Failed,
    Message[checkCatalogChanges::nomanifest];
    Return[$Failed]
  ];

  (* Quick check: compare catalog hash *)
  currentCatalogHash = getCanonicalHash[modelsAssoc];
  savedCatalogHash = savedManifest["CatalogHash"];

  If[currentCatalogHash === savedCatalogHash,
    (* No changes - return silently *)
    Return[Null]
  ];

  (* Catalog has changed - identify which models *)
  savedModelHashes = savedManifest["Models"];
  currentModelHashes = Map[getCanonicalHash, modelsAssoc];

  (* Find changed models (exist in both, hash differs) *)
  changedModels = Select[
    Keys[KeyTake[currentModelHashes, Keys[savedModelHashes]]],
    currentModelHashes[#] =!= savedModelHashes[#] &
  ];

  (* Find new models (in current but not saved) *)
  newModels = Complement[Keys[currentModelHashes], Keys[savedModelHashes]];

  (* Find removed models (in saved but not current) *)
  removedModels = Complement[Keys[savedModelHashes], Keys[currentModelHashes]];

  If[changedModels =!= {},
    Message[checkCatalogChanges::changed, StringRiffle[changedModels, ", "]]
  ];

  If[newModels =!= {},
    Message[checkCatalogChanges::newmodels, StringRiffle[newModels, ", "]]
  ];

  If[removedModels =!= {},
    Message[checkCatalogChanges::removed, StringRiffle[removedModels, ", "]]
  ];

  (* Validate changed and new models *)
  modelsToValidate = Join[changedModels, newModels];
  validationResult = If[modelsToValidate =!= {},
    Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
    FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog[
      KeyTake[modelsAssoc, modelsToValidate]
    ],
    <|"Valid" -> True, "Results" -> <||>, "InvalidModels" -> {}, "TotalErrors" -> 0|>
  ];

  (* No auto-reformat for association input - no file to reformat *)

  <|
    "Changed" -> changedModels,
    "New" -> newModels,
    "Removed" -> removedModels,
    "Validation" -> validationResult
  |>
];

(* === BoxData Conversion Functions === *)

(* Option A: Front end conversion using FrontEndToken SaveRename *)
convertWithFrontEnd[boxData_, outputPath_String] := Module[
  {nb, result = $Failed},

  UsingFrontEnd[
    (* Create notebook in memory with formatted content *)
    nb = NotebookPut[Notebook[{Cell[boxData, "Input"]}]];

    If[nb =!= $Failed,
      (* Save as .wl Package using front end's native mechanism *)
      FrontEndExecute[
        FrontEndToken[nb, "SaveRename", {outputPath, "Package"}]
      ];
      NotebookClose[nb];
      result = Import[outputPath, "Text"]
    ]
  ];
  result
];

(* Option B: Manual recursive flattening (fallback for headless mode) *)
boxToString[RowBox[items_List]] := StringJoin[boxToString /@ items];
boxToString[BoxData[content_]] := boxToString[content];
boxToString[Cell[BoxData[content_], ___]] := boxToString[content];
boxToString[s_String] := s;
boxToString[n_Integer] := ToString[n];
boxToString[n_Real] := ToString[n];
boxToString[items_List] := StringJoin[boxToString /@ items]; (* Handle bare lists *)

(* Mathematical box types *)
boxToString[SuperscriptBox[base_, exp_]] := StringJoin["Power[", boxToString[base], ", ", boxToString[exp], "]"];
boxToString[SubscriptBox[base_, sub_]] := StringJoin["Subscript[", boxToString[base], ", ", boxToString[sub], "]"];
boxToString[SubsuperscriptBox[base_, sub_, sup_]] := StringJoin["Subsuperscript[", boxToString[base], ", ", boxToString[sub], ", ", boxToString[sup], "]"];
boxToString[FractionBox[num_, denom_]] := StringJoin["(", boxToString[num], ")/(", boxToString[denom], ")"];
boxToString[SqrtBox[content_]] := StringJoin["Sqrt[", boxToString[content], "]"];
boxToString[RadicalBox[content_, n_]] := StringJoin["Power[", boxToString[content], ", 1/", boxToString[n], "]"];
boxToString[OverscriptBox[base_, over_]] := StringJoin["Overscript[", boxToString[base], ", ", boxToString[over], "]"];
boxToString[UnderscriptBox[base_, under_]] := StringJoin["Underscript[", boxToString[base], ", ", boxToString[under], "]"];

(* Catch-all for unknown boxes - try to convert content recursively *)
boxToString[box_[args___]] /; StringEndsQ[SymbolName[box], "Box"] :=
  StringJoin["(*UnhandledBox:", SymbolName[box], "*)", StringRiffle[boxToString /@ {args}, " "]];

(* Final fallback *)
boxToString[x_] := ToString[x, InputForm];

(* Main converter: uses boxToString for plain text output *)
(* Note: convertWithFrontEnd produces notebook format with cell markers, *)
(* which is undesirable for plain .wl files. Always use boxToString. *)
(* Safety: ensure result is always a string *)
boxDataToText[boxData_] := Module[{result},
  result = boxToString[boxData];
  If[StringQ[result], result, ToString[result, InputForm]]
];

(* === Catalog Section Parser === *)

(* Parse Catalog.wl and identify section boundaries *)
parseCatalogSections[filePath_String] := Module[
  {content, modelsStart, modelsEnd},

  content = Import[filePath, "Text"];

  (* Find "models = <|" position *)
  modelsStart = First[StringPosition[content, "models = <|"], {-1, -1}][[1]];

  (* Find "|>;(*end models*)" position *)
  modelsEnd = First[StringPosition[content, "|>;(*end models*)"], {-1, -1}][[2]];

  <|
    "Content" -> content,
    "ModelsStart" -> modelsStart,
    "ModelsEnd" -> modelsEnd
  |>
];

(* === Catalog Reformatter === *)

reformatCatalog[] := Module[
  {root, catalogFile, catalogModels, sections,
   formattedBoxData, formattedText, newContent,
   footerRaw, footerTrimmed, headerText},

  (* Find root and catalog file *)
  root = findPacletRoot[];
  If[root === $Failed, Message[reformatCatalog::noroot]; Return[$Failed]];

  catalogFile = FileNameJoin[{root, "Kernel", "Model", "Catalog.wl"}];
  If[!FileExistsQ[catalogFile], Message[reformatCatalog::nocat]; Return[$Failed]];

  (* Load NiceOutput *)
  Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];
  If[!NameQ["FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog"],
    Quiet@Get[FileNameJoin[{root, "Kernel", "Tools", "NiceOutput.wl"}]]
  ];

  (* Get current catalog models *)
  catalogModels = getCatalogModels[];
  If[!AssociationQ[catalogModels], Message[reformatCatalog::nocat]; Return[$Failed]];

  (* Parse file to identify sections *)
  sections = parseCatalogSections[catalogFile];
  If[sections["ModelsStart"] < 0 || sections["ModelsEnd"] < 0,
    Message[reformatCatalog::nocat]; Return[$Failed]
  ];

  (* Generate formatted BoxData using NiceOutput infrastructure *)
  formattedBoxData = FernandoDuarte`LongRunRisk`Tools`NiceOutput`formatModels[
    FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog[
      catalogModels,
      {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"}
    ]
  ];

  (* Convert BoxData to plain text and trim trailing whitespace *)
  formattedText = boxDataToText[formattedBoxData];
  If[!StringQ[formattedText],
    Message[reformatCatalog::convfail, "BoxData conversion failed - formattedText is not a string"];
    Return[$Failed]
  ];
  formattedText = StringTrim[formattedText, WhitespaceCharacter ..];

  (* Get footer and normalize the boundary to prevent whitespace accumulation *)
  footerRaw = StringDrop[sections["Content"], sections["ModelsEnd"]];
  footerTrimmed = StringTrim[footerRaw, WhitespaceCharacter ..];

  (* Get header *)
  headerText = StringTake[sections["Content"], sections["ModelsStart"] - 1];

  (* Validate all parts are strings before joining *)
  If[!StringQ[headerText],
    Message[reformatCatalog::convfail, "Header extraction failed - headerText is not a string"];
    Return[$Failed]
  ];
  If[!StringQ[footerTrimmed],
    Message[reformatCatalog::convfail, "Footer extraction failed - footerTrimmed is not a string"];
    Return[$Failed]
  ];

  (* Reconstruct file: preserve header + new models + separator + footer *)
  (* Use exactly two newlines (one blank line) as separator *)
  newContent = StringJoin[headerText, formattedText, "\n\n\n", footerTrimmed];

  (* Final validation before writing *)
  If[!StringQ[newContent],
    Message[reformatCatalog::convfail, "StringJoin failed to produce a string - check inputs"];
    Return[$Failed]
  ];

  (* Write back *)
  Export[catalogFile, newContent, "Text"];

  (* Reset cache to force reload on next access *)
  $catalogMTime = None;

  catalogFile
];


(* === buildModels orchestrator === *)

buildModels // Options = {
	"FromScratch" -> False,
	"CompileJacobians" -> False,
	"CreateMoments" -> True,
	"NumKernels" -> Automatic,  (* Automatic | n | None *)
	"MaxMaturity" -> 120,
	"Models" -> All,  (* All or list of shortnames *)
	"PdEquations" -> "B",  (* "B" | "AB" | "Both" - controls which pd equations to compute/compile *)
	"FileSuffix" -> "",  (* suffix for checkpoint files; "_BY" writes to Models_BY.wl *)
	"UpdateManifest" -> True  (* whether to update ModelManifest.wl at end *)
};


(* helper: select enabled models from catalog *)
selectEnabledModels[catalog_Association] := Select[catalog, TrueQ[#["enabled"]] &];


(* helper: delete all generated outputs for from-scratch builds *)
cleanAllOutputs[root_String] := Module[{resourcesDir, compiledDir, momentsDir},
	resourcesDir = FileNameJoin[{root, "Resources"}];
	compiledDir = FileNameJoin[{resourcesDir, "CompiledFunctions"}];
	momentsDir = FileNameJoin[{resourcesDir, "MomentsLookupTables"}];

	(* delete compiled .mx files from root and all platform subfolders *)
	If[DirectoryQ[compiledDir],
		DeleteFile /@ FileNames["*.mx", compiledDir, Infinity]
	];

	(* delete moments lookup tables *)
	If[DirectoryQ[momentsDir],
		DeleteFile /@ Join[
			FileNames["covLong*.mx", momentsDir],
			FileNames["covLong*.wl", momentsDir]
		]
	];

	(* delete Models.wl and ModelManifest.wl *)
	Quiet[DeleteFile[FileNameJoin[{resourcesDir, "Models.wl"}]]];
	Quiet[DeleteFile[FileNameJoin[{resourcesDir, "ModelManifest.wl"}]]];

	(* delete any suffixed Models files from parallel builds *)
	Quiet[DeleteFile /@ FileNames["Models_*.wl", resourcesDir]];
];


(* helper: save processed models to Models.wl using DefinitionData *)
saveModels[models_Association, file_String] := Module[{dataModels, modelsData},
	Quiet[CreateDirectory[DirectoryName[file]], {CreateDirectory::eexist}];
	(* DefinitionData requires a Symbol, not an inline association.
	   Assign to local symbol first so DefinitionData can serialize properly. *)
	modelsData = models;
	dataModels = PacletizedResourceFunctions`DefinitionData[modelsData];
	(* Ensure correct context before saving - prevents shadowing issues *)
	dataModels = PacletizedResourceFunctions`DefinitionData @@ List @@ dataModels;
	(* Block $ContextPath so Put writes full context prefix *)
	Block[{$ContextPath = {"System`"}},
		Put[dataModels, file]
	];
	file
];


(* helper: load models from Models.wl - Get@Get triggers DefinitionData UpValue *)
loadModels[file_String] := If[FileExistsQ[file], Get@Get[file], <||>];


(* helper: compute hash for moments cache *)
getMomentsHash[catalogEntry_Association, model_Association] :=
	getCanonicalHash[<|
		"catalog" -> catalogEntry,
		"exogenousEq" -> model["exogenousEq"],
		"endogenousEq" -> model["endogenousEq"]
	|>];

(* helper: check if moments files are current *)
(* Uses separate metadata file so we can validate cache without loading it *)
momentsUpToDate[momentsFile_String, metaFile_String, expectedHash_String] := Module[
	{savedMeta, savedHash},
	(* Both files must exist *)
	If[!FileExistsQ[momentsFile] || !FileExistsQ[metaFile], Return[False]];
	savedMeta = Quiet[Get[metaFile]];
	If[!AssociationQ[savedMeta], Return[False]];
	savedHash = savedMeta["Hash"];
	If[savedHash =!= expectedHash, Return[False]];
	If[KeyExistsQ[savedMeta, "SystemID"] && savedMeta["SystemID"] =!= $SystemID, Return[False]];
	True
];


(* helper: check if numerical solutions are valid *)
(* Note: addCoeffsSolutionN returns a List of Associations *)
validCoeffsSolutionN[model_] := With[
	{sol = model["coeffsSolutionN"]},
	KeyExistsQ[model, "coeffsSolutionN"] &&
	MatchQ[sol, {__Association}]
];


(* helper: validate compiled .mx file against model - matches pattern from FindRootOptim.wl *)
(* Note: compilerChoice and flattenOpt must match defaults in FindRootOptim.wl buildKernel/createCompiledEq *)
validateCompiledFile[mxFile_String, model_Association, compileMode_String : "FunctionOnly",
	compilerChoice_String : "Compile", flattenOpt_ : Automatic] := Module[
	{savedData, expectedHash, eqMap, pdMode},

	If[!FileExistsQ[mxFile], Return[<|"Valid" -> False, "Reason" -> "file missing"|>]];

	savedData = Quiet[Check[Import[mxFile, "MX"], $Failed]];
	If[!AssociationQ[savedData] || !KeyExistsQ[savedData, "meta"],
		Return[<|"Valid" -> False, "Reason" -> "invalid format"|>]
	];

	If[savedData["meta"]["SystemID"] =!= $SystemID,
		Return[<|"Valid" -> False, "Reason" -> "platform mismatch"|>]
	];

	(* Compute expected hash - same logic as createCompiledEq in FindRootOptim.wl *)
	pdMode = Lookup[model["coeffsParamQuadSolve"]["pd"], "pdMode", "B"];
	eqMap = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildEqMapFromModel[model];
	expectedHash = Hash[{compileMode, compilerChoice, flattenOpt, pdMode, eqMap}, "Expression"];

	If[savedData["meta"]["Hash"] =!= expectedHash,
		Return[<|"Valid" -> False, "Reason" -> "hash mismatch"|>]
	];

	<|"Valid" -> True, "Reason" -> "valid"|>
];

(* helper: resolve compiled .mx path (platform subfolder preferred, legacy flat fallback) *)
resolveCompiledMxFile[compiledDir_String, shortname_String, fileSuffix_String : ""] := Module[
	{newFile, legacyFile},
	newFile = FileNameJoin[{compiledDir, $SystemID, shortname <> fileSuffix <> ".mx"}];
	legacyFile = FileNameJoin[{compiledDir, shortname <> fileSuffix <> ".mx"}];
	Which[
		FileExistsQ[newFile], newFile,
		FileExistsQ[legacyFile], legacyFile,
		True, newFile
	]
];


(* helper: determine what stage a model needs to start from *)
determineModelStatus[modelKey_, catalogModels_, savedModels_, manifest_,
	compiledDir_, momentsDir_, compileJacobians_, createMoments_] := Module[
	{shortname, catalogHash, savedModel, mxFile, validation},

	shortname = catalogModels[modelKey]["shortname"];
	catalogHash = getCanonicalHash[catalogModels[modelKey]];

	(* Check: Catalog/manifest *)
	If[manifest === $Failed || !KeyExistsQ[manifest["Models"], modelKey] ||
		manifest["Models"][modelKey] =!= catalogHash,
		Return[<|"MainStage" -> "Symbolic", "NeedsJacobians" -> compileJacobians,
			"Reason" -> "catalog changed"|>]
	];

	(* Check: Saved model exists with matching catalogHash *)
	savedModel = savedModels[shortname];
	If[!AssociationQ[savedModel] || savedModel["catalogHash"] =!= catalogHash,
		Return[<|"MainStage" -> "Symbolic", "NeedsJacobians" -> compileJacobians,
			"Reason" -> "model not in Models.wl"|>]
	];

	(* Check: Compiled file valid - prefer platform-specific subfolder *)
	mxFile = resolveCompiledMxFile[compiledDir, shortname];
	validation = validateCompiledFile[mxFile, savedModel];
	If[!validation["Valid"],
		Return[<|"MainStage" -> "Compile", "NeedsJacobians" -> compileJacobians,
			"Reason" -> validation["Reason"]|>]
	];

	(* Check: Numerical solutions *)
	If[!validCoeffsSolutionN[savedModel],
		Return[<|"MainStage" -> "Numerical", "NeedsJacobians" -> compileJacobians,
			"Reason" -> "coeffsSolutionN missing"|>]
	];

	(* Check: Moments (if enabled) *)
	If[createMoments,
		With[{momentsFile = FileNameJoin[{momentsDir, "covLong" <> shortname <> ".mx"}],
			metaFile = FileNameJoin[{momentsDir, "covLong" <> shortname <> "_meta.wl"}],
			expectedHash = getMomentsHash[catalogModels[modelKey], savedModel]},
			If[!momentsUpToDate[momentsFile, metaFile, expectedHash],
				Return[<|"MainStage" -> "Moments", "NeedsJacobians" -> compileJacobians,
					"Reason" -> "moments stale"|>]
			]
		]
	];

	(* Check jacobians independently - prefer platform-specific subfolder *)
	If[compileJacobians,
		With[{jacFile = resolveCompiledMxFile[compiledDir, shortname, "_jacobians"]},
			validation = validateCompiledFile[jacFile, savedModel, "JacobianOnly"];
			If[!validation["Valid"],
				Return[<|"MainStage" -> "UpToDate", "NeedsJacobians" -> True,
					"Reason" -> "jacobians: " <> validation["Reason"]|>]
			]
		]
	];

	<|"MainStage" -> "UpToDate", "NeedsJacobians" -> False, "Reason" -> "all valid"|>
];


(* helper: setup parallel kernels *)
setupParallelKernels[numKernels_] := Module[{n},
	n = Switch[numKernels,
		Automatic, $ProcessorCount,
		None, 0,
		_Integer, numKernels,
		_, $ProcessorCount
	];
	If[n <= 0, Return[0]];

	(* Close existing and launch new *)
	CloseKernels[];
	LaunchKernels[n];

	Length[ParallelKernels[]]
];


(* helper: warmup parallel kernels *)
warmupParallelKernels[] := Module[{pacletDir},
	If[Length[ParallelKernels[]] == 0, Return[Null]];

	(* Find paclet root directory *)
	pacletDir = findPacletRoot[];
	If[!StringQ[pacletDir], Return[$Failed]];

	Needs["PacletizedResourceFunctions`"];
  	Module[{warmup}, warmup = Null; PacletizedResourceFunctions`DefinitionData[warmup];];

	(* Register paclet and load required packages on parallel kernels *)
	ParallelEvaluate[
		PacletDirectoryLoad[#];
		Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
		Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
		Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
		Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];
	] &@ pacletDir;
];


buildModels[opts : OptionsPattern[{buildModels, FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels, FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq}]] := With[
	{
		fromScratch = OptionValue["FromScratch"],
		compileJacobians = OptionValue["CompileJacobians"],
		createMoments = OptionValue["CreateMoments"],
		numKernels = OptionValue["NumKernels"],
		maxMaturity = OptionValue["MaxMaturity"],
		modelFilter = OptionValue["Models"],
		fileSuffix = OptionValue["FileSuffix"],
		updateManifest = OptionValue["UpdateManifest"]
	},
	Module[
		{
			root, resourcesDir, compiledDir, momentsDir, modelsFileCanonical, modelsFileCheckpoint, manifestFile,
			catalogModels, enabledModels, savedModels, manifest,
			modelStatuses, modelsByStage, modelsNeedingJacobians, modelsToPreload,
			symbolicModels, compileModels, numericalModels, momentsModels,
			processedModels, model, shortname, compiledFile, catalogHash, phase3ContextFile
			},

		(* find paclet root *)
		root = findPacletRoot[];
		If[root === $Failed, Message[buildModels::noroot]; Return[$Failed]];

		resourcesDir = FileNameJoin[{root, "Resources"}];
		compiledDir = FileNameJoin[{resourcesDir, "CompiledFunctions"}];
		momentsDir = FileNameJoin[{resourcesDir, "MomentsLookupTables"}];
		modelsFileCanonical = FileNameJoin[{resourcesDir, "Models.wl"}];
		modelsFileCheckpoint = FileNameJoin[{resourcesDir, "Models" <> fileSuffix <> ".wl"}];
		manifestFile = FileNameJoin[{resourcesDir, "ModelManifest.wl"}];

		(* ensure directories exist *)
		Quiet[CreateDirectory[compiledDir], {CreateDirectory::eexist}];
		Quiet[CreateDirectory[momentsDir], {CreateDirectory::eexist}];

		(* get catalog and filter enabled models *)
		catalogModels = getCatalogModels[];
		If[!AssociationQ[catalogModels], Message[buildModels::nocat]; Return[$Failed]];

		enabledModels = selectEnabledModels[catalogModels];

		(* apply model filter if specified - convert to strings for comparison *)
		(* Accept both All (symbol) and "All" (string) for convenience *)
		enabledModels = If[modelFilter === All || modelFilter === "All",
			enabledModels,
			KeyTake[enabledModels,
				Select[Keys[enabledModels], MemberQ[ToString /@ Flatten@{modelFilter}, catalogModels[#]["shortname"]] &]
			]
		];

		If[Length[enabledModels] == 0,
			Return[<||>]
		];

		(* load dependencies early - needed for determineModelStatus *)
		Needs["PacletizedResourceFunctions`"];
		Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"];
		Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
		Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];

		(* load saved state from canonical file *)
		savedModels = loadModels[modelsFileCanonical];
		manifest = loadManifestSafe[manifestFile];

		(* handle fromScratch option *)
		If[fromScratch,
			cleanAllOutputs[root];
			savedModels = <||>;
			manifest = $Failed;
		];

		(* report removed models *)
		If[AssociationQ[manifest] && AssociationQ[manifest["Models"]],
			With[{removed = Complement[Keys[manifest["Models"]], Keys[catalogModels]]},
				If[removed =!= {}, Message[checkCatalogChanges::removed, StringRiffle[removed, ", "]]]
			]
		];

		(* determine status for each enabled model *)
		modelStatuses = Association @ Table[
			k -> determineModelStatus[k, catalogModels, savedModels, manifest,
				compiledDir, momentsDir, compileJacobians, createMoments],
			{k, Keys[enabledModels]}
		];

		(* group by main pipeline stage *)
		modelsByStage = GroupBy[Keys[modelStatuses], modelStatuses[#]["MainStage"] &];
		modelsNeedingJacobians = Select[Keys[modelStatuses], modelStatuses[#]["NeedsJacobians"] &];

		(* early exit if nothing to do *)
		modelsByStage = KeyDrop[modelsByStage, "UpToDate"];
		If[Total[Length /@ Values[modelsByStage]] == 0 && Length[modelsNeedingJacobians] == 0,
			Return[<||>]
		];

		(* preload saved models for non-symbolic stages *)
		processedModels = <||>;
		modelsToPreload = DeleteDuplicates @ Join[
			Flatten @ Values @ KeyDrop[modelsByStage, "Symbolic"],
			modelsNeedingJacobians
		];
		Do[
			With[{sn = catalogModels[k]["shortname"]},
				If[KeyExistsQ[savedModels, sn], processedModels[sn] = savedModels[sn]]
			], {k, modelsToPreload}
		];

		(* execute pipeline with cascade *)
		symbolicModels = Lookup[modelsByStage, "Symbolic", {}];

		(* Disable history to prevent memory accumulation from Out[] values *)
		$HistoryLength = 0;

		(* Memory profiling helper *)
			$memoryProfileLog = {};
			logMemory[label_String] := Module[{mem = MemoryInUse[], memGB, kernelGB},
				memGB = N[mem / 1024^3];
				kernelGB = wolframKernelMemoryGB[];
				AppendTo[$memoryProfileLog, <|"Label" -> label, "MemoryGB" -> memGB, "KernelRSSGB" -> kernelGB, "Time" -> DateString["ISODateTime"]|>];
				Print[
					Style[StringPadRight[label, 50], Bold],
					" | Memory: ", NumberForm[memGB, {5, 2}], " GB",
					" | KernelRSS: ", If[NumberQ[kernelGB], NumberForm[kernelGB, {5, 2}], "n/a"], " GB"
				]
			];
		logMemory["buildModels START"];

		(* Phase 1: Symbolic processing *)
		Do[
			shortname = catalogModels[modelKey]["shortname"];
			PrintTemporary["Processing model ", shortname, "..."];
			logMemory["Phase1 START: " <> shortname];

			(* run symbolic processing *)
			model = First @ Values @ FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels[
				KeyTake[catalogModels, {modelKey}],
				FilterRules[Flatten @ {opts}, Options[FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels]]
			];
			logMemory["Phase1 processModels done: " <> shortname];

			(* store catalogHash with model *)
			catalogHash = getCanonicalHash[catalogModels[modelKey]];
			processedModels[shortname] = Append[model, "catalogHash" -> catalogHash];

			(* Checkpoint after each model's symbolic processing *)
			saveModels[Merge[{savedModels, processedModels}, Last], modelsFileCheckpoint];

			(* Clear system cache to free memory after each model *)
			ClearSystemCache[];
			logMemory["Phase1 END: " <> shortname];

			, {modelKey, symbolicModels}
		];

		(* Phase 2: Compile functions - cascade from Symbolic + models at Compile stage *)
		logMemory["Phase2 START (Compile)"];
		compileModels = DeleteDuplicates @ Join[symbolicModels, Lookup[modelsByStage, "Compile", {}]];
		Do[
			shortname = catalogModels[modelKey]["shortname"];
			PrintTemporary["Compiling model ", shortname, "..."];
			logMemory["Phase2 START: " <> shortname];
			compiledFile = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq[
				processedModels[shortname],
				compiledDir
			];
			logMemory["Phase2 END: " <> shortname];
			, {modelKey, compileModels}
		];

		(* Jacobian track - runs after function compilation, before numerical *)
		If[compileJacobians && Length[modelsNeedingJacobians] > 0,
			logMemory["Jacobian compilation START"];
			Do[
				shortname = catalogModels[modelKey]["shortname"];
				logMemory["Jacobian START: " <> shortname];
				FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq[
					processedModels[shortname],
					compiledDir,
					"CompileMode" -> "JacobianOnly"
				];
				logMemory["Jacobian END: " <> shortname];
				, {modelKey, modelsNeedingJacobians}
			];
			logMemory["Jacobian compilation END"]
		];

			(* Phase 3: Numerical solutions - cascade from Compile + models at Numerical stage *)
			logMemory["Phase3 START (Numerical)"];
			phase3ContextFile = FileNameJoin[{root, "temp", "Phase3Context.wl"}];
			Quiet[CreateDirectory[DirectoryName[phase3ContextFile]], {CreateDirectory::eexist}];
			Put[
				<|
					"Timestamp" -> DateString["ISODateTime"],
					"compileModels" -> compileModels,
					"modelsByStage" -> modelsByStage,
					"processedModels" -> processedModels,
					"catalogModels" -> catalogModels,
					"savedModels" -> savedModels,
					"modelsFileCheckpoint" -> modelsFileCheckpoint,
					"logMemoryPresent" -> ValueQ[logMemory]
				|>,
				phase3ContextFile
			];
			Print["Saved Phase3 context for replay to ", phase3ContextFile];
			numericalModels = DeleteDuplicates @ Join[compileModels, Lookup[modelsByStage, "Numerical", {}]];
			Do[
				shortname = catalogModels[modelKey]["shortname"];
				logMemory["Phase3 START: " <> shortname];
				With[{solN = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`addCoeffsSolutionN[
					processedModels[shortname]
				]},
				processedModels[shortname] = Append[processedModels[shortname], "coeffsSolutionN" -> solN];
				(* Verify coeffsSolutionN was computed correctly *)
				If[!validCoeffsSolutionN[processedModels[shortname]],
					Print["WARNING: coeffsSolutionN validation failed for ", shortname,
						"; Keys: ", If[AssociationQ[solN], Keys[solN], Head[solN]]]
				]
			];

			(* Checkpoint after each model's numerical solutions *)
			saveModels[Merge[{savedModels, processedModels}, Last], modelsFileCheckpoint];
			logMemory["Phase3 END: " <> shortname];

				, {modelKey, numericalModels}
			];

			If[$Notebooks === True,
				CreateDialog[{
					TextCell[
						"Phase 3 numerical loop complete.\nContext saved to:\n" <> phase3ContextFile,
						"Text"
					],
					DefaultButton["OK", DialogReturn[]]
				}],
				Print["Phase 3 numerical loop complete. Context file: ", phase3ContextFile]
			];

			(* Phase 4: Moments database - cascade from Numerical + models at Moments stage *)
			If[createMoments,
			Module[{numLaunched, momentsFile, metaFile, currentHash},
				momentsModels = DeleteDuplicates @ Join[numericalModels, Lookup[modelsByStage, "Moments", {}]];

				If[Length[momentsModels] > 0,
					(* Setup parallel kernels *)
					numLaunched = setupParallelKernels[numKernels];
					If[numLaunched > 0, warmupParallelKernels[]];

					(* Load createDatabase *)
					Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`"];

					(* Process each model *)
					Do[
						shortname = catalogModels[modelKey]["shortname"];
						momentsFile = FileNameJoin[{momentsDir, "covLong" <> shortname <> ".mx"}];
						metaFile = FileNameJoin[{momentsDir, "covLong" <> shortname <> "_meta.wl"}];

						(* Create moments database *)
						FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`createDatabase[
							processedModels[shortname],
							momentsFile
						];

						(* Compute hash and save metadata *)
						currentHash = getMomentsHash[catalogModels[modelKey], processedModels[shortname]];
						Put[
							<|
								"Hash" -> currentHash,
								"Date" -> DateString["ISODateTime"],
								"Version" -> $Version,
								"SystemID" -> $SystemID
							|>,
							metaFile
							];

					, {modelKey, momentsModels}
					];

					(* Cleanup parallel kernels *)
					If[numLaunched > 0, CloseKernels[]];
				]
			]
		];

		(* save - merge with existing models to checkpoint file *)
		saveModels[Merge[{savedModels, processedModels}, Last], modelsFileCheckpoint];
		logMemory["buildModels END - Final save complete"];

		(* Print memory profile summary *)
		Print["\n", Style["=== MEMORY PROFILE SUMMARY ===", Bold, Blue]];
		Print["Peak memory: ", Max[$memoryProfileLog[[All, "MemoryGB"]]], " GB"];
		Print["Memory growth: ", Last[$memoryProfileLog]["MemoryGB"] - First[$memoryProfileLog]["MemoryGB"], " GB"];
		Print["\nFull log available in $memoryProfileLog"];

		(* update manifest only when using canonical file (empty suffix) *)
		If[TrueQ[updateManifest] && fileSuffix === "", updateModelManifest[]];

		processedModels
	]
];


(* === buildModelsParallel - parallel orchestrator === *)

buildModelsParallel // Options = {
	"CreateMoments" -> True,
	"NumKernels" -> Automatic,
	"FromScratch" -> False,
	"PdEquations" -> "B"
};

buildModelsParallel[models_List, opts : OptionsPattern[{buildModelsParallel, buildModels}]] := Module[
	{root, modelsFile, resourcesDir, numKernels, nLaunched,
	 pacletDir, parallelResults, mergedModels, savedModels,
	 createMoments, fromScratch, failedModels,
	 filteredOpts, successResults, successModels, saveResult, startTime},

	startTime = AbsoluteTime[];
	Print["=== buildModelsParallel started at ", DateString[], " ==="];
	Print["Models to build: ", models];

	(* Get options *)
	createMoments = OptionValue["CreateMoments"];
	fromScratch = OptionValue["FromScratch"];
	numKernels = Replace[OptionValue["NumKernels"], {
		Automatic -> Min[Length[models], $ProcessorCount],
		None -> 1
	}];
	Print["Options: CreateMoments=", createMoments, ", FromScratch=", fromScratch, ", NumKernels=", numKernels];

	(* Find paclet root *)
	root = findPacletRoot[];
	If[root === $Failed, Message[buildModels::noroot]; Return[$Failed]];

	pacletDir = root;
	resourcesDir = FileNameJoin[{root, "Resources"}];
	modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}];
	Print["Resources dir: ", resourcesDir];

	(* Handle fromScratch *)
	If[fromScratch,
		Print["Cleaning all outputs (FromScratch=True)..."];
		cleanAllOutputs[root];
		Print["Clean complete."]
	];

	(* Launch parallel kernels *)
	Print["Closing any existing kernels..."];
	CloseKernels[];
	Print["Launching ", numKernels, " parallel kernels..."];
	nLaunched = LaunchKernels[numKernels];
	Print["Launched ", nLaunched, " kernels."];

	(* Initialize parallel kernels *)
	Print["Initializing parallel kernels (loading paclet)..."];
	ParallelEvaluate[
		PacletDirectoryLoad[#];
		Needs["PacletizedResourceFunctions`"];
		Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];
	] &@ pacletDir;
	Print["Parallel kernels initialized."];

	(* Run builds in parallel - each returns processed model or $Failed *)
	Print["Starting parallel builds at ", DateString[], "..."];

	(* Filter out options we force-set to prevent caller override *)
	filteredOpts = FilterRules[{opts},
		Except["FileSuffix" | "UpdateManifest" | "CreateMoments" | "FromScratch" | "Models"]];

	parallelResults = ParallelTable[
		Quiet @ Check[
			With[{result = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels[
				"Models" -> {m},
				"CreateMoments" -> False,
				"FromScratch" -> False,
				"FileSuffix" -> "_" <> m,
				"UpdateManifest" -> False,
				filteredOpts
			]},
				If[AssociationQ[result] && Length[result] > 0,
					<|"Model" -> m, "Status" -> "Success", "Data" -> result|>,
					<|"Model" -> m, "Status" -> "Empty", "Data" -> <||>|>
				]
			],
			<|"Model" -> m, "Status" -> "Failed", "Data" -> <||>|>
		],
		{m, models},
		DistributedContexts -> Automatic
	];
	Print["Parallel builds completed at ", DateString[], " (", Round[AbsoluteTime[] - startTime], "s elapsed)"];

	(* Close parallel kernels before moments phase *)
	Print["Closing parallel kernels..."];
	CloseKernels[];
	Print["Parallel kernels closed."];

	(* Get successful results directly from parallelResults (already in memory) *)
	Print["Parallel results status: ", #["Model"] -> #["Status"] & /@ parallelResults];
	successResults = Select[parallelResults, #["Status"] === "Success" &];
	successModels = #["Model"] & /@ successResults;
	Print["Success models: ", successModels];

	(* Report failures *)
	failedModels = #["Model"] & /@ Select[parallelResults, #["Status"] =!= "Success" &];
	If[Length[failedModels] > 0,
		Print["WARNING: Some models failed or returned empty: ",
			StringRiffle[failedModels, ", "]]
	];

	(* Load canonical Models.wl and merge with in-memory results *)
	Print["Loading existing Models.wl..."];
	savedModels = loadModels[modelsFile];
	Print["Loaded ", Length[savedModels], " existing models: ", Keys[savedModels]];
	Print["Merging results..."];
	mergedModels = Merge[
		Prepend[
			(#["Data"] & /@ successResults),
			savedModels
		],
		Last
	];
	Print["Merged models: ", Keys[mergedModels]];

	(* Save merged results to canonical file *)
	Print["Saving merged models to Models.wl..."];
	If[Length[mergedModels] > 0,
		saveResult = Quiet @ Check[
			saveModels[mergedModels, modelsFile];
			Print["Updating manifest..."];
			updateModelManifest[];
			Print["Save complete."];
			True,
			False
		];

		(* Only delete temp files if save succeeded *)
		If[saveResult,
			Do[
				Quiet[DeleteFile[FileNameJoin[{resourcesDir, "Models_" <> m <> ".wl"}]]],
				{m, successModels}
			],
			(* Save failed - keep all temp files for recovery *)
			Print["WARNING: Save to canonical Models.wl failed; keeping Models_*.wl files for recovery"]
		];
	];

	(* Note about failed model files (kept for debugging) *)
	If[Length[failedModels] > 0,
		Print["Note: Keeping Models_*.wl files for failed models: ", StringRiffle[failedModels, ", "]]
	];

	(* Run moments sequentially if requested *)
	If[createMoments && Length[successModels] > 0,
		Print["Starting moments phase for ", Length[successModels], " models..."];
		Do[
			Print["  Creating moments for ", m, "..."];
			buildModels[
				"Models" -> {m},
				"CreateMoments" -> True,
				"NumKernels" -> OptionValue["NumKernels"]
			],
			{m, successModels}
		];
		Print["Moments phase complete."],
		(* else *)
		Print["Skipping moments phase (CreateMoments=", createMoments, ", successModels=", successModels, ")"]
	];

	Print["=== buildModelsParallel finished at ", DateString[], " (", Round[AbsoluteTime[] - startTime], "s total) ==="];
	Print["Returning mergedModels with keys: ", Keys[mergedModels]];
	mergedModels
];


(* Public API for PipelineMonitor UI layer *)

(* checkCatalogForUI: Check catalog changes without auto-reformatting *)
(* Handles first-run case (no manifest) by returning all enabled models as "New" *)
checkCatalogForUI[] := Module[
	{root, manifestFile, catalogModels, savedManifest, currentCatalogHash,
	 savedCatalogHash, savedModelHashes, currentModelHashes,
	 changedModels, newModels, removedModels, modelsToValidate, validationResult},

	root = findPacletRoot[];
	If[root === $Failed, Return[$Failed]];

	manifestFile = FileNameJoin[{root, "Resources", "ModelManifest.wl"}];

	(* Get catalog - must succeed for any operation *)
	catalogModels = getCatalogModels[];
	If[!AssociationQ[catalogModels], Return[$Failed]];

	(* First run: manifest doesn't exist *)
	If[!FileExistsQ[manifestFile],
		Return[<|
			"Changed" -> {},
			"New" -> Keys[Select[catalogModels, TrueQ[#["enabled"]] &]],
			"Removed" -> {},
			"Validation" -> <|"Valid" -> True, "Results" -> <||>,
				"InvalidModels" -> {}, "TotalErrors" -> 0|>,
			"FirstRun" -> True
		|>]
	];

	(* Load manifest *)
	savedManifest = loadManifestSafe[manifestFile];
	If[savedManifest === $Failed, Return[$Failed]];

	(* Quick check: compare catalog hash *)
	currentCatalogHash = getCanonicalHash[catalogModels];
	savedCatalogHash = savedManifest["CatalogHash"];

	If[currentCatalogHash === savedCatalogHash,
		(* No changes *)
		Return[<|"Changed" -> {}, "New" -> {}, "Removed" -> {},
			"Validation" -> <|"Valid" -> True|>, "FirstRun" -> False|>]
	];

	(* Catalog has changed - identify which models *)
	savedModelHashes = savedManifest["Models"];
	currentModelHashes = Map[getCanonicalHash, catalogModels];

	(* Find changed models (exist in both, hash differs) *)
	changedModels = Select[
		Keys[KeyTake[currentModelHashes, Keys[savedModelHashes]]],
		currentModelHashes[#] =!= savedModelHashes[#] &
	];

	(* Find new models (in current but not saved) *)
	newModels = Complement[Keys[currentModelHashes], Keys[savedModelHashes]];

	(* Find removed models (in saved but not current) *)
	removedModels = Complement[Keys[savedModelHashes], Keys[currentModelHashes]];

	(* Validate changed and new models - but DON'T reformat *)
	modelsToValidate = Join[changedModels, newModels];
	validationResult = If[modelsToValidate =!= {},
		Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
		FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog[
			KeyTake[catalogModels, modelsToValidate]
		],
		<|"Valid" -> True, "Results" -> <||>, "InvalidModels" -> {}, "TotalErrors" -> 0|>
	];

	<|
		"Changed" -> changedModels,
		"New" -> newModels,
		"Removed" -> removedModels,
		"Validation" -> validationResult,
		"FirstRun" -> False
	|>
];

(* getModelPipelineStatus: Return pipeline status for models *)
getModelPipelineStatus[] := getModelPipelineStatus[All];

getModelPipelineStatus[shortnames_] := Module[
	{root, catalogModels, savedModels, manifest, compiledDir, momentsDir,
	 enabledModels, modelKeys, result},

	root = findPacletRoot[];
	If[root === $Failed, Return[$Failed]];

	(* Load all required data *)
	catalogModels = getCatalogModels[];
	If[!AssociationQ[catalogModels], Return[$Failed]];

	savedModels = loadModels[FileNameJoin[{root, "Resources", "Models.wl"}]];
	manifest = loadManifestSafe[FileNameJoin[{root, "Resources", "ModelManifest.wl"}]];
	compiledDir = FileNameJoin[{root, "Resources", "CompiledFunctions"}];
	momentsDir = FileNameJoin[{root, "Resources", "MomentsLookupTables"}];

	enabledModels = Select[catalogModels, TrueQ[#["enabled"]] &];

	(* Filter by shortnames if specified *)
	modelKeys = If[shortnames === All,
		Keys[enabledModels],
		Select[Keys[enabledModels],
			MemberQ[Flatten@{shortnames}, catalogModels[#]["shortname"]] &]
	];

	(* Build status for each model *)
	result = Association @ Table[
		catalogModels[key]["shortname"] ->
			determineModelStatus[key, catalogModels, savedModels, manifest,
				compiledDir, momentsDir, False, True],
		{key, modelKeys}
	];

	result
];


End[];
EndPackage[];
