(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/ManageResources/reformatCatalog.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`reformatCatalog`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["reformatCatalog Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`ManageResources`reformatCatalog`"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 30; ],
    HoldComplete[VerificationTest[Head[FernandoDuarte`LongRunRisk`Tools`ManageResources`reformatCatalog], Symbol, TestID -> "reformatCatalog-symbol-exists@@Tests/ManageResources/reformatCatalog.wlt:20,1-24,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 30; ],
    HoldComplete[VerificationTest[StringQ[FernandoDuarte`LongRunRisk`Tools`ManageResources`reformatCatalog::usage], True, TestID -> "reformatCatalog-has-usage@@Tests/ManageResources/reformatCatalog.wlt:42,1-46,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 30; ],
    HoldComplete[VerificationTest[Quiet[Module[{keysToKeep, raw, toCatalogFn, realModels}, toCatalogFn = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog; realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models; keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"}; raw = toCatalogFn[realModels, keysToKeep]; AssociationQ[raw] && Length[raw] === Length[realModels]], General::shdw], True, TimeConstraint -> $timeLimit, TestID -> "reformatCatalog-toCatalog-works-on-full-catalog@@Tests/ManageResources/reformatCatalog.wlt:64,1-78,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 30; ],
    HoldComplete[VerificationTest[Quiet[Module[{keysToKeep, raw, formatted, toCatalogFn, formatModelsFn, realModels}, toCatalogFn = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog; formatModelsFn = FernandoDuarte`LongRunRisk`Tools`NiceOutput`formatModels; realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models; keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"}; raw = toCatalogFn[realModels, keysToKeep]; formatted = formatModelsFn[raw]; Head[formatted] === BoxData], General::shdw], True, TimeConstraint -> $timeLimit, TestID -> "reformatCatalog-formatModels-produces-BoxData@@Tests/ManageResources/reformatCatalog.wlt:96,1-112,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 30; ],
    HoldComplete[VerificationTest[Quiet[Module[{keysToKeep, raw, formatted, strings, modelNames, toCatalogFn, formatModelsFn, realModels}, toCatalogFn = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog; formatModelsFn = FernandoDuarte`LongRunRisk`Tools`NiceOutput`formatModels; realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models; keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"}; raw = toCatalogFn[realModels, keysToKeep]; formatted = formatModelsFn[raw]; strings = Cases[formatted, _String, Infinity]; modelNames = Values[(#1["shortname"] & ) /@ raw]; AllTrue[modelNames, MemberQ[strings, s_String /; StringContainsQ[s, #1]] & ]], General::shdw], True, TimeConstraint -> $timeLimit, TestID -> "reformatCatalog-all-models-in-formatted-output@@Tests/ManageResources/reformatCatalog.wlt:130,1-148,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 30; ],
    HoldComplete[VerificationTest[Quiet[Module[{keysToKeep, raw, formatted, strings, toCatalogFn, formatModelsFn, realModels}, toCatalogFn = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog; formatModelsFn = FernandoDuarte`LongRunRisk`Tools`NiceOutput`formatModels; realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models; keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"}; raw = toCatalogFn[realModels, keysToKeep]; formatted = formatModelsFn[raw]; strings = Cases[formatted, _String, Infinity]; MemberQ[strings, s_String /; StringContainsQ[s, "enabled"]]], General::shdw], True, TimeConstraint -> $timeLimit, TestID -> "reformatCatalog-enabled-field-in-output@@Tests/ManageResources/reformatCatalog.wlt:166,1-183,2"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"]; ],
    HoldComplete[$timeLimit = 30; ],
    HoldComplete[VerificationTest[Module[{normalizeWS, stringFmt, desc, r1, r2, r3}, normalizeWS = ToExpression["FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`normalizeWhitespace"]; stringFmt = ToExpression["FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stringFormattingTemplate"]; desc = "Bansal and Yaron (2004) long-run risk model with stochastic volatility of consumption growth."; r1 = stringFmt[desc]; r2 = stringFmt[r1]; r3 = stringFmt[r2]; r1 === r2 && r2 === r3], True, TimeConstraint -> $timeLimit, TestID -> "reformatCatalog-string-formatting-idempotent@@Tests/ManageResources/reformatCatalog.wlt:201,1-214,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "reformatCatalog",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../ManageResources/reformatCatalog.wlt"
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
