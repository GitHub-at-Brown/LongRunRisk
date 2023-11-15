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
	TestID->"TimeAggregation_20231114-W8ON38"
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
	TestID->"TimeAggregation_20231114-0PNJO5"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"];
	True
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231114-D59EHX"
]
VerificationTest[
	!SameQ[Names @ "*growth", {}]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231114-5BSTWQ"
]
VerificationTest[
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc, t], dc @ t],
			Equal[FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc, t, "TimeAggregation" -> 1, "numPeriods" -> 1],
				dc @ t
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231114-E4C3YS"
]
VerificationTest[
	Apply[And,
		{
			Equal[FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1],
				Times[1 / 3,
					Plus[dc[t - 4],
						Plus[2 * dc[t - 3],
							(3 * dc[t - 2]) + (2 * dc[t - 1]) + dc[t]
						]
					]
				]
			],
			Equal[
				ReplaceAll[
					ReplaceAll[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc, t, "TimeAggregation" -> 12, "numPeriods" -> 1] /. Plus -> List,
							Times -> List
						],
						dc[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`x__, t}] -> (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`x)
					],
					dc[t] -> 0
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
	TestID->"TimeAggregation_20231114-ZIROF9"
]
VerificationTest[
	Apply[And,
		{
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc,
					t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j, h, k, v, im}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * dc[t - 4],
						Plus[0.6661665418542368 * dc[t - 3],
							Plus[
								dc[t - 2],
								(0.6671665414792372 * dc[t - 1]) + 0.33383345814576315 * dc[t]
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc,
					t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j, h, k, v}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * dc[t - 4],
						Plus[0.6661665418542368 * dc[t - 3],
							Plus[
								dc[t - 2],
								(0.6671665414792372 * dc[t - 1]) + 0.33383345814576315 * dc[t]
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc,
					t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j, h, k}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * dc[t - 4],
						Plus[0.6661665418542368 * dc[t - 3],
							Plus[
								dc[t - 2],
								(0.6671665414792372 * dc[t - 1]) + 0.33383345814576315 * dc[t]
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc,
					t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j, h}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * dc[t - 4],
						Plus[0.6661665418542368 * dc[t - 3],
							Plus[
								dc[t - 2],
								(0.6671665414792372 * dc[t - 1]) + 0.33383345814576315 * dc[t]
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc,
					t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * dc[t - 4],
						Plus[0.6661665418542368 * dc[t - 3],
							Plus[
								dc[t - 2],
								(0.6671665414792372 * dc[t - 1]) + 0.33383345814576315 * dc[t]
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc,
					t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * dc[t - 4],
						Plus[0.6661665418542368 * dc[t - 3],
							Plus[
								dc[t - 2],
								(0.6671665414792372 * dc[t - 1]) + 0.33383345814576315 * dc[t]
							]
						]
					]
				]
			],
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc,
					t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{}, 0.0015]
				],
				Plus[0.,
					Plus[0.3328334585207629 * dc[t - 4],
						Plus[0.6661665418542368 * dc[t - 3],
							Plus[
								dc[t - 2],
								(0.6671665414792372 * dc[t - 1]) + 0.33383345814576315 * dc[t]
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
	TestID->"TimeAggregation_20231114-25EQY9"
]
VerificationTest[
	Apply[And,
		{
			Equal[
				Simplify[
					FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc,
						t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j, h, k, v, im}, t]
					]
				],
				Times[1 / (1 + (E ^ t) + E ^ (2 * t)),
					Plus[dc[t - 4],
						Plus[(1 + E ^ t) * dc[t - 3],
							Plus[
								dc[t - 2],
								Plus[
									(E ^ t) * dc[t - 2],
									Plus[
										(E ^ (2 * t)) * dc[t - 2],
										Plus[
											(E ^ t) * dc[t - 1],
											((E ^ (2 * t)) * dc[t - 1]) + (E ^ (2 * t)) * dc[t]
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
	TestID->"TimeAggregation_20231114-CWZX0J"
]
VerificationTest[
	Apply[And,
		{
			FreeQ[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc,
					t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[
						{t, j, h, k, v, im},
						If[Equal[h, 12], h12, hnot12]
					]
				],
				h12
			],
			FreeQ[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc,
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
	TestID->"TimeAggregation_20231114-0603ZH"
]
VerificationTest[
	Apply[And,
		{
			SameQ[0,
				FullSimplify[
					Coefficient[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
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
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								dc, t, "TimeAggregation" -> 3, "numPeriods" -> 3, "v0" -> Function[{t, j, h, k, v, im}, h ^ 2]
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
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j, h, k, v, im}, im]
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
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
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
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
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
	TestID->"TimeAggregation_20231114-J5NVH4"
]
VerificationTest[
	arbitraryFun1 = Function[{t, j, h, k, v}, Sqrt @ h];
	arbitraryFun2 = Function[{t, j, h, k, v},
		If[Equal[v, dd], Sqrt @ h, Cos @ h]
	];
	arbitraryFun3 = Function[{t, j, h, k, v}, -h];
	arbitraryFun4 = Function[{t, j, h, k, v},
		(Sqrt[h] * t) - k ^ 2
	];
	arbitraryFun5 = Function[{t, j, h, k, v},
		If[Equal[v, dd],
			Sqrt[h] * Sqrt[t],
			Exp[t] * Cos[h]
		]
	];
	arbitraryFun6 = Function[{t, j, h, k, v}, (-h) * t * k];
	Apply[And,
		{
			N[
				ReplaceAll[
					SameQ[0,
						FullSimplify[
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
										dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j, h, k, v, im}, F[h, v, im]]
									],
									dc[__] -> dcX
								],
								dcX, 0
							]
						]
					],
					F -> arbitraryFun1
				]
			],
			N[
				ReplaceAll[
					SameQ[0,
						FullSimplify[
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
										dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j, h, k, v, im}, F[h, v, im]]
									],
									dc[__] -> dcX
								],
								dcX, 0
							]
						]
					],
					F -> arbitraryFun2
				]
			],
			N[
				ReplaceAll[
					SameQ[0,
						FullSimplify[
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
										dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j, h, k, v, im}, F[h, v, im]]
									],
									dc[__] -> dcX
								],
								dcX, 0
							]
						]
					],
					F -> arbitraryFun3
				]
			],
			N[
				ReplaceAll[
					SameQ[0,
						FullSimplify[
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
										dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j, h, k, v, im}, F[h, v, im]]
									],
									dc[__] -> dcX
								],
								dcX, 0
							]
						]
					],
					F -> arbitraryFun4
				]
			],
			N[
				ReplaceAll[
					SameQ[0,
						FullSimplify[
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
										dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j, h, k, v, im}, F[h, v, im]]
									],
									dc[__] -> dcX
								],
								dcX, 0
							]
						]
					],
					F -> arbitraryFun5
				]
			],
			N[
				ReplaceAll[
					SameQ[0,
						FullSimplify[
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
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
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231114-KHBHWB"
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
									dc, t, "TimeAggregation" -> 3, "numPeriods" -> 3, "v0" -> Function[{t, j, h, k, v, im}, j]
								],
								dc[__] -> dcX
							],
							dcX, 0
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
	TestID->"TimeAggregation_20231114-D1SPUQ"
]
VerificationTest[
	Apply[And,
		{
			Equal[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc,
					t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j}, j]
				],
				Subtract[
					Plus[
						Divide[
							Subtract[
								Subtract[
									dc[t - 4] + dc[t - 3] + (E ^ 4) * dc[t - 3],
									7
								],
								3 * E ^ 4
							],
							1 + (E ^ 4) + E ^ 7
						],
						Plus[dc[t - 2],
							Plus[
								dc[t - 1],
								Plus[
									dc @ t,
									Plus[
										Divide[
											((1 - E * dc[t]) - dc[t]) - dc[t - 1],
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
	TestID->"TimeAggregation_20231114-KMLM1K"
]
VerificationTest[
	Apply[And,
		{
			Not[
				FreeQ[
					FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc,
						t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[
							{t, j, h, k, v, im},
							If[SameQ[v, dc], Edc, 0]
						]
					],
					Edc
				]
			],
			FreeQ[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[pi,
					t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[
						{t, j, h, k, v, im},
						If[SameQ[v, dc], Edc, 0]
					]
				],
				Edc
			],
			Not[
				FreeQ[
					FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dd,
						t, i, "TimeAggregation" -> 12, "numPeriods" -> 1, "v0" -> Function[
							{t, j, h, k, v, im},
							If[SameQ[v, dd], Edd, 0]
						]
					],
					Edd
				]
			],
			FreeQ[
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc,
					t, "TimeAggregation" -> 12, "numPeriods" -> 1, "v0" -> Function[
						{t, j, h, k, v, im},
						If[SameQ[v, dd], Edd, 0]
					]
				],
				Edd
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231114-TP9WOS"
]
VerificationTest[
	Apply[And,
		{
			Equal[
				ReplaceAll[
					FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc,
						t, "TimeAggregation" -> 3, "numPeriods" -> 1, "v0" -> Function[{t, j, h, k, v, im}, Evaluate[uncondE[dc[t]]]]
					],
					uncondE[dc[t]] -> 0
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231114-ZSA0OV"
]
VerificationTest[
	h = 1;
	k = 1;
	Apply[And,
		{
			Simplify[
				SameQ[0,
					Coefficient[
						ReplaceAll[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
								dc, t, "TimeAggregation" -> h, "numPeriods" -> k, "v0" -> Function[{t, j, h, k, v, im}, F[t]]
							],
							dc[__] -> dcX
						],
						dcX, 0
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
	TestID->"TimeAggregation_20231114-MGBZVI"
]
VerificationTest[
	h = 2;
	k = 1;
	rulej = Table[F[i] -> F[(h * k) + i],
		{i, 0, h - 2}
	];
	Apply[And,
		{
			FullSimplify[
				SameQ[0,
					Coefficient[
						ReplaceAll[
							ReplaceAll[
								FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
									dc, t, "TimeAggregation" -> h, "numPeriods" -> k, "v0" -> Function[{t, j, h, k, v, im}, F[j]]
								],
								rulej
							],
							dc[__] -> dcX
						],
						dcX, 0
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
	TestID->"TimeAggregation_20231114-THJZ4H"
]
VerificationTest[
	h = 3;
	k = 1;
	rulej = Table[F[i] -> F[(h * k) + i],
		{i, 0, h - 2}
	];
	Apply[And,
		{
			FullSimplify[
				SameQ[0,
					Coefficient[
						ReplaceAll[
							ReplaceAll[
								FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
									dc, t, "TimeAggregation" -> h, "numPeriods" -> k, "v0" -> Function[{t, j, h, k, v, im}, F[j]]
								],
								rulej
							],
							dc[__] -> dcX
						],
						dcX, 0
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
	TestID->"TimeAggregation_20231114-EV6LIL"
]
VerificationTest[
	h = 4;
	k = 1;
	rulej = Table[F[i] -> F[(h * k) + i],
		{i, 0, h - 2}
	];
	Apply[And,
		{
			FullSimplify[
				SameQ[0,
					Coefficient[
						ReplaceAll[
							ReplaceAll[
								FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
									dc, t, "TimeAggregation" -> h, "numPeriods" -> k, "v0" -> Function[{t, j, h, k, v, im}, F[j]]
								],
								rulej
							],
							dc[__] -> dcX
						],
						dcX, 0
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
	TestID->"TimeAggregation_20231114-W9MCKG"
]
VerificationTest[
	Apply[And,
		{
			SameQ[
				Cases[
					Expand[
						FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 0]
					],
					Times[Optional[coef_], Power[dc[__], Optional[p_]]] :> p
				],
				{}
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 1]
						],
						Times[Optional[coef_], Power[dc[__], Optional[p_]]] :> p
					]
				],
				1
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 2]
						],
						Times[Optional[coef_], Power[dc[__], Optional[p_]]] :> p
					]
				],
				2
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 3]
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
	TestID->"TimeAggregation_20231114-G12P01"
]
VerificationTest[
	Apply[And,
		{
			SameQ[
				Cases[
					Expand[
						FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dd, t, i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 0]
					],
					Times[Optional[coef_], Power[dd[__, i], Optional[p_]]] :> p
				],
				{}
			],
			SameQ[
				Max[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dd, t, i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 1]
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
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dd, t, i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 2]
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
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[dd, t, i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 3]
						],
						Times[Optional[coef_], Power[dd[__, i], Optional[p_]]] :> p
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
	TestID->"TimeAggregation_20231114-EQ8DR8"
]
VerificationTest[
	f = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`f;
	g = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g;
	s = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`s;
	timeSeriesVector = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`timeSeriesVector;
	gt = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`gt;
	True
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231114-HSN4JG"
]
VerificationTest[
	h = 3;
	k = 2;
	Apply[And,
		{
			Equal[gt[dc, t], dc @ t],
			Equal[gt[dc, t, {"TimeAggregation" -> 3, "numPeriods" -> k}],
				Subtract[
					Plus[dc[t - 5],
						Plus[dc[t - 4],
							Plus[
								dc[t - 3],
								Plus[
									dc[t - 2],
									Plus[
										dc[t - 1],
										Plus[
											dc @ t,
											Log[
												Plus[
													1,
													(E ^ ((-dc[t]) - dc[t - 1])) + E ^ (-dc[t])
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
								E ^ ((-dc[t - 6]) - dc[t - 7]),
								E ^ (-dc[t - 6])
							]
						]
					]
				]
			],
			Equal[gt[dc, t, "TimeAggregation" -> 3, "numPeriods" -> k],
				Subtract[
					Plus[dc[t - 5],
						Plus[dc[t - 4],
							Plus[
								dc[t - 3],
								Plus[
									dc[t - 2],
									Plus[
										dc[t - 1],
										Plus[
											dc @ t,
											Log[
												Plus[
													1,
													(E ^ ((-dc[t]) - dc[t - 1])) + E ^ (-dc[t])
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
								E ^ ((-dc[t - 6]) - dc[t - 7]),
								E ^ (-dc[t - 6])
							]
						]
					]
				]
			],
			Equal[gt[dd, t, i, {"TimeAggregation" -> 3, "numPeriods" -> k}],
				Subtract[
					Plus[dd[t - 5, i],
						Plus[dd[t - 4, i],
							Plus[
								dd[t - 3, i],
								Plus[
									dd[t - 2, i],
									Plus[
										dd[t - 1, i],
										Plus[
											dd[t, i],
											Log[
												Plus[
													1,
													Plus[
														E ^ ((-dd[t, i]) - dd[t - 1, i]),
														E ^ (-dd[t, i])
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
									(-dd[t - 6, i]) - dd[t - 7, i]
								],
								E ^ (-dd[t - 6, i])
							]
						]
					]
				]
			],
			Equal[gt[dd, t, i, "TimeAggregation" -> 3, "numPeriods" -> k],
				Subtract[
					Plus[dd[t - 5, i],
						Plus[dd[t - 4, i],
							Plus[
								dd[t - 3, i],
								Plus[
									dd[t - 2, i],
									Plus[
										dd[t - 1, i],
										Plus[
											dd[t, i],
											Log[
												Plus[
													1,
													Plus[
														E ^ ((-dd[t, i]) - dd[t - 1, i]),
														E ^ (-dd[t, i])
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
									(-dd[t - 6, i]) - dd[t - 7, i]
								],
								E ^ (-dd[t - 6, i])
							]
						]
					]
				]
			],
			Equal[gt[dd, t, 1, {"TimeAggregation" -> 3, "numPeriods" -> k}],
				Subtract[
					Plus[dd[t - 5, 1],
						Plus[dd[t - 4, 1],
							Plus[
								dd[t - 3, 1],
								Plus[
									dd[t - 2, 1],
									Plus[
										dd[t - 1, 1],
										Plus[
											dd[t, 1],
											Log[
												Plus[
													1,
													Plus[
														E ^ ((-dd[t, 1]) - dd[t - 1, 1]),
														E ^ (-dd[t, 1])
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
									(-dd[t - 6, 1]) - dd[t - 7, 1]
								],
								E ^ (-dd[t - 6, 1])
							]
						]
					]
				]
			],
			Equal[gt[dd, t, 2, "TimeAggregation" -> 3, "numPeriods" -> k],
				Subtract[
					Plus[dd[t - 5, 2],
						Plus[dd[t - 4, 2],
							Plus[
								dd[t - 3, 2],
								Plus[
									dd[t - 2, 2],
									Plus[
										dd[t - 1, 2],
										Plus[
											dd[t, 2],
											Log[
												Plus[
													1,
													Plus[
														E ^ ((-dd[t, 2]) - dd[t - 1, 2]),
														E ^ (-dd[t, 2])
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
									(-dd[t - 6, 2]) - dd[t - 7, 2]
								],
								E ^ (-dd[t - 6, 2])
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
	TestID->"TimeAggregation_20231114-4PO5OJ"
]
VerificationTest[
	h = 3;
	k = 2;
	Apply[And,
		{
			Equal[gt[dc, t], dc @ t],
			Equal[gt[dc, t, "Variable" -> "Stock"], dc @ t],
			Equal[gt[dc, t, "TimeAggregation" -> 3, "Variable" -> "Stock"],
				dc[t - 2] + dc[t - 1] + dc[t]
			],
			Equal[gt[dd, t, i, {"numPeriods" -> k}, "Variable" -> "Stock"],
				dd[t - 1, i] + dd[t, i]
			],
			Equal[gt[dd, t, i, "Variable" -> "Stock"], dd[t, i]],
			Equal[gt[dd, t, 1, {"TimeAggregation" -> 3}, "Variable" -> "Stock"],
				dd[t - 2, 1] + dd[t - 1, 1] + dd[t, 1]
			],
			Equal[gt[dd, t, 2, "Variable" -> "Stock"], dd[t, 2]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231114-7Y1W4O"
]
VerificationTest[
	h = 3;
	k = 2;
	Apply[And,
		{
			Equal[gt[dc, t], dc @ t],
			Equal[
				gt[dc,
					t,
					{"TimeAggregation" -> h, "numPeriods" -> k},
					"Variable" -> "Stock"
				],
				Plus[dc[t - 5],
					Plus[dc[t - 4],
						dc[t - 3] + dc[t - 2] + dc[t - 1] + dc[t]
					]
				]
			],
			Equal[
				gt[dc, t, "TimeAggregation" -> h, "numPeriods" -> k, "Variable" -> "Stock"],
				Plus[dc[t - 5],
					Plus[dc[t - 4],
						dc[t - 3] + dc[t - 2] + dc[t - 1] + dc[t]
					]
				]
			],
			Equal[
				gt[dd,
					t, i, {"TimeAggregation" -> h, "numPeriods" -> k},
					"Variable" -> "Stock"
				],
				Plus[dd[t - 5, i],
					Plus[dd[t - 4, i],
						Plus[dd[t - 3, i],
							dd[t - 2, i] + dd[t - 1, i] + dd[t, i]
						]
					]
				]
			],
			Equal[
				gt[dd,
					t, i, "TimeAggregation" -> h, "numPeriods" -> k, "Variable" -> "Stock"
				],
				Plus[dd[t - 5, i],
					Plus[dd[t - 4, i],
						Plus[dd[t - 3, i],
							dd[t - 2, i] + dd[t - 1, i] + dd[t, i]
						]
					]
				]
			],
			Equal[
				gt[dd,
					t, 1, {"TimeAggregation" -> h, "numPeriods" -> k},
					"Variable" -> "Stock"
				],
				Plus[dd[t - 5, 1],
					Plus[dd[t - 4, 1],
						Plus[dd[t - 3, 1],
							dd[t - 2, 1] + dd[t - 1, 1] + dd[t, 1]
						]
					]
				]
			],
			Equal[
				gt[dd,
					t, 2, "TimeAggregation" -> h, "numPeriods" -> k, "Variable" -> "Stock"
				],
				Plus[dd[t - 5, 2],
					Plus[dd[t - 4, 2],
						Plus[dd[t - 3, 2],
							dd[t - 2, 2] + dd[t - 1, 2] + dd[t, 2]
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
	TestID->"TimeAggregation_20231114-X96JPO"
]
VerificationTest[
	h = 3;
	k = 1;
	Apply[And,
		{
			Equal[g[timeSeriesVector[dc, t, "TimeAggregation" -> h], h],
				Subtract[
					Plus[dc[t - 2],
						Plus[dc[t - 1],
							Plus[
								dc @ t,
								Log[
									Plus[
										1,
										(E ^ ((-dc[t]) - dc[t - 1])) + E ^ (-dc[t])
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-dc[t - 3]) - dc[t - 4]),
								E ^ (-dc[t - 3])
							]
						]
					]
				]
			],
			Equal[g[timeSeriesVector[dc, t, "numPeriods" -> k], 1, k], dc @ t],
			Equal[
				g[
					timeSeriesVector[dc, t, {"TimeAggregation" -> h, "numPeriods" -> k}],
					h, k
				],
				Subtract[
					Plus[dc[t - 2],
						Plus[dc[t - 1],
							Plus[
								dc @ t,
								Log[
									Plus[
										1,
										(E ^ ((-dc[t]) - dc[t - 1])) + E ^ (-dc[t])
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-dc[t - 3]) - dc[t - 4]),
								E ^ (-dc[t - 3])
							]
						]
					]
				]
			],
			Equal[
				g[
					timeSeriesVector[dc, t, "TimeAggregation" -> h, "numPeriods" -> k],
					h, k
				],
				Subtract[
					Plus[dc[t - 2],
						Plus[dc[t - 1],
							Plus[
								dc @ t,
								Log[
									Plus[
										1,
										(E ^ ((-dc[t]) - dc[t - 1])) + E ^ (-dc[t])
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-dc[t - 3]) - dc[t - 4]),
								E ^ (-dc[t - 3])
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
	TestID->"TimeAggregation_20231114-BKUGKQ"
]
VerificationTest[
	h = 3;
	k = 1;
	Apply[And,
		{
			Equal[g[timeSeriesVector[dc, t], h], FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{dc @ t}, 3]],
			Equal[
				g[Part[timeSeriesVector[dc, t, "TimeAggregation" -> h], 1;;-2],
					h
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{dc @ t, dc[t - 1], dc[t - 2], dc[t - 3]},
					3
				]
			],
			Equal[
				g[Part[timeSeriesVector[dc, t, "numPeriods" -> k], 1;;-2], 1, k],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{}, 1, 1]
			],
			Equal[
				g[
					Part[
						timeSeriesVector[dc, t, {"TimeAggregation" -> h, "numPeriods" -> k}],
						1;;-2
					],
					h, k
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{dc @ t, dc[t - 1], dc[t - 2], dc[t - 3]},
					3, 1
				]
			],
			Equal[
				g[
					Part[
						timeSeriesVector[dc, t, "TimeAggregation" -> h, "numPeriods" -> k],
						1;;-2
					],
					h, k
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{dc @ t, dc[t - 1], dc[t - 2], dc[t - 3]},
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
	TestID->"TimeAggregation_20231114-L83FCW"
]
VerificationTest[
	h = 3;
	k = 1;
	Apply[And,
		{
			Equal[
				g[timeSeriesVector[dc, t, "TimeAggregation" -> h],
					h, "Variable" -> "Flow"
				],
				Subtract[
					Plus[dc[t - 2],
						Plus[dc[t - 1],
							Plus[
								dc @ t,
								Log[
									Plus[
										1,
										(E ^ ((-dc[t]) - dc[t - 1])) + E ^ (-dc[t])
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-dc[t - 3]) - dc[t - 4]),
								E ^ (-dc[t - 3])
							]
						]
					]
				]
			],
			Equal[
				g[timeSeriesVector[dc, t, "numPeriods" -> k],
					1, k, "Variable" -> "Flow"
				],
				dc @ t
			],
			Equal[
				g[
					timeSeriesVector[dc, t, {"TimeAggregation" -> h, "numPeriods" -> k}],
					h, k, "Variable" -> "Flow"
				],
				Subtract[
					Plus[dc[t - 2],
						Plus[dc[t - 1],
							Plus[
								dc @ t,
								Log[
									Plus[
										1,
										(E ^ ((-dc[t]) - dc[t - 1])) + E ^ (-dc[t])
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-dc[t - 3]) - dc[t - 4]),
								E ^ (-dc[t - 3])
							]
						]
					]
				]
			],
			Equal[
				g[
					timeSeriesVector[dc, t, "TimeAggregation" -> h, "numPeriods" -> k],
					h, k, "Variable" -> "Flow"
				],
				Subtract[
					Plus[dc[t - 2],
						Plus[dc[t - 1],
							Plus[
								dc @ t,
								Log[
									Plus[
										1,
										(E ^ ((-dc[t]) - dc[t - 1])) + E ^ (-dc[t])
									]
								]
							]
						]
					],
					Log[
						Plus[1,
							Plus[
								E ^ ((-dc[t - 3]) - dc[t - 4]),
								E ^ (-dc[t - 3])
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
	TestID->"TimeAggregation_20231114-385D6O"
]
VerificationTest[
	h = 3;
	k = 1;
	Apply[And,
		{
			Equal[
				g[timeSeriesVector[dc, t, "TimeAggregation" -> h],
					h, "Variable" -> "Stock"
				],
				dc[t - 2] + dc[t - 1] + dc[t]
			],
			Equal[
				g[timeSeriesVector[dc, t, "numPeriods" -> k],
					1, k, "Variable" -> "Stock"
				],
				dc @ t
			],
			Equal[
				g[
					timeSeriesVector[dc, t, {"TimeAggregation" -> h, "numPeriods" -> k}],
					h, k, "Variable" -> "Stock"
				],
				dc[t - 2] + dc[t - 1] + dc[t]
			],
			Equal[
				g[
					timeSeriesVector[dc, t, "TimeAggregation" -> h, "numPeriods" -> k],
					h, k, "Variable" -> "Stock"
				],
				dc[t - 2] + dc[t - 1] + dc[t]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231114-62V5T6"
]
VerificationTest[
	h = 3;
	k = 1;
	Apply[And,
		{
			Equal[g[timeSeriesVector[dc, t], 1, "Variable" -> "Stock"], dc @ t],
			Equal[
				g[
					Part[timeSeriesVector[dc, t, "TimeAggregation" -> h],
						Span[1, h * k]
					],
					h, "Variable" -> "Stock"
				],
				dc[t - 2] + dc[t - 1] + dc[t]
			],
			Equal[
				g[timeSeriesVector[dc, t, "numPeriods" -> k],
					1, k, "Variable" -> "Stock"
				],
				dc @ t
			],
			Equal[
				g[
					Part[
						timeSeriesVector[dc, t, {"TimeAggregation" -> h, "numPeriods" -> k}],
						Span[1, h * k]
					],
					h, k, "Variable" -> "Stock"
				],
				dc[t - 2] + dc[t - 1] + dc[t]
			],
			Equal[
				g[
					Part[
						timeSeriesVector[dc, t, "TimeAggregation" -> h, "numPeriods" -> k],
						Span[1, h * k]
					],
					h, k, "Variable" -> "Stock"
				],
				dc[t - 2] + dc[t - 1] + dc[t]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231114-S8Q48A"
]
VerificationTest[
	h = 3;
	k = 1;
	Apply[And,
		{
			Equal[g[timeSeriesVector[dc, t], "Variable" -> "Stock"],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{dc @ t}, "Variable" -> "Stock"]
			],
			Equal[
				g[
					Part[timeSeriesVector[dc, t, "TimeAggregation" -> h],
						Span[1, (h * k) + 1]
					],
					h, "Variable" -> "Stock"
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{dc @ t, dc[t - 1], dc[t - 2], dc[t - 3]},
					3, "Variable" -> "Stock"
				]
			],
			Equal[
				g[
					Part[
						timeSeriesVector[dc, t, {"TimeAggregation" -> h, "numPeriods" -> k}],
						Span[1, (h * k) + 1]
					],
					h, k, "Variable" -> "Stock"
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{dc @ t, dc[t - 1], dc[t - 2], dc[t - 3]},
					3, 1, "Variable" -> "Stock"
				]
			],
			Equal[
				g[
					Part[
						timeSeriesVector[dc, t, "TimeAggregation" -> h, "numPeriods" -> k],
						Span[1, (h * k) + 1]
					],
					h, k, "Variable" -> "Stock"
				],
				FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{dc @ t, dc[t - 1], dc[t - 2], dc[t - 3]},
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
	TestID->"TimeAggregation_20231114-XHS940"
]
VerificationTest[
	h = 3;
	k = 1;
	Apply[And,
		{
			Equal[g[timeSeriesVector[dd, t, i], 1], dd[t, i]],
			Equal[g[timeSeriesVector[dd, t, i, "TimeAggregation" -> h], h],
				Subtract[
					Plus[dd[t - 2, i],
						Plus[dd[t - 1, i],
							Plus[
								dd[t, i],
								Log[
									Plus[
										1,
										Plus[
											E ^ ((-dd[t, i]) - dd[t - 1, i]),
											E ^ (-dd[t, i])
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
									(-dd[t - 3, i]) - dd[t - 4, i]
								],
								E ^ (-dd[t - 3, i])
							]
						]
					]
				]
			],
			Equal[g[timeSeriesVector[dd, t, i, "numPeriods" -> k], 1, k],
				dd[t, i]
			],
			Equal[
				g[
					timeSeriesVector[dd, t, i, {"TimeAggregation" -> h, "numPeriods" -> k}],
					h, k
				],
				Subtract[
					Plus[dd[t - 2, i],
						Plus[dd[t - 1, i],
							Plus[
								dd[t, i],
								Log[
									Plus[
										1,
										Plus[
											E ^ ((-dd[t, i]) - dd[t - 1, i]),
											E ^ (-dd[t, i])
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
									(-dd[t - 3, i]) - dd[t - 4, i]
								],
								E ^ (-dd[t - 3, i])
							]
						]
					]
				]
			],
			Equal[
				g[
					timeSeriesVector[dd, t, i, "TimeAggregation" -> h, "numPeriods" -> k],
					h, k
				],
				Subtract[
					Plus[dd[t - 2, i],
						Plus[dd[t - 1, i],
							Plus[
								dd[t, i],
								Log[
									Plus[
										1,
										Plus[
											E ^ ((-dd[t, i]) - dd[t - 1, i]),
											E ^ (-dd[t, i])
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
									(-dd[t - 3, i]) - dd[t - 4, i]
								],
								E ^ (-dd[t - 3, i])
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
	TestID->"TimeAggregation_20231114-A885RZ"
]
VerificationTest[
	h = 3;
	k = 1;
	Apply[And,
		{
			Equal[
				g[timeSeriesVector[bondret, t, m, "TimeAggregation" -> h], h],
				Subtract[
					Plus[bondret[t - 2, m],
						Plus[bondret[t - 1, m],
							Plus[
								bondret[t, m],
								Log[
									Plus[
										1,
										Plus[
											E ^ ((-bondret[t, m]) - bondret[t - 1, m]),
											E ^ (-bondret[t, m])
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
									(-bondret[t - 3, m]) - bondret[t - 4, m]
								],
								E ^ (-bondret[t - 3, m])
							]
						]
					]
				]
			],
			Equal[g[timeSeriesVector[bondret, t, m, "numPeriods" -> k], 1, k],
				bondret[t, m]
			],
			Equal[
				g[
					timeSeriesVector[bondret, t, m, {"TimeAggregation" -> h, "numPeriods" -> k}],
					h, k
				],
				Subtract[
					Plus[bondret[t - 2, m],
						Plus[bondret[t - 1, m],
							Plus[
								bondret[t, m],
								Log[
									Plus[
										1,
										Plus[
											E ^ ((-bondret[t, m]) - bondret[t - 1, m]),
											E ^ (-bondret[t, m])
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
									(-bondret[t - 3, m]) - bondret[t - 4, m]
								],
								E ^ (-bondret[t - 3, m])
							]
						]
					]
				]
			],
			Equal[
				g[
					timeSeriesVector[bondret, t, m, "TimeAggregation" -> h, "numPeriods" -> k],
					h, k
				],
				Subtract[
					Plus[bondret[t - 2, m],
						Plus[bondret[t - 1, m],
							Plus[
								bondret[t, m],
								Log[
									Plus[
										1,
										Plus[
											E ^ ((-bondret[t, m]) - bondret[t - 1, m]),
											E ^ (-bondret[t, m])
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
									(-bondret[t - 3, m]) - bondret[t - 4, m]
								],
								E ^ (-bondret[t - 3, m])
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
	TestID->"TimeAggregation_20231114-B932Q5"
]
VerificationTest[
	Apply[And,
		{
			Equal[timeSeriesVector[dc, t], {dc @ t}],
			Equal[timeSeriesVector[dc, t, "TimeAggregation" -> 3],
				{
					dc @ t,
					dc[t - 1],
					dc[t - 2],
					dc[t - 3],
					dc[t - 4]
				}
			],
			Equal[timeSeriesVector[dc, t, "numPeriods" -> 6],
				{
					dc @ t,
					dc[t - 1],
					dc[t - 2],
					dc[t - 3],
					dc[t - 4],
					dc[t - 5]
				}
			],
			Equal[
				timeSeriesVector[dc, t, {"TimeAggregation" -> 12, "numPeriods" -> 3}],
				{
					dc @ t,
					dc[t - 1],
					dc[t - 2],
					dc[t - 3],
					dc[t - 4],
					dc[t - 5],
					dc[t - 6],
					dc[t - 7],
					dc[t - 8],
					dc[t - 9],
					dc[t - 10],
					dc[t - 11],
					dc[t - 12],
					dc[t - 13],
					dc[t - 14],
					dc[t - 15],
					dc[t - 16],
					dc[t - 17],
					dc[t - 18],
					dc[t - 19],
					dc[t - 20],
					dc[t - 21],
					dc[t - 22],
					dc[t - 23],
					dc[t - 24],
					dc[t - 25],
					dc[t - 26],
					dc[t - 27],
					dc[t - 28],
					dc[t - 29],
					dc[t - 30],
					dc[t - 31],
					dc[t - 32],
					dc[t - 33],
					dc[t - 34],
					dc[t - 35],
					dc[t - 36],
					dc[t - 37],
					dc[t - 38],
					dc[t - 39],
					dc[t - 40],
					dc[t - 41],
					dc[t - 42],
					dc[t - 43],
					dc[t - 44],
					dc[t - 45],
					dc[t - 46]
				}
			],
			Equal[
				timeSeriesVector[dc, t, "TimeAggregation" -> 12, "numPeriods" -> 3],
				{
					dc @ t,
					dc[t - 1],
					dc[t - 2],
					dc[t - 3],
					dc[t - 4],
					dc[t - 5],
					dc[t - 6],
					dc[t - 7],
					dc[t - 8],
					dc[t - 9],
					dc[t - 10],
					dc[t - 11],
					dc[t - 12],
					dc[t - 13],
					dc[t - 14],
					dc[t - 15],
					dc[t - 16],
					dc[t - 17],
					dc[t - 18],
					dc[t - 19],
					dc[t - 20],
					dc[t - 21],
					dc[t - 22],
					dc[t - 23],
					dc[t - 24],
					dc[t - 25],
					dc[t - 26],
					dc[t - 27],
					dc[t - 28],
					dc[t - 29],
					dc[t - 30],
					dc[t - 31],
					dc[t - 32],
					dc[t - 33],
					dc[t - 34],
					dc[t - 35],
					dc[t - 36],
					dc[t - 37],
					dc[t - 38],
					dc[t - 39],
					dc[t - 40],
					dc[t - 41],
					dc[t - 42],
					dc[t - 43],
					dc[t - 44],
					dc[t - 45],
					dc[t - 46]
				}
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231114-XRPGDA"
]
VerificationTest[
	On[General::stop];
	True
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20231114-F57LY7"
] 
End[]
EndTestSection[]
