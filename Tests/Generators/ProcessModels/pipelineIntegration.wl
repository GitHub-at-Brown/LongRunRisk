(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/ProcessModels/pipelineIntegration.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`pipelineIntegration`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["pipelineIntegration Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`ProcessModels`pipelineIntegration`"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 10; ],
    HoldComplete[VerificationTest[MemberQ[$Packages, "FernandoDuarte`LongRunRisk`Model`Catalog`"], True, TestID -> "catalog-package-loaded@@Tests/ProcessModels/pipelineIntegration.wlt:20,1-24,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 10; ],
    HoldComplete[VerificationTest[MemberQ[$Packages, "FernandoDuarte`LongRunRisk`Model`ProcessModels`"], True, TestID -> "processModels-package-loaded@@Tests/ProcessModels/pipelineIntegration.wlt:42,1-46,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 10; ],
    HoldComplete[VerificationTest[MemberQ[$Packages, "FernandoDuarte`LongRunRisk`Tools`ManageResources`"], True, TestID -> "manageResources-package-loaded@@Tests/ProcessModels/pipelineIntegration.wlt:64,1-68,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 10; ],
    HoldComplete[VerificationTest[Head[FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels], Symbol, TestID -> "processModels-symbol-exists@@Tests/ProcessModels/pipelineIntegration.wlt:86,1-90,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 10; ],
    HoldComplete[VerificationTest[Head[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels], Symbol, TestID -> "buildModels-symbol-exists@@Tests/ProcessModels/pipelineIntegration.wlt:108,1-112,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 10; ],
    HoldComplete[VerificationTest[StringQ[FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels::usage], True, TestID -> "processModels-has-usage@@Tests/ProcessModels/pipelineIntegration.wlt:130,1-134,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 10; ],
    HoldComplete[VerificationTest[StringQ[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels::usage], True, TestID -> "buildModels-has-usage@@Tests/ProcessModels/pipelineIntegration.wlt:152,1-156,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 10; ],
    HoldComplete[VerificationTest[AssociationQ[FernandoDuarte`LongRunRisk`Model`Catalog`models], True, TestID -> "catalog-is-association@@Tests/ProcessModels/pipelineIntegration.wlt:174,1-178,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 10; ],
    HoldComplete[VerificationTest[Length[FernandoDuarte`LongRunRisk`Model`Catalog`models] > 0, True, TestID -> "catalog-has-models@@Tests/ProcessModels/pipelineIntegration.wlt:196,1-200,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 10; ],
    HoldComplete[VerificationTest[AllTrue[Keys[FernandoDuarte`LongRunRisk`Model`Catalog`models], StringQ], True, TestID -> "catalog-keys-are-strings@@Tests/ProcessModels/pipelineIntegration.wlt:218,1-222,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 10; ],
    HoldComplete[VerificationTest[AllTrue[Values[FernandoDuarte`LongRunRisk`Model`Catalog`models], AssociationQ], True, TestID -> "catalog-values-are-associations@@Tests/ProcessModels/pipelineIntegration.wlt:240,1-244,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 10; ],
    HoldComplete[VerificationTest[Module[{model}, model = FernandoDuarte`LongRunRisk`Model`Catalog`models["BKY"]; KeyExistsQ[model, "name"] && KeyExistsQ[model, "shortname"] && KeyExistsQ[model, "parameters"] && KeyExistsQ[model, "stateVars"]], True, TestID -> "BKY-model-has-required-keys@@Tests/ProcessModels/pipelineIntegration.wlt:262,1-270,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 10; ],
    HoldComplete[VerificationTest[Module[{model}, model = FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"]; KeyExistsQ[model, "enabled"] && BooleanQ[model["enabled"]]], True, TestID -> "BY-model-has-enabled-boolean@@Tests/ProcessModels/pipelineIntegration.wlt:288,1-295,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 10; ],
    HoldComplete[VerificationTest[Module[{model}, model = FernandoDuarte`LongRunRisk`Model`Catalog`models["BKY"]; KeyExistsQ[model, "enabled"] && BooleanQ[model["enabled"]]], True, TestID -> "BKY-model-has-enabled-boolean@@Tests/ProcessModels/pipelineIntegration.wlt:313,1-320,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "pipelineIntegration",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../ProcessModels/pipelineIntegration.wlt"
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
