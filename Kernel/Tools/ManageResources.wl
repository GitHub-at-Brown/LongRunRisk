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

Begin["`Private`"];

Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];

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
  Quiet[CreateDirectory[DirectoryName[manifestFile]], CreateDirectory::filex];

  (* Get catalog *)
  catalogModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;
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

  (* Get catalog *)
  catalogModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;
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

  <|
    "Changed" -> changedModels,
    "New" -> newModels,
    "Removed" -> removedModels,
    "Validation" -> validationResult
  |>
];

End[];
EndPackage[];
