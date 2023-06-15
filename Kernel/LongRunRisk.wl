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
Quiet@Get[FileNameJoin[{(First@PacletFind["MaTeX"->"1.7.9"])["Location"],"MaTeX.m"}]];(*Needs["MaTeX`",FileNameJoin[{pacletMaTeX["Location"],"MaTeX.m"}]]*)
MaTeX`Developer`ResetConfiguration[];

(*<<FernandoDuarte`LongRunRisk`Model`Parameters`;
<<FernandoDuarte`LongRunRisk`Model`Shocks`;
<<FernandoDuarte`LongRunRisk`Model`ExogenousEq`;
$ContextPath=AppendTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"];
<<FernandoDuarte`LongRunRisk`Model`Catalog`;
<<FernandoDuarte`LongRunRisk`Model`EndogenousEq`;
$ContextPath=AppendTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"];
<<FernandoDuarte`LongRunRisk`Tools`NiceOutput`;
$ContextPath=AppendTo[$ContextPath,"FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"];*)


(*<<FernandoDuarte`LongRunRisk`Model`Parameters`;
<<FernandoDuarte`LongRunRisk`Model`Shocks`;
<<FernandoDuarte`LongRunRisk`Model`ExogenousEq`;
<<FernandoDuarte`LongRunRisk`Model`EndogenousEq`;
$ContextPath=AppendTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"];
$ContextPath=AppendTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"];

<<FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`;*)



BeginPackage["FernandoDuarte`LongRunRisk`"]


(*<<FernandoDuarte`LongRunRisk`Model`ProcessModels`;
<<FernandoDuarte`LongRunRisk`Tools`TimeAggregation`;

<<FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`;*)


Models;
Info;
ToNum;
ToEquation;
ToExogenousVars;
ToStateVars;
UncondE; UncondVar; UncondCov; UncondCorr;
Ev; Var; Cov; Corr;
Moments;
Solution;
Growth;
YieldCurve;


(*PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"];
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"];

Symbol/@ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`$exogenousVarsPrivate
Symbol/@ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`$endogenousVarsPrivate*)


(*display ? without contexts*)
(*Unprotect@Definition;
Definition[x_Symbol] /; StringMatchQ[Context[x], "Package`" ~~ ___] := 
    StringReplace[ToString@FullDefinition[x], 
        (WordCharacter .. ~~ DigitCharacter ... ~~ "`") .. ~~ s_ :> s
    ];
Protect@Definition;*)


Begin["`Private`"]


(*Check out*)
(*ResourceFunction["CopyDefinitions"]*)

(*Language`ExtendedFullDefinition[] = ResourceFunction["ReplaceContext"][
  Language`ExtendedDefinition[f], $Context -> "MySandbox`"]*)
  
  (*ResourceFunction["TraceView"]*)


(* ::Subsection:: *)
(*Helper functions*)


(* ::Subsubsection:: *)
(*reExport*)


CopyDefinitions=ResourceFunction["CopyDefinitions"];
MessageReplace=ResourceFunction["MessageReplace"];
CompoundScope=ResourceFunction["CompoundScope"];
SymbolQ=ResourceFunction["SymbolQ"];

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
(*Re - export symbols from subcontexts*)


PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"];


<<FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`;
<<FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`;


reExport[#]&/@{
	"FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`",
	"FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`",
	"FernandoDuarte`LongRunRisk`Tools`TimeAggregation`",
	"FernandoDuarte`LongRunRisk`Tools`NicePlots`"
}



(* ::Subsubsection:: *)
(*Load models*)


(*Get@Get[FindFile[File["FernandoDuarte/LongRunRisk/Models.wl"]]] *)
(*loads the following symbols; write usage?*)
(*{
	"FernandoDuarte`LongRunRisk`Epd0",
	"FernandoDuarte`LongRunRisk`Ewc0",
	"FernandoDuarte`LongRunRisk`FindRootOptions",
	"FernandoDuarte`LongRunRisk`Models",
	"FernandoDuarte`LongRunRisk`RecurrenceTableOptions"
}*)


(* ::Subsubsection:: *)
(*Info*)


PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];

Info[models_Association] := PacletizedResourceFunctions`SetSymbolsContext@Column[(FernandoDuarte`LongRunRisk`Tools`NiceOutput`info@#&)/@(Values@FernandoDuarte`LongRunRisk`Tools`NiceOutput`createEqTables[models])];
Info::usage = Information[FernandoDuarte`LongRunRisk`Tools`NiceOutput`info,"Usage"];


(* ::Subsubsection:: *)
(*Variables*)


ToEquation[expr_,model_Association]:= ReplaceAll[expr, Normal@Join[model["exogenousEq"],model["endogenousEq"]] ]
ToEquation[model_Association]:=Function[{expr}, ToEquation[expr,model]]

(*ToEquation[expr_,model_Association, n_Integer?Positive]:= Nest[ToEquation[#,model]&,expr,n];
ToEquation[model_Association, n_Integer?Positive]:=Function[{expr}, Nest[ToEquation[#,model]&,expr,n]];*)
(*ReplaceAll[expr_,ToEquation[model_]]^:=ToEquation[expr,model]*)


ToExogenousVars[expr_,model_Association]:= ReplaceRepeated[expr, Normal@model["endogenousEq"]] 
ToExogenousVars[model_Association]:=Function[{expr}, ToExogenousVars[expr,model]]

ToStateVars[expr_,model_Association]:= ReplaceRepeated[expr, Normal@model["toStateVars"]] 
ToStateVars[model_Association]:=Function[{expr}, ToStateVars[expr,model]]


(* ::Subsubsection:: *)
(*ToNum*)


paramRules[model_]:= Join[model["parameters"], PacletizedResourceFunctions`SetSymbolsContext@model["parameters"]]
ToNum[model_Association]:=Function[{expr},ReplaceRepeated[expr,Evaluate@paramRules[model]]];

(*delta //ToNum[model]
delta //ToNum[Models["NRC"]]*)


(* ::Subsubsection:: *)
(*ToTex*)


(*dc[t] //ToTeX*)


(* ::Subsubsection:: *)
(*Re-export symbols*)


(*Ev[x_,t_,model_] := FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[x,t,model];
Var[x_,t_,model_] := FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`var[x,t,model];
Cov[x_,y_,t_,model_] := FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`cov[x,y,t,model];
Corr[x_,y_,t_,model_] := FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`corr[x,y,t,model];

Ev::usage = Information[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev,"Usage"];
Var::usage = Information[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`var,"Usage"];
Cov::usage = Information[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`cov,"Usage"];
Corr::usage = Information[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`corr,"Usage"];*)


(* ::Subsubsection:: *)
(*Time Aggregation*)


(*
Growth[args___] := FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth@@{args};
Growth::usage = Information[FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth,"Usage"];*)
(*ResourceFunction["MessageReplace"]*)


(* ::Subsubsection:: *)
(*Plots*)


(*PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`NicePlots`"];*)
(*Get["FernandoDuarte`LongRunRisk`Tools`NicePlots`"]
Options[YieldCurve] = Options[FernandoDuarte`LongRunRisk`Tools`NicePlots`yieldCurve];
YieldCurve[args___] := FernandoDuarte`LongRunRisk`Tools`NicePlots`yieldCurve@@{args};
YieldCurve::usage = Information[FernandoDuarte`LongRunRisk`Tools`NicePlots`yieldCurve,"Usage"];*)



(*main=1;

(*re-export symbols from other contexts *)
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Model`Catalog`"];

Info[Models[] := FernandoDuarte`LongRunRisk`Tools`NiceOutput`Info[FernandoDuarte`LongRunRisk`Model`Catalog`models];
Models[x_String] := FernandoDuarte`LongRunRisk`Model`Catalog`models[x];*)


(*Models::usage = Information["FernandoDuarte`LongRunRisk`Model`Catalog`models","Usage"];*)

(*NeedsDefinitions["FernandoDuarte`LongRunRisk`Model`NiceOutput`"];*)


(*models := Block[{$ContextPath = {}}, SetSymbolsContext[modelsLocal]];*)




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

