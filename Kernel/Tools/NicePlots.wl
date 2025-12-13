(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`NicePlots`"]


(* ::Subsection:: *)
(*Public symbols*)


yieldCurve
plotCoeffs


(* ::Subsubsection:: *)
(*Usage*)


yieldCurve::usage = "yieldCurve[model, newParameters, coeffsWc, bondType, opts] plots the yield curve";
plotCoeffs::usage = "plotCoeffs[model_Association, sol_List, parameters_List, Ewc0_List, opts: OptionsPattern[]] plots the steps that FindRoot takes to solve for A[0]";


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Load packages*)


Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`Tools`ToNumber`"]


(* ::Subsection:: *)
(*Yield curve*)


yieldCurve//Options={
	"MaxMaturity" -> 12,
	"MomentFunction" -> uncondE
};


yieldCurve[
	model_,
	newParameters_:{},
	coeffsWc_:{},
	bondType : "bond"|"nombond" : "nombond",
	opts : OptionsPattern[{yieldCurve, updateCoeffs, FindRoot, RecurrenceTable}]
]:= With[
	{
		params = model["params"],
		maxMaturity = Evaluate@OptionValue[yieldCurve,"MaxMaturity"],
		momF = Evaluate@OptionValue[yieldCurve,"MomentFunction"],
		initialOpts=Options[FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution]
	},
	Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
	Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
	Needs["FernandoDuarte`LongRunRisk`Tools`ToNumber`"];
	With[
		{
			newParams=processNewParameters[newParameters,params]
		},
			Module[
				{
					solWc,
					solNomBonds,
					yE,
					updateOpts,
					recurrenceOpts,
					coeffsWcList
				},

				Off[Reduce::ratnz];
				(*set options*)					
				SetOptions[FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution, FilterRules[{opts},FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution]];
			PrependTo[Options[FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution],FilterRules[{opts},FindRoot]];
			PrependTo[Options[FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution],FilterRules[{opts},RecurrenceTable]];
					
				(*if coefficients for wc were not provided, compute them*)
				updateOpts = FilterRules[Flatten @ {opts}, Join[Options[updateCoeffs], Options[FindRoot], Options[RecurrenceTable]]];
				recurrenceOpts = FilterRules[Flatten @ {opts}, Options[RecurrenceTable]];
				coeffsWcList = Which[
					coeffsWc === {}, {},
					AssociationQ[coeffsWc] || MatchQ[coeffsWc, {___Rule}], {coeffsWc},
					MatchQ[coeffsWc, {_Association ..}] || MatchQ[coeffsWc, {{___Rule} ..}], coeffsWc,
					True, coeffsWc
				];
				solWc = If[coeffsWcList === {},
					Map[#["A"]&, updateCoeffs[model, newParams, {}, Sequence @@ updateOpts]],
					coeffsWcList
				];
				(*solve bond recursion*)
				solNomBonds=FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[
					model["coeffsSolution"][bondType], params, newParams, maxMaturity, solWc, Sequence @@ recurrenceOpts
				];
				(*compute unconditional expectation of bond yields*)
				yE=Simplify@If[bondType==="nombond", momF@@{nombondyield[t,m],model}, momF@@{bondyield[t,m],model}];
				(*restore options*)
				SetOptions[FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution,initialOpts];
			On[Reduce::ratnz];
			(*yield curve, plot with ListLinePlot[yieldCurve]*)
			Table[{m,yE}/.m->mm,{mm,maxMaturity}]/.solNomBonds
			
		](*Module*)
	](*With*)
](*With*)


(*Plot to visualize solution to Ew0, Epd0
Fix moment function for yield curve
Variance ratios over horizons*)



plotCoeffs[model_Association, sol_List, params_List, Ewc0_List, opts: OptionsPattern[]] :=
	With[
		{
			activateLast = {MapThread},
			system = model["coeffsSystem"]["wc"],
			parameters = Quiet[processNewParameters[params,model["params"]]]
		},
		With[
			{
				inactiveFunctions = DeleteDuplicates @ Cases[system, Inactive[fun_] :> fun, Infinity, Heads -> True],
				alternativesActivateLast = Alternatives@@ activateLast
			},
			With[
				{
					activateFirst = Cases[inactiveFunctions, Except[alternativesActivateLast | FindRoot]]
				},
				With[
					{
						coeffSystem = Quiet[Activate[Activate[system //. parameters//. model["parameters"] /. FernandoDuarte`LongRunRisk`Ewc0 -> Sequence @@ Ewc0, Alternatives @@ activateFirst], alternativesActivateLast],Reduce::ratnz],
						indexToSymbol = x_[i_Integer] :> Symbol[SymbolName[x] <> IntegerString[i]],
						solWithout0 = KeySelect[sol, Not @ MatchQ[#, x_[0]]&]
					},
					With[
						{
							eq0 = First @ Select[coeffSystem[[1, 1, 1]] /. solWithout0, Not @ FreeQ[#, _[0]]&] /. indexToSymbol // N,
							ic0 =  First @ Select[coeffSystem[[1, 1, 2]], Not @ FreeQ[#, _[0]]&] /. indexToSymbol
						},
						{Show@DeleteCases[FullForm[ResourceFunction["FindRootPlot"][Last@eq0, ic0, Flatten @ {opts}]]/.TraditionalForm[x__]->"function",FullForm,Heads->True],Last@eq0, ic0[[{1,3,4}]]}
					](*With*)
				](*With*)
			](*With*)
		](*With*)
	](*With*) 



(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
