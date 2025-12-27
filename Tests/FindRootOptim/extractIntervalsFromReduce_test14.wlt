BeginTestSection["extractIntervalsFromReduce"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

(* Test: Indexed variable head - the variable has a compound head like B[1][0] *)
(* This tests the bug where reduceExpr contains B[1][0] but was passed B[j][0] *)
(* The extraction must correctly identify bounds when using indexed heads *)
VerificationTest[
    eir[Inequality[0, Less, B[1][0], LessEqual, 6.059], B[1][0], "InteriorShrink" -> 0],
    {{0., 6.059}},
    TestID -> "indexed-variable-head-extracts-bound@@Tests/FindRootOptim/extractIntervalsFromReduce_test14.wlt:14,1-18,4"
  ]

EndTestSection[]
