BeginTestSection["ComputeConditionalExpectations"] 
Begin["ComputationalEngine`Cond`"]
VerificationTest[
	Get @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
	Needs @ "FernandoDuarte`LongRunRisk`Model`ProcessModels`";
	Needs @ "PacletizedResourceFunctions`";
	,
	Null
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20230514-8E4LVW"
]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`";
	$ContextAliases["ce`"] = "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`";
	,
	Null
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20230514-OHVVZB"
]
VerificationTest[
	Apply[And, {MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"]}]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20230514-3PXLY5"
]
VerificationTest[
	Apply[And,
		{
			!SameQ[Names @ "*ev", {}],
			!SameQ[Names @ "ce`lagStateVarst", {}]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20230514-FFBQBR"
]
VerificationTest[
	ComputationalEngine`Cond`mm = FernandoDuarte`LongRunRisk`Model`Catalog`models;
	ComputationalEngine`Cond`ms = KeySelect[ComputationalEngine`Cond`mm, MatchQ[#, "BKY" | "NRC"]&];
	ComputationalEngine`Cond`msp = FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels @ ComputationalEngine`Cond`ms;
	ComputationalEngine`Cond`modNRC = ComputationalEngine`Cond`msp[[2]];
	,
	Null
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20230514-P6W8SG"
]
VerificationTest[
	SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
		FernandoDuarte`LongRunRisk`Model`Parameters`phip
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20230514-VW28FU"
]
VerificationTest[
	Apply[And,
		{
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`i] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]
						],
						Times[
							Plus[
								ComputationalEngine`Cond`mup,
								(ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
							],
							Plus[
								ComputationalEngine`Cond`mud @ ComputationalEngine`Cond`i,
								(ComputationalEngine`Cond`rhodp[ComputationalEngine`Cond`i] * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xid[ComputationalEngine`Cond`i] * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`i] * ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]
						],
						Plus[
							Times[
								Plus[
									ComputationalEngine`Cond`mud @ ComputationalEngine`Cond`i,
									(ComputationalEngine`Cond`rhodp[ComputationalEngine`Cond`i] * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xid[ComputationalEngine`Cond`i] * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
								],
								Plus[
									ComputationalEngine`Cond`muc,
									(ComputationalEngine`Cond`rhocp * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xic * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
								]
							],
							ComputationalEngine`Cond`phic * ComputationalEngine`Cond`phidc[ComputationalEngine`Cond`i]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[
								ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 3] * ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t + 2] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1],
								ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC
							]
						],
						Times[ComputationalEngine`Cond`Esg + (ComputationalEngine`Cond`rhog ^ 3) * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`Esg),
							Plus[
								Times[
									Plus[
										ComputationalEngine`Cond`mup,
										(ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
									],
									Plus[
										ComputationalEngine`Cond`muc,
										(ComputationalEngine`Cond`rhocp * ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`rhocp * ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
									]
								],
								(ComputationalEngine`Cond`rhocp * ComputationalEngine`Cond`phip ^ 2) + ComputationalEngine`Cond`xic * ComputationalEngine`Cond`phip * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 2] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Plus[
							Times[
								Plus[
									ComputationalEngine`Cond`mup,
									(ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
								],
								Plus[
									ComputationalEngine`Cond`mup,
									((ComputationalEngine`Cond`rhop ^ 2) * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`rhop * ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
								]
							],
							(ComputationalEngine`Cond`rhop * ComputationalEngine`Cond`phip ^ 2) + ComputationalEngine`Cond`xip * ComputationalEngine`Cond`phip
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t + 2] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`modNRC]
						],
						ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1] * PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t + 2], ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`modNRC]]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t + 2] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Plus[
							Times[
								Plus[
									ComputationalEngine`Cond`mup,
									(ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
								],
								Plus[
									ComputationalEngine`Cond`muc,
									(ComputationalEngine`Cond`rhocp * ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`rhocp * ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
								]
							],
							(ComputationalEngine`Cond`rhocp * ComputationalEngine`Cond`phip ^ 2) + ComputationalEngine`Cond`xic * ComputationalEngine`Cond`phip * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t + 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Times[
							Plus[
								ComputationalEngine`Cond`mup,
								(ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
							],
							Plus[
								ComputationalEngine`Cond`muc,
								(ComputationalEngine`Cond`rhocp * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xic * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Times[ComputationalEngine`Cond`pi @ ComputationalEngine`Cond`t,
							Plus[
								ComputationalEngine`Cond`muc,
								Plus[
									ComputationalEngine`Cond`rhocp * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1] - ComputationalEngine`Cond`mup),
									(ComputationalEngine`Cond`xic * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 2] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 1]) + ComputationalEngine`Cond`phic * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t]
								]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t - 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Times[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1],
							Plus[
								ComputationalEngine`Cond`muc,
								Plus[
									ComputationalEngine`Cond`rhocp * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 2] - ComputationalEngine`Cond`mup),
									(ComputationalEngine`Cond`xic * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 3] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 2]) + ComputationalEngine`Cond`phic * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t - 1]
								]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t - 2] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 2], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Times[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 2],
							Plus[
								ComputationalEngine`Cond`muc,
								Plus[
									ComputationalEngine`Cond`rhocp * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 3] - ComputationalEngine`Cond`mup),
									(ComputationalEngine`Cond`xic * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 4] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 3]) + ComputationalEngine`Cond`phic * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t - 2]
								]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 2] * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]
						],
						Plus[
							(1 - ComputationalEngine`Cond`rhog) * ComputationalEngine`Cond`Esg * PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
							ComputationalEngine`Cond`rhog * PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] ^ 3, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 2] * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]
						],
						Plus[
							Times[
								1 - ComputationalEngine`Cond`rhog,
								Times[
									ComputationalEngine`Cond`Esg,
									((ComputationalEngine`Cond`Esg + ComputationalEngine`Cond`rhog * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`Esg)) ^ 2) + ComputationalEngine`Cond`phig ^ 2
								]
							],
							Times[
								ComputationalEngine`Cond`rhog,
								Plus[
									(ComputationalEngine`Cond`Esg + ComputationalEngine`Cond`rhog * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`Esg)) ^ 3,
									Times[
										3,
										(ComputationalEngine`Cond`phig ^ 2) * (ComputationalEngine`Cond`Esg + ComputationalEngine`Cond`rhog * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`Esg))
									]
								]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 3] * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]
						],
						Plus[
							(1 - ComputationalEngine`Cond`rhog ^ 2) * ComputationalEngine`Cond`Esg * PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
							(ComputationalEngine`Cond`rhog ^ 2) * PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] ^ 3, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 3] * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]
						],
						Plus[
							Times[
								1 - ComputationalEngine`Cond`rhog ^ 2,
								Times[
									ComputationalEngine`Cond`Esg,
									((ComputationalEngine`Cond`Esg + ComputationalEngine`Cond`rhog * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`Esg)) ^ 2) + ComputationalEngine`Cond`phig ^ 2
								]
							],
							Times[
								ComputationalEngine`Cond`rhog ^ 2,
								Plus[
									(ComputationalEngine`Cond`Esg + ComputationalEngine`Cond`rhog * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`Esg)) ^ 3,
									Times[
										3,
										(ComputationalEngine`Cond`phig ^ 2) * (ComputationalEngine`Cond`Esg + ComputationalEngine`Cond`rhog * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`Esg))
									]
								]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 2] * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Plus[
							(ComputationalEngine`Cond`Esg + (ComputationalEngine`Cond`rhog ^ 2) * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`Esg)) * (ComputationalEngine`Cond`Esg + ComputationalEngine`Cond`rhog * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`Esg)),
							ComputationalEngine`Cond`rhog * ComputationalEngine`Cond`phig ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 3] * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Plus[
							(ComputationalEngine`Cond`Esg + (ComputationalEngine`Cond`rhog ^ 3) * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`Esg)) * (ComputationalEngine`Cond`Esg + ComputationalEngine`Cond`rhog * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`Esg)),
							(ComputationalEngine`Cond`rhog ^ 2) * ComputationalEngine`Cond`phig ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 2] * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
						],
						Plus[
							Times[
								ComputationalEngine`Cond`Esg + (ComputationalEngine`Cond`rhog ^ 3) * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] - ComputationalEngine`Cond`Esg),
								ComputationalEngine`Cond`Esg + (ComputationalEngine`Cond`rhog ^ 2) * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] - ComputationalEngine`Cond`Esg)
							],
							((ComputationalEngine`Cond`rhog ^ 3) * ComputationalEngine`Cond`phig ^ 2) + ComputationalEngine`Cond`rhog * ComputationalEngine`Cond`phig ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 3] * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
						],
						Plus[
							Times[
								ComputationalEngine`Cond`Esg + (ComputationalEngine`Cond`rhog ^ 4) * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] - ComputationalEngine`Cond`Esg),
								ComputationalEngine`Cond`Esg + (ComputationalEngine`Cond`rhog ^ 2) * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] - ComputationalEngine`Cond`Esg)
							],
							((ComputationalEngine`Cond`rhog ^ 4) * ComputationalEngine`Cond`phig ^ 2) + (ComputationalEngine`Cond`rhog ^ 2) * ComputationalEngine`Cond`phig ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Times[ComputationalEngine`Cond`Esg + ComputationalEngine`Cond`rhog * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`Esg),
							Plus[
								ComputationalEngine`Cond`mup,
								(ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]] - ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 2] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 2], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 2] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 2]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`modNRC]
						],
						ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Times[ComputationalEngine`Cond`Esg + ComputationalEngine`Cond`rhog * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`Esg),
							Plus[
								ComputationalEngine`Cond`mup,
								(ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
						],
						Times[ComputationalEngine`Cond`Esg + (ComputationalEngine`Cond`rhog ^ 2) * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] - ComputationalEngine`Cond`Esg),
							Plus[
								ComputationalEngine`Cond`mup,
								((ComputationalEngine`Cond`rhop ^ 2) * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`rhop * ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 1]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 2, ComputationalEngine`Cond`modNRC]
						],
						Times[ComputationalEngine`Cond`Esg + (ComputationalEngine`Cond`rhog ^ 3) * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 2] - ComputationalEngine`Cond`Esg),
							Plus[
								ComputationalEngine`Cond`mup,
								((ComputationalEngine`Cond`rhop ^ 3) * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 2] - ComputationalEngine`Cond`mup)) + (ComputationalEngine`Cond`rhop ^ 2) * ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 2]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						((ComputationalEngine`Cond`Esg + ComputationalEngine`Cond`rhog * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`Esg)) ^ 2) + ComputationalEngine`Cond`phig ^ 2
					]
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]] - ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] ^ 2
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]] - ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] ^ 2
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 2] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]] - ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 2] ^ 2
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`modNRC]] - ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] ^ 2
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						((ComputationalEngine`Cond`Esg + ComputationalEngine`Cond`rhog * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`Esg)) ^ 2) + ComputationalEngine`Cond`phig ^ 2
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]],
						Plus[
							Power[
								ComputationalEngine`Cond`Esg + (ComputationalEngine`Cond`rhog ^ 2) * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] - ComputationalEngine`Cond`Esg),
								2
							],
							((ComputationalEngine`Cond`rhog ^ 2) + 1) * ComputationalEngine`Cond`phig ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t - 2, ComputationalEngine`Cond`modNRC]],
						Plus[
							Power[
								ComputationalEngine`Cond`Esg + (ComputationalEngine`Cond`rhog ^ 3) * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 2] - ComputationalEngine`Cond`Esg),
								2
							],
							((ComputationalEngine`Cond`rhog ^ 4) + (ComputationalEngine`Cond`rhog ^ 2) + 1) * ComputationalEngine`Cond`phig ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]] - (ComputationalEngine`Cond`Esg + ComputationalEngine`Cond`rhog * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`Esg))
				]
			],
			SameQ[0, Simplify[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]] - ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t]]],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]] - ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1]
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 2], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]] - ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 2]
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`modNRC]] - ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1]
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]] - (ComputationalEngine`Cond`Esg + ComputationalEngine`Cond`rhog * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`Esg))
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]],
						ComputationalEngine`Cond`Esg + (ComputationalEngine`Cond`rhog ^ 2) * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] - ComputationalEngine`Cond`Esg)
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]],
						Plus[ComputationalEngine`Cond`muc,
							(ComputationalEngine`Cond`rhocp * ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`rhocp * ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]],
						Plus[ComputationalEngine`Cond`muc,
							(ComputationalEngine`Cond`rhocp * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xic * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 2] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 1]
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
	TestID->"ComputeConditionalExpectations_20230514-QUG7NA"
]
VerificationTest[
	ComputationalEngine`Cond`dc1 = PacletizedResourceFunctions`SetSymbolsContext[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t - 1] /. Normal[ComputationalEngine`Cond`modNRC["exogenousEq"]]];
	ComputationalEngine`Cond`dc2 = PacletizedResourceFunctions`SetSymbolsContext[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t - 2] /. Normal[ComputationalEngine`Cond`modNRC["exogenousEq"]]];
	Apply[And,
		{
			Simplify[
				SameQ[ComputationalEngine`Cond`dc1,
					Plus[ComputationalEngine`Cond`muc,
						Plus[ComputationalEngine`Cond`rhocp * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 2] - ComputationalEngine`Cond`mup),
							(ComputationalEngine`Cond`xic * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 3] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 2]) + ComputationalEngine`Cond`phic * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t - 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]],
						Plus[ComputationalEngine`Cond`muc,
							Plus[
								ComputationalEngine`Cond`rhocp * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 2] - ComputationalEngine`Cond`mup),
								(ComputationalEngine`Cond`xic * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 3] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 2]) + ComputationalEngine`Cond`phic * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t - 1]
							]
						]
					]
				]
			],
			Simplify[
				SameQ[ComputationalEngine`Cond`dc2,
					Plus[ComputationalEngine`Cond`muc,
						Plus[ComputationalEngine`Cond`rhocp * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 3] - ComputationalEngine`Cond`mup),
							(ComputationalEngine`Cond`xic * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 4] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 3]) + ComputationalEngine`Cond`phic * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t - 2]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t - 2], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]],
						Plus[ComputationalEngine`Cond`muc,
							Plus[
								ComputationalEngine`Cond`rhocp * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 3] - ComputationalEngine`Cond`mup),
								(ComputationalEngine`Cond`xic * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 4] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 3]) + ComputationalEngine`Cond`phic * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t - 2]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Plus[ComputationalEngine`Cond`muc,
							(ComputationalEngine`Cond`rhocp * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xic * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]],
						Plus[ComputationalEngine`Cond`muc,
							(ComputationalEngine`Cond`rhocp * ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`rhocp * ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 2, ComputationalEngine`Cond`modNRC]],
						Plus[ComputationalEngine`Cond`muc,
							Plus[
								ComputationalEngine`Cond`rhocp * (ComputationalEngine`Cond`rhop ^ 2) * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 2] - ComputationalEngine`Cond`mup),
								ComputationalEngine`Cond`rhocp * ComputationalEngine`Cond`rhop * ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 2]
							]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 2] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
						],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
						],
						ComputationalEngine`Cond`phip
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
						],
						(ComputationalEngine`Cond`rhop * ComputationalEngine`Cond`phip) + ComputationalEngine`Cond`xip
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
						],
						Times[
							Plus[
								ComputationalEngine`Cond`mup,
								((ComputationalEngine`Cond`rhop ^ 2) * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`rhop * ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 1]
							],
							ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 2] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
						],
						Times[
							Plus[
								ComputationalEngine`Cond`mup,
								((ComputationalEngine`Cond`rhop ^ 2) * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`rhop * ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 1]
							],
							ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 2]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 2] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]
						],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]
						],
						ComputationalEngine`Cond`phip
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Times[
							Plus[
								ComputationalEngine`Cond`mup,
								(ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
							],
							ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]
						],
						Times[
							Plus[
								ComputationalEngine`Cond`mup,
								(ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
							],
							ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 2] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]
						],
						Times[
							Plus[
								ComputationalEngine`Cond`mup,
								(ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
							],
							ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 2]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 2] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`modNRC]
						],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`modNRC]
						],
						ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`modNRC]
						],
						ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`modNRC]
						],
						ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 2] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`modNRC]
						],
						ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 2] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 2], ComputationalEngine`Cond`t - 2, ComputationalEngine`Cond`modNRC]
						],
						ComputationalEngine`Cond`rhop * ((ComputationalEngine`Cond`rhop * ComputationalEngine`Cond`phip) + ComputationalEngine`Cond`xip)
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 2, ComputationalEngine`Cond`modNRC]
						],
						(ComputationalEngine`Cond`rhop * ComputationalEngine`Cond`phip) + ComputationalEngine`Cond`xip
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t], ComputationalEngine`Cond`t - 2, ComputationalEngine`Cond`modNRC]],
						ComputationalEngine`Cond`phip
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1], ComputationalEngine`Cond`t - 2, ComputationalEngine`Cond`modNRC]
						],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 2], ComputationalEngine`Cond`t - 2, ComputationalEngine`Cond`modNRC]
						],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 2], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
						],
						ComputationalEngine`Cond`rhop * ((ComputationalEngine`Cond`rhop * ComputationalEngine`Cond`phip) + ComputationalEngine`Cond`xip)
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
						],
						(ComputationalEngine`Cond`rhop * ComputationalEngine`Cond`phip) + ComputationalEngine`Cond`xip
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]],
						ComputationalEngine`Cond`phip
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
						],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 2], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
						],
						0
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 2], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Times[
							Plus[
								ComputationalEngine`Cond`mup,
								((ComputationalEngine`Cond`rhop ^ 2) * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`rhop * ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
							],
							ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Times[
							Plus[
								ComputationalEngine`Cond`mup,
								(ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
							],
							ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]] - ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 2], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 2]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 2], ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`modNRC]
						],
						Times[
							Plus[
								ComputationalEngine`Cond`mup,
								(ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1]
							],
							ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`modNRC]
						],
						ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t], ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`modNRC]],
						ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1], ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`modNRC]
						],
						ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[
							FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 2], ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`modNRC]
						],
						ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 2]
					]
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 2], ComputationalEngine`Cond`t + 2, ComputationalEngine`Cond`modNRC]] - ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 2]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 2], ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`modNRC]],
						Plus[ComputationalEngine`Cond`mup,
							(ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 2], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Plus[ComputationalEngine`Cond`mup,
							((ComputationalEngine`Cond`rhop ^ 2) * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`rhop * ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 2], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]],
						Plus[ComputationalEngine`Cond`mup,
							((ComputationalEngine`Cond`rhop ^ 3) * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1] - ComputationalEngine`Cond`mup)) + (ComputationalEngine`Cond`rhop ^ 2) * ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 2], ComputationalEngine`Cond`t - 2, ComputationalEngine`Cond`modNRC]],
						Plus[ComputationalEngine`Cond`mup,
							((ComputationalEngine`Cond`rhop ^ 4) * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 2] - ComputationalEngine`Cond`mup)) + (ComputationalEngine`Cond`rhop ^ 3) * ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 2]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Plus[ComputationalEngine`Cond`mup,
							(ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]],
						Plus[ComputationalEngine`Cond`mup,
							((ComputationalEngine`Cond`rhop ^ 2) * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`rhop * ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 1]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 2, ComputationalEngine`Cond`modNRC]],
						Plus[ComputationalEngine`Cond`mup,
							((ComputationalEngine`Cond`rhop ^ 3) * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 2] - ComputationalEngine`Cond`mup)) + (ComputationalEngine`Cond`rhop ^ 2) * ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 2]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Plus[ComputationalEngine`Cond`mup,
							(ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Plus[ComputationalEngine`Cond`muc,
							(ComputationalEngine`Cond`rhocp * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xic * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]] - (ComputationalEngine`Cond`Esg + ComputationalEngine`Cond`rhog * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`Esg))
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`i], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Plus[ComputationalEngine`Cond`mud @ ComputationalEngine`Cond`i,
							(ComputationalEngine`Cond`rhodp[ComputationalEngine`Cond`i] * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xid[ComputationalEngine`Cond`i] * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Plus[
							Power[
								Plus[
									ComputationalEngine`Cond`mup,
									(ComputationalEngine`Cond`rhop * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xip * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
								],
								2
							],
							ComputationalEngine`Cond`phip ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Plus[
							Power[
								Plus[
									ComputationalEngine`Cond`muc,
									(ComputationalEngine`Cond`rhocp * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xic * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
								],
								2
							],
							ComputationalEngine`Cond`phic ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						((ComputationalEngine`Cond`Esg + ComputationalEngine`Cond`rhog * (ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`Esg)) ^ 2) + ComputationalEngine`Cond`phig ^ 2
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[
						PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`i] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]],
						Plus[
							Power[
								Plus[
									ComputationalEngine`Cond`mud @ ComputationalEngine`Cond`i,
									(ComputationalEngine`Cond`rhodp[ComputationalEngine`Cond`i] * (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] - ComputationalEngine`Cond`mup)) + ComputationalEngine`Cond`xid[ComputationalEngine`Cond`i] * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t]
								],
								2
							],
							ComputationalEngine`Cond`phidc[ComputationalEngine`Cond`i] ^ 2
						]
					]
				]
			],
			SameQ[0,
				Simplify[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`var[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]] - ComputationalEngine`Cond`phip ^ 2]
			],
			SameQ[0,
				Simplify[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`var[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]] - ComputationalEngine`Cond`phic ^ 2]
			],
			SameQ[0,
				Simplify[PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`var[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]] - ComputationalEngine`Cond`phig ^ 2]
			],
			SameQ[0,
				Simplify[
					PacletizedResourceFunctions`SetSymbolsContext[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`var[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`i], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]] - ComputationalEngine`Cond`phidc[ComputationalEngine`Cond`i] ^ 2
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20230514-PAL03S"
]
VerificationTest[
	Apply[And,
		{
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`i], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`i], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1] * ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1] * ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
							ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t + 1] * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t + 1] * ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
							ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
						]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
					]
				]
			],
			SameQ[0,
				Simplify[
					Subtract[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t + 2, ComputationalEngine`Cond`i], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
						FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t + 2, ComputationalEngine`Cond`i], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
					]
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] ^ 2) * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 2],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] ^ 2) * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 2], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] ^ 2) * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 2],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] ^ 2) * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 2], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] ^ 2) * ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 2],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] ^ 2) * ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 2], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] ^ 2) * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 2],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] ^ 2) * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 2], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] ^ 2) * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 2],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] ^ 2) * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 2], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[0,
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] ^ 2) * ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 2],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[(ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] ^ 2) * ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 2], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dc[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t, ComputationalEngine`Cond`i], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t, ComputationalEngine`Cond`i] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t, ComputationalEngine`Cond`i] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1] ^ 2,
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t, ComputationalEngine`Cond`i] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t, ComputationalEngine`Cond`i], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t, ComputationalEngine`Cond`i] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t, ComputationalEngine`Cond`i] * ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 1] ^ 2,
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t, ComputationalEngine`Cond`i] * ComputationalEngine`Cond`eps["sg"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t, ComputationalEngine`Cond`i], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t, ComputationalEngine`Cond`i] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t, ComputationalEngine`Cond`i] * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 1] ^ 2,
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t, ComputationalEngine`Cond`i] * ComputationalEngine`Cond`eps["dc"][ComputationalEngine`Cond`t + 1] ^ 2, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
					ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC
				]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20230514-HKKIAZ"
]
VerificationTest[
	Apply[And,
		{
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[foo`t + 1], foo`t, ComputationalEngine`Cond`modNRC] /. foo`t -> ComputationalEngine`Cond`t
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[foo`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + foo`t]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], foo`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + ComputationalEngine`Cond`t]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[foo`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + foo`t]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[ComputationalEngine`Cond`t + 1], foo`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + ComputationalEngine`Cond`t]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[bar`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + bar`t]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[ComputationalEngine`Cond`t + 1], bar`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + ComputationalEngine`Cond`t]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev[foo`pi[bar`t + 1], goo`t, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1 + bar`t]]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20230514-33QJ3G"
]
VerificationTest[
	Apply[And,
		{
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`minTfun[ComputationalEngine`Cond`pi @ ComputationalEngine`Cond`t, {"pi"}], ComputationalEngine`Cond`t],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`minTfun[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1], {"pi"}], ComputationalEngine`Cond`t - 1],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`minTfun[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1], {"pi"}], Infinity],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`minTfun[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1], {"pi", "sg"}], ComputationalEngine`Cond`t - 1],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`minTfun[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 2], {"pi", "sg"}],
				ComputationalEngine`Cond`t - 1
			],
			SameQ[
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`minTfun[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t - 2],
					{"pi", "sg", "eps"}
				],
				ComputationalEngine`Cond`t - 1
			],
			SameQ[
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`minTfun[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] * ComputationalEngine`Cond`dd[ComputationalEngine`Cond`t - 2, ComputationalEngine`Cond`i],
					{"pi", "sg", "dd"}
				],
				ComputationalEngine`Cond`t - 2
			],
			SameQ[
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`minTfun[
					Plus[ComputationalEngine`Cond`pi @ ComputationalEngine`Cond`t,
						ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] + (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1] ^ 2) / ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 2]
					],
					{"pi"}
				],
				ComputationalEngine`Cond`t - 1
			],
			SameQ[
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`minTfun[
					Plus[ComputationalEngine`Cond`pi @ ComputationalEngine`Cond`t,
						ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] + (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1] ^ 2) / ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 2]
					],
					{"pi", "sg"}
				],
				ComputationalEngine`Cond`t - 2
			],
			SameQ[
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`minTfun[
					{
						Plus[ComputationalEngine`Cond`pi @ ComputationalEngine`Cond`t,
							ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 1] + (ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t - 1] ^ 2) / ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 2]
						],
						Sqrt[ComputationalEngine`Cond`sg[ComputationalEngine`Cond`t - 3]]
					},
					{"pi", "sg"}
				],
				ComputationalEngine`Cond`t - 3
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20230514-DLSZ3P"
]
VerificationTest[
	Apply[And,
		{
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`minTfun[ComputationalEngine`Cond`pi @ foo`t, {"pi"}], foo`t],
			Equal[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`minTfun[foo`pi @ ComputationalEngine`Cond`t, {"pi"}], ComputationalEngine`Cond`t],
			Equal[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`minTfun[foo`pi @ bar`t, {"pi"}], bar`t],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`minTfun[ComputationalEngine`Cond`pi[context1`t] * ComputationalEngine`Cond`pi[context2`t - 1], {"pi"}],
				Min[context1`t, context2`t - 1]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`minTfun[ComputationalEngine`Cond`pi[context1`t] * ComputationalEngine`Cond`sg[context2`t - 1], {"pi"}], context1`t],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`minTfun[ComputationalEngine`Cond`pi[context1`t] * ComputationalEngine`Cond`pi[context1`t - 1], {"pi"}],
				context1`t - 1
			],
			SameQ[
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`minTfun[(c1`sg[c2`t - 1] * foo`pi[ComputationalEngine`Cond`t]) - ComputationalEngine`Cond`pi[foo`t - 2],
					{"pi", "sg"}
				],
				Min[c2`t - 1, foo`t - 2, ComputationalEngine`Cond`t]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20230514-TPIND8"
]
VerificationTest[
	Apply[And,
		{
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`pi @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
					Plus[FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ComputationalEngine`Cond`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
						(FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Cond`t - 1]) + FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Cond`t]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC] /. ComputationalEngine`Cond`t -> (ComputationalEngine`Cond`t + 1)
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t + 1], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
					Plus[FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Cond`t],
						Plus[
							Times[
								FernandoDuarte`LongRunRisk`Model`Parameters`rhop,
								Plus[
									FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ComputationalEngine`Cond`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
									(FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Cond`t - 1]) + FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Cond`t]
								]
							],
							FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][1 + ComputationalEngine`Cond`t]
						]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t + 2], ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ComputationalEngine`Cond`t] * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][2 + ComputationalEngine`Cond`t]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				Times[FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Cond`t],
					Plus[FernandoDuarte`LongRunRisk`Model`Parameters`mup,
						Plus[FernandoDuarte`LongRunRisk`Model`Parameters`rhop * (FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ComputationalEngine`Cond`t - 1] - FernandoDuarte`LongRunRisk`Model`Parameters`mup),
							(FernandoDuarte`LongRunRisk`Model`Parameters`xip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Cond`t - 1]) + FernandoDuarte`LongRunRisk`Model`Parameters`phip * FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][ComputationalEngine`Cond`t]
						]
					]
				]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`delta, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`Parameters`delta],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`A @ 0, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A @ 0],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`R[ComputationalEngine`Cond`m - 1][0], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`R[ComputationalEngine`Cond`m - 1][0]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`pieq[ComputationalEngine`Cond`t, ComputationalEngine`Cond`m], ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`modNRC], ComputationalEngine`Cond`pieq[ComputationalEngine`Cond`t, ComputationalEngine`Cond`m]],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`wceq @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`t + 1, ComputationalEngine`Cond`modNRC], ComputationalEngine`Cond`wceq @ ComputationalEngine`Cond`t],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[{ComputationalEngine`Cond`pi @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`sg @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`dc @ ComputationalEngine`Cond`t}, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				{
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`pi @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`sg @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
					FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`dc @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`t, ComputationalEngine`Cond`modNRC]
				}
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[foo`pi @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`pi @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[foo`pi[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t], ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[foo`pi[ComputationalEngine`Cond`t] ^ 2, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] ^ 2, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[foo`pi[ComputationalEngine`Cond`t] * ComputationalEngine`Cond`eps["pi"][ComputationalEngine`Cond`t] * bar`delta, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t] * foo`eps["pi"][ComputationalEngine`Cond`t] * ComputationalEngine`Cond`delta, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`pi @ foo`t, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC], FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi @ foo`t],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`pi @ ComputationalEngine`Cond`t, ComputationalEngine`Cond`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`pi[foo`t], foo`t - 1, ComputationalEngine`Cond`modNRC] /. foo`t -> ComputationalEngine`Cond`t
			],
			SameQ[ExpandAll[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`pi[foo`t] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t], foo`t - 1, ComputationalEngine`Cond`modNRC]],
				ExpandAll[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ComputationalEngine`Cond`t] * FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`pi[foo`t], foo`t - 1, ComputationalEngine`Cond`modNRC]]
			],
			SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`lagStateVarst[ComputationalEngine`Cond`pi[foo`t - 1] * ComputationalEngine`Cond`pi[ComputationalEngine`Cond`t], foo`t - 1, ComputationalEngine`Cond`modNRC],
				FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[foo`t - 1] * FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[ComputationalEngine`Cond`t]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20230514-ZUL9KY"
]
VerificationTest[
	Unset @ $ContextAliases @ "ce`"
	,
	Null
	,
	{}
	,
	TestID->"ComputeConditionalExpectations_20230514-3SW7TI"
] 
End[]
EndTestSection[]
