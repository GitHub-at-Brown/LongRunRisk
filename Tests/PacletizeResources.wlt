BeginTestSection["PacletizeResources"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`"
	,
	Null
	,
	{}
	,
	TestID->"PacletizeResources_20230407-764AHY"
]


VerificationTest[
	SameQ[PacletFind @ "MaTeX*", {}]
	,
	False
	,
	{}
	,
	TestID->"PacletizeResources_20230407-26RT9X"
]


VerificationTest[
	Context @ MaTeX`MaTeX
	,
	"MaTeX`"
	,
	{}
	,
	TestID->"PacletizeResources_20230407-UPBQC6"
]


VerificationTest[
	MemberQ[$ContextPath, "MaTeX`"]
	,
	True
	,
	{}
	,
	TestID->"PacletizeResources_20230407-KRAD3W"
]


VerificationTest[
	MemberQ[$Packages, "MaTeX`"]
	,
	True
	,
	{}
	,
	TestID->"PacletizeResources_20230407-QNF25T"
]


VerificationTest[
	SameQ[pacletMaTeX @ "Version", "1.7.9"]
	,
	True
	,
	{}
	,
	TestID->"PacletizeResources_20230407-NC98WI"
]


EndTestSection[]
