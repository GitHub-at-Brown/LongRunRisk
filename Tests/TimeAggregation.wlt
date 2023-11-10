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
	TestID->"TimeAggregation_20231109-6NGCCG"
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
	TestID->"TimeAggregation_20231109-C1QPXM"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"];
	True
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231109-97JHYG"
]
VerificationTest[
	!SameQ[Names @ "*growth", {}]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231109-O3QK0C"
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
	TestID->"TimeAggregation_20231109-3V0G7E"
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
	TestID->"TimeAggregation_20231109-CLYIM9"
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
	TestID->"TimeAggregation_20231109-Y0C5EG"
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
	TestID->"TimeAggregation_20231109-CUR9A4"
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
	TestID->"TimeAggregation_20231109-9ZA22Q"
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
	TestID->"TimeAggregation_20231109-HKOD0R"
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
	TestID->"TimeAggregation_20231109-XNVWEP"
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
	TestID->"TimeAggregation_20231109-43HRS8"
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
	TestID->"TimeAggregation_20231109-2DECZK"
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
	TestID->"TimeAggregation_20231109-HA92ZX"
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
	TestID->"TimeAggregation_20231109-AK3FMB"
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
	TestID->"TimeAggregation_20231109-YMMIKQ"
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
	TestID->"TimeAggregation_20231109-5AD91H"
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
	TestID->"TimeAggregation_20231109-AG6MKG"
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
	TestID->"TimeAggregation_20231109-NV99SS"
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
	TestID->"TimeAggregation_20231109-EIHR1J"
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
	TestID->"TimeAggregation_20231109-ZDI9Y7"
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
	TestID->"TimeAggregation_20231109-HVMIXP"
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
	TestID->"TimeAggregation_20231109-X105FQ"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 2;
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "flowVariable" -> False], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "flowVariable" -> False],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
			],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, {"numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}, "flowVariable" -> False],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]
			],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "flowVariable" -> False], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 1, {"TimeAggregation" -> 3}, "flowVariable" -> False],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 1]
			],
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 2, "flowVariable" -> False], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 2]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231109-VCGJ7K"
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
					"flowVariable" -> False
				],
				Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5],
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "flowVariable" -> False
				],
				Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5],
					Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd,
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, {"TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k},
					"flowVariable" -> False
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
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "flowVariable" -> False
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
					"flowVariable" -> False
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
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 2, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "flowVariable" -> False
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
	TestID->"TimeAggregation_20231109-4WEOQQ"
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
	TestID->"TimeAggregation_20231109-4WL4CG"
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
	TestID->"TimeAggregation_20231109-YI9IKG"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "flowVariable" -> True
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
					1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "flowVariable" -> True
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, {"TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "flowVariable" -> True
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
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "flowVariable" -> True
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
	TestID->"TimeAggregation_20231109-6WD4GU"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "flowVariable" -> False
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
					1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "flowVariable" -> False
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, {"TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "flowVariable" -> False
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "flowVariable" -> False
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
	TestID->"TimeAggregation_20231109-C0MIIE"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t], 1, "flowVariable" -> False],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					Part[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h],
						Span[1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "flowVariable" -> False
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
					1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "flowVariable" -> False
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					Part[
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, {"TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}],
						Span[1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "flowVariable" -> False
				],
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					Part[
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
						Span[1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "flowVariable" -> False
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
	TestID->"TimeAggregation_20231109-ONUICQ"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t], "flowVariable" -> False],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t}, "flowVariable" -> False]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					Part[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h],
						Span[1, (FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k) + 1]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "flowVariable" -> False
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3]},
					3, "flowVariable" -> False
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					Part[
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, {"TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}],
						Span[1, (FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k) + 1]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "flowVariable" -> False
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3]},
					3, 1, "flowVariable" -> False
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g[
					Part[
						FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
						Span[1, (FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k) + 1]
					],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, "flowVariable" -> False
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3]},
					3, 1, "flowVariable" -> False
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231109-FCNMT9"
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
	TestID->"TimeAggregation_20231109-818W33"
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
	TestID->"TimeAggregation_20231109-2BU9GW"
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
	TestID->"TimeAggregation_20231109-1VY3YY"
]
VerificationTest[
	On[General::stop];
	True
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231109-MNKB7G"
] 
End[]
EndTestSection[]
