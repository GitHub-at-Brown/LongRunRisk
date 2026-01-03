(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/FindRootOptim/scanAndSolveOptions.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`scanAndSolveOptions`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["scanAndSolveOptions Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`scanAndSolveOptions`"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[sas = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`scanAndSolve"]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{f, result}, f[z_] := (z[[1]] - 2.5)^2; result = sas[f, {2., 3.}, "BracketGrid" -> 32, AccuracyGoal -> 8]; Length[result] > 0 && result[[1]] >= 2. && result[[1]] <= 3.], True, TimeConstraint -> timeLimit, TestID -> "derivative-free-grid-hit@@Tests/FindRootOptim/scanAndSolveOptions.wlt:21,1-33,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[sas = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`scanAndSolve"]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{f, result}, f[z_] := z[[1]] - 2.5; result = sas[f, {2., 3.}, "BracketGrid" -> 16, AccuracyGoal -> 8]; Length[result] == 1 && Abs[result[[1]] - 2.5] < 10^(-6)], True, TimeConstraint -> timeLimit, TestID -> "derivative-free-finds-zero@@Tests/FindRootOptim/scanAndSolveOptions.wlt:52,1-61,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[sas = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`scanAndSolve"]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{f, df, result1, result2}, f[z_] := Sin[10*z[[1]]]; df[z_] := 10*Cos[10*z[[1]]]; result1 = sas[f, df, {0., 1.}, "BracketGrid" -> 8, AccuracyGoal -> 6]; result2 = sas[f, df, {0., 1.}, "BracketGrid" -> 64, AccuracyGoal -> 6]; Length[result2] >= Length[result1]], True, TimeConstraint -> timeLimit, TestID -> "custom-bracket-grid-coarse-vs-fine@@Tests/FindRootOptim/scanAndSolveOptions.wlt:80,1-93,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[sas = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`scanAndSolve"]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{f, df, result}, f[z_] := (z[[1]] - 1.5)*(z[[1]] - 2.5); df[z_] := 2*z[[1]] - 4.; result = sas[f, df, {1., 3.}, "BracketGrid" -> 4, AccuracyGoal -> 8]; Length[result] == 2 && Min[Abs[result[[1]] - 1.5], Abs[result[[1]] - 2.5]] < 10^(-6) && Min[Abs[result[[2]] - 1.5], Abs[result[[2]] - 2.5]] < 10^(-6)], True, TimeConstraint -> timeLimit, TestID -> "custom-bracket-grid-very-coarse@@Tests/FindRootOptim/scanAndSolveOptions.wlt:112,1-125,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[sas = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`scanAndSolve"]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{f, result}, f[z_] := (z[[1]] - 2.5)^4; result = sas[f, {2., 3.}, "BracketGrid" -> 32, "Tolerance" -> 10^(-12), AccuracyGoal -> 8]; Length[result] <= 1], True, TimeConstraint -> timeLimit, TestID -> "custom-tolerance-tight@@Tests/FindRootOptim/scanAndSolveOptions.wlt:144,1-158,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[sas = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`scanAndSolve"]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{f, result}, f[z_] := (z[[1]] - 2.5)^2; result = sas[f, {2., 3.}, "BracketGrid" -> 16, "Tolerance" -> 0.01, AccuracyGoal -> 8]; Length[result] >= 1], True, TimeConstraint -> timeLimit, TestID -> "custom-tolerance-relaxed@@Tests/FindRootOptim/scanAndSolveOptions.wlt:177,1-189,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[sas = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`scanAndSolve"]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{f, df, result}, f[z_] := Sin[z[[1]]]; df[z_] := Cos[z[[1]]]; result = sas[f, df, {3., 3.2}, "BracketGrid" -> 32, "Tolerance" -> 10^(-6), AccuracyGoal -> 8]; Length[result] == 1 && Abs[result[[1]] - Pi] < 10^(-6)], True, TimeConstraint -> timeLimit, TestID -> "tolerance-deduplication-single-root@@Tests/FindRootOptim/scanAndSolveOptions.wlt:208,1-221,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[sas = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`scanAndSolve"]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{f, df, result}, f[z_] := (z[[1]] - 1.)*(z[[1]] - 2.)*(z[[1]] - 3.); df[z_] := (z[[1]] - 2.)*(z[[1]] - 3.) + (z[[1]] - 1.)*(z[[1]] - 3.) + (z[[1]] - 1.)*(z[[1]] - 2.); result = sas[f, df, {0.5, 3.5}, "BracketGrid" -> 64, "Tolerance" -> 10^(-8), AccuracyGoal -> 8]; Length[result] == 3 && Abs[result[[1]] - 1.] < 10^(-6) && Abs[result[[2]] - 2.] < 10^(-6) && Abs[result[[3]] - 3.] < 10^(-6)], True, TimeConstraint -> timeLimit, TestID -> "tolerance-deduplication-multiple-roots@@Tests/FindRootOptim/scanAndSolveOptions.wlt:240,1-254,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[sas = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`scanAndSolve"]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{f, df, result}, f[z_] := (z[[1]] - 2.5)^2 + 10^(-6); df[z_] := 2*(z[[1]] - 2.5); result = sas[f, df, {2., 3.}, "BracketGrid" -> 32, AccuracyGoal -> 8, "Tolerance" -> 10^(-8)]; Length[result] == 0], True, TimeConstraint -> timeLimit, TestID -> "derivative-no-sign-change-no-hits@@Tests/FindRootOptim/scanAndSolveOptions.wlt:273,1-286,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[sas = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`scanAndSolve"]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{f, df, result}, f[z_] := (z[[1]] - 2.5)^2; df[z_] := 2*(z[[1]] - 2.5); result = sas[f, df, {2., 3.}, "BracketGrid" -> 32, AccuracyGoal -> 8, "Tolerance" -> 10^(-6)]; Length[result] >= 1 && Abs[result[[1]] - 2.5] < 0.1], True, TimeConstraint -> timeLimit, TestID -> "derivative-no-sign-change-with-grid-hit@@Tests/FindRootOptim/scanAndSolveOptions.wlt:305,1-319,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[sas = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`scanAndSolve"]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{f, result}, f[z_] := (z[[1]] - 2.5)^2 + 1.; result = sas[f, {2., 3.}, "BracketGrid" -> 16, AccuracyGoal -> 8]; Length[result] == 0], True, TimeConstraint -> timeLimit, TestID -> "derivative-free-no-hits-no-sign-change@@Tests/FindRootOptim/scanAndSolveOptions.wlt:338,1-349,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[sas = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`scanAndSolve"]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{f, result1, result2}, f[z_] := (z[[1]] - 2.5)^2 + 10^(-7); result1 = sas[f, {2., 3.}, "BracketGrid" -> 32, AccuracyGoal -> 6]; result2 = sas[f, {2., 3.}, "BracketGrid" -> 32, AccuracyGoal -> 8]; Length[result1] > Length[result2]], True, TimeConstraint -> timeLimit, TestID -> "accuracy-goal-affects-automatic-tolerance@@Tests/FindRootOptim/scanAndSolveOptions.wlt:368,1-383,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[sas = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`scanAndSolve"]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{f, df, result}, f[z_] := Sin[2*Pi*z[[1]]]; df[z_] := 2*Pi*Cos[2*Pi*z[[1]]]; result = sas[f, df, {0., 2.5}, "BracketGrid" -> 50, "Tolerance" -> 10^(-6), AccuracyGoal -> 8]; Length[result] >= 4 && Length[result] <= 6], True, TimeConstraint -> timeLimit, TestID -> "multiple-roots-custom-options@@Tests/FindRootOptim/scanAndSolveOptions.wlt:402,1-414,4"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "scanAndSolveOptions",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../FindRootOptim/scanAndSolveOptions.wlt"
};

(* --- internal helpers --- *)
testExprQ[HoldComplete[VerificationTest[___]]] := True;
testExprQ[HoldComplete[TestCreate[___]]] := True;
testExprQ[HoldComplete[IntermediateTest[___]]] := True;
testExprQ[_] := False;

hasOptionQ[hc_HoldComplete, sym_Symbol] := !FreeQ[hc, HoldPattern[(sym -> _) | (sym :> _)]];

removeOption[hc_HoldComplete, sym_Symbol] :=
    FixedPoint[
        ReplaceAll[
            #,
            HoldComplete[head_[pre___, (sym -> _) | (sym :> _), post___]] :> HoldComplete[head[pre, post]]
        ] &,
        hc
    ];

appendOption[hc_HoldComplete, rule_] := hc /. HoldComplete[head_[args___]] :> HoldComplete[head[args, rule]];

convertTestHead[hc_HoldComplete, Automatic] := hc;
convertTestHead[hc_HoldComplete, newHead_Symbol] :=
    hc /. HoldComplete[(VerificationTest | TestCreate | IntermediateTest)[args___]] :> HoldComplete[newHead[args]];

stripForHash[hc_HoldComplete] := removeOption[removeOption[hc, TestID], TimeConstraint];

shortHash[hc_HoldComplete, n_Integer?Positive] :=
    Module[{h = IntegerString[Hash[stripForHash[hc], "SHA256"], 36]}, StringTake[h, UpTo[n]]];

makeTestID[prefix_String, key_String, occ_Integer] :=
    If[occ <= 1, StringJoin[prefix, "-", key], StringJoin[prefix, "-", key, "-", IntegerString[occ]]];

ensureTestID[hc_HoldComplete, id_, preserveQ_] :=
    Module[{out = hc},
        If[preserveQ && hasOptionQ[out, TestID], Return[out]];
        out = removeOption[out, TestID];
        appendOption[out, TestID -> id]
    ];

ensureTimeConstraint[hc_HoldComplete, tc_, preserveQ_] :=
    Module[{out = hc},
        If[preserveQ && hasOptionQ[out, TimeConstraint], Return[out]];
        out = removeOption[out, TimeConstraint];
        appendOption[out, TimeConstraint -> tc]
    ];

transformTest[hc_HoldComplete, id_, opts:OptionsPattern[GenerateWLT]] :=
    Module[{out = hc, head, tc, keepID, keepTC},
        head  = OptionValue["OutputTestHead"];
        tc    = OptionValue["DefaultTimeConstraint"];
        keepID = TrueQ @ OptionValue["PreserveExistingTestIDs"];
        keepTC = TrueQ @ OptionValue["PreserveExistingTimeConstraints"];
        out = convertTestHead[out, head];
        out = ensureTestID[out, id, keepID];
        out = ensureTimeConstraint[out, tc, keepTC];
        out
    ];

stripHold[HoldComplete[e_]] :=
    Module[{s = ToString[HoldForm[e], InputForm, PageWidth -> Infinity]},
        If[StringStartsQ[s, "HoldForm["] && StringEndsQ[s, "]"], StringTake[s, {10, -2}], s]
    ];

writeHeldExpressions[file_String, exprs_List] :=
    Module[{res},
        res = Quiet@Check[Export[file, exprs, "HeldExpressions"], $Failed];
        If[res === $Failed,
            Export[file, StringRiffle[stripHold /@ exprs, "\n\n"], "Text"];
        ];
        file
    ];

defaultTarget[opts:OptionsPattern[GenerateWLT]] :=
    Module[{rel = OptionValue["TargetRelativeWLTPath"], here},
        here = If[StringQ[$InputFileName] && $InputFileName =!= "", DirectoryName[$InputFileName], Directory[]];
        ExpandFileName @ FileNameJoin[{here, rel}]
    ];

GenerateWLT[target_: Automatic, opts:OptionsPattern[]] :=
    Module[{outFile, outExprs, seen = <||>, prefix, n, key, occ, id},
        outFile = Replace[target, Automatic :> defaultTarget[opts]];
        CreateDirectory[DirectoryName[outFile], CreateIntermediateDirectories -> True];
        prefix = OptionValue["TestIDPrefix"];
        prefix = If[StringQ[prefix], prefix, ToString[prefix, InputForm]];
        n = OptionValue["HashLength"];
        n = If[IntegerQ[n] && n > 0, n, 8];
        outExprs = Map[
            Function[hc,
                If[testExprQ[hc],
                    key = shortHash[hc, n];
                    occ = Lookup[seen, key, 0] + 1;
                    seen[key] = occ;
                    id = makeTestID[prefix, key, occ];
                    transformTest[hc, id, opts],
                    hc
                ]
            ],
            $sourceExpressions
        ];
        writeHeldExpressions[outFile, outExprs];
        outFile
    ];

End[];
EndPackage[];
