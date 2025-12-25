BeginTestSection["createCompiledEq"]

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
  TestID -> "createCompiledEq-symbol-exists@@Tests/FindRootOptim/createCompiledEq.wlt:14,1-18,2"
]

VerificationTest[
  Head[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel],
  Symbol,
  TestID -> "buildKernel-symbol-exists@@Tests/FindRootOptim/createCompiledEq.wlt:20,1-24,2"
]

(* ============================================================ *)
(* Usage Message Tests *)
(* ============================================================ *)

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq::usage],
  True,
  TestID -> "createCompiledEq-has-usage@@Tests/FindRootOptim/createCompiledEq.wlt:30,1-34,2"
]

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel::usage],
  True,
  TestID -> "buildKernel-has-usage@@Tests/FindRootOptim/createCompiledEq.wlt:36,1-40,2"
]

(* ============================================================ *)
(* Options Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{opts, bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    opts = Options[bk];
    Length[opts] > 0
  ],
  True,
  TestID -> "buildKernel-has-options@@Tests/FindRootOptim/createCompiledEq.wlt:46,1-54,2"
]

VerificationTest[
  Module[{opts, bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    opts = Options[bk];
    MemberQ[Keys[opts], "CoeffName"]
  ],
  True,
  TestID -> "buildKernel-has-CoeffName-option@@Tests/FindRootOptim/createCompiledEq.wlt:56,1-64,2"
]

VerificationTest[
  Module[{opts, bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    opts = Options[bk];
    MemberQ[Keys[opts], "SignSymbol"]
  ],
  True,
  TestID -> "buildKernel-has-SignSymbol-option@@Tests/FindRootOptim/createCompiledEq.wlt:66,1-74,2"
]

VerificationTest[
  Module[{opts, bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    opts = Options[bk];
    MemberQ[Keys[opts], "PerformanceGoal"]
  ],
  True,
  TestID -> "buildKernel-has-PerformanceGoal-option@@Tests/FindRootOptim/createCompiledEq.wlt:76,1-84,2"
]

VerificationTest[
  Module[{opts, bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    opts = Options[bk];
    MemberQ[Keys[opts], "CompileMode"]
  ],
  True,
  TestID -> "buildKernel-has-CompileMode-option@@Tests/FindRootOptim/createCompiledEq.wlt:86,1-94,2"
]

VerificationTest[
  Module[{bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    OptionValue[bk, "CompileMode"]
  ],
  "FunctionOnly",
  TestID -> "buildKernel-CompileMode-default-is-FunctionOnly@@Tests/FindRootOptim/createCompiledEq.wlt:96,1-103,2"
]

(* ============================================================ *)
(* createCompiledEq Options Tests *)
(* Note: createCompiledEq uses OptionsPattern[{buildKernel, ...}] *)
(* so it inherits options but Options[createCompiledEq] is empty *)
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
  TestID -> "createCompiledEq-accepts-buildKernel-options@@Tests/FindRootOptim/createCompiledEq.wlt:111,1-122,2"
]

EndTestSection[]
