BeginTestSection["EndogenousEq"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";
	True
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20231109-G01M5E"
]
VerificationTest[
	!SameQ[Names @ "*pdeq", {}]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20231109-0K6DC8"
]
VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
			Map[Context,
				Cases[Map[Slot[1][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars]],
					RuleDelayed[
						PatternTest[
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var_Symbol,
							Function[
								MemberQ[
									Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
									SymbolName[#]
								]
							]
						][__],
						FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var
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
	TestID->"EndogenousEq_20231109-ULNWW5"
]
VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
			Map[Context,
				Cases[Map[Slot[1][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars]],
					RuleDelayed[
						PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
						FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var
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
	TestID->"EndogenousEq_20231109-KX7IZE"
]
VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
			Map[Context,
				Cases[Map[Slot[1][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars]],
					RuleDelayed[
						PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
						FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var
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
	TestID->"EndogenousEq_20231109-2EHHUF"
]
VerificationTest[
	Apply[And,
		Map[SameQ[#, "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"]&,
			Map[Context,
				Cases[Map[Slot[1][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t]&, Map[Symbol, FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars]],
					RuleDelayed[
						PatternTest[
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var_Symbol,
							Function[
								MemberQ[
									Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
									SymbolName[#]
								]
							]
						][__],
						FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`var
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
	TestID->"EndogenousEq_20231109-LT4IXI"
]
VerificationTest[
	Apply[And,
		{
			FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], foo`t],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t],
			FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[foo`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[foo`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], foo`t],
			!SameQ[foo`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m]],
			!SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[foo`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20231109-U5OZ2R"
]
VerificationTest[
	Apply[And,
		{
			FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], foo`m],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m],
			FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, foo`m], FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, foo`m], foo`m],
			!SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondyieldeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, foo`m]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20231109-OQ9UXC"
]
VerificationTest[
	Apply[And,
		{
			SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondfweq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondfweq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m, 1]],
			SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondreteq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondreteq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m, 1]],
			SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondfwspreadeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondfwspreadeq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m, 1]],
			SameQ[FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondexcreteq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m], FernandoDuarte`LongRunRisk`Model`EndogenousEq`bondexcreteq[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`m, 1]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20231109-R4FGZA"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefwc = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc;
	FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefpd = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd;
	FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefb = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb;
	FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefnb = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb;
	FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`hpd = Head @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefpd;
	FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`hb = Head @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefb;
	FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`hnb = Head @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefnb;
	FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`ch = Flatten[
		{
			{
				FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefwc @ 0,
				N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefwc @ 0,
				N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefwc @ 0,
				FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefwc @ 0.,
				N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefwc @ 0.,
				N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefwc @ 0.
			},
			Table[
				{
					FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`c @ 0,
					N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`c @ 0,
					N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`c @ 0,
					FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`c @ 0.,
					N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`c @ 0.,
					N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`c @ 0.
				},
				{FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`c, {FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefpd, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefb, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefnb}}
			],
			Table[
				ReplaceAll[
					ReplaceAll[
						{
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1][0],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1][0],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1][0],
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1][0.],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1][0.],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1][0.],
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][1],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][1],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][1],
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][1],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][1],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][1],
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1.][0],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1.][0],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1.][0],
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1.][0.],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1.][0.],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[1.][0.],
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][1.],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][1.],
							N[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h @ 0][1.],
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][1.],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][1.],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][1.],
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j],
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j],
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j][0],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j][0],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j][0],
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j][0.],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j][0.],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j][0.],
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][jj],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][jj],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0][jj],
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][jj],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][jj],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[0.][jj],
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[jj][0],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[jj][0],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[jj][0],
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[jj][0.],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[jj][0.],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[jj][0.],
							FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[jj][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`kk],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[jj][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`kk],
							N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[jj][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`kk],
							N @ Table[
								{FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`ii][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`qq], N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`ii][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`qq], N @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`ii][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`qq]},
								{FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`ii, 0, 1},
								{FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`qq, 2, 3}
							]
						},
						jj -> 2
					],
					FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`kk -> 3
				],
				{FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`h, {Head @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefpd, Head @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefb, Head @ FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`coefnb}}
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
								Flatten[Cases[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`ch, Pattern[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`x, _][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`i_] :> FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`i]],
								NumberQ
							]
						]
					],
					Map[Not,
						Map[InexactNumberQ,
							Select[
								Flatten[Cases[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`ch, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`x_[FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`i_][FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j_] :> {FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`i, FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`j}]],
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
	TestID->"EndogenousEq_20231109-UDCJKN"
] 
End[]
EndTestSection[]
