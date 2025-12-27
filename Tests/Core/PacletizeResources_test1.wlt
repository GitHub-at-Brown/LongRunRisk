BeginTestSection["PacletizeResources"] 
Begin["FernandoDuarte`LongRunRisk`Tests`PacletizeResources`"]

Needs @ "FernandoDuarte`LongRunRisk`";

VerificationTest[
	Apply[And,
		Simplify[
			{
				!SameQ[PacletFind @ "MaTeX", {}],
				!SameQ[PacletFind @ "PacletizedResourceFunctions", {}],
				MemberQ[$Packages, "MaTeX`"],
				SameQ[Part[PacletFind @ "MaTeX", 1]["Version"], "1.7.10"],
				!SameQ[PacletFind @ Names @ "*NeedsDefinitions", {}],
				!SameQ[PacletFind @ Names @ "*SetSymbolsContext", {}]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"PacletizeResources_20251223-96HVAR@@Tests/Core/PacletizeResources_test1.wlt:6,1-25,2"
]

End[]
EndTestSection[]
