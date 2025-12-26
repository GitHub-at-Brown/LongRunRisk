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

VerificationTest[
	If[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`longTest,
		Apply[And,
			{
				Apply[And,
					Map[
						Function[
							Apply[
								And,
								Map[
									SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
									Map[
										Context,
										Cases[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["stateVars"],
											RuleDelayed[
												PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
												FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				],
				Apply[And,
					Map[
						Function[
							Apply[
								And,
								Map[
									SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
									Map[
										Context,
										Cases[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["modelAssumptions"],
											RuleDelayed[
												PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
												FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				],
				Apply[And,
					Map[
						Function[
							Apply[
								And,
								Map[
									SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
									Map[
										Context,
										Cases[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["exogenousEq"],
											RuleDelayed[
												PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
												FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				],
				Apply[And,
					Map[
						Function[
							Apply[
								And,
								Map[
									SameQ[#, "FernandoDuarte`LongRunRisk`Model`Shocks`"]&,
									Map[
										Context,
										Cases[
											FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP[#]["endogenousEq"],
											RuleDelayed[
												PatternTest[FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var_Symbol, Function[MatchQ[SymbolName[#], "eps"]]][__][__],
												FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`var
											],
											Infinity
										]
									]
								]
							]
						],
						Keys @ FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`modelsP
					]
				]
			}
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"ProcessModels_20251223-D3T7VH@@Tests/ProcessModels.wlt:321,1-431,2"
]

End[]
EndTestSection[]
