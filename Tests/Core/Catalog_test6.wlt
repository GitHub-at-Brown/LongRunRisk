BeginTestSection["Catalog"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`Catalog`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

VerificationTest[
	SameQ[FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"]["stateVars"], {FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`x @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sx @ FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t}]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20251223-RMOIJN@@Tests/Catalog.wlt:87,1-95,2"
]

End[]
EndTestSection[]
