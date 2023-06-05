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


yieldCurve//Options = {
	"MaxMaturity" -> 12(*,
	"MomentFunction" -> uncondE*)
}


yieldCurve[
	model_,
	newParameters_:{},
	coeffsWc_:{},
	bondType : "bond"|"nombond" : "nombond",
	opts : OptionsPattern[{yieldCurve}]
]:= With[
	{
		params = model["params"],
		maxMaturity = Evaluate@OptionValue[yieldCurve,"MaxMaturity"]
	},
	With[
		{
			newParams=processNewParameters[newParameters,params]
		},
		Module[
			{
				solWc,
				solNomBonds,
				yE,
				yieldCurve
			},
			Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
			Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
			
			(*if coefficients for wc were not provided, compute them*)
			solWc=If[coeffsWc==={}, updateCoeffsWc[model["coeffsSolution"]["wc"], params, newParams], coeffsWc];
			
(*			Echo[solWc,"solWc"];
			Echo[maxMaturity,"maxMaturity"];
			Echo[newParams,"newParams"];
			Echo[params,"params"];*)
			
			(*solve bond recursion*)
			solNomBonds=updateCoeffsBond[model["coeffsSolution"][bondType], params, newParams, maxMaturity, solWc];
			
			(*compute unconditional expectation of bond yields*)
			yE=Simplify@If[bondType==="nombond", (*OptionValue[yieldCurve,"MomentFunction"]*)uncondE[nombondyield[t,m],model], (*OptionValue[yieldCurve,"MomentFunction"]*)uncondE[bondyield[t,m],model]];
			
			(*yield curve, plot with ListLinePlot[yieldCurve]*)
			Table[{m,yE},{m,maxMaturity}]/.solNomBonds
		](*Module*)
	](*With*)
](*With*)


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
