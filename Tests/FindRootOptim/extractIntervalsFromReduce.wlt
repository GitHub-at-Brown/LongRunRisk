BeginTestSection["extractIntervalsFromReduce Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`extractIntervalsFromReduce`"]

(* --- merged from: extractIntervalsFromReduce_test1.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

VerificationTest[
    eir[(x > 10) || (1 < x < 2), x, "InteriorShrink" -> 0],
    {{1., 2.}, {10., 15.}},
    TestID -> "mixed-two-sided-and-upper-fallback@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:13,1-17,4"
  ]

(* --- merged from: extractIntervalsFromReduce_test2.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

VerificationTest[
    eir[(x == 3) || (x > 10), x, "InteriorShrink" -> 0],
    {{3., 3.}, {10., 15.}},
    TestID -> "single-point-and-upper-fallback@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:28,1-32,4"
  ]

(* --- merged from: extractIntervalsFromReduce_test3.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

VerificationTest[
    eir[(x > 20) || (1 < x < 2), x, "InteriorShrink" -> 0, "RootUpperBound" -> 15],
    {{1., 2.}},
    TestID -> "drops-above-upper-bound-clause@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:43,1-47,4"
  ]

(* --- merged from: extractIntervalsFromReduce_test4.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

VerificationTest[
    eir[x < -1, x, "InteriorShrink" -> 0, "RootUpperBound" -> 10],
    {},
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce::nointervals},
    TestID -> "drops-below-zero-clause-and-returns-empty@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:58,1-63,4"
  ]

(* --- merged from: extractIntervalsFromReduce_test5.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

VerificationTest[
    eir[0 < x < 0.0015, x, "InteriorShrink" -> 0.001, "RootUpperBound" -> 1],
    {{0.00075, 0.00075}},
    TestID -> "collapses-narrow-interval-to-midpoint@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:74,1-78,4"
  ]

(* --- merged from: extractIntervalsFromReduce_test6.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

VerificationTest[
    eir[True, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 5],
    {{0.2, 4.8}},
    SameTest -> (Max[Abs[Flatten[#1] - Flatten[#2]]] < 10^-10 &),
    TestID -> "true-branch-full-range@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:89,1-94,4"
  ]

(* --- merged from: extractIntervalsFromReduce_test7.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

VerificationTest[
    eir[False, x],
    {},
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce::nointervals},
    TestID -> "false-branch-empty@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:105,1-110,4"
  ]

(* --- merged from: extractIntervalsFromReduce_test8.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

VerificationTest[
    eir[x > 1, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 5],
    {{1.1, 4.9}},
    TestID -> "one-sided-lower-clamped-to-upper@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:121,1-125,4"
  ]

(* --- merged from: extractIntervalsFromReduce_test9.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

VerificationTest[
    eir[x > 4.9, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 5],
    {{4.95, 4.95}},
    TestID -> "one-sided-near-upper-clamps-and-collapses@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:136,1-140,4"
  ]

(* --- merged from: extractIntervalsFromReduce_test10.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

VerificationTest[
    eir[2 < x < 2.2, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 10],
    {{2.1, 2.1}},
    TestID -> "width-equal-2xshrink-collapses-to-midpoint@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:151,1-155,4"
  ]

(* --- merged from: extractIntervalsFromReduce_test11.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

VerificationTest[
    eir[1 < x < 3, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 10],
    {{1.1, 2.9}},
    TestID -> "wide-interval-applies-shrink@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:166,1-170,4"
  ]

(* --- merged from: extractIntervalsFromReduce_test12.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

VerificationTest[
    eir[(x >= 4 && x <= 4.2) || (1 <= x <= 2) || (x >= 10), x, "InteriorShrink" -> 0],
    {{1., 2.}, {4., 4.2}, {10., 15.}},
    TestID -> "open-closed-mix-and-sorting@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:181,1-185,4"
  ]

(* --- merged from: extractIntervalsFromReduce_test13.wlt --- *)
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"],
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce,
  ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]
];

VerificationTest[
    eir[x > 20, x, "RootUpperBound" -> 15],
    {},
    {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce::nointervals},
    TestID -> "all-clauses-dropped-empty@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:196,1-201,4"
  ]

(* --- merged from: extractIntervalsFromReduce_test14.wlt --- *)
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
    TestID -> "indexed-variable-head-extracts-bound@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:215,1-219,4"
  ]

(* --- merged from: extractIntervalsFromReduce_test15.wlt --- *)
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
    TestID -> "mismatched-indexed-variable-returns-default@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:234,1-238,4"
  ]

End[]
EndTestSection[]
