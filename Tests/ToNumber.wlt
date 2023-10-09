BeginTestSection["ToNumber"] 
Begin["Tools`ToNumber`"]
Needs @ "FernandoDuarte`LongRunRisk`Tools`ToNumber`";
$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`"];
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Tools`ToNumber`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`"];
	True
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20231008-GF1J8P"
]
VerificationTest[
	Off[General::stop];
	Off[FindRoot::lstol];
	Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`";
	Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`";
	Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";
	Needs @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`";
	Needs @ "FernandoDuarte`LongRunRisk`Tools`TimeAggregation`";
	Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`";
	Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
	Tools`ToNumber`msp = FernandoDuarte`LongRunRisk`Models;
	Tools`ToNumber`modBY = Tools`ToNumber`msp @ "BY";
	Tools`ToNumber`modBKY = Tools`ToNumber`msp @ "BKY";
	Tools`ToNumber`modNRC = Tools`ToNumber`msp @ "NRC";
	Tools`ToNumber`modDES = Tools`ToNumber`msp @ "DES";
	Tools`ToNumber`modNRCStochVol = Tools`ToNumber`msp @ "NRCStochVol";
	Tools`ToNumber`mods = {Tools`ToNumber`modBY, Tools`ToNumber`modBKY, Tools`ToNumber`modNRC, Tools`ToNumber`modDES, Tools`ToNumber`modNRCStochVol};
	FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`expr[Tools`ToNumber`t_, Tools`ToNumber`m_, Tools`ToNumber`i_, Tools`ToNumber`mu_] := {
		Tools`ToNumber`wc @ Tools`ToNumber`t, Tools`ToNumber`pd[Tools`ToNumber`t, Tools`ToNumber`i],
		Tools`ToNumber`bond[Tools`ToNumber`t, Tools`ToNumber`m],
		Tools`ToNumber`nombond[Tools`ToNumber`t, Tools`ToNumber`m],
		Tools`ToNumber`bondexcret[Tools`ToNumber`t, Tools`ToNumber`m],
		Tools`ToNumber`bondfw[Tools`ToNumber`t, Tools`ToNumber`m],
		Tools`ToNumber`bondfwspread[Tools`ToNumber`t, Tools`ToNumber`m],
		Tools`ToNumber`bondret[Tools`ToNumber`t, Tools`ToNumber`m],
		Tools`ToNumber`bondyield[Tools`ToNumber`t, Tools`ToNumber`m],
		Tools`ToNumber`excretc @ Tools`ToNumber`t, Tools`ToNumber`excret[Tools`ToNumber`t, Tools`ToNumber`i],
		Tools`ToNumber`kappa0 @ Tools`ToNumber`mu, Tools`ToNumber`kappa1 @ Tools`ToNumber`mu, Tools`ToNumber`nombondexcret[Tools`ToNumber`t, Tools`ToNumber`m],
		Tools`ToNumber`nombondfw[Tools`ToNumber`t, Tools`ToNumber`m],
		Tools`ToNumber`nombondfwspread[Tools`ToNumber`t, Tools`ToNumber`m],
		Tools`ToNumber`nombondret[Tools`ToNumber`t, Tools`ToNumber`m],
		Tools`ToNumber`nombondyield[Tools`ToNumber`t, Tools`ToNumber`m],
		Tools`ToNumber`nomrf @ Tools`ToNumber`t, Tools`ToNumber`nomsdf @ Tools`ToNumber`t, Tools`ToNumber`retc @ Tools`ToNumber`t, Tools`ToNumber`ret[Tools`ToNumber`t, Tools`ToNumber`i],
		Tools`ToNumber`rf @ Tools`ToNumber`t, Tools`ToNumber`sdf @ Tools`ToNumber`t, Tools`ToNumber`pi @ Tools`ToNumber`t, Tools`ToNumber`dc @ Tools`ToNumber`t, Tools`ToNumber`growth[Tools`ToNumber`dc, Tools`ToNumber`t, "TimeAggregation" -> 2, "numPeriods" -> 1],
		Tools`ToNumber`growth[Tools`ToNumber`dd, Tools`ToNumber`t, 1, "TimeAggregation" -> 2],
		Tools`ToNumber`AA * Tools`ToNumber`dc[Tools`ToNumber`t + 1] * Tools`ToNumber`excret[Tools`ToNumber`t, 1],
		(Tools`ToNumber`AA * Tools`ToNumber`excret[Tools`ToNumber`t, 1]) + Tools`ToNumber`BB * Tools`ToNumber`nombondyield[Tools`ToNumber`t, 2]
	};
	Tools`ToNumber`ee = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`expr[Tools`ToNumber`t, 3, 1, 1];
	Tools`ToNumber`e1 = Tools`ToNumber`ee[[1;;3]];
	Tools`ToNumber`e2 = Tools`ToNumber`ee[[1;;2]];
	Tools`ToNumber`optsList = {
		{},
		{Tools`ToNumber`maxMaturity -> 6},
		{"FindRootOptions" -> {MaxIterations -> 100}},
		{MaxIterations -> 100},
		{"initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>},
		{
			"initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>,
			MaxIterations -> 100
		},
		{
			"initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>,
			"FindRootOptions" -> {MaxIterations -> 100}
		},
		{
			Tools`ToNumber`maxMaturity -> 6,
			"initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>,
			MaxIterations -> 100
		},
		{"PrintResidualsNorm" -> True},
		{"CheckResiduals" -> True, "Tol" -> 1},
		{"CheckResiduals" -> True, "Tol" -> (10. ^ -20)},
		{
			"PrintResidualsNorm" -> True, Tools`ToNumber`maxMaturity -> 6, "initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>,
			MaxIterations -> 100
		},
		{"RecurrenceTableOptions" -> {"DependentVariables" -> Automatic}},
		{DependentVariables -> Automatic}
	};
	FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`opts = Tools`ToNumber`optsList[[1;;5]];
	FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters = {Tools`ToNumber`delta -> 0.99};
	FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution = {Tools`ToNumber`A[0] -> 4.6};
	Tools`ToNumber`optNewParam = {
		"initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>,
		MaxIterations -> 100
	};
	Tools`ToNumber`exprNewParam = Tools`ToNumber`uncondE @ Tools`ToNumber`wc @ Tools`ToNumber`t;
	AbortProtect[
		Do[
			FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind = 0;
			Tools`ToNumber`stateVars = Map[
				Slot[1][_]&,
				DeleteDuplicates[
					DeleteCases[
						Cases[Variables @ FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model["stateVars"][Tools`ToNumber`t], Pattern[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`x, _][_] :> FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`x],
						0
					]
				]
			];
			Tools`ToNumber`numModel = Join[
				Thread[Tools`ToNumber`stateVars -> 1.],
				{
					FernandoDuarte`LongRunRisk`Model`Shocks`eps[_][_] -> 1,
					FernandoDuarte`LongRunRisk`Model`Shocks`eps[_][_, _] -> 1.,
					Tools`ToNumber`mu -> 2., Tools`ToNumber`AA -> -1., Tools`ToNumber`BB -> 3.
				}
			];
			Tools`ToNumber`toNum = FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum;
			Tools`ToNumber`toEquation = FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation;
			Tools`ToNumber`toExogenousVars = FernandoDuarte`LongRunRisk`Tools`ToNumber`toExogenousVars;
			Tools`ToNumber`toStateVars = FernandoDuarte`LongRunRisk`Tools`ToNumber`toStateVars;
			Tools`ToNumber`processNewParameters = FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters;
			Tools`ToNumber`uncondE = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE;
			Tools`ToNumber`uncondVar = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondVar;
			Tools`ToNumber`uncondCov = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondCov;
			Tools`ToNumber`uncondCorr = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondCorr;
			Tools`ToNumber`ev = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev;
			Tools`ToNumber`var = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`var;
			Tools`ToNumber`cov = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`cov;
			Tools`ToNumber`corr = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`corr;
			Tools`ToNumber`tn = FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum @ FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model;
			Tools`ToNumber`outTests[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind] = Apply[
				And,
				Flatten[
					{
						SameQ[Head @ Tools`ToNumber`tn, Function],
						Map[NumericQ,
							Flatten[
								{
									Tools`ToNumber`tn[Tools`ToNumber`e1] //. Tools`ToNumber`numModel,
									Tools`ToNumber`tn[Map[Tools`ToNumber`uncondE, Tools`ToNumber`e1]] //. Tools`ToNumber`numModel,
									Tools`ToNumber`tn[Map[Tools`ToNumber`uncondVar, Tools`ToNumber`e1]] //. Tools`ToNumber`numModel,
									Tools`ToNumber`tn[MapThread[Tools`ToNumber`uncondCov[#, #2]&, {Tools`ToNumber`e1, Reverse[Tools`ToNumber`e1]}]] //. Tools`ToNumber`numModel,
									ReplaceRepeated[
										Tools`ToNumber`tn[
											MapThread[
												Tools`ToNumber`uncondCorr[#, #2]&,
												{Tools`ToNumber`e1[[1;;2]], Tools`ToNumber`e1[[-2;;-1]]}
											]
										],
										Tools`ToNumber`numModel
									],
									ReplaceRepeated[
										Tools`ToNumber`tn[Map[Tools`ToNumber`ev[#, Tools`ToNumber`t - 1]&, Tools`ToNumber`e1]],
										Tools`ToNumber`numModel
									],
									ReplaceRepeated[
										Tools`ToNumber`tn[Map[Tools`ToNumber`var[#, Tools`ToNumber`t - 1]&, Tools`ToNumber`e1]],
										Tools`ToNumber`numModel
									],
									ReplaceRepeated[
										Tools`ToNumber`tn[
											MapThread[Tools`ToNumber`cov[#, #2, Tools`ToNumber`t - 1]&, {Tools`ToNumber`e1, Reverse @ Tools`ToNumber`e1}]
										],
										Tools`ToNumber`numModel
									],
									ReplaceRepeated[
										Tools`ToNumber`tn[
											MapThread[
												Tools`ToNumber`corr[#, #2, Tools`ToNumber`t - 1]&,
												{Tools`ToNumber`e1[[1;;2]], Tools`ToNumber`e1[[-2;;-1]]}
											]
										],
										Tools`ToNumber`numModel
									]
								}
							]
						]
					}
				]
			];
			FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind + 1;
			Tools`ToNumber`outTests[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind] = Apply[
				And,
				Flatten[
					{
						SameQ[Head @ Tools`ToNumber`tn, Function],
						Map[NumericQ,
							Flatten[
								{
									FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[Tools`ToNumber`e1, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model] //. Tools`ToNumber`numModel,
									FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[Map[Tools`ToNumber`uncondE, Tools`ToNumber`e1], FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model] //. Tools`ToNumber`numModel,
									FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[Map[Tools`ToNumber`uncondVar, Tools`ToNumber`e1], FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model] //. Tools`ToNumber`numModel,
									ReplaceRepeated[
										FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[MapThread[Tools`ToNumber`uncondCov[#, #2]&, {Tools`ToNumber`e1, Reverse @ Tools`ToNumber`e1}], FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model],
										Tools`ToNumber`numModel
									],
									ReplaceRepeated[
										FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
											MapThread[
												Tools`ToNumber`uncondCorr[#, #2]&,
												{Tools`ToNumber`e1[[1;;2]], Tools`ToNumber`e1[[-2;;-1]]}
											],
											FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model
										],
										Tools`ToNumber`numModel
									],
									ReplaceRepeated[
										FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
											Map[Tools`ToNumber`ev[#, Tools`ToNumber`t - 1]&, Tools`ToNumber`e1],
											FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model
										],
										Tools`ToNumber`numModel
									],
									ReplaceRepeated[
										FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
											Map[Tools`ToNumber`var[#, Tools`ToNumber`t - 1]&, Tools`ToNumber`e1],
											FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model
										],
										Tools`ToNumber`numModel
									],
									ReplaceRepeated[
										FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
											MapThread[Tools`ToNumber`cov[#, #2, Tools`ToNumber`t - 1]&, {Tools`ToNumber`e1, Reverse @ Tools`ToNumber`e1}],
											FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model
										],
										Tools`ToNumber`numModel
									],
									ReplaceRepeated[
										FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
											MapThread[
												Tools`ToNumber`corr[#, #2, Tools`ToNumber`t - 1]&,
												{Tools`ToNumber`e1[[1;;2]], Tools`ToNumber`e1[[-2;;-1]]}
											],
											FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model
										],
										Tools`ToNumber`numModel
									]
								}
							]
						]
					}
				]
			];
			FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind + 1;
			Tools`ToNumber`outTests[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind] = Apply[
				And,
				Flatten[
					{
						SameQ[Head @ Tools`ToNumber`tn, Function],
						Map[NumericQ,
							ReplaceRepeated[
								Flatten[
									{
										FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Tools`ToNumber`e1, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model] //. Tools`ToNumber`numModel,
										FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Map[Tools`ToNumber`uncondE, Tools`ToNumber`e1], FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model] //. Tools`ToNumber`numModel,
										FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Map[Tools`ToNumber`uncondVar, Tools`ToNumber`e1], FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model] //. Tools`ToNumber`numModel,
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[MapThread[Tools`ToNumber`uncondCov[#, #2]&, {Tools`ToNumber`e1, Reverse @ Tools`ToNumber`e1}], FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model],
											Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
												MapThread[
													Tools`ToNumber`uncondCorr[#, #2]&,
													{Tools`ToNumber`e1[[1;;2]], Tools`ToNumber`e1[[-2;;-1]]}
												],
												FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model
											],
											Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
												Map[Tools`ToNumber`ev[#, Tools`ToNumber`t - 1]&, Tools`ToNumber`e1],
												FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model
											],
											Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
												Map[Tools`ToNumber`var[#, Tools`ToNumber`t - 1]&, Tools`ToNumber`e1],
												FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model
											],
											Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
												MapThread[Tools`ToNumber`cov[#, #2, Tools`ToNumber`t - 1]&, {Tools`ToNumber`e1, Reverse @ Tools`ToNumber`e1}],
												FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model
											],
											Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
												MapThread[
													Tools`ToNumber`corr[#, #2, Tools`ToNumber`t - 1]&,
													{Tools`ToNumber`e1[[1;;2]], Tools`ToNumber`e1[[-2;;-1]]}
												],
												FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model
											],
											Tools`ToNumber`numModel
										]
									}
								],
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum["Rules", FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model]
							]
						]
					}
				]
			];
			FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind + 1;
			Do[
				Tools`ToNumber`tn = FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, Sequence @@ Tools`ToNumber`opt];
				Tools`ToNumber`outTests[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind] = Apply[
					And,
					Flatten[
						{
							SameQ[Head @ Tools`ToNumber`tn, Function],
							Map[
								NumericQ,
								Flatten[
									{
										Tools`ToNumber`tn[Tools`ToNumber`e2] //. Tools`ToNumber`numModel,
										Tools`ToNumber`tn[Map[Tools`ToNumber`uncondE, Tools`ToNumber`e2]] //. Tools`ToNumber`numModel,
										Tools`ToNumber`tn[Map[Tools`ToNumber`uncondVar, Tools`ToNumber`e2]] //. Tools`ToNumber`numModel,
										Tools`ToNumber`tn[MapThread[Tools`ToNumber`uncondCov[#, #2]&, {Tools`ToNumber`e2, Reverse[Tools`ToNumber`e2]}]] //. Tools`ToNumber`numModel,
										ReplaceRepeated[
											Tools`ToNumber`tn[
												MapThread[
													Tools`ToNumber`uncondCorr[#, #2]&,
													{Tools`ToNumber`e2[[1;;2]], Tools`ToNumber`e2[[-2;;-1]]}
												]
											],
											Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											Tools`ToNumber`tn[Map[Tools`ToNumber`ev[#, Tools`ToNumber`t - 1]&, Tools`ToNumber`e2]],
											Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											Tools`ToNumber`tn[Map[Tools`ToNumber`var[#, Tools`ToNumber`t - 1]&, Tools`ToNumber`e2]],
											Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											Tools`ToNumber`tn[
												MapThread[Tools`ToNumber`cov[#, #2, Tools`ToNumber`t - 1]&, {Tools`ToNumber`e2, Reverse @ Tools`ToNumber`e2}]
											],
											Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											Tools`ToNumber`tn[
												MapThread[
													Tools`ToNumber`corr[#, #2, Tools`ToNumber`t - 1]&,
													{Tools`ToNumber`e2[[1;;2]], Tools`ToNumber`e2[[-2;;-1]]}
												]
											],
											Tools`ToNumber`numModel
										]
									}
								]
							]
						}
					]
				];
				FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind + 1;
				Tools`ToNumber`outTests[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind] = Apply[
					And,
					Flatten[
						{
							SameQ[Head @ Tools`ToNumber`tn, Function],
							Map[
								NumericQ,
								Flatten[
									{
										FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[Tools`ToNumber`e2, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, Apply[Sequence, Tools`ToNumber`opt]] //. Tools`ToNumber`numModel,
										FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[Map[Tools`ToNumber`uncondE, Tools`ToNumber`e2], FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, Sequence @@ Tools`ToNumber`opt] //. Tools`ToNumber`numModel,
										FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[Map[Tools`ToNumber`uncondVar, Tools`ToNumber`e2], FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, Sequence @@ Tools`ToNumber`opt] //. Tools`ToNumber`numModel,
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
												MapThread[Tools`ToNumber`uncondCov[#, #2]&, {Tools`ToNumber`e2, Reverse @ Tools`ToNumber`e2}],
												FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, Sequence @@ Tools`ToNumber`opt
											],
											Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
												MapThread[
													Tools`ToNumber`uncondCorr[#, #2]&,
													{Tools`ToNumber`e2[[1;;2]], Tools`ToNumber`e2[[-2;;-1]]}
												],
												FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, Sequence @@ Tools`ToNumber`opt
											],
											Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
												Map[Tools`ToNumber`ev[#, Tools`ToNumber`t - 1]&, Tools`ToNumber`e2],
												FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, Sequence @@ Tools`ToNumber`opt
											],
											Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
												Map[Tools`ToNumber`var[#, Tools`ToNumber`t - 1]&, Tools`ToNumber`e2],
												FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, Sequence @@ Tools`ToNumber`opt
											],
											Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
												MapThread[Tools`ToNumber`cov[#, #2, Tools`ToNumber`t - 1]&, {Tools`ToNumber`e2, Reverse @ Tools`ToNumber`e2}],
												FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, Sequence @@ Tools`ToNumber`opt
											],
											Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
												MapThread[
													Tools`ToNumber`corr[#, #2, Tools`ToNumber`t - 1]&,
													{Tools`ToNumber`e2[[1;;2]], Tools`ToNumber`e2[[-2;;-1]]}
												],
												FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, Sequence @@ Tools`ToNumber`opt
											],
											Tools`ToNumber`numModel
										]
									}
								]
							]
						}
					]
				];
				FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind + 1;
				Tools`ToNumber`outTests[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind] = Apply[
					And,
					Flatten[
						{
							SameQ[Head @ Tools`ToNumber`tn, Function],
							Map[
								NumericQ,
								ReplaceRepeated[
									Flatten[
										{
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Tools`ToNumber`e2, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model] //. Tools`ToNumber`numModel,
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Map[Tools`ToNumber`uncondE, Tools`ToNumber`e2], FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model] //. Tools`ToNumber`numModel,
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Map[Tools`ToNumber`uncondVar, Tools`ToNumber`e2], FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model] //. Tools`ToNumber`numModel,
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[MapThread[Tools`ToNumber`uncondCov[#, #2]&, {Tools`ToNumber`e2, Reverse @ Tools`ToNumber`e2}], FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model],
												Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
													MapThread[
														Tools`ToNumber`uncondCorr[#, #2]&,
														{Tools`ToNumber`e2[[1;;2]], Tools`ToNumber`e2[[-2;;-1]]}
													],
													FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model
												],
												Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
													Map[Tools`ToNumber`ev[#, Tools`ToNumber`t - 1]&, Tools`ToNumber`e2],
													FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model
												],
												Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
													Map[Tools`ToNumber`var[#, Tools`ToNumber`t - 1]&, Tools`ToNumber`e2],
													FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model
												],
												Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
													MapThread[Tools`ToNumber`cov[#, #2, Tools`ToNumber`t - 1]&, {Tools`ToNumber`e2, Reverse @ Tools`ToNumber`e2}],
													FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model
												],
												Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
													MapThread[
														Tools`ToNumber`corr[#, #2, Tools`ToNumber`t - 1]&,
														{Tools`ToNumber`e2[[1;;2]], Tools`ToNumber`e2[[-2;;-1]]}
													],
													FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model
												],
												Tools`ToNumber`numModel
											]
										}
									],
									FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum["Rules", FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, Sequence @@ Tools`ToNumber`opt]
								]
							]
						}
					]
				];
				FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind + 1;
			,
				{Tools`ToNumber`opt, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`opts}
			];
			Tools`ToNumber`outTests[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind] = Apply[
				And,
				Map[NumericQ,
					Flatten[
						{
							ReplaceRepeated[FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, "UpdatePd" -> False], Tools`ToNumber`numModel][Tools`ToNumber`pd[Tools`ToNumber`t, 1]],
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[Tools`ToNumber`pd[Tools`ToNumber`t, 1], FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, "UpdatePd" -> False] //. Tools`ToNumber`numModel,
							ReplaceRepeated[
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Tools`ToNumber`pd[Tools`ToNumber`t, 1], FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model] //. FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum["Rules", FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, "UpdatePd" -> False],
								Tools`ToNumber`numModel
							],
							ReplaceRepeated[FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, "UpdateBonds" -> False], Tools`ToNumber`numModel][{Tools`ToNumber`bondyield[Tools`ToNumber`t, 2], Tools`ToNumber`nombondyield[Tools`ToNumber`t, 3]}],
							ReplaceRepeated[
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
									{Tools`ToNumber`bondyield[Tools`ToNumber`t, 2], Tools`ToNumber`nombondyield[Tools`ToNumber`t, 3]},
									FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, "UpdateBonds" -> False
								],
								Tools`ToNumber`numModel
							],
							ReplaceRepeated[
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[{Tools`ToNumber`bondyield[Tools`ToNumber`t, 2], Tools`ToNumber`nombondyield[Tools`ToNumber`t, 3]}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model] //. FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum["Rules", FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, "UpdateBonds" -> False],
								Tools`ToNumber`numModel
							]
						}
					]
				]
			];
			FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind + 1;
			Tools`ToNumber`outTests[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind] = Apply[
				And,
				Map[NumericQ,
					{
						ReplaceRepeated[FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters], Tools`ToNumber`numModel][Tools`ToNumber`exprNewParam],
						FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters] //. Tools`ToNumber`numModel,
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model] //. FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum["Rules", FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters],
							Tools`ToNumber`numModel
						],
						ReplaceRepeated[FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, {}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution], Tools`ToNumber`numModel][Tools`ToNumber`exprNewParam],
						FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, {}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution] //. Tools`ToNumber`numModel,
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model] //. FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum["Rules", FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, {}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution],
							Tools`ToNumber`numModel
						],
						ReplaceRepeated[FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution], Tools`ToNumber`numModel][Tools`ToNumber`exprNewParam],
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution],
							Tools`ToNumber`numModel
						],
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model] //. FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum["Rules", FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution],
							Tools`ToNumber`numModel
						],
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters, Sequence @@ Tools`ToNumber`optNewParam],
							Tools`ToNumber`numModel
						][Tools`ToNumber`exprNewParam],
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters, Sequence @@ Tools`ToNumber`optNewParam],
							Tools`ToNumber`numModel
						],
						ReplaceRepeated[
							ReplaceRepeated[
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model],
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum["Rules", FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters, Sequence @@ Tools`ToNumber`optNewParam]
							],
							Tools`ToNumber`numModel
						],
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, {}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution, Sequence @@ Tools`ToNumber`optNewParam],
							Tools`ToNumber`numModel
						][Tools`ToNumber`exprNewParam],
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
								Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, {}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution, Sequence @@ Tools`ToNumber`optNewParam
							],
							Tools`ToNumber`numModel
						],
						ReplaceRepeated[
							ReplaceRepeated[
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model],
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum["Rules", FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, {}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution, Sequence @@ Tools`ToNumber`optNewParam]
							],
							Tools`ToNumber`numModel
						],
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution, Sequence @@ Tools`ToNumber`optNewParam],
							Tools`ToNumber`numModel
						][Tools`ToNumber`exprNewParam],
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
								Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution, Sequence @@ Tools`ToNumber`optNewParam
							],
							Tools`ToNumber`numModel
						],
						ReplaceRepeated[
							ReplaceRepeated[
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model],
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
									"Rules", FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution, Sequence @@ Tools`ToNumber`optNewParam
								]
							],
							Tools`ToNumber`numModel
						]
					}
				]
			];
			FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind + 1;
		,
			{FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, Tools`ToNumber`mods}
		];
	];
	Tools`ToNumber`noMissingTest = {};
	Do[
		Tools`ToNumber`testNumber = Sort[
			Cases[Keys @ SubValues @ Tools`ToNumber`outTests,
				RuleDelayed[
					Verbatim[HoldPattern][Tools`ToNumber`outTests[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model["shortname"]][Tools`ToNumber`i_Integer]],
					Tools`ToNumber`i
				]
			]
		];
		AppendTo[Tools`ToNumber`noMissingTest, Equal[Range[0, Max @ Tools`ToNumber`testNumber], Tools`ToNumber`testNumber]];
	,
		{FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`model, Tools`ToNumber`mods}
	];
	Tools`ToNumber`out = Apply[
		And,
		Flatten[
			{
				Apply[And, Tools`ToNumber`noMissingTest],
				Apply[And, Values @ SubValues @ Tools`ToNumber`outTests]
			}
		]
	];
	On[General::stop];
	Off[FindRoot::lstol];
	Tools`ToNumber`out
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20231008-9U9EGD"
]
VerificationTest[
	Tools`ToNumber`processNewParameters = FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters;
	SetAttributes[Tools`ToNumber`checkAbrt, HoldAll];
	Tools`ToNumber`checkAbrt[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`expr_] := TrueQ[Quiet @ AbortProtect @ CheckAbort[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`expr, True]];
	SetAttributes[Tools`ToNumber`checkMsg, HoldAll];
	Tools`ToNumber`checkMsg[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`expr_, Tools`ToNumber`msg_] := CheckAbort[
		Quiet[
			AbortProtect[Tools`ToNumber`c = Check[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`expr;, True, Tools`ToNumber`msg];];
		];
		TrueQ[Tools`ToNumber`c],
		TrueQ[Tools`ToNumber`c]
	];
	Tools`ToNumber`p = {
		Tools`ToNumber`delta -> 0.998, Tools`ToNumber`Esx -> 0.0078, Tools`ToNumber`gamma -> 10, Tools`ToNumber`muc -> 0.0015, Tools`ToNumber`phisxs -> 2.3*10^-6, Tools`ToNumber`phix -> 0.044,
		Tools`ToNumber`psi -> 1.5, Tools`ToNumber`rhox -> 0.979, Tools`ToNumber`theta -> ((1 - Tools`ToNumber`gamma) / (1 - 1 / Tools`ToNumber`psi)),
		Tools`ToNumber`vx -> 0.987, Tools`ToNumber`mud[1] -> 0.0015,
		Tools`ToNumber`phidxd[1] -> 4.5,
		Tools`ToNumber`rhodx[1] -> 3
	};
	Tools`ToNumber`newP = {
		Tools`ToNumber`delta -> 0.998, Tools`ToNumber`Esx -> 0.0078, Tools`ToNumber`gamma -> 10, Tools`ToNumber`muc -> 0.0015, Tools`ToNumber`phisxs -> 2.3*10^-6, Tools`ToNumber`phix -> 0.044,
		Tools`ToNumber`psi -> 1.5, Tools`ToNumber`rhox -> 0.979, Tools`ToNumber`theta -> ((1 - Tools`ToNumber`gamma) / (1 - 1 / Tools`ToNumber`psi)),
		Tools`ToNumber`vx -> 0.987, Tools`ToNumber`mud[1] -> 0.0015,
		Tools`ToNumber`phidxd[1] -> 4.5,
		Tools`ToNumber`rhodx[1] -> 3
	};
	Tools`ToNumber`pn = KeyValueMap[Function[# -> (#2 /. Tools`ToNumber`p)], Association @ Tools`ToNumber`p];
	Tools`ToNumber`newPn = KeyValueMap[Function[# -> (#2 /. Tools`ToNumber`newP)], Association @ Tools`ToNumber`newP];
	Tools`ToNumber`procP = FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p];
	Tools`ToNumber`procPn = FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newPn, Tools`ToNumber`pn];
	Tools`ToNumber`procPn1 = FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`pn];
	Tools`ToNumber`procPn2 = FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newPn, Tools`ToNumber`p];
	Tools`ToNumber`msg = Block[{$MessagePrePrint = Sow, $MessageList = {}},
		Reap[
			Module[{}, FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p];];
			$MessageList
		]
	];
	Apply[And,
		{
			SameQ[Sort @ Tools`ToNumber`procP, Sort @ Tools`ToNumber`procPn, Sort @ Tools`ToNumber`procPn1, Sort @ Tools`ToNumber`procPn2],
			Apply[And, Map[NumberQ, Values @ Tools`ToNumber`procP]],
			SameQ[Sort @ Keys @ Tools`ToNumber`procP, Sort @ Keys @ Tools`ToNumber`newP],
			SubsetQ[Keys @ Tools`ToNumber`p, Keys @ Tools`ToNumber`procP],
			Equal[ReleaseHold @ Tools`ToNumber`msg, {{}, {}}],
			!Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20231008-OBOMYE"
]
VerificationTest[
	Tools`ToNumber`p = {
		Tools`ToNumber`delta -> 0.998, Tools`ToNumber`Esx -> 0.0078, Tools`ToNumber`gamma -> 10, Tools`ToNumber`muc -> 0.0015, Tools`ToNumber`phisxs -> 2.3*10^-6, Tools`ToNumber`phix -> 0.044,
		Tools`ToNumber`psi -> 1.5, Tools`ToNumber`rhox -> 0.979, Tools`ToNumber`theta -> ((1 - Tools`ToNumber`gamma) / (1 - 1 / Tools`ToNumber`psi)),
		Tools`ToNumber`vx -> 0.987, Tools`ToNumber`mud[1] -> 0.0015,
		Tools`ToNumber`phidxd[1] -> 4.5,
		Tools`ToNumber`rhodx[1] -> 3
	};
	Tools`ToNumber`newP = {Tools`ToNumber`delta -> 0.9, Tools`ToNumber`Esx -> 1};
	Tools`ToNumber`pn = KeyValueMap[Function[# -> (#2 /. Tools`ToNumber`p)], Association @ Tools`ToNumber`p];
	Tools`ToNumber`newPn = KeyValueMap[Function[# -> (#2 /. Tools`ToNumber`newP)], Association @ Tools`ToNumber`newP];
	Tools`ToNumber`procP = FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p];
	Tools`ToNumber`procPn = FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newPn, Tools`ToNumber`pn];
	Tools`ToNumber`procPn1 = FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`pn];
	Tools`ToNumber`procPn2 = FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newPn, Tools`ToNumber`p];
	Tools`ToNumber`msg = Block[{$MessagePrePrint = Sow, $MessageList = {}},
		Reap[
			Module[{}, FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p];];
			$MessageList
		]
	];
	Apply[And,
		{
			SameQ[Sort @ Tools`ToNumber`procP, Sort @ Tools`ToNumber`procPn, Sort @ Tools`ToNumber`procPn1, Sort @ Tools`ToNumber`procPn2],
			Apply[And, Map[NumberQ, Values @ Tools`ToNumber`procP]],
			SameQ[Sort @ Keys @ Tools`ToNumber`procP, Sort @ Keys @ Tools`ToNumber`newP],
			SubsetQ[Keys @ Tools`ToNumber`p, Keys @ Tools`ToNumber`procP],
			Equal[ReleaseHold @ Tools`ToNumber`msg, {{}, {}}],
			!Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20231008-18HDPG"
]
VerificationTest[
	Tools`ToNumber`p = {
		Tools`ToNumber`delta -> 0.998, Tools`ToNumber`Esx -> 0.0078, Tools`ToNumber`gamma -> 10, Tools`ToNumber`muc -> 0.0015, Tools`ToNumber`phisxs -> 2.3*10^-6, Tools`ToNumber`phix -> 0.044,
		Tools`ToNumber`psi -> 1.5, Tools`ToNumber`rhox -> 0.979, Tools`ToNumber`theta -> ((1 - Tools`ToNumber`gamma) / (1 - 1 / Tools`ToNumber`psi)),
		Tools`ToNumber`vx -> 0.987, Tools`ToNumber`mud[1] -> 0.0015,
		Tools`ToNumber`phidxd[1] -> 4.5,
		Tools`ToNumber`rhodx[1] -> 3
	};
	Tools`ToNumber`newP = {};
	Tools`ToNumber`pn = KeyValueMap[Function[# -> (#2 /. Tools`ToNumber`p)], Association @ Tools`ToNumber`p];
	Tools`ToNumber`newPn = KeyValueMap[Function[# -> (#2 /. Tools`ToNumber`newP)], Association @ Tools`ToNumber`newP];
	Tools`ToNumber`procP = FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p];
	Tools`ToNumber`procPn = FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newPn, Tools`ToNumber`pn];
	Tools`ToNumber`procPn1 = FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`pn];
	Tools`ToNumber`procPn2 = FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newPn, Tools`ToNumber`p];
	Tools`ToNumber`msg = Block[{$MessagePrePrint = Sow, $MessageList = {}},
		Reap[
			Module[{}, FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p];];
			$MessageList
		]
	];
	Apply[And,
		{
			SameQ[Sort @ Tools`ToNumber`procP, Sort @ Tools`ToNumber`procPn, Sort @ Tools`ToNumber`procPn1, Sort @ Tools`ToNumber`procPn2],
			Apply[And, Map[NumberQ, Values @ Tools`ToNumber`procP]],
			SameQ[Sort @ Keys @ Tools`ToNumber`procP, Sort @ Keys @ Tools`ToNumber`newP],
			SubsetQ[Keys @ Tools`ToNumber`p, Keys @ Tools`ToNumber`procP],
			Equal[ReleaseHold @ Tools`ToNumber`msg, {{}, {}}],
			!Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20231008-FIWR29"
]
VerificationTest[
	Tools`ToNumber`p = {
		Tools`ToNumber`delta -> 0.998, Tools`ToNumber`Esx -> 0.0078, Tools`ToNumber`gamma -> 10, Tools`ToNumber`muc -> 0.0015, Tools`ToNumber`phisxs -> 2.3*10^-6, Tools`ToNumber`phix -> 0.044,
		Tools`ToNumber`psi -> 1.5, Tools`ToNumber`rhox -> 0.979, Tools`ToNumber`theta -> ((1 - Tools`ToNumber`gamma) / (1 - 1 / Tools`ToNumber`psi)),
		Tools`ToNumber`vx -> 0.987, Tools`ToNumber`mud[1] -> 0.0015,
		Tools`ToNumber`phidxd[1] -> 4.5,
		Tools`ToNumber`rhodx[1] -> 3
	};
	Tools`ToNumber`newP = {Tools`ToNumber`delta -> 0.9, Tools`ToNumber`Esx -> 1, Tools`ToNumber`phip -> 3};
	Apply[And,
		{
			Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p],
			Tools`ToNumber`checkMsg[FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p],
				FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::subsetparam
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20231008-XRAJMG"
]
VerificationTest[
	Tools`ToNumber`p = {
		Tools`ToNumber`delta -> 0.998, Tools`ToNumber`Esx -> 0.0078, Tools`ToNumber`gamma -> 10, Tools`ToNumber`muc -> 0.0015, Tools`ToNumber`phisxs -> 2.3*10^-6, Tools`ToNumber`phix -> 0.044,
		Tools`ToNumber`psi -> 1.5, Tools`ToNumber`rhox -> 0.979, Tools`ToNumber`theta -> ((1 - Tools`ToNumber`gamma) / (1 - 1 / Tools`ToNumber`psi)),
		Tools`ToNumber`vx -> 0.987, Tools`ToNumber`mud[1] -> 0.0015,
		Tools`ToNumber`phidxd[1] -> 4.5,
		Tools`ToNumber`rhodx[1] -> 3
	};
	Tools`ToNumber`newP = {Tools`ToNumber`delta -> 0.9, Tools`ToNumber`Esx -> 1, Tools`ToNumber`psi -> 1};
	Apply[And,
		{
			Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p],
			Tools`ToNumber`checkMsg[FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p], FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::psi]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20231008-THA7ZT"
]
VerificationTest[
	Tools`ToNumber`p = {
		Tools`ToNumber`delta -> 0.998, Tools`ToNumber`Esx -> 0.0078, Tools`ToNumber`gamma -> 10, Tools`ToNumber`muc -> 0.0015, Tools`ToNumber`phisxs -> 2.3*10^-6, Tools`ToNumber`phix -> 0.044,
		Tools`ToNumber`psi -> 1.5, Tools`ToNumber`rhox -> 0.979, Tools`ToNumber`theta -> ((1 - Tools`ToNumber`gamma) / (1 - 1 / Tools`ToNumber`psi)),
		Tools`ToNumber`vx -> 0.987, Tools`ToNumber`mud[1] -> 0.0015,
		Tools`ToNumber`phidxd[1] -> 4.5,
		Tools`ToNumber`rhodx[1] -> 3
	};
	Tools`ToNumber`newP = {Tools`ToNumber`delta -> 0.9, Tools`ToNumber`Esx -> 1, Tools`ToNumber`psi -> 1.};
	Apply[And,
		{
			Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p],
			Tools`ToNumber`checkMsg[FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p], FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::psi]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20231008-01NY69"
]
VerificationTest[
	Tools`ToNumber`p = {
		Tools`ToNumber`delta -> 0.998, Tools`ToNumber`Esx -> 0.0078, Tools`ToNumber`gamma -> 10, Tools`ToNumber`muc -> 0.0015, Tools`ToNumber`phisxs -> 2.3*10^-6, Tools`ToNumber`phix -> 0.044,
		Tools`ToNumber`psi -> 1.5, Tools`ToNumber`rhox -> 0.979, Tools`ToNumber`theta -> ((1 - Tools`ToNumber`gamma) / (1 - 1 / Tools`ToNumber`psi)),
		Tools`ToNumber`vx -> 0.987, Tools`ToNumber`mud[1] -> 0.0015,
		Tools`ToNumber`phidxd[1] -> 4.5,
		Tools`ToNumber`rhodx[1] -> 3
	};
	Tools`ToNumber`newP = {
		Tools`ToNumber`gamma -> 10,
		Tools`ToNumber`theta -> ((1 - Tools`ToNumber`gamma) / (1 - 1 / Tools`ToNumber`psi)),
		Tools`ToNumber`psi -> 1.5
	};
	Tools`ToNumber`procP = FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p];
	Tools`ToNumber`msg = Block[{$MessagePrePrint = Sow, $MessageList = {}},
		Reap[
			Module[{}, FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p];];
			$MessageList
		]
	];
	Apply[And,
		{
			Apply[And, Map[NumberQ, Values @ Tools`ToNumber`procP]],
			SameQ[Sort @ Keys @ Tools`ToNumber`procP, Sort @ Keys @ Tools`ToNumber`newP],
			SubsetQ[Keys @ Tools`ToNumber`p, Keys @ Tools`ToNumber`procP],
			Equal[ReleaseHold @ Tools`ToNumber`msg, {{}, {}}],
			!Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20231008-50GV3K"
]
VerificationTest[
	Tools`ToNumber`p = {
		Tools`ToNumber`delta -> 0.998, Tools`ToNumber`Esx -> 0.0078, Tools`ToNumber`gamma -> 10, Tools`ToNumber`muc -> 0.0015, Tools`ToNumber`phisxs -> 2.3*10^-6, Tools`ToNumber`phix -> 0.044,
		Tools`ToNumber`psi -> 1.5, Tools`ToNumber`rhox -> 0.979, Tools`ToNumber`theta -> ((1 - Tools`ToNumber`gamma) / (1 - 1 / Tools`ToNumber`psi)),
		Tools`ToNumber`vx -> 0.987, Tools`ToNumber`mud[1] -> 0.0015,
		Tools`ToNumber`phidxd[1] -> 4.5,
		Tools`ToNumber`rhodx[1] -> 3
	};
	Tools`ToNumber`newP = {Tools`ToNumber`gamma -> 10, Tools`ToNumber`theta -> 3.23, Tools`ToNumber`psi -> 1.5};
	Tools`ToNumber`procP = Quiet[FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p], FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::param];
	Apply[And,
		{
			Apply[And, Map[NumberQ, Values @ Tools`ToNumber`procP]],
			SameQ[Sort @ Keys @ Tools`ToNumber`procP, Sort @ Keys @ Tools`ToNumber`newP],
			SubsetQ[Keys @ Tools`ToNumber`p, Keys @ Tools`ToNumber`procP],
			!Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p],
			Tools`ToNumber`checkMsg[FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p], FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::param],
			Less[Chop[RealAbs[(Tools`ToNumber`theta /. Tools`ToNumber`procP) - -27.]], $MachineEpsilon]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20231008-TQ1R03"
]
VerificationTest[
	Tools`ToNumber`p = {
		Tools`ToNumber`delta -> 0.998, Tools`ToNumber`Esx -> 0.0078, Tools`ToNumber`gamma -> 10, Tools`ToNumber`muc -> 0.0015, Tools`ToNumber`phisxs -> 2.3*10^-6, Tools`ToNumber`phix -> 0.044,
		Tools`ToNumber`psi -> 1.5, Tools`ToNumber`rhox -> 0.979, Tools`ToNumber`theta -> ((1 - Tools`ToNumber`gamma) / (1 - 1 / Tools`ToNumber`psi)),
		Tools`ToNumber`vx -> 0.987, Tools`ToNumber`mud[1] -> 0.0015,
		Tools`ToNumber`phidxd[1] -> 4.5,
		Tools`ToNumber`rhodx[1] -> 3
	};
	Tools`ToNumber`newP = {Tools`ToNumber`psi -> 2, Tools`ToNumber`theta -> -3.};
	Tools`ToNumber`procP = FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p];
	Tools`ToNumber`msg = Block[{$MessagePrePrint = Sow, $MessageList = {}},
		Reap[
			Module[{}, FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p];];
			$MessageList
		]
	];
	Apply[And,
		{
			Apply[And, Map[NumberQ, Values @ Tools`ToNumber`procP]],
			SameQ[Sort @ Keys @ Tools`ToNumber`procP, Sort @ Join[{Tools`ToNumber`gamma}, Keys @ Tools`ToNumber`newP]],
			SubsetQ[Keys @ Tools`ToNumber`p, Keys @ Tools`ToNumber`procP],
			!Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p],
			Equal[ReleaseHold @ Tools`ToNumber`msg, {{}, {}}],
			Less[Chop[RealAbs[(Tools`ToNumber`gamma /. Tools`ToNumber`procP) - 2.5]], $MachineEpsilon]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20231008-597Z62"
]
VerificationTest[
	Tools`ToNumber`p = {
		Tools`ToNumber`delta -> 0.998, Tools`ToNumber`Esx -> 0.0078, Tools`ToNumber`gamma -> 10, Tools`ToNumber`muc -> 0.0015, Tools`ToNumber`phisxs -> 2.3*10^-6, Tools`ToNumber`phix -> 0.044,
		Tools`ToNumber`psi -> 1.5, Tools`ToNumber`rhox -> 0.979, Tools`ToNumber`theta -> ((1 - Tools`ToNumber`gamma) / (1 - 1 / Tools`ToNumber`psi)),
		Tools`ToNumber`vx -> 0.987, Tools`ToNumber`mud[1] -> 0.0015,
		Tools`ToNumber`phidxd[1] -> 4.5,
		Tools`ToNumber`rhodx[1] -> 3
	};
	Tools`ToNumber`newP = {Tools`ToNumber`psi -> 2, Tools`ToNumber`gamma -> 2.5};
	Tools`ToNumber`procP = FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p];
	Tools`ToNumber`msg = Block[{$MessagePrePrint = Sow, $MessageList = {}},
		Reap[
			Module[{}, FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p];];
			$MessageList
		]
	];
	Apply[And,
		{
			Apply[And, Map[NumberQ, Values @ Tools`ToNumber`procP]],
			SameQ[Sort @ Keys @ Tools`ToNumber`procP, Sort @ Join[{Tools`ToNumber`theta}, Keys @ Tools`ToNumber`newP]],
			SubsetQ[Keys @ Tools`ToNumber`p, Keys @ Tools`ToNumber`procP],
			!Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p],
			Equal[ReleaseHold @ Tools`ToNumber`msg, {{}, {}}],
			Less[RealAbs[(Tools`ToNumber`theta /. Tools`ToNumber`procP) - -3], $MachineEpsilon]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20231008-96K47K"
]
VerificationTest[
	Tools`ToNumber`p = {
		Tools`ToNumber`delta -> 0.998, Tools`ToNumber`Esx -> 0.0078, Tools`ToNumber`gamma -> 10, Tools`ToNumber`muc -> 0.0015, Tools`ToNumber`phisxs -> 2.3*10^-6, Tools`ToNumber`phix -> 0.044,
		Tools`ToNumber`psi -> 1.5, Tools`ToNumber`rhox -> 0.979, Tools`ToNumber`theta -> ((1 - Tools`ToNumber`gamma) / (1 - 1 / Tools`ToNumber`psi)),
		Tools`ToNumber`vx -> 0.987, Tools`ToNumber`mud[1] -> 0.0015,
		Tools`ToNumber`phidxd[1] -> 4.5,
		Tools`ToNumber`rhodx[1] -> 3
	};
	Tools`ToNumber`newP = {Tools`ToNumber`gamma -> 2.5, Tools`ToNumber`theta -> -3.};
	Tools`ToNumber`procP = FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p];
	Tools`ToNumber`msg = Block[{$MessagePrePrint = Sow, $MessageList = {}},
		Reap[
			Module[{}, FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p];];
			$MessageList
		]
	];
	Apply[And,
		{
			Apply[And, Map[NumberQ, Values @ Tools`ToNumber`procP]],
			SameQ[Sort @ Keys @ Tools`ToNumber`procP, Sort @ Join[{Tools`ToNumber`psi}, Keys @ Tools`ToNumber`newP]],
			SubsetQ[Keys @ Tools`ToNumber`p, Keys @ Tools`ToNumber`procP],
			!Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p],
			Equal[ReleaseHold @ Tools`ToNumber`msg, {{}, {}}],
			Less[RealAbs[(Tools`ToNumber`psi /. Tools`ToNumber`procP) - 2], $MachineEpsilon]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20231008-IPRKEH"
]
VerificationTest[
	Tools`ToNumber`p = {
		Tools`ToNumber`delta -> 0.998, Tools`ToNumber`Esx -> 0.0078, Tools`ToNumber`gamma -> 10, Tools`ToNumber`muc -> 0.0015, Tools`ToNumber`phisxs -> 2.3*10^-6, Tools`ToNumber`phix -> 0.044,
		Tools`ToNumber`psi -> 1.5, Tools`ToNumber`rhox -> 0.979, Tools`ToNumber`theta -> ((1 - Tools`ToNumber`gamma) / (1 - 1 / Tools`ToNumber`psi)),
		Tools`ToNumber`vx -> 0.987, Tools`ToNumber`mud[1] -> 0.0015,
		Tools`ToNumber`phidxd[1] -> 4.5,
		Tools`ToNumber`rhodx[1] -> 3
	};
	Tools`ToNumber`newP = {Tools`ToNumber`delta -> 0.9, Tools`ToNumber`Esx -> 1, Tools`ToNumber`theta -> 1.};
	Apply[And,
		{
			Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p],
			Tools`ToNumber`checkMsg[FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p], FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::theta]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20231008-T7S6Y6"
]
VerificationTest[
	Tools`ToNumber`p = {
		context1`delta -> 0.998, context1`Esx -> 0.0078, foo`gamma -> 10, Tools`ToNumber`muc -> 0.0015, Tools`ToNumber`phisxs -> 2.3*10^-6, Tools`ToNumber`phix -> 0.044,
		Tools`ToNumber`psi -> 1.5, Tools`ToNumber`rhox -> 0.979, Tools`ToNumber`theta -> ((1 - Tools`ToNumber`gamma) / (1 - 1 / Tools`ToNumber`psi)),
		Tools`ToNumber`vx -> 0.987, Tools`ToNumber`mud[1] -> 0.0015,
		Tools`ToNumber`phidxd[1] -> 4.5,
		Tools`ToNumber`rhodx[1] -> 3
	};
	Tools`ToNumber`newP = {context2`delta -> 0.9, Tools`ToNumber`Esx -> 1, bar`gamma -> 2};
	Tools`ToNumber`procP = FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters[Tools`ToNumber`newP, Tools`ToNumber`p];
	Apply[And,
		{
			SameQ[KeyTake[Tools`ToNumber`p, Keys @ Tools`ToNumber`newP], <||>],
			SameQ[Map[Context, Keys @ Tools`ToNumber`procP],
				Map[Context, Keys @ KeyTake[Tools`ToNumber`p, Keys @ Tools`ToNumber`procP]]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20231008-8P0GF2"
] 
End[]
EndTestSection[]
