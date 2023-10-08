BeginTestSection["TimeAggregation"] 
Begin["Tools`TimeAggregation`"]
VerificationTest[
	Off[General::stop];
	Needs @ "FernandoDuarte`LongRunRisk`Tools`TimeAggregation`";
	True
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231008-NL9UOA"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"];
	True
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231008-8TZMK8"
]
VerificationTest[
	!SameQ[Names @ "*growth", {}]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231008-6ZK093"
]
VerificationTest[
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc, Tools`TimeAggregation`t], Tools`TimeAggregation`dc @ Tools`TimeAggregation`t],
			Equal[FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 1, "numPeriods" -> 1],
				Tools`TimeAggregation`dc @ Tools`TimeAggregation`t
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231008-4NSQ80"
]
VerificationTest[
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1],
				Times[1 / 3,
					Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4],
						Plus[2 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3],
							(3 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2]) + (2 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1]) + Tools`TimeAggregation`dc[Tools`TimeAggregation`t]
						]
					]
				]
			],
			Equal[
				ReplaceAll[
					ReplaceAll[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 12, "numPeriods" -> 1] /. Plus -> List,
							Times -> List
						],
						Tools`TimeAggregation`dc[{Tools`TimeAggregation`x__, Tools`TimeAggregation`t}] -> (-Tools`TimeAggregation`x)
					],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t] -> 0
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
	TestID->"TimeAggregation_20231008-7BZWGQ"
]
VerificationTest[
	Apply[And,
		{
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc,
					Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4],
						Plus[0.6661665418542368 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3],
							Plus[
								Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
								(0.6671665414792372 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1]) + 0.33383345814576315 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t]
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc,
					Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4],
						Plus[0.6661665418542368 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3],
							Plus[
								Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
								(0.6671665414792372 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1]) + 0.33383345814576315 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t]
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc,
					Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4],
						Plus[0.6661665418542368 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3],
							Plus[
								Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
								(0.6671665414792372 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1]) + 0.33383345814576315 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t]
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc,
					Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4],
						Plus[0.6661665418542368 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3],
							Plus[
								Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
								(0.6671665414792372 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1]) + 0.33383345814576315 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t]
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc,
					Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4],
						Plus[0.6661665418542368 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3],
							Plus[
								Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
								(0.6671665414792372 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1]) + 0.33383345814576315 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t]
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc,
					Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{Tools`TimeAggregation`t}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4],
						Plus[0.6661665418542368 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3],
							Plus[
								Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
								(0.6671665414792372 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1]) + 0.33383345814576315 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t]
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc,
					Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4],
						Plus[0.6661665418542368 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3],
							Plus[
								Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
								(0.6671665414792372 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1]) + 0.33383345814576315 * Tools`TimeAggregation`dc[Tools`TimeAggregation`t]
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
	TestID->"TimeAggregation_20231008-VIFCOZ"
]
VerificationTest[
	Apply[And,
		{
			Equal[
				Simplify[
					FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc,
						Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im}, Tools`TimeAggregation`t]
					]
				],
				Times[1 / (1 + (E ^ Tools`TimeAggregation`t) + E ^ (2 * Tools`TimeAggregation`t)),
					Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4],
						Plus[(1 + E ^ Tools`TimeAggregation`t) * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3],
							Plus[
								Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
								Plus[
									(E ^ Tools`TimeAggregation`t) * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
									Plus[
										(E ^ (2 * Tools`TimeAggregation`t)) * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
										Plus[
											(E ^ Tools`TimeAggregation`t) * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1],
											((E ^ (2 * Tools`TimeAggregation`t)) * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1]) + (E ^ (2 * Tools`TimeAggregation`t)) * Tools`TimeAggregation`dc[Tools`TimeAggregation`t]
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
	TestID->"TimeAggregation_20231008-3GM2MS"
]
VerificationTest[
	Apply[And,
		{
			FreeQ[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc,
					Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[
						{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im},
						If[Equal[Tools`TimeAggregation`h, 12], Tools`TimeAggregation`h12, Tools`TimeAggregation`hnot12]
					]
				],
				Tools`TimeAggregation`h12
			],
			FreeQ[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc,
					Tools`TimeAggregation`t, "TimeAggregation" -> 12, "numPeriods" -> 1, "v0" -> Function[
						{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im},
						If[Equal[Tools`TimeAggregation`h, 12], Tools`TimeAggregation`h12, Tools`TimeAggregation`hnot12]
					]
				],
				Tools`TimeAggregation`hnot12
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231008-TFPPSK"
]
VerificationTest[
	Apply[And,
		{
			SameQ[0,
				FullSimplify[
					Coefficient[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[
									{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im},
									-((Tools`TimeAggregation`h + 1) ^ -1)
								]
							],
							Tools`TimeAggregation`dc[__] -> Tools`TimeAggregation`dcX
						],
						Tools`TimeAggregation`dcX, 0
					]
				]
			],
			SameQ[0,
				FullSimplify[
					Coefficient[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 3, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im}, Tools`TimeAggregation`h ^ 2]
							],
							Tools`TimeAggregation`dc[__] -> Tools`TimeAggregation`dcX
						],
						Tools`TimeAggregation`dcX, 0
					]
				]
			],
			SameQ[0,
				FullSimplify[
					Coefficient[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im}, Tools`TimeAggregation`im]
							],
							Tools`TimeAggregation`dc[__] -> Tools`TimeAggregation`dcX
						],
						Tools`TimeAggregation`dcX, 0
					]
				]
			],
			SameQ[0,
				FullSimplify[
					Coefficient[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 3, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im}, Tools`TimeAggregation`v]
							],
							Tools`TimeAggregation`dc[__] -> Tools`TimeAggregation`dcX
						],
						Tools`TimeAggregation`dcX, 0
					]
				]
			],
			SameQ[0,
				FullSimplify[
					Coefficient[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								Tools`TimeAggregation`dd, Tools`TimeAggregation`t, Tools`TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im}, Tools`TimeAggregation`im]
							],
							Tools`TimeAggregation`dd[__, Tools`TimeAggregation`i] -> Tools`TimeAggregation`ddX
						],
						Tools`TimeAggregation`ddX, 0
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
	TestID->"TimeAggregation_20231008-YVXHUC"
]
VerificationTest[
	Tools`TimeAggregation`arbitraryFun1 = Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v}, Sqrt @ Tools`TimeAggregation`h];
	Tools`TimeAggregation`arbitraryFun2 = Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v},
		If[Equal[Tools`TimeAggregation`v, Tools`TimeAggregation`dd], Sqrt @ Tools`TimeAggregation`h, Cos @ Tools`TimeAggregation`h]
	];
	Tools`TimeAggregation`arbitraryFun3 = Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v}, -Tools`TimeAggregation`h];
	Tools`TimeAggregation`arbitraryFun4 = Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v},
		(Sqrt[Tools`TimeAggregation`h] * Tools`TimeAggregation`t) - Tools`TimeAggregation`k ^ 2
	];
	Tools`TimeAggregation`arbitraryFun5 = Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v},
		If[Equal[Tools`TimeAggregation`v, Tools`TimeAggregation`dd],
			Sqrt[Tools`TimeAggregation`h] * Sqrt[Tools`TimeAggregation`t],
			Exp[Tools`TimeAggregation`t] * Cos[Tools`TimeAggregation`h]
		]
	];
	Tools`TimeAggregation`arbitraryFun6 = Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v}, (-Tools`TimeAggregation`h) * Tools`TimeAggregation`t * Tools`TimeAggregation`k];
	Apply[And,
		{
			N[
				ReplaceAll[
					SameQ[0,
						FullSimplify[
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
										Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im}, Tools`TimeAggregation`F[Tools`TimeAggregation`h, Tools`TimeAggregation`v, Tools`TimeAggregation`im]]
									],
									Tools`TimeAggregation`dc[__] -> Tools`TimeAggregation`dcX
								],
								Tools`TimeAggregation`dcX, 0
							]
						]
					],
					Tools`TimeAggregation`F -> Tools`TimeAggregation`arbitraryFun1
				]
			],
			N[
				ReplaceAll[
					SameQ[0,
						FullSimplify[
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
										Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im}, Tools`TimeAggregation`F[Tools`TimeAggregation`h, Tools`TimeAggregation`v, Tools`TimeAggregation`im]]
									],
									Tools`TimeAggregation`dc[__] -> Tools`TimeAggregation`dcX
								],
								Tools`TimeAggregation`dcX, 0
							]
						]
					],
					Tools`TimeAggregation`F -> Tools`TimeAggregation`arbitraryFun2
				]
			],
			N[
				ReplaceAll[
					SameQ[0,
						FullSimplify[
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
										Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im}, Tools`TimeAggregation`F[Tools`TimeAggregation`h, Tools`TimeAggregation`v, Tools`TimeAggregation`im]]
									],
									Tools`TimeAggregation`dc[__] -> Tools`TimeAggregation`dcX
								],
								Tools`TimeAggregation`dcX, 0
							]
						]
					],
					Tools`TimeAggregation`F -> Tools`TimeAggregation`arbitraryFun3
				]
			],
			N[
				ReplaceAll[
					SameQ[0,
						FullSimplify[
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
										Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im}, Tools`TimeAggregation`F[Tools`TimeAggregation`h, Tools`TimeAggregation`v, Tools`TimeAggregation`im]]
									],
									Tools`TimeAggregation`dc[__] -> Tools`TimeAggregation`dcX
								],
								Tools`TimeAggregation`dcX, 0
							]
						]
					],
					Tools`TimeAggregation`F -> Tools`TimeAggregation`arbitraryFun4
				]
			],
			N[
				ReplaceAll[
					SameQ[0,
						FullSimplify[
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
										Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im}, Tools`TimeAggregation`F[Tools`TimeAggregation`h, Tools`TimeAggregation`v, Tools`TimeAggregation`im]]
									],
									Tools`TimeAggregation`dc[__] -> Tools`TimeAggregation`dcX
								],
								Tools`TimeAggregation`dcX, 0
							]
						]
					],
					Tools`TimeAggregation`F -> Tools`TimeAggregation`arbitraryFun5
				]
			],
			N[
				ReplaceAll[
					SameQ[0,
						FullSimplify[
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
										Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im}, Tools`TimeAggregation`F[Tools`TimeAggregation`h, Tools`TimeAggregation`v, Tools`TimeAggregation`im]]
									],
									Tools`TimeAggregation`dc[__] -> Tools`TimeAggregation`dcX
								],
								Tools`TimeAggregation`dcX, 0
							]
						]
					],
					Tools`TimeAggregation`F -> Tools`TimeAggregation`arbitraryFun6
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231008-91JF5Z"
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
									Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 3, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im}, Tools`TimeAggregation`j]
								],
								Tools`TimeAggregation`dc[__] -> Tools`TimeAggregation`dcX
							],
							Tools`TimeAggregation`dcX, 0
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
	TestID->"TimeAggregation_20231008-0FJ9QZ"
]
VerificationTest[
	Apply[And,
		{
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc,
					Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j}, Tools`TimeAggregation`j]
				],
				Subtract[
					Plus[
						Divide[
							Subtract[
								Subtract[
									Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3] + (E ^ 4) * Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3],
									7
								],
								3 * E ^ 4
							],
							1 + (E ^ 4) + E ^ 7
						],
						Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
							Plus[
								Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1],
								Plus[
									Tools`TimeAggregation`dc @ Tools`TimeAggregation`t,
									Plus[
										Divide[
											((1 - E * Tools`TimeAggregation`dc[Tools`TimeAggregation`t]) - Tools`TimeAggregation`dc[Tools`TimeAggregation`t]) - Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1],
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
	TestID->"TimeAggregation_20231008-E14NJZ"
]
VerificationTest[
	Apply[And,
		{
			Not[
				FreeQ[
					FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc,
						Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[
							{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im},
							If[SameQ[Tools`TimeAggregation`v, Tools`TimeAggregation`dc], Tools`TimeAggregation`Edc, 0]
						]
					],
					Tools`TimeAggregation`Edc
				]
			],
			FreeQ[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`pi,
					Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[
						{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im},
						If[SameQ[Tools`TimeAggregation`v, Tools`TimeAggregation`dc], Tools`TimeAggregation`Edc, 0]
					]
				],
				Tools`TimeAggregation`Edc
			],
			Not[
				FreeQ[
					FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dd,
						Tools`TimeAggregation`t, Tools`TimeAggregation`i, "TimeAggregation" -> 12, "numPeriods" -> 1, "v0" -> Function[
							{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im},
							If[SameQ[Tools`TimeAggregation`v, Tools`TimeAggregation`dd], Tools`TimeAggregation`Edd, 0]
						]
					],
					Tools`TimeAggregation`Edd
				]
			],
			FreeQ[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc,
					Tools`TimeAggregation`t, "TimeAggregation" -> 12, "numPeriods" -> 1, "v0" -> Function[
						{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im},
						If[SameQ[Tools`TimeAggregation`v, Tools`TimeAggregation`dd], Tools`TimeAggregation`Edd, 0]
					]
				],
				Tools`TimeAggregation`Edd
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231008-ZCTXUR"
]
VerificationTest[
	Apply[And,
		{
			Equal[
				ReplaceAll[
					FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc,
						Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im}, Evaluate[Tools`TimeAggregation`uncondE[Tools`TimeAggregation`dc[Tools`TimeAggregation`t]]]]
					],
					Tools`TimeAggregation`uncondE[Tools`TimeAggregation`dc[Tools`TimeAggregation`t]] -> 0
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231008-TYXH9R"
]
VerificationTest[
	Tools`TimeAggregation`h = 1;
	Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Simplify[
				SameQ[0,
					Coefficient[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im}, Tools`TimeAggregation`F[Tools`TimeAggregation`t]]
							],
							Tools`TimeAggregation`dc[__] -> Tools`TimeAggregation`dcX
						],
						Tools`TimeAggregation`dcX, 0
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
	TestID->"TimeAggregation_20231008-18G895"
]
VerificationTest[
	Tools`TimeAggregation`h = 2;
	Tools`TimeAggregation`k = 1;
	Tools`TimeAggregation`rulej = Table[Tools`TimeAggregation`F[Tools`TimeAggregation`i] -> Tools`TimeAggregation`F[(Tools`TimeAggregation`h * Tools`TimeAggregation`k) + Tools`TimeAggregation`i],
		{Tools`TimeAggregation`i, 0, Tools`TimeAggregation`h - 2}
	];
	Apply[And,
		{
			FullSimplify[
				SameQ[0,
					Coefficient[
						ReplaceAll[
							ReplaceAll[
								FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
									Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im}, Tools`TimeAggregation`F[Tools`TimeAggregation`j]]
								],
								Tools`TimeAggregation`rulej
							],
							Tools`TimeAggregation`dc[__] -> Tools`TimeAggregation`dcX
						],
						Tools`TimeAggregation`dcX, 0
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
	TestID->"TimeAggregation_20231008-8ACQXK"
]
VerificationTest[
	Tools`TimeAggregation`h = 3;
	Tools`TimeAggregation`k = 1;
	Tools`TimeAggregation`rulej = Table[Tools`TimeAggregation`F[Tools`TimeAggregation`i] -> Tools`TimeAggregation`F[(Tools`TimeAggregation`h * Tools`TimeAggregation`k) + Tools`TimeAggregation`i],
		{Tools`TimeAggregation`i, 0, Tools`TimeAggregation`h - 2}
	];
	Apply[And,
		{
			FullSimplify[
				SameQ[0,
					Coefficient[
						ReplaceAll[
							ReplaceAll[
								FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
									Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im}, Tools`TimeAggregation`F[Tools`TimeAggregation`j]]
								],
								Tools`TimeAggregation`rulej
							],
							Tools`TimeAggregation`dc[__] -> Tools`TimeAggregation`dcX
						],
						Tools`TimeAggregation`dcX, 0
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
	TestID->"TimeAggregation_20231008-31R2WE"
]
VerificationTest[
	Tools`TimeAggregation`h = 4;
	Tools`TimeAggregation`k = 1;
	Tools`TimeAggregation`rulej = Table[Tools`TimeAggregation`F[Tools`TimeAggregation`i] -> Tools`TimeAggregation`F[(Tools`TimeAggregation`h * Tools`TimeAggregation`k) + Tools`TimeAggregation`i],
		{Tools`TimeAggregation`i, 0, Tools`TimeAggregation`h - 2}
	];
	Apply[And,
		{
			FullSimplify[
				SameQ[0,
					Coefficient[
						ReplaceAll[
							ReplaceAll[
								FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
									Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k, "v0" -> Function[{Tools`TimeAggregation`t, Tools`TimeAggregation`j, Tools`TimeAggregation`h, Tools`TimeAggregation`k, Tools`TimeAggregation`v, Tools`TimeAggregation`im}, Tools`TimeAggregation`F[Tools`TimeAggregation`j]]
								],
								Tools`TimeAggregation`rulej
							],
							Tools`TimeAggregation`dc[__] -> Tools`TimeAggregation`dcX
						],
						Tools`TimeAggregation`dcX, 0
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
	TestID->"TimeAggregation_20231008-ZNFA7N"
]
VerificationTest[
	Apply[And,
		{
			SameQ[
				Cases[
					Expand[
						FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 0]
					],
					Times[Optional[Tools`TimeAggregation`coef_], Power[Tools`TimeAggregation`dc[__], Optional[Tools`TimeAggregation`p_]]] :> Tools`TimeAggregation`p
				],
				{}
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 1]
						],
						Times[Optional[Tools`TimeAggregation`coef_], Power[Tools`TimeAggregation`dc[__], Optional[Tools`TimeAggregation`p_]]] :> Tools`TimeAggregation`p
					]
				],
				1
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 2]
						],
						Times[Optional[Tools`TimeAggregation`coef_], Power[Tools`TimeAggregation`dc[__], Optional[Tools`TimeAggregation`p_]]] :> Tools`TimeAggregation`p
					]
				],
				2
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 3]
						],
						Times[Optional[Tools`TimeAggregation`coef_], Power[Tools`TimeAggregation`dc[__], Optional[Tools`TimeAggregation`p_]]] :> Tools`TimeAggregation`p
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
	TestID->"TimeAggregation_20231008-E42BTS"
]
VerificationTest[
	Apply[And,
		{
			SameQ[
				Cases[
					Expand[
						FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dd, Tools`TimeAggregation`t, Tools`TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 0]
					],
					Times[Optional[Tools`TimeAggregation`coef_], Power[Tools`TimeAggregation`dd[__, Tools`TimeAggregation`i], Optional[Tools`TimeAggregation`p_]]] :> Tools`TimeAggregation`p
				],
				{}
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dd, Tools`TimeAggregation`t, Tools`TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 1]
						],
						Times[Optional[Tools`TimeAggregation`coef_], Power[Tools`TimeAggregation`dd[__, Tools`TimeAggregation`i], Optional[Tools`TimeAggregation`p_]]] :> Tools`TimeAggregation`p
					]
				],
				1
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dd, Tools`TimeAggregation`t, Tools`TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 2]
						],
						Times[Optional[Tools`TimeAggregation`coef_], Power[Tools`TimeAggregation`dd[__, Tools`TimeAggregation`i], Optional[Tools`TimeAggregation`p_]]] :> Tools`TimeAggregation`p
					]
				],
				2
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[Tools`TimeAggregation`dd, Tools`TimeAggregation`t, Tools`TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 3]
						],
						Times[Optional[Tools`TimeAggregation`coef_], Power[Tools`TimeAggregation`dd[__, Tools`TimeAggregation`i], Optional[Tools`TimeAggregation`p_]]] :> Tools`TimeAggregation`p
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
	TestID->"TimeAggregation_20231008-W74JSN"
]
VerificationTest[
	Tools`TimeAggregation`f = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`f;
	Tools`TimeAggregation`g = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g;
	Tools`TimeAggregation`s = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`s;
	Tools`TimeAggregation`timeSeriesVector = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`timeSeriesVector;
	Tools`TimeAggregation`gt = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`gt;
	True
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231008-FK1LY2"
]
VerificationTest[
	Tools`TimeAggregation`h = 3;
	Tools`TimeAggregation`k = 2;
	Apply[And,
		{
			Equal[Tools`TimeAggregation`gt[Tools`TimeAggregation`dc, Tools`TimeAggregation`t], Tools`TimeAggregation`dc @ Tools`TimeAggregation`t],
			Equal[Tools`TimeAggregation`gt[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, {"TimeAggregation" -> 3, "numPeriods" -> Tools`TimeAggregation`k}],
				Subtract[
					Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 5],
						Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4],
							Plus[
								Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3],
								Plus[
									Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
									Plus[
										Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1],
										Plus[
											Tools`TimeAggregation`dc @ Tools`TimeAggregation`t,
											Log[
												Plus[
													1,
													(E ^ ((-Tools`TimeAggregation`dc[Tools`TimeAggregation`t]) - Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1])) + E ^ (-Tools`TimeAggregation`dc[Tools`TimeAggregation`t])
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
								E ^ ((-Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 6]) - Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 7]),
								E ^ (-Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 6])
							]
						]
					]
				]
			],
			Equal[Tools`TimeAggregation`gt[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> Tools`TimeAggregation`k],
				Subtract[
					Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 5],
						Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4],
							Plus[
								Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3],
								Plus[
									Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
									Plus[
										Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1],
										Plus[
											Tools`TimeAggregation`dc @ Tools`TimeAggregation`t,
											Log[
												Plus[
													1,
													(E ^ ((-Tools`TimeAggregation`dc[Tools`TimeAggregation`t]) - Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1])) + E ^ (-Tools`TimeAggregation`dc[Tools`TimeAggregation`t])
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
								E ^ ((-Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 6]) - Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 7]),
								E ^ (-Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 6])
							]
						]
					]
				]
			],
			Equal[Tools`TimeAggregation`gt[Tools`TimeAggregation`dd, Tools`TimeAggregation`t, Tools`TimeAggregation`i, {"TimeAggregation" -> 3, "numPeriods" -> Tools`TimeAggregation`k}],
				Subtract[
					Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 5, Tools`TimeAggregation`i],
						Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 4, Tools`TimeAggregation`i],
							Plus[
								Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 3, Tools`TimeAggregation`i],
								Plus[
									Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 2, Tools`TimeAggregation`i],
									Plus[
										Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, Tools`TimeAggregation`i],
										Plus[
											Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i],
											Log[
												Plus[
													1,
													Plus[
														E ^ ((-Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i]) - Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, Tools`TimeAggregation`i]),
														E ^ (-Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i])
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
									(-Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 6, Tools`TimeAggregation`i]) - Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 7, Tools`TimeAggregation`i]
								],
								E ^ (-Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 6, Tools`TimeAggregation`i])
							]
						]
					]
				]
			],
			Equal[Tools`TimeAggregation`gt[Tools`TimeAggregation`dd, Tools`TimeAggregation`t, Tools`TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> Tools`TimeAggregation`k],
				Subtract[
					Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 5, Tools`TimeAggregation`i],
						Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 4, Tools`TimeAggregation`i],
							Plus[
								Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 3, Tools`TimeAggregation`i],
								Plus[
									Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 2, Tools`TimeAggregation`i],
									Plus[
										Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, Tools`TimeAggregation`i],
										Plus[
											Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i],
											Log[
												Plus[
													1,
													Plus[
														E ^ ((-Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i]) - Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, Tools`TimeAggregation`i]),
														E ^ (-Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i])
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
									(-Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 6, Tools`TimeAggregation`i]) - Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 7, Tools`TimeAggregation`i]
								],
								E ^ (-Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 6, Tools`TimeAggregation`i])
							]
						]
					]
				]
			],
			Equal[Tools`TimeAggregation`gt[Tools`TimeAggregation`dd, Tools`TimeAggregation`t, 1, {"TimeAggregation" -> 3, "numPeriods" -> Tools`TimeAggregation`k}],
				Subtract[
					Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 5, 1],
						Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 4, 1],
							Plus[
								Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 3, 1],
								Plus[
									Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 2, 1],
									Plus[
										Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, 1],
										Plus[
											Tools`TimeAggregation`dd[Tools`TimeAggregation`t, 1],
											Log[
												Plus[
													1,
													Plus[
														E ^ ((-Tools`TimeAggregation`dd[Tools`TimeAggregation`t, 1]) - Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, 1]),
														E ^ (-Tools`TimeAggregation`dd[Tools`TimeAggregation`t, 1])
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
									(-Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 6, 1]) - Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 7, 1]
								],
								E ^ (-Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 6, 1])
							]
						]
					]
				]
			],
			Equal[Tools`TimeAggregation`gt[Tools`TimeAggregation`dd, Tools`TimeAggregation`t, 2, "TimeAggregation" -> 3, "numPeriods" -> Tools`TimeAggregation`k],
				Subtract[
					Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 5, 2],
						Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 4, 2],
							Plus[
								Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 3, 2],
								Plus[
									Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 2, 2],
									Plus[
										Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, 2],
										Plus[
											Tools`TimeAggregation`dd[Tools`TimeAggregation`t, 2],
											Log[
												Plus[
													1,
													Plus[
														E ^ ((-Tools`TimeAggregation`dd[Tools`TimeAggregation`t, 2]) - Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, 2]),
														E ^ (-Tools`TimeAggregation`dd[Tools`TimeAggregation`t, 2])
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
									(-Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 6, 2]) - Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 7, 2]
								],
								E ^ (-Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 6, 2])
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
	TestID->"TimeAggregation_20231008-F353ND"
]
VerificationTest[
	Tools`TimeAggregation`h = 3;
	Tools`TimeAggregation`k = 2;
	Apply[And,
		{
			Equal[Tools`TimeAggregation`gt[Tools`TimeAggregation`dc, Tools`TimeAggregation`t], Tools`TimeAggregation`dc @ Tools`TimeAggregation`t],
			Equal[Tools`TimeAggregation`gt[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "flowVariable" -> False], Tools`TimeAggregation`dc @ Tools`TimeAggregation`t],
			Equal[Tools`TimeAggregation`gt[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3, "flowVariable" -> False],
				Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t]
			],
			Equal[Tools`TimeAggregation`gt[Tools`TimeAggregation`dd, Tools`TimeAggregation`t, Tools`TimeAggregation`i, {"numPeriods" -> Tools`TimeAggregation`k}, "flowVariable" -> False],
				Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, Tools`TimeAggregation`i] + Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i]
			],
			Equal[Tools`TimeAggregation`gt[Tools`TimeAggregation`dd, Tools`TimeAggregation`t, Tools`TimeAggregation`i, "flowVariable" -> False], Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i]],
			Equal[
				Tools`TimeAggregation`gt[Tools`TimeAggregation`dd, Tools`TimeAggregation`t, 1, {"TimeAggregation" -> 3}, "flowVariable" -> False],
				Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 2, 1] + Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, 1] + Tools`TimeAggregation`dd[Tools`TimeAggregation`t, 1]
			],
			Equal[Tools`TimeAggregation`gt[Tools`TimeAggregation`dd, Tools`TimeAggregation`t, 2, "flowVariable" -> False], Tools`TimeAggregation`dd[Tools`TimeAggregation`t, 2]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231008-91PFM6"
]
VerificationTest[
	Tools`TimeAggregation`h = 3;
	Tools`TimeAggregation`k = 2;
	Apply[And,
		{
			Equal[Tools`TimeAggregation`gt[Tools`TimeAggregation`dc, Tools`TimeAggregation`t], Tools`TimeAggregation`dc @ Tools`TimeAggregation`t],
			Equal[
				Tools`TimeAggregation`gt[Tools`TimeAggregation`dc,
					Tools`TimeAggregation`t,
					{"TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k},
					"flowVariable" -> False
				],
				Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 5],
					Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4],
						Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t]
					]
				]
			],
			Equal[
				Tools`TimeAggregation`gt[Tools`TimeAggregation`dc,
					Tools`TimeAggregation`t, "TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k, "flowVariable" -> False
				],
				Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 5],
					Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4],
						Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t]
					]
				]
			],
			Equal[
				Tools`TimeAggregation`gt[Tools`TimeAggregation`dd,
					Tools`TimeAggregation`t, Tools`TimeAggregation`i, {"TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k},
					"flowVariable" -> False
				],
				Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 5, Tools`TimeAggregation`i],
					Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 4, Tools`TimeAggregation`i],
						Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 3, Tools`TimeAggregation`i],
							Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 2, Tools`TimeAggregation`i] + Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, Tools`TimeAggregation`i] + Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i]
						]
					]
				]
			],
			Equal[
				Tools`TimeAggregation`gt[Tools`TimeAggregation`dd,
					Tools`TimeAggregation`t, Tools`TimeAggregation`i, "TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k, "flowVariable" -> False
				],
				Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 5, Tools`TimeAggregation`i],
					Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 4, Tools`TimeAggregation`i],
						Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 3, Tools`TimeAggregation`i],
							Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 2, Tools`TimeAggregation`i] + Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, Tools`TimeAggregation`i] + Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i]
						]
					]
				]
			],
			Equal[
				Tools`TimeAggregation`gt[Tools`TimeAggregation`dd,
					Tools`TimeAggregation`t, 1, {"TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k},
					"flowVariable" -> False
				],
				Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 5, 1],
					Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 4, 1],
						Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 3, 1],
							Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 2, 1] + Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, 1] + Tools`TimeAggregation`dd[Tools`TimeAggregation`t, 1]
						]
					]
				]
			],
			Equal[
				Tools`TimeAggregation`gt[Tools`TimeAggregation`dd,
					Tools`TimeAggregation`t, 2, "TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k, "flowVariable" -> False
				],
				Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 5, 2],
					Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 4, 2],
						Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 3, 2],
							Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 2, 2] + Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, 2] + Tools`TimeAggregation`dd[Tools`TimeAggregation`t, 2]
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
	TestID->"TimeAggregation_20231008-7FVTG8"
]
VerificationTest[
	Tools`TimeAggregation`h = 3;
	Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[Tools`TimeAggregation`g[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> Tools`TimeAggregation`h], Tools`TimeAggregation`h],
				Subtract[
					Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
						Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1],
							Plus[
								Tools`TimeAggregation`dc @ Tools`TimeAggregation`t,
								Log[
									Plus[
										1,
										(E ^ ((-Tools`TimeAggregation`dc[Tools`TimeAggregation`t]) - Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1])) + E ^ (-Tools`TimeAggregation`dc[Tools`TimeAggregation`t])
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3]) - Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4]),
								E ^ (-Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3])
							]
						]
					]
				]
			],
			Equal[Tools`TimeAggregation`g[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "numPeriods" -> Tools`TimeAggregation`k], 1, Tools`TimeAggregation`k], Tools`TimeAggregation`dc @ Tools`TimeAggregation`t],
			Equal[
				Tools`TimeAggregation`g[
					Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, {"TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k}],
					Tools`TimeAggregation`h, Tools`TimeAggregation`k
				],
				Subtract[
					Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
						Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1],
							Plus[
								Tools`TimeAggregation`dc @ Tools`TimeAggregation`t,
								Log[
									Plus[
										1,
										(E ^ ((-Tools`TimeAggregation`dc[Tools`TimeAggregation`t]) - Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1])) + E ^ (-Tools`TimeAggregation`dc[Tools`TimeAggregation`t])
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3]) - Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4]),
								E ^ (-Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3])
							]
						]
					]
				]
			],
			Equal[
				Tools`TimeAggregation`g[
					Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k],
					Tools`TimeAggregation`h, Tools`TimeAggregation`k
				],
				Subtract[
					Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
						Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1],
							Plus[
								Tools`TimeAggregation`dc @ Tools`TimeAggregation`t,
								Log[
									Plus[
										1,
										(E ^ ((-Tools`TimeAggregation`dc[Tools`TimeAggregation`t]) - Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1])) + E ^ (-Tools`TimeAggregation`dc[Tools`TimeAggregation`t])
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3]) - Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4]),
								E ^ (-Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3])
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
	TestID->"TimeAggregation_20231008-742TNX"
]
VerificationTest[
	Tools`TimeAggregation`h = 3;
	Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[Tools`TimeAggregation`g[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t], Tools`TimeAggregation`h], FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{Tools`TimeAggregation`dc @ Tools`TimeAggregation`t}, 3]],
			Equal[
				Tools`TimeAggregation`g[Part[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> Tools`TimeAggregation`h], 1;;-2],
					Tools`TimeAggregation`h
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{Tools`TimeAggregation`dc @ Tools`TimeAggregation`t, Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1], Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2], Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3]},
					3
				]
			],
			Equal[
				Tools`TimeAggregation`g[Part[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "numPeriods" -> Tools`TimeAggregation`k], 1;;-2], 1, Tools`TimeAggregation`k],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{}, 1, 1]
			],
			Equal[
				Tools`TimeAggregation`g[
					Part[
						Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, {"TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k}],
						1;;-2
					],
					Tools`TimeAggregation`h, Tools`TimeAggregation`k
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{Tools`TimeAggregation`dc @ Tools`TimeAggregation`t, Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1], Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2], Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3]},
					3, 1
				]
			],
			Equal[
				Tools`TimeAggregation`g[
					Part[
						Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k],
						1;;-2
					],
					Tools`TimeAggregation`h, Tools`TimeAggregation`k
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{Tools`TimeAggregation`dc @ Tools`TimeAggregation`t, Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1], Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2], Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3]},
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
	TestID->"TimeAggregation_20231008-XDB92N"
]
VerificationTest[
	Tools`TimeAggregation`h = 3;
	Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[
				Tools`TimeAggregation`g[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> Tools`TimeAggregation`h],
					Tools`TimeAggregation`h, "flowVariable" -> True
				],
				Subtract[
					Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
						Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1],
							Plus[
								Tools`TimeAggregation`dc @ Tools`TimeAggregation`t,
								Log[
									Plus[
										1,
										(E ^ ((-Tools`TimeAggregation`dc[Tools`TimeAggregation`t]) - Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1])) + E ^ (-Tools`TimeAggregation`dc[Tools`TimeAggregation`t])
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3]) - Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4]),
								E ^ (-Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3])
							]
						]
					]
				]
			],
			Equal[
				Tools`TimeAggregation`g[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "numPeriods" -> Tools`TimeAggregation`k],
					1, Tools`TimeAggregation`k, "flowVariable" -> True
				],
				Tools`TimeAggregation`dc @ Tools`TimeAggregation`t
			],
			Equal[
				Tools`TimeAggregation`g[
					Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, {"TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k}],
					Tools`TimeAggregation`h, Tools`TimeAggregation`k, "flowVariable" -> True
				],
				Subtract[
					Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
						Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1],
							Plus[
								Tools`TimeAggregation`dc @ Tools`TimeAggregation`t,
								Log[
									Plus[
										1,
										(E ^ ((-Tools`TimeAggregation`dc[Tools`TimeAggregation`t]) - Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1])) + E ^ (-Tools`TimeAggregation`dc[Tools`TimeAggregation`t])
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3]) - Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4]),
								E ^ (-Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3])
							]
						]
					]
				]
			],
			Equal[
				Tools`TimeAggregation`g[
					Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k],
					Tools`TimeAggregation`h, Tools`TimeAggregation`k, "flowVariable" -> True
				],
				Subtract[
					Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
						Plus[Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1],
							Plus[
								Tools`TimeAggregation`dc @ Tools`TimeAggregation`t,
								Log[
									Plus[
										1,
										(E ^ ((-Tools`TimeAggregation`dc[Tools`TimeAggregation`t]) - Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1])) + E ^ (-Tools`TimeAggregation`dc[Tools`TimeAggregation`t])
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3]) - Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4]),
								E ^ (-Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3])
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
	TestID->"TimeAggregation_20231008-3CCD6C"
]
VerificationTest[
	Tools`TimeAggregation`h = 3;
	Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[
				Tools`TimeAggregation`g[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> Tools`TimeAggregation`h],
					Tools`TimeAggregation`h, "flowVariable" -> False
				],
				Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t]
			],
			Equal[
				Tools`TimeAggregation`g[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "numPeriods" -> Tools`TimeAggregation`k],
					1, Tools`TimeAggregation`k, "flowVariable" -> False
				],
				Tools`TimeAggregation`dc @ Tools`TimeAggregation`t
			],
			Equal[
				Tools`TimeAggregation`g[
					Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, {"TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k}],
					Tools`TimeAggregation`h, Tools`TimeAggregation`k, "flowVariable" -> False
				],
				Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t]
			],
			Equal[
				Tools`TimeAggregation`g[
					Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k],
					Tools`TimeAggregation`h, Tools`TimeAggregation`k, "flowVariable" -> False
				],
				Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231008-3599E6"
]
VerificationTest[
	Tools`TimeAggregation`h = 3;
	Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[Tools`TimeAggregation`g[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t], 1, "flowVariable" -> False],
				Tools`TimeAggregation`dc @ Tools`TimeAggregation`t
			],
			Equal[
				Tools`TimeAggregation`g[
					Part[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> Tools`TimeAggregation`h],
						Span[1, Tools`TimeAggregation`h * Tools`TimeAggregation`k]
					],
					Tools`TimeAggregation`h, "flowVariable" -> False
				],
				Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t]
			],
			Equal[
				Tools`TimeAggregation`g[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "numPeriods" -> Tools`TimeAggregation`k],
					1, Tools`TimeAggregation`k, "flowVariable" -> False
				],
				Tools`TimeAggregation`dc @ Tools`TimeAggregation`t
			],
			Equal[
				Tools`TimeAggregation`g[
					Part[
						Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, {"TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k}],
						Span[1, Tools`TimeAggregation`h * Tools`TimeAggregation`k]
					],
					Tools`TimeAggregation`h, Tools`TimeAggregation`k, "flowVariable" -> False
				],
				Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t]
			],
			Equal[
				Tools`TimeAggregation`g[
					Part[
						Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k],
						Span[1, Tools`TimeAggregation`h * Tools`TimeAggregation`k]
					],
					Tools`TimeAggregation`h, Tools`TimeAggregation`k, "flowVariable" -> False
				],
				Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1] + Tools`TimeAggregation`dc[Tools`TimeAggregation`t]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231008-7JQCN9"
]
VerificationTest[
	Tools`TimeAggregation`h = 3;
	Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[Tools`TimeAggregation`g[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t], "flowVariable" -> False],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{Tools`TimeAggregation`dc @ Tools`TimeAggregation`t}, "flowVariable" -> False]
			],
			Equal[
				Tools`TimeAggregation`g[
					Part[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> Tools`TimeAggregation`h],
						Span[1, (Tools`TimeAggregation`h * Tools`TimeAggregation`k) + 1]
					],
					Tools`TimeAggregation`h, "flowVariable" -> False
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{Tools`TimeAggregation`dc @ Tools`TimeAggregation`t, Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1], Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2], Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3]},
					3, "flowVariable" -> False
				]
			],
			Equal[
				Tools`TimeAggregation`g[
					Part[
						Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, {"TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k}],
						Span[1, (Tools`TimeAggregation`h * Tools`TimeAggregation`k) + 1]
					],
					Tools`TimeAggregation`h, Tools`TimeAggregation`k, "flowVariable" -> False
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{Tools`TimeAggregation`dc @ Tools`TimeAggregation`t, Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1], Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2], Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3]},
					3, 1, "flowVariable" -> False
				]
			],
			Equal[
				Tools`TimeAggregation`g[
					Part[
						Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k],
						Span[1, (Tools`TimeAggregation`h * Tools`TimeAggregation`k) + 1]
					],
					Tools`TimeAggregation`h, Tools`TimeAggregation`k, "flowVariable" -> False
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{Tools`TimeAggregation`dc @ Tools`TimeAggregation`t, Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1], Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2], Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3]},
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
	TestID->"TimeAggregation_20231008-R54CZ0"
]
VerificationTest[
	Tools`TimeAggregation`h = 3;
	Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[Tools`TimeAggregation`g[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dd, Tools`TimeAggregation`t, Tools`TimeAggregation`i], 1], Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i]],
			Equal[Tools`TimeAggregation`g[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dd, Tools`TimeAggregation`t, Tools`TimeAggregation`i, "TimeAggregation" -> Tools`TimeAggregation`h], Tools`TimeAggregation`h],
				Subtract[
					Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 2, Tools`TimeAggregation`i],
						Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, Tools`TimeAggregation`i],
							Plus[
								Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i],
								Log[
									Plus[
										1,
										Plus[
											E ^ ((-Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i]) - Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, Tools`TimeAggregation`i]),
											E ^ (-Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i])
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
									(-Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 3, Tools`TimeAggregation`i]) - Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 4, Tools`TimeAggregation`i]
								],
								E ^ (-Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 3, Tools`TimeAggregation`i])
							]
						]
					]
				]
			],
			Equal[Tools`TimeAggregation`g[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dd, Tools`TimeAggregation`t, Tools`TimeAggregation`i, "numPeriods" -> Tools`TimeAggregation`k], 1, Tools`TimeAggregation`k],
				Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i]
			],
			Equal[
				Tools`TimeAggregation`g[
					Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dd, Tools`TimeAggregation`t, Tools`TimeAggregation`i, {"TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k}],
					Tools`TimeAggregation`h, Tools`TimeAggregation`k
				],
				Subtract[
					Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 2, Tools`TimeAggregation`i],
						Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, Tools`TimeAggregation`i],
							Plus[
								Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i],
								Log[
									Plus[
										1,
										Plus[
											E ^ ((-Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i]) - Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, Tools`TimeAggregation`i]),
											E ^ (-Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i])
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
									(-Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 3, Tools`TimeAggregation`i]) - Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 4, Tools`TimeAggregation`i]
								],
								E ^ (-Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 3, Tools`TimeAggregation`i])
							]
						]
					]
				]
			],
			Equal[
				Tools`TimeAggregation`g[
					Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dd, Tools`TimeAggregation`t, Tools`TimeAggregation`i, "TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k],
					Tools`TimeAggregation`h, Tools`TimeAggregation`k
				],
				Subtract[
					Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 2, Tools`TimeAggregation`i],
						Plus[Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, Tools`TimeAggregation`i],
							Plus[
								Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i],
								Log[
									Plus[
										1,
										Plus[
											E ^ ((-Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i]) - Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 1, Tools`TimeAggregation`i]),
											E ^ (-Tools`TimeAggregation`dd[Tools`TimeAggregation`t, Tools`TimeAggregation`i])
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
									(-Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 3, Tools`TimeAggregation`i]) - Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 4, Tools`TimeAggregation`i]
								],
								E ^ (-Tools`TimeAggregation`dd[Tools`TimeAggregation`t - 3, Tools`TimeAggregation`i])
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
	TestID->"TimeAggregation_20231008-OUPHEO"
]
VerificationTest[
	Tools`TimeAggregation`h = 3;
	Tools`TimeAggregation`k = 1;
	Apply[And,
		{
			Equal[
				Tools`TimeAggregation`g[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`bondret, Tools`TimeAggregation`t, Tools`TimeAggregation`m, "TimeAggregation" -> Tools`TimeAggregation`h], Tools`TimeAggregation`h],
				Subtract[
					Plus[Tools`TimeAggregation`bondret[Tools`TimeAggregation`t - 2, Tools`TimeAggregation`m],
						Plus[Tools`TimeAggregation`bondret[Tools`TimeAggregation`t - 1, Tools`TimeAggregation`m],
							Plus[
								Tools`TimeAggregation`bondret[Tools`TimeAggregation`t, Tools`TimeAggregation`m],
								Log[
									Plus[
										1,
										Plus[
											E ^ ((-Tools`TimeAggregation`bondret[Tools`TimeAggregation`t, Tools`TimeAggregation`m]) - Tools`TimeAggregation`bondret[Tools`TimeAggregation`t - 1, Tools`TimeAggregation`m]),
											E ^ (-Tools`TimeAggregation`bondret[Tools`TimeAggregation`t, Tools`TimeAggregation`m])
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
									(-Tools`TimeAggregation`bondret[Tools`TimeAggregation`t - 3, Tools`TimeAggregation`m]) - Tools`TimeAggregation`bondret[Tools`TimeAggregation`t - 4, Tools`TimeAggregation`m]
								],
								E ^ (-Tools`TimeAggregation`bondret[Tools`TimeAggregation`t - 3, Tools`TimeAggregation`m])
							]
						]
					]
				]
			],
			Equal[Tools`TimeAggregation`g[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`bondret, Tools`TimeAggregation`t, Tools`TimeAggregation`m, "numPeriods" -> Tools`TimeAggregation`k], 1, Tools`TimeAggregation`k],
				Tools`TimeAggregation`bondret[Tools`TimeAggregation`t, Tools`TimeAggregation`m]
			],
			Equal[
				Tools`TimeAggregation`g[
					Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`bondret, Tools`TimeAggregation`t, Tools`TimeAggregation`m, {"TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k}],
					Tools`TimeAggregation`h, Tools`TimeAggregation`k
				],
				Subtract[
					Plus[Tools`TimeAggregation`bondret[Tools`TimeAggregation`t - 2, Tools`TimeAggregation`m],
						Plus[Tools`TimeAggregation`bondret[Tools`TimeAggregation`t - 1, Tools`TimeAggregation`m],
							Plus[
								Tools`TimeAggregation`bondret[Tools`TimeAggregation`t, Tools`TimeAggregation`m],
								Log[
									Plus[
										1,
										Plus[
											E ^ ((-Tools`TimeAggregation`bondret[Tools`TimeAggregation`t, Tools`TimeAggregation`m]) - Tools`TimeAggregation`bondret[Tools`TimeAggregation`t - 1, Tools`TimeAggregation`m]),
											E ^ (-Tools`TimeAggregation`bondret[Tools`TimeAggregation`t, Tools`TimeAggregation`m])
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
									(-Tools`TimeAggregation`bondret[Tools`TimeAggregation`t - 3, Tools`TimeAggregation`m]) - Tools`TimeAggregation`bondret[Tools`TimeAggregation`t - 4, Tools`TimeAggregation`m]
								],
								E ^ (-Tools`TimeAggregation`bondret[Tools`TimeAggregation`t - 3, Tools`TimeAggregation`m])
							]
						]
					]
				]
			],
			Equal[
				Tools`TimeAggregation`g[
					Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`bondret, Tools`TimeAggregation`t, Tools`TimeAggregation`m, "TimeAggregation" -> Tools`TimeAggregation`h, "numPeriods" -> Tools`TimeAggregation`k],
					Tools`TimeAggregation`h, Tools`TimeAggregation`k
				],
				Subtract[
					Plus[Tools`TimeAggregation`bondret[Tools`TimeAggregation`t - 2, Tools`TimeAggregation`m],
						Plus[Tools`TimeAggregation`bondret[Tools`TimeAggregation`t - 1, Tools`TimeAggregation`m],
							Plus[
								Tools`TimeAggregation`bondret[Tools`TimeAggregation`t, Tools`TimeAggregation`m],
								Log[
									Plus[
										1,
										Plus[
											E ^ ((-Tools`TimeAggregation`bondret[Tools`TimeAggregation`t, Tools`TimeAggregation`m]) - Tools`TimeAggregation`bondret[Tools`TimeAggregation`t - 1, Tools`TimeAggregation`m]),
											E ^ (-Tools`TimeAggregation`bondret[Tools`TimeAggregation`t, Tools`TimeAggregation`m])
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
									(-Tools`TimeAggregation`bondret[Tools`TimeAggregation`t - 3, Tools`TimeAggregation`m]) - Tools`TimeAggregation`bondret[Tools`TimeAggregation`t - 4, Tools`TimeAggregation`m]
								],
								E ^ (-Tools`TimeAggregation`bondret[Tools`TimeAggregation`t - 3, Tools`TimeAggregation`m])
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
	TestID->"TimeAggregation_20231008-YNM7TX"
]
VerificationTest[
	Apply[And,
		{
			Equal[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t], {Tools`TimeAggregation`dc @ Tools`TimeAggregation`t}],
			Equal[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 3],
				{
					Tools`TimeAggregation`dc @ Tools`TimeAggregation`t,
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4]
				}
			],
			Equal[Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "numPeriods" -> 6],
				{
					Tools`TimeAggregation`dc @ Tools`TimeAggregation`t,
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 5]
				}
			],
			Equal[
				Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, {"TimeAggregation" -> 12, "numPeriods" -> 3}],
				{
					Tools`TimeAggregation`dc @ Tools`TimeAggregation`t,
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 5],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 6],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 7],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 8],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 9],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 10],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 11],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 12],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 13],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 14],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 15],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 16],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 17],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 18],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 19],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 20],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 21],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 22],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 23],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 24],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 25],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 26],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 27],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 28],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 29],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 30],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 31],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 32],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 33],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 34],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 35],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 36],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 37],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 38],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 39],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 40],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 41],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 42],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 43],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 44],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 45],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 46]
				}
			],
			Equal[
				Tools`TimeAggregation`timeSeriesVector[Tools`TimeAggregation`dc, Tools`TimeAggregation`t, "TimeAggregation" -> 12, "numPeriods" -> 3],
				{
					Tools`TimeAggregation`dc @ Tools`TimeAggregation`t,
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 1],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 2],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 3],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 4],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 5],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 6],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 7],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 8],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 9],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 10],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 11],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 12],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 13],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 14],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 15],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 16],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 17],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 18],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 19],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 20],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 21],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 22],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 23],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 24],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 25],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 26],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 27],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 28],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 29],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 30],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 31],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 32],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 33],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 34],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 35],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 36],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 37],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 38],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 39],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 40],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 41],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 42],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 43],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 44],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 45],
					Tools`TimeAggregation`dc[Tools`TimeAggregation`t - 46]
				}
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231008-WPGXRF"
]
VerificationTest[
	On[General::stop];
	True
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231008-6QIC3T"
] 
End[]
EndTestSection[]
