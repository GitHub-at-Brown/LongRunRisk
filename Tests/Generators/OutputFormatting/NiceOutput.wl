(* Auto-generated from: /Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-feat-gen-tests/Tests/OutputFormatting/NiceOutput.wlt
   by WLTTestRefactor` on 2026-01-03
   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.
*)

BeginPackage["WLTGenerated`NiceOutput`"];

GenerateWLT::usage = "GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.";

Begin["`Private`"];

$sourceExpressions = {
    HoldComplete[BeginTestSection["NiceOutput Tests"]],
    HoldComplete[Begin["FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`"]],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest = False; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[$ContextPath = DeleteDuplicates[Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]]; ],
    HoldComplete[VerificationTest[Module[{pacletFile, pacletRoot}, pacletFile = FindFile["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; pacletRoot = If[StringQ[pacletFile], DirectoryName[pacletFile, 3], If[StringQ[$InputFileName] && $InputFileName =!= "", DirectoryName[$InputFileName, 2], Directory[]]]; FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`distributedPaclet = FileNameJoin[{pacletRoot, "Resources", "PacletizedResourceFunctions.paclet"}]; If[FileExistsQ[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`distributedPaclet], PacletInstall[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`distributedPaclet, "IgnoreVersion" -> True]; ]; True], True, {}, TestID -> "NiceOutput_20251223-0M5X2B@@Tests/OutputFormatting/NiceOutput.wlt:14,1-38,2"]],
    HoldComplete[$ContextPath = DeleteCases[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest = False; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[$ContextPath = DeleteDuplicates[Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]]; ],
    HoldComplete[VerificationTest[Length[PacletFind["PacletizedResourceFunctions"]] > 0, True, {}, TestID -> "NiceOutput_20251223-W4Y3IH@@Tests/OutputFormatting/NiceOutput.wlt:52,1-60,2"]],
    HoldComplete[$ContextPath = DeleteCases[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest = False; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[$ContextPath = DeleteDuplicates[Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]]; ],
    HoldComplete[VerificationTest[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp = If[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest, FernandoDuarte`LongRunRisk`Models, KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC", "DES", "NRCStochVol"}]]; FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]; FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBKY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BKY"]; FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRC = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["NRC"]; FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modDES = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["DES"]; FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRCStochVol = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["NRCStochVol"]; True, True, {}, TestID -> "NiceOutput_20251223-XQJQF1@@Tests/OutputFormatting/NiceOutput.wlt:74,1-90,2"]],
    HoldComplete[$ContextPath = DeleteCases[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest = False; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[$ContextPath = DeleteDuplicates[Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp = If[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest, FernandoDuarte`LongRunRisk`Models, KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC", "DES", "NRCStochVol"}]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBKY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BKY"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRC = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["NRC"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modDES = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["DES"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRCStochVol = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["NRCStochVol"]; ],
    HoldComplete[VerificationTest[And @@ {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]}, True, {}, TestID -> "NiceOutput_20251223-JUUTIC@@Tests/OutputFormatting/NiceOutput.wlt:114,1-122,2"]],
    HoldComplete[$ContextPath = DeleteCases[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest = False; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[$ContextPath = DeleteDuplicates[Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp = If[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest, FernandoDuarte`LongRunRisk`Models, KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC", "DES", "NRCStochVol"}]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBKY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BKY"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRC = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["NRC"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modDES = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["DES"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRCStochVol = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["NRCStochVol"]; ],
    HoldComplete[VerificationTest[ !Names["*info"] === {}, True, {}, TestID -> "NiceOutput_20251223-K4B6I8@@Tests/OutputFormatting/NiceOutput.wlt:146,1-154,2"]],
    HoldComplete[$ContextPath = DeleteCases[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest = False; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[$ContextPath = DeleteDuplicates[Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp = If[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest, FernandoDuarte`LongRunRisk`Models, KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC", "DES", "NRCStochVol"}]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBKY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BKY"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRC = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["NRC"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modDES = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["DES"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRCStochVol = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["NRCStochVol"]; ],
    HoldComplete[VerificationTest[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`myModelsInfo = SetSymbolsContext[FernandoDuarte`LongRunRisk`Tools`NiceOutput`info[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp]]; And @@ {Head[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`myModelsInfo] === Column, Head[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`myModelsInfo[[1]]] === List, Head[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`myModelsInfo[[1,1]]] === OpenerView, And @@ (MatchQ[#1, Grid] & ) /@ Head /@ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`myModelsInfo[[1,1 ;; All,1,2]]}, True, {}, TestID -> "NiceOutput_20251223-C58NLK@@Tests/OutputFormatting/NiceOutput.wlt:178,1-198,2"]],
    HoldComplete[$ContextPath = DeleteCases[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest = False; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[$ContextPath = DeleteDuplicates[Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp = If[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest, FernandoDuarte`LongRunRisk`Models, KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC", "DES", "NRCStochVol"}]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBKY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BKY"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRC = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["NRC"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modDES = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["DES"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRCStochVol = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["NRCStochVol"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`myModelsInfo = SetSymbolsContext[FernandoDuarte`LongRunRisk`Tools`NiceOutput`info[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp]]; ],
    HoldComplete[VerificationTest[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`justBY = Association["BY" -> FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]]; FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY = SetSymbolsContext[FernandoDuarte`LongRunRisk`Tools`NiceOutput`info[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`justBY]]; FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`newBY = Association["myModel" -> FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]]; FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY = SetSymbolsContext[FernandoDuarte`LongRunRisk`Tools`NiceOutput`info[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`newBY]]; And @@ {FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY[[1,1,1,1]] == "BY", SetSymbolsContext[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY[[1,1,1,2,1,4,1,1,2,1,1,1,1]]] === SetSymbolsContext[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`x[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`t]], FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY[[1,1,1,1]] == "BY", SetSymbolsContext[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY[[1,1,1,2,1,4,1,1,2,1,1,1,1]]] === SetSymbolsContext[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`x[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`t]]}, True, {}, TestID -> "NiceOutput_20251223-WJET5C@@Tests/OutputFormatting/NiceOutput.wlt:224,1-253,2"]],
    HoldComplete[$ContextPath = DeleteCases[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest = False; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[$ContextPath = DeleteDuplicates[Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp = If[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest, FernandoDuarte`LongRunRisk`Models, KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC", "DES", "NRCStochVol"}]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBKY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BKY"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRC = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["NRC"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modDES = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["DES"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRCStochVol = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["NRCStochVol"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`myModelsInfo = SetSymbolsContext[FernandoDuarte`LongRunRisk`Tools`NiceOutput`info[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`justBY = Association["BY" -> FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY = SetSymbolsContext[FernandoDuarte`LongRunRisk`Tools`NiceOutput`info[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`justBY]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`newBY = Association["myModel" -> FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY = SetSymbolsContext[FernandoDuarte`LongRunRisk`Tools`NiceOutput`info[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`newBY]]; ],
    HoldComplete[VerificationTest[And @@ {Head[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY] === Column, Head[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY[[1]]] === List, Head[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY[[1,1]]] === OpenerView, And @@ (MatchQ[#1, Grid] & ) /@ Head /@ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY[[1,1 ;; All,1,2]], Head[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY] === Column, Head[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY[[1]]] === List, Head[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY[[1,1]]] === OpenerView, And @@ (MatchQ[#1, Grid] & ) /@ Head /@ FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY[[1,1 ;; All,1,2]]}, True, {}, TestID -> "NiceOutput_20251223-1LRLAE@@Tests/OutputFormatting/NiceOutput.wlt:284,1-311,2"]],
    HoldComplete[$ContextPath = DeleteCases[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest = False; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[$ContextPath = DeleteDuplicates[Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp = If[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest, FernandoDuarte`LongRunRisk`Models, KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC", "DES", "NRCStochVol"}]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBKY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BKY"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRC = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["NRC"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modDES = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["DES"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRCStochVol = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["NRCStochVol"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`myModelsInfo = SetSymbolsContext[FernandoDuarte`LongRunRisk`Tools`NiceOutput`info[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`justBY = Association["BY" -> FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY = SetSymbolsContext[FernandoDuarte`LongRunRisk`Tools`NiceOutput`info[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`justBY]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`newBY = Association["myModel" -> FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY = SetSymbolsContext[FernandoDuarte`LongRunRisk`Tools`NiceOutput`info[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`newBY]]; ],
    HoldComplete[VerificationTest[With[{FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`localPi = 3.14}, {FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14], FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14, NumberMarks -> True], FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14, NumberMarks -> False], FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`localPi], FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`localPi, NumberMarks -> True], FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`localPi, NumberMarks -> False], FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`Π], FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`Π, CharacterEncoding -> "ASCII"], FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[Pi], FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[N[Pi]], FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14/10^7], FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[Flatten[{FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stripContext[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`delta]/2 /. FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stripContext[{FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`delta -> 0.99}]}]]}] === {"3.14", "3.14`", "3.14", "3.14", "3.14`", "3.14", "Π", "\\[CapitalPi]", "3.141592653589793", "3.141592653589793", "3.14*^-7", "{0.495}"}, True, {}, TestID -> "NiceOutput_20251223-TZN6TZ@@Tests/OutputFormatting/NiceOutput.wlt:342,1-375,2"]],
    HoldComplete[$ContextPath = DeleteCases[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]; ],
    HoldComplete[Off[General::shdw]; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[On[General::shdw]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest = False; ],
    HoldComplete[Needs["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; ],
    HoldComplete[$ContextPath = DeleteDuplicates[Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp = If[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`longTest, FernandoDuarte`LongRunRisk`Models, KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC", "DES", "NRCStochVol"}]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modBKY = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BKY"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRC = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["NRC"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modDES = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["DES"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`modNRCStochVol = FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["NRCStochVol"]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`myModelsInfo = SetSymbolsContext[FernandoDuarte`LongRunRisk`Tools`NiceOutput`info[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`justBY = Association["BY" -> FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoBY = SetSymbolsContext[FernandoDuarte`LongRunRisk`Tools`NiceOutput`info[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`justBY]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`newBY = Association["myModel" -> FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`msp["BY"]]; ],
    HoldComplete[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`infoNewBY = SetSymbolsContext[FernandoDuarte`LongRunRisk`Tools`NiceOutput`info[FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`newBY]]; ],
    HoldComplete[VerificationTest[ !StringFreeQ[FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stringFormattingTemplate["Long-run risk model with stochastic volatility in the original 2004 paper by Bansal and Yaron"], "\t" | "\n"], True, {}, TestID -> "NiceOutput_20251223-SFQJ4X@@Tests/OutputFormatting/NiceOutput.wlt:406,1-419,2"]],
    HoldComplete[$ContextPath = DeleteCases[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"]; ],
    HoldComplete[End[]],
    HoldComplete[EndTestSection[]]
};

(* --- options --- *)
Options[GenerateWLT] = {
    "OutputTestHead" -> TestCreate,
    "DefaultTimeConstraint" -> 30,
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> "NiceOutput",
    "HashLength" -> 8,
    "TargetRelativeWLTPath" -> "../../OutputFormatting/NiceOutput.wlt"
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
