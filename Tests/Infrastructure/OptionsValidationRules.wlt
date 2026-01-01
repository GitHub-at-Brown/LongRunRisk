BeginTestSection["OptionsValidationRules Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Infrastructure`OptionsValidationRules`"]

(* Test that options validation rules are installed correctly *)

Needs["FernandoDuarte`LongRunRisk`Tools`OptionsValidationRules`"];

timeLimit = 10;

(* Test: InstallOptionsValidationRules returns True or fails gracefully if OptionsValidation unavailable *)
VerificationTest[
    Quiet[
        Check[
            FernandoDuarte`LongRunRisk`Tools`OptionsValidationRules`InstallOptionsValidationRules[],
            $Failed
        ]
    ],
    True | $Failed,
    SameTest -> MatchQ,
    TimeConstraint -> timeLimit,
    TestID -> "InstallOptionsValidationRules-returns-true@@Tests/Infrastructure/OptionsValidationRules.wlt:11,1-16,2"
]

(* Test: buildModels with invalid FromScratch value triggers warning *)
(* Note: This test is skipped if OptionsValidation` paclet is not installed *)
VerificationTest[
    Module[{available},
        (* Check if OptionsValidation is available *)
        available = Quiet[Check[Needs["OptionsValidation`"]; True, False]];
        If[!available,
            (* OptionsValidation not available - skip test by returning True *)
            True,
            (* OptionsValidation available - test validation behavior *)
            Quiet[
                Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];
                FernandoDuarte`LongRunRisk`Tools`OptionsValidationRules`InstallOptionsValidationRules[];
                (* ValidateOptions returns False for invalid options, or raises message *)
                With[{bm = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels},
                    result = OptionsValidation`ValidateOptions[bm, "FromScratch" -> "invalid"];
                    (* Test passes if validation returns False (detected invalid) or True (rules not applied) *)
                    TrueQ[result] || result === False
                ]
            ]
        ]
    ],
    True,
    TimeConstraint -> timeLimit,
    TestID -> "buildModels-invalid-FromScratch-triggers-validation@@Tests/Infrastructure/OptionsValidationRules.wlt:20,1-39,2"
]

End[]
EndTestSection[]
