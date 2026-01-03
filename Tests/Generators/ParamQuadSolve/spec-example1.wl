(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/ParamQuadSolve/spec-example1.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`specexample1`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["spec-example1 Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`specExample1`"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve; ],
    HoldComplete[VerificationTest[Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, res}, params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3}; eqns = {(c11 + vv/2)*x^2 + c12*y == c13*x - 3 + c14 /. params, c21*x + c23*x^2 - c24*y == y - 3*x /. params}; vars = {x, y}; res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals]; AssociationQ[res]], True, {}, TestID -> "returns-association@@Tests/ParamQuadSolve/spec-example1.wlt:10,1-24,2"]],
    HoldComplete[VerificationTest[Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, res, signKeys}, params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3}; eqns = {(c11 + vv/2)*x^2 + c12*y == c13*x - 3 + c14 /. params, c21*x + c23*x^2 - c24*y == y - 3*x /. params}; vars = {x, y}; res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals]; signKeys = Keys[res["SignRootMap"]]; Length[signKeys] === 1], True, {}, TestID -> "one-sign-variable@@Tests/ParamQuadSolve/spec-example1.wlt:26,1-41,2"]],
    HoldComplete[VerificationTest[Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, res, signKeys, assigns, ourRules}, params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3}; eqns = {(c11 + vv/2)*x^2 + c12*y == c13*x - 3 + c14 /. params, c21*x + c23*x^2 - c24*y == y - 3*x /. params}; vars = {x, y}; res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals]; signKeys = Keys[res["SignRootMap"]]; assigns = Tuples[{-1, 1}, Length[signKeys]]; ourRules = (res["Solution"] /. Thread[signKeys -> #1] & ) /@ assigns; Length[ourRules] === 2], True, {}, TestID -> "two-branches@@Tests/ParamQuadSolve/spec-example1.wlt:43,1-60,2"]],
    HoldComplete[VerificationTest[Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, res, signKeys, assigns, ourRules}, params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3}; eqns = {(c11 + vv/2)*x^2 + c12*y == c13*x - 3 + c14 /. params, c21*x + c23*x^2 - c24*y == y - 3*x /. params}; vars = {x, y}; res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals]; signKeys = Keys[res["SignRootMap"]]; assigns = Tuples[{-1, 1}, Length[signKeys]]; ourRules = (res["Solution"] /. Thread[signKeys -> #1] & ) /@ assigns; And @@ (AllTrue[Simplify[eqns //. #1], TrueQ] & ) /@ ourRules], True, {}, TestID -> "subs-all-branches@@Tests/ParamQuadSolve/spec-example1.wlt:62,1-79,2"]],
    HoldComplete[VerificationTest[Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, res, signKeys, assigns, ourRules, solveRules}, params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3}; eqns = {(c11 + vv/2)*x^2 + c12*y == c13*x - 3 + c14 /. params, c21*x + c23*x^2 - c24*y == y - 3*x /. params}; vars = {x, y}; res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals]; signKeys = Keys[res["SignRootMap"]]; assigns = Tuples[{-1, 1}, Length[signKeys]]; ourRules = (res["Solution"] /. Thread[signKeys -> #1] & ) /@ assigns; solveRules = Solve[eqns, vars]; Length[solveRules] == Length[ourRules]], True, {}, TestID -> "solve-count-match@@Tests/ParamQuadSolve/spec-example1.wlt:81,1-99,2"]],
    HoldComplete[VerificationTest[Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, res, signKeys, assigns, ourRules, solveRules, sameQ}, params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3}; eqns = {(c11 + vv/2)*x^2 + c12*y == c13*x - 3 + c14 /. params, c21*x + c23*x^2 - c24*y == y - 3*x /. params}; vars = {x, y}; res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals]; signKeys = Keys[res["SignRootMap"]]; assigns = Tuples[{-1, 1}, Length[signKeys]]; ourRules = (res["Solution"] /. Thread[signKeys -> #1] & ) /@ assigns; solveRules = Solve[eqns, vars]; sameQ[r1_, r2_] := Quiet[Chop[N[(vars //. r1) - (vars //. r2), 50]] == ConstantArray[0, Length[vars]]]; AllTrue[solveRules, Function[ssol, AnyTrue[ourRules, sameQ[#1, ssol] & ]]]], True, {}, TestID -> "matches-Solve@@Tests/ParamQuadSolve/spec-example1.wlt:101,1-120,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "spec-example1",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../ParamQuadSolve/spec-example1.wlt"
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
