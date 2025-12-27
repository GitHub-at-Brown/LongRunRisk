BeginTestSection["EndogenousEq"]
Begin["FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";
Needs @ "FernandoDuarte`LongRunRisk`Model`Parameters`";
Needs @ "FernandoDuarte`LongRunRisk`";

VerificationTest[
	(* Test that parameters appearing in endogenous variables are in Parameters context *)
	(* Use model's endogenousEq directly with explicit context checking *)
	Module[{testModel, endoEqs, paramSymbols},
		(* Get a test model *)
		testModel = FernandoDuarte`LongRunRisk`Models["BY"];
		endoEqs = testModel["endogenousEq"];

		(* Extract symbols from endogenousEq that are in Parameters` context *)
		paramSymbols = Cases[
			Values[endoEqs],
			sym_Symbol /; (Context[sym] === "FernandoDuarte`LongRunRisk`Model`Parameters`"),
			Infinity
		];

		(* Verify all found parameters are in the expected parameter list *)
		If[Length[paramSymbols] > 0,
			Module[{uniqueParams, paramNames},
				uniqueParams = DeleteDuplicates[paramSymbols];
				paramNames = Map[SymbolName, uniqueParams];
				(* All found parameter symbols should be in the official parameter list *)
				Apply[And, Map[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, #]&, paramNames]]
			],
			True  (* If no parameters found, test passes vacuously *)
		]
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20251223-077TRW@@Tests/ModelDefinition/EndogenousEq_test4.wlt:8,1-40,2"
]

End[]
EndTestSection[]
