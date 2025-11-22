(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


(* ::Subsection:: *)
(*Public symbols*)


BuildKernel
BindUnary
A0Interval
FindRootA0
FindRootsA0
scanAndSolve
fastRoot


(* ::Subsubsection:: *)
(*Usage*)


BuildKernel::usage = "BuildKernel[expr, params] compiles expr into a C-kernel optimized for root-finding with respect to A[0] (or specified \"CoeffName\").";
BindUnary::usage   = "BindUnary[kernel, paramValues, signs] specializes the compiled kernel with numeric parameters, returning a pair of functions {f, df}.";
A0Interval::usage  = "A0Interval[conds, paramValues, signs] determines the search interval Interval[{min, max}] for the root variable based on constraints.";
FindRootA0::usage  = "FindRootA0[expr, params, assumptions, conds, paramValues, signs] finds a single root of expr == 0.\nReturns a rule A[0] -> value.";
FindRootsA0::usage = "FindRootsA0[expr, params, assumptions, conds, paramValues, signs] finds all roots of expr == 0 in the valid interval.";
scanAndSolve::usage = "scanAndSolve[f, {min, max}] finds roots of f[x] in the range by grid subdivision.\nscanAndSolve[f, df, {min, max}] uses derivative df for Newton steps.";
fastRoot::usage = "fastRoot[f, df, {a, b}] finds a root using a hybrid Newton/Brent/Secant strategy.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*BuildKernel*)


BuildKernel//Options = {
	CompilationTarget -> "C",
	"CoeffName" -> "A",
	"SignSymbol" -> "signA"
};


(* fast, robust scalar-args kernel *)
BuildKernel[
	expr_, 
	params_List, 
	OptionsPattern[]
] := Module[
  {
    tgt = OptionValue[CompilationTarget],
    coeffName = OptionValue["CoeffName"],
    signSym = OptionValue["SignSymbol"],
    ex0, z, idx, pSyms, sSyms, body, dbody, fC, dfC, nP, nS, signHead
  },

  ex0 = normalizeExp[expr];                             (* no N here *)
  z   = Unique["z"];

  (* A[0] -> z, context-agnostic *)
  ex0 = ex0 /. (s_Symbol[j_][0] /; SymbolName[s] === coeffName) :> z /. (s_Symbol[0] /; SymbolName[s] === coeffName) :> z;

  (* detect indices before any N *)
  idx = signIdxs[ex0, signSym];

  nP = Length@params;  nS = Length@idx;
  pSyms = Array[Unique["p$"]&, nP];
  sSyms = Array[Unique["s$"]&, nS];

  body = ex0 /. Thread[params -> pSyms];

  If[nS > 0,
    signHead = First @ Cases[ex0, s_Symbol[_Integer] /; SymbolName[s] === signSym :> s, Infinity, 1];
    body = body /. Thread[(signHead /@ idx) -> sSyms];
  ];

  body  = N[body, MachinePrecision];                   (* numericize after substitutions *)
  dbody = N[D[body, z], MachinePrecision];

    With[{args = Join[
                  {{z, _Real}},
                  Table[{pSyms[[i]], _Real},    {i, nP}],  (*signA in params is Integer*)
                  Table[{sSyms[[j]], _Integer}, {j, nS}]
                ], 
         b = body, db = dbody, tgt2 = tgt},
    fC = Compile[ Evaluate@args, Evaluate@b,
          CompilationTarget -> tgt2,
          RuntimeOptions    -> {"Speed", "EvaluateSymbolically"->False, "CatchMachineUnderflow"->True, "CatchMachineOverflow"->True},
          CompilationOptions -> {
            "ExpressionOptimization"->True,
            "InlineExternalDefinitions"->True,
            "InlineCompiledFunctions"->True
          }];

    dfC = Compile[ Evaluate@args, Evaluate@db,
          CompilationTarget -> tgt2,
          RuntimeOptions    -> {"Speed", "EvaluateSymbolically"->False, "CatchMachineUnderflow"->True, "CatchMachineOverflow"->True},
          CompilationOptions -> {
            "ExpressionOptimization"->True,
            "InlineExternalDefinitions"->True,
            "InlineCompiledFunctions"->True
          }];
  ];

  <|"fC"->fC, "dfC"->dfC, "ParamOrder"->params, "SignIndex"->idx, "CoeffName"->coeffName, "SignSymbol"->signSym|>
];


(* ::Subsection:: *)
(*BindUnary*)


(* bind: feed scalars to the scalar-args kernel *)
BindUnary[
	k_Association, 
	paramValues_Association, 
	signs_List:{}
] := Module[
  {paramsj, paramOrder, a, s, idx = k["SignIndex"], maxIdx},
  
  paramsj = First[
     KeySelect[paramValues, MatchQ[#, _Symbol] && SymbolName[#] === "j" &], 
     Missing["NotFound"]
  ];
  If[!MissingQ[paramsj],
    paramOrder = k["ParamOrder"] /. s_Symbol /; SymbolName[s] === "j" -> paramsj,
    paramOrder = k["ParamOrder"] 
 ];

  a = Developer`ToPackedArray @ N[Lookup[paramValues, paramOrder], MachinePrecision];
  s = If[idx === {}, {},
    maxIdx = Max[idx];
    If[Length[signs] < maxIdx, Return[$Failed]];
    Developer`ToPackedArray @ Round @ signs[[idx]]
  ];
  {
    Function[{z}, k["fC"][Sequence @@ Join[{z}, a, s]]],
    Function[{z}, k["dfC"][Sequence @@ Join[{z}, a, s]]]
  }
];


(* ::Subsection:: *)
(*A0Interval*)


A0Interval::emptyinterval = "There are no real solutions for `1`. Try changing signs `2` or parameters.";


A0Interval//Options = {
    "CoeffName" -> "A",
    "SignSymbol" -> "signA"
};


A0Interval[
	conds_, 
	paramValues_Association, 
	signs_List:{}, 
	OptionsPattern[]
] := Module[
  {coeffName = OptionValue["CoeffName"], signSym = OptionValue["SignSymbol"],
   condExpr, ineq, red, lexp, ints = {}, lb, ub, l, u, best, rootVar, signHead,
   signsRule, paramsRules, rootSym, rootRules, rootVarN, ineqRootVar},

  condExpr = And @@ Flatten[List @ conds];

  (* Create the root variable symbol dynamically based on coeffName *)
  rootVar = First[
    Join[
      Cases[condExpr, s_Symbol[0] /; SymbolName[s] === coeffName :> s[0], Infinity],
      Cases[condExpr, s_Symbol[i_][0] /; SymbolName[s] === coeffName :> s[i][0], Infinity]
    ],
    $Failed
  ];
  If[rootVar === $Failed,
    If[coeffName === "A",
      rootVar = ToExpression["A"][0],
      Return[$Failed]
    ]
  ];
  signHead = ToExpression[signSym];
  paramsRules = Normal@paramValues;

  (* fast path for equalities on the root variable *)
  If[
  MatchQ[
     condExpr, 
     Equal[s_Symbol[___][0], c_?NumericQ] /; SymbolName[s] === coeffName
  ],
    Return[With[{c = N @ Last[conds]},
      Interval[{Max[0., c], c}]
    ]]
  ];
 MatchQ[
     condExpr, 
     Equal[s_Symbol[___][0], c_?NumericQ] /; SymbolName[s] === coeffName
  ];

 signsRule = If[signs === {}, {}, Table[signHead[i] -> signs[[i]], {i, Length@signs}]];

 ineq = normalizeExp[condExpr] //. paramsRules /. signsRule;
  

  rootSym = Unique["root$"];
  rootVarN = (rootVar//. paramsRules);
    rootRules = rootVarN -> rootSym;
    ineqRootVar=ineq/. rootRules;


  red =  Check[
 Quiet[
    Reduce[ineqRootVar && rootSym > 0, rootSym, Reals],
    Reduce::ratnz
 ],
 Reduce[Rationalize[ineqRootVar, 0] && rootSym > 0, rootSym, Reals]
 ];
  red = red /. Reverse@rootRules;
If[red === False,Message[A0Interval::emptyinterval,rootVarN,Keys@signsRule];Return[$Failed]];
lexp = LogicalExpand @ red;
  ints = Join[
    Cases[lexp, Inequality[lo_, (Less|LessEqual), rootVarN, (Less|LessEqual), hi_] :> Interval[{N@lo, N@hi}], Infinity],
    Cases[lexp, Equal[rootVarN, c_] :> Interval[{N@c, N@c}], Infinity]
  ];
    If[ints === {},
    lb = Cases[lexp,
          (Less[lo_, rootVar] | LessEqual[lo_, rootVar] | Greater[rootVar, lo_] | GreaterEqual[rootVar, lo_]) :> N@lo,
          Infinity];
    ub = Cases[lexp,
          (Less[rootVar, hi_] | LessEqual[rootVar, hi_] | Greater[hi_, rootVar] | GreaterEqual[hi_, rootVar]) :> N@hi,
          Infinity];
    If[lb =!= {} && ub =!= {},
      l = Max@lb; u = Min@ub;
      If[NumericQ[l] && NumericQ[u] && l <= u, ints = {Interval[{l, u}]}];
    ];
  ];
  If[ints === {},
    ints = Cases[
      normalizeExp[conds],
      Equal[s_Symbol[___][0], c_?NumericQ] /; SymbolName[s] === coeffName :> Interval[{N@c, N@c}],
      Infinity
    ];
  ];
  If[ints === {},
    With[{vals = Cases[normalizeExp[conds], c_?NumericQ, Infinity]},
      If[vals =!= {},
        ints = {Interval[{Max[0., Min@vals], Max@vals}]}
      ];
    ];
  ];

  If[ints === {}, Return[$Failed]];
  best = First @ SortBy[
      ints,
      -((With[{seg = First @ List @@ #}, Last[seg] - First[seg]]) &)
  ];
  best /. Interval[{l_, u_}] :> Interval[{Max[0., l], u}]

];


(* ::Subsection:: *)
(*FindRootA0*)


FindRootA0//Options = Join[
  Options[FindRoot],
  {
    CompilationTarget -> "C",
    "CoeffName" -> "A",
    "SignSymbol" -> "signA",
    "BracketGrid" -> 32,
    "Seeds" -> Automatic
  }
];


FindRootA0[
  expr_,
  params_List,
  assumptions_,
  conds_,
  paramValues_Association,
  signs_List:{},
  opts:OptionsPattern[]
] := Module[
  {tgt = OptionValue[CompilationTarget],
   coeffName = OptionValue["CoeffName"],
   signSym = OptionValue["SignSymbol"],
   grid = OptionValue["BracketGrid"],
   seeds = OptionValue["Seeds"],
   findRootOpts = FilterRules[{opts}, Options[FindRoot]],
   K, f, fN, df, iv, L, U, Lint, Uint, shrink, span, xs, xsInt, ys, pairs, p, z, res, rootSym, tol, fLeft, fRight},

  If[!paramValidQ[assumptions, paramValues, coeffName], Return[$Failed]];

  iv = A0Interval[conds, paramValues, signs, "CoeffName" -> coeffName, "SignSymbol" -> signSym];
  If[iv === $Failed, Return[$Failed]];
  {L, U} = {Min@iv, Max@iv};
  span = Max[Abs[U - L], 1.];
  shrink = Max[10.^-12, 1000. $MachineEpsilon*span];
  shrink = If[U > L, Min[shrink, (U - L)/10.], shrink];
  Lint = L + shrink;
  Uint = U - shrink;
  If[Lint >= Uint,
    Lint = L + (U - L)/4.;
    Uint = U - (U - L)/4.;
    If[Lint >= Uint, Lint = Uint = (L + U)/2.]
  ];

  K = BuildKernel[expr, params, CompilationTarget -> tgt, "CoeffName" -> coeffName, "SignSymbol" -> signSym];
  {f, df} = BindUnary[K, paramValues, signs];
  If[f === $Failed || df === $Failed, Return[$Failed]];

  rootSym = ToExpression[coeffName];
  fN[z_?NumericQ] := Module[{x = N[z, MachinePrecision]},
    If[x <= Lint || x >= Uint, Indeterminate, f[x]]
  ];
  tol = 10.^(-OptionValue[AccuracyGoal]);
  If[L === U, Return[rootSym[0] -> L]];
  fLeft  = Quiet@Check[f[N[Lint, MachinePrecision]], Indeterminate];
  fRight = Quiet@Check[f[N[Uint, MachinePrecision]], Indeterminate];
  If[NumericQ[fLeft] && Abs[fLeft] <= tol, Return[rootSym[0] -> Lint]];
  If[NumericQ[fRight] && Abs[fRight] <= tol, Return[rootSym[0] -> Uint]];

  Which[
    MatchQ[seeds, {_?NumericQ, _?NumericQ}],
      p = N@seeds;
      res = Quiet @ Check[
        First @ FindRoot[fN[z], {z, p[[1]], p[[2]]}, Evaluate[Sequence @@ findRootOpts]],
        $Failed
      ],
    NumericQ[seeds],
      res = Quiet @ Check[
        First @ FindRoot[fN[z], {z, N@seeds, Lint, Uint}, Evaluate[Sequence @@ findRootOpts]],
        $Failed
      ],
    True,
      If[L === U,
        res = If[NumericQ[fN[L]] && Abs[fN[L]] <= tol,
          {z -> L},
          Quiet @ Check[FindRoot[fN[z], {z, L}, Evaluate[Sequence @@ findRootOpts]], $Failed]
        ],
        xs    = N[Subdivide[Lint, Uint, grid + 2], MachinePrecision];
        xsInt = xs[[2 ;; -2]];
        ys    = f /@ xsInt;
        pairs = xsInt[[#]] & /@ signFlipPairsNumericSubseq[ys];
        If[pairs === {}, Return[$Failed]];
        p = First@pairs;
        res = Quiet @ Check[
          First @ FindRoot[fN[z], {z, p[[1]], p[[2]]}, Evaluate[Sequence @@ findRootOpts]],
          $Failed
        ]
      ]
  ];

  If[res === $Failed, $Failed, res /. z -> rootSym[0]]
];


(* ::Subsection:: *)
(*FindRootsA0*)


FindRootsA0//Options = Options[FindRootA0];


FindRootsA0[
	expr_,
	params_List,
	assumptions_,
	conds_,
	paramValues_Association,
	signs_List:{},
	opts:OptionsPattern[]
] := Module[
  {tgt = OptionValue[CompilationTarget],
   coeffName = OptionValue["CoeffName"],
   signSym = OptionValue["SignSymbol"],
   grid = OptionValue["BracketGrid"],
   findRootOpts = FilterRules[{opts}, Options[FindRoot]],
   K, f, fN, df, iv, L, U, Lint, Uint, shrink, span, roots = {}, z, rootSym, tol, fLeft, fRight,
   segments, br, rootRes, rootRule, rootVal, epsBase, eps, seedPts, res},

  If[!paramValidQ[assumptions, paramValues, coeffName], Return[{}]];
  iv = A0Interval[conds, paramValues, signs, "CoeffName" -> coeffName, "SignSymbol" -> signSym];
  If[iv === $Failed, Return[{}]];
  {L, U} =  {Min@iv,Max@iv};
  span = Max[Abs[U - L], 1.];
  shrink = Max[10.^-12, 1000. $MachineEpsilon*span];
  shrink = If[U > L, Min[shrink, (U - L)/10.], shrink];
  Lint = L + shrink;
  Uint = U - shrink;
  If[Lint >= Uint,
    Lint = L + (U - L)/4.;
    Uint = U - (U - L)/4.;
    If[Lint >= Uint, Lint = Uint = (L + U)/2.;]
  ];

  K = BuildKernel[expr, params, CompilationTarget -> tgt, "CoeffName" -> coeffName, "SignSymbol" -> signSym];
  {f, df} = BindUnary[K, paramValues, signs];
  If[f === $Failed || df === $Failed, Return[{}]];
 
 rootSym = ToExpression[coeffName];
 fN[z_?NumericQ] := Module[{x = N[z, MachinePrecision]},
    If[x <= Lint || x >= Uint, Indeterminate, f[x]]
  ];
 
 roots = {};
 tol = 10.^(-OptionValue[AccuracyGoal]);
 fLeft  = Quiet@Check[f[N[Lint, MachinePrecision]], Indeterminate];
 fRight = Quiet@Check[f[N[Uint, MachinePrecision]], Indeterminate];
 If[NumericQ[fLeft] && Abs[fLeft] <= tol, AppendTo[roots, rootSym[0] -> Lint]];
 If[NumericQ[fRight] && Abs[fRight] <= tol, AppendTo[roots, rootSym[0] -> Uint]];

 segments = {{Lint, Uint}};
 epsBase = Max[tol, (Uint - Lint)/1000.];

  While[segments =!= {},
    {Lseg, Useg} = First[segments];
    segments = Rest[segments];
    If[!NumericQ[Lseg] || !NumericQ[Useg] || Lseg >= Useg, Continue[]];
    br = locateBracketInterval[f, {Lseg, Useg}, grid];
    If[br === $Failed, Continue[]];
   rootRes = Quiet @ Check[
     First @ FindRoot[fN[z], {z, br[[1]], br[[2]]}, Evaluate[Sequence @@ findRootOpts], Method -> "Secant"],
     $Failed
   ];
   If[rootRes === $Failed, Continue[]];
   rootRule = rootRes /. z -> rootSym[0];
   rootVal = rootRule[[2]];
   If[!NumericQ[rootVal], Continue[]];
   AppendTo[roots, rootRule];
   eps = Max[epsBase, 10.^(-ag) Abs[rootVal]];
   segments = Join[
     {
       {Lseg, Max[Lseg, rootVal - eps]},
       {Min[rootVal + eps, Useg], Useg}
     },
     segments
   ];
 ];
 
  If[roots === {},
    xs    = N[Subdivide[Lint, Uint, Max[256, 4 grid] + 2], MachinePrecision];
    xsInt = xs[[2 ;; -2]];
    ys    = f /@ xsInt;
    pairs = xsInt[[#]] & /@ signFlipPairsNumericSubseq[ys];
    Do[
      Quiet @ Check[
        AppendTo[
          roots,
          (First @ FindRoot[fN[z], {z, p[[1]], p[[2]]}, Evaluate[Sequence @@ findRootOpts], Method -> "Secant"]) /. z -> rootSym[0]
        ],
        Null
      ],
      {p, pairs}
    ];
  ];

  If[roots === {},
    seedPts = N @ Subdivide[Lint, Uint, Max[8, grid]];
    Do[
      res = Quiet @ Check[
        FindRoot[fN[z], {z, seed}, Evaluate[Sequence @@ findRootOpts]],
        $Failed
      ];
      If[res =!= $Failed,
        AppendTo[roots, (res /. z -> rootSym[0])]
      ];
      ,
      {seed, seedPts}
    ];
  ];
 
  DeleteDuplicatesBy[
    Select[roots, NumericQ[Last[#]] &],
    Round[Last[#], 10.^-10] &
  ]
];


(* ::Subsection:: *)
(*fastRoot*)


fastRoot//Options = {
  AccuracyGoal -> 8,
  PrecisionGoal -> 8,
  MaxIterations -> 20,
  WorkingPrecision -> MachinePrecision,
  "NewtonFirst" -> True,      (* try Newton with df before fallback *)
  "Return" -> "Rule"          (* "Rule" | "Value" *)
};


(* --- explicit f, df --- *)
fastRoot[
	f_, 
	df_, 
	{a_?NumericQ, b_?NumericQ}, 
	opts:OptionsPattern[]
] /; a < b := Module[
  {
    ff = f, dff = df, fnum, dfnum, fa, fb, x0, bracketedQ,
    acc = OptionValue[AccuracyGoal],
    prec = OptionValue[PrecisionGoal],
    maxit = OptionValue[MaxIterations],
    wp = OptionValue[WorkingPrecision],
    ret = OptionValue["Return"],
    res, newtonRes
  },

  (* numeric-only wrappers *)
  fnum[x_?NumericQ]  := ff[x];
  dfnum[x_?NumericQ] := dff[x];

  fa = fnum[N@a]; fb = fnum[N@b];
  If[!(NumericQ[fa] && NumericQ[fb]), Return[$Failed]];
  bracketedQ = Sign[fa] =!= Sign[fb];

  (* regula-falsi seed, else midpoint *)
  x0 = If[fa =!= fb, a - fa (b - a)/(fb - fa), (a + b)/2.];

  (* 1) Newton attempt (bounded to [a,b]) using your derivative *)
  newtonRes = If[TrueQ@OptionValue["NewtonFirst"],
    Quiet@Check[
      FindRoot[
        fnum[x] == 0.,
        {x, x0, a, b},
        Method -> "Newton",
        Jacobian -> {{dfnum[x]}},      (* explicit 1\[Times]1 Jacobian *)
        WorkingPrecision -> wp,
        AccuracyGoal -> acc, PrecisionGoal -> prec,
        MaxIterations -> maxit
      ],
      $Failed
    ],
    $Failed
  ];

  (* 2) Fallback: Brent if bracketed; otherwise Secant *)
  res = If[newtonRes =!= $Failed, newtonRes,
    Quiet@Check[
      If[bracketedQ,
        FindRoot[
          fnum[x] == 0., {x, a, b},
          Method -> "Brent",
          WorkingPrecision -> wp,
          AccuracyGoal -> acc, PrecisionGoal -> prec
        ],
        FindRoot[
          fnum[x] == 0., {x, a, b},
          Method -> "Secant",
          WorkingPrecision -> wp,
          AccuracyGoal -> acc, PrecisionGoal -> prec,
          MaxIterations -> 2 maxit
        ]
      ],
      $Failed
    ]
  ];

  If[res === $Failed, $Failed, If[ret === "Value", x /. res, res]]
];

(* --- positional convenience, same as before --- *)
fastRoot[f_, df_, {a_?NumericQ, b_?NumericQ}, acc_Integer?NonNegative] :=
  fastRoot[f, df, {a, b}, AccuracyGoal -> acc, PrecisionGoal -> acc];

fastRoot[f_, df_, {a_?NumericQ, b_?NumericQ}, acc_Integer?NonNegative, maxit_Integer?Positive] :=
  fastRoot[f, df, {a, b}, AccuracyGoal -> acc, PrecisionGoal -> acc, MaxIterations -> maxit];

(* --- optional: bracket-only version without df --- *)
fastRoot[f_, {a_?NumericQ, b_?NumericQ}, opts:OptionsPattern[]] /; a < b := Module[
  {ff = f, fnum, fa, fb, bracket, acc = OptionValue[AccuracyGoal], prec = OptionValue[PrecisionGoal], wp = OptionValue[WorkingPrecision]},
  fnum[x_?NumericQ] := ff[x];
  fa = fnum[N@a]; fb = fnum[N@b]; bracket = NumericQ[fa] && NumericQ[fb] && Sign[fa] =!= Sign[fb];
  If[bracket,
    FindRoot[fnum[x] == 0., {x, a, b}, Method -> "Brent", WorkingPrecision -> wp, AccuracyGoal -> acc, PrecisionGoal -> prec],
    FindRoot[fnum[x] == 0., {x, a, b}, Method -> "Secant", WorkingPrecision -> wp, AccuracyGoal -> acc, PrecisionGoal -> prec]
  ]
];


(* ::Subsection:: *)
(*scanAndSolve*)


(* Near-zero on the scan grid counts as a root; Automatic -> 10^-acc *)
scanAndSolve//Options = {
  "BracketGrid" -> 32,
  "Tolerance" -> Automatic,
  AccuracyGoal -> 8
};


(* -------- With derivative -------- *)
scanAndSolve[
	f_, 
	df_, 
	{a_?NumericQ, b_?NumericQ}, 
	opts : OptionsPattern[]
] /; a < b :=
 Module[{ff = f, dff = df, fnum, dfnum, xs, ys, tol, zeroRoots, signs, ints, roots, fastOpts,
         bins = OptionValue["BracketGrid"], acc = OptionValue[AccuracyGoal]},
  fnum[x_?NumericQ]  := ff[x];
  dfnum[x_?NumericQ] := dff[x];

  xs = N @ Subdivide[a, b, bins];        (* length = bins + 1 *)
  ys = fnum /@ xs;

  tol = Replace[OptionValue["Tolerance"], Automatic -> 10.^(-acc)];

  (* grid hits: use a listable selector *)
  zeroRoots = Pick[xs, UnitStep[tol - Abs[ys]], 1];

  signs = Sign[ys];
  (* sign-change subintervals; selector length == bins *)
  ints  = Pick[Partition[xs, 2, 1], Most[signs]*Rest[signs], -1];

  fastOpts = FilterRules[{opts}, Options[fastRoot]];

  roots = Quiet @ Select[
    (Quiet @ Check[
       x /. fastRoot[fnum, dfnum, #,
                     AccuracyGoal -> acc, PrecisionGoal -> acc,
                     Sequence @@ fastOpts],
       $Failed
     ]) & /@ ints,
    NumericQ
  ];

  Union[Join[zeroRoots, roots], SameTest -> (Abs[#1 - #2] <= tol &)]
];


(* -------- Without derivative -------- *)
scanAndSolve[
	f_, 
	{a_?NumericQ, b_?NumericQ}, 
	opts : OptionsPattern[]
] /; a < b :=
 Module[{ff = f, fnum, xs, ys, tol, zeroRoots, signs, ints, roots, fastOpts,
         bins = OptionValue["BracketGrid"], acc = OptionValue[AccuracyGoal]},
  fnum[x_?NumericQ] := ff[x];

  xs = N @ Subdivide[a, b, bins];
  ys = fnum /@ xs;

  tol = Replace[OptionValue["Tolerance"], Automatic -> 10.^(-acc)];

  zeroRoots = Pick[xs, UnitStep[tol - Abs[ys]], 1];

  signs = Sign[ys];
  ints  = Pick[Partition[xs, 2, 1], Most[signs]*Rest[signs], -1];

  fastOpts = FilterRules[{opts}, Options[fastRoot]];

  roots = Quiet @ Select[
    (Quiet @ Check[
       x /. fastRoot[fnum, #,
                     AccuracyGoal -> acc, PrecisionGoal -> acc,
                     Sequence @@ fastOpts],
       $Failed
     ]) & /@ ints,
    NumericQ
  ];

  Union[Join[zeroRoots, roots], SameTest -> (Abs[#1 - #2] <= tol &)]
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
(*locateBracketInterval*)


locateBracketInterval[f_, {a_, b_}, grid_Integer?Positive, minSamples_Integer:8] := Module[
  {levels, xs, xsInt, ys, pairs},
  If[!NumericQ[a] || !NumericQ[b] || a >= b, Return[$Failed]];
  levels = NestWhileList[Min[2 #, grid] &, Min[minSamples, grid], # < grid &];
  Do[
    xs = Subdivide[a, b, n + 2];
    xsInt = xs[[2 ;; -2]];
    If[xsInt === {}, Continue[]];
    ys = Quiet[f /@ xsInt];
    pairs = xsInt[[#]] & /@ signFlipPairsNumericSubseq[ys];
    If[pairs =!= {}, Return[pairs[[1]]]];
    ,
    {n, levels}
  ];
  $Failed
];


(* ::Section:: *)
(*End package*)


End[];


EndPackage[];
