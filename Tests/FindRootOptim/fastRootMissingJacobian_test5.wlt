BeginTestSection["fastRootMissingJacobian"]

(* Test that FailureQ does not match Missing *)
VerificationTest[
  FailureQ[Missing["NotCompiled"]],
  False,
  {},
  TestID -> "failureq-does-not-match-missing@@Tests/FindRootOptim/fastRootMissingJacobian_test5.wlt:4,1-9,2"
]

EndTestSection[]
