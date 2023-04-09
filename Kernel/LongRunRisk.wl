(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`"]


<<FernandoDuarte`LongRunRisk`Model`ExogenousEq`;
<<FernandoDuarte`LongRunRisk`Model`Shocks`;
<<FernandoDuarte`LongRunRisk`Model`Parameters`;
<<FernandoDuarte`LongRunRisk`Model`EndogenousEq`;
(*<<FernandoDuarte`LongRunRisk`Model`Catalog`;*)
(*<<FernandoDuarte`LongRunRisk`Model`NiceOutput`;*)


(*<<FernandoDuarte`LongRunRisk`ComputationalEngine`;*)
(*<<FernandoDuarte`LongRunRisk`Model`NiceOutput`; *)
main::usage=""

(*re-exported symbols*)
(*models
info*)


Begin["`Private`"]


main=1;

(*re-export models from FernandoDuarte`LongRunRisk`Model`Catalog` *)
(*models = (ResourceFunction["NeedsDefinitions"]["FernandoDuarte`LongRunRisk`Model`Catalog`"]; 
FernandoDuarte`LongRunRisk`Model`Catalog`models);

models::usage = (ResourceFunction["NeedsDefinitions"]["FernandoDuarte`LongRunRisk`Model`Catalog`"]; 
Information[FernandoDuarte`LongRunRisk`Model`Catalog`models,"Usage"]);*)

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
