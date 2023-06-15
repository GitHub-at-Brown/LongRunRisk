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

<<FernandoDuarte`LongRunRisk`Model`Parameters`;
<<FernandoDuarte`LongRunRisk`Model`Shocks`;
<<FernandoDuarte`LongRunRisk`Model`ExogenousEq`;
$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"];

<<FernandoDuarte`LongRunRisk`Model`EndogenousEq`;
$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"];

<<FernandoDuarte`LongRunRisk`Tools`NiceOutput`;
$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"];

<<FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`;
<<FernandoDuarte`LongRunRisk`Tools`TimeAggregation`;

(*<<FernandoDuarte`LongRunRisk`Model`Catalog`;
<<FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`;*)


(*<<FernandoDuarte`LongRunRisk`Model`Parameters`;
<<FernandoDuarte`LongRunRisk`Model`Shocks`;
<<FernandoDuarte`LongRunRisk`Model`ExogenousEq`;
<<FernandoDuarte`LongRunRisk`Model`EndogenousEq`;
$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"];
$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"];
*)
<<FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`;



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
covLongBY;covLongNRC;covLongDES


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


(* ::Subsubsection:: *)
(*Load models*)


Get@Get[FindFile[File["FernandoDuarte/LongRunRisk/Models.wl"]]];

momentsTablesFiles=FileNames["*.wl","FernandoDuarte/LongRunRisk/MomentsLookupTables/"];
momentsTables = Get/@momentsTablesFiles;
Get/@momentsTables;

(*loads the following symbols; write usage?*)
(*{
	"FernandoDuarte`LongRunRisk`Epd0",
	"FernandoDuarte`LongRunRisk`Ewc0",
	"FernandoDuarte`LongRunRisk`FindRootOptions",
	"FernandoDuarte`LongRunRisk`Models",
	"FernandoDuarte`LongRunRisk`RecurrenceTableOptions"
}*)


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


<<FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`;
<<FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`;


reExport[#]&/@{
(*	"FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`",*)
	"FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`",
	"FernandoDuarte`LongRunRisk`Tools`TimeAggregation`",
	"FernandoDuarte`LongRunRisk`Tools`NiceOutput`",
	"FernandoDuarte`LongRunRisk`Tools`NicePlots`"
}


UncondCov[x_,y_,model_]:=Module[
	{
		toExogenous = Normal@model["endogenousEq"],
		covLong=Symbol["FernandoDuarte`LongRunRisk`covLong"<>model["shortname"]]
	},
	<<FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`;
	cExo=FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`uncondCovLongExo[toExogenous, x, y, covLong];
	If[
		FreeQ[cE,covLong],
		cExo,
		FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondCov[x, y, model]]
];

UncondVar[x_, model_]:=UncondCov[x,x, model];
UncondCorr[x_,y_,model_]:=UncondCov[x,y,model]/(Sqrt[UncondVar[x,model]]Sqrt[UncondVar[y,model]]);


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

