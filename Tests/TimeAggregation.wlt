BeginTestSection["TimeAggregation"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`TimeAggregation`"
	,
	Null
	,
	{}
	,
	TestID->"TimeAggregation_20230416-B1L516"
]


VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`TimeAggregation`"]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20230416-R3D4P3"
]


VerificationTest[
	!SameQ[Names @ "*growth", {}]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20230416-1K9FEO"
]


VerificationTest[
	{
		FernandoDuarte`LongRunRisk`TimeAggregation`growth[dc, t],
		FernandoDuarte`LongRunRisk`TimeAggregation`growth[dc, t, "TimeAggregation" -> 1, "numPeriods" -> 1]
	}
	,
	{dc @ t, dc @ t}
	,
	{}
	,
	TestID->"TimeAggregation_20230416-5NGJCQ"
]


VerificationTest[
	{
		FernandoDuarte`LongRunRisk`TimeAggregation`growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1],
		ReplaceAll[
			ReplaceAll[
				ReplaceAll[
					FernandoDuarte`LongRunRisk`TimeAggregation`growth[dc, t, "TimeAggregation" -> 12, "numPeriods" -> 1] /. Plus -> List,
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
	TestID->"TimeAggregation_20230416-NTSZC2"
]


VerificationTest[
	{
		FernandoDuarte`LongRunRisk`TimeAggregation`growth[sx, tau, "TimeAggregation" -> 3, "numPeriods" -> 1],
		FernandoDuarte`LongRunRisk`TimeAggregation`growth[pibar, t - h, "TimeAggregation" -> 3, "numPeriods" -> 1]
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
	TestID->"TimeAggregation_20230416-8HGD4Y"
]


VerificationTest[
	{FernandoDuarte`LongRunRisk`TimeAggregation`growth[dd, t, i, "TimeAggregation" -> 3, "numPeriods" -> 1]}
	,
	{
		Times[Rational[1, 3],
			Plus[dd[t - 4, i],
				Plus[2 * dd[t - 3, i],
					(3 * dd[t - 2, i]) + (2 * dd[t - 1, i]) + dd[t, i]
				]
			]
		]
	}
	,
	{}
	,
	TestID->"TimeAggregation_20230416-2MKF3J"
]


VerificationTest[
	{
		ReplaceAll[
			ReplaceAll[
				ReplaceAll[
					ReplaceAll[
						FernandoDuarte`LongRunRisk`TimeAggregation`growth[dc,
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
	TestID->"TimeAggregation_20230416-V0J4SC"
]


VerificationTest[
	{
		FernandoDuarte`LongRunRisk`TimeAggregation`growth[dc,
			t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j}, 0.0015]
		]
	}
	,
	{
		Plus[0.,
			Plus[0.3328334585207629 * dc[t - 4],
				Plus[0.6661665418542368 * dc[t - 3],
					Plus[dc[t - 2],
						(0.6671665414792372 * dc[t - 1]) + 0.33383345814576315 * dc[t]
					]
				]
			]
		]
	}
	,
	{}
	,
	TestID->"TimeAggregation_20230416-LBW6AG"
]


VerificationTest[
	Apply[And,
		{
			FreeQ[
				FernandoDuarte`LongRunRisk`TimeAggregation`growth[dc,
					t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[
						{t, j, h, k, v, im},
						If[Equal[h, 12], h12, hnot12]
					]
				],
				h12
			],
			FreeQ[
				FernandoDuarte`LongRunRisk`TimeAggregation`growth[dc,
					t, "TimeAggregation" -> 12, "numPeriods" -> 1, "v0" -> Function[
						{t, j, h, k, v, im},
						If[Equal[h, 12], h12, hnot12]
					]
				],
				hnot12
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20230416-T9OEQ9"
]


VerificationTest[
	Apply[And,
		{
			SameQ[0,
				FullSimplify[
					Coefficient[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`TimeAggregation`growth[
								dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[
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
							FernandoDuarte`LongRunRisk`TimeAggregation`growth[
								dc, t, "TimeAggregation" -> 3, "numPeriods" -> 3, "v0" -> Function[{t, j, h, k, v, im}, k ^ 2]
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
							FernandoDuarte`LongRunRisk`TimeAggregation`growth[
								dc, t, "TimeAggregation" -> 3, "numPeriods" -> 3, "v0" -> Function[{t, j, h, k, v, im}, v]
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
							FernandoDuarte`LongRunRisk`TimeAggregation`growth[
								dd, t, i, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j, h, k, v, im}, im]
							],
							dd[__, i] -> ddX
						],
						ddX, 0
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
	TestID->"TimeAggregation_20230416-MPG2Z3"
]


VerificationTest[
	Module[
		{
			arbitraryFun = Function[{t, h, k, v},
				If[SameQ[v, dc],
					(-(k ^ 4)) * (h ^ 2) / t,
					Sqrt[(h / k) + 1] / t
				]
			]
		},
		SameQ[0.,
			FullSimplify[
				N[
					ReplaceAll[
						Coefficient[
							ReplaceAll[
								FernandoDuarte`LongRunRisk`TimeAggregation`growth[
									dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j, h, k, v, im}, F[t, h, k, v]]
								],
								dc[__] -> dcX
							],
							dcX, 0
						],
						F -> arbitraryFun
					]
				],
				GreaterEqual[t, 0]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20230416-JY01XB"
]


VerificationTest[
	Not[
		N[
			SameQ[0,
				Coefficient[
					ReplaceAll[
						FernandoDuarte`LongRunRisk`TimeAggregation`growth[dc,
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
	TestID->"TimeAggregation_20230416-7HJJNI"
]


VerificationTest[
	Module[{k = 1, h, rulej, out1, out2, out3},
		h = 1;
		out1 = N[
			SameQ[0,
				Coefficient[
					ReplaceAll[
						FernandoDuarte`LongRunRisk`TimeAggregation`growth[dc,
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
							FernandoDuarte`LongRunRisk`TimeAggregation`growth[
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
							FernandoDuarte`LongRunRisk`TimeAggregation`growth[
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
		Apply[And, {out1, out2, out3}]
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20230416-KXLIEQ"
]


VerificationTest[
	Apply[And,
		{
			SameQ[
				Cases[
					Expand[
						FernandoDuarte`LongRunRisk`TimeAggregation`growth[dd, t, i, "TimeAggregation" -> 3, "numPeriods" -> 2, "order" -> 0]
					],
					Times[Optional[coef_], Power[dd[__, i], Optional[p_]]] :> p
				],
				{}
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`TimeAggregation`growth[dd, t, i, "TimeAggregation" -> 3, "numPeriods" -> 2, "order" -> 1]
						],
						Times[Optional[coef_], Power[dd[__, i], Optional[p_]]] :> p
					]
				],
				1
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`TimeAggregation`growth[dd, t, i, "TimeAggregation" -> 3, "numPeriods" -> 2, "order" -> 2]
						],
						Times[Optional[coef_], Power[dd[__, i], Optional[p_]]] :> p
					]
				],
				2
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`TimeAggregation`growth[dd, t, i, "TimeAggregation" -> 3, "numPeriods" -> 2, "order" -> 3]
						],
						Times[Optional[coef_], Power[dd[__, i], Optional[p_]]] :> p
					]
				],
				3
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`TimeAggregation`growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 2, "order" -> 3]
						],
						Times[Optional[coef_], Power[dc[__], Optional[p_]]] :> p
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
	TestID->"TimeAggregation_20230416-KIYCWO"
]


EndTestSection[]
