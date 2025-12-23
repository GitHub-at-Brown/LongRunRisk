BeginTestSection["CreateMomentsDatabase"]


VerificationTest[
	FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`longTest = False;
	True
	,
	True
	,
	{}
	,
	TestID->"CreateMomentsDatabase_20251215-PTK7JM@@Tests/CreateMomentsDatabase.wlt:4,1-13,2"
]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`"];
	True
	,
	True
	,
	{}
	,
	TestID->"CreateMomentsDatabase_20251215-8EE8O6@@Tests/CreateMomentsDatabase.wlt:16,1-26,2"
]


EndTestSection[]
