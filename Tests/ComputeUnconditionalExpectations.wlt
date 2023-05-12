BeginTestSection["ComputeUnconditionalExpectations"] 
Begin["ComputationalEngine`"]
VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`"
	,
	$Failed
	,
	{HoldForm[Message[Get::noopen, 
   HoldForm["FernandoDuarte`LongRunRisk`ComputationalEngine`"]]], 
 HoldForm[Message[Needs::nocont, 
   HoldForm["FernandoDuarte`LongRunRisk`ComputationalEngine`"]]]}
	,
	TestID->"ComputeUnconditionalExpectations_20230512-AZNWH7"
]
VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`"]
	,
	False
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20230512-3RBH1F"
]
VerificationTest[
	!SameQ[Names @ "*uncondE", {}]
	,
	False
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20230512-ANM3IB"
] 
End[]
EndTestSection[]
