BeginTestSection["EndogenousEq"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";

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
	TestID->"EndogenousEq_20251223-402VM5@@Tests/EndogenousEq.wlt:173,1-301,2"
]

End[]
EndTestSection[]
