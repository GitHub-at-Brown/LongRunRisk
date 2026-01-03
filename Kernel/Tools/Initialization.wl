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

	(* Locally, skip if config already exists *)
	If[FileExistsQ[configFile], Return[Null]];

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

(* CI-specific pre-configuration: Set Ghostscript to None to prevent
   RunProcess[{gs, "--version"}] hang in MaTeX's checkConfig[].
   This is called BEFORE MaTeX loads, so when NiceOutput.wl triggers
   Needs["MaTeX`"], MaTeX will read this config and skip the gs check. *)
preConfigureMaTeXForCI[pdflatexPath_] := Module[
	{configDir, configFile, config},

	configDir = FileNameJoin[{$UserBaseDirectory, "ApplicationData", "MaTeX"}];
	configFile = FileNameJoin[{configDir, "config.m"}];

	(* Config with Ghostscript=None to skip the problematic RunProcess check *)
	config = <|
		"pdfLaTeX" -> pdflatexPath,
		"Ghostscript" -> None,
		"CacheSize" -> 100,
		"WorkingDirectory" -> Automatic
	|>;

	If[!DirectoryQ[configDir],
		CreateDirectory[configDir, CreateIntermediateDirectories -> True]
	];
	Put[config, configFile];
	Print["MaTeX config written: pdfLaTeX=", pdflatexPath, ", Ghostscript=None"];
]


installAndConfigureMaTeX[] := Module[{pdflatexPath, gsPath},
	(* In CI, pre-configure MaTeX with Ghostscript=None to prevent the
	   RunProcess[{gs, "--version"}] hang when MaTeX eventually loads.
	   MaTeX may be loaded by other packages (e.g., NiceOutput), so we must
	   ensure the config file exists before any potential load. *)
	If[inCIEnvironment[],
		{pdflatexPath, gsPath} = getMaTeXPaths[];
		preConfigureMaTeXForCI[pdflatexPath];
		Print["MaTeX: Pre-configured for CI, deferring load"];
		Return[Null]
	];

	(* Local development: full MaTeX setup *)
	{pdflatexPath, gsPath} = getMaTeXPaths[];

	If[pdflatexPath === None,
		Return[Null]
	];

	(* Pre-configure MaTeX before loading to prevent auto-detection *)
	preConfigureMaTeX[];

	(* Install and load MaTeX *)
	If[
		{} === PacletFind["MaTeX"],
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
		MaTeXInstall`MaTeXInstall[],
		Needs["MaTeX`"]
	];

	(* Verify configuration and update if needed *)
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
	];
]


End[] (*`Private`*)


EndPackage[]
