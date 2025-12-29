#!/usr/bin/env wolframscript
(* Test file consolidation script v2
   Merges individual test files preserving ALL content between Begin/End *)

print[a___] := WriteString["stdout", a, "\n"];

(* Sanitize function name for use in Wolfram context names *)
sanitizeContextName[name_String] := Module[{result},
  result = StringReplace[name, {
    "-" ~~ c:LetterCharacter :> ToUpperCase[c],
    "-" ~~ c:DigitCharacter :> c,
    "-" -> ""
  }];
  result = StringReplace[result,
    "_" ~~ c:LetterCharacter :> ToUpperCase[c]
  ];
  result
];

(* Extract Begin context from file *)
extractBeginContext[text_String] := Module[{match},
  match = StringCases[text, "Begin[\"" ~~ ctx:Shortest[___] ~~ "\"]" :> ctx, 1];
  If[Length[match] > 0, match[[1]], ""]
];

(* Extract test content - handles multiple file structures *)
extractTestContent[text_String] := Module[{beginPos, endPos, hasBeginEnd, hasTestSection},
  hasBeginEnd = StringContainsQ[text, "\nEnd[]"];
  hasTestSection = StringContainsQ[text, "BeginTestSection["];

  Which[
    (* Case 1: Has Begin[...]/End[] wrapper *)
    hasBeginEnd,
    beginPos = StringPosition[text, "Begin[" ~~ Shortest[___] ~~ "]\n", 1];
    If[Length[beginPos] === 0, Return[""]];
    beginPos = beginPos[[1, 2]] + 1;

    endPos = StringPosition[text, "\nEnd[]", 1];
    If[Length[endPos] === 0, Return[""]];
    endPos = endPos[[1, 1]];

    If[endPos > beginPos, StringTake[text, {beginPos, endPos}], ""],

    (* Case 2: Has BeginTestSection but no Begin/End *)
    hasTestSection,
    beginPos = StringPosition[text, "BeginTestSection[" ~~ Shortest[___] ~~ "]" ~~ WhitespaceCharacter..., 1];
    If[Length[beginPos] === 0, Return[""]];
    beginPos = beginPos[[1, 2]] + 1;

    endPos = StringPosition[text, "EndTestSection[]", 1];
    If[Length[endPos] === 0, Return[""]];
    endPos = endPos[[1, 1]] - 1;

    If[endPos > beginPos, StringTake[text, {beginPos, endPos}], ""],

    (* Case 3: No wrappers - starts with VerificationTest directly *)
    True,
    StringTrim[text]
  ]
];

Module[{
  pacletBaseDir, groupingRaw, grouping, consolidatedCount, deletedCount
},

pacletBaseDir = DirectoryName[DirectoryName[$InputFileName]];
print["Paclet root: ", pacletBaseDir];

groupingRaw = Import[FileNameJoin[{pacletBaseDir, ".agent", "grouping_summary.json"}], "RawJSON"];
grouping = Map[Association, groupingRaw];

print["Found ", Length[grouping], " consolidation groups"];

consolidatedCount = 0;
deletedCount = 0;

Do[
  Module[{
    dir, funcName, targetFile, sourcePattern, sourceFiles,
    contents, testContext, newContent, sanitizedName, originalContext, firstFileText
  },
    dir = g["directory"];
    funcName = g["functionName"];

    sourcePattern = FileNameJoin[{pacletBaseDir, "Tests", dir, funcName <> "_test*.wlt"}];
    sourceFiles = FileNames[sourcePattern];

    If[Length[sourceFiles] <= 1,
      print["Skipping ", dir, "/", funcName, " (already consolidated or single file)"];
      Continue[]
    ];

    sourceFiles = SortBy[sourceFiles,
      ToExpression[StringCases[FileBaseName[#], "_test" ~~ n__ :> n][[1]]] &
    ];

    print["Consolidating ", dir, "/", funcName, ".wlt from ", Length[sourceFiles], " files"];

    (* Extract original Begin context from first file *)
    firstFileText = ReadString[sourceFiles[[1]]];
    originalContext = extractBeginContext[firstFileText];

    (* Extract ALL content from each file *)
    contents = {};
    Do[
      Module[{text, testContent},
        text = ReadString[file];
        testContent = extractTestContent[text];
        If[StringLength[testContent] > 0,
          AppendTo[contents, {FileNameTake[file], StringTrim[testContent]}]
        ];
      ],
      {file, sourceFiles}
    ];

    (* Use original context if found, otherwise generate a safe one *)
    sanitizedName = sanitizeContextName[funcName];
    testContext = If[StringLength[originalContext] > 0,
      originalContext,
      "FernandoDuarte`LongRunRisk`Tests`" <> dir <> "`" <> sanitizedName <> "`"
    ];

    newContent = StringJoin[
      "BeginTestSection[\"", funcName, " Tests\"]\n",
      "Begin[\"", testContext, "\"]\n",
      "\n",
      StringRiffle[
        Map[
          Function[{item},
            "(* --- merged from: " <> item[[1]] <> " --- *)\n" <> item[[2]] <> "\n"
          ],
          contents
        ],
        "\n"
      ],
      "\n",
      "End[]\n",
      "EndTestSection[]\n"
    ];

    targetFile = FileNameJoin[{pacletBaseDir, "Tests", dir, funcName <> ".wlt"}];
    Export[targetFile, newContent, "Text"];
    consolidatedCount++;

    Do[
      DeleteFile[file];
      deletedCount++,
      {file, sourceFiles}
    ];

  ],
  {g, grouping}
];

print[""];
print["=== Consolidation Complete ==="];
print["Consolidated files created: ", consolidatedCount];
print["Source files deleted: ", deletedCount];
];
