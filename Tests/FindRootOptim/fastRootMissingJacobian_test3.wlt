BeginTestSection["fastRootMissingJacobian"]

(* Test that FailureQ correctly identifies $Failed *)
VerificationTest[
  FailureQ[$Failed],
  True,
  {},
  TestID -> "failureq-detects-failed@@Tests/FindRootOptim/fastRootMissingJacobian_test3.wlt:4,1-9,2"
]

EndTestSection[]
