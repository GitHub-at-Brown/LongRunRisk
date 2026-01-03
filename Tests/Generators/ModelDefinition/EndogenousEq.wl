(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/ModelDefinition/EndogenousEq.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`EndogenousEq`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["EndogenousEq Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"]; ],
    HoldComplete[VerificationTest[ !Names["*pdeq"] === {}, True, {}, TestID -> "EndogenousEq_20251223-C3LW7Z@@Tests/ModelDefinition/EndogenousEq.wlt:7,1-15,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"]; ],
    HoldComplete[VerificationTest[And @@ (#1 === "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`" & ) /@ Context /@ Cases[(#1[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t] & ) /@ Symbol /@ FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars, (FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var_Symbol)?(MemberQ[(StringDrop[#1, -2] & ) /@ FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars, SymbolName[#1]] & )[__] :> FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var, Infinity], True, {}, TestID -> "EndogenousEq_20251223-2SME0U@@Tests/ModelDefinition/EndogenousEq.wlt:20,1-48,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"]; ],
    HoldComplete[VerificationTest[And @@ (#1 === "FernandoDuarte`LongRunRisk`Model`Shocks`" & ) /@ Context /@ Cases[(#1[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t] & ) /@ Symbol /@ FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars, (FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var_Symbol)?(MatchQ[SymbolName[#1], "eps"] & )[__][__] :> FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var, Infinity], True, {}, TestID -> "EndogenousEq_20251223-L0VUEJ@@Tests/ModelDefinition/EndogenousEq.wlt:53,1-73,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`"]; ],
    HoldComplete[VerificationTest[Module[{testModel, endoEqs, paramSymbols}, testModel = FernandoDuarte`LongRunRisk`Models["BY"]; endoEqs = testModel["endogenousEq"]; paramSymbols = Cases[Values[endoEqs], sym_Symbol /; Context[sym] === "FernandoDuarte`LongRunRisk`Model`Parameters`", Infinity]; If[Length[paramSymbols] > 0, Module[{uniqueParams, paramNames}, uniqueParams = DeleteDuplicates[paramSymbols]; paramNames = SymbolName /@ uniqueParams; And @@ (MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, #1] & ) /@ paramNames], True]], True, {}, TestID -> "EndogenousEq_20251223-077TRW@@Tests/ModelDefinition/EndogenousEq.wlt:80,1-112,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"]; ],
    HoldComplete[VerificationTest[And @@ (#1 === "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`" & ) /@ Context /@ Cases[(#1[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t] & ) /@ Symbol /@ FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars, (FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var_Symbol)?(MemberQ[(StringDrop[#1, -2] & ) /@ FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars, SymbolName[#1]] & )[__] :> FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var, Infinity], True, {}, TestID -> "EndogenousEq_20251223-72QAYI@@Tests/ModelDefinition/EndogenousEq.wlt:117,1-145,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"]; ],
    HoldComplete[VerificationTest[And @@ {FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], foo`t],  !FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t], FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[foo`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t],  !FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[foo`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], foo`t],  !foo`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m] === FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m],  !FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m] === FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[foo`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m]}, True, {}, TestID -> "EndogenousEq_20251223-J1CO3Y@@Tests/ModelDefinition/EndogenousEq.wlt:150,1-167,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"]; ],
    HoldComplete[VerificationTest[And @@ {FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], foo`m],  !FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, foo`m], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m],  !FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, foo`m], foo`m],  !FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m] === FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, foo`m]}, True, {}, TestID -> "EndogenousEq_20251223-5751HS@@Tests/ModelDefinition/EndogenousEq.wlt:172,1-188,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"]; ],
    HoldComplete[VerificationTest[And @@ {FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondfweq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m] === FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondfweq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m, 1], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondreteq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m] === FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondreteq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m, 1], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondfwspreadeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m] === FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondfwspreadeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m, 1], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondexcreteq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m] === FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondexcreteq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m, 1]}, True, {}, TestID -> "EndogenousEq_20251223-CZNT6S@@Tests/ModelDefinition/EndogenousEq.wlt:193,1-208,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"]; ],
    HoldComplete[VerificationTest[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefwc = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc; FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefpd = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd; FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefb = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb; FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefnb = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb; FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`hpd = Head[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefpd]; FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`hb = Head[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefb]; FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`hnb = Head[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefnb]; FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`ch = Flatten[{{FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefwc[0], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefwc[0]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefwc[0]], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefwc[0.], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefwc[0.]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefwc[0.]]}, Table[{FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`c[0], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`c[0]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`c[0]], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`c[0.], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`c[0.]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`c[0.]]}, {FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`c, {FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefpd, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefb, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefnb}}], Table[{FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1][0], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1][0]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1][0]], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1][0.], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1][0.]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1][0.]], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][1], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][1]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][1]], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][1], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][1]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][1]], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1.][0], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1.][0]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1.][0]], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1.][0.], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1.][0.]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1.][0.]], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][1.], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][1.]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0]][1.], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][1.], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][1.]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][1.]], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j]], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j]], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j][0], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j][0]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j][0]], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j][0.], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j][0.]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j][0.]], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][jj], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][jj]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][jj]], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][jj], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][jj]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][jj]], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[jj][0], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[jj][0]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[jj][0]], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[jj][0.], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[jj][0.]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[jj][0.]], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[jj][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`kk], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[jj][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`kk]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[jj][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`kk]], N[Table[{FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`ii][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`qq], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`ii][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`qq]], N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`ii][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`qq]]}, {FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`ii, 0, 1}, {FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`qq, 2, 3}]]} /. jj -> 2 /. FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`kk -> 3, {FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h, {Head[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefpd], Head[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefb], Head[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefnb]}}]}]; And @@ Flatten[{{Not /@ InexactNumberQ /@ Select[Flatten[Cases[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`ch, (FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`x_)[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`i_] :> FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`i]], NumberQ], Not /@ InexactNumberQ /@ Select[Flatten[Cases[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`ch, (FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`x_)[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`i_][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j_] :> {FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`i, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j}]], NumberQ]}}], True, {}, TestID -> "EndogenousEq_20251223-402VM5@@Tests/ModelDefinition/EndogenousEq.wlt:213,1-341,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "EndogenousEq",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../ModelDefinition/EndogenousEq.wlt"
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
