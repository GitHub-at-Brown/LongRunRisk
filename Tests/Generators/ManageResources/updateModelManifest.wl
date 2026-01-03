(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/ManageResources/updateModelManifest.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`updateModelManifest`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["updateModelManifest Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`ManageResources`updateModelManifest`"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCanonicalHash"]; ],
    HoldComplete[$canonicalize = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`canonicalize"]; ],
    HoldComplete[$findPacletRoot = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot"]; ],
    HoldComplete[$getVersion = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getVersion"]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[$getHash[Association["b" -> 1, "a" -> 2]] === $getHash[Association["a" -> 2, "b" -> 1]], True, TestID -> "hash-key-order-invariant@@Tests/ManageResources/updateModelManifest.wlt:25,1-29,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCanonicalHash"]; ],
    HoldComplete[$canonicalize = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`canonicalize"]; ],
    HoldComplete[$findPacletRoot = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot"]; ],
    HoldComplete[$getVersion = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getVersion"]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[$getHash[Association["x" -> Association["b" -> 1, "a" -> 2]]] === $getHash[Association["x" -> Association["a" -> 2, "b" -> 1]]], True, TestID -> "hash-nested-key-order-invariant@@Tests/ManageResources/updateModelManifest.wlt:52,1-56,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCanonicalHash"]; ],
    HoldComplete[$canonicalize = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`canonicalize"]; ],
    HoldComplete[$findPacletRoot = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot"]; ],
    HoldComplete[$getVersion = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getVersion"]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[$getHash[Association["z" -> {Association["b" -> 1], Association["a" -> 2]}]] === $getHash[Association["z" -> {Association["b" -> 1], Association["a" -> 2]}]], True, TestID -> "hash-list-of-associations@@Tests/ManageResources/updateModelManifest.wlt:79,1-83,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCanonicalHash"]; ],
    HoldComplete[$canonicalize = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`canonicalize"]; ],
    HoldComplete[$findPacletRoot = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot"]; ],
    HoldComplete[$getVersion = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getVersion"]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[$getHash[Association["a" -> 1]] =!= $getHash[Association["a" -> 2]], True, TestID -> "hash-different-values-differ@@Tests/ManageResources/updateModelManifest.wlt:106,1-111,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCanonicalHash"]; ],
    HoldComplete[$canonicalize = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`canonicalize"]; ],
    HoldComplete[$findPacletRoot = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot"]; ],
    HoldComplete[$getVersion = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getVersion"]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[$canonicalize[Association["b" -> Association["d" -> 1, "c" -> 2], "a" -> 3]], Association["a" -> 3, "b" -> Association["c" -> 2, "d" -> 1]], TestID -> "canonicalize-sorts-nested-keys@@Tests/ManageResources/updateModelManifest.wlt:134,1-139,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCanonicalHash"]; ],
    HoldComplete[$canonicalize = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`canonicalize"]; ],
    HoldComplete[$findPacletRoot = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot"]; ],
    HoldComplete[$getVersion = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getVersion"]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Block[{FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot}, FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := $Failed; updateModelManifest[]] === $Failed, True, {FernandoDuarte`LongRunRisk`Tools`ManageResources`updateModelManifest::noroot}, TimeConstraint -> $timeLimit, TestID -> "fails-when-root-not-found@@Tests/ManageResources/updateModelManifest.wlt:162,1-172,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCanonicalHash"]; ],
    HoldComplete[$canonicalize = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`canonicalize"]; ],
    HoldComplete[$findPacletRoot = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot"]; ],
    HoldComplete[$getVersion = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getVersion"]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{tmp, manifestFile, result, fileExists}, tmp = CreateDirectory[FileNameJoin[{$TemporaryDirectory, StringJoin["tmp-", CreateUUID[]]}]]; manifestFile = FileNameJoin[{tmp, "Resources", "ModelManifest.wl"}]; Block[{FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot, FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels}, FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := tmp; FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[] := 42; result = updateModelManifest[]; fileExists = FileExistsQ[manifestFile]; ]; If[DirectoryQ[tmp], DeleteDirectory[tmp, DeleteContents -> True]]; result === $Failed && fileExists === False], True, {FernandoDuarte`LongRunRisk`Tools`ManageResources`updateModelManifest::nocat}, TimeConstraint -> $timeLimit, TestID -> "rejects-non-association-catalog@@Tests/ManageResources/updateModelManifest.wlt:195,1-216,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCanonicalHash"]; ],
    HoldComplete[$canonicalize = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`canonicalize"]; ],
    HoldComplete[$findPacletRoot = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot"]; ],
    HoldComplete[$getVersion = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getVersion"]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{tmp, manifestFile, catalogOverride, result, fileData, dropDate, dateOK, versionOK, hashesOK}, tmp = CreateDirectory[FileNameJoin[{$TemporaryDirectory, StringJoin["tmp-", CreateUUID[]]}]]; manifestFile = FileNameJoin[{tmp, "Resources", "ModelManifest.wl"}]; catalogOverride = Association["ModelA" -> Association["a" -> 1], "ModelB" -> Association["b" -> {1, 2}]]; dropDate = KeyDrop[#1, {"Date"}] & ; Block[{FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot, FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels}, FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := tmp; FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCatalogModels[] := catalogOverride; result = updateModelManifest[]; fileData = Get[manifestFile]; ]; If[DirectoryQ[tmp], DeleteDirectory[tmp, DeleteContents -> True]]; dateOK = StringQ[result["Date"]]; With[{baseResult = dropDate[result], baseFile = dropDate[fileData], expectedCatalogHash = $getHash[catalogOverride], expectedModelHashes = $getHash /@ catalogOverride}, versionOK = StringQ[baseResult["PacletVersion"]]; hashesOK = baseResult["CatalogHash"] === expectedCatalogHash && baseResult["Models"] === expectedModelHashes; baseResult === baseFile && versionOK && hashesOK && dateOK]], True, TimeConstraint -> $timeLimit, TestID -> "writes-manifest-with-expected-content@@Tests/ManageResources/updateModelManifest.wlt:239,1-273,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCanonicalHash"]; ],
    HoldComplete[$canonicalize = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`canonicalize"]; ],
    HoldComplete[$findPacletRoot = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot"]; ],
    HoldComplete[$getVersion = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getVersion"]; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{catalog1, catalog2}, catalog1 = Association["ModelB" -> Association["params" -> Association["gamma" -> 2, "beta" -> 1], "name" -> "B"], "ModelA" -> Association["name" -> "A", "params" -> Association["alpha" -> 0]]]; catalog2 = Association["ModelA" -> Association["params" -> Association["alpha" -> 0], "name" -> "A"], "ModelB" -> Association["name" -> "B", "params" -> Association["beta" -> 1, "gamma" -> 2]]]; $getHash[catalog1] === $getHash[catalog2]], True, TestID -> "hash-complex-permutation-invariant@@Tests/ManageResources/updateModelManifest.wlt:296,1-311,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "updateModelManifest",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../ManageResources/updateModelManifest.wlt"
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
