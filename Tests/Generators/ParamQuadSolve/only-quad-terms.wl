(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/ParamQuadSolve/only-quad-terms.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`onlyquadterms`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["only-quad-terms Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`onlyQuadTerms`"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve; ],
    HoldComplete[VerificationTest[Module[{x, y, z}, pqs[{x^2 + y^2 + z^2 == 3, x^2 + 2*x - 1 == 0}, {x, y, z}, "OnlyQuadTerms" -> True] === $Failed], True, {FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve::nocover}, TestID -> "onlyquad-reject-partial@@Tests/ParamQuadSolve/only-quad-terms.wlt:10,1-17,2"]],
    HoldComplete[VerificationTest[Module[{x, y, z, eqns, vars, res, solvedVars, diagnostics}, eqns = {x^2 - 1 == 0, y^2 - 4 == 0, z^2 - 9 == 0}; vars = {x, y, z}; res = pqs[eqns, vars, "OnlyQuadTerms" -> True]; solvedVars = Sort[res["Diagnostics"]["SolvedQuadraticVariables"]]; diagnostics = res["Diagnostics"]; AssociationQ[res] && solvedVars === {x, y, z} && diagnostics["DeferredVariables"] === {}], True, {}, TestID -> "onlyquad-all-covered@@Tests/ParamQuadSolve/only-quad-terms.wlt:19,1-33,2"]],
    HoldComplete[VerificationTest[Module[{x, y, z, eqns, vars, res, deferredEqns, deferredVars}, eqns = {x^2 == 1, x^2 + y == 2, y + z == 1}; vars = {x, y, z}; res = pqs[eqns, vars, "OnlyQuadTerms" -> True]; deferredEqns = res["DeferredEquations"]; deferredVars = res["DeferredVariables"]; AssociationQ[res] && res["Solution"][[All,1]] === {x} && Length[deferredEqns] == 2 && Sort[deferredVars] === {y, z}], True, {}, TestID -> "onlyquad-deferred-output@@Tests/ParamQuadSolve/only-quad-terms.wlt:35,1-50,2"]],
    HoldComplete[VerificationTest[Module[{x, y}, pqs[{x + y == 1}, {x, y}, "OnlyQuadTerms" -> True] === $Failed], True, {FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve::noquad}, TestID -> "onlyquad-noquadratic@@Tests/ParamQuadSolve/only-quad-terms.wlt:52,1-59,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "only-quad-terms",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../ParamQuadSolve/only-quad-terms.wlt"
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
