(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`ToNumber`"]


(* ::Subsection:: *)
(*Public symbols*)


toNum
processNewParameters


(* ::Subsubsection:: *)
(*Usage*)


processNewParameters::usage = "";
toNum::usage = "toNum[model] gives a list of rules to evaluate expressions numerically."<>"\n"<>
			   "toNum[model, parameters] uses the parameters provided in the list of rules parameters."<>"\n"<>
			   "toNum[\"Rules\", model] and toNum[\"Rules\", model, parameters] give substitution rules that can be used to evaluate expressions numerically.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];


(* ::Subsection:: *)
(*ToNumber*)


(*uses starting point from modelsExtraInfo in Catalog.wl if available and initial guess is passed by user*)
toNum["Rules",model_Association,rest__]:= (toNumRules[model,rest,{},ReleaseHold@If[KeyExistsQ[model["extraInfo"],"initialGuess"],"initialGuess"->model["extraInfo"]["initialGuess"],Hold@Sequence[] ] ]);

(*convenience forms that apply rules to expr or allow for postfix notation expr//toNum*)
toNum[expr_/;Not@AssociationQ[expr],model_Association,rest__]:= ReplaceRepeated[expr, toNum["Rules", model, rest] ] 
toNum[model_Association,rest__]:=Function[{expr}, toNum[expr,model,rest]]

(*if rest not provided, use model["params"]*)
toNum["Rules",model_Association]:= toNum["Rules", model,model["params"],{}];
toNum[expr_/;Not@AssociationQ[expr],model_Association]:= toNum[expr,model,model["params"],{}]
toNum[model_Association]:=toNum[model,model["params"],{}]


toNumRules[
	model_Association,
	Longest[newParameters_List : {}, 1],
	Longest[guessCoeffsSolution_List : {}, 2],
	maxMaturity_Integer: 120,
	opts : OptionsPattern[{updateCoeffsSol,checks,FindRoot,RecurrenceTable}]
]:=With[
	{
		params = model["params"],
		numStocks = model["numStocks"],
		uncondEwc = model["ratioUncondE"]["wc"],
		uncondEpd = model["ratioUncondE"]["pd"],
		optsUpdateCoeffsSol = Flatten@{
			FilterRules[Flatten@{opts},Flatten[Options/@{updateCoeffsSol,checks,FindRoot}]]
		},
		optsUpdateCoeffsBond = Flatten@{
			FilterRules[Flatten@{opts},Flatten[Options/@{RecurrenceTable}]]
		}
	},
	Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
(*	Echo[params,"params"];
	Echo[newParameters,"newParameters"];
	Echo[guessCoeffsSolution,"guessCoeffsSolution"];
	Echo[{opts},"opts"];*)
	With[{newParams=processNewParameters[newParameters,params]},
		(*Echo[newParams,"newParams"];*)
		Module[{solRatios,solBond,solNomBond,allParams},
			solRatios=updateCoeffsSol[model,Normal@Join[Association@params,Association@newParams],guessCoeffsSolution,optsUpdateCoeffsSol];	
			solBond=updateCoeffsBond[model["coeffsSolution"]["bond"],params,newParams,maxMaturity,solRatios];
			solNomBond=updateCoeffsBond[model["coeffsSolution"]["nombond"],params,newParams,maxMaturity,solRatios,optsUpdateCoeffsBond];
			allParams=Normal@Join[Association@params,Association@newParams];
			(*Echo[allParams,"allParams"];*)
			Join[
				solRatios,
				solBond,
				solNomBond,
				allParams,
				{
					FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Ewc ->
						(uncondEwc/.solRatios/.allParams),
					FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Epd[ind_] :>
						(uncondEpd/.FernandoDuarte`LongRunRisk`Model`ProcessModels`Private`j->ind/.solRatios/.allParams)
				}
			]
		]
	]
]


(* ::Subsection:: *)
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
			newParametersA=(Association@newParameters)(*//.newParameters*)//.parameters,
			parametersA=(Association@parameters)//.parameters
		},
		(*Echo[newParametersA,"newParametersA"];
		Echo[parametersA,"parametersA"];*)
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
						(*when gamma, psi, theta all provided, ignore theta and issue message unless theta is exactly (1-gamma)/(1-1/psi)*)	
						thetaNew=(1-("gamma"/.newParametersString))/(1-1/("psi"/.newParametersString));
						If[
							RealAbs[("theta"/.newParametersString)-thetaNew]>=$MachineEpsilon,
							Message[processNewParameters::param,thetaNew]
						];
						Append[newParametersSplit,{"Global`","theta"}->thetaNew],		
					2,
						(*when 2 of {gamma, psi, theta} are provided, solve for the third and add to newParameters*)
						system = ( (1-ToExpression@("gamma"/.newParametersString))/(1-1/ToExpression@("psi"/.newParametersString)) == (ToExpression@("theta"/.newParametersString)) );
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


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
