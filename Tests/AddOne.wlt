VerificationTest[$pacletDir = DirectoryName[$TestFileName, 2], _?DirectoryQ,
     SameTest -> MatchQ, TestID -> "AddOne-PacletDirectory"]

VerificationTest[PacletDirectoryLoad @ $pacletDir, {___, $pacletDir, 
    ___}, SameTest -> MatchQ, TestID -> "AddOne-PacletDirectoryLoad"]

VerificationTest[Needs["FernandoDuarte`LongRunRisk`"], Null, TestID ->
     "AddOne-Needs"]

VerificationTest[Context @ AddOne, "FernandoDuarte`LongRunRisk`", TestID
     -> "AddOne-Context"]

VerificationTest[AddOne @ 1, 2, TestID -> "AddOne-1"]

VerificationTest[AddOne @ 2, 3, TestID -> "AddOne-2"]
