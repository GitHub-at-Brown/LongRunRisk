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

(*install local version of MaTeX provided with LongRunRisk paclet if not already installed*)
If[
	{}===PacletFind["MaTeX"],
	If[
		{}===PacletFind["MaTeXInstall"->"1.0.0"],
		PacletInstall[
			File[
				FindFile[
					"FernandoDuarte/LongRunRisk/MaTeXInstall-1.0.0.paclet"
				]
			],
			KeepExistingVersion->True,
			ForceVersionInstall->True
		]
	];
	(*Quiet@PacletizedResourceFunctions`NeedsDefinitions["MaTeXInstall`"];*)
	Needs["MaTeXInstall`"];
	MaTeXInstall`MaTeXInstall[];
]

(*load packages*)
(*Get["PacletizedResourceFunctions`"];*)
(*run DefinitionData once to avoid Symbol::symname message; disable internet to prevent cloud auth prompts*)
Quiet[
	Block[{$AllowInternet = False},
		Module[{warmup}, warmup = Null; PacletizedResourceFunctions`DefinitionData[warmup];]
	],
	URLSubmit::offline
];

Needs["MaTeX`"];

(* Configure MaTeX for CI environment where PATH may not include TinyTeX *)
(* The test-paclet action runs in its own Docker container with different PATH *)
If[
	Environment["CI"] === "true",
	With[{
		ciPdflatex = "/github/home/bin/pdflatex",
		ciGs = "/usr/bin/gs"
	},
		If[FileExistsQ[ciPdflatex] && FileExistsQ[ciGs],
			Quiet @ ConfigureMaTeX["pdfLaTeX" -> ciPdflatex, "Ghostscript" -> ciGs]
		]
	]
]


(* ::Section:: *)
(*Load sub-contexts*)


Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];
Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];

(* Load OptionsConfig infrastructure (Phase 1 refactoring) *)
(* Use Get with relative path for development; Needs will work once paclet is installed *)
With[{optionsConfigPath = FileNameJoin[{DirectoryName[$InputFileName], "Tools", "OptionsConfig.wl"}]},
	If[FileExistsQ[optionsConfigPath],
		Get[optionsConfigPath],
		Needs["FernandoDuarte`LongRunRisk`Tools`OptionsConfig`"]  (* Fallback for installed paclet *)
	]
];

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
Needs["FernandoDuarte`LongRunRisk`Tools`CopyDefinitions`"];
Needs["FernandoDuarte`LongRunRisk`Tools`CompoundScope`"];
copyDefinitions = FernandoDuarte`LongRunRisk`Tools`CopyDefinitions`copyDefinitions;
compoundScope = FernandoDuarte`LongRunRisk`Tools`CompoundScope`compoundScope;


(* ::Subsection:: *)
(*Helper functions*)


(* ::Subsubsection:: *)
(*reExport*)


reExport[f_Symbol, g_Symbol]:=
(
	copyDefinitions[f,g];
	MessageName[g,"usage"] = StringReplace[Information[g,"Usage"],SymbolName[f] :> SymbolName[g]]
);
(*exports all public symbols from oldContext to newContext*)
reExport[oldContext_String, Optional[newContext_String, "FernandoDuarte`LongRunRisk`"]]:=compoundScope[
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


(* load models *)
FernandoDuarte`LongRunRisk`Models = Get@Get@"FernandoDuarte/LongRunRisk/Models.wl";

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
