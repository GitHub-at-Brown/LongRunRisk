(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/ModelDefinition/Shocks.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`Shocks`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["Shocks Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`Model`Shocks`"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"]; ],
    HoldComplete[VerificationTest[MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Shocks`"], True, {}, TestID -> "Shocks_20251223-AVT46T@@Tests/ModelDefinition/Shocks.wlt:7,1-15,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"]; ],
    HoldComplete[VerificationTest[ !Names["*rulesE"] === {}, True, {}, TestID -> "Shocks_20251223-HL1LFB@@Tests/ModelDefinition/Shocks.wlt:20,1-28,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"]; ],
    HoldComplete[VerificationTest[And @@ Flatten[{Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === 0, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}], Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === 0, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}]}], True, {}, TestID -> "Shocks_20251223-YEV9IQ@@Tests/ModelDefinition/Shocks.wlt:33,1-52,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"]; ],
    HoldComplete[VerificationTest[And @@ Flatten[{Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]^2 /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === 1, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}], Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii]^2 /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === 1, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}]}], True, {}, TestID -> "Shocks_20251223-B4YKQ7@@Tests/ModelDefinition/Shocks.wlt:57,1-76,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"]; ],
    HoldComplete[VerificationTest[And @@ Flatten[{Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]^3 /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === 0, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}], Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii]^3 /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === 0, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}]}], True, {}, TestID -> "Shocks_20251223-3S6A1J@@Tests/ModelDefinition/Shocks.wlt:81,1-100,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"]; ],
    HoldComplete[VerificationTest[And @@ Flatten[{Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]^4 /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === 3, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}], Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii]^4 /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === 3, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}]}], True, {}, TestID -> "Shocks_20251223-2XD9EI@@Tests/ModelDefinition/Shocks.wlt:105,1-124,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"]; ],
    HoldComplete[VerificationTest[And @@ Flatten[{Table[0 === If[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f === FernandoDuarte`LongRunRisk`Tests`Model`Shocks`g, 0, FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]*FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`g][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]], {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`g, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}], Table[0 === (FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii]*FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]), {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "pi", "pibar", "sg", "sx", "sc", "sp"}}]}], True, {}, TestID -> "Shocks_20251223-U4N31Y@@Tests/ModelDefinition/Shocks.wlt:129,1-159,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"]; ],
    HoldComplete[VerificationTest[With[{FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tb = Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii]*FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}]}, {SymbolName @* Head /@ FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tb, (If[NumberQ[#1], ToString[#1], If[Developer`HoldSymbolQ[#1], SymbolName[#1], ""]] & ) @* First /@ FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tb} === {{"taugd", "taugd", "taugd"}, {"1", "i", "j"}}], True, {}, TestID -> "Shocks_20251223-XDJQWX@@Tests/ModelDefinition/Shocks.wlt:164,1-194,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"]; ],
    HoldComplete[VerificationTest[And @@ Flatten[{Table[(FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr, Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t + 1], {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}]}], Table[(FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr, Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[ToExpression[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f]][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t], {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}]}], Table[(FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr, {FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t + 1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i], FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`dd][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i]}}]}], True, {}, TestID -> "Shocks_20251223-U3G5UH@@Tests/ModelDefinition/Shocks.wlt:199,1-234,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"]; ],
    HoldComplete[VerificationTest[And @@ Flatten[{Table[(FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr, Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f], {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}]}], Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"], {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}]}], True, {}, TestID -> "Shocks_20251223-Q140R5@@Tests/ModelDefinition/Shocks.wlt:239,1-263,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"]; ],
    HoldComplete[VerificationTest[And @@ Flatten[{Table[(FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr, Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f], {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"xx", "adc", "p", "rhobar", "ssg", "ssx", "sdc", "spi"}}]}], Table[(FernandoDuarte`LongRunRisk`Model`Shocks`eps["ddd"] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === FernandoDuarte`LongRunRisk`Model`Shocks`eps["ddd"], {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}]}], True, {}, TestID -> "Shocks_20251223-7O3J7T@@Tests/ModelDefinition/Shocks.wlt:268,1-295,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"]; ],
    HoldComplete[VerificationTest[And @@ Flatten[{Table[(FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr, Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tt], {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"xx", "adc", "p", "rhobar", "ssg", "ssx", "sdc", "spi"}}, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tt, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t + 1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t - 1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`s, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t + FernandoDuarte`LongRunRisk`Tests`Model`Shocks`h}}]}], Table[(FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`expr, Table[FernandoDuarte`LongRunRisk`Model`Shocks`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tt, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii], {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`tt, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t + 1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t - 1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`s, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t + FernandoDuarte`LongRunRisk`Tests`Model`Shocks`h}}]}]}], True, {}, TestID -> "Shocks_20251223-D9MOEK@@Tests/ModelDefinition/Shocks.wlt:300,1-334,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"]; ],
    HoldComplete[VerificationTest[And @@ Flatten[{Table[(NewContext`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === 0, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}], Table[(NewContext`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii] /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === 0, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}]}], True, {}, TestID -> "Shocks_20251223-DD6HSL@@Tests/ModelDefinition/Shocks.wlt:339,1-358,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"]; ],
    HoldComplete[VerificationTest[And @@ Flatten[{Table[(FernandoDuarte`LongRunRisk`Model`Shocks`Private`eps[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]^2 /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === 1, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}], Table[(FernandoDuarte`LongRunRisk`Model`Shocks`Private`eps["dd"][FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii]^2 /. FernandoDuarte`LongRunRisk`Model`Shocks`rulesE[FernandoDuarte`LongRunRisk`Tests`Model`Shocks`t]) === 1, {FernandoDuarte`LongRunRisk`Tests`Model`Shocks`ii, {1, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`i, FernandoDuarte`LongRunRisk`Tests`Model`Shocks`j}}]}], True, {}, TestID -> "Shocks_20251223-Z3LKCQ@@Tests/ModelDefinition/Shocks.wlt:363,1-382,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "Shocks",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../ModelDefinition/Shocks.wlt"
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
