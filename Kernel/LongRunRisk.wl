(* ::Package:: *)

(* ::Section:: *)
(*Install dependencies*)


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
Quiet@Get[FileNameJoin[{(First@PacletFind["MaTeX"->"1.7.9"])["Location"],"MaTeX.m"}]];
MaTeX`Developer`ResetConfiguration[];


(* ::Section:: *)
(*Load sub-contexts*)


<<FernandoDuarte`LongRunRisk`Model`Parameters`;
<<FernandoDuarte`LongRunRisk`Model`Shocks`;
<<FernandoDuarte`LongRunRisk`Model`ExogenousEq`;
<<FernandoDuarte`LongRunRisk`Model`EndogenousEq`;
$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"];
$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"];


(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`"]


(* ::Subsection:: *)
(*Public symbols*)


Models;
Info;
ToEquation;ToExogenousVars;ToStateVars;
UncondE; UncondCov; UncondVar; UncondCorr;
covLongBY;covLongNRC;covLongDES;
Ev; Var; Cov; Corr;
ToNum;
Growth;


(* ::Subsubsection:: *)
(*Usage*)


ToEquation::usage = "";
ToExogenousVars::usage = "";
ToStateVars::usage = "";
(*other symbols automatically inherit usage messages from the package in which they were first introduced*)


(*Symbol/@ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`$exogenousVarsPrivate
Symbol/@ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`$endogenousVarsPrivate*)


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Package dependencies*)


PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`"];
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`ToNumber`"];
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"];
(*PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`NiceTables`"];*)
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`NicePlots`"];
CopyDefinitions = ResourceFunction["CopyDefinitions"];
CompoundScope = ResourceFunction["CompoundScope"];


(* ::Subsection::Closed:: *)
(*Helper functions*)


(* ::Subsubsection::Closed:: *)
(*reExport*)


reExport[f_Symbol, g_Symbol]:=
(
	CopyDefinitions[f,g];
	MessageName[g,"usage"] = StringReplace[Information[g,"Usage"],SymbolName[f] :> SymbolName[g]]
);
(*exports all public symbols from oldContext to newContext*)
reExport[oldContext_String, Optional[newContext_String, "FernandoDuarte`LongRunRisk`"]]:=CompoundScope[
	{
		oldFullNames = Names[oldContext<>"*"],
		oldNames = StringExtract[#,"`"->-1]&/@oldFullNames,
		newNames = Capitalize/@oldNames,
		newFullNames = StringJoin[newContext,#]&/@newNames
	},
	MapThread[reExport[Symbol@#1,Symbol@#2]&,{oldFullNames,newFullNames}];
]


(* ::Subsection::Closed:: *)
(*Models*)


Get@Get[FindFile[File["FernandoDuarte/LongRunRisk/Models.wl"]]];


(* ::Subsection:: *)
(*Info*)


PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];
Info[models_Association] := PacletizedResourceFunctions`SetSymbolsContext@Column[(FernandoDuarte`LongRunRisk`Tools`NiceOutput`info@#&)/@(Values@FernandoDuarte`LongRunRisk`Tools`NiceOutput`createEqTables[models])];
Info::usage = StringReplace[Information[FernandoDuarte`LongRunRisk`Tools`NiceOutput`info,"Usage"],"info" -> "Info"];


(* ::Subsection:: *)
(*ToEquation and ToVars*)


(* ::Subsubsection:: *)
(*ToEquation*)


ToEquation[expr_,model_Association]:= ReplaceAll[expr, Normal@Join[model["exogenousEq"],model["endogenousEq"]] ]
ToEquation[model_Association]:=Function[{expr}, ToEquation[expr,model]]

(*ToEquation[expr_,model_Association, n_Integer?Positive]:= Nest[ToEquation[#,model]&,expr,n];
ToEquation[model_Association, n_Integer?Positive]:=Function[{expr}, Nest[ToEquation[#,model]&,expr,n]];*)
(*ReplaceAll[expr_,ToEquation[model_]]^:=ToEquation[expr,model]*)


(* ::Subsubsection:: *)
(*ToExogenousVars*)


ToExogenousVars[expr_,model_Association]:= ReplaceRepeated[expr, Normal@model["endogenousEq"]] 
ToExogenousVars[model_Association]:=Function[{expr}, ToExogenousVars[expr,model]]


(* ::Subsubsection:: *)
(*ToStateVars*)


ToStateVars[expr_,model_Association]:= ReplaceRepeated[expr, Normal@model["toStateVars"]] 
ToStateVars[model_Association]:=Function[{expr}, ToStateVars[expr,model]]


(* ::Subsection:: *)
(*Unconditional moments*)


(* ::Subsubsection::Closed:: *)
(*UncondE*)


reExport[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE,FernandoDuarte`LongRunRisk`UncondE];


(* ::Subsubsection::Closed:: *)
(*UncondCov*)


UncondCov[x_,y_,model_]:=With[
	{
		toExogenous = Normal@model["endogenousEq"],
		covLong=Symbol["FernandoDuarte`LongRunRisk`covLong"<>model["shortname"]]
	},
	Module[
		{cExo},
		Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`"];
		Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];

		cExo=FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`uncondCovLongExo[toExogenous, x, y, covLong];
		If[
			FreeQ[cExo,covLong],
			cExo,
			FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondCov[x, y, model]
		]
	](*Module*)
](*With*)


(* ::Subsubsection:: *)
(*covLong*)


covLongFileNames=Map[StringJoin["FernandoDuarte/LongRunRisk/MomentsLookupTables/covLong",#, ".wl"]&,Keys@Models];
Map[(Get@Get@#) &,covLongFileNames];


(* ::Subsubsection::Closed:: *)
(*UncondVar*)


UncondVar[x_, model_]:=UncondCov[x,x, model];


(* ::Subsubsection::Closed:: *)
(*UncondCorr*)


UncondCorr[x_,y_,model_]:=UncondCov[x,y,model]/(Sqrt[UncondVar[x,model]]Sqrt[UncondVar[y,model]]);


(* ::Subsection::Closed:: *)
(*Conditional moments*)


reExport[#]&/@{
	"FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"
}


(* ::Subsection:: *)
(*ToNum*)


(*reExport["FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum",FernandoDuarte`LongRunRisk`ToNum];*)
reExport[#]&/@{
	"FernandoDuarte`LongRunRisk`Tools`ToNumber`"
}


(* ::Subsection::Closed:: *)
(*Growth*)


reExport[#]&/@{
	"FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"
}


(* ::Subsection:: *)
(*Plots and tables*)


(* ::Subsubsection:: *)
(*NicePlots*)


reExport[#]&/@{
	"FernandoDuarte`LongRunRisk`Tools`NicePlots`"
}


(* ::Subsubsection:: *)
(*NiceTables*)


(*reExport[#]&/@{
	"FernandoDuarte`LongRunRisk`Tools`NiceTables`"
}*)


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];


(* ::Subsection:: *)
(*ToTex*)


(*dc[t] //ToTeX*)


(* ::Subsection:: *)
(*useMaTeX*)


(*Get[FileNameJoin[{pacletMaTeX["Location"],"MaTeX.m"}]]*)
(*Needs["MaTeX`",FileNameJoin[{pacletMaTeX["Location"],"MaTeX.m"}]]*)
(*automatically use MaTeX instead of built-in LaTeX in inline/displayed formula cells*)
(*UsingFrontEnd[
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

