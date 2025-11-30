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


(* ::Subsubsection:: *)
(*Usage*)


buildKernel::usage = "buildKernel[expr, params] compiles expr into a C-kernel optimized for root-finding with respect to A[0] (or specified \"CoeffName\"). (MODIFIED)";
bindUnary::usage   = "bindUnary[kernel, paramValues, signs] specializes the compiled kernel with numeric parameters, returning a pair of functions {f, df}.";
bindUnary::insufficientsigns = "Expected at least `1` sign values, but got `2`.";
findRootInterval::usage  = "findRootInterval[conds, paramValues, signs] determines the search interval Interval[{min, max}] for the root variable based on constraints.";
extractIntervalsFromReduce::usage = "extractIntervalsFromReduce[reduceExpr, rootVar] converts a Reduce expression into a list of numeric intervals {{a1, b1}, {a2, b2}, ...}.";
scanAndSolve::usage = "scanAndSolve[f, {min, max}] finds roots of f[x] in the range by grid subdivision.\nscanAndSolve[f, df, {min, max}] uses derivative df for Newton steps.";
fastRoot::usage = "fastRoot[f, df, {a, b}] finds a root using a hybrid Newton/Brent/Secant strategy.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*buildKernel*)


buildKernel//Options = {
	"CoeffName" -> "A",
	"SignSymbol" -> "signA"
};

buildKernel::badvars = "Expression contains coefficient variables not listed in vars.";
buildKernel::unusedvars = "Some vars were not found in the expression: `1`.";


(* fast, robust scalar-args kernel *)
buildKernel[
	expr_,
	vars_List,
	params_List,
	opts : OptionsPattern[{buildKernel}]
] := With[
  {
    coeffName = OptionValue["CoeffName"],
    signSym = OptionValue["SignSymbol"]
  },
  Module[
    {ex0, z, zRules, idx, pSyms, sSyms, body, dbody, fC, dfC, nP, nS, signHead},

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
    dbody = N[D[body, {z}], MachinePrecision]; (*jacobian*)

    {fC,dfC}=Module[
	    {inferType},
	    inferType[e_]:=With[
		    {
			    rank=ArrayDepth[e]
		    },
		    If[rank==0,"Real64",TypeSpecifier["PackedArray"]["Real64",rank]]
		];
		With[
			{
				args=Join[
					Flatten[{Thread[Typed[z,"Real64"]]}],
					Table[Typed[pSyms[[i]],"Real64"],{i,nP}],
					Table[Typed[sSyms[[j]],"Integer64"],{j,nS}]
				],
				b=body,
				db=dbody,
				dbType=inferType[dbody]
			},
			{
				FunctionCompile[
					Function[Evaluate@args,TypeHint[b,bType]],
					CompilerRuntimeErrorAction->"Evaluate",
					ProgressReporting->False
				],
				FunctionCompile[
					Function[Evaluate@args,TypeHint[db,dbType]],
					CompilerRuntimeErrorAction->"Evaluate",
					ProgressReporting->False
				]
			}
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
    Function[{z}, k["fC"][Sequence @@ Join[z, a, s]]],
    Function[{z}, k["dfC"][Sequence @@ Join[z, a, s]]]
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
(*fastRoot*)


fastRoot//Options = {
  "NewtonFirst" -> True,          (* try Newton with df before fallback *)
  "Return" -> "Value",             (* "Rule" | "Value" *)
  "SecantBlend" -> 0.5,           (* in Newton: starting point is lambda*secant+(1-lambda)*midpoint*) (*in Secant: starting secant is lambda*lb+(1-lambda)*x0 and lambda*ub+(1-lambda)*x0*) 
  "FindRootOptions" -> Function[
	  {x, lb, ub},
	  {
		  AccuracyGoal -> 8,
		  PrecisionGoal -> 8,
		  StepMonitor :> (x = Clip[x, {lb, ub}]) (*prevent evaluation outside interval [lb,ub] by clipping, disable with StepMonitor -> None*)
	  }
  ]
};


(*explicit f, df*)
fastRoot[
	f_,
	df_,
	{a_?NumericQ, b_?NumericQ},
	opts : OptionsPattern[{fastRoot, FindRoot}]
] /; a < b := With[
  {
    newtonFirst = OptionValue["NewtonFirst"],
    ret = OptionValue["Return"],
    lambda = N[OptionValue["SecantBlend"]],
    frSpec = OptionValue["FindRootOptions"],
    var = Unique["x"]
  },
	With[
		{
			frOpts = If[Head[frSpec] === Function, frSpec[var, a, b], frSpec]
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
			Module[{fnum, dfnum, fa, fb, x0, res, newtonRes},
						
			    (* numeric-only wrappers *)
			    fnum[x_?NumericQ]  := f[x];
			    dfnum[x_?NumericQ] := df[x];
			    fa = fnum[N@a]; fb = fnum[N@b];
			    If[!(NumericQ[fa] && NumericQ[fb]), Return[$Failed]];
				x0 = If[
					Abs[fb - fa] > 1.0*^-10,
					(1.-lambda)*(a+b)/2.+lambda*(a-fa*(b-a)/(fb-fa)),(* blended secant-midpoint *)
					(a + b)/2.(* else midpoint *)
				]; 
				
			    (* Newton attempt using derivative *)
			    newtonRes = If[TrueQ@newtonFirst && (df=!=None),
			      Quiet@Check[
					 FindRoot[
					   fnum[var] == 0.,
					   {var, x0, a, b},
					   Method -> "Newton",
					   Jacobian -> {{dfnum[var]}},
					   Evaluate[Sequence @@ findRootOpts]
					 ],
					 Failure["fastRootNewton", <|"Stage"->"Newton"|"Brent"|"Secant", "x0"->x0, "fa"->fa, "fb"->fb, "Bracket"->{a,b}|>]
			      ],(*Check*)
			      $Failed
			    ];(*If*)
			
			    (* Fallback: Brent if bracketed; otherwise Secant *)
			    res = If[!FailureQ[newtonRes] && newtonRes =!= $Failed, newtonRes,
			      Quiet@Check[
			        If[Sign[fa] =!= Sign[fb],
			          FindRoot[
			            fnum[var] == 0., {var, a, b},
			            Method -> "Brent",
			            Evaluate[Sequence @@ findRootOpts]
			          ],
			          FindRoot[
			            fnum[var] == 0., {var, lambda*a+(1-lambda)*x0, lambda*b+(1-lambda)*x0},
			            Method -> "Secant",
			            Evaluate[Sequence @@ findRootOpts]
			          ]
			        ],
			        Failure["fastRootNotNewton", <|"Stage"->If[Sign[fa] =!= Sign[fb],"Brent","Secant"], "fa"->fa, "fb"->fb, "Bracket"->{a,b}|>]
			      ]
			    ];
			
			    If[res === $Failed || FailureQ[res], $Failed, If[ret === "Value", var /. res, res]]
			](*Module*)
		](*With*)
	](*With*)
];(*With*)

(*positional convenience, same as before*)
fastRoot[f_, df_, {a_?NumericQ, b_?NumericQ}, acc_Integer?NonNegative] :=
  fastRoot[f, df, {a, b}, AccuracyGoal -> acc, PrecisionGoal -> acc];

fastRoot[f_, df_, {a_?NumericQ, b_?NumericQ}, acc_Integer?NonNegative, maxit_Integer?Positive] :=
  fastRoot[f, df, {a, b}, AccuracyGoal -> acc, PrecisionGoal -> acc, MaxIterations -> maxit];

(*optional: bracket-only version without df*)
fastRoot[f_, {a_?NumericQ, b_?NumericQ}, opts : OptionsPattern[{fastRoot, FindRoot}]] /; a < b := 
	fastRoot[f, None, {a, b}, opts]; 


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
		    frOpts = If[Head[frSpec] === Function, frSpec[var, a, b], frSpec]
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
			    fnum[x_?NumericQ]  := f[x];
			    dfnum[x_?NumericQ] := df[x];
			
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
			         fastRoot[fnum, dfnum, #, Sequence @@ fastOpts],
			         $Failed
			       ]) & /@ ints,
			      NumericQ
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


(* ::Section:: *)
(*End package*)


End[];


EndPackage[];
