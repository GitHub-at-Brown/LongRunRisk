BeginTestSection["extractIntervalsFromReduce"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

(* Test: Variable mismatch returns default fallback interval *)
(* When reduceExpr contains B[1][0] but we pass B[j][0] (symbolic index), *)
(* the pattern match fails and default interval is returned *)
(* This documents the expected behavior when caller forgets to substitute indices *)
VerificationTest[
    eir[Inequality[0, Less, B[1][0], LessEqual, 6.059], B[j][0], "InteriorShrink" -> 0],
    {{0., 15.}},
    TestID -> "mismatched-indexed-variable-returns-default@@Tests/FindRootOptim/extractIntervalsFromReduce_test15.wlt:15,1-19,4"
  ]

EndTestSection[]
