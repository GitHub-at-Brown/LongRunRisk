(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`Initialization`"]


(* ::Subsection:: *)
(*Public symbols*)


compoundScope
copyDefinitions
reExport


(* ::Subsubsection:: *)
(*Usage*)


compoundScope::usage = "compoundScope[{x = x0, y = y0, ...}, expr] specifies that all occurrences of the symbols x, y, ... in expr should be replaced by values x0, y0, ... where each value can depend on all the previous values." <> "\n" <>
	"compoundScope[{x = x0, code, y = y0, ...}, expr] also evaluates code that may depend on previously assigned values." <> "\n" <>
	"compoundScope[x = x0; code; y = y0; ..., expr] is the same as compoundScope[{x = x0, code, y = y0, ...}, expr]." <> "\n" <>
	"compoundScope[scope, assignments, expr] applies a different scoping construct scope, which can be either With, Block or Module.";

copyDefinitions::usage = "copyDefinitions[f, g] copies all definitions of symbol f to symbol g, creating an independent copy." <> "\n" <>
	"copyDefinitions[f, \"Context`\"] copies all definitions of symbol f to a new symbol with the same name in the specified context.";

reExport::usage = "reExport[f, g] copies all definitions from symbol f to symbol g and updates the usage message. reExport[oldContext] exports all public symbols from oldContext to FernandoDuarte`LongRunRisk` with capitalized names.";


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


(* ::Subsection:: *)
(*copyDefinitions*)


(* ::Subsubsection:: *)
(*Helper: symbolQ*)


SetAttributes[symbolQ, HoldAllComplete];

symbolQ[s_Symbol] := Depth[HoldComplete[s]] === 2

symbolQ[___] := False


(* ::Subsubsection:: *)
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


(* ::Subsection:: *)
(*reExport*)


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


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];


(* ::Section:: *)
(*Initialization code*)


If[
	{} === PacletFind["PacletizedResourceFunctions"],
	PacletInstall[
		File[
			FindFile["FernandoDuarte/LongRunRisk/PacletizedResourceFunctions.paclet"]
		],
		KeepExistingVersion -> False,
		ForceVersionInstall -> True
	]
];

(* Warm up DefinitionData to avoid Symbol::symname and cloud auth prompts. *)
Quiet[
	Block[{$AllowInternet = False},
		Needs["PacletizedResourceFunctions`"];
		Module[{warmup},
			warmup = Null;
			PacletizedResourceFunctions`DefinitionData[warmup];
		]
	],
	URLSubmit::offline
];



(* ::Subsection:: *)
(*MaTeX*)


(* Install and load MaTeX *)
If[
	{} === PacletFind["MaTeX"],
	(* Not installed: install via MaTeXInstall, which also loads MaTeX *)
	If[
		{} === PacletFind["MaTeXInstall" -> "1.0.0"],
		PacletInstall[
			File[
				FindFile["FernandoDuarte/LongRunRisk/MaTeXInstall-1.0.0.paclet"]
			],
			KeepExistingVersion -> True,
			ForceVersionInstall -> True
		]
	];
	Needs["MaTeXInstall`"];
	MaTeXInstall`MaTeXInstall[],
	(* Already installed: just load it *)
	Needs["MaTeX`"]
];

(* Configure MaTeX if auto-detection failed for pdfLaTeX or Ghostscript *)
initializeDependencies::pdflatex = "pdfLaTeX executable not found at `1`. Please configure MaTeX manually.";
initializeDependencies::gs = "Ghostscript executable not found at `1`. Please configure MaTeX manually.";

With[{currentConfig = Quiet @ MaTeX`ConfigureMaTeX[]},
	Module[{pdflatexPath, gsPath, needsPdflatex, needsGs, configChanges, validConfig},
		(* Validate that currentConfig is a proper list of rules or Association *)
		validConfig = MatchQ[currentConfig, {(_Rule | _RuleDelayed) ...}] || AssociationQ[currentConfig];
		needsPdflatex = If[validConfig, Lookup[currentConfig, "pdfLaTeX", None] === None, True];
		needsGs = If[validConfig, Lookup[currentConfig, "Ghostscript", None] === None, True];

		If[needsPdflatex || needsGs,
			(* Determine fallback paths based on platform.
			   Note: CI branch is checked first intentionally — on GitHub Actions macOS runners,
			   we want to use CI-specific paths rather than standard macOS paths. *)
			{pdflatexPath, gsPath} = Which[
				StringMatchQ[$SystemID, "Linux*"] && MemberQ[{"true", "True", "1"}, Environment["CI"]],
				{"/github/home/bin/pdflatex", None},
				StringMatchQ[$SystemID, "MacOSX*"],
				{
					SelectFirst[{"/opt/homebrew/bin/pdflatex", "/usr/local/bin/pdflatex"}, FileExistsQ, None],
					SelectFirst[{"/opt/homebrew/bin/gs", "/usr/local/bin/gs"}, FileExistsQ, None]
				},
				True,
				{None, None}
			];

			(* Build config changes only for what's needed and exists *)
			configChanges = {};
			If[needsPdflatex && pdflatexPath =!= None,
				If[FileExistsQ[pdflatexPath],
					AppendTo[configChanges, "pdfLaTeX" -> pdflatexPath],
					Message[initializeDependencies::pdflatex, pdflatexPath]
				]
			];
			If[needsGs && gsPath =!= None,
				If[FileExistsQ[gsPath],
					AppendTo[configChanges, "Ghostscript" -> gsPath],
					Message[initializeDependencies::gs, gsPath]
				]
			];

			(* Apply config if we have changes; redirect $Output to suppress MaTeX's Print *)
			If[configChanges =!= {},
				Block[{$Output = {}}, MaTeX`ConfigureMaTeX @@ configChanges]
			]
		]
	]
];

Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];
Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
