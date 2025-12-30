# Option dependency tree: "Signs"

Roots are nodes with no incoming edge for this option.

- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
- safeReduceCall (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl)
  - findRootInterval (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: explicit, use]
- solveWcPdRoots (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl)
  - solveCoeffRoots (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
    - bindUnary (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: explicit, use]
    - findRootInterval (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: explicit, use]