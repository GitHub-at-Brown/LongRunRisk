(* ::Package:: *)

(* ::Section:: *)
(*Test Helpers Package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tests`Common`"]


(* ::Subsection:: *)
(*Public symbols*)


captureStdout;
$pacletDir;


(* ::Subsubsection:: *)
(*Usage*)


captureStdout::usage = "captureStdout[expr] captures output written to $Output during evaluation of expr and returns it as a string.";
$pacletDir::usage = "$pacletDir is the root directory of the paclet containing the current test file.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*captureStdout*)


(* captureStdout captures output by redirecting $Output to a temporary file *)
SetAttributes[captureStdout, HoldFirst];
captureStdout[expr_] := Module[{file = CreateFile[], stream, result, out},
	stream = OpenWrite[file];
	Block[{$Output = {stream}, $Messages = {stream}},
		result = expr;
	];
	Close[stream];
	out = ReadString[file];
	DeleteFile[file];
	If[out === EndOfFile, "", out]
]


(* ::Subsection:: *)
(*$pacletDir*)


(* Find paclet root by walking up directory tree from $TestFileName *)
$pacletDir = Quiet[SelectFirst[
	FixedPointList[DirectoryName, $TestFileName, 20],
	Quiet[PacletObjectQ[PacletObject[Flatten[File[#]]]]] &,
	None
]];


(* ::Section:: *)
(*End package*)


End[] (*"`Private`"*)


EndPackage[]
