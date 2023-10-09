BeginTestSection["SolveEulerEq"] 
Begin["ComputationalEngine`SolveEulerEq`"]
Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`";
$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`"];
VerificationTest[
	Off[General::stop];
	Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`"];
	Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
	ComputationalEngine`SolveEulerEq`msp = FernandoDuarte`LongRunRisk`Models;
	ComputationalEngine`SolveEulerEq`modBY = ComputationalEngine`SolveEulerEq`msp @ "BY";
	ComputationalEngine`SolveEulerEq`modBKY = ComputationalEngine`SolveEulerEq`msp @ "BKY";
	ComputationalEngine`SolveEulerEq`modNRC = ComputationalEngine`SolveEulerEq`msp @ "NRC";
	ComputationalEngine`SolveEulerEq`modDES = ComputationalEngine`SolveEulerEq`msp @ "DES";
	ComputationalEngine`SolveEulerEq`modNRCStochVol = ComputationalEngine`SolveEulerEq`msp @ "NRCStochVol";
	ComputationalEngine`SolveEulerEq`mods = {ComputationalEngine`SolveEulerEq`modBY, ComputationalEngine`SolveEulerEq`modBKY, ComputationalEngine`SolveEulerEq`modNRC, ComputationalEngine`SolveEulerEq`modDES, ComputationalEngine`SolveEulerEq`modNRCStochVol};
	ComputationalEngine`SolveEulerEq`coeffsQ[ComputationalEngine`SolveEulerEq`sol_,ComputationalEngine`SolveEulerEq`coeffName_,ComputationalEngine`SolveEulerEq`numStateVars_,Optional[ComputationalEngine`SolveEulerEq`numAssets_, 0],Optional[ComputationalEngine`SolveEulerEq`bond_, 0]] := Apply[
		And,
		{
			If[Equal[ComputationalEngine`SolveEulerEq`numAssets, 0],
				SameQ[Sort[Cases[Map[Keys, ComputationalEngine`SolveEulerEq`sol], ComputationalEngine`SolveEulerEq`coeffName[ComputationalEngine`SolveEulerEq`i_Integer] :> ComputationalEngine`SolveEulerEq`i]],
					Range[ComputationalEngine`SolveEulerEq`numStateVars + 1] - 1
				],
				Equal[
					Sort[
						Tuples[{Range[ComputationalEngine`SolveEulerEq`numAssets] - ComputationalEngine`SolveEulerEq`bond, Range[ComputationalEngine`SolveEulerEq`numStateVars + 1] - 1}]
					],
					Sort[
						Cases[Map[Keys, ComputationalEngine`SolveEulerEq`sol], ComputationalEngine`SolveEulerEq`coeffName[ComputationalEngine`SolveEulerEq`i_Integer][ComputationalEngine`SolveEulerEq`j_Integer] :> {ComputationalEngine`SolveEulerEq`i, ComputationalEngine`SolveEulerEq`j}]
					]
				]
			],
			Apply[And,
				Map[MatchQ[#, ComputationalEngine`SolveEulerEq`coeffName]&,
					Cases[Map[Keys, ComputationalEngine`SolveEulerEq`sol], ComputationalEngine`SolveEulerEq`var_[ComputationalEngine`SolveEulerEq`i_Integer][ComputationalEngine`SolveEulerEq`j_Integer] :> ComputationalEngine`SolveEulerEq`var]
				]
			],
			Apply[And,
				Map[Function @ MatchQ[#, StringDrop[ToString @ ComputationalEngine`SolveEulerEq`coeffName, -1]],
					Cases[Map[Keys, ComputationalEngine`SolveEulerEq`sol], ComputationalEngine`SolveEulerEq`var_[ComputationalEngine`SolveEulerEq`i_Integer][ComputationalEngine`SolveEulerEq`j_Integer] :> Context[ComputationalEngine`SolveEulerEq`var]]
				]
			],
			Apply[And, Map[NumberQ, Map[Values, ComputationalEngine`SolveEulerEq`sol]]]
		}
	];
	ComputationalEngine`SolveEulerEq`opts = {
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
	ComputationalEngine`SolveEulerEq`optsRepeated = {
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
	ComputationalEngine`SolveEulerEq`optsMany = Join[ComputationalEngine`SolveEulerEq`opts[[5;;-1]], ComputationalEngine`SolveEulerEq`optsRepeated];
	Do[
		ComputationalEngine`SolveEulerEq`ind = 0;
		ComputationalEngine`SolveEulerEq`numStateVars = Length @ ComputationalEngine`SolveEulerEq`model["stateVars"][ComputationalEngine`SolveEulerEq`t];
		ComputationalEngine`SolveEulerEq`numStocks = ComputationalEngine`SolveEulerEq`model @ "numStocks";
		ComputationalEngine`SolveEulerEq`coeffsQWc[ComputationalEngine`SolveEulerEq`sol_] := ComputationalEngine`SolveEulerEq`coeffsQ[ComputationalEngine`SolveEulerEq`sol, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc, ComputationalEngine`SolveEulerEq`numStateVars];
		ComputationalEngine`SolveEulerEq`coeffsQPd[ComputationalEngine`SolveEulerEq`sol_] := ComputationalEngine`SolveEulerEq`coeffsQ[ComputationalEngine`SolveEulerEq`sol, Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd, ComputationalEngine`SolveEulerEq`numStateVars, ComputationalEngine`SolveEulerEq`numStocks];
		ComputationalEngine`SolveEulerEq`coeffsQBond[ComputationalEngine`SolveEulerEq`sol_, ComputationalEngine`SolveEulerEq`maxMaturity_] := ComputationalEngine`SolveEulerEq`coeffsQ[ComputationalEngine`SolveEulerEq`sol, Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb, ComputationalEngine`SolveEulerEq`numStateVars, ComputationalEngine`SolveEulerEq`maxMaturity + 1, 1];
		ComputationalEngine`SolveEulerEq`coeffsQNomBond[ComputationalEngine`SolveEulerEq`sol_, ComputationalEngine`SolveEulerEq`maxMaturity_] := ComputationalEngine`SolveEulerEq`coeffsQ[ComputationalEngine`SolveEulerEq`sol, Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb, ComputationalEngine`SolveEulerEq`numStateVars, ComputationalEngine`SolveEulerEq`maxMaturity + 1, 1];
		ComputationalEngine`SolveEulerEq`updateCoeffs = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs;
		ComputationalEngine`SolveEulerEq`updateCoeffsSol = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol;
		ComputationalEngine`SolveEulerEq`updateCoeffsWc = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsWc;
		ComputationalEngine`SolveEulerEq`updateCoeffsPd = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsPd;
		ComputationalEngine`SolveEulerEq`updateCoeffsBond = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond;
		ComputationalEngine`SolveEulerEq`newParameters = {ComputationalEngine`SolveEulerEq`delta -> 0.99};
		ComputationalEngine`SolveEulerEq`guessCoeffsSolution = {ComputationalEngine`SolveEulerEq`A[0] -> 4.6};
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			{
				Equal[ComputationalEngine`SolveEulerEq`updateCoeffs @ ComputationalEngine`SolveEulerEq`model,
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, {}],
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, {}, {}],
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, {}, {}, {}],
					ComputationalEngine`SolveEulerEq`updateCoeffsSol[ComputationalEngine`SolveEulerEq`model, {}, {}]
				],
				Equal[ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, ComputationalEngine`SolveEulerEq`newParameters],
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, ComputationalEngine`SolveEulerEq`newParameters, {}],
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, ComputationalEngine`SolveEulerEq`newParameters, {}, {}],
					ComputationalEngine`SolveEulerEq`updateCoeffsSol[ComputationalEngine`SolveEulerEq`model, ComputationalEngine`SolveEulerEq`newParameters, {}]
				],
				Equal[ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, ComputationalEngine`SolveEulerEq`newParameters, ComputationalEngine`SolveEulerEq`guessCoeffsSolution],
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, ComputationalEngine`SolveEulerEq`newParameters, ComputationalEngine`SolveEulerEq`guessCoeffsSolution],
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, ComputationalEngine`SolveEulerEq`newParameters, ComputationalEngine`SolveEulerEq`guessCoeffsSolution, {}, {}],
					ComputationalEngine`SolveEulerEq`updateCoeffsSol[ComputationalEngine`SolveEulerEq`model, ComputationalEngine`SolveEulerEq`newParameters, ComputationalEngine`SolveEulerEq`guessCoeffsSolution]
				]
			}
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Quiet[
			Apply[And,
				Flatten[
					{
						Map[ComputationalEngine`SolveEulerEq`coeffsQWc,
							Map[
								Function[
									{
										ComputationalEngine`SolveEulerEq`updateCoeffsSol[ComputationalEngine`SolveEulerEq`model, {}, {}, #],
										ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, {}, {}, Sequence @ #],
										ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, {}, {}, Sequence @@ #],
										ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, {}, #],
										ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, Sequence @ {}, #],
										ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, Sequence @@ {}, #],
										ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, #],
										ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, Sequence @ #],
										ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, Sequence @@ #],
										ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, Most @ #, Last @ #],
										ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, Sequence @ Most @ #, Last @ #]
									}
								],
								ComputationalEngine`SolveEulerEq`opts[[1;;4]]
							],
							{2}
						],
						Map[ComputationalEngine`SolveEulerEq`coeffsQWc,
							Map[
								Function @ {
									ComputationalEngine`SolveEulerEq`updateCoeffsSol[ComputationalEngine`SolveEulerEq`model, {}, {}, #],
									ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, First @ #, Rest @ #],
									ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, First @ #, Sequence @ Rest @ #],
									ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, Sequence[First @ #, Rest @ #]],
									ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, Most @ #, {Last @ #}],
									ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, {First @ #}, Rest @ #]
								},
								ComputationalEngine`SolveEulerEq`optsMany
							],
							{2}
						]
					}
				]
			]
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`optsWc = {"MaxIterations" -> 100};
		ComputationalEngine`SolveEulerEq`solWc = ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, ComputationalEngine`SolveEulerEq`optsWc];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Equal[
			ComputationalEngine`SolveEulerEq`solWc,
			ComputationalEngine`SolveEulerEq`updateCoeffsSol[ComputationalEngine`SolveEulerEq`model, {}, {}, ComputationalEngine`SolveEulerEq`optsWc],
			ComputationalEngine`SolveEulerEq`updateCoeffsWc[ComputationalEngine`SolveEulerEq`model["coeffsSolution"]["wc"], ComputationalEngine`SolveEulerEq`model @ "params", {}, ComputationalEngine`SolveEulerEq`optsWc]
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`solWc1 = ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "MaxIterations" -> 1, "initialGuess" -> <|"Ewc" -> {3}|>];
		ComputationalEngine`SolveEulerEq`solWc2 = ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "MaxIterations" -> 1, "initialGuess" -> <|"Ewc" -> {1}|>];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Greater[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[0] /. ComputationalEngine`SolveEulerEq`solWc1, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[0] /. ComputationalEngine`SolveEulerEq`solWc2];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`solWc1 = ComputationalEngine`SolveEulerEq`updateCoeffs[
			ComputationalEngine`SolveEulerEq`model,
			"FindRootOptions" -> {"MaxIterations" -> 1},
			"initialGuess" -> <|"Ewc" -> {3}|>
		];
		ComputationalEngine`SolveEulerEq`solWc2 = ComputationalEngine`SolveEulerEq`updateCoeffs[
			ComputationalEngine`SolveEulerEq`model,
			"FindRootOptions" -> {"MaxIterations" -> 1},
			"initialGuess" -> <|"Ewc" -> {1}|>
		];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Greater[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[0] /. ComputationalEngine`SolveEulerEq`solWc1, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[0] /. ComputationalEngine`SolveEulerEq`solWc2];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`m1 = Block[
			{$MessagePrePrint = Sow, $MessageList = {}},
			Reap[
				Module[{},
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "MaxIterations" -> 1, "initialGuess" -> <|"Ewc" -> {4}|>];
				];
				$MessageList
			]
		];
		ComputationalEngine`SolveEulerEq`m2 = Block[
			{$MessagePrePrint = Sow, $MessageList = {}},
			Reap[
				Module[{},
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "MaxIterations" -> 3, "initialGuess" -> <|"Ewc" -> {4}|>];
				];
				$MessageList
			]
		];
		ComputationalEngine`SolveEulerEq`m3 = Block[
			{$MessagePrePrint = Sow, $MessageList = {}},
			Reap[
				Module[{},
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model,
						"FindRootOptions" -> {"MaxIterations" -> 1},
						"initialGuess" -> <|"Ewc" -> {4}|>
					];
				];
				$MessageList
			]
		];
		ComputationalEngine`SolveEulerEq`m4 = Block[
			{$MessagePrePrint = Sow, $MessageList = {}},
			Reap[
				Module[{},
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model,
						"FindRootOptions" -> {"MaxIterations" -> 3},
						"initialGuess" -> <|"Ewc" -> {4}|>
					];
				];
				$MessageList
			]
		];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			{
				Equal[ReleaseHold @ Last @ ComputationalEngine`SolveEulerEq`m1, {{1}}],
				Equal[ReleaseHold @ Last @ ComputationalEngine`SolveEulerEq`m2, {{3}}],
				Equal[ReleaseHold @ Last @ ComputationalEngine`SolveEulerEq`m3, {{1}}],
				Equal[ReleaseHold @ Last @ ComputationalEngine`SolveEulerEq`m4, {{3}}]
			}
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`m1 = Block[
			{$MessagePrePrint = Sow, $MessageList = {}},
			Reap[
				Module[{},
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model,
						"MaxIterations" -> 3,
						"FindRootOptions" -> {"MaxIterations" -> 1},
						"initialGuess" -> <|"Ewc" -> {4}|>
					];
				];
				$MessageList
			]
		];
		ComputationalEngine`SolveEulerEq`m2 = Block[
			{$MessagePrePrint = Sow, $MessageList = {}},
			Reap[
				Module[{},
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model,
						"FindRootOptions" -> {"MaxIterations" -> 1},
						"MaxIterations" -> 3,
						"initialGuess" -> <|"Ewc" -> {4}|>
					];
				];
				$MessageList
			]
		];
		ComputationalEngine`SolveEulerEq`m3 = Block[
			{$MessagePrePrint = Sow, $MessageList = {}},
			Reap[
				Module[{},
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model,
						"MaxIterations" -> 1,
						"FindRootOptions" -> {"MaxIterations" -> 3},
						"initialGuess" -> <|"Ewc" -> {4}|>
					];
				];
				$MessageList
			]
		];
		ComputationalEngine`SolveEulerEq`m4 = Block[
			{$MessagePrePrint = Sow, $MessageList = {}},
			Reap[
				Module[{},
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model,
						"FindRootOptions" -> {"MaxIterations" -> 3},
						"MaxIterations" -> 1,
						"initialGuess" -> <|"Ewc" -> {4}|>
					];
				];
				$MessageList
			]
		];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			{
				Equal[ReleaseHold @ Last @ ComputationalEngine`SolveEulerEq`m1, {{3}}],
				Equal[ReleaseHold @ Last @ ComputationalEngine`SolveEulerEq`m2, {{3}}],
				Equal[ReleaseHold @ Last @ ComputationalEngine`SolveEulerEq`m3, {{1}}],
				Equal[ReleaseHold @ Last @ ComputationalEngine`SolveEulerEq`m4, {{1}}]
			}
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`m1 = Block[
			{$MessagePrePrint = Sow, $MessageList = {}},
			Reap[
				Module[{}, ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "PrintResidualsNorm" -> False];];
				$MessageList
			]
		];
		ComputationalEngine`SolveEulerEq`m2 = Block[
			{$MessagePrePrint = Sow, $MessageList = {}},
			Reap[
				Module[{}, ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "PrintResidualsNorm" -> True];];
				$MessageList
			]
		];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Equal[ReleaseHold @ ComputationalEngine`SolveEulerEq`m1, {{}, {}}];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Equal[First @ ComputationalEngine`SolveEulerEq`m2, {HoldForm[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::norm]}];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = NumberQ[ReleaseHold @ First @ Flatten @ Last @ ComputationalEngine`SolveEulerEq`m2];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`c1 = Not[
			TrueQ[
				CheckAbort[
					Check[ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "CheckResiduals" -> False],
						Abort[], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid
					],
					True
				]
			]
		];
		ComputationalEngine`SolveEulerEq`c2 = TrueQ[
			CheckAbort[
				Check[ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "CheckResiduals" -> True],
					Abort[], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid
				],
				True
			]
		];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Apply[And, {ComputationalEngine`SolveEulerEq`c1, ComputationalEngine`SolveEulerEq`c2}];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`c1 = Not[
			TrueQ[
				CheckAbort[
					Check[
						ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "CheckResiduals" -> True, "Tol" -> 1],
						Abort[], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid
					],
					True
				]
			]
		];
		ComputationalEngine`SolveEulerEq`c2 = TrueQ[
			CheckAbort[
				Check[
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "CheckResiduals" -> True, "Tol" -> (10. ^ -20)],
					Abort[], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid
				],
				True
			]
		];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Apply[And, {ComputationalEngine`SolveEulerEq`c1, ComputationalEngine`SolveEulerEq`c2}];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`Ewc0 = 4.6;
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = ComputationalEngine`SolveEulerEq`coeffsQWc[
			ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model,
				"UpdatePd" -> False,
				"initialGuess" -> <|"Ewc" -> {ComputationalEngine`SolveEulerEq`Ewc0}, "Epd" -> {{5.5}}|>
			]
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind;
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`coeffsWcPd = ComputationalEngine`SolveEulerEq`updateCoeffs[
			ComputationalEngine`SolveEulerEq`model, "UpdatePd" -> True, "initialGuess" -> <|"Ewc" -> {ComputationalEngine`SolveEulerEq`Ewc0}, "Epd" -> {{5.5}}|>
		];
		ComputationalEngine`SolveEulerEq`coeffsWc = FilterRules[ComputationalEngine`SolveEulerEq`coeffsWcPd, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc @ _Integer];
		ComputationalEngine`SolveEulerEq`coeffsPd = FilterRules[ComputationalEngine`SolveEulerEq`coeffsWcPd, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd @ _Integer];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = ComputationalEngine`SolveEulerEq`coeffsQWc @ ComputationalEngine`SolveEulerEq`coeffsWc;
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = ComputationalEngine`SolveEulerEq`coeffsQPd @ ComputationalEngine`SolveEulerEq`coeffsPd;
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Equal[
			ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "initialGuess" -> <|"Ewc" -> {ComputationalEngine`SolveEulerEq`Ewc0}|>],
			ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model,
				"UpdatePd" -> False,
				"initialGuess" -> <|"Ewc" -> {ComputationalEngine`SolveEulerEq`Ewc0}, "Epd" -> {{5.5}}|>
			]
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			{
				SubsetQ[Options @ ComputationalEngine`SolveEulerEq`updateCoeffs, Options @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol],
				SubsetQ[Options @ ComputationalEngine`SolveEulerEq`updateCoeffs, Options @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks]
			}
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`oldOptions = Options @ ComputationalEngine`SolveEulerEq`updateCoeffs;
		ComputationalEngine`SolveEulerEq`oldOptionsSol = Options @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol;
		ComputationalEngine`SolveEulerEq`oldOptionsWc = Options @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsWc;
		ComputationalEngine`SolveEulerEq`ig = 1;
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Equal[
			ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "initialGuess" -> <|"Ewc" -> {ComputationalEngine`SolveEulerEq`ig}|>],
			ComputationalEngine`SolveEulerEq`updateCoeffsSol[ComputationalEngine`SolveEulerEq`model, {}, {}, "initialGuess" -> <|"Ewc" -> {ComputationalEngine`SolveEulerEq`ig}|>],
			ComputationalEngine`SolveEulerEq`updateCoeffsWc[ComputationalEngine`SolveEulerEq`model["coeffsSolution"]["wc"],
				ComputationalEngine`SolveEulerEq`model @ "parameters", {}, "Ewc0" -> ComputationalEngine`SolveEulerEq`ig
			]
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		SetOptions[ComputationalEngine`SolveEulerEq`updateCoeffs, "initialGuess" -> <|"Ewc" -> {ComputationalEngine`SolveEulerEq`ig}|>];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Equal[
			ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "initialGuess" -> <|"Ewc" -> {ComputationalEngine`SolveEulerEq`ig}|>],
			ComputationalEngine`SolveEulerEq`updateCoeffs @ ComputationalEngine`SolveEulerEq`model
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		Options[ComputationalEngine`SolveEulerEq`updateCoeffs] = ComputationalEngine`SolveEulerEq`oldOptions;
		SetOptions[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol, "initialGuess" -> <|"Ewc" -> {ComputationalEngine`SolveEulerEq`ig}|>];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Equal[
			ComputationalEngine`SolveEulerEq`updateCoeffsSol[ComputationalEngine`SolveEulerEq`model, {}, {}],
			ComputationalEngine`SolveEulerEq`updateCoeffsSol[ComputationalEngine`SolveEulerEq`model, {}, {}, "initialGuess" -> <|"Ewc" -> {ComputationalEngine`SolveEulerEq`ig}|>],
			ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "initialGuess" -> <|"Ewc" -> {ComputationalEngine`SolveEulerEq`ig}|>]
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Not[
			TrueQ[
				Equal[ComputationalEngine`SolveEulerEq`updateCoeffsSol[ComputationalEngine`SolveEulerEq`model, {}, {}, MaxIterations -> 1],
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, MaxIterations -> 1]
				]
			]
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		Options[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol] = ComputationalEngine`SolveEulerEq`oldOptionsSol;
		SetOptions[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsWc, "Ewc0" -> ComputationalEngine`SolveEulerEq`ig];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Equal[
			ComputationalEngine`SolveEulerEq`updateCoeffsWc[ComputationalEngine`SolveEulerEq`model["coeffsSolution"]["wc"], ComputationalEngine`SolveEulerEq`model @ "parameters", {}],
			ComputationalEngine`SolveEulerEq`updateCoeffsWc[ComputationalEngine`SolveEulerEq`model["coeffsSolution"]["wc"],
				ComputationalEngine`SolveEulerEq`model @ "parameters", {}, "Ewc0" -> ComputationalEngine`SolveEulerEq`ig
			],
			ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "initialGuess" -> <|"Ewc" -> {ComputationalEngine`SolveEulerEq`ig}|>]
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Not[
			TrueQ[
				Equal[
					ComputationalEngine`SolveEulerEq`updateCoeffsWc[ComputationalEngine`SolveEulerEq`model["coeffsSolution"]["wc"],
						ComputationalEngine`SolveEulerEq`model @ "parameters", {}, MaxIterations -> 1
					],
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, MaxIterations -> 1]
				]
			]
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		Options[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsWc] = ComputationalEngine`SolveEulerEq`oldOptionsWc;
		ComputationalEngine`SolveEulerEq`oldOptions = Options @ ComputationalEngine`SolveEulerEq`updateCoeffs;
		ComputationalEngine`SolveEulerEq`optsUpdateCoeff = {
			{"initialGuess" -> <|"Ewc" -> {4.6}, "Epd" -> {{4.6}}|>},
			{"PrintResidualsNorm" -> True}
		};
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			Flatten[
				Map[
					Function[
						{
							SetOptions[ComputationalEngine`SolveEulerEq`updateCoeffs, #];
							ComputationalEngine`SolveEulerEq`out = Equal[ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, #], ComputationalEngine`SolveEulerEq`updateCoeffs @ ComputationalEngine`SolveEulerEq`model];
							Options[ComputationalEngine`SolveEulerEq`updateCoeffs] = ComputationalEngine`SolveEulerEq`oldOptions;
							ComputationalEngine`SolveEulerEq`out
						}
					],
					ComputationalEngine`SolveEulerEq`optsUpdateCoeff
				]
			]
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`optsBad = {{MaxIterations -> 100}, {PrecisionGoal -> $MachinePrecision}};
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			Flatten[
				Map[
					Function[
						{
							ComputationalEngine`SolveEulerEq`m = Block[
								{$MessagePrePrint = Sow, $MessageList = {}},
								Reap[
									Module[{}, SetOptions[ComputationalEngine`SolveEulerEq`updateCoeffs, #]];
									$MessageList
								]
							];
							Options[ComputationalEngine`SolveEulerEq`updateCoeffs] = ComputationalEngine`SolveEulerEq`oldOptions;
							Equal[First @ First @ ComputationalEngine`SolveEulerEq`m, HoldForm[SetOptions::optnf]]
						}
					],
					ComputationalEngine`SolveEulerEq`optsBad
				]
			]
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`optsFindRoot = {
			"FindRootOptions" -> {MaxIterations -> 1},
			"FindRootOptions" -> {AccuracyGoal -> 2}
		};
		ComputationalEngine`SolveEulerEq`oldFindRootOpts = Options @ FindRoot;
		ComputationalEngine`SolveEulerEq`withFindRootOptionDefault = Keys["FindRootOptions" /. Options[ComputationalEngine`SolveEulerEq`updateCoeffs]];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			Flatten[
				Map[
					Function[
						{
							SetOptions[ComputationalEngine`SolveEulerEq`updateCoeffs, #];
							ComputationalEngine`SolveEulerEq`out1 = Equal[ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, #], ComputationalEngine`SolveEulerEq`updateCoeffs @ ComputationalEngine`SolveEulerEq`model];
							Options[ComputationalEngine`SolveEulerEq`updateCoeffs] = ComputationalEngine`SolveEulerEq`oldOptions;
							Unprotect @ FindRoot;
							SetOptions[FindRoot, Last @ #];
							ComputationalEngine`SolveEulerEq`out2 = Equal[ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, #], ComputationalEngine`SolveEulerEq`updateCoeffs @ ComputationalEngine`SolveEulerEq`model];
							ComputationalEngine`SolveEulerEq`out2 = If[
								MemberQ[ComputationalEngine`SolveEulerEq`withFindRootOptionDefault, First @ First @ Last @ #],
								!TrueQ[ComputationalEngine`SolveEulerEq`out2],
								ComputationalEngine`SolveEulerEq`out2
							];
							Options[FindRoot] = ComputationalEngine`SolveEulerEq`oldFindRootOpts;
							Protect @ FindRoot;
							{ComputationalEngine`SolveEulerEq`out1, ComputationalEngine`SolveEulerEq`out2}
						}
					],
					ComputationalEngine`SolveEulerEq`optsFindRoot
				]
			]
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			{
				ComputationalEngine`SolveEulerEq`coeffsQWc[
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "initialGuess" -> <|"Ewc" -> {1, 8}|>]
				],
				ComputationalEngine`SolveEulerEq`coeffsQWc[
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "initialGuess" -> <|"Ewc" -> {4, 1, 8}|>]
				]
			}
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			{
				Equal[
					ComputationalEngine`SolveEulerEq`coeffsQWc[ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "initialGuess" -> <|"Ewc" -> {4.}|>]],
					ComputationalEngine`SolveEulerEq`coeffsQWc[ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "initialGuess" -> <|"Ewc" -> {4}|>]]
				],
				Equal[
					ComputationalEngine`SolveEulerEq`coeffsQWc[
						ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "initialGuess" -> <|"Ewc" -> {1., 8.}|>]
					],
					ComputationalEngine`SolveEulerEq`coeffsQWc[
						ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "initialGuess" -> <|"Ewc" -> {1, 8}|>]
					]
				],
				Equal[
					ComputationalEngine`SolveEulerEq`coeffsQWc[
						ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "initialGuess" -> <|"Ewc" -> {4., 1., 8.}|>]
					],
					ComputationalEngine`SolveEulerEq`coeffsQWc[
						ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "initialGuess" -> <|"Ewc" -> {4, 1, 8}|>]
					]
				]
			}
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`maxMaturity = 12;
		ComputationalEngine`SolveEulerEq`solBond = ComputationalEngine`SolveEulerEq`updateCoeffsBond[
			ComputationalEngine`SolveEulerEq`model["coeffsSolution"]["bond"],
			ComputationalEngine`SolveEulerEq`model @ "params", {}, ComputationalEngine`SolveEulerEq`maxMaturity, ComputationalEngine`SolveEulerEq`solWc
		];
		ComputationalEngine`SolveEulerEq`solNomBond = ComputationalEngine`SolveEulerEq`updateCoeffsBond[
			ComputationalEngine`SolveEulerEq`model["coeffsSolution"]["nombond"],
			ComputationalEngine`SolveEulerEq`model @ "params", {}, ComputationalEngine`SolveEulerEq`maxMaturity, ComputationalEngine`SolveEulerEq`solWc
		];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			{
				ComputationalEngine`SolveEulerEq`coeffsQBond[ComputationalEngine`SolveEulerEq`solBond, ComputationalEngine`SolveEulerEq`maxMaturity],
				ComputationalEngine`SolveEulerEq`coeffsQNomBond[ComputationalEngine`SolveEulerEq`solNomBond, ComputationalEngine`SolveEulerEq`maxMaturity]
			}
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`newBondParams = {FernandoDuarte`LongRunRisk`Model`Parameters`psi -> ((0.1 + FernandoDuarte`LongRunRisk`Model`Parameters`psi) /. ComputationalEngine`SolveEulerEq`model["params"])};
		ComputationalEngine`SolveEulerEq`solWcNewBondParams = ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, ComputationalEngine`SolveEulerEq`newBondParams, ComputationalEngine`SolveEulerEq`optsWc];
		ComputationalEngine`SolveEulerEq`solBondNew = ComputationalEngine`SolveEulerEq`updateCoeffsBond[
			ComputationalEngine`SolveEulerEq`model["coeffsSolution"]["bond"],
			ComputationalEngine`SolveEulerEq`model @ "params", ComputationalEngine`SolveEulerEq`newBondParams, ComputationalEngine`SolveEulerEq`maxMaturity, ComputationalEngine`SolveEulerEq`solWcNewBondParams
		];
		ComputationalEngine`SolveEulerEq`solNomBondNew = ComputationalEngine`SolveEulerEq`updateCoeffsBond[
			ComputationalEngine`SolveEulerEq`model["coeffsSolution"]["nombond"],
			ComputationalEngine`SolveEulerEq`model @ "params", ComputationalEngine`SolveEulerEq`newBondParams, ComputationalEngine`SolveEulerEq`maxMaturity, ComputationalEngine`SolveEulerEq`solWcNewBondParams
		];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			{
				ComputationalEngine`SolveEulerEq`coeffsQBond[ComputationalEngine`SolveEulerEq`solBondNew, ComputationalEngine`SolveEulerEq`maxMaturity],
				ComputationalEngine`SolveEulerEq`coeffsQNomBond[ComputationalEngine`SolveEulerEq`solNomBondNew, ComputationalEngine`SolveEulerEq`maxMaturity],
				!SameQ[ComputationalEngine`SolveEulerEq`solBond, ComputationalEngine`SolveEulerEq`solBondNew],
				!SameQ[ComputationalEngine`SolveEulerEq`solNomBond, ComputationalEngine`SolveEulerEq`solNomBondNew]
			}
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`oldMaxMaturity = ComputationalEngine`SolveEulerEq`maxMaturity;
		ComputationalEngine`SolveEulerEq`maxMaturity = 2;
		ComputationalEngine`SolveEulerEq`solBond = ComputationalEngine`SolveEulerEq`updateCoeffsBond[
			ComputationalEngine`SolveEulerEq`model["coeffsSolution"]["bond"],
			ComputationalEngine`SolveEulerEq`model @ "params", {}, ComputationalEngine`SolveEulerEq`maxMaturity, ComputationalEngine`SolveEulerEq`solWc
		];
		ComputationalEngine`SolveEulerEq`solNomBond = ComputationalEngine`SolveEulerEq`updateCoeffsBond[
			ComputationalEngine`SolveEulerEq`model["coeffsSolution"]["nombond"],
			ComputationalEngine`SolveEulerEq`model @ "params", {}, ComputationalEngine`SolveEulerEq`maxMaturity, ComputationalEngine`SolveEulerEq`solWc
		];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			{
				ComputationalEngine`SolveEulerEq`coeffsQBond[ComputationalEngine`SolveEulerEq`solBond, ComputationalEngine`SolveEulerEq`maxMaturity],
				ComputationalEngine`SolveEulerEq`coeffsQNomBond[ComputationalEngine`SolveEulerEq`solNomBond, ComputationalEngine`SolveEulerEq`maxMaturity],
				Equal[Range[0, ComputationalEngine`SolveEulerEq`maxMaturity],
					Sort[DeleteDuplicates[Cases[Keys @ ComputationalEngine`SolveEulerEq`solBond, ComputationalEngine`SolveEulerEq`x_[ComputationalEngine`SolveEulerEq`i_][ComputationalEngine`SolveEulerEq`j_] :> ComputationalEngine`SolveEulerEq`i]]]
				],
				Equal[Range[0, ComputationalEngine`SolveEulerEq`maxMaturity],
					Sort[DeleteDuplicates[Cases[Keys @ ComputationalEngine`SolveEulerEq`solNomBond, ComputationalEngine`SolveEulerEq`x_[ComputationalEngine`SolveEulerEq`i_][ComputationalEngine`SolveEulerEq`j_] :> ComputationalEngine`SolveEulerEq`i]]]
				]
			}
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`maxMaturity = ComputationalEngine`SolveEulerEq`oldMaxMaturity;
		ComputationalEngine`SolveEulerEq`solBond = ComputationalEngine`SolveEulerEq`updateCoeffsBond[
			ComputationalEngine`SolveEulerEq`model["coeffsSolution"]["bond"],
			ComputationalEngine`SolveEulerEq`model @ "params", {}, ComputationalEngine`SolveEulerEq`maxMaturity, ComputationalEngine`SolveEulerEq`solWc, "Method" -> Automatic, "Precision" -> 1
		];
		ComputationalEngine`SolveEulerEq`solNomBond = ComputationalEngine`SolveEulerEq`updateCoeffsBond[
			ComputationalEngine`SolveEulerEq`model["coeffsSolution"]["nombond"],
			ComputationalEngine`SolveEulerEq`model @ "params", {}, ComputationalEngine`SolveEulerEq`maxMaturity, ComputationalEngine`SolveEulerEq`solWc, "Method" -> Automatic, "Precision" -> 1
		];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			{
				ComputationalEngine`SolveEulerEq`coeffsQBond[ComputationalEngine`SolveEulerEq`solBond, ComputationalEngine`SolveEulerEq`maxMaturity],
				ComputationalEngine`SolveEulerEq`coeffsQNomBond[ComputationalEngine`SolveEulerEq`solNomBond, ComputationalEngine`SolveEulerEq`maxMaturity]
			}
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			{
				SameQ[
					FilterRules[
						ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "UpdateBond" -> True, "MaxMaturity" -> ComputationalEngine`SolveEulerEq`maxMaturity],
						FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb @ _
					],
					ComputationalEngine`SolveEulerEq`updateCoeffsBond[ComputationalEngine`SolveEulerEq`model["coeffsSolution"]["bond"],
						ComputationalEngine`SolveEulerEq`model @ "params", {}, ComputationalEngine`SolveEulerEq`maxMaturity, ComputationalEngine`SolveEulerEq`solWc
					]
				],
				SameQ[
					FilterRules[
						ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "UpdateNomBond" -> True, "MaxMaturity" -> ComputationalEngine`SolveEulerEq`maxMaturity],
						FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb @ _
					],
					ComputationalEngine`SolveEulerEq`updateCoeffsBond[ComputationalEngine`SolveEulerEq`model["coeffsSolution"]["nombond"],
						ComputationalEngine`SolveEulerEq`model @ "params", {}, ComputationalEngine`SolveEulerEq`maxMaturity, ComputationalEngine`SolveEulerEq`solWc
					]
				]
			}
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			{
				SameQ[
					Sort[
						FilterRules[
							ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "UpdateBonds" -> True, "MaxMaturity" -> ComputationalEngine`SolveEulerEq`maxMaturity],
							FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb[_] | FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb[_]
						]
					],
					Sort @ Join[
						ComputationalEngine`SolveEulerEq`updateCoeffsBond[ComputationalEngine`SolveEulerEq`model["coeffsSolution"]["bond"],
							ComputationalEngine`SolveEulerEq`model @ "params", {}, ComputationalEngine`SolveEulerEq`maxMaturity, ComputationalEngine`SolveEulerEq`solWc
						],
						ComputationalEngine`SolveEulerEq`updateCoeffsBond[ComputationalEngine`SolveEulerEq`model["coeffsSolution"]["nombond"],
							ComputationalEngine`SolveEulerEq`model @ "params", {}, ComputationalEngine`SolveEulerEq`maxMaturity, ComputationalEngine`SolveEulerEq`solWc
						]
					]
				]
			}
		];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`m1 = Block[
			{$MessagePrePrint = Sow, $MessageList = {}},
			Reap[
				Module[{},
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "UpdateBond" -> True, "PrintResidualsNorm" -> False];
				];
				$MessageList
			]
		];
		ComputationalEngine`SolveEulerEq`m2 = Block[
			{$MessagePrePrint = Sow, $MessageList = {}},
			Reap[
				Module[{},
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "UpdateBond" -> True, "PrintResidualsNorm" -> True];
				];
				$MessageList
			]
		];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Equal[ReleaseHold @ ComputationalEngine`SolveEulerEq`m1, {{}, {}}];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = MemberQ[ReleaseHold @ First @ ComputationalEngine`SolveEulerEq`m2, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::norm];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = NumberQ[ReleaseHold @ First @ Flatten @ Last @ ComputationalEngine`SolveEulerEq`m2];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`c1 = Not[
			TrueQ[
				CheckAbort[
					Check[
						ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "UpdateBond" -> True, "CheckResiduals" -> False],
						Abort[], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid
					],
					True
				]
			]
		];
		ComputationalEngine`SolveEulerEq`c2 = TrueQ[
			CheckAbort[
				Check[
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "UpdateBond" -> True, "CheckResiduals" -> True],
					Abort[], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid
				],
				True
			]
		];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Apply[And, {ComputationalEngine`SolveEulerEq`c1, ComputationalEngine`SolveEulerEq`c2}];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
		ComputationalEngine`SolveEulerEq`c1 = Not[
			TrueQ[
				CheckAbort[
					Check[
						ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model, "UpdateBond" -> True, "CheckResiduals" -> True, "Tol" -> 1],
						Abort[], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid
					],
					True
				]
			]
		];
		ComputationalEngine`SolveEulerEq`c2 = TrueQ[
			CheckAbort[
				Check[
					ComputationalEngine`SolveEulerEq`updateCoeffs[ComputationalEngine`SolveEulerEq`model,
						"UpdateBond" -> True, "CheckResiduals" -> True, "Tol" -> (10. ^ -20)
					],
					Abort[], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid
				],
				True
			]
		];
		ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`ind] = Apply[And, {ComputationalEngine`SolveEulerEq`c1, ComputationalEngine`SolveEulerEq`c2}];
		ComputationalEngine`SolveEulerEq`ind = ComputationalEngine`SolveEulerEq`ind + 1;
	,
		{ComputationalEngine`SolveEulerEq`model, ComputationalEngine`SolveEulerEq`mods}
	];
	ComputationalEngine`SolveEulerEq`noMissingTest = {};
	Do[
		ComputationalEngine`SolveEulerEq`testNumber = Sort[
			Cases[Keys @ SubValues @ ComputationalEngine`SolveEulerEq`outTests,
				RuleDelayed[
					Verbatim[HoldPattern][ComputationalEngine`SolveEulerEq`outTests[ComputationalEngine`SolveEulerEq`model["shortname"]][ComputationalEngine`SolveEulerEq`i_Integer]],
					ComputationalEngine`SolveEulerEq`i
				]
			]
		];
		AppendTo[ComputationalEngine`SolveEulerEq`noMissingTest, Equal[Range[0, Max @ ComputationalEngine`SolveEulerEq`testNumber], ComputationalEngine`SolveEulerEq`testNumber]];
	,
		{ComputationalEngine`SolveEulerEq`model, ComputationalEngine`SolveEulerEq`mods}
	];
	ComputationalEngine`SolveEulerEq`out = Apply[
		And,
		{
			Apply[And, ComputationalEngine`SolveEulerEq`noMissingTest],
			Apply[And, Values @ SubValues @ ComputationalEngine`SolveEulerEq`outTests]
		}
	];
	On[General::stop];
	ComputationalEngine`SolveEulerEq`out
	,
	True
	,
	{HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[checks::norm, 3.113502648927882*^-14]], 
 HoldForm[Message[checks::largeresid, 3.113502648927882*^-14, 1.*^-16]], 
 HoldForm[Message[checks::smallresid, 3.113502648927882*^-14, 1]], 
 HoldForm[Message[checks::largeresid, 3.113502648927882*^-14, 1.*^-20]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[checks::norm, 3.113502648927882*^-14]], 
 HoldForm[Message[checks::norm, 3.113502648927882*^-14]], 
 HoldForm[Message[SetOptions::optnf, HoldForm[MaxIterations], 
   HoldForm[updateCoeffs]]], HoldForm[Message[SetOptions::optnf, 
   HoldForm[PrecisionGoal], HoldForm[updateCoeffs]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[checks::norm, 3.113502648927882*^-14]], 
 HoldForm[Message[checks::norm, 2.5569089476209456*^-13]], 
 HoldForm[Message[checks::norm, 3.113502648927882*^-14]], 
 HoldForm[Message[checks::largeresid, 3.113502648927882*^-14, 1.*^-16]], 
 HoldForm[Message[checks::smallresid, 3.113502648927882*^-14, 1]], 
 HoldForm[Message[checks::smallresid, 2.5569089476209456*^-13, 1]], 
 HoldForm[Message[checks::smallresid, 3.113502648927882*^-14, 1]], 
 HoldForm[Message[checks::largeresid, 3.113502648927882*^-14, 1.*^-20]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[checks::norm, 4.383905086044507*^-14]], 
 HoldForm[Message[checks::largeresid, 4.383905086044507*^-14, 1.*^-16]], 
 HoldForm[Message[checks::smallresid, 4.383905086044507*^-14, 1]], 
 HoldForm[Message[checks::largeresid, 4.383905086044507*^-14, 1.*^-20]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[checks::norm, 4.383905086044507*^-14]], 
 HoldForm[Message[checks::norm, 4.383905086044507*^-14]], 
 HoldForm[Message[SetOptions::optnf, HoldForm[MaxIterations], 
   HoldForm[updateCoeffs]]], HoldForm[Message[SetOptions::optnf, 
   HoldForm[PrecisionGoal], HoldForm[updateCoeffs]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[checks::norm, 4.383905086044507*^-14]], 
 HoldForm[Message[checks::norm, 2.4890825068561554*^-13]], 
 HoldForm[Message[checks::norm, 4.383905086044507*^-14]], 
 HoldForm[Message[checks::largeresid, 4.383905086044507*^-14, 1.*^-16]], 
 HoldForm[Message[checks::smallresid, 4.383905086044507*^-14, 1]], 
 HoldForm[Message[checks::smallresid, 2.4890825068561554*^-13, 1]], 
 HoldForm[Message[checks::smallresid, 4.383905086044507*^-14, 1]], 
 HoldForm[Message[checks::largeresid, 4.383905086044507*^-14, 1.*^-20]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[checks::norm, 2.315142795448291*^-14]], 
 HoldForm[Message[checks::largeresid, 2.315142795448291*^-14, 1.*^-16]], 
 HoldForm[Message[checks::smallresid, 2.315142795448291*^-14, 1]], 
 HoldForm[Message[checks::largeresid, 2.315142795448291*^-14, 1.*^-20]], 
 HoldForm[Message[FindRoot::lstol, HoldForm[MachinePrecision]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[checks::norm, 2.315142795448291*^-14]], 
 HoldForm[Message[checks::norm, 2.315142795448291*^-14]], 
 HoldForm[Message[SetOptions::optnf, HoldForm[MaxIterations], 
   HoldForm[updateCoeffs]]], HoldForm[Message[SetOptions::optnf, 
   HoldForm[PrecisionGoal], HoldForm[updateCoeffs]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[checks::norm, 2.315142795448291*^-14]], 
 HoldForm[Message[checks::norm, 2.1898485160071426*^-13]], 
 HoldForm[Message[checks::norm, 2.315142795448291*^-14]], 
 HoldForm[Message[checks::largeresid, 2.315142795448291*^-14, 1.*^-16]], 
 HoldForm[Message[checks::smallresid, 2.315142795448291*^-14, 1]], 
 HoldForm[Message[checks::smallresid, 2.1898485160071426*^-13, 1]], 
 HoldForm[Message[checks::smallresid, 2.315142795448291*^-14, 1]], 
 HoldForm[Message[checks::largeresid, 2.315142795448291*^-14, 1.*^-20]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[checks::norm, 1.1383179045888502*^-12]], 
 HoldForm[Message[checks::largeresid, 1.1383179045888502*^-12, 1.*^-16]], 
 HoldForm[Message[checks::smallresid, 1.1383179045888502*^-12, 1]], 
 HoldForm[Message[checks::largeresid, 1.1383179045888502*^-12, 1.*^-20]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[100]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[100]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[100]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[100]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[100]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[100]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[100]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[100]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[100]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[100]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[100]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[checks::norm, 1.1383179045888502*^-12]], 
 HoldForm[Message[checks::norm, 1.1383179045888502*^-12]], 
 HoldForm[Message[SetOptions::optnf, HoldForm[MaxIterations], 
   HoldForm[updateCoeffs]]], HoldForm[Message[SetOptions::optnf, 
   HoldForm[PrecisionGoal], HoldForm[updateCoeffs]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[100]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[100]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[100]]], 
 HoldForm[Message[checks::norm, 1.1383179045888502*^-12]], 
 HoldForm[Message[checks::norm, 3.8764093488563845*^-12]], 
 HoldForm[Message[checks::norm, 1.1383179045888502*^-12]], 
 HoldForm[Message[checks::largeresid, 1.1383179045888502*^-12, 1.*^-16]], 
 HoldForm[Message[checks::smallresid, 1.1383179045888502*^-12, 1]], 
 HoldForm[Message[checks::smallresid, 3.8764093488563845*^-12, 1]], 
 HoldForm[Message[checks::smallresid, 1.1383179045888502*^-12, 1]], 
 HoldForm[Message[checks::largeresid, 1.1383179045888502*^-12, 1.*^-20]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[3]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[checks::norm, 2.799177515852174*^-14]], 
 HoldForm[Message[checks::largeresid, 2.799177515852174*^-14, 1.*^-16]], 
 HoldForm[Message[checks::smallresid, 2.799177515852174*^-14, 1]], 
 HoldForm[Message[checks::largeresid, 2.799177515852174*^-14, 1.*^-20]], 
 HoldForm[Message[FindRoot::lstol, HoldForm[MachinePrecision]]], 
 HoldForm[Message[FindRoot::lstol, HoldForm[MachinePrecision]]], 
 HoldForm[Message[FindRoot::lstol, HoldForm[MachinePrecision]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[checks::norm, 2.799177515852174*^-14]], 
 HoldForm[Message[checks::norm, 2.799177515852174*^-14]], 
 HoldForm[Message[SetOptions::optnf, HoldForm[MaxIterations], 
   HoldForm[updateCoeffs]]], HoldForm[Message[SetOptions::optnf, 
   HoldForm[PrecisionGoal], HoldForm[updateCoeffs]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[FindRoot::cvmit, HoldForm[1]]], 
 HoldForm[Message[checks::norm, 2.799177515852174*^-14]], 
 HoldForm[Message[checks::norm, 2.6632349341506793*^-14]], 
 HoldForm[Message[checks::norm, 2.799177515852174*^-14]], 
 HoldForm[Message[checks::largeresid, 2.799177515852174*^-14, 1.*^-16]], 
 HoldForm[Message[checks::smallresid, 2.799177515852174*^-14, 1]], 
 HoldForm[Message[checks::smallresid, 2.6632349341506793*^-14, 1]], 
 HoldForm[Message[checks::smallresid, 2.799177515852174*^-14, 1]], 
 HoldForm[Message[checks::largeresid, 2.799177515852174*^-14, 1.*^-20]]}
	,
	TestID->"SolveEulerEq_20231008-BNRV7R"
] 
End[]
EndTestSection[]
