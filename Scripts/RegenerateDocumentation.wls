#!/usr/bin/env wolframscript
(* Script to regenerate all documentation notebook outputs *)

SetDirectory["/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk"];

(* Load the package *)
Print["Loading LongRunRisk package..."];
Needs["FernandoDuarte`LongRunRisk`"];

(* Get all documentation notebooks *)
notebooks = FileNames["*.nb", "Documentation/English/ReferencePages/Symbols"];
Print["Found ", Length[notebooks], " notebooks to process"];

(* Process each notebook *)
successCount = 0;
failCount = 0;

Do[
  Print["\n[", i, "/", Length[notebooks], "] Processing: ", FileBaseName[nb]];

  Check[
    (* Open notebook without showing it *)
    nbObj = NotebookOpen[nb, Visible -> False];

    (* Evaluate all cells *)
    SelectionMove[nbObj, All, Notebook];
    SelectionEvaluate[nbObj];

    (* Wait for evaluation to complete *)
    Pause[2];

    (* Save and close *)
    NotebookSave[nbObj];
    NotebookClose[nbObj];

    Print["  ✓ Success: ", FileBaseName[nb]];
    successCount++;
    ,
    (* If error occurs *)
    Print["  ✗ Failed: ", FileBaseName[nb]];
    failCount++;
  ];

  (* Small pause between notebooks *)
  Pause[0.5];
  ,
  {i, 1, Length[notebooks]},
  {nb, notebooks}
];

Print["\n=== Summary ==="];
Print["Successfully processed: ", successCount, "/", Length[notebooks]];
Print["Failed: ", failCount];
Print["Done!"];
