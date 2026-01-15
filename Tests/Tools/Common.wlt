(* ::Package:: *)

(* ::Section:: *)
(*Kernel/Tools/Common.wl Tests*)


BeginTestSection["Kernel/Tools/Common.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`Common`"]

Needs["FernandoDuarte`LongRunRisk`Tools`Common`"];


(* ::Subsection:: *)
(*Load Test Helpers*)


(* Load top-level TestHelpers.wl only - not ToolsTestHelpers.wl to avoid circular dependency *)
Get @ FileNameJoin[{DirectoryName[$TestFileName, 2], "TestHelpers.wl"}];


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
	TestID -> "[print] Verbose False returns Null",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[print] Verbose True returns Null",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[print] All options returns Null",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[print] Verbose CI without env returns Null",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[print] Verbose invalid value returns Null",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[print] Memory False excludes memory info",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[print] Memory True includes memory info",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[print] Prefix None produces no prefix",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[print] Prefix INFO adds prefix",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[print] Prefix DEBUG adds bracketed prefix",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[print] Prefix and Memory combine correctly",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[print] Verbose False overrides other options",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[print] Empty message outputs newline only",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[print] Special characters are preserved",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[print] Unicode characters are preserved",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*Default Options Tests*)


(* Test: Default Verbose is "CI" *)
TestCreate[
	OptionValue[print, "Verbose"],
	"CI",
	{},
	TestID -> "[print] Default Verbose is CI",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Default Memory is False *)
TestCreate[
	OptionValue[print, "Memory"],
	False,
	{},
	TestID -> "[print] Default Memory is False",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Default Prefix is None *)
TestCreate[
	OptionValue[print, "Prefix"],
	None,
	{},
	TestID -> "[print] Default Prefix is None",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: Options list is complete *)
TestCreate[
	Sort[Keys[Options[print]]],
	Sort[{"Memory", "Prefix", "Verbose"}],
	{},
	TestID -> "[print] Options list is complete",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*Internal Logic Tests via Private Functions*)


(* Test: formatMemoryInfo returns a string *)
TestCreate[
	StringQ[FernandoDuarte`LongRunRisk`Tools`Common`Private`formatMemoryInfo[]],       
	True,
	{},
	TestID -> "[formatMemoryInfo] Returns a string",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: formatMemoryInfo contains expected markers *)
TestCreate[
	Module[{result = FernandoDuarte`LongRunRisk`Tools`Common`Private`formatMemoryInfo[]},  
		StringContainsQ[result, "Wolfram Memory:"] && StringContainsQ[result, "Physical RAM:"]
	],
	True,
	{},
	TestID -> "[formatMemoryInfo] Contains expected markers",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: wolframKernelMemoryGB returns a number or Missing *)
TestCreate[
	MatchQ[FernandoDuarte`LongRunRisk`Tools`Common`Private`wolframKernelMemoryGB[], _?NumberQ | _Missing],
	True,
	{},
	TestID -> "[wolframKernelMemoryGB] Returns number or Missing",
	MetaInformation -> <|"Category" -> "extended"|>
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
	TestID -> "[formatMemoryInfo] Missing kernel memory shows NA",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* ::Section:: *)
(*isolatedEvaluate Tests*)


(* ::Subsection:: *)
(*Basic Functionality*)

TestCreate[
    isolatedEvaluate[1 + 1] === 2,
    True,
    {},
    TestID -> "[isolatedEvaluate] Basic evaluation returns correct result",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* ::Subsection:: *)
(*Option: Bindings*)

TestCreate[
    isolatedEvaluate[x + y, "Bindings" -> {x -> 10, y -> 20}] === 30,
    True,
    {},
    TestID -> "[isolatedEvaluate] Bindings substitute variables",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* ::Subsection:: *)
(*Option: Assumptions*)

TestCreate[
    isolatedEvaluate[Simplify[Sqrt[a^2]], "Assumptions" -> a > 0] === a,
    True,
    {},
    TestID -> "[isolatedEvaluate] Assumptions are applied",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* ::Subsection:: *)
(*Assumptions Precedence*)

(* Simplify's explicit Assumptions option replaces $Assumptions from Assuming wrapper *)
TestCreate[
    isolatedEvaluate[
        Simplify[Sqrt[a^2], Assumptions -> a < 0],
        "Assumptions" -> a > 0  (* Wraps with Assuming[a > 0, ...] but Simplify overrides *)
    ] === -a,
    True,
    {},
    TestID -> "[isolatedEvaluate] Simplify Assumptions option overrides isolatedEvaluate Assumptions",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* When Simplify has no explicit Assumptions, it uses $Assumptions from Assuming wrapper *)
TestCreate[
    isolatedEvaluate[
        Simplify[Sqrt[a^2]],  (* No Assumptions option - uses $Assumptions *)
        "Assumptions" -> a > 0
    ] === a,
    True,
    {},
    TestID -> "[isolatedEvaluate] Simplify uses Assuming wrapper when no explicit Assumptions",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* ::Subsection:: *)
(*Option: Quiet*)

TestCreate[
    isolatedEvaluate[1/1, "Quiet" -> True] === 1,
    True,
    {},
    TestID -> "[isolatedEvaluate] Quiet option allows normal evaluation",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* Quiet -> True suppresses Simplify timeout messages and returns correct value *)
(* Uses Simplify::time which is in the suppression list, so no message leaks to stdout *)
TestCreate[
    isolatedEvaluate[(Message[Simplify::time]; 42), "Quiet" -> True] === 42,
    True,
    {},
    TestID -> "[isolatedEvaluate] Quiet True suppresses Simplify::time and returns value",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* Quiet -> False does not suppress messages but still returns correct value *)
(* Note: Messages from LocalEvaluate subprocess don't propagate to main kernel *)
TestCreate[
    isolatedEvaluate[(Message[Simplify::time]; 42), "Quiet" -> False] === 42,
    True,
    {},
    TestID -> "[isolatedEvaluate] Quiet False returns value despite messages",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* ::Subsection:: *)
(*Option: HistoryLength*)

TestCreate[
    isolatedEvaluate[$HistoryLength, "HistoryLength" -> 123] === 123,
    True,
    {},
    TestID -> "[isolatedEvaluate] HistoryLength is set correctly inside block",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* ::Subsection:: *)
(*Option: LocalTimeout*)

TestCreate[
    isolatedEvaluate[Pause[2.0]; 1, "LocalTimeout" -> 0.2, "LocalTimeoutValue" -> "TimedOut"] === "TimedOut",
    True,
    {},
    TestID -> "[isolatedEvaluate] LocalTimeout triggers on slow evaluation",
    MetaInformation -> <|"Category" -> "extended"|>
]

TestCreate[
    isolatedEvaluate[1 + 1, "LocalTimeout" -> 5.0, "LocalTimeoutValue" -> "TimedOut"] === 2,
    True,
    {},
    TestID -> "[isolatedEvaluate] LocalTimeout allows fast evaluation",
    MetaInformation -> <|"Category" -> "extended"|>
]

TestCreate[
    isolatedEvaluate[Pause[1.0]; 1, "LocalTimeout" -> 0.1] === $Failed,
    True,
    {},
    TestID -> "[isolatedEvaluate] LocalTimeout returns $Failed by default",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* ::Subsection:: *)
(*Option: HardTimeout*)

TestCreate[
    isolatedEvaluate[Pause[2.0]; 1, "HardTimeout" -> 0.2, "HardTimeoutValue" -> "HardTimedOut"] === "HardTimedOut",
    True,
    {},
    TestID -> "[isolatedEvaluate] HardTimeout triggers on slow evaluation",
    MetaInformation -> <|"Category" -> "extended"|>
]

TestCreate[
    isolatedEvaluate[1 + 1, "HardTimeout" -> 5.0, "HardTimeoutValue" -> "HardTimedOut"] === 2,
    True,
    {},
    TestID -> "[isolatedEvaluate] HardTimeout allows fast evaluation",
    MetaInformation -> <|"Category" -> "extended"|>
]

TestCreate[
    isolatedEvaluate[Pause[1.0]; 1, "HardTimeout" -> 0.1] === $Failed,
    True,
    {},
    TestID -> "[isolatedEvaluate] HardTimeout returns $Failed by default",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* ::Subsection:: *)
(*Combined Options*)

TestCreate[
    isolatedEvaluate[
        Simplify[Sqrt[x^2]] + y,
        "Bindings" -> {y -> 5},
        "Assumptions" -> x > 0,
        "HistoryLength" -> 0,
        "LocalTimeout" -> 5.0
    ] === x + 5,
    True,
    {},
    TestID -> "[isolatedEvaluate] Combined options work together",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* Combined Quiet and LocalTimeout: completes successfully *)
(* Note: LocalEvaluate returns symbols in calling context, so compare by structure *)
TestCreate[
    MatchQ[
        isolatedEvaluate[
            Simplify[Global`a + Global`a],
            "Quiet" -> True,
            "LocalTimeout" -> 5.0
        ],
        Times[2, _Symbol?(SymbolName[#] === "a" &)]
    ],
    True,
    {},
    TestID -> "[isolatedEvaluate] Quiet with LocalTimeout returns simplified result",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* Quiet False with LocalTimeout also returns correct result *)
TestCreate[
    MatchQ[
        isolatedEvaluate[
            Simplify[Global`a + Global`a],
            "Quiet" -> False,
            "LocalTimeout" -> 5.0
        ],
        Times[2, _Symbol?(SymbolName[#] === "a" &)]
    ],
    True,
    {},
    TestID -> "[isolatedEvaluate] Quiet False with LocalTimeout returns simplified result",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* Same-context symbols simplify: MyTestContext`a + MyTestContext`a -> 2*MyTestContext`a *)
TestCreate[
    isolatedEvaluate[Simplify[MyTestContext`a + MyTestContext`a]] === 2*MyTestContext`a,
    True,
    {},
    TestID -> "[isolatedEvaluate] Same-context symbols simplify together",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* Different-context symbols do NOT simplify: MyTestContext`a + Global`a stays as sum *)
(* Note: Result symbols may have different contexts due to LocalEvaluate context handling *)
TestCreate[
    Module[{result = isolatedEvaluate[Simplify[MyTestContext`a + Global`a]]},
        And[
            Head[result] === Plus,
            Length[result] == 2,
            AllTrue[List @@ result, Head[#] === Symbol && SymbolName[#] === "a" &]
        ]
    ],
    True,
    {},
    TestID -> "[isolatedEvaluate] Different-context symbols do not simplify",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* ::Subsection:: *)
(*Context Behavior with Bindings*)

(* Unqualified symbols match unqualified binding patterns (both resolve to same context) *)
TestCreate[
    isolatedEvaluate[x + 1, "Bindings" -> {x -> 100}] === 101,
    True,
    {},
    TestID -> "[isolatedEvaluate] Unqualified symbol matches unqualified binding",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* Fully qualified expression matches fully qualified binding with same context *)
TestCreate[
    isolatedEvaluate[Global`y + 1, "Bindings" -> {Global`y -> 200}] === 201,
    True,
    {},
    TestID -> "[isolatedEvaluate] Qualified symbol matches same-context qualified binding",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* When multiple bindings with different contexts exist, only matching context applies *)
TestCreate[
    isolatedEvaluate[
        TestContextA`x + 1,
        "Bindings" -> {TestContextA`x -> 100, TestContextB`x -> 200}
    ] === 101,
    True,
    {},
    TestID -> "[isolatedEvaluate] Correct context binding applied when multiple exist",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* Multiple symbols with different contexts each get their respective bindings *)
TestCreate[
    isolatedEvaluate[
        TestContextA`x + TestContextB`x,
        "Bindings" -> {TestContextA`x -> 100, TestContextB`x -> 200}
    ] === 300,
    True,
    {},
    TestID -> "[isolatedEvaluate] Multiple context bindings applied to respective symbols",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* Different contexts do NOT match - qualified expression with different-context binding *)
TestCreate[
    isolatedEvaluate[MyTestContext`v + 1, "Bindings" -> {Global`v -> 500}] === MyTestContext`v + 1,
    True,
    {},
    TestID -> "[isolatedEvaluate] Different contexts do not match",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* Subprocess evaluates in Global` context *)
TestCreate[
    isolatedEvaluate[$Context] === "Global`",
    True,
    {},
    TestID -> "[isolatedEvaluate] Subprocess uses Global context",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* Unqualified expression with non-Global qualified binding does NOT match *)
TestCreate[
    isolatedEvaluate[v + 1, "Bindings" -> {MyTestContext`v -> 500}] === v + 1,
    True,
    {},
    TestID -> "[isolatedEvaluate] Unqualified expr does not match non-Global binding",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* Non-matching bindings are ignored, matching binding is applied *)
TestCreate[
    isolatedEvaluate[
        TestContextA`z + 1,
        "Bindings" -> {TestContextB`z -> 500, TestContextC`z -> 600, TestContextA`z -> 700}
    ] === 701,
    True,
    {},
    TestID -> "[isolatedEvaluate] Only matching context binding applied among multiple",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* ::Subsection:: *)
(*Map Pattern with Bindings*)

(* Test showcasing the primary use case: Map + Simplify with Assumptions option *)
TestCreate[
    Module[{coeffMap, ass, simpBudget},
        coeffMap = {Sqrt[a^2], Sqrt[b^2], a + a};
        ass = a > 0 && b > 0;
        simpBudget = 5;
        isolatedEvaluate[
            Map[Simplify[#, TimeConstraint -> budget] &, data],
            "Bindings" -> {data -> coeffMap, budget -> simpBudget},
            "Assumptions" -> ass
        ] === {a, b, 2 a}
    ],
    True,
    {},
    TestID -> "[isolatedEvaluate] Map pattern with Assumptions option wraps in Assuming",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* ::Subsection:: *)
(*Isolation Guarantees*)

(* Assignments inside isolatedEvaluate do not leak to the calling kernel *)
TestCreate[
    Module[{testSymbol},
        ClearAll[testSymbol];
        isolatedEvaluate[testSymbol = 999];
        !ValueQ[testSymbol]
    ],
    True,
    {},
    TestID -> "[isolatedEvaluate] Assignments inside do not leak to caller",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* Multiple assignments inside do not affect outer scope *)
TestCreate[
    Module[{a, b, c},
        ClearAll[a, b, c];
        isolatedEvaluate[(a = 1; b = 2; c = a + b)];
        NoneTrue[{a, b, c}, ValueQ]
    ],
    True,
    {},
    TestID -> "[isolatedEvaluate] Multiple assignments do not leak",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* $HistoryLength in outer kernel is unchanged after isolatedEvaluate *)
TestCreate[
    Module[{before, after},
        before = $HistoryLength;
        isolatedEvaluate[1 + 1, "HistoryLength" -> 999];
        after = $HistoryLength;
        before === after
    ],
    True,
    {},
    TestID -> "[isolatedEvaluate] $HistoryLength unchanged in outer kernel",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* DownValues defined inside do not leak *)
TestCreate[
    Module[{f},
        ClearAll[f];
        isolatedEvaluate[f[x_] := x^2];
        DownValues[f] === {}
    ],
    True,
    {},
    TestID -> "[isolatedEvaluate] DownValues defined inside do not leak",
    MetaInformation -> <|"Category" -> "extended"|>
]

(* Return value is correctly passed back despite isolation *)
TestCreate[
    isolatedEvaluate[
        Module[{localVar = 10},
            localVar^2 + 5
        ]
    ] === 105,
    True,
    {},
    TestID -> "[isolatedEvaluate] Return value passed back correctly",
    MetaInformation -> <|"Category" -> "extended"|>
]

End[]
EndTestSection[]
