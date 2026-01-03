(* ::Package:: *)

(*  WLTTestRefactor.wl
    Convert existing .wlt VerificationTest/TestCreate files into Wolfram Language
    generator code that can reproduce the .wlt files, while programmatically
    (re)creating TestID and TimeConstraint.
*)

BeginPackage["WLTTestRefactor`"];

WLTToGeneratorSource::usage =
"WLTToGeneratorSource[wltFile] returns a Wolfram Language source string for a generator package \
that can reproduce the given .wlt file.\n\
\n\
The generated package defines GenerateWLT[ ] and GenerateWLT[target] to write the .wlt file.";

WriteWLTGenerator::usage =
"WriteWLTGenerator[wltFile, generatorFile] writes a generator .wl file to generatorFile.\n\
The generator file, when loaded, can regenerate the original .wlt file (optionally with new TestIDs and TimeConstraints).";

WriteWLTGenerators::usage =
"WriteWLTGenerators[wltFiles, generatorRoot] writes one generator file per input .wlt.\n\
It mirrors the directory structure under a common root (see option \"TestsRoot\").";

WLTToGeneratorSource::readfail = "Failed to read held expressions from `1`.";
WriteWLTGenerator::exists = "Generator file `1` already exists. Set \"OverwriteTarget\"->True to overwrite.";
WriteWLTGenerator::writefail = "Failed to write generator file `1`.";

(* Options *)
Options[WLTToGeneratorSource] = {
    "GeneratorContextBase" -> "WLTGenerated`",     (* base context for generated packages *)
    "OutputTestHead" -> TestCreate,                (* VerificationTest | TestCreate | IntermediateTest | Automatic *)
    "DefaultTimeConstraint" -> 30,                 (* seconds; used when missing *)
    "PreserveExistingTestIDs" -> False,
    "PreserveExistingTimeConstraints" -> True,
    "TestIDPrefix" -> Automatic,                   (* Automatic -> FileBaseName[wltFile] *)
    "HashLength" -> 8,                             (* chars from base36 SHA256 hash *)
    "TargetRelativeWLTPath" -> Automatic,           (* where generator writes by default, relative to generator file *)
    "IncludeHeaderComment" -> True
};

Options[WriteWLTGenerator] = Join[
    Options[WLTToGeneratorSource],
    {
        "OverwriteTarget" -> False
    }
];

Options[WriteWLTGenerators] = Join[
    Options[WriteWLTGenerator],
    {
        "TestsRoot" -> Automatic,   (* common root for relative paths; Automatic -> common directory of wltFiles *)
        "GeneratorExtension" -> "wl"
    }
];

Begin["`Private`"];

(* --------------------------------------------- *)
(* Path helpers                                   *)
(* --------------------------------------------- *)

commonDirectory[files_List] /; files =!= {} :=
    Module[{dirs, parts, minLen, i},
        dirs = ExpandFileName /@ (DirectoryName /@ files);
        parts = FileNameSplit /@ dirs;
        minLen = Min[Length /@ parts];
        i = 0;
        While[
            i < minLen && SameQ @@ (parts[[All, i + 1]]),
            i++
        ];
        FileNameJoin @ Take[First @ parts, i]
    ];

relativePath[fromDir_String, toPath_String] :=
    Module[{from = FileNameSplit @ ExpandFileName[fromDir],
            to   = FileNameSplit @ ExpandFileName[toPath],
            i = 0},
        While[i < Min[Length[from], Length[to]] && from[[i + 1]] === to[[i + 1]],
            i++
        ];
        FileNameJoin @ Join[
            Table["..", {Length[from] - i}],
            Drop[to, i]
        ]
    ];

ensureDirectoryForFile[file_String] :=
    With[{dir = DirectoryName[file]},
        If[dir === "" || dir === ".", Null, CreateDirectory[dir, CreateIntermediateDirectories -> True]]
    ];

(* --------------------------------------------- *)
(* Read .wlt as held expressions                   *)
(* --------------------------------------------- *)

readHeldExpressions[file_String] :=
    Module[{exprs},
        exprs = Quiet @ Check[Import[file, "HeldExpressions"], $Failed];
        If[ListQ[exprs],
            exprs,
            (* Fallback: read expression-by-expression, held *)
            Quiet @ Check[ReadList[file, HoldComplete[Expression]], $Failed]
        ]
    ];

(* --------------------------------------------- *)
(* Generate source for generator package           *)
(* --------------------------------------------- *)

sanitizeContextPiece[str_String] :=
    StringReplace[
        str,
        {
            WhitespaceCharacter .. -> "",
            "-" -> "",
            "_" -> "",  (* underscores invalid in Wolfram context names *)
            "." -> "",
            "/" -> "",
            "\\" -> "",
            ":" -> "",
            "@" -> "",
            "[" -> "",
            "]" -> "",
            "(" -> "",
            ")" -> "",
            "{" -> "",
            "}" -> "",
            "," -> ""
        }
    ];

makeGeneratorContext[base_String, wltFile_String] :=
    Module[{bn = sanitizeContextPiece @ FileBaseName[wltFile]},
        If[StringEndsQ[base, "`"], base <> bn <> "`", base <> "`" <> bn <> "`"]
    ];

heldListToSource[list_List, indent_String:"    "] :=
    StringJoin[
        "{\n",
        StringRiffle[
            (indent <> ToString[#, InputForm, PageWidth -> Infinity] & /@ list),
            ",\n"
        ],
        "\n}"
    ];

(* --------------------------------------------- *)
(* Public: WLTToGeneratorSource                    *)
(* --------------------------------------------- *)

WLTToGeneratorSource[wltFile_String, opts : OptionsPattern[]] :=
    Module[
        {
            exprs,
            genContext,
            outHead = OptionValue["OutputTestHead"],
            defaultTC = OptionValue["DefaultTimeConstraint"],
            keepIDsQ = TrueQ @ OptionValue["PreserveExistingTestIDs"],
            keepTCQ  = TrueQ @ OptionValue["PreserveExistingTimeConstraints"],
            prefix,
            hashLen = OptionValue["HashLength"],
            relTarget,
            includeHeader = TrueQ @ OptionValue["IncludeHeaderComment"],
            header,
            pkg
        },

        exprs = readHeldExpressions[wltFile];
        If[exprs === $Failed || !ListQ[exprs], Message[WLTToGeneratorSource::readfail, wltFile]; Return[$Failed]];

        prefix =
            Replace[OptionValue["TestIDPrefix"], Automatic :> FileBaseName[wltFile]];

        (* Default target path for the generated generator file:
           If not specified, assume generator is stored in a parallel directory and write back to original file name. *)
        relTarget =
            Replace[
                OptionValue["TargetRelativeWLTPath"],
                Automatic :> FileNameJoin @ {"..", FileNameTake[wltFile]}
            ];

        genContext = makeGeneratorContext[OptionValue["GeneratorContextBase"], wltFile];

        header =
            If[includeHeader,
                "(* Auto-generated from: " <> wltFile <> "\n" <>
                "   by WLTTestRefactor` on " <> DateString[{"Year","-","Month","-","Day"}] <> "\n" <>
                "   DO NOT EDIT BY HAND. Edit the generator or the original sources instead.\n" <>
                "*)\n\n",
                ""
            ];

        pkg =
            header <>
            "BeginPackage[\"" <> genContext <> "\"];\n\n" <>
            "GenerateWLT::usage = \"GenerateWLT[] writes the .wlt file. GenerateWLT[target] writes to target.\";\n\n" <>
            "Begin[\"`Private`\"];\n\n" <>

            "$sourceExpressions = " <> heldListToSource[exprs] <> ";\n\n" <>

            "(* --- options --- *)\n" <>
            "Options[GenerateWLT] = {\n" <>
            "    \"OutputTestHead\" -> " <> ToString[outHead, InputForm] <> ",\n" <>
            "    \"DefaultTimeConstraint\" -> " <> ToString[defaultTC, InputForm] <> ",\n" <>
            "    \"PreserveExistingTestIDs\" -> " <> ToString[keepIDsQ, InputForm] <> ",\n" <>
            "    \"PreserveExistingTimeConstraints\" -> " <> ToString[keepTCQ, InputForm] <> ",\n" <>
            "    \"TestIDPrefix\" -> " <> ToString[prefix, InputForm] <> ",\n" <>
            "    \"HashLength\" -> " <> ToString[hashLen, InputForm] <> ",\n" <>
            "    \"TargetRelativeWLTPath\" -> " <> ToString[relTarget, InputForm] <> "\n" <>
            "};\n\n" <>

            "(* --- internal helpers --- *)\n" <>
            "testExprQ[HoldComplete[VerificationTest[___]]] := True;\n" <>
            "testExprQ[HoldComplete[TestCreate[___]]] := True;\n" <>
            "testExprQ[HoldComplete[IntermediateTest[___]]] := True;\n" <>
            "testExprQ[_] := False;\n\n" <>

            "hasOptionQ[hc_HoldComplete, sym_Symbol] := !FreeQ[hc, HoldPattern[(sym -> _) | (sym :> _)]];\n\n" <>

            "removeOption[hc_HoldComplete, sym_Symbol] :=\n" <>
            "    FixedPoint[\n" <>
            "        ReplaceAll[\n" <>
            "            #,\n" <>
            "            HoldComplete[head_[pre___, (sym -> _) | (sym :> _), post___]] :> HoldComplete[head[pre, post]]\n" <>
            "        ] &,\n" <>
            "        hc\n" <>
            "    ];\n\n" <>

            "appendOption[hc_HoldComplete, rule_] := hc /. HoldComplete[head_[args___]] :> HoldComplete[head[args, rule]];\n\n" <>

            "convertTestHead[hc_HoldComplete, Automatic] := hc;\n" <>
            "convertTestHead[hc_HoldComplete, newHead_Symbol] :=\n" <>
            "    hc /. HoldComplete[(VerificationTest | TestCreate | IntermediateTest)[args___]] :> HoldComplete[newHead[args]];\n\n" <>

            "stripForHash[hc_HoldComplete] := removeOption[removeOption[hc, TestID], TimeConstraint];\n\n" <>

            "shortHash[hc_HoldComplete, n_Integer?Positive] :=\n" <>
            "    Module[{h = IntegerString[Hash[stripForHash[hc], \"SHA256\"], 36]}, StringTake[h, UpTo[n]]];\n\n" <>

            "makeTestID[prefix_String, key_String, occ_Integer] :=\n" <>
            "    If[occ <= 1, StringJoin[prefix, \"-\", key], StringJoin[prefix, \"-\", key, \"-\", IntegerString[occ]]];\n\n" <>

            "ensureTestID[hc_HoldComplete, id_, preserveQ_] :=\n" <>
            "    Module[{out = hc},\n" <>
            "        If[preserveQ && hasOptionQ[out, TestID], Return[out]];\n" <>
            "        out = removeOption[out, TestID];\n" <>
            "        appendOption[out, TestID -> id]\n" <>
            "    ];\n\n" <>

            "ensureTimeConstraint[hc_HoldComplete, tc_, preserveQ_] :=\n" <>
            "    Module[{out = hc},\n" <>
            "        If[preserveQ && hasOptionQ[out, TimeConstraint], Return[out]];\n" <>
            "        out = removeOption[out, TimeConstraint];\n" <>
            "        appendOption[out, TimeConstraint -> tc]\n" <>
            "    ];\n\n" <>

            "transformTest[hc_HoldComplete, id_, opts:OptionsPattern[GenerateWLT]] :=\n" <>
            "    Module[{out = hc, head, tc, keepID, keepTC},\n" <>
            "        head  = OptionValue[\"OutputTestHead\"];\n" <>
            "        tc    = OptionValue[\"DefaultTimeConstraint\"];\n" <>
            "        keepID = TrueQ @ OptionValue[\"PreserveExistingTestIDs\"];\n" <>
            "        keepTC = TrueQ @ OptionValue[\"PreserveExistingTimeConstraints\"];\n" <>
            "        out = convertTestHead[out, head];\n" <>
            "        out = ensureTestID[out, id, keepID];\n" <>
            "        out = ensureTimeConstraint[out, tc, keepTC];\n" <>
            "        out\n" <>
            "    ];\n\n" <>

                        "stripHold[HoldComplete[e_]] :=\n" <>
            "    Module[{s = ToString[HoldForm[e], InputForm, PageWidth -> Infinity]},\n" <>
            "        If[StringStartsQ[s, \"HoldForm[\"] && StringEndsQ[s, \"]\"], StringTake[s, {10, -2}], s]\n" <>
            "    ];\n\n" <>
            "writeHeldExpressions[file_String, exprs_List] :=\n" <>
            "    Module[{res},\n" <>
            "        res = Quiet@Check[Export[file, exprs, \"HeldExpressions\"], $Failed];\n" <>
            "        If[res === $Failed,\n" <>
            "            Export[file, StringRiffle[stripHold /@ exprs, \"\\n\\n\"], \"Text\"];\n" <>
            "        ];\n" <>
            "        file\n" <>
            "    ];\n\n" <>
"defaultTarget[opts:OptionsPattern[GenerateWLT]] :=\n" <>
            "    Module[{rel = OptionValue[\"TargetRelativeWLTPath\"], here},\n" <>
            "        here = If[StringQ[$InputFileName] && $InputFileName =!= \"\", DirectoryName[$InputFileName], Directory[]];\n" <>
            "        ExpandFileName @ FileNameJoin[{here, rel}]\n" <>
            "    ];\n\n" <>

            "GenerateWLT[target_: Automatic, opts:OptionsPattern[]] :=\n" <>
            "    Module[{outFile, outExprs, seen = <||>, prefix, n, key, occ, id},\n" <>
            "        outFile = Replace[target, Automatic :> defaultTarget[opts]];\n" <>
            "        CreateDirectory[DirectoryName[outFile], CreateIntermediateDirectories -> True];\n" <>
            "        prefix = OptionValue[\"TestIDPrefix\"];\n" <>
            "        prefix = If[StringQ[prefix], prefix, ToString[prefix, InputForm]];\n" <>
            "        n = OptionValue[\"HashLength\"];\n" <>
            "        n = If[IntegerQ[n] && n > 0, n, 8];\n" <>
            "        outExprs = Map[\n" <>
            "            Function[hc,\n" <>
            "                If[testExprQ[hc],\n" <>
            "                    key = shortHash[hc, n];\n" <>
            "                    occ = Lookup[seen, key, 0] + 1;\n" <>
            "                    seen[key] = occ;\n" <>
            "                    id = makeTestID[prefix, key, occ];\n" <>
            "                    transformTest[hc, id, opts],\n" <>
            "                    hc\n" <>
            "                ]\n" <>
            "            ],\n" <>
            "            $sourceExpressions\n" <>
            "        ];\n" <>
            "        writeHeldExpressions[outFile, outExprs];\n" <>
            "        outFile\n" <>
            "    ];\n\n" <>

            "End[];\nEndPackage[];\n";

        pkg
    ];

(* --------------------------------------------- *)
(* Public: WriteWLTGenerator                       *)
(* --------------------------------------------- *)

WriteWLTGenerator[wltFile_String, generatorFile_String, opts : OptionsPattern[]] :=
    Module[{out = ExpandFileName[generatorFile], overwriteQ, src, trwp, srcOpts},
        overwriteQ = TrueQ @ OptionValue["OverwriteTarget"];
        If[FileExistsQ[out] && !overwriteQ,
            Message[WriteWLTGenerator::exists, out];
            Return[$Failed]
        ];
        ensureDirectoryForFile[out];

        (* Ensure the generated generator writes back to the same .wlt by default, even when
           generators are stored in a mirrored directory tree. *)
        trwp = Replace[
            OptionValue["TargetRelativeWLTPath"],
            Automatic :> relativePath[DirectoryName[out], wltFile]
        ];

        srcOpts = FilterRules[
            Join[{opts}, {"TargetRelativeWLTPath" -> trwp}],
            Options[WLTToGeneratorSource]
        ];

        src = WLTToGeneratorSource[wltFile, Sequence @@ srcOpts];
        If[Quiet@Check[Export[out, src, "Text"], $Failed] === $Failed,
            Message[WriteWLTGenerator::writefail, out];
            Return[$Failed]
        ];
        out
    ];

(* --------------------------------------------- *)
(* Public: WriteWLTGenerators                      *)
(* --------------------------------------------- *)

WriteWLTGenerators[wltFiles_List, generatorRoot_String, opts : OptionsPattern[]] :=
    Module[
        {root = ExpandFileName[generatorRoot], testsRoot, ext, results},
        testsRoot = Replace[OptionValue["TestsRoot"], Automatic :> commonDirectory[wltFiles]];
        ext = OptionValue["GeneratorExtension"];

        results =
            Table[
                Module[{wlt = wltFiles[[k]], rel, genFile},
                    rel = relativePath[testsRoot, wlt];
                    (* change extension .wlt -> .<ext> *)
                    genFile = FileNameJoin @ {root, rel}; (* keep rel including filename *)
                    genFile = FileNameJoin @ {DirectoryName[genFile], FileBaseName[genFile] <> "." <> ext};
                    WriteWLTGenerator[
                        wlt,
                        genFile,
                        Sequence @@ FilterRules[{opts}, Options[WriteWLTGenerator]]
                    ]
                ],
                {k, Length[wltFiles]}
            ];

        results
    ];

End[]; (* `Private` *)

EndPackage[];
