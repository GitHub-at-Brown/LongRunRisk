(* ::Package:: *)

(* ::Section:: *)
(*Tools Test Helpers Package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tests`Tools`Common`"]


(* ::Subsection:: *)
(*Public symbols*)


$processedModels;
$testModels; $modBY;
$nft; $sft;
$g; $timeSeriesVector; $gt;
$baseParams;


(* ::Subsubsection:: *)
(*Usage*)


$processedModels::usage = "$processedModels is an Association of pre-processed models loaded from the Models.wl resource.";
$testModels::usage = "$testModels is a small subset of $processedModels for faster tests.";
$modBY::usage = "$modBY is the BY model from $testModels.";
$nft::usage = "$nft is an alias for NiceOutput`Private`numberFormattingTemplate.";
$sft::usage = "$sft is an alias for NiceOutput`Private`stringFormattingTemplate.";
$g::usage = "$g is an alias for TimeAggregation`Private`g.";
$timeSeriesVector::usage = "$timeSeriesVector is an alias for TimeAggregation`Private`timeSeriesVector.";
$gt::usage = "$gt is an alias for TimeAggregation`Private`gt.";
$baseParams::usage = "$baseParams is a shared fixture of base parameters for ToNumber tests.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Load Dependencies*)


Needs["PacletizedResourceFunctions`"];


(* ::Subsection:: *)
(*Load Pre-processed Models*)


$processedModels = Get[Get[FileNameJoin[{"FernandoDuarte/LongRunRisk", "Models.wl"}]]];

(* Use a small subset for faster tests *)
$testModels = KeyTake[$processedModels, {"BY", "BKY", "NRC"}];
$modBY = $testModels["BY"];


(* ::Subsection:: *)
(*NiceOutput Private Symbol Aliases*)


$nft = FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate;
$sft = FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stringFormattingTemplate;


(* ::Subsection:: *)
(*TimeAggregation Private Symbol Aliases*)


$g = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g;
$timeSeriesVector = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`timeSeriesVector;
$gt = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`gt;


(* ::Subsection:: *)
(*ToNumber Test Fixtures*)


(* Explicitly qualify all parameter symbols to ensure correct context *)
$baseParams = {
	FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.998`,
	FernandoDuarte`LongRunRisk`Model`Parameters`Esx -> 0.0078`,
	FernandoDuarte`LongRunRisk`Model`Parameters`gamma -> 10,
	FernandoDuarte`LongRunRisk`Model`Parameters`muc -> 0.0015`,
	FernandoDuarte`LongRunRisk`Model`Parameters`phisxs -> 2.3`*^-6,
	FernandoDuarte`LongRunRisk`Model`Parameters`phix -> 0.044`,
	FernandoDuarte`LongRunRisk`Model`Parameters`psi -> 1.5`,
	FernandoDuarte`LongRunRisk`Model`Parameters`rhox -> 0.979`,
	FernandoDuarte`LongRunRisk`Model`Parameters`theta -> (1 - FernandoDuarte`LongRunRisk`Model`Parameters`gamma)/(1 - 1/FernandoDuarte`LongRunRisk`Model`Parameters`psi),
	FernandoDuarte`LongRunRisk`Model`Parameters`vx -> 0.987`,
	FernandoDuarte`LongRunRisk`Model`Parameters`mud[1] -> 0.0015`,
	FernandoDuarte`LongRunRisk`Model`Parameters`phidxd[1] -> 4.5`,
	FernandoDuarte`LongRunRisk`Model`Parameters`rhodx[1] -> 3
};


(* ::Section:: *)
(*End package*)


End[] (*"`Private`"*)


EndPackage[]
