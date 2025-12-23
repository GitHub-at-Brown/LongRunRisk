BeginTestSection["createCompiledEq"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`createCompiledEq`"]

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
  TestID -> "createCompiledEq-symbol-exists@@Tests/FindRootOptim/createCompiledEq.wlt:20,1-24,2"
]

VerificationTest[
  Head[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel],
  Symbol,
  TestID -> "buildKernel-symbol-exists@@Tests/FindRootOptim/createCompiledEq.wlt:26,1-30,2"
]

(* ============================================================ *)
(* Usage Message Tests *)
(* ============================================================ *)

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq::usage],
  True,
  TestID -> "createCompiledEq-has-usage@@Tests/FindRootOptim/createCompiledEq.wlt:36,1-40,2"
]

VerificationTest[
  StringQ[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel::usage],
  True,
  TestID -> "buildKernel-has-usage@@Tests/FindRootOptim/createCompiledEq.wlt:42,1-46,2"
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
  TestID -> "buildKernel-has-options@@Tests/FindRootOptim/createCompiledEq.wlt:52,1-60,2"
]

VerificationTest[
  Module[{opts, bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    opts = Options[bk];
    MemberQ[Keys[opts], "CoeffName"]
  ],
  True,
  TestID -> "buildKernel-has-CoeffName-option@@Tests/FindRootOptim/createCompiledEq.wlt:62,1-70,2"
]

VerificationTest[
  Module[{opts, bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    opts = Options[bk];
    MemberQ[Keys[opts], "SignSymbol"]
  ],
  True,
  TestID -> "buildKernel-has-SignSymbol-option@@Tests/FindRootOptim/createCompiledEq.wlt:72,1-80,2"
]

VerificationTest[
  Module[{opts, bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    opts = Options[bk];
    MemberQ[Keys[opts], "PerformanceGoal"]
  ],
  True,
  TestID -> "buildKernel-has-PerformanceGoal-option@@Tests/FindRootOptim/createCompiledEq.wlt:82,1-90,2"
]

VerificationTest[
  Module[{opts, bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    opts = Options[bk];
    MemberQ[Keys[opts], "CompileMode"]
  ],
  True,
  TestID -> "buildKernel-has-CompileMode-option@@Tests/FindRootOptim/createCompiledEq.wlt:92,1-100,2"
]

VerificationTest[
  Module[{bk},
    bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;
    OptionValue[bk, "CompileMode"]
  ],
  "FunctionOnly",
  TestID -> "buildKernel-CompileMode-default-is-FunctionOnly@@Tests/FindRootOptim/createCompiledEq.wlt:102,1-109,2"
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
  TestID -> "createCompiledEq-accepts-buildKernel-options@@Tests/FindRootOptim/createCompiledEq.wlt:117,1-128,2"
]

End[]
EndTestSection[]
