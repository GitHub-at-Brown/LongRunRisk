BeginTestSection["fastRootMissingJacobian Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`fastRootMissingJacobian`"]

(* --- merged from: fastRootMissingJacobian_test1.wlt --- *)
(* Load package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Access public functions *)
buildKernel = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;

timeLimit = 10;

(* Verify that CompileMode -> "FunctionOnly" produces Missing Jacobian *)
VerificationTest[
  Module[{kernel, expr, vars, params},
    expr = x^2 - A[0];
    vars = {A[0]};
    params = {x};
    Block[{$ContextPath = Prepend[$ContextPath, "CCompilerDriver`"]},
      kernel = buildKernel[expr, vars, params, CompileMode -> "FunctionOnly"];
      (* Verify Jacobian is Missing *)
      MissingQ[kernel["dfC"]]
    ]
  ],
  True,
  {},
  TimeConstraint -> timeLimit,
  TestID -> "buildKernel-functiononly-missing-jacobian@@Tests/FindRootOptim/fastRootMissingJacobian.wlt:16,1-31,2"
]

(* --- merged from: fastRootMissingJacobian_test2.wlt --- *)
(* Test that MissingQ correctly identifies Missing["NotCompiled"] *)
VerificationTest[
  MissingQ[Missing["NotCompiled"]],
  True,
  {},
  TestID -> "missingq-detects-missing-notcompiled@@Tests/FindRootOptim/fastRootMissingJacobian.wlt:35,1-40,2"
]

(* --- merged from: fastRootMissingJacobian_test3.wlt --- *)
(* Test that FailureQ correctly identifies $Failed *)
VerificationTest[
  FailureQ[$Failed],
  True,
  {},
  TestID -> "failureq-detects-failed@@Tests/FindRootOptim/fastRootMissingJacobian.wlt:44,1-49,2"
]

(* --- merged from: fastRootMissingJacobian_test4.wlt --- *)
(* Test that MissingQ does not match $Failed *)
VerificationTest[
  MissingQ[$Failed],
  False,
  {},
  TestID -> "missingq-does-not-match-failed@@Tests/FindRootOptim/fastRootMissingJacobian.wlt:53,1-58,2"
]

(* --- merged from: fastRootMissingJacobian_test5.wlt --- *)
(* Test that FailureQ does not match Missing *)
VerificationTest[
  FailureQ[Missing["NotCompiled"]],
  False,
  {},
  TestID -> "failureq-does-not-match-missing@@Tests/FindRootOptim/fastRootMissingJacobian.wlt:62,1-67,2"
]

(* --- merged from: fastRootMissingJacobian_test6.wlt --- *)
(* Load package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Access public functions *)
buildKernel = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel;

timeLimit = 10;

(* Verify that CompileMode -> "Both" produces both function and Jacobian *)
VerificationTest[
  Module[{kernel, expr, vars, params},
    expr = x^2 - A[0];
    vars = {A[0]};
    params = {x};
    Block[{$ContextPath = Prepend[$ContextPath, "CCompilerDriver`"]},
      kernel = buildKernel[expr, vars, params, CompileMode -> "Both"];
      (* Verify Jacobian is NOT Missing *)
      !MissingQ[kernel["dfC"]] && !FailureQ[kernel["dfC"]]
    ]
  ],
  True,
  {},
  TimeConstraint -> timeLimit,
  TestID -> "buildKernel-both-has-jacobian@@Tests/FindRootOptim/fastRootMissingJacobian.wlt:81,1-96,2"
]

End[]
EndTestSection[]
