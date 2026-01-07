(* ::Package:: *)

(* ::Section:: *)
(*ComputationalEngine Test Helpers Package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`Common`"]


(* ::Subsection:: *)
(*Public symbols*)


$models;


(* ::Subsubsection:: *)
(*Usage*)


$models::usage = "$models is an Association of pre-processed models loaded from the Models.wl resource.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Load Dependencies*)


Needs["PacletizedResourceFunctions`"];


(* ::Subsection:: *)
(*Load Pre-processed Models*)


$models = Get[Get[FileNameJoin[{"FernandoDuarte/LongRunRisk", "Models.wl"}]]];


(* ::Section:: *)
(*End package*)


End[] (*"`Private`"*)


EndPackage[]
