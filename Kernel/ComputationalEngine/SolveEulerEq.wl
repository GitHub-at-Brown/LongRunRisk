(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];


(* ::Subsection:: *)
(*Public symbols*)


updateCoeffs
addCoeffsSolutionN
flattenCoeffs
flattenCoeffsBundles


(* ::Subsubsection:: *)
(*Usage*)


updateCoeffs::usage = "updateCoeffs[model] solves for the coefficients of the wealth-consumption ratio, price-dividend ratio, real bonds, and nominal bonds.\n" <>
    "Returns a hierarchical structure: list of A solutions, each containing:\n" <>
    "  - IntervalA, SignsA, SolutionIndexA, IntervalIndexA: metadata\n" <>
    "  - A: coefficient rules for wealth-consumption ratio\n" <>
    "  - Stocks: Association of stock j -> list of B solutions, each with IntervalB, SignsB, B\n" <>
    "  - Bond, NomBond: bond coefficient rules (if computed)\n" <>
    "Use flattenCoeffs[result] to extract all coefficient rules as a flat list.";

addCoeffsSolutionN::usage = "addCoeffsSolutionN[model] computes numerical solutions for all coefficient types (wc, pd, bond, nombond) using default parameters and model extraInfo.";

flattenCoeffs::usage = "flattenCoeffs[updateCoeffsResult] extracts all coefficient rules from the hierarchical structure returned by updateCoeffs.\n" <>
    "flattenCoeffs[result, n] extracts rules from the n-th A solution only.\n" <>
    "flattenCoeffs[result, n, j] extracts A rules and B rules for stock j from the n-th A solution.\n" <>
    "flattenCoeffs[result, n, j, m] extracts A rules and the m-th B solution for stock j from the n-th A solution.";

flattenCoeffsBundles::usage = "flattenCoeffsBundles[updateCoeffsResult] returns a list of complete solution bundles.\n" <>
    "Each bundle is a flat list of rules (A + one B per stock + Bond + NomBond) ready to apply with /. (ReplaceAll).\n" <>
    "Generates Cartesian product: if stock 1 has 2 B solutions and stock 2 has 3, returns 6 bundles.\n" <>
    "flattenCoeffsBundles[result, n] returns bundles for the n-th A solution only.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Tools`ToNumber`"];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];

$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"];
$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"];


(* ::Subsection:: *)
(*nD Root-Finding Helpers*)


(* Step 1: safeReduceCall - wraps findRootInterval with timeout for nD *)
safeReduceCall[conds_, paramsAll_, signs_, cName_, sName_, findOpts_, timeout_] :=
  TimeConstrained[
    findRootInterval[conds, paramsAll,
      "Signs" -> signs, "CoeffName" -> cName, "SignSymbol" -> sName, Sequence @@ findOpts],
    timeout,
    $Failed
  ];


(* Step 2: convertInfinityBounds - converts Infinity to finite bounds for x0 computation *)
convertInfinityBounds[a_List, b_List, pad_?NumericQ] := {
  a /. -Infinity -> -pad,
  b /. Infinity -> pad
};


(* Step 3: trySmartIntervals - attempts root-finding with Reduce-derived intervals *)
trySmartIntervals[f_, df_, reduceExpr_, coefList_, extractOpts_, scanOpts_, rub_, pad_] :=
  Module[{intervals, finalRoots = {}, finalIntervals = {}},
    If[reduceExpr === $Failed, Return[$Failed]];

    intervals = extractIntervalsFromReduce[reduceExpr, coefList,
      "UnboundedPad" -> Infinity, Sequence @@ extractOpts];

    If[intervals === {} || intervals === $Failed, Return[$Failed]];

    Scan[
      Function[{iv},
        Module[{a, b, aFinite, bFinite, x0, frRes},
          (* iv = {lowerVector, upperVector} for nD *)
          a = iv[[1]];  (* lower bounds vector *)
          b = iv[[2]];  (* upper bounds vector *)
          (* Convert Infinity to finite for initial guess computation *)
          {aFinite, bFinite} = convertInfinityBounds[a, b, pad];
          (* Heuristic x0 *)
          x0 = MapThread[
            Which[
              NumericQ[#1] && NumericQ[#2], (#1 + #2)/2.,
              #1 === -Infinity && #2 === Infinity, 0.,
              NumericQ[#1], #1 + 1.,
              NumericQ[#2], #2 - 1.,
              True, 0.
            ] &,
            {a, b}
          ];
          frRes = fastRoot[f, {x0, aFinite, bFinite}, Jacobian -> df, Sequence @@ scanOpts];
          If[!FailureQ[frRes],
            AppendTo[finalRoots, {frRes}];
            AppendTo[finalIntervals, iv]
          ]
        ]
      ],
      intervals
    ];

    If[Length[finalRoots] > 0, {finalRoots, finalIntervals}, $Failed]
  ];


(* Step 4: tryArtificialBox - fallback with artificial finite bounds *)
tryArtificialBox[f_, df_, coefList_, scanOpts_, rub_, pad_] :=
  Module[{d, a, b, x0, frRes, artificialBounds},
    d = Length[coefList];
    artificialBounds = Prepend[ConstantArray[{-pad, pad}, d - 1], {0., rub}];
    a = artificialBounds[[All, 1]];
    b = artificialBounds[[All, 2]];
    x0 = (a + b) / 2.;

    frRes = fastRoot[f, {x0, a, b}, Jacobian -> df, Sequence @@ scanOpts];
    If[!FailureQ[frRes],
      {{{frRes}}, {artificialBounds}},  (* Double-wrap root for Map[..., {2}] compatibility *)
      $Failed
    ]
  ];


(* Step 5: nMinimizeFallback - optimization-based fallback *)
nMinimizeFallback[f_, coefList_, reduceExpr_, rub_, pad_, tol_] :=
  Module[{d, vars, coefToVar, objFn, boxConstraints,
          mappedReduceExpr, constraints, nmRes, artificialBounds},

    d = Length[coefList];
    (* Create unique symbols for NMinimize *)
    vars = Array[Unique["x$"] &, d];
    coefToVar = Thread[coefList -> vars];

    (* Build artificial bounds for result reporting *)
    artificialBounds = Prepend[ConstantArray[{-pad, pad}, d - 1], {0., rub}];

    (* Objective: minimize sum of squared residuals *)
    (* Note: f expects numeric vectors, so define objective as a black-box function *)
    objFn[v_?(VectorQ[#, NumericQ] &)] := Total[f[v]^2];

    (* Box constraints (always used) *)
    boxConstraints = And @@ MapThread[
      #1 <= #2 <= #3 &,
      {artificialBounds[[All, 1]], vars, artificialBounds[[All, 2]]}
    ];

    (* Map reduceExpr coefficients to optimization variables *)
    mappedReduceExpr = If[
      reduceExpr =!= $Failed && reduceExpr =!= True && reduceExpr =!= False,
      reduceExpr /. coefToVar,
      True
    ];

    (* Combine box with mapped reduce constraint *)
    constraints = boxConstraints && mappedReduceExpr;

    nmRes = Quiet @ Check[
      NMinimize[{objFn[vars], constraints}, vars, Method -> "NelderMead"],
      $Failed
    ];

    If[!FailureQ[nmRes] && nmRes[[1]] < tol,
      (* Convert vars back to coefficient values *)
      {{{vars /. nmRes[[2]]}}, {artificialBounds}},  (* Wrap interval in list for MapThread *)
      $Failed
    ]
  ];


(* Step 6: solveND - orchestrates the nD fallback chain *)
solveND // Options = {
  "ReduceTimeLimit" -> 5.
};

solveND[f_, df_, conds_, paramsAll_, signs_, coefList_, cName_, sName_,
        findOpts_, extractOpts_, scanOpts_, solTemplate_,
        opts : OptionsPattern[{solveND}]] :=
  Module[{reduceExpr, rub, pad, acc, tol, signHead, signsRule, sol, result},

    (* Extract options from extractIntervalsFromReduce *)
    rub = Lookup[Flatten@{extractOpts}, "RootUpperBound", 15.];
    pad = Lookup[Flatten@{extractOpts}, "UnboundedPad", 1.*^5];
    acc = AccuracyGoal /. Flatten[{scanOpts, Options[FindRoot]}] /. AccuracyGoal -> 8;
    tol = 10.^(-acc);

    (* Prepare solution substitution *)
    signHead = If[StringQ[sName], ToExpression[sName], sName];
    signsRule = If[signs === {}, {}, Table[signHead[i] -> signs[[i]], {i, Length@signs}]];
    sol = solTemplate //. paramsAll //. signsRule;

    (* Helper to package result matching original format *)
    packageResult[{rootsList_, intervalsList_}] := Module[{rRules, sRules},
      rRules = Map[Thread[coefList -> #] &, rootsList, {2}];
      sRules = Map[Join[{#}, sol /. #] &, rRules, {2}];
      MapThread[
        <|
          "Interval" -> #1,
          "Roots"    -> #2,
          "Error"    -> (RealAbs /@ (f /@ #2)),  (* Match original: RealAbs, not Norm *)
          "Sol"      -> Association /@ #3,
          "Signs"    -> signs
        |> &,
        {intervalsList, rootsList, sRules}
      ]
    ];

    (* Stage 1: Safe reduce call with timeout *)
    reduceExpr = safeReduceCall[conds, paramsAll, signs, cName, sName,
      findOpts, OptionValue["ReduceTimeLimit"]];

    (* Stage 2: Try smart intervals with Infinity padding *)
    result = trySmartIntervals[f, df, reduceExpr, coefList, extractOpts, scanOpts, rub, pad];
    If[result =!= $Failed, Return[packageResult[result]]];

    (* Stage 3: Try artificial box *)
    result = tryArtificialBox[f, df, coefList, scanOpts, rub, pad];
    If[result =!= $Failed, Return[packageResult[result]]];

    (* Stage 4: NMinimize fallback *)
    result = nMinimizeFallback[f, coefList, reduceExpr, rub, pad, tol];
    If[result =!= $Failed, Return[packageResult[result]]];

    {}  (* All stages failed *)
  ];


(* ::Subsection:: *)
(*loadModelKernels*)


(* Global cache for loaded kernels *)
$kernelCache = <||>;


loadModelKernels::nofile = "Kernel file not found for model `1`. Expected: `2`";
loadModelKernels::sysid = "Kernel was compiled on `1` but current system is `2`. Recompile may be needed.";


(* Find paclet root from current file location - evaluated at package load time *)
$pacletRoot = Module[{d},
  d = DirectoryName[$InputFileName];
  While[!FileExistsQ[FileNameJoin[{d, "PacletInfo.wl"}]] && d =!= DirectoryName[d],
    d = DirectoryName[d]
  ];
  d
];


loadModelKernels[shortname_String] := Module[
  {file, data},

  (* Return cached if available *)
  If[KeyExistsQ[$kernelCache, shortname],
    Return[$kernelCache[shortname]]
  ];

  (* Build file path *)
  file = FileNameJoin[{$pacletRoot, "Resources", "CompiledFunctions", shortname <> ".mx"}];

  (* Check file exists *)
  If[!FileExistsQ[file],
    Message[loadModelKernels::nofile, shortname, file];
    Return[$Failed]
  ];

  (* Load the file *)
  data = Import[file, "MX"];

  (* Warn if SystemID mismatch *)
  If[KeyExistsQ[data, "meta"] && data["meta"]["SystemID"] =!= $SystemID,
    Message[loadModelKernels::sysid, data["meta"]["SystemID"], $SystemID]
  ];

  (* Cache and return *)
  $kernelCache[shortname] = data;
  data
];


loadModelKernels[model_Association] := loadModelKernels[model["shortname"]];


clearKernelCache[] := ($kernelCache = <||>);


(* ::Subsection:: *)
(*updateCoeffsSol*)


updateCoeffsSol//Options={
	"initialGuess" -> <|"Ewc"->{4},"Epd"->{{4}}|>,
	"FindRootOptions"->{MaxIterations->100}, (*"FindRootOptions"->{PrecisionGoal\[Rule]$MachinePrecision,AccuracyGoal\[Rule]$MachinePrecision,WorkingPrecision->$MachinePrecision*)
	"RecurrenceTableOptions"->{"DependentVariables"->Automatic},
	"UpdatePd"->False,
	"UpdateBond"->False,
	"UpdateNomBond"->False,
	"UpdateBonds"->False,
	"MaxMaturity"->12,
	"RootSigns" -> Automatic
				(* 
					All: returns solutions for all square root sign combinations, even if empty
					Automatic: like All but removes empty solutions
					A list like {"wc"->{-1,1},"pd"->{-1,1}} specifying signs
					A list like {"wc"->Automatic,"pd"->{-1,1}} specifying signs| All | Automatic for "wc" and "pd" separately
				*)
};


(* ::Subsubsection:: *)
(*normalizeRootSigns*)


normalizeRootSigns::badsignidx =
  "signIndex must be an Association with \"wc\"/\"pd\" keys; got `1` instead.";

(* Normalize RootSigns option into explicit sign tuples for wc/pd *)
normalizeRootSigns[rootSigns_, signIndex_Association] := Module[
  {base, numSigns, idxFor, makeTuples},

  (* Normalize RootSigns into an Association over {\"wc\",\"pd\"} *)
  base = Replace[rootSigns, {
    Automatic :> <|"wc" -> Automatic, "pd" -> Automatic|>,
    All       :> <|"wc" -> All,       "pd" -> All|>,
    r_        :> Association[r]
  }];

  (* Helper: number of distinct sign slots for each key *)
  idxFor[key_] := Lookup[signIndex, key, {}];
  numSigns = Association @ Map[
    Function[key,
      Module[{idx = idxFor[key], flat},
        flat = Flatten[idx];
        key -> If[flat === {} || flat === {0}, 0, Max[flat]]
      ]
    ],
    {"wc", "pd"}
  ];

  (* Helper: all sign tuples for a given key *)
  makeTuples[key_] := Module[{n = numSigns[key]},
    If[n <= 0, {{}}, Tuples[{-1, 1}, n]]
  ];

  Association @ KeyValueMap[
    Function[{key, spec},
      key -> Which[
        MatchQ[spec, Automatic | All],
          makeTuples[key],
        True,
          Module[{normalized},
            normalized =
              If[!MatchQ[spec, {{___} ..}], {Flatten @ {spec}}, spec];
            If[normalized === {{}}, Table[{}, numSigns[key]], normalized]
          ]
      ]
    ],
    base
  ]
]

(* Fallback when signIndex is not an Association *)
normalizeRootSigns[rootSigns_, signIndex_] := (
  Message[normalizeRootSigns::badsignidx, Head[signIndex]];
  $Failed
)


(* ::Subsubsection:: *)
(*filterSolutions*)


(* filterSolutions: legacy filter for backward compatibility, now handled in updateCoeffsWcPd *)
filterSolutions[solAll_, Automatic] := solAll;
filterSolutions[solAll_, _] := solAll;


(* ::Subsubsection:: *)
(*extractSignIndex*)


extractSignIndex[kernels_Association] := <|
  "wc" -> Lookup[Lookup[kernels, "A", <||>], "SignIndex", {}],
  "pd" -> Lookup[Lookup[kernels, "B", <||>], "SignIndex", {}]
|>;


(* ::Subsubsection:: *)
(*computeWcCoeffs*)


computeWcCoeffs[model_, kernels_, params_, newParams_, rootSignsNorm_, rootSigns_, opts_] :=
  Module[{rawResults},
    rawResults = filterSolutions[
      updateCoeffsWcPd["wc", model["coeffsParamQuadSolve"], kernels,
                       params, newParams, rootSignsNorm, rootSigns, opts],
      rootSigns
    ];
    (* Rename keys to A-specific names *)
    Map[
      <|
        "IntervalA" -> #["Interval"],
        "SignsA" -> #["Signs"],
        "SolutionIndexA" -> #["SolutionIndex"],
        "IntervalIndexA" -> #["IntervalIndex"],
        "A" -> #["Sol"]
      |> &,
      rawResults
    ]
  ];


(* ::Subsubsection:: *)
(*computePdCoeffs*)


computePdCoeffs[model_, kernels_, params_, newParams_, solWc_,
                rootSignsNorm_, rootSigns_, numStocks_, opts_] :=
  Module[{renameToB, computeBForASolution},
    (* For each A solution, compute B solutions for all stocks *)
    (* solWc is now a list of associations with keys: IntervalA, SignsA, SolutionIndexA, IntervalIndexA, A *)

    (* Helper to rename keys to B-specific names *)
    renameToB[bResult_] := <|
      "IntervalB" -> bResult["Interval"],
      "SignsB" -> bResult["Signs"],
      "SolutionIndexB" -> bResult["SolutionIndex"],
      "IntervalIndexB" -> bResult["IntervalIndex"],
      "B" -> bResult["Sol"]
    |>;

    (* For a single A solution, compute B solutions for all stocks *)
    computeBForASolution[aSol_] := Association @ Table[
      jVal -> Map[
        renameToB,
        filterSolutions[
          updateCoeffsWcPd[
            "pd", model["coeffsParamQuadSolve"], kernels, params,
            Join[newParams, <|j -> jVal|>, aSol["A"]],
            rootSignsNorm, rootSigns, opts
          ],
          rootSigns
        ]
      ],
      {jVal, numStocks}
    ];

    (* Return list of B solutions indexed by stock, one per A solution *)
    (* This preserves the A->B mapping: result[[i]] corresponds to solWc[[i]] *)
    Map[computeBForASolution, solWc]
  ];


(* ::Subsubsection:: *)
(*checkCoeffs*)


checkCoeffs[type_String, model_, sol_, params_, newParams_,
            maxMaturity_, numStocks_, opts_] :=
  Switch[type,
    "wc",
      checks[First @ model["coeffsSystem"]["wc"], sol, params, newParams, opts],
    "pd",
      checks[Table[First @ model["coeffsSystem"]["pd"], {j, 1, numStocks}],
             sol, params, newParams, opts],
    "bond",
      checks[Flatten @ Table[First @ model["coeffsSystem"]["bond"], {n, 1, maxMaturity}],
             sol, params, newParams, opts],
    "nombond",
      checks[Flatten @ Table[First @ model["coeffsSystem"]["nombond"], {n, 1, maxMaturity}],
             sol, params, newParams, opts]
  ];


(* ::Subsection:: *)
(*updateCoeffsWcPd*)


updateCoeffsWcPd[key : "wc" | "pd", coeffsParamQuadSolve_Association, kernels_, params_Association, newParams_Association, rootSignsNorm_, rootSigns_,
  solveCoeffRootsOpts_] :=
    With[{kernelKey = <|"wc" -> "A", "pd" -> "B"|>[key]},
      Module[{solAll, flattenedWithMeta, intervalIdx, solIdx},
        (* solAll structure: list of {list of <|"Interval"->..., "Signs"->..., "Sol"->...|>} per sign combo *)
        solAll = solveCoeffRoots[
          coeffsParamQuadSolve[key],
          kernels[kernelKey],
          params,
          #,
          newParams,
          solveCoeffRootsOpts
        ] & /@ rootSignsNorm[key];

        (* Flatten while preserving metadata: add interval index and solution index *)
        flattenedWithMeta = Flatten @ MapIndexed[
          Function[{signResults, signPos},
            (* signResults is list of associations for one sign combination *)
            MapIndexed[
              Function[{intervalResult, intervalPos},
                intervalIdx = intervalPos[[1]];
                (* intervalResult has "Interval", "Signs", "Sol" (list of associations) *)
                MapIndexed[
                  Function[{solAssoc, solPos},
                    solIdx = solPos[[1]];
                    <|
                      "Interval" -> intervalResult["Interval"],
                      "Signs" -> intervalResult["Signs"],
                      "SolutionIndex" -> solIdx,
                      "IntervalIndex" -> intervalIdx,
                      "Sol" -> solAssoc
                    |>
                  ],
                  intervalResult["Sol"]
                ]
              ],
              signResults
            ]
          ],
          solAll
        ];

        (* Filter empty solutions if Automatic *)
        If[MatchQ[rootSigns, Automatic | KeyValuePattern[key -> Automatic]],
          Select[flattenedWithMeta, AssociationQ[#["Sol"]] && Length[#["Sol"]] > 0 &],
          flattenedWithMeta
        ]
      ]
    ]


updateCoeffsSol::badkernels = "savedKernels must contain a \"kernels\" key with \"A\" and \"B\" sub-keys. Got: `1`";


updateCoeffsSol[
	model_Association,
	savedKernels_Association,
	newParameters_List,
	guessCoeffsSolution_List,
	opts : OptionsPattern[{updateCoeffsSol, solveCoeffRoots, checks, FindRoot, RecurrenceTable}]
] /; (
	KeyExistsQ[savedKernels, "kernels"] &&
	AssociationQ[savedKernels["kernels"]] &&
	AllTrue[{"A", "B"}, KeyExistsQ[savedKernels["kernels"], #] &]
) := Module[
	{
		params, newParams, kernels, numStocks, stockFreeQ, maxMaturity,
		rootSigns, rootSignsNorm, doChecks, needsPd,
		solWc = Nothing, solPd = Nothing, solBond = Nothing, solNomBond = Nothing,
		solveOpts, checkOpts, recurrenceOpts
	},

	Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
	Needs["FernandoDuarte`LongRunRisk`Tools`ToNumber`"];

	(* Initialize parameters *)
	params = (Association @ model["params"]) //. model["params"] // N;
	newParams = (Association @ newParameters) //. newParameters // N;
	kernels = savedKernels["kernels"];
	numStocks = model["numStocks"];
	stockFreeQ = FreeQ[#, _Symbol[_Integer]] & /@ Keys @ newParameters;
	maxMaturity = OptionValue["MaxMaturity"];
	rootSigns = OptionValue["RootSigns"];
	doChecks = OptionValue["PrintResidualsNorm"] || OptionValue["CheckResiduals"];

	(* Validate kernels *)
	If[!AssociationQ[kernels],
		Message[updateCoeffsSol::badkernels, kernels];
		Return[$Failed]
	];

	(* Compute rootSignsNorm *)
	rootSignsNorm = normalizeRootSigns[rootSigns, extractSignIndex[kernels]];
	If[rootSignsNorm === $Failed, Return[$Failed]];

	(* Filter options once *)
	solveOpts = FilterRules[Flatten @ {opts}, Options[updateCoeffsSol]];
	checkOpts = FilterRules[Flatten @ {opts}, Options[checks]];
	recurrenceOpts = Flatten[{
		FilterRules[Flatten @ {opts}, Options[RecurrenceTable]],
		OptionValue["RecurrenceTableOptions"]
	}];

	(* Determine what to compute *)
	needsPd = AnyTrue[Not /@ stockFreeQ, TrueQ] || TrueQ[OptionValue["UpdatePd"]];

	(* Step 1: Always compute wc *)
	solWc = computeWcCoeffs[model, kernels, params, newParams, rootSignsNorm, rootSigns, solveOpts];

	(* Step 2: Compute pd if needed *)
	If[needsPd,
		solPd = computePdCoeffs[model, kernels, params, newParams, solWc,
		                        rootSignsNorm, rootSigns, numStocks, solveOpts]
	];

	(* Step 3: Compute bonds if requested - extract A coefficients for bond computation *)
	With[{wcCoeffsList = Map[#["A"] &, solWc]},
		If[OptionValue["UpdateBond"] || OptionValue["UpdateBonds"],
			solBond = updateCoeffsBond[model["coeffsSolution"]["bond"], params, newParams,
			                           maxMaturity, wcCoeffsList, recurrenceOpts];
		];
		If[OptionValue["UpdateNomBond"] || OptionValue["UpdateBonds"],
			solNomBond = updateCoeffsBond[model["coeffsSolution"]["nombond"], params, newParams,
			                              maxMaturity, wcCoeffsList, recurrenceOpts]
		]
	];

	(* Step 4: Run checks if requested - extract coefficients for checking *)
	If[doChecks,
		With[{wcCoeffsFlat = Map[#["A"] &, solWc]},
			checkCoeffs["wc", model, wcCoeffsFlat, params, newParams, maxMaturity, numStocks, checkOpts];
			If[needsPd,
				(* Flatten B coefficients for checking *)
				With[{pdCoeffsFlat = Flatten @ Map[Values[#][[All, All, "B"]] &, solPd]},
					checkCoeffs["pd", model, Flatten @ {wcCoeffsFlat, pdCoeffsFlat}, params, newParams, maxMaturity, numStocks, checkOpts]
				]
			];
			If[solBond =!= Nothing,
				checkCoeffs["bond", model, Flatten @ {wcCoeffsFlat, solBond}, params, newParams, maxMaturity, numStocks, checkOpts]
			];
			If[solNomBond =!= Nothing,
				checkCoeffs["nombond", model, Flatten @ {wcCoeffsFlat, solNomBond}, params, newParams, maxMaturity, numStocks, checkOpts]
			]
		]
	];

	(* Build hierarchical result: each A solution bundled with its B solutions and bonds *)
	MapIndexed[
		Function[{aSol, idx},
			Join[
				aSol,  (* Contains: IntervalA, SignsA, SolutionIndexA, IntervalIndexA, A *)
				<|
					"Stocks" -> If[needsPd && solPd =!= Nothing,
						solPd[[idx[[1]]]],  (* B solutions indexed by stock for this A *)
						<||>
					],
					"Bond" -> If[solBond =!= Nothing,
						solBond[[idx[[1]]]],  (* Bond coefficients for this A *)
						Missing["NotComputed"]
					],
					"NomBond" -> If[solNomBond =!= Nothing,
						solNomBond[[idx[[1]]]],  (* Nominal bond coefficients for this A *)
						Missing["NotComputed"]
					]
				|>
			]
		],
		solWc
	]
]


(* ::Subsubsection:: *)
(*updateCoeffsBond*)


updateCoeffsBond[
modelCoeffsSolution_,
modelParameters: (_List | _Association),
newParameters: (_List | _Association),
maxMaturity_, coeffsWc : (_List | _Association),
opts : OptionsPattern[{RecurrenceTable}]
]:=Module[{solFirst,solRest},
	With[{newParams=processNewParameters[newParameters,modelParameters]},
		Association@Flatten@MapThread[Flatten@{#1,#2/.#1}&,
		Activate[
			(#[maxMaturity]&/@modelCoeffsSolution)//.newParameters//.modelParameters/.#/.
				(x_Symbol?(MatchQ[SymbolName[#],"RecurrenceTableOptions"]&)->FilterRules[Flatten@{opts}, Options[RecurrenceTable]])
		]
		]&/@coeffsWc
	]
]


(* ::Subsubsection:: *)
(*checks*)


checks//Options ={
	"PrintResidualsNorm"->False,
	"CheckResiduals"->False,
	"Tol"->10.^-16
};
checks::norm="The norm of the residuals (errors) is `1`";
checks::largeresid="The norm of the residuals (errors) is `1`, which is larger than the specified tolerance `2`.";
checks::smallresid="The norm of the residuals (errors) is `1`, which is smaller than the specified tolerance `2`.";


checks[eqs_, sol_, params_, newParams_, opts : OptionsPattern[]] :=With[
	{
		residualsNorm = Max @ (Norm @ (Subtract @@@ eqs) //. newParams //. params//. sol)
	},
	If[OptionValue["CheckResiduals"],
		If[
			residualsNorm >= OptionValue["Tol"],
			Message[checks::largeresid, residualsNorm, OptionValue["Tol"]];Abort[],
			Message[checks::smallresid, residualsNorm, OptionValue["Tol"]]
		];
		,
		If[OptionValue["PrintResidualsNorm"],
			Message[checks::norm, residualsNorm]
		];
	];
];


(* ::Subsection:: *)
(*updateCoeffs*)


(* Fallback for invalid savedKernels structure *)
updateCoeffsSol[
	model_Association,
	savedKernels_,
	newParameters_List,
	guessCoeffsSolution_List,
	opts___
] := (
	Message[updateCoeffsSol::badkernels, Short[savedKernels, 2]];
	$Failed
)


(*inherit default options from updateCoeffsSol, checks*)
updateCoeffs//Options = Join@@(
Options/@
	{
		updateCoeffsSol,
		checks
	}
);


(*updateCoeffs is a wrapper to updateCoeffsSol that splits arguments into positional and optional*)
updateCoeffs[args__]:=Module[
	{
		posArgs,
		optArgs,
		posArgsLength4
	},
	{posArgs,optArgs}=ArgumentsOptions[
		updateCoeffsSol[args],
		{1,4},
		<|"OptionsMode"->"Shortest","ExtraOptions"->{checks,FindRoot,RecurrenceTable}|>
	];
	posArgsLength4=PadRight[posArgs,4,{{}}];
	(* auto-load kernels if caller didn't supply them *)
	If[!AssociationQ[posArgsLength4[[2]]],
		posArgsLength4[[2]] = loadModelKernels[posArgsLength4[[1]]];
		(* check if kernel loading failed *)
		If[posArgsLength4[[2]] === $Failed,
			Return[$Failed, Module]
		]
	];
	updateCoeffsSol[Sequence @@ Join[posArgsLength4, optArgs, Options@updateCoeffs]]
]


(* ::Subsection:: *)
(*solveCoeffRoots*)


solveCoeffRoots[
  quadSol_Association,
  savedKernel_Association,
  paramsBase_Association,
  signs : ({} | {_Integer ..}) : {},
  extraParams_Association : <||>,
  opts : OptionsPattern[{solveCoeffRoots, findRootInterval, extractIntervalsFromReduce, scanAndSolve, fastRoot, FindRoot}]
] /; AllTrue[signs, (# === 1 || # === -1) &] :=
   With[
    {
        (*paramsBase = (Association @ model["params"]) //. model["params"] // N,
		quadSol     = model["coeffsParamQuadSolve"][coeffKey],*)
		coefList   = savedKernel["Vars"]
      },
      With[
        {
          conds      = quadSol["Conditions"],
          paramsAll = Join[
            paramsBase,
            Association @ If[
	            (* if j not present as Key in extraParams add j->1 with j extracted from coefName *)
              AnyTrue[Keys[extraParams], MatchQ[Replace[#, s_Symbol :> SymbolName[s]], "i" | "j"] &],
              {},
              Cases[First@coefList, s_Symbol /; MemberQ[{"i", "j"}, SymbolName[s]] :> (s -> 1), {2}, Heads -> True]
            ],
            extraParams (*putting extra params last in Join takes priority and overwrites paramsBase*)
          ],
          cName       = Lookup[savedKernel, "CoeffName"],
          sName       = Lookup[savedKernel, "SignSymbol"],
          findOpts    = FilterRules[Flatten@{opts}, Options[findRootInterval]],
          extractOpts = FilterRules[Flatten@{opts}, Options[extractIntervalsFromReduce]],
          scanOpts    = FilterRules[
            Flatten@{opts},
            Join[Options[scanAndSolve], Options[FindRoot], Options[fastRoot]]
          ]
        },
        Module[{f, df, reduceExpr, intervals, roots, sol0Rules, sol, solRules, signHead, signsRule, jRule, bindResult},
          bindResult = bindUnary[savedKernel, paramsAll, "Signs" -> signs];
          If[bindResult === $Failed, Return[$Failed, Module]];
          {f, df} = bindResult;

          (* treat 1D and nD differently *)
          If[Length[coefList] > 1,
            (* nD: Delegate to solveND and return early with packaged result *)
            Return[
              solveND[f, df, conds, paramsAll, signs, coefList, cName, sName,
                      findOpts, extractOpts, scanOpts, quadSol["Solution"],
                      "ReduceTimeLimit" -> 5.],
              Module  (* Return from enclosing Module *)
            ]
          ];

          (* 1D *)
          reduceExpr = findRootInterval[conds, paramsAll, "Signs" -> signs, "CoeffName" -> cName, "SignSymbol" -> sName, Sequence @@ findOpts];
          intervals  = extractIntervalsFromReduce[reduceExpr, coefList, Sequence @@ extractOpts];
          roots = (scanAndSolve[First@*f, First@*df, #, Sequence @@ scanOpts] & /@ intervals);
          
          (* Substitute signs into the analytical solution *)
          signHead   = If[StringQ[sName], ToExpression[sName], sName];
          signsRule  = If[signs === {}, {}, Table[signHead[i] -> signs[[i]], {i, Length@signs}]];
          
          (* rest of the coefficients with all parameters substituted *)
          sol        = quadSol["Solution"] //. paramsAll //. signsRule ;

          (* rule to substitute stock index if present *)
          (* jRule = First[
               KeySelect[paramsAll, MatchQ[Replace[#, s_Symbol :> SymbolName[s]], "i" | "j"] &],
               <||>
             ]; *)
  
          (* Create rules for the root variable (e.g. B[1][0] -> value) *)
          sol0Rules  = Map[Thread[(coefList /. paramsAll(*jRule*)) -> #] &, roots, {2}];

          (* Combine root rule with the rest of the solution *)
          solRules   = Map[Join[{#}, sol /. #] &, sol0Rules, {2}];
          
          MapThread[
            <|
              "Interval" -> #1,
              "Roots"    -> #2,
              "Error"    -> (RealAbs /@ (f /@ #2)),
              "Sol"      -> Association /@ #3,
              "Signs"    -> signs
            |> &,
            {intervals, roots, solRules}
          ]

        ]
      ]
    ];


(* ::Subsection:: *)
(*solveWcPdRoots*)


solveWcPdRoots[
  model_Association,
  savedKernelWc_Association,
  savedKernelPd_Association,
  extraParams_Association : <||>,
  opts : OptionsPattern[solveCoeffRoots]
] := Module[
  {
    getSigCount, nWc, nPd, signsWcOptions, signsPdOptions,
    resCoeff, resWcPd, allResults
  },
  getSigCount[k_] := If[KeyExistsQ[k, "SignIndex"], Max[Join[{0}, k["SignIndex"]]], 0];
  nWc = getSigCount[savedKernelWc];
  nPd = getSigCount[savedKernelPd];
  
  signsWcOptions = If[nWc == 0, {{}}, Tuples[{-1, 1}, nWc]];
  signsPdOptions = If[nPd == 0, {{}}, Tuples[{-1, 1}, nPd]];
  
  allResults = {};
  
  Do[
    resCoeff = Quiet[Check[solveCoeffRoots[model["coeffsParamQuadSolve"]["wc"], savedKernelWc, (Association@model["params"])//.model["params"]//N, sWc, extraParams, opts], $Failed], CompiledFunction::cfn];
    If[resCoeff =!= $Failed,
      Do[
        resWcPd = Quiet[Check[solveWcPdRoots[model, savedKernelWc, savedKernelPd, sWc, sPd, extraParams, opts], $Failed], CompiledFunction::cfn];
        If[resWcPd =!= $Failed && ListQ[resWcPd],
           If[AnyTrue[resWcPd, Function[wcRes, 
                KeyExistsQ[wcRes, "Pd"] && ListQ[wcRes["Pd"]] && 
                AnyTrue[wcRes["Pd"], Function[pdList, AnyTrue[pdList, Length[#["Roots"]] > 0 &]]]
              ]],
              allResults = Join[allResults, resWcPd]
           ]
        ]
      , {sPd, signsPdOptions}]
    ]
  , {sWc, signsWcOptions}];
  allResults
];


solveWcPdRoots[
  model_Association,
  savedKernelWc_Association,
  savedKernelPd_Association,
  signsWc : ({} | {_Integer ..}) : {},
  signsPd : ({} | {_Integer ..}) : {},
  extraParams_Association : <||>,
  opts : OptionsPattern[solveCoeffRoots]
] /; AllTrue[signsWc, (# === 1 || # === -1) &] && AllTrue[signsPd, (# === 1 || # === -1) &] := With[
  {optSeq = Sequence @@ FilterRules[Flatten@{opts}, Options[solveCoeffRoots]]},
  With[
    {wcResults = solveCoeffRoots[model["coeffsParamQuadSolve"]["wc"], savedKernelWc, (Association@model["params"])//.model["params"]//N, signsWc, "wc", extraParams, optSeq]},
    Map[
      Function[wr,
        With[
          {
            pdForRoot = (solveCoeffRoots[
              model["coeffsParamQuadSolve"]["pd"],
              savedKernelPd,
              (Association@model["params"])//.model["params"]//N,
              signsPd,
              Join[extraParams, #],
              optSeq
            ] & /@ wr(*["Sol"]*))
          },
          Join[wr, <|"Pd" -> pdForRoot, "SignsWc" -> signsWc, "SignsPd" -> signsPd|>]
        ]
      ],
      wcResults
    ]
  ]
];


(* ::Subsection:: *)
(*getStartingValues*)


(* helper for addCoeffsSolutionN - retrieves initial guesses from model extraInfo *)
getStartingValues // Options = {
	"initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>
};


getStartingValues[
	ratio_String,
	infoModel_Association : <||>,
	opts : OptionsPattern[{getStartingValues}]
] := With[
	{
		iEv = "E" <> ratio,
		ig = First @ OptionValue[getStartingValues, Flatten @ {opts}, {"initialGuess"}]
	},
	Which[
		(* option provided and non-empty *)
		And[
			KeyExistsQ[ig, iEv],
			Not[SameQ[ig, {}]] || Not[SameQ[ig[iEv], {}]]
		],
		ig[iEv],
		(* from infoModel["initialGuess"] *)
		KeyExistsQ[infoModel, "initialGuess"] && KeyExistsQ[infoModel["initialGuess"], iEv],
		infoModel["initialGuess"][iEv],
		(* default *)
		True,
		Switch[ratio, "wc", {4}, "pd", {{4}}]
	]
];


(* ::Subsection:: *)
(*addCoeffsSolutionN*)


addCoeffsSolutionN[model_] := Module[{k},
	k=FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels[model["shortname"]];
	updateCoeffs[
		model,
		k,
		"UpdatePd"->True,
		"UpdateBonds"->True,
		"MaxMaturity"->120,
		"RootSigns" -> Automatic
	]
];


(* ::Subsection:: *)
(*flattenCoeffs*)


(* Extract all coefficient rules from hierarchical updateCoeffs result *)
flattenCoeffs[results_List] := Flatten @ Map[
  Function[aSol,
    Join[
      Normal[aSol["A"]],
      Flatten @ Map[
        Function[bSolList, Map[Normal[#["B"]] &, bSolList]],
        Values[aSol["Stocks"]]
      ],
      If[!MissingQ[aSol["Bond"]], Normal[aSol["Bond"]], {}],
      If[!MissingQ[aSol["NomBond"]], Normal[aSol["NomBond"]], {}]
    ]
  ],
  results
];

(* Extract rules from n-th A solution only *)
flattenCoeffs[results_List, n_Integer] := With[{aSol = results[[n]]},
  Join[
    Normal[aSol["A"]],
    Flatten @ Map[
      Function[bSolList, Map[Normal[#["B"]] &, bSolList]],
      Values[aSol["Stocks"]]
    ],
    If[!MissingQ[aSol["Bond"]], Normal[aSol["Bond"]], {}],
    If[!MissingQ[aSol["NomBond"]], Normal[aSol["NomBond"]], {}]
  ]
];

(* Extract A rules and all B rules for stock j from n-th A solution *)
flattenCoeffs[results_List, n_Integer, j_Integer] := With[{aSol = results[[n]]},
  Join[
    Normal[aSol["A"]],
    Flatten @ Map[Normal[#["B"]] &, aSol["Stocks"][j]]
  ]
];

(* Extract A rules and m-th B solution for stock j from n-th A solution *)
flattenCoeffs[results_List, n_Integer, j_Integer, m_Integer] := With[{aSol = results[[n]]},
  Join[
    Normal[aSol["A"]],
    Normal[aSol["Stocks"][j][[m]]["B"]]
  ]
];


(* ::Subsection:: *)
(*flattenCoeffsBundles*)


(* Generate Cartesian product of complete A+B solution bundles *)
flattenCoeffsBundles[results_List] := Flatten[
  Map[flattenCoeffsBundlesForA, results],
  1
];

(* Generate bundles for n-th A solution only *)
flattenCoeffsBundles[results_List, n_Integer] := flattenCoeffsBundlesForA[results[[n]]];

(* Helper: generate all bundles for a single A solution *)
flattenCoeffsBundlesForA[aSol_Association] := Module[
  {aRules, stockKeys, bSolsPerStock, bondRules, nomBondRules, cartesianB},

  aRules = Normal[aSol["A"]];
  bondRules = If[!MissingQ[aSol["Bond"]], Normal[aSol["Bond"]], {}];
  nomBondRules = If[!MissingQ[aSol["NomBond"]], Normal[aSol["NomBond"]], {}];

  (* Get stock keys and B solutions for each stock *)
  stockKeys = Keys[aSol["Stocks"]];

  (* Handle empty Stocks case *)
  If[stockKeys === {} || aSol["Stocks"] === <||>,
    Return[{Join[aRules, bondRules, nomBondRules]}]
  ];

  (* Get list of B rule lists for each stock *)
  bSolsPerStock = Map[
    Function[j,
      Map[Normal[#["B"]] &, aSol["Stocks"][j]]
    ],
    stockKeys
  ];

  (* Handle case where any stock has no B solutions *)
  If[MemberQ[bSolsPerStock, {}],
    Return[{Join[aRules, bondRules, nomBondRules]}]
  ];

  (* Cartesian product of B solutions across stocks *)
  cartesianB = Tuples[bSolsPerStock];

  (* Build complete bundles: A + each B combination + bonds *)
  Map[
    Function[bCombo,
      Join[aRules, Flatten[bCombo], bondRules, nomBondRules]
    ],
    cartesianB
  ]
];


(* ::Section::Closed:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
