(* Test Compilation Caching - Isolated *)

Needs["PacletTools`"];
PacletDirectoryLoad[DirectoryName[$InputFileName, 2]];

Needs["FernandoDuarte`LongRunRisk`Model`ProcessModels`"];
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];

(* Use a copy of BY model for testing *)
byModel = FernandoDuarte`LongRunRisk`Model`Catalog`models["BY"];
testModel = Append[byModel, "shortname" -> "TestBY"];

(* Path to compiled file *)
resourcesDir = FileNameJoin[{DirectoryName[$InputFileName, 2], "Resources"}];
compiledDir = FileNameJoin[{resourcesDir, "CompiledFunctions"}];
mxFile = FileNameJoin[{compiledDir, "TestBY.mx"}];

(* Helper to get file modification time *)
getFileModTime[file_] := If[FileExistsQ[file], AbsoluteTime[FileDate[file]], 0];

(* Ensure clean state *)
If[FileExistsQ[mxFile], DeleteFile[mxFile]];

(* Step 1: Process model once to get stable input *)
modelsCatalog = <| "TestBY" -> testModel |>;
(* Capture processed models *)
processedCatalog = processModels[modelsCatalog, TimeConstraint -> 10];
processedModel = processedCatalog["TestBY"];

(* Run 1: Initial compilation with stable input *)
start1 = AbsoluteTime[];
FernandoDuarte`LongRunRisk`Model`ProcessModels`Private`createCompiledEq[processedModel, compiledDir];
end1 = AbsoluteTime[];
time1 = end1 - start1;

If[!FileExistsQ[mxFile],
    Exit[1];
];

modTime1 = getFileModTime[mxFile];

(* Run 2: Cached run with SAME stable input *)
start2 = AbsoluteTime[];
FernandoDuarte`LongRunRisk`Model`ProcessModels`Private`createCompiledEq[processedModel, compiledDir];
end2 = AbsoluteTime[];
time2 = end2 - start2;

modTime2 = getFileModTime[mxFile];

If[modTime1 =!= modTime2,
    Exit[1];
];

(* Run 3: Modify model input manually, should recompile *)
(* Modify a parameter in the processed model's params *)
(* params is an Association in the processed model *)
newParams = Append[processedModel["params"], delta -> 0.95];
processedModelModified = Append[processedModel, "params" -> newParams];

start3 = AbsoluteTime[];
FernandoDuarte`LongRunRisk`Model`ProcessModels`Private`createCompiledEq[processedModelModified, compiledDir];
end3 = AbsoluteTime[];
time3 = end3 - start3;

modTime3 = getFileModTime[mxFile];

If[modTime2 === modTime3,
    Exit[1];
];
