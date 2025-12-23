BeginTestSection["ProcessModels"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`";
	Needs @ "FernandoDuarte`LongRunRisk`Model`ProcessModels`";
	True
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251215-LKA9OO@@Tests/ProcessModels.wlt:4,1-13,2"
]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
	True
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251215-ZA5LB5@@Tests/ProcessModels.wlt:16,1-25,2"
]


VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest = False;
	True
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251215-ECBBD0@@Tests/ProcessModels.wlt:28,1-37,2"
]


VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Catalog`"], MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`ProcessModels`"]}]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251215-MOPMJQ@@Tests/ProcessModels.wlt:40,1-48,2"
]


VerificationTest[
	Apply[And,
		{
			!SameQ[Names @ "*processModels", {}],
			!SameQ[Names @ "*models", {}]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251215-Q4OQ1B@@Tests/ProcessModels.wlt:51,1-64,2"
]


EndTestSection[]
