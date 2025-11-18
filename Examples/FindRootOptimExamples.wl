(* ::Package:: *)

(* :Title: A0RootPack *)
(* :Context: A0RootPack` *)
(* :Summary: Fast compiled root-finding for expr(A[0], params, signA[i]) with domain from condA. *)
(* :Version: 1.1 (2025-11-17) *)

BeginPackage["A0RootPack`"];

BuildKernel::usage = "BuildKernel[expr, param, OptionsPattern[]] compiles expr with A[0] as the variable. Returns <|\"fC\",\"dfC\",\"ParamOrder\",\"SignIndex\"|>.";
BindUnary::usage  = "BindUnary[kernel, paramsAssoc, signsList] binds numeric params and signs, returning {f, df} unary functions of A[0].";
A0Interval::usage = "A0Interval[condA, paramsAssoc, signsList] returns Interval[{L,U}] (A[0]>0) from condA or $Failed.";
FindRootA0::usage = "FindRootA0[expr, param, assumeA, condA, paramsAssoc, signsList, opts] returns a single rule A[0]->root or $Failed.";
FindRootsA0::usage= "FindRootsA0[expr, param, assumeA, condA, paramsAssoc, signsList, opts] returns a list of rules A[0]->root.";


Options[BuildKernel] = {CompilationTarget -> "C", "CoeffName" -> "A", "SignSymbol" -> "signA"};
Options[FindRootA0]  = {CompilationTarget -> "C", "BracketGrid" -> 256, "Seeds"->Automatic, AccuracyGoal->8, PrecisionGoal->8, Method->"Secant"};
Options[FindRootsA0] = {CompilationTarget -> "C", "BracketGrid" -> 512, AccuracyGoal->8, PrecisionGoal->8};

Begin["`Private`"];

normalizeExp[e_] := e //. {
  Power[E, a_?AtomQ][x_] :> Exp[a[x]],
  Power[E, u_] :> Exp[u]
};

(* match signA[...] regardless of context *)
signIdxs[ex_, sigSym_String] := Sort @ DeleteDuplicates @ Cases[
  ex,
  s_Symbol[i_Integer] /; SymbolName[s] === sigSym :> i,
  Infinity
];


(* small CSE: hoist t = Exp[z] and map Exp[k z] with integer k to t^k *)
expCSE[ex_, z_Symbol] := Module[{t = Unique["t$"], e = ex},
  e = e /. Exp[z] :> t;
  e = e /. Exp[k_Integer z] :> t^k;
  {t, e}
];

(* fast, robust scalar-args kernel *)
BuildKernel[expr_, param_List, OptionsPattern[{CompilationTarget -> "C"}]] := Module[
  {
    tgt = OptionValue[CompilationTarget], sigSym = OptionValue["SignSymbol"], cn = OptionValue["CoeffName"],
    ex0, z, idx, pSyms, sSyms, body, dbody, fC, dfC, nP, nS, signHead
  },

  ex0 = normalizeExp[expr];                             (* no N here *)
  z   = Unique["z"];

  (* A[0] -> z, context-agnostic *)
  ex0 = ex0 /. (s_Symbol[j_][0] /; SymbolName[s] === cn) :> z /. (s_Symbol[0] /; SymbolName[s] === cn) :> z;

  (* detect indices before any N *)
  idx = signIdxs[ex0, sigSym];

  nP = Length@param;  nS = Length@idx;
  pSyms = Array[Unique["p$"]&, nP];
  sSyms = Array[Unique["s$"]&, nS];

  body = ex0 /. Thread[param -> pSyms];

  If[nS > 0,
    signHead = First @ Cases[ex0, s_Symbol[_Integer] /; SymbolName[s] === sigSym :> s, Infinity, 1];
    body = body /. Thread[(signHead /@ idx) -> (1.0*sSyms)];
  ];

  body  = N[body, MachinePrecision];                   (* numericize after substitutions *)
  dbody = N[D[body, z], MachinePrecision];

    With[{args = Join[
                  {{z, _Real}},
                  Table[{pSyms[[i]], _Real},    {i, nP}],
                  Table[{sSyms[[j]], _Integer}, {j, nS}]
                ],
         b = body, db = dbody, tgt2 = tgt},
    fC = Compile[ Evaluate@args, Evaluate@b,
          CompilationTarget -> tgt2,
          RuntimeOptions    -> "Speed",
          CompilationOptions -> {
            "ExpressionOptimization"->True,
            "InlineExternalDefinitions"->True,
            "InlineCompiledFunctions"->True
          }];

    dfC = Compile[ Evaluate@args, Evaluate@db,
          CompilationTarget -> tgt2,
          RuntimeOptions    -> "Speed",
          CompilationOptions -> {
            "ExpressionOptimization"->True,
            "InlineExternalDefinitions"->True,
            "InlineCompiledFunctions"->True
          }];
  ];

  <|"fC"->fC, "dfC"->dfC, "ParamOrder"->param, "SignIndex"->idx|>
];


(* bind: feed scalars to the scalar-args kernel *)
BindUnary[k_Association, params_Association, signs_List:{}] := Module[
  {a, s, idx = k["SignIndex"]},
  a = Developer`ToPackedArray @ N[Lookup[params, k["ParamOrder"]], MachinePrecision];
  s = If[idx === {}, {}, Developer`ToPackedArray @ Round @ signs[[idx]]];
  {
    Function[{z}, k["fC"][Sequence @@ Join[{z}, a, s]]],
    Function[{z}, k["dfC"][Sequence @@ Join[{z}, a, s]]]
  }
];


paramValidQ[ass_, params_Association] := Module[
  {assP = LogicalExpand[ass] //. params, only},
  only = Select[List @@ assP, FreeQ[#, A[0]] &];
  TrueQ @ Simplify[If[only === {}, True, Not[False === (And @@ only)]]]
];

A0Interval[condA_, params_Association, signs_List:{}] := Module[
  {ineq, red, lexp, ints = {}, lb, ub, L, U, best},
  ineq = normalizeExp[condA] /. Normal@params /. Table[signA[i] -> signs[[i]], {i, Length@signs}];
  red = Quiet @ Check[
    Reduce[ineq && A[0] > 0, A[0], Reals],
    Reduce[Rationalize[ineq, 0] && A[0] > 0, A[0], Reals]
  ];
  If[red === False, Return[$Failed]];

  lexp = LogicalExpand @ red;

  ints = Join[
    Cases[lexp, Inequality[lo_, (Less|LessEqual), A[0], (Less|LessEqual), hi_] :> Interval[{N@lo, N@hi}], Infinity],
    Cases[lexp, Equal[A[0], c_] :> Interval[{N@c, N@c}], Infinity]
  ];

  If[ints === {},
    lb = Cases[lexp,
          (Less[lo_, A[0]] | LessEqual[lo_, A[0]] | Greater[A[0], lo_] | GreaterEqual[A[0], lo_]) :> N@lo,
          Infinity];
    ub = Cases[lexp,
          (Less[A[0], hi_] | LessEqual[A[0], hi_] | Greater[hi_, A[0]] | GreaterEqual[hi_, A[0]]) :> N@hi,
          Infinity];
    If[lb =!= {} && ub =!= {},
      L = Max@lb; U = Min@ub;
      If[NumericQ[L] && NumericQ[U] && L <= U, ints = {Interval[{L, U}]}];
    ];
  ];

  If[ints === {}, Return[$Failed]];
  best = First @ SortBy[ints, -IntervalMeasure[#] &];
  best /. Interval[{l_, u_}] :> Interval[{Max[0., l], u}]
]

bracketSeeds[f_, Interval[{L_,U_}], n_Integer:256] := Module[
  {xs = Subdivide[N@L, N@U, n], ys, i},
  ys = f /@ xs;
  i = SelectFirst[Range[Length@xs - 1],
       NumericQ[ys[[#]]] && NumericQ[ys[[#+1]]] && ys[[#]]*ys[[#+1]] <= 0. &,
       Missing["NotFound"]];
  If[i === Missing["NotFound"], (L + U)/2., Mean[{xs[[i]], xs[[i + 1]]}]]
];

Options[FindRootA0] = {
  CompilationTarget -> "C",
  "BracketGrid" -> 256,
  "Seeds" -> Automatic,
  AccuracyGoal -> 8,
  PrecisionGoal -> 8,
  Method -> "Secant"
};

FindRootA0[
  expr_, param_List, assumeA_, condA_,
  params_Association, signs_List:{},
  OptionsPattern[]
] := Module[
  {tgt = OptionValue[CompilationTarget], grid = OptionValue["BracketGrid"],
   seeds = OptionValue["Seeds"], ag = OptionValue[AccuracyGoal],
   pg = OptionValue[PrecisionGoal], meth = OptionValue[Method],
   K, f, fN, df, iv, L, U, xs, xsInt, ys, pairs, p, z, res},

  If[!paramValidQ[assumeA, params], Return[$Failed]];
  
  iv = A0Interval[condA, params, signs];
  If[iv === $Failed, Return[$Failed]];
  {L, U} = {Min@iv, Max@iv};

  K = BuildKernel[expr, param, CompilationTarget -> tgt];
  {f, df} = BindUnary[K, params, signs];

  fN[z_?NumericQ] := f[N[z, MachinePrecision]];
  
  Which[
    MatchQ[seeds, {_?NumericQ, _?NumericQ}],
      p = N@seeds;
      res = Quiet @ Check[
        First @ FindRoot[fN[z], {z, p[[1]], p[[2]]}, Method -> meth, AccuracyGoal -> ag, PrecisionGoal -> pg],
        $Failed
      ],
    NumericQ[seeds],
      res = Quiet @ Check[
        First @ FindRoot[fN[z], {z, N@seeds, L, U}, Method -> meth, AccuracyGoal -> ag, PrecisionGoal -> pg],
        $Failed
      ],
    True,
		xs    = N[Subdivide[L, U, grid + 2], MachinePrecision];
		xsInt = xs[[2 ;; -2]];
		ys    = f /@ xsInt;  (* f is compiled *)
      pairs = xsInt[[#]] & /@ signFlipPairsNumericSubseq[ys];
      If[pairs === {}, Return[$Failed]];
      p = First @ pairs;
      res = Quiet @ Check[
        First @ FindRoot[fN[z], {z, p[[1]], p[[2]]}, Method -> meth, AccuracyGoal -> ag, PrecisionGoal -> pg],
        $Failed
      ]
  ];

  If[res === $Failed, $Failed, res /. z -> A[0]]
];


signFlipPairsNumericSubseq[list_List] := Module[{pos, s, k},
  pos = Flatten@Position[list, _?NumericQ, {1}];
  s   = Sign[list[[pos]]];
  k   = Flatten @ Position[Partition[s, 2, 1], {a_, b_} /; a b < 0];
  Transpose @ {pos[[k]], pos[[k + 1]]}   (* pairs {i, i+1} in the original list indexing *)
];

Options[FindRootsA0] = {CompilationTarget -> "C", "BracketGrid" -> 512, AccuracyGoal -> 8, PrecisionGoal -> 8};

FindRootsA0[expr_, param_List, assumeA_, condA_, params_Association, signs_List:{}, OptionsPattern[]] := Module[
  {tgt = OptionValue[CompilationTarget], grid = OptionValue["BracketGrid"], ag = OptionValue[AccuracyGoal], pg = OptionValue[PrecisionGoal],
   K, f, fN, df, iv, L, U, xs, xsInt, ys, pairs, roots = {}, z},

  If[!paramValidQ[assumeA, params], Return[{}]];
  iv = A0Interval[condA, params, signs];
  If[iv === $Failed, Return[{}]];
  {L, U} =  {Min@iv,Max@iv};

  K = BuildKernel[expr, param, CompilationTarget -> tgt];
  {f, df} = BindUnary[K, params, signs];
 
 fN[z_?NumericQ] := f[N@z];
 
 xs    = N[Subdivide[L, U, grid + 2], MachinePrecision];
		xsInt = xs[[2 ;; -2]];
		ys    = f /@ xsInt;  (* f is compiled *)
      pairs = xsInt[[#]] & /@ signFlipPairsNumericSubseq[ys];
      
  Do[ 
	Quiet @ Check[
	   AppendTo[roots, (First @ FindRoot[fN[z], {z, p[[1]], p[[2]]}, Method -> "Secant", AccuracyGoal -> ag, PrecisionGoal -> pg]) /. z -> A[0]],
	    Null
  ],
    {p, pairs}
  ];
 
  DeleteDuplicatesBy[roots, Round[Last[#], 10.^-10] &]
];


End[];
EndPackage[];


(* load the package *)
Get["A0RootPack`"];  (* or Get["/full/path/to/A0RootPack.wl"] *)


Subtract@@eqAB0/.signB[1]->1/.signB[2]->1/.signA[1]->1/.signA[2]->1/.j->1//.params/.B[1][0]->3/.A[0]->3//N//Simplify


expr=Subtract@@eqA0;
param =  Keys@model["params"];
assume=assumeA;
condA=And@@conditionsA;
paramsAssoc = (Association@model["params"])/.model["params"]//N;
params = paramsAssoc;
signs = {1, 1};  (* edit to match your expr; {} if no signA[i] *)
solsNA0=FindRootsA0[expr, param, assume, condA, params, signs]
solNA0=FindRootA0[expr, param, assume, condA, params, signs]







exprAB=Subtract@@eqAB0;
signsA = Thread[{signA[1],signA[2]}->signs];
paramAB = Join[param,{Keys@solNA0},Keys@signsA];
paramsAB = Join[params,Association@solNA0,Association@signsA];
condAB=And@@conditionsB;
signsAB = {1, 1}; 


(* compile once *)
K = BuildKernel[expr, param, CompilationTarget -> "C"];

(* save it (machine- and version-specific) *)
filename = FileNameJoin[{DirectoryName[NotebookDirectory[],2],"Resources","CompiledFunctions",model["shortname"]<>".mx"}]
$SavedKernel = K;
DumpSave[filename, "$SavedKernel"];



Get[filename];     (* restores $SavedKernel *)
K = $SavedKernel;

(* bind params/signs and use *)
{f, df} = BindUnary[K, paramsAssoc, signs];
iv = A0Interval[condA, paramsAssoc, signs];
{L, U} =  {Min@iv,Max@iv};
root = FindRoot[f[z], {z, (L+U)/2., L, U}] /. z -> A[0];



ClearAll[fastRoot];
fastRoot::usage =
  "fastRoot[{a,b}, acc:8, maxit:20] finds a real root of f[x]==0 in [a,b]. \
Tries fast Newton with df from a false-position seed; \
falls back to Brent if the ends bracket a sign change, otherwise to a two-point secant. \
Returns the rule x->root.";


Options[fastRoot] = {
  AccuracyGoal -> 8,
  PrecisionGoal -> 8,
  MaxIterations -> 20,
  WorkingPrecision -> MachinePrecision,
  "NewtonFirst" -> True,      (* try Newton with df before fallback *)
  "Return" -> "Rule"          (* "Rule" | "Value" *)
};

(* --- explicit f, df --- *)
fastRoot[f_, df_, {a_?NumericQ, b_?NumericQ}, opts:OptionsPattern[]] /; a < b := Module[
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



ClearAll[scanAndSolve];

(* Near-zero on the scan grid counts as a root; Automatic -> 10^-acc *)
Options[scanAndSolve] = {
  "Tolerance" -> Automatic
};

(* -------- With derivative -------- *)
scanAndSolve[f_, df_, {a_?NumericQ, b_?NumericQ}, bins_: 32, acc_: 8, opts : OptionsPattern[]] /; a < b :=
 Module[{ff = f, dff = df, fnum, dfnum, xs, ys, tol, zeroRoots, signs, ints, roots, fastOpts},
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
scanAndSolve[f_, {a_?NumericQ, b_?NumericQ}, bins_: 32, acc_: 8, opts : OptionsPattern[]] /; a < b :=
 Module[{ff = f, fnum, xs, ys, tol, zeroRoots, signs, ints, roots, fastOpts},
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



fastRoot[Function[x, Cos[x] - x],
         Function[x, -Sin[x] - 1.0],
         {0., 1.},
         10, 30]
(* -> x -> 0.7390851332... *)
cf  = Compile[{{x, _Real}},  Cos[x] - x];
cdf = Compile[{{x, _Real}}, -Sin[x] - 1.0];

fastRoot[cf, cdf, {0., 1.}, 10, 30]                     (* positional *)
fastRoot[cf, cdf, {0., 1.}, AccuracyGoal->12, PrecisionGoal->12]

fastRoot[cf, cdf, {0., 1.}, "Return" -> "Value"]
(* -> 0.7390851332... *)


cf  = Compile[{{x,_Real}},  Cos[x] - x];
cdf = Compile[{{x,_Real}}, -Sin[x] - 1.0];

scanAndSolve[cf, cdf, {0., 3.}, 64, 8]
(* {0.739085...} *)

scanAndSolve[(Cos[#] - #) &, {0., 3.}, 64, 8]
(* {0.739085...} *)




  ClearAll[K,fC,dFC,f,df,iv,L,U]
  K = BuildKernel[expr, param, CompilationTarget -> "C"];
  {fC, dfC} = BindUnary[K, params, signs];
  f[x_?NumericQ]  := fC[x];
  df[x_?NumericQ] := dfC[x];
  iv = A0Interval[condA, params, signs];
  If[iv === $Failed, Return[$Failed]];
  {L, U} = {N@Min@iv, N@Max@iv};
  {f[L],f[U-0.01],df[L],df[U-0.01]}
    fastRoot[f, df,{L, U-0.01}] 


scanAndSolve[f, df,{L, U-0.01}]


(* cache/ensure a compiled kernel on disk *)
Options[EnsureKernelFile] = Options[BuildKernel];

EnsureKernelFile[
  expr_, param_List,
  file_: Automatic,
  OptionsPattern[]
] := Module[
  {tgt = OptionValue[CompilationTarget], path = file, dir, key, K},

  (* choose default location when file == Automatic *)
  path = If[path === Automatic,
    dir = FileNameJoin[{$UserBaseDirectory, "A0RootPack", "kernels"}];
    If[!DirectoryQ[dir], CreateDirectory[dir, CreateIntermediateDirectories -> True]];
    key = IntegerString[Hash @ HoldComplete[expr, param, tgt], 36];
    FileNameJoin[{dir, "K-" <> key <> ".mx"}],
    path
  ];

  (* try to load existing mx *)
  If[FileExistsQ[path],
    Quiet @ Check[Get[path]; K = $A0Kernel;, K = $Failed];
    If[AssociationQ[K] && KeyExistsQ[K, "ParamOrder"] && K["ParamOrder"] === param,
      Return[{K, path}]
    ];
  ];

  (* build and save *)
  K = BuildKernel[expr, param, CompilationTarget -> tgt];
  $A0Kernel = K;                                     (* private stash symbol *)
  DumpSave[path, $A0Kernel];                         (* persist for later reuse *)

  {K, path}
];



{K, file} = EnsureKernelFile[expr, param, Automatic, CompilationTarget -> "C"];
{f, df}   = BindUnary[K, paramsAssoc, signs];

iv = A0Interval[condA, paramsAssoc, signs];
{L, U} = iv[[1]];
FindRoot[f[z] == 0, {z, (L + U)/2., L, U}, Method -> "Secant"]

