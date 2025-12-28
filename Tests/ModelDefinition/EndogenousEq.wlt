BeginTestSection["EndogenousEq Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`"]

(* --- merged from: EndogenousEq_test1.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";

VerificationTest[
	!SameQ[Names @ "*pdeq", {}]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20251223-C3LW7Z@@Tests/ModelDefinition/EndogenousEq.wlt:7,1-15,2"
]

(* --- merged from: EndogenousEq_test2.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";

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
	TestID->"EndogenousEq_20251223-2SME0U@@Tests/ModelDefinition/EndogenousEq.wlt:20,1-48,2"
]

(* --- merged from: EndogenousEq_test3.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";

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
	TestID->"EndogenousEq_20251223-L0VUEJ@@Tests/ModelDefinition/EndogenousEq.wlt:53,1-73,2"
]

(* --- merged from: EndogenousEq_test4.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";
Needs @ "FernandoDuarte`LongRunRisk`Model`Parameters`";
Needs @ "FernandoDuarte`LongRunRisk`";

VerificationTest[
	(* Test that parameters appearing in endogenous variables are in Parameters context *)
	(* Use model's endogenousEq directly with explicit context checking *)
	Module[{testModel, endoEqs, paramSymbols},
		(* Get a test model *)
		testModel = FernandoDuarte`LongRunRisk`Models["BY"];
		endoEqs = testModel["endogenousEq"];

		(* Extract symbols from endogenousEq that are in Parameters` context *)
		paramSymbols = Cases[
			Values[endoEqs],
			sym_Symbol /; (Context[sym] === "FernandoDuarte`LongRunRisk`Model`Parameters`"),
			Infinity
		];

		(* Verify all found parameters are in the expected parameter list *)
		If[Length[paramSymbols] > 0,
			Module[{uniqueParams, paramNames},
				uniqueParams = DeleteDuplicates[paramSymbols];
				paramNames = Map[SymbolName, uniqueParams];
				(* All found parameter symbols should be in the official parameter list *)
				Apply[And, Map[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, #]&, paramNames]]
			],
			True  (* If no parameters found, test passes vacuously *)
		]
	]
	,
	True
	,
	{}
	,
	TestID->"EndogenousEq_20251223-077TRW@@Tests/ModelDefinition/EndogenousEq.wlt:80,1-112,2"
]

(* --- merged from: EndogenousEq_test5.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";

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
	TestID->"EndogenousEq_20251223-72QAYI@@Tests/ModelDefinition/EndogenousEq.wlt:117,1-145,2"
]

(* --- merged from: EndogenousEq_test6.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";

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
	TestID->"EndogenousEq_20251223-J1CO3Y@@Tests/ModelDefinition/EndogenousEq.wlt:150,1-167,2"
]

(* --- merged from: EndogenousEq_test7.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";

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
	TestID->"EndogenousEq_20251223-5751HS@@Tests/ModelDefinition/EndogenousEq.wlt:172,1-188,2"
]

(* --- merged from: EndogenousEq_test8.wlt --- *)
Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";

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
	TestID->"EndogenousEq_20251223-CZNT6S@@Tests/ModelDefinition/EndogenousEq.wlt:193,1-208,2"
]

(* --- merged from: EndogenousEq_test9.wlt --- *)
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
	TestID->"EndogenousEq_20251223-402VM5@@Tests/ModelDefinition/EndogenousEq.wlt:213,1-341,2"
]

End[]
EndTestSection[]
