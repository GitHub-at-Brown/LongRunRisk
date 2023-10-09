BeginTestSection["EndogenousEq"] 
Begin["Model`EndogenousEq`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";
	True
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20231007-Q9SEK1"
]
VerificationTest[
	!SameQ[Names @ "*pdeq", {}]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20231007-XU08RC"
]
VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
			Map[Context,
				Cases[Map[Slot[1][Model`EndogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars]],
					RuleDelayed[
						PatternTest[
							Model`EndogenousEq`var_Symbol,
							Function[
								MemberQ[
									Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
									SymbolName[#]
								]
							]
						][__],
						Model`EndogenousEq`var
					],
					Infinity
				]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20231007-KPJDHK"
]
VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
			Map[Context,
				Cases[Map[Slot[1][Model`EndogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars]],
					RuleDelayed[
						PatternTest[Model`EndogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
						Model`EndogenousEq`var
					],
					Infinity
				]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20231007-LIXVR2"
]
VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
			Map[Context,
				Cases[Map[Slot[1][Model`EndogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars]],
					RuleDelayed[
						PatternTest[Model`EndogenousEq`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
						Model`EndogenousEq`var
					],
					Infinity
				]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20231007-FQ06I5"
]
VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"]&,
			Map[Context,
				Cases[Map[Slot[1][Model`EndogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars]],
					RuleDelayed[
						PatternTest[
							Model`EndogenousEq`var_Symbol,
							Function[
								MemberQ[
									Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
									SymbolName[#]
								]
							]
						][__],
						Model`EndogenousEq`var
					],
					Infinity
				]
			]
		]
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20231007-AC6YZU"
]
VerificationTest[
	Apply[And,
		{
			FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[Model`EndogenousEq`t, Model`EndogenousEq`m], foo`t],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[Model`EndogenousEq`t, Model`EndogenousEq`m], Model`EndogenousEq`t],
			FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[foo`t, Model`EndogenousEq`m], Model`EndogenousEq`t],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[foo`t, Model`EndogenousEq`m], foo`t],
			!SameQ[foo`bondyieldeq[Model`EndogenousEq`t, Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[Model`EndogenousEq`t, Model`EndogenousEq`m]],
			!SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[Model`EndogenousEq`t, Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[foo`t, Model`EndogenousEq`m]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20231007-A63EXY"
]
VerificationTest[
	Apply[And,
		{
			FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[Model`EndogenousEq`t, Model`EndogenousEq`m], foo`m],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[Model`EndogenousEq`t, Model`EndogenousEq`m], Model`EndogenousEq`m],
			FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[Model`EndogenousEq`t, foo`m], Model`EndogenousEq`m],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[Model`EndogenousEq`t, foo`m], foo`m],
			!SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[Model`EndogenousEq`t, Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[Model`EndogenousEq`t, foo`m]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20231007-1XJ1EX"
]
VerificationTest[
	Apply[And,
		{
			SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondfweq[Model`EndogenousEq`t, Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondfweq[Model`EndogenousEq`t, Model`EndogenousEq`m, 1]],
			SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondreteq[Model`EndogenousEq`t, Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondreteq[Model`EndogenousEq`t, Model`EndogenousEq`m, 1]],
			SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondfwspreadeq[Model`EndogenousEq`t, Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondfwspreadeq[Model`EndogenousEq`t, Model`EndogenousEq`m, 1]],
			SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondexcreteq[Model`EndogenousEq`t, Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondexcreteq[Model`EndogenousEq`t, Model`EndogenousEq`m, 1]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20231007-4YPA5Y"
]
VerificationTest[
	Model`EndogenousEq`coefwc = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc;
	Model`EndogenousEq`coefpd = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd;
	Model`EndogenousEq`coefb = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb;
	Model`EndogenousEq`coefnb = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb;
	Model`EndogenousEq`hpd = Head @ Model`EndogenousEq`coefpd;
	Model`EndogenousEq`hb = Head @ Model`EndogenousEq`coefb;
	Model`EndogenousEq`hnb = Head @ Model`EndogenousEq`coefnb;
	Model`EndogenousEq`ch = Flatten[
		{
			{
				Model`EndogenousEq`coefwc @ 0,
				N @ Model`EndogenousEq`coefwc @ 0,
				N @ Model`EndogenousEq`coefwc @ 0,
				Model`EndogenousEq`coefwc @ 0.,
				N @ Model`EndogenousEq`coefwc @ 0.,
				N @ Model`EndogenousEq`coefwc @ 0.
			},
			Table[
				{
					Model`EndogenousEq`c @ 0,
					N @ Model`EndogenousEq`c @ 0,
					N @ Model`EndogenousEq`c @ 0,
					Model`EndogenousEq`c @ 0.,
					N @ Model`EndogenousEq`c @ 0.,
					N @ Model`EndogenousEq`c @ 0.
				},
				{Model`EndogenousEq`c, {Model`EndogenousEq`coefpd, Model`EndogenousEq`coefb, Model`EndogenousEq`coefnb}}
			],
			Table[
				ReplaceAll[
					ReplaceAll[
						{
							Model`EndogenousEq`h[1][0],
							N @ Model`EndogenousEq`h[1][0],
							N @ Model`EndogenousEq`h[1][0],
							Model`EndogenousEq`h[1][0.],
							N @ Model`EndogenousEq`h[1][0.],
							N @ Model`EndogenousEq`h[1][0.],
							Model`EndogenousEq`h[0][1],
							N @ Model`EndogenousEq`h[0][1],
							N @ Model`EndogenousEq`h[0][1],
							Model`EndogenousEq`h[0.][1],
							N @ Model`EndogenousEq`h[0.][1],
							N @ Model`EndogenousEq`h[0.][1],
							Model`EndogenousEq`h[1.][0],
							N @ Model`EndogenousEq`h[1.][0],
							N @ Model`EndogenousEq`h[1.][0],
							Model`EndogenousEq`h[1.][0.],
							N @ Model`EndogenousEq`h[1.][0.],
							N @ Model`EndogenousEq`h[1.][0.],
							Model`EndogenousEq`h[0][1.],
							N @ Model`EndogenousEq`h[0][1.],
							N[Model`EndogenousEq`h @ 0][1.],
							Model`EndogenousEq`h[0.][1.],
							N @ Model`EndogenousEq`h[0.][1.],
							N @ Model`EndogenousEq`h[0.][1.],
							Model`EndogenousEq`h[0][Model`EndogenousEq`j],
							N @ Model`EndogenousEq`h[0][Model`EndogenousEq`j],
							N @ Model`EndogenousEq`h[0][Model`EndogenousEq`j],
							Model`EndogenousEq`h[0.][Model`EndogenousEq`j],
							N @ Model`EndogenousEq`h[0.][Model`EndogenousEq`j],
							N @ Model`EndogenousEq`h[0.][Model`EndogenousEq`j],
							Model`EndogenousEq`h[Model`EndogenousEq`j][0],
							N @ Model`EndogenousEq`h[Model`EndogenousEq`j][0],
							N @ Model`EndogenousEq`h[Model`EndogenousEq`j][0],
							Model`EndogenousEq`h[Model`EndogenousEq`j][0.],
							N @ Model`EndogenousEq`h[Model`EndogenousEq`j][0.],
							N @ Model`EndogenousEq`h[Model`EndogenousEq`j][0.],
							Model`EndogenousEq`h[0][Model`EndogenousEq`jj],
							N @ Model`EndogenousEq`h[0][Model`EndogenousEq`jj],
							N @ Model`EndogenousEq`h[0][Model`EndogenousEq`jj],
							Model`EndogenousEq`h[0.][Model`EndogenousEq`jj],
							N @ Model`EndogenousEq`h[0.][Model`EndogenousEq`jj],
							N @ Model`EndogenousEq`h[0.][Model`EndogenousEq`jj],
							Model`EndogenousEq`h[Model`EndogenousEq`jj][0],
							N @ Model`EndogenousEq`h[Model`EndogenousEq`jj][0],
							N @ Model`EndogenousEq`h[Model`EndogenousEq`jj][0],
							Model`EndogenousEq`h[Model`EndogenousEq`jj][0.],
							N @ Model`EndogenousEq`h[Model`EndogenousEq`jj][0.],
							N @ Model`EndogenousEq`h[Model`EndogenousEq`jj][0.],
							Model`EndogenousEq`h[Model`EndogenousEq`jj][Model`EndogenousEq`kk],
							N @ Model`EndogenousEq`h[Model`EndogenousEq`jj][Model`EndogenousEq`kk],
							N @ Model`EndogenousEq`h[Model`EndogenousEq`jj][Model`EndogenousEq`kk],
							N @ Table[
								{Model`EndogenousEq`h[Model`EndogenousEq`ii][Model`EndogenousEq`qq], N @ Model`EndogenousEq`h[Model`EndogenousEq`ii][Model`EndogenousEq`qq], N @ Model`EndogenousEq`h[Model`EndogenousEq`ii][Model`EndogenousEq`qq]},
								{Model`EndogenousEq`ii, 0, 1},
								{Model`EndogenousEq`qq, 2, 3}
							]
						},
						Model`EndogenousEq`jj -> 2
					],
					Model`EndogenousEq`kk -> 3
				],
				{Model`EndogenousEq`h, {Head @ Model`EndogenousEq`coefpd, Head @ Model`EndogenousEq`coefb, Head @ Model`EndogenousEq`coefnb}}
			]
		}
	];
	Apply[And,
		Flatten[
			{
				{
					Map[Not,
						Map[InexactNumberQ,
							Select[
								Flatten[Cases[Model`EndogenousEq`ch, Pattern[Model`EndogenousEq`x, _][Model`EndogenousEq`i_] :> Model`EndogenousEq`i]],
								NumberQ
							]
						]
					],
					Map[Not,
						Map[InexactNumberQ,
							Select[
								Flatten[Cases[Model`EndogenousEq`ch, Model`EndogenousEq`x_[Model`EndogenousEq`i_][Model`EndogenousEq`j_] :> {Model`EndogenousEq`i, Model`EndogenousEq`j}]],
								NumberQ
							]
						]
					]
				}
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20231007-9MSXSQ"
] 
End[]
EndTestSection[]
