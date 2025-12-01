(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];

updateModelManifest::usage = "updateModelManifest[] generates and saves the ModelManifest.wl file.";
updateModelManifest::noroot = "Could not locate paclet root directory.";
updateModelManifest::nocat = "Catalog models not found or invalid.";
updateModelManifest::versionmismatch = "PacletInfo.wl version `1` differs from installed paclet version `2`; using PacletInfo.wl version.";

checkCatalogChanges::usage = "checkCatalogChanges[] compares the current Catalog to the saved manifest and reports which models have changed.";
checkCatalogChanges::noroot = "Could not locate paclet root directory.";
checkCatalogChanges::nocat = "Catalog models not found or invalid.";
checkCatalogChanges::nomanifest = "ModelManifest.wl not found. Run updateModelManifest[] first.";
checkCatalogChanges::changed = "The following models have changed and need updating: `1`.";
checkCatalogChanges::newmodels = "New models added to catalog: `1`.";
checkCatalogChanges::removed = "Models removed from catalog: `1`.";

reformatCatalog::usage = "reformatCatalog[] reformats the models section of Catalog.wl using standard formatting, preserving modelsExtraInfo unchanged.";
reformatCatalog::noroot = "Could not locate paclet root directory.";
reformatCatalog::nocat = "Could not locate Catalog.wl or parse its structure.";
reformatCatalog::success = "Catalog.wl reformatted successfully.";

Begin["`Private`"];

(* Live catalog loading - tracks file modification time *)
$catalogFile = None;
$catalogMTime = None;

getCatalogModels[] := Module[{mtime},
  (* Find file path once *)
  If[!StringQ[$catalogFile],
    $catalogFile = FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"]
  ];
  If[!StringQ[$catalogFile], Return[$Failed]];

  (* Check modification time *)
  mtime = FileDate[$catalogFile, "Modification"];

  If[mtime =!= $catalogMTime,
    Get["FernandoDuarte`LongRunRisk`Model`Catalog`"];
    $catalogMTime = mtime
  ];

  FernandoDuarte`LongRunRisk`Model`Catalog`models
];

(* Simple root finder - uses FindFile on THIS package *)
findPacletRoot[] := Module[{file, root},
  file = FindFile["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];
  If[!StringQ[file], Return[$Failed]];
  root = DirectoryName[file, 3];  (* Kernel/Tools/file.wl -> root *)
  If[FileExistsQ[FileNameJoin[{root, "PacletInfo.wl"}]], root, $Failed]
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

getCanonicalHash[expr_] := Hash[ExportString[canonicalize[expr], "WL"], "SHA256", "HexString"];

loadManifestSafe[file_] := Module[{held, data},
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

updateModelManifest[] := Module[
  {root, manifestFile, catalogModels, catalogHash, modelHashes, version, manifestData},

  (* Find root *)
  root = findPacletRoot[];
  If[root === $Failed, Message[updateModelManifest::noroot]; Return[$Failed]];

  (* Build manifest path *)
  manifestFile = FileNameJoin[{root, "Resources", "ModelManifest.wl"}];
  Quiet[CreateDirectory[DirectoryName[manifestFile]], {CreateDirectory::filex, CreateDirectory::eexist}];

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

  (* Auto-reformat if there were changes *)
  If[changedModels =!= {} || newModels =!= {},
    reformatCatalog[]
  ];

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
boxToString[x_] := ToString[x, InputForm];

(* Main converter: tries front end first, falls back to manual *)
boxDataToText[boxData_] := Module[{tempFile, result},
  (* Try front end approach if available *)
  If[$FrontEnd =!= Null,
    tempFile = FileNameJoin[{$TemporaryDirectory, CreateUUID[] <> ".wl"}];
    result = convertWithFrontEnd[boxData, tempFile];
    If[result =!= $Failed,
      Quiet[DeleteFile[tempFile]];
      Return[result]
    ]
  ];
  (* Fallback to manual boxToString *)
  boxToString[boxData]
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
   formattedBoxData, formattedText, newContent},

  (* Find root and catalog file *)
  root = findPacletRoot[];
  If[root === $Failed, Message[reformatCatalog::noroot]; Return[$Failed]];

  catalogFile = FileNameJoin[{root, "Kernel", "Model", "Catalog.wl"}];
  If[!FileExistsQ[catalogFile], Message[reformatCatalog::nocat]; Return[$Failed]];

  (* Load NiceOutput *)
  Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];

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

  (* Convert BoxData to plain text (tries front end first, falls back to manual) *)
  formattedText = boxDataToText[formattedBoxData];

  (* Reconstruct file: preserve header + new models + preserve footer *)
  newContent = StringJoin[
    StringTake[sections["Content"], sections["ModelsStart"] - 1],
    formattedText,
    StringDrop[sections["Content"], sections["ModelsEnd"]]
  ];

  (* Write back *)
  Export[catalogFile, newContent, "Text"];

  (* Reset cache to force reload on next access *)
  $catalogMTime = None;

  Message[reformatCatalog::success];
  catalogFile
];

End[];
EndPackage[];
