(* Setup: Load NiceOutput.wl *)
Module[{start, d, pacletRoot},
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName], Directory[]];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
    d = DirectoryName[d]];
  pacletRoot = d;
  Off[General::shdw];
  Get[FileNameJoin[{pacletRoot, "Kernel", "Tools", "NiceOutput.wl"}]];
  On[General::shdw];
];

(* Extract private functions for testing *)
$normalizeWhitespace = ToExpression["FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`normalizeWhitespace"];
$stringFormattingTemplate = ToExpression["FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stringFormattingTemplate"];

$timeLimit = 5;

(* ============================================================ *)
(* normalizeWhitespace Tests *)
(* ============================================================ *)

VerificationTest[
  $normalizeWhitespace["hello\tworld"],
  "hello world",
  TestID -> "normalizeWhitespace-tab-to-space"
]

VerificationTest[
  $normalizeWhitespace["hello\nworld"],
  "hello world",
  TestID -> "normalizeWhitespace-newline-to-space"
]

VerificationTest[
  $normalizeWhitespace["hello\t\t\tworld"],
  "hello world",
  TestID -> "normalizeWhitespace-multi-tab-collapse"
]

VerificationTest[
  $normalizeWhitespace["hello\n\t\t\tworld"],
  "hello world",
  TestID -> "normalizeWhitespace-mixed-whitespace"
]

VerificationTest[
  $normalizeWhitespace["hello     world"],
  "hello world",
  TestID -> "normalizeWhitespace-multi-space-collapse"
]

VerificationTest[
  $normalizeWhitespace["  hello world  "],
  "hello world",
  TestID -> "normalizeWhitespace-trim-leading-trailing"
]

VerificationTest[
  $normalizeWhitespace["\t\nhello\n\t  \t\nworld\n\t"],
  "hello world",
  TestID -> "normalizeWhitespace-complex-mixed"
]

VerificationTest[
  $normalizeWhitespace[""],
  "",
  TestID -> "normalizeWhitespace-empty-string"
]

VerificationTest[
  $normalizeWhitespace["\t\n   \t\n"],
  "",
  TestID -> "normalizeWhitespace-only-whitespace"
]

VerificationTest[
  (* unicode should be preserved *)
  $normalizeWhitespace["Müller–Lyer illusion with αβγ symbols"],
  "Müller–Lyer illusion with αβγ symbols",
  TestID -> "normalizeWhitespace-unicode-preserved"
]

(* ============================================================ *)
(* stringFormattingTemplate Idempotency Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{short, r1, r2},
    short = "Hello world";
    r1 = $stringFormattingTemplate[short];
    r2 = $stringFormattingTemplate[r1];
    r1 === r2
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "stringFormattingTemplate-idempotent-short"
]

VerificationTest[
  Module[{long, r1, r2, r3},
    long = "Bansal and Yaron (2004) long-run risk model with stochastic volatility of consumption growth.";
    r1 = $stringFormattingTemplate[long];
    r2 = $stringFormattingTemplate[r1];
    r3 = $stringFormattingTemplate[r2];
    r1 === r2 && r2 === r3
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "stringFormattingTemplate-idempotent-long"
]

VerificationTest[
  Module[{original, formatted, normalized},
    original = "This is a test string with some content.";
    formatted = $stringFormattingTemplate[original];
    normalized = $normalizeWhitespace[formatted];
    normalized === original
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "stringFormattingTemplate-content-preserved"
]

VerificationTest[
  Module[{long, result},
    long = "This is a fairly long string that should have line breaks inserted at word boundaries.";
    result = $stringFormattingTemplate[long];
    StringContainsQ[result, "\n"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "stringFormattingTemplate-inserts-line-breaks"
]

VerificationTest[
  Module[{long, result},
    long = "This is a fairly long string that should have indentation after line breaks.";
    result = $stringFormattingTemplate[long];
    StringContainsQ[result, "\n\t\t\t"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "stringFormattingTemplate-adds-indentation"
]

(* ============================================================ *)
(* Round-trip stability with already-formatted strings *)
(* ============================================================ *)

VerificationTest[
  Module[{formatted, r1, r2},
    (* string that looks like it was already formatted *)
    formatted = "Bansal and Yaron (2004) long-run risk\n\t\t\tmodel with stochastic volatility of\n\t\t\tconsumption growth.";
    r1 = $stringFormattingTemplate[formatted];
    r2 = $stringFormattingTemplate[r1];
    r1 === r2
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "stringFormattingTemplate-idempotent-preformatted"
]

VerificationTest[
  Module[{messy, r1, r2, r3},
    (* string with mixed whitespace *)
    messy = "Test\t\twith\n\nmultiple   spaces   and\ttabs";
    r1 = $stringFormattingTemplate[messy];
    r2 = $stringFormattingTemplate[r1];
    r3 = $stringFormattingTemplate[r2];
    StringLength[r1] === StringLength[r2] && StringLength[r2] === StringLength[r3]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "stringFormattingTemplate-stable-length"
]
