BeginTestSection["TimeAggregation"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`"]

FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`longTest = False;
Off[General::stop];
	Needs @ "FernandoDuarte`LongRunRisk`Tools`TimeAggregation`";

VerificationTest[
	Apply[And,
		Simplify[
			{
				Equal[FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1],
					Times[1 / 3,
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
							Plus[
								2 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
								(3 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2]) + (2 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1]) + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
							]
						]
					]
				],
				Equal[
					ReplaceAll[
						ReplaceAll[
							ReplaceAll[
								FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 12, "numPeriods" -> 1] /. Plus -> List,
								Times -> List
							],
							FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`x__, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t}] -> (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`x)
						],
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t] -> 0
					],
					{
						{1 / 12, 22},
						{1 / 6, 21},
						{1 / 4, 20},
						{1 / 3, 19},
						{5 / 12, 18},
						{1 / 2, 17},
						{7 / 12, 16},
						{2 / 3, 15},
						{3 / 4, 14},
						{5 / 6, 13},
						{11 / 12, 12},
						11,
						{11 / 12, 10},
						{5 / 6, 9},
						{3 / 4, 8},
						{2 / 3, 7},
						{7 / 12, 6},
						{1 / 2, 5},
						{5 / 12, 4},
						{1 / 3, 3},
						{1 / 4, 2},
						{1 / 6, 1},
						{1 / 12, 0}
					}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20251223-4E6B0H@@Tests/ModelProcessing/TimeAggregation_test4.wlt:8,1-68,2"
]

End[]
EndTestSection[]
