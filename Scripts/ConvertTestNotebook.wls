#!/usr/bin/env wolframscript
(* Convert a test notebook (.nb) to a WLT test file (.wlt). *)

args = Rest[$ScriptCommandLine];
force = False;
If[Length[args] >= 1 && MemberQ[args, "--force"],
  force = True;
  args = DeleteCases[args, "--force"];
];
If[Length[args] != 2,
  Print["Usage: ConvertTestNotebook.wls [--force] <input_test_nb> <output_wlt>"];
  Exit[1];
];

inputNb = AbsoluteFileName[args[[1]]];
outputWlt = AbsoluteFileName[args[[2]]];

If[inputNb === $Failed || !FileExistsQ[inputNb],
  Print["Input notebook not found: ", args[[1]]];
  Exit[1];
];

outputDir = DirectoryName[outputWlt];
If[outputDir === $Failed || !DirectoryQ[outputDir],
  Print["Output directory does not exist: ", outputDir];
  Exit[1];
];

If[FileExistsQ[outputWlt] && !force,
  resp = InputString[
    "Output file exists. Overwrite? (y/N): "
  ];
  If[resp =!= "y" && resp =!= "Y",
    Print["Aborted. Output file not overwritten."];
    Exit[0];
  ];
];

UsingFrontEnd[
  Needs["MUnit`"];
  nb = NotebookOpen[inputNb, Visible -> False];
  str = MUnit`NotebookToTests[nb, Automatic, PreserveDataInSections -> False];
  NotebookClose[nb];
  Export[outputWlt, str, "String"];
];
