(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/ParamQuadSolve/orphan-variable-avoidance.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`orphanvariableavoidance`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["orphan-variable-avoidance Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`orphanVariableAvoidance`"]],
    HoldComplete[Null],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"]; ],
    HoldComplete[pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve; ],
    HoldComplete[Null],
    HoldComplete[VerificationTest[Module[{eqns, vars, res, selectedEqs, deferredEqs}, eqns = {x^2 == 1, y^2 == 4, x^2 + y + w == 0, z == 5}; vars = {x, y, z, w}; res = pqs[eqns, vars, "OnlyQuadTerms" -> True]; deferredEqs = res["Diagnostics"]["DeferredEquationsIndices"]; selectedEqs = Complement[Range[4], deferredEqs]; AssociationQ[res] && Sort[selectedEqs] === {1, 2} && MemberQ[deferredEqs, 3] && MemberQ[res["DeferredVariables"], w]], True, TestID -> "orphan-simple-avoidance@@Tests/ParamQuadSolve/orphan-variable-avoidance.wlt:12,1-35,2"]],
    HoldComplete[Null],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"]; ],
    HoldComplete[pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve; ],
    HoldComplete[Null],
    HoldComplete[VerificationTest[Module[{eqns, vars, res, selectedEqs, deferredEqs}, eqns = {a^2 == 1, a^2 + b^2 == 2, b^2 + c == 3, d == 4}; vars = {a, b, c, d}; res = pqs[eqns, vars, "OnlyQuadTerms" -> True]; selectedEqs = Complement[Range[4], res["Diagnostics"]["DeferredEquationsIndices"]]; deferredEqs = res["Diagnostics"]["DeferredEquationsIndices"]; AssociationQ[res] && Sort[selectedEqs] === {1, 2} && MemberQ[deferredEqs, 3] && MemberQ[res["DeferredVariables"], c]], True, TestID -> "orphan-prefer-no-orphans@@Tests/ParamQuadSolve/orphan-variable-avoidance.wlt:45,1-67,2"]],
    HoldComplete[Null],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"]; ],
    HoldComplete[pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve; ],
    HoldComplete[Null],
    HoldComplete[VerificationTest[Module[{sys, vars, res, deferredEqs, varsInDeferred}, sys = {0 == ((1 - gamma)*(-1 + psi)*rhocp)/((1 - 1/psi)*psi) - ((1 - gamma)*A[1])/(1 - 1/psi) + (E^A[0]*(1 - gamma)*vpp*A[7])/((1 + E^A[0])*(1 - 1/psi)), 0 == ((1 - gamma)*(-1 + psi)*xic)/((1 - 1/psi)*psi) - ((1 - gamma)*A[2])/(1 - 1/psi), 0 == (E^A[0]*(1 - gamma)*xip*A[1])/((1 + E^A[0])*(1 - 1/psi)) - ((1 - gamma)*A[3])/(1 - 1/psi), 0 == (E^(2*A[0])*(1 - gamma)^2*phip*A[1]*A[2])/((1 + E^A[0])^2*(1 - 1/psi)^2) + A[2]*((E^A[0]*(1 - gamma)^2*phicp*(-1 + psi))/((1 + E^A[0])*(1 - 1/psi)^2*psi) + (E^(2*A[0])*(1 - gamma)^2*A[3])/((1 + E^A[0])^2*(1 - 1/psi)^2)) - (2*E^A[0]*Esg*(1 - gamma)*(-1 + rhog)*rhog*A[5])/((1 + E^A[0])*(1 - 1/psi)) - (4*E^(2*A[0])*Esg*(1 - gamma)^2*phig^2*(-1 + rhog)*rhog*A[5]^2)/((1 + E^A[0])^2*(1 - 1/psi)^2) + A[4]*(((1 - gamma)*(-1 + E^A[0]*(-1 + rhog)))/((1 + E^A[0])*(1 - 1/psi)) + (2*E^(2*A[0])*(1 - gamma)^2*phig^2*rhog*A[5])/((1 + E^A[0])^2*(1 - 1/psi)^2)), 0 == (E^(2*A[0])*(1 - gamma)^2*A[2]^2)/(2*(1 + E^A[0])^2*(1 - 1/psi)^2) + ((1 - gamma)*(-1 + E^A[0]*(-1 + rhog^2))*A[5])/((1 + E^A[0])*(1 - 1/psi)) + (2*E^(2*A[0])*(1 - gamma)^2*phig^2*rhog^2*A[5]^2)/((1 + E^A[0])^2*(1 - 1/psi)^2), 0 == ((1 - gamma)*(-1 + psi)*rhocpbar)/((1 - 1/psi)*psi) + (E^A[0]*(1 - gamma)*rhoppbar*A[1])/((1 + E^A[0])*(1 - 1/psi)) + ((1 - gamma)*(-1 + E^A[0]*(-1 + rhopbar))*A[6])/((1 + E^A[0])*(1 - 1/psi)) + (E^A[0]*(1 - gamma)*vppbar*A[7])/((1 + E^A[0])*(1 - 1/psi)), 0 == (E^(2*A[0])*(1 - gamma)^2*phipbarpb^2*A[6]^2)/(2*(1 + E^A[0])^2*(1 - 1/psi)^2) + ((1 - gamma)*(-1 + E^A[0]*(-1 + vp))*A[7])/((1 + E^A[0])*(1 - 1/psi))}; vars = {A[1], A[2], A[3], A[4], A[5], A[6], A[7]}; res = pqs[sys, vars, "OnlyQuadTerms" -> True]; deferredEqs = res["Diagnostics"]["DeferredEquationsIndices"]; AssociationQ[res] && MemberQ[deferredEqs, 4] && MemberQ[res["DeferredVariables"], A[4]] &&  !FreeQ[res["DeferredEquations"][[Position[deferredEqs, 4][[1,1]]]], A[4]]], True, TestID -> "orphan-longrunrisk-eq4-deferred@@Tests/ParamQuadSolve/orphan-variable-avoidance.wlt:77,1-119,2"]],
    HoldComplete[Null],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"]; ],
    HoldComplete[pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve; ],
    HoldComplete[Null],
    HoldComplete[VerificationTest[Module[{sys, vars, res, deferredEqs, deferredVars, varsInDeferredEqs, orphanedVars}, sys = {0 == ((1 - gamma)*(-1 + psi)*rhocp)/((1 - 1/psi)*psi) - ((1 - gamma)*A[1])/(1 - 1/psi) + (E^A[0]*(1 - gamma)*vpp*A[7])/((1 + E^A[0])*(1 - 1/psi)), 0 == ((1 - gamma)*(-1 + psi)*xic)/((1 - 1/psi)*psi) - ((1 - gamma)*A[2])/(1 - 1/psi), 0 == (E^A[0]*(1 - gamma)*xip*A[1])/((1 + E^A[0])*(1 - 1/psi)) - ((1 - gamma)*A[3])/(1 - 1/psi), 0 == (E^(2*A[0])*(1 - gamma)^2*phip*A[1]*A[2])/((1 + E^A[0])^2*(1 - 1/psi)^2) + A[2]*((E^A[0]*(1 - gamma)^2*phicp*(-1 + psi))/((1 + E^A[0])*(1 - 1/psi)^2*psi) + (E^(2*A[0])*(1 - gamma)^2*A[3])/((1 + E^A[0])^2*(1 - 1/psi)^2)) - (2*E^A[0]*Esg*(1 - gamma)*(-1 + rhog)*rhog*A[5])/((1 + E^A[0])*(1 - 1/psi)) - (4*E^(2*A[0])*Esg*(1 - gamma)^2*phig^2*(-1 + rhog)*rhog*A[5]^2)/((1 + E^A[0])^2*(1 - 1/psi)^2) + A[4]*(((1 - gamma)*(-1 + E^A[0]*(-1 + rhog)))/((1 + E^A[0])*(1 - 1/psi)) + (2*E^(2*A[0])*(1 - gamma)^2*phig^2*rhog*A[5])/((1 + E^A[0])^2*(1 - 1/psi)^2)), 0 == (E^(2*A[0])*(1 - gamma)^2*A[2]^2)/(2*(1 + E^A[0])^2*(1 - 1/psi)^2) + ((1 - gamma)*(-1 + E^A[0]*(-1 + rhog^2))*A[5])/((1 + E^A[0])*(1 - 1/psi)) + (2*E^(2*A[0])*(1 - gamma)^2*phig^2*rhog^2*A[5]^2)/((1 + E^A[0])^2*(1 - 1/psi)^2), 0 == ((1 - gamma)*(-1 + psi)*rhocpbar)/((1 - 1/psi)*psi) + (E^A[0]*(1 - gamma)*rhoppbar*A[1])/((1 + E^A[0])*(1 - 1/psi)) + ((1 - gamma)*(-1 + E^A[0]*(-1 + rhopbar))*A[6])/((1 + E^A[0])*(1 - 1/psi)) + (E^A[0]*(1 - gamma)*vppbar*A[7])/((1 + E^A[0])*(1 - 1/psi)), 0 == (E^(2*A[0])*(1 - gamma)^2*phipbarpb^2*A[6]^2)/(2*(1 + E^A[0])^2*(1 - 1/psi)^2) + ((1 - gamma)*(-1 + E^A[0]*(-1 + vp))*A[7])/((1 + E^A[0])*(1 - 1/psi))}; vars = {A[1], A[2], A[3], A[4], A[5], A[6], A[7]}; res = pqs[sys, vars, "OnlyQuadTerms" -> True]; deferredEqs = res["DeferredEquations"]; deferredVars = res["DeferredVariables"]; varsInDeferredEqs = Union[Flatten[Cases[deferredEqs, A[i_] :> A[i], Infinity]]]; orphanedVars = Complement[deferredVars, varsInDeferredEqs]; AssociationQ[res] && orphanedVars === {}], True, TestID -> "orphan-no-orphans-in-deferred@@Tests/ParamQuadSolve/orphan-variable-avoidance.wlt:129,1-176,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "orphan-variable-avoidance",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../ParamQuadSolve/orphan-variable-avoidance.wlt"
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
