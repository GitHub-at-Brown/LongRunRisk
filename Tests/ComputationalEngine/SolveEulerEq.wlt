(* ::Package:: *)

(* ::Section:: *)
(*Kernel/ComputationalEngine/SolveEulerEq.wl Tests*)


BeginTestSection["Kernel/ComputationalEngine/SolveEulerEq.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];


(* ::Subsection:: *)
(*Load Test Helpers*)


Get @ FileNameJoin[{DirectoryName[$TestFileName, 2], "TestHelpers.wl"}];
Get @ FileNameJoin[{DirectoryName[$TestFileName, 1], "CETestHelpers.wl"}];


(* ::Subsection:: *)
(*Test Setup*)


(* Pre-compute results once per model to avoid redundant expensive computations *)
$bkyResult = updateCoeffs[
	$modBKY,
	"UpdatePd" -> True,
	"UpdateBonds" -> True,
	"MaxMaturity" -> 5,
	"FindRootOptions" -> {"MaxIterations" -> 100}
];

$desResult = updateCoeffs[
	$modDES,
	"FindRootOptions" -> {"MaxIterations" -> 100}
];


(* ::Subsection:: *)
(*Test Helpers*)


(* coeffsQ: Validates coefficient structure (flat list of rules OR Association) *)
coeffsQ[solIn_, coeffName_, numStateVars_, numAssets_ : 0, bond_ : 0] := Module[
	{sol, keys, vals},
	sol = If[AssociationQ[solIn], Normal[solIn], solIn];
	If[!MatchQ[sol, {__Rule}], Return[False]];
	keys = Keys[sol];
	vals = Values[sol];
	AllTrue[
		{
			If[numAssets == 0,
				Sort[Cases[keys, coeffName[i_Integer] :> i]] === Range[0, numStateVars],
				Sort[Tuples[{Range[numAssets] - bond, Range[0, numStateVars]}]] ===
					Sort[Cases[keys, coeffName[i_Integer][j_Integer] :> {i, j}]]
			],
			AllTrue[Cases[keys, var_[_Integer][_Integer] :> var], MatchQ[coeffName]],
			AllTrue[Cases[keys, var_[_Integer][_Integer] :> Context[var]], # === Context[coeffName] &],
			If[bond == 1,
				AllTrue[vals, NumberQ[#] || MatchQ[#, _Missing] &],
				AllTrue[vals, NumberQ]
			]
		},
		TrueQ
	]
];


(* firstASol: Extract first A solution from hierarchical structure using FirstCase *)
firstASol[res_] := FirstCase[res, a_Association /; KeyExistsQ[a, "A"] :> a, $Failed];


(* wcRulesFirst: Extract wealth-consumption rules from first solution *)
wcRulesFirst[res_] := Module[{a = firstASol[res]},
	If[a === $Failed, $Failed, Normal[a["A"]]]
];


(* pdRulesFirstBundle: Extract price-dividend rules for all stocks *)
pdRulesFirstBundle[res_, numStocks_] := Module[{a = firstASol[res], stocks},
	If[a === $Failed, Return[$Failed]];
	stocks = a["Stocks"];
	If[!AssociationQ[stocks] || stocks === <||>, Return[{}]];
	Flatten@Table[
		If[KeyExistsQ[stocks, j] && MatchQ[stocks[j], {__}],
			Normal[stocks[j][[1, "B"]]],
			{}
		],
		{j, 1, numStocks}
	]
];


(* Model-specific coefficient validators *)
(* Note: Actual coefficient symbols are A, B, R for wc, pd, bond respectively *)
coeffsQWcRules[model_, solRules_] := With[
	{numStateVars = Length[model["stateVars"][t]]},
	coeffsQ[solRules, $A, numStateVars]
];

coeffsQPdRules[model_, solRules_] := With[
	{
		numStateVars = Length[model["stateVars"][t]],
		numStocks = model["numStocks"]
	},
	coeffsQ[
		solRules,
		$B,
		numStateVars,
		numStocks
	]
];

coeffsQBondRules[model_, solRules_, maxMaturity_] := With[
	{numStateVars = Length[model["stateVars"][t]]},
	coeffsQ[
		solRules,
		$R,
		numStateVars,
		maxMaturity + 1,
		1
	]
];

coeffsQNomBondRules[model_, solRules_, maxMaturity_] := With[
	{numStateVars = Length[model["stateVars"][t]]},
	coeffsQ[
		solRules,
		$P,
		numStateVars,
		maxMaturity + 1,
		1
	]
];


(* ::Subsection:: *)
(*updateCoeffs - Basic Tests*)


(* Test: updateCoeffs returns non-empty list for BKY model *)
TestCreate[
	MatchQ[$bkyResult, {__}],
	True,
	{},
	TestID -> "[updateCoeffs] BKY returns non-empty list",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* Test: updateCoeffs returns non-empty list for DES model *)
TestCreate[
	MatchQ[$desResult, {__}],
	True,
	{},
	TestID -> "[updateCoeffs] DES returns non-empty list",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* Test: Result contains expected hierarchical keys *)
TestCreate[
	Module[{firstSol},
		firstSol = firstASol[$bkyResult];
		firstSol =!= $Failed && AllTrue[{"A", "IntervalA", "SignsA", "Stocks"}, KeyExistsQ[firstSol, #] &]
	],
	True,
	{},
	TestID -> "[updateCoeffs] Result has expected keys",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*updateCoeffs - Wealth-Consumption Coefficient Tests*)


(* Test: WC coefficients have valid structure for BKY *)
TestCreate[
	Module[{wcRules},
		wcRules = wcRulesFirst[$bkyResult];
		wcRules =!= $Failed && coeffsQWcRules[$modBKY, wcRules]
	],
	True,
	{},
	TestID -> "[updateCoeffs] BKY wc coefficients have valid structure",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* Test: WC coefficients have valid structure for DES *)
TestCreate[
	Module[{wcRules},
		wcRules = wcRulesFirst[$desResult];
		wcRules =!= $Failed && coeffsQWcRules[$modDES, wcRules]
	],
	True,
	{},
	TestID -> "[updateCoeffs] DES wc coefficients have valid structure",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*updateCoeffs - UpdatePd Option Tests*)


(* Test: UpdatePd=False returns only wealth-consumption coefficients *)
TestCreate[
	Module[{result, wcRules},
		result = updateCoeffs[
			$modBKY,
			"UpdatePd" -> False,
			"FindRootOptions" -> {"MaxIterations" -> 100}
		];
		wcRules = wcRulesFirst[result];
		wcRules =!= $Failed && coeffsQWcRules[$modBKY, wcRules]
	],
	True,
	{},
	TestID -> "[updateCoeffs] UpdatePd False returns only wc coefficients",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* Test: UpdatePd=True returns both WC and PD coefficients *)
TestCreate[
	Module[{wcRules, pdRules, numStocks},
		numStocks = $modBKY["numStocks"];
		wcRules = wcRulesFirst[$bkyResult];
		pdRules = pdRulesFirstBundle[$bkyResult, numStocks];
		AllTrue[
			{
				wcRules =!= $Failed,
				coeffsQWcRules[$modBKY, wcRules],
				pdRules =!= $Failed
			},
			TrueQ
		]
	],
	True,
	{},
	TestID -> "[updateCoeffs] UpdatePd True returns both wc and pd coefficients",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* Test: PD coefficients have expected structure when UpdatePd=True *)
TestCreate[
	Module[{pdRules, numStocks},
		numStocks = $modBKY["numStocks"];
		pdRules = pdRulesFirstBundle[$bkyResult, numStocks];
		pdRules =!= $Failed && MatchQ[pdRules, {__}] && coeffsQPdRules[$modBKY, pdRules]
	],
	True,
	{},
	TestID -> "[updateCoeffs] UpdatePd True pd coefficients have valid structure",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*updateCoeffs - Option Tests*)


(* Test: PrintResidualsNorm option is recognized *)
TestCreate[
	MemberQ[Keys[Options[updateCoeffs]], "PrintResidualsNorm"],
	True,
	{},
	TestID -> "[updateCoeffs] PrintResidualsNorm option is recognized",
	MetaInformation -> <|"Category" -> "extended"|>
]

(* Test: CheckResiduals option is recognized *)
TestCreate[
	MemberQ[Keys[Options[updateCoeffs]], "CheckResiduals"],
	True,
	{},
	TestID -> "[updateCoeffs] CheckResiduals option is recognized",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*loadModelKernels Tests*)


(* Test: loadModelKernels returns Association for valid model *)
TestCreate[
	Module[{kernels},
		kernels = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels["BKY"];
		AssociationQ[kernels]
	],
	True,
	{},
	TestID -> "[loadModelKernels] BKY returns association",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* Test: loadModelKernels returns Association with expected keys *)
TestCreate[
	Module[{kernels},
		kernels = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels["BKY"];
		AssociationQ[kernels] && KeyExistsQ[kernels, "kernels"]
	],
	True,
	{},
	TestID -> "[loadModelKernels] BKY has kernels key",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* Test: loadModelKernels fails gracefully for invalid model *)
TestCreate[
	Module[{kernels},
		kernels = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels["INVALID_MODEL_NAME"];
		kernels === $Failed
	],
	True,
	{FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels::nofile},
	TestID -> "[loadModelKernels] Invalid model returns Failed",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*Bond Coefficient Tests*)


(* Test: Real bond coefficients have expected structure *)
TestCreate[
	Module[{firstA, bondRules, maxMaturity},
		maxMaturity = 5;
		firstA = firstASol[$bkyResult];
		bondRules = Normal[firstA["Bond"]];
		MatchQ[bondRules, {__Rule}] && coeffsQBondRules[$modBKY, bondRules, maxMaturity]
	],
	True,
	{},
	TestID -> "[updateCoeffs] BKY bond coefficients have valid structure",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* Test: Nominal bond coefficients have expected structure *)
TestCreate[
	Module[{firstA, nomBondRules, maxMaturity},
		maxMaturity = 5;
		firstA = firstASol[$bkyResult];
		nomBondRules = Normal[firstA["NomBond"]];
		MatchQ[nomBondRules, {__Rule}] && coeffsQNomBondRules[$modBKY, nomBondRules, maxMaturity]
	],
	True,
	{},
	TestID -> "[updateCoeffs] BKY nominal bond coefficients have valid structure",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* Test: Bond coefficients have correct maturity indices *)
TestCreate[
	Module[{firstA, bondKeys, maxIdx, maxMaturity},
		maxMaturity = 5;
		firstA = firstASol[$bkyResult];
		bondKeys = Keys[firstA["Bond"]];
		maxIdx = Max[Cases[bondKeys, _[i_][_] :> i]];
		maxIdx === maxMaturity
	],
	True,
	{},
	TestID -> "[updateCoeffs] BKY bond max maturity is correct",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*flattenCoeffs Tests*)


(* Test: flattenCoeffs extracts all coefficient rules *)
TestCreate[
	Module[{flattened},
		flattened = flattenCoeffs[$bkyResult];
		VectorQ[flattened, MatchQ[_Rule]]
	],
	True,
	{},
	TestID -> "[flattenCoeffs] All rules returns rule list",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* Test: flattenCoeffs with index extracts single solution *)
TestCreate[
	Module[{flattened},
		flattened = flattenCoeffs[$bkyResult, 1];
		VectorQ[flattened, MatchQ[_Rule]]
	],
	True,
	{},
	TestID -> "[flattenCoeffs] Single solution returns rule list",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*flattenCoeffsBundles Tests*)


(* Test: flattenCoeffsBundles generates complete bundles *)
TestCreate[
	Module[{bundles},
		bundles = flattenCoeffsBundles[$bkyResult];
		VectorQ[bundles, VectorQ[#, MatchQ[_Rule]] &]
	],
	True,
	{},
	TestID -> "[flattenCoeffsBundles] All bundles returns list of rule lists",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* Test: flattenCoeffsBundles with index extracts bundles for single A solution *)
TestCreate[
	Module[{bundles},
		bundles = flattenCoeffsBundles[$bkyResult, 1];
		VectorQ[bundles, VectorQ[#, MatchQ[_Rule]] &]
	],
	True,
	{},
	TestID -> "[flattenCoeffsBundles] Single solution returns list of rule lists",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*addCoeffsSolutionN Tests*)


(* Test: addCoeffsSolutionN computes all coefficient types *)
TestCreate[
	Module[{result},
		result = addCoeffsSolutionN[$modBKY, 5];
		MatchQ[result, {__}] && AllTrue[result, AssociationQ[#] && KeyExistsQ[#, "Bond"] &]
	],
	True,
	{},
	TestID -> "[addCoeffsSolutionN] BKY computes all coefficient types",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* Test: addCoeffsSolutionN default maturity is 12 *)
TestCreate[
	Module[{result, bondKeys, maxIdx},
		result = addCoeffsSolutionN[$modBKY];
		(* Check that bond coefficients go up to maturity 12 *)
		bondKeys = Keys[First[result]["Bond"]];
		maxIdx = Max[Cases[bondKeys, _[i_][_] :> i]];
		maxIdx === 12
	],
	True,
	{},
	TestID -> "[addCoeffsSolutionN] Default maturity is 12",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* Test: addCoeffsSolutionN respects explicit maturity argument *)
TestCreate[
	Module[{result, bondKeys, maxIdx},
		result = addCoeffsSolutionN[$modBKY, 3];
		bondKeys = Keys[First[result]["Bond"]];
		maxIdx = Max[Cases[bondKeys, _[i_][_] :> i]];
		maxIdx === 3
	],
	True,
	{},
	TestID -> "[addCoeffsSolutionN] Explicit maturity respects argument",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*updateCoeffs - InitialGuess Option Tests*)


(* Test: updateCoeffs accepts different Ewc initialGuess lengths *)
TestCreate[
	Module[{res1, res2},
		res1 = Quiet@updateCoeffs[
			$modBKY,
			"initialGuess" -> <|"Ewc" -> {1, 8}|>,
			"FindRootOptions" -> {"MaxIterations" -> 100}
		];
		res2 = Quiet@updateCoeffs[
			$modBKY,
			"initialGuess" -> <|"Ewc" -> {4, 1, 8}|>,
			"FindRootOptions" -> {"MaxIterations" -> 100}
		];
		MatchQ[res1, {__}] && MatchQ[res2, {__}]
	],
	True,
	{},
	TestID -> "[updateCoeffs] Accepts different Ewc initialGuess lengths",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*updateCoeffs - Parameter Sensitivity Tests*)


(* Test: Parameter changes produce different coefficients *)
TestCreate[
	Module[{res1, res2, newParams},
		res1 = Quiet@updateCoeffs[$modBKY, "FindRootOptions" -> {"MaxIterations" -> 100}];
		newParams = {FernandoDuarte`LongRunRisk`Model`Parameters`psi ->
			(0.1 + (FernandoDuarte`LongRunRisk`Model`Parameters`psi /. $modBKY["params"]))};
		res2 = Quiet@updateCoeffs[$modBKY, {}, newParams, {}, "FindRootOptions" -> {"MaxIterations" -> 100}];
		res1 =!= res2
	],
	True,
	{},
	TestID -> "[updateCoeffs] Parameter changes produce different coefficients",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*updateCoeffs - Regression Tests*)


(* Test: updateCoeffs completes without cfne warnings *)
TestCreate[
	Module[{cfneOccurred = False, result},
		result = Quiet[
			Check[
				updateCoeffs[$modBKY, "UpdatePd" -> True, "FindRootOptions" -> {"MaxIterations" -> 100}],
				cfneOccurred = True,
				CompiledFunction::cfne
			]
		];
		!cfneOccurred && MatchQ[result, {__}]
	],
	True,
	{},
	TestID -> "[updateCoeffs] BKY completes without cfne warnings",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* ::Subsection:: *)
(*Options Inheritance Tests*)


(* Test: updateCoeffs inherits options from updateCoeffsSol *)
TestCreate[
	SubsetQ[
		Keys[Options[updateCoeffs]],
		Keys[Options[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol]]
	],
	True,
	{},
	TestID -> "[updateCoeffs] Options inherit from updateCoeffsSol",
	MetaInformation -> <|"Category" -> "extended"|>
]


(* Test: updateCoeffs inherits options from checks *)
TestCreate[
	SubsetQ[
		Keys[Options[updateCoeffs]],
		Keys[Options[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks]]
	],
	True,
	{},
	TestID -> "[updateCoeffs] Options inherit from Checks",
	MetaInformation -> <|"Category" -> "extended"|>
]


End[]
EndTestSection[]
