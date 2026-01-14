(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];


(* ::Subsection:: *)
(*Public symbols*)


validateModel
validateCatalog


(* ::Subsubsection:: *)
(*Usage*)


validateModel::usage = "validateModel[model] validates a single model Association against the schema. Returns a ValidationResult Association.";

validateCatalog::usage = "validateCatalog[catalog] validates all models in a catalog Association. Returns a CatalogValidationResult.";


(* ::Subsubsection:: *)
(*Messages*)


validateModel::missingkey = "Model \"`1`\": Missing required key \"`2`\".";
validateModel::wrongtype = "Model \"`1`\": Key \"`2`\" expected `3`, got `4`.";
validateModel::badstatevar = "Model \"`1`\": Invalid state variable `2`. Expected expression with [t] dependency.";
validateModel::badparam = "Model \"`1`\": Parameter `2` has non-numeric value `3`.";
validateModel::duplicateparam = "Model \"`1`\": Duplicate parameter `2`.";
validateModel::missingstockparam = "Model \"`1`\": Stock `2` is incomplete. Missing: `3`.";
validateModel::notrule = "Model \"`1`\": Parameter entry `2` is not a Rule.";
validateModel::badparamname = "Model \"`1`\": Invalid parameter name `2`.";
validateModel::extraparam = "Model \"`1`\": Extra parameter(s) not in $parameters: `2`. Valid parameters: `3`.";
validateModel::missingparam = "Model \"`1`\": Missing parameter(s) from $parameters: `2`. Valid parameters: `3`.";
validateModel::badindexedparam = "Model \"`1`\": Indexed parameter `2` is not a valid dividend growth parameter. Valid dividend growth parameters: `3`.";
validateModel::indexnotpositive = "Model \"`1`\": Parameter `2` has non-positive index.";
validateModel::indexgap = "Model \"`1`\": Stock indices are not sequential starting from 1. Found indices: `2`.";
validateModel::badassumption = "Model \"`1`\": Parameter `2` = `3` violates assumption `4`.";
validateModel::badstatevarsymbol = "Model \"`1`\": State variable `2` contains invalid symbol(s): `3`.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];
Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];


(* ::Subsection:: *)
(*Schema definition*)


(* Schema definition using patterns *)

(* Required keys with their expected type patterns *)
$requiredKeys = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"};

(* Type patterns for each key (used with MatchQ) *)
$keyTypePatterns = <|
  "name" -> _String,
  "shortname" -> _String,
  "bibRef" -> _String,
  "desc" -> _String,
  "enabled" -> True | False,
  "stateVars" -> _List,
  "parameters" -> _List
|>;

(* Human-readable type names for error messages *)
$keyTypeNames = <|
  "name" -> "String",
  "shortname" -> "String",
  "bibRef" -> "String",
  "desc" -> "String",
  "enabled" -> "True or False",
  "stateVars" -> "List",
  "parameters" -> "List"
|>;

(* Get expected indexed parameter names from paramList["Real dividend growth"] *)
(* Returns list of strings like {"mud", "rhodx", ...} for context-independent comparison *)
getExpectedIndexedParamNames[] := Module[{dividendParams},
  dividendParams = FernandoDuarte`LongRunRisk`Model`Parameters`Private`paramList["Real dividend growth"];
  SymbolName[Head[#]] & /@ dividendParams
];

(* Get parameter assumptions as a list of individual conditions *)
(* Returns list like {delta > 0, delta < 1, psi > 0, ...} *)
getParamAssumptions[] := List @@ FernandoDuarte`LongRunRisk`Model`Parameters`Private`paramAssumptions;

(* Extract the parameter name from an assumption condition *)
(* e.g., delta > 0 -> "delta", rhox < 1 -> "rhox" *)
getAssumptionParamName[cond_] := Module[{syms},
  syms = Cases[cond, s_Symbol :> SymbolName[s], {0, Infinity}];
  (* Filter out comparison operators and numbers - take first symbol name *)
  SelectFirst[syms, !MemberQ[{"Greater", "Less", "GreaterEqual", "LessEqual", "Or", "And"}, #] &, None]
];

(* Get the set of allowed symbol names in state variables *)
(* Returns: {exo var base names, shock name, parameters, "t"} *)
getAllowedStateVarSymbols[] := Module[{exoBaseNames, shockName, paramNames},
  (* Exogenous vars: xeq -> x, pieq -> pi, etc. *)
  exoBaseNames = StringReplace[#, "eq" -> ""] & /@
    FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVarsNoStocks;
  (* Shock name *)
  shockName = First@FernandoDuarte`LongRunRisk`Model`Shocks`$shocks;
  (* Parameter names *)
  paramNames = FernandoDuarte`LongRunRisk`Model`Parameters`$parameters;
  (* Combine all with time variable "t" *)
  Union[exoBaseNames, {shockName}, paramNames, {"t"}]
];

(* Built-in math operators that should be ignored in state variable validation *)
$builtInMathSymbols = {"Plus", "Times", "Power", "Sqrt", "Exp", "Log", "Sin", "Cos", "Tan",
  "Rational", "Integer", "Real", "Complex", "List", "Rule", "Slot", "Function"};

(* Extract all symbol names from a state variable expression *)
(* Includes both pure symbols and function heads, excluding built-in math operators *)
(* Returns list of unique symbol name strings *)
extractStateVarSymbols[expr_] := Module[{pureSymbols, headNames, allNames},
  (* Extract pure symbols (atoms) *)
  pureSymbols = Cases[expr, s_Symbol :> SymbolName[s], {0, Infinity}];
  (* Extract function heads - h[...] -> SymbolName[h] for symbol heads *)
  headNames = Cases[expr, h_Symbol[___] :> SymbolName[h], {0, Infinity}];
  allNames = Union[pureSymbols, headNames];
  (* Filter out built-in math symbols *)
  Complement[allNames, $builtInMathSymbols]
];


(* ::Subsection:: *)
(*Helper functions*)


(* Check if an expression contains t-dependency like x[t], sx[-1+t], etc. *)
(* Match any symbol named "t" regardless of context *)
containsTimeDependency[expr_] := !FreeQ[expr, _[_?(Not@FreeQ[#, _Symbol?(SymbolName[#] === "t" &)] &)]];

(* Check if a value is numeric or evaluates to numeric with placeholder substitutions *)
(* Match any symbol by name regardless of context *)
(* This allows symbolic expressions that reference other parameters *)
numericValueQ[val_] := Module[{testVal, placeholders},
  If[NumericQ[val], Return[True]];
  (* Common symbolic parameter placeholders for most use cases *)
  placeholders = {
    "psi" -> 1.5, "gamma" -> 10, "delta" -> 0.99, "theta" -> -27,
    "mupbar" -> 0.002, "mup" -> 0.002, "muc" -> 0.0015,
    "Esx" -> 0.001, "Esc" -> 0.001, "Esp" -> 0.001, "Esg" -> 0.001,
    "rhox" -> 0.98, "rhop" -> 0.9, "vc" -> 0.99, "vx" -> 0.99, "vp" -> 0.99
  };
  (* Replace any symbol whose name matches a placeholder *)
  testVal = val /. (s_Symbol :> With[{name = SymbolName[s]},
    Lookup[placeholders, name, s]
  ]);
  NumberQ[N[testVal]]
];

(* Check if a parameter name is valid: Symbol or Symbol[Integer] *)
validParamNameQ[name_] := MatchQ[name, _Symbol | _Symbol[_Integer]];

(* Strip index from parameter name: mud[1] -> "mud", delta -> "delta" *)
(* Returns string name for context-independent comparison *)
stripParamIndex[sym_Symbol] := SymbolName[sym];
stripParamIndex[sym_Symbol[_Integer]] := SymbolName[sym];
stripParamIndex[other_] := ToString[other];

(* Get canonical parameter names from $parameters as strings *)
(* $parameters is already a list of strings from Names[] *)
getExpectedParamNames[] := FernandoDuarte`LongRunRisk`Model`Parameters`$parameters;


(* ::Subsection:: *)
(*Validation functions*)


(* Check required keys and types against schema *)
validateStructure[model_, modelName_] := Flatten[Last[Reap[
  Module[{missingKeys, presentKeys},

    (* Find missing required keys using Complement *)
    missingKeys = Complement[$requiredKeys, Keys[model]];
    Scan[
      Sow[<|
        "Type" -> "MissingKey",
        "Model" -> modelName,
        "Key" -> #,
        "Message" -> validateModel::missingkey
      |>] &,
      missingKeys
    ];

    (* Check types of present keys using MatchQ with patterns *)
    presentKeys = Intersection[$requiredKeys, Keys[model]];
    Scan[
      Function[key,
        If[!MatchQ[model[key], $keyTypePatterns[key]],
          Sow[<|
            "Type" -> "WrongType",
            "Model" -> modelName,
            "Key" -> key,
            "Expected" -> $keyTypeNames[key],
            "Got" -> ToString[Head[model[key]]],
            "Message" -> validateModel::wrongtype
          |>]
        ]
      ],
      presentKeys
    ]
  ]
], {}]];

(* Validate stateVars list *)
validateStateVars[stateVars_, modelName_] := Flatten[Last[Reap[
  Module[{badStateVars},

    (* Early return for non-List *)
    If[!MatchQ[stateVars, _List], Return[{}]];

    (* Check for empty list *)
    If[MatchQ[stateVars, {}],
      Sow[<|
        "Type" -> "WrongType",
        "Model" -> modelName,
        "Key" -> "stateVars",
        "Expected" -> "non-empty List",
        "Got" -> "empty List",
        "Message" -> validateModel::wrongtype
      |>];
      Return[{}]
    ];

    (* Find state variables missing [t] dependency using Select *)
    badStateVars = Select[stateVars, !containsTimeDependency[#] &];
    Scan[
      Sow[<|
        "Type" -> "BadStateVar",
        "Model" -> modelName,
        "Key" -> #,
        "Message" -> validateModel::badstatevar
      |>] &,
      badStateVars
    ];

    (* Check that each state variable only contains allowed symbols *)
    Module[{allowedSymbols, svSymbols, invalidSymbols},
      allowedSymbols = getAllowedStateVarSymbols[];
      Scan[
        Function[sv,
          svSymbols = extractStateVarSymbols[sv];
          invalidSymbols = Complement[svSymbols, allowedSymbols];
          If[invalidSymbols =!= {},
            Sow[<|
              "Type" -> "BadStateVarSymbol",
              "Model" -> modelName,
              "StateVar" -> sv,
              "InvalidSymbols" -> invalidSymbols,
              "Message" -> validateModel::badstatevarsymbol
            |>]
          ]
        ],
        stateVars
      ]
    ]
  ]
], {}]];

(* Validate parameters list *)
validateParameters[params_, modelName_] := Flatten[Last[Reap[
  Module[{nonRules, paramRules, lhsNames, duplicates, badNames, badValues},

    (* Early return for non-List *)
    If[!MatchQ[params, _List], Return[{}]];

    (* Check for empty list *)
    If[MatchQ[params, {}],
      Sow[<|
        "Type" -> "WrongType",
        "Model" -> modelName,
        "Key" -> "parameters",
        "Expected" -> "non-empty List",
        "Got" -> "empty List",
        "Message" -> validateModel::wrongtype
      |>];
      Return[{}]
    ];

    (* Find non-Rule entries using Select with Except pattern *)
    nonRules = Select[params, !MatchQ[#, _Rule] &];
    Scan[
      Sow[<|
        "Type" -> "NotRule",
        "Model" -> modelName,
        "Key" -> #,
        "Message" -> validateModel::notrule
      |>] &,
      nonRules
    ];

    (* Extract valid rules for further validation *)
    paramRules = Cases[params, _Rule];
    lhsNames = First /@ paramRules;

    (* Find duplicates using GroupBy and Select *)
    duplicates = Keys[Select[Counts[lhsNames], # > 1 &]];
    Scan[
      Sow[<|
        "Type" -> "DuplicateParam",
        "Model" -> modelName,
        "Key" -> #,
        "Message" -> validateModel::duplicateparam
      |>] &,
      duplicates
    ];

    (* Find invalid parameter names using Select *)
    badNames = Select[paramRules, !validParamNameQ[First[#]] &];
    Scan[
      Sow[<|
        "Type" -> "BadParamName",
        "Model" -> modelName,
        "Key" -> First[#],
        "Message" -> validateModel::badparamname
      |>] &,
      badNames
    ];

    (* Find non-numeric values using Select *)
    badValues = Select[paramRules, !numericValueQ[Last[#]] &];
    Scan[
      Function[rule,
        Sow[<|
          "Type" -> "BadParam",
          "Model" -> modelName,
          "Key" -> First[rule],
          "Value" -> Last[rule],
          "Message" -> validateModel::badparam
        |>]
      ],
      badValues
    ];

    (* Validate indexed parameters (dividend growth params like mud[1], rhodx[2], etc.) *)
    Module[{allIndexedRules, expectedIndexedNames, badIndexedParams, nonPositiveIndices,
            stockIndices, presentForStock, missingForStock, indexedParams},

      (* Get all indexed parameter rules: sym[idx] -> val where idx is Integer *)
      (* Note: Cases with _Symbol[_Integer] doesn't work as expected, so use Select with MatchQ *)
      allIndexedRules = Select[paramRules, MatchQ[First[#], _Symbol[_Integer]] &];

      If[allIndexedRules =!= {},
        expectedIndexedNames = getExpectedIndexedParamNames[];

        (* Check that indexed param names are valid dividend growth params *)
        badIndexedParams = Select[allIndexedRules,
          !MemberQ[expectedIndexedNames, SymbolName[Head[First[#]]]] &];
        Scan[
          Function[rule,
            Sow[<|
              "Type" -> "BadIndexedParam",
              "Model" -> modelName,
              "Key" -> First[rule],
              "ValidIndexedParams" -> expectedIndexedNames,
              "Message" -> validateModel::badindexedparam
            |>]
          ],
          badIndexedParams
        ];

        (* Check that all indices are positive *)
        nonPositiveIndices = Select[allIndexedRules,
          First[#][[1]] <= 0 &];
        Scan[
          Function[rule,
            Sow[<|
              "Type" -> "IndexNotPositive",
              "Model" -> modelName,
              "Key" -> First[rule],
              "Message" -> validateModel::indexnotpositive
            |>]
          ],
          nonPositiveIndices
        ];

        (* Get all indices used and check they are sequential starting from 1 *)
        stockIndices = Union[First[#][[1]] & /@ allIndexedRules];
        If[stockIndices =!= {} && stockIndices =!= Range[Max[stockIndices]],
          Sow[<|
            "Type" -> "IndexGap",
            "Model" -> modelName,
            "Indices" -> stockIndices,
            "Message" -> validateModel::indexgap
          |>]
        ];

        (* For each valid index, check all expected indexed params are present *)
        (* Extract {paramName, index} pairs from indexed rules *)
        indexedParams = Map[
          Function[rule, {SymbolName[Head[First[rule]]], First[rule][[1]]}],
          allIndexedRules
        ];
        Scan[
          Function[idx,
            presentForStock = Select[indexedParams, #[[2]] === idx &][[All, 1]];
            missingForStock = Complement[expectedIndexedNames, presentForStock];
            If[missingForStock =!= {},
              Sow[<|
                "Type" -> "MissingStockParam",
                "Model" -> modelName,
                "Key" -> idx,
                "Missing" -> missingForStock,
                "Message" -> validateModel::missingstockparam
              |>]
            ]
          ],
          stockIndices
        ]
      ]
    ];

    (* Check parameter set matches $parameters exactly *)
    Module[{modelParamNames, expectedParamNames, extraParams, missingParams},
      (* Get unique parameter names from model, stripping indices *)
      modelParamNames = Union[stripParamIndex /@ lhsNames];
      expectedParamNames = getExpectedParamNames[];

      (* Find parameters in model but not in $parameters *)
      extraParams = Complement[modelParamNames, expectedParamNames];
      If[extraParams =!= {},
        Sow[<|
          "Type" -> "ExtraParam",
          "Model" -> modelName,
          "Extra" -> extraParams,
          "Expected" -> expectedParamNames,
          "Message" -> validateModel::extraparam
        |>]
      ];

      (* Find parameters in $parameters but not in model *)
      missingParams = Complement[expectedParamNames, modelParamNames];
      If[missingParams =!= {},
        Sow[<|
          "Type" -> "MissingParam",
          "Model" -> modelName,
          "Missing" -> missingParams,
          "Expected" -> expectedParamNames,
          "Message" -> validateModel::missingparam
        |>]
      ]
    ];

    (* Validate parameter values against paramAssumptions *)
    Module[{assumptions, paramValues, paramName, paramValue, testResult},
      assumptions = getParamAssumptions[];
      (* Build association of parameter name -> value for substitution *)
      (* Use context-independent name matching, strip index from indexed params *)
      paramValues = Association[
        (stripParamIndex[First[#]] -> Last[#]) & /@ paramRules
      ];

      (* Check each assumption *)
      Scan[
        Function[assumption,
          paramName = getAssumptionParamName[assumption];
          If[paramName =!= None && KeyExistsQ[paramValues, paramName],
            paramValue = paramValues[paramName];
            (* Only check if value is numeric *)
            If[NumericQ[paramValue],
              (* Substitute the value into the assumption and evaluate *)
              testResult = assumption /. (s_Symbol :> With[{name = SymbolName[s]},
                If[KeyExistsQ[paramValues, name], paramValues[name], s]
              ]);
              If[TrueQ[testResult],
                Null, (* Assumption satisfied *)
                Sow[<|
                  "Type" -> "BadAssumption",
                  "Model" -> modelName,
                  "Key" -> paramName,
                  "Value" -> paramValue,
                  "Assumption" -> assumption,
                  "Message" -> validateModel::badassumption
                |>]
              ]
            ]
          ]
        ],
        assumptions
      ]
    ]
  ]
], {}]];


(* ::Subsection:: *)
(*Message issuing*)


issueMessage[error_Association] := Switch[error["Type"],
  "MissingKey",
    Message[validateModel::missingkey, error["Model"], error["Key"]],
  "WrongType",
    Message[validateModel::wrongtype, error["Model"], error["Key"], error["Expected"], error["Got"]],
  "BadStateVar",
    Message[validateModel::badstatevar, error["Model"], error["Key"]],
  "BadParam",
    Message[validateModel::badparam, error["Model"], error["Key"], error["Value"]],
  "DuplicateParam",
    Message[validateModel::duplicateparam, error["Model"], error["Key"]],
  "MissingStockParam",
    Message[validateModel::missingstockparam, error["Model"], error["Key"], StringRiffle[ToString /@ error["Missing"], ", "]],
  "NotRule",
    Message[validateModel::notrule, error["Model"], error["Key"]],
  "BadParamName",
    Message[validateModel::badparamname, error["Model"], error["Key"]],
  "ExtraParam",
    Message[validateModel::extraparam, error["Model"], StringRiffle[error["Extra"], ", "], StringRiffle[error["Expected"], ", "]],
  "MissingParam",
    Message[validateModel::missingparam, error["Model"], StringRiffle[error["Missing"], ", "], StringRiffle[error["Expected"], ", "]],
  "BadIndexedParam",
    Message[validateModel::badindexedparam, error["Model"], error["Key"], StringRiffle[error["ValidIndexedParams"], ", "]],
  "IndexNotPositive",
    Message[validateModel::indexnotpositive, error["Model"], error["Key"]],
  "IndexGap",
    Message[validateModel::indexgap, error["Model"], StringRiffle[ToString /@ error["Indices"], ", "]],
  "BadAssumption",
    Message[validateModel::badassumption, error["Model"], error["Key"], error["Value"], error["Assumption"]],
  "BadStateVarSymbol",
    Message[validateModel::badstatevarsymbol, error["Model"], error["StateVar"], StringRiffle[error["InvalidSymbols"], ", "]],
  _,
    Null
];


(* ::Subsection:: *)
(*validateModel*)


validateModel[model_Association] := Module[
  {errors, modelName, structureErrors, stateVarsErrors, paramsErrors},

  modelName = Lookup[model, "shortname", Lookup[model, "name", "<unnamed>"]];

  (* Validate structure *)
  structureErrors = validateStructure[model, modelName];

  (* Validate stateVars if present and is a List *)
  stateVarsErrors = If[KeyExistsQ[model, "stateVars"] && ListQ[model["stateVars"]],
    validateStateVars[model["stateVars"], modelName],
    {}
  ];

  (* Validate parameters if present and is a List *)
  paramsErrors = If[KeyExistsQ[model, "parameters"] && ListQ[model["parameters"]],
    validateParameters[model["parameters"], modelName],
    {}
  ];

  errors = Join[structureErrors, stateVarsErrors, paramsErrors];

  (* Issue all messages *)
  Scan[issueMessage, errors];

  <|
    "Valid" -> (errors === {}),
    "ModelName" -> modelName,
    "Errors" -> errors,
    "ErrorCount" -> Length[errors]
  |>
];

validateModel[_] := <|
  "Valid" -> False,
  "ModelName" -> "<invalid>",
  "Errors" -> {<|"Type" -> "NotAssociation", "Message" -> "Model must be an Association"|>},
  "ErrorCount" -> 1
|>;


(* ::Subsection:: *)
(*validateCatalog*)


validateCatalog[catalog_Association] := Module[
  {results, invalidModels, totalErrors},

  results = KeyValueMap[
    Function[{key, model},
      key -> validateModel[model]
    ],
    catalog
  ] // Association;

  invalidModels = Keys[Select[results, Not[#["Valid"]] &]];
  totalErrors = Total[#["ErrorCount"] & /@ Values[results]];

  <|
    "Valid" -> (invalidModels === {}),
    "Results" -> results,
    "InvalidModels" -> invalidModels,
    "TotalErrors" -> totalErrors
  |>
];

validateCatalog[_] := <|
  "Valid" -> False,
  "Results" -> <||>,
  "InvalidModels" -> {},
  "TotalErrors" -> 1
|>;


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
