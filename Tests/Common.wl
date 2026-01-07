(* ::Package:: *)

(* ::Section:: *)
(*Test Helpers Package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tests`Common`"]


(* ::Subsection:: *)
(*Public symbols*)


captureStdout;
$pacletDir;

(* Pre-processed models *)
$models;

(* Model aliases *)
$modBY; $modBKY; $modNRC; $modDES; $modNRCStochVol;

(* Standard test model sets *)
$testModels; $testModelsCore;


(* ::Subsubsection:: *)
(*Usage*)


captureStdout::usage = "captureStdout[expr] captures output written to $Output during evaluation of expr and returns it as a string.";
$pacletDir::usage = "$pacletDir is the root directory of the paclet containing the current test file.";
$models::usage = "$models is an Association of pre-processed models loaded from the Models.wl resource.";
$modBY::usage = "$modBY is the BY model.";
$modBKY::usage = "$modBKY is the BKY model.";
$modNRC::usage = "$modNRC is the NRC model.";
$modDES::usage = "$modDES is the DES model.";
$modNRCStochVol::usage = "$modNRCStochVol is the NRCStochVol model.";
$testModelsCore::usage = "$testModelsCore is a minimal set of models for fast tests.";
$testModels::usage = "$testModels is the full set of models for comprehensive tests.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Load Dependencies*)


Needs["PacletizedResourceFunctions`"];


(* ::Subsection:: *)
(*Load Pre-processed Models*)


$models = Get[Get[FileNameJoin[{"FernandoDuarte/LongRunRisk", "Models.wl"}]]];


(* ::Subsection:: *)
(*Model Aliases*)


$modBY = $models["BY"];
$modBKY = $models["BKY"];
$modNRC = $models["NRC"];
$modDES = $models["DES"];
$modNRCStochVol = $models["NRCStochVol"];


(* ::Subsection:: *)
(*Standard Test Model Sets*)


(* Core models for fast tests *)
$testModelsCore = {$modBKY, $modNRC};

(* Full model set for comprehensive tests *)
$testModels = {$modBY, $modBKY, $modNRC, $modDES, $modNRCStochVol};


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
