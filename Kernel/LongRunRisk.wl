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


Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];
Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];

$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"];
$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"];


If[Not[$FrontEnd===Null],SetOptions[$FrontEndSession,AutoStyleOptions->{"SymbolShadowingStyle"->{FontColor->Black}}]];


(* Unprotect package symbols in case it is double-loaded *)
(*Unprotect[
	"FernandoDuarte`LongRunRisk`*",
	(*"FernandoDuarte`LongRunRisk`Model`Parameters`*",
	"FernandoDuarte`LongRunRisk`Model`Shocks`*",
	"FernandoDuarte`LongRunRisk`Model`ExogenousEq`*",
	"FernandoDuarte`LongRunRisk`Model`EndogenousEq`*",
	"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*",*)
	"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`t"
];*)


(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`"]


(* ::Subsection:: *)
(*Public symbols*)


Models;
Info;
ToNum;ToEquation;ToExogenousVars;ToStateVars;
UncondE; UncondCov; UncondVar; UncondCorr;
Ev; Var; Cov; Corr;
Growth;
YieldCurve;
(*t;*)
(*covLongBY;covLongNRC;covLongDES;*)


(* ::Subsubsection:: *)
(*Usage*)


(*symbols automatically inherit usage messages from the package in which they are first introduced*)


(*Symbol/@ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`$exogenousVarsPrivate
Symbol/@ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`$endogenousVarsPrivate*)


(*
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"]
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"];
$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"];
*)


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(*FernandoDuarte`LongRunRisk`t=FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t;*)


(* ::Subsection:: *)
(*Package dependencies*)


(*PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`"];*)
(*PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`ToNumber`"];
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"];*)
(*PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`NiceTables`"];*)
(*PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`NicePlots`"];*)
CopyDefinitions = ResourceFunction["CopyDefinitions"];
CompoundScope = ResourceFunction["CompoundScope"];


(* ::Subsection:: *)
(*Helper functions*)


(* ::Subsubsection:: *)
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


(* ::Subsection:: *)
(*Models*)


(*load file with pre-processed models*)
(*Get@Get[FindFile[File["FernandoDuarte/LongRunRisk/Models.wl"]]];*)


(*load file with pre-processed models and pre-computed moments*)
Needs["PacletTools`"];
pacletObj=First@PacletFind["FernandoDuarte/LongRunRisk"];
filesInResources = PacletTools`PacletExtensionFiles[pacletObj,"Path"][{"Path",<|"Root"->"Resources"|>}];
Map[Get@Get@#&,Flatten@StringCases[filesInResources,__~~".wl"]];


(* ::Subsection:: *)
(*ComputationalEngine*)


(* ::Subsubsection:: *)
(*Conditional moments*)


PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];


reExport[#]&/@{
	"FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"
}


(* ::Subsubsection:: *)
(*Unconditional moments*)


PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];


(* ::Text:: *)
(*UncondE*)


reExport[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE,FernandoDuarte`LongRunRisk`UncondE];


(* ::Text:: *)
(*UncondCov*)


UncondCov::usage = StringReplace[Information[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondCov,"Usage"],"uncondCov" -> "UncondCov"];


UncondCov[x_,y_,model_]:=With[
	{
		toExogenous = Normal@model["endogenousEq"],
		covLong=Symbol["FernandoDuarte`LongRunRisk`covLong"<>model["shortname"]]
	},
	Module[
		{cExo},
		cExo=FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`uncondCovLongExo[model, x, y, covLong]
	](*Module*)
](*With*)


(* ::Text:: *)
(*UncondVar*)


UncondVar::usage = StringReplace[Information[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondVar,"Usage"],"uncondVar" -> "UncondVar"];


UncondVar[x_, model_]:=UncondCov[x,x, model];


(* ::Text:: *)
(*UncondCorr*)


UncondCorr::usage = StringReplace[Information[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondCorr,"Usage"],"uncondCorr" -> "UncondCorr"];


UncondCorr[x_,y_,model_]:=UncondCov[x,y,model]/(Sqrt[UncondVar[x,model]]Sqrt[UncondVar[y,model]]);


(* ::Subsection:: *)
(*Tools*)


(* ::Subsubsection:: *)
(*NiceOutput*)


PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];


Info::usage = StringReplace[Information[FernandoDuarte`LongRunRisk`Tools`NiceOutput`info,"Usage"],"info" -> "Info"];


Info[models_Association] :=PacletizedResourceFunctions`SetSymbolsContext@FernandoDuarte`LongRunRisk`Tools`NiceOutput`info[models]; (*PacletizedResourceFunctions`SetSymbolsContext@Column[(FernandoDuarte`LongRunRisk`Tools`NiceOutput`info@#&)/@(Values@FernandoDuarte`LongRunRisk`Tools`NiceOutput`createEqTables[models])];*)


(* ::Subsubsection:: *)
(*NicePlots*)


PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`NicePlots`"];


reExport[#]&/@{
	"FernandoDuarte`LongRunRisk`Tools`NicePlots`"
}


(* ::Subsubsection:: *)
(*NiceTables*)


(*reExport[#]&/@{
	"FernandoDuarte`LongRunRisk`Tools`NiceTables`"
}*)


(* ::Subsubsection:: *)
(*TimeAggregation*)


PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"];


reExport[#]&/@{
	"FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"
}


(* ::Subsubsection:: *)
(*ToNumber*)


PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`ToNumber`"];


reExport[#]&/@{
	"FernandoDuarte`LongRunRisk`Tools`ToNumber`"
}


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];


(* Protect all package symbols after EndPackage[]; *)
(*SetAttributes[
 Evaluate@Names["FernandoDuarte`LongRunRisk`*"]
  ,
  {Protected, ReadProtected}
]

SetAttributes[
 FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t
  ,
  {Protected, ReadProtected}
]*)

(*SetAttributes[
 Evaluate@Names["FernandoDuarte`LongRunRisk`Model`Parameters`*"]
  ,
  {Protected, ReadProtected}
]

SetAttributes[
  Evaluate@Names["FernandoDuarte`LongRunRisk`Model`Shocks`*"]
  ,
  {Protected, ReadProtected}
]

SetAttributes[
 Evaluate@Names["FernandoDuarte`LongRunRisk`Model`EndogenousEq`*"]
  ,
  {Protected, ReadProtected}
]

SetAttributes[
 Evaluate@Names["FernandoDuarte`LongRunRisk`Model`ExogenousEq`*"]
  ,
  {Protected, ReadProtected}
]



SetAttributes[
 Evaluate@Names["FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*"]
  ,
  {Protected, ReadProtected}
]

*)



(* ::Subsection:: *)
(*ToTex*)


(*dc[t] //ToTeX*)


(* ::Subsection:: *)
(*useMaTeX*)


(*Needs["MaTeX`"]
(*automatically use MaTeX instead of built-in LaTeX in inline/displayed formula cells*)
UsingFrontEnd[
	$useMaTeXMag=1;
	$useMaTeXBaselineShift=0;
	$useMaTeXMag=1.44; (*x^2 and x have the~same size in a Text cell*)
	$useMaTeXBaselineShift=-0.12;  (*aligns x^2 with x in a Text cell*)
	$useMaTeXQ=True;
	Module[{$s},
	Quiet[
	(*clear any existing customizations*)
	InputAssistant`TeXStringToBoxes//Unprotect;
	InputAssistant`TeXStringToBoxes[$s_String]/;TrueQ@$useMaTeXQ=.;
	InputAssistant`TeXStringToBoxes//Protect;
	(*use MaTeX*)
	InputAssistant`TeXStringToBoxes//Unprotect;
	InputAssistant`TeXStringToBoxes[$s_String]/;TrueQ@$useMaTeXQ:=AdjustmentBox[ToBoxes@MaTeX[$s,Magnification->$useMaTeXMag],BoxBaselineShift->$useMaTeXBaselineShift];
	InputAssistant`TeXStringToBoxes//Protect;
	]];
	(*preamble for MaTeX to use in LaTeX files*)
	preambleTeX={
	"\\usepackage{color}",
	"\\usepackage{microtype}"
	};
]
*)
