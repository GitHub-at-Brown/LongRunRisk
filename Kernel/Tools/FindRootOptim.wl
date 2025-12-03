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


(* ::Subsubsection:: *)
(*Usage*)


buildKernel::usage = "buildKernel[expr, vars, params] compiles expr into a kernel optimized for root-finding.
vars: the coefficient variables (e.g., {A[0]}) to solve for.
params: the parameter symbols present in expr.
Options: \"CoeffName\" (default \"A\"), \"SignSymbol\" (default \"signA\"), \"PerformanceGoal\" (\"Quality\" | \"Speed\"; Speed uses WVM with OptimizationLevel 0).
Returns an Association with keys: \"fC\", \"dfC\", \"Vars\", \"ParamOrder\", \"SignIndex\", \"CoeffName\", \"SignSymbol\".";
bindUnary::usage   = "bindUnary[kernel, paramValues, signs] specializes the compiled kernel with numeric parameters, returning a pair of functions {f, df}.";
bindUnary::insufficientsigns = "Expected at least `1` sign values, but got `2`.";
findRootInterval::usage  = "findRootInterval[conds, paramValues, signs] returns a Reduce expression constraining the root variable.
Pass the result to extractIntervalsFromReduce to obtain numeric intervals.
Options: \"CoeffName\" (default \"A\"), \"SignSymbol\" (default \"signA\").";
extractIntervalsFromReduce::usage = "extractIntervalsFromReduce[reduceExpr, rootVar] converts a Reduce expression into a list of numeric intervals {{a1, b1}, {a2, b2}, ...}.
Options: \"InteriorShrink\" (default 0.001), \"RootUpperBound\" (default 15).";
scanAndSolve::usage = "scanAndSolve[f, {min, max}] finds roots of f[x] in the range by grid subdivision.
scanAndSolve[f, df, {min, max}] uses derivative df for Newton steps.
Options: \"BracketGrid\" (default 32), \"Tolerance\" (default Automatic), \"FastRootOptions\", \"FindRootOptions\".";
fastRoot::usage = "fastRoot[f, df, {a, b}] finds a root using a hybrid Newton/Brent/Secant strategy.
Calling conventions:
  1D: fastRoot[f, df, {a, b}] bounds, fastRoot[f, df, {x0, a, b}] full spec, fastRoot[f, df, x0] start only
  nD: fastRoot[f, df, {{a1,a2,...}, {b1,b2,...}}] bounds, fastRoot[f, df, {{x0}, {a}, {b}}] full spec, fastRoot[f, df, {{x0_1, x0_2, ...}}] start only (nested list)
  df can be None for derivative-free solving.";
fastRoot::cvmit = "Failed to converge within `1` iterations starting from x0=`2` in bounds [`3`, `4`].";
fastRoot::nnum = "Function returned non-numeric value `1` at x=`2`.";
fastRoot::nobnd = "No bounds specified and FindRoot failed from x0=`1`.";
fastRoot::badbnds = "Invalid bounds: lower bound `1` must be less than upper bound `2`.";
createCompiledEq::usage = "createCompiledEq[model, dir] compiles model equations to dir/{shortname}.mx. Returns file path on success.";
createCompiledEq::cachehit = "cache hit for model `1`; skipping compilation.";
createCompiledEq::compiling = "compiling model `1`; this may take a long time.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*buildKernel*)


buildKernel//Options = {
	"CoeffName" -> "A",
	"SignSymbol" -> "signA",
	"PerformanceGoal" -> "Quality",
	"CompileMode" -> "FunctionOnly"  (* "Both" | "FunctionOnly" | "JacobianOnly" *)
};

buildKernel::badvars = "Expression contains coefficient variables not listed in vars.";
buildKernel::unusedvars = "Some vars were not found in the expression: `1`.";
buildKernel::badcompilemode = "Invalid CompileMode `1`. Expected \"Both\", \"FunctionOnly\", or \"JacobianOnly\".";


(* fast, robust scalar-args kernel *)
buildKernel[
	expr_,
	vars_List,
	params_List,
	opts : OptionsPattern[{buildKernel, FunctionCompile}]
] := With[
  {
    coeffName = OptionValue["CoeffName"],
    signSym = OptionValue["SignSymbol"],
    perfGoal = OptionValue["PerformanceGoal"],
    compileMode = OptionValue["CompileMode"]
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

    compileOpts = Join[
      FilterRules[{opts}, Options[FunctionCompile]],
      If[perfGoal === "Speed",
        {CompilerOptions -> {"AbortHandling" -> False, "OptimizationLevel" -> 0}},
        {}
      ]
    ];

    {fC,dfC}=Module[
	    {inferType, compileWithDiagnostics},
	    (* Infer type by checking if expression is a list structure *)
	    inferType[e_]:=With[
		    {
			    rank=If[ListQ[e], ArrayDepth[e], 0]
		    },
		    If[rank==0,"Real64",TypeSpecifier["PackedArray"]["Real64",rank]]
		];

		(* Wrapper that logs diagnostics before FunctionCompile *)
		compileWithDiagnostics[func_, label_String, compOpts_List] := Module[
		  {leafCount, byteCount, result, logFile},
		  leafCount = LeafCount[func];
		  byteCount = ByteCount[func];

		  (* Write diagnostic info to file in case of crash - use Export for immediate flush *)
		  logFile = FileNameJoin[{$TemporaryDirectory, "FunctionCompile_diagnostic.txt"}];
		  With[{entry = StringJoin[
		      DateString[], " | ", label,
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
		    Print["FunctionCompile[", label, "]: LeafCount=", leafCount, ", ByteCount=", byteCount,
		      ", MemoryInUse=", Round[MemoryInUse[]/1024^2], "MB",
		      ", MemoryLimit=", Round[memLimit/1024^3], "GB"];

		    (* Attempt compilation with MemoryConstrained *)
		    result = MemoryConstrained[
		      FunctionCompile[func, CompilerRuntimeErrorAction -> None, Sequence @@ compOpts],
		      memLimit,
		      (Print["FunctionCompile[", label, "]: Memory limit exceeded (", Round[memLimit/1024^3], "GB)"]; $Failed)
		    ];
		  ];

		  If[result === $Failed || FailureQ[result],
		    Print["FunctionCompile[", label, "]: FAILED"];
		    $Failed,
		    Print["FunctionCompile[", label, "]: SUCCESS"];
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
				{
					compileWithDiagnostics[
						Function[Evaluate@args,Evaluate@TypeHint[b,bType]],
						"f (function)",
						compileOpts
					],
					Missing["NotCompiled"]
				},
				"JacobianOnly",
				With[{db = N[D[body, {z}], MachinePrecision]},
					With[{dbType = inferType[db]},
						{
							Missing["NotCompiled"],
							compileWithDiagnostics[
								Function[Evaluate@args,Evaluate@TypeHint[db,dbType]],
								"df (jacobian)",
								compileOpts
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
								compileOpts
							],
							compileWithDiagnostics[
								Function[Evaluate@args,Evaluate@TypeHint[db,dbType]],
								"df (jacobian)",
								compileOpts
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
	    If[Length[signs] < maxIdx,
	      Message[bindUnary::insufficientsigns, maxIdx, Length[signs]];
	      Return[$Failed]
	    ];
	    Developer`ToPackedArray @ Round @ signs[[idx]]
	  ];
	  
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


fastRoot//Options = {
  "NewtonFirst" -> True,
  "Return" -> "Value",
  "SecantBlend" -> 0.5,
  "FindRootOptions" -> Automatic  (* Automatic builds StepMonitor dynamically; override with explicit list *)
  (* FindRoot options are accepted via OptionsPattern[{fastRoot, FindRoot}] and
     forwarded using FilterRules[{opts}, Options[FindRoot]] *)
};


scalarOrVectorQ[x_] := NumberQ[x] || VectorQ[x, NumberQ];


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


(* Entry point 1: 1D bounds {a, b} - both scalars *)
fastRoot[f_, df_, {a_?NumericQ, b_?NumericQ}, opts : OptionsPattern[{fastRoot, FindRoot}]] /; (b > a) :=
  Module[{x0, fa, fb, lambda = N[OptionValue["SecantBlend"]]},
    fa = f[{N@a}];
    fb = f[{N@b}];
    If[!NumberQ[fa], Message[fastRoot::nnum, Short[fa], a]; Return[$Failed]];
    If[!NumberQ[fb], Message[fastRoot::nnum, Short[fb], b]; Return[$Failed]];
    x0 = If[
      Abs[fb - fa] > 1.0*^-10,
      Clip[(1. - lambda) * (a + b)/2. + lambda * (a - fa * (b - a)/(fb - fa)), {a, b}],
      (a + b)/2.
    ];
    fastRootCore[f, df, x0, a, b, opts]
  ];

(* Catch reversed 1D bounds - must come before nD x0 pattern *)
fastRoot[f_, df_, {a_?NumericQ, b_?NumericQ}, opts : OptionsPattern[{fastRoot, FindRoot}]] /; (b <= a) :=
  (Message[fastRoot::badbnds, a, b]; $Failed);


(* Entry point 2: nD bounds {a, b} - both numeric vectors of same length *)
(* Component-wise secant blend, falling back to midpoint where fb-fa is too small *)
fastRoot[f_, df_, {a_?(VectorQ[#, NumericQ]&), b_?(VectorQ[#, NumericQ]&)}, opts : OptionsPattern[{fastRoot, FindRoot}]] /; (Length[a] == Length[b] && Min[b - a] > 0) :=
  Module[{x0, fa, fb, lambda = N[OptionValue["SecantBlend"]], aN, bN},
    aN = N[a]; bN = N[b];
    fa = f[aN];
    fb = f[bN];
    If[!AllTrue[Flatten[{fa}], NumberQ], Message[fastRoot::nnum, Short[fa], Short[a]]; Return[$Failed]];
    If[!AllTrue[Flatten[{fb}], NumberQ], Message[fastRoot::nnum, Short[fb], Short[b]]; Return[$Failed]];
    (* Component-wise: use secant blend if |fb-fa| > tol, else midpoint *)
    x0 = MapThread[
      Module[{diff = #2 - #1, mid = (#3 + #4)/2.},
        If[Abs[diff] > 1.0*^-10,
          Clip[(1. - lambda) * mid + lambda * (#3 - #1 * (#4 - #3) / diff), {#3, #4}],
          mid
        ]
      ] &,
      {fa, fb, aN, bN}
    ];
    fastRootCore[f, df, x0, aN, bN, opts]
  ];


(* Entry point 3: 1D full spec {x0, a, b} - all scalars *)
fastRoot[f_, df_, {x0_?NumericQ, a_?NumericQ, b_?NumericQ}, opts : OptionsPattern[{fastRoot, FindRoot}]] /; (b > a) :=
  fastRootCore[f, df, x0, a, b, opts];


(* Entry point 4: nD full spec {x0, a, b} - all numeric vectors of same length *)
fastRoot[f_, df_, {x0_?(VectorQ[#, NumericQ]&), a_?(VectorQ[#, NumericQ]&), b_?(VectorQ[#, NumericQ]&)}, opts : OptionsPattern[{fastRoot, FindRoot}]] /; (Length[x0] == Length[a] == Length[b] && Min[b - a] > 0) :=
  fastRootCore[f, df, x0, a, b, opts];


(* Entry point 5: x0 only - scalar (1D) *)
fastRoot[f_, df_, x0_?NumericQ, opts : OptionsPattern[{fastRoot, FindRoot}]] :=
  fastRootCore[f, df, x0, None, None, opts];


(* Entry point 6: x0 only - numeric vector (nD), wrapped in extra list to disambiguate from 1D bounds *)
(* Use {{x0_1, x0_2, ...}} syntax to distinguish from {a, b} for 1D bounds *)
fastRoot[f_, df_, {x0_?(VectorQ[#, NumericQ]&)}, opts : OptionsPattern[{fastRoot, FindRoot}]] :=
  fastRootCore[f, df, x0, None, None, opts];


(* Core implementation handling both 1D and nD *)
fastRootCore[f_, df_, x0_, lb_, ub_, opts : OptionsPattern[{fastRoot, FindRoot}]] :=
With[{
  newtonFirst = OptionValue["NewtonFirst"],
  ret = OptionValue["Return"],
  lambda = OptionValue["SecantBlend"],
  frSpec = OptionValue["FindRootOptions"]
},
  Module[{var, dim, vars, frOpts, findRootOpts, spec, newtonRes, res, hasJacobian, fTest, fa, fb, fnum, dfnum},

    (* Determine dimensionality from x0 *)
    dim = If[NumberQ[x0], 1, Length[x0]];
    vars = If[dim == 1, {Unique["x"]}, Table[Unique["x"], dim]];
    var = If[dim == 1, vars[[1]], vars];

    (* Numeric wrappers to prevent symbolic evaluation - defined once for all branches *)
    fnum[x_?NumberQ] := f[{x}];  (* 1D: wrap scalar in list *)
    fnum[v_?(VectorQ[#, NumberQ]&)] := f[v];  (* nD: pass vector directly *)
    dfnum[x_?NumberQ] := df[{x}];  (* 1D: wrap scalar in list *)
    dfnum[v_?(VectorQ[#, NumberQ]&)] := df[v];  (* nD: pass vector directly *)

    (* Early check: verify function returns numeric values at x0 *)
    fTest = f[If[dim == 1, {x0}, x0]];
    If[!AllTrue[Flatten[{fTest}], NumberQ],
      Message[fastRoot::nnum, Short[fTest], Short[x0]];
      Return[$Failed]
    ];

    (* For 1D with bounds, get function values at boundaries for Brent/Secant decision *)
    If[dim == 1 && lb =!= None,
      fa = f[{N@lb}];
      fb = f[{N@ub}];
    ];

    (* Build FindRoot options with proper StepMonitor *)
    frOpts = If[frSpec === Automatic,
      makeFindRootOptions[var, lb, ub],
      If[Head[frSpec] === Function, frSpec[var, lb, ub], frSpec]
    ];

    findRootOpts = DeleteDuplicatesBy[
      Flatten[{FilterRules[Flatten@{opts}, Options[FindRoot]], frOpts}],
      First
    ];

    (* Build variable spec for FindRoot *)
    spec = If[dim == 1,
      If[lb === None, {var, x0}, {var, x0, lb, ub}],
      (* nD: build {{x1, x01}, ...} or {{x1, x01, a1, b1}, ...} *)
      If[lb === None,
        MapThread[{#1, #2} &, {vars, x0}],
        MapThread[{#1, #2, #3, #4} &, {vars, x0, lb, ub}]
      ]
    ];

    (* Check if Jacobian is available *)
    hasJacobian = (df =!= None && !MissingQ[df]);

    (* Newton attempt - pass Jacobian as numeric function *)
    newtonRes = If[TrueQ@newtonFirst && hasJacobian,
      With[{
        s = spec, fo = findRootOpts, dfn = dfnum,
        eq = If[dim == 1, fnum[var] == 0., Thread[fnum[vars] == 0.]]
      },
        Quiet@Check[
          FindRoot[eq, s, Method -> "Newton", Jacobian -> dfn, Evaluate[Sequence @@ fo]],
          $Failed
        ]
      ],
      $Failed
    ];

    (* Fallback strategy *)
    res = If[!FailureQ[newtonRes] && newtonRes =!= $Failed,
      newtonRes,
      (* 1D with bounds: Brent if bracketed, Secant otherwise *)
      If[dim == 1 && lb =!= None,
        Module[{frOptsBrent},
          (* For Brent/Secant fallback, use simpler options without StepMonitor
             since these methods handle bounds internally *)
          frOptsBrent = DeleteCases[findRootOpts, HoldPattern[StepMonitor -> _] | HoldPattern[StepMonitor :> _]];
          If[Sign[fa] =!= Sign[fb],
            (* Bracketed: use Brent *)
            Quiet@Check[
              FindRoot[fnum[var] == 0., {var, lb, ub}, Method -> "Brent",
                Evaluate[Sequence @@ frOptsBrent]],
              $Failed
            ],
            (* Not bracketed: use Secant with blended starting points *)
            Quiet@Check[
              FindRoot[fnum[var] == 0., {var, lambda*lb + (1-lambda)*x0, lambda*ub + (1-lambda)*x0},
                Method -> "Secant", Evaluate[Sequence @@ frOptsBrent]],
              $Failed
            ]
          ]
        ],
        (* nD WITH bounds: use optimization-based fallback *)
        If[dim > 1 && lb =!= None,
          Module[{objective, constraints, fmRes, nmRes, gradFunc, acc, tol},
            (* Extract AccuracyGoal for tolerance *)
            acc = AccuracyGoal /. findRootOpts /. AccuracyGoal -> 8;
            tol = 10.^(-acc);

            (* Minimize sum of squared residuals *)
            objective = Total[fnum[vars]^2];

            (* Gradient from Jacobian: d/dx[sum(fi^2)] = 2 * J^T . f *)
            (* Computed numerically using dfnum *)
            gradFunc = If[hasJacobian,
              Function[v, 2 * Transpose[dfnum[v]] . fnum[v]],
              Automatic
            ];

            (* Try FindMinimum with InteriorPoint first *)
            fmRes = Quiet@Check[
              If[hasJacobian,
                FindMinimum[objective, spec, Method -> "InteriorPoint", Gradient -> gradFunc],
                FindMinimum[objective, spec, Method -> "InteriorPoint"]
              ],
              $Failed
            ];

            (* If FindMinimum succeeded and residual is small, return as rule list *)
            If[!FailureQ[fmRes] && fmRes =!= $Failed && fmRes[[1]] < tol^2,
              fmRes[[2]],  (* Already a rule list {x1 -> val1, x2 -> val2, ...} *)

              (* Fallback to NMinimize with explicit constraints *)
              (* Skip infinite bounds to avoid -Infinity <= x becoming True or failing *)
              constraints = And @@ Cases[
                MapThread[{#1, #2, #3} &, {lb, vars, ub}],
                {lo_, v_, hi_} /; NumberQ[lo] && NumberQ[hi] && lo > -Infinity && hi < Infinity :> lo <= v <= hi
              ];
              nmRes = Quiet@Check[
                NMinimize[{objective, constraints}, vars,
                  Method -> {"NelderMead", "RandomSeed" -> 0}],
                $Failed
              ];

              If[!FailureQ[nmRes] && nmRes =!= $Failed && nmRes[[1]] < tol^2,
                nmRes[[2]],  (* Already a rule list *)
                $Failed  (* Both methods failed *)
              ]
            ]
          ],

          (* nD without bounds OR 1D: use default FindRoot *)
          If[dim == 1,
            With[{sv = spec, fo = findRootOpts, eq = (fnum[var] == 0.)},
              Quiet@Check[FindRoot[eq, sv, Evaluate[Sequence @@ fo]], $Failed]
            ],
            With[{sv = spec, fo = findRootOpts, eq = Thread[fnum[vars] == 0.]},
              Quiet@Check[FindRoot[eq, sv, Evaluate[Sequence @@ fo]], $Failed]
            ]
          ]
        ]
      ]
    ];

    (* Return result with informative message on failure *)
    If[res === $Failed || FailureQ[res],
      If[lb === None,
        Message[fastRoot::nobnd, Short[x0]],
        Message[fastRoot::cvmit, MaxIterations /. findRootOpts /. MaxIterations -> 100, Short[x0], Short[lb], Short[ub]]
      ];
      $Failed,
      If[ret === "Value", var /. res, res]
    ]
  ]
];


(* Positional convenience overloads *)
fastRoot[f_, df_, {a_?NumericQ, b_?NumericQ}, acc_Integer?NonNegative] :=
  fastRoot[f, df, {a, b}, AccuracyGoal -> acc, PrecisionGoal -> acc];

fastRoot[f_, df_, {a_?NumericQ, b_?NumericQ}, acc_Integer?NonNegative, maxit_Integer?Positive] :=
  fastRoot[f, df, {a, b}, AccuracyGoal -> acc, PrecisionGoal -> acc, MaxIterations -> maxit];


(* No-derivative versions: 1D bounds *)
fastRoot[f_, {a_?NumericQ, b_?NumericQ}, opts : OptionsPattern[{fastRoot, FindRoot}]] /; (b > a) :=
  fastRoot[f, None, {a, b}, opts];

fastRoot[f_, {a_?NumericQ, b_?NumericQ}, opts : OptionsPattern[{fastRoot, FindRoot}]] /; (b <= a) :=
  (Message[fastRoot::badbnds, a, b]; $Failed);

(* No-derivative versions: nD bounds *)
fastRoot[f_, {a_?(VectorQ[#, NumericQ]&), b_?(VectorQ[#, NumericQ]&)}, opts : OptionsPattern[{fastRoot, FindRoot}]] /; (Length[a] == Length[b] && Min[b - a] > 0) :=
  fastRoot[f, None, {a, b}, opts];

(* No-derivative versions: 1D full spec *)
fastRoot[f_, {x0_?NumericQ, a_?NumericQ, b_?NumericQ}, opts : OptionsPattern[{fastRoot, FindRoot}]] /; (b > a) :=
  fastRoot[f, None, {x0, a, b}, opts];

(* No-derivative versions: nD full spec *)
fastRoot[f_, {x0_?(VectorQ[#, NumericQ]&), a_?(VectorQ[#, NumericQ]&), b_?(VectorQ[#, NumericQ]&)}, opts : OptionsPattern[{fastRoot, FindRoot}]] /; (Length[x0] == Length[a] == Length[b] && Min[b - a] > 0) :=
  fastRoot[f, None, {x0, a, b}, opts];

(* No-derivative versions: x0 only - scalar *)
fastRoot[f_, x0_?NumericQ, opts : OptionsPattern[{fastRoot, FindRoot}]] :=
  fastRoot[f, None, x0, opts];

(* No-derivative versions: x0 only - vector (nested list syntax) *)
fastRoot[f_, {x0_?(VectorQ[#, NumericQ]&)}, opts : OptionsPattern[{fastRoot, FindRoot}]] :=
  fastRoot[f, None, {x0}, opts]; 


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
			    acc = Replace[
			      AccuracyGoal /. findRootOpts,
			      AccuracyGoal -> (AccuracyGoal /. Options[FindRoot])
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
			    roots = Quiet @ Select[
			      (Quiet @ Check[
			         fastRoot[fnum, dfnum, #, Sequence @@ fastOpts],
			         $Failed
			       ]) & /@ ints,
			      NumberQ
			    ];
			
			    Union[Join[zeroRoots, roots], SameTest -> (Abs[#1 - #2] <= tol &)]
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
    {ff = f, fnum, xs, ys, tol, zeroRoots, signs, ints, roots, fastOpts, acc},
    acc = Replace[
      AccuracyGoal /. findRootOpts,
      AccuracyGoal -> (AccuracyGoal /. Options[FindRoot])
    ];
    fastOpts = Flatten[{
      Evaluate @ FilterRules[Flatten@{opts}, Options[fastRoot]],
      Evaluate @ OptionValue["FastRootOptions"],
      Evaluate @ findRootOpts
    }];
    (* fnum: wrap scalar in list, pass vector through (consistent with fastRootCore) *)
    fnum[x_?NumberQ] := ff[{x}];
    fnum[v_?(VectorQ[#, NumberQ]&)] := ff[v];

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

    Union[Join[zeroRoots, roots], SameTest -> (Abs[#1 - #2] <= tol &)]
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

extractIntervalsFromReduce[reduceExpr_, rootVars_, opts : OptionsPattern[{extractIntervalsFromReduce}]] := With[
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
(*createCompiledEq*)


(* createCompiledEq inherits "CompileMode" from buildKernel via OptionsPattern *)

createCompiledEq[model_Association, resourcesCompiledDir_String, opts : OptionsPattern[{buildKernel, FunctionCompile}]] :=
With[{
	quadSol = model["coeffsParamQuadSolve"],
	modelParamsKeys = Keys @ model["params"],
	shortname = model["shortname"],
	buildKernelOpts = FilterRules[Flatten @ {opts}, Join[Options @ buildKernel, Options @ FunctionCompile]],
	coeffsSystem = model["coeffsSystem"],
	compileMode = ("CompileMode" /. Flatten @ {opts}) /. "CompileMode" -> "FunctionOnly"
},
With[{
	fileSuffix = If[compileMode === "JacobianOnly", "_jacobians", ""],
	storageKey = If[compileMode === "JacobianOnly", "jacobians", "kernels"]
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
	jSymbol = pdSys[[2, 1, 0, 1]]
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
With[{
	eqMap = <|
		"A" -> <|
			"Expr" -> Map[If[Head[#] === Equal, If[Length[#] == 2, Subtract @@ #, #], #] &, quadSolWc["eqA0"]],
			"Vars" -> wcVars,
			"Params" -> paramsA,
			"CoeffName" -> wcCoeffName,
			"SignSymbol" -> If[wcSigns === {}, "sign" <> SymbolName[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc], SymbolName @ Head @ First @ wcSigns]
		|>,
		"B" -> <|
			"Expr" -> Map[If[Head[#] === Equal, If[Length[#] == 2, Subtract @@ #, #], #] &, quadSolPd["eqB0"]],
			"Vars" -> pdVars,
			"Params" -> Join[paramsA, paramsStocks, wcCoeffs],
			"CoeffName" -> pdCoeffName,
			"SignSymbol" -> If[pdSigns === {}, "sign" <> SymbolName[Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd], SymbolName @ Head @ First @ pdSigns]
		|>,
		"AB" -> <|
			"Expr" -> Map[If[Head[#] === Equal, If[Length[#] == 2, Subtract @@ #, #], #] &, quadSolPd["eqAB0"]],
			"Vars" -> pdVars,
			"Params" -> Join[paramsA, paramsStocks, {First @ wcCoeffs}, wcSignRootMap],
			"CoeffName" -> pdCoeffName,
			"SignSymbol" -> If[pdSigns === {}, "sign" <> SymbolName[Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd], SymbolName @ Head @ First @ pdSigns]
		|>
	|>
},
Module[{kernels, file, currentHash, savedData, savedHash, savedSystemID},
	file = FileNameJoin[{resourcesCompiledDir, shortname <> fileSuffix <> ".mx"}];
	currentHash = Hash[{compileMode, eqMap}, "Expression"];

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
]
]]]]]]]


(* ::Section:: *)
(*End package*)


End[];


EndPackage[];
