(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


(* ::Subsection:: *)
(*Public symbols*)


buildKernel
bindUnary
findRootInterval
findRootsCoeff0
extractIntervalsFromReduce
findRootCoeff0
scanAndSolve
fastRoot


(* ::Subsubsection:: *)
(*Usage*)


buildKernel::usage = "buildKernel[expr, params] compiles expr into a C-kernel optimized for root-finding with respect to A[0] (or specified \"CoeffName\").";
bindUnary::usage   = "bindUnary[kernel, paramValues, signs] specializes the compiled kernel with numeric parameters, returning a pair of functions {f, df}.";
bindUnary::insufficientsigns = "Expected at least `1` sign values, but got `2`.";
findRootInterval::usage  = "findRootInterval[conds, paramValues, signs] determines the search interval Interval[{min, max}] for the root variable based on constraints.";
extractIntervalsFromReduce::usage = "extractIntervalsFromReduce[reduceExpr, rootVar] converts a Reduce expression into a list of numeric intervals {{a1, b1}, {a2, b2}, ...}.";
findRootCoeff0::usage  = "findRootCoeff0[expr, params, assumptions, conds, paramValues, signs] finds a single root of expr == 0.\nReturns a rule A[0] -> value.";
findRootsCoeff0::usage = "findRootsCoeff0[expr, params, assumptions, conds, paramValues, signs] finds all roots of expr == 0 in the valid interval.";
scanAndSolve::usage = "scanAndSolve[f, {min, max}] finds roots of f[x] in the range by grid subdivision.\nscanAndSolve[f, df, {min, max}] uses derivative df for Newton steps.";
fastRoot::usage = "fastRoot[f, df, {a, b}] finds a root using a hybrid Newton/Brent/Secant strategy.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*buildKernel*)


buildKernel//Options = {
	"CompilationTarget" -> "C",
	"CoeffName" -> "A",
	"SignSymbol" -> "signA"
};


(* fast, robust scalar-args kernel *)
buildKernel[
	expr_,
	params_List,
	opts : OptionsPattern[{buildKernel}]
] := With[
  {
    tgt = OptionValue["CompilationTarget"],
    coeffName = OptionValue["CoeffName"],
    signSym = OptionValue["SignSymbol"]
  },
  Module[
    {ex0, z, idx, pSyms, sSyms, body, dbody, fC, dfC, nP, nS, signHead},

    ex0 = normalizeExp[expr];
    z   = Unique["z"];

    (* Replace A[0] or B[j][0] with z, regardless of context *)
    ex0 = ex0 /. {
      (s_Symbol[j_][0] /; SymbolName[s] === coeffName) :> z,
      (s_Symbol[0] /; SymbolName[s] === coeffName) :> z
    };

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
    body  = N[body, MachinePrecision];
    dbody = N[D[body, z], MachinePrecision];

    With[{
      args = Join[
        {{z, _Real}},
        Table[{pSyms[[i]], _Real}, {i, nP}],
        Table[{sSyms[[j]], _Integer}, {j, nS}]
      ],
      b = body,
      db = dbody,
      tgt2 = tgt
    },
      fC = Compile[
        Evaluate@args,
        Evaluate@b,
        CompilationTarget -> tgt2,
        RuntimeOptions -> {"Speed", "EvaluateSymbolically" -> False,
                          "CatchMachineUnderflow" -> True, "CatchMachineOverflow" -> True},
        CompilationOptions -> {
          "ExpressionOptimization" -> True,
          "InlineExternalDefinitions" -> True,
          "InlineCompiledFunctions" -> True
        }
      ];
      dfC = Compile[
        Evaluate@args,
        Evaluate@db,
        CompilationTarget -> tgt2,
        RuntimeOptions -> {"Speed", "EvaluateSymbolically" -> False,
                          "CatchMachineUnderflow" -> True, "CatchMachineOverflow" -> True},
        CompilationOptions -> {
          "ExpressionOptimization" -> True,
          "InlineExternalDefinitions" -> True,
          "InlineCompiledFunctions" -> True
        }
      ];
    ];

    <|"fC"->fC, "dfC"->dfC, "ParamOrder"->params, "SignIndex"->idx, "CoeffName"->coeffName, "SignSymbol"->signSym|>
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
  If[!MissingQ[paramsj],
    paramOrder = k["ParamOrder"] /. s_Symbol /; SymbolName[s] === "j" -> paramsj,
    paramOrder = k["ParamOrder"] 
 ];

 (*pack parameters and signs*)
  a = Developer`ToPackedArray @ N[Lookup[paramValues, paramOrder], MachinePrecision];

  s = If[idx === {}, {},
    maxIdx = Max[idx];
    If[Length[signs] < maxIdx,
      Message[bindUnary::insufficientsigns, maxIdx, Length[signs]];
      Return[$Failed]
    ];
    Developer`ToPackedArray @ Round @ signs[[idx]]
  ];

  {
    Function[{z}, k["fC"][Sequence @@ Join[{z}, a, s]]],
    Function[{z}, k["dfC"][Sequence @@ Join[{z}, a, s]]]
  }
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
    paramsRules = Normal@paramValues;
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
(*findRootCoeff0*)


findRootCoeff0::badparams = "Parameter values violate the supplied assumptions.";

findRootCoeff0//Options = {
  "CompilationTarget" -> "C",
  "CoeffName" -> "A",
  "SignSymbol" -> "signA",
  "FindRootOptions" -> {AccuracyGoal -> 8, PrecisionGoal -> 8},
  "FastRootOptions" -> {},
  "ExtractIntervalsOptions" -> {}
};


findRootCoeff0[
  expr_,
  params_List,
  assumptions_,
  conds_,
  paramValues_Association,
  signs_List : {},
  opts : OptionsPattern[{findRootCoeff0, FindRoot, fastRoot, extractIntervalsFromReduce}]
] := With[
  {
    tgt = OptionValue["CompilationTarget"],
    coeffName = OptionValue["CoeffName"],
    signSym = OptionValue["SignSymbol"],
    fastRootOpts = DeleteDuplicatesBy[
      Flatten[{
      Evaluate @ FilterRules[Flatten@{opts}, Options[fastRoot]],
      Evaluate @ FilterRules[Flatten@{opts}, Options[FindRoot]],
      Evaluate @ OptionValue["FastRootOptions"],
      Evaluate @ OptionValue["FindRootOptions"]
      }],
      First
    ],
    extractOpts = Flatten[{
      Evaluate @ FilterRules[Flatten@{opts}, Options[extractIntervalsFromReduce]],
      Evaluate @ OptionValue["ExtractIntervalsOptions"]
    }]
  },
  Module[
    {kernel, f, df, reduceExpr, intervals, rootSym, rootVal},

    (* Validate parameters *)
    If[!paramValidQ[assumptions, paramValues, coeffName],
      Message[findRootCoeff0::badparams];
      Return[$Failed]
    ];

    (* Get reduced constraints from findRootInterval *)
    reduceExpr = findRootInterval[conds, paramValues, signs,
      "CoeffName" -> coeffName, "SignSymbol" -> signSym];
    If[reduceExpr === False || reduceExpr === $Failed, Return[$Failed]];

    (* Determine root variable symbol *)
    rootSym = Module[{paramsj},
      paramsj = First[
        KeySelect[paramValues, MatchQ[#, _Symbol] && SymbolName[#] === "j" &],
        Missing["NotFound"]
      ];
      If[!MissingQ[paramsj],
        ToExpression[coeffName][paramsj][0],
        ToExpression[coeffName][0]
      ]
    ];

    (* Extract intervals from Reduce output *)
    intervals = extractIntervalsFromReduce[reduceExpr, rootSym, Sequence @@ extractOpts];
    If[intervals === $Failed || intervals === {}, Return[$Failed]];

    (* Build compiled kernel and bind to numeric values *)
    kernel = buildKernel[expr, params, "CompilationTarget" -> tgt,
      "CoeffName" -> coeffName, "SignSymbol" -> signSym];


    {f, df} = bindUnary[kernel, paramValues, signs];

    If[f === $Failed || df === $Failed, Return[$Failed]];

    (* Find first root across all intervals *)
    rootVal = findFirstRootInIntervals[f, df, intervals, Sequence @@ fastRootOpts];

    If[rootVal =!= $Failed, rootSym -> rootVal, $Failed]
  ]
];



(* ::Subsection:: *)
(*fastRoot*)


fastRoot//Options = {
  "NewtonFirst" -> True,          (* try Newton with df before fallback *)
  "Return" -> "Rule",             (* "Rule" | "Value" *)
  "FindRootOptions" -> {AccuracyGoal -> 8, PrecisionGoal -> 8}         (* Additional FindRoot options bundle *)
};


(*explicit f, df*)
fastRoot[
	f_,
	df_,
	{a_?NumericQ, b_?NumericQ},
  opts : OptionsPattern[{fastRoot, FindRoot}]
] /; a < b := With[
  {
    ret = OptionValue["Return"],
    newtonFirst = OptionValue["NewtonFirst"],
    findRootOpts = DeleteDuplicatesBy[
      Flatten[{
        Evaluate @ FilterRules[Flatten@{opts}, Options[FindRoot]],
        Evaluate @ OptionValue["FindRootOptions"]
      }],
      First
    ]
  },
  Module[
    {ff = f, dff = df, fnum, dfnum, fa, fb, x0, bracketedQ, res, newtonRes, maxit},

    maxit = Replace[
      MaxIterations /. findRootOpts,
      MaxIterations -> (MaxIterations /. Options[FindRoot])
    ];

    (* numeric-only wrappers *)
    fnum[x_?NumericQ]  := ff[x];
    dfnum[x_?NumericQ] := dff[x];

    fa = fnum[N@a]; fb = fnum[N@b];
    If[!(NumericQ[fa] && NumericQ[fb]), Return[$Failed]];
    bracketedQ = Sign[fa] =!= Sign[fb];

    (* regula-falsi seed, else midpoint *)
    x0 = If[Abs[fb - fa] > 1.0*^-10, a - fa (b - a)/(fb - fa), (a + b)/2.];

    (* Newton attempt (bounded to [a,b]) using your derivative *)
    newtonRes = If[TrueQ@newtonFirst,
      Quiet@Check[
        FindRoot[
          fnum[x] == 0.,
          {x, x0, a, b},
          Method -> "Newton",
          Jacobian -> {{dfnum[x]}},      (* explicit 1\[Times]1 Jacobian *)
          Evaluate[Sequence @@ findRootOpts]
        ],
        $Failed
      ],
      $Failed
    ];

    (* Fallback: Brent if bracketed; otherwise Secant *)
    res = If[newtonRes =!= $Failed, newtonRes,
      Quiet@Check[
        If[bracketedQ,
          FindRoot[
            fnum[x] == 0., {x, a, b},
            Method -> "Brent",
            Evaluate[Sequence @@ findRootOpts]
          ],
          FindRoot[
            fnum[x] == 0., {x, a, b},
            Method -> "Secant",
            Evaluate[Sequence @@ findRootOpts]
          ]
        ],
        $Failed
      ]
    ];

    If[res === $Failed, $Failed, If[ret === "Value", x /. res, res]]
  ]
];

(*positional convenience, same as before*)
fastRoot[f_, df_, {a_?NumericQ, b_?NumericQ}, acc_Integer?NonNegative] :=
  fastRoot[f, df, {a, b}, AccuracyGoal -> acc, PrecisionGoal -> acc];

fastRoot[f_, df_, {a_?NumericQ, b_?NumericQ}, acc_Integer?NonNegative, maxit_Integer?Positive] :=
  fastRoot[f, df, {a, b}, AccuracyGoal -> acc, PrecisionGoal -> acc, MaxIterations -> maxit];

(*optional: bracket-only version without df*)
fastRoot[f_, {a_?NumericQ, b_?NumericQ}, opts : OptionsPattern[{fastRoot, FindRoot}]] /; a < b := With[
  {
    findRootOpts = Flatten[{
      Evaluate @ FilterRules[Flatten@{opts}, Options[FindRoot]],
      Evaluate @ OptionValue["FindRootOptions"]
    }]
  },
  Module[
    {ff = f, fnum, fa, fb, bracket},
    fnum[x_?NumericQ] := ff[x];
    fa = fnum[N@a]; fb = fnum[N@b]; bracket = NumericQ[fa] && NumericQ[fb] && Sign[fa] =!= Sign[fb];
    If[bracket,
      FindRoot[fnum[x] == 0., {x, a, b}, Method -> "Brent", Evaluate[Sequence @@ findRootOpts]],
      FindRoot[fnum[x] == 0., {x, a, b}, Method -> "Secant", Evaluate[Sequence @@ findRootOpts]]
    ]
  ]
];


(* ::Subsection:: *)
(*findRootsCoeff0*)


findRootsCoeff0::badparams = "Parameter values violate the supplied assumptions.";

findRootsCoeff0//Options = {
  "CompilationTarget" -> "C",
  "CoeffName" -> "A",
  "SignSymbol" -> "signA",
  "FindRootOptions" -> {AccuracyGoal -> 8, PrecisionGoal -> 8},
  "ScanAndSolveOptions" -> {},
  "ExtractIntervalsOptions" -> {}
};


findRootsCoeff0[
  expr_,
  params_List,
  assumptions_,
  conds_,
  paramValues_Association,
  signs_List : {},
  opts : OptionsPattern[{findRootsCoeff0, FindRoot, scanAndSolve, extractIntervalsFromReduce}]
] := With[
  {
    tgt = OptionValue["CompilationTarget"],
    coeffName = OptionValue["CoeffName"],
    signSym = OptionValue["SignSymbol"],
    scanOpts = DeleteDuplicatesBy[
      Flatten[{
      Evaluate @ FilterRules[Flatten@{opts}, Options[scanAndSolve]],
      Evaluate @ FilterRules[Flatten@{opts}, Options[FindRoot]],
      Evaluate @ OptionValue["ScanAndSolveOptions"],
      Evaluate @ OptionValue["FindRootOptions"]
      }],
      First
    ],
    extractOpts = Flatten[{
      Evaluate @ FilterRules[Flatten@{opts}, Options[extractIntervalsFromReduce]],
      Evaluate @ OptionValue["ExtractIntervalsOptions"]
    }]
  },
  Module[
    {kernel, f, df, reduceExpr, intervals, rootSym, rootVals},

    (* Validate parameters *)
    If[!paramValidQ[assumptions, paramValues, coeffName],
      Message[findRootsCoeff0::badparams];
      Return[{}]
    ];

    (* Get reduced constraints from findRootInterval *)
    reduceExpr = findRootInterval[conds, paramValues, signs,
      "CoeffName" -> coeffName, "SignSymbol" -> signSym];
    If[reduceExpr === False || reduceExpr === $Failed, Return[{}]];

    (* Determine root variable symbol *)
    rootSym = Module[{paramsj},
      paramsj = First[
        KeySelect[paramValues, MatchQ[#, _Symbol] && SymbolName[#] === "j" &],
        Missing["NotFound"]
      ];
      If[!MissingQ[paramsj],
        ToExpression[coeffName][paramsj][0],
        ToExpression[coeffName][0]
      ]
    ];

    (* Extract intervals from Reduce output *)
    intervals = extractIntervalsFromReduce[reduceExpr, rootSym, Sequence @@ extractOpts];
    If[intervals === $Failed || intervals === {}, Return[{}]];

    (* Build compiled kernel and bind to numeric values *)
    kernel = buildKernel[expr, params, "CompilationTarget" -> tgt,
      "CoeffName" -> coeffName, "SignSymbol" -> signSym];
    {f, df} = bindUnary[kernel, paramValues, signs];
    If[f === $Failed || df === $Failed, Return[{}]];

    (* Find all roots across all intervals *)
    rootVals = findAllRootsInIntervals[f, df, intervals, Sequence @@ scanOpts];

    (* Return as list of rules *)
    (rootSym -> #) & /@ rootVals
  ]
];


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
    findRootOpts = DeleteDuplicatesBy[
      Flatten[{
        Evaluate @ FilterRules[Flatten@{opts}, Options[FindRoot]],
        Evaluate @ OptionValue["FindRootOptions"]
      }],
      First
    ]
  },
  Module[
    {ff = f, dff = df, fnum, dfnum, xs, ys, tol, zeroRoots, signs, ints, roots, fastOpts, acc},
    acc = Replace[
      AccuracyGoal /. findRootOpts,
      AccuracyGoal -> (AccuracyGoal /. Options[FindRoot])
    ];
    fastOpts = Flatten[{
      Evaluate @ FilterRules[Flatten@{opts}, Options[fastRoot]],
      Evaluate @ OptionValue["FastRootOptions"],
      Evaluate @ findRootOpts
    }];
    fnum[x_?NumericQ]  := ff[x];
    dfnum[x_?NumericQ] := dff[x];

    xs = N @ Subdivide[a, b, bins];        (* length = bins + 1 *)
    ys = fnum /@ xs;

    tol = Replace[tolOpt, Automatic -> 10.^(-acc)];

    (* grid hits: use a listable selector *)
    zeroRoots = Pick[xs, UnitStep[tol - Abs[ys]], 1];

    signs = Sign[ys];
    (* sign-change subintervals; selector length == bins *)
    ints  = Pick[Partition[xs, 2, 1], Most[signs]*Rest[signs], -1];

    roots = Quiet @ Select[
      (Quiet @ Check[
         x /. fastRoot[fnum, dfnum, #, Sequence @@ fastOpts],
                       $Failed
       ]) & /@ ints,
      NumericQ
    ];

    Union[Join[zeroRoots, roots], SameTest -> (Abs[#1 - #2] <= tol &)]
  ]
];


(* -------- Without derivative -------- *)
scanAndSolve[
	f_,
	{a_?NumericQ, b_?NumericQ},
	opts : OptionsPattern[{scanAndSolve, FindRoot, fastRoot}]
] /; a < b := With[
  {
    bins = OptionValue["BracketGrid"],
    tolOpt = OptionValue["Tolerance"],
    findRootOpts = DeleteDuplicatesBy[
      Flatten[{
        Evaluate @ FilterRules[Flatten@{opts}, Options[FindRoot]],
        Evaluate @ OptionValue["FindRootOptions"]
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
    fnum[x_?NumericQ] := ff[x];

    xs = N @ Subdivide[a, b, bins];
    ys = fnum /@ xs;

    tol = Replace[tolOpt, Automatic -> 10.^(-acc)];

    zeroRoots = Pick[xs, UnitStep[tol - Abs[ys]], 1];

    signs = Sign[ys];
    ints  = Pick[Partition[xs, 2, 1], Most[signs]*Rest[signs], -1];

    roots = Quiet @ Select[
      (Quiet @ Check[
         x /. fastRoot[fnum, #, Sequence @@ fastOpts],
                       $Failed
       ]) & /@ ints,
      NumericQ
    ];

    Union[Join[zeroRoots, roots], SameTest -> (Abs[#1 - #2] <= tol &)]
  ]
];


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
(*paramValidQ*)


paramValidQ[assumptions_, paramValues_Association, coeffName_String:"A"] := Module[
  {assP = assumptions //. paramValues, only, rootHead, rootFreeQ, parts, rootClauses, rootFree},
  Which[
    assP === True, Return[True],
    assP === False, Return[False]
  ];
  rootHead  = SymbolName @ ToExpression[coeffName];
  rootFreeQ = FreeQ[#, s_Symbol /; SymbolName[s] === rootHead] &;
  parts = If[MatchQ[assP, _And | _Or], List @@ assP, {assP}];
  rootClauses = Select[parts, Not@*rootFreeQ];
  If[rootClauses =!= {} && TrueQ[Simplify[And @@ rootClauses] === False], Return[False]];
  only  = Select[parts, rootFreeQ];
  If[only === {}, Return[True]];
  rootFree = Simplify[And @@ only];
  If[rootFree === False, False, True]
];


(* ::Subsubsection:: *)
(*signFlipPairsNumericSubseq*)


signFlipPairsNumericSubseq[list_List] := Module[{pos, s, k},
  pos = Flatten@Position[list, _?NumericQ, {1}];
  s   = Sign[list[[pos]]];
  k   = Flatten @ Position[Partition[s, 2, 1], {a_, b_} /; a b < 0];
  Transpose @ {pos[[k]], pos[[k + 1]]}   (* pairs {i, i+1} in the original list indexing *)
];


(* ::Subsubsection:: *)
(*extractIntervalsFromReduce*)


extractIntervalsFromReduce::nointervals = "Could not extract any valid intervals from reduced expression `1`.";

extractIntervalsFromReduce // Options = {
  "InteriorShrink" -> 0.001,
  "RootUpperBound" -> 15
};

extractIntervalsFromReduce[reduceExpr_, rootVar_, opts : OptionsPattern[{extractIntervalsFromReduce}]] := With[
  {
    shrink = OptionValue["InteriorShrink"],
    maxBound = OptionValue["RootUpperBound"]
  },
  Module[
    {lexp, disjuncts, intervals, intervalFromClause, rSym, rExpr},

    Which[
      reduceExpr === False, Return[{}],
      reduceExpr === True, Return[{{shrink, maxBound - shrink}}]
    ];

    (* Normalize root variable to a simple symbol if needed *)
    rSym = If[MatchQ[rootVar, _Symbol], rootVar, Unique["root$"]];
    rExpr = reduceExpr /. rootVar -> rSym;

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

    intervals = intervalFromClause /@ disjuncts;
    intervals = Select[intervals, NumericQ[#[[1]]] && NumericQ[#[[2]]] &];

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

    intervals
  ]
];


(* ::Subsubsection:: *)
(*findFirstRootInIntervals*)


findFirstRootInIntervals // Options = {
  "FastRootOptions" -> {},
  "FindRootOptions" -> ("FindRootOptions" /. Options[fastRoot])
};

findFirstRootInIntervals[f_, df_, intervals_List, opts : OptionsPattern[{findFirstRootInIntervals, FindRoot, fastRoot}]] := With[
  {
    findRootOpts = DeleteDuplicatesBy[
      Flatten[{
        Evaluate @ FilterRules[Flatten@{opts}, Options[FindRoot]],
        Evaluate @ OptionValue["FindRootOptions"]
      }],
      First
    ]
  },
  Module[
    {result, tol, fastOpts, acc},

    acc = Replace[
      AccuracyGoal /. findRootOpts,
      AccuracyGoal -> (AccuracyGoal /. Options[FindRoot])
    ];

    fastOpts = Flatten[{
      Evaluate @ FilterRules[Flatten@{opts}, Options[fastRoot]],
      Evaluate @ OptionValue["FastRootOptions"],
      Evaluate @ findRootOpts
    }];

    tol = 10.^(-acc);

    Do[
      (* Handle single-point intervals *)
      If[interval[[1]] == interval[[2]],
        If[Abs[f[interval[[1]]]] < tol, Return[interval[[1]], Module]];
        Continue[]
      ];

      (* Normal interval - use fastRoot *)
      result = Quiet@Check[
        fastRoot[f, df, interval, Sequence @@ fastOpts],
        $Failed
      ];

      result = First@Flatten@{result /. Rule[_, v_] :> v};

      If[result =!= $Failed && NumericQ[result], Return[result, Module]],
      {interval, intervals}
    ];

    $Failed
  ]
];


(* ::Subsubsection:: *)
(*findAllRootsInIntervals*)


findAllRootsInIntervals // Options = {
  "ScanAndSolveOptions" -> {},
  "FindRootOptions" -> ("FindRootOptions" /. Options[scanAndSolve])
};

findAllRootsInIntervals[f_, df_, intervals_List, opts : OptionsPattern[{findAllRootsInIntervals, FindRoot, scanAndSolve}]] := With[
  {
    findRootOpts = DeleteDuplicatesBy[
      Flatten[{
      Evaluate @ FilterRules[Flatten@{opts}, Options[FindRoot]],
      Evaluate @ OptionValue["FindRootOptions"]
      }],
      First
    ]
  },
  Module[
    {allRoots = {}, roots, tol, scanOpts, acc},

    acc = Replace[
      AccuracyGoal /. findRootOpts,
      AccuracyGoal -> (AccuracyGoal /. Options[FindRoot])
    ];

    scanOpts = Flatten[{
      Evaluate @ FilterRules[Flatten@{opts}, Options[scanAndSolve]],
      Evaluate @ OptionValue["ScanAndSolveOptions"],
      Evaluate @ findRootOpts
    }];

    tol = 10.^(-acc);

    Do[
      (* Handle single-point intervals *)
      If[interval[[1]] == interval[[2]],
        If[Abs[f[interval[[1]]]] < tol,
          AppendTo[allRoots, interval[[1]]]
        ];
        Continue[]
      ];

      (* Normal interval - use scanAndSolve *)
      roots = Quiet@Check[
        scanAndSolve[f, df, interval, Sequence @@ scanOpts],
        {}
      ];

      allRoots = Join[allRoots, roots],
      {interval, intervals}
    ];

    (* Deduplicate roots at interval boundaries *)
    Union[allRoots, SameTest -> (Abs[#1 - #2] <= tol &)]
  ]
];


(* ::Section:: *)
(*End package*)


End[];


EndPackage[];
