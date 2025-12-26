BeginTestSection["TimeAggregation"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`"]

FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`longTest = False;
Off[General::stop];
	Needs @ "FernandoDuarte`LongRunRisk`Tools`TimeAggregation`";

(* === Shared State Setup === *)
FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`arbitraryFun1 = Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, v}, Sqrt @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h];
FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`arbitraryFun2 = Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, v},
		If[Equal[v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd], Sqrt @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, Cos @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h]
	];
FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`arbitraryFun3 = Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, v}, -FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h];
FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`arbitraryFun4 = Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, v},
		(Sqrt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h] * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k ^ 2
	];
FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`arbitraryFun5 = Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, v},
		If[Equal[v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd],
			Sqrt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h] * Sqrt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t],
			Exp[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t] * Cos[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h]
		]
	];
FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`arbitraryFun6 = Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, v}, (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h) * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k];

VerificationTest[
	Apply[And,
		Simplify[
			{
				Not[
					N[
						SameQ[0,
							Coefficient[
								ReplaceAll[
									FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[
										FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> 3, "v0" -> Function[{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k, v, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`im}, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`j]
									],
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[__] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX
								],
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dcX, 0
							]
						]
					]
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20251223-I7KL2Y@@Tests/TimeAggregation.wlt:540,1-568,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
