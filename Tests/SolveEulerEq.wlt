BeginTestSection["SolveEulerEq"] 
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`"]
VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`longTest = False;
	True
	,
	True
	,
	{}
	,
	TestID->"SolveEulerEq_20231014-DV7Z0A@@Tests/SolveEulerEq.wlt:3,1-12,2"
]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`"];
	True
	,
	True
	,
	{}
	,
	TestID->"SolveEulerEq_20231014-ZQXSBE@@Tests/SolveEulerEq.wlt:13,1-23,2"
]
VerificationTest[
	Off[General::stop];
	If[!FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`longTest, Off[FindRoot::cvmit]];
	Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`msp = FernandoDuarte`LongRunRisk`Models;
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modBY = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`msp @ "BY";
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modBKY = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`msp @ "BKY";
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modNRC = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`msp @ "NRC";
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modDES = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`msp @ "DES";
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modNRCStochVol = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`msp @ "NRCStochVol";
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`mods = If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`longTest,
		{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modBY, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modBKY, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modNRC, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modDES, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modNRCStochVol},
		{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modBKY, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modDES}
	];
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol_,FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffName_,FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numStateVars_,Optional[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numAssets_, 0],Optional[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`bond_, 0]] := Apply[And,
		{
			If[Equal[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numAssets, 0],
				SameQ[Sort[Cases[Map[Keys, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffName[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i_Integer] :> FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i]],
					Range[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numStateVars + 1] - 1
				],
				Equal[
					Sort[
						Tuples[{Range[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numAssets] - FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`bond, Range[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numStateVars + 1] - 1}]
					],
					Sort[
						Cases[Map[Keys, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffName[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i_Integer][FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`j_Integer] :> {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`j}]
					]
				]
			],
			Apply[And,
				Map[MatchQ[#, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffName]&,
					Cases[Map[Keys, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`var_[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i_Integer][FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`j_Integer] :> FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`var]
				]
			],
			Apply[And,
				Map[Function @ MatchQ[#, StringDrop[ToString @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffName, -1]],
					Cases[Map[Keys, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`var_[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i_Integer][FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`j_Integer] :> Context[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`var]]
				]
			],
			Apply[And, Map[NumberQ, Map[Values, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol]]]
		}
	];
	FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`opts = {
		{"initialGuess" -> <|"Ewc" -> {4.6}, "Epd" -> {{5.6}}|>},
		{"PrintResidualsNorm" -> False},
		{"MaxIterations" -> 1},
		{"FindRootOptions" -> {"MaxIterations" -> 1}},
		{
			"initialGuess" -> <|"Ewc" -> {4.6}, "Epd" -> {{5.6}}|>,
			"PrintResidualsNorm" -> False
		},
		{
			"initialGuess" -> <|"Ewc" -> {4.6}, "Epd" -> {{5.6}}|>,
			"PrintResidualsNorm" -> False, "MaxIterations" -> 1
		},
		{
			"initialGuess" -> <|"Ewc" -> {4.6}, "Epd" -> {{5.6}}|>,
			"MaxIterations" -> 1
		},
		{"PrintResidualsNorm" -> False, "MaxIterations" -> 1},
		{
			"initialGuess" -> <|"Ewc" -> {4.6}, "Epd" -> {{5.6}}|>,
			"PrintResidualsNorm" -> False,
			"FindRootOptions" -> {WorkingPrecision -> $MachinePrecision}
		},
		{
			"initialGuess" -> <|"Ewc" -> {4.6}, "Epd" -> {{5.6}}|>,
			"PrintResidualsNorm" -> False, "MaxIterations" -> 1, "FindRootOptions" -> {WorkingPrecision -> $MachinePrecision}
		},
		{
			"initialGuess" -> <|"Ewc" -> {4.6}, "Epd" -> {{5.6}}|>,
			"MaxIterations" -> 1,
			"FindRootOptions" -> {WorkingPrecision -> $MachinePrecision}
		},
		{"PrintResidualsNorm" -> False, "MaxIterations" -> 1, "FindRootOptions" -> {WorkingPrecision -> $MachinePrecision}}
	};
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`optsRepeated = {
		{
			"initialGuess" -> <|"Ewc" -> {4.6}, "Epd" -> {{5.6}}|>,
			"PrintResidualsNorm" -> False,
			"FindRootOptions" -> {WorkingPrecision -> $MachinePrecision},
			WorkingPrecision -> $MachinePrecision
		},
		{
			"initialGuess" -> <|"Ewc" -> {4.6}, "Epd" -> {{5.6}}|>,
			"PrintResidualsNorm" -> False, "MaxIterations" -> 1, "FindRootOptions" -> {WorkingPrecision -> $MachinePrecision},
			WorkingPrecision -> $MachinePrecision
		},
		{
			"initialGuess" -> <|"Ewc" -> {4.6}, "Epd" -> {{5.6}}|>,
			"MaxIterations" -> 1,
			"FindRootOptions" -> {WorkingPrecision -> $MachinePrecision},
			WorkingPrecision -> $MachinePrecision
		},
		{
			"PrintResidualsNorm" -> False, "MaxIterations" -> 1, "FindRootOptions" -> {WorkingPrecision -> $MachinePrecision},
			WorkingPrecision -> $MachinePrecision
		},
		{"PrintResidualsNorm" -> False, "MaxIterations" -> 1, "FindRootOptions" -> {"MaxIterations" -> 5}},
		{"PrintResidualsNorm" -> False, "MaxIterations" -> 1, "FindRootOptions" -> {"MaxIterations" -> 5, WorkingPrecision -> $MachinePrecision}};
		{
			"PrintResidualsNorm" -> False, "MaxIterations" -> 1, "FindRootOptions" -> {"MaxIterations" -> 5, WorkingPrecision -> $MachinePrecision},
			WorkingPrecision -> $MachinePrecision
		}
	};
	If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`longTest,
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`optsMany = Join[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`opts[[5;;-1]], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`optsRepeated];
	,
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`optsMany = Join[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`opts[[5;;6]], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`optsRepeated[[1;;2]]];
	];
	Do[
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = 0;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numStateVars = Length @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`t];
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`numStocks = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model @ "numStocks";
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQWc[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol_] := FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numStateVars];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQPd[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol_] := FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol, Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numStateVars, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`numStocks];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQBond[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol_, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity_] := FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol, Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numStateVars, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity + 1, 1];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQNomBond[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol_, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity_] := FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol, Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numStateVars, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity + 1, 1];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`updateCoeffs = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`updateCoeffsSol = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`updateCoeffsWc = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsWc;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`updateCoeffsPd = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsPd;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`updateCoeffsBond = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond;
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`newParameters = {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`delta -> 0.99};
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`guessCoeffsSolution = {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`A[0] -> 4.6};
		If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`longTest,
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[
				And,
				{
					Equal[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model,
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, {}],
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, {}, {}],
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, {}, {}, {}],
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, {}, {}]
					],
					Equal[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`newParameters],
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`newParameters, {}],
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`newParameters, {}, {}],
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`newParameters, {}]
					],
					Equal[
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`newParameters, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`guessCoeffsSolution],
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`newParameters, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`guessCoeffsSolution],
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`newParameters, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`guessCoeffsSolution, {}, {}],
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`newParameters, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`guessCoeffsSolution]
					]
				}
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		];
		If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`longTest,
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Quiet[
				Apply[And,
					Flatten[
						{
							Map[
								FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQWc,
								Map[
									Function[
										{
											FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, {}, {}, #],
											FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, {}, {}, Sequence @ #],
											FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, {}, {}, Sequence @@ #],
											FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, {}, #],
											FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, Sequence @ {}, #],
											FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, Sequence @@ {}, #],
											FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, #],
											FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, Sequence @ #],
											FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, Sequence @@ #],
											FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, Most @ #, Last @ #],
											FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, Sequence @ Most @ #, Last @ #]
										}
									],
									FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`opts[[1;;4]]
								],
								{2}
							],
							Map[
								FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQWc,
								Map[
									Function @ {
										FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, {}, {}, #],
										FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, First @ #, Rest @ #],
										FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, First @ #, Sequence @ Rest @ #],
										FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, Sequence[First @ #, Rest @ #]],
										FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, Most @ #, {Last @ #}],
										FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, {First @ #}, Rest @ #]
									},
									FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`optsMany
								],
								{2}
							]
						}
					]
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`optsWc = {"MaxIterations" -> 100};
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solWc = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`optsWc];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Equal[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solWc,
			FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, {}, {}, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`optsWc],
			FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsWc[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["coeffsSolution"]["wc"], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model @ "params", {}, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`optsWc]
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`longTest,
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solWc1 = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "MaxIterations" -> 1, "initialGuess" -> <|"Ewc" -> {3}|>];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solWc2 = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "MaxIterations" -> 1, "initialGuess" -> <|"Ewc" -> {1}|>];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Greater[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[0] /. FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solWc1, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[0] /. FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solWc2];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solWc1 = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model,
				"FindRootOptions" -> {"MaxIterations" -> 1},
				"initialGuess" -> <|"Ewc" -> {3}|>
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solWc2 = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model,
				"FindRootOptions" -> {"MaxIterations" -> 1},
				"initialGuess" -> <|"Ewc" -> {1}|>
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Greater[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[0] /. FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solWc1, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[0] /. FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solWc2];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m1 = Block[
				{$MessagePrePrint = Sow, $MessageList = {}},
				Reap[
					Module[{},
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "MaxIterations" -> 1, "initialGuess" -> <|"Ewc" -> {4}|>];
					];
					$MessageList
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m2 = Block[
				{$MessagePrePrint = Sow, $MessageList = {}},
				Reap[
					Module[{},
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "MaxIterations" -> 3, "initialGuess" -> <|"Ewc" -> {4}|>];
					];
					$MessageList
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m3 = Block[
				{$MessagePrePrint = Sow, $MessageList = {}},
				Reap[
					Module[{},
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model,
							"FindRootOptions" -> {"MaxIterations" -> 1},
							"initialGuess" -> <|"Ewc" -> {4}|>
						];
					];
					$MessageList
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m4 = Block[
				{$MessagePrePrint = Sow, $MessageList = {}},
				Reap[
					Module[{},
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model,
							"FindRootOptions" -> {"MaxIterations" -> 3},
							"initialGuess" -> <|"Ewc" -> {4}|>
						];
					];
					$MessageList
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[
				And,
				{
					Equal[ReleaseHold @ Last @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m1, {{1}}],
					Equal[ReleaseHold @ Last @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m2, {{3}}],
					Equal[ReleaseHold @ Last @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m3, {{1}}],
					Equal[ReleaseHold @ Last @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m4, {{3}}]
				}
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m1 = Block[
				{$MessagePrePrint = Sow, $MessageList = {}},
				Reap[
					Module[{},
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model,
							"MaxIterations" -> 3,
							"FindRootOptions" -> {"MaxIterations" -> 1},
							"initialGuess" -> <|"Ewc" -> {4}|>
						];
					];
					$MessageList
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m2 = Block[
				{$MessagePrePrint = Sow, $MessageList = {}},
				Reap[
					Module[{},
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model,
							"FindRootOptions" -> {"MaxIterations" -> 1},
							"MaxIterations" -> 3,
							"initialGuess" -> <|"Ewc" -> {4}|>
						];
					];
					$MessageList
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m3 = Block[
				{$MessagePrePrint = Sow, $MessageList = {}},
				Reap[
					Module[{},
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model,
							"MaxIterations" -> 1,
							"FindRootOptions" -> {"MaxIterations" -> 3},
							"initialGuess" -> <|"Ewc" -> {4}|>
						];
					];
					$MessageList
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m4 = Block[
				{$MessagePrePrint = Sow, $MessageList = {}},
				Reap[
					Module[{},
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model,
							"FindRootOptions" -> {"MaxIterations" -> 3},
							"MaxIterations" -> 1,
							"initialGuess" -> <|"Ewc" -> {4}|>
						];
					];
					$MessageList
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[
				And,
				{
					Equal[ReleaseHold @ Last @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m1, {{3}}],
					Equal[ReleaseHold @ Last @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m2, {{3}}],
					Equal[ReleaseHold @ Last @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m3, {{1}}],
					Equal[ReleaseHold @ Last @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m4, {{1}}]
				}
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m1 = Block[
				{$MessagePrePrint = Sow, $MessageList = {}},
				Reap[
					Module[{}, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "PrintResidualsNorm" -> False];];
					$MessageList
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m2 = Block[
				{$MessagePrePrint = Sow, $MessageList = {}},
				Reap[
					Module[{}, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "PrintResidualsNorm" -> True];];
					$MessageList
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Equal[ReleaseHold @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m1, {{}, {}}];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Equal[First @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m2, {HoldForm[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::norm]}];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = NumberQ[ReleaseHold @ First @ Flatten @ Last @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m2];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`c1 = Not[
				TrueQ[
					CheckAbort[
						Check[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "CheckResiduals" -> False],
							Abort[], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid
						],
						True
					]
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`c2 = TrueQ[
				CheckAbort[
					Check[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "CheckResiduals" -> True],
						Abort[], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid
					],
					True
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[And, {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`c1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`c2}];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`c1 = Not[
				TrueQ[
					CheckAbort[
						Check[
							FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "CheckResiduals" -> True, "Tol" -> 1],
							Abort[], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid
						],
						True
					]
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`c2 = TrueQ[
				CheckAbort[
					Check[
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "CheckResiduals" -> True, "Tol" -> (10. ^ -20)],
						Abort[], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid
					],
					True
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[And, {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`c1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`c2}];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`Ewc0 = 4.6;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQWc[
			FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model,
				"UpdatePd" -> False,
				"initialGuess" -> <|"Ewc" -> {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`Ewc0}, "Epd" -> {{5.5}}|>
			]
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsWcPd = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model,
			"UpdatePd" -> True,
			"initialGuess" -> <|"Ewc" -> {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`Ewc0}, "Epd" -> {{5.5}}|>
		];
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`coeffsWc = FilterRules[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsWcPd, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc @ _Integer];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsPd = FilterRules[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsWcPd, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd @ _Integer];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQWc @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`coeffsWc;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQPd @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsPd;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`longTest,
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Equal[
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "initialGuess" -> <|"Ewc" -> {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`Ewc0}|>],
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model,
					"UpdatePd" -> False,
					"initialGuess" -> <|"Ewc" -> {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`Ewc0}, "Epd" -> {{5.5}}|>
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[
				And,
				{
					SubsetQ[Options @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs, Options @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol],
					SubsetQ[Options @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs, Options @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks]
				}
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`oldOptions = Options @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`oldOptionsSol = Options @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`oldOptionsWc = Options @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsWc;
			FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`ig = 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Equal[
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "initialGuess" -> <|"Ewc" -> {FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`ig}|>],
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, {}, {}, "initialGuess" -> <|"Ewc" -> {FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`ig}|>],
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsWc[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["coeffsSolution"]["wc"],
					FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model @ "parameters", {}, "Ewc0" -> FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`ig
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			SetOptions[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs, "initialGuess" -> <|"Ewc" -> {FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`ig}|>];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Equal[
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "initialGuess" -> <|"Ewc" -> {FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`ig}|>],
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			Options[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs] = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`oldOptions;
			SetOptions[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol, "initialGuess" -> <|"Ewc" -> {FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`ig}|>];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Equal[
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, {}, {}],
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, {}, {}, "initialGuess" -> <|"Ewc" -> {FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`ig}|>],
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "initialGuess" -> <|"Ewc" -> {FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`ig}|>]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Not[
				TrueQ[
					Equal[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, {}, {}, MaxIterations -> 1],
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, MaxIterations -> 1]
					]
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			Options[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol] = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`oldOptionsSol;
			SetOptions[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsWc, "Ewc0" -> FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`ig];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Equal[
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsWc[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["coeffsSolution"]["wc"], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model @ "parameters", {}],
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsWc[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["coeffsSolution"]["wc"],
					FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model @ "parameters", {}, "Ewc0" -> FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`ig
				],
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "initialGuess" -> <|"Ewc" -> {FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`ig}|>]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Not[
				TrueQ[
					Equal[
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsWc[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["coeffsSolution"]["wc"],
							FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model @ "parameters", {}, MaxIterations -> 1
						],
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, MaxIterations -> 1]
					]
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			Options[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsWc] = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`oldOptionsWc;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`oldOptions = Options @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`optsUpdateCoeff = {
				{"initialGuess" -> <|"Ewc" -> {4.6}, "Epd" -> {{4.6}}|>},
				{"PrintResidualsNorm" -> True}
			};
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[
				And,
				Flatten[
					Map[
						Function[
							{
								SetOptions[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs, #];
								FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`out = Equal[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, #], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model];
								Options[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs] = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`oldOptions;
								FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`out
							}
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`optsUpdateCoeff
					]
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`optsBad = {{MaxIterations -> 100}, {PrecisionGoal -> $MachinePrecision}};
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[
				And,
				Flatten[
					Map[
						Function[
							{
								FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m = Block[
									{$MessagePrePrint = Sow, $MessageList = {}},
									Reap[
										Module[{}, SetOptions[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs, #]];
										$MessageList
									]
								];
								Options[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs] = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`oldOptions;
								Equal[First @ First @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m, HoldForm[SetOptions::optnf]]
							}
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`optsBad
					]
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`optsFindRoot = {
				"FindRootOptions" -> {MaxIterations -> 1},
				"FindRootOptions" -> {AccuracyGoal -> 2}
			};
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`oldFindRootOpts = Options @ FindRoot;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`withFindRootOptionDefault = Keys["FindRootOptions" /. Options[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs]];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[
				And,
				Flatten[
					Map[
						Function[
							{
								SetOptions[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs, #];
								FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`out1 = Equal[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, #], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model];
								Options[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs] = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`oldOptions;
								Unprotect @ FindRoot;
								SetOptions[FindRoot, Last @ #];
								FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`out2 = Equal[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, #], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model];
								FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`out2 = If[
									MemberQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`withFindRootOptionDefault, First @ First @ Last @ #],
									!TrueQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`out2],
									FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`out2
								];
								Options[FindRoot] = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`oldFindRootOpts;
								Protect @ FindRoot;
								{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`out1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`out2}
							}
						],
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`optsFindRoot
					]
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[And,
			{
				FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQWc[
					FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "initialGuess" -> <|"Ewc" -> {1, 8}|>]
				],
				FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQWc[
					FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "initialGuess" -> <|"Ewc" -> {4, 1, 8}|>]
				]
			}
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`longTest,
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[
				And,
				{
					Equal[
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQWc[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "initialGuess" -> <|"Ewc" -> {4.}|>]],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQWc[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "initialGuess" -> <|"Ewc" -> {4}|>]]
					],
					Equal[
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQWc[
							FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "initialGuess" -> <|"Ewc" -> {1., 8.}|>]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQWc[
							FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "initialGuess" -> <|"Ewc" -> {1, 8}|>]
						]
					],
					Equal[
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQWc[
							FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "initialGuess" -> <|"Ewc" -> {4., 1., 8.}|>]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQWc[
							FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "initialGuess" -> <|"Ewc" -> {4, 1, 8}|>]
						]
					]
				}
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		];
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity = 12;
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solBond = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["coeffsSolution"]["bond"],
			FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model @ "params", {}, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solWc
		];
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solNomBond = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["coeffsSolution"]["nombond"],
			FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model @ "params", {}, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solWc
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[And,
			{
				FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQBond[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solBond, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity],
				FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQNomBond[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solNomBond, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity]
			}
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`newBondParams = {FernandoDuarte`LongRunRisk`Model`Parameters`psi -> ((0.1 + FernandoDuarte`LongRunRisk`Model`Parameters`psi) /. FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["params"])};
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solWcNewBondParams = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`newBondParams, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`optsWc];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solBondNew = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["coeffsSolution"]["bond"],
			FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model @ "params", FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`newBondParams, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solWcNewBondParams
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solNomBondNew = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["coeffsSolution"]["nombond"],
			FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model @ "params", FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`newBondParams, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solWcNewBondParams
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[And,
			{
				FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQBond[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solBondNew, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity],
				FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQNomBond[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solNomBondNew, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity],
				!SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solBond, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solBondNew],
				!SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solNomBond, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solNomBondNew]
			}
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`oldMaxMaturity = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity;
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity = 2;
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solBond = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["coeffsSolution"]["bond"],
			FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model @ "params", {}, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solWc
		];
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solNomBond = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["coeffsSolution"]["nombond"],
			FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model @ "params", {}, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solWc
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[And,
			{
				FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQBond[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solBond, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity],
				FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQNomBond[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solNomBond, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity],
				Equal[Range[0, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity],
					Sort[DeleteDuplicates[Cases[Keys @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solBond, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`x_[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i_][FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`j_] :> FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i]]]
				],
				Equal[Range[0, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity],
					Sort[DeleteDuplicates[Cases[Keys @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solNomBond, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`x_[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i_][FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`j_] :> FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i]]]
				]
			}
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`oldMaxMaturity;
		If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`longTest,
			FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solBond = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["coeffsSolution"]["bond"],
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model @ "params", {}, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solWc, "Method" -> Automatic, "Precision" -> 1
			];
			FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solNomBond = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["coeffsSolution"]["nombond"],
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model @ "params", {}, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solWc, "Method" -> Automatic, "Precision" -> 1
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[
				And,
				{
					FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQBond[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solBond, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity],
					FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQNomBond[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solNomBond, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity]
				}
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[
				And,
				{
					SameQ[
						FilterRules[
							FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "UpdateBond" -> True, "MaxMaturity" -> FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity],
							FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb @ _
						],
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["coeffsSolution"]["bond"],
							FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model @ "params", {}, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solWc
						]
					],
					SameQ[
						FilterRules[
							FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "UpdateNomBond" -> True, "MaxMaturity" -> FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity],
							FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb @ _
						],
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["coeffsSolution"]["nombond"],
							FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model @ "params", {}, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solWc
						]
					]
				}
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[
				And,
				{
					SameQ[
						Sort[
							FilterRules[
								FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "UpdateBonds" -> True, "MaxMaturity" -> FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity],
								FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb[_] | FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb[_]
							]
						],
						Sort @ Join[
							FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[
								FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["coeffsSolution"]["bond"],
								FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model @ "params", {}, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solWc
							],
							FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[
								FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["coeffsSolution"]["nombond"],
								FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model @ "params", {}, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solWc
							]
						]
					]
				}
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m1 = Block[
				{$MessagePrePrint = Sow, $MessageList = {}},
				Reap[
					Module[{},
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "UpdateBond" -> True, "PrintResidualsNorm" -> False];
					];
					$MessageList
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m2 = Block[
				{$MessagePrePrint = Sow, $MessageList = {}},
				Reap[
					Module[{},
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "UpdateBond" -> True, "PrintResidualsNorm" -> True];
					];
					$MessageList
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Equal[ReleaseHold @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m1, {{}, {}}];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = MemberQ[ReleaseHold @ First @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m2, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::norm];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = NumberQ[ReleaseHold @ First @ Flatten @ Last @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`m2];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`c1 = Not[
				TrueQ[
					CheckAbort[
						Check[
							FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "UpdateBond" -> True, "CheckResiduals" -> False],
							Abort[], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid
						],
						True
					]
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`c2 = TrueQ[
				CheckAbort[
					Check[
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "UpdateBond" -> True, "CheckResiduals" -> True],
						Abort[], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid
					],
					True
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[And, {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`c1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`c2}];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`c1 = Not[
				TrueQ[
					CheckAbort[
						Check[
							FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, "UpdateBond" -> True, "CheckResiduals" -> True, "Tol" -> 1],
							Abort[], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid
						],
						True
					]
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`c2 = TrueQ[
				CheckAbort[
					Check[
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model,
							"UpdateBond" -> True, "CheckResiduals" -> True, "Tol" -> (10. ^ -20)
						],
						Abort[], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid
					],
					True
				]
			];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[And, {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`c1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`c2}];
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		];
	,
		{FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`mods}
	];
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`noMissingTest = {};
	Do[
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`testNumber = Sort[
			Cases[Keys @ SubValues @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests,
				RuleDelayed[
					Verbatim[HoldPattern][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i_Integer]],
					FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i
				]
			]
		];
		AppendTo[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`noMissingTest, Equal[Range[0, Max @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`testNumber], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`testNumber]];
	,
		{FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`model, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`mods}
	];
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`out = Apply[And,
		{
			Apply[And, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`noMissingTest],
			Apply[And, Values @ SubValues @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests]
		}
	];
	On[General::stop];
	On[FindRoot::cvmit];
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`out
	,
	True
	,
	{}
	,
	TestID->"SolveEulerEq_20231014-3WPEY0@@Tests/SolveEulerEq.wlt:24,1-854,2"
] 
End[]
EndTestSection[]
