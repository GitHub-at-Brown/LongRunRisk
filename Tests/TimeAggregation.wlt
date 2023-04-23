BeginTestSection["TimeAggregation"] 
Begin["TimeAggregation`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"
	,
	Null
	,
	{}
	,
	TestID->"TimeAggregation_20230423-KPQB0B"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20230423-JL3EZL"
]
VerificationTest[
	!SameQ[Names @ "*growth", {}]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20230423-WH9KE8"
]
VerificationTest[
	{
		FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[TimeAggregation`dc, TimeAggregation`t],
		FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[TimeAggregation`dc, TimeAggregation`t, "TimeAggregation" -> 1, "numPeriods" -> 1]
	}
	,
	{TimeAggregation`dc @ TimeAggregation`t, TimeAggregation`dc @ TimeAggregation`t}
	,
	{}
	,
	TestID->"TimeAggregation_20230423-D9OPZX"
]
VerificationTest[
	{
		FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[TimeAggregation`dc, TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1],
		ReplaceAll[
			ReplaceAll[
				ReplaceAll[
					FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[TimeAggregation`dc, TimeAggregation`t, "TimeAggregation" -> 12, "numPeriods" -> 1] /. Plus -> List,
					Times -> List
				],
				TimeAggregation`dc[{TimeAggregation`x__, TimeAggregation`t}] -> (-TimeAggregation`x)
			],
			TimeAggregation`dc[TimeAggregation`t] -> 0
		]
	}
	,
	{
		Times[Rational[1, 3],
			Plus[TimeAggregation`dc[TimeAggregation`t - 4],
				Plus[2 * TimeAggregation`dc[TimeAggregation`t - 3],
					(3 * TimeAggregation`dc[TimeAggregation`t - 2]) + (2 * TimeAggregation`dc[TimeAggregation`t - 1]) + TimeAggregation`dc[TimeAggregation`t]
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
	TestID->"TimeAggregation_20230423-45HRTG"
]
VerificationTest[
	{
		FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[TimeAggregation`sx, TimeAggregation`tau, "TimeAggregation" -> 3, "numPeriods" -> 1],
		FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[TimeAggregation`pibar, TimeAggregation`t - TimeAggregation`h, "TimeAggregation" -> 3, "numPeriods" -> 1]
	}
	,
	{
		Times[Rational[1, 3],
			Plus[TimeAggregation`sx[TimeAggregation`tau - 4],
				Plus[2 * TimeAggregation`sx[TimeAggregation`tau - 3],
					(3 * TimeAggregation`sx[TimeAggregation`tau - 2]) + (2 * TimeAggregation`sx[TimeAggregation`tau - 1]) + TimeAggregation`sx[TimeAggregation`tau]
				]
			]
		],
		Times[Rational[1, 3],
			Plus[TimeAggregation`pibar[(TimeAggregation`t - 4) - TimeAggregation`h],
				Plus[2 * TimeAggregation`pibar[(TimeAggregation`t - 3) - TimeAggregation`h],
					Plus[3 * TimeAggregation`pibar[(TimeAggregation`t - 2) - TimeAggregation`h],
						(2 * TimeAggregation`pibar[(TimeAggregation`t - 1) - TimeAggregation`h]) + TimeAggregation`pibar[TimeAggregation`t - TimeAggregation`h]
					]
				]
			]
		]
	}
	,
	{}
	,
	TestID->"TimeAggregation_20230423-BKME0N"
]
VerificationTest[
	{FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[TimeAggregation`dd, TimeAggregation`t, TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 1]}
	,
	{
		Times[Rational[1, 3],
			Plus[TimeAggregation`dd[TimeAggregation`t - 4, TimeAggregation`i],
				Plus[2 * TimeAggregation`dd[TimeAggregation`t - 3, TimeAggregation`i],
					(3 * TimeAggregation`dd[TimeAggregation`t - 2, TimeAggregation`i]) + (2 * TimeAggregation`dd[TimeAggregation`t - 1, TimeAggregation`i]) + TimeAggregation`dd[TimeAggregation`t, TimeAggregation`i]
				]
			]
		]
	}
	,
	{}
	,
	TestID->"TimeAggregation_20230423-6CV0A3"
]
VerificationTest[
	{
		ReplaceAll[
			ReplaceAll[
				ReplaceAll[
					ReplaceAll[
						FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[TimeAggregation`dc,
							TimeAggregation`t, "TimeAggregation" -> 12, "numPeriods" -> 1, "v0" -> Function[{TimeAggregation`t, TimeAggregation`j, TimeAggregation`h, TimeAggregation`k, TimeAggregation`v, TimeAggregation`im}, 0.0015]
						],
						Plus -> List
					],
					Times -> List
				],
				TimeAggregation`dc[{TimeAggregation`x__, TimeAggregation`t}] -> (-TimeAggregation`x)
			],
			TimeAggregation`dc[TimeAggregation`t] -> 0
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
	TestID->"TimeAggregation_20230423-HT6FU6"
]
VerificationTest[
	{
		FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[TimeAggregation`dc,
			TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{TimeAggregation`t, TimeAggregation`j}, 0.0015]
		]
	}
	,
	{
		Plus[0.,
			Plus[0.3328334585207629 * TimeAggregation`dc[TimeAggregation`t - 4],
				Plus[0.6661665418542368 * TimeAggregation`dc[TimeAggregation`t - 3],
					Plus[TimeAggregation`dc[TimeAggregation`t - 2],
						(0.6671665414792372 * TimeAggregation`dc[TimeAggregation`t - 1]) + 0.33383345814576315 * TimeAggregation`dc[TimeAggregation`t]
					]
				]
			]
		]
	}
	,
	{}
	,
	TestID->"TimeAggregation_20230423-WHBQKK"
]
VerificationTest[
	Apply[And,
		{
			FreeQ[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[TimeAggregation`dc,
					TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[
						{TimeAggregation`t, TimeAggregation`j, TimeAggregation`h, TimeAggregation`k, TimeAggregation`v, TimeAggregation`im},
						If[Equal[TimeAggregation`h, 12], TimeAggregation`h12, TimeAggregation`hnot12]
					]
				],
				TimeAggregation`h12
			],
			FreeQ[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[TimeAggregation`dc,
					TimeAggregation`t, "TimeAggregation" -> 12, "numPeriods" -> 1, "v0" -> Function[
						{TimeAggregation`t, TimeAggregation`j, TimeAggregation`h, TimeAggregation`k, TimeAggregation`v, TimeAggregation`im},
						If[Equal[TimeAggregation`h, 12], TimeAggregation`h12, TimeAggregation`hnot12]
					]
				],
				TimeAggregation`hnot12
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20230423-6A2R9N"
]
VerificationTest[
	Apply[And,
		{
			SameQ[0,
				FullSimplify[
					Coefficient[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								TimeAggregation`dc, TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[
									{TimeAggregation`t, TimeAggregation`j, TimeAggregation`h, TimeAggregation`k, TimeAggregation`v, TimeAggregation`im},
									-((TimeAggregation`h + 1) ^ -1)
								]
							],
							TimeAggregation`dc[__] -> TimeAggregation`dcX
						],
						TimeAggregation`dcX, 0
					]
				]
			],
			SameQ[0,
				FullSimplify[
					Coefficient[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								TimeAggregation`dc, TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 3, "v0" -> Function[{TimeAggregation`t, TimeAggregation`j, TimeAggregation`h, TimeAggregation`k, TimeAggregation`v, TimeAggregation`im}, TimeAggregation`k ^ 2]
							],
							TimeAggregation`dc[__] -> TimeAggregation`dcX
						],
						TimeAggregation`dcX, 0
					]
				]
			],
			SameQ[0,
				FullSimplify[
					Coefficient[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								TimeAggregation`dc, TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 3, "v0" -> Function[{TimeAggregation`t, TimeAggregation`j, TimeAggregation`h, TimeAggregation`k, TimeAggregation`v, TimeAggregation`im}, TimeAggregation`v]
							],
							TimeAggregation`dc[__] -> TimeAggregation`dcX
						],
						TimeAggregation`dcX, 0
					]
				]
			],
			SameQ[0,
				FullSimplify[
					Coefficient[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								TimeAggregation`dd, TimeAggregation`t, TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{TimeAggregation`t, TimeAggregation`j, TimeAggregation`h, TimeAggregation`k, TimeAggregation`v, TimeAggregation`im}, TimeAggregation`im]
							],
							TimeAggregation`dd[__, TimeAggregation`i] -> TimeAggregation`ddX
						],
						TimeAggregation`ddX, 0
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
	TestID->"TimeAggregation_20230423-G9K8GT"
]
VerificationTest[
	Module[
		{
			TimeAggregation`arbitraryFun = Function[{TimeAggregation`t, TimeAggregation`h, TimeAggregation`k, TimeAggregation`v},
				If[SameQ[TimeAggregation`v, TimeAggregation`dc],
					(-(TimeAggregation`k ^ 4)) * (TimeAggregation`h ^ 2) / TimeAggregation`t,
					Sqrt[(TimeAggregation`h / TimeAggregation`k) + 1] / TimeAggregation`t
				]
			]
		},
		SameQ[0.,
			FullSimplify[
				N[
					ReplaceAll[
						Coefficient[
							ReplaceAll[
								FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
									TimeAggregation`dc, TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{TimeAggregation`t, TimeAggregation`j, TimeAggregation`h, TimeAggregation`k, TimeAggregation`v, TimeAggregation`im}, TimeAggregation`F[TimeAggregation`t, TimeAggregation`h, TimeAggregation`k, TimeAggregation`v]]
								],
								TimeAggregation`dc[__] -> TimeAggregation`dcX
							],
							TimeAggregation`dcX, 0
						],
						TimeAggregation`F -> TimeAggregation`arbitraryFun
					]
				],
				GreaterEqual[TimeAggregation`t, 0]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20230423-89AP1H"
]
VerificationTest[
	Not[
		N[
			SameQ[0,
				Coefficient[
					ReplaceAll[
						FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[TimeAggregation`dc,
							TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 3, "v0" -> Function[{TimeAggregation`t, TimeAggregation`j, TimeAggregation`h, TimeAggregation`k, TimeAggregation`v, TimeAggregation`im}, TimeAggregation`j]
						],
						TimeAggregation`dc[__] -> TimeAggregation`dcX
					],
					TimeAggregation`dcX, 0
				]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20230423-HURIQ5"
]
VerificationTest[
	Module[{TimeAggregation`k = 1, TimeAggregation`h, TimeAggregation`rulej, TimeAggregation`out1, TimeAggregation`out2, TimeAggregation`out3},
		TimeAggregation`h = 1;
		TimeAggregation`out1 = N[
			SameQ[0,
				Coefficient[
					ReplaceAll[
						FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[TimeAggregation`dc,
							TimeAggregation`t, "TimeAggregation" -> TimeAggregation`h, "numPeriods" -> TimeAggregation`k, "v0" -> Function[{TimeAggregation`t, TimeAggregation`j, TimeAggregation`h, TimeAggregation`k, TimeAggregation`v, TimeAggregation`im}, TimeAggregation`F[TimeAggregation`t]]
						],
						TimeAggregation`dc[__] -> TimeAggregation`dcX
					],
					TimeAggregation`dcX, 0
				]
			]
		];
		TimeAggregation`h = 2;
		TimeAggregation`rulej = Table[
			TimeAggregation`F[TimeAggregation`i] -> TimeAggregation`F[(TimeAggregation`h * TimeAggregation`k) + TimeAggregation`i],
			{TimeAggregation`i, 0, TimeAggregation`h - 2}
		];
		TimeAggregation`out2 = N[
			SameQ[0,
				Coefficient[
					ReplaceAll[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								TimeAggregation`dc, TimeAggregation`t, "TimeAggregation" -> TimeAggregation`h, "numPeriods" -> TimeAggregation`k, "v0" -> Function[{TimeAggregation`t, TimeAggregation`j, TimeAggregation`h, TimeAggregation`k, TimeAggregation`v, TimeAggregation`im}, TimeAggregation`F[TimeAggregation`j]]
							],
							TimeAggregation`rulej
						],
						TimeAggregation`dc[__] -> TimeAggregation`dcX
					],
					TimeAggregation`dcX, 0
				]
			]
		];
		TimeAggregation`h = 3;
		TimeAggregation`rulej = Table[
			TimeAggregation`F[TimeAggregation`i] -> TimeAggregation`F[(TimeAggregation`h * TimeAggregation`k) + TimeAggregation`i],
			{TimeAggregation`i, 0, TimeAggregation`h - 2}
		];
		TimeAggregation`out3 = N[
			SameQ[0,
				Coefficient[
					ReplaceAll[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								TimeAggregation`dc, TimeAggregation`t, "TimeAggregation" -> TimeAggregation`h, "numPeriods" -> TimeAggregation`k, "v0" -> Function[{TimeAggregation`t, TimeAggregation`j, TimeAggregation`h, TimeAggregation`k, TimeAggregation`v, TimeAggregation`im}, TimeAggregation`F[TimeAggregation`j]]
							],
							TimeAggregation`rulej
						],
						TimeAggregation`dc[__] -> TimeAggregation`dcX
					],
					TimeAggregation`dcX, 0
				]
			]
		];
		Apply[And, {TimeAggregation`out1, TimeAggregation`out2, TimeAggregation`out3}]
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20230423-0HCVKW"
]
VerificationTest[
	Apply[And,
		{
			SameQ[
				Cases[
					Expand[
						FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[TimeAggregation`dd, TimeAggregation`t, TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 2, "order" -> 0]
					],
					Times[Optional[TimeAggregation`coef_], Power[TimeAggregation`dd[__, TimeAggregation`i], Optional[TimeAggregation`p_]]] :> TimeAggregation`p
				],
				{}
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[TimeAggregation`dd, TimeAggregation`t, TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 2, "order" -> 1]
						],
						Times[Optional[TimeAggregation`coef_], Power[TimeAggregation`dd[__, TimeAggregation`i], Optional[TimeAggregation`p_]]] :> TimeAggregation`p
					]
				],
				1
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[TimeAggregation`dd, TimeAggregation`t, TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 2, "order" -> 2]
						],
						Times[Optional[TimeAggregation`coef_], Power[TimeAggregation`dd[__, TimeAggregation`i], Optional[TimeAggregation`p_]]] :> TimeAggregation`p
					]
				],
				2
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[TimeAggregation`dd, TimeAggregation`t, TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 2, "order" -> 3]
						],
						Times[Optional[TimeAggregation`coef_], Power[TimeAggregation`dd[__, TimeAggregation`i], Optional[TimeAggregation`p_]]] :> TimeAggregation`p
					]
				],
				3
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[TimeAggregation`dc, TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 2, "order" -> 3]
						],
						Times[Optional[TimeAggregation`coef_], Power[TimeAggregation`dc[__], Optional[TimeAggregation`p_]]] :> TimeAggregation`p
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
	TestID->"TimeAggregation_20230423-8EF4ZS"
] 
End[]
EndTestSection[]
