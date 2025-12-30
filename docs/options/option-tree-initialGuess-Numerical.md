# Option dependency tree: "initialGuess"

Roots are nodes with no incoming edge for this option.

- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
- processModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl)
  - addCoeffsSolution (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl) [pass: implicit]
- toNum (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl)
  - toNumRules (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl) [pass: explicit]
- updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl)
  - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]