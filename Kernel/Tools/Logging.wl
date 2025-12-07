(* ::Package:: *)

(* ::Section:: *)
(*Logging*)


(* ::Subsection:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`Logging`"];


(* ::Subsection:: *)
(*Public symbols*)


LRRProgress;
LRRTimed;
$LRRVerbose;
initializeLogging;


(* ::Subsubsection:: *)
(*Usage*)


LRRProgress::usage = "LRRProgress[expr] wraps expr with progress indication. \
In notebooks, shows a spinning progress indicator. In CLI, evaluates silently. \
Respects both $LRRVerbose and $ProgressReporting.";

LRRTimed::usage = "LRRTimed[expr, label] evaluates expr and prints timing with label. \
Respects $LRRVerbose. Use for single operations that need timing output.";

$LRRVerbose::usage = "$LRRVerbose controls LongRunRisk output verbosity. \
Values: \"Silent\" | \"Normal\" (default). \
When \"Silent\", progress and timing output is suppressed.";

initializeLogging::usage = "initializeLogging[] initializes the logging system. \
Call once at paclet load time (from LongRunRisk.wl). Always returns True.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Initialize defaults*)


If[!ValueQ[$LRRVerbose], $LRRVerbose = "Normal"];


(* ::Subsection:: *)
(*initializeLogging*)


(* initializeLogging[] is a no-op, kept for backwards compatibility *)
initializeLogging[] := True;


(* ::Subsection:: *)
(*shouldShowProgress*)


(* Helper: should we show progress? *)
(* Show progress unless explicitly disabled *)
shouldShowProgress[] := And[
  $LRRVerbose =!= "Silent",
  $ProgressReporting =!= False  (* Automatic or True both allow progress *)
];


(* ::Subsection:: *)
(*LRRProgress*)


(* LRRProgress: For loops with progress indication *)
(* Currently just evaluates silently - progress indication proved unreliable *)
SetAttributes[LRRProgress, HoldFirst];

LRRProgress[expr_] := expr;


(* ::Subsection:: *)
(*LRRTimed*)


(* LRRTimed: For single timed operations *)
SetAttributes[LRRTimed, HoldFirst];

LRRTimed[expr_, label_String] /; shouldShowProgress[] := Module[
  {result, time},
  {time, result} = AbsoluteTiming[expr];
  Print[label, ": ", Round[time, 0.01], "s"];
  result
];

LRRTimed[expr_, _] := expr;  (* Silent mode - just evaluate *)


(* ::Section:: *)
(*End package*)


End[];  (* `Private` *)


EndPackage[];
