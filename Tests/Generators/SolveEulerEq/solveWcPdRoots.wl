(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/SolveEulerEq/solveWcPdRoots.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`solveWcPdRoots`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["solveWcPdRoots Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`SolveEulerEq`solveWcPdRoots`"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["PacletizedResourceFunctions`"]; ],
    HoldComplete[Module[{pacletFile, pacletRoot, resourcesDir, modelsFile, candidateRoots}, candidateRoots = {}; If[StringQ[$InputFileName] && $InputFileName =!= "", Module[{d = DirectoryName[$InputFileName]}, While[ !FileExistsQ[FileNameJoin[{d, "PacletInfo.wl"}]] && d =!= DirectoryName[d], d = DirectoryName[d]]; AppendTo[candidateRoots, d]]]; AppendTo[candidateRoots, Directory[]]; pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; If[StringQ[pacletFile], AppendTo[candidateRoots, DirectoryName[pacletFile, 3]]]; pacletRoot = SelectFirst[candidateRoots, FileExistsQ[FileNameJoin[{#1, "Resources", "Models.wl"}]] & , First[candidateRoots]]; $testPacletRoot = pacletRoot; PacletDirectoryLoad[pacletRoot]; resourcesDir = FileNameJoin[{pacletRoot, "Resources"}]; modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}]; $testModels = Get[Get[modelsFile]]; ]; ],
    HoldComplete[timeLimit = 300; ],
    HoldComplete[getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx}, signIdx = kernel["SignIndex"]; If[signIdx === {} || signIdx === {{}}, Return[{}]]; maxIdx = Max[Flatten[signIdx]]; Table[-1, maxIdx]]; ],
    HoldComplete[getParamsBase[model_Association] := N[Association[model["params"]] //. model["params"]]; ],
    HoldComplete[loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"]; ],
    HoldComplete[loadKernels[modelKey_String] := Module[{model, kernelData}, model = $testModels[modelKey]; kernelData = loadModelKernels[modelKey]; Association["Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]]]; ],
    HoldComplete[solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"]; ],
    HoldComplete[solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"]; ],
    HoldComplete[jSym = Symbol["j"]; ],
    HoldComplete[iSym = Symbol["i"]; ],
    HoldComplete[extraParams = Association[jSym -> 1, iSym -> 1]; ],
    HoldComplete[VerificationTest[Module[{kernels, model, signsWc, paramsBase, wcResults}, kernels = loadKernels["BY"]; model = kernels["Model"]; signsWc = getSignsFromKernel[kernels["WcKernel"]]; paramsBase = getParamsBase[model]; wcResults = Quiet[Check[solveCoeffRoots[model["coeffsParamQuadSolve"]["wc"], kernels["WcKernel"], paramsBase, Association[], "Signs" -> signsWc], $Failed]]; ListQ[wcResults] && Length[wcResults] > 0 && KeyExistsQ[wcResults[[1]], "Signs"] && wcResults[[1]]["Signs"] === signsWc], True, TestID -> "solveCoeffRoots-Signs-Key@@Tests/SolveEulerEq/solveWcPdRoots.wlt:96,1-120,4"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Module[{pacletFile, pacletRoot, resourcesDir, modelsFile, candidateRoots}, candidateRoots = {}; If[StringQ[$InputFileName] && $InputFileName =!= "", Module[{d = DirectoryName[$InputFileName]}, While[ !FileExistsQ[FileNameJoin[{d, "PacletInfo.wl"}]] && d =!= DirectoryName[d], d = DirectoryName[d]]; AppendTo[candidateRoots, d]]]; AppendTo[candidateRoots, Directory[]]; pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; If[StringQ[pacletFile], AppendTo[candidateRoots, DirectoryName[pacletFile, 3]]]; pacletRoot = SelectFirst[candidateRoots, FileExistsQ[FileNameJoin[{#1, "Resources", "Models.wl"}]] & , First[candidateRoots]]; $testPacletRoot = pacletRoot; PacletDirectoryLoad[pacletRoot]; resourcesDir = FileNameJoin[{pacletRoot, "Resources"}]; modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}]; $testModels = Get[Get[modelsFile]]; ]; ],
    HoldComplete[timeLimit = 300; ],
    HoldComplete[getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx}, signIdx = kernel["SignIndex"]; If[signIdx === {} || signIdx === {{}}, Return[{}]]; maxIdx = Max[Flatten[signIdx]]; Table[-1, maxIdx]]; ],
    HoldComplete[getParamsBase[model_Association] := N[Association[model["params"]] //. model["params"]]; ],
    HoldComplete[loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"]; ],
    HoldComplete[loadKernels[modelKey_String] := Module[{model, kernelData}, model = $testModels[modelKey]; kernelData = loadModelKernels[modelKey]; Association["Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]]]; ],
    HoldComplete[solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"]; ],
    HoldComplete[solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"]; ],
    HoldComplete[jSym = Symbol["j"]; ],
    HoldComplete[iSym = Symbol["i"]; ],
    HoldComplete[extraParams = Association[jSym -> 1, iSym -> 1]; ],
    HoldComplete[VerificationTest[Module[{kernels, model, signsWc, signsPd, wcPdResults}, kernels = loadKernels["BY"]; model = kernels["Model"]; signsWc = getSignsFromKernel[kernels["WcKernel"]]; signsPd = getSignsFromKernel[kernels["PdKernel"]]; wcPdResults = Quiet[Check[solveWcPdRoots[model, kernels["WcKernel"], kernels["PdKernel"], signsWc, signsPd, extraParams], $Failed]]; ListQ[wcPdResults] && Length[wcPdResults] > 0 && KeyExistsQ[wcPdResults[[1]], "SignsWc"] && KeyExistsQ[wcPdResults[[1]], "SignsPd"] && wcPdResults[[1]]["SignsWc"] === signsWc && wcPdResults[[1]]["SignsPd"] === signsPd], True, TestID -> "solveWcPdRoots-Original-Signs-Keys@@Tests/SolveEulerEq/solveWcPdRoots.wlt:214,1-234,4"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Module[{pacletFile, pacletRoot, resourcesDir, modelsFile, candidateRoots}, candidateRoots = {}; If[StringQ[$InputFileName] && $InputFileName =!= "", Module[{d = DirectoryName[$InputFileName]}, While[ !FileExistsQ[FileNameJoin[{d, "PacletInfo.wl"}]] && d =!= DirectoryName[d], d = DirectoryName[d]]; AppendTo[candidateRoots, d]]]; AppendTo[candidateRoots, Directory[]]; pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; If[StringQ[pacletFile], AppendTo[candidateRoots, DirectoryName[pacletFile, 3]]]; pacletRoot = SelectFirst[candidateRoots, FileExistsQ[FileNameJoin[{#1, "Resources", "Models.wl"}]] & , First[candidateRoots]]; $testPacletRoot = pacletRoot; PacletDirectoryLoad[pacletRoot]; resourcesDir = FileNameJoin[{pacletRoot, "Resources"}]; modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}]; $testModels = Get[Get[modelsFile]]; ]; ],
    HoldComplete[timeLimit = 300; ],
    HoldComplete[getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx}, signIdx = kernel["SignIndex"]; If[signIdx === {} || signIdx === {{}}, Return[{}]]; maxIdx = Max[Flatten[signIdx]]; Table[-1, maxIdx]]; ],
    HoldComplete[getParamsBase[model_Association] := N[Association[model["params"]] //. model["params"]]; ],
    HoldComplete[loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"]; ],
    HoldComplete[loadKernels[modelKey_String] := Module[{model, kernelData}, model = $testModels[modelKey]; kernelData = loadModelKernels[modelKey]; Association["Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]]]; ],
    HoldComplete[solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"]; ],
    HoldComplete[solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"]; ],
    HoldComplete[jSym = Symbol["j"]; ],
    HoldComplete[iSym = Symbol["i"]; ],
    HoldComplete[extraParams = Association[jSym -> 1, iSym -> 1]; ],
    HoldComplete[VerificationTest[Module[{kernels, model, results}, kernels = loadKernels["BY"]; model = kernels["Model"]; results = Quiet[Check[solveWcPdRoots[model, kernels["WcKernel"], kernels["PdKernel"], extraParams], $Failed]]; ListQ[results] && Length[results] > 0 && KeyExistsQ[results[[1]], "SignsWc"] && KeyExistsQ[results[[1]], "SignsPd"] && KeyExistsQ[results[[1]], "Roots"] && KeyExistsQ[results[[1]], "Pd"]], True, TestID -> "solveWcPdRoots-Wrapper-BY-Structure@@Tests/SolveEulerEq/solveWcPdRoots.wlt:328,1-347,4"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Module[{pacletFile, pacletRoot, resourcesDir, modelsFile, candidateRoots}, candidateRoots = {}; If[StringQ[$InputFileName] && $InputFileName =!= "", Module[{d = DirectoryName[$InputFileName]}, While[ !FileExistsQ[FileNameJoin[{d, "PacletInfo.wl"}]] && d =!= DirectoryName[d], d = DirectoryName[d]]; AppendTo[candidateRoots, d]]]; AppendTo[candidateRoots, Directory[]]; pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; If[StringQ[pacletFile], AppendTo[candidateRoots, DirectoryName[pacletFile, 3]]]; pacletRoot = SelectFirst[candidateRoots, FileExistsQ[FileNameJoin[{#1, "Resources", "Models.wl"}]] & , First[candidateRoots]]; $testPacletRoot = pacletRoot; PacletDirectoryLoad[pacletRoot]; resourcesDir = FileNameJoin[{pacletRoot, "Resources"}]; modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}]; $testModels = Get[Get[modelsFile]]; ]; ],
    HoldComplete[timeLimit = 300; ],
    HoldComplete[getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx}, signIdx = kernel["SignIndex"]; If[signIdx === {} || signIdx === {{}}, Return[{}]]; maxIdx = Max[Flatten[signIdx]]; Table[-1, maxIdx]]; ],
    HoldComplete[getParamsBase[model_Association] := N[Association[model["params"]] //. model["params"]]; ],
    HoldComplete[loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"]; ],
    HoldComplete[loadKernels[modelKey_String] := Module[{model, kernelData}, model = $testModels[modelKey]; kernelData = loadModelKernels[modelKey]; Association["Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]]]; ],
    HoldComplete[solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"]; ],
    HoldComplete[solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"]; ],
    HoldComplete[jSym = Symbol["j"]; ],
    HoldComplete[iSym = Symbol["i"]; ],
    HoldComplete[extraParams = Association[jSym -> 1, iSym -> 1]; ],
    HoldComplete[VerificationTest[Module[{kernels, model, results}, kernels = loadKernels["DES"]; model = kernels["Model"]; results = Quiet[Check[solveWcPdRoots[model, kernels["WcKernel"], kernels["PdKernel"], extraParams], $Failed]]; results === $Failed || (ListQ[results] && Length[results] >= 1 && AllTrue[results, KeyExistsQ[#1, "SignsWc"] & ] && AllTrue[results, KeyExistsQ[#1, "SignsPd"] & ])], True, TestID -> "solveWcPdRoots-Wrapper-DES-handles-gracefully@@Tests/SolveEulerEq/solveWcPdRoots.wlt:441,1-459,4"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Module[{pacletFile, pacletRoot, resourcesDir, modelsFile, candidateRoots}, candidateRoots = {}; If[StringQ[$InputFileName] && $InputFileName =!= "", Module[{d = DirectoryName[$InputFileName]}, While[ !FileExistsQ[FileNameJoin[{d, "PacletInfo.wl"}]] && d =!= DirectoryName[d], d = DirectoryName[d]]; AppendTo[candidateRoots, d]]]; AppendTo[candidateRoots, Directory[]]; pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; If[StringQ[pacletFile], AppendTo[candidateRoots, DirectoryName[pacletFile, 3]]]; pacletRoot = SelectFirst[candidateRoots, FileExistsQ[FileNameJoin[{#1, "Resources", "Models.wl"}]] & , First[candidateRoots]]; $testPacletRoot = pacletRoot; PacletDirectoryLoad[pacletRoot]; resourcesDir = FileNameJoin[{pacletRoot, "Resources"}]; modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}]; $testModels = Get[Get[modelsFile]]; ]; ],
    HoldComplete[timeLimit = 300; ],
    HoldComplete[getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx}, signIdx = kernel["SignIndex"]; If[signIdx === {} || signIdx === {{}}, Return[{}]]; maxIdx = Max[Flatten[signIdx]]; Table[-1, maxIdx]]; ],
    HoldComplete[getParamsBase[model_Association] := N[Association[model["params"]] //. model["params"]]; ],
    HoldComplete[loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"]; ],
    HoldComplete[loadKernels[modelKey_String] := Module[{model, kernelData}, model = $testModels[modelKey]; kernelData = loadModelKernels[modelKey]; Association["Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]]]; ],
    HoldComplete[solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"]; ],
    HoldComplete[solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"]; ],
    HoldComplete[getJSymbolFromKernel[kernel_Association] := Module[{var, innerHead}, var = First[kernel["Vars"]]; innerHead = Head[var]; If[Length[innerHead] > 0, innerHead[[1]], Symbol["j"]]]; ],
    HoldComplete[VerificationTest[Module[{kernels, model, results, jSym, extraParams}, kernels = loadKernels["NRCStochVol"]; model = kernels["Model"]; jSym = getJSymbolFromKernel[kernels["PdKernel"]]; extraParams = Association[jSym -> 1]; results = Quiet[Check[solveWcPdRoots[model, kernels["WcKernel"], kernels["PdKernel"], extraParams], $Failed]]; results === $Failed || (ListQ[results] && Length[results] >= 1 && AllTrue[results, KeyExistsQ[#1, "SignsWc"] & ] && AllTrue[results, KeyExistsQ[#1, "SignsPd"] & ])], True, TimeConstraint -> timeLimit, TestID -> "solveWcPdRoots-Wrapper-NRCStochVol-handles-gracefully@@Tests/SolveEulerEq/solveWcPdRoots.wlt:558,1-581,4"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "solveWcPdRoots",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../SolveEulerEq/solveWcPdRoots.wlt"
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
