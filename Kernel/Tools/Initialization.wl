If[
	{} === PacletFind["PacletizedResourceFunctions"],
	PacletInstall[
		File[
			FindFile["FernandoDuarte/LongRunRisk/PacletizedResourceFunctions.paclet"]
		],
		KeepExistingVersion -> False,
		ForceVersionInstall -> True
	]
];

(* Warm up DefinitionData to avoid Symbol::symname and cloud auth prompts. *)
Quiet[
	Block[{$AllowInternet = False},
		Needs["PacletizedResourceFunctions`"];
		Module[{warmup},
			warmup = Null;
			PacletizedResourceFunctions`DefinitionData[warmup];
		]
	],
	URLSubmit::offline
];



(* ::Subsection:: *)
(*MaTeX*)


(* Install and load MaTeX *)
If[
	{} === PacletFind["MaTeX"],
	(* Not installed: install via MaTeXInstall, which also loads MaTeX *)
	If[
		{} === PacletFind["MaTeXInstall" -> "1.0.0"],
		PacletInstall[
			File[
				FindFile["FernandoDuarte/LongRunRisk/MaTeXInstall-1.0.0.paclet"]
			],
			KeepExistingVersion -> True,
			ForceVersionInstall -> True
		]
	];
	Needs["MaTeXInstall`"];
	MaTeXInstall`MaTeXInstall[],
	(* Already installed: just load it *)
	Needs["MaTeX`"]
];

(* Configure MaTeX if auto-detection failed for pdfLaTeX or Ghostscript *)
initializeDependencies::pdflatex = "pdfLaTeX executable not found at `1`. Please configure MaTeX manually.";
initializeDependencies::gs = "Ghostscript executable not found at `1`. Please configure MaTeX manually.";

With[{currentConfig = Quiet @ MaTeX`ConfigureMaTeX[]},
	Module[{pdflatexPath, gsPath, needsPdflatex, needsGs, configChanges, validConfig},
		(* Validate that currentConfig is a proper list of rules or Association *)
		validConfig = MatchQ[currentConfig, {(_Rule | _RuleDelayed) ...}] || AssociationQ[currentConfig];
		needsPdflatex = If[validConfig, Lookup[currentConfig, "pdfLaTeX", None] === None, True];
		needsGs = If[validConfig, Lookup[currentConfig, "Ghostscript", None] === None, True];

		If[needsPdflatex || needsGs,
			(* Determine fallback paths based on platform.
			   Note: CI branch is checked first intentionally — on GitHub Actions macOS runners,
			   we want to use CI-specific paths rather than standard macOS paths. *)
			{pdflatexPath, gsPath} = Which[
				StringMatchQ[$SystemID, "Linux*"] && MemberQ[{"true", "True", "1"}, Environment["CI"]],
				{"/github/home/bin/pdflatex", None},
				StringMatchQ[$SystemID, "MacOSX*"],
				{
					SelectFirst[{"/opt/homebrew/bin/pdflatex", "/usr/local/bin/pdflatex"}, FileExistsQ, None],
					SelectFirst[{"/opt/homebrew/bin/gs", "/usr/local/bin/gs"}, FileExistsQ, None]
				},
				True,
				{None, None}
			];

			(* Build config changes only for what's needed and exists *)
			configChanges = {};
			If[needsPdflatex && pdflatexPath =!= None,
				If[FileExistsQ[pdflatexPath],
					AppendTo[configChanges, "pdfLaTeX" -> pdflatexPath],
					Message[initializeDependencies::pdflatex, pdflatexPath]
				]
			];
			If[needsGs && gsPath =!= None,
				If[FileExistsQ[gsPath],
					AppendTo[configChanges, "Ghostscript" -> gsPath],
					Message[initializeDependencies::gs, gsPath]
				]
			];

			(* Apply config if we have changes; redirect $Output to suppress MaTeX's Print *)
			If[configChanges =!= {},
				Block[{$Output = {}}, MaTeX`ConfigureMaTeX @@ configChanges]
			]
		]
	]
];

Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];
Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
