(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];


(* ::Subsection:: *)
(*Public symbols*)


findEulerEqConstants::usage = "findEulerEqConstants[x[t]] or findEulerEqConstants[x[t,i]] finds \
the constants of the price-dividend ratio of the asset whose return is x[t] or x[t,i]."; 
niceEulerEq::usage = "temp"
niceNomEulerEq::usage = "temp"

findBondRecursion::usage = "findBondRecursion[b[t,m]]] finds the recursion satisfied by \
the bond price coefficients in bondeq[t,m] for a bond with maturity m."; 

eulereq::usage = "eulereq[x[t],s,model] or eulereq[x[t,i],s,model] gives the Euler equation for (real) \
	return x[t] or x[t,i] conditional on time s."
nomeulereq::usage = "nomeulereq[x[t],s,model] or nomeulereq[x[t,i],s,model]  gives the Euler equation for \
	nominal return x[t] or x[t,i] conditional on time s."
	
coeff::usage = "coeff[model] solves for the coefficients in the wealth-consumption ratio, price-dividend ratio of stocks, and bond prices."


Begin["`Private`"];


(* ::Subsection:: *)
(*niceEulerEq*)


Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];


(* Euler equation *)
eulereq[x_[t_,i___],s_,model_] := ev[sdf[t],s,model]+(1/2)var[sdf[t],s,model]+ev[x[t,i],s,model]+(1/2)var[x[t,i],s,model]+cov[sdf[t],x[t,i],s,model] 
nomeulereq[x_[t_,i___],s_,model_] := ev[nomsdf[t],s,model]+(1/2)var[nomsdf[t],s,model]+ev[x[t,i],s,model]+(1/2)var[x[t,i],s,model]+cov[nomsdf[t],x[t,i],s,model] 



orderingToTarget[list_,sourceIds_,targetIds_]:=list[[Ordering@sourceIds]][[Ordering@Ordering@targetIds]]
	
niceEulerEq[x_[t_,i___],model_,nominalFlag_:False]:=With[
	{
		stateVars=DeleteDuplicates[DeleteCases[Cases[Variables[model["stateVars"][t] ],z_[_]:>z],0]],
		mapAll = Normal[Join[model["exogenousEq"],model["endogenousEq"]]]
	},
	Module[
	{
		ratio,
		unknowns,
		timeVars,
		timeVarsPolyu,
		newRules,
		newRulesNoConst,
		sortF,
		sortedNewRules,
		newCoeff,
		newReminder,
		coeffC,
		crRules,
		newPoly,
		newC
	},
	stateVarsAnyt:=Alternatives@@Map[Function[{y},y[r_]],stateVars];
	ratio=If[{i} === {},wc[t-1]/.mapAll,pd[t-1,i]/.mapAll];
	unknowns=If[
		{i} === {},
		Sort[Cases[Variables[ratio],FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc[j_]]],
		Sort[Cases[Variables[ratio],FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd[j_]  ]]
	];
	timeVars=DeleteDuplicates[Cases[ratio,stateVarsAnyt,Infinity]];
	timeVarsPolyu=DeleteCases[Flatten[CoefficientList[ratio,unknowns]],0|1]; 
	newRules=CoefficientRules[ratio,unknowns];
	newRulesNoConst = newRules[[2;;,2]];
	sortF[lst_]:=SortBy[lst,{-Total@#,-Max@#}&[Exponent[#,Variables[timeVars] ]]&];(*orders newRules for PolynomialReduce*)
	sortedNewRules=sortF[newRulesNoConst];
	(* use real or nominal euler equation depending on nominalFlag *)
	{newCoeff,newReminder}=If[
		nominalFlag,
		PolynomialReduce[Expand[nomeulereq[x[t,i],t-1,model]],Factor[sortedNewRules],timeVars],
		PolynomialReduce[Expand[eulereq[x[t,i],t-1,model]],Factor[sortedNewRules],timeVars]
	];
	(* undo ordering *)
	newCoeff=orderingToTarget[newCoeff,sortedNewRules,newRulesNoConst];
	coeffC=If[
		{i} === {},
		Table[G[j],{j,0,Length[newCoeff]}],
		Table[F[i,j],{j,0,Length[newCoeff]}]
	];
	newPoly=coeffC . Flatten[{1,newRulesNoConst}];
	newPoly=Replace[
		SortBy[
			List@@newPoly,
			Cases[#,(G|F)[j_,p___]:>{j,p}]&
		],
		List[y__]:>HoldForm[Plus[y]]
	];
	newC=Flatten[{
		coeffC[[1]]->Collect[newReminder,unknowns,Simplify],
		MapThread[#1->#2&,{coeffC[[2;;-1]],Collect[newCoeff,unknowns,Simplify]}]
	}];
	{newPoly,newC}
]
]

(* wrapper for nominal euler eq *)
niceNomEulerEq[x_[t_,i___],model_]:=niceEulerEq[x[t,i],model,True] (* flag True indicates nominal *)


(* ::Subsection:: *)
(*findEulerEqConstants*)


(* find Euler equation for return on consumption portfolio *)
findEulerEqConstants[x_[t_,i___],model_,nominalFlag_:False]:=With[
	{
		mapAll = Normal[Join[model["exogenousEq"],model["endogenousEq"]]]
	},
	Module[
	{
		ruleToEqual,
		eulerEqCoeff,
		systemEq,
		ratio,
		unknownCoefficients
	},
	(* first define some formatting rules *)
	ruleToEqual[a_->b_] := (0==b);

	(* find Euler equation *)
	eulerEqCoeff = niceEulerEq[x[t,i],model,nominalFlag];
	
	(* convert to system of equations on coefficients *)
	systemEq=Map[ruleToEqual,eulerEqCoeff[[2]]];
	ratio=If[{i} === {},wc[t-1]/.mapAll,pd[t-1,i]/.mapAll];
	unknownCoefficients=If[
		{i} === {},
		Sort[Cases[Variables[ratio],FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc[j_]]],
		Sort[Cases[Variables[ratio],FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd[j_]  ]]
	];

	(* return system of equations and the unknowns of the system  *)
	{systemEq,unknownCoefficients}
]
]
(* solve system of equations *)
(* if the system is solvable symbolically, you can solve with the following line *)
(* wSol=Solve[systemEqCons,unknownCoefficients] // Simplify; *)



(* ::Subsection:: *)
(*findBondRecursion*)


(* find Euler equation for bonds, which gives a recursion *)
findBondRecursion[t_,n_,model_]:=With[
	{
		mapAll = Normal[Join[model["exogenousEq"],model["endogenousEq"]]]
	},
	Module[
	{
		ruleToEqual,
		eulerEqBond,
		eulerEqNomBond,
		systemEqBond,
		unknownsCondBond,
		initialCondBond,
		systemEqNomBond,
		unknownsCondNomBond,
		initialCondNomBond
	},
	(* first define formatting rules *)
	ruleToEqual[x_->y_]:=0==y;

	(* get Euler equation for the bonds *)
	eulerEqBond = niceEulerEq[bondret[t+1,n-1],model];
	eulerEqNomBond = niceNomEulerEq[nombondret[t+1,n-1],model]; 

	(* convert to a system of recursive equations *)
	systemEqBond=Map[ruleToEqual,eulerEqBond[[2]]];
	unknownsCondBond=Sort[Cases[bond[t+1,n-1]/.mapAll,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb[m_],Infinity]];
	initialCondBond=Thread[(unknownsCondBond/.((n-1)->0))==0];
	systemEqBond=Flatten[Solve[systemEqBond,unknownsCondBond]]/.Rule->Equal;(* solves for the highest n coefficient, can comment out and recursion will be a set of implicit equations *)
	
	systemEqNomBond=Map[ruleToEqual,eulerEqNomBond[[2]]]/.
		If[
			(*if inflation not defined, set it equal to zero*)
			FreeQ[Join[model["endogenousVars"],model["exogenousVars"]],"pieq"],
			_Symbol?(MatchQ[SymbolName@#,"pi"]&)[__]->0,
			{}
		];
	unknownsCondNomBond = Sort[Cases[nombond[t+1,n-1]/.mapAll,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb[m_],Infinity]];
	initialCondNomBond =Thread[(unknownsCondNomBond/.((n-1)->0))==0];
	(*(*systemEqNomBond=Flatten[Solve[systemEqNomBond,unknownsCondNomBond]]/.Rule->Equal;*) *)	

	(* return all elements of the recursion *)
{	
		{"Real Bonds",systemEqBond,initialCondBond,unknownsCondBond,n},
		{"Nominal Bonds",systemEqNomBond,initialCondNomBond,unknownsCondNomBond,n}
	}
]
]
(* solve recursion *)
(* if the recursion is solvable symbolically, you can solve with the following line *)
(* solBond=RSolve[Flatten[{systemEqBond,initialCondBond}],unknownsCondBond,n]; *)


(* ::Subsection:: *)
(*coeff*)


coeff//Options={
	"initialGuessEwc"->8,
	"initialGuessEPd"->7,
	"maxMaturity"->6,
	"parameters"->{},
	"FindRootOptions"->{MaxIterations->1500(*,"FindRootOptions"->{PrecisionGoal\[Rule]$MachinePrecision,AccuracyGoal\[Rule]$MachinePrecision,WorkingPrecision->$MachinePrecision*)},
	"RecurrenceTableOptions"->{"DependentVariables"->Automatic}
};


coeff[model_, opts : OptionsPattern[{coeff,FindRoot,RecurrenceTable}]]:=With[
	{
		modelAssumptions=model["modelAssumptions"],
		parameters=model["parameters"],
		numStocks=model["numStocks"],
		maxMaturity = Evaluate@OptionValue["maxMaturity"],
		initialGuessEwc = Evaluate@OptionValue["initialGuessEwc"],
		initialGuessEPd = Evaluate@OptionValue["initialGuessEPd"]
	},
	Module[
		{
			newParameters=Evaluate@OptionValue["parameters"],
			ratiosUncondERule,
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
		
		ratiosUncondERule={
			FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Ewc->
				Simplify@FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[wc[t],model],
			FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Epd[j_]->
				Simplify@FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE[pd[t,j],model]
		};

		(* create system of equations for coefficients of wc ratio *)
		{systemWc,unknownsWc}=findEulerEqConstants[retc[t+1],model]/.ratiosUncondERule;
			
		(* create system of equations for coefficients of pd ratios *)
		{systemPd,unknownsPd}=findEulerEqConstants[ret[t+1,j],model]/.ratiosUncondERule;
		
		(* create recursion for price of bonds *)
		bondRecursion = findBondRecursion[t,n+1,model]/.ratiosUncondERule;
		
		(*solve for coefficients of wc ratio *)
		unknownsWcGuess=Prepend[Table[0,Length[unknownsWc]-1],initialGuessEwc];
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
		]/.(x_[n][j_Integer] :> Rule[x[n_][j], Symbol[(SymbolName@x)<>IntegerString[j]][n]]);
		
		(*real bonds*)
		(*add small perturbation to make all coefficients depend on n, otherwise RecurrenceTable does not work*)
		posConstantCoeff=Position[bondRecursion[[1,2]],_?(FreeQ[#,n-1]&),1,Heads->False];
		perturbation=If[posConstantCoeff==={},0,N[10^-18]First@Extract[bondRecursion[[1,4]],posConstantCoeff]/.(n->n-1)];
		bondRecursionPerturbation=MapAt[(#/.(Equal[a_,b_]:>Equal[a,b+perturbation])&),bondRecursion[[1,2]],posConstantCoeff];		
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


processNewParameters::psi="psi=1 implies a constant wealth-consumption ratio, please choose a different psi.";
processNewParameters::param="theta must equal (1-gamma)/(1-1/psi), replacing theta by (1-gamma)/(1-1/psi)=`1`.";
processNewParameters::theta="Plase provide psi or gamma with theta.";
processNewParameters::subsetparam="Provided parameters must be a subset of model[\"parameters\"]= `1`.";


processNewParameters[newParameters:{(_Rule)...},parameters:{(_Rule)..}]:=Module[
	{
		toSymNewParam,
		toSymParam,
		symNewParam,
		symParam,
		posNew,
		newParametersString,
		thetaNew,
		system,
		processedParameters
	},
	If[
		newParameters==={},
		Return[{}],
		newParametersString=Normal@KeyMap[ToString,Association@newParameters];
		If[1===("psi"/.newParametersString),Message[processNewParameters::psi];Abort[];]; (*psi=1 aborts*)
		processedParameters=Switch[
			Count[MemberQ[Keys@newParametersString,#]&/@{"gamma","psi","theta"},True],
				3,
					(*when gamma,psi,theta all provided, override theta*)	
					thetaNew=(1-("gamma"/.newParametersString))/(1-1/("psi"/.newParametersString));
					Message[processNewParameters::param,thetaNew];
					ReplaceAll[newParameters, Rule[s_Symbol?(MatchQ[SymbolName[#],"theta"]&),_] :> Rule[s, thetaNew] ],		
				2,
					(*when 2 of {gamma,psi,theta} are provided solve for the third and add to newParameters*)
					system= (1-ToExpression@("gamma"/.newParametersString))/(1-1/ToExpression@("psi"/.newParametersString)) == ToExpression@("theta"/.newParametersString);
					Join[newParameters,Solve[system,Reals][[1]]],
				1,
					(*if theta provided without gamma or psi, abort -- otherwise, return newParameters unchanged*)
					If[
						MemberQ[SymbolName/@(Keys@newParameters),"theta"],
						Message[processNewParameters::theta];Abort[];,
						newParameters
					],
				_,
				newParameters
		];
		(*make Keys of newParameters match context of Keys of parameters that have the same SymbolName*)
		toSymNewParam=DeleteDuplicates@((Keys@processedParameters)/.x_[j_Integer]:>x);
		toSymParam=DeleteDuplicates@((Keys@parameters)/.x_[j_Integer]:>x);
		symNewParam=SymbolName/@(toSymNewParam);
		symParam=SymbolName/@(toSymParam);
		If[
			Not@SubsetQ[symParam,symNewParam],
			Message[processNewParameters::subsetparam,symParam];Abort[];,	
			posNew=Position[symParam,#]&/@symNewParam;
			Thread[
				(
					Symbol/@MapThread[
						StringJoin,
						{
							Context@@@Extract[Keys@parameters,posNew],
							symNewParam
						}
					]
				) -> 
				(Values@processedParameters)
			]
		]
		(*TO DO: iterate over stocks to not ignore stock parameters*)
	]
]


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
