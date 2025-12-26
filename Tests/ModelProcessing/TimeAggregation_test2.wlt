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
	TestID->"TimeAggregation_20251223-WONDVI@@Tests/TimeAggregation.wlt:34,1-42,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
