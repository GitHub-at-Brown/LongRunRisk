(* ::Package:: *)

(* ::Section:: *)
(*Kernel/Tools/FindRootOptim.wl Tests*)


BeginTestSection["Kernel/Tools/FindRootOptim.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`FindRootOptim`"]

Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];


(* ::Subsection:: *)
(*Load Test Helpers*)


Get @ FileNameJoin[{DirectoryName[$TestFileName, 2], "TestHelpers.wl"}];
Get @ FileNameJoin[{DirectoryName[$TestFileName, 1], "ToolsTestHelpers.wl"}];


(* ::Subsection:: *)
(*Test Setup*)


(* Private symbol aliases *)
$normalizeExp = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`normalizeExp;
$signIdxs = FernandoDuarte`LongRunRisk`Tools`FindRootOptim`Private`signIdxs;

(* Interval comparison tolerance *)
$intervalSameTest = (Max[Abs@Flatten[#1 - #2]] < 10^-10 &);

(* Helper functions for root finding tests *)
$f1[z_] := z[[1]]^2 - 2;
$df1[z_] := 2*z[[1]];
$f2[z_] := z[[1]]^2 - 4;
$df2[z_] := 2*z[[1]];
$fcos[z_] := Cos[z[[1]]];
$dfcos[z_] := -Sin[z[[1]]];

(* 2D system for nD tests *)
$fND2[z_] := {z[[1]]^2 + z[[2]] - 3, z[[1]] + z[[2]]^2 - 3};
$dfND2[z_] := {{2*z[[1]], 1}, {1, 2*z[[2]]}};

(* Helper to reduce repeated CCompilerDriver context setup *)
SetAttributes[$withCCompilerDriver, HoldFirst];
$withCCompilerDriver[expr_] := Block[
	{$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "CCompilerDriver`"]},
	expr
];


(* ::Subsection:: *)
(*Usage Message Tests*)


(* Test: createCompiledEq has usage message *)
TestCreate[
	StringQ[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq::usage],
	True,
	{},
	TestID -> "[createCompiledEq] Has usage message"
]

(* Test: buildKernel has usage message *)
TestCreate[
	StringQ[FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel::usage],
	True,
	{},
	TestID -> "[buildKernel] Has usage message"
]



(* ::Subsection:: *)
(*createCompiledEq - Functionality Tests*)


(* Test: createCompiledEq works with a valid model and creates output *)
TestCreate[
        Module[{tempDir, result, mxFiles, model},
                tempDir = CreateDirectory[];
                (* Use a real model from TestHelpers *)
                model = FernandoDuarte`LongRunRisk`Tests`Common`$modBKY; 
                
                WithCleanup[
                        (* Define mud and j to satisfy FunctionCompile if they are missing from params *)
                        Block[{
                                FernandoDuarte`LongRunRisk`Model`Parameters`mud = 0.0015,
                                FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`j = 1
                        },
                                result = createCompiledEq[
                                        model, 
                                        tempDir, 
                                        "Compiler" -> "FunctionCompile", (* Matches paclet default *)
                                        "CompileMode" -> "FunctionOnly" (* Minimal work *)
                                ]
                        ];
                        
                        (* Check results *)
                        mxFiles = FileNames["*.mx", tempDir, Infinity];
                        
                        (* Verify: Result is a string path, file exists, and file is in expected subfolder *)
                        StringQ[result] && 
                        FileExistsQ[result] && 
                        Length[mxFiles] > 0
                        ,
                        DeleteDirectory[tempDir, DeleteContents -> True]
                ]
        ],
        True,
        {},
        TestID -> "[createCompiledEq] Creates MX file with valid model"
]


(* ::Subsection:: *)
(*buildKernel - Options Tests*)


(* Test: buildKernel has options *)
TestCreate[
	Length[Options[buildKernel]] > 0,
	True,
	{},
	TestID -> "[buildKernel] Has options"
]

(* Test: buildKernel has CoeffName option *)
TestCreate[
	MemberQ[Keys[Options[buildKernel]], "CoeffName"],
	True,
	{},
	TestID -> "[buildKernel] Has CoeffName option"
]

(* Test: buildKernel has CompileSignSymbol option *)
TestCreate[
	MemberQ[Keys[Options[buildKernel]], "CompileSignSymbol"],
	True,
	{},
	TestID -> "[buildKernel] Has CompileSignSymbol option"
]

(* Test: buildKernel has PerformanceGoal option *)
TestCreate[
	MemberQ[Keys[Options[buildKernel]], "PerformanceGoal"],
	True,
	{},
	TestID -> "[buildKernel] Has PerformanceGoal option"
]

(* Test: buildKernel has CompileMode option *)
TestCreate[
	MemberQ[Keys[Options[buildKernel]], "CompileMode"],
	True,
	{},
	TestID -> "[buildKernel] Has CompileMode option"
]

(* Test: buildKernel respects explicit CompileMode option *)
TestCreate[
	OptionValue[buildKernel, {"CompileMode" -> "FunctionOnly"}, "CompileMode"],
	"FunctionOnly",
	{},
	TestID -> "[buildKernel] Explicit CompileMode is respected"
]


(* ::Subsection:: *)
(*buildKernel - Functionality Tests*)


(* Test: buildKernel with FunctionOnly produces Missing Jacobian *)
TestCreate[
	Module[{kernel, expr, vars, params},
		expr = x^2 - A[0];
		vars = {A[0]};
		params = {x};
		$withCCompilerDriver[
			kernel = buildKernel[expr, vars, params, "CompileMode" -> "FunctionOnly"];
			MissingQ[kernel["dfC"]]
		]
	],
	True,
	{},
	TestID -> "[buildKernel] FunctionOnly produces Missing Jacobian"
]

(* Test: buildKernel with Both produces function and Jacobian *)
TestCreate[
	Module[{kernel, expr, vars, params},
		expr = x^2 - A[0];
		vars = {A[0]};
		params = {x};
		$withCCompilerDriver[
			kernel = buildKernel[expr, vars, params, "CompileMode" -> "Both"];
			!MissingQ[kernel["dfC"]] && !FailureQ[kernel["dfC"]]
		]
	],
	True,
	{},
	TestID -> "[buildKernel] Both mode produces Jacobian"
]

(* Test: buildKernel respects CoeffName and CompileSignSymbol options *)
TestCreate[
	Module[{kernel},
		$withCCompilerDriver[
			kernel = buildKernel[
				x^2 - B[0] + signB[1],
				{B[0]},
				{x},
				"CoeffName" -> "B",
				"CompileSignSymbol" -> "signB"
			];
			kernel["CoeffName"] === "B" && kernel["CompileSignSymbol"] === "signB"
		]
	],
	True,
	{},
	TestID -> "[buildKernel] CoeffName and CompileSignSymbol are respected"
]

(* Test: buildKernel produces Association with expected structure *)
TestCreate[
	Module[{kernel},
		$withCCompilerDriver[
			kernel = buildKernel[
				x^2 - A[0],
				{A[0]},
				{x},
				"CoeffName" -> "A",
				"CompileSignSymbol" -> "signA",
				"CompileMode" -> "Both",
				"Compiler" -> "FunctionCompile"
			];
			AssociationQ[kernel] &&
			KeyExistsQ[kernel, "fC"] &&
			KeyExistsQ[kernel, "dfC"] &&
			KeyExistsQ[kernel, "Vars"]
		]
	],
	True,
	{},
	TestID -> "[buildKernel] Returns Association with expected keys"
]

(* Test: buildKernel with Compile produces expected structure *)
TestCreate[
	Module[{kernel},
		$withCCompilerDriver[
			kernel = buildKernel[
				x^2 - A[0],
				{A[0]},
				{x},
				"CoeffName" -> "A",
				"CompileSignSymbol" -> "signA",
				"Compiler" -> "Compile"
			];
			AssociationQ[kernel] &&
			KeyExistsQ[kernel, "fC"] &&
			KeyExistsQ[kernel, "Vars"]
		]
	],
	True,
	{},
	TestID -> "[buildKernel] Compile mode produces expected structure"
]

(* Test: Both compiler modes produce equivalent results *)
TestCreate[
	Module[{kernelFC, kernelC, fFC, fC, dfFC, dfC},
		$withCCompilerDriver[
			kernelFC = buildKernel[x^2 - A[0], {A[0]}, {x}, "Compiler" -> "FunctionCompile"];
			kernelC = buildKernel[x^2 - A[0], {A[0]}, {x}, "Compiler" -> "Compile"];
			{fFC, dfFC} = bindUnary[kernelFC, <|x -> 2|>, {}];
			{fC, dfC} = bindUnary[kernelC, <|x -> 2|>, {}];
			Abs[fFC[1] - fC[1]] < 10^-10
		]
	],
	True,
	{},
	TestID -> "[buildKernel] Both compiler modes produce equivalent results"
]


(* ::Subsection:: *)
(*buildKernel - Error and Edge Case Tests*)


(* Test: buildKernel detects unused variables *)
TestCreate[
	$withCCompilerDriver[
		buildKernel[x^2, {A[0]}, {x}, "CoeffName" -> "A"]
	] === $Failed,
	True,
	{buildKernel::unusedvars},
	TestID -> "[buildKernel] Error on unused variable"
]

(* Test: buildKernel with JacobianOnly produces only Jacobian *)
TestCreate[
	$withCCompilerDriver[
		Module[{kernel},
			kernel = buildKernel[x^2 - A[0], {A[0]}, {x}, "CompileMode" -> "JacobianOnly"];
			MissingQ[kernel["fC"]] && !MissingQ[kernel["dfC"]]
		]
	],
	True,
	{},
	TestID -> "[buildKernel] JacobianOnly mode produces only Jacobian"
]


(* ::Subsection:: *)
(*bindUnary - Message Tests*)


(* Test: bindUnary issues toofewsigns with one sign when two needed *)
TestCreate[
	Module[{kernel},
		$withCCompilerDriver[
			kernel = buildKernel[
				signA[1] * gamma + signA[2] * delta - A[0],
				{A[0]},
				{gamma, delta},
				"CompileSignSymbol" -> "signA"
			];
			bindUnary[kernel, <|gamma -> 1.0, delta -> 2.0|>, {1}] === $Failed
		]
	],
	True,
	{bindUnary::toofewsigns},
	TestID -> "[bindUnary] Too few signs returns Failed with one sign"
]

(* Test: bindUnary issues toofewsigns with empty signs when signs needed *)
TestCreate[
	Module[{kernel},
		$withCCompilerDriver[
			kernel = buildKernel[
				signA[1] * gamma + signA[2] * delta - A[0],
				{A[0]},
				{gamma, delta},
				"CompileSignSymbol" -> "signA"
			];
			bindUnary[kernel, <|gamma -> 1.0, delta -> 2.0|>, {}] === $Failed
		]
	],
	True,
	{bindUnary::toofewsigns},
	TestID -> "[bindUnary] Too few signs returns Failed with empty signs"
]

(* Test: bindUnary succeeds with valid sign count *)
TestCreate[
	Module[{kernel, result, f, df, testVal},
		$withCCompilerDriver[
			kernel = buildKernel[
				signA[1] * gamma + signA[2] * delta - A[0],
				{A[0]},
				{gamma, delta},
				"CompileSignSymbol" -> "signA"
			];
			result = bindUnary[kernel, <|gamma -> 1.0, delta -> 2.0|>, {1, -1}];
			{f, df} = result;
			(* With signs {1, -1}: 1*1.0 + (-1)*2.0 - A[0] = -1 - A[0] *)
			(* Evaluated at A[0] = 3.0: -1 - 3 = -4 *)
			testVal = f[{3.0}];
			MatchQ[result, {_Function, _Function}] &&
			NumericQ[testVal] &&
			Abs[testVal - (-4.0)] < 10^-6
		]
	],
	True,
	{},
	TestID -> "[bindUnary] Valid sign count returns function pair"
]

(* Test: bindUnary issues toomanysigns when more signs than needed *)
TestCreate[
	$withCCompilerDriver[
		Module[{kernel},
			kernel = buildKernel[
				signA[1] * gamma - A[0],
				{A[0]},
				{gamma},
				"CompileSignSymbol" -> "signA"
			];
			bindUnary[kernel, <|gamma -> 1.0|>, {1, -1}] === $Failed
		]
	],
	True,
	{bindUnary::toomanysigns},
	TestID -> "[bindUnary] Too many signs returns Failed"
]


(* ::Subsection:: *)
(*extractIntervalsFromReduce - Basic Tests*)


(* Test: True input returns default interval *)
TestCreate[
	extractIntervalsFromReduce[True, A[0]],
	{{0.002, 14.998}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] True input returns default interval"
]

(* Test: False input returns empty with message *)
TestCreate[
	extractIntervalsFromReduce[False, {A[0], B[1][0]}],
	{},
	{extractIntervalsFromReduce::nointervals},
	TestID -> "[extractIntervalsFromReduce] False returns empty with message"
]

(* Test: Inequality extracts with padding for n-dimensional case *)
TestCreate[
	extractIntervalsFromReduce[Inequality[1, LessEqual, A[0], LessEqual, 5], {A[0], B[1][0]}],
	{{{1.001, -1.*^5}, {4.999, 1.*^5}}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] nD case pads second dimension"
]

(* Test: Mixed two-sided and upper fallback *)
TestCreate[
	extractIntervalsFromReduce[(x > 10) || (1 < x < 2), x, "InteriorShrink" -> 0],
	{{1., 2.}, {10., 15.}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Mixed two-sided and upper fallback"
]

(* Test: Single point and upper fallback *)
TestCreate[
	extractIntervalsFromReduce[(x == 3) || (x > 10), x, "InteriorShrink" -> 0],
	{{3., 3.}, {10., 15.}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Single point and upper fallback"
]

(* Test: Drops clause above upper bound *)
TestCreate[
	extractIntervalsFromReduce[(x > 20) || (1 < x < 2), x, "InteriorShrink" -> 0, "RootUpperBound" -> 15],
	{{1., 2.}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Drops clause above upper bound"
]

(* Test: Drops clause below zero and returns empty *)
TestCreate[
	extractIntervalsFromReduce[x < -1, x, "InteriorShrink" -> 0, "RootUpperBound" -> 10],
	{},
	{extractIntervalsFromReduce::nointervals},
	TestID -> "[extractIntervalsFromReduce] Below zero clause returns empty"
]

(* Test: Collapses narrow interval to midpoint *)
TestCreate[
	extractIntervalsFromReduce[0 < x < 0.0015, x, "InteriorShrink" -> 0.001, "RootUpperBound" -> 1],
	{{0.00075, 0.00075}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Narrow interval collapses to midpoint"
]

(* Test: True branch with full range *)
TestCreate[
	extractIntervalsFromReduce[True, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 5],
	{{0.2, 4.8}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] True with shrink returns adjusted range"
]

(* Test: False branch returns empty *)
TestCreate[
	extractIntervalsFromReduce[False, x],
	{},
	{extractIntervalsFromReduce::nointervals},
	TestID -> "[extractIntervalsFromReduce] False returns empty"
]

(* Test: One-sided lower clamped to upper *)
TestCreate[
	extractIntervalsFromReduce[x > 1, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 5],
	{{1.1, 4.9}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] One-sided clamped to upper bound"
]

(* Test: One-sided near upper clamps and collapses *)
TestCreate[
	extractIntervalsFromReduce[x > 4.9, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 5],
	{{4.95, 4.95}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Near upper bound collapses"
]

(* Test: Width equal to 2x shrink collapses to midpoint *)
TestCreate[
	extractIntervalsFromReduce[2 < x < 2.2, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 10],
	{{2.1, 2.1}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Equal shrink collapses to midpoint"
]

(* Test: Wide interval applies shrink *)
TestCreate[
	extractIntervalsFromReduce[1 < x < 3, x, "InteriorShrink" -> 0.1, "RootUpperBound" -> 10],
	{{1.1, 2.9}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Wide interval applies shrink"
]

(* Test: Open-closed mix and sorting *)
TestCreate[
	extractIntervalsFromReduce[(x >= 4 && x <= 4.2) || (1 <= x <= 2) || (x >= 10), x, "InteriorShrink" -> 0],
	{{1., 2.}, {4., 4.2}, {10., 15.}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Open-closed mix sorted correctly"
]

(* Test: All clauses dropped returns empty *)
TestCreate[
	extractIntervalsFromReduce[x > 20, x, "RootUpperBound" -> 15],
	{},
	{extractIntervalsFromReduce::nointervals},
	TestID -> "[extractIntervalsFromReduce] All dropped returns empty"
]

(* Test: Indexed variable head extracts bound *)
TestCreate[
	extractIntervalsFromReduce[Inequality[0, Less, B[1][0], LessEqual, 6.059], B[1][0], "InteriorShrink" -> 0],
	{{0., 6.059}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Indexed variable extracts bounds"
]

(* Test: Mismatched indexed variable returns default *)
TestCreate[
	extractIntervalsFromReduce[Inequality[0, Less, B[1][0], LessEqual, 6.059], B[j][0], "InteriorShrink" -> 0],
	{{0., 15.}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Mismatched index returns default"
]


(* ::Subsection:: *)
(*extractIntervalsFromReduce - Options Tests*)


(* Test: Large shrink on wide interval *)
TestCreate[
	extractIntervalsFromReduce[1 < x < 5, x, "InteriorShrink" -> 0.5, "RootUpperBound" -> 10],
	{{1.5, 4.5}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Large shrink wide interval"
]

(* Test: Large shrink collapses narrow interval *)
TestCreate[
	extractIntervalsFromReduce[1 < x < 2, x, "InteriorShrink" -> 0.5, "RootUpperBound" -> 10],
	{{1.5, 1.5}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Large shrink collapses narrow"
]

(* Test: Shrink two with upper bound ten *)
TestCreate[
	extractIntervalsFromReduce[x > 0, x, "InteriorShrink" -> 2, "RootUpperBound" -> 10],
	{{2., 8.}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Shrink 2 upper bound 10"
]

(* Test: Shrink nearly half of upper bound collapses *)
TestCreate[
	extractIntervalsFromReduce[x > 0, x, "InteriorShrink" -> 4.9, "RootUpperBound" -> 10],
	{{4.9, 5.1}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Nearly half upper bound collapses"
]

(* Test: Two intervals with different collapse behavior *)
TestCreate[
	extractIntervalsFromReduce[(0.5 < x < 1.5) || (3 < x < 6), x, "InteriorShrink" -> 0.25, "RootUpperBound" -> 8],
	{{0.75, 1.25}, {3.25, 5.75}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Two intervals different collapse"
]

(* Test: Very small shrink with small upper bound *)
TestCreate[
	extractIntervalsFromReduce[x > 0, x, "InteriorShrink" -> 0.0001, "RootUpperBound" -> 2],
	{{0.0001, 1.9999}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Very small shrink small upper"
]

(* Test: Zero shrink with large upper bound *)
TestCreate[
	extractIntervalsFromReduce[x > 0, x, "InteriorShrink" -> 0, "RootUpperBound" -> 100],
	{{0., 100.}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Zero shrink large upper"
]

(* Test: Mixed bounded and unbounded with custom options *)
TestCreate[
	extractIntervalsFromReduce[(x > 5) || (0 < x < 1), x, "InteriorShrink" -> 0.2, "RootUpperBound" -> 20],
	{{0.2, 0.8}, {5.2, 19.8}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Mixed bounded unbounded custom"
]

(* Test: Three intervals with mixed collapse *)
TestCreate[
	extractIntervalsFromReduce[(1 < x < 2) || (3 < x < 4) || (5 < x < 6), x, "InteriorShrink" -> 0.4, "RootUpperBound" -> 10],
	{{1.4, 1.6}, {3.4, 3.6}, {5.4, 5.6}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Three intervals mixed collapse"
]

(* Test: Small interval small shrink no collapse *)
TestCreate[
	extractIntervalsFromReduce[0.1 < x < 0.3, x, "InteriorShrink" -> 0.05, "RootUpperBound" -> 5],
	{{0.15, 0.25}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Small interval no collapse"
]

(* Test: Small interval small shrink collapses *)
TestCreate[
	extractIntervalsFromReduce[0.1 < x < 0.2, x, "InteriorShrink" -> 0.05, "RootUpperBound" -> 5],
	{{0.15, 0.15}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Small interval collapses"
]

(* Test: Near upper bound with shrink collapses *)
TestCreate[
	extractIntervalsFromReduce[x > 18, x, "InteriorShrink" -> 1, "RootUpperBound" -> 20],
	{{19., 19.}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Near upper with shrink collapses"
]

(* Test: Point and unbounded with custom options *)
TestCreate[
	extractIntervalsFromReduce[(x == 5) || (x > 10), x, "InteriorShrink" -> 0.5, "RootUpperBound" -> 15],
	{{5., 5.}, {10.5, 14.5}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Point and unbounded custom"
]

(* Test: Shrink equals half upper bound collapses *)
TestCreate[
	extractIntervalsFromReduce[x > 0, x, "InteriorShrink" -> 1.5, "RootUpperBound" -> 3],
	{{1.5, 1.5}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Shrink equals half upper collapses"
]

(* Test: Second interval clipped by upper bound *)
TestCreate[
	extractIntervalsFromReduce[(0.5 < x < 2) || (10 < x < 15), x, "InteriorShrink" -> 0.3, "RootUpperBound" -> 12],
	{{0.8, 1.7}, {10.3, 11.7}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Second interval clipped"
]

(* Test: Small shrink large upper bound *)
TestCreate[
	extractIntervalsFromReduce[x > 0, x, "InteriorShrink" -> 0.01, "RootUpperBound" -> 50],
	{{0.01, 49.99}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Small shrink large upper"
]

(* Test: Mixed inequality types with custom shrink *)
TestCreate[
	extractIntervalsFromReduce[(0 < x <= 1) || (2 <= x < 3), x, "InteriorShrink" -> 0.4, "RootUpperBound" -> 8],
	{{0.4, 0.6}, {2.4, 2.6}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Mixed inequality types"
]

(* Test: Tiny intervals small shrink no collapse *)
TestCreate[
	extractIntervalsFromReduce[(0.01 < x < 0.02) || (0.03 < x < 0.04), x, "InteriorShrink" -> 0.004, "RootUpperBound" -> 1],
	{{0.014, 0.016}, {0.034, 0.036}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Tiny intervals no collapse"
]

(* Test: Large shrink moderate upper bound *)
TestCreate[
	extractIntervalsFromReduce[x > 0, x, "InteriorShrink" -> 3, "RootUpperBound" -> 8],
	{{3., 5.}},
	{},
	SameTest -> $intervalSameTest,
	TestID -> "[extractIntervalsFromReduce] Large shrink moderate upper"
]


(* ::Subsection:: *)
(*findRootInterval - Message Tests*)


(* Test: Empty interval message on false *)
TestCreate[
	Block[{A},
		findRootInterval[A[0] < 0 && A[0] > 0, <||>, "A", "signA"]
	] === $Failed,
	True,
	{findRootInterval::emptyinterval},
	TestID -> "[findRootInterval] Empty interval on contradiction"
]

(* Test: Empty interval message on range contradiction *)
TestCreate[
	Block[{A},
		findRootInterval[A[0] > 10 && A[0] < 5, <||>, "A", "signA"]
	] === $Failed,
	True,
	{findRootInterval::emptyinterval},
	TestID -> "[findRootInterval] Empty interval on range contradiction"
]

(* Test: Empty interval message on parameter contradiction *)
TestCreate[
	Block[{A},
		findRootInterval[A[0] > 0 && A[0] < -1, <||>, "A", "signA"]
	] === $Failed,
	True,
	{findRootInterval::emptyinterval},
	TestID -> "[findRootInterval] Empty interval on parameter contradiction"
]

(* Test: No coefficient message when no coefficient found *)
TestCreate[
	Block[{x},
		findRootInterval[x > 0 && x < 10, <||>, "A", "signA"]
	] === $Failed,
	True,
	{findRootInterval::nocoeff},
	TestID -> "[findRootInterval] No coefficient message"
]

(* Test: No coefficient message with only parameters *)
TestCreate[
	Block[{a},
		findRootInterval[a > 0, <|a -> 1|>, "A", "signA"]
	] === $Failed,
	True,
	{findRootInterval::nocoeff},
	TestID -> "[findRootInterval] No coefficient with only params"
]

(* Test: No coefficient message with wrong coefficient name *)
TestCreate[
	Block[{B},
		findRootInterval[B[0] > 1 && B[0] < 5, <||>, "A", "signA"]
	] === $Failed,
	True,
	{findRootInterval::nocoeff},
	TestID -> "[findRootInterval] Wrong coefficient name"
]

(* Test: findRootInterval returns valid logical expression on success *)
TestCreate[
	Module[{result},
		result = findRootInterval[A[0] > 1 && A[0] < 5, <||>, "A", "signA"];
		!FailureQ[result] && MatchQ[result, _And | _Less | _LessEqual | _Greater | _GreaterEqual | _Inequality]
	],
	True,
	{},
	TestID -> "[findRootInterval] Returns valid logical expression"
]


(* ::Subsection:: *)
(*fastRoot - Newton Without Jacobian Tests*)


(* Test: 1D quadratic without Jacobian *)
TestCreate[
	Module[{f, result},
		f[z_] := z[[1]]^2 - 4;
		result = fastRoot[f, {1.5, 3.}, "Return" -> "Value"];
		NumericQ[result] && Abs[result^2 - 4] < 10^-6
	],
	True,
	{},
	TestID -> "[fastRoot] 1D quadratic without Jacobian"
]

(* Test: 1D cubic without Jacobian *)
TestCreate[
	Module[{f, result},
		f[z_] := z[[1]]^3 - 8;
		result = fastRoot[f, {1.5, 3.}, "Return" -> "Value"];
		NumericQ[result] && Abs[result^3 - 8] < 10^-6
	],
	True,
	{},
	TestID -> "[fastRoot] 1D cubic without Jacobian"
]

(* Test: 1D transcendental without Jacobian *)
TestCreate[
	Module[{f, result},
		f[z_] := Cos[z[[1]]] - 0.5;
		result = fastRoot[f, {0.5, 1.5}, "Return" -> "Value"];
		NumericQ[result] && Abs[Cos[result] - 0.5] < 10^-6
	],
	True,
	{},
	TestID -> "[fastRoot] 1D transcendental without Jacobian"
]

(* Test: 1D exponential without Jacobian *)
TestCreate[
	Module[{f, result},
		f[z_] := Exp[z[[1]]] - 3;
		result = fastRoot[f, {0.5, 1.5}, "Return" -> "Value"];
		NumericQ[result] && Abs[Exp[result] - 3] < 10^-6
	],
	True,
	{},
	TestID -> "[fastRoot] 1D exponential without Jacobian"
]

(* Test: Newton Automatic 1D without Jacobian *)
TestCreate[
	Module[{f, result},
		f[z_] := z[[1]]^2 - 4;
		result = fastRoot[f, {1.5, 3.0}, Method -> Automatic, "Return" -> "Value"];
		NumericQ[result] && Abs[result^2 - 4] < 10^-6
	],
	True,
	{},
	TestID -> "[fastRoot] Newton Automatic without Jacobian"
]

(* Test: Newton explicit 1D without Jacobian *)
TestCreate[
	Module[{f, result},
		f[z_] := z[[1]]^2 - 4;
		result = fastRoot[f, {1.5, 3.0}, Method -> "Newton", "Return" -> "Value"];
		NumericQ[result] && Abs[result^2 - 4] < 10^-6
	],
	True,
	{},
	TestID -> "[fastRoot] Newton explicit without Jacobian"
]

(* Test: 1D with explicit Jacobian still works *)
TestCreate[
	Module[{f, df, result},
		f[z_] := z[[1]]^2 - 4;
		df[z_] := {2*z[[1]]};
		result = fastRoot[f, {1.5, 3.}, Jacobian -> df, "Return" -> "Value"];
		NumericQ[result] && Abs[result^2 - 4] < 10^-6
	],
	True,
	{},
	TestID -> "[fastRoot] 1D with explicit Jacobian"
]

(* Test: Multiple roots finds one *)
TestCreate[
	Module[{f, result},
		f[z_] := (z[[1]] - 1)*(z[[1]] - 2)*(z[[1]] - 3);
		result = fastRoot[f, {1.2, 1.8}, "Return" -> "Value"];
		NumericQ[result] && (Abs[result - 1] < 10^-6 || Abs[result - 2] < 10^-6)
	],
	True,
	{},
	TestID -> "[fastRoot] Multiple roots finds one"
]

(* Test: Steep gradient without Jacobian *)
TestCreate[
	Module[{f, result},
		f[z_] := z[[1]]^10 - 1024;
		result = fastRoot[f, {1.5, 2.5}, "Return" -> "Value"];
		NumericQ[result] && Abs[result^10 - 1024] < 10^-4
	],
	True,
	{},
	TestID -> "[fastRoot] Steep gradient without Jacobian"
]

(* Test: Different starting points find different roots *)
TestCreate[
	Module[{f, result1, result2},
		f[z_] := z[[1]]^2 - 4;
		result1 = fastRoot[f, {1.5, 2.5}, "Return" -> "Value"];
		result2 = fastRoot[f, {-3., -1.5}, "Return" -> "Value"];
		NumericQ[result1] && NumericQ[result2] &&
		Abs[result1 - 2] < 10^-6 &&
		Abs[result2 - (-2)] < 10^-6
	],
	True,
	{},
	TestID -> "[fastRoot] Different starting points find roots"
]


(* ::Subsection:: *)
(*fastRoot - Method and Options Tests*)


(* Test: Method Secant with Jacobian *)
TestCreate[
	Module[{result},
		result = fastRoot[$f1, {1., 2.}, Jacobian -> $df1, Method -> "Secant"];
		NumericQ[result] && Abs[result^2 - 2] < 10^-6
	],
	True,
	{},
	TestID -> "[fastRoot] Method Secant with Jacobian"
]

(* Test: Method Secant non-bracketed *)
TestCreate[
	Module[{result},
		result = fastRoot[$f2, {1.5, 3.}, Jacobian -> $df2, Method -> "Secant"];
		NumericQ[result] && Abs[result^2 - 4] < 10^-6
	],
	True,
	{},
	TestID -> "[fastRoot] Method Secant non-bracketed"
]

(* Test: Method Brent bracketed *)
TestCreate[
	Module[{result},
		result = fastRoot[$fcos, {1., 2.}, Jacobian -> $dfcos, Method -> "Brent"];
		NumericQ[result] && Abs[Cos[result]] < 10^-6
	],
	True,
	{},
	TestID -> "[fastRoot] Method Brent bracketed"
]

(* Test: Method Secant ignores Jacobian (verifies method selection) *)
TestCreate[
	Module[{f, df, dfCalled, result},
		f[z_] := z[[1]]^2 - 4;
		dfCalled = False;
		df[z_] := (dfCalled = True; {2*z[[1]]});

		result = fastRoot[f, {1.5, 3.}, Jacobian -> df, Method -> "Secant"];

		NumericQ[result] && !dfCalled
	],
	True,
	{},
	TestID -> "[fastRoot] Secant method ignores Jacobian"
]

(* Test: Method Newton uses Jacobian *)
TestCreate[
	Module[{f, df, dfCalled, result},
		f[z_] := z[[1]]^2 - 4;
		dfCalled = False;
		df[z_] := (dfCalled = True; {2*z[[1]]});

		result = fastRoot[f, {1.5, 3.}, Jacobian -> df, Method -> "Newton"];

		NumericQ[result] && dfCalled
	],
	True,
	{},
	TestID -> "[fastRoot] Newton method uses Jacobian"
]

(* Test: fastRoot nD case finds symmetric root *)
TestCreate[
	Module[{result, expectedRoot},
		(* System: {x^2 + y - 3, x + y^2 - 3} has symmetric root at x = y = (-1 + Sqrt[13])/2 *)
		expectedRoot = (-1 + Sqrt[13])/2 // N;  (* ~1.3028 *)
		result = fastRoot[$fND2, {{1., 2.}, {1., 2.}}, Jacobian -> $dfND2, "Return" -> "Value"];
		ListQ[result] && Length[result] == 2 &&
		Abs[result[[1]] - expectedRoot] < 10^-4 &&
		Abs[result[[2]] - expectedRoot] < 10^-4
	],
	True,
	{},
	TestID -> "[fastRoot] nD case finds symmetric root"
]


(* ::Subsection:: *)
(*fastRoot - Error Message Tests*)


(* Test: Bad spec string error *)
TestCreate[
	fastRoot[$f1, "invalid"] === $Failed,
	True,
	{fastRoot::badspec},
	TestID -> "[fastRoot] Bad spec string error"
]

(* Test: Bad bounds nD error *)
TestCreate[
	fastRoot[$fND2, {{2., 1.}, {0.5, 2.}}, Jacobian -> $dfND2] === $Failed,
	True,
	{fastRoot::badbounds},
	TestID -> "[fastRoot] Bad bounds nD error"
]

(* Test: fastRoot fails with Automatic start and no bounds *)
TestCreate[
	fastRoot[#^2 &, Automatic] === $Failed,
	True,
	{fastRoot::noautox0},
	TestID -> "[fastRoot] Error on Automatic start without bounds"
]

(* Test: fastRoot fails on non-numeric function evaluation *)
TestCreate[
	fastRoot[Function[z, Symbol["x"] * z[[1]]], {1.0, 2.0}] === $Failed,
	True,
	{fastRoot::nonnumeric},
	TestID -> "[fastRoot] Error on non-numeric evaluation"
]


(* ::Subsection:: *)
(*normalizeExp - Basic Tests*)


(* Test: Wraps E^a application as Exp *)
TestCreate[
	$normalizeExp[(E^a)[x]],
	Exp[a[x]],
	{},
	TestID -> "[normalizeExp] Wraps E^a application as Exp"
]

(* Test: Normalizes standard E power *)
TestCreate[
	$normalizeExp[E^(a[x] + b[x])],
	Exp[a[x] + b[x]],
	{},
	TestID -> "[normalizeExp] Normalizes standard E power"
]

(* Test: Leaves non-E expressions unchanged *)
TestCreate[
	$normalizeExp[Sin[x]],
	Sin[x],
	{},
	TestID -> "[normalizeExp] Leaves non-E expressions unchanged"
]


(* ::Subsection:: *)
(*normalizeExp - Nested Tests*)


(* Test: Multiple E powers in product *)
TestCreate[
	$normalizeExp[E^a * E^b],
	Exp[a] * Exp[b],
	{},
	TestID -> "[normalizeExp] Multiple E powers in product"
]

(* Test: Multiple E powers in sum *)
TestCreate[
	$normalizeExp[E^a + E^b + E^c],
	Exp[a] + Exp[b] + Exp[c],
	{},
	TestID -> "[normalizeExp] Multiple E powers in sum"
]

(* Test: Doubly nested E power *)
TestCreate[
	$normalizeExp[E^(E^a)],
	Exp[Exp[a]],
	{},
	TestID -> "[normalizeExp] Doubly nested E power"
]

(* Test: Triply nested E power *)
TestCreate[
	$normalizeExp[E^(E^(E^a))],
	Exp[Exp[Exp[a]]],
	{},
	TestID -> "[normalizeExp] Triply nested E power"
]

(* Test: E powers inside trigonometric functions *)
TestCreate[
	$normalizeExp[Sin[E^a] + Cos[E^b]],
	Sin[Exp[a]] + Cos[Exp[b]],
	{},
	TestID -> "[normalizeExp] E powers inside trigonometric"
]

(* Test: E powers inside Log *)
TestCreate[
	$normalizeExp[Log[E^a * E^b]],
	Log[Exp[a] * Exp[b]],
	{},
	TestID -> "[normalizeExp] E powers inside Log"
]


(* ::Subsection:: *)
(*scanAndSolve - Basic Tests*)


(* Test: Finds simple cubic root *)
TestCreate[
	Module[{f, df, result},
		f[z_] := z[[1]]^3 - 8;
		df[z_] := 3*z[[1]]^2;
		result = scanAndSolve[f, df, {1., 3.}, "BracketGrid" -> 16, AccuracyGoal -> 8];
		Length[result] >= 1 && AnyTrue[result, Abs[# - 2] < 0.01 &]
	],
	True,
	{},
	TestID -> "[scanAndSolve] Finds simple cubic root"
]

(* Test: Finds single quadratic root *)
TestCreate[
	Module[{f, df, result},
		f[z_] := z[[1]]^2 - 4;
		df[z_] := 2*z[[1]];
		result = scanAndSolve[f, df, {0.5, 3.}, "BracketGrid" -> 16, AccuracyGoal -> 8];
		Length[result] >= 1 && AnyTrue[result, Abs[# - 2] < 0.01 &]
	],
	True,
	{},
	TestID -> "[scanAndSolve] Finds single quadratic root"
]

(* Test: Finds exponential-shifted root *)
TestCreate[
	Module[{f, df, result},
		f[z_] := Exp[z[[1]]] - 10;
		df[z_] := Exp[z[[1]]];
		result = scanAndSolve[f, df, {1., 3.}, "BracketGrid" -> 16, AccuracyGoal -> 8];
		Length[result] >= 1 && AnyTrue[result, Abs[# - Log[10]] < 0.01 &]
	],
	True,
	{},
	TestID -> "[scanAndSolve] Finds exponential-shifted root"
]

(* Test: Derivative-free mode with sign change *)
TestCreate[
	Module[{f, result},
		f[z_] := z[[1]]^2 - 4;
		result = scanAndSolve[f, {0.5, 3.}, "BracketGrid" -> 16, AccuracyGoal -> 8];
		Length[result] >= 1 && AnyTrue[result, Abs[# - 2] < 0.1 &]
	],
	True,
	{},
	TestID -> "[scanAndSolve] Derivative-free with sign change"
]

(* Test: Multiple roots found with high grid *)
TestCreate[
	Module[{f, df, result},
		f[z_] := Sin[z[[1]]];
		df[z_] := Cos[z[[1]]];
		result = scanAndSolve[f, df, {0.5, 10.}, "BracketGrid" -> 64, AccuracyGoal -> 8];
		Length[result] >= 2
	],
	True,
	{},
	TestID -> "[scanAndSolve] Multiple roots with high grid"
]


(* ::Subsection:: *)
(*scanAndSolve - Options Tests*)


(* Test: No sign change no hits *)
TestCreate[
	Module[{f, df, result},
		f[z_] := (z[[1]] - 2.5)^2 + 10^-6;
		df[z_] := 2*(z[[1]] - 2.5);
		result = scanAndSolve[f, df, {2.0, 3.0}, "BracketGrid" -> 32, AccuracyGoal -> 8, "Tolerance" -> 10^-8];
		Length[result] == 0
	],
	True,
	{},
	TestID -> "[scanAndSolve] No sign change no hits"
]

(* Test: No sign change with grid hit *)
TestCreate[
	Module[{f, df, result},
		f[z_] := (z[[1]] - 2.5)^2;
		df[z_] := 2*(z[[1]] - 2.5);
		result = scanAndSolve[f, df, {2.0, 3.0}, "BracketGrid" -> 32, AccuracyGoal -> 8, "Tolerance" -> 10^-6];
		Length[result] >= 1 && AnyTrue[result, Abs[# - 2.5] < 0.1 &]
	],
	True,
	{},
	TestID -> "[scanAndSolve] No sign change with grid hit"
]

(* Test: Derivative-free no hits no sign change *)
TestCreate[
	Module[{f, result},
		f[z_] := (z[[1]] - 2.5)^2 + 1.0;
		result = scanAndSolve[f, {2.0, 3.0}, "BracketGrid" -> 16, AccuracyGoal -> 8];
		Length[result] == 0
	],
	True,
	{},
	TestID -> "[scanAndSolve] Derivative-free no hits"
]

(* Test: Accuracy goal affects automatic tolerance *)
TestCreate[
	Module[{f, result1, result2},
		f[z_] := (z[[1]] - 2.5)^2 + 10^-7;
		result1 = scanAndSolve[f, {2.0, 3.0}, "BracketGrid" -> 32, AccuracyGoal -> 6];
		result2 = scanAndSolve[f, {2.0, 3.0}, "BracketGrid" -> 32, AccuracyGoal -> 8];
		(* Higher accuracy goal should result in fewer or equal hits *)
		Length[result1] >= Length[result2]
	],
	True,
	{},
	TestID -> "[scanAndSolve] Higher accuracy goal does not increase hits"
]

(* Test: Multiple roots with custom options *)
TestCreate[
	Module[{f, df, result},
		f[z_] := Sin[2*Pi*z[[1]]];
		df[z_] := 2*Pi*Cos[2*Pi*z[[1]]];
		result = scanAndSolve[f, df, {0.0, 2.5}, "BracketGrid" -> 50, "Tolerance" -> 10^-6, AccuracyGoal -> 8];
		Length[result] >= 4 && Length[result] <= 6
	],
	True,
	{},
	TestID -> "[scanAndSolve] Multiple roots custom options"
]


(* ::Subsection:: *)
(*signIdxs - Private Function Tests*)


(* Test: Extracts and sorts sign indices *)
TestCreate[
	$signIdxs[signA[3] + signA[1]^2 + other[2] + signB[5], "signA"],
	{1, 3},
	{},
	TestID -> "[signIdxs] Extracts and sorts indices"
]

(* Test: Returns empty when no matching head *)
TestCreate[
	$signIdxs[1 + other[2] + signB[5], "signA"],
	{},
	{},
	TestID -> "[signIdxs] Returns empty no match"
]


(* ::Subsection:: *)
(*Utility Function Tests*)


(* Test: MissingQ detects Missing NotCompiled *)
TestCreate[
	MissingQ[Missing["NotCompiled"]],
	True,
	{},
	TestID -> "[MissingQ] Detects Missing NotCompiled"
]

(* Test: FailureQ detects Failed *)
TestCreate[
	FailureQ[$Failed],
	True,
	{},
	TestID -> "[FailureQ] Detects Failed"
]

(* Test: MissingQ does not match Failed *)
TestCreate[
	MissingQ[$Failed],
	False,
	{},
	TestID -> "[MissingQ] Does not match Failed"
]

(* Test: FailureQ does not match Missing *)
TestCreate[
	FailureQ[Missing["NotCompiled"]],
	False,
	{},
	TestID -> "[FailureQ] Does not match Missing"
]


(* ::Subsection:: *)
(*buildEqMapFromModel - Functionality Tests*)


(* Test: buildEqMapFromModel symbol exists *)
TestCreate[
	NameQ["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildEqMapFromModel"],
	True,
	{},
	TestID -> "[buildEqMapFromModel] Symbol exists"
]

(* Test: buildEqMapFromModel returns valid Association for test model *)
TestCreate[
	Module[{result, model},
		model = FernandoDuarte`LongRunRisk`Tests`Common`$modBKY;
		result = buildEqMapFromModel[model];
		AssociationQ[result] && KeyExistsQ[result, "A"]
	],
	True,
	{},
	TestID -> "[buildEqMapFromModel] Returns valid Association for BKY model"
]


End[]
EndTestSection[]
