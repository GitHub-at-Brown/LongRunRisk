BeginTestSection["createCompiledEq Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`createCompiledEq`"]

(* --- merged from: createCompiledEq_test1.wlt --- *)
(* Setup: Load FindRootOptim package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

$timeLimit = 5;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  Head[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq],
  Symbol,
  TestID -> "createCompiledEq-symbol-exists@@Tests/FindRootOptim/createCompiledEq.wlt:16,1-20,2"
]

(* --- merged from: createCompiledEq_test2.wlt --- *)
(* Setup: Load FindRootOptim package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

$timeLimit = 5;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  Head[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel],
  Symbol,
  TestID -> "buildKernel-symbol-exists@@Tests/FindRootOptim/createCompiledEq.wlt:34,1-38,2"
]

(* --- merged from: createCompiledEq_test3.wlt --- *)
(* Setup: Load FindRootOptim package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

$timeLimit = 5;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq::usage],
  True,
  TestID -> "createCompiledEq-has-usage@@Tests/FindRootOptim/createCompiledEq.wlt:52,1-56,2"
]

(* --- merged from: createCompiledEq_test4.wlt --- *)
(* Setup: Load FindRootOptim package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

$timeLimit = 5;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel::usage],
  True,
  TestID -> "buildKernel-has-usage@@Tests/FindRootOptim/createCompiledEq.wlt:70,1-74,2"
]

(* --- merged from: createCompiledEq_test5.wlt --- *)
(* Setup: Load FindRootOptim package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

$timeLimit = 5;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{opts, bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    opts = Options[bk];
    Length[opts] > 0
  ],
  True,
  TestID -> "buildKernel-has-options@@Tests/FindRootOptim/createCompiledEq.wlt:88,1-96,2"
]

(* --- merged from: createCompiledEq_test6.wlt --- *)
(* Setup: Load FindRootOptim package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

$timeLimit = 5;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{opts, bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    opts = Options[bk];
    MemberQ[Keys[opts], "CoeffName"]
  ],
  True,
  TestID -> "buildKernel-has-CoeffName-option@@Tests/FindRootOptim/createCompiledEq.wlt:110,1-118,2"
]

(* --- merged from: createCompiledEq_test7.wlt --- *)
(* Setup: Load FindRootOptim package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

$timeLimit = 5;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{opts, bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    opts = Options[bk];
    MemberQ[Keys[opts], "SignSymbol"]
  ],
  True,
  TestID -> "buildKernel-has-SignSymbol-option@@Tests/FindRootOptim/createCompiledEq.wlt:132,1-140,2"
]

(* --- merged from: createCompiledEq_test8.wlt --- *)
(* Setup: Load FindRootOptim package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

$timeLimit = 5;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{opts, bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    opts = Options[bk];
    MemberQ[Keys[opts], "PerformanceGoal"]
  ],
  True,
  TestID -> "buildKernel-has-PerformanceGoal-option@@Tests/FindRootOptim/createCompiledEq.wlt:154,1-162,2"
]

(* --- merged from: createCompiledEq_test9.wlt --- *)
(* Setup: Load FindRootOptim package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

$timeLimit = 5;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{opts, bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    opts = Options[bk];
    MemberQ[Keys[opts], "CompileMode"]
  ],
  True,
  TestID -> "buildKernel-has-CompileMode-option@@Tests/FindRootOptim/createCompiledEq.wlt:176,1-184,2"
]

(* --- merged from: createCompiledEq_test10.wlt --- *)
(* Setup: Load FindRootOptim package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

$timeLimit = 5;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    OptionValue[bk, "CompileMode"]
  ],
  "FunctionOnly",
  TestID -> "buildKernel-CompileMode-default-is-FunctionOnly@@Tests/FindRootOptim/createCompiledEq.wlt:198,1-205,2"
]

(* --- merged from: createCompiledEq_test11.wlt --- *)
(* Setup: Load FindRootOptim package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

$timeLimit = 5;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{cce},
    cce = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq;
    (* createCompiledEq uses OptionsPattern[{buildKernel, ...}] to inherit options *)
    MatchQ[
      Head[cce],
      Symbol
    ]
  ],
  True,
  TestID -> "createCompiledEq-accepts-buildKernel-options@@Tests/FindRootOptim/createCompiledEq.wlt:219,1-230,2"
]

End[]
EndTestSection[]
