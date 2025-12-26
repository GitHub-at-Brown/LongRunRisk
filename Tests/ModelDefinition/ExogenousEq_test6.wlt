BeginTestSection["ExogenousEq"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`"]

Needs @ "FernandoDuarte`LongRunRisk`Model`ExogenousEq`";

VerificationTest[
	Apply[And,
		{
			FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t, foo`t],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t, FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t],
			FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ foo`t, FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t],
			!FreeQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ foo`t, foo`t],
			!SameQ[foo`xeq @ FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t],
			!SameQ[FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`t, FernandoDuarte`LongRunRisk`Model`ExogenousEq`xeq @ foo`t]
		}
	]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20251223-0DJU31@@Tests/ExogenousEq.wlt:253,1-270,2"
]

End[]
EndTestSection[]
