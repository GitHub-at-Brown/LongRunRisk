#!/usr/bin/env wolframscript
(* Phase 1b: Helper Validation Functions *)

Print["========================================"];
Print["Phase 1b: Helper Validation Functions"];
Print["========================================"];
Print[""];

(* Load paclet *)
Needs["FernandoDuarte`LongRunRisk`"];

(* Import models data from Phase 1 *)
If[!FileExistsQ["/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-clean-up/Tests/Integration/ToNumber/modelsData.mx"],
  Print["ERROR: modelsData.mx not found. Run phase1_setup.wls first."];
  Exit[1]
];

modelsData = Import["/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-clean-up/Tests/Integration/ToNumber/modelsData.mx"];
Print["OK Models data imported from Phase 1"];
Print[""];

(* Define robust numeric validator - checks for real, finite numbers *)
realFiniteNumberQ[x_] := Module[{n = Quiet@Check[N[x], $Failed]},
  NumberQ[n] &&
  n =!= $Failed &&
  n =!= Indeterminate &&
  n =!= ComplexInfinity &&
  n =!= Infinity && n =!= -Infinity &&
  PossibleZeroQ[Im[n]]  (* Allow tiny numeric noise in imaginary part *)
];

Print["OK Defined: realFiniteNumberQ"];

(* Validate hierarchical solution structure *)
validateHierarchicalStructure[sol_] := Module[{checks, failures = <||>},
  (* Basic type check *)
  If[!ListQ[sol],
    Return[Failure["InvalidType", <|"Message" -> "Must be a List", "Actual" -> Head[sol]|>]]
  ];

  If[!AllTrue[sol, AssociationQ],
    Return[Failure["InvalidType", <|"Message" -> "All elements must be Associations"|>]]
  ];

  (* Check required keys exist *)
  checks = <|
    "IsList" -> ListQ[sol],
    "AllAssociations" -> AllTrue[sol, AssociationQ],
    "HasRequiredKeys" -> AllTrue[sol,
      KeyExistsQ[#, "A"] && KeyExistsQ[#, "Stocks"] &&
      KeyExistsQ[#, "SignsA"] && KeyExistsQ[#, "IntervalA"] &],
    "AIsAssociation" -> AllTrue[sol, AssociationQ[#["A"]] &],
    "StocksIsAssociation" -> AllTrue[sol, AssociationQ[#["Stocks"]] &],
    "SignsAIsList" -> AllTrue[sol, ListQ[#["SignsA"]] &],
    "IntervalAIsList" -> AllTrue[sol, ListQ[#["IntervalA"]] && Length[#["IntervalA"]] == 2 &]
  |>;

  (* Check all values are real finite numbers *)
  If[!AllTrue[Flatten[Values[#["A"]] & /@ sol], realFiniteNumberQ],
    failures["NonRealValues"] = "Found non-real or infinite values in A coefficients"
  ];

  If[Length[failures] > 0,
    Failure["ValidationFailed", failures],
    Success["Validated", <|
      "NumSolutions" -> Length[sol],
      "Checks" -> checks
    |>]
  ]
];

Print["OK Defined: validateHierarchicalStructure"];

(* Validate flat rules structure *)
validateFlatRules[rules_] := Module[{checks, failures = <||>, keys},
  (* Basic format check *)
  If[!MatchQ[rules, {__Rule}],
    Return[Failure["InvalidFormat", <|"Message" -> "Must be a list of Rule objects"|>]]
  ];

  checks = <|
    "IsListOfRules" -> MatchQ[rules, {___Rule}],
    "HasACoeffs" -> AnyTrue[rules, MatchQ[#[[1]], A[_]] &],
    "AllRealOrSymbolic" -> !AnyTrue[rules[[All, 2]], # === Indeterminate || # === ComplexInfinity &],
    "NoFailure" -> !FailureQ[rules]
  |>;

  (* Check for duplicate keys *)
  keys = First /@ rules;
  If[Length[keys] =!= Length[DeleteDuplicates[keys]],
    failures["DuplicateKeys"] = Select[Tally[keys], Last[#] > 1 &]
  ];

  (* Check all RHS are real finite numbers or valid symbolic expressions *)
  (* Some rules have symbolic RHS like theta -> (1-gamma)/(1-psi^(-1)) which is valid *)
  nonNumericRHS = Select[rules[[All, 2]], !realFiniteNumberQ[#] &];
  If[Length[nonNumericRHS] > 0,
    (* Check if they're at least not Indeterminate/ComplexInfinity *)
    badValues = Select[nonNumericRHS, # === Indeterminate || # === ComplexInfinity &];
    If[Length[badValues] > 0,
      failures["BadValues"] = "Found Indeterminate or ComplexInfinity values"
    ]
  ];

  If[Length[failures] > 0,
    Failure["ValidationFailed", failures],
    Success["ValidationFailed", <|
      "NumRules" -> Length[rules],
      "Checks" -> checks
    |>]
  ]
];

Print["OK Defined: validateFlatRules"];
Print[""];

(* Test the helpers with actual data *)
Print["Testing helpers with BKY model..."];
testModel = modelsData["BKY"];
testRules = ToNum["Rules", testModel];
testHier = ToNum["Rules", testModel, "ReturnAllSolutions" -> True];

Print["  ToNum[\"Rules\", BKY]: ", Head[testRules], " with ", Length[testRules], " elements"];
Print["  ToNum[\"Rules\", BKY, \"ReturnAllSolutions\"->True]: ", Head[testHier], " with ", Length[testHier], " elements"];
Print[""];

flatResult = validateFlatRules[testRules];
hierResult = validateHierarchicalStructure[testHier];

Print["Validation Results:"];
Print["  Flat rules: ", If[!FailureQ[flatResult], "OK PASS", "FAIL FAIL - " <> ToString[flatResult]]];
Print["  Hierarchical: ", If[!FailureQ[hierResult], "OK PASS", "FAIL FAIL - " <> ToString[hierResult]]];
Print[""];

(* Export helper functions for use by subsequent phases *)
Export["/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-clean-up/Tests/Integration/ToNumber/helpers.mx",
  <|
    "realFiniteNumberQ" -> realFiniteNumberQ,
    "validateHierarchicalStructure" -> validateHierarchicalStructure,
    "validateFlatRules" -> validateFlatRules
  |>
];

Print["========================================"];
Print["Phase 1b: COMPLETE OK"];
Print["========================================"];
Print[""];
Print["Helper functions exported to helpers.mx for Phase 2"];
