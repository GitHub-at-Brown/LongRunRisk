(* ::Package:: *)

$pacletBaseDir=DirectoryName[NotebookDirectory[],1];

(*<<FernandoDuarte`LongRunRisk`AddOne`;
<<FernandoDuarte`LongRunRisk`AddTwo`;*)

(*ToMatlab: general tools to write to Matlab*)
(*<<ToMatlab`;*)
 (*toMatlabTools: tools to write to Matlab specific to this project*)
(*<<toMatlabTools`;*)
(*TeXUtilities: convert Mathematica expressions into LaTeX*)
(*install with Get["https://raw.githubusercontent.com/jkuczm/MathematicaTeXUtilities/master/BootstrapInstall.m"]*)
(*<<TeXUtilities`;*)


(*install local version of external packages*)
PacletInstall[FileNameJoin[{$pacletBaseDir,"Resources","MaTeX-1.7.9.paclet"}],KeepExistingVersion->True, ForceVersionInstall->True];
PacletInstall[FileNameJoin[{$pacletBaseDir,"Resources","PacletizedResourceFunctions.paclet"}],KeepExistingVersion->True, ForceVersionInstall->True];
(*automatically use MaTeX instead of built-in LaTeX in inline/displayed formula cells*)
Get[FileNameJoin[{$UserBasePacletsDirectory,"Repository","MaTeX-1.7.9","MaTeX.m"}]]
$useMaTeXMag=1;
$useMaTeXBaselineShift=0;
$useMaTeXMag=1.44; (*x^2 and x have the~same size in a Text cell*)
$useMaTeXBaselineShift=-0.12;  (*aligns x^2 with x in a Text cell*)
$useMaTeXQ=True;
Quiet[
InputAssistant`TeXStringToBoxes//Unprotect;
InputAssistant`TeXStringToBoxes[s_String]/;TrueQ@$useMaTeXQ=.;
InputAssistant`TeXStringToBoxes//Protect;
InputAssistant`TeXStringToBoxes//Unprotect;
InputAssistant`TeXStringToBoxes[s_String]/;TrueQ@$useMaTeXQ:=AdjustmentBox[ToBoxes@MaTeX[s,Magnification->$useMaTeXMag],BoxBaselineShift->$useMaTeXBaselineShift];InputAssistant`TeXStringToBoxes//Protect;
];
(*preamble for MaTeX to use in LaTeX files*)
preambleTeX={
"\\usepackage{color}",
"\\usepackage{microtype}"
};


<<FernandoDuarte`LongRunRisk`Model`ExogenousEq`;
<<FernandoDuarte`LongRunRisk`Model`EndogenousEq`;
<<FernandoDuarte`LongRunRisk`Model`Catalog`;
<<FernandoDuarte`LongRunRisk`Model`NiceOutput`;

(*<<FernandoDuarte`LongRunRisk`ComputationalEngine`;*)
(*<<FernandoDuarte`LongRunRisk`TimeAggregation`; *)
(*<<FernandoDuarte`LongRunRisk`Subpackage`AddThree`; (*if you want AddThree for user*)*)
BeginPackage["FernandoDuarte`LongRunRisk`"]
EndPackage[]
