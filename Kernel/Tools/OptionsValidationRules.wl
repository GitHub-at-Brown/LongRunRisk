(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`Tools`OptionsValidationRules`"];

InstallOptionsValidationRules::usage = "InstallOptionsValidationRules[] installs option validation rules via OptionsValidation.`";

Begin["`Private`"];

InstallOptionsValidationRules[] := Module[
    {makeMsgs, checksByOwner},

    Needs["OptionsValidation`"]; (* no ErrorTools *)
    Needs["PacletizedResourceFunctions`"];

    (* Ensure owners exist *)
    PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`ManageResources`"];
    PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Tools`FindRootOptim`"];
    PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
    PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
    PacletizedResourceFunctions`NeedsDefinitions["FernandoDuarte`LongRunRisk`Model`ProcessModels`"];

    makeMsgs[owner_Symbol] := Module[{base = SymbolName[owner]},
        owner::optx = "`1` is not a valid option for " <> base <> ".";
        owner::optv = "Invalid value `1` for option `2` in " <> base <> ".";
    ];

    checksByOwner = <|
        FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels -> {
            "FromScratch" -> "Boolean",
            "CompileJacobians" -> "Boolean",
            "CreateMoments" -> "Boolean",
            "NumKernels" -> {"Integer" | "Symbol", "Min" -> 1},
            "BuildMaxMaturity" -> {"Integer", "Min" -> 1},
            "Models" -> "Any",
            "FileSuffix" -> "String",
            "UpdateManifest" -> "Boolean",
            "Verbose" -> "Boolean",
            "CompileMode" -> {"Member", {"Both", "JacobianOnly", "FunctionOnly"}},
            "Compiler" -> {"Member", {"Compile", "FunctionCompile"}},
            "FlattenExpressions" -> ("Boolean" | Automatic),
            "PdEquations" -> {"Member", {"A", "B", "AB", "Both"}}
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
            "Signs" -> "Any" (* keep permissive; or enforce list of ±1 if desired *)
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
            "GroebnerMemoryCap" -> {"Integer", "Min" -> 0},
            "Verbose" -> "Boolean"
        },

        FernandoDuarte`LongRunRisk`Model`ProcessModels`solveCoeffsSystem -> {
            "PdEquations" -> {"Member", {"A", "B", "AB", "Both"}},
            "Verbose" -> "Boolean"
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
