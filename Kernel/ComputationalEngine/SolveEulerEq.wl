(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];


(* ::Subsection:: *)
(*Public symbols*)


(*coeff::usage = "coeff[model] solves for the coefficients in the wealth-consumption ratio, price-dividend ratio of stocks, and bond prices."*)
processNewParameters::usage = "";
updateCoeffsWc::usage = "";
updateCoeffsPd::usage = "";
updateCoeffsBond::usage = "";
updateCoeffsSol::usage = "";
(*createStartingPoint::usage = "";
getStartingValues::usage = "";
formatStartingValuesRest::usage = "";
formatStartingValues::usage = "formatStartingValues[initialGuess, coefficients] transforms user-provided starting values initialGuess into a form that can be used directly as a second argument to FindRoots when numerically solving for coefficients of the wealth-consumption or price-dividend ratios. 

Example: let the wealth-consumption ratio be given by:

wc = someContext`A[0] +  someContext`A[1] * state variable 1 +  someContext`A[2] * state variable 2 +  someContext`A[3] * state variable 3.

We know someContext`A[2] and want to use FindRoot to solve for someContext`A[0], someContext`A[1] and someContext`A[3]. The variable initialGuess provided by the user is:

initialGuess = {{A[0],1},{A[3],2}}.

Then, 

sv = formatStartingValues[initialGuess, {someContext`A[0], someContext`A[1] and someContext`A[3]} ]

gives

{{someContext`A[1],0}, {someContext`A[3],2}} and 

which can be used in a call FindRoot[ ... , sv]."*)


Begin["`Private`"];


(* ::Subsubsection:: *)
(*processNewParameters*)


processNewParameters::psi="psi=1 implies a constant wealth-consumption ratio, please choose a different psi.";
processNewParameters::param="theta must equal (1-gamma)/(1-1/psi), replacing theta by (1-gamma)/(1-1/psi)=`1`.";
processNewParameters::theta="Plase provide psi or gamma with theta.";
processNewParameters::subsetparam="Parameters `1` in newParameters are not a subset of model[\"parameters\"].";


processNewParameters[newParameters:{(_Rule)...},parameters:{(_Rule)..}]:=If[
	newParameters==={},
	Return[{}],
	With[
		{
			newParametersA=Association@newParameters,
			parametersA=Association@parameters
		},
		Module[
			{
				newParametersSplit,
				parametersSplit,
				newParametersString,
				processedParameters,
				thetaNew,
				system,
				processedParametersA,
				posNew
			},
			(*newParameters and parameters may have symbols in different contexts, split keys into context, symbol name and index*)
			newParametersSplit=KeyMap[Replace[{x_Symbol[j_Integer]:>{Context@x,SymbolName@x,j},x_Symbol:>{Context@x,SymbolName@x}}],newParametersA];
			parametersSplit=KeyMap[Replace[{x_Symbol[j_Integer]:>{Context@x,SymbolName@x,j},x_Symbol:>{Context@x,SymbolName@x}}],parametersA];
			If[
				Not@SubsetQ[Map[Rest,Keys@parametersSplit],Map[Rest,Keys@newParametersSplit]],
				(*abort with message if newParameters has a parameter not in parameters*)
				Message[processNewParameters::subsetparam,Pick[newParameters,MemberQ[Map[Rest,Keys@parametersSplit],#]&/@Map[Rest,Keys@newParametersSplit],False]];
				Abort[];
			];
			(*process gamma, psi, theta*)
			newParametersString = Normal@KeyMap[#[[2]]&,newParametersSplit];
			If[1===("psi"/.newParametersString), Message[processNewParameters::psi]; Abort[]; ]; (*psi=1 aborts*)
			processedParameters = Switch[
				Count[MemberQ[Keys@newParametersString,#]&/@{"gamma","psi","theta"},True],
					3,
						(*when gamma, psi, theta all provided, ignore theta and issue message*)	
						thetaNew=(1-("gamma"/.newParametersString))/(1-1/("psi"/.newParametersString));
						Message[processNewParameters::param,thetaNew];
						Append[newParametersSplit,{"Global`","theta"}->thetaNew],		
					2,
						(*when 2 of {gamma, psi, theta} are provided, solve for the third and add to newParameters*)
						system = (1-ToExpression@("gamma"/.newParametersString))/(1-1/ToExpression@("psi"/.newParametersString)) == ToExpression@("theta"/.newParametersString);
						Append[newParametersSplit,KeyMap[{"Context`",SymbolName@#}&,Association@SolveAlways[system,Reals]]],
					1,
						(*if theta provided without gamma or psi, abort*)
						If[
							MemberQ[SymbolName/@(Keys@newParameters),"theta"],
							Message[processNewParameters::theta];Abort[];,
							newParametersSplit
						],
					(*otherwise, return newParametersSplit unchanged*)
					_,
					newParametersSplit
			];
			(*make keys of newParameters match context of keys of parameters that have the same SymbolName*)
			processedParametersA=Association@processedParameters;
			posNew=Position[Rest/@Keys@parametersSplit,#]&/@Rest/@Keys@processedParametersA;
			Thread[Extract[Keys@parametersA,Flatten[posNew,1]]->(Values@processedParametersA)]
		](*Module*)
	](*With*)
](*If*)


(* ::Subsection:: *)
(*updateCoeffSol*)


checks[eqs_, sol_, params_, newParams_, opts : OptionsPattern[{updateCoeffsSol}]] :=
	With[{residualsNorm = Norm @ (Subtract @@@ eqs) //. newParams //. params//. sol},
		If[OptionValue["PrintResidualsNorm"],
			Message[updateCoeffsSol::norm, residualsNorm]
		];

		If[OptionValue["CheckResiduals"],
			If[
				residualsNorm >= OptionValue["Tol"],
				Message[updateCoeffsSol::largeresid, residualsNorm, OptionValue["Tol"]],
				Message[updateCoeffsSol::smallresid, residualsNorm, OptionValue["Tol"]]
			];
		];
	];
	
(*bond checks
residuals=Table[Subtract@@@(First@model["coeffsSystem"]["nombond"])/.model["coeffsSystem"]["nombond"][[4]]->n,{n,1,maxMaturity}]//.newProcessedParam//.params/.solWc/.solNomBonds;
Norm[residuals]*)


updateCoeffsWc[modelCoeffsSolution_, modelParameters_, newParameters_List, opts : OptionsPattern[{}]]:=Module[{solFirst,solRest},
	
	With[
		{
			newParams=processNewParameters[newParameters,modelParameters]
		},
		
	{solFirst,solRest}=Activate[
		modelCoeffsSolution//.newParameters//.modelParameters/.(x_Symbol?(MatchQ[SymbolName[#],"FindRootOptions"]&)->FilterRules[Flatten@{opts}, Options[FindRoot]])/.(x_Symbol?(MatchQ[SymbolName[#],"Ewc0"]&)->OptionValue["Ewc0"])
	];
	Flatten@Join[solFirst,solRest/.solFirst,2]
	]
]


updateCoeffsPd[modelCoeffsSolution_, modelParameters_, newParameters_List, coeffsWc_List, opts : OptionsPattern[{}]]:=Module[{solFirst,solRest},

With[
		{
			newParams=processNewParameters[newParameters,modelParameters]
		},
		
	{solFirst,solRest}=Activate[
		modelCoeffsSolution//.newParameters//.modelParameters/.coeffsWc/.({x_Symbol?(MatchQ[SymbolName[#],"FindRootOptions"]&)}->FilterRules[Flatten@{opts}, Options[FindRoot]])/.(x_Symbol?(MatchQ[SymbolName[#],"Epd0"]&)[j_Integer]:>OptionValue["Epd0["<>IntegerString[j]<>"]"])
	];
	MapThread[Flatten@{#1,#2/.#1}&,{solFirst,solRest}]
	
	]
]


updateCoeffsBond[modelCoeffsSolution_, modelParameters_, newParameters_List, maxMaturity_, coeffsWc_List, opts : OptionsPattern[{}]]:=Module[
{solFirst,solRest},
With[
		{
			newParams=processNewParameters[newParameters,modelParameters]
		},
		(*Echo[(#[maxMaturity]&/@modelCoeffsSolution)//.newParameters//.modelParameters/.coeffsWc,"E"];*)
		{solFirst,solRest}=Activate[
			(#[maxMaturity]&/@modelCoeffsSolution)//.newParameters//.modelParameters/.coeffsWc/.(x_Symbol?(MatchQ[SymbolName[#],"RecurrenceTableOptions"]&)->FilterRules[Flatten@{opts}, Options[RecurrenceTable]])
		];
	Flatten@MapThread[Flatten@{#1,#2/.#1}&,{solFirst,solRest}]
	]
]


updateCoeffsSol//Options ={
	"PrintResidualsNorm"->True,
	"CheckResiduals"->False,
	"Tol"->10.^-16
};
updateCoeffsSol::norm="The norm of the residuals (errors) is `1`";
updateCoeffsSol::largeresid="The norm of the residuals (errors) is `1`, which is larger than the specified tolerance `2`.";
updateCoeffsSol::smallresid="The norm of the residuals (errors) is `1`, which is smaller than the specified tolerance `2`.";


updateCoeffsSol[
	model_Association,
	newParameters_List,
	guessCoeffsSolution_List:{},
	opts : OptionsPattern[
		{
			updateCoeffsSol,
			FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution,
			FernandoDuarte`LongRunRisk`Model`ProcessModels`Private`getStartingValues,
			FindRoot,
			RecurrenceTable
		}
	]	
]:=With[
	{
		parameters=model["parameters"],
		params = model["params"],
		numStocks = model["numStocks"],
		guessCoeffsSolutionWc=FilterRules[guessCoeffsSolution,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc[_]]
	},
	With[
		{
			stockFreeQ=FreeQ[#,_Symbol[_Integer]]&/@(Keys@newParameters),
			optsFindRoot = Flatten[{
				Evaluate[FilterRules[Flatten@{opts},Options[FindRoot]]],
				Evaluate[OptionValue[FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution,{"FindRootOptions"}]]
			}],
			initialGuessEwc = "Ewc0"->If[
				MemberQ[Keys@guessCoeffsSolution,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc[0]],
				FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc[0]/.guessCoeffsSolution,
				First@(Evaluate[OptionValue["initialGuess"]]["Ewc"])
			],
			guessCoeffsSolutionPd=Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd[[0]][j][0],{j,1,numStocks}]/.guessCoeffsSolution,
			ig = Evaluate[OptionValue["initialGuess"]]["Epd"],
			(*initialGuessEpd = First@(First@(Evaluate[OptionValue["initialGuess"]]["Epd"])),*)
			doChecks= OptionValue["PrintResidualsNorm"] || OptionValue["CheckResiduals"],
			optsCheck = FilterRules[Flatten@{opts}, Options[updateCoeffsSol]]
		},
		(*Echo[guessCoeffsSolutionPd,"guessCoeffsSolutionPd"];
		Echo[ig,"ig"];*)
		With[
		{
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
			(*Echo[initialGuessEpd,"initialGuessEpd"];*)
			Module[
				{
					solWc = Nothing,
					solPd = Nothing,
					solFirst,
					solRest,
					solFirstStocks,
					solRestStocks
				},
				Which[
					(*if none of the new parameters are stock parameters*)
					AllTrue[stockFreeQ,TrueQ]
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
			Flatten@{solWc,solPd}
		](*Module*)
	](*With*)
	](*With*)
	](*With*)
](*With*)



(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
