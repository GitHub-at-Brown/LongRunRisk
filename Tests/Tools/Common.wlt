(* ::Package:: *)

(* ::Section:: *)
(*Kernel/Tools/Common.wl Tests*)


BeginTestSection["Kernel/Tools/Common.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`Common`"]

Needs["FernandoDuarte`LongRunRisk`Tools`Common`"];


(* ::Subsection:: *)
(*Load Test Helpers*)


(* Load top-level TestHelpers.wl only - not ToolsTestHelpers.wl to avoid circular dependency *)
Get[FileNameJoin[{DirectoryName[$TestFileName, 2], "TestHelpers.wl"}]];


(* ::Subsection:: *)
(*Basic Functionality Tests*)


(* Test: print returns Null with Verbose -> False and produces no output *)
TestCreate[
	Module[{stdout},
		stdout = captureStdout[print["test message", "Verbose" -> False]];
		IntermediateTest[stdout, "", TestID -> "stdout-empty"];
		print["test message", "Verbose" -> False]
	],
	Null,
	{},
	TestID -> "print-VerboseFalse-ReturnsNull"
]

(* Test: print returns Null with Verbose -> True and produces output *)
TestCreate[
	Module[{stdout},
		stdout = captureStdout[print["test message", "Verbose" -> True]];
		IntermediateTest[StringContainsQ[stdout, "test message"], True, TestID -> "VerboseTrue-stdout-contains-message"];
		IntermediateTest[StringEndsQ[stdout, "\n"], True, TestID -> "VerboseTrue-stdout-ends-newline"];
		print["test message", "Verbose" -> True]
	],
	Null,
	{},
	TestID -> "print-VerboseTrue-ReturnsNull"
]

(* Test: print returns Null with all options and produces correct output *)
TestCreate[
	Module[{stdout},
		stdout = captureStdout[print["full test", "Verbose" -> True, "Memory" -> True, "Prefix" -> "[TEST]"]];
		IntermediateTest[StringContainsQ[stdout, "[TEST]"], True, TestID -> "AllOptions-stdout-contains-prefix"];
		IntermediateTest[StringContainsQ[stdout, "full test"], True, TestID -> "AllOptions-stdout-contains-message"];
		IntermediateTest[StringContainsQ[stdout, "Wolfram Memory:"], True, TestID -> "AllOptions-stdout-contains-memory"];
		print["full test", "Verbose" -> True, "Memory" -> True, "Prefix" -> "[TEST]"]
	],
	Null,
	{},
	TestID -> "print-AllOptions-ReturnsNull"
]


(* ::Subsection:: *)
(*Verbose Option Tests*)


(* Test: Verbose -> "CI" produces no output when CI env is not set *)
TestCreate[
	Module[{stdout, result, originalCI},
		originalCI = Environment["CI"];
		WithCleanup[
			SetEnvironment["CI" -> None],
			stdout = captureStdout[result = print["ci test", "Verbose" -> "CI"]];
			IntermediateTest[stdout, "", TestID -> "stdout-empty-no-ci-env"];
			result,
			SetEnvironment["CI" -> Replace[originalCI, $Failed -> None]]
		]
	],
	Null,
	{},
	TestID -> "print-VerboseCINoEnv-ReturnsNull"
]

(* Test: Verbose with invalid value behaves as False (no output) *)
TestCreate[
	Module[{stdout},
		stdout = captureStdout[print["fallback test", "Verbose" -> "invalid"]];
		IntermediateTest[stdout, "", TestID -> "stdout-empty-invalid-verbose"];
		print["fallback test", "Verbose" -> "invalid"]
	],
	Null,
	{},
	TestID -> "print-VerboseInvalidValue-ReturnsNull"
]


(* ::Subsection:: *)
(*Memory Option Tests*)


(* Test: Memory -> False does not include memory info *)
TestCreate[
	Module[{stdout},
		stdout = captureStdout[print["memory test", "Verbose" -> True, "Memory" -> False]];
		IntermediateTest[StringContainsQ[stdout, "memory test"], True, TestID -> "MemoryFalse-stdout-contains-message"];
		IntermediateTest[StringContainsQ[stdout, "Wolfram Memory:"], False, TestID -> "MemoryFalse-stdout-no-memory-info"];
		print["memory test", "Verbose" -> True, "Memory" -> False]
	],
	Null,
	{},
	TestID -> "print-MemoryFalse-NoMemoryInfo"
]

(* Test: Memory -> True includes memory info *)
TestCreate[
	Module[{stdout},
		stdout = captureStdout[print["memory test", "Verbose" -> True, "Memory" -> True]];
		IntermediateTest[StringContainsQ[stdout, "memory test"], True, TestID -> "MemoryTrue-stdout-contains-message"];
		IntermediateTest[StringContainsQ[stdout, "Wolfram Memory:"], True, TestID -> "MemoryTrue-stdout-has-memory-info"];
		IntermediateTest[StringContainsQ[stdout, "Physical RAM:"], True, TestID -> "MemoryTrue-stdout-has-ram-info"];
		print["memory test", "Verbose" -> True, "Memory" -> True]
	],
	Null,
	{},
	TestID -> "print-MemoryTrue-IncludesMemoryInfo"
]


(* ::Subsection:: *)
(*Prefix Option Tests*)


(* Test: Prefix -> None produces no prefix in output *)
TestCreate[
	Module[{stdout},
		stdout = captureStdout[print["no prefix message", "Verbose" -> True, "Prefix" -> None]];
		IntermediateTest[StringStartsQ[stdout, "no prefix message"], True, TestID -> "stdout-starts-with-message"];
		print["no prefix message", "Verbose" -> True, "Prefix" -> None]
	],
	Null,
	{},
	TestID -> "print-PrefixNone-NoPrefix"
]

(* Test: Prefix -> "INFO" adds prefix to output *)
TestCreate[
	Module[{stdout},
		stdout = captureStdout[print["info message", "Verbose" -> True, "Prefix" -> "INFO"]];
		IntermediateTest[StringStartsQ[stdout, "INFO "], True, TestID -> "PrefixINFO-stdout-starts-with-prefix"];
		IntermediateTest[StringContainsQ[stdout, "info message"], True, TestID -> "PrefixINFO-stdout-contains-message"];
		print["info message", "Verbose" -> True, "Prefix" -> "INFO"]
	],
	Null,
	{},
	TestID -> "print-PrefixINFO-AddsPrefix"
]

(* Test: Prefix -> "[DEBUG]" adds bracketed prefix to output *)
TestCreate[
	Module[{stdout},
		stdout = captureStdout[print["debug message", "Verbose" -> True, "Prefix" -> "[DEBUG]"]];
		IntermediateTest[StringStartsQ[stdout, "[DEBUG] "], True, TestID -> "PrefixDEBUG-stdout-starts-with-prefix"];
		IntermediateTest[StringContainsQ[stdout, "debug message"], True, TestID -> "PrefixDEBUG-stdout-contains-message"];
		print["debug message", "Verbose" -> True, "Prefix" -> "[DEBUG]"]
	],
	Null,
	{},
	TestID -> "print-PrefixDEBUG-AddsPrefix"
]


(* ::Subsection:: *)
(*Option Combination Tests*)


(* Test: Prefix + Memory combination produces correct output format *)
TestCreate[
	Module[{stdout},
		stdout = captureStdout[print["combined test", "Verbose" -> True, "Prefix" -> "LOG", "Memory" -> True]];
		IntermediateTest[StringStartsQ[stdout, "LOG "], True, TestID -> "PrefixAndMemory-stdout-starts-with-prefix"];
		IntermediateTest[StringContainsQ[stdout, "combined test"], True, TestID -> "PrefixAndMemory-stdout-contains-message"];
		IntermediateTest[StringContainsQ[stdout, "Wolfram Memory:"], True, TestID -> "PrefixAndMemory-stdout-has-memory"];
		print["combined test", "Verbose" -> True, "Prefix" -> "LOG", "Memory" -> True]
	],
	Null,
	{},
	TestID -> "print-PrefixAndMemory-CombinesCorrectly"
]

(* Test: Verbose False overrides other options (no output despite prefix/memory) *)
TestCreate[
	Module[{stdout},
		stdout = captureStdout[print["should not appear", "Verbose" -> False, "Memory" -> True, "Prefix" -> "[HIDDEN]"]];
		IntermediateTest[stdout, "", TestID -> "stdout-empty-verbose-false-overrides"];
		print["should not appear", "Verbose" -> False, "Memory" -> True, "Prefix" -> "[HIDDEN]"]
	],
	Null,
	{},
	TestID -> "print-VerboseFalseWithOptions-OverridesAll"
]


(* ::Subsection:: *)
(*Edge Case Tests*)


(* Test: Empty string message produces empty line (just newline) *)
TestCreate[
	Module[{stdout},
		stdout = captureStdout[print["", "Verbose" -> True]];
		IntermediateTest[stdout, "\n", TestID -> "stdout-only-newline"];
		print["", "Verbose" -> True]
	],
	Null,
	{},
	TestID -> "print-EmptyMessage-OutputsNewlineOnly"
]

(* Test: Message with special characters is preserved *)
TestCreate[
	Module[{stdout},
		stdout = captureStdout[print["Test with special chars: !@#$%^&*()", "Verbose" -> True]];
		IntermediateTest[StringContainsQ[stdout, "!@#$%^&*()"], True, TestID -> "stdout-preserves-special-chars"];
		print["Test with special chars: !@#$%^&*()", "Verbose" -> True]
	],
	Null,
	{},
	TestID -> "print-SpecialCharacters-PreservesAll"
]

(* Test: Message with unicode characters is preserved *)
TestCreate[
	Module[{stdout},
		stdout = captureStdout[print["Unicode test: \[Alpha]\[Beta]\[Gamma]", "Verbose" -> True]];
		IntermediateTest[StringLength[stdout] > 0, True, TestID -> "stdout-has-content"];
		print["Unicode test: \[Alpha]\[Beta]\[Gamma]", "Verbose" -> True]
	],
	Null,
	{},
	TestID -> "print-UnicodeCharacters-PreservesAll"
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


(* Test: formatMemoryInfo returns a string *)
TestCreate[
	StringQ[FernandoDuarte`LongRunRisk`Tools`Common`Private`formatMemoryInfo[]],       
	True,
	{},
	TestID -> "print-formatMemoryInfo-ReturnsString"
]

(* Test: formatMemoryInfo contains expected markers *)
TestCreate[
	Module[{result = FernandoDuarte`LongRunRisk`Tools`Common`Private`formatMemoryInfo[]},  
		StringContainsQ[result, "Wolfram Memory:"] && StringContainsQ[result, "Physical RAM:"]
	],
	True,
	{},
	TestID -> "print-formatMemoryInfo-ContainsExpectedMarkers"
]

(* Test: wolframKernelMemoryGB returns a number or Missing *)
TestCreate[
	MatchQ[FernandoDuarte`LongRunRisk`Tools`Common`Private`wolframKernelMemoryGB[], _?NumberQ | _Missing],
	True,
	{},
	TestID -> "wolframKernelMemoryGB-Call-ReturnsNumberOrMissing"
]

(* Test: formatMemoryInfo shows N/A when wolframKernelMemoryGB returns Missing (Windows behavior) *)
TestCreate[
	Block[{FernandoDuarte`LongRunRisk`Tools`Common`Private`wolframKernelMemoryGB = Missing["NotAvailable"] &},
		StringContainsQ[
			FernandoDuarte`LongRunRisk`Tools`Common`Private`formatMemoryInfo[],
			"Physical RAM: N/A"
		]
	],
	True,
	{},
	TestID -> "formatMemoryInfo-MissingKernelMemory-ShowsNA"
]

End[]
EndTestSection[]
