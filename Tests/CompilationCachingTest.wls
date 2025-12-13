(* Test Compilation Caching - Isolated *)

Needs["PacletTools`"];
PacletDirectoryLoad[DirectoryName[$InputFileName, 2]];

Needs["PacletizedResourceFunctions`"];
Needs["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];

resourcesDir = FileNameJoin[{DirectoryName[$InputFileName, 2], "Resources"}];

compiledDir = CreateDirectory[
  FileNameJoin[{$TemporaryDirectory, "LongRunRisk-CompilationCachingTest-" <> CreateUUID[]}]
];
mxFile = FileNameJoin[{compiledDir, "TestBY.mx"}];

getFileModTime[file_] := If[FileExistsQ[file], AbsoluteTime[FileDate[file]], 0];

failure = False;

modelsFile = FileNameJoin[{resourcesDir, "Models.wl"}];
processedModel =
  If[FileExistsQ[modelsFile],
    Module[{models = Get@Get[modelsFile]},
      If[AssociationQ[models] && KeyExistsQ[models, "BY"],
        models["BY"],
        $Failed
      ]
    ],
    $Failed
  ];

If[processedModel === $Failed,
  Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"];
  Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
  byModel = FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"];
  testModel = Append[byModel, "shortname" -> "TestBY"];
  modelsCatalog = <|"TestBY" -> testModel|>;
  processedCatalog = processModels[modelsCatalog];
  processedModel = processedCatalog["TestBY"];
];

processedModel = Append[processedModel, "shortname" -> "TestBY"];

If[FileExistsQ[mxFile], DeleteFile[mxFile]];

(* Run 1: Initial compilation *)
start1 = AbsoluteTime[];
FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq[processedModel, compiledDir];
end1 = AbsoluteTime[];
time1 = end1 - start1;

If[!FileExistsQ[mxFile], failure = True];
modTime1 = getFileModTime[mxFile];

Pause[1];

(* Run 2: Cached run with identical input *)
start2 = AbsoluteTime[];
FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq[processedModel, compiledDir];
end2 = AbsoluteTime[];
time2 = end2 - start2;
modTime2 = getFileModTime[mxFile];

If[modTime1 =!= modTime2, failure = True];

Pause[1];

(* Run 3: Change the model input shape -> should recompile *)
newParams = Append[
  processedModel["params"],
  FernandoDuarte`LongRunRisk`Model`Parameters`delta -> 0.95
];
processedModelModified = Append[processedModel, "params" -> newParams];

start3 = AbsoluteTime[];
FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq[processedModelModified, compiledDir];
end3 = AbsoluteTime[];
time3 = end3 - start3;
modTime3 = getFileModTime[mxFile];

If[modTime2 === modTime3, failure = True];

If[DirectoryQ[compiledDir], DeleteDirectory[compiledDir, DeleteContents -> True]];
Exit[If[failure, 1, 0]];
