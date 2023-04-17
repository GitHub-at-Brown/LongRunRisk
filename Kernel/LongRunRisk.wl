(* ::Package:: *)

(*install PacletizedResourceFunctions provided with LongRunRisk paclet if not already installed*)
If[
	{}===PacletFind["PacletizedResourceFunctions"],
	PacletInstall[
		File[
			FindFile[
				"FernandoDuarte/LongRunRisk/PacletizedResourceFunctions.paclet"
			]
		],
	KeepExistingVersion->False,
	ForceVersionInstall->True
	]
];
Get["PacletizedResourceFunctions`"];

(*install local version of MaTeX provided with LongRunRisk paclet if not already installed*)
(*consider putting in a module to localize pacletMaTeX*)
If[
	{}===PacletFind["MaTeX"->"1.7.9"],
	PacletInstall[
		File[
			FindFile[
				"FernandoDuarte/LongRunRisk/MaTeX-1.7.9.paclet"
			]
		],
		KeepExistingVersion->True,
		ForceVersionInstall->True
	]
]
Get[FileNameJoin[{(First@PacletFind["MaTeX"->"1.7.9"])["Location"],"MaTeX.m"}]];(*Needs["MaTeX`",FileNameJoin[{pacletMaTeX["Location"],"MaTeX.m"}]]*)

ConfigureMaTeX["pdfLaTeX" -> "/github/home/bin/pdflatex"]
ConfigureMaTeX["Ghostscript" -> "/usr/bin/gs"]


BeginPackage["FernandoDuarte`LongRunRisk`"]


<<FernandoDuarte`LongRunRisk`Model`Parameters`;
<<FernandoDuarte`LongRunRisk`Model`Shocks`;
<<FernandoDuarte`LongRunRisk`Model`ExogenousEq`;
<<FernandoDuarte`LongRunRisk`Model`Catalog`;
<<FernandoDuarte`LongRunRisk`Model`EndogenousEq`;
<<FernandoDuarte`LongRunRisk`Model`NiceOutput`;
<<FernandoDuarte`LongRunRisk`TimeAggregation`;


main::usage="";

(*re-exported symbols*)
Models;
Growth;

(*models
info*)
(*fillModels*)


Begin["`Private`"]


main=1;

(*NeedsDefinitions=ResourceFunction["NeedsDefinitions"];
SetSymbolsContext=ResourceFunction["SetSymbolsContext"];*)

(*re-export symbols from other private contexts *)
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Model`Catalog`"];
fillModels := FernandoDuarte`LongRunRisk`Model`NiceOutput`fillModels;
Models[] := FernandoDuarte`LongRunRisk`Model`NiceOutput`Catalog[FernandoDuarte`LongRunRisk`Model`NiceOutput`fillModels[FernandoDuarte`LongRunRisk`Model`Catalog`models]];

Models[x_String] := FernandoDuarte`LongRunRisk`Model`Catalog`models[x];
Models::usage = Information["FernandoDuarte`LongRunRisk`Model`Catalog`models","Usage"];

(*NeedsDefinitions["FernandoDuarte`LongRunRisk`Model`NiceOutput`"];*)


(*models := Block[{$ContextPath = {}}, SetSymbolsContext[modelsLocal]];*)



PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`TimeAggregation`"];
Growth[] := FernandoDuarte`LongRunRisk`TimeAggregation`growth;
Growth::usage = Information["FernandoDuarte`LongRunRisk`TimeAggregation`growth","Usage"];




(*re-export info from FernandoDuarte`LongRunRisk`Model`NiceOutput` *)
(*info = (ResourceFunction["NeedsDefinitions"]["FernandoDuarte`LongRunRisk`Model`NiceOutput`"]; 
FernandoDuarte`LongRunRisk`Model`NiceOutput`info);

info::usage = (ResourceFunction["NeedsDefinitions"]["FernandoDuarte`LongRunRisk`Model`NiceOutput`"]; 
Information[FernandoDuarte`LongRunRisk`Model`NiceOutput`info,"Usage"]);*)


End[](*"`Private`"*)


EndPackage[]


(*(*install local version of external packages*)
UsingFrontEnd[
	$pacletBaseDir=DirectoryName[NotebookDirectory[],1];
	pacletResourceFuns=PacletInstall[FileNameJoin[{$pacletBaseDir,"Resources","PacletizedResourceFunctions.paclet"}],KeepExistingVersion->True, ForceVersionInstall->True];
	pacletMaTeX=PacletInstall[FileNameJoin[{$pacletBaseDir,"Resources","MaTeX-1.7.9.paclet"}],KeepExistingVersion->True, ForceVersionInstall->True];
]
Get[FileNameJoin[{pacletMaTeX["Location"],"MaTeX.m"}]]
(*Needs["MaTeX`",FileNameJoin[{pacletMaTeX["Location"],"MaTeX.m"}]]*)
(*automatically use MaTeX instead of built-in LaTeX in inline/displayed formula cells*)
UsingFrontEnd[
	$useMaTeXMag=1;
	$useMaTeXBaselineShift=0;
	$useMaTeXMag=1.44; (*x^2 and x have the~same size in a Text cell*)
	$useMaTeXBaselineShift=-0.12;  (*aligns x^2 with x in a Text cell*)
	$useMaTeXQ=True;
	Module[{$s},
	Quiet[
	InputAssistant`TeXStringToBoxes//Unprotect;
	InputAssistant`TeXStringToBoxes[$s_String]/;TrueQ@$useMaTeXQ=.;
	InputAssistant`TeXStringToBoxes//Protect;
	InputAssistant`TeXStringToBoxes//Unprotect;
	InputAssistant`TeXStringToBoxes[$s_String]/;TrueQ@$useMaTeXQ:=AdjustmentBox[ToBoxes@MaTeX[$s,Magnification->$useMaTeXMag],BoxBaselineShift->$useMaTeXBaselineShift];
	InputAssistant`TeXStringToBoxes//Protect;
	]];
	(*preamble for MaTeX to use in LaTeX files*)
	preambleTeX={
	"\\usepackage{color}",
	"\\usepackage{microtype}"
	};
]*)

