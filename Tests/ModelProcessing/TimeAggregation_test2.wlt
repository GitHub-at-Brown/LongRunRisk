BeginTestSection["TimeAggregation"] 
Begin["FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`"]

FernandoDuarte`LongRunRisk`Tests`Tools`TimeAggregation`longTest = False;
Off[General::stop];
	Needs @ "FernandoDuarte`LongRunRisk`Tools`TimeAggregation`";

VerificationTest[
	!SameQ[Names @ "*growth", {}]
	,
	True
	,
	{}
	,
	TestID->"TimeAggregation_20251223-WONDVI@@Tests/ModelProcessing/TimeAggregation_test2.wlt:8,1-16,2"
]

End[]
EndTestSection[]
