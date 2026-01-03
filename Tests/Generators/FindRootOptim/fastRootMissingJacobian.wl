(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/FindRootOptim/fastRootMissingJacobian.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`fastRootMissingJacobian`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["fastRootMissingJacobian Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`fastRootMissingJacobian`"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[buildKernel = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel; ],
    HoldComplete[timeLimit = 10; ],
    HoldComplete[VerificationTest[Module[{kernel, expr, vars, params}, expr = x^2 - A[0]; vars = {A[0]}; params = {x}; Block[{$ContextPath = Prepend[$ContextPath, "CCompilerDriver`"]}, kernel = buildKernel[expr, vars, params, CompileMode -> "FunctionOnly"]; MissingQ[kernel["dfC"]]]], True, {}, TimeConstraint -> timeLimit, TestID -> "buildKernel-functiononly-missing-jacobian@@Tests/FindRootOptim/fastRootMissingJacobian.wlt:16,1-31,2"]],
    HoldComplete[VerificationTest[MissingQ[Missing["NotCompiled"]], True, {}, TestID -> "missingq-detects-missing-notcompiled@@Tests/FindRootOptim/fastRootMissingJacobian.wlt:35,1-40,2"]],
    HoldComplete[VerificationTest[FailureQ[$Failed], True, {}, TestID -> "failureq-detects-failed@@Tests/FindRootOptim/fastRootMissingJacobian.wlt:44,1-49,2"]],
    HoldComplete[VerificationTest[MissingQ[$Failed], False, {}, TestID -> "missingq-does-not-match-failed@@Tests/FindRootOptim/fastRootMissingJacobian.wlt:53,1-58,2"]],
    HoldComplete[VerificationTest[FailureQ[Missing["NotCompiled"]], False, {}, TestID -> "failureq-does-not-match-missing@@Tests/FindRootOptim/fastRootMissingJacobian.wlt:62,1-67,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[buildKernel = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel; ],
    HoldComplete[timeLimit = 10; ],
    HoldComplete[VerificationTest[Module[{kernel, expr, vars, params}, expr = x^2 - A[0]; vars = {A[0]}; params = {x}; Block[{$ContextPath = Prepend[$ContextPath, "CCompilerDriver`"]}, kernel = buildKernel[expr, vars, params, CompileMode -> "Both"];  !MissingQ[kernel["dfC"]] &&  !FailureQ[kernel["dfC"]]]], True, {}, TimeConstraint -> timeLimit, TestID -> "buildKernel-both-has-jacobian@@Tests/FindRootOptim/fastRootMissingJacobian.wlt:81,1-96,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "fastRootMissingJacobian",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../FindRootOptim/fastRootMissingJacobian.wlt"
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
