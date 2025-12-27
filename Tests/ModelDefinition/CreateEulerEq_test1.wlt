BeginTestSection["CreateEulerEq"] 
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`"]

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
	TestID->"CreateEulerEq_20251223-CKEXB0@@Tests/ModelDefinition/CreateEulerEq_test1.wlt:6,1-19,2"
]

End[]
EndTestSection[]
