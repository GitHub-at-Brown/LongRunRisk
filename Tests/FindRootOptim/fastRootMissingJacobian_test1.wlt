BeginTestSection["fastRootMissingJacobian"]

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
  TestID -> "buildKernel-functiononly-missing-jacobian@@Tests/FindRootOptim/fastRootMissingJacobian_test1.wlt:14,1-29,2"
]

EndTestSection[]
