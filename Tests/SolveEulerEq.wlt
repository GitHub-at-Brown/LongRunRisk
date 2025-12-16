BeginTestSection["SolveEulerEq"]


VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`SolveEulerEq`longTest = False;
	True
	,
	True
	,
	{}
	,
	TestID->"SolveEulerEq_20251215-PSLMDL@@Tests/SolveEulerEq.wlt:4,1-13,2"
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
	TestID->"SolveEulerEq_20251215-H57OCV@@Tests/SolveEulerEq.wlt:16,1-26,2"
]


EndTestSection[]
