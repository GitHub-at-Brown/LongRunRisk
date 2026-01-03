(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/ParamQuadSolve/basic-2x2.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`basic2x2`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["basic-2x2 Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`basic2x2`"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve; ],
    HoldComplete[VerificationTest[Module[{x, y, eqns, vars, res}, eqns = {x^2 - 5 == 0, y + 2*x - 3 == 0}; vars = {x, y}; res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals]; AssociationQ[res]], True, {}, TestID -> "returns-association@@Tests/ParamQuadSolve/basic-2x2.wlt:10,1-20,2"]],
    HoldComplete[VerificationTest[Module[{x, y, eqns, vars, res}, eqns = {x^2 - 5 == 0, y + 2*x - 3 == 0}; vars = {x, y}; res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals]; AllTrue[Flatten[res["Verification"]], TrueQ]], True, {}, TestID -> "verification-all-true@@Tests/ParamQuadSolve/basic-2x2.wlt:22,1-32,2"]],
    HoldComplete[VerificationTest[Module[{x, y, eqns, vars, res, signSym}, eqns = {x^2 - 5 == 0, y + 2*x - 3 == 0}; vars = {x, y}; res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals]; signSym = First[Keys[res["SignRootMap"]]]; AllTrue[Simplify[eqns /. res["Solution"] /. signSym -> 1], TrueQ]], True, {}, TestID -> "subs-sign-+1@@Tests/ParamQuadSolve/basic-2x2.wlt:34,1-45,2"]],
    HoldComplete[VerificationTest[Module[{x, y, eqns, vars, res, signSym}, eqns = {x^2 - 5 == 0, y + 2*x - 3 == 0}; vars = {x, y}; res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals]; signSym = First[Keys[res["SignRootMap"]]]; AllTrue[Simplify[eqns /. res["Solution"] /. signSym -> -1], TrueQ]], True, {}, TestID -> "subs-sign--1@@Tests/ParamQuadSolve/basic-2x2.wlt:47,1-58,2"]],
    HoldComplete[VerificationTest[Module[{x, y, eqns, vars, res, signSym, rad}, eqns = {x^2 - 5 == 0, y + 2*x - 3 == 0}; vars = {x, y}; res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals]; signSym = First[Keys[res["SignRootMap"]]]; rad = res["SignRootMap"][signSym]; Simplify[rad^2 == 20]], True, {}, TestID -> "discriminant-20@@Tests/ParamQuadSolve/basic-2x2.wlt:60,1-72,2"]],
    HoldComplete[VerificationTest[Module[{x, y, eqns, vars, res, signSym, signs, ourRules, solveRules, sameQ}, eqns = {x^2 - 5 == 0, y + 2*x - 3 == 0}; vars = {x, y}; res = pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals]; signSym = First[Keys[res["SignRootMap"]]]; signs = {1, -1}; ourRules = (res["Solution"] /. signSym -> #1 & ) /@ signs; solveRules = Solve[eqns, vars, Reals]; sameQ[r1_, r2_] := TrueQ[Simplify[(vars /. r1) == (vars /. r2)]]; Length[solveRules] == Length[ourRules] && AllTrue[solveRules, Function[ssol, AnyTrue[ourRules, sameQ[#1, ssol] & ]]]], True, {}, TestID -> "matches-Solve@@Tests/ParamQuadSolve/basic-2x2.wlt:74,1-89,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "basic-2x2",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../ParamQuadSolve/basic-2x2.wlt"
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
