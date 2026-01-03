(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/Core/Catalog.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`Catalog`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["Catalog Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`Model`Catalog`"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[VerificationTest[MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Catalog`"], True, {}, TestID -> "Catalog_20251223-CVYMGR@@Tests/Core/Catalog.wlt:7,1-15,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[VerificationTest[And @@ StringQ /@ Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], True, {}, TestID -> "Catalog_20251223-ZQHUJ0@@Tests/Core/Catalog.wlt:20,1-28,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[VerificationTest[And @@ StringQ /@ Flatten[({FernandoDuarte`LongRunRisk`Model`Catalog`models[#1]["name"], FernandoDuarte`LongRunRisk`Model`Catalog`models[#1]["shortname"], FernandoDuarte`LongRunRisk`Model`Catalog`models[#1]["bibRef"], FernandoDuarte`LongRunRisk`Model`Catalog`models[#1]["desc"]} & ) /@ Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models]], True, {}, TestID -> "Catalog_20251223-N0A4JV@@Tests/Core/Catalog.wlt:33,1-55,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[VerificationTest[And @@ BooleanQ /@ Flatten[({FernandoDuarte`LongRunRisk`Model`Catalog`models[#1]["enabled"]} & ) /@ Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models]], True, {}, TestID -> "Catalog_20251223-OX2LLT@@Tests/Core/Catalog.wlt:60,1-72,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[VerificationTest[And @@ NumberQ /@ Flatten[(FernandoDuarte`LongRunRisk`Model`Catalog`models[#1]["parameters"][[1 ;; All,2]] //. FernandoDuarte`LongRunRisk`Model`Catalog`models[#1]["parameters"] & ) /@ Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models]], True, {}, TestID -> "Catalog_20251223-TQC5UV@@Tests/Core/Catalog.wlt:77,1-96,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[VerificationTest[FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"]["stateVars"] === {FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`x[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sx[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t]}, True, {}, TestID -> "Catalog_20251223-RMOIJN@@Tests/Core/Catalog.wlt:101,1-109,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[VerificationTest[And @@ (MemberQ[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], #1] & ) /@ {"BY", "BKY"}, True, {}, TestID -> "Catalog_20251223-AWF8GZ@@Tests/Core/Catalog.wlt:114,1-122,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[VerificationTest[And @@ (MatchQ[Association, #1] & ) /@ Flatten[{Head[FernandoDuarte`LongRunRisk`Model`Catalog`models], (Head[FernandoDuarte`LongRunRisk`Model`Catalog`models[#1]] & ) /@ Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models]}], True, {}, TestID -> "Catalog_20251223-L8VWTP@@Tests/Core/Catalog.wlt:127,1-144,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[VerificationTest[And @@ (And @@ (#1 === "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`" & ) /@ Context /@ Cases[FernandoDuarte`LongRunRisk`Model`Catalog`models[#1]["stateVars"], (FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var_Symbol)?(MemberQ[(StringDrop[#1, -2] & ) /@ FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars, SymbolName[#1]] & )[__] :> FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var, Infinity] & ) /@ Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], True, {}, TestID -> "Catalog_20251223-1G21CC@@Tests/Core/Catalog.wlt:149,1-185,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[VerificationTest[And @@ (And @@ (#1 === "FernandoDuarte`LongRunRisk`Model`Shocks`" & ) /@ Context /@ Cases[FernandoDuarte`LongRunRisk`Model`Catalog`models[#1]["stateVars"], (FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var_Symbol)?(MatchQ[SymbolName[#1], "eps"] & )[__][__] :> FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var, Infinity] & ) /@ Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], True, {}, TestID -> "Catalog_20251223-CW7BLD@@Tests/Core/Catalog.wlt:190,1-218,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[VerificationTest[And @@ (And @@ (#1 === "FernandoDuarte`LongRunRisk`Model`Parameters`" & ) /@ Context /@ Cases[FernandoDuarte`LongRunRisk`Model`Catalog`models[#1]["parameters"], (FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var_Symbol)?(MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#1]] & ) :> FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var, Infinity] & ) /@ Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], True, {}, TestID -> "Catalog_20251223-USIK1Y@@Tests/Core/Catalog.wlt:223,1-251,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[VerificationTest[And @@ (And @@ (#1 === "FernandoDuarte`LongRunRisk`Model`Parameters`" & ) /@ Context /@ Cases[FernandoDuarte`LongRunRisk`Model`Catalog`models[#1]["stateVars"], (FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var_Symbol)?(MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#1]] & ) :> FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var, Infinity] & ) /@ Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], True, {}, TestID -> "Catalog_20251223-2IK0IQ@@Tests/Core/Catalog.wlt:256,1-284,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[VerificationTest[And @@ (MatchQ[{}, #1] & ) /@ (Cases[FernandoDuarte`LongRunRisk`Model`Catalog`models[#1]["stateVars"], (FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var_Symbol)?(MemberQ[(StringDrop[#1, -2] & ) /@ FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars, SymbolName[#1]] & )[__] :> FernandoDuarte`LongRunRisk`Tests`Model`Catalog`var, Infinity] & ) /@ Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], True, {}, TestID -> "Catalog_20251223-16V8HS@@Tests/Core/Catalog.wlt:289,1-320,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[VerificationTest[And @@ {AllTrue[FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo, AssociationQ], AllTrue[(FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo[#1] & ) /@ Keys[FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo], AssociationQ]}, True, {}, TestID -> "Catalog_20251223-91RLYU@@Tests/Core/Catalog.wlt:325,1-340,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[VerificationTest[And @@ {SubsetQ[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], Keys[FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo]]}, True, {}, TestID -> "Catalog_20251223-O3EOWM@@Tests/Core/Catalog.wlt:345,1-353,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[VerificationTest[And @@ Flatten[(If[KeyExistsQ[FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo[#1], "initialGuess"], {If[KeyExistsQ[FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo[#1]["initialGuess"], "Ewc"], VectorQ["Ewc" /. FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo[#1]["initialGuess"]], True], If[KeyExistsQ[FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo[#1]["initialGuess"], "Epd"], ArrayQ["Epd" /. FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo[#1]["initialGuess"], 2], True]}, True] & ) /@ Keys[FernandoDuarte`LongRunRisk`Model`Catalog`modelsExtraInfo]], True, {}, TestID -> "Catalog_20251223-IJ59KY@@Tests/Core/Catalog.wlt:358,1-389,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "Catalog",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../Core/Catalog.wlt"
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
