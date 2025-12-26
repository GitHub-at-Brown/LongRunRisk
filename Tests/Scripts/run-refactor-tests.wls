#!/usr/bin/env wolframscript
(*
 * run-refactor-tests.wls
 *
 * Comprehensive test suite runner for options refactoring.
 * Runs all Phase 5 validation tests.
 *
 * Exit codes:
 *   0 - All tests passed
 *   1 - Some tests failed
 *)

(* Set working directory to package root *)
SetDirectory[DirectoryName[DirectoryName[DirectoryName[$InputFileName]]]];

Print["================================================="];
Print["LongRunRisk Options Refactoring - Test Suite"];
Print["=================================================\n"];

(* Test files to run *)
testFiles = {
	"Tests/OptionsConfig.wlt",
	"Tests/pipelineOptionForwarding.wlt",
	"Tests/yieldCurveThreadSafety.wlt",
	"Tests/yieldCurveRegression.wlt",
	"Tests/optionErrorHandling.wlt",
	"Tests/optionRenaming.wlt"
};

(* Track results *)
allResults = <||>;
totalTests = 0;
totalPassed = 0;
totalFailed = 0;

(* Run each test file *)
Do[
	If[FileExistsQ[testFile],
		Print["Running: ", testFile];
		Print[StringRepeat["-", 60]];

		result = Quiet[
			TestReport[testFile],
			{TestReport::notests}
		];

		If[Head[result] === TestReportObject,
			passed = result["TestsSucceededCount"];
			failed = result["TestsFailedCount"];
			total = passed + failed;

			totalTests += total;
			totalPassed += passed;
			totalFailed += failed;

			allResults[testFile] = <|
				"Total" -> total,
				"Passed" -> passed,
				"Failed" -> failed,
				"Result" -> result
			|>;

			Print["  Tests: ", total];
			Print["  Passed: ", passed];
			Print["  Failed: ", failed];

			If[failed > 0,
				Print["  STATUS: FAILED"];
				Print["\n  Failed tests:"];
				Do[
					Print["    - ", test["TestID"]],
					{test, result["TestsFailed"]}
				];
			,
				Print["  STATUS: PASSED"];
			];
		,
			Print["  ERROR: Could not run test file"];
			allResults[testFile] = <|"Error" -> "Could not run"|>;
			totalFailed += 1;
		];

		Print[""];
	,
		Print["WARNING: Test file not found: ", testFile];
		Print[""];
	],
	{testFile, testFiles}
];

(* Summary *)
Print["================================================="];
Print["Summary"];
Print["================================================="];
Print["Total test files: ", Length[testFiles]];
Print["Total tests: ", totalTests];
Print["Passed: ", totalPassed, " (", If[totalTests > 0, N[100.0 * totalPassed / totalTests], 0], "%)"];
Print["Failed: ", totalFailed];
Print[""];

(* Overall status *)
If[totalFailed === 0,
	Print["✓ ALL TESTS PASSED"];
	exitCode = 0;
,
	Print["✗ SOME TESTS FAILED"];
	Print["\nFailed test files:"];
	KeyValueMap[
		Function[{file, res},
			If[KeyExistsQ[res, "Failed"] && res["Failed"] > 0,
				Print["  - ", file, ": ", res["Failed"], " failed tests"]
			]
		],
		allResults
	];
	exitCode = 1;
];

Print["=================================================\n"];

(* Export detailed results if requested *)
If[$ScriptCommandLine =!= {} && MemberQ[$ScriptCommandLine, "--export"],
	resultFile = "Tests/refactor-test-results.wdx";
	Export[resultFile, allResults];
	Print["Detailed results exported to: ", resultFile, "\n"];
];

Exit[exitCode];
