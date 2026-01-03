(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/FindRootOptim/FindRootOptim.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`FindRootOptim`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["FindRootOptim Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`FindRootOptim`"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Module[{testDir, sourceFile, pacletFile, pacletRoot, candidateDirs}, candidateDirs = {}; If[StringQ[$InputFileName] && $InputFileName =!= "", AppendTo[candidateDirs, DirectoryName[$InputFileName]]]; AppendTo[candidateDirs, FileNameJoin[{Directory[], "Tests", "FindRootOptim"}]]; pacletFile = FindFile["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; If[StringQ[pacletFile], pacletRoot = DirectoryName[pacletFile, 3]; AppendTo[candidateDirs, FileNameJoin[{pacletRoot, "Tests", "FindRootOptim"}]]]; AppendTo[candidateDirs, Directory[]]; testDir = SelectFirst[candidateDirs, FileExistsQ[FileNameJoin[{#1, "TestDataSource.wl"}]] & , First[candidateDirs]]; sourceFile = FileNameJoin[{testDir, "TestDataSource.wl"}]; If[FileExistsQ[sourceFile], Get[sourceFile], solNA0 = {}; solNAB0 = {}; paramsA = Association[]; ]; ]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 60; ],
    HoldComplete[VerificationTest[solNA0, {A[0] -> 1.777113528819289}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "dividend-model-A0-coefficient@@Tests/FindRootOptim/FindRootOptim.wlt:70,1-76,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Module[{testDir, sourceFile, pacletFile, pacletRoot, candidateDirs}, candidateDirs = {}; If[StringQ[$InputFileName] && $InputFileName =!= "", AppendTo[candidateDirs, DirectoryName[$InputFileName]]]; AppendTo[candidateDirs, FileNameJoin[{Directory[], "Tests", "FindRootOptim"}]]; pacletFile = FindFile["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; If[StringQ[pacletFile], pacletRoot = DirectoryName[pacletFile, 3]; AppendTo[candidateDirs, FileNameJoin[{pacletRoot, "Tests", "FindRootOptim"}]]]; AppendTo[candidateDirs, Directory[]]; testDir = SelectFirst[candidateDirs, FileExistsQ[FileNameJoin[{#1, "TestDataSource.wl"}]] & , First[candidateDirs]]; sourceFile = FileNameJoin[{testDir, "TestDataSource.wl"}]; If[FileExistsQ[sourceFile], Get[sourceFile], solNA0 = {}; solNAB0 = {}; paramsA = Association[]; ]; ]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 60; ],
    HoldComplete[VerificationTest[solNAB0, {B[1][0] -> 1.784254766558428}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "dividend-model-B10-coefficient@@Tests/FindRootOptim/FindRootOptim.wlt:147,1-153,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Module[{testDir, sourceFile, pacletFile, pacletRoot, candidateDirs}, candidateDirs = {}; If[StringQ[$InputFileName] && $InputFileName =!= "", AppendTo[candidateDirs, DirectoryName[$InputFileName]]]; AppendTo[candidateDirs, FileNameJoin[{Directory[], "Tests", "FindRootOptim"}]]; pacletFile = FindFile["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; If[StringQ[pacletFile], pacletRoot = DirectoryName[pacletFile, 3]; AppendTo[candidateDirs, FileNameJoin[{pacletRoot, "Tests", "FindRootOptim"}]]]; AppendTo[candidateDirs, Directory[]]; testDir = SelectFirst[candidateDirs, FileExistsQ[FileNameJoin[{#1, "TestDataSource.wl"}]] & , First[candidateDirs]]; sourceFile = FileNameJoin[{testDir, "TestDataSource.wl"}]; If[FileExistsQ[sourceFile], Get[sourceFile], solNA0 = {}; solNAB0 = {}; paramsA = Association[]; ]; ]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 60; ],
    HoldComplete[VerificationTest[1.77 < solNA0[[1,2]] < 1.78, True, TimeConstraint -> timeLimit, TestID -> "A0-coefficient-in-range@@Tests/FindRootOptim/FindRootOptim.wlt:224,1-229,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Module[{testDir, sourceFile, pacletFile, pacletRoot, candidateDirs}, candidateDirs = {}; If[StringQ[$InputFileName] && $InputFileName =!= "", AppendTo[candidateDirs, DirectoryName[$InputFileName]]]; AppendTo[candidateDirs, FileNameJoin[{Directory[], "Tests", "FindRootOptim"}]]; pacletFile = FindFile["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; If[StringQ[pacletFile], pacletRoot = DirectoryName[pacletFile, 3]; AppendTo[candidateDirs, FileNameJoin[{pacletRoot, "Tests", "FindRootOptim"}]]]; AppendTo[candidateDirs, Directory[]]; testDir = SelectFirst[candidateDirs, FileExistsQ[FileNameJoin[{#1, "TestDataSource.wl"}]] & , First[candidateDirs]]; sourceFile = FileNameJoin[{testDir, "TestDataSource.wl"}]; If[FileExistsQ[sourceFile], Get[sourceFile], solNA0 = {}; solNAB0 = {}; paramsA = Association[]; ]; ]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 60; ],
    HoldComplete[VerificationTest[1.78 < solNAB0[[1,2]] < 1.79, True, TimeConstraint -> timeLimit, TestID -> "B10-coefficient-in-range@@Tests/FindRootOptim/FindRootOptim.wlt:300,1-305,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Module[{testDir, sourceFile, pacletFile, pacletRoot, candidateDirs}, candidateDirs = {}; If[StringQ[$InputFileName] && $InputFileName =!= "", AppendTo[candidateDirs, DirectoryName[$InputFileName]]]; AppendTo[candidateDirs, FileNameJoin[{Directory[], "Tests", "FindRootOptim"}]]; pacletFile = FindFile["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; If[StringQ[pacletFile], pacletRoot = DirectoryName[pacletFile, 3]; AppendTo[candidateDirs, FileNameJoin[{pacletRoot, "Tests", "FindRootOptim"}]]]; AppendTo[candidateDirs, Directory[]]; testDir = SelectFirst[candidateDirs, FileExistsQ[FileNameJoin[{#1, "TestDataSource.wl"}]] & , First[candidateDirs]]; sourceFile = FileNameJoin[{testDir, "TestDataSource.wl"}]; If[FileExistsQ[sourceFile], Get[sourceFile], solNA0 = {}; solNAB0 = {}; paramsA = Association[]; ]; ]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 60; ],
    HoldComplete[VerificationTest[Module[{intervals}, intervals = eir[B[1][0] > 0, B[1][0]]; MatchQ[intervals, {{_?NumericQ, _?NumericQ}..}]], True, TimeConstraint -> timeLimit, TestID -> "extractIntervalsFromReduce-exported@@Tests/FindRootOptim/FindRootOptim.wlt:376,1-384,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Module[{testDir, sourceFile, pacletFile, pacletRoot, candidateDirs}, candidateDirs = {}; If[StringQ[$InputFileName] && $InputFileName =!= "", AppendTo[candidateDirs, DirectoryName[$InputFileName]]]; AppendTo[candidateDirs, FileNameJoin[{Directory[], "Tests", "FindRootOptim"}]]; pacletFile = FindFile["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; If[StringQ[pacletFile], pacletRoot = DirectoryName[pacletFile, 3]; AppendTo[candidateDirs, FileNameJoin[{pacletRoot, "Tests", "FindRootOptim"}]]]; AppendTo[candidateDirs, Directory[]]; testDir = SelectFirst[candidateDirs, FileExistsQ[FileNameJoin[{#1, "TestDataSource.wl"}]] & , First[candidateDirs]]; sourceFile = FileNameJoin[{testDir, "TestDataSource.wl"}]; If[FileExistsQ[sourceFile], Get[sourceFile], solNA0 = {}; solNAB0 = {}; paramsA = Association[]; ]; ]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 60; ],
    HoldComplete[VerificationTest[eir[B[1][0] > 0, B[1][0]], {{0.001, 14.999}}, SameTest -> tolSameTest, TimeConstraint -> timeLimit, TestID -> "extractIntervalsFromReduce-simple-inequality@@Tests/FindRootOptim/FindRootOptim.wlt:455,1-461,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Module[{testDir, sourceFile, pacletFile, pacletRoot, candidateDirs}, candidateDirs = {}; If[StringQ[$InputFileName] && $InputFileName =!= "", AppendTo[candidateDirs, DirectoryName[$InputFileName]]]; AppendTo[candidateDirs, FileNameJoin[{Directory[], "Tests", "FindRootOptim"}]]; pacletFile = FindFile["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; If[StringQ[pacletFile], pacletRoot = DirectoryName[pacletFile, 3]; AppendTo[candidateDirs, FileNameJoin[{pacletRoot, "Tests", "FindRootOptim"}]]]; AppendTo[candidateDirs, Directory[]]; testDir = SelectFirst[candidateDirs, FileExistsQ[FileNameJoin[{#1, "TestDataSource.wl"}]] & , First[candidateDirs]]; sourceFile = FileNameJoin[{testDir, "TestDataSource.wl"}]; If[FileExistsQ[sourceFile], Get[sourceFile], solNA0 = {}; solNAB0 = {}; paramsA = Association[]; ]; ]; ],
    HoldComplete[eir = If[NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce"], FernandoDuarte`LongRunRisk`Tools`FindRootOptim`extractIntervalsFromReduce, ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`extractIntervalsFromReduce"]]; ],
    HoldComplete[tolSameTest = Function[{actual, expected}, Module[{a, e}, a = actual /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; e = expected /. {(_ -> (v_)?NumericQ) :> v, {_ -> (v_)?NumericQ} :> v}; Max[Abs[Flatten[{a}] - Flatten[{e}]]] < 10^(-6)]]; ],
    HoldComplete[timeLimit = 60; ],
    HoldComplete[VerificationTest[Module[{testParams}, testParams = Append[paramsA, solNA0[[1]]]; MatchQ[Lookup[testParams, A[0]], _?NumericQ]], True, TimeConstraint -> 5, TestID -> "integration-parameter-chaining@@Tests/FindRootOptim/FindRootOptim.wlt:532,1-541,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "FindRootOptim",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../FindRootOptim/FindRootOptim.wlt"
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
