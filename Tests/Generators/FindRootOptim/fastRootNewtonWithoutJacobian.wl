(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`fastRootNewtonWithoutJacobian`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["fastRootNewtonWithoutJacobian Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot; ],
    HoldComplete[timeLimit = 10; ],
    HoldComplete[f1D[z_] := z[[1]]^2 - 4; ],
    HoldComplete[VerificationTest[Module[{result}, result = fastRoot[f1D, {1.5, 3.}, "Return" -> "Value"]; NumericQ[result] && Abs[result^2 - 4] < 10^(-6)], True, {}, TimeConstraint -> timeLimit, TestID -> "1d-quadratic-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:18,1-28,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot; ],
    HoldComplete[timeLimit = 10; ],
    HoldComplete[fCubic[z_] := z[[1]]^3 - 8; ],
    HoldComplete[VerificationTest[Module[{result}, result = fastRoot[fCubic, {1.5, 3.}, "Return" -> "Value"]; NumericQ[result] && Abs[result^3 - 8] < 10^(-6)], True, {}, TimeConstraint -> timeLimit, TestID -> "1d-cubic-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:44,1-53,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot; ],
    HoldComplete[timeLimit = 10; ],
    HoldComplete[fTranscendental[z_] := Cos[z[[1]]] - 0.5; ],
    HoldComplete[VerificationTest[Module[{result}, result = fastRoot[fTranscendental, {0.5, 1.5}, "Return" -> "Value"]; NumericQ[result] && Abs[Cos[result] - 0.5] < 10^(-6)], True, {}, TimeConstraint -> timeLimit, TestID -> "1d-transcendental-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:69,1-78,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot; ],
    HoldComplete[timeLimit = 10; ],
    HoldComplete[fExp[z_] := Exp[z[[1]]] - 3; ],
    HoldComplete[VerificationTest[Module[{result}, result = fastRoot[fExp, {0.5, 1.5}, "Return" -> "Value"]; NumericQ[result] && Abs[Exp[result] - 3] < 10^(-6)], True, {}, TimeConstraint -> timeLimit, TestID -> "1d-exponential-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:94,1-103,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot; ],
    HoldComplete[timeLimit = 10; ],
    HoldComplete[f1D[z_] := z[[1]]^2 - 4; ],
    HoldComplete[VerificationTest[Module[{result}, result = fastRoot[f1D, {1.5, 3.}, Method -> Automatic, "Return" -> "Value"]; NumericQ[result] && Abs[result^2 - 4] < 10^(-6)], True, {}, TimeConstraint -> timeLimit, TestID -> "newton-automatic-1d-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:120,1-130,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot; ],
    HoldComplete[timeLimit = 10; ],
    HoldComplete[f1D[z_] := z[[1]]^2 - 4; ],
    HoldComplete[VerificationTest[Module[{result}, result = fastRoot[f1D, {1.5, 3.}, Method -> "Newton", "Return" -> "Value"]; NumericQ[result] && Abs[result^2 - 4] < 10^(-6)], True, {}, TimeConstraint -> timeLimit, TestID -> "newton-explicit-1d-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:146,1-156,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot; ],
    HoldComplete[timeLimit = 10; ],
    HoldComplete[f1DJac[z_] := z[[1]]^2 - 4; ],
    HoldComplete[df1DJac[z_] := {2*z[[1]]}; ],
    HoldComplete[VerificationTest[Module[{result}, result = fastRoot[f1DJac, {1.5, 3.}, Jacobian -> df1DJac, "Return" -> "Value"]; NumericQ[result] && Abs[result^2 - 4] < 10^(-6)], True, {}, TimeConstraint -> timeLimit, TestID -> "1d-with-explicit-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:173,1-183,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot; ],
    HoldComplete[timeLimit = 10; ],
    HoldComplete[fMultiRoot[z_] := (z[[1]] - 1)*(z[[1]] - 2)*(z[[1]] - 3); ],
    HoldComplete[VerificationTest[Module[{result}, result = fastRoot[fMultiRoot, {1.2, 1.8}, "Return" -> "Value"]; NumericQ[result] && (Abs[result - 1] < 10^(-6) || Abs[result - 2] < 10^(-6))], True, {}, TimeConstraint -> timeLimit, TestID -> "multiple-roots-finds-one@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:199,1-209,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot; ],
    HoldComplete[timeLimit = 10; ],
    HoldComplete[fSteep[z_] := z[[1]]^10 - 1024; ],
    HoldComplete[VerificationTest[Module[{result}, result = fastRoot[fSteep, {1.5, 2.5}, "Return" -> "Value"]; NumericQ[result] && Abs[result^10 - 1024] < 10^(-4)], True, {}, TimeConstraint -> timeLimit, TestID -> "steep-gradient-without-jacobian@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:225,1-234,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[fastRoot = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`fastRoot; ],
    HoldComplete[timeLimit = 10; ],
    HoldComplete[f1D[z_] := z[[1]]^2 - 4; ],
    HoldComplete[VerificationTest[Module[{result1, result2}, result1 = fastRoot[f1D, {1.5, 2.5}, "Return" -> "Value"]; result2 = fastRoot[f1D, {-3., -1.5}, "Return" -> "Value"]; NumericQ[result1] && NumericQ[result2] && Abs[result1 - 2] < 10^(-6) && Abs[result2 - -2] < 10^(-6)], True, {}, TimeConstraint -> timeLimit, TestID -> "different-starting-points@@Tests/FindRootOptim/fastRootNewtonWithoutJacobian.wlt:250,1-263,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "fastRootNewtonWithoutJacobian",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../FindRootOptim/fastRootNewtonWithoutJacobian.wlt"
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
