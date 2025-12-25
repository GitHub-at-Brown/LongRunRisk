BeginTestSection["CreateEulerEq"] 
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`"]

FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest = False;

(* === Shared State Setup === *)
FernandoDuarte`LongRunRisk`Models = Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
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
	If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest,
		Apply[And,
			Flatten[
				{
					SameQ[Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`retc[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t], #]&, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods],
						Map[Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`retc[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1], #]], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods]
					],
					SameQ[Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`j], #]&, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods],
						Map[Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`j], #]], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods]
					],
					SameQ[Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`bondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #]&, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods],
						Map[Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`bondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #]], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods]
					],
					SameQ[
						Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nombondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #, True]&, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods],
						Map[
							Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nombondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #, True]],
							FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
						]
					]
				}
			]
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251223-6Y9I2S@@Tests/CreateEulerEq.wlt:306,1-338,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
