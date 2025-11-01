BeginTestSection["ToNumber"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`"]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`longTest = False;
	True
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20251030-U1SUOF@@Tests/ToNumber.wlt:3,1-12,2"
]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`Tools`ToNumber`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`"];
	True
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20251030-OX8QHZ@@Tests/ToNumber.wlt:13,1-23,2"
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
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msp = FernandoDuarte`LongRunRisk`Models;
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`modBY = FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msp @ "BY";
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`modBKY = FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msp @ "BKY";
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`modNRC = FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msp @ "NRC";
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`modDES = FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msp @ "DES";
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`modNRCStochVol = FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msp @ "NRCStochVol";
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mods = If[
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`longTest,
		{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`modBY, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`modBKY, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`modNRC, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`modDES, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`modNRCStochVol},
		{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`modBKY}
	];
	FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`expr[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t_, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`m_, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`i_, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mu_] := {
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`wc @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`pd[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`i],
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`bond[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`m],
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`nombond[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`m],
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`bondexcret[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`m],
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`bondfw[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`m],
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`bondfwspread[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`m],
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`bondret[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`m],
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`bondyield[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`m],
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`excretc @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`excret[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`i],
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`kappa0 @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mu, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`kappa1 @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mu, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`nombondexcret[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`m],
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`nombondfw[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`m],
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`nombondfwspread[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`m],
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`nombondret[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`m],
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`nombondyield[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`m],
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`nomrf @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`nomsdf @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`retc @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`ret[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`i],
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rf @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`sdf @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`pi @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`dc @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`growth[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`dc, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, "TimeAggregation" -> 2, "numPeriods" -> 1],
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`growth[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`dd, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, 1, "TimeAggregation" -> 2],
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`AA * FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`dc[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t + 1] * FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`excret[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, 1],
		(FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`AA * FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`excret[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, 1]) + FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`BB * FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`nombondyield[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, 2]
	};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`ee = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`expr[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, 3, 1, 1];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1 = FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`ee[[1;;3]];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2 = FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`ee[[1;;2]];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`optsList = {
		{},
		{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`maxMaturity -> 6},
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
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`maxMaturity -> 6,
			"initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>,
			MaxIterations -> 100
		},
		{"PrintResidualsNorm" -> True},
		{"CheckResiduals" -> True, "Tol" -> 1},
		{"CheckResiduals" -> True, "Tol" -> (10. ^ -20)},
		{
			"PrintResidualsNorm" -> True, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`maxMaturity -> 6, "initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>,
			MaxIterations -> 100
		},
		{"RecurrenceTableOptions" -> {"DependentVariables" -> Automatic}},
		{DependentVariables -> Automatic}
	};
	FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`opts = If[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`longTest, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`optsList[[1;;5]], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`optsList[[1;;2]]];
	FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters = {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`delta -> 0.99};
	FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution = {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`A[0] -> 4.6};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`optNewParam = {
		"initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>,
		MaxIterations -> 100
	};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`exprNewParam = FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondE @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`wc @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t;
	AbortProtect[
		Do[
			FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind = 0;
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`stateVars = Map[
				Slot[1][_]&,
				DeleteDuplicates[
					DeleteCases[
						Cases[Variables @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel["stateVars"][FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t], Pattern[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`x, _][_] :> FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`x],
						0
					]
				]
			];
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel = Join[
				Thread[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`stateVars -> 1.],
				{
					FernandoDuarte`LongRunRisk`Model`Shocks`eps[_][_] -> 1,
					FernandoDuarte`LongRunRisk`Model`Shocks`eps[_][_, _] -> 1.,
					FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mu -> 2., FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`AA -> -1., FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`BB -> 3.
				}
			];
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`toNum = FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum;
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`toEquation = FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation;
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`toExogenousVars = FernandoDuarte`LongRunRisk`Tools`ToNumber`toExogenousVars;
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`toStateVars = FernandoDuarte`LongRunRisk`Tools`ToNumber`toStateVars;
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`processNewParameters = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters;
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondE = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondE;
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondVar = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondVar;
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondCov = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondCov;
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondCorr = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondCorr;
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`ev = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`ev;
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`var = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`var;
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`cov = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`cov;
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`corr = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`corr;
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn = FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel;
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`outTests[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel["shortname"]][FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind] = Apply[
				And,
				Flatten[
					{
						SameQ[Head @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn, Function],
						Map[NumericQ,
							Flatten[
								If[
									FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`longTest,
									{
										FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
										FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondE, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1]] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
										FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondVar, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1]] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
										FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[MapThread[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondCov[#, #2]&, {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1, Reverse[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1]}]] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[
												MapThread[
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondCorr[#, #2]&,
													{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1[[1;;2]], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1[[-2;;-1]]}
												]
											],
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`ev[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1]],
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`var[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1]],
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[
												MapThread[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`cov[#, #2, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1, Reverse @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1}]
											],
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[
												MapThread[
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`corr[#, #2, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&,
													{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1[[1;;2]], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1[[-2;;-1]]}
												]
											],
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
										]
									},
									{
										FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
										FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondE, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1]] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
										FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondVar, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1]] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`ev[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1]],
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`var[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1]],
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
										]
									}
								]
							]
						]
					}
				]
			];
			FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`outTests[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel["shortname"]][FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind] = Apply[
				And,
				Flatten[
					{
						SameQ[Head @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn, Function],
						Map[NumericQ,
							Flatten[
								If[
									FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`longTest,
									{
										FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
										FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondE, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
										FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondVar, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[MapThread[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondCov[#, #2]&, {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1, Reverse @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1}], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel],
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
												MapThread[
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondCorr[#, #2]&,
													{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1[[1;;2]], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1[[-2;;-1]]}
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
											],
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
												Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`ev[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
											],
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
												Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`var[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
											],
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
												MapThread[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`cov[#, #2, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1, Reverse @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1}],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
											],
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
												MapThread[
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`corr[#, #2, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&,
													{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1[[1;;2]], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1[[-2;;-1]]}
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
											],
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
										]
									},
									{
										FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
										FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondE, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
										FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondVar, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
												Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`ev[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
											],
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
										],
										ReplaceRepeated[
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
												Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`var[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
											],
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
										]
									}
								]
							]
						]
					}
				]
			];
			FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`outTests[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel["shortname"]][FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind] = Apply[
				And,
				Flatten[
					{
						SameQ[Head @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn, Function],
						Map[NumericQ,
							ReplaceRepeated[
								Flatten[
									If[
										FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`longTest,
										{
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondE, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondVar, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[MapThread[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondCov[#, #2]&, {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1, Reverse @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1}], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
													MapThread[
														FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondCorr[#, #2]&,
														{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1[[1;;2]], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1[[-2;;-1]]}
													],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
													Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`ev[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
													Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`var[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
													MapThread[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`cov[#, #2, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1, Reverse @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1}],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
													MapThread[
														FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`corr[#, #2, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&,
														{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1[[1;;2]], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1[[-2;;-1]]}
													],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											]
										},
										{
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondE, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondVar, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
													Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`ev[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
													Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`var[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e1],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											]
										}
									]
								],
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum["Rules", FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel]
							]
						]
					}
				]
			];
			FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind + 1;
			Do[
				FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn = FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`opt];
				FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`outTests[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel["shortname"]][FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind] = Apply[
					And,
					Flatten[
						{
							SameQ[Head @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn, Function],
							Map[
								NumericQ,
								Flatten[
									If[
										FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`longTest,
										{
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondE, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2]] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondVar, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2]] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[MapThread[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondCov[#, #2]&, {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2, Reverse[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2]}]] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[
													MapThread[
														FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondCorr[#, #2]&,
														{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2[[1;;2]], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2[[-2;;-1]]}
													]
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`ev[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2]],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`var[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2]],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[
													MapThread[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`cov[#, #2, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2, Reverse @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2}]
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[
													MapThread[
														FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`corr[#, #2, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&,
														{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2[[1;;2]], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2[[-2;;-1]]}
													]
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											]
										},
										{
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondE, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2]] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondVar, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2]] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`ev[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2]],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`var[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2]],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											]
										}
									]
								]
							]
						}
					]
				];
				FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind + 1;
				FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`outTests[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel["shortname"]][FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind] = Apply[
					And,
					Flatten[
						{
							SameQ[Head @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn, Function],
							Map[
								NumericQ,
								Flatten[
									If[
										FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`longTest,
										{
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, Apply[Sequence, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`opt]] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondE, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`opt] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondVar, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`opt] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
													MapThread[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondCov[#, #2]&, {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2, Reverse @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2}],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`opt
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
													MapThread[
														FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondCorr[#, #2]&,
														{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2[[1;;2]], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2[[-2;;-1]]}
													],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`opt
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
													Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`ev[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`opt
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
													Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`var[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`opt
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
													MapThread[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`cov[#, #2, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2, Reverse @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2}],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`opt
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
													MapThread[
														FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`corr[#, #2, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&,
														{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2[[1;;2]], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2[[-2;;-1]]}
													],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`opt
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											]
										},
										{
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, Apply[Sequence, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`opt]] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondE, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`opt] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
											FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondVar, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`opt] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
													Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`ev[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`opt
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											],
											ReplaceRepeated[
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
													Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`var[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`opt
												],
												FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
											]
										}
									]
								]
							]
						}
					]
				];
				FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind + 1;
				FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`outTests[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel["shortname"]][FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind] = Apply[
					And,
					Flatten[
						{
							SameQ[Head @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`tn, Function],
							Map[
								NumericQ,
								ReplaceRepeated[
									Flatten[
										If[
											FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`longTest,
											{
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondE, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondVar, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
												ReplaceRepeated[
													FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[MapThread[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondCov[#, #2]&, {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2, Reverse @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2}], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
												],
												ReplaceRepeated[
													FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
														MapThread[
															FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondCorr[#, #2]&,
															{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2[[1;;2]], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2[[-2;;-1]]}
														],
														FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
													],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
												],
												ReplaceRepeated[
													FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
														Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`ev[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2],
														FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
													],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
												],
												ReplaceRepeated[
													FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
														Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`var[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2],
														FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
													],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
												],
												ReplaceRepeated[
													FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
														MapThread[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`cov[#, #2, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2, Reverse @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2}],
														FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
													],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
												],
												ReplaceRepeated[
													FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
														MapThread[
															FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`corr[#, #2, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&,
															{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2[[1;;2]], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2[[-2;;-1]]}
														],
														FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
													],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
												]
											},
											{
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondE, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
												FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`uncondVar, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
												ReplaceRepeated[
													FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
														Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`ev[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2],
														FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
													],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
												],
												ReplaceRepeated[
													FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[
														Map[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`var[#, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t - 1]&, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`e2],
														FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel
													],
													FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
												]
											}
										]
									],
									FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum["Rules", FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`opt]
								]
							]
						}
					]
				];
				FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind + 1;
			,
				{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`opt, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`opts}
			];
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`outTests[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel["shortname"]][FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind] = Apply[
				And,
				Map[NumericQ,
					Flatten[
						{
							ReplaceRepeated[FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, "UpdatePd" -> False], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel][FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`pd[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, 1]],
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`pd[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, 1], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, "UpdatePd" -> False] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
							ReplaceRepeated[
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`pd[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, 1], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum["Rules", FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, "UpdatePd" -> False],
								FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
							],
							ReplaceRepeated[FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, "UpdateBonds" -> False], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel][{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`bondyield[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, 2], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`nombondyield[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, 3]}],
							ReplaceRepeated[
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
									{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`bondyield[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, 2], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`nombondyield[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, 3]},
									FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, "UpdateBonds" -> False
								],
								FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
							],
							ReplaceRepeated[
								ReplaceRepeated[
									FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`bondyield[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, 2], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`nombondyield[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`t, 3]}, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel],
									FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum["Rules", FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, "UpdateBonds" -> False]
								],
								FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
							]
						}
					]
				]
			];
			FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`outTests[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel["shortname"]][FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind] = Apply[
				And,
				Map[NumericQ,
					{
						ReplaceRepeated[FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel][FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`exprNewParam],
						FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum["Rules", FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters],
							FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
						],
						ReplaceRepeated[FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, {}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel][FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`exprNewParam],
						FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, {}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution] //. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel,
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel] //. FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum["Rules", FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, {}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution],
							FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
						],
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution],
							FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
						][FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`exprNewParam],
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution],
							FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
						],
						ReplaceRepeated[
							ReplaceRepeated[
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel],
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum["Rules", FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution]
							],
							FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
						],
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`optNewParam],
							FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
						][FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`exprNewParam],
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`optNewParam],
							FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
						],
						ReplaceRepeated[
							ReplaceRepeated[
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel],
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum["Rules", FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`optNewParam]
							],
							FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
						],
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, {}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`optNewParam],
							FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
						][FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`exprNewParam],
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
								FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, {}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`optNewParam
							],
							FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
						],
						ReplaceRepeated[
							ReplaceRepeated[
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel],
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum["Rules", FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, {}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`optNewParam]
							],
							FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
						],
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
								FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`optNewParam
							],
							FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
						][FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`exprNewParam],
						ReplaceRepeated[
							FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
								FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`optNewParam
							],
							FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
						],
						ReplaceRepeated[
							ReplaceRepeated[
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toEquation[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`exprNewParam, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel],
								FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum[
									"Rules", FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`newParameters, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`guessCoeffsSolution, Sequence @@ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`optNewParam
								]
							],
							FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`numModel
						]
					}
				]
			];
			FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`ind + 1;
		,
			{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mods}
		];
	];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`noMissingTest = {};
	Do[
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`testNumber = Sort[
			Cases[Keys @ SubValues @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`outTests,
				RuleDelayed[
					Verbatim[HoldPattern][FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`outTests[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel["shortname"]][FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`i_Integer]],
					FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`i
				]
			]
		];
		AppendTo[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`noMissingTest, Equal[Range[0, Max @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`testNumber], FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`testNumber]];
	,
		{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`thisModel, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mods}
	];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`out = Apply[
		And,
		Flatten[
			{
				Apply[And, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`noMissingTest],
				Apply[And, Values @ SubValues @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`outTests]
			}
		]
	];
	On[General::stop];
	Off[FindRoot::lstol];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`out
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20251030-OP2N6I@@Tests/ToNumber.wlt:24,1-786,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`processNewParameters = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters;
	SetAttributes[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkAbrt, HoldAll];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkAbrt[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`expr_] := TrueQ[Quiet @ AbortProtect @ CheckAbort[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`expr, True]];
	SetAttributes[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkMsg, HoldAll];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkMsg[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`expr_, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msg_] := CheckAbort[
		Quiet[
			AbortProtect[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`c = Check[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`expr;, True, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msg];];
		];
		TrueQ[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`c],
		TrueQ[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`c]
	];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p = {
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`delta -> 0.998, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`Esx -> 0.0078, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma -> 10, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`muc -> 0.0015, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phisxs -> 2.3*10^-6, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phix -> 0.044,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 1.5, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhox -> 0.979, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta -> ((1 - FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma) / (1 - 1 / FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi)),
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`vx -> 0.987, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mud[1] -> 0.0015,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phidxd[1] -> 4.5,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhodx[1] -> 3
	};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP = {
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`delta -> 0.998, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`Esx -> 0.0078, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma -> 10, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`muc -> 0.0015, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phisxs -> 2.3*10^-6, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phix -> 0.044,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 1.5, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhox -> 0.979, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta -> ((1 - FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma) / (1 - 1 / FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi)),
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`vx -> 0.987, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mud[1] -> 0.0015,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phidxd[1] -> 4.5,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhodx[1] -> 3
	};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`pn = KeyValueMap[Function[# -> (#2 /. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p)], Association @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newPn = KeyValueMap[Function[# -> (#2 /. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP)], Association @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procPn = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newPn, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`pn];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procPn1 = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`pn];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procPn2 = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newPn, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msg = Block[{$MessagePrePrint = Sow, $MessageList = {}},
		Reap[
			Module[{}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];];
			$MessageList
		]
	];
	Apply[And,
		Simplify[
			{
				SameQ[Sort @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP, Sort @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procPn, Sort @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procPn1, Sort @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procPn2],
				Apply[And, Map[NumberQ, Values @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP]],
				SameQ[Sort @ Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP, Sort @ Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP],
				SubsetQ[Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p, Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP],
				Equal[ReleaseHold @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msg, {{}, {}}],
				!FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20251030-UD2NZ1@@Tests/ToNumber.wlt:787,1-843,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p = {
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`delta -> 0.998, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`Esx -> 0.0078, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma -> 10, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`muc -> 0.0015, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phisxs -> 2.3*10^-6, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phix -> 0.044,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 1.5, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhox -> 0.979, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta -> ((1 - FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma) / (1 - 1 / FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi)),
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`vx -> 0.987, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mud[1] -> 0.0015,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phidxd[1] -> 4.5,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhodx[1] -> 3
	};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP = {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`delta -> 0.9, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`Esx -> 1};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`pn = KeyValueMap[Function[# -> (#2 /. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p)], Association @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newPn = KeyValueMap[Function[# -> (#2 /. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP)], Association @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procPn = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newPn, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`pn];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procPn1 = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`pn];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procPn2 = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newPn, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msg = Block[{$MessagePrePrint = Sow, $MessageList = {}},
		Reap[
			Module[{}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];];
			$MessageList
		]
	];
	Apply[And,
		Simplify[
			{
				SameQ[Sort @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP, Sort @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procPn, Sort @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procPn1, Sort @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procPn2],
				Apply[And, Map[NumberQ, Values @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP]],
				SameQ[Sort @ Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP, Sort @ Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP],
				SubsetQ[Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p, Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP],
				Equal[ReleaseHold @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msg, {{}, {}}],
				!FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20251030-BDEY8N@@Tests/ToNumber.wlt:844,1-883,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p = {
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`delta -> 0.998, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`Esx -> 0.0078, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma -> 10, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`muc -> 0.0015, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phisxs -> 2.3*10^-6, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phix -> 0.044,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 1.5, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhox -> 0.979, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta -> ((1 - FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma) / (1 - 1 / FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi)),
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`vx -> 0.987, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mud[1] -> 0.0015,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phidxd[1] -> 4.5,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhodx[1] -> 3
	};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP = {};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`pn = KeyValueMap[Function[# -> (#2 /. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p)], Association @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newPn = KeyValueMap[Function[# -> (#2 /. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP)], Association @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procPn = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newPn, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`pn];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procPn1 = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`pn];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procPn2 = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newPn, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msg = Block[{$MessagePrePrint = Sow, $MessageList = {}},
		Reap[
			Module[{}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];];
			$MessageList
		]
	];
	Apply[And,
		Simplify[
			{
				SameQ[Sort @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP, Sort @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procPn, Sort @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procPn1, Sort @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procPn2],
				Apply[And, Map[NumberQ, Values @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP]],
				SameQ[Sort @ Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP, Sort @ Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP],
				SubsetQ[Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p, Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP],
				Equal[ReleaseHold @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msg, {{}, {}}],
				!FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20251030-UPYCMP@@Tests/ToNumber.wlt:884,1-923,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p = {
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`delta -> 0.998, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`Esx -> 0.0078, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma -> 10, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`muc -> 0.0015, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phisxs -> 2.3*10^-6, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phix -> 0.044,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 1.5, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhox -> 0.979, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta -> ((1 - FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma) / (1 - 1 / FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi)),
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`vx -> 0.987, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mud[1] -> 0.0015,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phidxd[1] -> 4.5,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhodx[1] -> 3
	};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP = {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`delta -> 0.9, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`Esx -> 1, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phip -> 3};
	Apply[And,
		Simplify[
			{
				FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p],
				FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkMsg[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p],
					FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters::subsetparam
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20251030-U6XDL7@@Tests/ToNumber.wlt:924,1-949,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p = {
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`delta -> 0.998, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`Esx -> 0.0078, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma -> 10, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`muc -> 0.0015, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phisxs -> 2.3*10^-6, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phix -> 0.044,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 1.5, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhox -> 0.979, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta -> ((1 - FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma) / (1 - 1 / FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi)),
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`vx -> 0.987, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mud[1] -> 0.0015,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phidxd[1] -> 4.5,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhodx[1] -> 3
	};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP = {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`delta -> 0.9, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`Esx -> 1, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 1};
	Apply[And,
		Simplify[
			{
				FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p],
				FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkMsg[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p], FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters::psi]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20251030-PHD5Y1@@Tests/ToNumber.wlt:950,1-973,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p = {
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`delta -> 0.998, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`Esx -> 0.0078, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma -> 10, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`muc -> 0.0015, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phisxs -> 2.3*10^-6, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phix -> 0.044,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 1.5, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhox -> 0.979, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta -> ((1 - FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma) / (1 - 1 / FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi)),
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`vx -> 0.987, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mud[1] -> 0.0015,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phidxd[1] -> 4.5,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhodx[1] -> 3
	};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP = {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`delta -> 0.9, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`Esx -> 1, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 1.};
	Apply[And,
		Simplify[
			{
				FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p],
				FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkMsg[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p], FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters::psi]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20251030-WFZ7YV@@Tests/ToNumber.wlt:974,1-997,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p = {
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`delta -> 0.998, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`Esx -> 0.0078, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma -> 10, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`muc -> 0.0015, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phisxs -> 2.3*10^-6, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phix -> 0.044,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 1.5, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhox -> 0.979, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta -> ((1 - FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma) / (1 - 1 / FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi)),
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`vx -> 0.987, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mud[1] -> 0.0015,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phidxd[1] -> 4.5,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhodx[1] -> 3
	};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP = {
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma -> 10,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta -> ((1 - FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma) / (1 - 1 / FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi)),
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 1.5
	};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msg = Block[{$MessagePrePrint = Sow, $MessageList = {}},
		Reap[
			Module[{}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];];
			$MessageList
		]
	];
	Apply[And,
		Simplify[
			{
				Apply[And, Map[NumberQ, Values @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP]],
				SameQ[Sort @ Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP, Sort @ Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP],
				SubsetQ[Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p, Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP],
				Equal[ReleaseHold @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msg, {{}, {}}],
				!FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20251030-56P2RS@@Tests/ToNumber.wlt:998,1-1035,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p = {
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`delta -> 0.998, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`Esx -> 0.0078, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma -> 10, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`muc -> 0.0015, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phisxs -> 2.3*10^-6, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phix -> 0.044,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 1.5, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhox -> 0.979, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta -> ((1 - FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma) / (1 - 1 / FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi)),
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`vx -> 0.987, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mud[1] -> 0.0015,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phidxd[1] -> 4.5,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhodx[1] -> 3
	};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP = {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma -> 10, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta -> 3.23, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 1.5};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP = Quiet[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p], FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters::param];
	Apply[And,
		Simplify[
			{
				Apply[And, Map[NumberQ, Values @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP]],
				SameQ[Sort @ Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP, Sort @ Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP],
				SubsetQ[Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p, Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP],
				!FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p],
				FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkMsg[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p], FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters::param],
				Less[Chop[RealAbs[(FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta /. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP) - -27.]], $MachineEpsilon]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20251030-UCW0SO@@Tests/ToNumber.wlt:1036,1-1064,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p = {
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`delta -> 0.998, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`Esx -> 0.0078, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma -> 10, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`muc -> 0.0015, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phisxs -> 2.3*10^-6, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phix -> 0.044,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 1.5, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhox -> 0.979, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta -> ((1 - FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma) / (1 - 1 / FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi)),
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`vx -> 0.987, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mud[1] -> 0.0015,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phidxd[1] -> 4.5,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhodx[1] -> 3
	};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP = {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 2, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta -> -3.};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msg = Block[{$MessagePrePrint = Sow, $MessageList = {}},
		Reap[
			Module[{}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];];
			$MessageList
		]
	];
	Apply[And,
		Simplify[
			{
				Apply[And, Map[NumberQ, Values @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP]],
				SameQ[Sort @ Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP, Sort @ Join[{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma}, Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP]],
				SubsetQ[Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p, Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP],
				!FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p],
				Equal[ReleaseHold @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msg, {{}, {}}],
				Less[Chop[RealAbs[(FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma /. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP) - 2.5]], $MachineEpsilon]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20251030-UTIQAA@@Tests/ToNumber.wlt:1065,1-1099,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p = {
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`delta -> 0.998, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`Esx -> 0.0078, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma -> 10, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`muc -> 0.0015, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phisxs -> 2.3*10^-6, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phix -> 0.044,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 1.5, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhox -> 0.979, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta -> ((1 - FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma) / (1 - 1 / FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi)),
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`vx -> 0.987, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mud[1] -> 0.0015,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phidxd[1] -> 4.5,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhodx[1] -> 3
	};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP = {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 2, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma -> 2.5};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msg = Block[{$MessagePrePrint = Sow, $MessageList = {}},
		Reap[
			Module[{}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];];
			$MessageList
		]
	];
	Apply[And,
		Simplify[
			{
				Apply[And, Map[NumberQ, Values @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP]],
				SameQ[Sort @ Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP, Sort @ Join[{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta}, Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP]],
				SubsetQ[Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p, Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP],
				!FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p],
				Equal[ReleaseHold @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msg, {{}, {}}],
				Less[RealAbs[(FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta /. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP) - -3], $MachineEpsilon]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20251030-30OZXL@@Tests/ToNumber.wlt:1100,1-1134,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p = {
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`delta -> 0.998, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`Esx -> 0.0078, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma -> 10, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`muc -> 0.0015, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phisxs -> 2.3*10^-6, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phix -> 0.044,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 1.5, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhox -> 0.979, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta -> ((1 - FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma) / (1 - 1 / FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi)),
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`vx -> 0.987, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mud[1] -> 0.0015,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phidxd[1] -> 4.5,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhodx[1] -> 3
	};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP = {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma -> 2.5, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta -> -3.};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msg = Block[{$MessagePrePrint = Sow, $MessageList = {}},
		Reap[
			Module[{}, FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];];
			$MessageList
		]
	];
	Apply[And,
		Simplify[
			{
				Apply[And, Map[NumberQ, Values @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP]],
				SameQ[Sort @ Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP, Sort @ Join[{FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi}, Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP]],
				SubsetQ[Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p, Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP],
				!FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p],
				Equal[ReleaseHold @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`msg, {{}, {}}],
				Less[RealAbs[(FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi /. FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP) - 2], $MachineEpsilon]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20251030-4YT8X7@@Tests/ToNumber.wlt:1135,1-1169,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p = {
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`delta -> 0.998, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`Esx -> 0.0078, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma -> 10, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`muc -> 0.0015, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phisxs -> 2.3*10^-6, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phix -> 0.044,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 1.5, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhox -> 0.979, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta -> ((1 - FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma) / (1 - 1 / FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi)),
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`vx -> 0.987, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mud[1] -> 0.0015,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phidxd[1] -> 4.5,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhodx[1] -> 3
	};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP = {FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`delta -> 0.9, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`Esx -> 1, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta -> 1.};
	Apply[And,
		Simplify[
			{
				FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkAbrt @ FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p],
				FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`checkMsg[FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p], FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters::theta]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20251030-RCWEA2@@Tests/ToNumber.wlt:1170,1-1193,2"
]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p = {
		context1`delta -> 0.998, context1`Esx -> 0.0078, foo`gamma -> 10, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`muc -> 0.0015, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phisxs -> 2.3*10^-6, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phix -> 0.044,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi -> 1.5, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhox -> 0.979, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`theta -> ((1 - FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`gamma) / (1 - 1 / FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`psi)),
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`vx -> 0.987, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`mud[1] -> 0.0015,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`phidxd[1] -> 4.5,
		FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`rhodx[1] -> 3
	};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP = {context2`delta -> 0.9, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`Esx -> 1, bar`gamma -> 2};
	FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP = FernandoDuarte`LongRunRisk`Tools`ToNumber`Private`processNewParameters[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP, FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p];
	Apply[And,
		Simplify @ {
			SameQ[KeyTake[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p, Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`newP], <||>],
			SameQ[Map[Context, Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP],
				Map[Context, Keys @ KeyTake[FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`p, Keys @ FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`procP]]
			]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ToNumber_20251030-4GAHTA@@Tests/ToNumber.wlt:1194,1-1218,2"
] 
VerificationTest[
  $ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ]; True,
  True,
  TestID -> "Untitled-28@@Tests/ToNumber.wlt:1219,1-1223,2"
]
End[]
EndTestSection[]
