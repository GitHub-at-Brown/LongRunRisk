# Option dependency tree: "SignSymbol"

Roots are nodes with no incoming edge for this option.

- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
    - createCompiledEq (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: config]
      - buildKernel (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: explicit, use]
- safeReduceCall (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl)
  - findRootInterval (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: explicit, use]
- solveCoeffsSystem (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl)
  - paramQuadSolve (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/ParamQuadSolve.wl) [pass: explicit, use]
- solveWcPdRoots (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl)
  - solveCoeffRoots (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
    - findRootInterval (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: explicit, use]