(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


(* ::Subsection:: *)
(*Public symbols*)


paramQuadSolve
expandPatternAssumptions
simplifyWithDummySubstitution


(* ::Subsubsection:: *)
(*Usage*)


paramQuadSolve::usage =
  "paramQuadSolve[eqns, vars, opts] returns an Association with keys \"Solution\", \"SignRootMap\", \"CoeffMap\", \"Conditions\", \"Assumptions\", \"Verification\", and \"Diagnostics\", or $Failed on error.\n\n\
paramQuadSolve is a symbolic solver for square systems with per-variable degree <= 2. The per-variable degree test means bilinear terms such as x*y are permitted, \
but they do not classify either variable as \"quadratic\" on their own. The solver produces parametric solutions with signA[k] for square-root branches, \
a reversible coefficient map, and validation.";

expandPatternAssumptions::usage =
  "expandPatternAssumptions[expr, assumptions] expands pattern-based assumptions by finding all matching instances in expr.\n\n\
Pattern-based assumptions use Blank (_), BlankSequence (__), or BlankNullSequence (___) in expressions like Element[x[_], Reals] or x[_] > 0. \
This function searches expr for all matching patterns and expands them into concrete assumptions. \
For example, if expr contains x[1] and x[2], then Element[x[_], Reals] expands to Element[x[1], Reals] && Element[x[2], Reals]. \
Supports comparison operators: Element, Greater, GreaterEqual, Less, LessEqual, Equal, Unequal.";

simplifyWithDummySubstitution::usage =
  "simplifyWithDummySubstitution[expr, opts] simplifies expr by temporarily replacing Exp, Tanh, and Sqrt subexpressions with dummy symbols.\n\n\
This prevents memory explosion during Simplify by converting:\n\
- Level-0 symbols sym (e.g., A[0], B[j][0]) to Log[dummy], so E^sym becomes dummy\n\
- Tanh[sym/2] to (dummy - 1)/(dummy + 1)\n\
- Sqrt[radicand] to sqrtDummy\n\n\
After simplification with positivity assumptions on dummies (via Assuming[...]), original forms are restored.\n\n\
Options:\n\
- \"Assumptions\" -> Automatic: User assumptions combined with dummy positivity for Assuming[] (Automatic uses defaultAssumptions[], True inherits from outer Assuming context via $Assumptions)\n\
- \"Level0Pattern\" -> _Symbol[0] | _Symbol[_][0]: Pattern matching level-0 symbols\n\
- \"SimplifyFunction\" -> Simplify: Function to use (Simplify or FullSimplify)\n\
- Any Simplify options (e.g., TimeConstraint) are passed through directly\n\n\
For a list of rules {lhs -> rhs, ...}, simplifies the RHS of each rule.";


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
  "TimeoutOption" -> 600,
  "SimplifyTimeout" -> Automatic,
  "DiagnosticsOption" -> False,
  "OnlyQuadTerms" -> False,
  "SignSymbol" -> signA,
  "GroebnerMemoryFraction" -> 0.5,  (* fraction of MemoryAvailable[] to use *)
  "GroebnerMemoryFloor" -> 1*1024^3,  (* minimum memory limit in bytes *)
  "GroebnerMemoryCap" -> 16*1024^3,  (* maximum memory limit in bytes *)
  "Verbose" -> True  (* whether to print memory usage during solving *)
};

Options[simplifyWithDummySubstitution] = {
  "Assumptions" -> Automatic,
  "Level0Pattern" -> _Symbol[0] | _Symbol[_][0],
  "SimplifyFunction" -> Simplify
};


paramQuadSolve::badmethod = "Method -> `1` is not supported. Use Automatic, \"Sequential\", or \"SequentialWithGroebner\".";
paramQuadSolve::badorder = "MonomialOrder -> `1` is not supported by GroebnerBasis.";
paramQuadSolve::noquad = "No quadratic variables detected in the given system; OnlyQuadTerms cannot be applied.";
paramQuadSolve::nocover = "Unable to select a square subsystem covering the quadratic variables.";
paramQuadSolve::emptyvar = "Variables list cannot be empty.";
paramQuadSolve::emptyeq = "Equations list cannot be empty.";
paramQuadSolve::solvefail = "Solver failed or timed out.";
paramQuadSolve::gbmem = "GroebnerBasis exceeded memory limit (`1` GB). Consider simplifying the system or increasing GroebnerMemoryCap.";


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
      signHead        = OptionValue["SignSymbol"],
      gbMemFraction   = OptionValue["GroebnerMemoryFraction"],
      gbMemFloor      = OptionValue["GroebnerMemoryFloor"],
      gbMemCap        = OptionValue["GroebnerMemoryCap"],
      verbose         = OptionValue["Verbose"]
    },
    With[
      {
        methodSpec = Which[
          methodChoice === Automatic || methodChoice === "SequentialWithGroebner",
            <|"Tag" -> "SequentialWithGroebner", "AllowGroebner" -> True|>,
          methodChoice === "Sequential",
            <|"Tag" -> "Sequential", "AllowGroebner" -> False|>,
          True,
            Message[paramQuadSolve::badmethod, methodChoice];
            $Failed
        ],
        gbOrderUsed = Replace[gbOrder, Automatic -> Lexicographic],
        gbMemLimit = Clip[Round[gbMemFraction * MemoryAvailable[]], {gbMemFloor, gbMemCap}],
        simpBudget = Which[
          NumericQ[simplifyTimeout] && simplifyTimeout >= 0, N@simplifyTimeout,
          simplifyTimeout === Automatic && NumericQ[timeout] && timeout > 0, Min[5., N@timeout/10.],(*{1, Min[60.(*one minute*), N@timeout/10.(*1/10 of total time limit*)]},*)
          True, 1.0
        ],
        ass = buildAssumptions[userAss]
      },
      Module[
        {pairsFull, polysFull, densFull, eqVarSets, selection, varsToSolve, quadraticVars,
        deferredVarList, selectedEqIndices, deferredEqIndices, eqnsUsed, eqnsDeferred, pairs, eqPolys,
        dens, denConds, canPolys, coeffMap, seqRes, solved, signMap, signRadMap, leftover, steps, solRules,
        signRootMap, conditions, verif, out, t0, t1, solRulesDesym, signRootMapDesym, signRadMapDesym, diagExtra,
        radicandsRaw, uniqueRadicands, radicandConditions, signVars, signAssumptions, fullAss,
        methodTag, allowGroebner, logMem},

        (* Memory logging helper *)
        logMem[label_String] := If[TrueQ[verbose],
          With[{memGB = N[MemoryInUse[] / 1024^3]},
            Print["[paramQuadSolve] ", label, " | Memory: ", NumberForm[memGB, {4, 2}], " GB"]
          ]
        ];

        (* Debug: print option values *)
        If[TrueQ[verbose],
          Print["[paramQuadSolve] Options: timeout=", timeout, ", simplifyTimeout=", simplifyTimeout,
                ", simpBudget=", simpBudget, ", doValidate=", doValidate]
        ];

        If[methodSpec === $Failed, Return[$Failed]];
        methodTag = methodSpec["Tag"];
        allowGroebner = methodSpec["AllowGroebner"];
        If[NumericQ[timeout] && timeout <= 0, Return[$Failed]];
        (* Input validation *)
        If[vars === {}, Message[paramQuadSolve::emptyvar]; Return[$Failed]];
        If[eqns === {}, Message[paramQuadSolve::emptyeq]; Return[$Failed]];
        t0 = AbsoluteTime[];
        logMem["START"];
        pairsFull = toPolyAndDen /@ eqns;
        logMem["toPolyAndDen done"];
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
        logMem["canonicalizeCoefficients done"];
        (* TimeConstraint returns best simplification found within budget *)
        coeffMap = With[
          {localCoeffMap = coeffMap, localAss = ass, localBudget = simpBudget},
          LocalEvaluate[
            Block[{$HistoryLength = 0},
              Map[Simplify[#, Assumptions -> localAss, TimeConstraint -> localBudget] &, localCoeffMap]
            ]
          ]
        ];
        logMem["Simplify coeffMap done"];
        seqRes = TimeConstrained[
          With[{localCanPolys = canPolys, localVarsToSolve = varsToSolve, localAss = ass,
                localSignHead = signHead, localGbOrder = gbOrderUsed, localAllowGroebner = allowGroebner,
                localGbMemLimit = gbMemLimit, localSimpBudget = simpBudget},
            LocalEvaluate[
              Block[{$HistoryLength = 0},
                sequentialSolve[localCanPolys, localVarsToSolve, localAss, localSignHead,
                                localGbOrder, localAllowGroebner, localGbMemLimit, localSimpBudget]
              ]
            ]
          ],
          N@timeout,
          $Failed
        ];
        logMem["sequentialSolve done"];
        If[!MatchQ[seqRes, {__}], Message[paramQuadSolve::solvefail]; Return[$Failed]];
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
        logMem["FixedPoint substitution done"];
        If[solRules === $Failed, Message[paramQuadSolve::solvefail]; Return[$Failed]];
        signRootMap = Association[signMap];
        (* substitute original coefficient expressions back *)
        solRulesDesym = (solRules /. coeffMap);
        signRootMapDesym = Map[# /. coeffMap &, signRootMap];
        signRadMapDesym  = Map[# /. coeffMap &, Association[signRadMap]];
        signVars = Keys[signRootMapDesym];
        signAssumptions = If[signVars === {}, True, And @@ Thread[(signVars)^2 == 1]];
        fullAss = expandPatternAssumptions[eqns, ass && signAssumptions];
        logMem["coefficient desymbolization done"];
        If[TrueQ[verbose],
          Print["[paramQuadSolve] DATA SIZES BEFORE LocalEvaluate:"];
          Print["  signRootMapDesym: ", Length[signRootMapDesym], " entries, ", ByteCount[signRootMapDesym], " bytes"];
          Print["  signRadMapDesym: ", Length[signRadMapDesym], " entries, ", ByteCount[signRadMapDesym], " bytes"];
          Print["  fullAss: ", ByteCount[fullAss], " bytes"];
        ];
        logMem["BEFORE LocalEvaluate simplifySignMap"];

        (* Apply square root simplification *)
        {signRootMapDesym, signRadMapDesym} = With[
          {localSignRootMap = signRootMapDesym, localSignRadMap = signRadMapDesym, localFullAss = fullAss},
          LocalEvaluate[
            Block[{$HistoryLength = 0},
              simplifySignMap[localSignRootMap, localSignRadMap, localFullAss]
            ]
          ]
        ];
        logMem["LocalEvaluate simplifySignMap done"];
        If[TrueQ[verbose],
          Print["[paramQuadSolve] DATA SIZES AFTER LocalEvaluate:"];
          Print["  signRootMapDesym: ", Length[signRootMapDesym], " entries, ", ByteCount[signRootMapDesym], " bytes"];
          Print["  signRadMapDesym: ", Length[signRadMapDesym], " entries, ", ByteCount[signRadMapDesym], " bytes"];
        ];
        logMem["CHECKPOINT A - before doValidate check"];

        If[TrueQ[doValidate],
          logMem["CHECKPOINT B - inside doValidate block"];
          (* Debug: show sizes before simplification *)
          If[TrueQ[verbose],
            logMem["CHECKPOINT C - before DEBUG prints"];
            Print["[paramQuadSolve] DEBUG: solRulesDesym length=", Length[solRulesDesym],
                  ", bytes=", ByteCount[solRulesDesym]];
            logMem["CHECKPOINT D - after solRulesDesym ByteCount"];
            Print["[paramQuadSolve] DEBUG: fullAss bytes=", ByteCount[fullAss]];
            logMem["CHECKPOINT E - after fullAss ByteCount"];
            Print["[paramQuadSolve] DEBUG: simpBudget=", simpBudget];
            logMem["CHECKPOINT F - after all DEBUG prints"];
          ];
          logMem["BEFORE simplifyWithDummySubstitution solRulesDesym"];
          (* Simplify solRulesDesym using dummy substitution to prevent memory explosion *)
          (* Note: Cannot use LocalEvaluate here because simplifyWithDummySubstitution is not available in local kernel *)
          solRulesDesym = simplifyWithDummySubstitution[solRulesDesym,
            "Assumptions" -> fullAss,
            TimeConstraint -> simpBudget
          ];
          logMem["simplifyWithDummySubstitution solRulesDesym done"];

          (* Simplify signRootMapDesym and signRadMapDesym *)
          signRootMapDesym = KeyValueMap[
            Function[{key, val},
              key -> simplifyWithDummySubstitution[val,
                "Assumptions" -> fullAss,
                TimeConstraint -> simpBudget
              ]
            ],
            signRootMapDesym
          ] // Association;
          logMem["simplifyWithDummySubstitution signRootMapDesym done"];
          signRadMapDesym = KeyValueMap[
            Function[{key, val},
              key -> simplifyWithDummySubstitution[val,
                "Assumptions" -> fullAss,
                TimeConstraint -> simpBudget
              ]
            ],
            signRadMapDesym
          ] // Association;
          logMem["simplifyWithDummySubstitution signRadMapDesym done"];
        ];
        radicandsRaw = Values[signRadMapDesym];
        uniqueRadicands = DeleteDuplicates[radicandsRaw];
        radicandConditions =
          If[domain === Reals,
            If[uniqueRadicands === {},
              {},
              Flatten@{TimeConstrained[
                Quiet[Simplify[Thread[uniqueRadicands >= 0], Assumptions -> fullAss, TimeConstraint -> simpBudget], {Simplify::time}],
                simpBudget + 0.5,
                Thread[uniqueRadicands >= 0] (* return unchanged on timeout *)
              ]}
            ],
            {}
          ];
        logMem["Simplify radicandConditions done"];
        conditions = DeleteCases[Flatten@{denConds, radicandConditions}, True];
        verif = If[TrueQ[doValidate],
          TimeConstrained[
            With[{localEqnsUsed = eqnsUsed, localSolRulesDesym = solRulesDesym,
                  localSignHead = signHead, localFullAss = fullAss, localSimpBudget = simpBudget},
              LocalEvaluate[
                Block[{$HistoryLength = 0},
                  Module[{polys0, exprs, zeroQuick, checked},
                    polys0 = Subtract @@@ localEqnsUsed;
                    exprs = normalizeSigns[polys0 /. localSolRulesDesym, localSignHead];
                    zeroQuick = PossibleZeroQ[#, Assumptions -> localFullAss] & /@ exprs;
                    checked = MapIndexed[
                      Function[{pair, idx},
                        With[{zq = pair[[1]], expr = pair[[2]]},
                          If[zq === True,
                            True,
                            Module[{noAss, withAss},
                              noAss = TimeConstrained[
                                Quiet[Simplify[expr == 0, TimeConstraint -> localSimpBudget], {Simplify::time}],
                                localSimpBudget + 0.5,
                                expr == 0 (* unchanged on timeout *)
                              ];
                              If[TrueQ[noAss],
                                True,
                                withAss = TimeConstrained[
                                  Quiet[Simplify[expr == 0, Assumptions -> localFullAss, TimeConstraint -> localSimpBudget], {Simplify::time}],
                                  localSimpBudget + 0.5,
                                  expr == 0
                                ];
                                withAss
                              ]
                            ]
                          ]
                        ]
                      ],
                      Transpose[{zeroQuick, exprs}]
                    ];
                    checked
                  ]
                ]
              ]
            ],
            N@timeout,
            $Failed
          ],
          Missing["NotEvaluated"]
        ];
        logMem["Verification done"];
        t1 = AbsoluteTime[];
        logMem["END"];
        out = <|
          "Solution" -> Sort@solRulesDesym,
          "SignRootMap" -> signRootMapDesym,
          "Maps" -> <|
		          "Solution" -> solRules,
		          "SignRootMap" -> signRootMap,
		          "SignRadicandMap" -> signRadMap,
		          "CoeffMap" -> coeffMap
	          |>,
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


(* ::Subsubsection:: *)
(*toPolyAndDen*)


toPolyAndDen[eq_] := Module[{lhs, rhs, expr, num, den},
  If[MatchQ[eq, _Equal], lhs = eq[[1]]; rhs = eq[[2]];, lhs = eq; rhs = 0;];
  expr = Together[lhs - rhs];
  num = Numerator[expr];
  den = Denominator[expr];
  num = Expand[num];
  {num, den}
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


(* ::Subsubsection:: *)
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


solveLinearFor[poly_, v_, ass_, simplifyTC_: 5] := Module[{a, b, rhs},
  a = Coefficient[poly, v, 1];
  b = Quiet[Simplify[poly /. v -> 0, Assumptions -> ass, TimeConstraint -> simplifyTC], {Simplify::time}];
  If[a === 0 || PossibleZeroQ[a, Assumptions -> ass], $Failed,
    rhs = Quiet[Simplify[-b/a, Assumptions -> ass, TimeConstraint -> simplifyTC], {Simplify::time}];
    {v -> rhs, <||>, <||>}
  ]
];


(* ::Subsubsection::Closed:: *)
(*quadraticSolveParam*)


quadraticSolveParam[poly_, v_, signGen_, ass_, simplifyTC_: 5] := Module[{a, b, c, delta, alpha, beta, s, rule},
  a = Coefficient[poly, v, 2];
  b = Coefficient[poly, v, 1];
  c = Quiet[Simplify[poly /. v -> 0, Assumptions -> ass, TimeConstraint -> simplifyTC], {Simplify::time}];
  If[a === 0 || PossibleZeroQ[a, Assumptions -> ass], Return[solveLinearFor[poly, v, ass, simplifyTC]]];
  delta = Quiet[Simplify[b^2 - 4 a c, Assumptions -> ass, TimeConstraint -> simplifyTC], {Simplify::time}];
  s = signGen[];
  alpha = Quiet[Simplify[-b/(2 a), Assumptions -> ass, TimeConstraint -> simplifyTC], {Simplify::time}];
  beta  = Quiet[Simplify[1/(2 a), Assumptions -> ass, TimeConstraint -> simplifyTC], {Simplify::time}];
  rule = v -> Quiet[Simplify[(alpha + beta*s*Sqrt[delta]), Assumptions -> ass, TimeConstraint -> simplifyTC], {Simplify::time}];
  {rule, <|s -> Sqrt[delta]|>, <|s -> delta|>}
];


(* ::Subsubsection::Closed:: *)
(*quarticSolveParam*)


quarticSolveParam[poly_, v_, signGen_, ass_, simplifyTC_: 5] := Module[
  {px = Expand[poly], lc, norm, a3, a2, a1, a0, shift, p, q, r,
   mVar, mSolutions, m, radR, radicalR, sign1, sign2, inner, exprY, exprV, rule, signAssoc, radAssoc,
   wDelta, sW, sY, wExpr, simp},
  simp[expr_] := Quiet[Simplify[expr, Assumptions -> ass, TimeConstraint -> simplifyTC], {Simplify::time}];
  lc = Coefficient[px, v, 4];
  If[lc === 0, Return[$Failed]];
  norm = Expand[px/lc];
  a3 = Coefficient[norm, v, 3];
  a2 = Coefficient[norm, v, 2];
  a1 = Coefficient[norm, v, 1];
  a0 = Coefficient[norm, v, 0];
  shift = simp[a3/4];
  p = simp[a2 - 3 a3^2/8];
  q = simp[a1 - (a2 a3)/2 + a3^3/8];
  r = simp[a0 - (a1 a3)/4 + (a2 a3^2)/16 - 3 a3^4/256];
  If[simp[q == 0] === True,
    (* Biquadratic: y^4 + p y^2 + r = 0 *)
    wDelta = simp[p^2/4 - r];
    sW = signGen[];
    wExpr = simp[-p/2 + sW*Sqrt[wDelta]];
    sY = signGen[];
    exprY = simp[sY*Sqrt[wExpr]];
    exprV = simp[exprY - shift];
    rule = v -> exprV;
    signAssoc = <|sW -> Sqrt[wDelta], sY -> Sqrt[wExpr]|>;
    radAssoc  = <|sW -> wDelta,           sY -> wExpr|>;
    Return[{rule, signAssoc, radAssoc}];
  ];
  mVar = Unique["m"];
  mSolutions = Solve[mVar^3 - (p/2) mVar^2 - r mVar + (p r)/2 - q^2/8 == 0, mVar];
  If[mSolutions === {}, Return[$Failed]];
  Module[{candidates, picked},
    candidates = simp /@ (mVar /. mSolutions);
    picked = SelectFirst[
      candidates,
      With[{rad = simp[2 # - p]},
        Not[rad === 0 || PossibleZeroQ[rad, Assumptions -> ass]]
      ] &,
      Missing["NoCandidate"]
    ];
    If[picked === Missing["NoCandidate"], Return[$Failed]];
    m = picked;
    radR = simp[2 m - p];
  ];
  If[radR === 0 || PossibleZeroQ[radR, Assumptions -> ass], Return[$Failed]];
  radicalR = Sqrt[radR];
  sign2 = signGen[];
  sign1 = signGen[];
  inner = Sqrt[simp[-2 m - p - (2 q/radicalR) sign2]];
  exprY = simp[(sign2*radicalR)/2 + (sign1*inner)/2];
  exprV = simp[exprY - shift];
  rule = v -> exprV;
  signAssoc = <|sign2 -> radicalR, sign1 -> inner|>;
  radAssoc  = <|sign2 -> radR, sign1 -> simp[-2 m - p - (2 q/radicalR) sign2]|>;
  {rule, signAssoc, radAssoc}
];


(* ::Subsubsection::Closed:: *)
(*simplifySquareRoot*)


(* Simplify a square root expression Sqrt[radicand].
   Uses FullSimplify with FactorTerms to simplify the radicand.

   Single expression form:
     simplifySquareRoot[radicand, assumptions, timeConstraint]

   Multiple transforms form (tries each and picks best by LeafCount):
     simplifySquareRoot[radicand, {transform1, transform2, ...}, assumptions, timeConstraint]
*)
simplifySquareRoot[radicand_, ass : Except[_List] : Automatic, tc_: 5] := Module[{expr, simplified},
  expr = Sqrt[radicand];

  (* Apply FullSimplify with FactorTerms on numerator/denominator *)
  simplified = Quiet[
    FullSimplify[
      expr /. Sqrt[z_] :> Sqrt[FactorTerms[Numerator@z]]/Sqrt[FactorTerms[Denominator@z]],
      Assumptions -> Replace[ass, Automatic -> defaultAssumptions[]],
      TimeConstraint -> tc
    ],
    {FullSimplify::time}
  ];

  simplified
];

(* Overload that tries multiple parameter transformations and picks the best one *)
simplifySquareRoot[radicand_, transforms_List /; VectorQ[transforms, ListQ], ass : Except[_List] : Automatic, tc_: 5] :=
  Module[{results},
    results = Table[
      simplifySquareRoot[radicand /. transform, ass, tc],
      {transform, transforms}
    ];
    First[MinimalBy[results, LeafCount, 1]]
  ];


(* ::Subsubsection:: *)
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


(* ::Subsubsection:: *)
(*simplifyWithDummySubstitution*)


(* Simplify an expression by temporarily replacing Exp, Tanh, and Sqrt subexpressions
   with dummy symbols to prevent memory explosion during Simplify.

   Single expression form:
     simplifyWithDummySubstitution[expr, opts]

   List of rules form (simplifies RHS of each rule):
     simplifyWithDummySubstitution[{lhs1 -> rhs1, ...}, opts]
*)
simplifyWithDummySubstitution[expr_, opts:OptionsPattern[{simplifyWithDummySubstitution, Simplify}]] := Module[
  {ass, level0Pattern, simplifyFn, simplifyOpts, baseLevel0Symbols, expToDummy, expTransformRules,
   tanhTransformRules, dummyToExp, dummyToTanh, sqrtToDummy, dummyToSqrt,
   sqrtDummies, expDummies, dummyPositiveAss, augmentedAss,
   allTransformRules, allRestoreRules, exprTransformed, allSqrtRadicands},

  (* Extract our custom options *)
  (* True means inherit from outer Assuming context via $Assumptions *)
  ass = Replace[OptionValue["Assumptions"], {Automatic -> defaultAssumptions[], True -> $Assumptions}];
  level0Pattern = OptionValue["Level0Pattern"];
  simplifyFn = OptionValue["SimplifyFunction"];
  (* Pass through Simplify options directly *)
  simplifyOpts = FilterRules[Flatten[{opts}], Options[Simplify]];
  (* Step 1: Find level-0 symbols and create exp transform rules *)
  baseLevel0Symbols = Union[Cases[expr, level0Pattern, Infinity]];

  expToDummy = Association[Map[
    # -> Symbol["expPlaceholder$" <> ToString[Hash[#]]] &,
    baseLevel0Symbols
  ]];

  expTransformRules = Map[# -> Log[expToDummy[#]] &, baseLevel0Symbols];

  (* Step 1b: Create tanh transform rules *)
  tanhTransformRules = Map[
    With[{d = expToDummy[#]}, Tanh[#/2] -> (d - 1)/(d + 1)] &,
    baseLevel0Symbols
  ];

  (* Restore rules *)
  dummyToExp = Map[expToDummy[#] -> Exp[#] &, baseLevel0Symbols];
  dummyToTanh = Map[
    With[{d = expToDummy[#]}, (d - 1)/(d + 1) -> Tanh[#/2]] &,
    baseLevel0Symbols
  ];

  (* Step 2: Apply exp/tanh transforms, then extract Sqrt radicands *)
  exprTransformed = expr /. Join[tanhTransformRules, expTransformRules];
  allSqrtRadicands = Union[Cases[exprTransformed, Power[x_, Rational[1, 2]] :> x, {0, Infinity}]];

  sqrtToDummy = Map[
    Sqrt[#] -> Symbol["sqrtPlaceholder$" <> ToString[Hash[#]]] &,
    allSqrtRadicands
  ];
  dummyToSqrt = Map[
    Symbol["sqrtPlaceholder$" <> ToString[Hash[#]]] -> Sqrt[#] &,
    allSqrtRadicands
  ];

  (* Step 3: Build augmented assumptions *)
  sqrtDummies = Cases[sqrtToDummy, Rule[_, sym_Symbol] :> sym];
  expDummies = Values[expToDummy];
  dummyPositiveAss = And @@ Map[# > 0 &, Join[expDummies, sqrtDummies]];
  augmentedAss = And[ass, dummyPositiveAss];

  (* Combine rules *)
  allTransformRules = Join[tanhTransformRules, expTransformRules, sqrtToDummy];
  allRestoreRules = Join[dummyToTanh, dummyToExp, dummyToSqrt];

  (* Step 4: Transform, simplify with Assuming, restore *)
  (* Extract TimeConstraint for outer TimeConstrained wrapper as a hard timeout *)
  Module[{tcOpts, tcVal, transformed, simplified},
    tcOpts = Cases[simplifyOpts, HoldPattern[TimeConstraint -> v_] :> v];
    tcVal = If[tcOpts === {}, 60, First[tcOpts]]; (* default 60s hard timeout *)
    (* Handle nested TimeConstraint format {perStep, total} *)
    tcVal = If[ListQ[tcVal], Last[tcVal] + 1, tcVal + 1]; (* add 1s buffer over soft timeout *)

    transformed = expr /. allTransformRules;

    (* Use LocalEvaluate for memory isolation and TimeConstrained for hard timeout *)
    simplified = LocalEvaluate[
      Block[{$HistoryLength = 0},
        TimeConstrained[
          Assuming[augmentedAss,
            Quiet[simplifyFn[transformed, Sequence @@ simplifyOpts], {Simplify::time, FullSimplify::time}]
          ],
          tcVal,
          transformed (* return transformed but unsimplified on timeout *)
        ]
      ]
    ];

    simplified /. allRestoreRules
  ]
];

(* Overload for list of rules - simplify RHS of each with garbage collection hints *)
simplifyWithDummySubstitution[rules:{__Rule}, opts:OptionsPattern[]] := Module[
  {n = Length[rules], result},
  (* Process each rule individually with memory management *)
  Table[
    result = rules[[i, 1]] -> simplifyWithDummySubstitution[rules[[i, 2]], opts];
    (* Clear system cache periodically to prevent memory accumulation *)
    If[Mod[i, 2] == 0, ClearSystemCache[]];
    result,
    {i, n}
  ]
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


(* ::Subsubsection:: *)
(*sequentialSolve*)


sequentialSolve[polys_List, vars_List, ass_, signHead_, gbOrder_, allowGroebner_, gbMemLimit_, simplifyTC_: 5] := Module[
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
        res = solveLinearFor[peq, v, ass, simplifyTC];
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
            res = solveLinearFor[peq, v, ass, simplifyTC];
            If[res === $Failed, Break[]];
            AppendTo[steps, {"linear", v}];
            solved[v] = res[[1, 2]];
            KeyValueMap[(signMap[#1] = #2) &, res[[2]]];
            If[Length[res] >= 3, KeyValueMap[(radMap[#1] = #2) &, res[[3]]]];
            unsolved = DeleteCases[unsolved, v];
            eqs = Delete[eqs, bestIndex] /. res[[1]];
            Continue[],
          degree == 2,
            res = quadraticSolveParam[peq, v, signGen, ass, simplifyTC];
            If[res === $Failed, Break[]];
            AppendTo[steps, {"quadratic", v}];
            solved[v] = res[[1, 2]];
            KeyValueMap[(signMap[#1] = #2) &, res[[2]]];
            If[Length[res] >= 3, KeyValueMap[(radMap[#1] = #2) &, res[[3]]]];
            unsolved = DeleteCases[unsolved, v];
            eqs = Delete[eqs, bestIndex] /. res[[1]];
            Continue[],
          degree == 4,
            res = quarticSolveParam[peq, v, signGen, ass, simplifyTC];
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
      (* Use MemoryConstrained with GroebnerWalk for better performance *)
      gb = Quiet@Check[
        MemoryConstrained[
          GroebnerBasis[eqs, unsolved,
            Method -> {"GroebnerWalk", "InitialMonomialOrder" -> DegreeReverseLexicographic},
            MonomialOrder -> gbOrderClean
          ],
          gbMemLimit,
          (Message[paramQuadSolve::gbmem, Round[gbMemLimit/1024^3]]; $Failed)
        ],
        $Failed
      ];
      If[gb === $Failed,
        (* Don't emit badorder message if it was a memory failure *)
        Break[];
      ];
      uni = SelectFirst[gb, (varsInPoly[#, unsolved] === {last} && varDegree[#, last] <= 2) & , Missing["NotFound"]];
      If[uni === Missing["NotFound"], Break[]];
      res = quadraticSolveParam[uni, last, signGen, ass, simplifyTC];
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


(* ::Subsection:: *)
(*expandPatternAssumptions*)


expandPatternAssumptions[expr_, ass_] :=
  And @@ DeleteCases[
    If[Head@ass === And, List @@ ass, {ass}] /.
      (op : (Element | Greater | GreaterEqual | Less | LessEqual | Equal | Unequal))[p_, v_] /;
        !FreeQ[p, Blank | BlankSequence | BlankNullSequence] :>
          Sequence @@ (op[#, v] & /@ DeleteDuplicates@Cases[expr, p, {0, Infinity}]),
    True
  ]


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
