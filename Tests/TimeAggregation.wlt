BeginTestSection["TimeAggregation"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`"
	,
	Null
	,
	{}
	,
	TestID->"TimeAggregation_20230414-56CZ60"
]


VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`"]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20230414-EMS273"
]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`TimeAggregation`"
	,
	Null
	,
	{}
	,
	TestID->"TimeAggregation_20230414-ZI0STI"
]


VerificationTest[
	!SameQ[Names @ "*Growth", {}]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20230414-5OPIXY"
]


VerificationTest[
	{
		FernandoDuarte`LongRunRisk`TimeAggregation`Growth[dc, t],
		FernandoDuarte`LongRunRisk`TimeAggregation`Growth[dc, t, "TimeAggregation" -> 1, "numPeriods" -> 1]
	}
	,
	{dc @ t, dc @ t}
	,
	{}
	,
	TestID->"TimeAggregation_20230414-J01UM3"
]


VerificationTest[
	{
		FernandoDuarte`LongRunRisk`TimeAggregation`Growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1],
		ReplaceAll[
			ReplaceAll[
				ReplaceAll[
					FernandoDuarte`LongRunRisk`TimeAggregation`Growth[dc, t, "TimeAggregation" -> 12, "numPeriods" -> 1] /. Plus -> List,
					Times -> List
				],
				dc[{x__, t}] -> (-x)
			],
			dc[t] -> 0
		]
	}
	,
	{
		Times[Rational[1, 3],
			Plus[dc[t - 4],
				Plus[2 * dc[t - 3],
					(3 * dc[t - 2]) + (2 * dc[t - 1]) + dc[t]
				]
			]
		],
		{
			{Rational[1, 12], 22},
			{Rational[1, 6], 21},
			{Rational[1, 4], 20},
			{Rational[1, 3], 19},
			{Rational[5, 12], 18},
			{Rational[1, 2], 17},
			{Rational[7, 12], 16},
			{Rational[2, 3], 15},
			{Rational[3, 4], 14},
			{Rational[5, 6], 13},
			{Rational[11, 12], 12},
			11,
			{Rational[11, 12], 10},
			{Rational[5, 6], 9},
			{Rational[3, 4], 8},
			{Rational[2, 3], 7},
			{Rational[7, 12], 6},
			{Rational[1, 2], 5},
			{Rational[5, 12], 4},
			{Rational[1, 3], 3},
			{Rational[1, 4], 2},
			{Rational[1, 6], 1},
			{Rational[1, 12], 0}
		}
	}
	,
	{}
	,
	TestID->"TimeAggregation_20230414-UVGKQI"
]


VerificationTest[
	{
		FernandoDuarte`LongRunRisk`TimeAggregation`Growth[sx, tau, "TimeAggregation" -> 3, "numPeriods" -> 1],
		FernandoDuarte`LongRunRisk`TimeAggregation`Growth[pibar, t - h, "TimeAggregation" -> 3, "numPeriods" -> 1]
	}
	,
	{
		Times[Rational[1, 3],
			Plus[sx[tau - 4],
				Plus[2 * sx[tau - 3],
					(3 * sx[tau - 2]) + (2 * sx[tau - 1]) + sx[tau]
				]
			]
		],
		Times[Rational[1, 3],
			Plus[pibar[(t - 4) - h],
				Plus[2 * pibar[(t - 3) - h],
					Plus[3 * pibar[(t - 2) - h],
						(2 * pibar[(t - 1) - h]) + pibar[t - h]
					]
				]
			]
		]
	}
	,
	{}
	,
	TestID->"TimeAggregation_20230414-6GW8OI"
]


VerificationTest[
	{
		ReplaceAll[
			ReplaceAll[
				ReplaceAll[
					ReplaceAll[
						FernandoDuarte`LongRunRisk`TimeAggregation`Growth[dc,
							t, "TimeAggregation" -> 12, "numPeriods" -> 1, "v0" -> Function[{t, j, h, k, v, im}, 0.0015]
						],
						Plus -> List
					],
					Times -> List
				],
				dc[{x__, t}] -> (-x)
			],
			dc[t] -> 0
		]
	}
	,
	{
		{
			0.,
			{0.08264755348988516, 22},
			{0.1654191713350095, 21},
			{0.24831503977154812, 20},
			{0.33133534531523995, 19},
			{0.41448027476180754, 18},
			{0.4977500151873771, 17},
			{0.5811447539488999, 16},
			{0.664664678684573, 15},
			{0.7483099773142627, 14},
			{0.8320808380399262, 13},
			{0.9159774493460349, 12},
			11,
			{0.9173524465101148, 10},
			{0.8345808286649905, 9},
			{0.7516849602284519, 8},
			{0.6686646546847601, 7},
			{0.5855197252381925, 6},
			{0.502249984812623, 5},
			{0.41885524605110014, 4},
			{0.335335321315427, 3},
			{0.25169002268573726, 2},
			{0.16791916196007384, 1},
			{0.08402255065396513, 0}
		}
	}
	,
	{}
	,
	TestID->"TimeAggregation_20230414-H07DZ5"
]


VerificationTest[
	Simplify[
		FernandoDuarte`LongRunRisk`TimeAggregation`Growth[dc,
			t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[
				{t, j, h, k, v, im},
				If[Equal[h, 12], h12, hnot12]
			]
		]
	]
	,
	Divide[
		Plus[dc[t - 4],
			Plus[(1 + E ^ hnot12) * dc[t - 3],
				Plus[dc[t - 2],
					Plus[(E ^ hnot12) * dc[t - 2],
						Plus[(E ^ (2 * hnot12)) * dc[t - 2],
							Plus[
								(E ^ hnot12) * dc[t - 1],
								((E ^ (2 * hnot12)) * dc[t - 1]) + (E ^ (2 * hnot12)) * dc[t]
							]
						]
					]
				]
			]
		],
		1 + (E ^ hnot12) + E ^ (2 * hnot12)
	]
	,
	{}
	,
	TestID->"TimeAggregation_20230414-PNMEMY"
]


VerificationTest[
	{
		SameQ[0,
			FullSimplify[
				Coefficient[
					ReplaceAll[
						FernandoDuarte`LongRunRisk`TimeAggregation`Growth[dc,
							t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[
								{t, j, h, k, v, im},
								-((h + 1) ^ -1)
							]
						],
						dc[__] -> dcX
					],
					dcX, 0
				]
			]
		],
		SameQ[0,
			FullSimplify[
				Coefficient[
					ReplaceAll[
						FernandoDuarte`LongRunRisk`TimeAggregation`Growth[dc,
							t, "TimeAggregation" -> 3, "numPeriods" -> 3, "v0" -> Function[{t, j, h, k, v, im}, k ^ 2]
						],
						dc[__] -> dcX
					],
					dcX, 0
				]
			]
		],
		SameQ[0,
			FullSimplify[
				Coefficient[
					ReplaceAll[
						FernandoDuarte`LongRunRisk`TimeAggregation`Growth[dc,
							t, "TimeAggregation" -> 3, "numPeriods" -> 3, "v0" -> Function[{t, j, h, k, v, im}, v]
						],
						dc[__] -> dcX
					],
					dcX, 0
				]
			]
		],
		SameQ[0,
			FullSimplify[
				Coefficient[
					ReplaceAll[
						FernandoDuarte`LongRunRisk`TimeAggregation`Growth[dd,
							t, i, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j, h, k, v, im}, im]
						],
						dc[__] -> dcX
					],
					dcX, 0
				]
			]
		]
	}
	,
	{True, True, True, False}
	,
	{}
	,
	TestID->"TimeAggregation_20230414-AXTK26"
]


VerificationTest[
	Module[
		{arbitraryFun6 = Function[{t, j, h, k, v}, (-h) * t * k]},
		{
			N[
				ReplaceAll[
					SameQ[0,
						FullSimplify[
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`TimeAggregation`Growth[
										dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j, h, k, v, im}, F[h, v, im]]
									],
									dc[__] -> dcX
								],
								dcX, 0
							]
						]
					],
					F -> arbitraryFun6
				]
			]
		}
	]
	,
	{True}
	,
	{}
	,
	TestID->"TimeAggregation_20230414-YBBM3R"
]


VerificationTest[
	Not[
		N[
			SameQ[0,
				Coefficient[
					ReplaceAll[
						FernandoDuarte`LongRunRisk`TimeAggregation`Growth[dc,
							t, "TimeAggregation" -> 3, "numPeriods" -> 3, "v0" -> Function[{t, j, h, k, v, im}, j]
						],
						dc[__] -> dcX
					],
					dcX, 0
				]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20230414-4J8FE9"
]


VerificationTest[
	FernandoDuarte`LongRunRisk`TimeAggregation`Growth[dc,
		t,
		"TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j}, j]
	]
	,
	Subtract[
		Plus[
			Divide[
				Subtract[
					Plus[-3 * E ^ 4,
						dc[t - 4] + dc[t - 3] + (E ^ 4) * dc[t - 3]
					],
					7
				],
				1 + (E ^ 4) + E ^ 7
			],
			Plus[dc[t - 2],
				Plus[dc[t - 1],
					Plus[dc @ t,
						Plus[
							Divide[
								((1 - E * dc[t]) - dc[t]) - dc[t - 1],
								1 + 2 * E
							],
							Log[2 + E ^ -1]
						]
					]
				]
			]
		],
		Log[1 + (E ^ -7) + E ^ -3]
	]
	,
	{}
	,
	TestID->"TimeAggregation_20230414-UWU00G"
]


VerificationTest[
	Module[{k = 1, h, rulej, out1, out2, out3},
		h = 1;
		out1 = N[
			SameQ[0,
				Coefficient[
					ReplaceAll[
						FernandoDuarte`LongRunRisk`TimeAggregation`Growth[dc,
							t, "TimeAggregation" -> h, "numPeriods" -> k, "v0" -> Function[{t, j, h, k, v, im}, F[t]]
						],
						dc[__] -> dcX
					],
					dcX, 0
				]
			]
		];
		h = 2;
		rulej = Table[
			F[i] -> F[(h * k) + i],
			{i, 0, h - 2}
		];
		out2 = N[
			SameQ[0,
				Coefficient[
					ReplaceAll[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`TimeAggregation`Growth[
								dc, t, "TimeAggregation" -> h, "numPeriods" -> k, "v0" -> Function[{t, j, h, k, v, im}, F[j]]
							],
							rulej
						],
						dc[__] -> dcX
					],
					dcX, 0
				]
			]
		];
		h = 3;
		rulej = Table[
			F[i] -> F[(h * k) + i],
			{i, 0, h - 2}
		];
		out3 = N[
			SameQ[0,
				Coefficient[
					ReplaceAll[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`TimeAggregation`Growth[
								dc, t, "TimeAggregation" -> h, "numPeriods" -> k, "v0" -> Function[{t, j, h, k, v, im}, F[j]]
							],
							rulej
						],
						dc[__] -> dcX
					],
					dcX, 0
				]
			]
		];
		{out1, out2, out3}
	]
	,
	{True, True, True}
	,
	{}
	,
	TestID->"TimeAggregation_20230414-DZ4UZT"
]


VerificationTest[
	{
		FernandoDuarte`LongRunRisk`TimeAggregation`Growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "order" -> 0],
		FernandoDuarte`LongRunRisk`TimeAggregation`Growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "order" -> 1],
		ReplaceAll[
			ReplaceAll[
				ReplaceAll[
					ReplaceAll[
						FernandoDuarte`LongRunRisk`TimeAggregation`Growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "order" -> 2],
						Plus -> List
					],
					Times -> List
				],
				dc[{x__, t}] -> (-x)
			],
			dc[t] -> 0
		],
		ReplaceAll[
			ReplaceAll[
				ReplaceAll[
					ReplaceAll[
						FernandoDuarte`LongRunRisk`TimeAggregation`Growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "order" -> 3],
						Plus -> List
					],
					Times -> List
				],
				dc[{x__, t}] -> (-x)
			],
			dc[t] -> 0
		]
	}
	,
	{
		0,
		Times[Rational[1, 3],
			Plus[dc[t - 4],
				Plus[2 * dc[t - 3],
					(3 * dc[t - 2]) + (2 * dc[t - 1]) + dc[t]
				]
			]
		],
		{
			{
				{Rational[1, 3], 4},
				{Rational[2, 3], 3},
				2,
				{Rational[2, 3], 1},
				{Rational[1, 3], 0}
			},
			{
				{Rational[-1, 9], 16},
				{Rational[-1, 9], 4, 3},
				{Rational[-1, 9], 9},
				{Rational[1, 9], 1},
				{Rational[1, 9], 0, 1},
				{Rational[1, 9], 0}
			}
		},
		{
			{
				{Rational[1, 3], 4},
				{Rational[2, 3], 3},
				2,
				{Rational[2, 3], 1},
				{Rational[1, 3], 0}
			},
			{
				{Rational[-1, 9], 16},
				{Rational[-1, 9], 4, 3},
				{Rational[-1, 9], 9},
				{Rational[1, 9], 1},
				{Rational[1, 9], 0, 1},
				{Rational[1, 9], 0}
			},
			{
				{Rational[1, 81], 64},
				{Rational[1, 54], 16, 3},
				{Rational[-1, 54], 4, 9},
				{Rational[-1, 81], 27},
				{Rational[-1, 81], 1},
				{Rational[-1, 54], 0, 1},
				{Rational[1, 54], 0, 1},
				{Rational[1, 81], 0}
			}
		}
	}
	,
	{}
	,
	TestID->"TimeAggregation_20230414-J2QBRP"
]


EndTestSection[]
