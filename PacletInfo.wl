(* ::Package:: *)

PacletObject[
  <|
    "Name" -> "FernandoDuarte/LongRunRisk",
    "Description" -> "Tools to solve and analyze long-run risk models",
    "Creator" -> "Fernando Duarte",
    "SourceControlURL" -> "https://github.com/GitHub-at-Brown/LongRunRisk",
    "License" -> "MIT",
    "PublisherID" -> "FernandoDuarte",
    (* :!CodeAnalysis::Disable::InvalidFirstVersion:: *)
    "Version" -> "1.0.1",
    "WolframVersion" -> "13.1+",
    "PrimaryContext" -> "FernandoDuarte`LongRunRisk`",
    "Dependencies" -> {
      "MaTeX" -> ">=1.7.9",
      "PacletizedResourceFunctions" -> ">=1.0.0"
    },
    "Extensions" -> {
      {
        "Kernel",
        "Root" -> "Kernel",
        "Context" -> {"FernandoDuarte`LongRunRisk`"},
        "Symbols" -> {
          "FernandoDuarte`LongRunRisk`BuildModels",
          "FernandoDuarte`LongRunRisk`CheckModels",
          "FernandoDuarte`LongRunRisk`Corr",
          "FernandoDuarte`LongRunRisk`Cov",
          "FernandoDuarte`LongRunRisk`Ev",
          "FernandoDuarte`LongRunRisk`Growth",
          "FernandoDuarte`LongRunRisk`Info",
          "FernandoDuarte`LongRunRisk`Models",
          "FernandoDuarte`LongRunRisk`PlotCoeffs",
          "FernandoDuarte`LongRunRisk`ToEquation",
          "FernandoDuarte`LongRunRisk`ToExogenousVars",
          "FernandoDuarte`LongRunRisk`ToNum",
          "FernandoDuarte`LongRunRisk`ToStateVars",
          "FernandoDuarte`LongRunRisk`UncondCorr",
          "FernandoDuarte`LongRunRisk`UncondCov",
          "FernandoDuarte`LongRunRisk`UncondE",
          "FernandoDuarte`LongRunRisk`UncondVar",
          "FernandoDuarte`LongRunRisk`Var",
          "FernandoDuarte`LongRunRisk`VisualizeCoeffs",
          "FernandoDuarte`LongRunRisk`YieldCurve"
        }
      },
      {
        "Documentation"
      },
      {
	      "Asset",
	      "Assets" -> {{"License", "./LICENSE"}}
      },
      {
	      "Path",
	      "Root" -> "Resources"
      }
    }
  |>
]
