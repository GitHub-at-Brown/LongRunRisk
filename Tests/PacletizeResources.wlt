BeginTestSection["PacletizeResources"] 
Begin["PacletizeResources`"]
VerificationTest[
	{Needs @ "FernandoDuarte`LongRunRisk`";}
	,
	{Null}
	,
	{}
	,
	TestID->"PacletizeResources_20230430-TSBLY6"
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
	TestID->"PacletizeResources_20230430-8Q9ENI"
] 
End[]
EndTestSection[]
