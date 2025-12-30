# Option dependency tree: "RootSigns"

Roots are nodes with no incoming edge for this option.

- addCoeffsSolutionN (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl)
  - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: explicit]
    - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit, use]
- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
- processModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl)
  - addCoeffsSolution (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl) [pass: implicit]