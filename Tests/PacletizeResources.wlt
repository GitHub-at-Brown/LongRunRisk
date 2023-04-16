BeginTestSection["PacletizeResources"]


VerificationTest[
	{Needs @ "FernandoDuarte`LongRunRisk`"}
	,
	{Null}
	,
	{}
	,
	TestID->"PacletizeResources_20230415-DG3WKS"
]


VerificationTest[
	SameQ[PacletFind @ "MaTeX", {}]
	,
	False
	,
	{}
	,
	TestID->"PacletizeResources_20230415-3STXGP"
]


VerificationTest[
	SameQ[PacletFind @ "PacletizedResourceFunctions", {}]
	,
	False
	,
	{}
	,
	TestID->"PacletizeResources_20230415-WSHNSS"
]


VerificationTest[
	MemberQ[$Packages, "MaTeX`"]
	,
	True
	,
	{}
	,
	TestID->"PacletizeResources_20230415-5U5MIK"
]


VerificationTest[
	SameQ[Part[PacletFind @ "MaTeX", 1]["Version"], "1.7.9"]
	,
	True
	,
	{}
	,
	TestID->"PacletizeResources_20230415-1DSQHK"
]


VerificationTest[
	SameQ[PacletFind @ Names @ "*NeedsDefinitions", {}]
	,
	False
	,
	{}
	,
	TestID->"PacletizeResources_20230415-ZQ15HW"
]


VerificationTest[
	SameQ[PacletFind @ Names @ "*SetSymbolsContext", {}]
	,
	False
	,
	{}
	,
	TestID->"PacletizeResources_20230415-YG813A"
]


EndTestSection[]
