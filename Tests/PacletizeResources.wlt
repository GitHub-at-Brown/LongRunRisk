BeginTestSection["PacletizeResources"]


VerificationTest[
	SameQ[PacletFind @ "MaTeX*", {}]
	,
	False
	,
	{}
	,
	TestID->"PacletizeResources_20230404-T57LFK"
]


VerificationTest[
	MemberQ[$ContextPath, "MaTeX`"]
	,
	True
	,
	{}
	,
	TestID->"PacletizeResources_20230404-3KGR8U"
]


VerificationTest[
	MemberQ[$Packages, "MaTeX`"]
	,
	True
	,
	{}
	,
	TestID->"PacletizeResources_20230404-3B4DKH"
]


EndTestSection[]
