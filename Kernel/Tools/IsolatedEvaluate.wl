(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`IsolatedEvaluate`"]


(* ::Subsection:: *)
(*Public symbols*)


isolatedEvaluate


(* ::Subsubsection:: *)
(*Usage*)


isolatedEvaluate::usage = "isolatedEvaluate[expr, opts] evaluates expr in memory-isolated LocalEvaluate subprocess with $HistoryLength=0.
Options:
  \"Bindings\" -> {} - Rules to substitute into held expression
  \"Assumptions\" -> None - Wrap with Assuming[...]
  \"Quiet\" -> True - Suppress Simplify/FullSimplify timeout messages
  \"HistoryLength\" -> 0 - $HistoryLength inside Block
  \"LocalTimeout\" -> None - TimeConstrained inside LocalEvaluate
  \"LocalTimeoutValue\" -> $Failed - Return value on local timeout
  \"HardTimeout\" -> None - TimeConstrained around LocalEvaluate
  \"HardTimeoutValue\" -> $Failed - Return value on hard timeout"


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*isolatedEvaluate*)


SetAttributes[isolatedEvaluate, HoldFirst]


Options[isolatedEvaluate] = {
	"Bindings" -> {},
	"Assumptions" -> None,
	"Quiet" -> True,
	"HistoryLength" -> 0,
	"LocalTimeout" -> None,
	"LocalTimeoutValue" -> $Failed,
	"HardTimeout" -> None,
	"HardTimeoutValue" -> $Failed
}


isolatedEvaluate[expr_, opts : OptionsPattern[]] := Module[
	{
		bindings = OptionValue["Bindings"],
		ass = OptionValue["Assumptions"],
		quiet = OptionValue["Quiet"],
		hist = OptionValue["HistoryLength"],
		localT = OptionValue["LocalTimeout"],
		localTVal = OptionValue["LocalTimeoutValue"],
		hardT = OptionValue["HardTimeout"],
		hardTVal = OptionValue["HardTimeoutValue"],
		body
	},

	(* Start with held expression - CRITICAL for correct evaluation order *)
	body = Hold[expr];

	(* Apply bindings FIRST - substitute values into held expression *)
	If[bindings =!= {},
		body = body /. bindings
	];

	(* Wrap with Assuming if specified *)
	If[ass =!= None,
		body = With[{a = ass}, Replace[body, Hold[e_] :> Hold[Assuming[a, e]]]]
	];

	(* Wrap with Quiet if specified - suppresses Simplify/FullSimplify timeout messages *)
	If[quiet,
		body = Replace[body, Hold[e_] :> Hold[Quiet[e, {Simplify::time, Simplify::gtime, FullSimplify::time, FullSimplify::gtime}]]]
	];

	(* Wrap with inner TimeConstrained if specified *)
	If[localT =!= None,
		body = With[{t = N@localT, v = localTVal},
			Replace[body, Hold[e_] :> Hold[TimeConstrained[e, t, v]]]
		]
	];

	(* Wrap with LocalEvaluate + Block - the core pattern *)
	body = With[{h = hist},
		Replace[body, Hold[e_] :> Hold[LocalEvaluate[Block[{$HistoryLength = h}, e]]]]
	];

	(* Wrap with outer TimeConstrained if specified - MUST be inside Hold *)
	If[hardT =!= None,
		body = With[{t = N@hardT, v = hardTVal},
			Replace[body, Hold[le_] :> Hold[TimeConstrained[le, t, v]]]
		]
	];

	(* Release and evaluate the complete expression *)
	ReleaseHold[body]
]


(* ::Section:: *)
(*End package*)


End[] (*"`Private`"*)


EndPackage[]
