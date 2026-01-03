(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/ProcessModels/CreateMomentsDatabase_test1.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`CreateMomentsDatabasetest1`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["CreateMomentsDatabase"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`"]],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`longTest = False; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`"]; ],
    HoldComplete[$ContextPath = DeleteDuplicates[Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`"]]; ],
    HoldComplete[VerificationTest[Off[General::stop]; If[ !FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`longTest, Off[FindRoot::cvmit]]; Get[FileNameJoin[{"FernandoDuarte/LongRunRisk/MomentsLookupTables", "covLongBKY.mx"}]]; Get[FileNameJoin[{"FernandoDuarte/LongRunRisk/MomentsLookupTables", "covLongDES.mx"}]]; Get[FileNameJoin[{"FernandoDuarte/LongRunRisk/MomentsLookupTables", "covLongNRC.mx"}]]; Get[FileNameJoin[{"FernandoDuarte/LongRunRisk/MomentsLookupTables", "covLongNRCStochVol.mx"}]]; Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"]; Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`msp = FernandoDuarte`LongRunRisk`Models; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`modBKY = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`msp["BKY"]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`modNRC = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`msp["NRC"]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`modDES = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`msp["DES"]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`modNRCStochVol = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`msp["NRCStochVol"]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`mods = If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`longTest, {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`modBKY, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`modNRC, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`modDES, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`modNRCStochVol}, {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`modBKY, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`modNRC}]; Do[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`ind = 0; FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`covLong = Symbol[StringJoin["FernandoDuarte`LongRunRisk`covLong", FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`model["shortname"]]]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMoments = Apply[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`covLong, Outer[Append, Tuples[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`exo, {2}], Range[-8, 8], 1], {2}]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMomentsN = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMoments //. FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`model["params"]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMomentsOneStock = (Append[#1, FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`j] & ) /@ Flatten[Apply[Inactive[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`covLong], Outer[Append, Tuples[{FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`exo, FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`exoStocks}], Range[-8, 8], 1], {2}]]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMomentsOneStockN = Activate[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMomentsOneStock /. FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`j -> 1] //. FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`model["params"]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMomentsTwoStocks = Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`covLong @@ Join[#1, {FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`i, FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`j}] & , Outer[Append, Tuples[{FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`exoStocks, FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`exoStocks}], Range[-8, 8], 1], {2}]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMomentsTwoStocksN = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMomentsTwoStocks /. (Thread[{FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`i, FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`j} -> #1] & ) /@ Tuples[Range[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`model["numStocks"]], {2}] //. FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`model["params"]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMoments3 = (FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`covLong[##1, 0, 0] & ) @@@ Groupings[Tuples[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`exo, {3}], 2]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMoments3N = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMoments3 //. FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`model["params"]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMoments4 = (FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`covLong[##1, 0, 0, 0] & ) @@@ (Partition[#1, 2] & ) /@ Tuples[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`exo, {4}]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMoments4N = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMoments4 //. FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`model["params"]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMomentsStocks3 = Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`covLong @@ Join[#1, {0, 0, FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`i, FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`j, FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`k}] & , Groupings[Tuples[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`exoStocks, {3}], 2], {1}]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMomentsStocks3N = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMomentsStocks3 /. (Thread[{FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`i, FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`j, FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`k} -> #1] & ) /@ Tuples[Range[Min[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`model["numStocks"], 2]], {3}] //. FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`model["params"]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMomentsStocks4 = Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`covLong @@ Join[#1, {0, 0, 0, FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`i, FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`j, FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`k, FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`m}] & , (Partition[#1, 2] & ) /@ Tuples[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`exoStocks, {4}], {1}]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMomentsStocks4N = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMomentsStocks4 /. (Thread[{FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`i, FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`j, FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`k, FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`m} -> #1] & ) /@ Tuples[Range[Min[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`model["numStocks"], 2]], {4}] //. FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`model["params"]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`model["shortname"]][FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`ind] = And @@ {And @@ NumberQ /@ Flatten[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMomentsN], And @@ NumberQ /@ Flatten[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMomentsOneStockN], And @@ NumberQ /@ Flatten[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMomentsTwoStocksN], And @@ NumberQ /@ Flatten[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMoments3N], And @@ NumberQ /@ Flatten[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMoments4N], And @@ NumberQ /@ Flatten[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMomentsStocks3N], And @@ NumberQ /@ Flatten[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMomentsStocks4N]}; FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`ind = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`ind + 1; If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`longTest, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`tuples3q = Groupings[Tuples[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`exo, {3}], 2]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`ntest = 150; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`toEval3q = Extract[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`tuples3q, Thread[{RandomInteger[Length[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`tuples3q], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`ntest]}]]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMoments3q = Table[(FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`covLong[Sequence[##1], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`q1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`q2] & ) @@@ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`toEval3q, {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`q1, -4, 4}, {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`q2, 4, 4}]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMoments3qN = Flatten[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMoments3q] //. FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`model["params"]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`model["shortname"]][FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`ind] = And @@ NumberQ /@ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMoments3qN; FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`ind = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`ind + 1; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`tuples4q = (Partition[#1, 2] & ) /@ Tuples[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`exo, {4}]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`ntest = 150; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`toEval4q = Extract[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`tuples4q, Thread[{RandomInteger[Length[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`tuples4q], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`ntest]}]]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMoments4q = Table[(FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`covLong[Sequence[##1], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`q1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`q2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`q3] & ) @@@ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`toEval4q, {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`q1, -3, 3}, {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`q2, 3, 3}, {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`q3, 3, 3}]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMoments4qN = Flatten[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMoments4q] //. FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`model["params"]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`model["shortname"]][FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`ind] = And @@ NumberQ /@ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testMoments4qN; FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`ind = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`ind + 1; ]; , {FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`model, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`mods}]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`noMissingTest = {}; Do[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testNumber = Sort[Cases[Keys[SubValues[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`outTests]], Verbatim[HoldPattern][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`model["shortname"]][FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`i_Integer]] :> FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`i]]; AppendTo[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`noMissingTest, Range[0, Max[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testNumber]] == FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`testNumber]; , {FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`model, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`mods}]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`out = And @@ {And @@ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`noMissingTest, And @@ Values[SubValues[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`outTests]]}; On[General::stop]; On[FindRoot::cvmit]; FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`out, True, {}, TestID -> "CreateMomentsDatabase_20251223-YUYZXN@@Tests/ProcessModels/CreateMomentsDatabase_test1.wlt:8,1-164,2"]],
    HoldComplete[$ContextPath = DeleteCases[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`"]; ],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "CreateMomentsDatabase_test1",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../ProcessModels/CreateMomentsDatabase_test1.wlt"
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
