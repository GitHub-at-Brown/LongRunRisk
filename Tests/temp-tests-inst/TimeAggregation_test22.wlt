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

FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`f = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`f;
FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`g = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g;
FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`s = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`s;
FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`timeSeriesVector = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`timeSeriesVector;
FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`gt;

FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 2;

VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 2;
	Apply[And,
		Simplify[
			{
				Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t],
				Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "Variable" -> "Stock"], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t],
				Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "Variable" -> "Stock"],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]
				],
				Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, {"numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}, "Variable" -> "Stock"],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]
				],
				Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "Variable" -> "Stock"], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]],
				Equal[
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 1, {"TimeAggregation" -> 3}, "Variable" -> "Stock"],
					FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, 1] + FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 1]
				],
				Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 2, "Variable" -> "Stock"], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 2]]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20251223-Q8KJ84@@Tests/TimeAggregation.wlt:1213,1-1242,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
