#!/usr/bin/env wolframscript
(* OptionDependencyTree.wls
   Usage:
     wolframscript -file Scripts/OptionDependencyTree.wls --option PdEquations --root .
     wolframscript -file Scripts/OptionDependencyTree.wls --option PdEquations --out docs/options-pdequations-tree.md
     wolframscript -file Scripts/OptionDependencyTree.wls --option PdEquations --format json
*)

ClearAll["Global`*"];

(* ----------------------- *)
(* Argument parsing        *)
(* ----------------------- *)

parseArgs[args_List] := Module[{assoc = <||>, i = 1, key, val},
  While[i <= Length[args],
    If[StringStartsQ[args[[i]], "--"],
      key = StringDrop[args[[i]], 2];
      val = If[i + 1 <= Length[args] && !StringStartsQ[args[[i + 1]], "--"], args[[i + 1]], True];
      assoc[key] = val;
      i += If[val === True, 1, 2],
      (* Positional arg fallback: first positional is option name *)
      If[!KeyExistsQ[assoc, "option"], assoc["option"] = args[[i]]];
      i++
    ]
  ];
  assoc
];

topLevelForms[held_List] := Module[{forms},
  forms = Flatten @ Replace[
    held,
    HoldPattern[HoldComplete[CompoundExpression[exprs___]]] :>
      First[Map[HoldComplete, HoldComplete[{exprs}], {2}]],
    {1}
  ];
  DeleteCases[forms, HoldComplete[Null]]
];
topLevelForms[_] := {};

args = Rest[$ScriptCommandLine];
argAssoc = parseArgs[args];

optionName = Lookup[argAssoc, "option", Missing["OptionMissing"]];
If[optionName === Missing["OptionMissing"],
  Print["ERROR: --option is required."];
  Exit[1];
];

rootDir = Lookup[argAssoc, "root", Directory[]];
format = ToLowerCase @ ToString @ Lookup[argAssoc, "format", "md"];
outFile = Lookup[argAssoc, "out", None];

(* ----------------------- *)
(* File collection         *)
(* ----------------------- *)

collectFiles[root_] := Module[
  {baseDirs, scanDirs, files, excludeFragments},
  baseDirs = Select[FileNameJoin[{root, #}] & /@ {"Kernel", "Scripts"}, DirectoryQ];
  scanDirs = If[baseDirs === {}, {root}, baseDirs];
  files = Flatten @ FileNames[{"*.wl", "*.wls"}, scanDirs, Infinity];
  excludeFragments = {"/build/", "/Resources/", "/Documentation/", "/docs/", "/temp/", "/ToProcess/", "/.git/"};
  Select[files, !StringContainsQ[#, excludeFragments] &]
];

files = collectFiles[rootDir];

(* ----------------------- *)
(* Helpers                 *)
(* ----------------------- *)

inertExpr[expr_] := expr /. {
	HoldPattern[Symbol[args___]] :> HoldComplete[Symbol][args],
	HoldPattern[StringJoin[args___]] :> HoldComplete[StringJoin][args],
	HoldPattern[StringDrop[args___]] :> HoldComplete[StringDrop][args]
};

SetAttributes[heldCases, HoldRest];
heldCases[expr_, pat_, levelspec_: {0, Infinity}] := Module[{safe, pos},
	safe = inertExpr[expr];
	pos = Position[safe, HoldPattern[pat], levelspec];
	If[pos === {}, {}, Extract[safe, pos, HoldComplete]]
];

SetAttributes[heldFreeQ, HoldRest];
heldFreeQ[expr_, pat_] := Position[inertExpr[expr], HoldPattern[pat], {0, Infinity}] === {};

optionKeyToString[key_] := Module[{held},
	held = If[MatchQ[key, HoldComplete[_]], key, HoldComplete[key]];
	held = Replace[held, HoldPattern[HoldComplete[HoldComplete[x_]]] :> HoldComplete[x]];
	Which[
		MatchQ[held, HoldComplete[_String]],
		Replace[held, HoldPattern[HoldComplete[s_String]] :> s],
		MatchQ[held, HoldComplete[_Symbol]],
		Replace[held, HoldPattern[HoldComplete[s_Symbol]] :> SymbolName[s]],
		True,
		Missing["NotStringOrSymbol"]
	]
];

matchesOptionKeyQ[key_, opt_] := With[{keyStr = optionKeyToString[key]},
  StringQ[keyStr] && keyStr === opt
];

optionPatternQ[expr_] := (!heldFreeQ[expr, Verbatim[OptionsPattern][___]]) || (!heldFreeQ[expr, OptionQ]);

extractDefSymbol[lhs_] := Module[{core, sym},
	core = FixedPoint[
		Replace[#, {
			HoldPattern[HoldComplete[Verbatim[HoldPattern][inner_]]] :> HoldComplete[inner],
			HoldPattern[HoldComplete[Verbatim[Condition][inner_, _]]] :> HoldComplete[inner],
			HoldPattern[HoldComplete[Verbatim[Pattern][_, inner_]]] :> HoldComplete[inner],
			HoldPattern[HoldComplete[Verbatim[Optional][inner_, _]]] :> HoldComplete[inner]
		}] &,
		lhs
	];
	sym = Replace[
		core,
		{
			HoldPattern[HoldComplete[s_Symbol[___]]] :> s,
			HoldPattern[HoldComplete[s_Symbol]] :> s
		}
	];
	If[MatchQ[HoldComplete[sym], HoldComplete[_Symbol]], sym, Missing["UnknownSymbol"]]
];

symbolId[s_] := Module[{held = HoldComplete[s], sym, sid},
	sym = Replace[held, HoldPattern[HoldComplete[sym_Symbol]] :> sym];
	If[!MatchQ[HoldComplete[sym], HoldComplete[_Symbol]], Return[Missing["NotSymbol"]]];
	sid = Quiet @ Check[SymbolName[sym], Missing["BadSymbol"]];
	sid
];

extractOptionKeys[opts_] := Module[{ruleMatches, keys},
	ruleMatches = heldCases[opts, Rule[key_, _] | RuleDelayed[key_, _]];
	keys = Replace[
		ruleMatches,
		HoldPattern[HoldComplete[Rule[key_, _] | RuleDelayed[key_, _]]] :> HoldComplete[key],
		{1}
	];
	DeleteDuplicates @ DeleteCases[optionKeyToString /@ keys, _Missing]
];

extractOptionsPatternSymbols[lhs_, defSym_] := Module[{args, syms},
	args = Replace[
		heldCases[lhs, Verbatim[OptionsPattern][arg___]],
		HoldPattern[HoldComplete[Verbatim[OptionsPattern][arg___]]] :> HoldComplete[{arg}],
		{1}
	];
	syms = DeleteDuplicates @ Replace[
		heldCases[args, s_Symbol],
		HoldPattern[HoldComplete[s_Symbol]] :> s,
		{1}
	];
	syms = Select[syms, !MemberQ[{List, OptionsPattern, HoldComplete}, #] &];
	If[!heldFreeQ[lhs, Verbatim[OptionsPattern][]], syms = Append[syms, defSym]];
	DeleteDuplicates[syms]
];

extractOptionParams[lhs_] := Module[{matches},
	matches = heldCases[lhs, Verbatim[Pattern][s_, pat_]];
	DeleteDuplicates @ Cases[
		matches,
		HoldPattern[HoldComplete[Verbatim[Pattern][s_, pat_]]] /;
			MatchQ[HoldComplete[s], HoldComplete[_Symbol]] && optionPatternQ[HoldComplete[pat]] :>
			Replace[HoldComplete[s], HoldPattern[HoldComplete[sym_Symbol]] :> sym]
	]
];

extractAssignments[rhs_] := Module[{sets, delayed},
	sets = Replace[
		heldCases[rhs, HoldPattern[Set[var_Symbol, expr_]]],
		HoldPattern[HoldComplete[Set[var_Symbol, expr_]]] :> {var, HoldComplete[expr]},
		{1}
	];
	delayed = Replace[
		heldCases[rhs, HoldPattern[SetDelayed[var_Symbol, expr_]]],
		HoldPattern[HoldComplete[SetDelayed[var_Symbol, expr_]]] :> {var, HoldComplete[expr]},
		{1}
	];
	Join[sets, delayed]
];

carrierUsedQ[expr_, carriers_List] := AnyTrue[carriers, Function[{carrier}, !heldFreeQ[expr, carrier]]];

extractArgumentsOptionsCarriers[rhs_] := Module[
	{listAssigns, listVars, listCarriers, singleAssigns},
	listAssigns = Replace[
		heldCases[rhs, HoldPattern[Set[vars_List, ArgumentsOptions[__]] | SetDelayed[vars_List, ArgumentsOptions[__]]]],
		HoldPattern[HoldComplete[Set[vars_List, ArgumentsOptions[__]] | SetDelayed[vars_List, ArgumentsOptions[__]]]] :> HoldComplete[vars],
		{1}
	];
	listVars = Replace[listAssigns, HoldPattern[HoldComplete[list_List]] :> list, {1}];
	listCarriers = Replace[listVars, list_List /; list =!= {} :> Last[list], {1}];
	singleAssigns = Replace[
		heldCases[rhs, HoldPattern[Set[var_Symbol, ArgumentsOptions[__]] | SetDelayed[var_Symbol, ArgumentsOptions[__]]]],
		HoldPattern[HoldComplete[Set[var_Symbol, ArgumentsOptions[__]] | SetDelayed[var_Symbol, ArgumentsOptions[__]]]] :> var,
		{1}
	];
	DeleteDuplicates @ Cases[Join[listCarriers, singleAssigns], _Symbol]
];

optionsCarrierQ[expr_] := MatchQ[
	inertExpr[expr],
	HoldComplete[
		_Symbol |
		{___} | _Association |
		FilterRules[__] | Flatten[__] | Join[__] | Options[__] | Normal[__] |
		Sequence[__] | Apply[Sequence, __] |
		Rule[_, _] | RuleDelayed[_, _]
	]
];

computeCarriers[base_List, rhs_] := Module[{carriers = Union[base], assignments, changed = True},
	carriers = Union[carriers, extractArgumentsOptionsCarriers[rhs]];
	assignments = extractAssignments[rhs];
	While[changed,
		changed = False;
		Do[
			With[{var = pair[[1]], expr = pair[[2]]},
				If[!MemberQ[carriers, var] && carrierUsedQ[expr, carriers] && optionsCarrierQ[expr],
					carriers = Append[carriers, var];
					changed = True;
				]
			],
			{pair, assignments}
		];
	];
	DeleteDuplicates[carriers]
];

optionValueUseQ[expr_, opt_] := !heldFreeQ[
	expr,
	OptionValue[___, key_] /; matchesOptionKeyQ[HoldComplete[key], opt]
];

explicitRuleUseQ[expr_, opt_] := AnyTrue[
	Replace[
		heldCases[expr, Rule[key_, _] | RuleDelayed[key_, _]],
		HoldPattern[HoldComplete[Rule[key_, _] | RuleDelayed[key_, _]]] :> HoldComplete[key],
		{1}
	],
	matchesOptionKeyQ[#, opt] &
];

(* ----------------------- *)
(* Parse files             *)
(* ----------------------- *)

defs = {};
optsDefs = {};
splitDefs = {};

Do[
  Module[{held, topLevel, fileDefs, fileOpts, fileSplits},
    held = Quiet @ Check[Import[file, "HeldExpressions"], $Failed];
    If[held === $Failed || !ListQ[held], Continue[]];
    topLevel = topLevelForms[held];

    fileOpts = Join[
      Cases[topLevel, HoldPattern[HoldComplete[Options[s_Symbol] = o_]] :> {s, HoldComplete[o], file}, {1}],
      Cases[topLevel, HoldPattern[HoldComplete[Options[s_Symbol] := o_]] :> {s, HoldComplete[o], file}, {1}]
    ];
    optsDefs = Join[optsDefs, fileOpts];

    fileSplits = Cases[
      topLevel,
      HoldPattern[HoldComplete[sym_Symbol[_, sub_] := rhs_]] /;
        SymbolName[Unevaluated[sym]] === "splitConfig" :>
        With[{subKey = optionKeyToString[sub]},
          If[StringQ[subKey], {subKey, HoldComplete[rhs], file}, Nothing]
        ],
      {1}
    ];
    splitDefs = Join[splitDefs, fileSplits];

    fileDefs = Join[
      Cases[topLevel, HoldPattern[HoldComplete[lhs_ = rhs_]] :> {HoldComplete[lhs], HoldComplete[rhs], file}, {1}],
      Cases[topLevel, HoldPattern[HoldComplete[lhs_ := rhs_]] :> {HoldComplete[lhs], HoldComplete[rhs], file}, {1}]
    ];
    defs = Join[defs, fileDefs];
  ],
  {file, files}
];

(* ----------------------- *)
(* Build options metadata  *)
(* ----------------------- *)

builtinOptionSymbols = {Compile, FunctionCompile};
builtinOptionsBySymbol = Association @ Cases[
	builtinOptionSymbols,
	sym_Symbol :> Module[{sid = symbolId[sym], keys},
		keys = Check[SymbolName /@ Keys[Options[sym]], {}];
		If[MissingQ[sid] || keys === {}, Nothing, sid -> keys]
	]
];

optionsBySymbol = Association @ Merge[
  Join[
    Cases[
      optsDefs,
      {sym_, opts_, _} :> Module[{sid = symbolId[sym]},
        If[MissingQ[sid], Nothing, sid -> extractOptionKeys[opts]]
      ]
    ],
    Normal[builtinOptionsBySymbol]
  ],
  Union @ Flatten[#] &
];

splitConfigOptions = Association @ Merge[
  (#[[1]] -> extractOptionKeys[#[[2]]]) & /@ splitDefs,
  Union @ Flatten[#] &
];

optionSubsystems = DeleteCases[
  optionKeyToString /@ Select[Keys[splitConfigOptions], MemberQ[splitConfigOptions[#], optionName] &],
  _Missing
];

(* ----------------------- *)
(* Build definition data   *)
(* ----------------------- *)

defData = Module[{reaped},
  reaped = Reap[
    Do[
      Module[{lhs, rhs, file, defSym, defId, optParams, optPatternSyms},
        {lhs, rhs, file} = def;
        defSym = extractDefSymbol[lhs];
        If[defSym === Missing["UnknownSymbol"], Continue[]];
        defId = symbolId[defSym];
        If[MissingQ[defId], Continue[]];
        optParams = extractOptionParams[lhs];
        optPatternSyms = extractOptionsPatternSymbols[lhs, defSym];
        Sow[
          <|
            "Symbol" -> defSym,
            "SymbolId" -> defId,
            "LHS" -> lhs,
            "RHS" -> rhs,
            "File" -> file,
            "OptionParams" -> optParams,
            "OptionPatternSymbols" -> optPatternSyms
          |>
        ];
      ],
      {def, defs}
    ]
  ][[2]];
  If[Length[reaped] >= 1, First[reaped], {}]
];

(* Map symbol -> files and options-pattern symbols *)
symbolFiles = Association @ Merge[
  (#[["SymbolId"]] -> {#[["File"]]}) & /@ defData,
  First
];

definedSymbols = If[defData === {}, {}, Union[defData[[All, "SymbolId"]]]];

patternSymbolsById = Association @ Merge[
  Map[
    Function[{entry},
      entry[["SymbolId"]] -> DeleteCases[Flatten[symbolId /@ entry[["OptionPatternSymbols"]]], _Missing]
    ],
    defData
  ],
  Union @ Flatten[#] &
];

hasAssociationParamQ[lhs_] := !heldFreeQ[
  lhs,
  Verbatim[Pattern][_, Verbatim[Blank][Association]]
];

configAcceptsById = Association @ Merge[
  Map[
    Function[{entry},
      entry[["SymbolId"]] -> hasAssociationParamQ[entry[["LHS"]]]
    ],
    defData
  ],
  AnyTrue[#, TrueQ] &
];

(* Accepted options per symbol (Options + OptionsPattern symbols) *)
acceptedOptions = Association @ Map[
  Function[{sid},
    sid -> Module[{own = Lookup[optionsBySymbol, sid, {}], deps = Lookup[patternSymbolsById, sid, {}]},
      Union[own, Flatten[Lookup[optionsBySymbol, deps, {}]]]
    ]
  ],
  Union[Keys[optionsBySymbol], Keys[patternSymbolsById]]
];

(* Option usage per symbol *)
usesOption = Association @ Merge[
  (#[["SymbolId"]] -> optionValueUseQ[#[["RHS"]], optionName]) & /@ defData,
  AnyTrue[#, TrueQ] &
];

(* ----------------------- *)
(* Build edges             *)
(* ----------------------- *)

excludedCallHeads = {OptionValue, Options, Rule, RuleDelayed, Set, SetDelayed, Pattern, Condition,
  With, Module, Block, Function, Hold, HoldComplete, HoldPattern, PatternTest, Optional, Alternatives,
  Sequence, List, Association, ReplaceAll, ReplaceRepeated, Map, MapThread, Apply, Table, Do, While, For,
  If, Which, Switch, Quiet, Check, Message, MessageName, Needs, Get, Put, PutAppend, Print, PrintTemporary};

callHasSplitConfigQ[call_] := Module[{subs},
  subs = Replace[
    heldCases[call, sym_Symbol[_, sub_] /; SymbolName[Unevaluated[sym]] === "splitConfig"],
    HoldPattern[HoldComplete[sym_Symbol[_, sub_]]] :> optionKeyToString[sub],
    {1}
  ];
  AnyTrue[DeleteCases[subs, _Missing], MemberQ[optionSubsystems, #] &]
];

callHasNormalizeConfigQ[call_] :=
  heldCases[call, sym_Symbol[___] /; SymbolName[Unevaluated[sym]] === "normalizeConfig"] =!= {};

callPassType[call_, carriers_, callerId_, calleeId_] := Module[{accepts, callerAccepts, configAccepts},
	accepts = MemberQ[Lookup[acceptedOptions, calleeId, {}], optionName];
	callerAccepts = MemberQ[Lookup[acceptedOptions, callerId, {}], optionName];
	configAccepts = TrueQ[Lookup[configAcceptsById, calleeId, False]];
	Which[
		explicitRuleUseQ[call, optionName], "explicit",
		callHasSplitConfigQ[call] && accepts, "config",
		callHasNormalizeConfigQ[call] && configAccepts && calleeId =!= "normalizeConfig", "config",
		carriers =!= {} && carrierUsedQ[call, carriers] && accepts, "implicit",
		True, None
	]
];

edges = Module[{reaped},
  reaped = Reap[
    Do[
      Module[{callerId, rhs, optParams, carriers, calls},
        callerId = def["SymbolId"];
        rhs = def["RHS"];
        optParams = def["OptionParams"];
        carriers = computeCarriers[optParams, rhs];
        calls = heldCases[rhs, call : _Symbol[___]];
        Do[
          Module[{calleeHeld, callee, calleeId, passType},
            calleeHeld = Replace[call, HoldPattern[HoldComplete[s_Symbol[___]]] :> HoldComplete[s]];
            callee = Replace[calleeHeld, HoldPattern[HoldComplete[s_Symbol]] :> s];
            If[callee === calleeHeld, Continue[]];
            If[MemberQ[excludedCallHeads, callee], Continue[]];
            calleeId = symbolId[callee];
            If[MissingQ[calleeId], Continue[]];
            If[!MemberQ[definedSymbols, calleeId], Continue[]];
            passType = callPassType[call, carriers, callerId, calleeId];
            If[passType =!= None,
              Sow[<|"From" -> callerId, "To" -> calleeId, "Type" -> passType|>]
            ];
          ],
          {call, calls}
        ];
      ],
      {def, defData}
    ]
  ][[2]];
  If[Length[reaped] >= 1, First[reaped], {}]
];
edges = Select[edges, AssociationQ];

(* Deduplicate edges, prefer explicit > config > implicit *)
edgeRank[type_] := Switch[type, "explicit", 3, "config", 2, "implicit", 1, _, 0];
edges = Values @ Merge[
  (#[["From"]] <> "->" <> #[["To"]] -> #) & /@ edges,
  Function[{vals}, First @ MaximalBy[vals, edgeRank[#["Type"]] &]]
];

(* ----------------------- *)
(* Build tree              *)
(* ----------------------- *)

usesOptionTrue = Select[usesOption, TrueQ];
nodeIds = Union[Flatten[{edges[[All, "From"]], edges[[All, "To"]], Keys[usesOptionTrue]}]];
incoming = Association @ Merge[(#["To"] -> {#["From"]}) & /@ edges, Union];
outgoing = Association @ GroupBy[edges, #["From"] &];

roots = Select[nodeIds, !KeyExistsQ[incoming, #] &];

displayName[id_] := Module[{parts = StringSplit[id, "`"]},
  If[Length[parts] >= 2, Last[parts], id]
];

labelFor[id_] := Module[{name, file},
  name = displayName[id];
  file = Lookup[symbolFiles, id, None];
  If[file === None, name, name <> " (" <> file <> ")"]
];

tagFor[id_, edgeType_] := Module[{tags = {}},
  If[edgeType =!= None, AppendTo[tags, "pass: " <> edgeType]];
  If[TrueQ[Lookup[usesOption, id, False]], AppendTo[tags, "use"]];
  If[tags === {}, "", " [" <> StringRiffle[tags, ", "] <> "]"]
];

renderTree[roots_List] := Module[{lines = {}},
  ClearAll[dfs];
  dfs[node_, depth_, edgeType_, path_] := Module[{children, line, indent, nextPath},
    indent = StringRepeat["  ", depth];
    line = indent <> "- " <> labelFor[node] <> tagFor[node, edgeType];
    AppendTo[lines, line];
    children = Lookup[outgoing, node, {}];
    nextPath = Append[path, node];
    Do[
      If[MemberQ[nextPath, edge["To"]],
        AppendTo[lines, indent <> "  - " <> labelFor[edge["To"]] <> " [cycle]"],
        dfs[edge["To"], depth + 1, edge["Type"], nextPath]
      ],
      {edge, children}
    ];
  ];
  Do[dfs[root, 0, None, {}], {root, roots}];
  StringRiffle[lines, "\n"]
];

(* ----------------------- *)
(* Output                  *)
(* ----------------------- *)

output = Switch[format,
  "json",
  ExportString[
    <|
      "Option" -> optionName,
      "Roots" -> roots,
      "Edges" -> edges
    |>,
    "JSON"
  ],
  _, (* default md *)
  StringRiffle[
    {
      "# Option dependency tree: \"" <> optionName <> "\"",
      "",
      "Roots are nodes with no incoming edge for this option.",
      "",
      renderTree[roots]
    },
    "\n"
  ]
];

If[outFile =!= None,
  Export[outFile, output, "Text"],
  Print[output]
];
