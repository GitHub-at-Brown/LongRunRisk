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
Print["Step 1: Processing model to get stable input..."];
modelsCatalog = <| "TestBY" -> testModel |>;
(* Capture processed models *)
processedCatalog = processModels[modelsCatalog, TimeConstraint -> 10];
processedModel = processedCatalog["TestBY"];

(* Run 1: Initial compilation with stable input *)
Print["Run 1: Initial compilation..."];
start1 = AbsoluteTime[];
FernandoDuarte`LongRunRisk`Model`ProcessModels`Private`createCompiledEq[processedModel, compiledDir];
end1 = AbsoluteTime[];
time1 = end1 - start1;
Print["Run 1 time: ", time1];

If[!FileExistsQ[mxFile],
    Print["Error: mxFile not created after Run 1 at: ", mxFile];
    Exit[1];
];

modTime1 = getFileModTime[mxFile];
Print["File Mod Time 1: ", modTime1];

(* Run 2: Cached run with SAME stable input *)
Print["Run 2: Cached run..."];
start2 = AbsoluteTime[];
FernandoDuarte`LongRunRisk`Model`ProcessModels`Private`createCompiledEq[processedModel, compiledDir];
end2 = AbsoluteTime[];
time2 = end2 - start2;
Print["Run 2 time: ", time2];

modTime2 = getFileModTime[mxFile];
Print["File Mod Time 2: ", modTime2];

If[modTime1 =!= modTime2,
    Print["Error: File modification time changed! Caching failed."];
    Exit[1];
];

Print["Success: Caching works!"];

(* Run 3: Modify model input manually, should recompile *)
Print["Run 3: Modified model..."];
(* Modify a parameter in the processed model's params *)
(* params is an Association in the processed model *)
newParams = Append[processedModel["params"], delta -> 0.95];
processedModelModified = Append[processedModel, "params" -> newParams];

start3 = AbsoluteTime[];
FernandoDuarte`LongRunRisk`Model`ProcessModels`Private`createCompiledEq[processedModelModified, compiledDir];
end3 = AbsoluteTime[];
time3 = end3 - start3;
Print["Run 3 time: ", time3];

modTime3 = getFileModTime[mxFile];
Print["File Mod Time 3: ", modTime3];

If[modTime2 === modTime3,
    Print["Error: File modification time did NOT change after model modification!"];
    Exit[1];
];

Print["Success: Recompilation on change works!"];
