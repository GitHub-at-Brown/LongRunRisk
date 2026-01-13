(* ::Package:: *)

(* ::Section:: *)
(*Initialization*)
Get["FernandoDuarte`LongRunRisk`Tools`Initialization`"];

(* ::Section:: *)
(*Load sub-contexts*)


$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"];
$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"];


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


BuildModels;
CheckModels;
Ev;Var;Corr;Cov;
Growth;
Info;
Models;
PlotCoeffs;
ToEquation;ToExogenousVars;ToNum;ToStateVars;
UncondE; UncondCov; UncondVar; UncondCorr;
VisualizeCoeffs;
YieldCurve;


(* ::Subsubsection:: *)
(*Usage*)


(*symbols automatically inherit usage messages from the file in which they are first introduced*)


(*Symbol/@ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`$exogenousVarsPrivate
Symbol/@ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`$endogenousVarsPrivate*)

(* PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"]
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"]; *)
(* $ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"];
$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"]; *)



(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* FernandoDuarte`LongRunRisk`t=FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t; *)


(* ::Subsection:: *)
(*Package dependencies*)


(*PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`"];*)
(*PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];*)
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`ToNumber`"];
(*PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"];*)
(*PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`NiceTables`"];*)
(*PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`NicePlots`"];*)
reExport = FernandoDuarte`LongRunRisk`Tools`Initialization`reExport;


(* ::Subsection:: *)
(*Models*)


(* load models via Get@Get pattern - requires PacletizedResourceFunctions loaded first *)
Needs["PacletizedResourceFunctions`"];
FernandoDuarte`LongRunRisk`Models = Get@Get@"FernandoDuarte/LongRunRisk/Models.wl"; (* is this safer?: FileNameJoin[{"FernandoDuarte/LongRunRisk", "Models.wl"}] *)

PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Model`Catalog`"];
FernandoDuarte`LongRunRisk`Models::usage = Information["FernandoDuarte`LongRunRisk`Model`Catalog`models","Usage"];


(* load moments lookup tables *)
Needs["PacletTools`"];
pacletObj=First@PacletFind["FernandoDuarte/LongRunRisk"];
filesMom = PacletTools`PacletExtensionFiles[pacletObj,"Path"][{"Path",<|"Root"->"Resources"|>}];
Map[
	Get@#&,
	Flatten@StringCases[filesMom,__~~"MomentsLookupTables"~~__~~".mx"]
];

(* load compiled functions -- commented out since done automatically downstream *)
(*filesComp= PacletTools`PacletExtensionFiles[pacletObj,"Path"][{"Path",\[LeftAssociation]"Root"\[Rule]"Resources/CompiledFunctions"\[RightAssociation]}];
Map[
	Get@#&,
	Flatten@StringCases[filesComp,__~~"/"~~$SystemID~~"/"~~__~~".mx"]
]*)


(* ::Subsection:: *)
(*ComputationalEngine*)


(* ::Subsubsection:: *)
(*Conditional moments*)


(*PacletizedResourceFunctions`*)
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];


reExport[#]&/@{
	"FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"
}


(* ::Subsubsection:: *)
(*Unconditional moments*)


PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`"];


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
(*ManageResources*)


PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];


(* ::Text:: *)
(*BuildModels*)


reExport[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels,FernandoDuarte`LongRunRisk`BuildModels];


(* ::Subsubsection:: *)
(*NiceOutput*)


PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];


Info::usage = StringReplace[Information[FernandoDuarte`LongRunRisk`Tools`NiceOutput`info,"Usage"],"info" -> "Info"];


Info[models_Association] :=PacletizedResourceFunctions`SetSymbolsContext@FernandoDuarte`LongRunRisk`Tools`NiceOutput`info[models]; 
(*PacletizedResourceFunctions`SetSymbolsContext@Column[(FernandoDuarte`LongRunRisk`Tools`NiceOutput`info@#&)/@(Values@FernandoDuarte`LongRunRisk`Tools`NiceOutput`createEqTables[models])];*)


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
(*PipelineMonitor*)


PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`PipelineMonitor`"];


(* ::Text:: *)
(*BuildModels*)


reExport[FernandoDuarte`LongRunRisk`Tools`PipelineMonitor`checkModels,FernandoDuarte`LongRunRisk`CheckModels];


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


(* ::Subsubsection:: *)
(*VisualizeCoeffs*)


PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`VisualizeCoeffs`"];


reExport[#]&/@{
	"FernandoDuarte`LongRunRisk`Tools`VisualizeCoeffs`"
}


(* ::Subsubsection:: *)
(*OptionsValidationRules*)


Quiet[
	Check[
		PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`OptionsValidationRules`"];
		FernandoDuarte`LongRunRisk`Tools`OptionsValidationRules`InstallOptionsValidationRules[],
		Null
	]
];


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];


(* ::Subsection:: *)
(*Load and build models*)


Quiet[
	Check[
		If[!TrueQ[$ParallelEvaluationEnvironment] && $KernelID === 0 &&
			(* Skip CheckModels if LONGRUNRISK_SKIP_CHECK=true (for CI warmup) *)
			!MemberQ[{"true", "1"}, ToLowerCase[ToString[Environment["LONGRUNRISK_SKIP_CHECK"]]]],
			(* Only run if not in parallel context and main kernel *)
			FernandoDuarte`LongRunRisk`CheckModels[]
		],
		Null
	],
	All
];


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


(* ::Subsection:: *)
(*Display formatting*)


(* Strip qualification from subcontexts for cleaner display in documentation *)
(* Unprotect[MakeBoxes];

MakeBoxes[sym_Symbol /; StringMatchQ[Context[sym], "FernandoDuarte`LongRunRisk`*`*"], StandardForm] :=
  RowBox[{SymbolName[sym]}]

Protect[MakeBoxes]; *)
