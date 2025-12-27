BeginTestSection["fastRootMissingJacobian"]

(* Test that MissingQ correctly identifies Missing["NotCompiled"] *)
VerificationTest[
  MissingQ[Missing["NotCompiled"]],
  True,
  {},
  TestID -> "missingq-detects-missing-notcompiled@@Tests/FindRootOptim/fastRootMissingJacobian_test2.wlt:4,1-9,2"
]

EndTestSection[]
