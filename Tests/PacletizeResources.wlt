BeginTestSection["PacletizeResources"] 
Begin["FernandoDuarte`LongRunRisk`Tests`PacletizeResources`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`";
	True
	,
	True
	,
	{}
	,
	TestID->"PacletizeResources_20231129-X7A7EP@@Tests/PacletizeResources.wlt:3,1-12,2"
]
VerificationTest[
	Apply[And,
		{
			!SameQ[PacletFind @ "MaTeX", {}],
			!SameQ[PacletFind @ "PacletizedResourceFunctions", {}],
			MemberQ[$Packages, "MaTeX`"],
			SameQ[Part[PacletFind @ "MaTeX", 1]["Version"], "1.7.9"],
			!SameQ[PacletFind @ Names @ "*NeedsDefinitions", {}],
			!SameQ[PacletFind @ Names @ "*SetSymbolsContext", {}]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"PacletizeResources_20231129-1C4E6R@@Tests/PacletizeResources.wlt:13,1-30,2"
] 
End[]
EndTestSection[]
