(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/ModelDefinition/ExogenousEq.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`ExogenousEq`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["ExogenousEq Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"]; ],
    HoldComplete[VerificationTest[ !Names["*xeq"] === {}, True, {}, TestID -> "ExogenousEq_20251223-ZYM4OJ@@Tests/ModelDefinition/ExogenousEq.wlt:7,1-15,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"]; ],
    HoldComplete[VerificationTest[And @@ {MemberQ[DeleteDuplicates[Context /@ Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t], (FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol)?(MatchQ[SymbolName[#1], "x"] & )[___] :> FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var, Infinity]], "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"], MemberQ[DeleteDuplicates[Context /@ Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`pieq[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t], (FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol)?(MatchQ[SymbolName[#1], "pi"] & )[___] :> FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var, Infinity]], "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"], MemberQ[DeleteDuplicates[Context /@ Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`pibareq[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t], (FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol)?(MatchQ[SymbolName[#1], "pibar"] & )[___] :> FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var, Infinity]], "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"], MemberQ[DeleteDuplicates[Context /@ Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`sgeq[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t], (FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol)?(MatchQ[SymbolName[#1], "sg"] & )[___] :> FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var, Infinity]], "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"], MemberQ[DeleteDuplicates[Context /@ Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`sxeq[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t], (FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol)?(MatchQ[SymbolName[#1], "sx"] & )[___] :> FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var, Infinity]], "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"], MemberQ[DeleteDuplicates[Context /@ Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`sceq[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t], (FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol)?(MatchQ[SymbolName[#1], "sc"] & )[___] :> FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var, Infinity]], "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"], MemberQ[DeleteDuplicates[Context /@ Cases[FernandoDuarte`LongRunRisk`Model`ExogenousEq`speq[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t], (FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol)?(MatchQ[SymbolName[#1], "sp"] & )[___] :> FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var, Infinity]], "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],  !{} === Cases[Symbol /@ Names["FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*"], (FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol)?(MatchQ[SymbolName[#1], "dc"] & ) :> FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var, Infinity],  !{} === Cases[Symbol /@ Names["FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*"], (FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol)?(MatchQ[SymbolName[#1], "dd"] & ) :> FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var, Infinity], MemberQ[DeleteDuplicates[Context /@ Cases[Symbol /@ Names["FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*"], (FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol)?(MatchQ[SymbolName[#1], "dc"] & ) :> FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var, Infinity]], "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"], MemberQ[DeleteDuplicates[Context /@ Cases[Symbol /@ Names["FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*"], (FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol)?(MatchQ[SymbolName[#1], "dd"] & ) :> FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var, Infinity]], "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]}, True, {}, TestID -> "ExogenousEq_20251223-H81EM4@@Tests/ModelDefinition/ExogenousEq.wlt:20,1-179,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"]; ],
    HoldComplete[VerificationTest[And @@ (#1 === "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`" & ) /@ Context /@ Cases[(#1[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t] & ) /@ Symbol /@ FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars, (FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol)?(MemberQ[(StringDrop[#1, -2] & ) /@ FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars, SymbolName[#1]] & )[__] :> FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var, Infinity], True, {}, TestID -> "ExogenousEq_20251223-PWNV9J@@Tests/ModelDefinition/ExogenousEq.wlt:184,1-212,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"]; ],
    HoldComplete[VerificationTest[And @@ (#1 === "FernandoDuarte`LongRunRisk`Model`Shocks`" & ) /@ Context /@ Cases[(#1[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t] & ) /@ Symbol /@ FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars, (FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol)?(MatchQ[SymbolName[#1], "eps"] & )[__][__] :> FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var, Infinity], True, {}, TestID -> "ExogenousEq_20251223-GBWLQP@@Tests/ModelDefinition/ExogenousEq.wlt:217,1-237,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"]; ],
    HoldComplete[VerificationTest[And @@ (#1 === "FernandoDuarte`LongRunRisk`Model`Parameters`" & ) /@ Context /@ Cases[(#1[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t] & ) /@ Symbol /@ FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars, (FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var_Symbol)?(MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#1]] & ) :> FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`var, Infinity], True, {}, TestID -> "ExogenousEq_20251223-A7X3P4@@Tests/ModelDefinition/ExogenousEq.wlt:242,1-262,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"]; ],
    HoldComplete[VerificationTest[And @@ {FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t], foo`t],  !FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t], FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t], FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq[foo`t], FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t],  !FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq[foo`t], foo`t],  !foo`xeq[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t] === FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t],  !FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq[FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t] === FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq[foo`t]}, True, {}, TestID -> "ExogenousEq_20251223-0DJU31@@Tests/ModelDefinition/ExogenousEq.wlt:267,1-284,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "ExogenousEq",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../ModelDefinition/ExogenousEq.wlt"
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
