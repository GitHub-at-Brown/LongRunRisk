(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];


(* ::Subsection:: *)
(*Public symbols*)


updateCoeffsWc::usage = "";
updateCoeffsPd::usage = "";
updateCoeffsBond::usage = "";
updateCoeffsSol::usage = "";
updateCoeffs::usage = "";
checks::usage = "";


updateCoeffs::usage = "updateCoeffs[model] gives a list of rules to evaluate expressions numerically."<>"\n"<>
			          "updateCoeffs[model, newParameters] uses the parameters provided in the list of rules parameters."<>"\n"<>
			          "updateCoeffs[model, newParameters, guessCoeffsSolution] uses the parameters provided in the list of rules parameters."


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Tools`ToNumber`"];


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
			guessCoeffsSolutionPd=Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd[[0]][j][0],{j,1,numStocks}]/.guessCoeffsSolution,
			igNumStocks=If[(First@Dimensions[ig])!=numStocks,ConstantArray[First@ig,numStocks],ig]
		},
		With[
			{
				initialGuessEpd = Table[
					"Epd0["<>IntegerString[j]<>"]"->
						If[
							NumberQ[guessCoeffsSolutionPd[[j]]],
							guessCoeffsSolutionPd[[j]],igNumStocks[[j]]/.List->Sequence
						],
					{j,1,numStocks}
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
					(*if none of the new parameters are stock parameters and pd coefficients were not requested*)
					AllTrue[stockFreeQ,TrueQ] && Not@TrueQ[optsUpdatePd]
					,
					(*only update wealth-consumption ratio coefficients*)
					solWc=updateCoeffsWc[model["coeffsSolution"]["wc"], params, newParameters, Sequence[optsFindRoot,initialGuessEwc]];
					If[
						doChecks,
						checks[First@model["coeffsSystem"]["wc"],solWc,params,newParameters,optsCheck]
					];
					,
					(*if all of the new parameters are stock parameters*)
					AllTrue[Not/@stockFreeQ,TrueQ]
					,
					(*only update price-dividend ratio coefficients*)
					solWc=If[
						guessCoeffsSolutionWc==={},
						(*if coefficients for wc were not provided, compute them*)
						updateCoeffsWc[model["coeffsSolution"]["wc"], params, newParameters, Sequence[optsFindRoot,initialGuessEwc]],
						guessCoeffsSolutionWc
					];
					solPd=updateCoeffsPd[model["coeffsSolution"]["pd"], params, newParameters, solWc, Sequence[optsFindRoot,initialGuessEpd]];
						(*TO DO: If[doChecks, ... ];*)
					,
					(*both stock and non-stock parameters*)
					True
					,
					solWc=updateCoeffsWc[model["coeffsSolution"]["wc"], params, newParameters, Sequence[optsFindRoot,initialGuessEwc]];
					solPd=updateCoeffsPd[model["coeffsSolution"]["pd"], params, newParameters, solWc, Sequence[optsFindRoot,initialGuessEpd]];
	
					If[
						doChecks,
						checks[First@model["coeffsSystem"]["wc"],solWc,parameters,newParameters,optsCheck];
					];
					(*TO DO: checks for stocks;*)
				];(*Which*)
				If[
					(*any bond coefficients requested*)
					optsUpdateBond || optsUpdateNomBond || optsUpdateBonds
					,
					(*get wc coefficients*)
					If[
						(*bond coefficients requested and wc coefficients not computed*)
						solWc===Nothing,
						(*compute wc coefficients*)
						solWc=updateCoeffsWc[model["coeffsSolution"]["wc"], params, newParameters, Sequence[optsFindRoot,initialGuessEwc]]
					];
					(*compute bond coefficients*)
					Which[
						optsUpdateBonds || (optsUpdateBond && optsUpdateNomBond),
						(*compute both*)
						solBond=updateCoeffsBond[model["coeffsSolution"]["bond"],params, newParameters,maxMaturity,solWc,optsRecurrenceTable];
						solNomBond=updateCoeffsBond[model["coeffsSolution"]["nombond"],params, newParameters,maxMaturity,solWc,optsRecurrenceTable];
						,
						optsUpdateBond,
						(*compute only real*)
						solBond=updateCoeffsBond[model["coeffsSolution"]["bond"],params, newParameters,maxMaturity,solWc,optsRecurrenceTable];
						,
						optsUpdateNomBond,
						(*compute only nominal*)
						solNomBond=updateCoeffsBond[model["coeffsSolution"]["nombond"],params, newParameters,maxMaturity,solWc,optsRecurrenceTable];
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
	"Epd0[2]" -> Sequence[6],
	"Epd0[3]" -> Sequence[7]
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
	{residualsNorm = Norm @ (Subtract @@@ eqs) //. newParams //. params//. sol},
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
	
(*bond checks
residuals=Table[Subtract@@@(First@model["coeffsSystem"]["nombond"])/.model["coeffsSystem"]["nombond"][[4]]->n,{n,1,maxMaturity}]//.newProcessedParam//.params/.solWc/.solNomBonds;
Norm[residuals]*)


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
		<|"OptionsMode"->"Shortest","ExtraOptions"->{checks,FindRoot}|>
	];
	posArgsLength3=PadRight[posArgs,3,{{}}];
	updateCoeffsSol[Sequence@@Join[posArgsLength3,optArgs,Options@updateCoeffs]]
]


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
