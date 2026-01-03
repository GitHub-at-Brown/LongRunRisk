(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/FindRootOptim/normalizeExpNested.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`normalizeExpNested`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["normalizeExpNested Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`normalizeExpNested`"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]; ],
    HoldComplete[VerificationTest[f[E^a*E^b], Exp[a]*Exp[b], TimeConstraint -> timeLimit, TestID -> "multiple-E-powers-in-product@@Tests/FindRootOptim/normalizeExpNested.wlt:12,1-17,6"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]; ],
    HoldComplete[VerificationTest[f[E^a + E^b + E^c], Exp[a] + Exp[b] + Exp[c], TimeConstraint -> timeLimit, TestID -> "multiple-E-powers-in-sum@@Tests/FindRootOptim/normalizeExpNested.wlt:27,1-32,6"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]; ],
    HoldComplete[VerificationTest[f[E^E^a], Exp[Exp[a]], TimeConstraint -> timeLimit, TestID -> "doubly-nested-E-power@@Tests/FindRootOptim/normalizeExpNested.wlt:42,1-47,6"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]; ],
    HoldComplete[VerificationTest[f[E^E^E^a], Exp[Exp[Exp[a]]], TimeConstraint -> timeLimit, TestID -> "triply-nested-E-power@@Tests/FindRootOptim/normalizeExpNested.wlt:57,1-62,6"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]; ],
    HoldComplete[VerificationTest[f[Sin[E^a] + Cos[E^b]], Sin[Exp[a]] + Cos[Exp[b]], TimeConstraint -> timeLimit, TestID -> "E-powers-inside-trigonometric-functions@@Tests/FindRootOptim/normalizeExpNested.wlt:72,1-77,6"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]; ],
    HoldComplete[VerificationTest[f[Log[E^a*E^b]], Log[Exp[a]*Exp[b]], TimeConstraint -> timeLimit, TestID -> "E-powers-inside-Log@@Tests/FindRootOptim/normalizeExpNested.wlt:87,1-92,6"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]; ],
    HoldComplete[VerificationTest[f[(E^a)[x]*(E^b)[y]], Exp[a[x]]*Exp[b[y]], TimeConstraint -> timeLimit, TestID -> "multiple-E-function-applications@@Tests/FindRootOptim/normalizeExpNested.wlt:102,1-107,6"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]; ],
    HoldComplete[VerificationTest[f[E^(a[x] + b[x])*E^c[y]], Exp[a[x] + b[x]]*Exp[c[y]], TimeConstraint -> timeLimit, TestID -> "mixed-complex-exponents-in-product@@Tests/FindRootOptim/normalizeExpNested.wlt:117,1-122,6"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]; ],
    HoldComplete[VerificationTest[f[1 + E^a + E^E^b + (E^c)[x]], 1 + Exp[a] + Exp[Exp[b]] + Exp[c[x]], TimeConstraint -> timeLimit, TestID -> "deeply-nested-multiple-E-forms@@Tests/FindRootOptim/normalizeExpNested.wlt:132,1-137,6"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]; ],
    HoldComplete[VerificationTest[f[f1[E^a, E^b] + f2[(E^c)[x], E^E^d]], f1[Exp[a], Exp[b]] + f2[Exp[c[x]], Exp[Exp[d]]], TimeConstraint -> timeLimit, TestID -> "E-forms-in-function-arguments@@Tests/FindRootOptim/normalizeExpNested.wlt:147,1-152,6"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]; ],
    HoldComplete[VerificationTest[f[{E^a, {E^b, E^E^c}}], {Exp[a], {Exp[b], Exp[Exp[c]]}}, TimeConstraint -> timeLimit, TestID -> "E-forms-in-nested-lists@@Tests/FindRootOptim/normalizeExpNested.wlt:162,1-167,6"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]; ],
    HoldComplete[VerificationTest[f[(E^a)[x] + E^b[y]], Exp[a[x]] + Exp[b[y]], TimeConstraint -> timeLimit, TestID -> "mixed-application-and-standard-power@@Tests/FindRootOptim/normalizeExpNested.wlt:177,1-182,6"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]; ],
    HoldComplete[VerificationTest[f[E^(a*E^b)], Exp[a*Exp[b]], TimeConstraint -> timeLimit, TestID -> "E-power-in-exponent-expression@@Tests/FindRootOptim/normalizeExpNested.wlt:192,1-197,6"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]; ],
    HoldComplete[VerificationTest[f[E^a/E^b], Exp[a]/Exp[b], TimeConstraint -> timeLimit, TestID -> "E-powers-in-division@@Tests/FindRootOptim/normalizeExpNested.wlt:207,1-212,6"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[f = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp"]; ],
    HoldComplete[VerificationTest[f[(E^a)^2], Exp[a]^2, TimeConstraint -> timeLimit, TestID -> "E-power-raised-to-power@@Tests/FindRootOptim/normalizeExpNested.wlt:222,1-227,6"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "normalizeExpNested",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../FindRootOptim/normalizeExpNested.wlt"
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
