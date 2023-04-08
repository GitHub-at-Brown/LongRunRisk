BeginTestSection["ExogenousEq"]


VerificationTest[
	Needs @ "FernandoDuarte`LongRunRisk`"
	,
	Null
	,
	{}
	,
	TestID->"ExogenousEq_20230407-TXVE04"
]


VerificationTest[
	MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`"]
	,
	True
	,
	{}
	,
	TestID->"ExogenousEq_20230407-QWWQ1Z"
]


VerificationTest[
	{
		(FernandoDuarte`LongRunRisk`eps[\[FormalC]][t] * FernandoDuarte`LongRunRisk`eps[\[FormalD]][t, i]) /. FernandoDuarte`LongRunRisk`rulesE[t],
		(FernandoDuarte`LongRunRisk`eps[\[FormalC]][t] * FernandoDuarte`LongRunRisk`eps[\[FormalD]][t, 1]) /. FernandoDuarte`LongRunRisk`rulesE[t],
		ReplaceAll[FernandoDuarte`LongRunRisk`eps[\[FormalC]][t + 1] * FernandoDuarte`LongRunRisk`eps[\[FormalD]][t + 1, j],
			FernandoDuarte`LongRunRisk`rulesE[t + 1]
		],
		(FernandoDuarte`LongRunRisk`eps[\[FormalC]][t] * FernandoDuarte`LongRunRisk`eps[\[FormalD]][t, i]) /. FernandoDuarte`LongRunRisk`rulesE[t + 1],
		(FernandoDuarte`LongRunRisk`eps[\[FormalX]][t] * FernandoDuarte`LongRunRisk`eps[\[FormalD]][t, i]) /. FernandoDuarte`LongRunRisk`rulesE[t],
		(FernandoDuarte`LongRunRisk`eps[\[FormalC]][t + 1] * FernandoDuarte`LongRunRisk`eps[\[FormalD]][t, i]) /. FernandoDuarte`LongRunRisk`rulesE[t],
		(FernandoDuarte`LongRunRisk`eps[\[FormalC]][t] * FernandoDuarte`LongRunRisk`eps[\[FormalD]][t + 1, i]) /. FernandoDuarte`LongRunRisk`rulesE[t],
		(FernandoDuarte`LongRunRisk`eps[FernandoDuarte`LongRunRisk`x][t] * FernandoDuarte`LongRunRisk`eps[\[FormalD]][t, i]) /. FernandoDuarte`LongRunRisk`rulesE[t],
		(FernandoDuarte`LongRunRisk`eps[\[FormalX]][t] * FernandoDuarte`LongRunRisk`eps[d][t, i]) /. FernandoDuarte`LongRunRisk`rulesE[t],
		(FernandoDuarte`LongRunRisk`eps[c][t] * FernandoDuarte`LongRunRisk`eps[d][t, i]) /. FernandoDuarte`LongRunRisk`rulesE[t]
	}
	,
	{
		FernandoDuarte`LongRunRisk`taugd @ i, FernandoDuarte`LongRunRisk`taugd @ 1, FernandoDuarte`LongRunRisk`taugd @ j, FernandoDuarte`LongRunRisk`eps[\[FormalC]][t] * FernandoDuarte`LongRunRisk`eps[\[FormalD]][t, i],
		0, 0, 0, 0, 0, FernandoDuarte`LongRunRisk`eps[c][t] * FernandoDuarte`LongRunRisk`eps[d][t, i]
	}
	,
	{}
	,
	TestID->"ExogenousEq_20230407-Z7HVGL"
]


VerificationTest[
	{
		FernandoDuarte`LongRunRisk`eps[\[FormalX]][t] /. FernandoDuarte`LongRunRisk`rulesE[t],
		FernandoDuarte`LongRunRisk`eps[\[FormalX]][t + h] /. FernandoDuarte`LongRunRisk`rulesE[t + h],
		FernandoDuarte`LongRunRisk`eps[\[FormalX]][t + 1] /. FernandoDuarte`LongRunRisk`rulesE[t + 1],
		FernandoDuarte`LongRunRisk`eps[FernandoDuarte`LongRunRisk`x][t] /. FernandoDuarte`LongRunRisk`rulesE[t],
		FernandoDuarte`LongRunRisk`eps[FernandoDuarte`LongRunRisk`x][t + h] /. FernandoDuarte`LongRunRisk`rulesE[t + h],
		FernandoDuarte`LongRunRisk`eps[FernandoDuarte`LongRunRisk`x][t + 1] /. FernandoDuarte`LongRunRisk`rulesE[t + 1]
	}
	,
	{
		0, 0, 0, FernandoDuarte`LongRunRisk`eps[FernandoDuarte`LongRunRisk`x][t],
		FernandoDuarte`LongRunRisk`eps[FernandoDuarte`LongRunRisk`x][h + t],
		FernandoDuarte`LongRunRisk`eps[FernandoDuarte`LongRunRisk`x][1 + t]
	}
	,
	{}
	,
	TestID->"ExogenousEq_20230407-R1F7RY"
]


VerificationTest[
	{
		FernandoDuarte`LongRunRisk`eps[\[FormalD]][t, i] /. FernandoDuarte`LongRunRisk`rulesE[t],
		FernandoDuarte`LongRunRisk`eps[\[FormalD]][t, 1] /. FernandoDuarte`LongRunRisk`rulesE[t],
		FernandoDuarte`LongRunRisk`eps[\[FormalD]][t + 1, i] /. FernandoDuarte`LongRunRisk`rulesE[t + 1],
		FernandoDuarte`LongRunRisk`eps[\[FormalD]][t, \[FormalI]] /. FernandoDuarte`LongRunRisk`rulesE[t],
		FernandoDuarte`LongRunRisk`eps[\[FormalD]][t + h, 1] /. FernandoDuarte`LongRunRisk`rulesE[t + h],
		FernandoDuarte`LongRunRisk`eps[\[FormalX]][t + 1, i] /. FernandoDuarte`LongRunRisk`rulesE[t + 1]
	}
	,
	{0, 0, 0, 0, 0, FernandoDuarte`LongRunRisk`eps[\[FormalX]][1 + t, i]}
	,
	{}
	,
	TestID->"ExogenousEq_20230407-T3VY95"
]


VerificationTest[
	{
		(FernandoDuarte`LongRunRisk`eps[\[FormalX]][t] ^ 1) /. FernandoDuarte`LongRunRisk`rulesE[t],
		(FernandoDuarte`LongRunRisk`eps[\[FormalX]][t + h] ^ 2) /. FernandoDuarte`LongRunRisk`rulesE[t + h],
		(FernandoDuarte`LongRunRisk`eps[\[FormalX]][t + 1] ^ 3) /. FernandoDuarte`LongRunRisk`rulesE[t + 1],
		(FernandoDuarte`LongRunRisk`eps[\[FormalX]][t + 1] ^ 4) /. FernandoDuarte`LongRunRisk`rulesE[t + 1],
		(FernandoDuarte`LongRunRisk`eps[FernandoDuarte`LongRunRisk`x][t] ^ 3) /. FernandoDuarte`LongRunRisk`rulesE[t]
	}
	,
	{0, 1, 0, 3, FernandoDuarte`LongRunRisk`eps[FernandoDuarte`LongRunRisk`x][t] ^ 3}
	,
	{}
	,
	TestID->"ExogenousEq_20230407-3C2RJO"
]


VerificationTest[
	{
		ReplaceAll[(FernandoDuarte`LongRunRisk`eps[\[FormalX]][t + h] ^ 1) * FernandoDuarte`LongRunRisk`eps[\[FormalX]][t + h] ^ 2,
			FernandoDuarte`LongRunRisk`rulesE[t + h]
		],
		ReplaceAll[(FernandoDuarte`LongRunRisk`eps[\[FormalX]][t + h] ^ 2) * FernandoDuarte`LongRunRisk`eps[\[FormalX]][t + h] ^ 2,
			FernandoDuarte`LongRunRisk`rulesE[t + h]
		],
		ReplaceAll[(FernandoDuarte`LongRunRisk`eps[\[FormalX]][t + h] ^ 1) * FernandoDuarte`LongRunRisk`eps[\[FormalC]][t + h] ^ 2,
			FernandoDuarte`LongRunRisk`rulesE[t + h]
		],
		ReplaceAll[(FernandoDuarte`LongRunRisk`eps[\[FormalX]][t + h] ^ 2) * FernandoDuarte`LongRunRisk`eps[\[FormalC]][t + h] ^ 2,
			FernandoDuarte`LongRunRisk`rulesE[t + h]
		],
		ReplaceAll[(FernandoDuarte`LongRunRisk`eps[\[FormalX]][t + h] ^ 2) * FernandoDuarte`LongRunRisk`eps[\[FormalC]][t + h] ^ 3,
			FernandoDuarte`LongRunRisk`rulesE[t + h]
		]
	}
	,
	{0, 3, 0, 1, 0}
	,
	{}
	,
	TestID->"ExogenousEq_20230407-GRLRO5"
]


VerificationTest[
	{
		ReplaceAll[(FernandoDuarte`LongRunRisk`eps[\[FormalX]][t + 1] ^ 1) * FernandoDuarte`LongRunRisk`eps[\[FormalX]][t + 2] ^ 2,
			FernandoDuarte`LongRunRisk`rulesE[t + 1]
		],
		ReplaceAll[(FernandoDuarte`LongRunRisk`eps[\[FormalX]][t + 1] ^ 1) * FernandoDuarte`LongRunRisk`eps[\[FormalX]][t + 2] ^ 2,
			FernandoDuarte`LongRunRisk`rulesE[t + 2]
		],
		ReplaceAll[(FernandoDuarte`LongRunRisk`eps[\[FormalX]][t + 1] ^ 1) * FernandoDuarte`LongRunRisk`eps[\[FormalC]][t] ^ 2,
			FernandoDuarte`LongRunRisk`rulesE @ t
		],
		ReplaceAll[(FernandoDuarte`LongRunRisk`eps[\[FormalX]][t + 2] ^ 2) * FernandoDuarte`LongRunRisk`eps[\[FormalC]][t + 2] ^ 2,
			FernandoDuarte`LongRunRisk`rulesE[t + 1]
		]
	}
	,
	{
		0,
		FernandoDuarte`LongRunRisk`eps[\[FormalX]][1 + t],
		FernandoDuarte`LongRunRisk`eps[\[FormalX]][1 + t],
		(FernandoDuarte`LongRunRisk`eps[\[FormalC]][2 + t] ^ 2) * FernandoDuarte`LongRunRisk`eps[\[FormalX]][2 + t] ^ 2
	}
	,
	{}
	,
	TestID->"ExogenousEq_20230407-M928SH"
]


EndTestSection[]
