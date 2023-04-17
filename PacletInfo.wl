(* ::Package:: *)

PacletObject[
  <|
    "Name" -> "FernandoDuarte/LongRunRisk",
    "Description" -> "Tools to solve and analyze long-run risk models",
    "Creator" -> "Fernando Duarte",
    "SourceControlURL" -> "https://github.com/GitHub-at-Brown/LongRunRisk",
    "License" -> "MIT",
    "PublisherID" -> "FernandoDuarte",
    "Version" -> "1.0.0",
    "WolframVersion" -> "13.0+",
    "Dependencies"     -> {
        "MaTeX" -> ">=1.7.9",
        "PacletizedResourceFunctions"-> ">=1.0.0"
    },
    "Extensions" -> {
      {
        "Kernel",
        "Root" -> "Kernel",
        "Context" -> {"FernandoDuarte`LongRunRisk`"},
        "Symbols" -> {
        }
      },
      {
        "Documentation",
        "Root" -> "Documentation",
        "Language" -> "English"
      },
      {"Asset", "Assets" -> {{"License", "./LICENSE"}}},
      {"Path","Root"->"Resources"}
    }
  |>
]
