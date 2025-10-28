#!/usr/bin/env wolframscript
(*!wls
    :Name: nb-clean
    :Synopsis: Normalize Mathematica notebooks for Git using SaveReadableNotebook
*)

Needs["ResourceFunction`"];

ClearAll[stripOutputs, normalizeNB];

(* notebooks we intentionally leave untouched (dynamic or unsupported content) *)
excludedPaths = {
  "ResourceDefinition.nb",
  FileNameJoin[{"Tests", "InteractiveTests", "longRunRisk.nb"}]
};

(* remove common generated cells that create volatile diffs *)
stripOutputs[nb_Notebook] := DeleteCases[
    nb,
    Cell[_, s_String /; MemberQ[{"Output", "Print", "Message", "Echo"}, s], ___],
    Infinity
];

normalizeNB[path_String] := Module[{nbExpr, tmp, opts, result, relPath},
  relPath = FileNameJoin[FileNameSplit[path]];

  If[MemberQ[excludedPaths, relPath],
    Print["[nb-clean] SKIP: ", relPath, " (excluded)"];
    Return[relPath]
  ];

  If[!FileExistsQ[path],
    Print["[nb-clean] ERROR: File not found: ", relPath];
    Return[$Failed]
  ];

  nbExpr = Quiet@Check[Import[path, "NB"], $Failed];
  If[nbExpr === $Failed,
    Print["[nb-clean] ERROR: Failed to import notebook: ", relPath];
    Return[$Failed]
  ];
  If[!MatchQ[nbExpr, _Notebook],
    Print["[nb-clean] ERROR: Not a valid notebook expression: ", relPath];
    Return[$Failed]
  ];

  nbExpr = stripOutputs[nbExpr];

  tmp = FileNameJoin[{DirectoryName[path], "." <> FileNameTake[path] <> ".tmp"}];

  opts = {
    "ExcludedCellOptions" -> {CellChangeTimes, ExpressionUUID, CellLabel},
    "ExcludedNotebookOptions" -> Automatic
  };

  result = Quiet@Check[
    ResourceFunction["SaveReadableNotebook"][nbExpr, tmp, Sequence @@ opts],
    $Failed
  ];

  If[result === $Failed,
    Print["[nb-clean] ERROR: SaveReadableNotebook failed: ", relPath];
    If[FileExistsQ[tmp], DeleteFile[tmp]];
    Return[$Failed]
  ];

  result = Quiet@Check[CopyFile[tmp, path, OverwriteTarget -> True], $Failed];
  If[result === $Failed,
    Print["[nb-clean] ERROR: Failed to write cleaned notebook: ", relPath];
    If[FileExistsQ[tmp], DeleteFile[tmp]];
    Return[$Failed]
  ];

  If[FileExistsQ[tmp], Quiet@DeleteFile[tmp]];

  result = Quiet@Check[RunProcess[{"git", "add", path}], $Failed];
  If[!AssociationQ[result] || Lookup[result, "ExitCode", 1] =!= 0,
    Print["[nb-clean] ERROR: git add failed for ", relPath];
    If[AssociationQ[result],
      With[{stderr = StringTrim[Lookup[result, "StandardError", ""]]},
        If[StringLength[stderr] > 0, Print["[nb-clean] STDERR: ", stderr]]
      ]
    ];
    Return[$Failed]
  ];

  relPath
];

nbFiles = Select[$ScriptCommandLine, StringMatchQ[#, ___ ~~ ".nb"] &];

If[nbFiles === {},
  Print["[nb-clean] No .nb files provided. Usage: wolframscript -file scripts/nb-clean.wls <paths>.nb"];
  Quit[0];
];

results = Table[
  With[{r = Check[normalizeNB[f], $Failed]},
    If[r === $Failed,
      Print["[nb-clean] FAIL: ", f];
      $Failed,
      Print["[nb-clean] OK:   ", f];
      r
    ]
  ],
  {f, nbFiles}
];

If[MemberQ[results, $Failed],
  Quit[1],
  Quit[0]
];
