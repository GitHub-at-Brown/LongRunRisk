(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`Tools`PackageHealth`"];

updateModelManifest::usage = "updateModelManifest[] generates and saves the ModelManifest.wl file.";
updateModelManifest::noroot = "Could not locate paclet root directory.";
updateModelManifest::nocat = "Catalog models not found or invalid.";

Begin["`Private`"];

Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];

(* Simple root finder - uses FindFile on THIS package *)
findPacletRoot[] := Module[{file, root},
  file = FindFile["FernandoDuarte`LongRunRisk`Tools`PackageHealth`"];
  If[!StringQ[file], Return[$Failed]];
  root = DirectoryName[file, 3];  (* Kernel/Tools/file.wl -> root *)
  If[FileExistsQ[FileNameJoin[{root, "PacletInfo.wl"}]], root, $Failed]
];

(* Simple version getter *)
getVersion[root_String] := Module[{found},
  found = PacletFind["FernandoDuarte/LongRunRisk"];
  (* Prefer matching root, else first found, else "Development" *)
  SelectFirst[found, #["Location"] === root &,
    If[found =!= {}, First[found], <|"Version" -> "Development"|>]
  ]["Version"]
];

canonicalize[expr_Association] := KeySort[Map[canonicalize, expr]];
canonicalize[expr_List] := Map[canonicalize, expr];
canonicalize[expr_] := expr;

getCanonicalHash[expr_] := Hash[ExportString[canonicalize[expr], "WL"], "SHA256", "HexString"];

updateModelManifest[] := Module[
  {root, manifestFile, catalogModels, catalogHash, modelHashes, version, manifestData},

  (* Find root *)
  root = findPacletRoot[];
  If[root === $Failed, Message[updateModelManifest::noroot]; Return[$Failed]];

  (* Build manifest path *)
  manifestFile = FileNameJoin[{root, "Resources", "ModelManifest.wl"}];
  Quiet[CreateDirectory[DirectoryName[manifestFile]], CreateDirectory::filex];

  (* Get catalog *)
  catalogModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;
  If[!AssociationQ[catalogModels], Message[updateModelManifest::nocat]; Return[$Failed]];

  (* Compute hashes *)
  catalogHash = getCanonicalHash[catalogModels];
  modelHashes = Map[getCanonicalHash, catalogModels];

  (* Get version *)
  version = getVersion[root];

  (* Build and save *)
  manifestData = <|
    "PacletVersion" -> version,
    "CatalogHash" -> catalogHash,
    "Models" -> modelHashes,
    "Date" -> DateString["ISODateTime"]
  |>;

  Put[manifestData, manifestFile];
  manifestData
];

End[];
EndPackage[];
