BeginTestSection["CreateEulerEq"] 
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`"]

FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest = False;

(* === Shared State Setup === *)
Needs @ "FernandoDuarte`LongRunRisk`";
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`msp = FernandoDuarte`LongRunRisk`Models;
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modBY = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`msp @ "BY";
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modNRC = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`msp @ "NRC";
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modDES = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`msp @ "DES";
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods = {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modBY, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modNRC, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modDES};

FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`eulereq = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`eulereq;
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nomeulereq = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`nomeulereq;
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`findEulerEqConstants = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants;
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ee[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model_] := {
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`eulereq[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`retc[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model],
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`eulereq[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`j], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model],
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`eulereq[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`bondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model],
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nomeulereq[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nombondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model]
	};
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`eeAll = Map[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ee, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods];
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffWc[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model_] := Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`i, {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`i, Length @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t]}];
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffPd[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model_] := Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`i, {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`i, Length @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t]}];
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffBond[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model_] := Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`i, {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`i, Length @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t]}];
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffNomBond[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model_] := Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`i, {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`i, Length @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t]}];
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffWcAll = Map[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffWc, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods];
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffPdAll = Map[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffPd, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods];
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffBondAll = Map[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffBond, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods];
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffNomBondAll = Map[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffNomBond, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods];

VerificationTest[
	Apply[And,
		Flatten[
			{
				Map[
					Function[
						Equal[
							Max[
								Keys[
									CoefficientRules[
										#,
										DeleteDuplicates[
											Cases[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modBY["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t], Blank[Symbol][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t] ^ Optional[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`p_], Infinity]
										]
									]
								]
							],
							1
						]
					],
					FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ee @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modBY
				],
				Map[
					Function[
						Equal[
							Max[
								Keys[
									CoefficientRules[
										#,
										DeleteDuplicates[
											Cases[
												FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modNRC["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t],
												Blank[Symbol][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t] ^ Optional[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`p_],
												Infinity
											]
										]
									]
								]
							],
							1
						]
					],
					FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ee @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modNRC
				],
				Map[
					Function[
						Equal[
							Max[
								Keys[
									CoefficientRules[
										#,
										DeleteDuplicates[
											Cases[
												FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modDES["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t],
												Blank[Symbol][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t] ^ Optional[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`p_],
												Infinity
											]
										]
									]
								]
							],
							1
						]
					],
					FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ee @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modDES
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251223-4AUI3V@@Tests/CreateEulerEq.wlt:65,1-140,2"
]

End[]
EndTestSection[]