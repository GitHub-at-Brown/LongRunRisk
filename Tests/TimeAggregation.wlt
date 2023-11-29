BeginTestSection["TimeAggregation"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`"]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`longTest = False;
	True
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-G1MBIO@@Tests/TimeAggregation.wlt:3,1-12,2"
]
VerificationTest[
	Off[General::stop];
	Needs @ "FernandoDuarte`LongRunRisk`Tools`TimeAggregation`";
	True
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-M9LZA0@@Tests/TimeAggregation.wlt:13,1-23,2"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"];
	True
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-HHW7EU@@Tests/TimeAggregation.wlt:24,1-33,2"
]
VerificationTest[
	!SameQ[Names @ "*growth", {}]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-7OOBD9@@Tests/TimeAggregation.wlt:34,1-42,2"
]
VerificationTest[
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t],
			Equal[FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 1, "numPeriods" -> 1],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-XXMQ9G@@Tests/TimeAggregation.wlt:43,1-58,2"
]
VerificationTest[
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1],
				Times[1 / 3,
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
						Plus[2 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
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
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-CM8V2T@@Tests/TimeAggregation.wlt:59,1-116,2"
]
VerificationTest[
	Apply[And,
		{
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
						Plus[0.6661665418542368 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
								(0.6671665414792372 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1]) + 0.33383345814576315 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
						Plus[0.6661665418542368 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
								(0.6671665414792372 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1]) + 0.33383345814576315 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
						Plus[0.6661665418542368 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
								(0.6671665414792372 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1]) + 0.33383345814576315 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
						Plus[0.6661665418542368 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
								(0.6671665414792372 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1]) + 0.33383345814576315 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
						Plus[0.6661665418542368 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
								(0.6671665414792372 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1]) + 0.33383345814576315 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
						Plus[0.6661665418542368 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
								(0.6671665414792372 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1]) + 0.33383345814576315 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
						Plus[0.6661665418542368 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
								(0.6671665414792372 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1]) + 0.33383345814576315 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
							]
						]
					]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-I62G8B@@Tests/TimeAggregation.wlt:117,1-233,2"
]
VerificationTest[
	Apply[And,
		{
			Equal[
				Simplify[
					FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc,
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
					]
				],
				Times[1 / (1 + (E ^ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t) + E ^ (2 * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t)),
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
						Plus[(1 + E ^ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t) * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
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
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-9M2TFJ@@Tests/TimeAggregation.wlt:234,1-271,2"
]
VerificationTest[
	Apply[And,
		{
			FreeQ[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[
						{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im},
						If[Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, 12], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h12, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`hnot12]
					]
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h12
			],
			FreeQ[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 12, "numPeriods" -> 1, "v0" -> Function[
						{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im},
						If[Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, 12], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h12, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`hnot12]
					]
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`hnot12
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-S8RYU8@@Tests/TimeAggregation.wlt:272,1-301,2"
]
VerificationTest[
	Apply[And,
		{
			SameQ[0,
				FullSimplify[
					Coefficient[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[
									{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im},
									-((FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h + 1) ^ -1)
								]
							],
							FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX
						],
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX, 0
					]
				]
			],
			SameQ[0,
				FullSimplify[
					Coefficient[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 3, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h ^ 2]
							],
							FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX
						],
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX, 0
					]
				]
			],
			SameQ[0,
				FullSimplify[
					Coefficient[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im]
							],
							FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX
						],
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX, 0
					]
				]
			],
			SameQ[0,
				FullSimplify[
					Coefficient[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 3, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v]
							],
							FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX
						],
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX, 0
					]
				]
			],
			SameQ[0,
				FullSimplify[
					Coefficient[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im]
							],
							FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[__, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`ddX
						],
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`ddX, 0
					]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-LUP5QZ@@Tests/TimeAggregation.wlt:302,1-381,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`arbitraryFun1 = Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v}, Sqrt @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h];
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`arbitraryFun2 = Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v},
		If[Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd], Sqrt @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, Cos @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h]
	];
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`arbitraryFun3 = Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v}, -FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h];
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`arbitraryFun4 = Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v},
		(Sqrt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h] * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k ^ 2
	];
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`arbitraryFun5 = Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v},
		If[Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd],
			Sqrt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h] * Sqrt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t],
			Exp[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t] * Cos[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h]
		]
	];
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`arbitraryFun6 = Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v}, (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h) * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k];
	Apply[And,
		{
			N[
				ReplaceAll[
					SameQ[0,
						FullSimplify[
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
										FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im]]
									],
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX
								],
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX, 0
							]
						]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`arbitraryFun1
				]
			],
			N[
				ReplaceAll[
					SameQ[0,
						FullSimplify[
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
										FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im]]
									],
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX
								],
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX, 0
							]
						]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`arbitraryFun2
				]
			],
			N[
				ReplaceAll[
					SameQ[0,
						FullSimplify[
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
										FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im]]
									],
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX
								],
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX, 0
							]
						]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`arbitraryFun3
				]
			],
			N[
				ReplaceAll[
					SameQ[0,
						FullSimplify[
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
										FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im]]
									],
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX
								],
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX, 0
							]
						]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`arbitraryFun4
				]
			],
			N[
				ReplaceAll[
					SameQ[0,
						FullSimplify[
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
										FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im]]
									],
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX
								],
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX, 0
							]
						]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`arbitraryFun5
				]
			],
			N[
				ReplaceAll[
					SameQ[0,
						FullSimplify[
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
										FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im]]
									],
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX
								],
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX, 0
							]
						]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`arbitraryFun6
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-CDS42C@@Tests/TimeAggregation.wlt:382,1-516,2"
]
VerificationTest[
	Apply[And,
		{
			Not[
				N[
					SameQ[0,
						Coefficient[
							ReplaceAll[
								FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 3, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j]
								],
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX
							],
							FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX, 0
						]
					]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-LCIZMC@@Tests/TimeAggregation.wlt:517,1-543,2"
]
VerificationTest[
	Apply[And,
		{
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j}, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j]
				],
				Subtract[
					Plus[
						Divide[
							Subtract[
								Subtract[
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3] + (E ^ 4) * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
									7
								],
								3 * E ^ 4
							],
							1 + (E ^ 4) + E ^ 7
						],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1],
								Plus[
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t,
									Plus[
										Divide[
											((1 - E * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1],
											1 + 2 * E
										],
										Log[2 + 1 / E]
									]
								]
							]
						]
					],
					Log[1 + (1 / E ^ 7) + 1 / E ^ 3]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-CCD4RB@@Tests/TimeAggregation.wlt:544,1-590,2"
]
VerificationTest[
	Apply[And,
		{
			Not[
				FreeQ[
					FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc,
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[
							{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im},
							If[SameQ[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`Edc, 0]
						]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`Edc
				]
			],
			FreeQ[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`pi,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[
						{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im},
						If[SameQ[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`Edc, 0]
					]
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`Edc
			],
			Not[
				FreeQ[
					FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd,
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "TimeAggregation" -> 12, "numPeriods" -> 1, "v0" -> Function[
							{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im},
							If[SameQ[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`Edd, 0]
						]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`Edd
				]
			],
			FreeQ[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 12, "numPeriods" -> 1, "v0" -> Function[
						{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im},
						If[SameQ[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`Edd, 0]
					]
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`Edd
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-291J4P@@Tests/TimeAggregation.wlt:591,1-642,2"
]
VerificationTest[
	Apply[And,
		{
			Equal[
				ReplaceAll[
					FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc,
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, Evaluate[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`uncondE[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]]]]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`uncondE[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]] -> 0
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-NUOMZV@@Tests/TimeAggregation.wlt:643,1-663,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 1;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Simplify[
				SameQ[0,
					Coefficient[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]]
							],
							FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX
						],
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX, 0
					]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-2W4E5Z@@Tests/TimeAggregation.wlt:664,1-690,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 2;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`rulej = Table[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[(FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k) + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
		{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, 0, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h - 2}
	];
	Apply[And,
		{
			FullSimplify[
				SameQ[0,
					Coefficient[
						ReplaceAll[
							ReplaceAll[
								FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j]]
								],
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`rulej
							],
							FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX
						],
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX, 0
					]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-OHBRR7@@Tests/TimeAggregation.wlt:691,1-723,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`rulej = Table[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[(FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k) + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
		{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, 0, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h - 2}
	];
	Apply[And,
		{
			FullSimplify[
				SameQ[0,
					Coefficient[
						ReplaceAll[
							ReplaceAll[
								FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j]]
								],
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`rulej
							],
							FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX
						],
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX, 0
					]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-39VUEC@@Tests/TimeAggregation.wlt:724,1-756,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 4;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`rulej = Table[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[(FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k) + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
		{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, 0, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h - 2}
	];
	Apply[And,
		{
			FullSimplify[
				SameQ[0,
					Coefficient[
						ReplaceAll[
							ReplaceAll[
								FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j]]
								],
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`rulej
							],
							FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX
						],
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX, 0
					]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-6WZ6SC@@Tests/TimeAggregation.wlt:757,1-789,2"
]
VerificationTest[
	Apply[And,
		{
			SameQ[
				Cases[
					Expand[
						FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 0]
					],
					Times[Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`coef_], Power[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__], Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p_]]] :> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p
				],
				{}
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 1]
						],
						Times[Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`coef_], Power[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__], Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p_]]] :> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p
					]
				],
				1
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 2]
						],
						Times[Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`coef_], Power[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__], Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p_]]] :> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p
					]
				],
				2
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 3]
						],
						Times[Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`coef_], Power[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__], Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p_]]] :> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p
					]
				],
				3
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-FCVFCC@@Tests/TimeAggregation.wlt:790,1-843,2"
]
VerificationTest[
	Apply[And,
		{
			SameQ[
				Cases[
					Expand[
						FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 0]
					],
					Times[Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`coef_], Power[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[__, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i], Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p_]]] :> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p
				],
				{}
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 1]
						],
						Times[Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`coef_], Power[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[__, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i], Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p_]]] :> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p
					]
				],
				1
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 2]
						],
						Times[Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`coef_], Power[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[__, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i], Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p_]]] :> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p
					]
				],
				2
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 3]
						],
						Times[Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`coef_], Power[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[__, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i], Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p_]]] :> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p
					]
				],
				3
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-5M56LY@@Tests/TimeAggregation.wlt:844,1-897,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`f = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`f;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`s = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`s;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`timeSeriesVector;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`gt;
	True
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-MDPBSV@@Tests/TimeAggregation.wlt:898,1-911,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 2;
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, {"TimeAggregation" -> 3, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}],
				Subtract[
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
								Plus[
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
									Plus[
										FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1],
										Plus[
											FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t,
											Log[
												Plus[
													1,
													(E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1])) + E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t])
												]
											]
										]
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 7]),
								E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6])
							]
						]
					]
				]
			],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
				Subtract[
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
								Plus[
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
									Plus[
										FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1],
										Plus[
											FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t,
											Log[
												Plus[
													1,
													(E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1])) + E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t])
												]
											]
										]
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 7]),
								E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6])
							]
						]
					]
				]
			],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, {"TimeAggregation" -> 3, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}],
				Subtract[
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
								Plus[
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
									Plus[
										FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
										Plus[
											FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
											Log[
												Plus[
													1,
													Plus[
														E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]),
														E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i])
													]
												]
											]
										]
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								Power[
									E,
									(-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 7, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]
								],
								E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i])
							]
						]
					]
				]
			],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
				Subtract[
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
								Plus[
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
									Plus[
										FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
										Plus[
											FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
											Log[
												Plus[
													1,
													Plus[
														E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]),
														E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i])
													]
												]
											]
										]
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								Power[
									E,
									(-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 7, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]
								],
								E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i])
							]
						]
					]
				]
			],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 1, {"TimeAggregation" -> 3, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}],
				Subtract[
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5, 1],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4, 1],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, 1],
								Plus[
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, 1],
									Plus[
										FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, 1],
										Plus[
											FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 1],
											Log[
												Plus[
													1,
													Plus[
														E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 1]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, 1]),
														E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 1])
													]
												]
											]
										]
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								Power[
									E,
									(-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6, 1]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 7, 1]
								],
								E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6, 1])
							]
						]
					]
				]
			],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 2, "TimeAggregation" -> 3, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
				Subtract[
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5, 2],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4, 2],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, 2],
								Plus[
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, 2],
									Plus[
										FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, 2],
										Plus[
											FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 2],
											Log[
												Plus[
													1,
													Plus[
														E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 2]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, 2]),
														E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 2])
													]
												]
											]
										]
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								Power[
									E,
									(-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6, 2]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 7, 2]
								],
								E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6, 2])
							]
						]
					]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-2GH09Z@@Tests/TimeAggregation.wlt:912,1-1154,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 2;
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "Variable" -> "Stock"], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "Variable" -> "Stock"],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
			],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, {"numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}, "Variable" -> "Stock"],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]
			],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "Variable" -> "Stock"], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 1, {"TimeAggregation" -> 3}, "Variable" -> "Stock"],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 1]
			],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 2, "Variable" -> "Stock"], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 2]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-RZPIF0@@Tests/TimeAggregation.wlt:1155,1-1181,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 2;
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t,
					{"TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k},
					"Variable" -> "Stock"
				],
				Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5],
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "Variable" -> "Stock"],
				Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5],
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, {"TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k},
					"Variable" -> "Stock"
				],
				Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
							FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "Variable" -> "Stock"
				],
				Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
							FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 1, {"TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k},
					"Variable" -> "Stock"
				],
				Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5, 1],
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4, 1],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, 1],
							FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 1]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 2, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "Variable" -> "Stock"
				],
				Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5, 2],
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4, 2],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, 2],
							FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, 2] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, 2] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 2]
						]
					]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-QYPWYJ@@Tests/TimeAggregation.wlt:1182,1-1266,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h],
				Subtract[
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t,
								Log[
									Plus[
										1,
										(E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1])) + E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t])
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4]),
								E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3])
							]
						]
					]
				]
			],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k], 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, {"TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k
				],
				Subtract[
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t,
								Log[
									Plus[
										1,
										(E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1])) + E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t])
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4]),
								E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3])
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k
				],
				Subtract[
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t,
								Log[
									Plus[
										1,
										(E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1])) + E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t])
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4]),
								E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3])
							]
						]
					]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-5V9ZSS@@Tests/TimeAggregation.wlt:1267,1-1364,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h], FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t}, 3]],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[Part[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h], 1;;-2],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3]},
					3
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[Part[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k], 1;;-2], 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{}, 1, 1]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					Part[
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, {"TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}],
						1;;-2
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3]},
					3, 1
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					Part[
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
						1;;-2
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3]},
					3, 1
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-ASL132@@Tests/TimeAggregation.wlt:1365,1-1415,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "Variable" -> "Flow"
				],
				Subtract[
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t,
								Log[
									Plus[
										1,
										(E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1])) + E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t])
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4]),
								E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3])
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
					1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "Variable" -> "Flow"
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, {"TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "Variable" -> "Flow"
				],
				Subtract[
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t,
								Log[
									Plus[
										1,
										(E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1])) + E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t])
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4]),
								E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3])
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "Variable" -> "Flow"
				],
				Subtract[
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t,
								Log[
									Plus[
										1,
										(E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1])) + E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t])
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4]),
								E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3])
							]
						]
					]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-8K5AIS@@Tests/TimeAggregation.wlt:1416,1-1521,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "Variable" -> "Stock"
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
					1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "Variable" -> "Stock"
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, {"TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "Variable" -> "Stock"
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "Variable" -> "Stock"
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-SQ902S@@Tests/TimeAggregation.wlt:1522,1-1561,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t], 1, "Variable" -> "Stock"], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					Part[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h],
						Span[1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "Variable" -> "Stock"
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
					1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "Variable" -> "Stock"
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					Part[
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, {"TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}],
						Span[1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "Variable" -> "Stock"
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					Part[
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
						Span[1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "Variable" -> "Stock"
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-8FAPMG@@Tests/TimeAggregation.wlt:1562,1-1611,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t], "Variable" -> "Stock"],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t}, "Variable" -> "Stock"]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					Part[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h],
						Span[1, (FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k) + 1]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "Variable" -> "Stock"
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3]},
					3, "Variable" -> "Stock"
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					Part[
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, {"TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}],
						Span[1, (FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k) + 1]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "Variable" -> "Stock"
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3]},
					3, 1, "Variable" -> "Stock"
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					Part[
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
						Span[1, (FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k) + 1]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "Variable" -> "Stock"
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3]},
					3, 1, "Variable" -> "Stock"
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-ZMJM7O@@Tests/TimeAggregation.wlt:1612,1-1663,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i], 1], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h],
				Subtract[
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
								Log[
									Plus[
										1,
										Plus[
											E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]),
											E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i])
										]
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								Power[
									E,
									(-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]
								],
								E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i])
							]
						]
					]
				]
			],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k], 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, {"TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k
				],
				Subtract[
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
								Log[
									Plus[
										1,
										Plus[
											E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]),
											E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i])
										]
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								Power[
									E,
									(-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]
								],
								E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i])
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k
				],
				Subtract[
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
								Log[
									Plus[
										1,
										Plus[
											E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]),
											E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i])
										]
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								Power[
									E,
									(-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]
								],
								E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i])
							]
						]
					]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-QC3NYH@@Tests/TimeAggregation.wlt:1664,1-1782,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h],
				Subtract[
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m],
								Log[
									Plus[
										1,
										Plus[
											E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m]),
											E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m])
										]
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								Power[
									E,
									(-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m]
								],
								E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m])
							]
						]
					]
				]
			],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k], 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m, {"TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k
				],
				Subtract[
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m],
								Log[
									Plus[
										1,
										Plus[
											E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m]),
											E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m])
										]
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								Power[
									E,
									(-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m]
								],
								E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m])
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k
				],
				Subtract[
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m],
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m],
								Log[
									Plus[
										1,
										Plus[
											E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m]),
											E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m])
										]
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								Power[
									E,
									(-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m]
								],
								E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`m])
							]
						]
					]
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-84PETM@@Tests/TimeAggregation.wlt:1783,1-1901,2"
]
VerificationTest[
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t], {FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t}],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3],
				{
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4]
				}
			],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "numPeriods" -> 6],
				{
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5]
				}
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, {"TimeAggregation" -> 12, "numPeriods" -> 3}],
				{
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 7],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 8],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 9],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 10],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 11],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 12],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 13],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 14],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 15],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 16],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 17],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 18],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 19],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 20],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 21],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 22],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 23],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 24],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 25],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 26],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 27],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 28],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 29],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 30],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 31],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 32],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 33],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 34],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 35],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 36],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 37],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 38],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 39],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 40],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 41],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 42],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 43],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 44],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 45],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 46]
				}
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 12, "numPeriods" -> 3],
				{
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 7],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 8],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 9],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 10],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 11],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 12],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 13],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 14],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 15],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 16],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 17],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 18],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 19],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 20],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 21],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 22],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 23],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 24],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 25],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 26],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 27],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 28],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 29],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 30],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 31],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 32],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 33],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 34],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 35],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 36],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 37],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 38],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 39],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 40],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 41],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 42],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 43],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 44],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 45],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 46]
				}
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-2RT0Y8@@Tests/TimeAggregation.wlt:1902,1-2037,2"
]
VerificationTest[
	On[General::stop];
	True
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231129-QNA59G@@Tests/TimeAggregation.wlt:2038,1-2047,2"
] 
End[]
EndTestSection[]
