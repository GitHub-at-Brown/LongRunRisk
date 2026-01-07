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


Scan[Get @ FileNameJoin[{DirectoryName[$TestFileName, #], "Common.wl"}] &, {2, 1}];


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
	TestID -> "updateCoeffs-BKY-ReturnsNonEmptyList"
]


(* Test: updateCoeffs returns non-empty list for DES model *)
TestCreate[
	MatchQ[$desResult, {__}],
	True,
	{},
	TestID -> "updateCoeffs-DES-ReturnsNonEmptyList"
]


(* Test: Result contains expected hierarchical keys *)
TestCreate[
	Module[{firstSol},
		firstSol = firstASol[$bkyResult];
		firstSol =!= $Failed && AllTrue[{"A", "IntervalA", "SignsA", "Stocks"}, KeyExistsQ[firstSol, #] &]
	],
	True,
	{},
	TestID -> "updateCoeffs-Result-HasExpectedKeys"
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
	TestID -> "updateCoeffs-BKY-WcCoeffsValidStructure"
]


(* Test: WC coefficients have valid structure for DES *)
TestCreate[
	Module[{wcRules},
		wcRules = wcRulesFirst[$desResult];
		wcRules =!= $Failed && coeffsQWcRules[$modDES, wcRules]
	],
	True,
	{},
	TestID -> "updateCoeffs-DES-WcCoeffsValidStructure"
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
	TestID -> "updateCoeffs-UpdatePdFalse-ReturnsWcCoeffs"
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
	TestID -> "updateCoeffs-UpdatePdTrue-ReturnsBothWcAndPd"
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
	TestID -> "updateCoeffs-UpdatePdTrue-PdCoeffsValidStructure"
]


(* ::Subsection:: *)
(*updateCoeffs - Initial Guess Tests*)


(* Test: Different initial guess formats work correctly *)
TestCreate[
	Module[{result, wcRules},
		(* Test with interval format *)
		result = updateCoeffs[
			$modBKY,
			"initialGuess" -> <|"Ewc" -> {1, 8}|>,
			"FindRootOptions" -> {"MaxIterations" -> 100}
		];
		wcRules = wcRulesFirst[result];
		wcRules =!= $Failed && coeffsQWcRules[$modBKY, wcRules]
	],
	True,
	{},
	TestID -> "updateCoeffs-IntervalInitialGuess-Works"
]


(* Test: Point plus interval initial guess format works *)
TestCreate[
	Module[{result, wcRules},
		(* Test with point plus interval format *)
		result = updateCoeffs[
			$modBKY,
			"initialGuess" -> <|"Ewc" -> {4, 1, 8}|>,
			"FindRootOptions" -> {"MaxIterations" -> 100}
		];
		wcRules = wcRulesFirst[result];
		wcRules =!= $Failed && coeffsQWcRules[$modBKY, wcRules]
	],
	True,
	{},
	TestID -> "updateCoeffs-PointIntervalInitialGuess-Works"
]


(* ::Subsection:: *)
(*updateCoeffs - Option Tests*)


(* Test: PrintResidualsNorm option is recognized *)
TestCreate[
	MemberQ[Keys[Options[updateCoeffs]], "PrintResidualsNorm"],
	True,
	{},
	TestID -> "updateCoeffs-PrintResidualsNormOption-IsRecognized"
]

(* Test: CheckResiduals option is recognized *)
TestCreate[
	MemberQ[Keys[Options[updateCoeffs]], "CheckResiduals"],
	True,
	{},
	TestID -> "updateCoeffs-CheckResidualsOption-IsRecognized"
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
	TestID -> "loadModelKernels-BKY-ReturnsAssociation"
]


(* Test: loadModelKernels returns Association with expected keys *)
TestCreate[
	Module[{kernels},
		kernels = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels["BKY"];
		AssociationQ[kernels] && KeyExistsQ[kernels, "kernels"]
	],
	True,
	{},
	TestID -> "loadModelKernels-BKY-HasKernelsKey"
]


(* Test: loadModelKernels fails gracefully for invalid model *)
TestCreate[
	Module[{kernels},
		kernels = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels["INVALID_MODEL_NAME"];
		kernels === $Failed
	],
	True,
	{FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels::nofile},
	TestID -> "loadModelKernels-InvalidModel-ReturnsFailed"
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
	TestID -> "updateCoeffs-BKY-BondCoeffsValidStructure"
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
	TestID -> "updateCoeffs-BKY-NomBondCoeffsValidStructure"
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
	TestID -> "updateCoeffs-BKY-BondMaxMaturityCorrect"
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
	TestID -> "flattenCoeffs-AllRules-ReturnsRuleList"
]


(* Test: flattenCoeffs with index extracts single solution *)
TestCreate[
	Module[{flattened},
		flattened = flattenCoeffs[$bkyResult, 1];
		VectorQ[flattened, MatchQ[_Rule]]
	],
	True,
	{},
	TestID -> "flattenCoeffs-SingleSolution-ReturnsRuleList"
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
	TestID -> "flattenCoeffsBundles-AllBundles-ReturnsListOfRuleLists"
]


(* Test: flattenCoeffsBundles with index extracts bundles for single A solution *)
TestCreate[
	Module[{bundles},
		bundles = flattenCoeffsBundles[$bkyResult, 1];
		VectorQ[bundles, VectorQ[#, MatchQ[_Rule]] &]
	],
	True,
	{},
	TestID -> "flattenCoeffsBundles-SingleASolution-ReturnsListOfRuleLists"
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
	TestID -> "addCoeffsSolutionN-BKY-ComputesAllCoeffTypes"
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
	TestID -> "addCoeffsSolutionN-DefaultMaturity-Is12"
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
	TestID -> "addCoeffsSolutionN-ExplicitMaturity-RespectsArgument"
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
	TestID -> "updateCoeffs-Options-InheritsFromUpdateCoeffsSol"
]


(* Test: updateCoeffs inherits options from checks *)
TestCreate[
	SubsetQ[
		Keys[Options[updateCoeffs]],
		Keys[Options[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks]]
	],
	True,
	{},
	TestID -> "updateCoeffs-Options-InheritsFromChecks"
]


End[]
EndTestSection[]
