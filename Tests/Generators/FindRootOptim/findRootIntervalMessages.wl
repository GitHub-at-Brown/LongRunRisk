(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/FindRootOptim/findRootIntervalMessages.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`findRootIntervalMessages`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["findRootIntervalMessages Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`findRootIntervalMessages`"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[fri = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval; ],
    HoldComplete[VerificationTest[Block[{A}, fri[A[0] < 0 && A[0] > 0, Association[], "A", "signA"]] === $Failed, True, {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::emptyinterval}, TimeConstraint -> timeLimit, TestID -> "emptyinterval-message-on-false@@Tests/FindRootOptim/findRootIntervalMessages.wlt:12,1-20,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[fri = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval; ],
    HoldComplete[VerificationTest[Block[{A}, fri[A[0] > 10 && A[0] < 5, Association[], "A", "signA"]] === $Failed, True, {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::emptyinterval}, TimeConstraint -> timeLimit, TestID -> "emptyinterval-message-on-contradiction@@Tests/FindRootOptim/findRootIntervalMessages.wlt:30,1-38,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[fri = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval; ],
    HoldComplete[VerificationTest[Block[{A}, fri[A[0] > 0 && A[0] > 0 && A[0] < -1, Association[], "A", "signA"]] === $Failed, True, {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::emptyinterval}, TimeConstraint -> timeLimit, TestID -> "emptyinterval-message-on-param-contradiction@@Tests/FindRootOptim/findRootIntervalMessages.wlt:48,1-56,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[fri = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval; ],
    HoldComplete[VerificationTest[Block[{x}, fri[x > 0 && x < 10, Association[], "A", "signA"]] === $Failed, True, {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::nocoeff}, TimeConstraint -> timeLimit, TestID -> "nocoeff-message-no-coefficient@@Tests/FindRootOptim/findRootIntervalMessages.wlt:66,1-74,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[fri = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval; ],
    HoldComplete[VerificationTest[Block[{a}, fri[a > 0, Association[a -> 1], "A", "signA"]] === $Failed, True, {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::nocoeff}, TimeConstraint -> timeLimit, TestID -> "nocoeff-message-only-parameters@@Tests/FindRootOptim/findRootIntervalMessages.wlt:84,1-92,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[fri = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval; ],
    HoldComplete[VerificationTest[Block[{B}, fri[B[0] > 1 && B[0] < 5, Association[], "A", "signA"]] === $Failed, True, {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::nocoeff}, TimeConstraint -> timeLimit, TestID -> "nocoeff-message-wrong-coefficient-name@@Tests/FindRootOptim/findRootIntervalMessages.wlt:102,1-110,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[fri = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval; ],
    HoldComplete[VerificationTest[Block[{B}, fri[B[1][0] > 1 && B[1][0] < 5, Association[], "A", "signA"]] === $Failed, True, {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::nocoeff}, TimeConstraint -> timeLimit, TestID -> "nocoeff-message-wrong-coefficient-name-indexed@@Tests/FindRootOptim/findRootIntervalMessages.wlt:120,1-128,4"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 5; ],
    HoldComplete[fri = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval; ],
    HoldComplete[VerificationTest[Block[{A}, fri[A[0] > 1 && A[0] < 5, Association[], "A", "signA"]], _, {}, SameTest -> MatchQ, TimeConstraint -> timeLimit, TestID -> "no-messages-on-valid-input@@Tests/FindRootOptim/findRootIntervalMessages.wlt:138,1-147,4"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "findRootIntervalMessages",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../FindRootOptim/findRootIntervalMessages.wlt"
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
