BeginTestSection["PacletizeResources"]


VerificationTest[
	Quiet[
		pacletBaseDir = DirectoryName[NotebookDirectory[], 1];
		PacletDirectoryLoad @ pacletBaseDir;
		Needs @ "FernandoDuarte`LongRunRisk`";
		out = SameQ[PacletFind @ "MaTeX*", {}];
	];
	out
	,
	False
	,
	{}
	,
	TestID->"PacletizeResources_20230404-4Z5J55"
]


VerificationTest[
	Quiet[
		pacletBaseDir = DirectoryName[NotebookDirectory[], 1];
		PacletDirectoryLoad @ pacletBaseDir;
		Needs @ "FernandoDuarte`LongRunRisk`";
		out = MemberQ[$ContextPath, "MaTeX`"];
	];
	out
	,
	True
	,
	{}
	,
	TestID->"PacletizeResources_20230404-F162K4"
]


VerificationTest[
	Quiet[
		pacletBaseDir = DirectoryName[NotebookDirectory[], 1];
		PacletDirectoryLoad @ pacletBaseDir;
		Needs @ "FernandoDuarte`LongRunRisk`";
		out = MemberQ[$Packages, "MaTeX`"];
	];
	out
	,
	True
	,
	{}
	,
	TestID->"PacletizeResources_20230404-I89ETN"
]


EndTestSection[]
