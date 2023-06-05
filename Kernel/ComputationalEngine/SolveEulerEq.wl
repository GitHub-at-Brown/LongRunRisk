(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];


(* ::Subsection:: *)
(*Public symbols*)


coeff::usage = "coeff[model] solves for the coefficients in the wealth-consumption ratio, price-dividend ratio of stocks, and bond prices."
processNewParameters::usage = "";
updateCoeffSol::usage = "";
createStartingPoint::usage = "";
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

which can be used in a call FindRoot[ ... , sv]."


Begin["`Private`"];


(* ::Subsection:: *)
(*coeff*)


solveEulerEq//Options={
	"initialGuess" -> <|"Ewc"->{6},"Epd"->{{4.1}}|>,
	"maxMaturity"->6,
	"parameters"->{},
	"FindRootOptions"->{MaxIterations->1500(*,"FindRootOptions"->{PrecisionGoal\[Rule]$MachinePrecision,AccuracyGoal\[Rule]$MachinePrecision,WorkingPrecision->$MachinePrecision*)},
	"RecurrenceTableOptions"->{"DependentVariables"->Automatic}
};


coeff::badextrainfo="The rules provided in modelsExtraInfo[\"coeffs\"] do not solve the Euler equation. Switching to a numerical solution.";


coeff[model_, opts : OptionsPattern[{coeff,FindRoot,RecurrenceTable}]]:=With[
	{
		modelAssumptions=model["modelAssumptions"],
		parameters=model["parameters"],
		numStocks=model["numStocks"],
		maxMaturity = Evaluate@OptionValue["maxMaturity"],
		initialGuessEwc = Evaluate@OptionValue["initialGuessEwc"],
		initialGuessEpd = Evaluate@OptionValue["initialGuessEpd"],
		(*rules that re-write Ewc, Epd in terms of the coefficients of wc[t] or pd[t,j]*)
		ratiosUncondERuleWc={
			FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Ewc :>
				Simplify@FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[wc[t],model]
		},
		ratiosUncondERulePd ={
			ratiosUncondERuleWc,
			FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Epd[j_] :> Simplify@FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[pd[t,j],model]
		}
	},
	Module[
		{
			newParameters=Evaluate@OptionValue["parameters"],
			systemWc,
			unknownsWc,
			systemPd,
			unknownsPd,
			bondRecursion,
			unknownsWcGuess,
			solWc,
			unknownsPdGuess,
			solOnePd,
			solPd,
			bondCoefficientRules,
			posConstantCoeff,
			perturbation,
			bondRecursionPerturbation,
			solBondNum,
			solBond,
			posConstantCoeffNom,
			perturbationNom,
			bondRecursionPerturbationNom,
			solNomBondNum,
			solNomBond
		},
		(*check, process newParameters*)
		newParameters = processNewParameters[newParameters,parameters];

		(* create system of equations for coefficients of wc ratio *)
		{systemWc,unknownsWc}=findEulerEqConstants[retc[t+1],model]/.ratiosUncondERuleWc;
			
		(* create system of equations for coefficients of pd ratios *)
		{systemPd,unknownsPd}=findEulerEqConstants[ret[t+1,j],model]/.ratiosUncondERulePd[j];
		
		(* create recursion for price of bonds *)
		bondRecursion = findBondRecursion[t,n+1,model]/.ratiosUncondERuleWc;
		
		(*solve for coefficients of wc ratio *)
		unknownsWcGuess=Prepend[Table[0,Length[unknownsWc]-1],ratiosUncondERuleWc];
		solWc=FindRoot[
			systemWc//.newParameters//.parameters,
			Thread@List[unknownsWc,unknownsWcGuess],
			Evaluate[FilterRules[{opts}, Options[FindRoot]]],
			Evaluate@OptionValue["FindRootOptions"]
		];
			
		(*solve for coefficients of pd ratios *)
		unknownsPdGuess=Prepend[Table[0,Length[unknownsPd]-1],initialGuessEPd];
		solOnePd[stockNumber_]:=FindRoot[
			systemPd/.j->stockNumber//.solWc//.newParameters//.parameters,
			Thread@List[unknownsPd,unknownsPdGuess]/.j->stockNumber,
			Evaluate[FilterRules[{opts}, Options[FindRoot]]],
			Evaluate@OptionValue["FindRootOptions"]
		];
		solPd=solOnePd[#]&/@Range[numStocks];
		
		(*solve for bond prices *)
		bondCoefficientRules=Join[
			bondRecursion[[1,4]],
			bondRecursion[[2,4]]
		]/.(x_[n][j_Integer] :> RuleDelayed[x[m_][j], Symbol[(SymbolName@x)<>IntegerString[j]][m]]);
		
		(*real bonds*)
		(*add small perturbation to make all coefficients depend on n, otherwise RecurrenceTable does not work*)
		posConstantCoeff=Position[bondRecursion[[1,2]],_?(FreeQ[#,n-1]&),1,Heads->False];
		perturbation=If[posConstantCoeff==={},0,N[10^-18]*First@Extract[bondRecursion[[1,4]],posConstantCoeff]/.(n->n-1)];
		bondRecursionPerturbation=MapAt[(#/.(Equal[a_,b_]:>Equal[a,b+perturbation])&),bondRecursion[[1,2]],posConstantCoeff];
		(*TO DO: check out AsymptoticRSolveValue for long maturities*)
		solBondNum=RecurrenceTable[
			Flatten[
				{
					bondRecursionPerturbation,
					bondRecursion[[1,3]]
				}
			]//.newParameters//.parameters/.solWc/.bondCoefficientRules,
			bondRecursion[[1,4]]/.bondCoefficientRules,
			{n,1,maxMaturity},
			Evaluate[FilterRules[{opts}, Options[RecurrenceTable]]],
			Evaluate@OptionValue["RecurrenceTableOptions"]
		]//Column//Chop;		
		solBond=Flatten[{bondRecursion[[1,3]]/. Equal->Rule,Table[Thread[bondRecursion[[1,4]]->solBondNum[[1,n]]],{n,1,maxMaturity}]}];
		
		(*nominal bonds*)
		posConstantCoeffNom=Position[bondRecursion[[2,2]],_?(FreeQ[#,n-1]&),1,Heads->False];
		perturbationNom=If[posConstantCoeffNom==={},0,10^-18 First@Extract[bondRecursion[[2,4]],posConstantCoeffNom]/.(n->n-1)];(*(Last@bondRecursion[[1,4]] /.n->n-1)*)
		bondRecursionPerturbationNom=MapAt[(#/.(Equal[a_,b_]:>Equal[a,b+perturbationNom])&),bondRecursion[[2,2]],posConstantCoeffNom];		
		solNomBondNum=RecurrenceTable[
			Flatten[
				{
					bondRecursionPerturbationNom,
					bondRecursion[[2,3]]
				}
			]//.newParameters//.parameters/.solWc/.bondCoefficientRules,
			bondRecursion[[2,4]]/.bondCoefficientRules,
			{n,1,maxMaturity},
			Evaluate[FilterRules[{opts}, Options[RecurrenceTable]]],
			Evaluate@OptionValue["RecurrenceTableOptions"]
		]//Column//Chop;	
		solNomBond=Flatten[{bondRecursion[[2,3]]/. Equal->Rule,Table[Thread[bondRecursion[[2,4]]->solNomBondNum[[1,n]]],{n,1,maxMaturity}]}];
		
		Flatten@{solWc,solPd,solBond,solNomBond}
	]
]


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
(*createStartingPoint*)


createStartingPoint::coeffswc = "infoModel[\"modelAssumptions\"] requires values of the wealth-consumption ratio
coefficients to be provided as an association with key \"coeffsSolution\" in opts, e.g., 
opts={ \"coeffsSolution\"-> <|\"wc\"-> {A[0]\[Rule]4.59,A[1],...}|>}";


createStartingPoint[
	coefficientNames_,
	ratioUncondE_,
	numStocks_Integer:1,
	opts_List:{},
	infoModel_Association:<||>
]:=With[
	{
		ratio = If[FreeQ[coefficientNames,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc],"pd","wc"]
	},
	With[
		{
			iEv = "E"<>ratio,
			startValues=formatStartingValues[coefficientNames, ratioUncondE, opts, infoModel]
		},		
		Module[{out},
			Catch[
				With[
					{
						dimStartValues=Dimensions@startValues
					},
					If[
						StringMatchQ[ratio,"pd"] && (*createStartingPoints for stocks*)
						Not@KeyExistsQ[opts,"stocksSolvedQ"] || (KeyExistsQ[opts,"stocksSolvedQ"] && Not@TrueQ["stocksSolvedQ"/.opts]) &&  (*opts["stocksSolvedQ"] is used as an internal state that indicates createStartingPoint has already been run for stocks*)
						MatchQ[ First@dimStartValues, 1 | model["numStocks"]] && MatchQ[Length@coefficientNames, dimStartValues[[2]]] (*dimensions of startValues are correct*)
						,
						(*If[
							(*if infoModel["modelAssumptions"][iEv] exists*)
							KeyExistsQ[infoModel,"modelAssumptions"] && KeyExistsQ[infoModel["modelAssumptions"],iEv] &&
							(*and if infoModel["modelAssumptions"] has expressions that contain the coefficients
							of the wealth-consumption ratio*)
							Not@FreeQ[infoModel["modelAssumptions"][iEv],FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc] &&
							(*and if user did not provide the coefficients inside opts*) 
							(Not@KeyExistsQ[opts,"coeffsSolution"] || Not@KeyExistsQ["coeffsSolution"/.opts,"wc"])
							,
							(*issue message and abort*)
							Message[createStartingPoint::coeffswc];Abort[];
						];*)
						out=With[
							{
								j=Last@Head@First@coefficientNames
							},
							MapIndexed[
								createStartingPoint[
									coefficientNames /. j -> (First@#2),
									ratioUncondE /. j -> (First@#2),
									numStocks,
									{"initialGuess" -> <|"Epd" -> (#1 /. j -> (First@#2) )|>, "stocksSolvedQ" -> True},
									infoModel  //.
										If[
											(*infoModel["modelAssumptions"][iEv] does not exist*)
											(Not@KeyExistsQ[infoModel,"modelAssumptions"] || Not@KeyExistsQ[infoModel["modelAssumptions"],iEv])
												(*or infoModel["modelAssumptions"][iEv] is free of coefficients of the price-dividend ratio with index other than 0*)
												||FreeQ[infoModel["modelAssumptions"][iEv],FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd[Except[0]]]
											,
											(*then nothing to do*)
											{}
											,
											(*otherwise, use the provided coefficients*)
											infoModel["coeffs"][ratio]
										] /. j -> (First@#2)
								]&,
								If[
									(*if user provided a single set of starting values but there are more stocks, use the same starting value for all stocks*)
									((First@dimStartValues)===1) && (numStocks>1),
									Table[Replace[startValues[[1]],B_[1][ind_]:>B[k][ind],{2}],{k,numStocks}],
									startValues
								]
							](*MapIndexed*)
						];(*With*)
						Throw[out];
					];(*If*)
				];(*With*)		
				With[
					{
						guessFirst = First@startValues
					},
					With[
						{
							guessFirstValues = Rest@guessFirst,
							coeff0 = First@coefficientNames
						},
						Module[
							{
								boundsGuess0,
								boundsInfo0,
								bounds0,
								guess0,
								lb,
								ub,
								fv,(*maybe move to With*)
								intervalPattern,(*maybe move to With*)
								intervals0(*maybe move to With*)
							},
							boundsGuess0=Switch[
								Length[guessFirstValues],
								1, True,
								2, Inequality[guessFirstValues[[1]],LessEqual,coeff0,LessEqual,guessFirstValues[[2]]],
								3, Inequality[guessFirstValues[[2]],LessEqual,coeff0,LessEqual,guessFirstValues[[3]]]
							];		
							(*combine with assumptions*)	
							boundsInfo0=If[
								KeyExistsQ[infoModel,"modelAssumptions"] && KeyExistsQ[infoModel["modelAssumptions"],iEv]
								,
								infoModel["modelAssumptions"][iEv]
								,
								True
							];
							bounds0= Inactive[Reduce][Inactive[Simplify][ boundsGuess0 && boundsInfo0 && 0 < coeff0 < 15], coeff0];
							fv=First@guessFirstValues;
							intervalPattern=Alternatives@@((Inequality[ lb_?NumberQ,#[[1]],coeff0,#[[2]], ub_?NumberQ])&/@Tuples[{Less,LessEqual},2]);
							intervals0=Inactive[Cases][bounds0,intervalPattern :> {coeff0,Inactive[If][Inactive[TrueQ][lb<=fv<=ub],fv,(lb+ub)/2],lb,ub},{0,1}];
							guess0=Inactive[If][
								Inactive[SameQ][{}, intervals0]
								,
								(*if assumptions don't give an interval, use initial guess only*)
								{guessFirst}
								,
								(*if assumptions do give an interval, use it*)
								intervals0
							];		
							Inactive[Map][Join[{#},Rest@startValues]&, guess0]
						](*Module*)
					](*With*)
				](*With*)
			](*Catch*)
		](*Module for stocks*)
	](*With*)
](*With*)


(* ::Subsubsection:: *)
(*formatStartingValues*)


formatStartingValues::badformat = "The format of `1` for starting points is incorrect. Try setting starting points using the optional argument {\"initialGuess\" -> \[LeftAssociation]\"Ewc\"\[Rule]{4.5},\"Epd\"\[Rule]{4.5}\[RightAssociation]}."


formatStartingValues[
	coefficientNames_List,
	ratioUncondE_,
	opts_:{},
	infoModel_:<||>
]:=With[
	{
		ratio = If[FreeQ[coefficientNames,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc],"pd","wc"],
		pattern1 = (VectorQ[#,NumberQ] && 1<=Length[#]<=3)&,
		pattern2 = { {_?(Not@NumberQ[#]&),Repeated[_?NumberQ,{1,3}]}..}
	},
	With[
		{
			pattern3 = (ListQ[#] && pattern1[First@#] && MatchQ[Rest@#, {} | pattern2])&,
			ig = getStartingValues[ratio,opts,infoModel]
		},
		Module[{out},
			Catch[
				If[
					StringMatchQ[ratio,"pd"] && And@@((pattern1[#] || (ListQ[#] && MatchQ[#, pattern2]) || pattern3[#])& /@ig)
					,
					out=With[
						{
							j=Last@Head@First@coefficientNames
						},
						MapIndexed[
							formatStartingValues[
								coefficientNames /. (j -> (First@#2)), 
								ratioUncondE /. (j -> (First@#2)), 
								{"initialGuess" -> <|"Epd" -> #1|>},
								infoModel/. (j -> (First@#2))
							]&,ig
						]
					];
					Throw[out];
				];
				With[
					{
						firstIg = First@ig,
						restIg = Rest@ig
					},
					With[
						{
							firstNames = First@coefficientNames,
							restNames = Rest@coefficientNames
						},
						Which[
							(*a number or a vector of up to three numbers*)
							(*NumberQ[ig] || (VectorQ[ig,NumberQ] && 1<=Length[ig]<=3)*)
							NumberQ[ig] || pattern1[ig]
							,
							(*wrap ig in list, add zeros for all other variables*)
							If[
								Length[ig]===2,
								Join[{Flatten@{firstNames,Mean@ig,ig}},Thread[{#,0}]&/@restNames],
								Join[{Flatten@{firstNames,ig}},Thread[{#,0}]&/@restNames]
							]
							,
							(*a list of lists, with sublists having 1 to 3 numbers as their last entries*)
							(*ListQ[ig] && MatchQ[ig, { {_?(Not@NumberQ[#]&),Repeated[_?NumberQ,{1,3}]}..}]*)
							ListQ[ig] && MatchQ[ig, pattern2]
							,
							(*reformat to only include needed coefficients and fix the context of the coefficients if needed*)
							Join[{Flatten@{firstNames,Rest@(firstIg)}},formatStartingValuesRest[restIg,restNames]]
							,
							(*ListQ[ig] && (NumberQ[firstIg]||(VectorQ[firstIg,NumberQ]&&1<=Length[firstIg]<=3))  &&  MatchQ[restIg, {} | { {_?(Not@NumberQ[#]&),Repeated[_?NumberQ,{1,3}]}..}]*)
							pattern3[ig]
							,
							Module[
								{
									guessRest,
									guessRules,
									guessFirst,
									keys,
									values,
									uncondERatio
								},
								guessRest=formatStartingValuesRest[restIg,restNames];
								guessRules = MapThread[#1 -> If[Length[#2]==2,Mean[#2],#2[[1]]]&,{First/@guessRest,Rest/@guessRest}];
								guessFirst=Solve[(ratioUncondE/.guessRules)==uncondERatio,firstNames,Reals];
								keys = Keys[guessFirst];
								values = Switch[
									Length[firstIg],
									1,
										Values@(guessFirst/.uncondERatio->First@firstIg),
									2,
										Join[Values@(guessFirst/.uncondERatio->Mean@firstIg),Sort@@@(Values@(guessFirst/.(uncondERatio->(firstIg)))),2],
									3,
										Join[Values@(guessFirst/.uncondERatio->First@firstIg),Sort@@@(Values@(guessFirst/.(uncondERatio->(Rest@firstIg)))),2]
								];
								Join[Join[keys,values,2],guessRest]
							](*Module*)
							,
							(*all other cases*)
							True
							,
							Abort[];
						](*Which*)
					](*With*)
				](*With*)
			](*Catch for stocks*)
		](*Module for stocks*)
	](*With*)
](*With*)

getStartingValues[ratio_String,opts_:{},infoModel_:<||>]:=With[
	{
		iEv = "E"<>ratio
	},
	(*get initial guess from the places where it can be provided*)
	ig=Which[
		(*optional argument in call to solveEulerEq*)
		KeyExistsQ[opts,"initialGuess"] && KeyExistsQ["initialGuess"/.opts,iEv],
			("initialGuess"/.opts)[iEv],
		(*modelsExtraInfo[modKey]["initialGuess"] in Catalog.wl*)
		KeyExistsQ[infoModel,"initialGuess"] && KeyExistsQ[infoModel["initialGuess"],iEv],
			infoModel["initialGuess"][iEv],
		(*default function option*)
		KeyExistsQ[Options[solveEulerEq],"initialGuess"] && KeyExistsQ["initialGuess"/.Options[solveEulerEq],iEv],
			("initialGuess"/.Options[solveEulerEq])[iEv],
		(*a number*)
		True,
			Switch[ratio,"wc",{4},"pd",{{6}}]
	]
]

formatStartingValuesRest[startingValuesRest_,coefficientNamesRest_List]:=Module[
	{
		all,
		guess,
		inter,
		overlapAll,
		overlapGuess,
		overlapNames,
		noOverlapNames,
		noOverlapNamesGuess,
		overlapNamesGuess
	},
	all=ReplaceAll[coefficientNamesRest, ( a_[j__] | a_)[ind_] :> {SymbolName@a,If[j===Sequence ,Nothing,Switch[ Head[j],Symbol,SymbolName@j,Integer,IntegerString@j,_,ToString@j]],ind}];
	guess=Replace[First/@startingValuesRest, ( a_[j__] | a_)[ind_] :> {SymbolName@a,If[j===Sequence ,Nothing,Switch[ Head[j],Symbol,SymbolName@j,Integer,IntegerString@j,_,ToString@j]],ind},{1}];
	inter=Intersection[all,guess];
	overlapAll=PositionIndex[all][#]&/@(Keys@PositionIndex[inter]);
	overlapGuess=PositionIndex[guess][#]&/@(Keys@PositionIndex[inter]);
	overlapNames=Extract[coefficientNamesRest,overlapAll];
	noOverlapNames = Complement[coefficientNamesRest,overlapNames];
	noOverlapNamesGuess=Thread[{#,0}]&/@noOverlapNames;
	overlapNamesGuess=MapIndexed[Join[overlapNames[[#2]],Rest@#1]&,Extract[startingValuesRest,overlapGuess]];
	SortBy[Join[overlapNamesGuess,noOverlapNamesGuess],First]
]


(* ::Subsection:: *)
(*updateCoeffSol*)


updateCoeffSol//Options ={
"PrintResidualsNorm"->True,
"CheckResiduals"->True,
"Tol"->10^-16
};
updateCoeffSol::largeresid="The norm of the residuals (errors) is `1`, which is larger than the specified tolerance `2`.";


checks[eqs_, sol_, params_, newParams_] :=
	With[{residualsNorm = Norm @ (Subtract @@@ (eqs //. newParams //. params
		 //. sol))},
		If[TrueQ @ OptionValue["PrintResidualsNorm"],
			Echo[residualsNorm, "Norm of residual (error) for the wealth-consumption ratio coefficients"
				];
		];
		If[TrueQ @ OptionValue["CheckResiduals"] && TrueQ[residualsNorm >= 
			OptionValue["Tol"]],
			Message[updateCoeffSol::check, residualsNorm, OptionValue["Tol"]]
		];
	];


(* ::Input::Initialization:: *)
updateCoeffSol[model_Association,newParameters_List,GuessCoeffsSolution_List:{}]:=With[
{
	parameters=model["parameters"],
	params = model["params"]
},
	With[
	{
		newProcessedParam=processNewParameters[newParameters,params]
	},
	With[
	{
	stockFreeQ=FreeQ[#,_Symbol[_Integer]]&/@(Keys@newProcessedParam),
	doChecks=TrueQ@OptionValue["PrintResidualsNorm"] || TrueQ@OptionValue["CheckResiduals"] 
	},
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
		{solFirst,solRest}=Activate[model["coeffsSolution"]["wc"]//.newProcessedParam//.parameters];
		solWc=Flatten@Join[solFirst,solRest/.solFirst,2];
		
		If[
		doChecks,
		checks[First@model["coeffsSystem"]["wc"],solWc,parameters,newProcessedParam];
		];
	,
	(*if all of the new parameters are stock parameters*)
	AllTrue[Not/@stockFreeQ,TrueQ]
	,
		(*only update price-dividend ratio coefficients*)
		solWc=If[GuessCoeffsSolution==={},
		(*if coefficients for wc were not provided, will have to compute them anyway*)
		{solFirst,solRest}=Activate[model["coeffsSolution"]["wc"]//.newProcessedParam//.parameters];
		Flatten@Join[solFirst,solRest/.solFirst,2],
		GuessCoeffsSolution
		];
		
		{solFirstStocks,solRestStocks}=Activate[model["coeffsSolution"]["pd"]//.newProcessedParam//.parameters /.solWc,Reduce|Simplify|Cases|Flatten|If|TrueQ|SameQ |Map | MapThread]//Activate;
		solPd=MapThread[Flatten@{#1,#2/.#1}&,{solFirstStocks,solRestStocks}];
		(*TO DO: If[doChecks, ... ];*)
	,
	(*both stock and non-stock parameters*)
	True
	,
		{solFirst,solRest}=Activate[model["coeffsSolution"]["wc"]//.newProcessedParam//.parameters];
		solWc=Flatten@Join[solFirst,solRest/.solFirst,2];

		{solFirstStocks,solRestStocks}=Activate[model["coeffsSolution"]["pd"]//.newProcessedParam//.parameters /.solWc,Reduce|Simplify|Cases|Flatten|If|TrueQ|SameQ |Map | MapThread]//Activate;
		solPd=MapThread[Flatten@{#1,#2/.#1}&,{solFirstStocks,solRestStocks}];

		If[
			doChecks,
			checks[First@model["coeffsSystem"]["wc"],solWc,parameters,newProcessedParam];
		];(*TO DO: checks for stocks;*)

];(*Which*)
Flatten@{solWc,solPd}
](*Module*)
](*With*)
](*With*)
](*With*)



(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
