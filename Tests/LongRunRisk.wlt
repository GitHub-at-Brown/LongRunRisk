BeginTestSection["LongRunRisk"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`";
	,
	Null
	,
	{}
	,
	TestID->"LongRunRisk_20230415-SW94O0"
]


VerificationTest[
	SameQ[PacletFind @ "MaTeX", {}]
	,
	False
	,
	{}
	,
	TestID->"LongRunRisk_20230415-S8U3WJ"
]


VerificationTest[
	Equal[FernandoDuarte`LongRunRisk`Models["BY"]["shortname"], "BY"]
	,
	True
	,
	{}
	,
	TestID->"LongRunRisk_20230415-78GGAF"
]


VerificationTest[
	Quiet[
		!SameQ[Information[PacletizedResourceFunctions`SetSymbolsContext, "Definitions"], None]
	]
	,
	True
	,
	{}
	,
	TestID->"LongRunRisk_20230415-SZOV9L"
]


VerificationTest[
	!SameQ[Information[PacletizedResourceFunctions`NeedsDefinitions, "Definitions"], None]
	,
	True
	,
	{}
	,
	TestID->"LongRunRisk_20230415-4A6JI1"
]


VerificationTest[
	{
		FernandoDuarte`LongRunRisk`Growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1],
		ReplaceAll[
			ReplaceAll[
				ReplaceAll[
					FernandoDuarte`LongRunRisk`Growth[dc, t, "TimeAggregation" -> 12, "numPeriods" -> 1] /. Plus -> List,
					Times -> List
				],
				dc[{x__, t}] -> (-x)
			],
			dc[t] -> 0
		]
	}
	,
	{
		FernandoDuarte`LongRunRisk`Growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1],
		FernandoDuarte`LongRunRisk`Growth[dc, t, "TimeAggregation" -> 12, "numPeriods" -> 1]
	}
	,
	{}
	,
	TestID->"LongRunRisk_20230415-W5NTNF"
]


EndTestSection[]
