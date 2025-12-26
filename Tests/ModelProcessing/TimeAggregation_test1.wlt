BeginTestSection["TimeAggregation"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`"]

FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`longTest = False;
Off[General::stop];
	Needs @ "FernandoDuarte`LongRunRisk`Tools`TimeAggregation`";

VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"];
	True
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20251223-VG5BVR@@Tests/TimeAggregation.wlt:24,1-33,2"
]

End[]
EndTestSection[]
