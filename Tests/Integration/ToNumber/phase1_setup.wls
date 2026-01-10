#!/usr/bin/env wolframscript
(* Phase 1: Environment Setup & Model Loading *)

Print["========================================"];
Print["Phase 1: Environment Setup & Model Loading"];
Print["========================================"];
Print[""];

(* Load paclet *)
Needs["FernandoDuarte`LongRunRisk`"];

(* Load models using repository-standard Get@Get pattern *)
Needs["PacletizedResourceFunctions`"];
modelsData = Get@Get@"FernandoDuarte/LongRunRisk/Models.wl";

Print["OK Models loaded using Get@Get pattern"];
Print[""];

(* Define model names *)
modelNames = {"BY", "BKY", "NRC", "DES", "NRCStochVol"};

(* Validate all models exist *)
missingModels = Select[modelNames, !KeyExistsQ[modelsData, #] &];
If[Length[missingModels] > 0,
  Print["WARNING WARNING: Missing models: ", missingModels];
  Exit[1],
  Print["OK All 5 models found in dataset"]
];
Print[""];

(* Extract metadata for each model *)
modelMetadata = Association @ Map[
  # -> <|
    "numStocks" -> modelsData[#]["numStocks"],
    "numStates" -> Length[modelsData[#]["stateVars"]],
    "hasLongRunRisk" -> MemberQ[{"BY", "BKY", "DES"}, #],
    "description" -> modelsData[#]["name"]
  |> &,
  modelNames
];

Print["OK Model metadata extracted"];
Print[""];
Print["Metadata Summary:"];
Print[TableForm[
  {#,
   modelMetadata[#]["numStocks"],
   modelMetadata[#]["numStates"],
   If[modelMetadata[#]["hasLongRunRisk"], "Yes", "No"],
   modelMetadata[#]["description"]
  } & /@ modelNames,
  TableHeadings -> {None, {"Model", "Stocks", "States", "LRR", "Description"}}
]];

Print[""];
Print["========================================"];
Print["Phase 1: COMPLETE"];
Print["========================================"];

(* Export modelsData for use by subsequent phases *)
Export["/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-clean-up/Tests/Integration/ToNumber/modelsData.mx", modelsData];
Print[""];
Print["Models data exported to modelsData.mx for Phase 1b"];
