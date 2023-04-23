BeginTestSection["PacletizeResources"] 
Begin["PacletizeResources`"]
VerificationTest[
	{Needs @ "FernandoDuarte`LongRunRisk`"}
	,
	{Null}
	,
	{}
	,
	TestID->"PacletizeResources_20230423-YRJP88"
]
VerificationTest[
	Apply[And,
		{
			MemberQ[$ContextPath, "MaTeX`"],
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
	TestID->"PacletizeResources_20230423-ZJY76W"
] 
End[]
EndTestSection[]
