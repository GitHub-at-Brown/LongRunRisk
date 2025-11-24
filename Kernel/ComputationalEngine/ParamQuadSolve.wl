(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


paramQuadSolve::usage =
  "paramQuadSolve[eqns, vars, opts] returns an Association with keys \"Solution\", \"SignRootMap\", \"CoeffMap\", \"Conditions\", \"Assumptions\", \"Verification\", and \"Diagnostics\".\n\n\
paramQuadSolve is a symbolic solver for square systems with per-variable degree <= 2. The per-variable degree test means bilinear terms such as x*y are permitted, \
but they do not classify either variable as \"quadratic\" on their own. The solver produces parametric solutions with signA[k] for square-root branches, \
a reversible coefficient map, and validation.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];


(* ::Subsection:: *)
(*paramQuadSolve*)


Options[paramQuadSolve] = {
  "DomainOption" -> Reals,
  "Assumptions" -> Automatic,
  "Method" -> Automatic,
  "MonomialOrder" -> Automatic,
  "ValidationOption" -> True,
  "ReturnOption" -> "All",
  "TimeoutOption" -> 60,
  "SimplifyTimeout" -> Automatic,
  "DiagnosticsOption" -> False,
  "OnlyQuadTerms" -> False,
  "SignSymbol" -> signA
};


paramQuadSolve::badmethod = "Method -> `1` is not supported. Use Automatic, \"Sequential\", or \"SequentialWithGroebner\".";
paramQuadSolve::badorder = "MonomialOrder -> `1` is not supported by GroebnerBasis.";
paramQuadSolve::noquad = "No quadratic variables detected in the given system; OnlyQuadTerms cannot be applied.";
paramQuadSolve::nocover = "Unable to select a square subsystem covering the quadratic variables.";


paramQuadSolve[eqns_List, vars_List, opts : OptionsPattern[{paramQuadSolve}]] :=
  With[
    {
      domain          = OptionValue["DomainOption"],
      userAss         = OptionValue["Assumptions"],
      methodChoice    = OptionValue["Method"],
      gbOrder         = OptionValue["MonomialOrder"],
      doValidate      = OptionValue["ValidationOption"],
      ret             = OptionValue["ReturnOption"],
      timeout         = OptionValue["TimeoutOption"],
      simplifyTimeout = OptionValue["SimplifyTimeout"],
      diagnosticsQ    = OptionValue["DiagnosticsOption"],
      onlyQuadQ       = TrueQ @ OptionValue["OnlyQuadTerms"],
      signHead        = OptionValue["SignSymbol"]
    },
    Module[
      {ass, pairsFull, polysFull, densFull, eqVarSets, selection, varsToSolve, quadraticVars,
      deferredVarList, selectedEqIndices, deferredEqIndices, eqnsUsed, eqnsDeferred, pairs, eqPolys,
      dens, denConds, canPolys, coeffMap, seqRes, solved, signMap, signRadMap, leftover, steps, solRules,
      signRootMap, conditions, verif, out, t0, t1, solRulesDesym, signRootMapDesym, signRadMapDesym, diagExtra,
      radicandsRaw, uniqueRadicands, radicandConditions, signVars, signAssumptions, fullAss,
      methodTag, allowGroebner, gbOrderUsed, simpBudget},
      {methodTag, allowGroebner} = Which[
        methodChoice === Automatic || methodChoice === "SequentialWithGroebner", {"SequentialWithGroebner", True},
        methodChoice === "Sequential", {"Sequential", False},
        True, Message[paramQuadSolve::badmethod, methodChoice]; Return[$Failed]
      ];
      gbOrderUsed = Replace[gbOrder, Automatic -> Lexicographic];
      ass = buildAssumptions[userAss];
      simpBudget = Which[
        NumericQ[simplifyTimeout] && simplifyTimeout >= 0, N@simplifyTimeout,
        simplifyTimeout === Automatic && NumericQ[timeout] && timeout > 0, Min[5., N@timeout/10.],
        True, 1.0
      ];
      If[NumericQ[timeout] && timeout <= 0, Return[<|"Error" -> "Timeout or failure during solving"|>]];
      (* Input validation *)
      If[vars === {}, Return[<|"Error" -> "Variables list cannot be empty"|>]];
      If[eqns === {}, Return[<|"Error" -> "Equations list cannot be empty"|>]];
      t0 = AbsoluteTime[];
      pairsFull = toPolyAndDen /@ eqns;
      polysFull = pairsFull[[All, 1]];
      densFull = pairsFull[[All, 2]];
      eqVarSets = varsInPoly[#, vars] & /@ polysFull;
      With[{analysis = quadAnalysis[polysFull, vars]},
        quadraticVars = analysis["QuadraticVars"];
      ];
      If[onlyQuadQ,
        selection = selectQuadraticSubset[quadraticVars, eqVarSets, eqns, vars];
        If[selection === $Failed, Return[$Failed]];
        varsToSolve = selection["VarsToSolve"];
        deferredVarList = selection["DeferredVars"];
        selectedEqIndices = selection["SelectedEqIndices"];
        deferredEqIndices = selection["DeferredEqIndices"];
        eqnsUsed = eqns[[selectedEqIndices]];
        eqnsDeferred = eqns[[deferredEqIndices]];
        pairs = pairsFull[[selectedEqIndices]];
        eqPolys = pairs[[All, 1]];
        dens = pairs[[All, 2]];
        diagExtra = selection["Diagnostics"];
      ,
        varsToSolve = vars;
        deferredVarList = {};
        selectedEqIndices = Range[Length[eqns]];
        deferredEqIndices = {};
        eqnsUsed = eqns;
        eqnsDeferred = {};
        pairs = pairsFull;
        eqPolys = polysFull;
        dens = densFull;
        diagExtra = <|
          "OnlyQuadTermsApplied" -> False,
          "QuadraticVariables" -> quadraticVars,
          "SolvedQuadraticVariables" -> varsToSolve,
          "DeferredVariables" -> {},
          "DeferredEquationsIndices" -> {}
        |>;
      ];
      denConds = collectDenominatorConditions[dens];
      {canPolys, coeffMap} = canonicalizeCoefficients[eqPolys, varsToSolve];
      coeffMap = TimeConstrained[
        Map[Simplify[#, Assumptions -> ass] &, coeffMap],
        simpBudget,
        coeffMap
      ];
      seqRes = TimeConstrained[sequentialSolve[canPolys, varsToSolve, ass, signHead, gbOrderUsed, allowGroebner], N@timeout, $Failed];
      If[!MatchQ[seqRes, {__}], Return[<|"Error" -> "Timeout or failure during solving"|>]];
      {solved, signMap, signRadMap, leftover, steps} = seqRes;
      solRules = Normal[solved];
      solRules = TimeConstrained[
        FixedPoint[
          Function[rules,
            KeyValueMap[#1 -> (#2 /. rules) &, Association[rules]] // Normal
          ],
          solRules,
          100
        ],
        N@timeout,
        $Failed
      ];
      If[solRules === $Failed, Return[<|"Error" -> "Timeout or failure during solving"|>]];
      signRootMap = Association[signMap];
      (* substitute original coefficient expressions back *)
      solRulesDesym = (solRules /. coeffMap);
      signRootMapDesym = Map[# /. coeffMap &, signRootMap];
      signRadMapDesym  = Map[# /. coeffMap &, Association[signRadMap]];
      signVars = Keys[signRootMapDesym];
      signAssumptions = If[signVars === {}, True, And @@ Thread[(signVars)^2 == 1]];
      fullAss = expandPatternAssumptions[eqns,ass && signAssumptions];

      (* Apply square root simplification *)
      {signRootMapDesym, signRadMapDesym} = simplifySignMap[signRootMapDesym, signRadMapDesym, fullAss];

      If[TrueQ[doValidate],
        solRulesDesym = TimeConstrained[
          (#[[1]] -> Simplify[#[[2]], Assumptions -> fullAss]) & /@ solRulesDesym,
          simpBudget,
          solRulesDesym
        ];
        signRootMapDesym = TimeConstrained[
          Map[Simplify[#, Assumptions -> fullAss] &, signRootMapDesym],
          simpBudget,
          signRootMapDesym
        ];
        signRadMapDesym = TimeConstrained[
          Map[Simplify[#, Assumptions -> fullAss] &, signRadMapDesym],
          simpBudget,
          signRadMapDesym
        ];
      ];
      radicandsRaw = Values[signRadMapDesym];
      uniqueRadicands = DeleteDuplicates[radicandsRaw];
      radicandConditions =
        If[domain === Reals,
          If[uniqueRadicands === {},
            {},
            Flatten@{Simplify[Thread[uniqueRadicands >= 0], Assumptions -> fullAss]}
          ],
          {}
        ];
      conditions = DeleteCases[Flatten@{denConds, radicandConditions}, True];
      verif = If[TrueQ[doValidate],
        TimeConstrained[
          Quiet@Check[
            Module[{polys0, exprs, zeroQuick, checked},
              polys0 = Subtract@@@eqnsUsed;
              exprs = normalizeSigns[polys0 /. solRulesDesym, signHead];
              zeroQuick = PossibleZeroQ[#, Assumptions -> fullAss] & /@ exprs;
              checked = MapThread[
                If[#1 === True,
                  True,
                  Module[{noAss = Simplify[#2 == 0]},
                    If[TrueQ[noAss],
                      True,
                      Simplify[#2 == 0, Assumptions -> fullAss]
                    ]
                  ]
                ] &,
                {zeroQuick, exprs}
              ];
              checked
            ],
            $Failed
          ],
          N@timeout,
          $Failed
        ],
        Missing["NotEvaluated"]
      ];
      t1 = AbsoluteTime[];
      out = <|
        "Solution" -> Sort@solRulesDesym,
        "SignRootMap" -> signRootMapDesym,
        "CoeffMap" -> coeffMap,
        "Conditions" -> conditions,
        "Assumptions" -> fullAss,
        "Verification" -> verif,
        "DeferredVariables" -> deferredVarList,
        "DeferredEquations" -> eqnsDeferred,
        "Diagnostics" -> Join[
          diagExtra,
          <|
            "LeftoverEquations" -> leftover,
            "Steps" -> steps,
            "TimingSeconds" -> t1 - t0,
            "Method" -> methodTag,
            "GroebnerMonomialOrder" -> gbOrderUsed,
            "SignRadicandMap" -> signRadMapDesym
          |>
        ]
      |>;
      Which[
        ret === "All", out,
        ListQ[ret], KeyTake[out, Intersection[Keys[out], ret]],
        True, out
      ]
    ]
  ];


(* ::Subsubsection:: *)
(*defaultAssumptions*)


defaultAssumptions[] := Module[
  {paramsRealAss, endogVarsRealAss, endogAss, syms, headsApplied, scalars,
   varsWithElementHeads, funcMissing, scalarMissing, pAssoc, divParamPat, restParam, restScalars},
  (* endogEqAssumptions from EndogenousEq.wl *)
  (* paramAssumptions from Parameters.wl *)

  (* Base endogenous-equation assumptions *)
  endogAss = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`endogEqAssumptions;

  (* Parameters real-valued: mirror external construction using paramList *)
  pAssoc = FernandoDuarte`LongRunRisk`Model`Parameters`Private`paramList;
  divParamPat = pAssoc["Real dividend growth"] /. x_[1] :> x[_];
  restParam = Values@KeyDrop[pAssoc, "Real dividend growth"];
  restScalars = Select[Flatten@restParam, Head[#] === Symbol &];
  paramsRealAss = And @@ Join[
    (Element[#, Reals] & /@ restScalars),
    (Element[#, Reals] & /@ divParamPat)
  ];

  (* Symbols from endogenous assumptions: real-valued, distinguishing scalars vs function heads *)
  syms = DeleteDuplicates @ Cases[endogAss, s_Symbol /; Context[s] =!= "System`", {0, Infinity}];
  headsApplied = Select[syms, Not@FreeQ[endogAss, HoldPattern[# [___]]] &];
  scalars = Complement[syms, headsApplied];
  varsWithElementHeads = DeleteDuplicates@Cases[
    endogAss,
    Element[var_, Reals] :> Replace[var, {h_[___] :> h, s_Symbol :> s}],
    {0, Infinity}
  ];
  funcMissing = Complement[headsApplied, varsWithElementHeads];
  scalarMissing = Complement[scalars, varsWithElementHeads];
  endogVarsRealAss = And @@ Join[
    (Element[#, Reals] & /@ scalarMissing),
    (Element[#[__], Reals] & /@ funcMissing)
  ];

  (* Combine all assumptions *)
  And[
    endogAss,
    FernandoDuarte`LongRunRisk`Model`Parameters`Private`paramAssumptions,
    paramsRealAss,
    endogVarsRealAss
  ]
];


(* ::Subsubsection::Closed:: *)
(*toPolyAndDen*)


toPolyAndDen[eq_] := Module[{lhs, rhs, expr, num, den},
  If[MatchQ[eq, _Equal], lhs = eq[[1]]; rhs = eq[[2]];, lhs = eq; rhs = 0;];
  expr = Together[lhs - rhs];
  num = Numerator[expr];
  den = Denominator[expr];
  {Expand[num], den}
];


(* ::Subsubsection::Closed:: *)
(*collectDenominatorConditions*)


collectDenominatorConditions[dlist_List] := Module[{expr, conds},
  expr = LogicalExpand[And @@ Thread[dlist != 0]];
  conds = Which[
    expr === True, {},
    Head[expr] === And, List @@ expr,
    True, {expr}
  ];
  DeleteDuplicates[DeleteCases[conds, True]]
];


(* ::Subsubsection::Closed:: *)
(*canonicalizeCoefficients*)


(* Replace all coefficients of polys by unique dummy symbols; return new polys and a mapping. *)
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


(* ::Subsubsection::Closed:: *)
(*makeSignGenerator*)


makeSignGenerator[head_Symbol] := Module[{idx = 0},
  Function[head[++idx]]
];


(* ::Subsubsection::Closed:: *)
(*varsInPoly*)


varsInPoly[poly_, vars_] := Select[vars, Exponent[poly, #] > 0 &];


(* ::Subsubsection::Closed:: *)
(*varDegree*)


varDegree[poly_, v_] := Exponent[poly, v];


(* ::Subsubsection::Closed:: *)
(*univariateQ*)


univariateQ[poly_, vars_] := Length[varsInPoly[poly, vars]] == 1;


(* ::Subsubsection::Closed:: *)
(*linearInVarQ*)


linearInVarQ[poly_, v_, ass_] := Module[{deg = varDegree[poly, v], coeff},
  If[deg == 1,
    coeff = Coefficient[poly, v, 1];
    Not[PossibleZeroQ[coeff, Assumptions -> ass]],
    False
  ]
];


(* ::Subsubsection::Closed:: *)
(*quadAnalysis*)


quadAnalysis[polys_List, vars_List] := Module[
  {maxDeg},
  maxDeg = AssociationThread[
    vars,
    Table[
      With[{deg = Max[Exponent[polys, vars[[i]]]]},
        If[deg === -Infinity, 0, deg]
      ],
      {i, Length[vars]}
    ]
  ];
  <|
    "MaxDegree" -> maxDeg,
    "QuadraticVars" -> Select[vars, Lookup[maxDeg, #, 0] >= 2 &]
  |>
];


(* ::Subsubsection::Closed:: *)
(*rankQuadraticVariables*)


rankQuadraticVariables[quadraticVars_List, eqsWithQuad_List, eqQuadVars_Association, vars_List] := Module[
  {varPositions, occurrences, minEqSize, usageCount},
  varPositions = AssociationThread[vars, Range[Length[vars]]];
  occurrences = Association@Table[
    var -> Select[eqsWithQuad, MemberQ[eqQuadVars[#], var] &],
    {var, quadraticVars}
  ];
  minEqSize = AssociationMap[
    If[occurrences[#] === {}, Infinity, Min[Length /@ (eqQuadVars /@ occurrences[#])]] &,
    quadraticVars
  ];
  usageCount = AssociationMap[Length[occurrences[#]] &, quadraticVars];
  <|
    "Rank" -> AssociationMap[
      {Lookup[minEqSize, #, Infinity], Lookup[usageCount, #, Infinity], Lookup[varPositions, #, Infinity]} &,
      quadraticVars
    ],
    "Occurrences" -> occurrences
  |>
];


(* ::Subsubsection::Closed:: *)
(*selectQuadraticSubset*)


selectQuadraticSubset[quadraticVars_List, eqVarSets_List, eqns_List, vars_List] := Module[
  {eqsWithQuad, eqQuadVars, ranking, rankAssoc, targetCount,
   varsToSolve, selectedEqIndices, deferredVars, deferredEqIndices, diagBase},
  If[quadraticVars === {},
    Message[paramQuadSolve::noquad];
    Return[$Failed];
  ];
  eqsWithQuad = Select[Range[Length[eqns]], Intersection[eqVarSets[[#]], quadraticVars] =!= {} &];
  If[eqsWithQuad === {},
    Message[paramQuadSolve::noquad];
    Return[$Failed];
  ];
  If[Length[eqsWithQuad] < Length[quadraticVars],
    Message[paramQuadSolve::nocover];
    Return[$Failed];
  ];
  eqQuadVars = AssociationThread[eqsWithQuad, Intersection[eqVarSets[[#]], quadraticVars] & /@ eqsWithQuad];
  ranking = rankQuadraticVariables[quadraticVars, eqsWithQuad, eqQuadVars, vars];
  rankAssoc = ranking["Rank"];
  targetCount = Length[quadraticVars];
  Module[{varsOrdered, eqOrder, usedEq = <||>, selectionPairs = {}, extraEqs, eqOptions, eqChosen,
         varUsage, orphanCount},
    (* Compute variable usage count within candidate equations *)
    varUsage = Association@Table[
      v -> Length[Select[eqsWithQuad, MemberQ[eqVarSets[[#]], v] &]],
      {v, vars}
    ];

    (* Count non-quadratic variables in each equation *)
    orphanCount[eq_] := Module[{varsInEq, nonQuadVars},
      varsInEq = eqVarSets[[eq]];
      nonQuadVars = Complement[varsInEq, quadraticVars];
      Length[Select[nonQuadVars, varUsage[#] == 1 &]]
    ];

    varsOrdered = SortBy[quadraticVars, rankAssoc];
    varsToSolve = Take[varsOrdered, targetCount];

    (* Sort by non-quadratic variable count first to avoid equations with isolated variables *)
    eqOrder = SortBy[eqsWithQuad, {orphanCount[#], Length[eqQuadVars[#]], #} &];
    Do[
      eqOptions = Select[eqOrder, MemberQ[eqQuadVars[#], var] &];
      If[eqOptions === {},
        Message[paramQuadSolve::nocover];
        Return[$Failed];
      ];
      eqChosen = SelectFirst[eqOptions, !KeyExistsQ[usedEq, #] &, First[eqOptions]];
      usedEq[eqChosen] = True;
      AppendTo[selectionPairs, {eqChosen, var}];
    , {var, varsToSolve}];
    selectedEqIndices = DeleteDuplicates[selectionPairs[[All, 1]]];
    If[Length[selectedEqIndices] < targetCount,
      extraEqs = Complement[eqOrder, selectedEqIndices];
      selectedEqIndices = Join[selectedEqIndices, Take[extraEqs, targetCount - Length[selectedEqIndices]]];
    ];
    If[Length[selectedEqIndices] < targetCount,
      Message[paramQuadSolve::nocover];
      Return[$Failed];
    ];
    selectedEqIndices = Sort[selectedEqIndices];
  ];
  deferredVars = Complement[vars, varsToSolve];
  deferredEqIndices = Complement[Range[Length[eqns]], selectedEqIndices];
  diagBase = <|
    "OnlyQuadTermsApplied" -> True,
    "QuadraticVariables" -> quadraticVars,
    "SolvedQuadraticVariables" -> varsToSolve,
    "DeferredVariables" -> deferredVars,
    "DeferredEquationsIndices" -> deferredEqIndices
  |>;
  <|
    "VarsToSolve" -> varsToSolve,
    "SelectedEqIndices" -> selectedEqIndices,
    "DeferredVars" -> deferredVars,
    "DeferredEqIndices" -> deferredEqIndices,
    "Diagnostics" -> diagBase
  |>
];


(* ::Subsubsection::Closed:: *)
(*solveLinearFor*)


solveLinearFor[poly_, v_, ass_] := Module[{a, b, rhs},
  a = Coefficient[poly, v, 1];
  b = Simplify[poly /. v -> 0, Assumptions -> ass];
  If[a === 0 || PossibleZeroQ[a, Assumptions -> ass], $Failed,
    rhs = Simplify[-b/a, Assumptions -> ass];
    {v -> rhs, <||>, <||>}
  ]
];


(* ::Subsubsection::Closed:: *)
(*quadraticSolveParam*)


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
  {rule, <|s -> Sqrt[delta]|>, <|s -> delta|>}
];


(* ::Subsubsection::Closed:: *)
(*quarticSolveParam*)


quarticSolveParam[poly_, v_, signGen_, ass_] := Module[
  {px = Expand[poly], lc, norm, a3, a2, a1, a0, shift, p, q, r,
   mVar, mSolutions, m, radR, radicalR, sign1, sign2, inner, exprY, exprV, rule, signAssoc, radAssoc,
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
    radAssoc  = <|sW -> wDelta,           sY -> wExpr|>;
    Return[{rule, signAssoc, radAssoc}];
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
  radicalR = Sqrt[radR];
  sign2 = signGen[];
  sign1 = signGen[];
  inner = Sqrt[Simplify[-2 m - p - (2 q/radicalR) sign2, Assumptions -> ass]];
  exprY = Simplify[(sign2*radicalR)/2 + (sign1*inner)/2, Assumptions -> ass];
  exprV = Simplify[exprY - shift, Assumptions -> ass];
  rule = v -> exprV;
  signAssoc = <|sign2 -> radicalR, sign1 -> inner|>;
  radAssoc  = <|sign2 -> radR, sign1 -> Simplify[-2 m - p - (2 q/radicalR) sign2, Assumptions -> ass]|>;
  {rule, signAssoc, radAssoc}
];


(* ::Subsubsection::Closed:: *)
(*simplifySquareRoot*)


(* Simplify a square root expression Sqrt[radicand].
   Uses FullSimplify with FactorTerms to simplify the radicand.

   Single expression form:
     simplifySquareRoot[radicand, assumptions]

   Multiple transforms form (tries each and picks best by LeafCount):
     simplifySquareRoot[radicand, {transform1, transform2, ...}, assumptions]
*)
simplifySquareRoot[radicand_, ass : Except[_List] : Automatic] := Module[{expr, simplified},
  expr = Sqrt[radicand];

  (* Apply FullSimplify with FactorTerms on numerator/denominator *)
  simplified = FullSimplify[
    expr /. Sqrt[z_] :> Sqrt[FactorTerms[Numerator@z]]/Sqrt[FactorTerms[Denominator@z]],
    Assumptions -> Replace[ass, Automatic -> defaultAssumptions[]]
  ];

  simplified
];

(* Overload that tries multiple parameter transformations and picks the best one *)
simplifySquareRoot[radicand_, transforms_List /; VectorQ[transforms, ListQ], ass : Except[_List] : Automatic] :=
  Module[{results},
    results = Table[
      simplifySquareRoot[radicand /. transform, ass],
      {transform, transforms}
    ];
    First[MinimalBy[results, LeafCount, 1]]
  ];


(* ::Subsubsection::Closed:: *)
(*simplifySignMap*)


(* Simplify all square roots in a sign map and return:
   {simplifiedSignMap, simplifiedRadMap}
   Applies simplifySquareRoot to each radicand and extracts the simplified radicand. *)
simplifySignMap[signMap_Association, radMap_Association, ass : Except[_List] : Automatic] := Module[
  {simplifiedSignMap = <||>, simplifiedRadMap = <||>, signVars},
  signVars = Keys[signMap];

  Do[
    Module[{radicand, simplified, newRadicand},
      radicand = radMap[s];
      simplified = simplifySquareRoot[radicand, ass];

      (* Extract radicand from simplified Sqrt[...] *)
      newRadicand = Which[
        MatchQ[simplified, Sqrt[r_]], r,
        MatchQ[simplified, Times[___, Sqrt[r_]]],
          (* If simplified is factor*Sqrt[r], reconstruct as Sqrt[factor^2 * r] *)
          Module[{factors, sqrtPart},
            factors = Select[List @@ simplified, FreeQ[#, Sqrt] &];
            sqrtPart = Select[List @@ simplified, !FreeQ[#, Sqrt] &];
            If[sqrtPart === {} || !MatchQ[First[sqrtPart], Sqrt[_]],
              radicand,
              (Times @@ factors)^2 * First[sqrtPart][[1]]
            ]
          ],
        True, radicand  (* Couldn't extract, keep original *)
      ];

      (* Store the simplified sqrt *)
      simplifiedSignMap[s] = simplified;

      (* Store the simplified radicand *)
      simplifiedRadMap[s] = newRadicand;
    ],
    {s, signVars}
  ];

  {simplifiedSignMap, simplifiedRadMap}
];


(* ::Subsubsection::Closed:: *)
(*normalizeSigns*)


(* Sign normalization without slow Simplify. Reduce even powers to 1,
   odd powers to a single sign, and collapse repeated factors. *)
normalizeSigns[expr_, signHead_Symbol] := Module[{rules},
    rules = {
      Power[signHead[_], _Integer?EvenQ] :> 1,
      Power[signHead[i_], n_Integer?OddQ] /; n > 1 :> signHead[i]
    };
    ReplaceRepeated[expr, rules, MaxIterations -> 10]
  ];


(* ::Subsubsection::Closed:: *)
(*sequentialSolve*)


sequentialSolve[polys_List, vars_List, ass_, signHead_, gbOrder_, allowGroebner_] := Module[
  {eqs = polys, unsolved = vars, solved = <||>, signMap = <||>, radMap = <||>, steps = {}, iter = 0,
   maxIter = 5 Length[vars], signGen = makeSignGenerator[signHead], gbOrderClean = Replace[gbOrder, Automatic -> Lexicographic]},
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
        If[Length[res] >= 3, KeyValueMap[(radMap[#1] = #2) &, res[[3]]]];
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
            If[Length[res] >= 3, KeyValueMap[(radMap[#1] = #2) &, res[[3]]]];
            unsolved = DeleteCases[unsolved, v];
            eqs = Delete[eqs, bestIndex] /. res[[1]];
            Continue[],
          degree == 2,
            res = quadraticSolveParam[peq, v, signGen, ass];
            If[res === $Failed, Break[]];
            AppendTo[steps, {"quadratic", v}];
            solved[v] = res[[1, 2]];
            KeyValueMap[(signMap[#1] = #2) &, res[[2]]];
            If[Length[res] >= 3, KeyValueMap[(radMap[#1] = #2) &, res[[3]]]];
            unsolved = DeleteCases[unsolved, v];
            eqs = Delete[eqs, bestIndex] /. res[[1]];
            Continue[],
          degree == 4,
            res = quarticSolveParam[peq, v, signGen, ass];
            If[res === $Failed, Break[]];
            AppendTo[steps, {"quartic", v}];
            solved[v] = res[[1, 2]];
            KeyValueMap[(signMap[#1] = #2) &, res[[2]]];
            If[Length[res] >= 3, KeyValueMap[(radMap[#1] = #2) &, res[[3]]]];
            unsolved = DeleteCases[unsolved, v];
            eqs = Delete[eqs, bestIndex] /. res[[1]];
            Continue[],
          True, Null
        ]
      ];
      If[!TrueQ[allowGroebner], Break[]];
      last = Last[unsolved];
      gb = Quiet@Check[
        GroebnerBasis[eqs, unsolved, MonomialOrder -> gbOrderClean],
        $Failed
      ];
      If[gb === $Failed,
        Message[paramQuadSolve::badorder, gbOrder];
        Return[$Failed];
      ];
      uni = SelectFirst[gb, (varsInPoly[#, unsolved] === {last} && varDegree[#, last] <= 2) & , Missing["NotFound"]];
      If[uni === Missing["NotFound"], Break[]];
      res = quadraticSolveParam[uni, last, signGen, ass];
      If[res === $Failed, Break[]];
      AppendTo[steps, {"quadraticGB", last}];
      solved[last] = res[[1, 2]];
      KeyValueMap[(signMap[#1] = #2) &, res[[2]]];
      If[Length[res] >= 3, KeyValueMap[(radMap[#1] = #2) &, res[[3]]]];
      unsolved = DeleteCases[unsolved, last];
      eqs = (eqs /. res[[1]]);
    ]
  ];
  {solved, signMap, radMap, eqs, steps}
];


(* ::Subsubsection::Closed:: *)
(*buildAssumptions*)


buildAssumptions[userAss_] := Module[{base = defaultAssumptions[]},
  Which[
    userAss === Automatic, base,
    True, base && userAss
  ]
];


(* ::Subsubsection:: *)
(* ::Subsubsection:: *)
(*expandPatternAssumptions*)


expandPatternAssumptions[expr_,ass_]:=And@@DeleteCases[If[Head@ass===And,List@@ass,{ass}]/.
(op:(Element|Greater|GreaterEqual|Less|LessEqual|Equal|Unequal))[p_,v_]/;!FreeQ[p,Blank|BlankSequence|BlankNullSequence]:>Sequence@@(op[#,v]&/@DeleteDuplicates@Cases[expr,p,{0,Infinity}]),True]


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
