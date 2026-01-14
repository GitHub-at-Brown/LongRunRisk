(* ::Package:: *)

(* ::Section:: *)
(*Kernel/Tools/OptionsValidationRules.wl Tests*)


BeginTestSection["Kernel/Tools/OptionsValidationRules.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`OptionsValidationRules`"]

Needs["FernandoDuarte`LongRunRisk`Tools`OptionsValidationRules`"];


(* ::Subsection:: *)
(*Load Test Helpers*)


Get @ FileNameJoin[{DirectoryName[$TestFileName, 2], "TestHelpers.wl"}];


(* ::Subsection:: *)
(*OptionsValidation Availability and Setup*)


(* Check if OptionsValidation paclet is available without triggering messages *)
$optionsValidationAvailable = Quiet @ Check[Length[PacletFind["OptionsValidation"]] > 0, False];

(* Load all required contexts once at setup time *)
If[$optionsValidationAvailable,
	Needs["OptionsValidation`"];
	Needs["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];
	Needs["FernandoDuarte`LongRunRisk`Tools`Common`"];
	Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
	Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
	Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"];
	InstallOptionsValidationRules[];
];

(* Sentinel value for skipped tests when paclet not available *)
$skipped = "Skipped";

(* Helper to run validation - returns $skipped when paclet not available *)
validate[func_, opts_] := If[$optionsValidationAvailable,
	OptionsValidation`ValidateOptions[func, opts],
	$skipped
];

(* Helper to get expected result based on availability *)
expected[val_] := If[$optionsValidationAvailable, val, $skipped];


(* ::Subsection:: *)
(*InstallOptionsValidationRules - Availability Tests*)


(* Test: InstallOptionsValidationRules symbol exists in expected context *)
TestCreate[
	NameQ["FernandoDuarte`LongRunRisk`Tools`OptionsValidationRules`InstallOptionsValidationRules"],
	True,
	{},
	TestID -> "[InstallOptionsValidationRules] Symbol exists in OptionsValidationRules context"
]


(* ::Subsection:: *)
(*InstallOptionsValidationRules - Execution Tests*)


(* Test: InstallOptionsValidationRules returns True when OptionsValidation is available *)
TestCreate[
	If[$optionsValidationAvailable,
		InstallOptionsValidationRules[],
		True  (* Skip - passes trivially when paclet not available *)
	],
	True,
	{},
	TestID -> "[InstallOptionsValidationRules] Returns True when OptionsValidation available"
]


(* ::Subsection:: *)
(*buildModels Validation Tests*)


(* Test: buildModels with invalid FromScratch value is rejected *)
TestCreate[
	validate[
		FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels,
		"FromScratch" -> "invalid"
	],
	expected[False],
	{},
	TestID -> "[buildModels] Invalid FromScratch value rejected"
]

(* Test: buildModels with valid FromScratch value is accepted *)
TestCreate[
	validate[
		FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels,
		"FromScratch" -> True
	],
	expected[True],
	{},
	TestID -> "[buildModels] Valid FromScratch value accepted"
]


(* ::Subsection:: *)
(*print Validation Tests*)


(* Test: print with invalid Verbose value is rejected *)
TestCreate[
	validate[
		FernandoDuarte`LongRunRisk`Tools`Common`print,
		"Verbose" -> "invalid"
	],
	expected[False],
	{},
	TestID -> "[print] Invalid Verbose value rejected"
]

(* Test: print with valid Verbose value is accepted *)
TestCreate[
	validate[
		FernandoDuarte`LongRunRisk`Tools`Common`print,
		"Verbose" -> True
	],
	expected[True],
	{},
	TestID -> "[print] Valid Verbose value accepted"
]

(* Test: print with valid CI Verbose value is accepted *)
TestCreate[
	validate[
		FernandoDuarte`LongRunRisk`Tools`Common`print,
		"Verbose" -> "CI"
	],
	expected[True],
	{},
	TestID -> "[print] Valid CI Verbose value accepted"
]


(* ::Subsection:: *)
(*buildKernel Validation Tests*)


(* Test: buildKernel with invalid CompileMode value is rejected *)
TestCreate[
	validate[
		FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel,
		"CompileMode" -> "InvalidMode"
	],
	expected[False],
	{},
	TestID -> "[buildKernel] Invalid CompileMode value rejected"
]

(* Test: buildKernel with valid CompileMode value is accepted *)
TestCreate[
	validate[
		FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel,
		"CompileMode" -> "Both"
	],
	expected[True],
	{},
	TestID -> "[buildKernel] Valid CompileMode value accepted"
]

(* Test: buildKernel with valid JacobianOnly CompileMode is accepted *)
TestCreate[
	validate[
		FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel,
		"CompileMode" -> "JacobianOnly"
	],
	expected[True],
	{},
	TestID -> "[buildKernel] Valid JacobianOnly CompileMode accepted"
]


(* ::Subsection:: *)
(*paramQuadSolve Validation Tests*)


(* Test: paramQuadSolve with invalid ReturnOption value is rejected *)
TestCreate[
	validate[
		FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve,
		"ReturnOption" -> "InvalidReturn"
	],
	expected[False],
	{},
	TestID -> "[paramQuadSolve] Invalid ReturnOption value rejected"
]

(* Test: paramQuadSolve with valid ReturnOption value is accepted *)
TestCreate[
	validate[
		FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve,
		"ReturnOption" -> "All"
	],
	expected[True],
	{},
	TestID -> "[paramQuadSolve] Valid ReturnOption value accepted"
]

(* Test: paramQuadSolve with valid Solution ReturnOption is accepted *)
TestCreate[
	validate[
		FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve,
		"ReturnOption" -> "Solution"
	],
	expected[True],
	{},
	TestID -> "[paramQuadSolve] Valid Solution ReturnOption accepted"
]


(* ::Subsection:: *)
(*solveCoeffsSystem Validation Tests*)


(* Test: solveCoeffsSystem with invalid PdEquations value is rejected *)
TestCreate[
	validate[
		FernandoDuarte`LongRunRisk`Model`ProcessModels`solveCoeffsSystem,
		"PdEquations" -> "InvalidValue"
	],
	expected[False],
	{},
	TestID -> "[solveCoeffsSystem] Invalid PdEquations value rejected"
]

(* Test: solveCoeffsSystem with valid PdEquations value is accepted *)
TestCreate[
	validate[
		FernandoDuarte`LongRunRisk`Model`ProcessModels`solveCoeffsSystem,
		"PdEquations" -> "Both"
	],
	expected[True],
	{},
	TestID -> "[solveCoeffsSystem] Valid PdEquations value accepted"
]

(* Test: solveCoeffsSystem with valid B PdEquations is accepted *)
TestCreate[
	validate[
		FernandoDuarte`LongRunRisk`Model`ProcessModels`solveCoeffsSystem,
		"PdEquations" -> "B"
	],
	expected[True],
	{},
	TestID -> "[solveCoeffsSystem] Valid B PdEquations accepted"
]


End[]
EndTestSection[]
