(* Fake failing test to verify CI artifact and summary display *)

VerificationTest[
    1 + 1,
    3,
    TestID -> "FakeFailingTest-Arithmetic"
]

VerificationTest[
    "hello",
    "world",
    TestID -> "FakeFailingTest-String"
]
