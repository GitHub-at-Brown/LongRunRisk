BeginTestSection["TimeAggregation"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`"]

FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`longTest = False;
Off[General::stop];
	Needs @ "FernandoDuarte`LongRunRisk`Tools`TimeAggregation`";

VerificationTest[
	Apply[And,
		Simplify[
			{
				FreeQ[
					FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc,
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[
							{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im},
							If[Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, 12], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h12, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`hnot12]
						]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h12
				],
				FreeQ[
					FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc,
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 12, "numPeriods" -> 1, "v0" -> Function[
							{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im},
							If[Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, 12], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h12, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`hnot12]
						]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`hnot12
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20251223-6IK7G0@@Tests/TimeAggregation.wlt:289,1-320,2"
]

End[]
EndTestSection[]
