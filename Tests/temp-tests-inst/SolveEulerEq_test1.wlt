BeginTestSection["SolveEulerEq"] 
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`"]

FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`longTest = False;
Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`"];

VerificationTest[
	Off[General::stop];
	If[!FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`longTest, Off[FindRoot::cvmit]];
	FernandoDuarte`LongRunRisk`Models = Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`msp = FernandoDuarte`LongRunRisk`Models;
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modBY = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`msp @ "BY";
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modBKY = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`msp @ "BKY";
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modNRC = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`msp @ "NRC";
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modDES = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`msp @ "DES";
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modNRCStochVol = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`msp @ "NRCStochVol";
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`mods = If[
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`longTest,
		{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modBY, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modBKY, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modNRC, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modDES, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modNRCStochVol},
		{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modBKY, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`modDES}
	];
	FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs;
	FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol;
	FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels;
	FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond;
	ClearAll @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests;
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solIn_,FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffName_,FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numStateVars_,Optional[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numAssets_, 0],Optional[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`bond_, 0]] := Module[
		{FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solIn},
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol = Which[
			AssociationQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol],
				Normal @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol,
			True,
				FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol
		];
		If[!ListQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol], Return[False]];
		Apply[And,
			{
				If[Equal[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numAssets, 0],
					SameQ[Sort[Cases[Map[Keys, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffName[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i_Integer] :> FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i]],
						Range[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numStateVars + 1] - 1
					],
					SameQ[
						Sort[
							Tuples[{Range[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numAssets] - FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`bond, Range[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numStateVars + 1] - 1}]
						],
						Sort[
							Cases[Map[Keys, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffName[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i_Integer][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`j_Integer] :> {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`j}]
						]
					]
				],
				Apply[And,
					Map[MatchQ[#, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffName]&,
						Cases[Map[Keys, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`var_[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i_Integer][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`j_Integer] :> FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`var]
					]
				],
				Apply[And,
					Map[SameQ[#, Context @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffName]&,
						Cases[Map[Keys, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`var_[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i_Integer][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`j_Integer] :> Context[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`var]]
					]
				],
				Apply[And, Map[NumberQ, Map[Values, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`sol]]]
			}
		]
	];
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`firstASol[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`res_] := If[
		And[ListQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`res],
			UnsameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`res, {}],
			AssociationQ[First @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`res],
			KeyExistsQ[First @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`res, "A"]
		],
		First @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`res, False
	];
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`wcRulesFirst[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`res_] := Module[
		{FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`a = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`firstASol @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`res},
		If[SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`a, False], False, Normal @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`a @ "A"]
	];
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`pdRulesFirstBundle[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`res_, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`numStocks_] := Module[
		{FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`a = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`firstASol @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`res, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`stocks},
		If[SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`a, False], Return[False]];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`stocks = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`a @ "Stocks";
		If[Or[!AssociationQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`stocks], SameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`stocks, <||>]], Return[{}]];
		Flatten[
			Table[
				If[
					And[KeyExistsQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`stocks, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`j],
						ListQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`stocks @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`j],
						UnsameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`stocks @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`j, {}]
					],
					Normal[Part[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`stocks @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`j, 1, "B"]],
					{}
				],
				{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`j, 1, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`numStocks}
			]
		]
	];
	Do[
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = 0;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numStateVars = Length @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`t];
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`numStocks = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel @ "numStocks";
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQWcRules[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solRules_] := FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solRules, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numStateVars];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQPdRules[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solRules_] := FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solRules, Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numStateVars, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`numStocks];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQBondRules[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solRules_, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity_] := FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solRules, Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numStateVars, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity + 1, 1];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQNomBondRules[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solRules_, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity_] := FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solRules, Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`numStateVars, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity + 1, 1];
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`savedKernels = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`optsWc = {"MaxIterations" -> 100};
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`resWc = Quiet @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`optsWc];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`resWcSol = Quiet @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`savedKernels, {}, {}, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`optsWc];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			{
				And[ListQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`resWc], UnsameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`resWc, {}]],
				And[ListQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`resWcSol], UnsameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`resWcSol, {}]],
				UnsameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`wcRulesFirst @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`resWc, False],
				UnsameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`wcRulesFirst @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`resWcSol, False],
				SameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`wcRulesFirst @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`resWc, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`wcRulesFirst @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`resWcSol],
				FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQWcRules @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`wcRulesFirst @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`resWc
			}
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`Ewc0 = 4.6;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`resNoPd = Quiet[
			FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel,
				"UpdatePd" -> False,
				"initialGuess" -> <|"Ewc" -> {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`Ewc0}, "Epd" -> {{5.5}}|>
			]
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQWcRules @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`wcRulesFirst @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`resNoPd;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`resWcPd = Quiet[
			FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel,
				"UpdatePd" -> True,
				"initialGuess" -> <|"Ewc" -> {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`Ewc0}, "Epd" -> {{5.5}}|>
			]
		];
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`coeffsWc = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`wcRulesFirst @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`resWcPd;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsPd = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`pdRulesFirstBundle[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`resWcPd, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`numStocks];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQWcRules @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`coeffsWc;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQPdRules @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsPd;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			{
				FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQWcRules[
					FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`wcRulesFirst[
						Quiet[
							FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel, "initialGuess" -> <|"Ewc" -> {1, 8}|>]
						]
					]
				],
				FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQWcRules[
					FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`wcRulesFirst[
						Quiet[
							FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel, "initialGuess" -> <|"Ewc" -> {4, 1, 8}|>]
						]
					]
				]
			}
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity = 12;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`wcCoeffSets = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`resWc[[All, "A"]];
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solBond = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel["coeffsSolution"]["bond"],
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel @ "params", {}, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`wcCoeffSets
		];
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solNomBond = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel["coeffsSolution"]["nombond"],
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel @ "params", {}, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`wcCoeffSets
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			{
				And[ListQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solBond], UnsameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solBond, {}]],
				And[ListQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solNomBond], UnsameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solNomBond, {}]],
				Apply[And,
					Map[Function @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQBondRules[Normal @ #, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity], FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solBond]
				],
				Apply[And,
					Map[Function @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQNomBondRules[Normal @ #, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity],
						FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solNomBond
					]
				]
			}
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`newBondParams = {FernandoDuarte`LongRunRisk`Model`Parameters`psi -> (0.1 + (FernandoDuarte`LongRunRisk`Model`Parameters`psi /. FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel["params"]))};
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`resWcNewBondParams = Quiet @ FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel, {}, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`newBondParams, {}, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`optsWc];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`wcCoeffSetsNew = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`resWcNewBondParams[[All, "A"]];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solBondNew = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel["coeffsSolution"]["bond"],
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel @ "params", FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`newBondParams, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`wcCoeffSetsNew
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solNomBondNew = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel["coeffsSolution"]["nombond"],
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel @ "params", FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`newBondParams, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`wcCoeffSetsNew
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			{
				Apply[And,
					Map[Function @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQBondRules[Normal @ #, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solBondNew
					]
				],
				Apply[And,
					Map[Function @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQNomBondRules[Normal @ #, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solNomBondNew
					]
				],
				!SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solBond, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solBondNew],
				!SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`solNomBond, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solNomBondNew]
			}
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`oldMaxMaturity = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity;
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity = 2;
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solBond2 = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel["coeffsSolution"]["bond"],
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel @ "params", {}, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`wcCoeffSets
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solNomBond2 = FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond[
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel["coeffsSolution"]["nombond"],
			FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel @ "params", {}, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`wcCoeffSets
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind] = Apply[
			And,
			{
				Apply[And,
					Map[Function @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQBondRules[Normal @ #, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solBond2
					]
				],
				Apply[And,
					Map[Function @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`coeffsQNomBondRules[Normal @ #, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solNomBond2
					]
				],
				Apply[And,
					Map[
						Function[
							SameQ[
								Range[0, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity],
								Sort[DeleteDuplicates[Cases[Keys @ #, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`x_[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i_][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`j_] :> FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i]]]
							]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solBond2
					]
				],
				Apply[And,
					Map[
						Function[
							SameQ[
								Range[0, FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity],
								Sort[DeleteDuplicates[Cases[Keys @ #, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`x_[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i_][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`j_] :> FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i]]]
							]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`solNomBond2
					]
				]
			}
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`ind + 1;
		FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`maxMaturity = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`oldMaxMaturity;
	,
		{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`mods}
	];
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`noMissingTest = {};
	Do[
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`testNumber = Sort[
			Cases[Keys @ SubValues @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests,
				RuleDelayed[
					Verbatim[HoldPattern][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`outTests[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel["shortname"]][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i_Integer]],
					FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`i
				]
			]
		];
		AppendTo[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`noMissingTest, Equal[Range[0, Max @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`testNumber], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`testNumber]];
	,
		{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`thisModel, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`mods}
	];
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`out = Apply[
		And,
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
	TestID->"SolveEulerEq_20251223-R6ABWE@@Tests/SolveEulerEq.wlt:24,1-315,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
