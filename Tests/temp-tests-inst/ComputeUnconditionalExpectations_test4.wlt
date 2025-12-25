BeginTestSection["ComputeUnconditionalExpectations"] 
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`"]

FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`longTest = False;
Needs @ "PacletizedResourceFunctions`";
Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`"];
	Needs @ "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`";
	$ContextPath = DeleteDuplicates @ Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`"];

(* === Shared State Setup === *)
FernandoDuarte`LongRunRisk`Models = Get @ Get @ FileNameJoin @ {"FernandoDuarte/LongRunRisk", "Models.wl"};
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`msp = FernandoDuarte`LongRunRisk`Models;
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modBY = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`msp @ "BY";
FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC = FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`msp @ "NRC";

VerificationTest[
	If[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`longTest,
		{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`nameRules1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`system1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns1} = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`createSystem[1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC];
		{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`nameRules2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`system2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns2} = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`createSystem[2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC];
		{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`nameRules3, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`system3, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns3} = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`createSystem[3, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC];
		{FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`nameRules4, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`system4, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns4} = FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`createSystem[4, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`modNRC];
		FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`sol1 = Flatten @ Solve[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`system1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns1];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sol2 = Flatten @ Solve[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`system2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns2];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sol3 = Flatten @ Solve[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`system3, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns3];
		FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sol4 = Flatten @ Solve[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`system4, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns4];
		Apply[And,
			{
				Apply[And,
					{
						!SameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`nameRules1, $Failed],
						!SameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`system1, $Failed],
						!SameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns1, $Failed]
					}
				],
				Apply[And,
					{
						!SameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`nameRules2, $Failed],
						!SameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`system2, $Failed],
						!SameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns2, $Failed]
					}
				],
				Apply[And,
					{
						!SameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`nameRules3, $Failed],
						!SameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`system3, $Failed],
						!SameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns3, $Failed]
					}
				],
				Apply[And,
					{
						!SameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`nameRules4, $Failed],
						!SameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`system4, $Failed],
						!SameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns4, $Failed]
					}
				],
				Apply[And,
					{
						!SameQ[FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`sol1, {}],
						!SameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sol2, {}],
						!SameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sol3, {}],
						!SameQ[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sol4, {}]
					}
				],
				Apply[And,
					{
						Apply[MatchQ, Intersection[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns3] /. {FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`sol1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sol3}],
						Apply[MatchQ, Intersection[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns3] /. {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sol2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sol3}],
						Apply[MatchQ, Intersection[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns4] /. {FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`sol1, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sol4}],
						Apply[MatchQ, Intersection[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns4] /. {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sol2, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sol4}],
						Apply[MatchQ, Intersection[FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns3, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`unknowns4] /. {FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sol3, FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`sol4}]
					}
				]
			}
		],
		True
	]
	,
	True
	,
	{}
	,
	TestID->"ComputeUnconditionalExpectations_20251223-XP9SMZ@@Tests/ComputeUnconditionalExpectations.wlt:67,1-134,2"
]

$ContextPath = Select[$ContextPath,  !(StringContainsQ[#1, "FernandoDuarte`LongRunRisk`"] && StringEndsQ[#1, "Private`"]) & ];

End[]
EndTestSection[]
