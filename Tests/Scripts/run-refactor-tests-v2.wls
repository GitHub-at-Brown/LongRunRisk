#!/usr/bin/env wolframscript
SetDirectory[DirectoryName[DirectoryName[DirectoryName[$InputFileName]]]];

Print["================================================="];
Print["LongRunRisk Options Refactoring - Test Suite v2"];
Print["=================================================\n"];

testFiles = {
	"Tests/OptionsConfig.wlt",
	"Tests/pipelineOptionForwarding.wlt",
	"Tests/optionErrorHandling.wlt",
	"Tests/optionRenaming.wlt"
};

totalTests = 0;
totalPassed = 0;
totalFailed = 0;

Do[
	If[FileExistsQ[testFile],
		Print["Running: ", testFile];
		Print[StringRepeat["-", 60]];

		result = Quiet[TestReport[testFile], {TestReport::notests}];

		If[Head[result] === TestReportObject,
			passed = result["TestsSucceededCount"];
			failed = result["TestsFailedCount"];
			total = passed + failed;

			totalTests += total;
			totalPassed += passed;
			totalFailed += failed;

			Print["  Tests: ", total];
			Print["  Passed: ", passed];
			Print["  Failed: ", failed];

			If[failed > 0,
				Print["  STATUS: FAILED"];
			,
				Print["  STATUS: PASSED"];
			];
		,
			Print["  ERROR: Could not run test file"];
			totalFailed += 1;
		];

		Print[""];
	,
		Print["WARNING: Test file not found: ", testFile];
		Print[""];
	],
	{testFile, testFiles}
];

Print["================================================="];
Print["Summary"];
Print["================================================="];
Print["Total tests: ", totalTests];
Print["Passed: ", totalPassed, " (", If[totalTests > 0, N[100.0 * totalPassed / totalTests], 0], "%)"];
Print["Failed: ", totalFailed];
Print[""];

If[totalFailed === 0,
	Print["✓ ALL TESTS PASSED"];
	exitCode = 0;
,
	Print["✗ SOME TESTS FAILED"];
	exitCode = 1;
];

Print["=================================================\n"];

Exit[exitCode];
