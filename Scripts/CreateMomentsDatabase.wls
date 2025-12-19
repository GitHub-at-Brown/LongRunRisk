#!/usr/bin/env wolframscript
(* ::Package:: *)

numKernels=14;
Unprotect[$ProcessorCount];$ProcessorCount=numKernels;
CloseKernels[];LaunchKernels[numKernels];Kernels[];

pacletDir=DirectoryName[File["CreateMomentsDatabase.wls"],1];
PacletDirectoryLoad[pacletDir];
resourcesDir=FileNameJoin[{pacletDir,"Resources"}];
Get[FileNameJoin[{resourcesDir,"Models.wl"}]];
Get@FileNameJoin[{pacletDir,"Kernel","ComputationalEngine","CreateMomentsDatabase"<>".wl"}];
Echo[pacletDir,"pacletDir"];
out=AbsoluteTiming[
Do[
fileName=FileNameJoin[{resourcesDir,"MomentsLookupTables","covLong"<>key<>".mx"}];
createDatabase[
	FernandoDuarte`LongRunRisk`Models[key],
	fileName
];
,
{key,(*{"NRCStochVol"}*)Keys@FernandoDuarte`LongRunRisk`Models}
];
];
Echo[out,"out"];
