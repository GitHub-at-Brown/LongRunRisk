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
	TestID->"PacletizeResources_20251030-9EMLIL@@Tests/PacletizeResources.wlt:3,1-12,2"
]
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
	TestID->"PacletizeResources_20251030-VTQFZH@@Tests/PacletizeResources.wlt:13,1-32,2"
] 
VerificationTest[
  $ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ]; True,
  True,
  TestID -> "Untitled-18@@Tests/PacletizeResources.wlt:33,1-41,8"
]
End[]
EndTestSection[]
