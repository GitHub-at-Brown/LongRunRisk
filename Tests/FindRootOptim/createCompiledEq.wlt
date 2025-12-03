(* Setup: Load FindRootOptim.wl *)
Module[{start, d, pacletRoot},
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName], Directory[]];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
    d = DirectoryName[d]];
  pacletRoot = d;
  Off[General::shdw];
  Get[FileNameJoin[{pacletRoot, "Kernel", "Tools", "FindRootOptim.wl"}]];
  On[General::shdw];
];

$timeLimit = 5;

(* ============================================================ *)
(* Symbol Existence Tests *)
(* ============================================================ *)

VerificationTest[
  Head[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq],
  Symbol,
  TestID -> "createCompiledEq-symbol-exists"
]

VerificationTest[
  Head[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel],
  Symbol,
  TestID -> "buildKernel-symbol-exists"
]

(* ============================================================ *)
(* Usage Message Tests *)
(* ============================================================ *)

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq::usage],
  True,
  TestID -> "createCompiledEq-has-usage"
]

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel::usage],
  True,
  TestID -> "buildKernel-has-usage"
]

(* ============================================================ *)
(* Message Definition Tests *)
(* ============================================================ *)

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq::cachehit],
  True,
  TestID -> "createCompiledEq-has-cachehit-message"
]

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq::compiling],
  True,
  TestID -> "createCompiledEq-has-compiling-message"
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
  TestID -> "buildKernel-has-options"
]

VerificationTest[
  Module[{opts, bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    opts = Options[bk];
    MemberQ[Keys[opts], "CoeffName"]
  ],
  True,
  TestID -> "buildKernel-has-CoeffName-option"
]

VerificationTest[
  Module[{opts, bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    opts = Options[bk];
    MemberQ[Keys[opts], "SignSymbol"]
  ],
  True,
  TestID -> "buildKernel-has-SignSymbol-option"
]

VerificationTest[
  Module[{opts, bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    opts = Options[bk];
    MemberQ[Keys[opts], "PerformanceGoal"]
  ],
  True,
  TestID -> "buildKernel-has-PerformanceGoal-option"
]

VerificationTest[
  Module[{opts, bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    opts = Options[bk];
    MemberQ[Keys[opts], "CompileMode"]
  ],
  True,
  TestID -> "buildKernel-has-CompileMode-option"
]

VerificationTest[
  Module[{bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    OptionValue[bk, "CompileMode"]
  ],
  "FunctionOnly",
  TestID -> "buildKernel-CompileMode-default-is-FunctionOnly"
]

(* ============================================================ *)
(* createCompiledEq Options Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{opts, cce},
    cce = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq;
    opts = Options[cce];
    Length[opts] > 0
  ],
  True,
  TestID -> "createCompiledEq-has-options"
]

VerificationTest[
  Module[{opts, cce},
    cce = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq;
    opts = Options[cce];
    MemberQ[Keys[opts], "CompileMode"]
  ],
  True,
  TestID -> "createCompiledEq-has-CompileMode-option"
]

VerificationTest[
  Module[{cce},
    cce = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq;
    OptionValue[cce, "CompileMode"]
  ],
  "FunctionOnly",
  TestID -> "createCompiledEq-CompileMode-default-is-FunctionOnly"
]
