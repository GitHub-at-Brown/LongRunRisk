(* ::Package:: *)

(* ::Section:: *)
(*Kernel/Tools/IsolatedEvaluate.wl Tests*)

BeginTestSection["Kernel/Tools/IsolatedEvaluate.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`IsolatedEvaluate`"]

Needs["FernandoDuarte`LongRunRisk`Tools`IsolatedEvaluate`"]

(* ::Subsection:: *)
(*Basic Functionality*)

TestCreate[
    isolatedEvaluate[1 + 1] === 2,
    True,
    {},
    TestID -> "[isolatedEvaluate] Basic evaluation returns correct result"
]

(* ::Subsection:: *)
(*Option: Bindings*)

TestCreate[
    isolatedEvaluate[x + y, "Bindings" -> {x -> 10, y -> 20}] === 30,
    True,
    {},
    TestID -> "[isolatedEvaluate] Bindings substitute variables"
]

(* ::Subsection:: *)
(*Option: Assumptions*)

TestCreate[
    isolatedEvaluate[Simplify[Sqrt[a^2]], "Assumptions" -> a > 0] === a,
    True,
    {},
    TestID -> "[isolatedEvaluate] Assumptions are applied"
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
    TestID -> "[isolatedEvaluate] Simplify Assumptions option overrides isolatedEvaluate Assumptions"
]

(* When Simplify has no explicit Assumptions, it uses $Assumptions from Assuming wrapper *)
TestCreate[
    isolatedEvaluate[
        Simplify[Sqrt[a^2]],  (* No Assumptions option - uses $Assumptions *)
        "Assumptions" -> a > 0
    ] === a,
    True,
    {},
    TestID -> "[isolatedEvaluate] Simplify uses Assuming wrapper when no explicit Assumptions"
]

(* ::Subsection:: *)
(*Option: Quiet*)

TestCreate[
    isolatedEvaluate[1/1, "Quiet" -> True] === 1,
    True,
    {},
    TestID -> "[isolatedEvaluate] Quiet option allows normal evaluation"
]

(* Test that Quiet -> True suppresses messages and returns correct value *)
TestCreate[
    Module[{msgIssued = False, result},
        result = Check[
            isolatedEvaluate[
                (Message[General::argx, foo, 1]; 42),
                "Quiet" -> True
            ],
            msgIssued = True,
            General::argx
        ];
        result === 42 && msgIssued === False
    ],
    True,
    {},
    TestID -> "[isolatedEvaluate] Quiet True suppresses messages and returns value"
]

(* Test that without Quiet, messages ARE emitted and correct value returned *)
TestCreate[
    Module[{msgIssued = False, result},
        result = Check[
            isolatedEvaluate[
                (Message[General::argx, foo, 1]; 42),
                "Quiet" -> False
            ],
            msgIssued = True,
            General::argx
        ];
        result === 42 && msgIssued === True
    ],
    True,
    {},
    TestID -> "[isolatedEvaluate] Without Quiet, messages emitted and returns value"
]

(* ::Subsection:: *)
(*Option: HistoryLength*)

TestCreate[
    isolatedEvaluate[$HistoryLength, "HistoryLength" -> 123] === 123,
    True,
    {},
    TestID -> "[isolatedEvaluate] HistoryLength is set correctly inside block"
]

(* ::Subsection:: *)
(*Option: LocalTimeout*)

TestCreate[
    isolatedEvaluate[Pause[2.0]; 1, "LocalTimeout" -> 0.2, "LocalTimeoutValue" -> "TimedOut"] === "TimedOut",
    True,
    {},
    TestID -> "[isolatedEvaluate] LocalTimeout triggers on slow evaluation"
]

TestCreate[
    isolatedEvaluate[1 + 1, "LocalTimeout" -> 5.0, "LocalTimeoutValue" -> "TimedOut"] === 2,
    True,
    {},
    TestID -> "[isolatedEvaluate] LocalTimeout allows fast evaluation"
]

TestCreate[
    isolatedEvaluate[Pause[1.0]; 1, "LocalTimeout" -> 0.1] === $Failed,
    True,
    {},
    TestID -> "[isolatedEvaluate] LocalTimeout returns $Failed by default"
]

(* ::Subsection:: *)
(*Option: HardTimeout*)

TestCreate[
    isolatedEvaluate[Pause[2.0]; 1, "HardTimeout" -> 0.2, "HardTimeoutValue" -> "HardTimedOut"] === "HardTimedOut",
    True,
    {},
    TestID -> "[isolatedEvaluate] HardTimeout triggers on slow evaluation"
]

TestCreate[
    isolatedEvaluate[1 + 1, "HardTimeout" -> 5.0, "HardTimeoutValue" -> "HardTimedOut"] === 2,
    True,
    {},
    TestID -> "[isolatedEvaluate] HardTimeout allows fast evaluation"
]

TestCreate[
    isolatedEvaluate[Pause[1.0]; 1, "HardTimeout" -> 0.1] === $Failed,
    True,
    {},
    TestID -> "[isolatedEvaluate] HardTimeout returns $Failed by default"
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
    TestID -> "[isolatedEvaluate] Combined options work together"
]

(* Test that Quiet suppresses Simplify::time even when LocalTimeout is also used *)
(* Note: Result is the unsimplified Sum since TimeConstraint causes Simplify to give up *)
TestCreate[
    Module[{msgIssued = False, result},
        result = Check[
            isolatedEvaluate[
                Simplify[Sum[x^i, {i, 1000}], TimeConstraint -> 0.0001],
                "Quiet" -> True,
                "LocalTimeout" -> 5.0
            ],
            msgIssued = True,
            Simplify::time
        ];
        Head[result] === Sum && msgIssued === False
    ],
    True,
    {},
    TestID -> "[isolatedEvaluate] Quiet suppresses Simplify::time with LocalTimeout"
]

(* Test that without Quiet, Simplify::time is emitted even with LocalTimeout *)
TestCreate[
    Module[{msgIssued = False, result},
        result = Check[
            isolatedEvaluate[
                Simplify[Sum[x^i, {i, 1000}], TimeConstraint -> 0.0001],
                "Quiet" -> False,
                "LocalTimeout" -> 5.0
            ],
            msgIssued = True,
            Simplify::time
        ];
        Head[result] === Sum && msgIssued === True
    ],
    True,
    {},
    TestID -> "[isolatedEvaluate] Without Quiet, Simplify::time emitted with LocalTimeout"
]

(* ::Subsection:: *)
(*Context Behavior with Bindings*)

(* Unqualified symbols match unqualified binding patterns (both resolve to same context) *)
TestCreate[
    isolatedEvaluate[x + 1, "Bindings" -> {x -> 100}] === 101,
    True,
    {},
    TestID -> "[isolatedEvaluate] Unqualified symbol matches unqualified binding"
]

(* Fully qualified expression matches fully qualified binding with same context *)
TestCreate[
    isolatedEvaluate[Global`y + 1, "Bindings" -> {Global`y -> 200}] === 201,
    True,
    {},
    TestID -> "[isolatedEvaluate] Qualified symbol matches same-context qualified binding"
]

(* Unqualified expression matches Global`-qualified binding (same context) *)
TestCreate[
    isolatedEvaluate[z + 1, "Bindings" -> {Global`z -> 300}] === 301,
    True,
    {},
    TestID -> "[isolatedEvaluate] Unqualified matches Global-qualified binding"
]

(* Global`-qualified expression matches unqualified binding *)
TestCreate[
    isolatedEvaluate[Global`w + 1, "Bindings" -> {w -> 400}] === 401,
    True,
    {},
    TestID -> "[isolatedEvaluate] Global-qualified matches unqualified binding"
]

(* Different contexts do NOT match - qualified expression with different-context binding *)
TestCreate[
    isolatedEvaluate[MyTestContext`v + 1, "Bindings" -> {Global`v -> 500}] === MyTestContext`v + 1,
    True,
    {},
    TestID -> "[isolatedEvaluate] Different contexts do not match"
]

(* Returned unqualified symbols are in Global` context *)
TestCreate[
    Context[isolatedEvaluate[someSymbol]] === "Global`",
    True,
    {},
    TestID -> "[isolatedEvaluate] Returned unqualified symbols are in Global context"
]

(* Returned qualified symbols preserve their context *)
TestCreate[
    Context[isolatedEvaluate[MyTestContext`qualifiedSymbol]] === "MyTestContext`",
    True,
    {},
    TestID -> "[isolatedEvaluate] Returned qualified symbols preserve their context"
]

(* Unqualified expression with non-Global qualified binding does NOT match *)
TestCreate[
    isolatedEvaluate[v + 1, "Bindings" -> {MyTestContext`v -> 500}] === v + 1,
    True,
    {},
    TestID -> "[isolatedEvaluate] Unqualified expr does not match non-Global binding"
]

(* When both Global` and non-Global` bindings present, unqualified expr matches Global` *)
TestCreate[
    isolatedEvaluate[v + 1, "Bindings" -> {Global`v -> 600, MyTestContext`v -> 700}] === 601,
    True,
    {},
    TestID -> "[isolatedEvaluate] Unqualified expr matches Global binding when multiple contexts"
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
    TestID -> "[isolatedEvaluate] Map pattern with Assumptions option wraps in Assuming"
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
    TestID -> "[isolatedEvaluate] Assignments inside do not leak to caller"
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
    TestID -> "[isolatedEvaluate] Multiple assignments do not leak"
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
    TestID -> "[isolatedEvaluate] $HistoryLength unchanged in outer kernel"
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
    TestID -> "[isolatedEvaluate] DownValues defined inside do not leak"
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
    TestID -> "[isolatedEvaluate] Return value passed back correctly"
]

End[]
EndTestSection[]
