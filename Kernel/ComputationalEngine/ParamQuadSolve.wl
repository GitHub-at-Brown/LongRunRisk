(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


(* ::Subsection:: *)
(*Public symbols*)


paramQuadSolve
expandPatternAssumptions


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


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];

(* OS-level memory usage (sum of WolframKernel RSS, in GB) *)
wolframKernelMemoryGB[] := Module[{raw, kb},
  raw = Quiet@Import["!ps -axo rss,comm | grep -i '[W]olframKernel' | awk '{sum+=$1} END {print sum}'", "String"];
  kb = Quiet@Check[ToExpression@StringTrim[raw], $Failed];
  If[NumberQ[kb], N[kb/1024.^2], Missing["NotAvailable"]]
];


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
  "GroebnerMemoryCap" -> 16*1024^3  (* maximum memory limit in bytes *)
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
      gbMemCap        = OptionValue["GroebnerMemoryCap"]
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
        methodTag, allowGroebner, logPQS},
        (* Memory logging for paramQuadSolve internals *)
        logPQS[label_] := Module[{memGB = N[MemoryInUse[]/1024^3], kernelGB = wolframKernelMemoryGB[]},
          Print[
            "      paramQuadSolve: ", label,
            " | Memory: ", NumberForm[memGB, {5, 2}], " GB",
            " | KernelRSS: ", If[NumberQ[kernelGB], NumberForm[kernelGB, {5, 2}], "n/a"], " GB"
          ]
        ];
        If[methodSpec === $Failed, Return[$Failed]];
        methodTag = methodSpec["Tag"];
        allowGroebner = methodSpec["AllowGroebner"];
        If[NumericQ[timeout] && timeout <= 0, Return[$Failed]];
        (* Input validation *)
        If[vars === {}, Message[paramQuadSolve::emptyvar]; Return[$Failed]];
        If[eqns === {}, Message[paramQuadSolve::emptyeq]; Return[$Failed]];
        t0 = AbsoluteTime[];
        logPQS["START"];
        logPQS["BEFORE toPolyAndDen (" <> ToString[Length[eqns]] <> " eqs)"];
        pairsFull = MapIndexed[
          (logPQS["  toPolyAndDen eq " <> ToString[#2[[1]]] <> "/" <> ToString[Length[eqns]] <>
                  " bytes=" <> ToString[ByteCount[#1]]];
           toPolyAndDen[#1]) &,
          eqns
        ];
        logPQS["AFTER toPolyAndDen"];
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
        logPQS["after setup"];
        denConds = collectDenominatorConditions[dens];
        logPQS["BEFORE canonicalizeCoefficients (" <> ToString[Length[eqPolys]] <> " polys, " <>
               ToString[Length[varsToSolve]] <> " vars, polyBytes=" <> ToString[Total[ByteCount /@ eqPolys]] <> ")"];
        {canPolys, coeffMap} = canonicalizeCoefficients[eqPolys, varsToSolve];
        logPQS["AFTER canonicalizeCoefficients (coeffMap size=" <> ToString[Length[coeffMap]] <>
               ", coeffMapBytes=" <> ToString[ByteCount[coeffMap]] <> ")"];
        (* TimeConstraint returns best simplification found within budget *)
        logPQS["BEFORE Simplify coeffMap"];
        coeffMap = Map[
          Simplify[#, Assumptions -> ass, TimeConstraint -> simpBudget] &,
          coeffMap
        ];
        logPQS["AFTER Simplify coeffMap"];
        seqRes = TimeConstrained[sequentialSolve[canPolys, varsToSolve, ass, signHead, gbOrderUsed, allowGroebner, gbMemLimit, simpBudget], N@timeout, $Failed];
        logPQS["after sequentialSolve"];
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
        If[solRules === $Failed, Message[paramQuadSolve::solvefail]; Return[$Failed]];
        signRootMap = Association[signMap];
        (* substitute original coefficient expressions back *)
        solRulesDesym = (solRules /. coeffMap);
        signRootMapDesym = Map[# /. coeffMap &, signRootMap];
        signRadMapDesym  = Map[# /. coeffMap &, Association[signRadMap]];
        signVars = Keys[signRootMapDesym];
        signAssumptions = If[signVars === {}, True, And @@ Thread[(signVars)^2 == 1]];
        fullAss = expandPatternAssumptions[eqns, ass && signAssumptions];
        logPQS["after desym substitution"];

        (* Apply square root simplification *)
        {signRootMapDesym, signRadMapDesym} = simplifySignMap[signRootMapDesym, signRadMapDesym, fullAss];
        logPQS["after simplifySignMap"];

        (* Debug: capture state before doValidate block for testing *)
        If[$Notebooks === True,
          Module[{debugState},
            debugState = <|
              "vars" -> vars,
              "solRulesDesym" -> solRulesDesym,
              "signRootMapDesym" -> signRootMapDesym,
              "signRadMapDesym" -> signRadMapDesym,
              "fullAss" -> fullAss,
              "simpBudget" -> simpBudget
            |>;
            Put[debugState, "/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/temp/debugStateA.wl"];
            Print["Debug state saved to temp/debugState.wl"];
            Print["  vars: ", vars];
            Print["  solRulesDesym length: ", Length[solRulesDesym], ", bytes: ", ByteCount[solRulesDesym]];
            Print["  signRootMapDesym keys: ", Keys[signRootMapDesym]];
            Print["  signRadMapDesym keys: ", Keys[signRadMapDesym]];
          ]
        ];

        If[TrueQ[doValidate],
          (* TimeConstraint returns best simplification found within budget *)
          (* Replace Sqrt, Exp, and Tanh expressions with dummy symbols to prevent memory explosion during Simplify *)
          Module[{level0Pattern, baseLevel0Symbols, expToDummy, expTransformRules, tanhTransformRules,
                  dummyToExp, dummyToTanh, sqrtToDummy, dummyToSqrt, sqrtDummies, expDummies,
                  dummyPositiveAss, augmentedAss, allTransformRules, allRestoreRules},
            logPQS["BEFORE validate simplify solRulesDesym (len=" <> ToString[Length[solRulesDesym]] <>
                   ", bytes=" <> ToString[ByteCount[solRulesDesym]] <> ")"];

            (* Step 1: Create rules to replace level-0 symbols with Log[dummy] *)
            (* This handles E^(a*A[0] + b*B[j][0]) -> dummyA^a * dummyB^b automatically *)
            level0Pattern = _Symbol[0] | _Symbol[_][0];
            baseLevel0Symbols = Union[Cases[solRulesDesym, level0Pattern, Infinity]];

            expToDummy = Association[Map[
              # -> Symbol["expPlaceholder$" <> ToString[Hash[#]]] &,
              baseLevel0Symbols
            ]];

            (* Replace sym -> Log[dummy], so E^(n*sym) becomes dummy^n *)
            expTransformRules = Map[
              # -> Log[expToDummy[#]] &,
              baseLevel0Symbols
            ];

            (* Step 1b: Create rules to replace Tanh[sym/2] with (dummy - 1)/(dummy + 1) *)
            (* This is needed because Tanh[A[0]/2] = (E^A[0] - 1)/(E^A[0] + 1) *)
            (* Without this, Tanh[Log[dummy]/2] creates complex expressions *)
            tanhTransformRules = Map[
              With[{d = expToDummy[#]}, Tanh[#/2] -> (d - 1)/(d + 1)] &,
              baseLevel0Symbols
            ];

            (* To restore: dummy -> E^sym *)
            dummyToExp = Map[expToDummy[#] -> Exp[#] &, baseLevel0Symbols];
            (* To restore Tanh: (dummy - 1)/(dummy + 1) -> Tanh[sym/2] *)
            dummyToTanh = Map[
              With[{d = expToDummy[#]}, (d - 1)/(d + 1) -> Tanh[#/2]] &,
              baseLevel0Symbols
            ];

            (* Step 2: Apply exp and tanh transforms first, then extract ALL Sqrt expressions *)
            (* This is more robust than extracting from signRootMapDesym since solRulesDesym *)
            (* may have Sqrt expressions with different factorizations *)
            Module[{solRulesPartiallyTransformed, allSqrtRadicands},
              solRulesPartiallyTransformed = solRulesDesym /. Join[tanhTransformRules, expTransformRules];

              (* Find all unique Sqrt radicands in the partially transformed expressions *)
              allSqrtRadicands = Union[Cases[solRulesPartiallyTransformed, Power[x_, Rational[1, 2]] :> x, Infinity]];

              (* Create dummy for each unique Sqrt radicand *)
              sqrtToDummy = Map[
                Sqrt[#] -> Symbol["sqrtPlaceholder$" <> ToString[Hash[#]]] &,
                allSqrtRadicands
              ];

              (* dummyToSqrt restores each Sqrt *)
              dummyToSqrt = Map[
                Symbol["sqrtPlaceholder$" <> ToString[Hash[#]]] -> Sqrt[#] &,
                allSqrtRadicands
              ];
            ];

            (* Step 3: Build augmented assumptions with positivity for dummies *)
            sqrtDummies = Cases[sqrtToDummy, Rule[_, sym_Symbol] :> sym];
            expDummies = Values[expToDummy];
            dummyPositiveAss = And @@ Map[# > 0 &, Join[expDummies, sqrtDummies]];
            augmentedAss = And[fullAss, dummyPositiveAss];

            (* Combine all transform and restore rules *)
            (* Order matters: tanhTransformRules first (exact match), then expTransformRules, then sqrtToDummy *)
            allTransformRules = Join[tanhTransformRules, expTransformRules, sqrtToDummy];
            allRestoreRules = Join[dummyToTanh, dummyToExp, dummyToSqrt];

            (* Step 4: Apply all transforms, simplify with HARD timeout, then restore *)
            (* TimeConstrained provides hard cutoff; TimeConstraint is soft and often ignored *)
            solRulesDesym = Map[
              Function[rule, Module[{transformed, simplified},
                transformed = rule[[2]] /. allTransformRules;
                simplified = TimeConstrained[
                  Quiet[Simplify[transformed, Assumptions -> augmentedAss, TimeConstraint -> simpBudget], {Simplify::time}],
                  simpBudget + 0.5, (* hard timeout slightly above soft *)
                  transformed (* return unchanged on timeout *)
                ];
                rule[[1]] -> (simplified /. allRestoreRules)
              ]],
              solRulesDesym
            ];
            logPQS["after validate simplify solRulesDesym"];
            logPQS["BEFORE simplify signRootMapDesym (len=" <> ToString[Length[signRootMapDesym]] <>
                   ", bytes=" <> ToString[ByteCount[signRootMapDesym]] <> ")"];
            signRootMapDesym = KeyValueMap[
              Function[{key, val},
                key -> TimeConstrained[
                  Quiet[Simplify[val, Assumptions -> augmentedAss, TimeConstraint -> simpBudget], {Simplify::time}],
                  simpBudget + 0.5,
                  val
                ]
              ],
              signRootMapDesym
            ] // Association;
            logPQS["AFTER simplify signRootMapDesym"];
            logPQS["BEFORE simplify signRadMapDesym (len=" <> ToString[Length[signRadMapDesym]] <>
                   ", bytes=" <> ToString[ByteCount[signRadMapDesym]] <> ")"];
            signRadMapDesym = KeyValueMap[
              Function[{key, val},
                key -> TimeConstrained[
                  Quiet[Simplify[val, Assumptions -> augmentedAss, TimeConstraint -> simpBudget], {Simplify::time}],
                  simpBudget + 0.5,
                  val
                ]
              ],
              signRadMapDesym
            ] // Association;
            logPQS["AFTER simplify signRadMapDesym"];
            logPQS["after validate simplify signMaps"];
          ]; (* end Module for dummy replacement *)
        ];
        logPQS["after doValidate block"];
        radicandsRaw = Values[signRadMapDesym];
        uniqueRadicands = DeleteDuplicates[radicandsRaw];
        logPQS["BEFORE radicandConditions (uniqueRadicands len=" <> ToString[Length[uniqueRadicands]] <>
               ", bytes=" <> ToString[ByteCount[uniqueRadicands]] <> ")"];
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
        logPQS["AFTER radicandConditions"];
        conditions = DeleteCases[Flatten@{denConds, radicandConditions}, True];
        logPQS["BEFORE verif block"];
        verif = If[TrueQ[doValidate],
          TimeConstrained[
            Module[{polys0, exprs, zeroQuick, checked},
              logPQS["  verif: computing polys0"];
              polys0 = Subtract@@@eqnsUsed;
              logPQS["  verif: computing exprs (polys0 bytes=" <> ToString[ByteCount[polys0]] <> ")"];
              exprs = normalizeSigns[polys0 /. solRulesDesym, signHead];
              logPQS["  verif: BEFORE PossibleZeroQ (exprs len=" <> ToString[Length[exprs]] <>
                     ", bytes=" <> ToString[ByteCount[exprs]] <> ")"];
              zeroQuick = MapIndexed[
                (logPQS["    PossibleZeroQ expr " <> ToString[#2[[1]]] <> "/" <> ToString[Length[exprs]] <>
                        " bytes=" <> ToString[ByteCount[#1]]];
                 PossibleZeroQ[#1, Assumptions -> fullAss]) &,
                exprs
              ];
              logPQS["  verif: AFTER PossibleZeroQ (results=" <> ToString[zeroQuick] <> ")"];
              logPQS["  verif: BEFORE checked Simplify loop"];
              checked = MapIndexed[
                Function[{pair, idx},
                  With[{zq = pair[[1]], expr = pair[[2]]},
                    If[zq === True,
                      True,
                      (logPQS["    checked Simplify idx=" <> ToString[idx[[1]]] <> " exprBytes=" <> ToString[ByteCount[expr]]];
                       Module[{noAss, withAss},
                         logPQS["      Simplify without assumptions"];
                         noAss = TimeConstrained[
                           Quiet[Simplify[expr == 0, TimeConstraint -> simpBudget], {Simplify::time}],
                           simpBudget + 0.5,
                           expr == 0 (* unchanged on timeout *)
                         ];
                         If[TrueQ[noAss],
                           True,
                           (logPQS["      Simplify WITH assumptions"];
                            withAss = TimeConstrained[
                              Quiet[Simplify[expr == 0, Assumptions -> fullAss, TimeConstraint -> simpBudget], {Simplify::time}],
                              simpBudget + 0.5,
                              expr == 0
                            ];
                            withAss)
                         ]
                       ])
                    ]
                  ]
                ],
                Transpose[{zeroQuick, exprs}]
              ];
              logPQS["  verif: AFTER checked Simplify loop"];
              checked
            ],
            N@timeout,
            $Failed
          ],
          Missing["NotEvaluated"]
        ];
        logPQS["AFTER verif block"];
        t1 = AbsoluteTime[];
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


toPolyAndDen[eq_] := Module[{lhs, rhs, expr, num, den, t0, t1, t2},
  If[MatchQ[eq, _Equal], lhs = eq[[1]]; rhs = eq[[2]];, lhs = eq; rhs = 0;];
  t0 = AbsoluteTime[];
  expr = Together[lhs - rhs];
  t1 = AbsoluteTime[];
  num = Numerator[expr];
  den = Denominator[expr];
  num = Expand[num];
  t2 = AbsoluteTime[];
  If[t1 - t0 > 1 || t2 - t1 > 1,
    Print["        toPolyAndDen: Together=", NumberForm[t1 - t0, {4, 2}], "s Expand=", NumberForm[t2 - t1, {4, 2}], "s | numBytes=", ByteCount[num]]
  ];
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
{rulesPer, allCoeffs, symb, cmap = <||>, newPolys, t0, t1, t2, t3, t4, logCC},
logCC[label_] := Module[{memGB = N[MemoryInUse[]/1024^3], kernelGB = wolframKernelMemoryGB[]},
  Print[
    "        canonicalizeCoefficients: ", label,
    " | Memory: ", NumberForm[memGB, {5, 2}], " GB",
    " | KernelRSS: ", If[NumberQ[kernelGB], NumberForm[kernelGB, {5, 2}], "n/a"], " GB"
  ]
];
  symb[c_] := Lookup[cmap, c, With[{s = Unique["c$"]}, cmap[c] = s; s]];
  (* Extract coefficient rules for each poly *)
  t0 = AbsoluteTime[];
  rulesPer = CoefficientRules[#, vars] & /@ polys;
  t1 = AbsoluteTime[];
  logCC["after CoefficientRules (" <> ToString[NumberForm[t1 - t0, {4, 2}]] <> "s, totalRules=" <>
        ToString[Total[Length /@ rulesPer]] <> ")"];
  allCoeffs = Union[Flatten[Values /@ rulesPer]];
  t2 = AbsoluteTime[];
  logCC["after Union allCoeffs (" <> ToString[NumberForm[t2 - t1, {4, 2}]] <> "s, uniqueCoeffs=" <>
        ToString[Length[allCoeffs]] <> ", coeffsBytes=" <> ToString[ByteCount[allCoeffs]] <> ")"];
  (* Build cmap explicitly *)
  Scan[(symb[#]) &, allCoeffs];
  t3 = AbsoluteTime[];
  logCC["after build cmap (" <> ToString[NumberForm[t3 - t2, {4, 2}]] <> "s)"];
  (* Rebuild polynomials with dummy coefficients *)
  newPolys = Map[
    Function[assocList,
      With[{assoc = Association[assocList]},
        Total@KeyValueMap[Function[{exps, coeff}, cmap[coeff] * Times @@ (vars^exps)], assoc]
      ]
    ],
    rulesPer
  ];
  t4 = AbsoluteTime[];
  logCC["after rebuild polys (" <> ToString[NumberForm[t4 - t3, {4, 2}]] <> "s)"];
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
   maxIter = 5 Length[vars], signGen = makeSignGenerator[signHead], gbOrderClean = Replace[gbOrder, Automatic -> Lexicographic],
   logSeq},
  logSeq[label_] := Module[{memGB = N[MemoryInUse[]/1024^3], kernelGB = wolframKernelMemoryGB[]},
    Print[
      "        sequentialSolve: ", label,
      " | Memory: ", NumberForm[memGB, {5, 2}], " GB",
      " | KernelRSS: ", If[NumberQ[kernelGB], NumberForm[kernelGB, {5, 2}], "n/a"], " GB"
    ]
  ];
  logSeq["START (vars=" <> ToString[Length[vars]] <> ")"];
  While[eqs =!= {} && unsolved =!= {} && iter++ < maxIter,
    (* Log each iteration to track expression growth *)
    logSeq["iter=" <> ToString[iter] <> " eqs=" <> ToString[Length[eqs]] <>
           " unsolved=" <> ToString[Length[unsolved]] <>
           " eqBytes=" <> ToString[Round[Total[ByteCount /@ eqs]/1024.]] <> "KB"];
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
      logSeq["BEFORE GroebnerBasis (unsolved=" <> ToString[Length[unsolved]] <> ")"];
      (* Debug Dialog: inspect GroebnerBasis inputs before call - only if front end available *)
      If[$Notebooks =!= True,
        (* No front end - just print summary *)
        Print["        GroebnerBasis inputs: eqs=", Length[eqs], " vars=", Length[unsolved],
              " eqBytes=", Round[Total[ByteCount /@ eqs]/1024.], "KB"];,
        (* Front end available - show dialog *)
        CreateDialog[{
            TextCell["GroebnerBasis Debug - Inspect inputs before call", "Title"],
            TextCell[
              With[{kernelGB = wolframKernelMemoryGB[]},
                "Memory: " <> ToString[Round[MemoryInUse[]/1024^3, 0.01]] <> " GB" <>
                " | KernelRSS: " <> If[NumberQ[kernelGB], ToString[NumberForm[kernelGB, {5, 2}]], "n/a"] <> " GB"
              ],
              "Subtitle"
            ],
            TextCell["Number of equations: " <> ToString[Length[eqs]], "Text"],
            TextCell["Number of variables: " <> ToString[Length[unsolved]], "Text"],
            TextCell["Total ByteCount of eqs: " <> ToString[Round[Total[ByteCount /@ eqs]/1024., 0.1]] <> " KB", "Text"],
            TextCell["Max ByteCount per eq: " <> ToString[Round[Max[ByteCount /@ eqs]/1024., 0.1]] <> " KB", "Text"],
            TextCell["gbMemLimit: " <> ToString[Round[gbMemLimit/1024^3, 0.1]] <> " GB", "Text"],
            TextCell["MonomialOrder: " <> ToString[gbOrderClean], "Text"],
            TextCell["Variables (unsolved):", "Section"],
            ExpressionCell[unsolved, "Output"],
            TextCell["Equations (eqs):", "Section"],
            ExpressionCell[Short[eqs, 10], "Output"],
            TextCell["Full equations (scroll):", "Section"],
            ExpressionCell[eqs, "Output", CellSize -> {600, 200}, CellMargins -> {{20, 20}, {5, 5}}],
            DefaultButton["Continue", DialogReturn[]]
          },
          Modal -> True
        ]
      ];
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
      logSeq["AFTER GroebnerBasis"];
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
  logSeq["END (solved=" <> ToString[Length[solved]] <> ")"];
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
