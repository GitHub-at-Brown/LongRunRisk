(* ::Package:: *)

BeginPackage["FernandoDuarte`PacletizeResources`"]
(*Helper package to convert external resources (like paclets or 
functions from ResourceFunction) that are used by FernandoDuarte/LongRunRisk
 into local paclets that can be ported*)
 
thisDir=NotebookDirectory[]
resourceDir = FileNameJoin[{DirectoryName[NotebookDirectory[],1],"Resources"}] 
If[FileNames[resourceDir]==={},CreateDirectory[resourceDir]]

toPacletize = "MaTeX-1.7.9";
pacletName = "PacletizedResourceFunctions"; 
fileName =  FileNameJoin[{resourceDir,pacletName<>".paclet"}]


paclet = ResourceFunction["PacletizeResourceFunction"][
			toPacletize,
			fileName,
			"PacletName" -> pacletName
		]

EndPackage[]
