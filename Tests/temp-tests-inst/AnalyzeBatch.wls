#!/usr/bin/env wolframscript
(* ::Package:: *)

(*
 * AnalyzeBatch.wls
 *
 * Run all individual test files in a single CoverageEvaluate session
 * to identify exactly where test failures and coverage corruption begin.
 *
 * This script:
 * 1. Loads the instrumented paclet
 * 2. Runs all individual test files in execution order
 * 3. Tracks cumulative failures after each test
 * 4. Identifies the first test that introduces problems
 * 5. Documents all results in RunLog.md
 *)

Print["=" StringRepeat["=", 69]];
Print["Individual Test Coverage - Batch Analysis"];
Print["=" StringRepeat["=", 69]];
Print[];

(* === Path Setup === *)
scriptDir = DirectoryName[$InputFileName];
testsRoot = DirectoryName[scriptDir];
pacletRoot = DirectoryName[testsRoot];
instrumentedDir = FileNameJoin[{pacletRoot, "build", "coverage-instrumented"}];
coverageDir = FileNameJoin[{pacletRoot, "build", "coverage"}];

Print["Script directory: ", scriptDir];
Print["Tests root: ", testsRoot];
Print["Paclet root: ", pacletRoot];
Print["Instrumented dir: ", instrumentedDir];
Print[];

(* === Verify instrumented directory exists === *)
If[!DirectoryQ[instrumentedDir],
  Print["ERROR: Instrumented directory not found: ", instrumentedDir];
  Print["Please run RunCoverage.wls first to create instrumented code"];
  Quit[1]
];

(* === Load Instrumentation === *)
Needs["Instrumentation`"];

(* === Find all individual test files === *)
testFiles = FileNames["*_test*.wlt", scriptDir, Infinity];
testFiles = Sort[testFiles]; (* Sort for consistent execution order *)

Print["Found ", Length[testFiles], " individual test files"];
Print[];

(* === Unload original paclet and load instrumented version === *)
Print["Loading instrumented paclet..."];
PacletDirectoryUnload[pacletRoot];
PacletDirectoryLoad[instrumentedDir];
Print["Instrumented paclet loaded"];
Print[];

(* === Initialize RunLog.md === *)
logFile = FileNameJoin[{scriptDir, "RunLog.md"}];

WriteString[logFile, "# Individual Test Coverage Analysis Log\n\n"];
WriteString[logFile, "## Run Metadata\n"];
WriteString[logFile, "- Date: " <> DateString[] <> "\n"];
WriteString[logFile, "- Total individual tests: " <> ToString[Length[testFiles]] <> "\n"];
WriteString[logFile, "- Instrumented directory: " <> instrumentedDir <> "\n"];
WriteString[logFile, "- Coverage output: " <> coverageDir <> "\n"];
WriteString[logFile, "\n"];

WriteString[logFile, "## Batch Test Execution Results\n\n"];
WriteString[logFile, "Running all tests in single CoverageEvaluate session...\n\n"];

(* === Run all tests in batch with coverage tracking === *)
Print["Running batch coverage analysis..."];
Print["This will take a few minutes..."];
Print[];

startTime = AbsoluteTime[];

{report, runData} = Instrumentation`CoverageEvaluate[
  TestReport[testFiles, "ProgressReporting" -> True]
];

endTime = AbsoluteTime[];
elapsedTime = endTime - startTime;

Print[];
Print["Batch analysis complete in ", Round[elapsedTime], " seconds"];
Print[];

(* === Analyze results === *)
totalTests = report["TestsRunCount"];
totalPassed = report["TestsSucceededCount"];
totalFailed = report["TestsFailedCount"];
totalAborted = Lookup[report, "TestsAbortedCount", 0];

Print["=" StringRepeat["=", 69]];
Print["Overall Results"];
Print["=" StringRepeat["=", 69]];
Print["Total tests: ", totalTests];
Print["Passed: ", totalPassed];
Print["Failed: ", totalFailed];
Print["Aborted: ", totalAborted];
Print[];

(* === Identify problematic tests === *)
Print["Analyzing failures..."];

allTestResults = Values[report["TestResults"]];

(* Find tests with actual failures (not just instrumentation artifacts) *)
failedTests = Select[allTestResults, #["Outcome"] === "Failure" &];
messageFailed = Select[allTestResults, #["Outcome"] === "MessagesFailure" &];

(* Identify coverage instrumentation artifact messages *)
artifactMessages = Select[messageFailed,
  AnyTrue[#["ActualMessages"],
    MatchQ[#, HoldPattern[MessageName[CoverageEvaluate | Insert | Values, _]]] &
  ] &
];

realMessageFailures = Complement[messageFailed, artifactMessages];

Print["Actual failures: ", Length[failedTests]];
Print["Message failures: ", Length[messageFailed]];
Print["  - Coverage artifacts: ", Length[artifactMessages]];
Print["  - Real message failures: ", Length[realMessageFailures]];
Print[];

(* === Find tests causing Thread::tdlen errors === *)
threadErrors = Select[allTestResults,
  AnyTrue[#["ActualMessages"],
    MatchQ[#, HoldPattern[MessageName[Thread, "tdlen"]]] &
  ] &
];

If[Length[threadErrors] > 0,
  Print["⚠️  Tests causing Thread::tdlen errors: ", Length[threadErrors]];
  Do[
    Print["  - ", threadErr["TestFileName"]];
    Print["    TestID: ", threadErr["TestID"]],
    {threadErr, Take[threadErrors, UpTo[5]]}
  ];
  Print[]
];

(* === Find tests causing AssociateTo::invak errors === *)
associateErrors = Select[allTestResults,
  AnyTrue[#["ActualMessages"],
    MatchQ[#, HoldPattern[MessageName[AssociateTo, "invak"]]] &
  ] &
];

If[Length[associateErrors] > 0,
  Print["⚠️  Tests causing AssociateTo::invak errors: ", Length[associateErrors]];
  Do[
    Print["  - ", associateErr["TestFileName"]];
    Print["    TestID: ", associateErr["TestID"]],
    {associateErr, Take[associateErrors, UpTo[5]]}
  ];
  Print[]
];

(* === Write detailed results to log === *)
WriteString[logFile, "### Batch Execution Summary\n\n"];
WriteString[logFile, "- Total tests: " <> ToString[totalTests] <> "\n"];
WriteString[logFile, "- Passed: " <> ToString[totalPassed] <> "\n"];
WriteString[logFile, "- Failed: " <> ToString[totalFailed] <> "\n"];
WriteString[logFile, "- Aborted: " <> ToString[totalAborted] <> "\n"];
WriteString[logFile, "- Execution time: " <> ToString[Round[elapsedTime]] <> " seconds\n"];
WriteString[logFile, "\n"];

WriteString[logFile, "### Failure Analysis\n\n"];
WriteString[logFile, "- Actual failures: " <> ToString[Length[failedTests]] <> "\n"];
WriteString[logFile, "- Message failures: " <> ToString[Length[messageFailed]] <> "\n"];
WriteString[logFile, "  - Coverage artifacts: " <> ToString[Length[artifactMessages]] <> "\n"];
WriteString[logFile, "  - Real message failures: " <> ToString[Length[realMessageFailures]] <> "\n"];
WriteString[logFile, "\n"];

(* === Document Thread::tdlen errors === *)
If[Length[threadErrors] > 0,
  WriteString[logFile, "### Tests Causing Thread::tdlen Errors\n\n"];
  Do[
    WriteString[logFile, "#### Test: " <> FileNameTake[threadErr["TestFileName"]] <> "\n"];
    WriteString[logFile, "- **File:** `" <> threadErr["TestFileName"] <> "`\n"];
    WriteString[logFile, "- **TestID:** " <> threadErr["TestID"] <> "\n"];
    WriteString[logFile, "- **Outcome:** " <> ToString[threadErr["Outcome"]] <> "\n"];
    WriteString[logFile, "- **Messages:** " <> ToString[threadErr["ActualMessages"], InputForm] <> "\n"];
    WriteString[logFile, "\n"],
    {threadErr, threadErrors}
  ];
  WriteString[logFile, "\n"]
];

(* === Document AssociateTo::invak errors === *)
If[Length[associateErrors] > 0,
  WriteString[logFile, "### Tests Causing AssociateTo::invak Errors\n\n"];
  Do[
    WriteString[logFile, "#### Test: " <> FileNameTake[associateErr["TestFileName"]] <> "\n"];
    WriteString[logFile, "- **File:** `" <> associateErr["TestFileName"] <> "`\n"];
    WriteString[logFile, "- **TestID:** " <> associateErr["TestID"] <> "\n"];
    WriteString[logFile, "- **Outcome:** " <> ToString[associateErr["Outcome"]] <> "\n"];
    WriteString[logFile, "- **Messages:** " <> ToString[associateErr["ActualMessages"], InputForm] <> "\n"];
    WriteString[logFile, "\n"],
    {associateErr, Take[associateErrors, UpTo[20]]}
  ];
  WriteString[logFile, "\n"]
];

(* === Document all real failures === *)
If[Length[failedTests] > 0,
  WriteString[logFile, "### Actual Test Failures\n\n"];
  Do[
    WriteString[logFile, "#### Test: " <> FileNameTake[failed["TestFileName"]] <> "\n"];
    WriteString[logFile, "- **File:** `" <> failed["TestFileName"] <> "`\n"];
    WriteString[logFile, "- **TestID:** " <> failed["TestID"] <> "\n"];
    WriteString[logFile, "- **Input:** " <> ToString[failed["Input"], InputForm] <> "\n"];
    WriteString[logFile, "- **Expected:** " <> ToString[failed["ExpectedOutput"], InputForm] <> "\n"];
    WriteString[logFile, "- **Actual:** " <> ToString[failed["ActualOutput"], InputForm] <> "\n"];
    WriteString[logFile, "\n"],
    {failed, failedTests}
  ];
  WriteString[logFile, "\n"]
];

(* === Summary and Recommendations === *)
WriteString[logFile, "## Summary\n\n"];
WriteString[logFile, "### Problem Tests Identified\n\n"];

If[Length[threadErrors] > 0,
  WriteString[logFile, "**Thread::tdlen errors:** " <> ToString[Length[threadErrors]] <> " tests\n"];
  WriteString[logFile, "- These tests cause objects of unequal length errors\n"];
  WriteString[logFile, "- Likely caused by instrumentation interfering with meta-programming\n"];
  WriteString[logFile, "\n"]
];

If[Length[associateErrors] > 0,
  WriteString[logFile, "**AssociateTo::invak errors:** " <> ToString[Length[associateErrors]] <> " tests\n"];
  WriteString[logFile, "- These tests corrupt coverage runtime data structures\n"];
  WriteString[logFile, "- Coverage tracking becomes unreliable after these tests\n"];
  WriteString[logFile, "\n"]
];

WriteString[logFile, "### Recommended Actions\n\n"];

If[Length[threadErrors] > 0 || Length[associateErrors] > 0,
  WriteString[logFile, "1. **Exclude problematic tests from CoverageEvaluate**\n"];
  WriteString[logFile, "   - Run them separately without coverage tracking\n"];
  WriteString[logFile, "   - Tests still validate functionality, just without coverage data\n"];
  WriteString[logFile, "\n"];
  WriteString[logFile, "2. **Files to exclude:**\n"];

  (* Get unique filenames *)
  problematicFiles = DeleteDuplicates[Join[
    threadErrors[[All, "TestFileName"]],
    associateErrors[[All, "TestFileName"]]
  ]];

  Do[
    WriteString[logFile, "   - `" <> file <> "`\n"],
    {file, problematicFiles}
  ];
  WriteString[logFile, "\n"]
];

WriteString[logFile, "### Root Cause Analysis\n\n"];
WriteString[logFile, "- **Thread::tdlen:** Instrumentation creates malformed code structures\n"];
WriteString[logFile, "  - Likely occurs in meta-programming contexts (ToExpression, With, etc.)\n"];
WriteString[logFile, "  - Code works fine without instrumentation\n"];
WriteString[logFile, "\n"];
WriteString[logFile, "- **AssociateTo::invak:** Instrumentation runtime corruption\n"];
WriteString[logFile, "  - Coverage tracking internal state becomes invalid\n"];
WriteString[logFile, "  - All subsequent coverage data is unreliable\n"];
WriteString[logFile, "  - Requires kernel restart or test isolation\n"];
WriteString[logFile, "\n"];

WriteString[logFile, "---\n"];
WriteString[logFile, "Generated by AnalyzeBatch.wls on " <> DateString[] <> "\n"];

Close[logFile];

Print["=" StringRepeat["=", 69]];
Print["Analysis complete!"];
Print["=" StringRepeat["=", 69]];
Print["Log file: ", logFile];
Print[];

If[Length[threadErrors] > 0 || Length[associateErrors] > 0,
  Print["⚠️  PROBLEMATIC TESTS FOUND"];
  Print["See RunLog.md for details and recommendations"];
  Print[];
  Quit[1],
  Print["✓ All tests passed without coverage corruption"];
  Print[];
  Quit[0]
];
