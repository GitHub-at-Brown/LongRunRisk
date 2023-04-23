(* ::Package:: *)

(*BeginPackage["FernandoDuarte`PacletizeResources`"]*)
(*Helper package to convert external resources (like paclets or 
functions from ResourceFunction) that are used by FernandoDuarte/LongRunRisk
 into local paclets that can be ported*)
 
 findPacletDir=NameQ["pacletDir"];
 If[
	 findPacletDir
	 ,
	 thisFile = FindFile[FileNameJoin[{pacletDir,"Scripts","PacletizeResources.wl"}]];
	 resourceDir = FileNameJoin[{DirectoryName[thisFile,2],"Resources"}];
	 ,
	 resourceDir = FileNameJoin[{DirectoryName[NotebookDirectory[],1],"Resources"}] ;
	 Remove["pacletDir"];
 ];




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
