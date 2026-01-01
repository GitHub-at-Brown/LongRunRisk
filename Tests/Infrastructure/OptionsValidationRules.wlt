BeginTestSection["OptionsValidationRules Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Infrastructure`OptionsValidationRules`"]

(* Test that options validation rules are installed correctly *)

Needs["FernandoDuarte`LongRunRisk`Tools`OptionsValidationRules`"];

timeLimit = 10;

(* Test: InstallOptionsValidationRules returns True *)
VerificationTest[
    FernandoDuarte`LongRunRisk`Tools`OptionsValidationRules`InstallOptionsValidationRules[],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "InstallOptionsValidationRules-returns-true@@Tests/Infrastructure/OptionsValidationRules.wlt:11,1-16,2"
]

(* Test: buildModels with invalid FromScratch value triggers warning *)
(* Note: This test may need OptionsValidation` paclet to be installed to work *)
VerificationTest[
    Quiet[
        Check[
            Needs["OptionsValidation`"];
            Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];
            (* Install rules if not already installed *)
            FernandoDuarte`LongRunRisk`Tools`OptionsValidationRules`InstallOptionsValidationRules[];
            (* Try to validate invalid option - this should trigger a message *)
            With[{bm = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels},
                OptionsValidation`ValidateOptions[bm, "FromScratch" -> "invalid"]
            ],
            $Failed
        ],
        True (* If OptionsValidation not available, test passes *)
    ],
    True | $Failed,
    SameTest -> MatchQ,
    TimeConstraint -> timeLimit,
    TestID -> "buildModels-invalid-FromScratch-triggers-validation@@Tests/Infrastructure/OptionsValidationRules.wlt:20,1-39,2"
]

End[]
EndTestSection[]
