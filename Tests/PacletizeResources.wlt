BeginTestSection["PacletizeResources"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`"
	,
	Null
	,
	{}
	,
	TestID->"PacletizeResources_20230414-5DF78T"
]


VerificationTest[
	SameQ[PacletFind @ "MaTeX", {}]
	,
	False
	,
	{}
	,
	TestID->"PacletizeResources_20230414-6ZM6ZG"
]


VerificationTest[
	SameQ[PacletFind @ "PacletizedResourceFunctions", {}]
	,
	False
	,
	{}
	,
	TestID->"PacletizeResources_20230414-T243UX"
]


VerificationTest[
	Context @ MaTeX`MaTeX
	,
	"MaTeX`"
	,
	{}
	,
	TestID->"PacletizeResources_20230414-QZILYD"
]


VerificationTest[
	MemberQ[$Packages, "MaTeX`"]
	,
	True
	,
	{}
	,
	TestID->"PacletizeResources_20230414-ULTRAS"
]


VerificationTest[
	SameQ[Part[PacletFind @ "MaTeX", 1]["Version"], "1.7.9"]
	,
	True
	,
	{}
	,
	TestID->"PacletizeResources_20230414-DVI7RK"
]


VerificationTest[
	SameQ[PacletFind @ Names @ "*NeedsDefinitions", {}]
	,
	False
	,
	{}
	,
	TestID->"PacletizeResources_20230414-9QDOFO"
]


VerificationTest[
	SameQ[PacletFind @ Names @ "*SetSymbolsContext", {}]
	,
	False
	,
	{}
	,
	TestID->"PacletizeResources_20230414-G6STRE"
]


EndTestSection[]
