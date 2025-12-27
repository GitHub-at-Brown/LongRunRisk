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

FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 1;
FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;

FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 2;
FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;
FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`rulej = Table[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[(FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k) + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
		{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, 0, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h - 2}
	];

FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;
FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`rulej = Table[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[(FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k) + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
		{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, 0, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h - 2}
	];

FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 4;
FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 1;
FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`rulej = Table[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i] -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`F[(FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h * FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k) + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
		{FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, 0, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h - 2}
	];

VerificationTest[
	Apply[And,
		Simplify[
			{
				SameQ[
					Cases[
						Expand[
							FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 0]
						],
						Times[Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`coef_], Power[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[__, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i], Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p_]]] :> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p
					],
					{}
				],
				SameQ[
					Max[
						Cases[
							Expand[
								FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 1]
							],
							Times[Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`coef_], Power[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[__, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i], Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p_]]] :> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p
						]
					],
					1
				],
				SameQ[
					Max[
						Cases[
							Expand[
								FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 2]
							],
							Times[Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`coef_], Power[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[__, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i], Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p_]]] :> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p
						]
					],
					2
				],
				SameQ[
					Max[
						Cases[
							Expand[
								FernandoDuarte`LongRunRisk`Tools`TimeAggregation`growth[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 3]
							],
							Times[Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`coef_], Power[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[__, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i], Optional[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p_]]] :> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`p
						]
					],
					3
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20251223-M73FMI@@Tests/ModelProcessing/TimeAggregation_test19.wlt:46,1-101,2"
]

End[]
EndTestSection[]
