(* ::Package:: *)

(*install local version of external packages*)
$pacletBaseDir=DirectoryName[NotebookDirectory[],1];
pacletResourceFuns=PacletInstall[FileNameJoin[{$pacletBaseDir,"Resources","PacletizedResourceFunctions.paclet"}],KeepExistingVersion->True, ForceVersionInstall->True];
pacletMaTeX=PacletInstall[FileNameJoin[{$pacletBaseDir,"Resources","MaTeX-1.7.9.paclet"}],KeepExistingVersion->True, ForceVersionInstall->True];


Get[FileNameJoin[{pacletMaTeX["Location"],"MaTeX.m"}]]
(*Needs["MaTeX`",FileNameJoin[{pacletMaTeX["Location"],"MaTeX.m"}]]*)


(*ToMatlab: general tools to write to Matlab*)
(*<<ToMatlab`;*)
 (*toMatlabTools: tools to write to Matlab specific to this project*)
(*<<toMatlabTools`;*)
(*TeXUtilities: convert Mathematica expressions into LaTeX*)
(*install with Get["https://raw.githubusercontent.com/jkuczm/MathematicaTeXUtilities/master/BootstrapInstall.m"]*)
(*<<TeXUtilities`;*)


(*automatically use MaTeX instead of built-in LaTeX in inline/displayed formula cells*)

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



BeginPackage["FernandoDuarte`LongRunRisk`"]

ClearAll[LongRunRisk];
LongRunRisk::usage="LongRunRisk is a manager head for the LongRunRisk package";

EndPackage[]


 BeginPackage["FernandoDuarte`LongRunRisk`Loader`"]
(*<<FernandoDuarte`LongRunRisk`AddOne`;
<<FernandoDuarte`LongRunRisk`AddTwo`;*)
(*<<FernandoDuarte`LongRunRisk`Subpackage`AddThree`; (*if you want AddThree for user*)
*)

<<FernandoDuarte`LongRunRisk`Model`ExogenousEq`;
(*<<FernandoDuarte`LongRunRisk`Model`EndogenousEq`;
<<FernandoDuarte`LongRunRisk`Model`Catalog`;*)
(*<<FernandoDuarte`LongRunRisk`ComputationalEngine`;*)
(*<<FernandoDuarte`LongRunRisk`TimeAggregation`; *)



Begin["`Private`"]


(*<<FernandoDuarte`LongRunRisk`Model`ExogenousEq`;
<<FernandoDuarte`LongRunRisk`Model`Catalog`;
<<FernandoDuarte`LongRunRisk`Model`NiceOutput`;
*)
(*Get["FernandoDuarte`LongRunRisk`Model`Catalog`"]
Get["FernandoDuarte`LongRunRisk`Model`NiceOutput`"]

Catalog=FernandoDuarte`LongRunRisk`Model`NiceOutput`Private`Catalog;
*)

(*
Catalog[]:=
Catalog[_models]:= 
Catalog[m_model]/;MemberQ[Keys[models,m]] := m*)



End[](*"`Private`"*)


EndPackage[]
