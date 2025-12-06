(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


(* ::Subsection:: *)
(*Public symbols*)


buildKernel
bindUnary
findRootInterval
extractIntervalsFromReduce
scanAndSolve
fastRoot
createCompiledEq
buildEqMapFromModel


(* ::Subsubsection:: *)
(*Usage*)


buildKernel::usage = "buildKernel[expr, vars, params] compiles expr into a kernel optimized for root-finding.
vars: the coefficient variables (e.g., {A[0]}) to solve for.
params: the parameter symbols present in expr.
Options: \"CoeffName\" (default \"A\"), \"SignSymbol\" (default \"signA\"), \"PerformanceGoal\" (\"Quality\" | \"Speed\"; Speed uses WVM with OptimizationLevel 0).
Returns an Association with keys: \"fC\", \"dfC\", \"Vars\", \"ParamOrder\", \"SignIndex\", \"CoeffName\", \"SignSymbol\".";
bindUnary::usage   = "bindUnary[kernel, paramValues, signs] specializes the compiled kernel with numeric parameters, returning a pair of functions {f, df}.";
bindUnary::insufficientsigns = "Expected at least `1` sign values, but got `2`.";
bindUnary::toomanyigns = "Expected exactly `1` sign values, but got `2`.";
findRootInterval::usage  = "findRootInterval[conds, paramValues, signs] returns a Reduce expression constraining the root variable.
Pass the result to extractIntervalsFromReduce to obtain numeric intervals.
Options: \"CoeffName\" (default \"A\"), \"SignSymbol\" (default \"signA\").";
extractIntervalsFromReduce::usage = "extractIntervalsFromReduce[reduceExpr, rootVar] converts a Reduce expression into a list of numeric intervals {{a1, b1}, {a2, b2}, ...}.
Options: \"InteriorShrink\" (default 0.001), \"RootUpperBound\" (default 15).";
scanAndSolve::usage = "scanAndSolve[f, {min, max}] finds roots of f[x] in the range by grid subdivision.
scanAndSolve[f, df, {min, max}] uses derivative df for Newton steps.
Options: \"BracketGrid\" (default 32), \"Tolerance\" (default Automatic), \"FastRootOptions\", \"FindRootOptions\".";
fastRoot::usage = "fastRoot[f, spec, opts] finds a root using a hybrid Newton/Brent/Secant strategy.
Spec formats:
  1D: {x0, min, max} full | {min, max} bounds only | x0 start only
  nD: {{x01,min1,max1},...} full | {{min1,max1},...} bounds only | {{x01,x02,...}} start only
Options: Jacobian->df, Method->Automatic, \"SecantBlend\"->0.5, \"Return\"->\"Value\".";
fastRoot::cvmit = "Failed to converge within `1` iterations starting from x0=`2` in bounds [`3`, `4`].";
fastRoot::nnum = "Function returned non-numeric value `1` at x=`2`.";
fastRoot::nobnd = "No bounds specified and FindRoot failed from x0=`1`.";
fastRoot::badbnds = "Invalid bounds: lower bound `1` must be less than upper bound `2`.";
fastRoot::badspec = "Invalid spec format `1`. Expected scalar, {lo, hi}, {x0, lo, hi}, or nested list.";
fastRoot::noautox0 = "Cannot compute automatic starting point without bounds.";
fastRoot::compiled = "Function is a CompiledCodeFunction; Newton+Jacobian unavailable, using fallback.";
fastRoot::baddim = "Inconsistent dimensions in spec: `1`.";
createCompiledEq::usage = "createCompiledEq[model, dir] compiles model equations to dir/{shortname}.mx. Returns file path on success.";
createCompiledEq::cachehit = "cache hit for model `1`; skipping compilation.";
createCompiledEq::compiling = "compiling model `1`; this may take a long time.";
buildEqMapFromModel::usage = "buildEqMapFromModel[model] extracts the equation map from a processed model for use in compilation and hash validation.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*buildKernel*)


buildKernel//Options = {
	"CoeffName" -> "A",
	"SignSymbol" -> "signA",
	"PerformanceGoal" -> "Speed", (* "Speed" | "Quality" *)
	"CompileMode" -> "FunctionOnly",  (* "Both" | "FunctionOnly" | "JacobianOnly" *)
	"Compiler" -> "Compile",  (* "Compile" | "FunctionCompile" - Compile uses C target *)
	"FlattenExpressions" -> Automatic  (* True | False | Automatic (auto at LeafCount > 5000) *)
};

buildKernel::badvars = "Expression contains coefficient variables not listed in vars.";
buildKernel::unusedvars = "Some vars were not found in the expression: `1`.";
buildKernel::badcompilemode = "Invalid CompileMode `1`. Expected \"Both\", \"FunctionOnly\", or \"JacobianOnly\".";


(* fast, robust scalar-args kernel *)
buildKernel[
	expr_,
	vars_List,
	params_List,
	opts : OptionsPattern[{buildKernel, FunctionCompile, Compile}]
] := With[
  {
    coeffName = OptionValue["CoeffName"],
    signSym = OptionValue["SignSymbol"],
    perfGoal = OptionValue["PerformanceGoal"],
    compileMode = OptionValue["CompileMode"],
    compiler = OptionValue["Compiler"]
  },
  Module[
    {ex0, z, zRules, idx, pSyms, sSyms, body, fC, dfC, nP, nS, signHead, compileOpts},

    ex0 = normalizeExp[expr];

    (* deterministic z symbols from provided vars *)
    z     = Array[Unique["z$"] &, Length@vars];
    zRules = AssociationThread[vars -> z];

    (* Replace only expected vars; fail on others *)
    ex0 = Quiet@Check[
      ex0 /. (Rule @@@ Normal@zRules),
      Message[buildKernel::badvars];
      Return[$Failed]
    ];

    (* verify every var was used at least once *)
    unused = Pick[vars, FreeQ[ex0, #] & /@ z];
    If[unused =!= {},
      Message[buildKernel::unusedvars, unused];
      Return[$Failed]
    ];

    (* detect leftover coefficient heads *)
    unexpected = Cases[ex0, s_Symbol /; SymbolName[s] === coeffName, Infinity];
    If[unexpected =!= {},
      Message[buildKernel::badvars];
      Return[$Failed]
    ];

    (* detect indices before any N *)
    idx = signIdxs[ex0, signSym];

   (* create unique simple names *)
    nP = Length@params;  nS = Length@idx;
    pSyms = Array[Unique["p$"]&, nP];
    sSyms = Array[Unique["s$"]&, nS];

    body = ex0 /. Thread[params -> pSyms] /. Abs -> RealAbs; (*replace Abs->RealAbs so that D[body,z] computes*)

    If[nS > 0,
      signHead = First @ Cases[ex0, s_Symbol[_Integer] /; SymbolName[s] === signSym :> s, Infinity, 1];
      body = body /. Thread[(signHead /@ idx) -> sSyms];
    ];

    (* numericize after substitutions *)
    z = Values@zRules;
    body  = N[body, MachinePrecision];

    (* Apply expression flattening if requested - ONLY for FunctionOnly mode *)
    (* D[Inactive[Module][...], x] produces garbage, so cannot flatten for Jacobian *)
    flattenOpt = OptionValue["FlattenExpressions"];
    {flatBody, flatType} = If[
        compileMode === "FunctionOnly",
        With[{lc = LeafCount[body]},
            Switch[flattenOpt,
                True,
                (Print["buildKernel: Flattening expression (LeafCount=", lc, ")"];
                 flattenForCompileBody[body]),
                Automatic,
                If[lc > 5000,
                    (Print["buildKernel: Flattening expression (LeafCount=", lc, ")"];
                     flattenForCompileBody[body]),
                    {body, Automatic}
                ],
                _,
                {body, Automatic}
            ]
        ],
        (* For JacobianOnly or Both: no flattening *)
        {body, Automatic}
    ];

    compileOpts = If[compiler === "FunctionCompile",
      (* FunctionCompile options *)
      Join[
        FilterRules[Flatten@{opts}, Options[FunctionCompile]],
        If[perfGoal === "Speed",
          {CompilerRuntimeErrorAction -> None, CompilerOptions -> {"AbortHandling" -> False, "OptimizationLevel" -> 0}},
          {}
        ]
      ],
      (* Compile options - default to C target *)
      Join[
        FilterRules[Flatten@{opts}, Options[Compile]],
        If[perfGoal === "Speed",
          {CompilationTarget -> "C", RuntimeOptions -> "Speed"},
          {CompilationTarget -> "C"}
        ]
      ]
    ];

    {fC,dfC}=Module[
	    {inferType, convertTypesForCompile, compileWithDiagnostics},
	    (* Infer type by checking if expression is a list structure *)
	    inferType[e_]:=With[
		    {
			    rank=If[ListQ[e], ArrayDepth[e], 0]
		    },
		    If[rank==0,"Real64",TypeSpecifier["PackedArray"]["Real64",rank]]
		];

		(* Convert FunctionCompile type annotations to Compile format *)
		convertTypesForCompile[args_List] := Map[
		  Function[{arg},
		    Which[
		      MatchQ[arg, Typed[_, "Real64"]], {arg[[1]], _Real},
		      MatchQ[arg, Typed[_, "Integer64"]], {arg[[1]], _Integer},
		      MatchQ[arg, Typed[_, TypeSpecifier["PackedArray"]["Real64", _]]],
		        {arg[[1]], _Real, arg[[2, 2]]},
		      True, {arg[[1]], _Real}
		    ]
		  ],
		  args
		];

		(* Wrapper that logs diagnostics and compiles using selected compiler *)
		compileWithDiagnostics[func_, label_String, compOpts_List, useCompiler_String] := Module[
		  {leafCount, byteCount, result, logFile},
		  leafCount = LeafCount[func];
		  byteCount = ByteCount[func];

		  (* Write diagnostic info to file in case of crash - use Export for immediate flush *)
		  logFile = FileNameJoin[{$TemporaryDirectory, "Compile_diagnostic.txt"}];
		  With[{entry = StringJoin[
		      DateString[], " | ", label, " [", useCompiler, "]",
		      " | LeafCount=", ToString[leafCount],
		      " | ByteCount=", ToString[byteCount],
		      " | MemoryInUse=", ToString[Round[MemoryInUse[]/1024^2]], "MB",
		      " | MaxMemoryUsed=", ToString[Round[MaxMemoryUsed[]/1024^2]], "MB\n"
		    ]},
		    (* Append with immediate flush *)
		    With[{stream = OpenAppend[logFile]},
		      WriteString[stream, entry];
		      Close[stream];
		    ];
		  ];

		  (* Use 80% of available memory, with 2GB floor and 32GB cap *)
		  With[{memLimit = Clip[Round[0.8 * MemoryAvailable[]], {2*1024^3, 32*1024^3}]},
		    Print[useCompiler, "[", label, "]: LeafCount=", leafCount, ", ByteCount=", byteCount,
		      ", MemoryInUse=", Round[MemoryInUse[]/1024^2], "MB",
		      ", MemoryLimit=", Round[memLimit/1024^3], "GB"];

		    (* Attempt compilation with MemoryConstrained *)
		    result = MemoryConstrained[
		      If[useCompiler === "FunctionCompile",
		        (* FunctionCompile path *)
		        FunctionCompile[func, Sequence @@ compOpts],
		        (* Compile path - extract args and body from Function, convert types *)
		        With[{
		          funcArgs = func[[1]],
		          funcBody = func[[2]]
		        },
		          Compile[
		            Evaluate @ convertTypesForCompile[Flatten@{funcArgs}],
		            Evaluate @ (funcBody /. TypeHint[e_, _] :> e),
		            Evaluate[Sequence @@ compOpts]
		          ]
		        ]
		      ],
		      memLimit,
		      (Print[useCompiler, "[", label, "]: Memory limit exceeded (", Round[memLimit/1024^3], "GB)"]; $Failed)
		    ];
		  ];

		  If[result === $Failed || FailureQ[result],
		    Print[useCompiler, "[", label, "]: FAILED"];
		    $Failed,
		    Print[useCompiler, "[", label, "]: SUCCESS"];
		    result
		  ]
		];

		With[
			{
				args=Join[
					Flatten[{Thread[Typed[z,"Real64"]]}],
					Table[Typed[pSyms[[i]],"Real64"],{i,nP}],
					Table[Typed[sSyms[[j]],"Integer64"],{j,nS}]
				],
				b=body,
				bType=inferType[body]
			},
			Switch[compileMode,
				"FunctionOnly",
				With[{
					b2 = flatBody,
					bType2 = If[flatType === Automatic, inferType[flatBody], flatType]
				},
					{
						If[MatchQ[Head[b2], Inactive[_]],
							(* Flattened: use Activate pattern *)
							(* Note: Head[Inactive[Module][...]] is Inactive[Module], not Inactive *)
							compileWithDiagnostics[
								Activate[Inactive[Function][args, Inactive[TypeHint][b2, bType2]]],
								"f (function)",
								compileOpts,
								compiler
							],
							(* Not flattened: original path *)
							compileWithDiagnostics[
								Function[Evaluate@args, Evaluate@TypeHint[b2, bType2]],
								"f (function)",
								compileOpts,
								compiler
							]
						],
						Missing["NotCompiled"]
					}
				],
				"JacobianOnly",
				With[{db = N[D[body, {z}], MachinePrecision]},
					With[{dbType = inferType[db]},
						{
							Missing["NotCompiled"],
							compileWithDiagnostics[
								Function[Evaluate@args,Evaluate@TypeHint[db,dbType]],
								"df (jacobian)",
								compileOpts,
								compiler
							]
						}
					]
				],
				"Both",
				With[{db = N[D[body, {z}], MachinePrecision]},
					With[{dbType = inferType[db]},
						{
							compileWithDiagnostics[
								Function[Evaluate@args,Evaluate@TypeHint[b,bType]],
								"f (function)",
								compileOpts,
								compiler
							],
							compileWithDiagnostics[
								Function[Evaluate@args,Evaluate@TypeHint[db,dbType]],
								"df (jacobian)",
								compileOpts,
								compiler
							]
						}
					]
				],
				_, (* invalid CompileMode *)
				Message[buildKernel::badcompilemode, compileMode];
				{$Failed, $Failed}
			]
		]
	];

    <|"fC"->fC, "dfC"->dfC, "Vars"->vars, "ParamOrder"->params, "SignIndex"->idx, "CoeffName"->coeffName, "SignSymbol"->signSym|>
  ]
];


(* ::Subsection:: *)
(*bindUnary*)


(* bind: feed scalars to the scalar-args kernel *)
bindUnary[
	k_Association, 
	paramValues_Association, 
	signs_List:{}
] := Module[
  {paramsj, paramOrder, a, s, idx = k["SignIndex"], maxIdx},
  
  (*if j present as Key in paramValues, find its associated value*)
  paramsj = First[
     KeySelect[paramValues, MatchQ[#, _Symbol] && SymbolName[#] === "j" &], 
     Missing["NotFound"]
  ];
  (*replace j->paramsj in k["ParamOrder"] *)
  paramOrder = If[!MissingQ[paramsj],
     k["ParamOrder"] /. s_Symbol /; SymbolName[s] === "j" -> paramsj,
     k["ParamOrder"] 
 ];

 (*pack parameters and signs*)
 With[
	 {
		 paramValuesNum = N[paramValues//.paramValues,MachinePrecision]
	 },
	  a = Developer`ToPackedArray @ Lookup[paramValuesNum, paramOrder];

	  s = If[idx === {}, {},
	    maxIdx = Max[idx];
	    Which[
	      Length[signs] < maxIdx,
	        Message[bindUnary::insufficientsigns, maxIdx, Length[signs]];
	        $Failed,
	      Length[signs] > maxIdx,
	        Message[bindUnary::toomanyigns, maxIdx, Length[signs]];
	        $Failed,
	      True,
	        Developer`ToPackedArray @ Round @ signs[[idx]]
	    ]
	  ];

	  (* Return early if sign extraction failed *)
	  If[s === $Failed, Return[$Failed, Module]];

	  With[
		  {
			  kfC=k["fC"],kdfC=k["dfC"],suffix=Join[a,s]
		  },
		  {
			  Function[{z},kfC[Sequence@@Join[Flatten@{z},suffix]]],
			  Function[{z},kdfC[Sequence@@Join[Flatten@{z},suffix]]]
		  }
	   ]
   ]
];


(* ::Subsection:: *)
(*findRootInterval*)


findRootInterval::emptyinterval = "There are no real solutions for `1`. Try changing signs `2` or parameters.";
findRootInterval::nocoeff = "Could not locate a root variable for coefficient head `1` in the conditions.";


findRootInterval//Options = {
    "CoeffName" -> "A",
    "SignSymbol" -> "signA"
};


findRootInterval[
	conds_,
	paramValues_Association,
	signs_List : {},
	opts : OptionsPattern[{findRootInterval}]
] := With[
  {
    coeffName = OptionValue["CoeffName"],
    signSym = OptionValue["SignSymbol"]
  },
  Module[
    {condExpr, condNorm, ineq, red, rootVar, signHead,
     signsRule, paramsRules, rootSym, rootRules, rootVarN, ineqRootVar},

    (*normalize form*)
    condExpr = And @@ Flatten[List @ conds];
    condNorm = normalizeExp[condExpr];

    (* Create symbol based on coeffName *)
    rootVar = First[
      Join[
        Cases[condExpr, s_Symbol[0] /; SymbolName[s] === coeffName :> s[0], Infinity],
        Cases[condExpr, s_Symbol[i_][0] /; SymbolName[s] === coeffName :> s[i][0], Infinity]
      ],
      $Failed
    ];
    If[rootVar === $Failed,
      Message[findRootInterval::nocoeff, coeffName];
      Return[$Failed]
    ];

    (*evaluate conditions numerically*)
    signHead = ToExpression[signSym];
    signsRule = If[signs === {}, {}, Table[signHead[i] -> signs[[i]], {i, Length@signs}]];
    paramsRules = paramValues//.paramValues;
    ineq = condNorm //. paramsRules /. signsRule;

    rootSym = Unique["root$"];
    rootVarN = (rootVar//. paramsRules);
    rootRules = rootVarN -> rootSym;
    ineqRootVar=ineq/. rootRules;

    red =  Check[
    Quiet[
      Reduce[ineqRootVar && rootSym > 0, rootSym, Reals],
      Reduce::ratnz (*ignore warning about solving exact system and numericizing the result*)
    ],
      (*try Rationalize if last attempt fails*)
      Reduce[Rationalize[ineqRootVar, 0] && rootSym > 0, rootSym, Reals]
    ];

    If[red === False,
      Message[findRootInterval::emptyinterval, coeffName, signSym];
      Return[$Failed]
    ];

    (*restore original variable names*)
    red = red /. Reverse@rootRules
  ]
];


(* ::Subsection:: *)
(*fastRoot*)


fastRoot // Options = {
  Jacobian        -> None,        (* derivative/Jacobian function *)
  Method          -> Automatic,   (* "Newton" | "Brent" | "Secant" | Automatic *)
  "SecantBlend"   -> 0.5,         (* blend factor for initial guess *)
  "Return"        -> "Value",     (* "Value" | "Rule" *)
  "FindRootOptions" -> Automatic  (* Automatic builds StepMonitor dynamically *)
  (* FindRoot options are accepted via OptionsPattern[{fastRoot, FindRoot}] and
     forwarded using FilterRules[{opts}, Options[FindRoot]] *)
};


(* parseSpec: normalize any valid spec to canonical Association *)
(* Returns <|"dim"->Int, "x0"->val, "lower"->val, "upper"->val|> or $Failed *)

(* 1D scalar start only *)
parseSpec[x0_?NumericQ] := <|"dim" -> 1, "x0" -> N[x0], "lower" -> None, "upper" -> None|>

(* Automatic without bounds - will trigger noautox0 error in main entry point *)
parseSpec[Automatic] := <|"dim" -> 1, "x0" -> Automatic, "lower" -> None, "upper" -> None|>

(* 1D bounds only (2 elements): {lo, hi} *)
parseSpec[{lo_?NumericQ, hi_?NumericQ}] /; hi > lo :=
  <|"dim" -> 1, "x0" -> Automatic, "lower" -> N[lo], "upper" -> N[hi]|>

(* 1D bounds with bad order *)
parseSpec[{lo_?NumericQ, hi_?NumericQ}] /; hi <= lo :=
  (Message[fastRoot::badbnds, lo, hi]; $Failed)

(* 1D full spec (3 elements): {x0, lo, hi} or {Automatic, lo, hi} *)
parseSpec[{x0 : (_?NumericQ | Automatic), lo_?NumericQ, hi_?NumericQ}] /; hi > lo :=
  <|"dim" -> 1, "x0" -> If[x0 === Automatic, Automatic, N[x0]], "lower" -> N[lo], "upper" -> N[hi]|>

(* 1D full spec with bad bounds *)
parseSpec[{x0 : (_?NumericQ | Automatic), lo_?NumericQ, hi_?NumericQ}] /; hi <= lo :=
  (Message[fastRoot::badbnds, lo, hi]; $Failed)

(* nD start only - NESTED SINGLETON {{x0_vec}} *)
parseSpec[{v_?(VectorQ[#, NumericQ] &)}] :=
  <|"dim" -> Length[v], "x0" -> N[v], "lower" -> None, "upper" -> None|>

(* nD bounds only - nested, each inner has {lo, hi} *)
parseSpec[nested : {{_?NumericQ, _?NumericQ} ..}] /; And @@ ((#[[2]] > #[[1]]) & /@ nested) :=
  <|"dim" -> Length[nested], "x0" -> Automatic, "lower" -> N[nested[[All, 1]]], "upper" -> N[nested[[All, 2]]]|>

(* nD bounds with bad order *)
parseSpec[nested : {{_?NumericQ, _?NumericQ} ..}] /; !And @@ ((#[[2]] > #[[1]]) & /@ nested) := Module[
  {badIdx = FirstPosition[nested, {lo_, hi_} /; hi <= lo, {1}, {1}][[1]]},
  Message[fastRoot::badbnds, nested[[badIdx, 1]], nested[[badIdx, 2]]]; $Failed
]

(* nD full spec - nested, each inner has {x0|Automatic, lo, hi} *)
parseSpec[nested : {{(_?NumericQ | Automatic), _?NumericQ, _?NumericQ} ..}] /; And @@ ((#[[3]] > #[[2]]) & /@ nested) :=
  <|
    "dim" -> Length[nested],
    "x0" -> (nested[[All, 1]] /. x_?NumericQ :> N[x]),
    "lower" -> N[nested[[All, 2]]],
    "upper" -> N[nested[[All, 3]]]
  |>

(* nD full spec with bad bounds *)
parseSpec[nested : {{(_?NumericQ | Automatic), _?NumericQ, _?NumericQ} ..}] /; !And @@ ((#[[3]] > #[[2]]) & /@ nested) := Module[
  {badIdx = FirstPosition[nested, {_, lo_, hi_} /; hi <= lo, {1}, {1}][[1]]},
  Message[fastRoot::badbnds, nested[[badIdx, 2]], nested[[badIdx, 3]]]; $Failed
]

(* Catch-all for invalid spec *)
parseSpec[spec_] := (Message[fastRoot::badspec, Short[spec]]; $Failed)


(* computeX0: compute automatic initial guess via secant blend *)
(* For 1D: x0 = blend of midpoint and secant estimate *)
(* For nD: component-wise version *)
computeX0[f_, lo_?NumericQ, hi_?NumericQ, blend_] := Module[
  {fa, fb, mid, secant},
  fa = f[{N@lo}];
  fb = f[{N@hi}];
  mid = (lo + hi) / 2.;
  If[!NumberQ[fa] || !NumberQ[fb], Return[mid]];
  If[Abs[fb - fa] > 1.0*^-10,
    secant = lo - fa * (hi - lo) / (fb - fa);
    Clip[(1. - blend) * mid + blend * secant, {lo, hi}],
    mid
  ]
]

computeX0[f_, lo_?(VectorQ[#, NumericQ] &), hi_?(VectorQ[#, NumericQ] &), blend_] := Module[
  {loN, hiN, fa, fb},
  loN = N[lo]; hiN = N[hi];
  fa = f[loN];
  fb = f[hiN];
  If[!AllTrue[Flatten[{fa}], NumberQ] || !AllTrue[Flatten[{fb}], NumberQ],
    Return[(loN + hiN) / 2.]
  ];
  MapThread[
    Module[{diff = #2 - #1, mid = (#3 + #4) / 2.},
      If[Abs[diff] > 1.0*^-10,
        Clip[(1. - blend) * mid + blend * (#3 - #1 * (#4 - #3) / diff), {#3, #4}],
        mid
      ]
    ] &,
    {fa, fb, loN, hiN}
  ]
]

(* Handle mixed Automatic/numeric x0 for nD *)
computeX0Mixed[f_, x0_List, lo_List, hi_List, blend_] := Module[
  {result, fullAuto},
  (* If all Automatic, compute full secant blend *)
  If[AllTrue[x0, # === Automatic &],
    Return[computeX0[f, lo, hi, blend]]
  ];
  (* Mixed case: compute full auto version, then replace non-Automatic entries *)
  fullAuto = computeX0[f, lo, hi, blend];
  MapThread[If[#1 === Automatic, #2, N[#1]] &, {x0, fullAuto}]
]


(* isCompiledCode: detect both FunctionCompile'd and Compile'd functions *)
isCompiledCode[f_] := MatchQ[f, _CompiledCodeFunction | _CompiledFunction]


(* validateRoot: check if candidate root is valid *)
(* Returns True if residual < tolerance *)
(* Note: bounds are not enforced - they're initialization hints, not constraints *)
(* FindRoot/Secant/Brent can legitimately find roots outside the initial search interval *)
validateRoot[f_, x_, acc_: 8] := Module[
  {xVal, residual, tol},

  (* Extract numeric value from rule list if needed *)
  xVal = If[MatchQ[x, {(_Rule | _RuleDelayed) ..}],
    x[[All, 2]],
    x
  ];

  (* Handle both scalar and vector cases *)
  xVal = If[NumberQ[xVal], {xVal}, Flatten@{xVal}];

  (* Compute residual: |f(x)| for 1D, Max[Abs[f(x)]] for nD *)
  With[{fVal = f[xVal]},
    If[!AllTrue[Flatten@{fVal}, NumberQ],
      Return[False]  (* Non-numeric output means failure *)
    ];
    residual = Max[Abs[Flatten@{fVal}]]
  ];

  (* Tolerance from AccuracyGoal *)
  tol = 10.^(-acc);

  (* Success requires residual < tol *)
  residual < tol
]


(* Method implementations for tryMethods *)

(* 1D Newton with Jacobian *)
tryNewton1D[fnum_, dfnum_, var_, x0_, lb_, ub_, findRootOpts_] := Module[
  {spec, eq},
  spec = If[lb === None, {var, x0}, {var, x0, lb, ub}];
  eq = fnum[var] == 0.;
  Quiet @ Check[
    FindRoot[eq, spec, Method -> "Newton", Jacobian -> dfnum[var],
      Evaluate[Sequence @@ findRootOpts]],
    $Failed
  ]
]

(* nD Newton with Jacobian - requires matrix form *)
tryNewtonND[fnum_, dfnum_, vars_, x0_, lb_, ub_, findRootOpts_] := Module[
  {spec, eq},
  spec = If[lb === None,
    MapThread[{#1, #2} &, {vars, x0}],
    MapThread[{#1, #2, #3, #4} &, {vars, x0, lb, ub}]
  ];
  eq = Thread[fnum[vars] == 0.];
  Quiet @ Check[
    FindRoot[eq, spec, Method -> "Newton", Jacobian -> dfnum[vars],
      Evaluate[Sequence @@ findRootOpts]],
    $Failed
  ]
]

(* 1D Brent (requires bracketed interval) *)
tryBrent1D[fnum_, var_, lb_, ub_, findRootOpts_] :=
  Quiet @ Check[
    FindRoot[fnum[var] == 0., {var, lb, ub}, Method -> "Brent",
      Evaluate[Sequence @@ findRootOpts]],
    $Failed
  ]

(* 1D Secant *)
trySecant1D[fnum_, var_, x0_, lb_, ub_, blend_, findRootOpts_] := Module[
  {x1, x2},
  (* Use blended starting points for Secant *)
  If[lb =!= None,
    x1 = blend * lb + (1 - blend) * x0;
    x2 = blend * ub + (1 - blend) * x0,
    x1 = x0 * 0.9;
    x2 = x0 * 1.1
  ];
  Quiet @ Check[
    FindRoot[fnum[var] == 0., {var, x1, x2}, Method -> "Secant",
      Evaluate[Sequence @@ findRootOpts]],
    $Failed
  ]
]

(* nD optimization fallback: minimize sum of squares *)
tryOptimizationND[fnum_, dfnum_, vars_, x0_, lb_, ub_, hasJacobian_, findRootOpts_] := Module[
  {objective, gradExpr, spec, fmRes, nmRes, acc, tol, constraints},

  acc = AccuracyGoal /. findRootOpts /. AccuracyGoal -> 8;
  tol = 10.^(-acc);

  objective = Total[fnum[vars]^2];
  (* Note: this function is only called when lb =!= None *)
  spec = MapThread[{#1, #2, #3, #4} &, {vars, x0, lb, ub}];

  (* Gradient from Jacobian: d/dx[sum(fi^2)] = 2 * J^T . f *)
  gradExpr = If[hasJacobian,
    2 * Transpose[dfnum[vars]] . fnum[vars],
    Automatic
  ];

  (* Try FindMinimum with InteriorPoint first *)
  fmRes = Quiet @ Check[
    If[hasJacobian && gradExpr =!= Automatic,
      FindMinimum[objective, spec, Method -> "InteriorPoint", Gradient -> gradExpr],
      FindMinimum[objective, spec, Method -> "InteriorPoint"]
    ],
    $Failed
  ];

  If[!FailureQ[fmRes] && fmRes =!= $Failed && fmRes[[1]] < tol^2,
    Return[fmRes[[2]]]  (* Already a rule list *)
  ];

  (* Fallback to NMinimize with explicit constraints *)
  If[lb =!= None,
    constraints = And @@ Cases[
      MapThread[{#1, #2, #3} &, {lb, vars, ub}],
      {lo_, v_, hi_} /; NumberQ[lo] && NumberQ[hi] && lo > -Infinity && hi < Infinity :> lo <= v <= hi
    ];
    nmRes = Quiet @ Check[
      NMinimize[{objective, constraints}, vars,
        Method -> {"NelderMead", "RandomSeed" -> 0}],
      $Failed
    ];
    If[!FailureQ[nmRes] && nmRes =!= $Failed && nmRes[[1]] < tol^2,
      Return[nmRes[[2]]]
    ]
  ];

  $Failed
]

(* Default FindRoot (numerical derivatives) *)
tryDefaultFindRoot[fnum_, var_, vars_, x0_, lb_, ub_, dim_, findRootOpts_] := Module[
  {spec, eq},
  If[dim == 1,
    spec = If[lb === None, {var, x0}, {var, x0, lb, ub}];
    eq = fnum[var] == 0.;
    Quiet @ Check[FindRoot[eq, spec, Evaluate[Sequence @@ findRootOpts]], $Failed],
    spec = If[lb === None,
      MapThread[{#1, #2} &, {vars, x0}],
      MapThread[{#1, #2, #3, #4} &, {vars, x0, lb, ub}]
    ];
    eq = Thread[fnum[vars] == 0.];
    Quiet @ Check[FindRoot[eq, spec, Evaluate[Sequence @@ findRootOpts]], $Failed]
  ]
]

(* tryMethods: try methods in order, validate each result *)
(* Returns first validated success or $Failed *)
tryMethods[methodFuncs_List, f_, acc_] := Module[
  {result, validated},
  Do[
    result = method[];
    If[result =!= $Failed && !FailureQ[result],
      validated = validateRoot[f, result, acc];
      If[validated, Return[result, Module]]
    ],
    {method, methodFuncs}
  ];
  $Failed
]


(* New fastRootCore: unified core implementation *)
(* Takes parsed spec components, returns result in requested format *)
fastRootCoreNew[f_, df_, x0_, lb_, ub_, dim_, opts : OptionsPattern[{fastRoot, FindRoot}]] :=
With[{
  ret = OptionValue["Return"],
  blend = N[OptionValue["SecantBlend"]],
  method = OptionValue[Method],
  frSpec = OptionValue["FindRootOptions"]
},
  Module[{var, vars, fnum, dfnum, hasJacobian, isCompiled, fa, fb, isBracketed,
          frOpts, findRootOpts, acc, methods, res},

    (* Create iteration variables *)
    vars = Table[Unique["x"], dim];
    var = If[dim == 1, vars[[1]], vars];

    (* Numeric wrappers - use Block-local definitions to avoid context issues *)
    fnum = If[dim == 1,
      Function[{x}, f[{x}]],
      Function[{v}, f[v]]
    ];
    dfnum = If[df === None,
      None,
      If[dim == 1,
        Function[{x}, df[{x}]],
        Function[{v}, df[v]]
      ]
    ];

    (* Check Jacobian availability *)
    hasJacobian = (df =!= None && !MissingQ[df]);
    isCompiled = hasJacobian && isCompiledCode[f];

    (* Warn if compiled function with Jacobian - Newton won't work *)
    If[hasJacobian && isCompiled,
      Message[fastRoot::compiled]
    ];

    (* Check for bracketing (1D only) *)
    isBracketed = False;
    If[dim == 1 && lb =!= None,
      fa = f[{N@lb}];
      fb = f[{N@ub}];
      If[NumberQ[fa] && NumberQ[fb],
        isBracketed = (Sign[fa] =!= Sign[fb])
      ]
    ];

    (* Build FindRoot options *)
    frOpts = If[frSpec === Automatic,
      makeFindRootOptions[var, lb, ub],
      If[Head[frSpec] === Function, frSpec[var, lb, ub], frSpec]
    ];
    findRootOpts = DeleteDuplicatesBy[
      Flatten[{
        DeleteCases[FilterRules[Flatten@{opts}, Options[FindRoot]], HoldPattern[Jacobian -> _]],
        frOpts
      }],
      First
    ];
    (* Remove StepMonitor for Brent/Secant - they handle bounds internally *)
    With[{frOptsBrent = DeleteCases[findRootOpts, HoldPattern[StepMonitor -> _] | HoldPattern[StepMonitor :> _]]},

      acc = AccuracyGoal /. findRootOpts /. AccuracyGoal -> 8;

      (* Build method list based on context *)
      methods = Which[
        (* 1D case *)
        dim == 1,
        Join[
          (* Newton first if Jacobian available and not compiled and not forced otherwise *)
          If[hasJacobian && !isCompiled && (method === Automatic || method === "Newton"),
            {Function[tryNewton1D[fnum, dfnum, var, x0, lb, ub, findRootOpts]]},
            {}
          ],
          (* Brent if bracketed (1D with bounds) and method allows it *)
          If[lb =!= None && isBracketed && (method === Automatic || method === "Brent"),
            {Function[tryBrent1D[fnum, var, lb, ub, frOptsBrent]]},
            {}
          ],
          (* Secant if bounds available and not forced to other method *)
          If[lb =!= None && (method === Automatic || method === "Secant"),
            {Function[trySecant1D[fnum, var, x0, lb, ub, blend, frOptsBrent]]},
            {}
          ],
          (* Default FindRoot as fallback *)
          {Function[tryDefaultFindRoot[fnum, var, vars, x0, lb, ub, dim, findRootOpts]]}
        ],

        (* nD case *)
        True,
        Join[
          (* Newton first if Jacobian available and not compiled *)
          If[hasJacobian && !isCompiled && (method === Automatic || method === "Newton"),
            {Function[tryNewtonND[fnum, dfnum, vars, x0, lb, ub, findRootOpts]]},
            {}
          ],
          (* Optimization if bounds available *)
          If[lb =!= None,
            {Function[tryOptimizationND[fnum, dfnum, vars, x0, lb, ub, hasJacobian && !isCompiled, findRootOpts]]},
            {}
          ],
          (* Default FindRoot as fallback *)
          {Function[tryDefaultFindRoot[fnum, var, vars, x0, lb, ub, dim, findRootOpts]]}
        ]
      ];

      (* Try methods with validation *)
      res = tryMethods[methods, f, acc];

      (* Handle failure *)
      If[res === $Failed,
        If[lb === None,
          Message[fastRoot::nobnd, Short[x0]],
          Message[fastRoot::cvmit, MaxIterations /. findRootOpts /. MaxIterations -> 100, Short[x0], Short[lb], Short[ub]]
        ];
        Return[$Failed]
      ];

      (* Format output *)
      Which[
        ret === "Rule",
        res,  (* Already a rule list from FindRoot *)

        ret === "Value" && dim == 1,
        var /. res,

        ret === "Value" && dim > 1,
        vars /. res,

        True,
        res
      ]
    ]
  ]
];


(* ===== NEW SINGLE ENTRY POINT ===== *)

(* Main entry point: fastRoot[f, spec, opts] *)
(* spec formats:
   1D: x0 | {lo, hi} | {x0, lo, hi} | {Automatic, lo, hi}
   nD: {{x01,...}} | {{lo1,hi1},...} | {{x01,lo1,hi1},...}
*)
fastRoot[f_, spec_, opts : OptionsPattern[{fastRoot, FindRoot}]] := Module[
  {parsed, df, x0, lb, ub, dim, blend},

  (* Parse the spec *)
  parsed = parseSpec[spec];
  If[FailureQ[parsed] || parsed === $Failed, Return[$Failed]];

  (* Extract components *)
  {dim, x0, lb, ub} = Lookup[parsed, {"dim", "x0", "lower", "upper"}];
  df = OptionValue[Jacobian];
  blend = N[OptionValue["SecantBlend"]];

  (* Validate: cannot compute automatic x0 without bounds *)
  If[x0 === Automatic && (lb === None || ub === None),
    Message[fastRoot::noautox0];
    Return[$Failed]
  ];
  If[ListQ[x0] && MemberQ[x0, Automatic] && (lb === None || ub === None),
    Message[fastRoot::noautox0];
    Return[$Failed]
  ];

  (* Compute x0 if Automatic *)
  x0 = Which[
    x0 === Automatic && dim == 1,
    computeX0[f, lb, ub, blend],

    x0 === Automatic && dim > 1,
    computeX0[f, lb, ub, blend],

    ListQ[x0] && MemberQ[x0, Automatic],
    computeX0Mixed[f, x0, lb, ub, blend],

    True,
    x0
  ];

  (* Early check: verify function returns numeric values at x0 *)
  With[{fTest = f[If[dim == 1, {x0}, x0]]},
    If[!AllTrue[Flatten@{fTest}, NumberQ],
      Message[fastRoot::nnum, Short[fTest], Short[x0]];
      Return[$Failed]
    ]
  ];

  (* Call core implementation *)
  fastRootCoreNew[f, df, x0, lb, ub, dim, opts]
]


(* Construct FindRoot options with proper StepMonitor for 1D vs nD *)
makeFindRootOptions[var_, None, None] := {AccuracyGoal -> 8, PrecisionGoal -> 8};

makeFindRootOptions[var_, a_?NumericQ, b_?NumericQ] := {
  AccuracyGoal -> 8,
  PrecisionGoal -> 8,
  StepMonitor :> (var = Clip[var, {a, b}])
};

makeFindRootOptions[var_, a_?(VectorQ[#, NumericQ]&), b_?(VectorQ[#, NumericQ]&)] := {
  AccuracyGoal -> 8,
  PrecisionGoal -> 8,
  StepMonitor :> (var = MapThread[Clip[#1, {#2, #3}] &, {var, a, b}])
};


(* ::Subsection:: *)
(*scanAndSolve*)


(* Near-zero on the scan grid counts as a root; Automatic -> 10^-acc *)
scanAndSolve//Options = {
  "BracketGrid" -> 32,
  "Tolerance" -> Automatic,
  "FastRootOptions" -> {},
  "FindRootOptions" -> ("FindRootOptions" /. Options[fastRoot])
};


(* -------- With derivative -------- *)
scanAndSolve[
	f_,
	df_,
	{a_?NumericQ, b_?NumericQ},
	opts : OptionsPattern[{scanAndSolve, FindRoot, fastRoot}]
] /; a < b := With[
  {
    bins = OptionValue["BracketGrid"],
    tolOpt = OptionValue["Tolerance"],
    frSpec = OptionValue["FindRootOptions"],
    var = Unique[x]
  },
	  With[
		  {
		    (* Handle Automatic -> {}, Function -> evaluate, otherwise pass through *)
		    frOpts = Which[
		      frSpec === Automatic, {},
		      Head[frSpec] === Function, frSpec[var, a, b],
		      True, frSpec
		    ]
		  },
		  With[
			  {
			   findRootOpts = DeleteDuplicatesBy[
			      Flatten[{
			        Evaluate @ FilterRules[Flatten@{opts}, Options[FindRoot]],
			        Evaluate @ frOpts
			      }],
			      First
			    ],
			    frFindRootOpts = DeleteDuplicatesBy[
			      Flatten[{
			        Evaluate @ FilterRules[Flatten@{opts}, Options[FindRoot]],
			        "FindRootOptions"  -> (Evaluate @ frSpec)
			      }],
			      First
			    ]
			 },
			 Module[
			    {fnum, dfnum, xs, ys, tol, zeroRoots, signs, ints, roots, fastOpts, acc},
			    (* Get AccuracyGoal, defaulting to 8 if not specified or Automatic *)
			    acc = Replace[
			      AccuracyGoal /. findRootOpts /. AccuracyGoal -> 8,
			      Automatic -> 8
			    ];
			    fastOpts = Flatten[{
			      Evaluate @ FilterRules[Flatten@{opts}, Options[fastRoot]],
			      Evaluate @ frFindRootOpts
			    }];
			    (* fnum/dfnum: wrap scalar in list, pass vector through (consistent with fastRootCore) *)
			    fnum[x_?NumberQ] := f[{x}];
			    fnum[v_?(VectorQ[#, NumberQ]&)] := f[v];
			    dfnum[x_?NumberQ] := df[{x}];
			    dfnum[v_?(VectorQ[#, NumberQ]&)] := df[v];
			
			    xs = N @ Subdivide[a, b, bins];        (* length = bins + 1 *)
			    ys = fnum /@ xs;
			
			    tol = Replace[tolOpt, Automatic -> 10.^(-acc)];
			
			    (* grid hits: use a listable selector *)
			    zeroRoots = Pick[xs, UnitStep[tol - Abs[ys]], 1];
			
			    signs = Sign[ys];
			    (* sign-change subintervals; selector length == bins *)
			    ints  = Pick[Partition[xs, 2, 1], Most[signs]*Rest[signs], -1];
			
			    (* fastRoot returns numeric value directly with default "Return" -> "Value" *)
			    (* New API: fastRoot[f, spec, Jacobian -> df, opts] *)
			    roots = Quiet @ Select[
			      (Quiet @ Check[
			         fastRoot[fnum, #, Jacobian -> dfnum, Sequence @@ fastOpts],
			         $Failed
			       ]) & /@ ints,
			      NumberQ
			    ];
			
			    (* Use With to inject tol value into pure function at definition time *)
			    With[{t = tol},
			      Union[Join[zeroRoots, roots], SameTest -> (Abs[#1 - #2] <= t &)]
			    ]
			](*Module*)
		](*With*)
	](*With*)
](*With*);


(* -------- Without derivative -------- *)
scanAndSolve[
	f_,
	{a_?NumericQ, b_?NumericQ},
	opts : OptionsPattern[{scanAndSolve, FindRoot, fastRoot}]
] /; a < b := With[
  {
    bins = OptionValue["BracketGrid"],
    tolOpt = OptionValue["Tolerance"],
    frSpec = OptionValue["FindRootOptions"]
  },
  With[
    {
      (* Handle Automatic -> {} for FindRootOptions *)
      frOpts = Replace[frSpec, Automatic -> {}]
    },
    With[
      {
        findRootOpts = DeleteDuplicatesBy[
          Flatten[{
            Evaluate @ FilterRules[Flatten@{opts}, Options[FindRoot]],
            Evaluate @ frOpts
          }],
          First
        ]
      },
  Module[
    {fnum, xs, ys, tol, zeroRoots, signs, ints, roots, fastOpts, acc},
    (* Get AccuracyGoal, defaulting to 8 if not specified or Automatic *)
    acc = Replace[
      AccuracyGoal /. findRootOpts /. AccuracyGoal -> 8,
      Automatic -> 8
    ];
    fastOpts = Flatten[{
      Evaluate @ FilterRules[Flatten@{opts}, Options[fastRoot]],
      Evaluate @ OptionValue["FastRootOptions"],
      Evaluate @ findRootOpts
    }];
    (* fnum: wrap scalar in list, pass vector through (consistent with fastRootCore) *)
    fnum[x_?NumberQ] := f[{x}];
    fnum[v_?(VectorQ[#, NumberQ]&)] := f[v];

    xs = N @ Subdivide[a, b, bins];
    ys = fnum /@ xs;

    tol = Replace[tolOpt, Automatic -> 10.^(-acc)];

    zeroRoots = Pick[xs, UnitStep[tol - Abs[ys]], 1];

    signs = Sign[ys];
    ints  = Pick[Partition[xs, 2, 1], Most[signs]*Rest[signs], -1];

    (* fastRoot returns numeric value directly with default "Return" -> "Value" *)
    roots = Quiet @ Select[
      (Quiet @ Check[
         fastRoot[fnum, #, Sequence @@ fastOpts],
         $Failed
       ]) & /@ ints,
      NumberQ
    ];

    (* Use With to inject tol value into pure function at definition time *)
    With[{t = tol},
      Union[Join[zeroRoots, roots], SameTest -> (Abs[#1 - #2] <= t &)]
    ]
  ](*Module*)
    ](*With findRootOpts*)
  ](*With frOpts*)
](*With bins,tolOpt,frSpec*);


(* ::Subsection:: *)
(*Helper functions*)


(* ::Subsubsection:: *)
(*normalizeExp*)


normalizeExp[e_] := e //. {
  Power[E, a_?AtomQ][x_] :> Exp[a[x]],
  Power[E, u_] :> Exp[u]
};


(* ::Subsubsection:: *)
(*flattenForCompileBody*)


(* Ensure PacletizedResourceFunctions is loaded for RecursiveRewrite *)
Once[Needs["PacletizedResourceFunctions`"]];

(* Flatten expression for compilation using RecursiveRewrite *)
(* Returns {Inactive[Module][...], returnType} where returnType preserves ListQ info *)
flattenForCompileBody[expr_] := Module[
    {result, finalVar, rules, paramRules, compRules,
     varMapping, literalMapping, fullMapping,
     localVars, assignments, returnExpr, returnType},

    (* Compute return type from ORIGINAL expression FIRST *)
    (* Must do this before any processing because returnExpr will be a symbol *)
    (* and ListQ[symbol] returns False, causing wrong TypeHint *)
    returnType = With[{rank = If[ListQ[expr], ArrayDepth[expr], 0]},
        If[rank == 0, "Real64", TypeSpecifier["PackedArray"]["Real64", rank]]
    ];

    (* Apply RecursiveRewrite to decompose expression *)
    result = ResourceFunction["RecursiveRewrite"][expr];
    If[!MatchQ[result, {_String, {__RuleDelayed}}],
        Return[{expr, returnType}]
    ];

    {finalVar, rules} = result;

    (* Separate literals (numbers, symbols) from computed expressions *)
    paramRules = Cases[rules, (v_ :> val_) /; FreeQ[val, _String]];
    compRules = Cases[rules, (v_ :> val_) /; !FreeQ[val, _String]];

    (* If no computed rules, return original *)
    If[Length[compRules] == 0, Return[{expr, returnType}]];

    (* Create unique symbols for intermediate variables *)
    varMapping = Association @@ ((#[[1]] -> Unique["t"]) & /@ compRules);
    literalMapping = Association @@ ((#[[1]] -> #[[2]]) & /@ paramRules);
    fullMapping = Join[varMapping, literalMapping];

    localVars = Values[varMapping];

    (* Build assignments using Inactive to prevent evaluation *)
    assignments = Table[
        Inactive[Set][
            varMapping[compRules[[i, 1]]],
            compRules[[i, 2]] /. s_String :> fullMapping[s]
        ],
        {i, Length[compRules]}
    ];

    returnExpr = fullMapping[finalVar];

    (* Return {Inactive Module, type} *)
    {
        Inactive[Module][
            localVars,
            Inactive[CompoundExpression] @@ Append[assignments, returnExpr]
        ],
        returnType
    }
];


(* ::Subsubsection:: *)
(*signIdxs*)


(* match signA[...] regardless of context *)
signIdxs[ex_, sigSym_String] := Sort @ DeleteDuplicates @ Cases[
  ex,
  s_Symbol[i_Integer] /; SymbolName[s] === sigSym :> i,
  Infinity
];


(* ::Subsubsection:: *)
(*extractIntervalsFromReduce*)


extractIntervalsFromReduce::nointervals = "Could not extract any valid intervals from reduced expression `1`.";

extractIntervalsFromReduce // Options = {
  "InteriorShrink" -> 0.001,
  "RootUpperBound" -> 15,
  "UnboundedPad" -> 1.*^5
};

extractIntervalsFromReduce[
	reduceExpr_,
	rootVars_,
	opts : OptionsPattern[{extractIntervalsFromReduce}]
] := With[
  {
    shrink = OptionValue["InteriorShrink"],
    maxBound = OptionValue["RootUpperBound"],
    rootList = Flatten@{rootVars},
    pad = OptionValue["UnboundedPad"]
  },
  Module[
    {lexp, disjuncts, intervals, intervalFromClause, rSym, rExpr},
    If[rootList === {}, Message[extractIntervalsFromReduce::nointervals, reduceExpr]; Return[{}]];

    intervals = Which[
      reduceExpr === False, {},
      reduceExpr === True, {{shrink, maxBound - shrink}},
      True,
        (
          (* Normalize root variable to a simple symbol if needed *)
          rSym = If[MatchQ[First[rootList], _Symbol], First[rootList], Unique["root$"]];
          rExpr = reduceExpr /. First[rootList] -> rSym;

          lexp = LogicalExpand[rExpr];
          disjuncts = If[Head[lexp] === Or, List @@ lexp, {lexp}];

          intervalFromClause[cl_] := Module[{direct, single, lower, upper, lo, hi},
            direct = Cases[cl,
              Inequality[loP_, (Less|LessEqual), rSym, (Less|LessEqual), hiP_] /;
                NumericQ[N@loP] && NumericQ[N@hiP] :> {N@loP, N@hiP},
              {0, Infinity}, Heads -> True
            ];
            If[direct =!= {}, Return[First[direct]]];

            single = Cases[cl,
              Equal[rSym, cP_] /; NumericQ[N@cP] :> {N@cP, N@cP},
              {0, Infinity}, Heads -> True
            ];
            If[single =!= {}, Return[First[single]]];

            lower = Cases[cl,
              (Greater[rSym, loP_] | GreaterEqual[rSym, loP_] |
               Less[loP_, rSym] | LessEqual[loP_, rSym]) /; NumericQ[N@loP] :> N@loP,
              {0, Infinity}, Heads -> True
            ];
            upper = Cases[cl,
              (Less[rSym, hiP_] | LessEqual[rSym, hiP_] |
               Greater[hiP_, rSym] | GreaterEqual[hiP_, rSym]) /; NumericQ[N@hiP] :> N@hiP,
              {0, Infinity}, Heads -> True
            ];

            lo = N[If[lower === {}, 0., Max[lower]], MachinePrecision];
            hi = N[If[upper === {}, maxBound, Min[upper]], MachinePrecision];
            {lo, hi}
          ];

          Select[intervalFromClause /@ disjuncts, NumericQ[#[[1]]] && NumericQ[#[[2]]] &]
        )
    ];

    intervals = Map[
      Function[{interval},
        Module[{lo, hi, width, mid},
          lo = Max[interval[[1]], 0.];
          hi = Min[interval[[2]], maxBound];
          lo = N[lo, MachinePrecision]; hi = N[hi, MachinePrecision];
          If[hi < lo,
            Nothing,
            width = hi - lo;
            Which[
              width <= 2*shrink, mid = (lo + hi)/2.; {mid, mid},  (* single-point or very narrow -> collapse *)
              True, {lo + shrink, hi - shrink}
            ]
          ]
        ]
      ],
      intervals
    ];

    intervals = Select[intervals, #[[1]] <= #[[2]] &];
    intervals = SortBy[intervals, First];

    If[intervals === {},
      Message[extractIntervalsFromReduce::nointervals, reduceExpr];
      Return[{}]
    ];

    (* If more dimensions are requested, pad with wide symmetric bounds for the extra variables *)
    If[Length[rootList] > 1,
      intervals = Map[
        Function[{interval},
          {
            Join[{interval[[1]]}, ConstantArray[-pad, Length[rootList] - 1]],
            Join[{interval[[2]]}, ConstantArray[ pad, Length[rootList] - 1]]
          }
        ],
        intervals
      ]
    ];

    intervals
  ]
];


(* ::Subsection:: *)
(*buildEqMapFromModel*)


(* Extracts equation map from a processed model - used by createCompiledEq and for hash validation *)
buildEqMapFromModel[model_Association] :=
With[{
	quadSol = model["coeffsParamQuadSolve"],
	modelParamsKeys = Keys @ model["params"],
	coeffsSystem = model["coeffsSystem"]
},
With[{
	ddHeads = Apply[Alternatives, Part[FernandoDuarte`LongRunRisk`Model`Parameters`Private`paramList["Real dividend growth"], All, 0]],
	wcSys = coeffsSystem["wc"],
	pdSys = coeffsSystem["pd"],
	quadSolWc = quadSol["wc"],
	quadSolPd = quadSol["pd"]
},
With[{
	(* Extract the actual j symbol from pd coefficients to ensure context consistency *)
	(* pdSys[[2,1]] has form coefpd[j][0], so pdSys[[2,1,0,1]] extracts j *)
	jSymbol = pdSys[[2, 1, 0, 1]],
	pdMode = Lookup[quadSolPd, "pdMode", "B"]
},
With[{
	paramsA = DeleteCases[modelParamsKeys, ddHeads[_]],
	paramsStocks = Cases[modelParamsKeys, x : ddHeads[_] :> Head[x][jSymbol]],
	wcCoeffs = wcSys[[2]],
	wcSignRootMap = Normal @ quadSolWc["SignRootMap"]
},
With[{
	wcCoeffName = SymbolName @ Head @ wcCoeffs[[1]],
	pdCoeffName = SymbolName @ Head @ Head @ pdSys[[2, 1]],
	wcSigns = Keys @ wcSignRootMap,
	pdSigns = Keys @ quadSolPd["SignRootMap"],
	wcVars = quadSolWc["varsA0"],
	pdVars = quadSolPd["varsB0"]
},
	Join[
		<|
			"A" -> <|
				"Expr" -> Map[If[Head[#] === Equal, If[Length[#] == 2, Subtract @@ #, #], #] &, quadSolWc["eqA0"]],
				"Vars" -> wcVars,
				"Params" -> paramsA,
				"CoeffName" -> wcCoeffName,
				"SignSymbol" -> If[wcSigns === {}, "sign" <> SymbolName[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc], SymbolName @ Head @ First @ wcSigns]
			|>
		|>,
		If[MatchQ[pdMode, "B" | "Both"] && KeyExistsQ[quadSolPd, "eqB0"],
			<|
				"B" -> <|
					"Expr" -> Map[If[Head[#] === Equal, If[Length[#] == 2, Subtract @@ #, #], #] &, quadSolPd["eqB0"]],
					"Vars" -> pdVars,
					"Params" -> Join[paramsA, paramsStocks, wcCoeffs],
					"CoeffName" -> pdCoeffName,
					"SignSymbol" -> If[pdSigns === {}, "sign" <> SymbolName[Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd], SymbolName @ Head @ First @ pdSigns]
				|>
			|>,
			<||>
		],
		If[MatchQ[pdMode, "AB" | "Both"] && KeyExistsQ[quadSolPd, "eqAB0"],
			<|
				"AB" -> <|
					"Expr" -> Map[If[Head[#] === Equal, If[Length[#] == 2, Subtract @@ #, #], #] &, quadSolPd["eqAB0"]],
					"Vars" -> pdVars,
					"Params" -> Join[paramsA, paramsStocks, {First @ wcCoeffs}, wcSignRootMap],
					"CoeffName" -> pdCoeffName,
					"SignSymbol" -> If[pdSigns === {}, "sign" <> SymbolName[Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd], SymbolName @ Head @ First @ pdSigns]
				|>
			|>,
			<||>
		]
	]
]]]]]


(* ::Subsection:: *)
(*createCompiledEq*)


(* createCompiledEq inherits "CompileMode" from buildKernel via OptionsPattern *)

createCompiledEq[model_Association, resourcesCompiledDir_String, opts : OptionsPattern[{buildKernel, FunctionCompile, Compile}]] :=
With[{
	shortname = model["shortname"],
	buildKernelOpts = FilterRules[Flatten @ {opts}, Join[Options @ buildKernel, Options @ FunctionCompile, Options @ Compile]],
	compileMode = ("CompileMode" /. Flatten @ {opts}) /. "CompileMode" -> "FunctionOnly",
	compilerChoice = ("Compiler" /. Flatten @ {opts}) /. "Compiler" -> "Compile",
	flattenOpt = ("FlattenExpressions" /. Flatten @ {opts}) /. "FlattenExpressions" -> Automatic,
	pdMode = Lookup[model["coeffsParamQuadSolve"]["pd"], "pdMode", "B"],
	eqMap = buildEqMapFromModel[model]
},
With[{
	fileSuffix = If[compileMode === "JacobianOnly", "_jacobians", ""],
	storageKey = If[compileMode === "JacobianOnly", "jacobians", "kernels"]
},
Module[{kernels, file, currentHash, savedData, savedHash, savedSystemID},
	file = FileNameJoin[{resourcesCompiledDir, shortname <> fileSuffix <> ".mx"}];
	currentHash = Hash[{compileMode, compilerChoice, flattenOpt, pdMode, eqMap}, "Expression"];

	(* check cache *)
	If[FileExistsQ[file],
		savedData = Quiet[Import[file, "MX"]];
		If[AssociationQ[savedData] && KeyExistsQ[savedData, "meta"],
			savedHash = savedData["meta"]["Hash"];
			savedSystemID = savedData["meta"]["SystemID"];
			If[savedHash === currentHash && savedSystemID === $SystemID,
				Message[createCompiledEq::cachehit, shortname];
				Return[file]
			]
		]
	];

	Message[createCompiledEq::compiling, shortname];

	kernels = Association @ Table[
		eq -> buildKernel[
			eqMap[eq]["Expr"],
			eqMap[eq]["Vars"],
			eqMap[eq]["Params"],
			"CoeffName" -> eqMap[eq]["CoeffName"],
			"SignSymbol" -> eqMap[eq]["SignSymbol"],
			Sequence @@ buildKernelOpts
		],
		{eq, Keys @ eqMap}
	];

	Export[file, <|
		storageKey -> kernels,
		"meta" -> <|
			"Version" -> $Version,
			"SystemID" -> $SystemID,
			"Date" -> DateString[],
			"Hash" -> currentHash
		|>
	|>, "MX"]
]]]


(* ::Section:: *)
(*End package*)


End[];


EndPackage[];
