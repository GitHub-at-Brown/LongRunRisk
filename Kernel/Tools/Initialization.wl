(* ::Package:: *)

(* ::Section:: *)
(*Initialization*)


(* Install and configure bundled dependencies for the LongRunRisk paclet *)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`Initialization`"]


(* ::Subsection:: *)
(*Public symbols*)


initializeDependencies::usage = "initializeDependencies[] installs and configures bundled dependencies (PacletizedResourceFunctions, MaTeX) for the LongRunRisk paclet.";
initializeDependencies::pdflatex = "pdfLaTeX not found at `1`.";
initializeDependencies::gs = "Ghostscript not found at `1`.";


(* ::Section:: *)
(*Private*)


Begin["`Private`"]


initializeDependencies[] := Module[{},
	installPacletizedResourceFunctions[];
	installAndConfigureMaTeX[];
]


(* ::Subsection:: *)
(*PacletizedResourceFunctions*)


installPacletizedResourceFunctions[] := Module[{},
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
]


(* ::Subsection:: *)
(*MaTeX*)


(* Pre-configure MaTeX by creating its config file BEFORE loading it.
   This prevents MaTeX from running auto-detection (which can hang on
   ReadList["!which pdflatex"] or runProcess[{gs, "--version"}]).
   MaTeX looks for config at $UserBaseDirectory/ApplicationData/MaTeX/config.m *)
preConfigureMaTeX[] := Module[
	{configDir, configFile, pdflatexPath, gsPath, config},

	configDir = FileNameJoin[{$UserBaseDirectory, "ApplicationData", "MaTeX"}];
	configFile = FileNameJoin[{configDir, "config.m"}];

	(* Only pre-configure if config doesn't exist yet *)
	If[FileExistsQ[configFile], Return[Null]];

	(* Determine paths based on platform *)
	{pdflatexPath, gsPath} = Which[
		(* GitHub Actions Linux environment *)
		StringMatchQ[$SystemID, "Linux*"] && Environment["CI"] === "true",
		{
			(* TinyTeX installs pdflatex here *)
			If[FileExistsQ["/github/home/bin/pdflatex"],
				"/github/home/bin/pdflatex",
				None
			],
			(* Ghostscript from apt-get install *)
			If[FileExistsQ["/usr/bin/gs"],
				"/usr/bin/gs",
				None
			]
		},
		(* macOS with Homebrew *)
		StringMatchQ[$SystemID, "MacOSX*"],
		{
			If[FileExistsQ["/opt/homebrew/bin/pdflatex"],
				"/opt/homebrew/bin/pdflatex",
				If[FileExistsQ["/Library/TeX/texbin/pdflatex"],
					"/Library/TeX/texbin/pdflatex",
					None
				]
			],
			If[FileExistsQ["/opt/homebrew/bin/gs"],
				"/opt/homebrew/bin/gs",
				If[FileExistsQ["/usr/local/bin/gs"],
					"/usr/local/bin/gs",
					None
				]
			]
		},
		(* Other Unix systems *)
		True,
		{None, None}
	];

	(* Build config association - MaTeX expects these keys *)
	config = <|
		"pdfLaTeX" -> pdflatexPath,
		"Ghostscript" -> gsPath,
		"CacheSize" -> 100,
		"WorkingDirectory" -> Automatic
	|>;

	(* Create directory and write config file *)
	If[!DirectoryQ[configDir],
		CreateDirectory[configDir, CreateIntermediateDirectories -> True]
	];
	Put[config, configFile];
]


installAndConfigureMaTeX[] := Module[{},
	(* Pre-configure MaTeX before loading to prevent auto-detection hangs *)
	preConfigureMaTeX[];

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

	(* Verify configuration and update if needed *)
	With[{currentConfig = Quiet @ MaTeX`ConfigureMaTeX[]},
		Module[{pdflatexPath, gsPath, needsPdflatex, needsGs, configChanges, validConfig},
			(* Validate that currentConfig is a proper list of rules before using ReplaceAll *)
			validConfig = MatchQ[currentConfig, {(_Rule | _RuleDelayed) ...}];
			needsPdflatex = If[validConfig, ("pdfLaTeX" /. currentConfig) === None, True];
			needsGs = If[validConfig, ("Ghostscript" /. currentConfig) === None, True];

			If[needsPdflatex || needsGs,
				(* Determine fallback paths based on platform *)
				{pdflatexPath, gsPath} = Which[
					StringMatchQ[$SystemID, "Linux*"] && Environment["CI"] === "true",
					{"/github/home/bin/pdflatex", "/usr/bin/gs"},
					StringMatchQ[$SystemID, "MacOSX*"],
					{"/opt/homebrew/bin/pdflatex", "/opt/homebrew/bin/gs"},
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

				(* Apply config if we have changes *)
				If[configChanges =!= {},
					MaTeX`ConfigureMaTeX @@ configChanges
				]
			]
		]
	];
]


End[] (*`Private`*)


EndPackage[]
