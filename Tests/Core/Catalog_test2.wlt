BeginTestSection["Catalog"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`Catalog`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`Catalog`";

VerificationTest[
	Apply[And, Map[StringQ, Keys @ FernandoDuarte`LongRunRisk`Model`Catalog`models]]
	,
	True
	,
	{}
	,
	TestID->"Catalog_20251223-ZQHUJ0@@Tests/Core/Catalog_test2.wlt:6,1-14,2"
]

End[]
EndTestSection[]
