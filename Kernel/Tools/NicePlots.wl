(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`NicePlots`"]


(* ::Subsection:: *)
(*Public symbols*)


yieldCurve


(* ::Subsubsection:: *)
(*Usage*)


yieldCurve::usage = "real/nom"


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Load packages*)


Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];


(* ::Subsection:: *)
(*Yield curve*)


yieldCurve//Options={
	"MaxMaturity" -> 12,
	"MomentFunction" -> uncondE
};


yieldCurve[
	model_,
	newParameters_,
	coeffsWc_,
	bondType : "bond"|"nombond" : "nombond",
	opts : OptionsPattern[{yieldCurve, FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution, FindRoot, RecurrenceTable}]
]:= With[
	{
		params = model["params"],
		maxMaturity = Evaluate@OptionValue[yieldCurve,"MaxMaturity"],
		momF = Evaluate@OptionValue[yieldCurve,"MomentFunction"],
		initialOpts=Options[FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution]
	},
	Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
	Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
	With[
		{
			newParams=processNewParameters[newParameters,params]
		},
		Module[
			{
				solWc,
				solNomBonds,
				yE
			},

			Off[Reduce::ratnz];
			(*set options*)					
			SetOptions[FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution, FilterRules[{opts},FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution]];
			PrependTo[Options[FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution],FilterRules[{opts},FindRoot]];
			PrependTo[Options[FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution],FilterRules[{opts},RecurrenceTable]];
				
			(*if coefficients for wc were not provided, compute them*)
			solWc=If[coeffsWc==={}, updateCoeffsWc[model["coeffsSolution"]["wc"], params, newParams,opts], coeffsWc];
			
			(*solve bond recursion*)
			solNomBonds=updateCoeffsBond[model["coeffsSolution"][bondType], params, newParams, maxMaturity, solWc,opts];

			(*compute unconditional expectation of bond yields*)
			yE=Simplify@If[bondType==="nombond", momF@@{nombondyield[t,m],model}, momF@@{bondyield[t,m],model}];

			(*restore options*)
			SetOptions[FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution,initialOpts];
			On[Reduce::ratnz];
			(*yield curve, plot with ListLinePlot[yieldCurve]*)
			Table[{m,yE},{m,maxMaturity}]/.solNomBonds
			
		](*Module*)
	](*With*)
](*With*)


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
