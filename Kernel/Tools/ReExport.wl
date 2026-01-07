(* ::Package:: *)

(* ::Section:: *)
(*ReExport*)


(* Utilities for re-exporting symbols from one context to another *)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`ReExport`"]


(* ::Subsection:: *)
(*Public symbols*)


reExport::usage = "reExport[f, g] copies all definitions from symbol f to symbol g and updates the usage message. reExport[oldContext] exports all public symbols from oldContext to FernandoDuarte`LongRunRisk` with capitalized names.";


(* ::Section:: *)
(*Private*)


Begin["`Private`"]


Needs["FernandoDuarte`LongRunRisk`Tools`CopyDefinitions`"];
Needs["FernandoDuarte`LongRunRisk`Tools`CompoundScope`"];

copyDefinitions = FernandoDuarte`LongRunRisk`Tools`CopyDefinitions`copyDefinitions;
compoundScope = FernandoDuarte`LongRunRisk`Tools`CompoundScope`compoundScope;


reExport[f_Symbol, g_Symbol] := (copyDefinitions[f, g];
	MessageName[g, "usage"] = StringReplace[Information[g, "Usage"], SymbolName[f] :> SymbolName[g]])

(* Exports all public symbols from oldContext to newContext *)
reExport[oldContext_String, Optional[newContext_String, "FernandoDuarte`LongRunRisk`"]] := compoundScope[
	{
		oldFullNames = Names[oldContext <> "*"],
		oldNames = StringExtract[#, "`" -> -1] & /@ oldFullNames,
		newNames = Capitalize /@ oldNames,
		newFullNames = StringJoin[newContext, #] & /@ newNames
	},
	MapThread[reExport[Symbol @ #1, Symbol @ #2] &, {oldFullNames, newFullNames}];
]


End[] (*`Private`*)


EndPackage[]
