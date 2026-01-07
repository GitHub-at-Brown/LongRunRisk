(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`CompoundScope`"]


(* ::Subsection:: *)
(*Public symbols*)


compoundScope


(* ::Subsubsection:: *)
(*Usage*)


compoundScope::usage = "compoundScope[{x = x0, y = y0, ...}, expr] specifies that all occurrences of the symbols x, y, ... in expr should be replaced by values x0, y0, ... where each value can depend on all the previous values." <> "\n" <>
	"compoundScope[{x = x0, code, y = y0, ...}, expr] also evaluates code that may depend on previously assigned values." <> "\n" <>
	"compoundScope[x = x0; code; y = y0; ..., expr] is the same as compoundScope[{x = x0, code, y = y0, ...}, expr]." <> "\n" <>
	"compoundScope[scope, assignments, expr] applies a different scoping construct scope, which can be either With, Block or Module.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*compoundScope*)


SetAttributes[compoundScope, HoldAll];

(* Base case: empty list *)
compoundScope[scope : With | Block | Module : With, {}, expr_] := expr

(* Main case: process list of assignments/expressions *)
compoundScope[scope : With | Block | Module : With, {x_, xs___}, expr_] := If[
	MatchQ[Unevaluated[x], HoldPattern[(Set | SetDelayed)[_Symbol, _]]],
		(* x is an assignment - wrap in scoping construct *)
		scope[{x}, compoundScope[scope, {xs}, expr]],
		(* x is code to evaluate - use CompoundExpression *)
		x; compoundScope[scope, {xs}, expr]
	]

(* Handle CompoundExpression (semicolon-separated) input *)
compoundScope[scope : With | Block | Module : With, compound_CompoundExpression, expr_] := Function[Null,
	compoundScope[scope, {##}, expr], HoldAll] @@ Unevaluated[compound]

(* Single variable (not in list) - wrap in list *)
compoundScope[scope : With | Block | Module : With, var_, expr_] := compoundScope[scope, {var}, expr]


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
