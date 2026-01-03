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


(* Detect CI environment - skip MaTeX there as it's not needed for testing *)
inCIEnvironment[] := StringQ[Environment["CI"]] && Environment["CI"] === "true";

installAndConfigureMaTeX[] := Module[{},
	(* Skip MaTeX in CI - not needed for testing and can hang on auto-detection *)
	If[inCIEnvironment[], Return[Null]];

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
					{"/github/home/bin/pdflatex", None},
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

				(* Apply config if we have changes; Block suppresses MaTeX's own warning about missing gs *)
				If[configChanges =!= {},
					Block[{Print}, MaTeX`ConfigureMaTeX @@ configChanges]
				]
			]
		]
	];
]


End[] (*`Private`*)


EndPackage[]
