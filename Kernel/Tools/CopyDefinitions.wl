(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`CopyDefinitions`"]


(* ::Subsection:: *)
(*Public symbols*)


copyDefinitions


(* ::Subsubsection:: *)
(*Usage*)


copyDefinitions::usage = "copyDefinitions[f, g] copies all definitions of symbol f to symbol g, creating an independent copy." <> "\n" <>
	"copyDefinitions[f, \"Context`\"] copies all definitions of symbol f to a new symbol with the same name in the specified context.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Helper: symbolQ*)


SetAttributes[symbolQ, HoldAllComplete];

symbolQ[s_Symbol] := Depth[HoldComplete[s]] === 2

symbolQ[___] := False


(* ::Subsection:: *)
(*copyDefinitions*)


SetAttributes[copyDefinitions, HoldAllComplete];

(* Copy from symbol f to symbol g *)
copyDefinitions[f_?symbolQ, g_?symbolQ] := Module[{fDef},
	ClearAll[g];
	fDef = Language`ExtendedDefinition[f];
	If[FreeQ[fDef, HoldPattern[g]],
		Language`ExtendedDefinition[g] = fDef /. HoldPattern[f] :> g,
		With[{s = Unique[SymbolName[Unevaluated[g]]]},
			Language`ExtendedDefinition[g] = fDef /. HoldPattern[g] :> s /. HoldPattern[f] :> g
		]
	]
]

(* Copy to a new symbol in a specific context *)
copyDefinitions[f_?symbolQ, ctx_String /; StringMatchQ[ctx, __ ~~ "`"]] := With[
	{name = SymbolName[Unevaluated[f]]},
		ToExpression[
			StringJoin[ctx, name],
			InputForm,
			Function[g, copyDefinitions[f, g], {HoldAllComplete}]
		]
	]


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
