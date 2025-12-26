BeginTestSection["ProcessModels"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`"]

Needs @ "FernandoDuarte`LongRunRisk`";
	Needs @ "FernandoDuarte`LongRunRisk`Model`ProcessModels`";
Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";
FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest = False;

(* === Shared State Setup === *)
FernandoDuarte`LongRunRisk`Models = Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsTest = If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest, FernandoDuarte`LongRunRisk`Model`Catalog`models, KeyTake[FernandoDuarte`LongRunRisk`Model`Catalog`models, {"BY", "BKY", "NRC"}]];
FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP = If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest, FernandoDuarte`LongRunRisk`Models, KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY", "BKY", "NRC"}]];

FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelPNRC = FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP @ "NRC";

VerificationTest[
	Apply[And,
		{
			Apply[And,
				Map[MatchQ[{}, #]&,
					Map[
						Function[
							Cases[
								FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`wc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
								RuleDelayed[
									PatternTest[
										FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol,
										Function[
											MemberQ[
												Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars],
												SymbolName[#]
											]
										]
									][__],
									FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
								],
								Infinity
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				]
			],
			Apply[And,
				Map[MatchQ[#, "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&,
					Flatten[
						Map[
							Function[
								Cases[
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`wc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol,
											Function[
												MemberQ[
													Map[Function[StringDrop[#, -2]], FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars],
													SymbolName[#]
												]
											]
										][__],
										Context @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
						]
					]
				]
			],
			Apply[And,
				Map[MatchQ[#, "FernandoDuarte`LongRunRisk`Model`Parameters`"]&,
					Flatten[
						Map[
							Function[
								Cases[
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`wc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters, SymbolName[#]]]],
										Context @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
						]
					]
				]
			],
			Apply[And,
				Map[MatchQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
					Flatten[
						Map[
							Function[
								Cases[
									FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`wc[FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t] //. Normal[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"]],
									RuleDelayed[
										PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
										Context @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
									],
									Infinity
								]
							],
							Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
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
	TestID->"ProcessModels_20251223-9LS8U8@@Tests/ProcessModels.wlt:888,1-989,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
