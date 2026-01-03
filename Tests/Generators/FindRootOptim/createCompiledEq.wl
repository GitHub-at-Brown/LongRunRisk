(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/FindRootOptim/createCompiledEq.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`createCompiledEq`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["createCompiledEq Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`createCompiledEq`"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Head[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq], Symbol, TestID -> "createCompiledEq-symbol-exists@@Tests/FindRootOptim/createCompiledEq.wlt:16,1-20,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Head[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel], Symbol, TestID -> "buildKernel-symbol-exists@@Tests/FindRootOptim/createCompiledEq.wlt:34,1-38,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[StringQ[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq::usage], True, TestID -> "createCompiledEq-has-usage@@Tests/FindRootOptim/createCompiledEq.wlt:52,1-56,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[StringQ[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel::usage], True, TestID -> "buildKernel-has-usage@@Tests/FindRootOptim/createCompiledEq.wlt:70,1-74,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{opts, bk}, bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel; opts = Options[bk]; Length[opts] > 0], True, TestID -> "buildKernel-has-options@@Tests/FindRootOptim/createCompiledEq.wlt:88,1-96,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{opts, bk}, bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel; opts = Options[bk]; MemberQ[Keys[opts], "CoeffName"]], True, TestID -> "buildKernel-has-CoeffName-option@@Tests/FindRootOptim/createCompiledEq.wlt:110,1-118,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{opts, bk}, bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel; opts = Options[bk]; MemberQ[Keys[opts], "CompileSignSymbol"]], True, TestID -> "buildKernel-has-CompileSignSymbol-option@@Tests/FindRootOptim/createCompiledEq.wlt:132,1-140,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{opts, bk}, bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel; opts = Options[bk]; MemberQ[Keys[opts], "PerformanceGoal"]], True, TestID -> "buildKernel-has-PerformanceGoal-option@@Tests/FindRootOptim/createCompiledEq.wlt:154,1-162,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{opts, bk}, bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel; opts = Options[bk]; MemberQ[Keys[opts], "CompileMode"]], True, TestID -> "buildKernel-has-CompileMode-option@@Tests/FindRootOptim/createCompiledEq.wlt:176,1-184,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{bk}, bk = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel; OptionValue[bk, {"CompileMode" -> "FunctionOnly"}, "CompileMode"]], "FunctionOnly", TestID -> "buildKernel-CompileMode-explicit-is-respected@@Tests/FindRootOptim/createCompiledEq.wlt:198,1-205,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{cce}, cce = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq; MatchQ[Head[cce], Symbol]], True, TestID -> "createCompiledEq-accepts-buildKernel-options@@Tests/FindRootOptim/createCompiledEq.wlt:219,1-230,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "createCompiledEq",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../FindRootOptim/createCompiledEq.wlt"
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
