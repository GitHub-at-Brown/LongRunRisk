BeginTestSection["fastRootMissingJacobian"]

(* Test that MissingQ does not match $Failed *)
VerificationTest[
  MissingQ[$Failed],
  False,
  {},
  TestID -> "missingq-does-not-match-failed@@Tests/FindRootOptim/fastRootMissingJacobian_test4.wlt:4,1-9,2"
]

EndTestSection[]
