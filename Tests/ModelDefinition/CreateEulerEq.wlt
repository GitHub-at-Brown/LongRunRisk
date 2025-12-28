BeginTestSection["CreateEulerEq Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`"]

(* --- merged from: CreateEulerEq_test1.wlt --- *)
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest = False;

VerificationTest[
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`msp = FernandoDuarte`LongRunRisk`Models;
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modBY = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`msp @ "BY";
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modNRC = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`msp @ "NRC";
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modDES = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`msp @ "DES";
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods = {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modBY, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modNRC, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modDES};
	True
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251223-CKEXB0@@Tests/ModelDefinition/CreateEulerEq.wlt:7,1-20,2"
]

(* --- merged from: CreateEulerEq_test2.wlt --- *)
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest = False;

(* === Shared State Setup === *)
Needs @ "FernandoDuarte`LongRunRisk`";
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`msp = FernandoDuarte`LongRunRisk`Models;
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modBY = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`msp @ "BY";
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modNRC = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`msp @ "NRC";
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modDES = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`msp @ "DES";
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods = {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modBY, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modNRC, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modDES};

VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`";
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
	True
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251223-UJVGYV@@Tests/ModelDefinition/CreateEulerEq.wlt:33,1-60,2"
]

(* --- merged from: CreateEulerEq_test3.wlt --- *)
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest = False;

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
	!SameQ[Names @ "*eulereq", {}]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251223-TKMWO2@@Tests/ModelDefinition/CreateEulerEq.wlt:92,1-100,2"
]

(* --- merged from: CreateEulerEq_test4.wlt --- *)
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest = False;

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
	Apply[And,
		Flatten[
			{
				Map[
					Function[
						Equal[
							Max[
								Keys[
									CoefficientRules[
										#,
										DeleteDuplicates[
											Cases[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modBY["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t], Blank[Symbol][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t] ^ Optional[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`p_], Infinity]
										]
									]
								]
							],
							1
						]
					],
					FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ee @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modBY
				],
				Map[
					Function[
						Equal[
							Max[
								Keys[
									CoefficientRules[
										#,
										DeleteDuplicates[
											Cases[
												FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modNRC["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t],
												Blank[Symbol][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t] ^ Optional[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`p_],
												Infinity
											]
										]
									]
								]
							],
							1
						]
					],
					FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ee @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modNRC
				],
				Map[
					Function[
						Equal[
							Max[
								Keys[
									CoefficientRules[
										#,
										DeleteDuplicates[
											Cases[
												FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modDES["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t],
												Blank[Symbol][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t] ^ Optional[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`p_],
												Infinity
											]
										]
									]
								]
							],
							1
						]
					],
					FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ee @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`modDES
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251223-4AUI3V@@Tests/ModelDefinition/CreateEulerEq.wlt:132,1-207,2"
]

(* --- merged from: CreateEulerEq_test5.wlt --- *)
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest = False;

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
	Apply[And,
		Flatten[
			{
				Table[
					Map[
						Function[
							Not[
								FreeQ[Part[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`eeAll[[1;;, 1]], n], #]
							]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffWcAll[[n]]
					],
					{n, 1, Length @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods}
				],
				Table[
					Map[
						Function[
							Not[
								FreeQ[Part[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`eeAll[[1;;, 2]], n], #]
							]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffPdAll[[n]]
					],
					{n, 1, Length @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods}
				],
				Table[
					Map[
						Function[
							Not[
								FreeQ[Part[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`eeAll[[1;;, 3]], n], #]
							]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffBondAll[[n]]
					],
					{n, 1, Length @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods}
				],
				Table[
					Map[
						Function[
							Not[
								FreeQ[Part[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`eeAll[[1;;, 4]], n], #]
							]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`coeffNomBondAll[[n]]
					],
					{n, 1, Length @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods}
				]
			}
		]
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251223-WC774K@@Tests/ModelDefinition/CreateEulerEq.wlt:239,1-296,2"
]

(* --- merged from: CreateEulerEq_test6.wlt --- *)
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest = False;

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
	If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest,
		Apply[And,
			Flatten[
				{
					Map[
						Function[
							SameQ[
								Count[
									Cases[
										First @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`retc @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, #],
										Equal[0, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`x__] :> True
									],
									True
								],
								Length[#["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t]] + 1
							]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
					],
					Map[
						Function[
							SameQ[
								Count[
									Cases[
										First @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`j], #],
										Equal[0, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`x__] :> True
									],
									True
								],
								Length[#["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t]] + 1
							]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
					],
					Map[
						Function[
							SameQ[
								Count[
									Cases[
										First @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`bondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #],
										Equal[0, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`x__] :> True
									],
									True
								],
								Length[#["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t]] + 1
							]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
					],
					Map[
						Function[
							SameQ[
								Count[
									Cases[
										First @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nombondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #, True],
										Equal[0, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`x__] :> True
									],
									True
								],
								Length[#["stateVars"][FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t]] + 1
							]
						],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
					]
				}
			]
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251223-IPFAFE@@Tests/ModelDefinition/CreateEulerEq.wlt:328,1-404,2"
]

(* --- merged from: CreateEulerEq_test7.wlt --- *)
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest = False;

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
	If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest,
		Apply[And,
			Flatten[
				{
					Map[Function @ FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`retc @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, #], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods],
					Map[
						Function @ FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`j], #], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
					],
					Map[
						Function @ FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`bondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
					],
					Map[
						Function @ FreeQ[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nombondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #, True], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t],
						FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
					]
				}
			]
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251223-3EC0IX@@Tests/ModelDefinition/CreateEulerEq.wlt:436,1-465,2"
]

(* --- merged from: CreateEulerEq_test8.wlt --- *)
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest = False;

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
	If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest,
		Apply[And,
			Flatten[
				{
					SameQ[Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`retc[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t], #]&, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods],
						Map[Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`retc[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1], #]], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods]
					],
					SameQ[Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`j], #]&, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods],
						Map[Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`j], #]], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods]
					],
					SameQ[Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`bondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #]&, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods],
						Map[Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`bondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #]], FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods]
					],
					SameQ[
						Map[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nombondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #, True]&, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods],
						Map[
							Function[FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nombondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t + 1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #, True]],
							FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
						]
					]
				}
			]
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251223-6Y9I2S@@Tests/ModelDefinition/CreateEulerEq.wlt:497,1-529,2"
]

(* --- merged from: CreateEulerEq_test9.wlt --- *)
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest = False;

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
	If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`longTest,
		SameQ[{"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"},
			DeleteDuplicates[
				Flatten[
					{
						Map[Function @ Context @ Evaluate @ #,
							Flatten[
								Map[
									Function[
										Part[Flatten @ Rest @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`retc @ FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, #], 1;;, 0]
									],
									FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
								]
							]
						],
						Map[Function @ Context @ Evaluate @ #,
							Flatten[
								Map[
									Function[
										Part[Flatten @ Rest @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`ret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`j], #], 1;;, 0, 0]
									],
									FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
								]
							]
						],
						Map[Function @ Context @ Evaluate @ #,
							Flatten[
								Map[
									Function[
										Part[
											Flatten @ Rest @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`bondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #],
											1;;, 0, 0
										]
									],
									FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
								]
							]
						],
						Map[Function @ Context @ Evaluate @ #,
							Flatten[
								Map[
									Function[
										Part[
											Flatten @ Rest @ FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`nombondret[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`t, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`m], #, True],
											1;;, 0, 0
										]
									],
									FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`mods
								]
							]
						]
					}
				]
			]
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"CreateEulerEq_20251223-UIA984@@Tests/ModelDefinition/CreateEulerEq.wlt:561,1-625,2"
]

(* --- merged from: CreateEulerEq_test10.wlt --- *)
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
	TestID->"CreateEulerEq_20251223-HZWDF2@@Tests/ModelDefinition/CreateEulerEq.wlt:662,1-693,2"
]

$ContextPath = DeleteCases[$ContextPath, "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"];

End[]
EndTestSection[]
