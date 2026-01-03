(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`findRootCoeff0EdgeCases`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["findRootCoeff0EdgeCases Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`FindRootOptim`findRootCoeff0EdgeCases`"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 15; ],
    HoldComplete[fri = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval"]; ],
    HoldComplete[bk = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel"]; ],
    HoldComplete[bu = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary"]; ],
    HoldComplete[VerificationTest[Block[{A}, fri[A[0] < 0 && A[0] > 0, Association[x -> 2], "A", "signA"] === $Failed], True, {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval::emptyinterval}, TimeConstraint -> timeLimit, TestID -> "findRootInterval-contradiction-returns-failed@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:18,1-30,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 15; ],
    HoldComplete[fri = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval"]; ],
    HoldComplete[bk = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel"]; ],
    HoldComplete[bu = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary"]; ],
    HoldComplete[VerificationTest[Module[{kernel}, Block[{$ContextPath = Prepend[$ContextPath, "CCompilerDriver`"]}, kernel = bk[x^2 - B[0] + signB[1], {B[0]}, {x}, "CoeffName" -> "B", "CompileSignSymbol" -> "signB"]; kernel["CoeffName"] === "B" && kernel["CompileSignSymbol"] === "signB"]], True, TimeConstraint -> timeLimit, TestID -> "buildKernel-coeffname-signsymbol-options@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:46,1-62,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 15; ],
    HoldComplete[fri = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval"]; ],
    HoldComplete[bk = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel"]; ],
    HoldComplete[bu = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary"]; ],
    HoldComplete[VerificationTest[Module[{kernel, result}, Block[{$ContextPath = Prepend[$ContextPath, "CCompilerDriver`"]}, kernel = bk[x^2 - A[0] + signA[1] + signA[2], {A[0]}, {x}, "CoeffName" -> "A", "CompileSignSymbol" -> "signA"]; result = bu[kernel, Association[x -> 2], {1}]; result === $Failed]], True, {FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary::toofewsigns}, TimeConstraint -> timeLimit, TestID -> "bindUnary-insufficient-signs-returns-failed@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:78,1-96,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 15; ],
    HoldComplete[fri = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval"]; ],
    HoldComplete[bk = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel"]; ],
    HoldComplete[bu = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary"]; ],
    HoldComplete[VerificationTest[Module[{kernel}, Block[{$ContextPath = Prepend[$ContextPath, "CCompilerDriver`"]}, kernel = bk[x^2 - A[0], {A[0]}, {x}, "CoeffName" -> "A", "CompileSignSymbol" -> "signA", "CompileMode" -> "Both", "Compiler" -> "FunctionCompile"]; AssociationQ[kernel] && KeyExistsQ[kernel, "fC"] && KeyExistsQ[kernel, "dfC"] && KeyExistsQ[kernel, "Vars"]]], True, TimeConstraint -> timeLimit, TestID -> "buildKernel-produces-CompiledCodeFunction@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:112,1-134,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 15; ],
    HoldComplete[fri = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval"]; ],
    HoldComplete[bk = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel"]; ],
    HoldComplete[bu = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary"]; ],
    HoldComplete[VerificationTest[Module[{kernel}, Block[{$ContextPath = Prepend[$ContextPath, "CCompilerDriver`"]}, kernel = bk[x^2 - A[0], {A[0]}, {x}, "CoeffName" -> "A", "CompileSignSymbol" -> "signA", "Compiler" -> "Compile"]; AssociationQ[kernel] && KeyExistsQ[kernel, "fC"] && KeyExistsQ[kernel, "Vars"]]], True, TimeConstraint -> timeLimit, TestID -> "buildKernel-Compile-produces-CompiledFunction@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:150,1-170,2"]],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[timeLimit = 15; ],
    HoldComplete[fri = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`findRootInterval"]; ],
    HoldComplete[bk = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel"]; ],
    HoldComplete[bu = ToExpression["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`bindUnary"]; ],
    HoldComplete[VerificationTest[Module[{kernelFC, kernelC, fFC, fC, dfFC, dfC}, Block[{$ContextPath = Prepend[$ContextPath, "CCompilerDriver`"]}, kernelFC = bk[x^2 - A[0], {A[0]}, {x}, "Compiler" -> "FunctionCompile"]; kernelC = bk[x^2 - A[0], {A[0]}, {x}, "Compiler" -> "Compile"]; {fFC, dfFC} = bu[kernelFC, Association[x -> 2], {}]; {fC, dfC} = bu[kernelC, Association[x -> 2], {}]; Abs[fFC[1] - fC[1]] < 10^(-10)]], True, TimeConstraint -> timeLimit, TestID -> "buildKernel-both-compilers-equivalent-results@@Tests/FindRootOptim/findRootCoeff0EdgeCases.wlt:186,1-200,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "findRootCoeff0EdgeCases",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../FindRootOptim/findRootCoeff0EdgeCases.wlt"
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
