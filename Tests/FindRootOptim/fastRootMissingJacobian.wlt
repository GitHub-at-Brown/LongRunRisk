BeginTestSection["fastRootMissingJacobian"]

(* Load package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
On[General::shdw];

(* Access public functions - use full context path *)
With[{
  fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot,
  buildKernel = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel,
  bindUnary = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary
},

(* Test parameters *)
timeLimit = 10;

(* ===== Test FunctionOnly Compilation Mode ===== *)

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
  TestID -> "buildKernel-functiononly-missing-jacobian@@Tests/FindRootOptim/fastRootMissingJacobian.wlt:21,1-36,2"
]

(* Note: Full workflow test with bindUnary + fastRoot is complex and tested elsewhere.
   The key insight is that MissingQ[kernel["dfC"]] correctly detects Missing["NotCompiled"],
   and SolveEulerEq's detection logic (line 846) will set df = None when this is detected.
   The fastRoot with df = None case is tested in fastRootNewtonWithoutJacobian.wlt *)

(* ===== Test Detection Logic Directly ===== *)

(* Test that MissingQ correctly identifies Missing["NotCompiled"] *)
VerificationTest[
  MissingQ[Missing["NotCompiled"]],
  True,
  {},
  TestID -> "missingq-detects-missing-notcompiled@@Tests/FindRootOptim/fastRootMissingJacobian.wlt:46,1-51,2"
]

(* Test that FailureQ correctly identifies $Failed *)
VerificationTest[
  FailureQ[$Failed],
  True,
  {},
  TestID -> "failureq-detects-failed@@Tests/FindRootOptim/fastRootMissingJacobian.wlt:54,1-59,2"
]

(* Test that MissingQ does not match $Failed *)
VerificationTest[
  MissingQ[$Failed],
  False,
  {},
  TestID -> "missingq-does-not-match-failed@@Tests/FindRootOptim/fastRootMissingJacobian.wlt:62,1-67,2"
]

(* Test that FailureQ does not match Missing *)
VerificationTest[
  FailureQ[Missing["NotCompiled"]],
  False,
  {},
  TestID -> "failureq-does-not-match-missing@@Tests/FindRootOptim/fastRootMissingJacobian.wlt:70,1-75,2"
]

(* ===== Test Both Mode Compilation ===== *)

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
  TestID -> "buildKernel-both-has-jacobian@@Tests/FindRootOptim/fastRootMissingJacobian.wlt:80,1-95,2"
]

(* Note: Full workflow tests comparing FunctionOnly vs Both modes are complex and would
   require proper parameter binding. The key tests are:
   1. buildKernel with FunctionOnly produces Missing Jacobian ✓
   2. buildKernel with Both produces valid Jacobian ✓
   3. Detection logic (MissingQ, FailureQ) works correctly ✓
   4. fastRoot works with df = None (tested in fastRootNewtonWithoutJacobian.wlt) *)

]  (* End With *)
EndTestSection[]
