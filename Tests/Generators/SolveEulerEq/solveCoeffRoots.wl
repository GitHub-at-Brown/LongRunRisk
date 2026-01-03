(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/SolveEulerEq/solveCoeffRoots.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`solveCoeffRoots`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["solveCoeffRoots Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`SolveEulerEq`solveCoeffRoots`"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Needs["PacletizedResourceFunctions`"]; ],
    HoldComplete[Module[{pacletFile, pacletRoot, resourcesDir, modelsFile}, pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; pacletRoot = If[StringQ[pacletFile], DirectoryName[pacletFile, 3], If[StringQ[$InputFileName] && $InputFileName =!= "", Module[{d = DirectoryName[$InputFileName]}, While[ !FileExistsQ[FileNameJoin[{d, "PacletInfo.wl"}]] && d =!= DirectoryName[d], d = DirectoryName[d]]; d], Directory[]]]; $testPacletRoot = pacletRoot; PacletDirectoryLoad[pacletRoot]; resourcesDir = FileNameJoin[{pacletRoot, "Resources"}]; modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}]; $testModels = Get[Get[modelsFile]]; ]; ],
    HoldComplete[timeLimit = 120; ],
    HoldComplete[getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx}, signIdx = kernel["SignIndex"]; If[signIdx === {} || signIdx === {{}}, Return[{}]]; maxIdx = Max[Flatten[signIdx]]; Table[-1, maxIdx]]; ],
    HoldComplete[getParamsBase[model_Association] := N[Association[model["params"]] //. model["params"]]; ],
    HoldComplete[loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"]; ],
    HoldComplete[loadKernels[modelKey_String] := Module[{model, kernelData}, model = $testModels[modelKey]; kernelData = loadModelKernels[modelKey]; Association["Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]]]; ],
    HoldComplete[solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"]; ],
    HoldComplete[solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"]; ],
    HoldComplete[jSym = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`j; ],
    HoldComplete[VerificationTest[Module[{kernels, model, signsWc, paramsBase, wcResults}, kernels = loadKernels["BY"]; model = kernels["Model"]; signsWc = getSignsFromKernel[kernels["WcKernel"]]; paramsBase = getParamsBase[model]; wcResults = Quiet[Check[TimeConstrained[solveCoeffRoots[model["coeffsParamQuadSolve"]["wc"], kernels["WcKernel"], paramsBase, Association[], "Signs" -> signsWc], 60], $Failed]]; ListQ[wcResults] && Length[wcResults] > 0 && AssociationQ[wcResults[[1]]] && KeyExistsQ[wcResults[[1]], "Sol"] && Length[wcResults[[1]]["Sol"]] > 0 && AssociationQ[wcResults[[1]]["Sol"][[1]]] && AllTrue[Values[wcResults[[1]]["Sol"][[1]]], NumericQ]], True, TimeConstraint -> timeLimit, TestID -> "solveCoeffRoots-wc-BY-numeric@@Tests/SolveEulerEq/solveCoeffRoots.wlt:85,1-118,4"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Module[{pacletFile, pacletRoot, resourcesDir, modelsFile}, pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; pacletRoot = If[StringQ[pacletFile], DirectoryName[pacletFile, 3], If[StringQ[$InputFileName] && $InputFileName =!= "", Module[{d = DirectoryName[$InputFileName]}, While[ !FileExistsQ[FileNameJoin[{d, "PacletInfo.wl"}]] && d =!= DirectoryName[d], d = DirectoryName[d]]; d], Directory[]]]; $testPacletRoot = pacletRoot; PacletDirectoryLoad[pacletRoot]; resourcesDir = FileNameJoin[{pacletRoot, "Resources"}]; modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}]; $testModels = Get[Get[modelsFile]]; ]; ],
    HoldComplete[timeLimit = 120; ],
    HoldComplete[getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx}, signIdx = kernel["SignIndex"]; If[signIdx === {} || signIdx === {{}}, Return[{}]]; maxIdx = Max[Flatten[signIdx]]; Table[-1, maxIdx]]; ],
    HoldComplete[getParamsBase[model_Association] := N[Association[model["params"]] //. model["params"]]; ],
    HoldComplete[loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"]; ],
    HoldComplete[loadKernels[modelKey_String] := Module[{model, kernelData}, model = $testModels[modelKey]; kernelData = loadModelKernels[modelKey]; Association["Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]]]; ],
    HoldComplete[solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"]; ],
    HoldComplete[solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"]; ],
    HoldComplete[jSym = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`j; ],
    HoldComplete[VerificationTest[Module[{kernels, model, signsWc, signsPd, paramsBase, wcResults, extraParamsPd, jAsoc, pdResults}, kernels = loadKernels["BY"]; model = kernels["Model"]; signsWc = getSignsFromKernel[kernels["WcKernel"]]; signsPd = getSignsFromKernel[kernels["PdKernel"]]; paramsBase = getParamsBase[model]; wcResults = Quiet[Check[TimeConstrained[solveCoeffRoots[model["coeffsParamQuadSolve"]["wc"], kernels["WcKernel"], paramsBase, Association[], "Signs" -> signsWc], 60], $Failed]]; If[ !ListQ[wcResults] || Length[wcResults] == 0, Return[False]]; extraParamsPd = wcResults[[1]]["Sol"][[1]]; jAsoc = Association[jSym -> 1]; pdResults = Quiet[Check[TimeConstrained[solveCoeffRoots[model["coeffsParamQuadSolve"]["pd"], kernels["PdKernel"], paramsBase, Join[extraParamsPd, jAsoc], "Signs" -> signsPd], 60], $Failed]]; ListQ[pdResults] && Length[pdResults] > 0 && AssociationQ[pdResults[[1]]] && KeyExistsQ[pdResults[[1]], "Roots"] && Length[pdResults[[1]]["Roots"]] > 0 && KeyExistsQ[pdResults[[1]], "Sol"] && Length[pdResults[[1]]["Sol"]] > 0 && AssociationQ[pdResults[[1]]["Sol"][[1]]] && AllTrue[Values[pdResults[[1]]["Sol"][[1]]], NumericQ]], True, TimeConstraint -> timeLimit, TestID -> "solveCoeffRoots-pd-BY-numeric@@Tests/SolveEulerEq/solveCoeffRoots.wlt:201,1-258,4"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Module[{pacletFile, pacletRoot, resourcesDir, modelsFile}, pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; pacletRoot = If[StringQ[pacletFile], DirectoryName[pacletFile, 3], If[StringQ[$InputFileName] && $InputFileName =!= "", Module[{d = DirectoryName[$InputFileName]}, While[ !FileExistsQ[FileNameJoin[{d, "PacletInfo.wl"}]] && d =!= DirectoryName[d], d = DirectoryName[d]]; d], Directory[]]]; $testPacletRoot = pacletRoot; PacletDirectoryLoad[pacletRoot]; resourcesDir = FileNameJoin[{pacletRoot, "Resources"}]; modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}]; $testModels = Get[Get[modelsFile]]; ]; ],
    HoldComplete[timeLimit = 120; ],
    HoldComplete[getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx}, signIdx = kernel["SignIndex"]; If[signIdx === {} || signIdx === {{}}, Return[{}]]; maxIdx = Max[Flatten[signIdx]]; Table[-1, maxIdx]]; ],
    HoldComplete[getParamsBase[model_Association] := N[Association[model["params"]] //. model["params"]]; ],
    HoldComplete[loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"]; ],
    HoldComplete[loadKernels[modelKey_String] := Module[{model, kernelData}, model = $testModels[modelKey]; kernelData = loadModelKernels[modelKey]; Association["Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]]]; ],
    HoldComplete[solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"]; ],
    HoldComplete[solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"]; ],
    HoldComplete[jSym = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`j; ],
    HoldComplete[VerificationTest[Module[{kernels, model, signsWc, signsPd, jAsoc, wcPdResults}, kernels = loadKernels["BY"]; model = kernels["Model"]; signsWc = getSignsFromKernel[kernels["WcKernel"]]; signsPd = getSignsFromKernel[kernels["PdKernel"]]; jAsoc = Association[jSym -> 1]; wcPdResults = Quiet[Check[TimeConstrained[solveWcPdRoots[model, kernels["WcKernel"], kernels["PdKernel"], signsWc, signsPd, jAsoc], 90], $Failed]]; ListQ[wcPdResults] && Length[wcPdResults] > 0 && AssociationQ[wcPdResults[[1]]] && KeyExistsQ[wcPdResults[[1]], "Roots"] && KeyExistsQ[wcPdResults[[1]], "Pd"]], True, TimeConstraint -> timeLimit, TestID -> "solveWcPdRoots-BY-structure@@Tests/SolveEulerEq/solveCoeffRoots.wlt:341,1-367,4"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Module[{pacletFile, pacletRoot, resourcesDir, modelsFile}, pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; pacletRoot = If[StringQ[pacletFile], DirectoryName[pacletFile, 3], If[StringQ[$InputFileName] && $InputFileName =!= "", Module[{d = DirectoryName[$InputFileName]}, While[ !FileExistsQ[FileNameJoin[{d, "PacletInfo.wl"}]] && d =!= DirectoryName[d], d = DirectoryName[d]]; d], Directory[]]]; $testPacletRoot = pacletRoot; PacletDirectoryLoad[pacletRoot]; resourcesDir = FileNameJoin[{pacletRoot, "Resources"}]; modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}]; $testModels = Get[Get[modelsFile]]; ]; ],
    HoldComplete[timeLimit = 120; ],
    HoldComplete[getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx}, signIdx = kernel["SignIndex"]; If[signIdx === {} || signIdx === {{}}, Return[{}]]; maxIdx = Max[Flatten[signIdx]]; Table[-1, maxIdx]]; ],
    HoldComplete[getParamsBase[model_Association] := N[Association[model["params"]] //. model["params"]]; ],
    HoldComplete[loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"]; ],
    HoldComplete[loadKernels[modelKey_String] := Module[{model, kernelData}, model = $testModels[modelKey]; kernelData = loadModelKernels[modelKey]; Association["Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]]]; ],
    HoldComplete[solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"]; ],
    HoldComplete[solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"]; ],
    HoldComplete[jSym = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`j; ],
    HoldComplete[VerificationTest[Module[{kernels, model, signsWc, paramsBase, wcResults}, kernels = loadKernels["BKY"]; model = kernels["Model"]; signsWc = getSignsFromKernel[kernels["WcKernel"]]; paramsBase = getParamsBase[model]; wcResults = Quiet[Check[TimeConstrained[solveCoeffRoots[model["coeffsParamQuadSolve"]["wc"], kernels["WcKernel"], paramsBase, Association[], "Signs" -> signsWc], 60], $Failed]]; ListQ[wcResults] && Length[wcResults] > 0 && AssociationQ[wcResults[[1]]] && KeyExistsQ[wcResults[[1]], "Sol"] && Length[wcResults[[1]]["Sol"]] > 0 && AssociationQ[wcResults[[1]]["Sol"][[1]]] && AllTrue[Values[wcResults[[1]]["Sol"][[1]]], NumericQ]], True, TimeConstraint -> timeLimit, TestID -> "solveCoeffRoots-wc-BKY-numeric@@Tests/SolveEulerEq/solveCoeffRoots.wlt:450,1-482,4"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Module[{pacletFile, pacletRoot, resourcesDir, modelsFile}, pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; pacletRoot = If[StringQ[pacletFile], DirectoryName[pacletFile, 3], If[StringQ[$InputFileName] && $InputFileName =!= "", Module[{d = DirectoryName[$InputFileName]}, While[ !FileExistsQ[FileNameJoin[{d, "PacletInfo.wl"}]] && d =!= DirectoryName[d], d = DirectoryName[d]]; d], Directory[]]]; $testPacletRoot = pacletRoot; PacletDirectoryLoad[pacletRoot]; resourcesDir = FileNameJoin[{pacletRoot, "Resources"}]; modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}]; $testModels = Get[Get[modelsFile]]; ]; ],
    HoldComplete[timeLimit = 120; ],
    HoldComplete[getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx}, signIdx = kernel["SignIndex"]; If[signIdx === {} || signIdx === {{}}, Return[{}]]; maxIdx = Max[Flatten[signIdx]]; Table[-1, maxIdx]]; ],
    HoldComplete[getParamsBase[model_Association] := N[Association[model["params"]] //. model["params"]]; ],
    HoldComplete[loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"]; ],
    HoldComplete[loadKernels[modelKey_String] := Module[{model, kernelData}, model = $testModels[modelKey]; kernelData = loadModelKernels[modelKey]; Association["Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]]]; ],
    HoldComplete[solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"]; ],
    HoldComplete[solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"]; ],
    HoldComplete[jSym = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`j; ],
    HoldComplete[VerificationTest[Module[{kernels, model, signsWc, paramsBase, wcResults}, kernels = loadKernels["NRC"]; model = kernels["Model"]; signsWc = getSignsFromKernel[kernels["WcKernel"]]; paramsBase = getParamsBase[model]; wcResults = Quiet[Check[TimeConstrained[solveCoeffRoots[model["coeffsParamQuadSolve"]["wc"], kernels["WcKernel"], paramsBase, Association[], "Signs" -> signsWc], 60], $Failed]]; wcResults === $Failed || (ListQ[wcResults] && Length[wcResults] > 0 && AssociationQ[wcResults[[1]]] && KeyExistsQ[wcResults[[1]], "Sol"])], True, TimeConstraint -> timeLimit, TestID -> "solveCoeffRoots-wc-NRC-handles-gracefully@@Tests/SolveEulerEq/solveCoeffRoots.wlt:565,1-596,4"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Module[{pacletFile, pacletRoot, resourcesDir, modelsFile}, pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; pacletRoot = If[StringQ[pacletFile], DirectoryName[pacletFile, 3], If[StringQ[$InputFileName] && $InputFileName =!= "", Module[{d = DirectoryName[$InputFileName]}, While[ !FileExistsQ[FileNameJoin[{d, "PacletInfo.wl"}]] && d =!= DirectoryName[d], d = DirectoryName[d]]; d], Directory[]]]; $testPacletRoot = pacletRoot; PacletDirectoryLoad[pacletRoot]; resourcesDir = FileNameJoin[{pacletRoot, "Resources"}]; modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}]; $testModels = Get[Get[modelsFile]]; ]; ],
    HoldComplete[timeLimit = 120; ],
    HoldComplete[getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx}, signIdx = kernel["SignIndex"]; If[signIdx === {} || signIdx === {{}}, Return[{}]]; maxIdx = Max[Flatten[signIdx]]; Table[-1, maxIdx]]; ],
    HoldComplete[getParamsBase[model_Association] := N[Association[model["params"]] //. model["params"]]; ],
    HoldComplete[loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"]; ],
    HoldComplete[loadKernels[modelKey_String] := Module[{model, kernelData}, model = $testModels[modelKey]; kernelData = loadModelKernels[modelKey]; Association["Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]]]; ],
    HoldComplete[solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"]; ],
    HoldComplete[solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"]; ],
    HoldComplete[jSym = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`j; ],
    HoldComplete[VerificationTest[Module[{kernels, signSymbol}, kernels = loadKernels["BY"]; signSymbol = Lookup[kernels["WcKernel"], "CompileSignSymbol"]; StringQ[signSymbol] && signSymbol === "signA"], True, TimeConstraint -> timeLimit, TestID -> "kernel-CompileSignSymbol-wc@@Tests/SolveEulerEq/solveCoeffRoots.wlt:679,1-690,4"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Module[{pacletFile, pacletRoot, resourcesDir, modelsFile}, pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; pacletRoot = If[StringQ[pacletFile], DirectoryName[pacletFile, 3], If[StringQ[$InputFileName] && $InputFileName =!= "", Module[{d = DirectoryName[$InputFileName]}, While[ !FileExistsQ[FileNameJoin[{d, "PacletInfo.wl"}]] && d =!= DirectoryName[d], d = DirectoryName[d]]; d], Directory[]]]; $testPacletRoot = pacletRoot; PacletDirectoryLoad[pacletRoot]; resourcesDir = FileNameJoin[{pacletRoot, "Resources"}]; modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}]; $testModels = Get[Get[modelsFile]]; ]; ],
    HoldComplete[timeLimit = 120; ],
    HoldComplete[getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx}, signIdx = kernel["SignIndex"]; If[signIdx === {} || signIdx === {{}}, Return[{}]]; maxIdx = Max[Flatten[signIdx]]; Table[-1, maxIdx]]; ],
    HoldComplete[getParamsBase[model_Association] := N[Association[model["params"]] //. model["params"]]; ],
    HoldComplete[loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"]; ],
    HoldComplete[loadKernels[modelKey_String] := Module[{model, kernelData}, model = $testModels[modelKey]; kernelData = loadModelKernels[modelKey]; Association["Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]]]; ],
    HoldComplete[solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"]; ],
    HoldComplete[solveWcPdRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveWcPdRoots"]; ],
    HoldComplete[jSym = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`j; ],
    HoldComplete[VerificationTest[Module[{kernels, signSymbol}, kernels = loadKernels["BY"]; signSymbol = Lookup[kernels["PdKernel"], "CompileSignSymbol"]; StringQ[signSymbol] && signSymbol === "signB"], True, TimeConstraint -> timeLimit, TestID -> "kernel-CompileSignSymbol-pd@@Tests/SolveEulerEq/solveCoeffRoots.wlt:773,1-784,4"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[Module[{pacletFile, pacletRoot, resourcesDir, modelsFile}, pacletFile = FindFile["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"]; pacletRoot = If[StringQ[pacletFile], DirectoryName[pacletFile, 3], If[StringQ[$InputFileName] && $InputFileName =!= "", Module[{d = DirectoryName[$InputFileName]}, While[ !FileExistsQ[FileNameJoin[{d, "PacletInfo.wl"}]] && d =!= DirectoryName[d], d = DirectoryName[d]]; d], Directory[]]]; $testPacletRoot = pacletRoot; PacletDirectoryLoad[pacletRoot]; resourcesDir = FileNameJoin[{pacletRoot, "Resources"}]; modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}]; $testModels = Get[Get[modelsFile]]; ]; ],
    HoldComplete[timeLimit = 120; ],
    HoldComplete[getSignsFromKernel[kernel_Association] := Module[{signIdx, maxIdx}, signIdx = kernel["SignIndex"]; If[signIdx === {} || signIdx === {{}}, Return[{}]]; maxIdx = Max[Flatten[signIdx]]; Table[-1, maxIdx]]; ],
    HoldComplete[getParamsBase[model_Association] := N[Association[model["params"]] //. model["params"]]; ],
    HoldComplete[loadModelKernels = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels"]; ],
    HoldComplete[loadKernels[modelKey_String] := Module[{model, kernelData}, model = $testModels[modelKey]; kernelData = loadModelKernels[modelKey]; Association["Model" -> model, "WcKernel" -> kernelData["kernels"]["A"], "PdKernel" -> kernelData["kernels"]["B"]]]; ],
    HoldComplete[solveCoeffRoots = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solveCoeffRoots"]; ],
    HoldComplete[jSym = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`j; ],
    HoldComplete[VerificationTest[Module[{kernels, model, signsPd, paramsBase, pdResults, cfneOccurred}, kernels = loadKernels["BY"]; model = kernels["Model"]; signsPd = getSignsFromKernel[kernels["PdKernel"]]; paramsBase = getParamsBase[model]; cfneOccurred = False; Quiet[Check[pdResults = TimeConstrained[solveCoeffRoots[model["coeffsParamQuadSolve"]["pd"], kernels["PdKernel"], paramsBase, Association[jSym -> 1], "Signs" -> signsPd], 60], cfneOccurred = True, CompiledFunction::cfne]];  !cfneOccurred], True, TimeConstraint -> timeLimit, TestID -> "solveCoeffRoots-pd-no-cfne-messages@@Tests/SolveEulerEq/solveCoeffRoots.wlt:869,1-903,4"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "solveCoeffRoots",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../SolveEulerEq/solveCoeffRoots.wlt"
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
