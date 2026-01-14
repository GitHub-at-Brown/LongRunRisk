(* ::Package:: *)

(* ::Section:: *)
(*ComputationalEngine Test Helpers Package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`Common`"]


(* ::Subsection:: *)
(*Public symbols*)


(* ExogenousEq Private symbols *)
$pi; $dc; $sg; $dd;

(* EndogenousEq Private symbols *)
$A; $B; $R; $P; $wc; $pd; $t; $retc; $ret; $bondret; $nombondret;

(* Coefficient symbols for Euler equations *)
$coefwc; $coefpd; $coefb; $coefnb;

(* ComputationalEngine Private symbols *)
$evNoEps; $lagStateVarst; $createSystem; $uncondEStep;

(* createSystem solution symbols *)
$pi1; $sg1; $pi2; $sg2; $pi1sg1;

(* Test utilities *)
simplifiesZeroQ; allNumericQ; exportedSymbolQ;


(* ::Subsubsection:: *)
(*Usage*)


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*ExogenousEq Private Symbols*)


$pi = FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi;
$dc = FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dc;
$sg = FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg;
$dd = FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`dd;


(* ::Subsection:: *)
(*EndogenousEq Private Symbols*)


$A = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A;
$B = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B;
$R = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`R;
$P = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`P;
$wc = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`wc;
$pd = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`pd;
$t = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`t;
$retc = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`retc;
$ret = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`ret;
$bondret = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondret;
$nombondret = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`nombondret;


(* ::Subsection:: *)
(*ComputationalEngine Private Symbols*)


$evNoEps = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`evNoEpsStateVarsProduct;
$lagStateVarst = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst;
$createSystem = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`createSystem;
$uncondEStep = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`uncondEStep;


(* ::Subsection:: *)
(*createSystem Solution Symbols*)


$pi1 = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`pi1;
$sg1 = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`sg1;
$pi2 = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`pi2;
$sg2 = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`sg2;
$pi1sg1 = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`pi1sg1;


(* ::Subsection:: *)
(*Euler Equation Coefficient Symbols*)


$coefwc = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc;
$coefpd = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd;
$coefb = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb;
$coefnb = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb;


(* ::Subsection:: *)
(*Test Utility Functions*)


(* Check if expression simplifies to zero *)
simplifiesZeroQ[expr_] := PossibleZeroQ[Simplify[expr]]

(* Check if all elements in a nested list are numeric *)
allNumericQ[list_] := AllTrue[Flatten[list], NumericQ]

(* Check if a symbol is properly exported (has usage, values, or definitions) *)
exportedSymbolQ[s_Symbol] := AnyTrue[
	{
		ValueQ[s],
		OwnValues[s] =!= {},
		DownValues[s] =!= {},
		StringQ[MessageName[s, "usage"]]
	},
	TrueQ
]


(* ::Section:: *)
(*End package*)


End[] (*"`Private`"*)


EndPackage[]
