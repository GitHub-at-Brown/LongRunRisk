(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/ParamQuadSolve/options-and-domain.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`optionsanddomain`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["options-and-domain Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`optionsAndDomain`"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve; ],
    HoldComplete[loadMessages = Block[{$MessageList = {}}, Off[General::shdw]; On[General::shdw]; $MessageList]; ],
    HoldComplete[VerificationTest[loadMessages === {}, True, {}, TestID -> "package-load-clean@@Tests/ParamQuadSolve/options-and-domain.wlt:13,1-18,2"]],
    HoldComplete[VerificationTest[Module[{x, y, eq, vars, rBase}, eq = {x^2 - 5 == 0, y + 2*x - 3 == 0}; vars = {x, y}; rBase = Quiet[pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> True], {Power::infy, Infinity::indet}]; AssociationQ[rBase]], True, {}, TestID -> "assoc-r1@@Tests/ParamQuadSolve/options-and-domain.wlt:20,1-30,2"]],
    HoldComplete[VerificationTest[Module[{x, y, eq, vars, rSeq, diagMethodOK}, eq = {x^2 - 5 == 0, y + 2*x - 3 == 0}; vars = {x, y}; rSeq = Quiet[pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False, "Method" -> "Sequential"], {Power::infy, Infinity::indet}]; diagMethodOK = rSeq["Diagnostics"]["Method"] === "Sequential"; diagMethodOK], True, {}, TestID -> "method-option-used@@Tests/ParamQuadSolve/options-and-domain.wlt:32,1-43,2"]],
    HoldComplete[VerificationTest[Module[{x, y, eq, vars, rOrder, diagOrderOK}, eq = {x^2 - 5 == 0, y + 2*x - 3 == 0}; vars = {x, y}; rOrder = Quiet[pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False, "Method" -> "SequentialWithGroebner", "MonomialOrder" -> DegreeReverseLexicographic], {Power::infy, Infinity::indet}]; diagOrderOK = rOrder["Diagnostics"]["GroebnerMonomialOrder"] === DegreeReverseLexicographic; diagOrderOK], True, {}, TestID -> "monomial-order-recorded@@Tests/ParamQuadSolve/options-and-domain.wlt:45,1-56,2"]],
    HoldComplete[VerificationTest[Module[{x, y, sg, eq, vars, rSign, signHeadOK}, eq = {x^2 - 5 == 0, y + 2*x - 3 == 0}; vars = {x, y}; rSign = Quiet[pqs[eq, vars, "SymbolicSignSymbol" -> sg, "DomainOption" -> Reals], {Power::infy, Infinity::indet}]; signHeadOK = And @@ (Head /@ Keys[rSign["SignRootMap"]] === Table[sg, {Length[Keys[rSign["SignRootMap"]]]}]); signHeadOK], True, {}, TestID -> "symbolicsignsymbol-head@@Tests/ParamQuadSolve/options-and-domain.wlt:58,1-69,2"]],
    HoldComplete[VerificationTest[Module[{x, y, eq, vars, rRad, radCondOK}, eq = {x^2 - 1 == 0, y^2 - x == 0}; vars = {x, y}; rRad = Quiet[pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False], {Power::infy, Infinity::indet}]; radCondOK = Module[{sk = Keys[rRad["SignRootMap"]]}, MemberQ[rRad["Conditions"], First[sk] >= 0]]; radCondOK], True, {}, TestID -> "radicand-sign-constraint@@Tests/ParamQuadSolve/options-and-domain.wlt:71,1-82,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "options-and-domain",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../ParamQuadSolve/options-and-domain.wlt"
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
