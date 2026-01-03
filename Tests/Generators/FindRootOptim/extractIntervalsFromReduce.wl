(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/FindRootOptim/extractIntervalsFromReduce.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`extractIntervalsFromReduce`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["extractIntervalsFromReduce Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`extractIntervalsFromReduce`"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[VerificationTest[eir[x > 10 || 1 < x < 2, x, "InteriorShrink" -> 0], {{1., 2.}, {10., 15.}}, TestID -> "mixed-two-sided-and-upper-fallback@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:13,1-17,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[VerificationTest[eir[x == 3 || x > 10, x, "InteriorShrink" -> 0], {{3., 3.}, {10., 15.}}, TestID -> "single-point-and-upper-fallback@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:28,1-32,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[VerificationTest[eir[x > 20 || 1 < x < 2, x, "InteriorShrink" -> 0, "RootUpperBound" -> 15], {{1., 2.}}, TestID -> "drops-above-upper-bound-clause@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:43,1-47,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[VerificationTest[eir[x < -1, x, "InteriorShrink" -> 0, "RootUpperBound" -> 10], {}, {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce::nointervals}, TestID -> "drops-below-zero-clause-and-returns-empty@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:58,1-63,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[VerificationTest[eir[0 < x < 0.0015, x, "InteriorShrink" -> 0.001, "RootUpperBound" -> 1], {{0.00075, 0.00075}}, TestID -> "collapses-narrow-interval-to-midpoint@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:74,1-78,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[VerificationTest[eir[True, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 5], {{0.2, 4.8}}, SameTest -> (Max[Abs[Flatten[#1] - Flatten[#2]]] < 10^(-10) & ), TestID -> "true-branch-full-range@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:89,1-94,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[VerificationTest[eir[False, x], {}, {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce::nointervals}, TestID -> "false-branch-empty@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:105,1-110,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[VerificationTest[eir[x > 1, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 5], {{1.1, 4.9}}, TestID -> "one-sided-lower-clamped-to-upper@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:121,1-125,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[VerificationTest[eir[x > 4.9, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 5], {{4.95, 4.95}}, TestID -> "one-sided-near-upper-clamps-and-collapses@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:136,1-140,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[VerificationTest[eir[2 < x < 2.2, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 10], {{2.1, 2.1}}, TestID -> "width-equal-2xshrink-collapses-to-midpoint@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:151,1-155,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[VerificationTest[eir[1 < x < 3, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 10], {{1.1, 2.9}}, TestID -> "wide-interval-applies-shrink@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:166,1-170,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[VerificationTest[eir[(x >= 4 && x <= 4.2) || 1 <= x <= 2 || x >= 10, x, "InteriorShrink" -> 0], {{1., 2.}, {4., 4.2}, {10., 15.}}, TestID -> "open-closed-mix-and-sorting@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:181,1-185,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[VerificationTest[eir[x > 20, x, "RootUpperBound" -> 15], {}, {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce::nointervals}, TestID -> "all-clauses-dropped-empty@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:196,1-201,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[VerificationTest[eir[Inequality[0, Less, B[1][0], LessEqual, 6.059], B[1][0], "InteriorShrink" -> 0], {{0., 6.059}}, TestID -> "indexed-variable-head-extracts-bound@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:215,1-219,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[VerificationTest[eir[Inequality[0, Less, B[1][0], LessEqual, 6.059], B[j][0], "InteriorShrink" -> 0], {{0., 15.}}, TestID -> "mismatched-indexed-variable-returns-default@@Tests/FindRootOptim/extractIntervalsFromReduce.wlt:234,1-238,4"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "extractIntervalsFromReduce",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../FindRootOptim/extractIntervalsFromReduce.wlt"
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
