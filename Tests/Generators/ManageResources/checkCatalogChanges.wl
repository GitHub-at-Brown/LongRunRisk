(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/ManageResources/checkCatalogChanges.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`checkCatalogChanges`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["checkCatalogChanges Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`ManageResources`checkCatalogChanges`"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$timeLimit = 30; ],
    HoldComplete[VerificationTest[Module[{tmpRoot, manifestFile, modelsAssoc, modelHashes, savedManifest, checkCatalogChangesFn, result}, tmpRoot = CreateDirectory[]; CreateDirectory[FileNameJoin[{tmpRoot, "Resources"}]]; manifestFile = FileNameJoin[{tmpRoot, "Resources", "ModelManifest.wl"}]; modelsAssoc = Association["ModelA" -> Association["a" -> 1], "ModelB" -> Association["b" -> {1, 2}]]; modelHashes = FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCanonicalHash /@ modelsAssoc; savedManifest = Association["PacletVersion" -> "Development", "CatalogHash" -> "not-the-real-hash", "Models" -> modelHashes, "Date" -> "2025-01-01T00:00:00"]; Put[savedManifest, manifestFile]; checkCatalogChangesFn = FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogChanges; Block[{FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot}, FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := tmpRoot; result = Quiet[checkCatalogChangesFn[modelsAssoc]]; ]; DeleteDirectory[tmpRoot, DeleteContents -> True]; AssociationQ[result] && KeyExistsQ[result, "Changed"] && KeyExistsQ[result, "New"] && KeyExistsQ[result, "Removed"] && KeyExistsQ[result, "Validation"] && result["Changed"] === {} && result["New"] === {} && result["Removed"] === {} && AssociationQ[result["Validation"]] && TrueQ[result["Validation"]["Valid"]]], True, TimeConstraint -> $timeLimit, TestID -> "checkCatalogChanges-assoc-input-returns-structure@@Tests/ManageResources/checkCatalogChanges.wlt:16,1-65,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$timeLimit = 30; ],
    HoldComplete[VerificationTest[Module[{tmpRoot, manifestFile, modelsAssoc, currentHashes, savedManifest, checkCatalogChangesFn, result}, tmpRoot = CreateDirectory[]; CreateDirectory[FileNameJoin[{tmpRoot, "Resources"}]]; manifestFile = FileNameJoin[{tmpRoot, "Resources", "ModelManifest.wl"}]; modelsAssoc = Association["A" -> Association["x" -> 1], "B" -> Association["y" -> 2]]; currentHashes = FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getCanonicalHash /@ modelsAssoc; savedManifest = Association["PacletVersion" -> "Development", "CatalogHash" -> "not-the-real-hash", "Models" -> Association["A" -> "different-hash", "Old" -> "old-hash"], "Date" -> "2025-01-01T00:00:00"]; Put[savedManifest, manifestFile]; checkCatalogChangesFn = FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogChanges; Block[{FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot, Needs, FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog}, FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`findPacletRoot[] := tmpRoot; Needs[_] := Null; FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog[_] := Association["Valid" -> True, "Results" -> Association[], "InvalidModels" -> {}, "TotalErrors" -> 0]; result = Quiet[checkCatalogChangesFn[modelsAssoc]]; ]; DeleteDirectory[tmpRoot, DeleteContents -> True]; AssociationQ[result] && Sort[result["Changed"]] === {"A"} && Sort[result["New"]] === {"B"} && Sort[result["Removed"]] === {"Old"} && TrueQ[result["Validation"]["Valid"]]], True, TimeConstraint -> $timeLimit, TestID -> "checkCatalogChanges-detects-changed-new-removed@@Tests/ManageResources/checkCatalogChanges.wlt:79,1-135,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "checkCatalogChanges",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../ManageResources/checkCatalogChanges.wlt"
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
