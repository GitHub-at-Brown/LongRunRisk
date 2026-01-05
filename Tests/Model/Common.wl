(* ::Package:: *)

(* ::Section:: *)
(*Model Test Helpers Package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tests`Model`Common`"]


(* ::Subsection:: *)
(*Public symbols*)


verifySymbolContext;
headSymbolInContextQ;
contextIsolationQ;
coefficientIndicesExactQ;
checkModelsFieldContext;


(* ::Subsubsection:: *)
(*Usage*)


verifySymbolContext::usage = "verifySymbolContext[sourceVars, extractType, matchNames, expectedContext] verifies that symbols extracted from equations are in the expected context. sourceVars is the list of equation names (defaults to $endogenousVars). extractType is \"functionHead\" for s_Symbol[__], \"bareSymbol\" for s_Symbol, or \"curriedHead\" for s_Symbol[__][__]. matchNames is a list of symbol names to match.";
headSymbolInContextQ::usage = "headSymbolInContextQ[expr, symName, targetCtx] returns True if function symbols (heads with args) matching symName exist in expr and are all in targetCtx.";
contextIsolationQ::usage = "contextIsolationQ[func, normalArgs, fooArgs, sym] returns True if context isolation is preserved for func: output with normalArgs contains sym but not foo`sym, output with fooArgs contains foo`sym but not sym, the outputs differ, and foo`func gives different results than func.";
coefficientIndicesExactQ::usage = "coefficientIndicesExactQ[coefSym, spec] returns True if coefficient indices remain exact when given inexact input. spec is an Association with \"indices\" -> list. Type is inferred: {{i1}, {i2}, ...} for single-index, {{i1, j1}, {i2, j2}, ...} for double-index.";
checkModelsFieldContext::usage = "checkModelsFieldContext[models, field, extractType, matchNames, expectedContext] checks that symbols in model[field] matching matchNames are in expectedContext. extractType is \"functionHead\", \"bareSymbol\", or \"curriedHead\". Use None for expectedContext to check symbols are absent.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Private Helpers*)


(* Build a pattern rule that extracts symbols matching given names.
   extractType: "functionHead" for s_Symbol[__], "bareSymbol" for s_Symbol, "curriedHead" for s_Symbol[__][__] *)
makeSymbolExtractionPattern[extractType_String, matchNames_List] :=
	With[{nameSet = AssociationThread[matchNames -> True]},
		Switch[extractType,
			"functionHead", s_Symbol[__] /; KeyExistsQ[nameSet, SymbolName[s]] :> s,
			"bareSymbol", s_Symbol /; KeyExistsQ[nameSet, SymbolName[s]] :> s,
			"curriedHead", s_Symbol[__][__] /; KeyExistsQ[nameSet, SymbolName[s]] :> s
		]
	]

(* Check that a list is non-empty and all elements are in the expected context *)
nonEmptyAndAllInContextQ[symbols_List, expectedContext_String] :=
	symbols =!= {} && AllTrue[symbols, Context[#] === expectedContext &]


(* ::Subsection:: *)
(*verifySymbolContext*)


(* Verify symbols extracted from equations are in expected context *)
verifySymbolContext[sourceVars_List, extractType_String, matchNames_List, expectedContext_String] :=
	With[{
		exprs = (#[t]) & /@ (Symbol /@ sourceVars),
		pattern = makeSymbolExtractionPattern[extractType, matchNames]
	},
		nonEmptyAndAllInContextQ[Cases[exprs, pattern, Infinity], expectedContext]
	]


(* ::Subsection:: *)
(*headSymbolInContextQ*)


(* Check if function symbols (heads with args) matching a name exist in an expression and are in a specific context *)
headSymbolInContextQ[expr_, symName_String, targetCtx_String] :=
	nonEmptyAndAllInContextQ[
		Cases[expr, var_Symbol?(SymbolName[#] === symName &)[___] :> var, Infinity],
		targetCtx
	]


(* ::Subsection:: *)
(*contextIsolationQ*)


(* Check context isolation - func output with sym vs foo`sym remain distinct *)
contextIsolationQ[func_Symbol, normalArgs_List, fooArgs_List, sym_Symbol] :=
	With[{
		exprNormal = func @@ normalArgs,
		exprFoo = func @@ fooArgs,
		fooSym = Symbol["foo`" <> SymbolName[sym]],
		fooFunc = Symbol["foo`" <> SymbolName[func]]
	},
		And[
			FreeQ[exprNormal, fooSym],
			!FreeQ[exprNormal, sym],
			FreeQ[exprFoo, sym],
			!FreeQ[exprFoo, fooSym],
			exprNormal =!= exprFoo,
			(fooFunc @@ normalArgs) =!= exprNormal
		]
	]


(* ::Subsection:: *)
(*coefficientIndicesExactQ*)


(* Test that coefficient indices remain exact when given inexact input.
   Type is inferred from index structure: {{i}, ...} for single-index, {{i, j}, ...} for double-index *)

(* Single-index case: coefSym[i] - indices are single-element lists like {{0}, {1}} *)
coefficientIndicesExactQ[coefSym_Symbol, <|"indices" -> indices:{{_}..}, ___|>] :=
	Cases[
		Join[
			coefSym[N@#[[1]]] & /@ indices,
			N[coefSym[#[[1]]]] & /@ indices
		],
		coefSym[i_] :> {i}
	] === Join[indices, indices]

(* Double-index case: coefSym[i][j] - indices are two-element lists like {{0, 0}, {1, 1}} *)
coefficientIndicesExactQ[coefSym_Symbol, <|"indices" -> indices:{{_, _}..}, ___|>] :=
	Cases[
		Join[
			coefSym[N@#[[1]]][N@#[[2]]] & /@ indices,
			N[coefSym[#[[1]]][#[[2]]]] & /@ indices
		],
		coefSym[i_][j_] :> {i, j}
	] === Join[indices, indices]


(* ::Subsection:: *)
(*checkModelsFieldContext*)


(* Check symbols in model fields are in expected context (or absent if None).
   expectedContext: context string, or None to check symbols are absent *)
checkModelsFieldContext[models_Association, field_String, extractType_String, matchNames_List, expectedContext_] :=
	With[{pattern = makeSymbolExtractionPattern[extractType, matchNames]},
		AllTrue[Values[models],
			Function[model,
				With[{symbols = Cases[model[field], pattern, Infinity]},
					If[expectedContext === None,
						symbols === {},
						AllTrue[symbols, Context[#] === expectedContext &]
					]
				]
			]
		]
	]


(* ::Section:: *)
(*End package*)


End[] (*"`Private`"*)


EndPackage[]
