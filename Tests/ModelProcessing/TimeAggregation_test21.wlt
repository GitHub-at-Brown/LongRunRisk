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

VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`h = 3;
	FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k = 2;
	Apply[And,
		Simplify[
			{
				Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t], FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t],
				Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, {"TimeAggregation" -> 3, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}],
					Subtract[
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
								Plus[
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
									Plus[
										FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
										Plus[
											FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1],
											Plus[
												FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t,
												Log[
													Plus[
														1,
														(E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1])) + E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t])
													]
												]
											]
										]
									]
								]
							]
						],
						Log[
							Plus[
								1,
								Plus[
									E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 7]),
									E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6])
								]
							]
						]
					]
				],
				Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, "TimeAggregation" -> 3, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
					Subtract[
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4],
								Plus[
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3],
									Plus[
										FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2],
										Plus[
											FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1],
											Plus[
												FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t,
												Log[
													Plus[
														1,
														(E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1])) + E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t])
													]
												]
											]
										]
									]
								]
							]
						],
						Log[
							Plus[
								1,
								Plus[
									E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 7]),
									E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dc[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6])
								]
							]
						]
					]
				],
				Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, {"TimeAggregation" -> 3, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}],
					Subtract[
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
								Plus[
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
									Plus[
										FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
										Plus[
											FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
											Plus[
												FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
												Log[
													Plus[
														1,
														Plus[
															E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]),
															E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i])
														]
													]
												]
											]
										]
									]
								]
							]
						],
						Log[
							Plus[
								1,
								Plus[
									Power[
										E,
										(-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 7, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]
									],
									E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i])
								]
							]
						]
					]
				],
				Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i, "TimeAggregation" -> 3, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
					Subtract[
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
								Plus[
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
									Plus[
										FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
										Plus[
											FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
											Plus[
												FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i],
												Log[
													Plus[
														1,
														Plus[
															E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]),
															E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i])
														]
													]
												]
											]
										]
									]
								]
							]
						],
						Log[
							Plus[
								1,
								Plus[
									Power[
										E,
										(-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 7, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i]
									],
									E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`i])
								]
							]
						]
					]
				],
				Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 1, {"TimeAggregation" -> 3, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k}],
					Subtract[
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5, 1],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4, 1],
								Plus[
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, 1],
									Plus[
										FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, 1],
										Plus[
											FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, 1],
											Plus[
												FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 1],
												Log[
													Plus[
														1,
														Plus[
															E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 1]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, 1]),
															E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 1])
														]
													]
												]
											]
										]
									]
								]
							]
						],
						Log[
							Plus[
								1,
								Plus[
									Power[
										E,
										(-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6, 1]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 7, 1]
									],
									E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6, 1])
								]
							]
						]
					]
				],
				Equal[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`gt[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd, FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 2, "TimeAggregation" -> 3, "numPeriods" -> FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`k],
					Subtract[
						Plus[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 5, 2],
							Plus[
								FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 4, 2],
								Plus[
									FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 3, 2],
									Plus[
										FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 2, 2],
										Plus[
											FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, 2],
											Plus[
												FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 2],
												Log[
													Plus[
														1,
														Plus[
															E ^ ((-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 2]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 1, 2]),
															E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t, 2])
														]
													]
												]
											]
										]
									]
								]
							]
						],
						Log[
							Plus[
								1,
								Plus[
									Power[
										E,
										(-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6, 2]) - FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 7, 2]
									],
									E ^ (-FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`dd[FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`t - 6, 2])
								]
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
	TestID->"TimeAggregation_20251223-437MTH@@Tests/TimeAggregation.wlt:956,1-1212,2"
]

End[]
EndTestSection[]
