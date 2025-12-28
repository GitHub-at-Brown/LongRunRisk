BeginTestSection["FakeFailingTest"]
Begin["FernandoDuarte`LongRunRisk`Tests`FakeFailingTest`"]

VerificationTest[
	1 + 1
	,
	3
	,
	{}
	,
	TestID->"FakeFailingTest-Arithmetic@@Tests/ModelDefinition/FakeFailingTest_test1.wlt:4,1-11,2"
]

VerificationTest[
	"hello"
	,
	"world"
	,
	{}
	,
	TestID->"FakeFailingTest-String@@Tests/ModelDefinition/FakeFailingTest_test1.wlt:14,1-21,2"
]

End[]
EndTestSection[]
