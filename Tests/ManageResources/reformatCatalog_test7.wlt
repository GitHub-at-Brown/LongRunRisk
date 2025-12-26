BeginTestSection["reformatCatalog"]

(* Setup: Load required packages *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];
Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];
On[General::shdw];

(* Load catalog for testing *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];

$timeLimit = 30;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{normalizeWS, stringFmt, desc, r1, r2, r3},
    normalizeWS = ToExpression["FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`normalizeWhitespace"];
    stringFmt = ToExpression["FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stringFormattingTemplate"];
    desc = "Bansal and Yaron (2004) long-run risk model with stochastic volatility of consumption growth.";
    r1 = stringFmt[desc];
    r2 = stringFmt[r1];
    r3 = stringFmt[r2];
    r1 === r2 && r2 === r3
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "reformatCatalog-string-formatting-idempotent@@Tests/ManageResources/reformatCatalog.wlt:112,1-125,2"
]

EndTestSection[]
