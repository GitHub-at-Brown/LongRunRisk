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


(* Detect if running in CI environment *)
inCIEnvironment[] := Or[
	StringQ[Environment["CI"]] && StringMatchQ[Environment["CI"], "true", IgnoreCase -> True],
	StringQ[Environment["GITHUB_ACTIONS"]] && StringMatchQ[Environment["GITHUB_ACTIONS"], "true", IgnoreCase -> True],
	StringQ[Environment["WOLFRAMSCRIPT_ENTITLEMENTID"]]
]

(* Get MaTeX executable paths, preferring environment variables *)
getMaTeXPaths[] := Module[{pdflatexPath, gsPath, envPdflatex, envGs},
	(* Check for explicit environment variables first *)
	envPdflatex = Environment["MATEX_PDFLATEX"];
	envGs = Environment["MATEX_GHOSTSCRIPT"];

	(* Use environment variables if set, otherwise detect based on platform *)
	pdflatexPath = If[StringQ[envPdflatex] && FileExistsQ[envPdflatex],
		envPdflatex,
		Which[
			StringMatchQ[$SystemID, "Linux*"] && inCIEnvironment[],
			"/github/home/bin/pdflatex",
			StringMatchQ[$SystemID, "MacOSX*"] && FileExistsQ["/opt/homebrew/bin/pdflatex"],
			"/opt/homebrew/bin/pdflatex",
			StringMatchQ[$SystemID, "MacOSX*"] && FileExistsQ["/Library/TeX/texbin/pdflatex"],
			"/Library/TeX/texbin/pdflatex",
			True,
			None
		]
	];

	gsPath = If[StringQ[envGs] && FileExistsQ[envGs],
		envGs,
		Which[
			StringMatchQ[$SystemID, "Linux*"] && inCIEnvironment[],
			"/usr/bin/gs",
			StringMatchQ[$SystemID, "MacOSX*"] && FileExistsQ["/opt/homebrew/bin/gs"],
			"/opt/homebrew/bin/gs",
			StringMatchQ[$SystemID, "MacOSX*"] && FileExistsQ["/usr/local/bin/gs"],
			"/usr/local/bin/gs",
			True,
			None
		]
	];

	{pdflatexPath, gsPath}
]

(* Pre-configure MaTeX by creating its config file BEFORE loading it.
   This prevents MaTeX from running auto-detection (which can hang on
   ReadList["!which pdflatex"] or runProcess[{gs, "--version"}]).
   MaTeX looks for config at $UserBaseDirectory/ApplicationData/MaTeX/config.m *)
preConfigureMaTeX[] := Module[
	{configDir, configFile, pdflatexPath, gsPath, config},

	configDir = FileNameJoin[{$UserBaseDirectory, "ApplicationData", "MaTeX"}];
	configFile = FileNameJoin[{configDir, "config.m"}];

	(* In CI, always write config to ensure correct paths; locally, skip if exists *)
	If[!inCIEnvironment[] && FileExistsQ[configFile], Return[Null]];

	{pdflatexPath, gsPath} = getMaTeXPaths[];

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
				{pdflatexPath, gsPath} = getMaTeXPaths[];

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
