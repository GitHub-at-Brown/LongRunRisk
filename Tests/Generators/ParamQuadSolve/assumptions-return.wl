(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/ParamQuadSolve/assumptions-return.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`assumptionsreturn`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["assumptions-return Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`assumptionsReturn`"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve; ],
    HoldComplete[VerificationTest[Module[{x, y, eqns, vars, res}, eqns = {x^2 == 1, y == x + 1}; vars = {x, y}; res = pqs[eqns, vars, "ValidationOption" -> False]; KeyExistsQ[res, "Assumptions"]], True, {}, TestID -> "assumptions-key-exists-default@@Tests/ParamQuadSolve/assumptions-return.wlt:12,1-22,2"]],
    HoldComplete[VerificationTest[Module[{x, y, eqns, vars, res, ass}, eqns = {x^2 == 1, y == x + 1}; vars = {x, y}; res = pqs[eqns, vars, "Assumptions" -> Automatic, "ValidationOption" -> False]; ass = res["Assumptions"]; StringContainsQ[ToString[ass, InputForm], "delta"] && StringContainsQ[ToString[ass, InputForm], "gamma"] && StringContainsQ[ToString[ass, InputForm], "psi"]], True, {}, TestID -> "assumptions-include-defaults-automatic@@Tests/ParamQuadSolve/assumptions-return.wlt:24,1-37,2"]],
    HoldComplete[VerificationTest[Module[{x, y, eqns, vars, res, ass}, eqns = {x^2 == 1, y == x + 1}; vars = {x, y}; res = pqs[eqns, vars, "ValidationOption" -> False]; ass = res["Assumptions"]; StringContainsQ[ToString[ass, InputForm], "delta"] && StringContainsQ[ToString[ass, InputForm], "gamma"] && StringContainsQ[ToString[ass, InputForm], "psi"]], True, {}, TestID -> "assumptions-include-defaults-omitted@@Tests/ParamQuadSolve/assumptions-return.wlt:39,1-52,2"]],
    HoldComplete[VerificationTest[Module[{x, y, a, b, eqns, vars, res, ass}, eqns = {x^2 == a, y == x + b}; vars = {x, y}; res = pqs[eqns, vars, "ValidationOption" -> False]; ass = res["Assumptions"]; StringContainsQ[ToString[ass, InputForm], "signA[1]^2 == 1"]], True, {}, TestID -> "assumptions-include-sign-constraints@@Tests/ParamQuadSolve/assumptions-return.wlt:54,1-65,2"]],
    HoldComplete[VerificationTest[Module[{x, y, a, b, eqns, vars, customAss, res, ass, assStr}, eqns = {x^2 == a, y == x + b}; vars = {x, y}; customAss = a > 0 && b > 0; res = pqs[eqns, vars, "Assumptions" -> customAss, "ValidationOption" -> False]; ass = res["Assumptions"]; assStr = ToString[ass, InputForm]; StringContainsQ[assStr, RegularExpression["a\\$\\d+ > 0"]] && StringContainsQ[assStr, RegularExpression["b\\$\\d+ > 0"]] && StringContainsQ[assStr, "delta"] && StringContainsQ[assStr, "gamma"]], True, {}, TestID -> "assumptions-combine-custom-and-defaults@@Tests/ParamQuadSolve/assumptions-return.wlt:67,1-84,2"]],
    HoldComplete[VerificationTest[Module[{x, y, eqns, vars, res, ass}, eqns = {x == 1, y == x + 1}; vars = {x, y}; res = pqs[eqns, vars, "ValidationOption" -> False]; ass = res["Assumptions"];  !StringContainsQ[ToString[ass, InputForm], "signA"]], True, {}, TestID -> "assumptions-no-sign-when-no-quadratics@@Tests/ParamQuadSolve/assumptions-return.wlt:86,1-97,2"]],
    HoldComplete[VerificationTest[Module[{x, y, z, a, b, eqns, vars, res, ass}, eqns = {x^2 == a, y^2 == b, z == x + y}; vars = {x, y, z}; res = pqs[eqns, vars, "ValidationOption" -> False]; ass = res["Assumptions"]; StringContainsQ[ToString[ass, InputForm], "signA[1]^2 == 1"] && StringContainsQ[ToString[ass, InputForm], "signA[2]^2 == 1"]], True, {}, TestID -> "assumptions-multiple-sign-constraints@@Tests/ParamQuadSolve/assumptions-return.wlt:99,1-111,2"]],
    HoldComplete[VerificationTest[Module[{x, y, a, b, eqns, vars, customAss, res}, eqns = {x^2 == a, y == x + b}; vars = {x, y}; customAss = a > 0 && Element[a, Reals] && Element[b, Reals]; res = pqs[eqns, vars, "Assumptions" -> customAss, "ValidationOption" -> True]; AssociationQ[res] && KeyExistsQ[res, "Verification"]], True, {}, TestID -> "assumptions-used-in-verification@@Tests/ParamQuadSolve/assumptions-return.wlt:113,1-124,2"]],
    HoldComplete[VerificationTest[Module[{x, y, z, eqns, vars, res, ass}, eqns = {x^2 == 1, y^2 == 4, z == 5}; vars = {x, y, z}; res = pqs[eqns, vars, "OnlyQuadTerms" -> True, "ValidationOption" -> False]; ass = res["Assumptions"]; AssociationQ[res] && KeyExistsQ[res, "Assumptions"] && StringContainsQ[ToString[ass, InputForm], "signA"]], True, {}, TestID -> "assumptions-with-only-quad-terms@@Tests/ParamQuadSolve/assumptions-return.wlt:126,1-139,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "assumptions-return",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../ParamQuadSolve/assumptions-return.wlt"
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
