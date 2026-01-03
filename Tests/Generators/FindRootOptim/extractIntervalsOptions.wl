(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/FindRootOptim/extractIntervalsOptions.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`extractIntervalsOptions`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["extractIntervalsOptions Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`extractIntervalsOptions`"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce; ],
    HoldComplete[tolSameTest = Max[Abs[Flatten[#1 - #2]]] < 10^(-10) & ; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[eir[1 < x < 5, x, "InteriorShrink" -> 0.5, "RootUpperBound" -> 10], {{1.5, 4.5}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "large-shrink-wide-interval@@Tests/FindRootOptim/extractIntervalsOptions.wlt:12,1-18,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce; ],
    HoldComplete[tolSameTest = Max[Abs[Flatten[#1 - #2]]] < 10^(-10) & ; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[eir[1 < x < 2, x, "InteriorShrink" -> 0.5, "RootUpperBound" -> 10], {{1.5, 1.5}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "large-shrink-collapses-narrow-interval@@Tests/FindRootOptim/extractIntervalsOptions.wlt:28,1-34,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce; ],
    HoldComplete[tolSameTest = Max[Abs[Flatten[#1 - #2]]] < 10^(-10) & ; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[eir[x > 0, x, "InteriorShrink" -> 2, "RootUpperBound" -> 10], {{2., 8.}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "shrink-two-upperbound-ten@@Tests/FindRootOptim/extractIntervalsOptions.wlt:44,1-50,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce; ],
    HoldComplete[tolSameTest = Max[Abs[Flatten[#1 - #2]]] < 10^(-10) & ; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[eir[x > 0, x, "InteriorShrink" -> 4.9, "RootUpperBound" -> 10], {{4.9, 5.1}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "shrink-nearly-half-upperbound-collapses@@Tests/FindRootOptim/extractIntervalsOptions.wlt:60,1-66,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce; ],
    HoldComplete[tolSameTest = Max[Abs[Flatten[#1 - #2]]] < 10^(-10) & ; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[eir[0.5 < x < 1.5 || 3 < x < 6, x, "InteriorShrink" -> 0.25, "RootUpperBound" -> 8], {{0.75, 1.25}, {3.25, 5.75}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "two-intervals-different-collapse-behavior@@Tests/FindRootOptim/extractIntervalsOptions.wlt:76,1-82,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce; ],
    HoldComplete[tolSameTest = Max[Abs[Flatten[#1 - #2]]] < 10^(-10) & ; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[eir[x > 0, x, "InteriorShrink" -> 0.0001, "RootUpperBound" -> 2], {{0.0001, 1.9999}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "very-small-shrink-small-upperbound@@Tests/FindRootOptim/extractIntervalsOptions.wlt:92,1-98,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce; ],
    HoldComplete[tolSameTest = Max[Abs[Flatten[#1 - #2]]] < 10^(-10) & ; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[eir[x > 0, x, "InteriorShrink" -> 0, "RootUpperBound" -> 100], {{0., 100.}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "zero-shrink-large-upperbound@@Tests/FindRootOptim/extractIntervalsOptions.wlt:108,1-114,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce; ],
    HoldComplete[tolSameTest = Max[Abs[Flatten[#1 - #2]]] < 10^(-10) & ; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[eir[x > 5 || 0 < x < 1, x, "InteriorShrink" -> 0.2, "RootUpperBound" -> 20], {{0.2, 0.8}, {5.2, 19.8}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "mixed-bounded-unbounded-custom-options@@Tests/FindRootOptim/extractIntervalsOptions.wlt:124,1-130,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce; ],
    HoldComplete[tolSameTest = Max[Abs[Flatten[#1 - #2]]] < 10^(-10) & ; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[eir[1 < x < 2 || 3 < x < 4 || 5 < x < 6, x, "InteriorShrink" -> 0.4, "RootUpperBound" -> 10], {{1.4, 1.6}, {3.4, 3.6}, {5.4, 5.6}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "three-intervals-mixed-collapse@@Tests/FindRootOptim/extractIntervalsOptions.wlt:140,1-146,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce; ],
    HoldComplete[tolSameTest = Max[Abs[Flatten[#1 - #2]]] < 10^(-10) & ; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[eir[0.1 < x < 0.3, x, "InteriorShrink" -> 0.05, "RootUpperBound" -> 5], {{0.15, 0.25}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "small-interval-small-shrink-no-collapse@@Tests/FindRootOptim/extractIntervalsOptions.wlt:156,1-162,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce; ],
    HoldComplete[tolSameTest = Max[Abs[Flatten[#1 - #2]]] < 10^(-10) & ; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[eir[0.1 < x < 0.2, x, "InteriorShrink" -> 0.05, "RootUpperBound" -> 5], {{0.15, 0.15}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "small-interval-small-shrink-collapses@@Tests/FindRootOptim/extractIntervalsOptions.wlt:172,1-178,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce; ],
    HoldComplete[tolSameTest = Max[Abs[Flatten[#1 - #2]]] < 10^(-10) & ; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[eir[x > 18, x, "InteriorShrink" -> 1, "RootUpperBound" -> 20], {{19., 19.}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "near-upperbound-with-shrink-collapses@@Tests/FindRootOptim/extractIntervalsOptions.wlt:188,1-194,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce; ],
    HoldComplete[tolSameTest = Max[Abs[Flatten[#1 - #2]]] < 10^(-10) & ; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[eir[x == 5 || x > 10, x, "InteriorShrink" -> 0.5, "RootUpperBound" -> 15], {{5., 5.}, {10.5, 14.5}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "point-and-unbounded-custom-options@@Tests/FindRootOptim/extractIntervalsOptions.wlt:204,1-210,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce; ],
    HoldComplete[tolSameTest = Max[Abs[Flatten[#1 - #2]]] < 10^(-10) & ; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[eir[x > 0, x, "InteriorShrink" -> 1.5, "RootUpperBound" -> 3], {{1.5, 1.5}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "shrink-equals-half-upperbound-collapses@@Tests/FindRootOptim/extractIntervalsOptions.wlt:220,1-226,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce; ],
    HoldComplete[tolSameTest = Max[Abs[Flatten[#1 - #2]]] < 10^(-10) & ; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[eir[0.5 < x < 2 || 10 < x < 15, x, "InteriorShrink" -> 0.3, "RootUpperBound" -> 12], {{0.8, 1.7}, {10.3, 11.7}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "second-interval-clipped-by-upperbound@@Tests/FindRootOptim/extractIntervalsOptions.wlt:236,1-242,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce; ],
    HoldComplete[tolSameTest = Max[Abs[Flatten[#1 - #2]]] < 10^(-10) & ; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[eir[x > 0, x, "InteriorShrink" -> 0.01, "RootUpperBound" -> 50], {{0.01, 49.99}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "small-shrink-large-upperbound@@Tests/FindRootOptim/extractIntervalsOptions.wlt:252,1-258,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce; ],
    HoldComplete[tolSameTest = Max[Abs[Flatten[#1 - #2]]] < 10^(-10) & ; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[eir[Inequality[0, Less, x, LessEqual, 1] || Inequality[2, LessEqual, x, Less, 3], x, "InteriorShrink" -> 0.4, "RootUpperBound" -> 8], {{0.4, 0.6}, {2.4, 2.6}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "mixed-inequality-types-custom-shrink@@Tests/FindRootOptim/extractIntervalsOptions.wlt:268,1-274,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce; ],
    HoldComplete[tolSameTest = Max[Abs[Flatten[#1 - #2]]] < 10^(-10) & ; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[eir[0.01 < x < 0.02 || 0.03 < x < 0.04, x, "InteriorShrink" -> 0.004, "RootUpperBound" -> 1], {{0.014, 0.016}, {0.034, 0.036}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "tiny-intervals-small-shrink-no-collapse@@Tests/FindRootOptim/extractIntervalsOptions.wlt:284,1-290,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[eir = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce; ],
    HoldComplete[tolSameTest = Max[Abs[Flatten[#1 - #2]]] < 10^(-10) & ; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[VerificationTest[eir[x > 0, x, "InteriorShrink" -> 3, "RootUpperBound" -> 8], {{3., 5.}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "large-shrink-moderate-upperbound@@Tests/FindRootOptim/extractIntervalsOptions.wlt:300,1-306,4"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "extractIntervalsOptions",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../FindRootOptim/extractIntervalsOptions.wlt"
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
