(* ::Package:: *)

(* ::Section:: *)
(*Common Tests*)


BeginTestSection["Common Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`Common`"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`Common`"];
On[General::shdw];


(* ::Subsection:: *)
(*Basic Functionality Tests*)


(* Test: print returns Null with Verbose -> False *)
TestCreate[
	print["test message", "Verbose" -> False],
	Null,
	{},
	TestID -> "print-ReturnsNull-VerboseFalse"
]

(* Test: print returns Null with Verbose -> True *)
TestCreate[
	print["test message", "Verbose" -> True],
	Null,
	{},
	TestID -> "print-ReturnsNull-VerboseTrue"
]

(* Test: print returns Null with all options *)
TestCreate[
	print["full test", "Verbose" -> True, "Memory" -> True, "Prefix" -> "[TEST]"],
	Null,
	{},
	TestID -> "print-ReturnsNull-AllOptions"
]


(* ::Subsection:: *)
(*Verbose Option Tests*)


(* Test: Verbose -> "CI" returns Null (default behavior) *)
TestCreate[
	print["ci test", "Verbose" -> "CI"],
	Null,
	{},
	TestID -> "print-VerboseCI-ReturnsNull"
]

(* Test: Verbose with invalid value behaves as False (fallback) *)
TestCreate[
	print["fallback test", "Verbose" -> "invalid"],
	Null,
	{},
	TestID -> "print-VerboseInvalid-ReturnsNull"
]


(* ::Subsection:: *)
(*Memory Option Tests*)


(* Test: Memory -> False returns Null *)
TestCreate[
	print["memory test", "Verbose" -> True, "Memory" -> False],
	Null,
	{},
	TestID -> "print-MemoryFalse-ReturnsNull"
]

(* Test: Memory -> True returns Null *)
TestCreate[
	print["memory test", "Verbose" -> True, "Memory" -> True],
	Null,
	{},
	TestID -> "print-MemoryTrue-ReturnsNull"
]


(* ::Subsection:: *)
(*Prefix Option Tests*)


(* Test: Prefix -> None returns Null *)
TestCreate[
	print["no prefix message", "Verbose" -> True, "Prefix" -> None],
	Null,
	{},
	TestID -> "print-PrefixNone-ReturnsNull"
]

(* Test: Prefix -> "INFO" returns Null *)
TestCreate[
	print["info message", "Verbose" -> True, "Prefix" -> "INFO"],
	Null,
	{},
	TestID -> "print-PrefixINFO-ReturnsNull"
]

(* Test: Prefix -> "[DEBUG]" returns Null *)
TestCreate[
	print["debug message", "Verbose" -> True, "Prefix" -> "[DEBUG]"],
	Null,
	{},
	TestID -> "print-PrefixDEBUG-ReturnsNull"
]


(* ::Subsection:: *)
(*Option Combination Tests*)


(* Test: Prefix + Memory combination returns Null *)
TestCreate[
	print["combined test", "Verbose" -> True, "Prefix" -> "LOG", "Memory" -> True],
	Null,
	{},
	TestID -> "print-PrefixAndMemory-ReturnsNull"
]

(* Test: Verbose False overrides other options (returns Null immediately) *)
TestCreate[
	print["should not appear", "Verbose" -> False, "Memory" -> True, "Prefix" -> "[HIDDEN]"],
	Null,
	{},
	TestID -> "print-VerboseFalseOverridesAll-ReturnsNull"
]


(* ::Subsection:: *)
(*Edge Case Tests*)


(* Test: Empty string message returns Null *)
TestCreate[
	print["", "Verbose" -> True],
	Null,
	{},
	TestID -> "print-EmptyMessage-ReturnsNull"
]

(* Test: Message with special characters returns Null *)
TestCreate[
	print["Test with special chars: !@#$%^&*()", "Verbose" -> True],
	Null,
	{},
	TestID -> "print-SpecialCharacters-ReturnsNull"
]

(* Test: Message with unicode characters returns Null *)
TestCreate[
	print["Unicode test: alpha beta gamma", "Verbose" -> True],
	Null,
	{},
	TestID -> "print-UnicodeCharacters-ReturnsNull"
]


(* ::Subsection:: *)
(*Default Options Tests*)


(* Test: Default Verbose is "CI" *)
TestCreate[
	OptionValue[print, "Verbose"],
	"CI",
	{},
	TestID -> "print-DefaultVerbose-IsCI"
]

(* Test: Default Memory is False *)
TestCreate[
	OptionValue[print, "Memory"],
	False,
	{},
	TestID -> "print-DefaultMemory-IsFalse"
]

(* Test: Default Prefix is None *)
TestCreate[
	OptionValue[print, "Prefix"],
	None,
	{},
	TestID -> "print-DefaultPrefix-IsNone"
]

(* Test: Options list is complete *)
TestCreate[
	Sort[Keys[Options[print]]],
	Sort[{"Memory", "Prefix", "Verbose"}],
	{},
	TestID -> "print-OptionsComplete-AllThreePresent"
]


(* ::Subsection:: *)
(*Internal Logic Tests via Private Functions*)


$formatMemoryInfo = ToExpression["FernandoDuarte`LongRunRisk`Tools`Common`Private`formatMemoryInfo"];
$wolframKernelMemoryGB = ToExpression["FernandoDuarte`LongRunRisk`Tools`Common`Private`wolframKernelMemoryGB"];

(* Test: formatMemoryInfo returns a string *)
TestCreate[
	StringQ[$formatMemoryInfo[]],
	True,
	{},
	TestID -> "print-formatMemoryInfo-ReturnsString"
]

(* Test: formatMemoryInfo contains expected markers *)
TestCreate[
	Module[{result = $formatMemoryInfo[]},
		StringContainsQ[result, "Wolfram Memory:"] && StringContainsQ[result, "Physical RAM:"]
	],
	True,
	{},
	TestID -> "print-formatMemoryInfo-ContainsExpectedMarkers"
]

(* Test: wolframKernelMemoryGB returns a number or Missing *)
TestCreate[
	MatchQ[$wolframKernelMemoryGB[], _?NumberQ | _Missing],
	True,
	{},
	TestID -> "print-wolframKernelMemoryGB-ReturnsNumberOrMissing"
]

End[]
EndTestSection[]
