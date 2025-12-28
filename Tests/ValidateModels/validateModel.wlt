BeginTestSection["validateModel Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ValidateModels`validateModel`"]

(* --- merged from: validateModel_test1.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  $containsTimeDep[x[t]],
  True,
  TestID -> "containsTimeDep-simple-x[t]@@Tests/ValidateModels/validateModel.wlt:28,1-32,2"
]

(* --- merged from: validateModel_test2.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  $containsTimeDep[sx[-1 + t]],
  True,
  TestID -> "containsTimeDep-lagged-sx[-1+t]@@Tests/ValidateModels/validateModel.wlt:58,1-62,2"
]

(* --- merged from: validateModel_test3.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  $containsTimeDep[-mup + pi[t]],
  True,
  TestID -> "containsTimeDep-expression-with-t@@Tests/ValidateModels/validateModel.wlt:88,1-92,2"
]

(* --- merged from: validateModel_test4.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  $containsTimeDep[x],
  False,
  TestID -> "containsTimeDep-symbol-without-t@@Tests/ValidateModels/validateModel.wlt:118,1-122,2"
]

(* --- merged from: validateModel_test5.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  $containsTimeDep[42],
  False,
  TestID -> "containsTimeDep-number@@Tests/ValidateModels/validateModel.wlt:148,1-152,2"
]

(* --- merged from: validateModel_test6.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  $numericValueQ[0.998],
  True,
  TestID -> "numericValueQ-decimal@@Tests/ValidateModels/validateModel.wlt:178,1-182,2"
]

(* --- merged from: validateModel_test7.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  $numericValueQ[10],
  True,
  TestID -> "numericValueQ-integer@@Tests/ValidateModels/validateModel.wlt:208,1-212,2"
]

(* --- merged from: validateModel_test8.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  $numericValueQ[(1 - gamma)/(1 - psi^(-1))],
  True,
  TestID -> "numericValueQ-symbolic-expression@@Tests/ValidateModels/validateModel.wlt:238,1-242,2"
]

(* --- merged from: validateModel_test9.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  $numericValueQ["not a number"],
  False,
  TestID -> "numericValueQ-string-false@@Tests/ValidateModels/validateModel.wlt:268,1-272,2"
]

(* --- merged from: validateModel_test10.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  $validParamNameQ[delta],
  True,
  TestID -> "validParamNameQ-symbol@@Tests/ValidateModels/validateModel.wlt:298,1-302,2"
]

(* --- merged from: validateModel_test11.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  $validParamNameQ[mud[1]],
  True,
  TestID -> "validParamNameQ-indexed-symbol@@Tests/ValidateModels/validateModel.wlt:328,1-332,2"
]

(* --- merged from: validateModel_test12.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  $validParamNameQ["delta"],
  False,
  TestID -> "validParamNameQ-string-false@@Tests/ValidateModels/validateModel.wlt:358,1-362,2"
]

(* --- merged from: validateModel_test13.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  $validateModel[$realModels["BY"]]["Valid"],
  True,
  TestID -> "valid-model-passes-BY@@Tests/ValidateModels/validateModel.wlt:388,1-392,2"
]

(* --- merged from: validateModel_test14.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{result},
    result = $validateModel[$realModels["BKY"]];
    result["Valid"] && result["ErrorCount"] === 0
  ],
  True,
  TestID -> "valid-model-passes-BKY@@Tests/ValidateModels/validateModel.wlt:418,1-425,2"
]

(* --- merged from: validateModel_test15.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Test that all catalog models pass validation *)
  $validateCatalog[$realModels]["Valid"],
  True,
  TestID -> "all-catalog-models-valid@@Tests/ValidateModels/validateModel.wlt:451,1-456,2"
]

(* --- merged from: validateModel_test16.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{model, result},
    model = <|
      "shortname" -> "TM",
      "bibRef" -> "Test2025",
      "desc" -> "Missing name",
      "stateVars" -> {x[t]},
      "parameters" -> {delta -> 0.998}
    |>;
    result = Quiet[$validateModel[model]];
    (* Check that MissingKey error is present *)
    MemberQ[result["Errors"][[All, "Type"]], "MissingKey"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "missing-name-key-fails@@Tests/ValidateModels/validateModel.wlt:482,1-498,2"
]

(* --- merged from: validateModel_test17.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{model, result, missingKeyCount},
    model = <|
      "name" -> "Test",
      (* Missing shortname, bibRef, desc *)
      "stateVars" -> {x[t]},
      "parameters" -> {delta -> 0.998}
    |>;
    result = Quiet[$validateModel[model]];
    missingKeyCount = Count[result["Errors"][[All, "Type"]], "MissingKey"];
    missingKeyCount >= 3
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "multiple-missing-keys-accumulated@@Tests/ValidateModels/validateModel.wlt:524,1-539,2"
]

(* --- merged from: validateModel_test18.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{model, result},
    model = <|
      "name" -> 42,  (* Should be String *)
      "shortname" -> "TM",
      "bibRef" -> "Test2025",
      "desc" -> "Test",
      "stateVars" -> {x[t]},
      "parameters" -> {delta -> 0.998}
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "WrongType"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "wrong-type-name-integer@@Tests/ValidateModels/validateModel.wlt:565,1-581,2"
]

(* --- merged from: validateModel_test19.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{model, result},
    model = <|
      "name" -> "Test",
      "shortname" -> "TM",
      "bibRef" -> "Test2025",
      "desc" -> "Test",
      "stateVars" -> "not a list",  (* Should be List *)
      "parameters" -> {delta -> 0.998}
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "WrongType"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "wrong-type-stateVars-string@@Tests/ValidateModels/validateModel.wlt:607,1-623,2"
]

(* --- merged from: validateModel_test20.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{model, result},
    model = <|
      "name" -> "Test",
      "shortname" -> "TM",
      "bibRef" -> "Test2025",
      "desc" -> "Test",
      "stateVars" -> {x, y},  (* Missing [t] dependency *)
      "parameters" -> {delta -> 0.998}
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "BadStateVar"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "stateVars-missing-t-dependency@@Tests/ValidateModels/validateModel.wlt:649,1-665,2"
]

(* --- merged from: validateModel_test21.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{model, result},
    model = <|
      "name" -> "Test",
      "shortname" -> "TM",
      "bibRef" -> "Test2025",
      "desc" -> "Test",
      "stateVars" -> {},  (* Empty list *)
      "parameters" -> {delta -> 0.998}
    |>;
    result = Quiet[$validateModel[model]];
    (* Empty stateVars triggers WrongType error *)
    MemberQ[result["Errors"][[All, "Type"]], "WrongType"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "stateVars-empty-list-fails@@Tests/ValidateModels/validateModel.wlt:691,1-708,2"
]

(* --- merged from: validateModel_test22.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Test state variable with invalid symbol *)
  Module[{model, result},
    model = <|
      "name" -> "Test",
      "shortname" -> "TM",
      "bibRef" -> "Test2025",
      "desc" -> "Test",
      "stateVars" -> {invalidSymbol[t]},  (* invalidSymbol not in allowed list *)
      "parameters" -> $realModels["BY"]["parameters"]
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "BadStateVarSymbol"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "stateVars-invalid-symbol-fails@@Tests/ValidateModels/validateModel.wlt:734,1-751,2"
]

(* --- merged from: validateModel_test23.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Test state variable with mixed valid and invalid symbols *)
  Module[{model, result},
    model = <|
      "name" -> "Test",
      "shortname" -> "TM",
      "bibRef" -> "Test2025",
      "desc" -> "Test",
      "stateVars" -> {x[t], unknownVar[t] + delta},  (* unknownVar is invalid *)
      "parameters" -> $realModels["BY"]["parameters"]
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "BadStateVarSymbol"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "stateVars-mixed-valid-invalid-fails@@Tests/ValidateModels/validateModel.wlt:777,1-794,2"
]

(* --- merged from: validateModel_test24.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Test valid state variables with exo vars, params, shocks pass *)
  Module[{model, result},
    model = <|
      "name" -> "Test",
      "shortname" -> "TM",
      "bibRef" -> "Test2025",
      "desc" -> "Test",
      (* Valid: x is exo var, mup is param, t is time *)
      "stateVars" -> {x[t], -mup + pi[t]},
      "parameters" -> $realModels["BY"]["parameters"]
    |>;
    result = Quiet[$validateModel[model]];
    !MemberQ[result["Errors"][[All, "Type"]], "BadStateVarSymbol"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "stateVars-valid-symbols-pass@@Tests/ValidateModels/validateModel.wlt:820,1-838,2"
]

(* --- merged from: validateModel_test25.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{model, result},
    model = <|
      "name" -> "Test",
      "shortname" -> "TM",
      "bibRef" -> "Test2025",
      "desc" -> "Test",
      "stateVars" -> {x[t]},
      "parameters" -> {delta -> 0.998, delta -> 0.99}  (* Duplicate *)
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "DuplicateParam"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "duplicate-parameter-fails@@Tests/ValidateModels/validateModel.wlt:864,1-880,2"
]

(* --- merged from: validateModel_test26.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{model, result},
    model = <|
      "name" -> "Test",
      "shortname" -> "TM",
      "bibRef" -> "Test2025",
      "desc" -> "Test",
      "stateVars" -> {x[t]},
      "parameters" -> {delta -> "not numeric"}  (* Non-numeric value *)
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "BadParam"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "non-numeric-param-value-fails@@Tests/ValidateModels/validateModel.wlt:906,1-922,2"
]

(* --- merged from: validateModel_test27.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{model, result},
    model = <|
      "name" -> "Test",
      "shortname" -> "TM",
      "bibRef" -> "Test2025",
      "desc" -> "Test",
      "stateVars" -> {x[t]},
      "parameters" -> {delta -> 0.998, 42}  (* Not a Rule *)
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "NotRule"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "non-rule-parameter-entry-fails@@Tests/ValidateModels/validateModel.wlt:948,1-964,2"
]

(* --- merged from: validateModel_test28.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{model, result, byParams, incompleteStock2Params},
    (* Start with valid BY params (which has complete stock 1), then add incomplete stock 2 params *)
    byParams = $realModels["BY"]["parameters"];
    (* Add only some of the 16 stock params for stock 2 - incomplete *)
    incompleteStock2Params = {mud[2] -> 0.002, rhodx[2] -> 2.5};
    model = <|
      "name" -> "Multi Stock",
      "shortname" -> "MS",
      "bibRef" -> "Test2025",
      "desc" -> "Multi stock model",
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> Join[byParams, incompleteStock2Params]
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "MissingStockParam"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "incomplete-stock-params-fails@@Tests/ValidateModels/validateModel.wlt:990,1-1010,2"
]

(* --- merged from: validateModel_test29.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{model, result},
    model = <|
      "name" -> 42,  (* Wrong type *)
      "shortname" -> "TM",
      (* Missing bibRef, desc *)
      "stateVars" -> {x},  (* Missing [t] *)
      "parameters" -> {delta -> "bad", delta -> 0.99}  (* Non-numeric + duplicate *)
    |>;
    result = Quiet[$validateModel[model]];
    (* Should accumulate multiple errors - at least WrongType, MissingKey x2, BadStateVar, BadParam, DuplicateParam *)
    result["ErrorCount"] >= 4
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "accumulates-multiple-errors@@Tests/ValidateModels/validateModel.wlt:1036,1-1052,2"
]

(* --- merged from: validateModel_test30.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Test stripParamIndex helper *)
  $stripParamIndex[delta] === "delta",
  True,
  TestID -> "stripParamIndex-symbol@@Tests/ValidateModels/validateModel.wlt:1078,1-1083,2"
]

(* --- merged from: validateModel_test31.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Test stripParamIndex with indexed param *)
  $stripParamIndex[mud[1]] === "mud",
  True,
  TestID -> "stripParamIndex-indexed@@Tests/ValidateModels/validateModel.wlt:1109,1-1114,2"
]

(* --- merged from: validateModel_test32.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Model with extra parameter not in $parameters *)
  Module[{model, result, byParams},
    (* Start with valid BY params and add an extra one *)
    byParams = $realModels["BY"]["parameters"];
    model = <|
      "name" -> "Test",
      "shortname" -> "TM",
      "bibRef" -> "Test2025",
      "desc" -> "Test",
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> Append[byParams, notAValidParam -> 123]
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "ExtraParam"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "extra-param-detected@@Tests/ValidateModels/validateModel.wlt:1140,1-1159,2"
]

(* --- merged from: validateModel_test33.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Model missing a parameter from $parameters *)
  Module[{model, result, byParams},
    (* Remove delta param by matching symbol name (context-independent) *)
    byParams = DeleteCases[$realModels["BY"]["parameters"],
      Rule[s_Symbol, _] /; SymbolName[s] === "delta"];
    model = <|
      "name" -> "Test",
      "shortname" -> "TM",
      "bibRef" -> "Test2025",
      "desc" -> "Test",
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> byParams
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "MissingParam"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "missing-param-detected@@Tests/ValidateModels/validateModel.wlt:1185,1-1205,2"
]

(* --- merged from: validateModel_test34.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Simple test model has missing params *)
  Module[{model, result},
    model = <|
      "name" -> "Test",
      "shortname" -> "TM",
      "bibRef" -> "Test2025",
      "desc" -> "Test",
      "stateVars" -> {x[t]},
      "parameters" -> {delta -> 0.998, gamma -> 10}
    |>;
    result = Quiet[$validateModel[model]];
    (* Should detect missing params since only 2 of 73 are present *)
    MemberQ[result["Errors"][[All, "Type"]], "MissingParam"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "simple-model-missing-params@@Tests/ValidateModels/validateModel.wlt:1231,1-1249,2"
]

(* --- merged from: validateModel_test35.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Test invalid indexed parameter name (not in dividend growth params) *)
  Module[{model, result, byParams, badIndexedParams},
    byParams = $realModels["BY"]["parameters"];
    (* notADividendParam is not in paramList["Real dividend growth"] *)
    badIndexedParams = {notADividendParam[1] -> 0.5};
    model = <|
      "name" -> "Bad Indexed",
      "shortname" -> "BI",
      "bibRef" -> "Test2025",
      "desc" -> "Model with invalid indexed param",
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> Join[byParams, badIndexedParams]
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "BadIndexedParam"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "bad-indexed-param-name-fails@@Tests/ValidateModels/validateModel.wlt:1275,1-1295,2"
]

(* --- merged from: validateModel_test36.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Test non-positive index *)
  Module[{model, result, byParams, nonPositiveIndexParams},
    byParams = $realModels["BY"]["parameters"];
    (* mud[0] has non-positive index *)
    nonPositiveIndexParams = {mud[0] -> 0.001};
    model = <|
      "name" -> "Non-Positive Index",
      "shortname" -> "NPI",
      "bibRef" -> "Test2025",
      "desc" -> "Model with non-positive index",
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> Join[byParams, nonPositiveIndexParams]
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "IndexNotPositive"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "non-positive-index-fails@@Tests/ValidateModels/validateModel.wlt:1321,1-1341,2"
]

(* --- merged from: validateModel_test37.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Test index gap - has index 3 without index 2 *)
  Module[{model, result, byParams, gapIndexParams, stock3Params},
    byParams = $realModels["BY"]["parameters"];
    (* Add complete params for stock 3 but skip stock 2 *)
    stock3Params = {
      mud[3] -> 0.001, rhodx[3] -> 2, rhodp[3] -> 0, phidc[3] -> 0,
      phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> 0, phids[3] -> 0,
      phidxc[3] -> 0, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0,
      phidxd[3] -> 4, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    };
    model = <|
      "name" -> "Index Gap",
      "shortname" -> "IG",
      "bibRef" -> "Test2025",
      "desc" -> "Model with index gap",
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> Join[byParams, stock3Params]
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "IndexGap"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "index-gap-fails@@Tests/ValidateModels/validateModel.wlt:1367,1-1392,2"
]

(* --- merged from: validateModel_test38.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Test valid multi-stock model passes *)
  Module[{model, result, byParams, stock2Params},
    byParams = $realModels["BY"]["parameters"];
    (* Add complete params for stock 2 - should pass *)
    stock2Params = {
      mud[2] -> 0.001, rhodx[2] -> 2, rhodp[2] -> 0, phidc[2] -> 0,
      phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0,
      phidxd[2] -> 4, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    };
    model = <|
      "name" -> "Multi Stock Valid",
      "shortname" -> "MSV",
      "bibRef" -> "Test2025",
      "desc" -> "Valid multi-stock model",
      "enabled" -> True,
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> Join[byParams, stock2Params]
    |>;
    result = Quiet[$validateModel[model]];
    result["Valid"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "valid-multi-stock-passes@@Tests/ValidateModels/validateModel.wlt:1418,1-1444,2"
]

(* --- merged from: validateModel_test39.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Test delta outside valid range (0, 1) - violates delta > 0 *)
  Module[{model, result, byParams, modifiedParams},
    byParams = $realModels["BY"]["parameters"];
    (* Replace delta with invalid value *)
    modifiedParams = byParams /. (Rule[s_Symbol, _] /; SymbolName[s] === "delta" :> (s -> -0.5));
    model = <|
      "name" -> "Bad Delta",
      "shortname" -> "BD",
      "bibRef" -> "Test2025",
      "desc" -> "Model with invalid delta",
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> modifiedParams
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "BadAssumption"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "assumption-delta-negative-fails@@Tests/ValidateModels/validateModel.wlt:1470,1-1490,2"
]

(* --- merged from: validateModel_test40.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Test delta > 1 - violates delta < 1 *)
  Module[{model, result, byParams, modifiedParams},
    byParams = $realModels["BY"]["parameters"];
    modifiedParams = byParams /. (Rule[s_Symbol, _] /; SymbolName[s] === "delta" :> (s -> 1.5));
    model = <|
      "name" -> "Bad Delta High",
      "shortname" -> "BDH",
      "bibRef" -> "Test2025",
      "desc" -> "Model with delta too high",
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> modifiedParams
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "BadAssumption"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "assumption-delta-too-high-fails@@Tests/ValidateModels/validateModel.wlt:1516,1-1535,2"
]

(* --- merged from: validateModel_test41.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Test psi <= 0 - violates psi > 0 *)
  Module[{model, result, byParams, modifiedParams},
    byParams = $realModels["BY"]["parameters"];
    modifiedParams = byParams /. (Rule[s_Symbol, _] /; SymbolName[s] === "psi" :> (s -> -1));
    model = <|
      "name" -> "Bad Psi",
      "shortname" -> "BP",
      "bibRef" -> "Test2025",
      "desc" -> "Model with invalid psi",
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> modifiedParams
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "BadAssumption"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "assumption-psi-negative-fails@@Tests/ValidateModels/validateModel.wlt:1561,1-1580,2"
]

(* --- merged from: validateModel_test42.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Test theta = 0 - violates theta < 0 || theta > 0 *)
  Module[{model, result, byParams, modifiedParams},
    byParams = $realModels["BY"]["parameters"];
    modifiedParams = byParams /. (Rule[s_Symbol, _] /; SymbolName[s] === "theta" :> (s -> 0));
    model = <|
      "name" -> "Bad Theta",
      "shortname" -> "BT",
      "bibRef" -> "Test2025",
      "desc" -> "Model with theta = 0",
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> modifiedParams
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "BadAssumption"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "assumption-theta-zero-fails@@Tests/ValidateModels/validateModel.wlt:1606,1-1625,2"
]

(* --- merged from: validateModel_test43.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Test rhox outside (-1, 1) - violates rhox > -1 && rhox < 1 *)
  Module[{model, result, byParams, modifiedParams},
    byParams = $realModels["BY"]["parameters"];
    modifiedParams = byParams /. (Rule[s_Symbol, _] /; SymbolName[s] === "rhox" :> (s -> 1.5));
    model = <|
      "name" -> "Bad Rhox",
      "shortname" -> "BR",
      "bibRef" -> "Test2025",
      "desc" -> "Model with rhox out of range",
      "stateVars" -> $realModels["BY"]["stateVars"],
      "parameters" -> modifiedParams
    |>;
    result = Quiet[$validateModel[model]];
    MemberQ[result["Errors"][[All, "Type"]], "BadAssumption"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "assumption-rhox-out-of-range-fails@@Tests/ValidateModels/validateModel.wlt:1651,1-1670,2"
]

(* --- merged from: validateModel_test44.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  (* Use real catalog models which have complete parameter sets *)
  Module[{catalog},
    catalog = <|
      "ModelA" -> $realModels["BY"],
      "ModelB" -> $realModels["BKY"]
    |>;
    $validateCatalog[catalog]["Valid"]
  ],
  True,
  TestID -> "valid-catalog-passes@@Tests/ValidateModels/validateModel.wlt:1696,1-1707,2"
]

(* --- merged from: validateModel_test45.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{catalog, result},
    catalog = <|
      "ModelA" -> $realModels["BY"],
      "ModelB" -> <|
        "name" -> 42,  (* Invalid *)
        "shortname" -> "B",
        "bibRef" -> "B2025",
        "desc" -> "Second model",
        "stateVars" -> {y[t]},
        "parameters" -> {gamma -> 10}
      |>
    |>;
    result = Quiet[$validateCatalog[catalog]];
    MemberQ[result["InvalidModels"], "ModelB"] && result["TotalErrors"] >= 1
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "catalog-identifies-invalid-models@@Tests/ValidateModels/validateModel.wlt:1733,1-1752,2"
]

(* --- merged from: validateModel_test46.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result},
    result = Quiet[$validateModel[$badCatalog["BY"]]];
    MemberQ[result["Errors"][[All, "Type"]], "BadStateVar"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "badCatalog-BY-missing-t-dependency@@Tests/ValidateModels/validateModel.wlt:2148,1-2156,2"
]

(* --- merged from: validateModel_test47.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result},
    result = Quiet[$validateModel[$badCatalog["BYlowPers"]]];
    MemberQ[result["Errors"][[All, "Type"]], "WrongType"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "badCatalog-BYlowPers-bibRef-symbol@@Tests/ValidateModels/validateModel.wlt:2552,1-2560,2"
]

(* --- merged from: validateModel_test48.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result},
    result = Quiet[$validateModel[$badCatalog["BYverylowPers"]]];
    MemberQ[result["Errors"][[All, "Type"]], "BadParam"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "badCatalog-BYverylowPers-non-numeric-param@@Tests/ValidateModels/validateModel.wlt:2956,1-2964,2"
]

(* --- merged from: validateModel_test49.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result},
    result = Quiet[$validateModel[$badCatalog["BKY"]]];
    MemberQ[result["Errors"][[All, "Type"]], "MissingParam"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "badCatalog-BKY-missing-phipx@@Tests/ValidateModels/validateModel.wlt:3360,1-3368,2"
]

(* --- merged from: validateModel_test50.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result},
    result = Quiet[$validateModel[$badCatalog["BKYlowPers"]]];
    MemberQ[result["Errors"][[All, "Type"]], "ExtraParam"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "badCatalog-BKYlowPers-extra-param@@Tests/ValidateModels/validateModel.wlt:3764,1-3772,2"
]

(* --- merged from: validateModel_test51.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result},
    result = Quiet[$validateModel[$badCatalog["BKYverylowPers"]]];
    MemberQ[result["Errors"][[All, "Type"]], "MissingStockParam"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "badCatalog-BKYverylowPers-missing-stock-param@@Tests/ValidateModels/validateModel.wlt:4168,1-4176,2"
]

(* --- merged from: validateModel_test52.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result},
    result = Quiet[$validateModel[$badCatalog["BKYinf"]]];
    MemberQ[result["Errors"][[All, "Type"]], "BadAssumption"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "badCatalog-BKYinf-psi-negative@@Tests/ValidateModels/validateModel.wlt:4572,1-4580,2"
]

(* --- merged from: validateModel_test53.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result},
    result = Quiet[$validateModel[$badCatalog["NRC"]]];
    MemberQ[result["Errors"][[All, "Type"]], "BadStateVarSymbol"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "badCatalog-NRC-invalid-symbol@@Tests/ValidateModels/validateModel.wlt:4976,1-4984,2"
]

(* --- merged from: validateModel_test54.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result},
    result = Quiet[$validateModel[$badCatalog["NRCLLR"]]];
    MemberQ[result["Errors"][[All, "Type"]], "IndexGap"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "badCatalog-NRCLLR-index-gap@@Tests/ValidateModels/validateModel.wlt:5380,1-5388,2"
]

(* --- merged from: validateModel_test55.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result},
    result = Quiet[$validateModel[$badCatalog["WCratio"]]];
    MemberQ[result["Errors"][[All, "Type"]], "BadParam"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "badCatalog-WCratio-non-numeric@@Tests/ValidateModels/validateModel.wlt:5784,1-5792,2"
]

(* --- merged from: validateModel_test56.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result},
    result = Quiet[$validateModel[$badCatalog["WCratioInf"]]];
    MemberQ[result["Errors"][[All, "Type"]], "IndexNotPositive"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "badCatalog-WCratioInf-zero-index@@Tests/ValidateModels/validateModel.wlt:6188,1-6196,2"
]

(* --- merged from: validateModel_test57.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result},
    result = Quiet[$validateModel[$badCatalog["infStochVol"]]];
    MemberQ[result["Errors"][[All, "Type"]], "IndexGap"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "badCatalog-infStochVol-index-gap@@Tests/ValidateModels/validateModel.wlt:6592,1-6600,2"
]

(* --- merged from: validateModel_test58.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result},
    result = Quiet[$validateModel[$badCatalog["hassel"]]];
    MemberQ[result["Errors"][[All, "Type"]], "BadParamName"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "badCatalog-hassel-symbol-index@@Tests/ValidateModels/validateModel.wlt:6996,1-7004,2"
]

(* --- merged from: validateModel_test59.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result},
    result = Quiet[$validateModel[$badCatalog["hasselNRC"]]];
    MemberQ[result["Errors"][[All, "Type"]], "BadStateVarSymbol"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "badCatalog-hasselNRC-invalid-symbol-s@@Tests/ValidateModels/validateModel.wlt:7400,1-7408,2"
]

(* --- merged from: validateModel_test60.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result},
    result = Quiet[$validateModel[$badCatalog["BS"]]];
    MemberQ[result["Errors"][[All, "Type"]], "MissingStockParam"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "badCatalog-BS-incomplete-stock@@Tests/ValidateModels/validateModel.wlt:7804,1-7812,2"
]

(* --- merged from: validateModel_test61.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result},
    result = Quiet[$validateModel[$badCatalog["DES"]]];
    MemberQ[result["Errors"][[All, "Type"]], "BadStateVarSymbol"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "badCatalog-DES-invalid-symbol-ab@@Tests/ValidateModels/validateModel.wlt:8208,1-8216,2"
]

(* --- merged from: validateModel_test62.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result},
    result = Quiet[$validateModel[$badCatalog["NRCStochVol"]]];
    MemberQ[result["Errors"][[All, "Type"]], "BadStateVar"] ||
    MemberQ[result["Errors"][[All, "Type"]], "BadStateVarSymbol"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "badCatalog-NRCStochVol-wrong-time-var@@Tests/ValidateModels/validateModel.wlt:8612,1-8621,2"
]

(* --- merged from: validateModel_test63.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result},
    result = Quiet[$validateCatalog[$badCatalog]];
    result["Valid"] === False && Length[result["InvalidModels"]] === 17
  ],
  True,
  TimeConstraint -> 30,
  TestID -> "badCatalog-all-models-invalid@@Tests/ValidateModels/validateModel.wlt:9017,1-9025,2"
]

(* --- merged from: validateModel_test64.wlt --- *)
(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result, expectedErrors, actualErrorTypes, allMatch},
    result = Quiet[$validateCatalog[$badCatalog]];

    (* Expected primary error type for each model *)
    expectedErrors = <|
      "BY" -> "BadStateVar",
      "BYlowPers" -> "WrongType",
      "BYverylowPers" -> "BadParam",
      "BKY" -> "MissingParam",
      "BKYlowPers" -> "ExtraParam",
      "BKYverylowPers" -> "MissingStockParam",
      "BKYinf" -> "BadAssumption",
      "NRC" -> "BadStateVarSymbol",
      "NRCLLR" -> "IndexGap",
      "WCratio" -> "BadParam",
      "WCratioInf" -> "IndexNotPositive",
      "infStochVol" -> "IndexGap",
      "hassel" -> "BadParamName",
      "hasselNRC" -> "BadStateVarSymbol",
      "BS" -> "MissingStockParam",
      "DES" -> "BadStateVarSymbol",
      "NRCStochVol" -> "BadStateVar"
    |>;

    (* Check that each model has its expected error type *)
    allMatch = AllTrue[Keys[expectedErrors], Function[modelName,
      Module[{modelErrors},
        modelErrors = result["Results"][modelName]["Errors"][[All, "Type"]];
        MemberQ[modelErrors, expectedErrors[modelName]]
      ]
    ]];

    (* Verify: catalog is invalid, all 17 models invalid, all expected errors present *)
    result["Valid"] === False &&
    Length[result["InvalidModels"]] === 17 &&
    Sort[result["InvalidModels"]] === Sort[Keys[$badCatalog]] &&
    allMatch
  ],
  True,
  TimeConstraint -> 60,
  TestID -> "badCatalog-comprehensive-validation@@Tests/ValidateModels/validateModel.wlt:9421,1-9463,2"
]

End[]
EndTestSection[]
