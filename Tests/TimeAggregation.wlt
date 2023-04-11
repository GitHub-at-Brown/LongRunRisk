BeginTestSection["TimeAggregation"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`"
	,
	Null
	,
	{}
	,
	TestID->"TimeAggregation_20230411-ESAG9X"
]


VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`"]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20230411-ZMQMCL"
]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`TimeAggregation`"
	,
	Null
	,
	{}
	,
	TestID->"TimeAggregation_20230411-009P6N"
]


VerificationTest[
	!SameQ[Names @ "*Growth", {}]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20230411-X8R026"
]


EndTestSection[]
