(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/OutputFormatting/toCatalog.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`toCatalog`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["toCatalog Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`OutputFormatting`toCatalog`"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$toCatalog = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[$toCatalog[Association[], {"name", "shortname"}], Association[], TestID -> "toCatalog-empty-catalog-returns-empty@@Tests/OutputFormatting/toCatalog.wlt:22,1-26,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$toCatalog = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[AssociationQ[$toCatalog[Association[], {"name"}]], True, TestID -> "toCatalog-empty-catalog-is-association@@Tests/OutputFormatting/toCatalog.wlt:46,1-50,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$toCatalog = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{result, expectedKeys}, result = $toCatalog[$realModels, {"name", "shortname"}]; expectedKeys = Sort[{"name", "shortname", "stateVars"}]; AllTrue[Values[result], AssociationQ]], True, TimeConstraint -> $timeLimit, TestID -> "toCatalog-returns-associations@@Tests/OutputFormatting/toCatalog.wlt:70,1-80,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$toCatalog = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{result}, result = $toCatalog[$realModels, {"name"}]; Keys[result] === Keys[$realModels]], True, TimeConstraint -> $timeLimit, TestID -> "toCatalog-preserves-model-keys@@Tests/OutputFormatting/toCatalog.wlt:100,1-108,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$toCatalog = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{result}, result = $toCatalog[$realModels, {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"}]; AllTrue[Values[result], Length[#1] >= 6 & ]], True, TimeConstraint -> $timeLimit, TestID -> "toCatalog-filters-to-specified-keys@@Tests/OutputFormatting/toCatalog.wlt:128,1-137,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$toCatalog = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{testModel, result}, testModel = Association["test" -> Association["name" -> "Test", "stateVars" -> Function[t, {x[t], sc[t]}], "parameters" -> {delta -> 0.999}]]; result = $toCatalog[testModel, {"stateVars"}]; Head[result["test"]["stateVars"]] === List], True, TimeConstraint -> $timeLimit, TestID -> "toCatalog-evaluates-stateVars-function@@Tests/OutputFormatting/toCatalog.wlt:157,1-174,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$toCatalog = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{testModel, result}, testModel = Association["test" -> Association["name" -> "Test", "stateVars" -> {x[t], sc[t]}, "parameters" -> {delta -> 0.999}]]; result = $toCatalog[testModel, {"stateVars"}]; Head[result["test"]["stateVars"]] === List], True, TimeConstraint -> $timeLimit, TestID -> "toCatalog-preserves-stateVars-list@@Tests/OutputFormatting/toCatalog.wlt:194,1-211,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$toCatalog = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{result}, result = $toCatalog[$realModels, {"enabled"}]; AllTrue[Values[result], BooleanQ[#1["enabled"]] & ]], True, TimeConstraint -> $timeLimit, TestID -> "toCatalog-preserves-enabled-boolean@@Tests/OutputFormatting/toCatalog.wlt:231,1-240,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$toCatalog = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{result}, result = $toCatalog[$realModels, {"parameters"}]; AllTrue[Values[result], ListQ[#1["parameters"]] & ]], True, TimeConstraint -> $timeLimit, TestID -> "toCatalog-preserves-parameters-list@@Tests/OutputFormatting/toCatalog.wlt:260,1-269,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$toCatalog = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{testModel, result}, testModel = Association["test" -> Association["name" -> "Test Model", "shortname" -> "TM", "bibRef" -> "test2024", "desc" -> "A test model", "enabled" -> True, "stateVars" -> {x[t]}, "parameters" -> {delta -> 0.999}, "extraField" -> "should be filtered"]]; result = $toCatalog[testModel, {"name", "shortname"}];  !KeyExistsQ[result["test"], "extraField"]], True, TimeConstraint -> $timeLimit, TestID -> "toCatalog-filters-out-extra-fields@@Tests/OutputFormatting/toCatalog.wlt:289,1-309,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$toCatalog = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{singleModel, result}, singleModel = Association["BKY" -> $realModels["BKY"]]; result = $toCatalog[singleModel, {"name"}]; Length[result] === 1 && KeyExistsQ[result, "BKY"]], True, TimeConstraint -> $timeLimit, TestID -> "toCatalog-single-model@@Tests/OutputFormatting/toCatalog.wlt:329,1-338,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$toCatalog = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{result, keysToKeep}, keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"}; result = $toCatalog[$realModels, keysToKeep]; Length[result] === Length[$realModels]], True, TimeConstraint -> $timeLimit, TestID -> "toCatalog-preserves-all-models@@Tests/OutputFormatting/toCatalog.wlt:358,1-368,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$toCatalog = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{keysToKeep, result}, keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"}; result = $toCatalog[$realModels, keysToKeep]; AssociationQ[result] && AllTrue[Keys[$realModels], KeyExistsQ[result, #1] & ] && AllTrue[Values[result], AssociationQ]], True, TimeConstraint -> $timeLimit, TestID -> "toCatalog-full-catalog-roundtrip@@Tests/OutputFormatting/toCatalog.wlt:388,1-400,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "toCatalog",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../OutputFormatting/toCatalog.wlt"
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
