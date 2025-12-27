BeginTestSection["CreateEulerEq"]
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`"]

FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest = False;

(* Load required modules *)
Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`";
Needs @ "FernandoDuarte`LongRunRisk`Model`EndogenousEq`";
$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"];

(* === Shared State Setup === *)
Needs @ "FernandoDuarte`LongRunRisk`";
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
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`checkBoolean[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model_] := Module[
		{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e3, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0p, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e1p, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e2p, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e3p},
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0 = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`retc @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e1 = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, 1], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e2 = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`bondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e3 = FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nombondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model, True];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0p = Flatten[
			{
				Normal @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`model @ "parameters",
				Thread[Part[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0, 2] -> 4],
				FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Ewc -> 4
			}
		];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e1p = Flatten[{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0p, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd[_] -> 4, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Epd[_] -> 4}];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e2p = Flatten[{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0p, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m_] -> 4}];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e3p = Flatten[{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0p, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m_] -> 4}];
		{
			Part[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0, 1] /. FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e0p,
			Part[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e1, 1] /. FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e1p,
			Part[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e2, 1] /. FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e2p,
			Part[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e3, 1] /. FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`e3p
		}
	];
	Apply[And, Map[BooleanQ, Flatten @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`checkBoolean @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modBY]]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251223-HZWDF2@@Tests/CreateEulerEq.wlt:404,1-435,2"
]

$ContextPath = DeleteCases[$ContextPath, "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"];

End[]
EndTestSection[]