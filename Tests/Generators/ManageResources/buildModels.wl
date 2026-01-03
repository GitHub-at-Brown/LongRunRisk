(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/ManageResources/buildModels.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`buildModels`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["buildModels Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`ManageResources`buildModels`"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getMomentsHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getMomentsHash"]; ],
    HoldComplete[$momentsUpToDate = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`momentsUpToDate"]; ],
    HoldComplete[$setupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`setupParallelKernels"]; ],
    HoldComplete[$warmupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`warmupParallelKernels"]; ],
    HoldComplete[$buildModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[MemberQ[Keys[Options[$buildModels]], "CreateMoments"], True, TestID -> "buildModels-has-CreateMoments-option@@Tests/ManageResources/buildModels.wlt:26,1-30,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getMomentsHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getMomentsHash"]; ],
    HoldComplete[$momentsUpToDate = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`momentsUpToDate"]; ],
    HoldComplete[$setupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`setupParallelKernels"]; ],
    HoldComplete[$warmupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`warmupParallelKernels"]; ],
    HoldComplete[$buildModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[MemberQ[Keys[Options[$buildModels]], "NumKernels"], True, TestID -> "buildModels-has-NumKernels-option@@Tests/ManageResources/buildModels.wlt:54,1-58,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getMomentsHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getMomentsHash"]; ],
    HoldComplete[$momentsUpToDate = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`momentsUpToDate"]; ],
    HoldComplete[$setupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`setupParallelKernels"]; ],
    HoldComplete[$warmupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`warmupParallelKernels"]; ],
    HoldComplete[$buildModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[OptionValue[$buildModels, "CreateMoments"], True, TestID -> "buildModels-CreateMoments-default-is-True@@Tests/ManageResources/buildModels.wlt:82,1-86,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getMomentsHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getMomentsHash"]; ],
    HoldComplete[$momentsUpToDate = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`momentsUpToDate"]; ],
    HoldComplete[$setupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`setupParallelKernels"]; ],
    HoldComplete[$warmupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`warmupParallelKernels"]; ],
    HoldComplete[$buildModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[OptionValue[$buildModels, "NumKernels"], Automatic, TestID -> "buildModels-NumKernels-default-is-Automatic@@Tests/ManageResources/buildModels.wlt:110,1-114,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getMomentsHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getMomentsHash"]; ],
    HoldComplete[$momentsUpToDate = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`momentsUpToDate"]; ],
    HoldComplete[$setupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`setupParallelKernels"]; ],
    HoldComplete[$warmupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`warmupParallelKernels"]; ],
    HoldComplete[$buildModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[StringQ[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels::noroot], True, TestID -> "buildModels-has-noroot-message@@Tests/ManageResources/buildModels.wlt:138,1-142,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getMomentsHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getMomentsHash"]; ],
    HoldComplete[$momentsUpToDate = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`momentsUpToDate"]; ],
    HoldComplete[$setupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`setupParallelKernels"]; ],
    HoldComplete[$warmupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`warmupParallelKernels"]; ],
    HoldComplete[$buildModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[StringQ[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels::nocat], True, TestID -> "buildModels-has-nocat-message@@Tests/ManageResources/buildModels.wlt:166,1-170,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getMomentsHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getMomentsHash"]; ],
    HoldComplete[$momentsUpToDate = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`momentsUpToDate"]; ],
    HoldComplete[$setupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`setupParallelKernels"]; ],
    HoldComplete[$warmupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`warmupParallelKernels"]; ],
    HoldComplete[$buildModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{catalog, model, hash}, catalog = Association["name" -> "Test", "shortname" -> "T"]; model = Association["exogenousEq" -> {x -> y}, "endogenousEq" -> {a -> b}]; hash = $getMomentsHash[catalog, model]; StringQ[hash] && StringLength[hash] == 64], True, TestID -> "getMomentsHash-returns-64-char-hex-string@@Tests/ManageResources/buildModels.wlt:194,1-203,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getMomentsHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getMomentsHash"]; ],
    HoldComplete[$momentsUpToDate = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`momentsUpToDate"]; ],
    HoldComplete[$setupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`setupParallelKernels"]; ],
    HoldComplete[$warmupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`warmupParallelKernels"]; ],
    HoldComplete[$buildModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{catalog, model, hash1, hash2}, catalog = Association["name" -> "Test", "shortname" -> "T"]; model = Association["exogenousEq" -> {x -> y}, "endogenousEq" -> {a -> b}]; hash1 = $getMomentsHash[catalog, model]; hash2 = $getMomentsHash[catalog, model]; hash1 === hash2], True, TestID -> "getMomentsHash-is-deterministic@@Tests/ManageResources/buildModels.wlt:227,1-237,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getMomentsHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getMomentsHash"]; ],
    HoldComplete[$momentsUpToDate = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`momentsUpToDate"]; ],
    HoldComplete[$setupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`setupParallelKernels"]; ],
    HoldComplete[$warmupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`warmupParallelKernels"]; ],
    HoldComplete[$buildModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{catalog1, catalog2, model, hash1, hash2}, catalog1 = Association["name" -> "Test1", "shortname" -> "T1"]; catalog2 = Association["name" -> "Test2", "shortname" -> "T2"]; model = Association["exogenousEq" -> {x -> y}, "endogenousEq" -> {a -> b}]; hash1 = $getMomentsHash[catalog1, model]; hash2 = $getMomentsHash[catalog2, model]; hash1 =!= hash2], True, TestID -> "getMomentsHash-differs-for-different-catalog@@Tests/ManageResources/buildModels.wlt:261,1-272,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getMomentsHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getMomentsHash"]; ],
    HoldComplete[$momentsUpToDate = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`momentsUpToDate"]; ],
    HoldComplete[$setupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`setupParallelKernels"]; ],
    HoldComplete[$warmupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`warmupParallelKernels"]; ],
    HoldComplete[$buildModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{catalog, model1, model2, hash1, hash2}, catalog = Association["name" -> "Test", "shortname" -> "T"]; model1 = Association["exogenousEq" -> {x -> y}, "endogenousEq" -> {a -> b}]; model2 = Association["exogenousEq" -> {x -> z}, "endogenousEq" -> {a -> b}]; hash1 = $getMomentsHash[catalog, model1]; hash2 = $getMomentsHash[catalog, model2]; hash1 =!= hash2], True, TestID -> "getMomentsHash-differs-for-different-exogenousEq@@Tests/ManageResources/buildModels.wlt:296,1-307,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getMomentsHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getMomentsHash"]; ],
    HoldComplete[$momentsUpToDate = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`momentsUpToDate"]; ],
    HoldComplete[$setupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`setupParallelKernels"]; ],
    HoldComplete[$warmupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`warmupParallelKernels"]; ],
    HoldComplete[$buildModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[$momentsUpToDate["/nonexistent/file.wl", "/nonexistent/meta.wl", "somehash"], False, TestID -> "momentsUpToDate-false-for-nonexistent-files@@Tests/ManageResources/buildModels.wlt:331,1-335,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getMomentsHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getMomentsHash"]; ],
    HoldComplete[$momentsUpToDate = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`momentsUpToDate"]; ],
    HoldComplete[$setupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`setupParallelKernels"]; ],
    HoldComplete[$warmupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`warmupParallelKernels"]; ],
    HoldComplete[$buildModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{tmpDir, momentsFile, metaFile, result}, tmpDir = CreateDirectory[]; momentsFile = FileNameJoin[{tmpDir, "covLongTest.wl"}]; metaFile = FileNameJoin[{tmpDir, "covLongTest_meta.wl"}]; Put[{1, 2, 3}, momentsFile]; result = $momentsUpToDate[momentsFile, metaFile, "somehash"]; DeleteDirectory[tmpDir, DeleteContents -> True]; result], False, TestID -> "momentsUpToDate-false-when-meta-missing@@Tests/ManageResources/buildModels.wlt:359,1-372,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getMomentsHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getMomentsHash"]; ],
    HoldComplete[$momentsUpToDate = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`momentsUpToDate"]; ],
    HoldComplete[$setupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`setupParallelKernels"]; ],
    HoldComplete[$warmupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`warmupParallelKernels"]; ],
    HoldComplete[$buildModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{tmpDir, momentsFile, metaFile, result}, tmpDir = CreateDirectory[]; momentsFile = FileNameJoin[{tmpDir, "covLongTest.wl"}]; metaFile = FileNameJoin[{tmpDir, "covLongTest_meta.wl"}]; Put[{1, 2, 3}, momentsFile]; Put[Association["Hash" -> "expectedhash", "Date" -> "2024-01-01"], metaFile]; result = $momentsUpToDate[momentsFile, metaFile, "expectedhash"]; DeleteDirectory[tmpDir, DeleteContents -> True]; result], True, TestID -> "momentsUpToDate-true-when-hash-matches@@Tests/ManageResources/buildModels.wlt:396,1-409,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getMomentsHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getMomentsHash"]; ],
    HoldComplete[$momentsUpToDate = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`momentsUpToDate"]; ],
    HoldComplete[$setupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`setupParallelKernels"]; ],
    HoldComplete[$warmupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`warmupParallelKernels"]; ],
    HoldComplete[$buildModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[Module[{tmpDir, momentsFile, metaFile, result}, tmpDir = CreateDirectory[]; momentsFile = FileNameJoin[{tmpDir, "covLongTest.wl"}]; metaFile = FileNameJoin[{tmpDir, "covLongTest_meta.wl"}]; Put[{1, 2, 3}, momentsFile]; Put[Association["Hash" -> "oldhash", "Date" -> "2024-01-01"], metaFile]; result = $momentsUpToDate[momentsFile, metaFile, "newhash"]; DeleteDirectory[tmpDir, DeleteContents -> True]; result], False, TestID -> "momentsUpToDate-false-when-hash-differs@@Tests/ManageResources/buildModels.wlt:433,1-446,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getMomentsHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getMomentsHash"]; ],
    HoldComplete[$momentsUpToDate = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`momentsUpToDate"]; ],
    HoldComplete[$setupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`setupParallelKernels"]; ],
    HoldComplete[$warmupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`warmupParallelKernels"]; ],
    HoldComplete[$buildModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[$setupParallelKernels[None], 0, TestID -> "setupParallelKernels-None-returns-zero@@Tests/ManageResources/buildModels.wlt:470,1-474,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getMomentsHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getMomentsHash"]; ],
    HoldComplete[$momentsUpToDate = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`momentsUpToDate"]; ],
    HoldComplete[$setupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`setupParallelKernels"]; ],
    HoldComplete[$warmupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`warmupParallelKernels"]; ],
    HoldComplete[$buildModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[$setupParallelKernels[0], 0, TestID -> "setupParallelKernels-zero-returns-zero@@Tests/ManageResources/buildModels.wlt:498,1-502,2"]],
    HoldComplete[If[FindFile["FernandoDuarte`LongRunRisk`Model`Catalog`"] === $Failed, BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]; EndPackage[]; ]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[$getMomentsHash = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`getMomentsHash"]; ],
    HoldComplete[$momentsUpToDate = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`momentsUpToDate"]; ],
    HoldComplete[$setupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`setupParallelKernels"]; ],
    HoldComplete[$warmupParallelKernels = ToExpression["FernandoDuarte`LongRunRisk`Tools`ManageResources`Private`warmupParallelKernels"]; ],
    HoldComplete[$buildModels = FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels; ],
    HoldComplete[$timeLimit = 5; ],
    HoldComplete[VerificationTest[$setupParallelKernels[-1], 0, TestID -> "setupParallelKernels-negative-returns-zero@@Tests/ManageResources/buildModels.wlt:526,1-530,2"]],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "buildModels",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../ManageResources/buildModels.wlt"
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
