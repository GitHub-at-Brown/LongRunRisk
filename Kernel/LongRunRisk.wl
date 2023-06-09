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


BeginPackage["FernandoDuarte`LongRunRisk`"]


(*<<FernandoDuarte`LongRunRisk`Model`ProcessModels`;
<<FernandoDuarte`LongRunRisk`Tools`TimeAggregation`;
<<FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`;
<<FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`;
<<FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`;*)


Models;
Info;
ToNum;
ToExogenous;
YieldCurve;
Growth;


(*display ? without contexts*)
(*Unprotect@Definition;
Definition[x_Symbol] /; StringMatchQ[Context[x], "Package`" ~~ ___] := 
    StringReplace[ToString@FullDefinition[x], 
        (WordCharacter .. ~~ DigitCharacter ... ~~ "`") .. ~~ s_ :> s
    ];
Protect@Definition;*)


Begin["`Private`"]


(* ::Subsubsection:: *)
(*Load models*)


(*tempfile="FernandoDuarte/LongRunRisk/Models.mx";
Get[tempfile];*)
Get@Get[FindFile[File["FernandoDuarte/LongRunRisk/Models.wl"]]]


(* ::Subsubsection:: *)
(*Info*)


(*Check out*)
(*ResourceFunction["CopyDefinitions"]*)

(*Language`ExtendedFullDefinition[] = ResourceFunction["ReplaceContext"][
  Language`ExtendedDefinition[f], $Context -> "MySandbox`"]*)


PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"];

Info[models_Association] := Column[(FernandoDuarte`LongRunRisk`Tools`NiceOutput`info@#&)/@(Values@FernandoDuarte`LongRunRisk`Tools`NiceOutput`createEqTables[models])];
Info::usage = Information[FernandoDuarte`LongRunRisk`Tools`NiceOutput`info,"Usage"];


(* ::Subsubsection:: *)
(*Variables*)


(*Begin["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
EndogenousVars=Symbol/@StringDrop[FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars,-2]
End[];
Begin["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
ExogenousVars[model_Association]:=Symbol/@StringDrop[model["exogenousVars"],-2];
End[];*)
(*wcUsage = StringDelete[wceq::usage,"eq"]
sym2::msg = sym3::msg = sym1::msg; 
wc::usage = wceq::usage;(*to use ?wc*)
Do[With[{ff = f}, 
  Message[MessageName[ff, "msg"]]
  ],
   {f, {sym1, sym2, sym3}}
]*)
  


(* ::Subsubsection:: *)
(*ToNum*)


ToNum[model_Association]:=Function[{expr},ReplaceRepeated[expr,model["parameters"]]]
(*delta //ToNum[model]
delta //ToNum[Models["NRC"]]*)


(* ::Subsubsection:: *)
(*ToTex*)


(*dc[t] //ToTeX*)


(* ::Subsubsection:: *)
(*ToExogenous*)


(*ToExogenous[expr_]:=ReplaceRepeated
ToExogenous[model_Association]:=Function[{expr},ReplaceRepeated[expr,Normal@model["endogenousEq"]]]*)


(* ::Subsubsection:: *)
(*Moments*)


(*PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
*)
(*FernandoDuarte`LongRunRisk`uncondE[x_,model_] := FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[x,model];*)
(*uncondVar[x_] := FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondVar
uncondCov[x_,y_] := FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondCov
*)
(*uncondE::usage = Information[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE,"Usage"];*)
(*uncondVar::usage = Information[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondVar,"Usage"];
uncondCov::usage = Information[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondCov,"Usage"];*)



(* ::Subsubsection:: *)
(*Time Aggregation*)


PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"];
Growth[args___] := FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth@@{args};
Growth::usage = Information[FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth,"Usage"];
(*ResourceFunction["MessageReplace"]*)


(* ::Subsubsection:: *)
(*Plots*)


(*PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`NicePlots`"];*)
Get["FernandoDuarte`LongRunRisk`Tools`NicePlots`"]
Options[YieldCurve] = Options[FernandoDuarte`LongRunRisk`Tools`NicePlots`yieldCurve];
YieldCurve[args___] := FernandoDuarte`LongRunRisk`Tools`NicePlots`yieldCurve@@{args};
YieldCurve::usage = Information[FernandoDuarte`LongRunRisk`Tools`NicePlots`yieldCurve,"Usage"];



(*main=1;

(*re-export symbols from other contexts *)
PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Model`Catalog`"];

Info[Models[] := FernandoDuarte`LongRunRisk`Tools`NiceOutput`Info[FernandoDuarte`LongRunRisk`Model`Catalog`models];
Models[x_String] := FernandoDuarte`LongRunRisk`Model`Catalog`models[x];*)


(*Models::usage = Information["FernandoDuarte`LongRunRisk`Model`Catalog`models","Usage"];*)

(*NeedsDefinitions["FernandoDuarte`LongRunRisk`Model`NiceOutput`"];*)


(*models := Block[{$ContextPath = {}}, SetSymbolsContext[modelsLocal]];*)




(*PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
coeff[] := FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`coeff;
coeff::usage = Information["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`coeff","Usage"];*)


(*re-export info from FernandoDuarte`LongRunRisk`Model`NiceOutput` *)
(*Info = (PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; 
FernandoDuarte`LongRunRisk`Model`NiceOutput`info);

Info::usage = (PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]; 
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

