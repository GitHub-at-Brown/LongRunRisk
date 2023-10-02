(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`ToNumber`"]


(* ::Subsection:: *)
(*Public symbols*)


toNum
processNewParameters
toEquation
toExogenousVars
toStateVars


(* ::Subsubsection:: *)
(*Usage*)


toNum::usage = "toNum[model] gives a list of rules to evaluate expressions numerically."<>"\n"<>
			   "toNum[model, parameters] uses the parameters provided in the list of rules parameters."<>"\n"<>
			   "toNum[\"Rules\", model] and toNum[\"Rules\", model, parameters] give substitution rules that can be used to evaluate expressions numerically.";
toEquation::usage = ""
toExogenousVars::usage = ""
toStateVars::usage = ""
processNewParameters::usage = "processNewParameters[newParameters,parameters] returns a validated list of rules to substitute  ";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];


(* ::Subsection:: *)
(*toNum*)


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
	opts : OptionsPattern[{updateCoeffsSol, checks, FindRoot, RecurrenceTable}]
]:=With[
	{
		params = model["params"],
		numStocks = model["numStocks"],
		uncondEwc = model["ratioUncondE"]["wc"],
		uncondEpd = model["ratioUncondE"]["pd"],
		optsUpdateCoeffsSol = Flatten@{
			FilterRules[Flatten@{opts},Flatten[Options/@{updateCoeffsSol, checks, FindRoot}]]
		},
		optsUpdateCoeffsBond = Flatten@{
			FilterRules[Flatten@{opts},Flatten[Options/@{RecurrenceTable}]]
		}
	},
	Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
	With[{newParams=processNewParameters[newParameters,params]},
		With[{allParams=Normal@Join[Association@params,Association@newParams]},
			With[{sol=updateCoeffs[model,allParams,guessCoeffsSolution,"UpdatePd"->True,"UpdateBonds"->True,"MaxMaturity"->maxMaturity,optsUpdateCoeffsSol,optsUpdateCoeffsBond]},
				Join[
					sol,
					allParams,
					{
						FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Ewc ->
							(uncondEwc/.sol//.allParams),
						FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Epd[ind_] :>
							(uncondEpd/.(FernandoDuarte`LongRunRisk`Model`ProcessModels`Private`j->ind)/.sol//.allParams)
					}
				](*Join*)
			](*With*)
		](*With*)
	](*With*)
](*With*)


(* ::Subsection:: *)
(*toEquation*)


toEquation[expr_,model_Association]:= ReplaceAll[expr, Normal@Join[model["exogenousEq"],model["endogenousEq"]] ]
toEquation[model_Association]:=Function[{expr}, toEquation[expr,model]]

(*ToEquation[expr_,model_Association, n_Integer?Positive]:= Nest[ToEquation[#,model]&,expr,n];
ToEquation[model_Association, n_Integer?Positive]:=Function[{expr}, Nest[ToEquation[#,model]&,expr,n]];*)
(*ReplaceAll[expr_,ToEquation[model_]]^:=ToEquation[expr,model]*)


(* ::Subsection:: *)
(*toExogenousVars*)


toExogenousVars[expr_,model_Association]:= ReplaceRepeated[expr, Normal@model["endogenousEq"]] 
toExogenousVars[model_Association]:=Function[{expr}, toExogenousVars[expr,model]]


(* ::Subsection:: *)
(*toStateVars*)


toStateVars[expr_,model_Association]:= ReplaceRepeated[expr, Normal@model["toStateVars"]] 
toStateVars[model_Association]:=Function[{expr}, toStateVars[expr,model]]


(* ::Subsection:: *)
(*processNewParameters*)


processNewParameters::psi="psi=1 implies a constant wealth-consumption ratio, please choose a different psi.";
processNewParameters::param="theta must equal (1-gamma)/(1-1/psi), replacing theta by (1-gamma)/(1-1/psi)=`1`.";
processNewParameters::theta="Plase provide psi or gamma with theta.";
processNewParameters::subsetparam="Parameters `1` in newParameters are not a subset of parameters.";


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
			If[1.===N@("psi"/.newParametersString), Message[processNewParameters::psi]; Abort[]; ]; (*psi=1 aborts*)
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
