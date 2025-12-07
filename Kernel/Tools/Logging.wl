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


LRRProgress::usage = "LRRProgress[expr] wraps expr with MonitorProgress for automatic \
progress tracking. Respects both $LRRVerbose and $ProgressReporting. \
Works in notebooks (visual) and terminal (text progress bar).";

LRRTimed::usage = "LRRTimed[expr, label] evaluates expr and prints timing with label. \
Respects $LRRVerbose. Use for single operations that need timing output.";

$LRRVerbose::usage = "$LRRVerbose controls LongRunRisk output verbosity. \
Values: \"Silent\" | \"Normal\" (default). \
When \"Silent\", progress and timing output is suppressed.";

initializeLogging::usage = "initializeLogging[] attempts to load MonitorProgress from the \
Function Repository. Call once at paclet load time (from LongRunRisk.wl). \
Returns True if MonitorProgress loaded, False otherwise.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Initialize defaults*)


If[!ValueQ[$LRRVerbose], $LRRVerbose = "Normal"];


(* ::Subsection:: *)
(*Logging state*)


(* $LoggingInitialized: True after first initializeLogging[] call *)
$LoggingInitialized = False;

(* $MonitorProgressImpl: ResourceFunction["MonitorProgress"] or None *)
$MonitorProgressImpl = None;


(* ::Subsection:: *)
(*initializeLogging*)


(* initializeLogging[] is idempotent - safe to call multiple times *)
(* First call attempts to load MonitorProgress; subsequent calls return immediately *)
initializeLogging[] := (
  If[!TrueQ[$LoggingInitialized],
    $LoggingInitialized = True;
    $MonitorProgressImpl = Quiet @ Check[
      ResourceFunction["MonitorProgress"],
      None  (* Mark as unavailable on any error *)
    ];
    (* Verify we got a valid function, not $Failed or Missing *)
    If[!MatchQ[$MonitorProgressImpl, _ResourceFunction | _Function],
      $MonitorProgressImpl = None
    ];
  ];
  (* Return status *)
  $MonitorProgressImpl =!= None
);


(* ::Subsection:: *)
(*Fallback progress*)


(* Simple fallback using built-in Monitor (notebook) or silent (terminal) *)
SetAttributes[fallbackProgress, HoldFirst];

fallbackProgress[expr_] := If[$Notebooks,
  (* Notebook: use Monitor with indeterminate spinner *)
  Monitor[expr, ProgressIndicator[Indeterminate]],
  (* Terminal: just evaluate, no visual progress *)
  expr
];


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


(* LRRProgress: For loops with automatic step detection *)
SetAttributes[LRRProgress, HoldFirst];

LRRProgress[expr_] /; shouldShowProgress[] := If[$MonitorProgressImpl =!= None,
  $MonitorProgressImpl[expr],
  fallbackProgress[expr]
];

LRRProgress[expr_] := expr;  (* Silent mode - just evaluate *)

(* Operator form for manual step count *)
LRRProgress[n_Integer] /; shouldShowProgress[] := If[$MonitorProgressImpl =!= None,
  $MonitorProgressImpl[#, n] &,
  Identity  (* Fallback: no step tracking *)
];

LRRProgress[n_Integer] := Identity;  (* Silent mode *)


(* ::Subsection:: *)
(*LRRTimed*)


(* LRRTimed: For single timed operations *)
SetAttributes[LRRTimed, HoldFirst];

LRRTimed[expr_, label_String] /; shouldShowProgress[] := Module[
  {result, time},
  {time, result} = AbsoluteTiming[expr];
  PrintTemporary[label, ": ", Round[time, 0.01], "s"];
  result
];

LRRTimed[expr_, _] := expr;  (* Silent mode - just evaluate *)


(* ::Section:: *)
(*End package*)


End[];  (* `Private` *)


EndPackage[];
