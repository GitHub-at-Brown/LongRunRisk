(* ::Package:: *)

(*BeginPackage["FernandoDuarte`PacletizeResources`"]*)
(*Helper package to convert external resources (like paclets or 
functions from ResourceFunction) that are used by FernandoDuarte/LongRunRisk
 into local paclets that can be ported*)
 
thisDir=NotebookDirectory[];
resourceDir = FileNameJoin[{DirectoryName[NotebookDirectory[],1],"Resources"}] ;
If[FileNames[resourceDir]==={},CreateDirectory[resourceDir]];

toPacletize = {"NeedsDefinitions","SetSymbolsContext"}; (*ResourceFunction["SetByRules"]*)
pacletName = "PacletizedResourceFunctions"; 
fileName =  FileNameJoin[{resourceDir,pacletName<>".paclet"}];

paclet = ResourceFunction["PacletizeResourceFunction"][
			Evaluate@toPacletize,
			fileName,
			"PacletName" -> pacletName
		];

(*EndPackage[]*)
