BeginTestSection["EndogenousEq"]
Begin["FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";
Needs @ "FernandoDuarte`LongRunRisk`Model`Parameters`";
Needs @ "FernandoDuarte`LongRunRisk`";

VerificationTest[
	(* Test that parameters appearing in endogenous variables are in Parameters context *)
	(* Use model's endogenousEq directly to avoid symbol resolution ambiguity *)
	Module[{testModel, endoEqs, paramSymbols},
		(* Get a test model *)
		testModel = FernandoDuarte`LongRunRisk`Models["BY"];
		endoEqs = testModel["endogenousEq"];

		(* Extract all parameter symbols that appear in endogenous equations *)
		paramSymbols = Cases[
			Values[endoEqs],
			FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var_Symbol /;
				MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var]],
			Infinity
		];

		(* Check all are in Parameters` context *)
		Apply[And, Map[SameQ[Context[#], "FernandoDuarte`LongRunRisk`Model`Parameters`"]&, paramSymbols]]
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20251223-077TRW@@Tests/EndogenousEq.wlt:72,1-92,2"
]

End[]
EndTestSection[]
