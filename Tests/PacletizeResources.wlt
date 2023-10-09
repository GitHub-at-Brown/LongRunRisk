BeginTestSection["PacletizeResources"] 
Begin["PacletizeResources`"]
VerificationTest[
	{
		Needs @ "FernandoDuarte`LongRunRisk`";
		True
	}
	,
	{True}
	,
	{}
	,
	TestID->"PacletizeResources_20231008-U7OMIY"
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
	TestID->"PacletizeResources_20231008-FOD064"
] 
End[]
EndTestSection[]
