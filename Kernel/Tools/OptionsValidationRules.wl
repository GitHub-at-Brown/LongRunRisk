(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`Tools`OptionsValidationRules`"];

InstallOptionsValidationRules::usage = "InstallOptionsValidationRules[] installs validation rules via OptionsValidation.`";

Begin["`Private`"];

InstallOptionsValidationRules[] := Module[
    {makeMsgs, checksByOwner},

    Needs["OptionsValidation`"]; (* no ErrorTools *)
    Needs["PacletizedResourceFunctions`"];

    (* Ensure owners exist *)
    PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`Common`"];
    PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];
    PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
    PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
    PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
    PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Model`ProcessModels`"];
    PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`ToNumber`"];

    makeMsgs[owner_Symbol] := Module[{base = SymbolName[owner]},
        owner::optx = "`1` is not a valid option for " <> base <> ".";
        owner::optv = "Invalid value `1` for option `2` in " <> base <> ".";
    ];

    checksByOwner = <|
        FernandoDuarte`LongRunRisk`Tools`Common`print -> {
            "Verbose" -> {"Member", {True, False, "CI"}},
            "Memory" -> "Boolean",
            "Prefix" -> ("String" | None)
        },

        FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels -> {
            "FromScratch" -> "Boolean",
            "CompileJacobians" -> "Boolean",
            "CreateMoments" -> "Boolean",
            "NumKernels" -> {"Integer" | "Symbol", "Min" -> 1},
            "BuildMaxMaturity" -> {"Integer", "Min" -> 1},
            "Models" -> "Any",
            "FileSuffix" -> "String",
            "UpdateManifest" -> "Boolean"
        },

        FernandoDuarte`LongRunRisk`Tools`FindRootOptim`buildKernel -> {
            "CoeffName" -> "String",
            "CompileSignSymbol" -> "String",
            "CompileMode" -> {"Member", {"Both", "JacobianOnly", "FunctionOnly"}},
            "Compiler" -> {"Member", {"Compile", "FunctionCompile"}},
            "FlattenExpressions" -> ("Boolean" | Automatic),
            "AllowCompileDuringCoverage" -> "Boolean"
        },

        FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`solveCoeffRoots -> {
            "Signs" -> "Any" (* keep permissive; or enforce list of +1 and -1 if desired *)
        },

        FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve -> {
            "SymbolicSignSymbol" -> "Symbol",
            "DomainOption" -> "Any",
            "Assumptions" -> "Any",
            "Method" -> "Any",
            "MonomialOrder" -> "Any",
            "ValidationOption" -> "Boolean",
            "ReturnOption" -> {"Member", {"All", "Solution", "Equations"}},
            "TimeoutOption" -> {"Integer", "Min" -> 0},
            "SimplifyTimeout" -> "Any",
            "DiagnosticsOption" -> "Boolean",
            "OnlyQuadTerms" -> "Boolean",
            "GroebnerMemoryFraction" -> {"Real", "Min" -> 0, "Max" -> 1},
            "GroebnerMemoryFloor" -> {"Integer", "Min" -> 0},
            "GroebnerMemoryCap" -> {"Integer", "Min" -> 0}
        },

        FernandoDuarte`LongRunRisk`Model`ProcessModels`solveCoeffsSystem -> {
            "PdEquations" -> {"Member", {"B", "AB", "Both"}}
        },

        FernandoDuarte`LongRunRisk`Tools`ToNumber`toNum -> {
            "SolutionSelector" -> (
                Automatic |                    (* default: use first A solution *)
                All |                          (* return all solutions (requires ReturnAllSolutions->True) *)
                _Integer |                     (* select n-th A solution by index *)
                {_Integer, _Integer} |         (* {aIdx, bIdx} tuple: aIdx selects A solution, bIdx selects B solution for each stock *)
                _Association                   (* filter by: "SignsA" -> {1,-1,...}, "SignsB" -> {1,...},
                                                  "SolutionIndexA" -> n (n >= 1), "SolutionIndexB" -> m (m >= 1) *)
            ),
            "ReturnAllSolutions" -> "Boolean"
        }
    |>;

    KeyValueMap[
        Function[{owner, checks},
            makeMsgs[owner];
            OptionsValidation`SetDefaultOptionsValidation[
                owner,
                Map[OptionsValidation`CheckOption[owner, #] &, checks]
            ];
        ],
        checksByOwner
    ];

    True
];

End[];
EndPackage[];
