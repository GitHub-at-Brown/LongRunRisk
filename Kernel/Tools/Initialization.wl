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

(* Get MaTeX executable paths - ALWAYS verify file existence *)
getMaTeXPaths[] := Module[{pdflatexPath, gsPath, envPdflatex, envGs, candidates},
	(* Check for explicit environment variables first *)
	envPdflatex = Environment["MATEX_PDFLATEX"];
	envGs = Environment["MATEX_GHOSTSCRIPT"];

	(* Build candidate list for pdflatex - all paths that might contain it *)
	candidates = Select[{
		envPdflatex,
		"/github/home/bin/pdflatex",
		"/opt/homebrew/bin/pdflatex",
		"/Library/TeX/texbin/pdflatex",
		"/usr/local/bin/pdflatex",
		"/usr/bin/pdflatex"
	}, StringQ];
	(* Find first candidate that actually exists *)
	pdflatexPath = SelectFirst[candidates, FileExistsQ, None];

	(* Build candidate list for gs *)
	candidates = Select[{
		envGs,
		"/usr/bin/gs",
		"/opt/homebrew/bin/gs",
		"/usr/local/bin/gs"
	}, StringQ];
	(* Find first candidate that actually exists *)
	gsPath = SelectFirst[candidates, FileExistsQ, None];

	(* Debug output in CI *)
	If[inCIEnvironment[],
		Print["getMaTeXPaths: pdflatex=", pdflatexPath, ", gs=", gsPath]
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


installAndConfigureMaTeX[] := Module[{pdflatexPath, gsPath},
	(* First, check if required executables exist *)
	{pdflatexPath, gsPath} = getMaTeXPaths[];

	(* If pdflatex doesn't exist, skip MaTeX setup *)
	If[pdflatexPath === None,
		If[inCIEnvironment[],
			Print["MaTeX: pdfLaTeX not found, skipping setup"]
		];
		Return[Null]
	];

	(* Pre-configure MaTeX before loading to prevent auto-detection.
	   MaTeX's checkConfig[] runs RunProcess[{gs, "--version"}] which can hang
	   in CI environments. By setting Ghostscript to None in CI, we skip that check.
	   Users can still use MaTeX for basic LaTeX rendering; Ghostscript is only
	   needed for certain output format conversions. *)
	If[inCIEnvironment[],
		(* In CI: Configure with gs=None to prevent RunProcess hang during checkConfig *)
		preConfigureMaTeXForCI[pdflatexPath],
		(* Locally: Normal configuration with both paths *)
		preConfigureMaTeX[]
	];

	(* Install MaTeX paclet if not already installed *)
	If[
		{} === PacletFind["MaTeX"],
		If[inCIEnvironment[],
			(* CI: Direct paclet install - faster and avoids MaTeXInstall complexity *)
			Print["MaTeX: Installing bundled paclet"];
			PacletInstall[
				File[FindFile["FernandoDuarte/LongRunRisk/MaTeX-1.7.10.paclet"]],
				ForceVersionInstall -> True
			],
			(* Local: Use MaTeXInstall for full installation experience *)
			Print["Installing bundled MaTeX package..."];
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
			MaTeXInstall`MaTeXInstall[]
		]
	];

	(* Load MaTeX *)
	Needs["MaTeX`"];

	(* Verify configuration and update if needed - only locally since CI config
	   is already set correctly and we want to avoid triggering checkConfig's
	   RunProcess calls *)
	If[!inCIEnvironment[],
		With[{currentConfig = Quiet @ MaTeX`ConfigureMaTeX[]},
			Module[{needsPdflatex, needsGs, configChanges, validConfig},
				validConfig = MatchQ[currentConfig, {(_Rule | _RuleDelayed) ...}];
				needsPdflatex = If[validConfig, ("pdfLaTeX" /. currentConfig) === None, True];
				needsGs = If[validConfig, ("Ghostscript" /. currentConfig) === None, True];

				If[needsPdflatex || needsGs,
					configChanges = {};
					If[needsPdflatex && pdflatexPath =!= None,
						AppendTo[configChanges, "pdfLaTeX" -> pdflatexPath]
					];
					If[needsGs && gsPath =!= None,
						AppendTo[configChanges, "Ghostscript" -> gsPath]
					];
					If[configChanges =!= {},
						MaTeX`ConfigureMaTeX @@ configChanges
					]
				]
			]
		]
	];
]

(* CI-specific MaTeX configuration: set Ghostscript to None to prevent
   RunProcess[{gs, "--version"}] hang in checkConfig[]. MaTeX will still
   work for basic LaTeX rendering. *)
preConfigureMaTeXForCI[pdflatexPath_] := Module[
	{configDir, configFile, config},

	configDir = FileNameJoin[{$UserBaseDirectory, "ApplicationData", "MaTeX"}];
	configFile = FileNameJoin[{configDir, "config.m"}];

	(* Build config with gs=None to skip Ghostscript verification *)
	config = <|
		"pdfLaTeX" -> pdflatexPath,
		"Ghostscript" -> None,  (* Prevents RunProcess hang *)
		"CacheSize" -> 100,
		"WorkingDirectory" -> Automatic
	|>;

	If[!DirectoryQ[configDir],
		CreateDirectory[configDir, CreateIntermediateDirectories -> True]
	];
	Put[config, configFile];
	Print["MaTeX: Pre-configured with pdfLaTeX=", pdflatexPath, ", Ghostscript=None"];
]


End[] (*`Private`*)


EndPackage[]
