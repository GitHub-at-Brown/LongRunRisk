BeginTestSection["TimeAggregation"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`"]

FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`longTest = False;
Off[General::stop];
	Needs @ "FernandoDuarte`LongRunRisk`Tools`TimeAggregation`";

VerificationTest[
	Apply[And,
		Simplify[
			{
				Equal[
					Simplify[
						FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc,
							FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
						]
					],
					Times[1 / (1 + (E ^ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t) + E ^ (2 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t)),
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
							Plus[
								(1 + E ^ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t) * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
								Plus[
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
									Plus[
										(E ^ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t) * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
										Plus[
											(E ^ (2 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t)) * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
											Plus[
												(E ^ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t) * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1],
												((E ^ (2 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t)) * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1]) + (E ^ (2 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t)) * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
											]
										]
									]
								]
							]
						]
					]
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20251223-3UKC3U@@Tests/TimeAggregation.wlt:248,1-288,2"
]

End[]
EndTestSection[]
