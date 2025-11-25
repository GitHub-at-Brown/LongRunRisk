(* ::Package:: *)

(* compile once *)
kernel = buildKernel[expr, param, CompilationTarget -> "C"];

(* save it (machine- and version-specific) *)
filename = FileNameJoin[{DirectoryName[NotebookDirectory[],2],"Resources","CompiledFunctions",model["shortname"]<>".mx"}]
$SavedKernel = kernel;
DumpSave[filename, "$SavedKernel"];



Get[filename];     (* restores $SavedKernel *)
kernel = $SavedKernel;

(* bind params/signs and use *)
{f, df} = bindUnary[kernel, paramsAssoc, signs];
iv = findRootInterval[condA, paramsAssoc, signs];
{L, U} =  {Min@iv,Max@iv};
root = FindRoot[f[z], {z, (L+U)/2., L, U}] /. z -> A[0];



fastRoot[Function[x, Cos[x] - x],
         Function[x, -Sin[x] - 1.0],
         {0., 1.},
         10, 30]
(* -> x -> 0.7390851332... *)
cf  = Compile[{{x, _Real}},  Cos[x] - x];
cdf = Compile[{{x, _Real}}, -Sin[x] - 1.0];

fastRoot[cf, cdf, {0., 1.}, 10, 30]                     (* positional *)
fastRoot[cf, cdf, {0., 1.}, AccuracyGoal->12, PrecisionGoal->12]

fastRoot[cf, cdf, {0., 1.}, "Return" -> "Value"]
(* -> 0.7390851332... *)


cf  = Compile[{{x,_Real}},  Cos[x] - x];
cdf = Compile[{{x,_Real}}, -Sin[x] - 1.0];

scanAndSolve[cf, cdf, {0., 3.}, 64, 8]
(* {0.739085...} *)

scanAndSolve[(Cos[#] - #) &, {0., 3.}, 64, 8]
(* {0.739085...} *)




  ClearAll[kernel,fC,dFC,f,df,iv,L,U]
  kernel = buildKernel[expr, param, CompilationTarget -> "C"];
  {fC, dfC} = bindUnary[kernel, params, signs];
  f[x_?NumericQ]  := fC[x];
  df[x_?NumericQ] := dfC[x];
  iv = findRootInterval[condA, params, signs];
  If[iv === $Failed, Return[$Failed]];
  {L, U} = {N@Min@iv, N@Max@iv};
  {f[L],f[U-0.01],df[L],df[U-0.01]}
    fastRoot[f, df,{L, U-0.01}] 


scanAndSolve[f, df,{L, U-0.01}]


(* cache/ensure a compiled kernel on disk *)
Options[EnsureKernelFile] = Options[buildKernel];

EnsureKernelFile[
  expr_, param_List,
  file_: Automatic,
  OptionsPattern[]
] := Module[
  {tgt = OptionValue[CompilationTarget], path = file, dir, key, kernel},

  (* choose default location when file == Automatic *)
  path = If[path === Automatic,
    dir = FileNameJoin[{$UserBaseDirectory, "A0RootPack", "kernels"}];
    If[!DirectoryQ[dir], CreateDirectory[dir, CreateIntermediateDirectories -> True]];
    key = IntegerString[Hash @ HoldComplete[expr, param, tgt], 36];
    FileNameJoin[{dir, "K-" <> key <> ".mx"}],
    path
  ];

  (* try to load existing mx *)
  If[FileExistsQ[path],
    Quiet @ Check[Get[path]; kernel = $A0Kernel;, kernel = $Failed];
    If[AssociationQ[kernel] && KeyExistsQ[kernel, "ParamOrder"] && kernel["ParamOrder"] === param,
      Return[{kernel, path}]
    ];
  ];

  (* build and save *)
  kernel = buildKernel[expr, param, CompilationTarget -> tgt];
  $A0Kernel = kernel;                                     (* private stash symbol *)
  DumpSave[path, $A0Kernel];                         (* persist for later reuse *)

  {kernel, path}
];



{kernel, file} = EnsureKernelFile[expr, param, Automatic, CompilationTarget -> "C"];
{f, df}   = bindUnary[kernel, paramsAssoc, signs];

iv = findRootInterval[condA, paramsAssoc, signs];
{L, U} = iv[[1]];
FindRoot[f[z] == 0, {z, (L + U)/2., L, U}, Method -> "Secant"]

