(* ::Package:: *)

(* ParamQuadSolve: Symbolic solver for square systems with per-variable degree ≤ 2,
   allowing limited bilinear terms. Produces parametric solutions with signA[k]
   for square-root branches, a reversible coefficient map, and validation. *)

BeginPackage["ParamQuadSolver`"];

ParamQuadSolve::usage =
  "ParamQuadSolve[eqns, vars, opts] returns an Association with keys \"Solution\", \"SignRootMap\", \"CoeffMap\", \"Conditions\", \"Verification\", and \"Diagnostics\".";

Options[ParamQuadSolve] = {
  ParamQuadSolver`Domain -> Reals,
  ParamQuadSolver`Assumptions -> Automatic,
  ParamQuadSolver`Method -> Automatic,
  ParamQuadSolver`MonomialOrder -> Automatic,
  ParamQuadSolver`Validation -> True,
  ParamQuadSolver`Return -> "All",
  ParamQuadSolver`Timeout -> 300,
  ParamQuadSolver`Diagnostics -> False,
  ParamQuadSolver`SignSymbol -> signA
};

Begin["`Private`"];

ClearAll[defaultAssumptions];
defaultAssumptions[] := And @@ {
  Element[delta, Reals], 0 < delta < 1,
  Element[psi, Reals], psi > 0, psi != 1,
  Element[gamma, Reals], gamma > 0,
  Element[theta, Reals], theta != 0,
  Element[rhopbar, Reals], Element[rhog, Reals], Element[vp, Reals],
  -1 < rhopbar < 1, -1 < rhog < 1, -1 < vp < 1,
  Element[Esp, Reals], Element[phispw, Reals], Esp >= 0, phispw >= 0,
  Element[A, Reals], A[0] > 0
};

(* Utilities *)
ClearAll[toPolyAndDen];
toPolyAndDen[eq_, ass_] := Module[{lhs, rhs, expr, num, den},
  If[MatchQ[eq, _Equal], lhs = eq[[1]]; rhs = eq[[2]];, lhs = eq; rhs = 0;];
  expr = Together[lhs - rhs];
  num = Numerator[expr];
  den = Denominator[expr];
  {Expand[num], den}
];

ClearAll[collectDenominatorConditions];
collectDenominatorConditions[dlist_List] := Module[{expr, conds},
  expr = LogicalExpand[And @@ Thread[dlist != 0]];
  conds = Which[
    expr === True, {},
    Head[expr] === And, List @@ expr,
    True, {expr}
  ];
  DeleteDuplicates[DeleteCases[conds, True]]
];

ClearAll[canonicalizeCoefficients];
(* Replace all coefficients (wrt vars) by unique dummy symbols; return new polys and a mapping. *)
canonicalizeCoefficients[polys_List, vars_List] := Module[
  {rulesPer, allCoeffs, symb, cmap = <||>, newPolys},
  symb[c_] := Lookup[cmap, c, With[{s = Unique["c$"]}, cmap[c] = s; s]];
  (* Extract coefficient rules for each poly *)
  rulesPer = CoefficientRules[#, vars] & /@ polys;
  allCoeffs = Union[Flatten[Values /@ rulesPer]];
  (* Build cmap explicitly *)
  Scan[(symb[#]) &, allCoeffs];
  (* Rebuild polynomials with dummy coefficients *)
  newPolys = Map[
    Function[assocList,
      With[{assoc = Association[assocList]},
        Total@KeyValueMap[Function[{exps, coeff}, cmap[coeff] * Times @@ (vars^exps)], assoc]
      ]
    ],
    rulesPer
  ];
  {Expand /@ newPolys, AssociationThread[Values[cmap], Keys[cmap]]}
];

ClearAll[makeSignGenerator];
makeSignGenerator[head_Symbol] := Module[{idx = 0},
  Function[head[++idx]]
];

ClearAll[varsInPoly, varDegree, linearInVarQ, univariateQ];
varsInPoly[poly_, vars_] := Select[vars, Exponent[poly, #] > 0 &];
varDegree[poly_, v_] := Exponent[poly, v];
linearInVarQ[poly_, v_, ass_] := Module[{deg = varDegree[poly, v], coeff},
  If[deg == 1,
    coeff = Coefficient[poly, v, 1];
    Not[PossibleZeroQ[coeff, Assumptions -> ass]],
    False
  ]
];
univariateQ[poly_, vars_] := Length[varsInPoly[poly, vars]] == 1;

ClearAll[solveLinearFor];
solveLinearFor[poly_, v_, ass_] := Module[{a, b, rhs},
  a = Coefficient[poly, v, 1];
  b = Simplify[poly /. v -> 0, Assumptions -> ass];
  If[a === 0 || PossibleZeroQ[a, Assumptions -> ass], $Failed,
    rhs = Simplify[-b/a, Assumptions -> ass];
    {v -> rhs, <||>}
  ]
];

ClearAll[quadraticSolveParam];
(* Return {rule, signAssoc} for var; normalize as alpha + sign*beta*Sqrt[Δ] *)
quadraticSolveParam[poly_, v_, signGen_, ass_] := Module[{a, b, c, delta, alpha, beta, s, rule},
  a = Coefficient[poly, v, 2];
  b = Coefficient[poly, v, 1];
  c = Simplify[poly /. v -> 0, Assumptions -> ass];
  If[a === 0 || PossibleZeroQ[a, Assumptions -> ass], Return[solveLinearFor[poly, v, ass]]];
  delta = Simplify[b^2 - 4 a c, Assumptions -> ass];
  s = signGen[];
  alpha = Simplify[-b/(2 a), Assumptions -> ass];
  beta  = Simplify[1/(2 a), Assumptions -> ass];
  rule = v -> Simplify[(alpha + beta*s*Sqrt[delta]), Assumptions -> ass];
  {rule, <|s -> Sqrt[delta]|>}
];

ClearAll[quarticSolveParam];
quarticSolveParam[poly_, v_, signGen_, ass_] := Module[
  {px = Expand[poly], lc, norm, a3, a2, a1, a0, shift, p, q, r,
   mVar, mSolutions, m, radR, R, sign1, sign2, inner, exprY, exprV, rule, signAssoc,
   wDelta, sW, sY, wExpr},
  lc = Coefficient[px, v, 4];
  If[lc === 0, Return[$Failed]];
  norm = Expand[px/lc];
  a3 = Coefficient[norm, v, 3];
  a2 = Coefficient[norm, v, 2];
  a1 = Coefficient[norm, v, 1];
  a0 = Coefficient[norm, v, 0];
  shift = Simplify[a3/4, Assumptions -> ass];
  p = Simplify[a2 - 3 a3^2/8, Assumptions -> ass];
  q = Simplify[a1 - (a2 a3)/2 + a3^3/8, Assumptions -> ass];
  r = Simplify[a0 - (a1 a3)/4 + (a2 a3^2)/16 - 3 a3^4/256, Assumptions -> ass];
  If[Simplify[q == 0, Assumptions -> ass] === True,
    (* Biquadratic: y^4 + p y^2 + r = 0 *)
    wDelta = Simplify[p^2/4 - r, Assumptions -> ass];
    sW = signGen[];
    wExpr = Simplify[-p/2 + sW*Sqrt[wDelta], Assumptions -> ass];
    sY = signGen[];
    exprY = Simplify[sY*Sqrt[wExpr], Assumptions -> ass];
    exprV = Simplify[exprY - shift, Assumptions -> ass];
    rule = v -> exprV;
    signAssoc = <|sW -> Sqrt[wDelta], sY -> Sqrt[wExpr]|>;
    Return[{rule, signAssoc}];
  ];
  mVar = Unique["m"];
  mSolutions = Solve[mVar^3 - (p/2) mVar^2 - r mVar + (p r)/2 - q^2/8 == 0, mVar];
  If[mSolutions === {}, Return[$Failed]];
  Module[{candidates, picked},
    candidates = Simplify[#, Assumptions -> ass] & /@ (mVar /. mSolutions);
    picked = SelectFirst[
      candidates,
      With[{rad = Simplify[2 # - p, Assumptions -> ass]},
        Not[rad === 0 || PossibleZeroQ[rad, Assumptions -> ass]]
      ] &,
      Missing["NoCandidate"]
    ];
    If[picked === Missing["NoCandidate"], Return[$Failed]];
    m = picked;
    radR = Simplify[2 m - p, Assumptions -> ass];
  ];
  If[radR === 0 || PossibleZeroQ[radR, Assumptions -> ass], Return[$Failed]];
  R = Sqrt[radR];
  sign2 = signGen[];
  sign1 = signGen[];
  inner = Sqrt[Simplify[-2 m - p - (2 q/R) sign2, Assumptions -> ass]];
  exprY = Simplify[(sign2*R)/2 + (sign1*inner)/2, Assumptions -> ass];
  exprV = Simplify[exprY - shift, Assumptions -> ass];
  rule = v -> exprV;
  signAssoc = <|sign2 -> R, sign1 -> inner|>;
  {rule, signAssoc}
];

  (* Sign normalization that does not use Simplify. Reduces any even power to 1,
     any odd power (>1) to a single sign, and collapses repeated factors. *)
  ClearAll[normalizeSigns];
  normalizeSigns[expr_, signHead_Symbol] := Module[{rules},
    rules = {
      Power[signHead[_], n_Integer?EvenQ] :> 1,
      Power[signHead[i_], n_Integer?OddQ] /; n > 1 :> signHead[i]
    };
    expr //. rules
  ];

ClearAll[sequentialSolve];
sequentialSolve[polys_List, vars_List, ass_, signHead_] := Module[
  {eqs = polys, unsolved = vars, solved = <||>, signMap = <||>, steps = {}, iter = 0,
   maxIter = 5 Length[vars], signGen = makeSignGenerator[signHead]},
  While[eqs =!= {} && unsolved =!= {} && iter++ < maxIter,
    Module[{varCounts = varsInPoly[#, unsolved] & /@ eqs, counts, linearFlags, bestIndex, peq, varsIn,
      linearCandidates, v, res, degree, last, gb, uni},
      counts = Length /@ varCounts;
      linearFlags = Table[
        If[AnyTrue[varCounts[[i]], linearInVarQ[eqs[[i]], #, ass] &], 0, 1],
        {i, Length[eqs]}
      ];
      bestIndex = Ordering[Transpose[{counts, linearFlags}]][[1]];
      peq = eqs[[bestIndex]];
      varsIn = varCounts[[bestIndex]];
      linearCandidates = Select[varsIn, linearInVarQ[peq, #, ass] &];
      If[linearCandidates =!= {},
        v = First[linearCandidates];
        res = solveLinearFor[peq, v, ass];
        If[res === $Failed, Break[]];
        AppendTo[steps, {"linear", v}];
        solved[v] = res[[1, 2]];
        KeyValueMap[(signMap[#1] = #2) &, res[[2]]];
        unsolved = DeleteCases[unsolved, v];
        eqs = Delete[eqs, bestIndex] /. res[[1]];
        Continue[];
      ];
      If[univariateQ[peq, unsolved],
        v = First[varsIn];
        degree = varDegree[peq, v];
        Which[
          degree <= 1,
            res = solveLinearFor[peq, v, ass];
            If[res === $Failed, Break[]];
            AppendTo[steps, {"linear", v}];
            solved[v] = res[[1, 2]];
            KeyValueMap[(signMap[#1] = #2) &, res[[2]]];
            unsolved = DeleteCases[unsolved, v];
            eqs = Delete[eqs, bestIndex] /. res[[1]];
            Continue[],
          degree == 2,
            res = quadraticSolveParam[peq, v, signGen, ass];
            If[res === $Failed, Break[]];
            AppendTo[steps, {"quadratic", v}];
            solved[v] = res[[1, 2]];
            KeyValueMap[(signMap[#1] = #2) &, res[[2]]];
            unsolved = DeleteCases[unsolved, v];
            eqs = Delete[eqs, bestIndex] /. res[[1]];
            Continue[],
          degree == 4,
            res = quarticSolveParam[peq, v, signGen, ass];
            If[res === $Failed, Break[]];
            AppendTo[steps, {"quartic", v}];
            solved[v] = res[[1, 2]];
            KeyValueMap[(signMap[#1] = #2) &, res[[2]]];
            unsolved = DeleteCases[unsolved, v];
            eqs = Delete[eqs, bestIndex] /. res[[1]];
            Continue[],
          True, Null
        ]
      ];
      last = Last[unsolved];
      gb = GroebnerBasis[eqs, unsolved, MonomialOrder -> Lexicographic];
      uni = SelectFirst[gb, (varsInPoly[#, unsolved] === {last} && varDegree[#, last] <= 2) & , Missing["NotFound"]];
      If[uni === Missing["NotFound"], Break[]];
      res = quadraticSolveParam[uni, last, signGen, ass];
      If[res === $Failed, Break[]];
      AppendTo[steps, {"quadraticGB", last}];
      solved[last] = res[[1, 2]];
      KeyValueMap[(signMap[#1] = #2) &, res[[2]]];
      unsolved = DeleteCases[unsolved, last];
      eqs = (eqs /. res[[1]]);
    ]
  ];
  {solved, signMap, eqs, steps}
];

ClearAll[buildAssumptions];
buildAssumptions[userAss_] := Module[{base = defaultAssumptions[]},
  Which[
    userAss === Automatic, base,
    True, base && userAss
  ]
];

ClearAll[normalizeOptions];
normalizeOptions[opts___?OptionQ] := Module[{assoc = Association@Flatten@{opts}, get},
  get[keys_List, def_] := Module[{k = SelectFirst[keys, KeyExistsQ[assoc, #] &, Missing["KeyNotFound"]]}, If[k === Missing["KeyNotFound"], def, assoc[k]]];
  <|
    "Domain" -> get[{ParamQuadSolver`Domain, Domain}, Reals],
    "Assumptions" -> get[{ParamQuadSolver`Assumptions, Assumptions}, Automatic],
    "Method" -> get[{ParamQuadSolver`Method, Method}, Automatic],
    "MonomialOrder" -> get[{ParamQuadSolver`MonomialOrder, MonomialOrder}, Automatic],
    "Validation" -> get[{ParamQuadSolver`Validation, Validation}, True],
    "Return" -> get[{ParamQuadSolver`Return, Return}, "All"],
    "Timeout" -> get[{ParamQuadSolver`Timeout, Timeout}, 300],
    "Diagnostics" -> get[{ParamQuadSolver`Diagnostics, Diagnostics}, False],
    "SignSymbol" -> get[{ParamQuadSolver`SignSymbol, SignSymbol}, signA]
  |>
];

ClearAll[ParamQuadSolve];
ParamQuadSolve[eqns_List, vars_List, opts___?OptionQ] := Module[
  {o = normalizeOptions[opts], domain, userAss, doValidate, ret, timeout, signHead,
  ass, pairs, eqPolys, dens, denConds, canPolys, coeffMap, seqRes, solved, signMap, leftover, steps, solRules,
   signRootMap, conditions, verif, out, t0, t1, solRulesDesym, signRootMapDesym},
  domain = o["Domain"]; userAss = o["Assumptions"]; doValidate = o["Validation"]; ret = o["Return"]; timeout = o["Timeout"]; signHead = o["SignSymbol"];
  ass = buildAssumptions[userAss];
  If[NumericQ[timeout] && timeout <= 0, Return[<|"Error" -> "Timeout or failure during solving"|>]];
  t0 = AbsoluteTime[];
  pairs = toPolyAndDen[#, ass] & /@ eqns;
  eqPolys = pairs[[All, 1]];
  dens = pairs[[All, 2]];
  denConds = collectDenominatorConditions[dens];
  {canPolys, coeffMap} = canonicalizeCoefficients[eqPolys, vars];
  seqRes = TimeConstrained[sequentialSolve[canPolys, vars, ass, signHead], N@timeout, $Failed];
  If[!MatchQ[seqRes, {__}], Return[<|"Error" -> "Timeout or failure during solving"|>]];
  {solved, signMap, leftover, steps} = seqRes;
  (* Propagate solved dependencies so each var's RHS depends only on parameters/signs *)
  solRules = Normal[solved];
  solRules = FixedPoint[
    Function[rules,
      KeyValueMap[#1 -> (#2 /. rules) &, Association[rules]] // Normal
    ],
    solRules
  ];
  signRootMap = Association[signMap];
  (* substitute original coefficient expressions back *)
  solRulesDesym = (solRules /. coeffMap);
  signRootMapDesym = Map[# /. coeffMap &, signRootMap];
  Module[{radicandsRaw, uniqueRadicands, signSymbols, radicandConditions},
    radicandsRaw = (Values[signRootMapDesym] /. Sqrt[z_] :> z);
    uniqueRadicands = DeleteDuplicates[radicandsRaw];
    signSymbols = DeleteDuplicates@Cases[uniqueRadicands, signHead[_], Infinity];
    radicandConditions =
      If[domain === Reals,
        Which[
          uniqueRadicands === {}, {},
          signSymbols === {}, Thread[uniqueRadicands >= 0],
          True,
            With[{comb = Tuples[{1, -1}, Length[signSymbols]]},
              Or @@ Map[
                Function[vals,
                  With[{rules = Thread[signSymbols -> vals]},
                    And @@ Thread[(uniqueRadicands /. rules) >= 0]
                  ]
                ],
                comb
              ]
            ]
        ],
        {}
      ];
    conditions = Flatten@{denConds, radicandConditions};
  ];
  verif = If[TrueQ[doValidate],
    Quiet@Check[
      Module[{polys0, exprs, zeroQuick, checked, signVars, signAssumptions, fullAss},
        polys0 = Map[If[MatchQ[#, _Equal], #[[1]] - #[[2]], #] &, eqns];
        exprs = normalizeSigns[polys0 /. solRulesDesym, signHead];
        signVars = Keys[signRootMap];
        signAssumptions = If[signVars === {}, True, And @@ Thread[(signVars)^2 == 1]];
        fullAss = ass && signAssumptions;
        zeroQuick = PossibleZeroQ[#, Assumptions -> fullAss] & /@ exprs;
        checked = MapThread[
          If[#1 === True, True, Simplify[#2 == 0, Assumptions -> fullAss]] &,
          {zeroQuick, exprs}
        ];
        checked
      ],
      $Failed
    ],
    Missing["NotEvaluated"]
  ];
  t1 = AbsoluteTime[];
  out = <|
    "Solution" -> solRulesDesym,
    "SignRootMap" -> signRootMapDesym,
    "CoeffMap" -> coeffMap,
    "Conditions" -> conditions,
    "Verification" -> verif,
    "Diagnostics" -> <|
      "LeftoverEquations" -> leftover,
      "Steps" -> steps,
      "TimingSeconds" -> t1 - t0,
      "Method" -> "Sequential+FallbackGB"
    |>
  |>;
  Which[
    ret === "All", out,
    ListQ[ret], KeyTake[out, Intersection[Keys[out], ret]],
    True, out
  ]
];

End[];
EndPackage[];
