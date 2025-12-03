(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];


(* ::Subsection:: *)
(*Public symbols*)


updateCoeffs
addCoeffsSolutionN


(* ::Subsubsection:: *)
(*Usage*)


updateCoeffs::usage = "updateCoeffs[model] solves for the coefficients of the wealth-consumption ratio, price-dividend ratio, real bonds, and nominal bonds, and returns a list of rules to evaluate the coefficients numerically."<>"\n"<>
			          "updateCoeffs[model, newParameters] uses the parameters in the list of rules newParameters instead of the ones specified in model."<>"\n"<>
			          "updateCoeffs[model, newParameters, guessCoeffsSolution] uses initial solution estimates in guessCoeffsSolution.";

addCoeffsSolutionN::usage = "addCoeffsSolutionN[model] computes numerical solutions for all coefficient types (wc, pd, bond, nombond) using default parameters and model extraInfo.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Tools`ToNumber`"];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];

$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"];
$ContextPath=PrependTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"];


(* ::Subsection:: *)
(*nD Root-Finding Helpers*)


(* Step 1: safeReduceCall - wraps findRootInterval with timeout for nD *)
safeReduceCall[conds_, paramsAll_, signs_, cName_, sName_, findOpts_, timeout_] :=
  TimeConstrained[
    findRootInterval[conds, paramsAll, signs,
      "CoeffName" -> cName, "SignSymbol" -> sName, Sequence @@ findOpts],
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
          frRes = fastRoot[f, df, {x0, aFinite, bFinite}, Sequence @@ scanOpts];
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

    frRes = fastRoot[f, df, {x0, a, b}, Sequence @@ scanOpts];
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
	"MaxMaturity"->12
};


updateCoeffsSol[
	model_Association,
	newParameters_List,
	guessCoeffsSolution_List,
	opts : OptionsPattern[
		{
			updateCoeffsSol,
			checks,
			FindRoot,
			RecurrenceTable
		}
	]
]:=With[
	{
		parameters = model["parameters"],
		params = model["params"],
		numStocks = model["numStocks"],
		stockFreeQ=FreeQ[#,_Symbol[_Integer]]&/@(Keys@newParameters),
		ig = Evaluate[OptionValue["initialGuess"]]["Epd"],
		optsFindRoot = Flatten[{
			Evaluate[FilterRules[Flatten@{opts},Options[FindRoot]]],
			Evaluate[OptionValue["FindRootOptions"]]
		}],
		optsRecurrenceTable = Flatten[{
			Evaluate[FilterRules[Flatten@{opts},Options[RecurrenceTable]]],
			Evaluate[OptionValue["RecurrenceTableOptions"]]
		}],
		optsUpdatePd = OptionValue["UpdatePd"],
		optsUpdateBond = OptionValue["UpdateBond"],
		optsUpdateNomBond = OptionValue["UpdateNomBond"],
		optsUpdateBonds = OptionValue["UpdateBonds"],
		maxMaturity = OptionValue["MaxMaturity"],
		doChecks= OptionValue["PrintResidualsNorm"] || OptionValue["CheckResiduals"],
		optsCheck = Evaluate[FilterRules[Flatten@{opts}, Options[checks]]]
	},
	Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
	Needs["FernandoDuarte`LongRunRisk`Tools`ToNumber`"];
	With[
		{
			guessCoeffsSolutionWc = FilterRules[guessCoeffsSolution,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc[_]],
			initialGuessEwc = "Ewc0"->If[
				MemberQ[Keys@guessCoeffsSolution,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc[0]],
				FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc[0]/.guessCoeffsSolution,
				First@(Evaluate[OptionValue["initialGuess"]]["Ewc"])
			],
			guessCoeffsSolutionPd=Module[{j},Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd[[0]][j][0],{j,1,numStocks}]]/.guessCoeffsSolution,
			igNumStocks=If[(First@Dimensions[ig])!=numStocks,ConstantArray[First@ig,numStocks],ig]
		},
		With[
			{
				initialGuessEpd = Module[{j},
					Table[
						"Epd0["<>IntegerString[j]<>"]"->
							If[
								NumberQ[guessCoeffsSolutionPd[[j]]],
								guessCoeffsSolutionPd[[j]],igNumStocks[[j]]/.List->Sequence
							],
						{j,1,numStocks}
					]
				]
			},
			Module[
				{
					solWc = Nothing,
					solPd = Nothing,
					solBond = Nothing,
					solNomBond = Nothing
				},
				Which[
					(*if none of the new parameters are stock parameters and pd coefficients are not requested*)
					AllTrue[stockFreeQ,TrueQ] && Not@TrueQ[optsUpdatePd]
					,
					(*only update wealth-consumption ratio coefficients*)
					solWc=updateCoeffsWc[model["coeffsSolution"]["wc"], params, newParameters, Sequence[optsFindRoot,initialGuessEwc]];
					If[
						doChecks,
						checks[
							First@model["coeffsSystem"]["wc"],
							solWc,
							params,
							newParameters,
							optsCheck
						];
					];
					,
					(*if all of the new parameters are stock parameters*)
					AllTrue[Not/@stockFreeQ,TrueQ]
					,
					(*only update price-dividend ratio coefficients*)
					solWc=If[
						guessCoeffsSolutionWc==={},
						(*if coefficients for wc are not provided, compute them*)
						updateCoeffsWc[model["coeffsSolution"]["wc"], params, newParameters, Sequence[optsFindRoot,initialGuessEwc]],
						guessCoeffsSolutionWc
					];
					solPd=updateCoeffsPd[model["coeffsSolution"]["pd"], params, newParameters, solWc, Sequence[optsFindRoot,initialGuessEpd]];
					If[
						doChecks,
						(*check pd coefficients*)
						With[
							{
								j=DeleteDuplicates@Cases[(First@model["coeffsSystem"]["pd"]),Head[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd][j_][_]:>j,{0,Infinity}]
							},
							checks[
								Table[First@model["coeffsSystem"]["pd"],{j,1,numStocks}],
								Join[solWc,solPd],
								params,
								newParameters,
								optsCheck
							];
						];(*With*)
						(*check wc coefficients*)
						checks[
							First@model["coeffsSystem"]["wc"],
							solWc,
							params,
							newParameters,
							optsCheck
						];
					];(*If*)
					,
					(*both stock and non-stock parameters*)
					True
					,
					solWc=updateCoeffsWc[model["coeffsSolution"]["wc"], params, newParameters, Sequence[optsFindRoot,initialGuessEwc]];
					solPd=updateCoeffsPd[model["coeffsSolution"]["pd"], params, newParameters, solWc, Sequence[optsFindRoot,initialGuessEpd]];
					If[
						doChecks,
						(*check pd coefficients*)
						With[
							{
								j=First@DeleteDuplicates@Cases[(First@model["coeffsSystem"]["pd"]),Head[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd][j_][_]:>j,{0,Infinity}]
							},
							checks[
								Table[First@model["coeffsSystem"]["pd"],{j,1,numStocks}],
								Join[solWc,solPd],
								params,
								newParameters,
								optsCheck
							];
						];(*With*)
						(*check wc coefficients*)
						checks[
							First@model["coeffsSystem"]["wc"],
							solWc,
							params,
							newParameters,
							optsCheck
						];
					];(*If*)
				];(*Which*)
				If[
					(*any bond coefficients are requested*)
					optsUpdateBond || optsUpdateNomBond || optsUpdateBonds
					,
					(*get wc coefficients*)
					If[
						(*bond coefficients requested and wc coefficients not available*)
						solWc===Nothing,
						(*compute wc coefficients*)
						solWc=If[
							guessCoeffsSolutionWc==={},
							(*if coefficients for wc are not provided, compute them*)
							updateCoeffsWc[model["coeffsSolution"]["wc"], params, newParameters, Sequence[optsFindRoot,initialGuessEwc]],
							guessCoeffsSolutionWc
						];
					];
					(*compute bond coefficients*)
					Which[
						optsUpdateBonds || (optsUpdateBond && optsUpdateNomBond),
						(*compute both*)
						solBond=updateCoeffsBond[model["coeffsSolution"]["bond"],params, newParameters,maxMaturity,solWc,optsRecurrenceTable];
						solNomBond=updateCoeffsBond[model["coeffsSolution"]["nombond"],params, newParameters,maxMaturity,solWc,optsRecurrenceTable];
						If[
							doChecks,
							With[
								{
									n=First@DeleteDuplicates@Cases[(First@model["coeffsSystem"]["bond"]),Head[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb][n_][_]:>(n/;FreeQ[n,Plus]),{0,Infinity}]
								},
								(*check bond coefficients*)
								checks[
									Flatten@Table[First@model["coeffsSystem"]["bond"],{n,1,maxMaturity}],
									Join[solWc,solBond],
									params,
									newParameters,
									optsCheck
								];
								(*check nombond coefficients*)
								checks[
									Flatten@Table[First@model["coeffsSystem"]["nombond"],{n,1,maxMaturity}],
									Join[solWc,solNomBond],
									params,
									newParameters,
									optsCheck
								];
							];(*With*)
							(*check wc coefficients*)
							checks[
								First@model["coeffsSystem"]["wc"],
								solWc,
								params,
								newParameters,
								optsCheck
							];
						];		
						,
						optsUpdateBond,
						(*compute only real*)
						solBond=updateCoeffsBond[model["coeffsSolution"]["bond"],params, newParameters,maxMaturity,solWc,optsRecurrenceTable];
						If[
							doChecks,
							With[
								{
									n=First@DeleteDuplicates@Cases[(First@model["coeffsSystem"]["bond"]),Head[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb][n_][_]:>(n/;FreeQ[n,Plus]),{0,Infinity}]
								},
								(*check bond coefficients*)
								checks[
									Flatten@Table[First@model["coeffsSystem"]["bond"],{n,1,maxMaturity}],
									Join[solWc,solBond],
									params,
									newParameters,
									optsCheck
								];
							];(*With*)
							(*check wc coefficients*)
							checks[
								First@model["coeffsSystem"]["wc"],
								solWc,
								params,
								newParameters,
								optsCheck
							];
						];
						,
						optsUpdateNomBond,
						(*compute only nominal*)
						solNomBond=updateCoeffsBond[model["coeffsSolution"]["nombond"],params, newParameters,maxMaturity,solWc,optsRecurrenceTable];
						If[
							doChecks,
							With[
								{
									n=First@DeleteDuplicates@Cases[(First@model["coeffsSystem"]["bond"]),Head[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb][n_][_]:>(n/;FreeQ[n,Plus]),{0,Infinity}]
								},
								(*check nombond coefficients*)
								checks[
									Flatten@Table[First@model["coeffsSystem"]["nombond"],{n,1,maxMaturity}],
									Join[solWc,solNomBond],
									params,
									newParameters,
									optsCheck
								];
							];(*With*)
							(*check wc coefficients*)
							checks[
								First@model["coeffsSystem"]["wc"],
								solWc,
								params,
								newParameters,
								optsCheck
							];
						];
					];				
				];
			Flatten@{solWc,solPd,solBond,solNomBond}
		](*Module*)
	](*With*)
	](*With*)
](*With*)


(* ::Subsubsection:: *)
(*updateCoeffsWc*)


updateCoeffsWc//Options ={
	"Ewc0" -> 4
};


updateCoeffsWc[modelCoeffsSolution_, modelParameters_, newParameters_List, opts : OptionsPattern[{updateCoeffsWc,FindRoot}]]:=Module[{solFirst,solRest},
	With[{newParams=processNewParameters[newParameters,modelParameters]},
		Off[Reduce::ratnz];
		{solFirst,solRest}=Activate[
			modelCoeffsSolution//.newParameters//.modelParameters/.
				(x_/;(Head[x]===Symbol)&&(MatchQ[SymbolName[x],"FindRootOptions"]):>FilterRules[Flatten@{opts}, Options[FindRoot]])/.
				(x_Symbol?(MatchQ[SymbolName[#],"Ewc0"]&)->OptionValue["Ewc0"])
		];
		On[Reduce::ratnz];
		Flatten@Join[solFirst,solRest/.solFirst,2]
	]
]


(* ::Subsubsection:: *)
(*updateCoeffsPd*)


updateCoeffsPd//Options ={
	"Epd0[1]" -> Sequence[0,15],
	"Epd0[2]" -> Sequence[0,15],
	"Epd0[3]" -> Sequence[5.5]
};


updateCoeffsPd[modelCoeffsSolution_, modelParameters_, newParameters_List, coeffsWc_List, opts : OptionsPattern[{updateCoeffsPd,FindRoot}]]:=Module[{solFirst,solRest},
	With[{newParams=processNewParameters[newParameters,modelParameters]},
		Off[Reduce::ratnz];
		{solFirst,solRest}=Activate[
			modelCoeffsSolution//.newParameters//.modelParameters/.coeffsWc/.
				(x_/;(Head[x]===Symbol)&&(MatchQ[SymbolName[x],"FindRootOptions"]):>FilterRules[Flatten@{opts}, Options[FindRoot]])/.
				(x_Symbol?(MatchQ[SymbolName[#],"Epd0"]&)[j_Integer]:>OptionValue["Epd0["<>IntegerString[j]<>"]"])
		];
		On[Reduce::ratnz];
	MapThread[Flatten@{#1,#2/.#1}&,{solFirst,solRest}]
	]
]


(* ::Subsubsection:: *)
(*updateCoeffsBond*)


updateCoeffsBond[modelCoeffsSolution_, modelParameters_, newParameters_List, maxMaturity_, coeffsWc_List, opts : OptionsPattern[{RecurrenceTable}]]:=Module[{solFirst,solRest},
	With[{newParams=processNewParameters[newParameters,modelParameters]},
		{solFirst,solRest}=Activate[
			(#[maxMaturity]&/@modelCoeffsSolution)//.newParameters//.modelParameters/.coeffsWc/.
				(x_Symbol?(MatchQ[SymbolName[#],"RecurrenceTableOptions"]&)->FilterRules[Flatten@{opts}, Options[RecurrenceTable]])
		];
	Flatten@MapThread[Flatten@{#1,#2/.#1}&,{solFirst,solRest}]
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
		posArgsLength3
	},
	{posArgs,optArgs}=ArgumentsOptions[
		updateCoeffsSol[args],
		{1,3},
		<|"OptionsMode"->"Shortest","ExtraOptions"->{checks,FindRoot,RecurrenceTable}|>
	];
	posArgsLength3=PadRight[posArgs,3,{{}}];
	updateCoeffsSol[Sequence@@Join[posArgsLength3,optArgs,Options@updateCoeffs]]
]


(* ::Subsection:: *)
(*solveCoeffRoots*)


solveCoeffRoots[
  model_Association,
  savedKernel_Association,
  signs : ({} | {_Integer ..}) : {},
  coeffKey : "wc" | "pd" : "wc",
  extraParams_Association : <||>,
  opts : OptionsPattern[{solveCoeffRoots, findRootInterval, extractIntervalsFromReduce, scanAndSolve, fastRoot, FindRoot}]
] /; AllTrue[signs, (# === 1 || # === -1) &] :=
   With[
    {
        paramsBase = (Association @ model["params"]) //. model["params"] // N,
		quadSol     = model["coeffsParamQuadSolve"][coeffKey],
		coefList   = savedKernel["Vars"],
		coefName   = First@savedKernel["Vars"]
		
      },
      With[
        {
          conds      = quadSol["Conditions"],
          paramsAll = Join[
            paramsBase,
            extraParams,
            (* if j not present as Key in extraParams add j->1 with j extracted from coefName *)
            Association @ If[
              AnyTrue[Keys[extraParams], MatchQ[Replace[#, s_Symbol :> SymbolName[s]], "i" | "j"] &],
              {},
              Cases[coefName, s_Symbol /; MemberQ[{"i", "j"}, SymbolName[s]] :> (s -> 1), {2}, Heads -> True]
            ]
          ],
          cName       = Lookup[savedKernel, "CoeffName", If[coeffKey === "wc", "A", "B"]],
          sName       = Lookup[savedKernel, "SignSymbol", If[coeffKey === "wc", "signA", "signB"]],
          findOpts    = FilterRules[Flatten@{opts}, Options[findRootInterval]],
          extractOpts = FilterRules[Flatten@{opts}, Options[extractIntervalsFromReduce]],
          scanOpts    = FilterRules[
            Flatten@{opts},
            Join[Options[scanAndSolve], Options[FindRoot], Options[fastRoot]]
          ]
        },
        Module[{f, df, reduceExpr, intervals, roots, sol0Rules, sol, solRules, signHead, signsRule, jRule},
          {f, df}    = bindUnary[savedKernel, paramsAll, signs];

          (* Branch early: nD uses solveND with timeout protection, 1D uses original path *)
          If[Length[coefList] > 1,
            (* nD: Delegate to solveND and return early with packaged result *)
            Return[
              solveND[f, df, conds, paramsAll, signs, coefList, cName, sName,
                      findOpts, extractOpts, scanOpts, quadSol["Solution"],
                      "ReduceTimeLimit" -> 5.],
              Module  (* Return from enclosing Module *)
            ]
          ];

          (* 1D path: use existing logic without timeout (fast for 1D) *)
          reduceExpr = findRootInterval[conds, paramsAll, signs, "CoeffName" -> cName, "SignSymbol" -> sName, Sequence @@ findOpts];
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
  extraParamsPd_Association : <||>,
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
    resCoeff = Quiet[Check[solveCoeffRoots[model, savedKernelWc, sWc], $Failed], CompiledFunction::cfn];
    If[resCoeff =!= $Failed,
      Do[
        resWcPd = Quiet[Check[solveWcPdRoots[model, savedKernelWc, savedKernelPd, sWc, sPd, extraParamsPd, opts], $Failed], CompiledFunction::cfn];
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
  extraParamsPd_Association : <||>,
  opts : OptionsPattern[solveCoeffRoots]
] /; AllTrue[signsWc, (# === 1 || # === -1) &] && AllTrue[signsPd, (# === 1 || # === -1) &] := With[
  {optSeq = Sequence @@ FilterRules[Flatten@{opts}, Options[solveCoeffRoots]]},
  With[
    {wcResults = solveCoeffRoots[model, savedKernelWc, signsWc, "wc", <||>, optSeq]},
    Map[
      Function[wr,
        With[
          {
            pdForRoot = (solveCoeffRoots[
              model,
              savedKernelPd,
              signsPd,
              "pd",
              Join[extraParamsPd, #],
              optSeq
            ] & /@ wr["Sol"])
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


addCoeffsSolutionN[model_] := With[
	{
		modelInfo = model["extraInfo"],
		params = model["params"],
		maxMaturity = 120,
		numStocks = model["numStocks"]
	},
	Module[{Ewc0, Epd0, Epd0j, solWc, solPd, solBond, solNomBond},
		Ewc0 = getStartingValues["wc", modelInfo, "initialGuess" -> {}];
		Epd0 = getStartingValues["pd", modelInfo, "initialGuess" -> {}];
		Epd0j = Table["Epd0[" <> IntegerString[j] <> "]" -> First @ (Epd0[[j]]), {j, 1, numStocks}] /. Table -> Sequence;
		solWc = updateCoeffsWc[model["coeffsSolution"]["wc"], params, {}, "Ewc0" -> Sequence[First @ Ewc0], MaxIterations -> 1000];
		solPd = updateCoeffsPd[model["coeffsSolution"]["pd"], params, {}, solWc, Epd0j, MaxIterations -> 1000];
		solBond = updateCoeffsBond[model["coeffsSolution"]["bond"], params, {}, maxMaturity, solWc];
		solNomBond = updateCoeffsBond[model["coeffsSolution"]["nombond"], params, {}, maxMaturity, solWc];
		Flatten @ Join[solWc, solPd, solBond, solNomBond]
	]
];


(* ::Section::Closed:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
