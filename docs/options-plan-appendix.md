## Appendix — option dependency trees

# Appendix: Option trees and dependency documents 

This appendix is a companion to `options-plan.md`.
## Contents

- `options/` (33 files)
- `options-forward/` (35 files)
- `options-backward/` (12 files)

---

## options (per-option trees)

<details>
<summary><code>options/option-tree-CoeffName-Compile.md</code></summary>

```markdown
# Option dependency tree: "CoeffName"

Roots are nodes with no incoming edge for this option.

- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
    - createCompiledEq (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: config]
      - buildKernel (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: explicit, use]
- safeReduceCall (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl)
  - findRootInterval (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: explicit, use]
- solveWcPdRoots (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl)
  - solveCoeffRoots (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
    - findRootInterval (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: explicit, use]
```

</details>

<details>
<summary><code>options/option-tree-CompilationTarget-Compile.md</code></summary>

```markdown
# Option dependency tree: "CompilationTarget"

Roots are nodes with no incoming edge for this option.

- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
    - createCompiledEq (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: config]
      - buildKernel (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: implicit]
```

</details>

<details>
<summary><code>options/option-tree-CompileJacobians-Build.md</code></summary>

```markdown
# Option dependency tree: "CompileJacobians"

Roots are nodes with no incoming edge for this option.

- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
```

</details>

<details>
<summary><code>options/option-tree-CompileMode-Compile.md</code></summary>

```markdown
# Option dependency tree: "CompileMode"

Roots are nodes with no incoming edge for this option.

- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
    - createCompiledEq (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: explicit]
      - buildKernel (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: implicit, use]
```

</details>

<details>
<summary><code>options/option-tree-Compiler-Compile.md</code></summary>

```markdown
# Option dependency tree: "Compiler"

Roots are nodes with no incoming edge for this option.

- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
    - createCompiledEq (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: explicit]
      - buildKernel (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: implicit, use]
```

</details>

<details>
<summary><code>options/option-tree-CreateMoments-Build.md</code></summary>

```markdown
# Option dependency tree: "CreateMoments"

Roots are nodes with no incoming edge for this option.

- buildModelsParallel (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [use]
- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
```

</details>

<details>
<summary><code>options/option-tree-FileSuffix-Build.md</code></summary>

```markdown
# Option dependency tree: "FileSuffix"

Roots are nodes with no incoming edge for this option.

- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
```

</details>

<details>
<summary><code>options/option-tree-FindRootOptions-Numerical.md</code></summary>

```markdown
# Option dependency tree: "FindRootOptions"

Roots are nodes with no incoming edge for this option.

- processModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl)
  - addCoeffsSolution (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl) [pass: implicit]
- solveWcPdRoots (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl)
  - solveCoeffRoots (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
    - scanAndSolve (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: implicit, use]
      - fastRoot (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: implicit, use]
        - fastRootCoreNew (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: implicit, use]
- toNum (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl)
  - toNumRules (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl) [pass: explicit]
    - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
      - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
- yieldCurve (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/NicePlots.wl)
  - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
    - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
```

</details>

<details>
<summary><code>options/option-tree-FromScratch-Build.md</code></summary>

```markdown
# Option dependency tree: "FromScratch"

Roots are nodes with no incoming edge for this option.

- buildModelsParallel (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [use]
- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
```

</details>

<details>
<summary><code>options/option-tree-MaxMaturity-Build.md</code></summary>

```markdown
# Option dependency tree: "MaxMaturity"

Roots are nodes with no incoming edge for this option.

- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
```

</details>

<details>
<summary><code>options/option-tree-MaxMaturity-Numerical.md</code></summary>

```markdown
# Option dependency tree: "MaxMaturity"

Roots are nodes with no incoming edge for this option.

- addCoeffsSolutionN (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl)
  - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: explicit]
    - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit, use]
- processModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl)
  - addCoeffsSolution (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl) [pass: implicit]
- toNum (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl)
  - toNumRules (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl) [pass: explicit]
    - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
      - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit, use]
- yieldCurve (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/NicePlots.wl) [use]
  - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
    - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit, use]
```

</details>

<details>
<summary><code>options/option-tree-Models-Build.md</code></summary>

```markdown
# Option dependency tree: "Models"

Roots are nodes with no incoming edge for this option.

- showPipelineReport (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/PipelineMonitor.wl)
  - buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: explicit]
    - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
```

</details>

<details>
<summary><code>options/option-tree-NumKernels-Parallel.md</code></summary>

```markdown
# Option dependency tree: "NumKernels"

Roots are nodes with no incoming edge for this option.

- buildModelsParallel (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [use]
  - buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: explicit]
    - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
```

</details>

<details>
<summary><code>options/option-tree-PdEquations-Symbolic.md</code></summary>

```markdown
# Option dependency tree: "PdEquations"

Roots are nodes with no incoming edge for this option.

- buildModelsParallel (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: implicit]
    - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
      - processModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl) [pass: config, use]
        - solveCoeffsSystem (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl) [pass: explicit, use]
```

</details>

<details>
<summary><code>options/option-tree-PerformanceGoal-Compile.md</code></summary>

```markdown
# Option dependency tree: "PerformanceGoal"

Roots are nodes with no incoming edge for this option.

- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
    - createCompiledEq (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: config]
      - buildKernel (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: implicit, use]
```

</details>

<details>
<summary><code>options/option-tree-RecurrenceTableOptions-Numerical.md</code></summary>

```markdown
# Option dependency tree: "RecurrenceTableOptions"

Roots are nodes with no incoming edge for this option.

- processModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl)
  - addCoeffsSolution (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl) [pass: implicit, use]
- toNum (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl)
  - toNumRules (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl) [pass: explicit]
    - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
      - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit, use]
- yieldCurve (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/NicePlots.wl)
  - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
    - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit, use]
```

</details>

<details>
<summary><code>options/option-tree-ReduceTimeLimit-Numerical.md</code></summary>

```markdown
# Option dependency tree: "ReduceTimeLimit"

Roots are nodes with no incoming edge for this option.

- solveCoeffRoots (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl)
  - solveND (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: explicit, use]
```

</details>

<details>
<summary><code>options/option-tree-RootSigns-Numerical.md</code></summary>

```markdown
# Option dependency tree: "RootSigns"

Roots are nodes with no incoming edge for this option.

- addCoeffsSolutionN (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl)
  - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: explicit]
    - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit, use]
- processModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl)
  - addCoeffsSolution (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl) [pass: implicit]
- toNum (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl)
  - toNumRules (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl) [pass: explicit]
    - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
      - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit, use]
- yieldCurve (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/NicePlots.wl)
  - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
    - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit, use]
```

</details>

<details>
<summary><code>options/option-tree-RuntimeOptions-Compile.md</code></summary>

```markdown
# Option dependency tree: "RuntimeOptions"

Roots are nodes with no incoming edge for this option.

- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
    - createCompiledEq (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: config]
      - buildKernel (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: implicit]
```

</details>

<details>
<summary><code>options/option-tree-SignSymbol-Compile.md</code></summary>

```markdown
# Option dependency tree: "SignSymbol"

Roots are nodes with no incoming edge for this option.

- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
    - createCompiledEq (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: config]
      - buildKernel (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: explicit, use]
```

</details>

<details>
<summary><code>options/option-tree-SignSymbol-Symbolic.md</code></summary>

```markdown
# Option dependency tree: "SignSymbol"

Roots are nodes with no incoming edge for this option.

- solveCoeffsSystem (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl)
  - paramQuadSolve (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/ParamQuadSolve.wl) [pass: explicit, use]
```

</details>

<details>
<summary><code>options/option-tree-Signs-Numerical.md</code></summary>

```markdown
# Option dependency tree: "Signs"

Roots are nodes with no incoming edge for this option.

- safeReduceCall (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl)
  - findRootInterval (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: explicit, use]
- solveWcPdRoots (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl)
  - solveCoeffRoots (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
    - bindUnary (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: explicit, use]
    - findRootInterval (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/FindRootOptim.wl) [pass: explicit, use]
```

</details>

<details>
<summary><code>options/option-tree-SimplifyOptions-Symbolic.md</code></summary>

```markdown
# Option dependency tree: "SimplifyOptions"

Roots are nodes with no incoming edge for this option.

- simplifyCoeffsSystem (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl) [use]
- solveCoeffsSystem (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl) [use]
- tryTransforms (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl) [use]
```

</details>

<details>
<summary><code>options/option-tree-UpdateBond-Numerical.md</code></summary>

```markdown
# Option dependency tree: "UpdateBond"

Roots are nodes with no incoming edge for this option.

- toNum (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl)
  - toNumRules (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl) [pass: explicit]
    - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
      - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit, use]
- yieldCurve (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/NicePlots.wl)
  - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
    - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit, use]
```

</details>

<details>
<summary><code>options/option-tree-UpdateBonds-Numerical.md</code></summary>

```markdown
# Option dependency tree: "UpdateBonds"

Roots are nodes with no incoming edge for this option.

- addCoeffsSolutionN (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl)
  - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: explicit]
    - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit, use]
- toNum (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl)
  - toNumRules (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl) [pass: explicit]
    - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: explicit]
      - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit, use]
- yieldCurve (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/NicePlots.wl)
  - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
    - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit, use]
```

</details>

<details>
<summary><code>options/option-tree-UpdateManifest-Build.md</code></summary>

```markdown
# Option dependency tree: "UpdateManifest"

Roots are nodes with no incoming edge for this option.

- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
```

</details>

<details>
<summary><code>options/option-tree-UpdateNomBond-Numerical.md</code></summary>

```markdown
# Option dependency tree: "UpdateNomBond"

Roots are nodes with no incoming edge for this option.

- toNum (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl)
  - toNumRules (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl) [pass: explicit]
    - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
      - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit, use]
- yieldCurve (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/NicePlots.wl)
  - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
    - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit, use]
```

</details>

<details>
<summary><code>options/option-tree-UpdatePd-Numerical.md</code></summary>

```markdown
# Option dependency tree: "UpdatePd"

Roots are nodes with no incoming edge for this option.

- addCoeffsSolutionN (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl)
  - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: explicit]
    - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit, use]
- toNum (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl)
  - toNumRules (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl) [pass: explicit]
    - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: explicit]
      - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit, use]
- yieldCurve (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/NicePlots.wl)
  - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
    - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit, use]
```

</details>

<details>
<summary><code>options/option-tree-initialGuess-Numerical.md</code></summary>

```markdown
# Option dependency tree: "initialGuess"

Roots are nodes with no incoming edge for this option.

- processModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl)
  - addCoeffsSolution (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl) [pass: implicit]
- toNum (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl)
  - toNumRules (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ToNumber.wl) [pass: explicit]
    - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
      - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
- yieldCurve (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/NicePlots.wl)
  - updateCoeffs (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
    - updateCoeffsSol (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [pass: implicit]
- getStartingValues (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/SolveEulerEq.wl) [use]
```

</details>

<details>
<summary><code>options/option-tree-maxMomentsLagsToCreate-Moments.md</code></summary>

```markdown
# Option dependency tree: "maxMomentsLagsToCreate"

Roots are nodes with no incoming edge for this option.

- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
    - createDatabase (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/CreateMomentsDatabase.wl) [pass: config, use]
```

</details>

<details>
<summary><code>options/option-tree-paramQuadSolveOptions-Symbolic.md</code></summary>

```markdown
# Option dependency tree: "paramQuadSolveOptions"

Roots are nodes with no incoming edge for this option.

- solveCoeffsSystem (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ProcessModels.wl) [use]
```

</details>

<details>
<summary><code>options/option-tree-simplifyDownValues-Moments.md</code></summary>

```markdown
# Option dependency tree: "simplifyDownValues"

Roots are nodes with no incoming edge for this option.

- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
    - createDatabase (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/CreateMomentsDatabase.wl) [pass: config, use]
```

</details>

<details>
<summary><code>options/option-tree-startSequenceAtLag-Moments.md</code></summary>

```markdown
# Option dependency tree: "startSequenceAtLag"

Roots are nodes with no incoming edge for this option.

- buildModels (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl)
  - buildModelsInternal (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Tools/ManageResources.wl) [pass: config]
    - createDatabase (/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/ComputationalEngine/CreateMomentsDatabase.wl) [pass: config, use]
```

</details>

---

## options-forward (per-option forward propagation)

<details>
<summary><code>options-forward/Checks.md</code></summary>

````markdown
# Checks Option

**Location in config:** `config["Numerical"]["Checks"]`
**Default value:** Nested Association (see below)
**Subsystem:** Numerical

## Default Structure

```wolfram
"Checks" -> <|
  "PrintResidualsNorm" -> False,
  "CheckResiduals" -> False,
  "Tol" -> 10.^-16
|>
```

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ updateCoeffs[model, kernels, opts...]
   └─ Direct option forwarding

CONFIGURATION LAYER
│
└─ defaultConfig[]
   └─ "Checks" defined in "Numerical" subsystem (lines 125-129)

NOTE: Checks options are NOT extracted via splitConfig["Numerical"]

NUMERICAL SOLVING PATH
│
└─ updateCoeffsSol[model, kernels, newParams, guessCoeffs, opts...]
   │
   ├─ doChecks = OptionValue["PrintResidualsNorm"] || OptionValue["CheckResiduals"]
   ├─ checkOpts = FilterRules[opts, Options[checks]]
   │
   └─ If[doChecks, checkCoeffs[type, model, sol, params, newParams, maxMaturity, numStocks, checkOpts]]
      │
      └─ checks[eqs, sol, params, newParams, opts]  ◄── TERMINAL CONSUMER
         │
         ├─ If CheckResiduals && residualsNorm >= Tol: Abort[]
         └─ If PrintResidualsNorm: Print residual info
```

## Configuration Gap

**Important:** The `addCoeffsSolutionN` function (lines 1036-1046 in SolveEulerEq.wl) does NOT forward configuration options to `updateCoeffs`. It only passes the model. This means Checks options from buildModels configuration are NOT propagated to the numerical solving phase.

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 125-129 | Default nested structure defined |

### Terminal Consumer: `checks` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 719-744 | Function definition |
| Line 722 | Options: `"PrintResidualsNorm"->False, "CheckResiduals"->False, "Tol"->10.^-16` |
| Line 731 | Computes `residualsNorm` |
| Lines 733-738 | Uses `CheckResiduals` and `Tol` for validation |
| Line 740 | Uses `PrintResidualsNorm` for output |

**Validation logic:**
```wolfram
If[OptionValue["CheckResiduals"],
  If[residualsNorm >= OptionValue["Tol"],
    Message[checks::largeresid, residualsNorm, OptionValue["Tol"]];
    Abort[],
    Message[checks::smallresid, residualsNorm, OptionValue["Tol"]]
  ],
  If[OptionValue["PrintResidualsNorm"],
    Message[checks::norm, residualsNorm]
  ]
]
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 125-129 | Defines defaults |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Wrapper |
| Forwarder | `updateCoeffsSol` | SolveEulerEq.wl | 575-690 | Extracts and filters options |
| Dispatcher | `checkCoeffs` | SolveEulerEq.wl | 500-514 | Routes to checks |
| **Consumer** | `checks` | SolveEulerEq.wl | 719-744 | **Terminal consumer** |

## Sub-Option Descriptions

| Option | Default | Purpose |
|--------|---------|---------|
| PrintResidualsNorm | False | Print residual norm (informational) |
| CheckResiduals | False | Validate residuals against Tol |
| Tol | 10^-16 | Tolerance threshold for validation |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - validation |
| Nested structure | Yes - Association with 3 keys |
| Configuration gap | addCoeffsSolutionN does not forward options |
| Error handling | Abort[] when CheckResiduals fails |
| Mutual exclusivity | PrintResidualsNorm only runs if CheckResiduals is False |
````

</details>

<details>
<summary><code>options-forward/CoeffName.md</code></summary>

````markdown
# CoeffName Option

**Location in config:** `config["Compile"]["CoeffName"]`
**Default value:** `"A"`
**Legacy mapping:** `"CoeffName" -> {"Compile", "CoeffName"}` in OptionsConfig.wl:170

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ buildModels[...] (delegates)

ORCHESTRATION LAYER
│
└─ buildModelsInternal[config_Association]
   │
   └─ splitConfig[config, "Compile"]  ◄── EXTRACTS "CoeffName"
      │
      └─ createCompiledEq[model, resourcesDir, opts...]
         │
         └─ buildKernel[expr, vars, params, "CoeffName" -> value, ...]
            │  ◄── TERMINAL CONSUMER
            ├─ Validates no unexpected coefficient symbols
            └─ Stores in output Association for downstream use

DOWNSTREAM USAGE
│
└─ solveCoeffRoots[..., savedKernel, ...]
   │
   ├─ cName = Lookup[savedKernel, "CoeffName"]
   │
   └─ findRootInterval[..., "CoeffName" -> cName, ...]  ◄── TERMINAL CONSUMER
      └─ Extracts root variable by matching symbol name
```

## Entry Points (Public API)

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration in `Options[buildModels]` |
| Line 821 | Pattern: `buildModels[config_Association]` |
| Line 825 | Pattern: `buildModels[opts___?OptionQ]` |

**How received:** Via `OptionsPattern` or config Association
**How forwarded:** Config passed to `buildModelsInternal`

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 96 | Default: `"CoeffName" -> "A"` inside `"Compile"` subsystem |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 308-316 | `splitConfig[config, "Compile"]` definition |
| Line 309 | Extracts: `"CoeffName" -> config["Compile"]["CoeffName"]` |

## Intermediate Forwarders

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 829 | Receives normalized config as parameter |
| Line 998 | Calls `createCompiledEq` with `splitConfig[config, "Compile"]` |

**How forwarded:** Via `splitConfig[config, "Compile"]`

### `createCompiledEq` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 1476-1533 | Function definition |
| Line 1517 | Extracts CoeffName from equation map |
| Line 1518 | Forwards to `buildKernel` with `"CoeffName" -> eqMap[eq]["CoeffName"]` |

**How received:** Via `OptionsPattern[{buildKernel, FunctionCompile, Compile}]`
**How forwarded:** Explicitly passed to `buildKernel`

## Terminal Consumers

### `buildKernel` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Line 83 | Option declaration: `"CoeffName" -> "A"` |
| Line 102 | Extraction: `coeffName = OptionValue["CoeffName"]` |
| Line 133 | Validation: pattern matching for unexpected coeff symbols |
| Line 354 | Storage: `"CoeffName" -> coeffName` in output Association |

**Validation logic:**
```wolfram
Cases[ex0, s_Symbol /; SymbolName[s] === coeffName, Infinity]
```

Used to detect if expression contains coefficient variables that shouldn't be there.

### `findRootInterval` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Line 431 | Option declaration: `"CoeffName" -> "A"` |
| Line 443 | Extraction: `coeffName = OptionValue["CoeffName"]` |
| Lines 456-462 | Root variable extraction via pattern matching |

**Pattern matching logic:**
```wolfram
Cases[condExpr, s_Symbol[0] /; SymbolName[s] === coeffName :> s[0], Infinity]
```

Used to locate the coefficient variable to solve for (e.g., A[0], B[1][0]).

### `solveCoeffRoots` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Line 830 | Retrieves from kernel: `cName = Lookup[savedKernel, "CoeffName"]` |
| Line 862 | Forwards to `findRootInterval[..., "CoeffName" -> cName, ...]` |
| Line 854 | Forwards to `solveND[..., cName, ...]` |

### `solveND` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 212-261 | Function definition |
| Line 245 | Passes `cName` to `safeReduceCall` |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Config | `defaultConfig` | OptionsConfig.wl | 96 | Default value |
| Config | `splitConfig` | OptionsConfig.wl | 308-316 | Extracts Compile options |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 829, 998 | Forwards via splitConfig |
| Forwarder | `createCompiledEq` | FindRootOptim.wl | 1476-1533 | Extracts from eqMap, forwards to buildKernel |
| **Consumer** | `buildKernel` | FindRootOptim.wl | 83, 102, 133, 354 | Validation, storage |
| **Consumer** | `findRootInterval` | FindRootOptim.wl | 431, 443, 456-462 | Root variable extraction |
| Forwarder | `solveCoeffRoots` | SolveEulerEq.wl | 830, 862 | Retrieves from kernel, forwards |
| Consumer | `solveND` | SolveEulerEq.wl | 212-261 | Uses for root-finding |

## Propagation Paths

### Path A: Compilation Phase
```
buildModels["CoeffName" -> "A"]
  → normalizeConfig → config["Compile"]["CoeffName"] = "A"
  → buildModelsInternal[config]
  → splitConfig[config, "Compile"] → "CoeffName" -> "A"
  → createCompiledEq[..., "CoeffName" -> "A", ...]
  → buildKernel[..., "CoeffName" -> "A"]
  → Validates symbols, stores in output Association
```

### Path B: Root-Finding Phase
```
solveCoeffRoots[..., savedKernel, ...]
  → cName = Lookup[savedKernel, "CoeffName"]
  → findRootInterval[..., "CoeffName" -> cName, ...]
  → Extracts root variable by symbol name matching
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Compile and Numerical phases |
| Typical values | `"A"` (wealth-consumption), `"B"` (price-dividend) |
| Purpose | Identifies coefficient variable symbol name |
| Validation | Checks for unexpected coefficient symbols |
| Caching | Stored in kernel Association for reuse |
| Error messages | `buildKernel::badvars`, `findRootInterval::nocoeff` |
````

</details>

<details>
<summary><code>options-forward/CompilationTarget.md</code></summary>

````markdown
# CompilationTarget Option

**Location in config:** `config["Compile"]["CompilationTarget"]`
**Default value:** `"C"`
**Legacy mapping:** `"CompilationTarget" -> {"Compile", "CompilationTarget"}` in OptionsConfig.wl:173

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ buildModels[...] (delegates)

ORCHESTRATION LAYER
│
└─ buildModelsInternal[config_Association]
   │
   └─ splitConfig[config, "Compile"]  ◄── EXTRACTS "CompilationTarget"
      │
      └─ createCompiledEq[model, resourcesDir, opts...]
         │
         └─ buildKernel[..., opts...]
            │  ◄── TERMINAL CONSUMER
            │
            └─ Compile[..., CompilationTarget -> "C", ...]
```

## Entry Points (Public API)

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration in `Options[buildModels]` |
| Line 821 | Pattern: `buildModels[config_Association]` |
| Line 825 | Pattern: `buildModels[opts___?OptionQ]` |

**How received:** Via `OptionsPattern` or config Association
**How forwarded:** Config passed to `buildModelsInternal`

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 102 | Default: `"CompilationTarget" -> "C"` |

### `normalizeConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 173 | Legacy mapping: `"CompilationTarget" -> {"Compile", "CompilationTarget"}` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 308-316 | `splitConfig[config, "Compile"]` definition |
| Line 315 | Extracts: `"CompilationTarget" -> config["Compile"]["CompilationTarget"]` |

## Intermediate Forwarders

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 829 | Receives normalized config as parameter |
| Lines 995-998 | Calls `createCompiledEq` with `splitConfig[config, "Compile"]` |

**How forwarded:** Via `splitConfig[config, "Compile"]`

### `createCompiledEq` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 1476-1533 | Function definition |
| Line 1479 | Filters via `FilterRules[..., Options[Compile]]` |
| Lines 1480-1481 | Used for hash computation |
| Lines 1513-1520 | Forwards to `buildKernel` via `Sequence @@ buildKernelOpts` |

**How received:** Via `OptionsPattern[{buildKernel, FunctionCompile, Compile}]`
**How forwarded:** Via FilterRules to `buildKernel`

## Terminal Consumer

### `buildKernel` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 83-91 | Option declarations (CompilationTarget inherited from Compile) |
| Line 193 | Default application if not specified |
| Lines 254-259 | Passed to `Compile[...]` |

**Default application (line 193):**
```wolfram
If[FreeQ[userOpts, CompilationTarget], {CompilationTarget -> "C"}, {}]
```

**Compile call (lines 254-259):**
```wolfram
Compile[
  Evaluate @ convertTypesForCompile[Flatten@{funcArgs}],
  Evaluate @ (funcBody /. TypeHint[e_, _] :> e),
  Evaluate[Sequence @@ compOpts]  (* <-- CompilationTarget included here *)
]
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Config | `defaultConfig` | OptionsConfig.wl | 102 | Default "C" |
| Config | `normalizeConfig` | OptionsConfig.wl | 173 | Legacy mapping |
| Config | `splitConfig` | OptionsConfig.wl | 308-316 | Extracts Compile options |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 829, 995-998 | Forwards via splitConfig |
| Forwarder | `createCompiledEq` | FindRootOptim.wl | 1476-1533 | Hash, forwards via FilterRules |
| **Consumer** | `buildKernel` | FindRootOptim.wl | 193, 254-259 | **Terminal consumer** |
| Built-in | `Compile` | (System) | N/A | Ultimate consumer |

## Propagation Paths

### Path A: Via Normalized Config (Recommended)
```
buildModels["CompilationTarget" -> "C"]
  → normalizeConfig → config["Compile"]["CompilationTarget"] = "C"
  → buildModelsInternal[config]
  → splitConfig[config, "Compile"] → "CompilationTarget" -> "C"
  → createCompiledEq[..., "CompilationTarget" -> "C", ...]
  → buildKernel[..., "CompilationTarget" -> "C", ...]
  → Compile[..., CompilationTarget -> "C", ...]
```

### Path B: Default Application
```
buildModels[]  (* no CompilationTarget specified *)
  → ... → buildKernel
  → FreeQ[userOpts, CompilationTarget] = True
  → Default applied: {CompilationTarget -> "C"}
  → Compile[..., CompilationTarget -> "C", ...]
```

## Valid Values

| Value | Description |
|-------|-------------|
| `"C"` | Compile to C code (default, most portable) |
| `"WVM"` | Compile to Wolfram Virtual Machine bytecode |
| `"MVM"` | Compile to MVM bytecode |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Compile phase only |
| Default | `"C"` |
| Impact | Determines compilation output format |
| Default application | Applied if not explicitly specified |
| Only for Compile | Not used with FunctionCompile backend |
| Terminal consumer | `Compile` (Wolfram built-in) |
| Hash impact | Affects compiled file cache key |
````

</details>

<details>
<summary><code>options-forward/CompileJacobians.md</code></summary>

````markdown
# CompileJacobians Option

**Location in config:** `config["Build"]["CompileJacobians"]`
**Default value:** `True`
**Legacy mapping:** `"CompileJacobians" -> {"Build", "CompileJacobians"}` in OptionsConfig.wl:178

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ Forwards via filteredOpts to buildModels

CONFIGURATION LAYER
│
└─ splitConfig[config, "Build"]  ◄── EXTRACTS "CompileJacobians"
   │
   └─ "CompileJacobians" -> config["Build"]["CompileJacobians"]

BUILD ORCHESTRATION
│
└─ buildModelsInternal[config_Association]
   │
   ├─ compileJacobians = config["Build"]["CompileJacobians"]  (line 832)
   │
   ├─ determineModelStatus[..., compileJacobians, ...]  (line 912-914)
   │  │  ◄── INTERMEDIATE FORWARDER
   │  │
   │  └─ Returns "NeedsJacobians" -> compileJacobians
   │     in model status dictionary
   │
   └─ If[compileJacobians && Length[modelsNeedingJacobians] > 0,
        Do[
          createCompiledEq[model, compiledDir,
            "CompileMode" -> "JacobianOnly", ...]
        , {modelKey, modelsNeedingJacobians}]
      ]  ◄── TERMINAL CONSUMER (lines 1005-1020)
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 148 | Default: `"CompileJacobians" -> True` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 368-377 | `splitConfig[config, "Build"]` definition |
| Line 372 | Extracts: `"CompileJacobians" -> config["Build"]["CompileJacobians"]` |

## Entry Points

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration: `"CompileJacobians" -> False` |
| Lines 821-826 | Entry patterns (config or legacy options) |

**Note:** Option default in buildModels (False) differs from defaultConfig (True). The config value takes precedence.

### `buildModelsParallel` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 1138-1143 | Does NOT declare CompileJacobians |
| Lines 1188-1189 | Passes through via filteredOpts |
| Lines 1191-1210 | Forwards to each parallel buildModels call |

## Intermediate Forwarder

### `determineModelStatus` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 712-772 | Function definition |
| Line 713 | Receives `compileJacobians_` as 7th parameter |
| Lines 723, 730, 738, 744, 754 | Returns `"NeedsJacobians" -> compileJacobians` |
| Lines 761-769 | Validates existing jacobian files if True |

**Usage in determineModelStatus:**
```wolfram
If[compileJacobians,
  With[{jacFile = resolveCompiledMxFile[compiledDir, shortname, "_jacobians"]},
    validation = validateCompiledFile[jacFile, savedModel, "JacobianOnly", ...];
    If[!validation["Valid"],
      Return[<|"MainStage" -> "UpToDate", "NeedsJacobians" -> True, ...|>]
    ]
  ]
]
```

## Terminal Consumer

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 832 | `compileJacobians = config["Build"]["CompileJacobians"]` |
| Lines 1005-1020 | Jacobian compilation phase |

**Jacobian compilation phase:**
```wolfram
If[compileJacobians && Length[modelsNeedingJacobians] > 0,
  Do[
    shortname = catalogModels[modelKey]["shortname"];
    createCompiledEq[
      processedModels[shortname],
      compiledDir,
      "CompileMode" -> "JacobianOnly",
      "Compiler" -> compilerChoice
    ];
  , {modelKey, modelsNeedingJacobians}
  ]
]
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 148 | Default True |
| Config | `splitConfig` | OptionsConfig.wl | 368-377 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 568-578, 821-826 | Public API |
| Entry | `buildModelsParallel` | ManageResources.wl | 1145, 1188-1189 | Parallel orchestrator |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 832 | Extracts from config |
| Forwarder | `buildModelsInternal` | ManageResources.wl | 912-914 | Passes to determineModelStatus |
| Forwarder | `determineModelStatus` | ManageResources.wl | 712-772 | Validates and returns status |
| **Consumer** | `buildModelsInternal` | ManageResources.wl | 1005-1020 | **Jacobian compilation** |

## Output Files

When True, creates jacobian-only compiled function files:
- `Resources/CompiledFunctions/$SystemID/{shortname}_jacobians.mx`

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Build phase - jacobian function compilation |
| Default | `True` |
| When True | Creates separate compiled jacobian functions |
| When False | Skips jacobian compilation entirely |
| Status key | `"NeedsJacobians"` in model status dictionary |
| Called function | `createCompiledEq` with `"CompileMode" -> "JacobianOnly"` |
| Consumer count | Single terminal consumer with one forwarder |
````

</details>

<details>
<summary><code>options-forward/CompileMode.md</code></summary>

````markdown
# CompileMode Option

**Location in config:** `config["Compile"]["CompileMode"]`
**Default value:** `"Both"`
**Valid values:** `"Both"` | `"FunctionOnly"` | `"JacobianOnly"`
**Legacy mapping:** `"CompileMode" -> {"Compile", "CompileMode"}` in OptionsConfig.wl:169

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ buildModels[...] (delegates)

ORCHESTRATION LAYER
│
└─ buildModelsInternal[config_Association]
   │
   ├─ compileMode = config["Compile"]["CompileMode"]
   │
   └─ splitConfig[config, "Compile"]  ◄── EXTRACTS "CompileMode"
      │
      ├─ createCompiledEq[..., "CompileMode" -> "Both", ...]
      │  └─ Standard compilation path
      │
      └─ createCompiledEq[..., "CompileMode" -> "JacobianOnly", ...]
         └─ Override for Jacobian-only compilation (line 1013)

      └─ buildKernel[..., "CompileMode" -> value, ...]
         │  ◄── TERMINAL CONSUMER
         │
         └─ Switch[compileMode,
              "FunctionOnly" → {fC, Missing["NotCompiled"]},
              "JacobianOnly" → {Missing["NotCompiled"], dfC},
              "Both" → {fC, dfC}
            ]
```

## Entry Points (Public API)

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration in `Options[buildModels]` |
| Line 821 | Pattern: `buildModels[config_Association]` |
| Line 825 | Pattern: `buildModels[opts___?OptionQ]` |
| Lines 822, 826 | Normalizes via `normalizeConfig[]` |

**How received:** Via `OptionsPattern` or config Association
**How forwarded:** Config passed to `buildModelsInternal`

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 99 | Default: `"CompileMode" -> "Both"` |

### `normalizeConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 169 | Legacy mapping: `"CompileMode" -> {"Compile", "CompileMode"}` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 308-316 | `splitConfig[config, "Compile"]` definition |
| Line 312 | Extracts: `"CompileMode" -> config["Compile"]["CompileMode"]` |

## Intermediate Forwarders

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 829 | Receives normalized config as parameter |
| Line 840 | Extracts: `compileMode = config["Compile"]["CompileMode"]` |
| Lines 995-998 | Standard call to `createCompiledEq` with splitConfig |
| Line 1013 | Override call with `"CompileMode" -> "JacobianOnly"` |

**How forwarded:** Via `splitConfig[config, "Compile"]` or explicit override

### `createCompiledEq` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 1476-1533 | Function definition |
| Line 1480 | Extracts: `compileMode = OptionValue["CompileMode"]` |
| Line 1487 | Uses for filename: different suffix for "JacobianOnly" |
| Line 1495 | Uses for cache key |
| Lines 1513-1520 | Forwards to `buildKernel` via `Sequence @@ buildKernelOpts` |

**How received:** Via `OptionsPattern[{buildKernel, FunctionCompile, Compile}]`
**How forwarded:** Via FilterRules to `buildKernel`

## Terminal Consumer

### `buildKernel` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Line 87 | Option declaration: `"CompileMode" -> "FunctionOnly"` |
| Line 105 | Extraction: `compileMode = OptionValue["CompileMode"]` |
| Line 162 | Controls expression flattening (only for "FunctionOnly") |
| Lines 282-350 | Switch statement controls compilation logic |

**Switch logic (lines 282-350):**
```wolfram
Switch[compileMode,
  "FunctionOnly",
    (* Lines 283-310: Compile only function *)
    fC = If[compiler === "FunctionCompile",
      FunctionCompile[...],
      Compile[...]
    ];
    {fC, Missing["NotCompiled"]},

  "JacobianOnly",
    (* Lines 311-325: Compile only jacobian *)
    dfC = If[compiler === "FunctionCompile",
      FunctionCompile[...],
      Compile[...]
    ];
    {Missing["NotCompiled"], dfC},

  "Both",
    (* Lines 326-346: Compile both function and jacobian *)
    fC = ...;
    dfC = ...;
    {fC, dfC},

  _,
    (* Line 348: Invalid value error *)
    Message[buildKernel::badmode, compileMode];
    $Failed
]
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Config | `defaultConfig` | OptionsConfig.wl | 99 | Default "Both" |
| Config | `normalizeConfig` | OptionsConfig.wl | 169 | Legacy mapping |
| Config | `splitConfig` | OptionsConfig.wl | 308-316 | Extracts Compile options |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 840, 998, 1013 | Extracts, forwards, overrides |
| Forwarder | `createCompiledEq` | FindRootOptim.wl | 1480, 1487, 1495 | Filename, caching |
| **Consumer** | `buildKernel` | FindRootOptim.wl | 87, 105, 162, 282-350 | **Terminal consumer** |

## Propagation Paths

### Path A: Standard Compilation (Both)
```
buildModels["CompileMode" -> "Both"]
  → normalizeConfig → config["Compile"]["CompileMode"] = "Both"
  → buildModelsInternal[config]
  → splitConfig[config, "Compile"] → "CompileMode" -> "Both"
  → createCompiledEq[..., "CompileMode" -> "Both", ...]
  → buildKernel[..., "CompileMode" -> "Both"]
  → Switch: compiles both fC and dfC
  → Returns {fC, dfC}
```

### Path B: Jacobian-Only Override
```
buildModelsInternal[config]
  → createCompiledEq[..., "CompileMode" -> "JacobianOnly", ...]
  → buildKernel[..., "CompileMode" -> "JacobianOnly"]
  → Switch: compiles only dfC
  → Returns {Missing["NotCompiled"], dfC}
```

### Path C: Function-Only
```
buildModels["CompileMode" -> "FunctionOnly"]
  → ... → buildKernel[..., "CompileMode" -> "FunctionOnly"]
  → Switch: compiles only fC
  → Expression flattening enabled (line 162)
  → Returns {fC, Missing["NotCompiled"]}
```

## Mode Comparison

| Mode | Function (fC) | Jacobian (dfC) | Flattening | Use Case |
|------|---------------|----------------|------------|----------|
| "Both" | Compiled | Compiled | No | Full numerical solving |
| "FunctionOnly" | Compiled | Missing | Yes | Fast evaluation without derivatives |
| "JacobianOnly" | Missing | Compiled | No | Derivative-only computations |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Compile phase |
| Default | `"Both"` in config, `"FunctionOnly"` in buildKernel |
| Impact | Controls which objects are compiled (function, jacobian, or both) |
| Cache impact | Different modes produce different cache keys |
| Filename impact | "JacobianOnly" uses different file suffix |
| Error handling | Invalid values trigger `buildKernel::badmode` |
| Override pattern | `buildModelsInternal` can override with "JacobianOnly" |
````

</details>

<details>
<summary><code>options-forward/Compiler.md</code></summary>

````markdown
# Compiler Option

**Location in config:** `config["Compile"]["Compiler"]`
**Default value:** `"Compile"`
**Valid values:** `"Compile"` | `"FunctionCompile"`
**Legacy mapping:** `"Compiler" -> {"Compile", "Compiler"}` in OptionsConfig.wl:168

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ buildModels[...] (delegates)

ORCHESTRATION LAYER
│
└─ buildModelsInternal[config_Association]
   │
   ├─ compilerChoice = config["Compile"]["Compiler"]
   │
   └─ splitConfig[config, "Compile"]  ◄── EXTRACTS "Compiler"
      │
      └─ createCompiledEq[model, resourcesDir, opts...]
         │
         └─ buildKernel[..., "Compiler" -> value, ...]
            │  ◄── TERMINAL CONSUMER
            │
            └─ compileWithDiagnostics[..., useCompiler, ...]
               │
               ├─ If "FunctionCompile": FunctionCompile[...]
               └─ If "Compile": Compile[...]
```

## Entry Points (Public API)

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration in `Options[buildModels]` |
| Line 821 | Pattern: `buildModels[config_Association]` |
| Line 825 | Pattern: `buildModels[opts___?OptionQ]` |
| Lines 822, 826 | Normalizes via `normalizeConfig[]` |

**How received:** Via `OptionsPattern` or config Association
**How forwarded:** Config passed to `buildModelsInternal`

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 100 | Default: `"Compiler" -> "Compile"` |

### `normalizeConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 168 | Legacy mapping: `"Compiler" -> {"Compile", "Compiler"}` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 308-316 | `splitConfig[config, "Compile"]` definition |
| Line 313 | Extracts: `"Compiler" -> config["Compile"]["Compiler"]` |

## Intermediate Forwarders

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 829 | Receives normalized config as parameter |
| Line 841 | Extracts: `compilerChoice = config["Compile"]["Compiler"]` |
| Lines 995-998 | Calls `createCompiledEq` with `splitConfig[config, "Compile"]` |
| Line 1014 | Also passes directly as `"Compiler" -> compilerChoice` |

**How forwarded:** Via `splitConfig[config, "Compile"]` or explicit rule

### `createCompiledEq` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 1476-1533 | Function definition |
| Line 1481 | Extracts: `compilerChoice = ("Compiler" /. ...) /. "Compiler" -> "Compile"` |
| Lines 1513-1520 | Forwards to `buildKernel` via `Sequence @@ buildKernelOpts` |

**How received:** Via `OptionsPattern[{buildKernel, FunctionCompile, Compile}]`
**How forwarded:** Via FilterRules to `buildKernel`

## Terminal Consumer

### `buildKernel` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Line 88 | Option declaration: `"Compiler" -> "Compile"` |
| Line 106 | Extraction: `compiler = OptionValue["Compiler"]` |
| Lines 180-199 | Uses compiler value to determine compilation path |
| Line 246 | Passes to `compileWithDiagnostics[..., useCompiler, ...]` |

**Compilation logic:**
```wolfram
Switch[compiler,
  "FunctionCompile",
    FunctionCompile[func, ...],
  "Compile",
    Compile[func, ..., CompilationTarget -> "C", ...]
]
```

### `compileWithDiagnostics` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Line 246 | Receives `useCompiler` parameter |
| Internal | Selects between FunctionCompile and Compile based on useCompiler value |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Config | `defaultConfig` | OptionsConfig.wl | 100 | Default "Compile" |
| Config | `normalizeConfig` | OptionsConfig.wl | 168 | Legacy mapping |
| Config | `splitConfig` | OptionsConfig.wl | 308-316 | Extracts Compile options |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 841, 998, 1014 | Extracts and forwards |
| Forwarder | `createCompiledEq` | FindRootOptim.wl | 1476-1533 | Extracts, forwards to buildKernel |
| **Consumer** | `buildKernel` | FindRootOptim.wl | 88, 106, 180-199 | **Terminal consumer** |
| Internal | `compileWithDiagnostics` | FindRootOptim.wl | 246 | Actual compilation call |

## Propagation Paths

### Path A: Via Normalized Config (Recommended)
```
buildModels["Compiler" -> "FunctionCompile"]
  → normalizeConfig → config["Compile"]["Compiler"] = "FunctionCompile"
  → buildModelsInternal[config]
  → splitConfig[config, "Compile"] → "Compiler" -> "FunctionCompile"
  → createCompiledEq[..., "Compiler" -> "FunctionCompile", ...]
  → buildKernel[..., "Compiler" -> "FunctionCompile"]
  → compiler = "FunctionCompile"
  → FunctionCompile[...]
```

### Path B: Default (Compile)
```
buildModels[]
  → normalizeConfig → config["Compile"]["Compiler"] = "Compile"
  → ... → buildKernel
  → compiler = "Compile"
  → Compile[..., CompilationTarget -> "C", ...]
```

## Compiler Comparison

| Aspect | "Compile" | "FunctionCompile" |
|--------|-----------|-------------------|
| Backend | Traditional Compile | LLVM-based |
| Target | C code generation | Native compilation |
| Speed | Faster compilation | Faster execution |
| Compatibility | All platforms | Limited platforms |
| Error handling | RuntimeOptions | CompilerRuntimeErrorAction |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Compile phase only |
| Default | `"Compile"` |
| Impact | Determines which compilation backend is used |
| Terminal consumer | `buildKernel` (and `compileWithDiagnostics`) |
| Related options | PerformanceGoal, RuntimeOptions, CompilationTarget |
````

</details>

<details>
<summary><code>options-forward/CreateMoments.md</code></summary>

````markdown
# CreateMoments Option

**Location in config:** `config["Build"]["CreateMoments"]`
**Default value:** `True`
**Legacy mapping:** `"CreateMoments" -> {"Build", "CreateMoments"}` in OptionsConfig.wl:179

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   ├─ createMoments = OptionValue["CreateMoments"]
   ├─ buildModels[..., "CreateMoments" -> False, ...]  (parallel phase)
   └─ If[createMoments, buildModels[..., "CreateMoments" -> True, ...]]  (sequential)

CONFIGURATION LAYER
│
└─ splitConfig[config, "Build"]  ◄── EXTRACTS "CreateMoments"
   │
   └─ "CreateMoments" -> config["Build"]["CreateMoments"]

BUILD ORCHESTRATION
│
└─ buildModelsInternal[config_Association]
   │
   ├─ createMoments = config["Build"]["CreateMoments"]  (line 833)
   │
   ├─ determineModelStatus[..., createMoments, ...]  (line 912-914)
   │  │  ◄── INTERMEDIATE FORWARDER
   │  │
   │  └─ If[createMoments,
   │       (* validate moments cache *)
   │       If[!momentsUpToDate[...],
   │         Return[<|"MainStage" -> "Moments", ...|>]
   │       ]
   │     ]  ◄── TERMINAL CONSUMER #1
   │
   └─ If[createMoments,
        (* Phase 4: Moments *)
        Do[
          createDatabase[model, momentsFile,
            splitConfig[config, "Moments"]]
        , {modelKey, momentsModels}]
      ]  ◄── TERMINAL CONSUMER #2 (lines 1072-1122)
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 149 | Default: `"CreateMoments" -> True` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 368-377 | `splitConfig[config, "Build"]` definition |
| Line 373 | Extracts: `"CreateMoments" -> config["Build"]["CreateMoments"]` |

## Entry Points

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration: `"CreateMoments" -> True` |
| Lines 821-826 | Entry patterns (config or legacy options) |

### `buildModelsParallel` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 1138-1143 | Option declaration: `"CreateMoments" -> True` |
| Line 1154 | `createMoments = OptionValue["CreateMoments"]` |
| Line 1195 | Forces `"CreateMoments" -> False` in parallel workers |
| Lines 1261-1272 | Sequential moments phase if True |

## Intermediate Forwarder

### `buildModelsInternal` → `determineModelStatus`

| Location | What happens |
|----------|--------------|
| Lines 911-916 | Forwards createMoments as 8th positional argument |

```wolfram
modelStatuses = Association @ Table[
  k -> determineModelStatus[k, catalogModels, savedModels, manifest,
    compiledDir, momentsDir, compileJacobians, createMoments,
    compileMode, compilerChoice],
  {k, Keys[enabledModels]}
]
```

## Terminal Consumers

### Terminal Consumer #1: `determineModelStatus` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 712-772 | Function definition |
| Line 713 | Receives `createMoments_` as 8th parameter |
| Lines 748-758 | Moments cache validation |

**Validation logic:**
```wolfram
If[createMoments,
  With[{momentsFile = ..., metaFile = ..., expectedHash = ...},
    If[!momentsUpToDate[momentsFile, metaFile, expectedHash],
      Return[<|"MainStage" -> "Moments", ...|>]
    ]
  ]
]
```

### Terminal Consumer #2: `buildModelsInternal` Phase 4 Gate in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 833 | `createMoments = config["Build"]["CreateMoments"]` |
| Lines 1072-1122 | Phase 4 conditional execution |

**Phase 4 gate:**
```wolfram
If[createMoments,
  Module[{...},
    momentsModels = ...;
    If[Length[momentsModels] > 0,
      numLaunched = setupParallelKernels[numKernels];
      Needs["...CreateMomentsDatabase`"];
      Do[
        createDatabase[
          processedModels[shortname],
          momentsFile,
          splitConfig[config, "Moments"]  (* forwards Moments options, NOT CreateMoments *)
        ],
        {modelKey, momentsModels}
      ];
      If[numLaunched > 0, CloseKernels[]];
    ]
  ]
]
```

### Terminal Consumer #3: `buildModelsParallel` Sequential Phase in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 1154 | `createMoments = OptionValue["CreateMoments"]` |
| Lines 1261-1272 | Sequential moments phase |

**Sequential phase:**
```wolfram
If[createMoments && Length[successModels] > 0,
  Do[
    buildModels[
      "Models" -> {m},
      "CreateMoments" -> True,
      "NumKernels" -> OptionValue["NumKernels"]
    ],
    {m, successModels}
  ]
]
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 149 | Default True |
| Config | `splitConfig` | OptionsConfig.wl | 368-377 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 568-578, 821-826 | Public API |
| Entry | `buildModelsParallel` | ManageResources.wl | 1138-1275 | Parallel orchestrator |
| Forwarder | `buildModelsInternal` | ManageResources.wl | 911-916 | Passes to determineModelStatus |
| **Consumer** | `determineModelStatus` | ManageResources.wl | 748-758 | **Cache validation** |
| **Consumer** | `buildModelsInternal` | ManageResources.wl | 1072-1122 | **Phase 4 gate** |
| **Consumer** | `buildModelsParallel` | ManageResources.wl | 1261-1272 | **Sequential moments** |

## Parallel Build Strategy

| Phase | CreateMoments Value | Purpose |
|-------|---------------------|---------|
| Parallel workers | `False` (forced) | Avoid parallel overhead |
| Sequential phase | `True` (if user requested) | Create moments after merge |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Build phase - moments database creation gate |
| Default | `True` |
| When True | Enables Phase 4 (moments database creation) |
| When False | Skips all moments computation |
| NOT forwarded to | `createDatabase` (receives Moments subsystem options instead) |
| Parallel strategy | Disabled in parallel, enabled in sequential phase |
| Consumer count | Three terminal consumers |
````

</details>

<details>
<summary><code>options-forward/FileSuffix.md</code></summary>

````markdown
# FileSuffix Option

**Location in config:** `config["Build"]["FileSuffix"]`
**Default value:** `""`
**Legacy mapping:** `"FileSuffix" -> {"Build", "FileSuffix"}` in OptionsConfig.wl:181

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   ├─ Filters OUT FileSuffix from user options (line 1189)
   └─ Generates: "FileSuffix" -> "_" <> modelName  (line 1197)

CONFIGURATION LAYER
│
└─ splitConfig[config, "Build"]  ◄── EXTRACTS "FileSuffix"
   │
   └─ "FileSuffix" -> config["Build"]["FileSuffix"]

BUILD ORCHESTRATION
│
└─ buildModelsInternal[config_Association]
   │
   ├─ fileSuffix = config["Build"]["FileSuffix"]  (line 837)
   │
   ├─ modelsFileCheckpoint = FileNameJoin[{
   │    resourcesDir, "Models" <> fileSuffix <> ".wl"
   │  }]  ◄── TERMINAL CONSUMER #1 (line 860)
   │
   ├─ saveModels[..., modelsFileCheckpoint]  (lines 979, 1054, 1125)
   │
   └─ If[TrueQ[updateManifest] && fileSuffix === "",
        updateModelManifest[]
      ]  ◄── TERMINAL CONSUMER #2 (line 1129)
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 151 | Default: `"FileSuffix" -> ""` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 368-377 | `splitConfig[config, "Build"]` definition |
| Line 375 | Extracts: `"FileSuffix" -> config["Build"]["FileSuffix"]` |

## Entry Points

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration: `"FileSuffix" -> ""` |
| Lines 821-826 | Entry patterns (config or legacy options) |

### `buildModelsParallel` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 1138-1143 | Does NOT declare FileSuffix (not user-accessible) |
| Lines 1188-1189 | Explicitly filters OUT FileSuffix from user options |
| Line 1197 | Auto-generates: `"FileSuffix" -> "_" <> m` for each model |
| Lines 1244-1252 | Deletes temporary checkpoint files after merge |

**Filter pattern:**
```wolfram
filteredOpts = FilterRules[{opts},
  Except["FileSuffix" | "UpdateManifest" | "CreateMoments" | "FromScratch" | "Models"]]
```

## Terminal Consumers

### Terminal Consumer #1: Checkpoint File Path in `buildModelsInternal`

| Location | What happens |
|----------|--------------|
| Line 837 | `fileSuffix = config["Build"]["FileSuffix"]` |
| Line 860 | Creates checkpoint file path |

**Checkpoint file path:**
```wolfram
modelsFileCheckpoint = FileNameJoin[{resourcesDir, "Models" <> fileSuffix <> ".wl"}]
```

| fileSuffix Value | Resulting File |
|------------------|----------------|
| `""` (empty) | `Resources/Models.wl` (canonical) |
| `"_BY"` | `Resources/Models_BY.wl` (checkpoint) |
| `"_NRC"` | `Resources/Models_NRC.wl` (checkpoint) |

**Checkpoint saves:**
- Line 979: After symbolic phase
- Line 1054: After compile phase
- Line 1125: After numerical phase

### Terminal Consumer #2: Manifest Update Gate in `buildModelsInternal`

| Location | What happens |
|----------|--------------|
| Line 1129 | Conditional manifest update |

**Gate logic:**
```wolfram
If[TrueQ[updateManifest] && fileSuffix === "", updateModelManifest[]]
```

Only updates manifest when:
1. `updateManifest` is True, AND
2. `fileSuffix` is empty (canonical file, not checkpoint)

## Helper Function

### `resolveCompiledMxFile` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 699-708 | Resolves compiled .mx file paths |

**Note:** This function accepts an optional `fileSuffix` parameter but is NOT connected to the Build option. It's used for jacobian files with suffix `"_jacobians"`.

## Parallel Build Strategy

```
buildModelsParallel
│
├─ Filter out user's FileSuffix option
│
├─ For each model in parallel:
│  └─ buildModels[..., "FileSuffix" -> "_" <> modelName, ...]
│     └─ Writes: Models_BY.wl, Models_NRC.wl, etc.
│
├─ Merge all checkpoint files into Models.wl
│
└─ Delete temporary checkpoint files (lines 1244-1252)
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 151 | Default "" |
| Config | `splitConfig` | OptionsConfig.wl | 368-377 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 568-578, 821-826 | Public API |
| Entry | `buildModelsParallel` | ManageResources.wl | 1145, 1188-1189, 1197 | Parallel orchestrator |
| **Consumer** | `buildModelsInternal` | ManageResources.wl | 860 | **Checkpoint file path** |
| **Consumer** | `buildModelsInternal` | ManageResources.wl | 1129 | **Manifest update gate** |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Build phase - checkpoint file naming |
| Default | `""` (empty string) |
| When empty | Writes to canonical `Models.wl`, allows manifest update |
| When non-empty | Writes to `Models_{suffix}.wl`, blocks manifest update |
| User control | Filtered out in buildModelsParallel (auto-generated) |
| Purpose | Enables parallel builds with separate checkpoint files |
| Cleanup | Parallel orchestrator deletes temporary checkpoint files |
| Consumer count | Two terminal consumers |
````

</details>

<details>
<summary><code>options-forward/FindRoot.md</code></summary>

````markdown
# FindRoot Options

**Location in config:** `config["Numerical"]["FindRoot"]`
**Default value:** Nested Association (see below)
**Flattened as:** `"FindRootOptions"` when extracted via splitConfig

## Default Structure

```wolfram
"FindRoot" -> <|
  "MaxIterations" -> 100,
  "PrecisionGoal" -> Automatic,
  "AccuracyGoal" -> Automatic,
  "WorkingPrecision" -> MachinePrecision,
  "Options" -> {}
|>
```

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ updateCoeffs[model, kernels, "FindRootOptions" -> {...}, ...]

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]
   │
   └─ Flattens nested FindRoot to "FindRootOptions" → [...]
      │
      └─ (options not directly forwarded from buildModelsInternal)

NUMERICAL SOLVING PATH
│
└─ updateCoeffs[model, kernels, newParams, opts...]
   │
   └─ updateCoeffsSol[model, kernels, newParams, opts...]
      │
      └─ solveCoeffRoots[quadSol, kernel, paramsBase, signs, extraParams, opts...]
         │
         ├─ FilterRules extracts FindRoot-compatible options
         │
         ├─ findRootInterval[conds, paramsAll, opts...]
         │
         └─ scanAndSolve[f, {min, max}, opts...]
            │
            └─ fastRoot[f, spec, opts...]  ◄── TERMINAL CONSUMER
               │
               ├─ tryNewton1D[...] → FindRoot[...]
               ├─ tryNewtonND[...] → FindRoot[...]
               ├─ tryBrent1D[...] → FindRoot[...]
               ├─ trySecant1D[...] → FindRoot[...]
               └─ tryDefaultFindRoot[...] → FindRoot[...]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 104-112 | Default nested structure inside "Numerical" |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Lines 322-337 | Flattens FindRoot to "FindRootOptions" |

**Flattening logic:**
```wolfram
"FindRootOptions" -> Join[
  {"MaxIterations" -> config["Numerical"]["FindRoot"]["MaxIterations"]},
  If[config["Numerical"]["FindRoot"]["PrecisionGoal"] =!= Automatic,
    {"PrecisionGoal" -> config["Numerical"]["FindRoot"]["PrecisionGoal"]},
    {}
  ],
  If[config["Numerical"]["FindRoot"]["AccuracyGoal"] =!= Automatic,
    {"AccuracyGoal" -> config["Numerical"]["FindRoot"]["AccuracyGoal"]},
    {}
  ],
  If[config["Numerical"]["FindRoot"]["WorkingPrecision"] =!= MachinePrecision,
    {"WorkingPrecision" -> config["Numerical"]["FindRoot"]["WorkingPrecision"]},
    {}
  ],
  config["Numerical"]["FindRoot"]["Options"]
]
```

## Intermediate Forwarders

### `updateCoeffsSol` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 333-349 | Option declarations |
| Line 335 | `"FindRootOptions" -> {}` default |
| Lines 575-690 | Function implementation |
| Line 617 | FilterRules extracts options |

**How received:** Via `OptionsPattern[{updateCoeffsSol, solveCoeffRoots, checks, FindRoot, RecurrenceTable}]`
**How forwarded:** To `solveCoeffRoots` via FilterRules

### `solveCoeffRoots` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 803-904 | Function definition |
| Line 809 | Receives opts via OptionsPattern |
| Line 832 | `findOpts = FilterRules[Flatten@{opts}, Options[findRootInterval]]` |
| Lines 834-837 | `scanOpts = FilterRules[..., Join[Options[scanAndSolve], Options[FindRoot], Options[fastRoot]]]` |
| Line 862 | Passes `findOpts` to `findRootInterval` |
| Lines 867-870 | Passes `scanOpts` to `scanAndSolve` |

**How received:** Via opts parameter
**How forwarded:** Via FilterRules to downstream functions

### `scanAndSolve` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 1015-1179 | Function definition |
| Line 1019 | `"FindRootOptions" -> Automatic` |
| Line 1033 | `frSpec = OptionValue["FindRootOptions"]` |
| Lines 1039-1043 | Builds `frOpts` based on frSpec |
| Lines 1047-1060 | Merges FilterRules of FindRoot options |
| Lines 1095-1096 | Passes to `fastRoot` |

**How received:** Via `OptionsPattern[{scanAndSolve}]`
**How forwarded:** To `fastRoot` via `fastOpts`

## Terminal Consumers

### `fastRoot` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 517-525 | Option declarations |
| Line 521 | `"FindRootOptions" -> Automatic` |
| Line 810 | `frSpec = OptionValue["FindRootOptions"]` |
| Lines 848-858 | Builds `findRootOpts` from frSpec and FilterRules |

**Options built:**
```wolfram
findRootOpts = Join[
  FilterRules[Flatten@{opts}, Options[FindRoot]],
  frOpts  (* from "FindRootOptions" specification *)
]
```

### Internal FindRoot Callers

| Function | File | Lines | Call Pattern |
|----------|------|-------|--------------|
| `tryNewton1D` | FindRootOptim.wl | 675-676 | `FindRoot[..., Evaluate[Sequence @@ findRootOpts]]` |
| `tryNewtonND` | FindRootOptim.wl | 691-692 | `FindRoot[..., Evaluate[Sequence @@ findRootOpts]]` |
| `tryBrent1D` | FindRootOptim.wl | 700-701 | `FindRoot[..., Evaluate[Sequence @@ findRootOpts]]` |
| `trySecant1D` | FindRootOptim.wl | 716-717 | `FindRoot[..., Evaluate[Sequence @@ findRootOpts]]` |
| `tryDefaultFindRoot` | FindRootOptim.wl | 777, 783 | `FindRoot[..., Evaluate[Sequence @@ findRootOpts]]` |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 104-112 | Default nested structure |
| Config | `splitConfig` | OptionsConfig.wl | 322-337 | Flattens to "FindRootOptions" |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Wrapper |
| Forwarder | `updateCoeffsSol` | SolveEulerEq.wl | 333-690 | Option declaration, FilterRules |
| Forwarder | `solveCoeffRoots` | SolveEulerEq.wl | 803-904 | Extracts findOpts, scanOpts |
| Forwarder | `scanAndSolve` | FindRootOptim.wl | 1015-1179 | Builds frOpts |
| **Consumer** | `fastRoot` | FindRootOptim.wl | 517-858 | Builds findRootOpts |
| Internal | `tryNewton1D` | FindRootOptim.wl | 675-676 | Calls FindRoot |
| Internal | `tryNewtonND` | FindRootOptim.wl | 691-692 | Calls FindRoot |
| Internal | `tryBrent1D` | FindRootOptim.wl | 700-701 | Calls FindRoot |
| Internal | `trySecant1D` | FindRootOptim.wl | 716-717 | Calls FindRoot |
| Internal | `tryDefaultFindRoot` | FindRootOptim.wl | 777, 783 | Calls FindRoot |
| Built-in | `FindRoot` | (System) | N/A | Ultimate consumer |

## Propagation Paths

### Path A: Configuration-driven
```
buildModels[<|"Numerical" -> <|"FindRoot" -> <|"MaxIterations" -> 200|>|>|>]
  → normalizeConfig → merges with defaults
  → splitConfig[config, "Numerical"]
  → "FindRootOptions" -> {"MaxIterations" -> 200}
  → (stored in config but not directly forwarded to numerical phase)
```

### Path B: Direct Option Passing
```
updateCoeffs[model, kernels, params, "FindRootOptions" -> {MaxIterations -> 200}]
  → updateCoeffsSol[..., opts]
  → FilterRules extracts FindRoot options
  → solveCoeffRoots[..., opts]
  → scanAndSolve[..., opts] or findRootInterval[..., opts]
  → fastRoot[..., opts]
  → FindRoot[..., MaxIterations -> 200, ...]
```

### Path C: Default (no options)
```
addCoeffsSolutionN[model]
  → updateCoeffs (no FindRootOptions)
  → Uses defaults: MaxIterations -> 100, etc.
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase |
| Nested structure | Yes - Association inside "Numerical" |
| Flattening | splitConfig converts to flat "FindRootOptions" list |
| Default MaxIterations | 100 |
| Conditional options | PrecisionGoal, AccuracyGoal, WorkingPrecision only included if non-default |
| Terminal consumers | `fastRoot` and internal try* functions |
| Ultimate consumer | Wolfram `FindRoot` built-in |
````

</details>

<details>
<summary><code>options-forward/FromScratch.md</code></summary>

````markdown
# FromScratch Option

**Location in config:** `config["Build"]["FromScratch"]`
**Default value:** `False`
**Legacy mapping:** `"FromScratch" -> {"Build", "FromScratch"}` in OptionsConfig.wl:177

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   ├─ fromScratch = OptionValue["FromScratch"]
   ├─ If[fromScratch, cleanAllOutputs[root]]
   └─ buildModels[..., "FromScratch" -> False, ...]  (forced False)

CONFIGURATION LAYER
│
└─ splitConfig[config, "Build"]  ◄── EXTRACTS "FromScratch"
   │
   └─ "FromScratch" -> config["Build"]["FromScratch"]

BUILD ORCHESTRATION
│
└─ buildModelsInternal[config_Association]
   │
   ├─ fromScratch = config["Build"]["FromScratch"]  (line 831)
   │
   └─ If[fromScratch,
        cleanAllOutputs[root];
        savedModels = <||>;
        manifest = $Failed
      ]  ◄── TERMINAL CONSUMER
      │
      └─ cleanAllOutputs[root]  ◄── CLEANUP HELPER
         │
         ├─ DeleteFile @ Resources/CompiledFunctions/**/*.mx
         ├─ DeleteFile @ Resources/MomentsLookupTables/covLong*.mx|wl
         ├─ DeleteFile @ Resources/Models.wl
         ├─ DeleteFile @ Resources/ModelManifest.wl
         └─ DeleteFile @ Resources/Models_*.wl (suffixed checkpoints)
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 147 | Default: `"FromScratch" -> False` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 368-377 | `splitConfig[config, "Build"]` definition |
| Line 371 | Extracts: `"FromScratch" -> config["Build"]["FromScratch"]` |

## Entry Points

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration: `"FromScratch" -> False` |
| Lines 821-826 | Entry patterns (config or legacy options) |

### `buildModelsParallel` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 1138-1143 | Option declaration: `"FromScratch" -> False` |
| Line 1155 | `fromScratch = OptionValue["FromScratch"]` |
| Lines 1169-1172 | `If[fromScratch, cleanAllOutputs[root]]` |
| Line 1197 | Forces `"FromScratch" -> False` in parallel workers |

## Terminal Consumers

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 831 | `fromScratch = config["Build"]["FromScratch"]` (With clause) |
| Lines 896-901 | Cleanup trigger |

**Cleanup logic:**
```wolfram
If[fromScratch,
  cleanAllOutputs[root];
  savedModels = <||>;
  manifest = $Failed;
]
```

### `buildModelsParallel` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 1155 | `fromScratch = OptionValue["FromScratch"]` |
| Lines 1169-1172 | `If[fromScratch, cleanAllOutputs[root]]` |

### `cleanAllOutputs` Helper in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 586-610 | Actual deletion logic |

**Deleted artifacts:**
- All `.mx` files in `Resources/CompiledFunctions/` and platform subfolders
- All `covLong*.mx` and `covLong*.wl` files in `Resources/MomentsLookupTables/`
- `Resources/Models.wl` (processed models)
- `Resources/ModelManifest.wl` (catalog hash manifest)
- All `Resources/Models_*.wl` suffixed checkpoint files

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 147 | Default False |
| Config | `splitConfig` | OptionsConfig.wl | 368-377 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 568-578, 821-826 | Public API |
| Entry | `buildModelsParallel` | ManageResources.wl | 1138-1275 | Parallel orchestrator |
| **Consumer** | `buildModelsInternal` | ManageResources.wl | 831, 896-901 | **Cleanup trigger** |
| **Consumer** | `buildModelsParallel` | ManageResources.wl | 1155, 1169-1172 | **Cleanup trigger** |
| Helper | `cleanAllOutputs` | ManageResources.wl | 586-610 | Deletion logic |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Build phase - clean slate rebuild |
| Default | `False` |
| When True | Deletes all cached outputs before rebuilding |
| Parallel handling | Cleanup once at orchestrator, forced False in workers |
| Effects | Clears savedModels cache, forces manifest rebuild |
| Consumer count | Two terminal consumers (buildModelsInternal, buildModelsParallel) |
````

</details>

<details>
<summary><code>options-forward/IterationLimit.md</code></summary>

````markdown
# IterationLimit Option

**Location in config:** `config["Moments"]["IterationLimit"]`
**Default value:** `$IterationLimit/4`
**Legacy mapping:** `"IterationLimit" -> {"Moments", "IterationLimit"}` in OptionsConfig.wl:177

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ buildModels[...] (delegates)

CONFIGURATION LAYER
│
└─ splitConfig[config, "Moments"]  ◄── EXTRACTS "IterationLimit"
   │
   └─ "IterationLimit" -> config["Moments"]["IterationLimit"]

MOMENTS CREATION PATH
│
└─ buildModelsInternal[config_Association]
   │
   └─ Phase 4: Moments (if createMoments = True)
      │
      └─ createDatabase[model, momentsFile, splitConfig[config, "Moments"]]
         │
         └─ ... → uncondCovLongExo[..., opts]  ◄── TERMINAL CONSUMER
            │
            └─ Block[{$IterationLimit = OptionValue["IterationLimit"]},
                 Check[computation, fallback, $IterationLimit::itlim]
               ]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 140 | Default: `"IterationLimit" -> $IterationLimit/4` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 354-359 | `splitConfig[config, "Moments"]` definition |
| Line 358 | Extracts: `"IterationLimit" -> config["Moments"]["IterationLimit"]` |

## Propagation Path

### `createDatabase` → Helper Functions

| Function | Role |
|----------|------|
| `totCovLong` | Pure forwarder |
| `uncondCovLong` | Pure forwarder |
| `uncondVarLong` | Pure forwarder |
| `uncondVarLongExo` | Pure forwarder |
| `uncondCovLongExo` | Terminal consumer |

## Terminal Consumer

### `uncondCovLongExo` in `Kernel/ComputationalEngine/CreateMomentsDatabase.wl`

| Location | What happens |
|----------|--------------|
| Lines 122-219 | Function definition |
| Line 130 | Option declaration: `"IterationLimit" -> $IterationLimit/4` |
| Line 145 | `Block[{$IterationLimit = OptionValue["IterationLimit"]}, ...]` |

**Implementation pattern:**
```wolfram
Block[{$IterationLimit = OptionValue["IterationLimit"]},
  Check[
    Trace[symbolic computation],
    fallback,
    $IterationLimit::itlim
  ]
]
```

This provides a "soft timeout" that gracefully degrades to an alternative computation method when the iteration limit is exceeded.

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 140 | Default $IterationLimit/4 |
| Config | `splitConfig` | OptionsConfig.wl | 354-359 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Forwarder | `buildModelsInternal` | ManageResources.wl | 1097-1101 | Forwards to createDatabase |
| Forwarder | `createDatabase` | CreateMomentsDatabase.wl | 314-619 | Forwards to helpers |
| Forwarders | `totCovLong`, etc. | CreateMomentsDatabase.wl | Various | Pure forwarders |
| **Consumer** | `uncondCovLongExo` | CreateMomentsDatabase.wl | 122-219 | **Terminal consumer** |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Moments phase - covariance computation |
| Default | `$IterationLimit/4` (typically ~250,000) |
| Purpose | Limits iterations for expensive symbolic computations |
| Mechanism | `Block[{$IterationLimit = ...}, Check[..., fallback, $IterationLimit::itlim]]` |
| Fallback | Graceful degradation to alternative method on limit |
| Consumer count | Single terminal consumer |
````

</details>

<details>
<summary><code>options-forward/MaxMaturity-Build.md</code></summary>

````markdown
# MaxMaturity Option (Build Subsystem)

**Location in config:** `config["Build"]["MaxMaturity"]`
**Default value:** `120`
**Legacy mapping:** Ambiguous - see OptionsConfig.wl:196-199

## Disambiguation

There are TWO MaxMaturity options in different subsystems:

| Subsystem | Default | Purpose |
|-----------|---------|---------|
| **Build** | 120 | Upper bound for bond coefficient generation during builds |
| Numerical | 12 | Used by SolveEulerEq for numerical solutions |

This document covers the **Build** subsystem version.

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ Forwards via filteredOpts to buildModels

CONFIGURATION LAYER
│
├─ Ambiguous option handling (OptionsConfig.wl:196-199)
│  └─ "MaxMaturity" -> <|
│       "Numerical" -> {"Numerical", "MaxMaturity"},
│       "Build" -> {"Build", "MaxMaturity"}
│     |>
│
└─ splitConfig[config, "Build"]  ◄── EXTRACTS "MaxMaturity"
   │
   └─ "MaxMaturity" -> config["Build"]["MaxMaturity"]

BUILD ORCHESTRATION
│
└─ buildModelsInternal[config_Association]
   │
   └─ maxMaturity = config["Build"]["MaxMaturity"]  (line 835)
      │
      └─ (Variable bound but NOT forwarded to downstream functions)

NUMERICAL PHASE (where maxMaturity is actually used)
│
└─ addCoeffsSolutionN[model]  (SolveEulerEq.wl:1036-1046)
   │
   └─ updateCoeffs[..., "MaxMaturity" -> 12, ...]  ◄── HARD-CODED
      │
      └─ updateCoeffsSol[..., "MaxMaturity" -> 12, ...]
         │
         ├─ updateCoeffsBond[..., maxMaturity, ...]  ◄── TERMINAL CONSUMER
         └─ checkCoeffs[..., maxMaturity, ...]       ◄── TERMINAL CONSUMER
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 150 | Default: `"MaxMaturity" -> 120` (in Build subsystem) |

### Ambiguous Option Handling in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 196-199 | Distinguishes Build vs Numerical MaxMaturity |

```wolfram
"MaxMaturity" -> <|
  "Numerical" -> {"Numerical", "MaxMaturity"},  (* default: 12 *)
  "Build" -> {"Build", "MaxMaturity"}           (* default: 120 *)
|>
```

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 368-377 | `splitConfig[config, "Build"]` definition |
| Line 374 | Extracts: `"MaxMaturity" -> config["Build"]["MaxMaturity"]` |

## Entry Points

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration: `"MaxMaturity" -> 120` |
| Lines 821-826 | Entry patterns (config or legacy options) |

## Build Orchestration

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 835 | `maxMaturity = config["Build"]["MaxMaturity"]` |

**Critical Finding:** The extracted `maxMaturity` variable is bound in the `With` clause but is NOT forwarded to downstream numerical functions.

## Terminal Consumers (in SolveEulerEq.wl)

### `updateCoeffsBond` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 697-712 | Function definition |
| Line 707 | Uses maxMaturity in bond template evaluation |

### `checkCoeffs` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 500-514 | Function definition |
| Line 509 | `Table[..., {n, 1, maxMaturity}]` for "bond" |
| Line 512 | `Table[..., {n, 1, maxMaturity}]` for "nombond" |

## Critical Architecture Issue

**The Build subsystem's MaxMaturity (120) is NOT propagated to the numerical phase.**

### Evidence

`addCoeffsSolutionN` in SolveEulerEq.wl (lines 1036-1046):
```wolfram
addCoeffsSolutionN[model_] := Module[{k},
  k = loadModelKernels[model["shortname"]];
  updateCoeffs[
    model,
    k,
    "UpdatePd" -> True,
    "UpdateBonds" -> True,
    "MaxMaturity" -> 12,        (* <-- HARD-CODED, ignores Build config *)
    "RootSigns" -> All
  ]
]
```

### Implications

| Setting | Effect |
|---------|--------|
| `config["Build"]["MaxMaturity"] = 200` | No effect - bond coefficients computed to 12 years |
| Actual behavior | Always uses MaxMaturity = 12 from hard-coded value |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 150 | Default 120 |
| Config | Ambiguous handling | OptionsConfig.wl | 196-199 | Disambiguation |
| Config | `splitConfig` | OptionsConfig.wl | 368-377 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 568-578, 821-826 | Public API |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 835 | Extracts but doesn't forward |
| Hard-coded | `addCoeffsSolutionN` | SolveEulerEq.wl | 1036-1046 | Uses MaxMaturity=12 |
| Consumer | `updateCoeffsBond` | SolveEulerEq.wl | 697-712 | Bond template evaluation |
| Consumer | `checkCoeffs` | SolveEulerEq.wl | 500-514 | Bond equation validation |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Build phase - bond coefficient range |
| Default | `120` years |
| Actual effect | **None** - value not propagated to consumers |
| Gap | Missing link between buildModelsInternal and addCoeffsSolutionN |
| Hard-coded override | `addCoeffsSolutionN` uses 12 years |
| Status | Configuration value appears unused in current pipeline |
````

</details>

<details>
<summary><code>options-forward/MaxMaturity-Numerical.md</code></summary>

````markdown
# MaxMaturity Option (Numerical Subsystem)

**Location in config:** `config["Numerical"]["MaxMaturity"]`
**Default value:** `12`
**Legacy mapping:** `"MaxMaturity" -> {"Numerical", "MaxMaturity"}` in OptionsConfig.wl:186
**Note:** Different from Build subsystem's MaxMaturity (default 120)

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
├─ updateCoeffs[model, kernels, "MaxMaturity" -> n, ...]
│
└─ addCoeffsSolutionN[model]
   └─ updateCoeffs[..., "MaxMaturity" -> 12, ...]

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]  ◄── EXTRACTS "MaxMaturity"
   │
   └─ "MaxMaturity" -> config["Numerical"]["MaxMaturity"]

NUMERICAL SOLVING PATH
│
└─ updateCoeffsSol[model, kernels, newParams, guessCoeffs, opts...]
   │
   ├─ maxMaturity = OptionValue["MaxMaturity"]
   │
   ├─ updateCoeffsBond[..., maxMaturity, coeffsWc, opts...]  ◄── TERMINAL CONSUMER
   │  └─ #[maxMaturity]& /@ modelCoeffsSolution
   │
   └─ checkCoeffs[..., maxMaturity, ...]  ◄── TERMINAL CONSUMER
      └─ Table[..., {n, 1, maxMaturity}]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 117 | Default: `"MaxMaturity" -> 12` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Line 342 | Extracts: `"MaxMaturity" -> config["Numerical"]["MaxMaturity"]` |

## Intermediate Forwarders

### `updateCoeffs` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 765-796 | Wrapper function |
| Lines 765-771 | Inherits options from `updateCoeffsSol` |

**How received:** Via `OptionsPattern[{updateCoeffsSol, checks, ...}]`
**How forwarded:** To `updateCoeffsSol` via argument propagation

### `updateCoeffsSol` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 333-349 | Option declarations |
| Line 341 | `"MaxMaturity" -> 12` |
| Line 602 | `maxMaturity = OptionValue["MaxMaturity"]` |
| Lines 639-645 | Forward to `updateCoeffsBond` |

### `addCoeffsSolution` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Lines 904-911 | Option declarations |
| Line 905 | `"MaxMaturity" -> 12` |
| Lines 1047-1062 | Uses in parameterized functions |

### `yieldCurve` in `Kernel/Tools/NicePlots.wl`

| Location | What happens |
|----------|--------------|
| Lines 46-49 | Option declarations |
| Line 61 | `maxMaturity = OptionValue[yieldCurve, "MaxMaturity"]` |
| Line 105 | `Table[{m, yE} /. m -> mm, {mm, maxMaturity}]` |

## Terminal Consumers

### `updateCoeffsBond` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 697-712 | Function definition |
| Line 707 | `(#[maxMaturity]& /@ modelCoeffsSolution)` |

Applies the recurrence table solution function with specific maturity value.

### `checkCoeffs` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 500-514 | Function definition |
| Lines 509, 512 | `Flatten @ Table[..., {n, 1, maxMaturity}]` |

Generates validation equations for bonds up to maxMaturity.

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 117 | Default value 12 |
| Config | `splitConfig` | OptionsConfig.wl | 342 | Extracts from config |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Wrapper |
| Forwarder | `updateCoeffsSol` | SolveEulerEq.wl | 341, 602 | Main extraction |
| Forwarder | `addCoeffsSolution` | ProcessModels.wl | 905, 1047-1062 | Parameterized functions |
| Forwarder | `yieldCurve` | NicePlots.wl | 46-105 | Visualization |
| **Consumer** | `updateCoeffsBond` | SolveEulerEq.wl | 697-712 | Bond computation |
| **Consumer** | `checkCoeffs` | SolveEulerEq.wl | 500-514 | Validation |

## Propagation Paths

### Path A: Configuration-driven
```
buildModels[<|"Numerical" -> <|"MaxMaturity" -> 24|>|>]
  → normalizeConfig → merges with defaults
  → splitConfig[config, "Numerical"] → "MaxMaturity" -> 24
  → (flows to numerical phase)
```

### Path B: Direct Option Passing
```
updateCoeffs[model, kernels, params, "MaxMaturity" -> 24]
  → updateCoeffsSol[..., opts]
  → maxMaturity = OptionValue["MaxMaturity"] → 24
  → updateCoeffsBond[..., 24, ...]
  → Computes bond coefficients for maturities 0-24
```

### Path C: Default (addCoeffsSolutionN)
```
addCoeffsSolutionN[model]
  → updateCoeffs[..., "MaxMaturity" -> 12, ...]
  → Uses default 12
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - bond computations |
| Default | 12 (different from Build's 120) |
| Impact | Number of bond coefficient values computed (0 to maxMaturity) |
| Downstream effects | Yield curve length, validation scope |
| Ambiguity | Handled by normalizeConfig (line 264 in OptionsConfig.wl) |
````

</details>

<details>
<summary><code>options-forward/Models.md</code></summary>

````markdown
# Models Option

**Location in config:** `config["Build"]["Models"]`
**Default value:** `All`
**Legacy mapping:** `"Models" -> {"Build", "Models"}` in OptionsConfig.wl:180

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ buildModels["Models" -> {m}] for each model

CONFIGURATION LAYER
│
└─ splitConfig[config, "Build"]  ◄── EXTRACTS "Models"
   │
   └─ "Models" -> config["Build"]["Models"]

BUILD ORCHESTRATION
│
└─ buildModelsInternal[config_Association]
   │
   ├─ modelFilter = config["Build"]["Models"]
   │
   ├─ enabledModels = selectEnabledModels[catalogModels]
   │
   └─ If[modelFilter === All,
        enabledModels,
        KeyTake[enabledModels, matching shortnames]
      ]
      │
      ├─ symbolicModels (Phase 1)
      ├─ compileModels (Phase 2)
      ├─ numericalModels (Phase 3)
      └─ momentsModels (Phase 4)
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 146 | Default: `"Models" -> All` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 368-375 | `splitConfig[config, "Build"]` definition |
| Line 370 | Extracts: `"Models" -> config["Build"]["Models"]` |

## Terminal Consumer

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 836 | `modelFilter = config["Build"]["Models"]` |
| Line 871 | `enabledModels = selectEnabledModels[catalogModels]` |
| Lines 875-878 | Apply filter to enabledModels |

**Filtering logic:**
```wolfram
If[modelFilter === All || modelFilter === "All",
  enabledModels,
  KeyTake[enabledModels,
    Select[Keys[enabledModels],
      MemberQ[ToString /@ Flatten@{modelFilter},
        catalogModels[#]["shortname"]] &
    ]
  ]
]
```

## Model Selection Cascade

| Phase | Selection | Description |
|-------|-----------|-------------|
| 1 | `symbolicModels` | Models requiring symbolic processing |
| 2 | `compileModels` | Symbolic + new compile models |
| 3 | `numericalModels` | Compile + new numerical models |
| 4 | `momentsModels` | Special logic (catalog-changed only) |

## Value Types

| Value | Effect |
|-------|--------|
| `All` | Process all enabled models from Catalog |
| `"All"` | Same as All (string variant) |
| `{"BY", "NRC"}` | Process only specified shortnames |
| `"BY"` | Single model (coerced to list) |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 146 | Default All |
| Config | `splitConfig` | OptionsConfig.wl | 368-375 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Entry | `buildModelsParallel` | ManageResources.wl | 1145-1275 | Parallel variant |
| **Consumer** | `buildModelsInternal` | ManageResources.wl | 836, 875-878 | **Filtering logic** |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Build phase - model selection |
| Default | `All` |
| Impact | Determines which models flow through all 4 phases |
| Cascading | Once selected, model flows through entire pipeline |
| Not forwarded | Downstream functions receive filtered model subsets |
````

</details>

<details>
<summary><code>options-forward/NumKernels.md</code></summary>

````markdown
# NumKernels Option

**Location in config:** `config["Parallel"]["NumKernels"]`
**Default value:** `Automatic`
**Legacy mapping:** `"NumKernels" -> {"Parallel", "NumKernels"}` in OptionsConfig.wl:165

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   ├─ numKernels = OptionValue["NumKernels"]
   ├─ LaunchKernels[numKernels]  (for parallel phases)
   └─ Forwards to buildModels

CONFIGURATION LAYER
│
└─ splitConfig[config, "Parallel"]  ◄── EXTRACTS "NumKernels"
   │
   └─ "NumKernels" -> config["Parallel"]["NumKernels"]

MOMENTS PHASE (Phase 4)
│
└─ buildModelsInternal[config_Association]
   │
   ├─ numKernels = config["Parallel"]["NumKernels"]
   │
   └─ setupParallelKernels[numKernels]  ◄── TERMINAL CONSUMER
      │
      ├─ Automatic → $ProcessorCount
      ├─ None → 0 (no parallel kernels)
      ├─ Integer → use specified count
      │
      ├─ CloseKernels[]
      ├─ LaunchKernels[n]
      └─ warmupParallelKernels[] (if n > 0)
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 143 | Default: `"NumKernels" -> Automatic` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 363-365 | `splitConfig[config, "Parallel"]` definition |
| Line 364 | Extracts: `"NumKernels" -> config["Parallel"]["NumKernels"]` |

## Entry Points

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration: `"NumKernels" -> Automatic` |
| Lines 821-826 | Entry patterns |

### `buildModelsParallel` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 1138-1143 | Option declaration: `"NumKernels" -> Automatic` |
| Line 1156 | Extraction with resolution |
| Line 1176 | `LaunchKernels[numKernels]` |
| Line 1266 | Forwards to buildModels |

## Terminal Consumers

### `setupParallelKernels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 776-790 | Function definition |
| Lines 777-782 | Value resolution |
| Line 786 | `CloseKernels[]` |
| Line 787 | `LaunchKernels[n]` |
| Line 789 | Returns `Length[ParallelKernels[]]` |

**Resolution logic:**
```wolfram
n = Switch[numKernels,
  Automatic, $ProcessorCount,
  None, 0,
  _Integer, numKernels,
  _, $ProcessorCount
]
```

### `warmupParallelKernels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 794-817 | Function definition |
| Lines 810-816 | ParallelEvaluate to load packages on all kernels |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 143 | Default Automatic |
| Config | `splitConfig` | OptionsConfig.wl | 363-365 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 568-578, 821-826 | Public API |
| Entry | `buildModelsParallel` | ManageResources.wl | 1138-1275 | Parallel orchestrator |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 834, 1084 | Extracts and uses |
| **Consumer** | `setupParallelKernels` | ManageResources.wl | 776-790 | Launches kernels |
| Consumer | `warmupParallelKernels` | ManageResources.wl | 794-817 | Initializes kernels |

## Value Resolution

| Input | Resolution |
|-------|------------|
| `Automatic` | `$ProcessorCount` |
| `None` | 0 (serial execution) |
| Integer | Use specified count |
| Invalid | Falls back to `$ProcessorCount` |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Parallel kernel management for Moments phase |
| Default | `Automatic` |
| Applies to | Moments database creation (Phase 4) |
| Phases 1-3 | Always serial (Symbolic, Compile, Numerical) |
| Cleanup | Kernels closed after moments phase |
````

</details>

<details>
<summary><code>options-forward/PdEquations.md</code></summary>

````markdown
# PdEquations Option

**Location in config:** `config["Symbolic"]["PdEquations"]`
**Default value:** `"B"`
**Valid values:** `"B"` | `"AB"` | `"Both"`
**Legacy mapping:** `"PdEquations" -> {"Symbolic", "PdEquations"}` in OptionsConfig.wl:166

## Complete Propagation Tree

```
PUBLIC API ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│     └─ mergeNested[{defaultConfig[], user_config}]
│
└─ buildModelsParallel[models, opts...]
   └─ buildModels[...] (recursive)

ORCHESTRATION LAYER
│
└─ buildModelsInternal[config_Association]
   │
   └─ splitConfig[config, "Symbolic"]  ◄── EXTRACTS "PdEquations"
      │
      └─ processModels[modelsCatalog, splitConfig_result...]
         │
         └─ solveCoeffsSystem[model, "PdEquations" -> value]  ◄── TERMINAL CONSUMER
            │
            ├─ If "B" or "Both": computes eqB0 (pd equations)
            ├─ If "AB" or "Both": computes eqAB0 (pd with wc substituted)
            └─ Stores result in model["coeffsParamQuadSolve"]["pd"]["pdMode"]
```

## Entry Points (Public API)

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration in `Options[buildModels]` |
| Line 575 | `"PdEquations" -> "B"` with comment about valid values |
| Line 821 | Pattern: `buildModels[config_Association]` - receives normalized config |
| Line 825 | Pattern: `buildModels[opts___?OptionQ]` - receives flat legacy options |
| Lines 822, 826 | Normalizes via `normalizeConfig[]` |

**How received:** Via `OptionsPattern` in function definition
**How forwarded:** Config passed to `buildModelsInternal`

### `buildModelsParallel` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 1138-1143 | Option declaration |
| Line 1142 | `"PdEquations" -> "B"` |
| Lines 1193-1199 | Forwards to recursive `buildModels` calls |

**How received:** Via `OptionsPattern` with inheritance from `buildModels`
**How forwarded:** Passed to `buildModels` in parallel table

## Configuration Management Layer

### `normalizeConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 166 | Legacy mapping: `"PdEquations" -> {"Symbolic", "PdEquations"}` |
| Lines 245-292 | Converts legacy flat options to nested config Association |
| Lines 256-258 | Maps legacy option to nested path via `legacyOptionMap` |

**Role:** Converts legacy `"PdEquations" -> value` to `config["Symbolic"]["PdEquations"] -> value`

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 300-304 | `splitConfig[config, "Symbolic"]` definition |
| Line 301 | Extracts: `"PdEquations" -> config["Symbolic"]["PdEquations"]` |

**Role:** Extracts `PdEquations` from nested config and returns as `Sequence` of rules

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 76 | Default: `"PdEquations" -> "B"` inside `"Symbolic"` subsystem |

## Intermediate Forwarders

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 829 | Receives normalized config as parameter |
| Line 970 | Extracts Symbolic options: `splitConfig[config, "Symbolic"]` |
| Line 970 | Passes extracted options to `processModels` |

**How received:** Normalized config Association
**How forwarded:** Via `splitConfig[config, "Symbolic"]` which returns `Sequence` including `"PdEquations" -> value`

### `processModels` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Line 79 | `OptionsPattern[{solveCoeffsSystem, updateCoeffs, ...}]` - inherits options |
| Lines 246-247 | Forwards to `solveCoeffsSystem` |

**Forwarding mechanism:**
```wolfram
solveCoeffsSystem[#,
  "PdEquations" -> OptionValue[solveCoeffsSystem, Flatten@{opts}, "PdEquations"]
]
```

**How received:** Via `OptionsPattern` with inheritance from `solveCoeffsSystem`
**How forwarded:** Explicitly extracts and passes `"PdEquations"` option

## Terminal Consumer

### `solveCoeffsSystem` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Lines 637-641 | Option declaration |
| Line 640 | `"PdEquations" -> "B"` |
| Line 770 | **Direct consumption:** `pdMode = OptionValue["PdEquations"]` |
| Line 776 | Stores value: `solB["pdMode"] = pdMode` |
| Line 779 | `If[MatchQ[pdMode, "B" \| "Both"], ...]` - computes eqB0 |
| Line 791 | `If[MatchQ[pdMode, "AB" \| "Both"], ...]` - computes eqAB0 |

**Usage logic:**
```wolfram
pdMode = OptionValue["PdEquations"];
solB["pdMode"] = pdMode;

If[MatchQ[pdMode, "B" | "Both"],
  (* Compute pd equations without wc coefficient substitution *)
  eqB0 = ...
];

If[MatchQ[pdMode, "AB" | "Both"],
  (* Compute pd equations with wc coefficients substituted *)
  eqAB0 = ...
];
```

## Post-Processing Usage

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 687 | Reads stored `pdMode` from model result for hashing |

```wolfram
pdMode = Lookup[model["coeffsParamQuadSolve"]["pd"], "pdMode", "B"];
```

**Note:** This reads the **stored result** of the option (set in Phase 1), not the option itself. Used for cache validation/hashing.

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Entry | `buildModels` | ManageResources.wl | 575, 821-826 | Public API, normalizes config |
| Entry | `buildModelsParallel` | ManageResources.wl | 1142, 1193-1199 | Parallel variant, forwards to buildModels |
| Config | `defaultConfig` | OptionsConfig.wl | 76 | Default value |
| Config | `normalizeConfig` | OptionsConfig.wl | 166, 245-292 | Legacy option mapping |
| Config | `splitConfig` | OptionsConfig.wl | 300-304 | Extracts Symbolic subsystem options |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 829, 970 | Extracts and forwards via splitConfig |
| Forwarder | `processModels` | ProcessModels.wl | 79, 246-247 | Forwards via OptionValue extraction |
| **Consumer** | `solveCoeffsSystem` | ProcessModels.wl | 640, 770, 776, 779, 791 | **Terminal consumer** |

## Propagation Paths

### Path A: Via Normalized Config (Recommended)
```
buildModels["PdEquations" -> "AB"]
  → normalizeConfig → config["Symbolic"]["PdEquations"] = "AB"
  → buildModelsInternal[config]
  → splitConfig[config, "Symbolic"] → "PdEquations" -> "AB"
  → processModels[..., "PdEquations" -> "AB"]
  → solveCoeffsSystem[..., "PdEquations" -> "AB"]
  → pdMode = "AB" → computes eqAB0
```

### Path B: Via Legacy Flat Options
```
buildModels[PdEquations -> "Both"]  (* legacy style *)
  → normalizeConfig maps to config["Symbolic"]["PdEquations"]
  → [continues as Path A]
```

### Path C: Via Parallel Processing
```
buildModelsParallel[models, "PdEquations" -> "B"]
  → ParallelTable → buildModels for each model
  → [continues as Path A for each model]
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Symbolic phase only |
| Impact | Controls which PD equation systems are solved |
| Persistence | Stored in `model["coeffsParamQuadSolve"]["pd"]["pdMode"]` |
| No runtime switching | Decision made once in Phase 1, embedded in model |
````

</details>

<details>
<summary><code>options-forward/PerformanceGoal.md</code></summary>

````markdown
# PerformanceGoal Option

**Location in config:** `config["Compile"]["PerformanceGoal"]`
**Default value:** `"Quality"`
**Valid values:** `"Quality"` | `"Speed"`
**Legacy mapping:** `"PerformanceGoal" -> {"Compile", "PerformanceGoal"}` in OptionsConfig.wl:171

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ buildModels[...] (delegates)

ORCHESTRATION LAYER
│
└─ buildModelsInternal[config_Association]
   │
   └─ splitConfig[config, "Compile"]  ◄── EXTRACTS "PerformanceGoal"
      │
      └─ createCompiledEq[model, resourcesDir, opts...]
         │
         └─ buildKernel[..., "PerformanceGoal" -> value, ...]
            │  ◄── TERMINAL CONSUMER
            │
            ├─ If "Speed" + FunctionCompile:
            │  └─ CompilerRuntimeErrorAction -> None
            │  └─ OptimizationLevel -> 0
            │  └─ AbortHandling -> False
            │
            └─ If "Speed" + Compile:
               └─ RuntimeOptions -> "Speed"
```

## Entry Points (Public API)

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration in `Options[buildModels]` |
| Line 821 | Pattern: `buildModels[config_Association]` |
| Line 825 | Pattern: `buildModels[opts___?OptionQ]` |
| Lines 822, 826 | Normalizes via `normalizeConfig[]` |

**How received:** Via `OptionsPattern` or config Association
**How forwarded:** Config passed to `buildModelsInternal`

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 98 | Default: `"PerformanceGoal" -> "Quality"` (commented: `"Speed"`) |

### `normalizeConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 171 | Legacy mapping: `"PerformanceGoal" -> {"Compile", "PerformanceGoal"}` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 308-316 | `splitConfig[config, "Compile"]` definition |
| Line 311 | Extracts: `"PerformanceGoal" -> config["Compile"]["PerformanceGoal"]` |

## Intermediate Forwarders

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 829 | Receives normalized config as parameter |
| Lines 995-998 | Calls `createCompiledEq` with `splitConfig[config, "Compile"]` |

**How forwarded:** Via `splitConfig[config, "Compile"]`

### `createCompiledEq` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 1476-1533 | Function definition |
| Line 1479 | Filters options via `FilterRules[..., Options[buildKernel]]` |
| Lines 1513-1520 | Forwards to `buildKernel` via `Sequence @@ buildKernelOpts` |

**How received:** Via `OptionsPattern[{buildKernel, FunctionCompile, Compile}]`
**How forwarded:** Via FilterRules to `buildKernel`

## Terminal Consumer

### `buildKernel` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Line 86 | Option declaration: `"PerformanceGoal" -> "Speed"` |
| Line 104 | Extraction: `perfGoal = OptionValue["PerformanceGoal"]` |
| Lines 180-187 | FunctionCompile path: applies Speed optimizations |
| Lines 190-198 | Compile path: applies Speed optimizations |

**FunctionCompile path (lines 180-187):**
```wolfram
If[perfGoal === "Speed",
  {CompilerRuntimeErrorAction -> None,
   CompilerOptions -> {"AbortHandling" -> False, "OptimizationLevel" -> 0}},
  {}
]
```

**Compile path (lines 190-198):**
```wolfram
If[perfGoal === "Speed" && FreeQ[userOpts, RuntimeOptions],
  {RuntimeOptions -> "Speed"},
  {}
]
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Config | `defaultConfig` | OptionsConfig.wl | 98 | Default "Quality" |
| Config | `normalizeConfig` | OptionsConfig.wl | 171 | Legacy mapping |
| Config | `splitConfig` | OptionsConfig.wl | 308-316 | Extracts Compile options |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 829, 995-998 | Forwards via splitConfig |
| Forwarder | `createCompiledEq` | FindRootOptim.wl | 1476-1533 | Forwards via FilterRules |
| **Consumer** | `buildKernel` | FindRootOptim.wl | 86, 104, 180-198 | **Terminal consumer** |

## Propagation Paths

### Path A: Via Normalized Config (Recommended)
```
buildModels["PerformanceGoal" -> "Speed"]
  → normalizeConfig → config["Compile"]["PerformanceGoal"] = "Speed"
  → buildModelsInternal[config]
  → splitConfig[config, "Compile"] → "PerformanceGoal" -> "Speed"
  → createCompiledEq[..., "PerformanceGoal" -> "Speed", ...]
  → FilterRules extracts buildKernel-compatible options
  → buildKernel[..., "PerformanceGoal" -> "Speed"]
  → perfGoal = "Speed"
  → Applies low OptimizationLevel, disables error handling
```

### Path B: Via Legacy Flat Options
```
buildModels[PerformanceGoal -> "Speed"]
  → normalizeConfig maps to config["Compile"]["PerformanceGoal"]
  → [continues as Path A]
```

## Effect on Compilation

### "Quality" Mode (Default)

| Compiler | Effect |
|----------|--------|
| FunctionCompile | Default settings (full optimization, error handling) |
| Compile | Default RuntimeOptions |

### "Speed" Mode

| Compiler | Effect |
|----------|--------|
| FunctionCompile | `CompilerRuntimeErrorAction -> None`, `OptimizationLevel -> 0`, `AbortHandling -> False` |
| Compile | `RuntimeOptions -> "Speed"` |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Compile phase only |
| Default | `"Quality"` in config, `"Speed"` in buildKernel |
| Impact | Controls compiler optimization level and error handling |
| Terminal consumers | 1 (buildKernel) |
| Backends affected | Both FunctionCompile and Compile |
| Speed tradeoffs | Faster compilation, less optimization, reduced error handling |
````

</details>

<details>
<summary><code>options-forward/RecurrenceTable.md</code></summary>

````markdown
# RecurrenceTable Options

**Location in config:** `config["Numerical"]["RecurrenceTable"]`
**Default value:** Nested Association (see below)
**Flattened as:** `"RecurrenceTableOptions"` when extracted via splitConfig
**Legacy mapping:** `"RecurrenceTableOptions" -> {"Numerical", "RecurrenceTable", "Options"}` in OptionsConfig.wl:164

## Default Structure

```wolfram
"RecurrenceTable" -> <|
  "DependentVariables" -> Automatic,
  "Options" -> {}
|>
```

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ updateCoeffs[model, kernels, "RecurrenceTableOptions" -> {...}, ...]

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]
   │
   └─ Flattens: "RecurrenceTableOptions" -> Join[
        {"DependentVariables" -> ...},
        config["Numerical"]["RecurrenceTable"]["Options"]
      ]

NUMERICAL SOLVING PATH
│
└─ updateCoeffsSol[model, kernels, newParams, guessCoeffs, opts...]
   │
   ├─ recurrenceOpts = Flatten[{FilterRules[opts, Options[RecurrenceTable]],
   │                            OptionValue["RecurrenceTableOptions"]}]
   │
   └─ updateCoeffsBond[..., maxMaturity, coeffsWc, opts...]  ◄── TERMINAL CONSUMER
      │
      └─ Activate[... /. RecurrenceTableOptions -> FilterRules[opts, Options[RecurrenceTable]]]
         │
         └─ RecurrenceTable[...]  (Wolfram built-in)
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 113-116 | Default nested structure |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 338-341 | Flattens RecurrenceTable to "RecurrenceTableOptions" |

**Flattening logic:**
```wolfram
"RecurrenceTableOptions" -> Join[
  {"DependentVariables" -> config["Numerical"]["RecurrenceTable"]["DependentVariables"]},
  config["Numerical"]["RecurrenceTable"]["Options"]
]
```

## Intermediate Forwarders

### `addCoeffsSolution` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Lines 904-911 | Option declarations |
| Line 909 | `"RecurrenceTableOptions" -> {}` |
| Lines 1029-1032 | Combines options via FilterRules and OptionValue |

**Option combination:**
```wolfram
recurrenceTableOpts = Flatten[{
  Evaluate[FilterRules[Flatten@{opts}, Options[RecurrenceTable]]],
  Evaluate[First@OptionValue[addCoeffsSolution, {"RecurrenceTableOptions"}]]
}]
```

### `updateCoeffsSol` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 333-349 | Option declarations |
| Line 336 | `"RecurrenceTableOptions" -> {"DependentVariables" -> Automatic}` |
| Lines 619-622 | Extracts and combines options |

**Option extraction:**
```wolfram
recurrenceOpts = Flatten[{
  FilterRules[Flatten @ {opts}, Options[RecurrenceTable]],
  OptionValue["RecurrenceTableOptions"]
}]
```

## Terminal Consumer

### `updateCoeffsBond` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 697-712 | Function definition |
| Line 707 | Applies options to Inactive[RecurrenceTable] |

**Usage pattern:**
```wolfram
Activate[
  (#[maxMaturity]& /@ modelCoeffsSolution) //.
    ... /.
    (x_Symbol?(MatchQ[SymbolName[#], "RecurrenceTableOptions"]&) ->
      FilterRules[Flatten@{opts}, Options[RecurrenceTable]])
]
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 113-116 | Default nested structure |
| Config | `splitConfig` | OptionsConfig.wl | 338-341 | Flattens to "RecurrenceTableOptions" |
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Forwarder | `addCoeffsSolution` | ProcessModels.wl | 904-1032 | Declares and combines options |
| Forwarder | `updateCoeffsSol` | SolveEulerEq.wl | 333-622 | Extracts and forwards |
| **Consumer** | `updateCoeffsBond` | SolveEulerEq.wl | 697-712 | **Terminal consumer** |
| Built-in | `RecurrenceTable` | (System) | N/A | Ultimate consumer |

## Propagation Paths

### Path A: Configuration-driven
```
buildModels[<|"Numerical" -> <|"RecurrenceTable" -> <|"DependentVariables" -> {...}|>|>|>]
  → normalizeConfig → merges with defaults
  → splitConfig[config, "Numerical"]
  → "RecurrenceTableOptions" -> {"DependentVariables" -> {...}}
  → (flows through options system)
```

### Path B: Direct Option Passing
```
updateCoeffs[model, kernels, params, "RecurrenceTableOptions" -> {...}]
  → updateCoeffsSol[..., opts]
  → FilterRules extracts RecurrenceTable options
  → updateCoeffsBond[..., opts]
  → Activate[Inactive[RecurrenceTable][...]]
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - bond computations |
| Nested structure | Yes - Association with "DependentVariables" and "Options" |
| Conditional activation | Only when UpdateBond/UpdateBonds = True |
| Inactive/Activate pattern | Uses Inactive[RecurrenceTable] for deferred evaluation |
| Primary sub-option | DependentVariables controls symbol resolution |
````

</details>

<details>
<summary><code>options-forward/ReduceTimeLimit.md</code></summary>

````markdown
# ReduceTimeLimit Option

**Location in config:** `config["Numerical"]["ReduceTimeLimit"]`
**Default value:** `5.` (seconds)
**Legacy mapping:** `"ReduceTimeLimit" -> {"Numerical", "ReduceTimeLimit"}` in OptionsConfig.wl:190

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ updateCoeffs[model, kernels, opts...]

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]  ◄── EXTRACTS "ReduceTimeLimit"
   │
   └─ "ReduceTimeLimit" -> config["Numerical"]["ReduceTimeLimit"]

NUMERICAL SOLVING PATH (nD only)
│
└─ updateCoeffsSol → solveCoeffRoots → solveND
   │
   ├─ solveND receives "ReduceTimeLimit" -> 5.
   │
   └─ safeReduceCall[conds, paramsAll, signs, cName, sName, findOpts, timeout]
      │  ◄── TERMINAL CONSUMER
      │
      └─ TimeConstrained[
           findRootInterval[...],
           timeout,
           $Failed
         ]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 134 | Default: `"ReduceTimeLimit" -> 5.` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Line 349 | Extracts: `"ReduceTimeLimit" -> config["Numerical"]["ReduceTimeLimit"]` |

## Intermediate Forwarders

### `solveCoeffRoots` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 803-904 | Function definition |
| Lines 851-858 | For nD case: passes to `solveND` |

**⚠️ GAP - Hardcoded Value:** Despite `splitConfig` extracting `ReduceTimeLimit` from config, `solveCoeffRoots` **hard-codes** `"ReduceTimeLimit" -> 5.` in the call to `solveND`, ignoring any configured value. See `options-issues.md` for details.

**nD delegation (showing hardcoded value):**
```wolfram
If[Length[coefList] > 1,
  Return[
    solveND[f, df, conds, paramsAll, signs, coefList, cName, sName,
            findOpts, extractOpts, scanOpts, quadSol["Solution"],
            "ReduceTimeLimit" -> 5.],  (* <-- HARDCODED, ignores config *)
    Module
  ]
]
```

## Terminal Consumer

### `solveND` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 207-261 | Function definition |
| Lines 208-209 | Option declaration: `"ReduceTimeLimit" -> 5.` |
| Line 246 | `reduceExpr = safeReduceCall[..., OptionValue["ReduceTimeLimit"]]` |

### `safeReduceCall` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 84-91 | Function definition |
| Line 86-90 | `TimeConstrained[findRootInterval[...], timeout, $Failed]` |

**Implementation:**
```wolfram
safeReduceCall[conds_, paramsAll_, signs_, cName_, sName_, findOpts_, timeout_] :=
  TimeConstrained[
    findRootInterval[conds, paramsAll,
      "Signs" -> signs, "CoeffName" -> cName,
      "SignSymbol" -> sName, Sequence @@ findOpts],
    timeout,
    $Failed
  ]
```

## Fallback Chain

When `safeReduceCall` times out (returns `$Failed`):

1. **trySmartIntervals**: Uses Infinity padding → returns `$Failed`
2. **tryArtificialBox**: Uses finite bounds → may succeed
3. **nMinimizeFallback**: Optimization-based solving → last resort
4. **Empty result**: If all fail

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 134 | Default 5.0 |
| Config | `splitConfig` | OptionsConfig.wl | 349 | Extraction |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Wrapper |
| Forwarder | `solveCoeffRoots` | SolveEulerEq.wl | 851-858 | Delegates to solveND |
| Consumer | `solveND` | SolveEulerEq.wl | 207-261 | Extracts and passes |
| **Terminal** | `safeReduceCall` | SolveEulerEq.wl | 84-91 | TimeConstrained wrapper |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - nD root finding only |
| Default | 5.0 seconds |
| Applies to | Multi-dimensional coefficient systems (Length[coefList] > 1) |
| Does NOT apply to | 1D coefficient systems (direct findRootInterval) |
| Fallback behavior | Graceful degradation through fallback chain |
| Error handling | Returns `$Failed` on timeout, triggers fallbacks |
````

</details>

<details>
<summary><code>options-forward/RootSigns.md</code></summary>

````markdown
# RootSigns Option

**Location in config:** `config["Numerical"]["RootSigns"]`
**Default value:** `Automatic`
**Valid values:** `Automatic` | `All` | Custom Association
**Legacy mapping:** `"RootSigns" -> {"Numerical", "RootSigns"}` in OptionsConfig.wl:184

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ updateCoeffs[model, kernels, "RootSigns" -> value, ...]

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]  ◄── EXTRACTS "RootSigns"
   │
   └─ "RootSigns" -> config["Numerical"]["RootSigns"]

NUMERICAL SOLVING PATH
│
└─ updateCoeffsSol[model, kernels, newParams, guessCoeffs, opts...]
   │
   ├─ rootSigns = OptionValue["RootSigns"]
   │
   └─ normalizeRootSigns[rootSigns, extractSignIndex[kernels]]
      │
      └─ Returns: <|"wc" -> {...}, "pd" -> {...}|>
         │
         ├─ computeWcCoeffs[..., rootSignsNorm, rootSigns, ...]
         │  └─ updateCoeffsWcPd["wc", ...]
         │
         └─ computePdCoeffs[..., rootSignsNorm, rootSigns, ...]
            └─ updateCoeffsWcPd["pd", ...]
               │
               └─ solveCoeffRoots[..., signs, ...]  ◄── TERMINAL CONSUMER
                  │
                  ├─ bindUnary[..., "Signs" -> signs]
                  └─ findRootInterval[..., "Signs" -> signs, ...]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 118 | Default: `"RootSigns" -> Automatic` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Line 343 | Extracts: `"RootSigns" -> config["Numerical"]["RootSigns"]` |

## Intermediate Forwarders

### `updateCoeffsSol` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 333-349 | Option declarations |
| Line 342 | `"RootSigns" -> Automatic` |
| Line 603 | `rootSigns = OptionValue["RootSigns"]` |
| Line 613 | `normalizeRootSigns[rootSigns, extractSignIndex[kernels]]` |

### `normalizeRootSigns` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 456-502 | Function definition |

**Normalization logic:**
- `Automatic`: Filters to non-empty solutions only
- `All`: Returns all sign combinations including empty ones
- Custom Association: Uses explicit sign combinations provided

**Output format:**
```wolfram
<|"wc" -> {sign_tuples...}, "pd" -> {sign_tuples...}|>
```

### `computeWcCoeffs` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 463-505 | Function definition |
| Receives | `rootSignsNorm` (normalized) and `rootSigns` (original) |
| Forwards | To `updateCoeffsWcPd["wc", ...]` |

### `computePdCoeffs` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 508-543 | Function definition |
| Iterates | Through normalized signs for stock-specific B coefficient computation |

## Terminal Consumer

### `solveCoeffRoots` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 803-904 | Function definition |
| Line 807 | Receives `signs : ({} \| {_Integer ..}) : {}` |
| Line 840 | `bindUnary[..., "Signs" -> signs]` |
| Line 862 | `findRootInterval[..., "Signs" -> signs, ...]` |

**Usage:** Individual sign tuples from normalized RootSigns are passed to root-finding functions.

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 118 | Default Automatic |
| Config | `splitConfig` | OptionsConfig.wl | 343 | Extracts from config |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Wrapper |
| Forwarder | `updateCoeffsSol` | SolveEulerEq.wl | 342, 603, 613 | Extracts and normalizes |
| Processor | `normalizeRootSigns` | SolveEulerEq.wl | 456-502 | Converts to explicit tuples |
| Forwarder | `computeWcCoeffs` | SolveEulerEq.wl | 463-505 | Wealth-consumption path |
| Forwarder | `computePdCoeffs` | SolveEulerEq.wl | 508-543 | Price-dividend path |
| **Consumer** | `solveCoeffRoots` | SolveEulerEq.wl | 803-904 | Uses sign tuples |

## Propagation Paths

### Path A: Automatic (Default)
```
buildModels[]  (* no RootSigns specified *)
  → RootSigns = Automatic
  → normalizeRootSigns filters to non-empty solutions
  → Only valid sign combinations processed
```

### Path B: All
```
updateCoeffs[..., "RootSigns" -> All]
  → normalizeRootSigns returns all sign combinations
  → Including empty solutions
```

### Path C: Custom Association
```
updateCoeffs[..., "RootSigns" -> <|"wc" -> {{1, -1}}, "pd" -> {{1, 1}}|>]
  → Uses explicit sign combinations provided
  → Bypasses automatic detection
```

## Value Behaviors

| Value | Behavior |
|-------|----------|
| `Automatic` | Filters to non-empty solutions only |
| `All` | Returns all sign combinations including empty |
| `<\|...\|>` | Uses explicit sign combinations provided |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - root finding |
| Default | `Automatic` |
| Impact | Controls which square root sign combinations to solve |
| Related option | "Signs" (explicit sign values for individual roots) |
| Sign extraction | Via `extractSignIndex[kernels]` |
````

</details>

<details>
<summary><code>options-forward/RuntimeOptions.md</code></summary>

````markdown
# RuntimeOptions Option

**Location in config:** `config["Compile"]["RuntimeOptions"]`
**Default value:** `Automatic` (commented alternative: `"Speed"`)
**Legacy mapping:** `"RuntimeOptions" -> {"Compile", "RuntimeOptions"}` in OptionsConfig.wl:172

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ buildModels[...] (delegates)

ORCHESTRATION LAYER
│
└─ buildModelsInternal[config_Association]
   │
   └─ splitConfig[config, "Compile"]  ◄── EXTRACTS "RuntimeOptions"
      │
      └─ createCompiledEq[model, resourcesDir, opts...]
         │
         └─ buildKernel[..., opts...]
            │  ◄── TERMINAL CONSUMER
            │
            └─ Compile[..., RuntimeOptions -> value, ...]
```

## Entry Points (Public API)

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration in `Options[buildModels]` |
| Line 821 | Pattern: `buildModels[config_Association]` |
| Line 825 | Pattern: `buildModels[opts___?OptionQ]` |

**How received:** Via `OptionsPattern` or config Association
**How forwarded:** Config passed to `buildModelsInternal`

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 101 | Default: `"RuntimeOptions" -> Automatic` (commented: `"Speed"`) |

### `normalizeConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 172 | Legacy mapping: `"RuntimeOptions" -> {"Compile", "RuntimeOptions"}` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 308-316 | `splitConfig[config, "Compile"]` definition |
| Line 314 | Extracts: `"RuntimeOptions" -> config["Compile"]["RuntimeOptions"]` |

## Intermediate Forwarders

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 829 | Receives normalized config as parameter |
| Lines 995-998 | Calls `createCompiledEq` with `splitConfig[config, "Compile"]` |

**How forwarded:** Via `splitConfig[config, "Compile"]`

### `createCompiledEq` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 1476-1533 | Function definition |
| Line 1479 | Filters via `FilterRules[..., Options[Compile]]` |
| Lines 1513-1520 | Forwards to `buildKernel` via `Sequence @@ buildKernelOpts` |

**How received:** Via `OptionsPattern[{buildKernel, FunctionCompile, Compile}]`
**How forwarded:** Via FilterRules to `buildKernel`

## Terminal Consumer

### `buildKernel` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 83-91 | Option declarations (RuntimeOptions inherited from Compile) |
| Lines 189-198 | Conditional application based on PerformanceGoal |
| Lines 254-259 | Passed to `Compile[...]` |

**Conditional logic (lines 189-198):**
```wolfram
Module[{userOpts = FilterRules[Flatten@{opts}, Options[Compile]], defaults},
  defaults = Join[
    If[FreeQ[userOpts, CompilationTarget], {CompilationTarget -> "C"}, {}],
    (* Add RuntimeOptions -> Speed if PerformanceGoal is Speed and not specified *)
    If[perfGoal === "Speed" && FreeQ[userOpts, RuntimeOptions],
      {RuntimeOptions -> "Speed"},
      {}
    ]
  ];
  Join[userOpts, defaults]
]
```

**Compile call (lines 254-259):**
```wolfram
Compile[
  Evaluate @ convertTypesForCompile[Flatten@{funcArgs}],
  Evaluate @ (funcBody /. TypeHint[e_, _] :> e),
  Evaluate[Sequence @@ compOpts]  (* <-- RuntimeOptions included here *)
]
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Config | `defaultConfig` | OptionsConfig.wl | 101 | Default Automatic |
| Config | `normalizeConfig` | OptionsConfig.wl | 172 | Legacy mapping |
| Config | `splitConfig` | OptionsConfig.wl | 308-316 | Extracts Compile options |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 829, 995-998 | Forwards via splitConfig |
| Forwarder | `createCompiledEq` | FindRootOptim.wl | 1476-1533 | Forwards via FilterRules |
| **Consumer** | `buildKernel` | FindRootOptim.wl | 189-198, 254-259 | **Terminal consumer** |
| Built-in | `Compile` | (System) | N/A | Ultimate consumer |

## Propagation Paths

### Path A: Explicit RuntimeOptions
```
buildModels["RuntimeOptions" -> "Speed"]
  → normalizeConfig → config["Compile"]["RuntimeOptions"] = "Speed"
  → buildModelsInternal[config]
  → splitConfig[config, "Compile"] → "RuntimeOptions" -> "Speed"
  → createCompiledEq[..., "RuntimeOptions" -> "Speed", ...]
  → buildKernel[..., "RuntimeOptions" -> "Speed", ...]
  → Compile[..., RuntimeOptions -> "Speed", ...]
```

### Path B: Automatic with PerformanceGoal="Speed"
```
buildModels["PerformanceGoal" -> "Speed", "RuntimeOptions" -> Automatic]
  → ... → buildKernel
  → perfGoal = "Speed", RuntimeOptions not explicitly set
  → Defaults applied: {RuntimeOptions -> "Speed"}
  → Compile[..., RuntimeOptions -> "Speed", ...]
```

### Path C: Automatic with PerformanceGoal="Quality"
```
buildModels["PerformanceGoal" -> "Quality", "RuntimeOptions" -> Automatic]
  → ... → buildKernel
  → perfGoal = "Quality"
  → No RuntimeOptions default added
  → Compile uses its own default
```

## Interaction with PerformanceGoal

| PerformanceGoal | RuntimeOptions (user) | Effective RuntimeOptions |
|-----------------|----------------------|--------------------------|
| "Quality" | Automatic | (Compile default) |
| "Quality" | "Speed" | "Speed" |
| "Speed" | Automatic | "Speed" (auto-applied) |
| "Speed" | "Speed" | "Speed" |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Compile phase only |
| Default | `Automatic` |
| Impact | Controls runtime behavior of compiled functions |
| Conditional application | Applied as "Speed" when PerformanceGoal="Speed" |
| Only for Compile | Not used with FunctionCompile backend |
| Terminal consumer | `Compile` (Wolfram built-in) |
````

</details>

<details>
<summary><code>options-forward/Scan.md</code></summary>

````markdown
# Scan Options

**Location in config:** `config["Numerical"]["Scan"]`
**Default value:** Nested Association (see below)
**Note:** These options are defined in defaultConfig but NOT currently extracted in splitConfig

## Default Structure

```wolfram
"Scan" -> <|
  "FastRootOptions" -> {},
  "UnboundedPad" -> 1000,
  "ScanMethod" -> "Grid"
|>
```

## Configuration Gap

**Important:** The Scan options are defined in `defaultConfig` but are NOT extracted in `splitConfig[config, "Numerical"]`. This means they must be passed directly via options rather than through the buildModels configuration system.

## Complete Propagation Tree

```
ENTRY POINTS (Direct Option Passing Only)
│
├─ scanAndSolve[f, {min, max}, "FastRootOptions" -> {...}, ...]
│
└─ extractIntervalsFromReduce[conds, params, "UnboundedPad" -> n, ...]

ACTUAL USAGE PATH (not from config)
│
└─ solveCoeffRoots[quadSol, kernel, paramsBase, signs, extraParams, opts...]
   │
   ├─ scanOpts = FilterRules[opts, Join[Options[scanAndSolve], Options[FindRoot], Options[fastRoot]]]
   │
   └─ scanAndSolve[First@*f, #, Sequence @@ scanOpts]
      │
      ├─ OptionValue["FastRootOptions"]
      │
      └─ fastRoot[..., Sequence @@ fastOpts]  ◄── TERMINAL CONSUMER
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 119-123 | Default nested structure defined |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | **DOES NOT extract Scan options** |

**Gap:** The splitConfig function for "Numerical" does not include Scan options, creating a disconnect between configuration and usage.

## Direct Usage (Functions That Declare These Options)

### `scanAndSolve` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 1015-1020 | Option declarations |
| Line 1019 | `"FastRootOptions" -> {}` |
| Line 1146 | `OptionValue["FastRootOptions"]` |

### `extractIntervalsFromReduce` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 1282-1286 | Option declarations |
| Line 1284 | `"UnboundedPad" -> 1.*^5` (default different from config!) |
| Line 1297 | `OptionValue["UnboundedPad"]` |

## Intermediate Forwarders

### `solveCoeffRoots` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 803-904 | Function definition |
| Lines 834-837 | Extracts scanOpts via FilterRules |
| Line 867 | `scanAndSolve[..., Sequence @@ scanOpts]` |

### `solveND` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 212-219 | Function definition |
| Line 219 | Accesses UnboundedPad from extractOpts |

### `trySmartIntervals` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 102-141 | Function definition |
| Line 118 | `convertInfinityBounds[a, b, pad]` |

## Terminal Consumers

### `fastRoot` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 517-525 | Option declarations |
| Usage | Receives FastRootOptions from scanAndSolve |

### `convertInfinityBounds` (Internal Helper)

Receives the UnboundedPad value and applies it to convert infinite bounds to finite ones.

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 119-123 | Defines defaults (NOT EXTRACTED) |
| **Gap** | `splitConfig` | OptionsConfig.wl | 320-350 | **Missing extraction** |
| Declares | `scanAndSolve` | FindRootOptim.wl | 1015-1020 | FastRootOptions |
| Declares | `extractIntervalsFromReduce` | FindRootOptim.wl | 1282-1286 | UnboundedPad |
| Forwarder | `solveCoeffRoots` | SolveEulerEq.wl | 834-867 | FilterRules extraction |
| **Consumer** | `fastRoot` | FindRootOptim.wl | 517-525 | FastRootOptions |

## Propagation Paths

### Path A: Direct Option Passing (Working)
```
solveCoeffRoots[..., "FastRootOptions" -> {...}, ...]
  → scanOpts = FilterRules[opts, Options[scanAndSolve]]
  → scanAndSolve[..., Sequence @@ scanOpts]
  → fastRoot[..., Sequence @@ fastOpts]
```

### Path B: Configuration (NOT WORKING)
```
buildModels[<|"Numerical" -> <|"Scan" -> <|"FastRootOptions" -> {...}|>|>|>]
  → normalizeConfig
  → splitConfig[config, "Numerical"]
  → **Scan options NOT extracted**
  → Options lost!
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - root scanning |
| Config gap | Defined but not extracted in splitConfig |
| Workaround | Pass options directly to updateCoeffs/solveCoeffRoots |
| FastRootOptions | Controls fast root-finding algorithm |
| UnboundedPad | Converts infinite bounds to finite (default 1000 in config, 1e5 in function) |
| ScanMethod | Grid-based scanning method |

## Note on Default Discrepancy

The `UnboundedPad` has different defaults:
- In `defaultConfig`: `1000`
- In `extractIntervalsFromReduce`: `1.*^5` (100,000)

Since the config value is not extracted, the function default (1e5) is used.
````

</details>

<details>
<summary><code>options-forward/SignSymbol.md</code></summary>

````markdown
# SignSymbol Option

**Location in config:** `config["Compile"]["SignSymbol"]`
**Default value:** `"signA"` (string)
**Also exists at:** `config["Symbolic"]["paramQuadSolveOptions"]["SignSymbol"]` as `Symbol["signA"]`
**Legacy mapping:** `"SignSymbol" -> {"Compile", "SignSymbol"}` in OptionsConfig.wl:170 (ambiguous option)

## Type Duality

This option exists in **two forms** depending on context:

| Context | Location | Type | Default |
|---------|----------|------|---------|
| Compile | `config["Compile"]["SignSymbol"]` | String | `"signA"` |
| Symbolic | `config["Symbolic"]["paramQuadSolveOptions"]["SignSymbol"]` | Symbol | `Symbol["signA"]` |

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ buildModels[...] (delegates)

COMPILE SUBSYSTEM PATH
│
└─ buildModelsInternal[config_Association]
   │
   └─ splitConfig[config, "Compile"]  ◄── EXTRACTS "SignSymbol" (string)
      │
      └─ createCompiledEq[model, resourcesDir, opts...]
         │
         └─ buildKernel[..., "SignSymbol" -> "signA", ...]
            │  ◄── TERMINAL CONSUMER
            └─ signSym = OptionValue["SignSymbol"]
               └─ idx = signIdxs[ex0, signSym]

SYMBOLIC SUBSYSTEM PATH
│
└─ buildModelsInternal[config_Association]
   │
   └─ splitConfig[config, "Symbolic"]  ◄── EXTRACTS paramQuadSolveOptions
      │
      └─ processModels → solveCoeffsSystem
         │
         └─ paramQuadSolve[..., "SignSymbol" -> Symbol["signA"], ...]
            │  ◄── TERMINAL CONSUMER
            └─ signHead = OptionValue["SignSymbol"]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 89 | Symbolic: `"SignSymbol" -> Symbol["signA"]` inside paramQuadSolveOptions |
| Line 97 | Compile: `"SignSymbol" -> "signA"` |

### `ambiguousOptions` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 200-203 | Maps SignSymbol to correct context based on subsystem |

```wolfram
ambiguousOptions = <|
  "SignSymbol" -> <|
    "Symbolic" -> {"Symbolic", "paramQuadSolveOptions", "SignSymbol"},
    "Compile" -> {"Compile", "SignSymbol"}
  |>
|>;
```

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 310 | Compile: `"SignSymbol" -> config["Compile"]["SignSymbol"]` |
| Line 303 | Symbolic: Included in `"paramQuadSolveOptions"` extraction |

## Terminal Consumers (Compile Subsystem)

### `buildKernel` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Line 85 | Option declaration: `"SignSymbol" -> "signA"` |
| Line 103 | Extraction: `signSym = OptionValue["SignSymbol"]` |
| Line 140 | Usage: `idx = signIdxs[ex0, signSym]` |
| Line 354 | Storage: `"SignSymbol" -> signSym` in output Association |

**Purpose:** Detects sign indices in compiled expressions (e.g., signA[1], signA[2]).

### `findRootInterval` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Line 432 | Option declaration: `"SignSymbol" -> "signA"` |
| Line 444 | Extraction: `signSym = OptionValue["SignSymbol"]` |
| Line 469 | Conversion: `signHead = ToExpression[signSym]` |

**Purpose:** Converts string to symbol for pattern matching in root-finding.

## Terminal Consumer (Symbolic Subsystem)

### `paramQuadSolve` in `Kernel/ComputationalEngine/ParamQuadSolve.wl`

| Location | What happens |
|----------|--------------|
| Line 81 | Option declaration: `"SignSymbol" -> signA` (symbol, not string) |
| Line 117 | Extraction: `signHead = OptionValue["SignSymbol"]` |

**Purpose:** Uses symbol directly for creating sign variables (signA[k]) in parametric solutions.

## Intermediate Forwarders

### `solveCoeffRoots` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Line 831 | Retrieves: `sName = Lookup[savedKernel, "SignSymbol"]` |
| Line 862 | Forwards: `findRootInterval[..., "SignSymbol" -> sName, ...]` |

### `safeReduceCall` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Line 88 | Forwards to `findRootInterval[..., "SignSymbol" -> sName, ...]` |

### `buildEqMapFromModel` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 1439, 1449, 1461 | Generates SignSymbol values for equation maps |

## Summary Table

| Layer | Function | File | Lines | Role | Type |
|-------|----------|------|-------|------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 89, 97 | Default values | Symbol/String |
| Config | `ambiguousOptions` | OptionsConfig.wl | 200-203 | Context mapping | N/A |
| Config | `splitConfig` | OptionsConfig.wl | 303, 310 | Extraction | Both |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 829, 998 | Forwards | Both |
| Forwarder | `createCompiledEq` | FindRootOptim.wl | 1476-1533 | Forwards to buildKernel | String |
| **Consumer** | `buildKernel` | FindRootOptim.wl | 85, 103, 140, 354 | Sign index detection | String |
| **Consumer** | `findRootInterval` | FindRootOptim.wl | 432, 444, 469 | Pattern matching | String |
| Forwarder | `solveCoeffRoots` | SolveEulerEq.wl | 831, 862 | Retrieves, forwards | String |
| **Consumer** | `paramQuadSolve` | ParamQuadSolve.wl | 81, 117 | Sign variables | Symbol |

## Propagation Paths

### Path A: Compile Subsystem (String Form)
```
buildModels["SignSymbol" -> "signB"]
  → normalizeConfig → config["Compile"]["SignSymbol"] = "signB"
  → buildModelsInternal[config]
  → splitConfig[config, "Compile"] → "SignSymbol" -> "signB"
  → createCompiledEq → buildKernel
  → signSym = OptionValue["SignSymbol"] → "signB"
  → signIdxs[expr, "signB"] detects signB[1], signB[2], etc.
```

### Path B: Symbolic Subsystem (Symbol Form)
```
buildModels[<|"Symbolic" -> <|"paramQuadSolveOptions" -> <|"SignSymbol" -> signB|>|>|>]
  → normalizeConfig → merges with defaults
  → splitConfig[config, "Symbolic"]
  → solveCoeffsSystem → paramQuadSolve
  → signHead = OptionValue["SignSymbol"] → signB (symbol)
  → Creates signB[k] variables in parametric solutions
```

### Path C: Root-Finding (String to Symbol Conversion)
```
solveCoeffRoots[..., savedKernel, ...]
  → sName = Lookup[savedKernel, "SignSymbol"] → "signA" (string)
  → findRootInterval[..., "SignSymbol" -> "signA", ...]
  → signHead = ToExpression[signSym] → signA (symbol)
  → Creates rules: signA[1] -> +1, signA[2] -> -1, etc.
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Type duality | String in Compile, Symbol in Symbolic |
| Default values | `"signA"` (Compile), `Symbol["signA"]` (Symbolic) |
| Ambiguous option | Handled by `ambiguousOptions` in OptionsConfig.wl |
| Primary usage | Detecting/creating sign variables like signA[1], signA[2] |
| Conversion | `ToExpression[signSym]` converts string to symbol when needed |
| Caching | Stored in kernel Association for reuse |
````

</details>

<details>
<summary><code>options-forward/Signs.md</code></summary>

````markdown
# Signs Option

**Location in config:** `config["Numerical"]["Signs"]`
**Default value:** `{}`
**Legacy mapping:** `"Signs" -> {"Numerical", "Signs"}` in OptionsConfig.wl:185

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ solveCoeffRoots[..., signs, ...]
   └─ Direct parameter

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]  ◄── EXTRACTS "Signs"
   │
   └─ "Signs" -> config["Numerical"]["Signs"]

NUMERICAL SOLVING PATH
│
└─ solveCoeffRoots[quadSol, kernel, paramsBase, signs, extraParams, opts...]
   │
   ├─ bindUnary[kernel, paramsAll, "Signs" -> signs]  ◄── TERMINAL CONSUMER
   │  │
   │  └─ signs = OptionValue["Signs"]
   │     └─ Binds sign values into compiled kernel
   │
   └─ findRootInterval[conds, paramsAll, "Signs" -> signs, ...]  ◄── TERMINAL CONSUMER
      │
      └─ signs = OptionValue["Signs"]
         └─ Creates signsRule: Table[signHead[i] -> signs[[i]], ...]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 124 | Default: `"Signs" -> {}` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Line 344 | Extracts: `"Signs" -> config["Numerical"]["Signs"]` |

## Terminal Consumers

### `bindUnary` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 363-424 | Function definition |
| Lines 363-365 | Option declaration: `"Signs" -> {}` |
| Line 374 | `signs = OptionValue["Signs"]` |
| Lines 396-407 | Validates and processes signs array |
| Lines 415-420 | Creates specialized functions with signs bound |

**Validation:**
- Checks length matches expected count (maxIdx from kernel)
- Each element must be ±1
- Returns error message if validation fails

### `findRootInterval` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 430-510 | Function definition |
| Lines 430-434 | Option declaration: `"Signs" -> {}` |
| Line 445 | `signs = OptionValue["Signs"]` |
| Line 470-472 | Creates signsRule substitution table |

**Usage:**
```wolfram
signsRule = Table[signHead[i] -> signs[[i]], {i, Length@signs}]
```

### `solveCoeffRoots` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 803-904 | Function definition |
| Line 807 | Receives `signs : ({} \| {_Integer ..}) : {}` as parameter |
| Line 840 | `bindUnary[savedKernel, paramsAll, "Signs" -> signs]` |
| Line 862 | `findRootInterval[..., "Signs" -> signs, ...]` |
| Line 874 | Creates signsRule for analytical substitution |

### `safeReduceCall` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 85-91 | Helper function |
| Line 88 | `findRootInterval[..., "Signs" -> signs, ...]` |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 124 | Default {} |
| Config | `splitConfig` | OptionsConfig.wl | 344 | Extracts from config |
| **Consumer** | `bindUnary` | FindRootOptim.wl | 363-424 | Binds to compiled kernel |
| **Consumer** | `findRootInterval` | FindRootOptim.wl | 430-510 | Creates substitution rules |
| Orchestrator | `solveCoeffRoots` | SolveEulerEq.wl | 803-904 | Forwards to consumers |
| Wrapper | `safeReduceCall` | SolveEulerEq.wl | 85-91 | Timeout wrapper |

## Propagation Paths

### Path A: Configuration-driven
```
buildModels[<|"Numerical" -> <|"Signs" -> {1, -1}|>|>]
  → normalizeConfig → merges with defaults
  → splitConfig[config, "Numerical"] → "Signs" -> {1, -1}
  → (flows through options to solveCoeffRoots)
```

### Path B: Direct Parameter (solveCoeffRoots)
```
solveCoeffRoots[quadSol, kernel, params, {1, -1}, ...]
  → bindUnary[..., "Signs" -> {1, -1}]
  → Binds signA[1] -> 1, signA[2] -> -1
```

### Path C: Forwarded via RootSigns
```
RootSigns -> Automatic
  → normalizeRootSigns extracts sign combinations
  → solveCoeffRoots called for each combination
  → Signs passed as individual tuples
```

## Relationship with RootSigns

| Aspect | Signs | RootSigns |
|--------|-------|-----------|
| Level | Low-level (individual tuple) | High-level (combination selection) |
| Default | `{}` | `Automatic` |
| Usage | Direct sign values | Selection mode |
| Consumer | bindUnary, findRootInterval | normalizeRootSigns |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - root finding |
| Default | `{}` (empty list - no signs) |
| Valid values | List of -1 and 1 |
| Validation | Length must match sign count in kernel |
| Purpose | Selects square root branches (±√x) |
| Related option | RootSigns (high-level selection) |
| Error handling | Messages for length mismatch or invalid values |
````

</details>

<details>
<summary><code>options-forward/SimplifyOptions.md</code></summary>

````markdown
# SimplifyOptions Option

**Location in config:** `config["Symbolic"]["SimplifyOptions"]`
**Default value:** `{TimeConstraint -> {5, 300}}`
**Legacy mapping:** `"SimplifyOptions" -> {"Symbolic", "SimplifyOptions"}` in OptionsConfig.wl:167

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ buildModels[...] (delegates)

ORCHESTRATION LAYER
│
└─ buildModelsInternal[config_Association]
   │
   └─ splitConfig[config, "Symbolic"]  ◄── EXTRACTS "SimplifyOptions"
      │
      └─ processModels[modelsCatalog, splitConfig_result...]
         │
         ├─ simplifyCoeffsSystem[...]  ◄── TERMINAL CONSUMER
         │  └─ FullSimplify[..., Sequence @@ simplifyOpts]
         │
         └─ solveCoeffsSystem[...]  ◄── TERMINAL CONSUMER
            │
            ├─ Simplify[solA["Solution"], Sequence @@ simplifyOpts]
            ├─ Simplify[solB["Solution"], Sequence @@ simplifyOpts]
            ├─ FullSimplify[eqA0Unsimplified, Sequence @@ simplifyOpts]
            ├─ FullSimplify[eqB0, Sequence @@ simplifyOpts]
            │
            └─ tryTransforms[..., Sequence @@ simplifyOpts]  ◄── TERMINAL CONSUMER
               └─ Simplify[expr /. tr, Sequence @@ simplifyOpts]
```

## Entry Points (Public API)

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration in `Options[buildModels]` |
| Line 821 | Pattern: `buildModels[config_Association]` |
| Line 825 | Pattern: `buildModels[opts___?OptionQ]` |
| Lines 822, 826 | Normalizes via `normalizeConfig[]` |

**How received:** Via `OptionsPattern` in function definition
**How forwarded:** Config passed to `buildModelsInternal`

### `buildModelsParallel` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 1138-1143 | Option declaration |
| Lines 1193-1199 | Forwards to recursive `buildModels` calls |

**How received:** Via `OptionsPattern` with inheritance from `buildModels`
**How forwarded:** Passed to `buildModels` in parallel table

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 77 | Default: `"SimplifyOptions" -> {TimeConstraint -> {5, 300}}` |

### `normalizeConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 167 | Legacy mapping: `"SimplifyOptions" -> {"Symbolic", "SimplifyOptions"}` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 300-304 | `splitConfig[config, "Symbolic"]` definition |
| Line 302 | Extracts: `"SimplifyOptions" -> config["Symbolic"]["SimplifyOptions"]` |

## Intermediate Forwarders

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 829 | Receives normalized config as parameter |
| Line 970 | Extracts Symbolic options: `splitConfig[config, "Symbolic"]` |

**How received:** Normalized config Association
**How forwarded:** Via `splitConfig[config, "Symbolic"]`

### `processModels` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Line 79 | `OptionsPattern[{solveCoeffsSystem, updateCoeffs, ...}]` - inherits options |
| Line 246 | Forwards to `solveCoeffsSystem` |

**How received:** Via `OptionsPattern` with inheritance from `solveCoeffsSystem`

**⚠️ GAP:** While `processModels` declares `OptionsPattern` with inheritance, at Line 246-247 it only explicitly forwards `"PdEquations"` to `solveCoeffsSystem`. `SimplifyOptions` is NOT forwarded, so downstream functions use their own defaults. See `options-issues.md` for details.

## Terminal Consumers

### `simplifyCoeffsSystem` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Lines 556-558 | Option declaration: `"SimplifyOptions" -> {TimeConstraint -> {5, 300}}` |
| Lines 563-566 | Extracts options into `simplifyOpts` |
| Line 587 | `FullSimplify[e, Sequence @@ simplifyOpts]` (for solA) |
| Line 596 | `FullSimplify[e, Sequence @@ simplifyOpts]` (for solB) |

**Option extraction pattern:**
```wolfram
simplifyOpts = Flatten[{
  Evaluate @ FilterRules[Flatten@{opts}, Options[Simplify]],
  Evaluate @ OptionValue["SimplifyOptions"]
}]
```

### `solveCoeffsSystem` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Lines 637-641 | Option declaration: `"SimplifyOptions" -> {TimeConstraint -> {5, 300}}` |
| Lines 646-649 | Extracts options into `simplifyOpts` |
| Line 728 | `Simplify[solA["Solution"], Sequence @@ simplifyOpts]` |
| Line 729 | `Simplify[solB["Solution"], Sequence @@ simplifyOpts]` |
| Line 759 | `FullSimplify[eqA0Unsimplified, Sequence @@ simplifyOpts]` |
| Line 784 | `FullSimplify[eqB0, Sequence @@ simplifyOpts]` |
| Line 796 | `FullSimplify[eqB0/.solA["Solution"], Sequence @@ simplifyOpts]` |
| Lines 733-734 | Forwards to `tryTransforms` |

**Option extraction pattern:**
```wolfram
simplifyOpts = Flatten[{
  Evaluate @ FilterRules[Flatten@{opts}, Options[Simplify]],
  Evaluate @ OptionValue["SimplifyOptions"]
}]
```

### `tryTransforms` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Lines 825-827 | Option declaration: `"SimplifyOptions" -> {TimeConstraint -> {5, 300}}` |
| Lines 847-850 | Extracts options into `simplifyOpts` |
| Lines 860-863 | `Simplify[expr /. tr, Sequence @@ simplifyOpts]` |

**Option extraction pattern:**
```wolfram
simplifyOpts = Flatten[{
  Evaluate @ FilterRules[Flatten@{opts}, Options[Simplify]],
  Evaluate @ OptionValue["SimplifyOptions"]
}]
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API, normalizes config |
| Entry | `buildModelsParallel` | ManageResources.wl | 1138-1275 | Parallel variant |
| Config | `defaultConfig` | OptionsConfig.wl | 77 | Default value |
| Config | `normalizeConfig` | OptionsConfig.wl | 167 | Legacy option mapping |
| Config | `splitConfig` | OptionsConfig.wl | 300-304 | Extracts Symbolic subsystem options |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 829, 970 | Extracts and forwards via splitConfig |
| Forwarder | `processModels` | ProcessModels.wl | 79, 246 | Forwards via OptionsPattern |
| **Consumer** | `simplifyCoeffsSystem` | ProcessModels.wl | 556-558, 563-566, 587, 596 | Passes to FullSimplify |
| **Consumer** | `solveCoeffsSystem` | ProcessModels.wl | 637-649, 728-796 | Passes to Simplify/FullSimplify |
| **Consumer** | `tryTransforms` | ProcessModels.wl | 825-863 | Passes to Simplify |

## Built-in Functions That Receive This Option

| Function | File | Lines |
|----------|------|-------|
| `Simplify` | ProcessModels.wl | 728, 729, 863 |
| `FullSimplify` | ProcessModels.wl | 587, 596, 759, 784, 796 |

## Propagation Paths

### Path A: Via Normalized Config (Recommended)
```
buildModels["SimplifyOptions" -> {TimeConstraint -> {10, 600}}]
  → normalizeConfig → config["Symbolic"]["SimplifyOptions"] = {...}
  → buildModelsInternal[config]
  → splitConfig[config, "Symbolic"] → "SimplifyOptions" -> {...}
  → processModels[..., "SimplifyOptions" -> {...}]
  → solveCoeffsSystem / simplifyCoeffsSystem / tryTransforms
  → Simplify[..., TimeConstraint -> {10, 600}]
```

### Path B: Via Legacy Flat Options
```
buildModels[SimplifyOptions -> {TimeConstraint -> {10, 600}}]
  → normalizeConfig maps to config["Symbolic"]["SimplifyOptions"]
  → [continues as Path A]
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Symbolic phase only |
| Impact | Controls timeout for Simplify/FullSimplify operations |
| Multiple consumers | Yes - 3 functions consume this option |
| Option merging | Combines with any direct Simplify options via FilterRules |
| Default TimeConstraint | `{5, 300}` (5 seconds per sub-expression, 300 total) |
````

</details>

<details>
<summary><code>options-forward/UpdateBond.md</code></summary>

````markdown
# UpdateBond Option

**Location in config:** `config["Numerical"]["UpdateBond"]`
**Default value:** `False`
**Legacy mapping:** `"UpdateBond" -> {"Numerical", "UpdateBond"}` in OptionsConfig.wl:187

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ updateCoeffs[model, kernels, "UpdateBond" -> True, ...]

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]  ◄── EXTRACTS "UpdateBond"
   │
   └─ "UpdateBond" -> config["Numerical"]["UpdateBond"]

NUMERICAL SOLVING PATH
│
└─ updateCoeffsSol[model, kernels, newParams, guessCoeffs, opts...]
   │
   ├─ If[OptionValue["UpdateBond"] || OptionValue["UpdateBonds"], ...]
   │
   └─ updateCoeffsBond[model["coeffsSolution"]["bond"], params, newParams,
                       maxMaturity, wcCoeffsList, recurrenceOpts]
      │  ◄── TERMINAL CONSUMER
      └─ RecurrenceTable[...] for real bond coefficients
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 131 | Default: `"UpdateBond" -> False` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Line 346 | Extracts: `"UpdateBond" -> config["Numerical"]["UpdateBond"]` |

## Terminal Consumer

### `updateCoeffsSol` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 333-349 | Option declarations |
| Line 338 | `"UpdateBond" -> False` |
| Line 638 | `If[OptionValue["UpdateBond"] \|\| OptionValue["UpdateBonds"], ...]` |
| Lines 639-640 | `solBond = updateCoeffsBond[...]` |

**Decision logic:**
```wolfram
If[OptionValue["UpdateBond"] || OptionValue["UpdateBonds"],
  solBond = updateCoeffsBond[model["coeffsSolution"]["bond"], params, newParams,
                             maxMaturity, wcCoeffsList, recurrenceOpts]
]
```

### `updateCoeffsBond` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 697-712 | Function definition |
| Line 707 | `(#[maxMaturity]& /@ modelCoeffsSolution)` |

Uses `RecurrenceTable` to solve bond recursion equations.

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 131 | Default False |
| Config | `splitConfig` | OptionsConfig.wl | 346 | Extraction |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Wrapper |
| **Consumer** | `updateCoeffsSol` | SolveEulerEq.wl | 638-640 | Decision point |
| Terminal | `updateCoeffsBond` | SolveEulerEq.wl | 697-712 | RecurrenceTable execution |

## Relationship with UpdateBonds

| Option | Scope | Effect |
|--------|-------|--------|
| `UpdateBond` | Real bonds only | Computes bond coefficients |
| `UpdateBonds` | Both types | Enables both UpdateBond and UpdateNomBond |

**OR logic:**
```wolfram
If[OptionValue["UpdateBond"] || OptionValue["UpdateBonds"], ...]
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - real bond coefficients |
| Default | `False` |
| Umbrella option | `UpdateBonds` enables this |
| Dependency | Requires WC coefficients (computed first) |
| Terminal operation | `RecurrenceTable` for term structure |
````

</details>

<details>
<summary><code>options-forward/UpdateBonds.md</code></summary>

````markdown
# UpdateBonds Option

**Location in config:** `config["Numerical"]["UpdateBonds"]`
**Default value:** `False`
**Legacy mapping:** `"UpdateBonds" -> {"Numerical", "UpdateBonds"}` in OptionsConfig.wl:189

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
├─ addCoeffsSolutionN[model]
│  └─ Hard-coded: "UpdateBonds" -> True
│
└─ toNumRules[model, ...]
   └─ Hard-coded: "UpdateBonds" -> True

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]  ◄── EXTRACTS "UpdateBonds"
   │
   └─ "UpdateBonds" -> config["Numerical"]["UpdateBonds"]

NUMERICAL SOLVING PATH
│
└─ updateCoeffsSol[model, kernels, newParams, guessCoeffs, opts...]
   │
   ├─ If[OptionValue["UpdateBond"] || OptionValue["UpdateBonds"], ...]
   │  └─ updateCoeffsBond[..., "bond", ...]  ◄── Real bonds
   │
   └─ If[OptionValue["UpdateNomBond"] || OptionValue["UpdateBonds"], ...]
      └─ updateCoeffsBond[..., "nombond", ...]  ◄── Nominal bonds
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 133 | Default: `"UpdateBonds" -> False` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Line 348 | Extracts: `"UpdateBonds" -> config["Numerical"]["UpdateBonds"]` |

## Terminal Consumer

### `updateCoeffsSol` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 333-349 | Option declarations |
| Line 340 | `"UpdateBonds" -> False` |
| Line 638 | `If[OptionValue["UpdateBond"] \|\| OptionValue["UpdateBonds"], ...]` |
| Line 642 | `If[OptionValue["UpdateNomBond"] \|\| OptionValue["UpdateBonds"], ...]` |

**Umbrella behavior:**
```wolfram
(* Real bonds *)
If[OptionValue["UpdateBond"] || OptionValue["UpdateBonds"],
  solBond = updateCoeffsBond[model["coeffsSolution"]["bond"], ...]
]

(* Nominal bonds *)
If[OptionValue["UpdateNomBond"] || OptionValue["UpdateBonds"],
  solNomBond = updateCoeffsBond[model["coeffsSolution"]["nombond"], ...]
]
```

## Hard-Coded Consumers

### `addCoeffsSolutionN` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 1036-1046 | Function definition |
| Line 1042 | Hard-coded: `"UpdateBonds" -> True` |

### `toNumRules` in `Kernel/Tools/ToNumber.wl`

| Location | What happens |
|----------|--------------|
| Lines 77-113 | Function definition |
| Line 95 | Hard-coded: `"UpdateBonds" -> True` |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 133 | Default False |
| Config | `splitConfig` | OptionsConfig.wl | 348 | Extraction |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Wrapper |
| **Consumer** | `updateCoeffsSol` | SolveEulerEq.wl | 638, 642 | Decision points |
| Hard-coded | `addCoeffsSolutionN` | SolveEulerEq.wl | 1042 | Always True |
| Hard-coded | `toNumRules` | ToNumber.wl | 95 | Always True |

## Relationship with Individual Options

| UpdateBonds | UpdateBond | UpdateNomBond | Real Bonds | Nominal Bonds |
|-------------|------------|---------------|------------|---------------|
| False | False | False | No | No |
| False | True | False | Yes | No |
| False | False | True | No | Yes |
| True | * | * | Yes | Yes |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - all bond coefficients |
| Default | `False` |
| Umbrella role | Enables both UpdateBond and UpdateNomBond |
| Hard-coded overrides | addCoeffsSolutionN and toNumRules always set True |
| Dependency | Requires WC coefficients (computed first) |
````

</details>

<details>
<summary><code>options-forward/UpdateManifest.md</code></summary>

````markdown
# UpdateManifest Option

**Location in config:** `config["Build"]["UpdateManifest"]`
**Default value:** `True`
**Legacy mapping:** `"UpdateManifest" -> {"Build", "UpdateManifest"}` in OptionsConfig.wl:182

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   ├─ Filters OUT UpdateManifest from user options (line 1189)
   ├─ Forces "UpdateManifest" -> False in parallel workers (line 1198)
   └─ Unconditionally calls updateModelManifest[] after merge (line 1239)

CONFIGURATION LAYER
│
└─ splitConfig[config, "Build"]  ◄── EXTRACTS "UpdateManifest"
   │
   └─ "UpdateManifest" -> config["Build"]["UpdateManifest"]

BUILD ORCHESTRATION
│
└─ buildModelsInternal[config_Association]
   │
   ├─ updateManifest = config["Build"]["UpdateManifest"]  (line 838)
   │
   └─ If[TrueQ[updateManifest] && fileSuffix === "",
        updateModelManifest[]
      ]  ◄── TERMINAL CONSUMER (line 1129)
         │
         └─ updateModelManifest[]  (lines 184-216)
            │
            ├─ getCatalogModels[]
            ├─ getCanonicalHash[catalogModels]
            ├─ getVersion[root]
            └─ Put[manifestData, manifestFile]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 152 | Default: `"UpdateManifest" -> True` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 368-377 | `splitConfig[config, "Build"]` definition |
| Line 376 | Extracts: `"UpdateManifest" -> config["Build"]["UpdateManifest"]` |

## Entry Points

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration: `"UpdateManifest" -> True` |
| Lines 821-826 | Entry patterns (config or legacy options) |

### `buildModelsParallel` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 1138-1143 | Does NOT declare UpdateManifest |
| Lines 1188-1189 | Filters OUT UpdateManifest from user options |
| Line 1198 | Forces `"UpdateManifest" -> False` for parallel workers |
| Line 1239 | Unconditionally calls `updateModelManifest[]` after merge |

**Filter pattern:**
```wolfram
filteredOpts = FilterRules[{opts},
  Except["FileSuffix" | "UpdateManifest" | "CreateMoments" | "FromScratch" | "Models"]]
```

## Terminal Consumer

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 838 | `updateManifest = config["Build"]["UpdateManifest"]` |
| Line 1129 | Conditional manifest update |

**Manifest update gate:**
```wolfram
If[TrueQ[updateManifest] && fileSuffix === "", updateModelManifest[]]
```

Two conditions must be met:
1. `updateManifest` is True (user setting)
2. `fileSuffix === ""` (canonical file, not checkpoint)

## Helper Function

### `updateModelManifest` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 184-216 | Manifest generation |

**Implementation:**
```wolfram
updateModelManifest[] := Module[
  {root, manifestFile, catalogModels, catalogHash, modelHashes, version, manifestData},

  root = findPacletRoot[];
  manifestFile = FileNameJoin[{root, "Resources", "ModelManifest.wl"}];
  catalogModels = getCatalogModels[];
  catalogHash = getCanonicalHash[catalogModels];
  modelHashes = Map[getCanonicalHash, catalogModels];
  version = getVersion[root];

  manifestData = <|
    "PacletVersion" -> version,
    "CatalogHash" -> catalogHash,
    "Models" -> modelHashes,
    "Date" -> DateString["ISODateTime"]
  |>;

  Put[manifestData, manifestFile];
  manifestData
]
```

**Output file:** `Resources/ModelManifest.wl`

## Parallel Build Strategy

| Phase | UpdateManifest Behavior |
|-------|-------------------------|
| Parallel workers | Forced to False (line 1198) |
| After merge | Unconditionally True (line 1239) |

```
buildModelsParallel
│
├─ Filter out user's UpdateManifest option
│
├─ For each model in parallel:
│  └─ buildModels[..., "UpdateManifest" -> False, ...]
│     └─ Does NOT call updateModelManifest[]
│
├─ Merge results
│
└─ updateModelManifest[]  ← ALWAYS CALLED (unconditional)
```

**Key insight:** In parallel builds, the option is ignored and manifest is ALWAYS updated once after all models merge.

## NOT Forwarded

UpdateManifest is NOT forwarded to any downstream functions:
- Not passed to `processModels` (Phase 1)
- Not passed to `createCompiledEq` (Phase 2)
- Not passed to `addCoeffsSolutionN` (Phase 3)
- Not passed to `createDatabase` (Phase 4)

**Rationale:** UpdateManifest is a build-orchestration control, not a computational parameter.

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 152 | Default True |
| Config | `splitConfig` | OptionsConfig.wl | 368-377 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 568-578, 821-826 | Public API |
| Entry | `buildModelsParallel` | ManageResources.wl | 1145, 1188-1189, 1198, 1239 | Parallel orchestrator |
| **Consumer** | `buildModelsInternal` | ManageResources.wl | 838, 1129 | **Conditional update** |
| Helper | `updateModelManifest` | ManageResources.wl | 184-216 | Manifest generation |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Build phase - manifest regeneration |
| Default | `True` |
| When True | Regenerates `ModelManifest.wl` after build |
| When False | Skips manifest update (partial builds) |
| Gate condition | Also requires `fileSuffix === ""` |
| Parallel behavior | Forced False in workers, unconditional after merge |
| NOT forwarded | Option only used at orchestration level |
| Consumer count | Single terminal consumer |
````

</details>

<details>
<summary><code>options-forward/UpdateNomBond.md</code></summary>

````markdown
# UpdateNomBond Option

**Location in config:** `config["Numerical"]["UpdateNomBond"]`
**Default value:** `False`
**Legacy mapping:** `"UpdateNomBond" -> {"Numerical", "UpdateNomBond"}` in OptionsConfig.wl:188

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ updateCoeffs[model, kernels, "UpdateNomBond" -> True, ...]

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]  ◄── EXTRACTS "UpdateNomBond"
   │
   └─ "UpdateNomBond" -> config["Numerical"]["UpdateNomBond"]

NUMERICAL SOLVING PATH
│
└─ updateCoeffsSol[model, kernels, newParams, guessCoeffs, opts...]
   │
   ├─ If[OptionValue["UpdateNomBond"] || OptionValue["UpdateBonds"], ...]
   │
   └─ updateCoeffsBond[model["coeffsSolution"]["nombond"], params, newParams,
                       maxMaturity, wcCoeffsList, recurrenceOpts]
      │  ◄── TERMINAL CONSUMER
      └─ RecurrenceTable[...] for nominal bond coefficients
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 132 | Default: `"UpdateNomBond" -> False` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Line 347 | Extracts: `"UpdateNomBond" -> config["Numerical"]["UpdateNomBond"]` |

## Terminal Consumer

### `updateCoeffsSol` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 333-349 | Option declarations |
| Line 339 | `"UpdateNomBond" -> False` |
| Line 642 | `If[OptionValue["UpdateNomBond"] \|\| OptionValue["UpdateBonds"], ...]` |
| Lines 643-644 | `solNomBond = updateCoeffsBond[...]` |

**Decision logic:**
```wolfram
If[OptionValue["UpdateNomBond"] || OptionValue["UpdateBonds"],
  solNomBond = updateCoeffsBond[model["coeffsSolution"]["nombond"], params, newParams,
                                maxMaturity, wcCoeffsList, recurrenceOpts]
]
```

### `updateCoeffsBond` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 697-712 | Function definition |
| Line 707 | `(#[maxMaturity]& /@ modelCoeffsSolution)` |

Uses `RecurrenceTable` to solve nominal bond recursion equations.

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 132 | Default False |
| Config | `splitConfig` | OptionsConfig.wl | 347 | Extraction |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Wrapper |
| **Consumer** | `updateCoeffsSol` | SolveEulerEq.wl | 642-644 | Decision point |
| Terminal | `updateCoeffsBond` | SolveEulerEq.wl | 697-712 | RecurrenceTable execution |

## Relationship with UpdateBonds

| Option | Scope | Effect |
|--------|-------|--------|
| `UpdateNomBond` | Nominal bonds only | Computes nominal bond coefficients |
| `UpdateBonds` | Both types | Enables both UpdateBond and UpdateNomBond |

**OR logic:**
```wolfram
If[OptionValue["UpdateNomBond"] || OptionValue["UpdateBonds"], ...]
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - nominal bond coefficients |
| Default | `False` |
| Umbrella option | `UpdateBonds` enables this |
| Dependency | Requires WC coefficients (computed first) |
| Output location | Stored in result["NomBond"] |
````

</details>

<details>
<summary><code>options-forward/UpdatePd.md</code></summary>

````markdown
# UpdatePd Option

**Location in config:** `config["Numerical"]["UpdatePd"]`
**Default value:** `False`
**Legacy mapping:** `"UpdatePd" -> {"Numerical", "UpdatePd"}` in OptionsConfig.wl:186

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
├─ addCoeffsSolutionN[model]
│  └─ Hard-coded: "UpdatePd" -> True
│
└─ toNumRules[model, ...]
   └─ Hard-coded: "UpdatePd" -> True

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]  ◄── EXTRACTS "UpdatePd"
   │
   └─ "UpdatePd" -> config["Numerical"]["UpdatePd"]

NUMERICAL SOLVING PATH
│
└─ updateCoeffsSol[model, kernels, newParams, guessCoeffs, opts...]
   │
   ├─ needsPd = stockFreeQ || TrueQ[OptionValue["UpdatePd"]]
   │
   └─ If[needsPd, computePdCoeffs[...]]  ◄── TERMINAL CONSUMER
      │
      └─ Populates result["Stocks"] with B-coefficient solutions
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 130 | Default: `"UpdatePd" -> False` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Line 345 | Extracts: `"UpdatePd" -> config["Numerical"]["UpdatePd"]` |

## Terminal Consumer

### `updateCoeffsSol` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 333-349 | Option declarations |
| Line 337 | `"UpdatePd" -> False` |
| Line 625 | `needsPd = stockFreeQ \|\| TrueQ[OptionValue["UpdatePd"]]` |
| Lines 631-634 | Conditional: `If[needsPd, solPd = computePdCoeffs[...]]` |

**Decision logic:**
```wolfram
needsPd = stockFreeQ || TrueQ[OptionValue["UpdatePd"]]
```

- `stockFreeQ = True`: No stock indices in new parameters → auto-compute Pd
- `TrueQ[OptionValue["UpdatePd"]] = True`: Explicit request → compute Pd
- Both False: Skip Pd computation

## Hard-Coded Consumers

### `addCoeffsSolutionN` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 1036-1046 | Function definition |
| Line 1041 | Hard-coded: `"UpdatePd" -> True` |

### `toNumRules` in `Kernel/Tools/ToNumber.wl`

| Location | What happens |
|----------|--------------|
| Lines 77-113 | Function definition |
| Line 95 | Hard-coded: `"UpdatePd" -> True` |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 130 | Default False |
| Config | `splitConfig` | OptionsConfig.wl | 345 | Extraction |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Wrapper |
| **Consumer** | `updateCoeffsSol` | SolveEulerEq.wl | 625, 631-634 | Uses needsPd logic |
| Hard-coded | `addCoeffsSolutionN` | SolveEulerEq.wl | 1041 | Always True |
| Hard-coded | `toNumRules` | ToNumber.wl | 95 | Always True |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - Pd coefficients |
| Default | `False` |
| Dual-path logic | Works with `stockFreeQ` condition |
| Impact | Controls whether result["Stocks"] is populated |
| Hard-coded overrides | addCoeffsSolutionN and toNumRules always set True |
````

</details>

<details>
<summary><code>options-forward/initialGuess.md</code></summary>

````markdown
# initialGuess Option

**Location in config:** `config["Numerical"]["initialGuess"]`
**Default value:** `<|"Ewc" -> {4}, "Epd" -> {{4}}|>`
**Legacy mapping:** `"initialGuess" -> {"Numerical", "initialGuess"}` in OptionsConfig.wl:183

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
├─ toNum[model, opts...]
│  └─ Direct usage via model["extraInfo"]["initialGuess"]
│
└─ updateCoeffs[model, kernels, opts...]
   └─ Direct option forwarding

ORCHESTRATION LAYER
│
└─ buildModelsInternal[config_Association]
   │
   └─ splitConfig[config, "Numerical"]  ◄── EXTRACTS "initialGuess"
      │
      └─ (options forwarded to numerical solving functions)

NUMERICAL SOLVING PATH
│
└─ updateCoeffs[model, kernels, newParams, opts...]
   │
   └─ updateCoeffsSol[model, kernels, newParams, opts...]
      │
      └─ getStartingValues[infoModel, opts...]  ◄── TERMINAL CONSUMER
         │
         ├─ Extracts "Ewc" and "Epd" initial guesses
         └─ Returns starting values for root finding
```

## Default Structure

```wolfram
"initialGuess" -> <|
  "Ewc" -> {4},       (* Initial guess for wealth-consumption ratio *)
  "Epd" -> {{4}}      (* Initial guess for price-dividend ratios *)
|>
```

## Entry Points (Public API)

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration in `Options[buildModels]` |
| Line 821 | Pattern: `buildModels[config_Association]` |

**How received:** Via config Association
**How forwarded:** Via `splitConfig[config, "Numerical"]`

### `toNum` in `Kernel/Tools/ToNumber.wl`

| Location | What happens |
|----------|--------------|
| Lines 64-98 | Function definition |
| Line 65 | Checks `model["extraInfo"]["initialGuess"]` |

**How received:** Via model's extraInfo or options
**How used:** Directly passed to `updateCoeffs`

### `updateCoeffs` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 765-796 | Function definition |
| Lines 765-771 | Inherits options from `updateCoeffsSol` |

**How received:** Via `OptionsPattern`
**How forwarded:** To `updateCoeffsSol`

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 105 | Default: `"initialGuess" -> <\|"Ewc" -> {4}, "Epd" -> {{4}}\|>` |

### `normalizeConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 183 | Legacy mapping: `"initialGuess" -> {"Numerical", "initialGuess"}` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Line 321 | Extracts: `"initialGuess" -> config["Numerical"]["initialGuess"]` |

## Intermediate Forwarders

### `updateCoeffsSol` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 333-349 | Option declarations |
| Lines 575-690 | Function implementation |
| Line 617 | FilterRules extracts options |

**How received:** Via `OptionsPattern[{updateCoeffsSol, solveCoeffRoots, checks, FindRoot, RecurrenceTable}]`
**How forwarded:** To `getStartingValues` and other solving functions

## Terminal Consumer

### `getStartingValues` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 1001-1029 | Function definition |
| Lines 1001-1003 | Option declaration: `"initialGuess" -> <\|"Ewc" -> {4}, "Epd" -> {{4}}\|>` |
| Line 1013 | Extraction: `OptionValue[getStartingValues, Flatten @ {opts}, {"initialGuess"}]` |
| Lines 1023-1024 | Fallback to `infoModel["initialGuess"]` |

**Usage:**
- Extracts "Ewc" initial guess for wealth-consumption ratio solving
- Extracts "Epd" initial guesses for price-dividend ratio solving
- Returns starting values for numerical root finding

## Model-Specific Overrides

### `Catalog.wl` - Model Extra Info

| Model | Location | initialGuess Value |
|-------|----------|-------------------|
| CEE | Lines 1816-1819 | `<\|"Ewc" -> {6.25}, "Epd" -> {{5.5}}\|>` |
| BKY | Lines 1847-1850 | `<\|"Ewc" -> {1, 15}, "Epd" -> {{4}}\|>` |
| NRC | Lines 1893-1896 | `<\|"Ewc" -> {4.6}, "Epd" -> {{4.7}, {6.2}, {5.5}}\|>` |
| NRCLLR | Lines 1938-1941 | `<\|"Ewc" -> {4.6}, "Epd" -> {{6}, {7}, {4.6}}\|>` |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Entry | `toNum` | ToNumber.wl | 64-98 | Direct API |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Direct API |
| Config | `defaultConfig` | OptionsConfig.wl | 105 | Default value |
| Config | `normalizeConfig` | OptionsConfig.wl | 183 | Legacy mapping |
| Config | `splitConfig` | OptionsConfig.wl | 320-350 | Extracts Numerical options |
| Data | `modelsExtraInfo` | Catalog.wl | Various | Model-specific overrides |
| Forwarder | `updateCoeffsSol` | SolveEulerEq.wl | 333-690 | Passes to getStartingValues |
| **Consumer** | `getStartingValues` | SolveEulerEq.wl | 1001-1029 | **Terminal consumer** |

## Propagation Paths

### Path A: Configuration-driven
```
buildModels[<|"Numerical" -> <|"initialGuess" -> <|"Ewc" -> {5}|>|>|>]
  → normalizeConfig → merges with defaults
  → splitConfig[config, "Numerical"] → "initialGuess" -> <|...|>
  → updateCoeffs → updateCoeffsSol → getStartingValues
  → Uses provided initial guess
```

### Path B: Model-specific override
```
toNum[model, ...]
  → model["extraInfo"]["initialGuess"] → <|"Ewc" -> {6.25}|>
  → updateCoeffs[..., "initialGuess" -> model["extraInfo"]["initialGuess"]]
  → getStartingValues uses model-specific values
```

### Path C: Default fallback
```
updateCoeffs[model, kernels, params]  (* no initialGuess specified *)
  → updateCoeffsSol → getStartingValues
  → Falls back to infoModel["initialGuess"]
  → Falls back to default <|"Ewc" -> {4}, "Epd" -> {{4}}|>
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase |
| Structure | Association with "Ewc" and "Epd" keys |
| "Ewc" | List of initial guesses for wealth-consumption ratio |
| "Epd" | List of lists for price-dividend ratios |
| Override priority | User options > Model extraInfo > Default config |
| Model customization | 4 models have custom initialGuess values |
| Terminal consumer | `getStartingValues` |
````

</details>

<details>
<summary><code>options-forward/maxMomentsLagsToCreate.md</code></summary>

````markdown
# maxMomentsLagsToCreate Option

**Location in config:** `config["Moments"]["maxMomentsLagsToCreate"]`
**Default value:** `8`
**Legacy mapping:** `"maxMomentsLagsToCreate" -> {"Moments", "maxMomentsLagsToCreate"}` in OptionsConfig.wl:174

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ buildModels[...] (delegates)

CONFIGURATION LAYER
│
└─ splitConfig[config, "Moments"]  ◄── EXTRACTS "maxMomentsLagsToCreate"
   │
   └─ "maxMomentsLagsToCreate" -> config["Moments"]["maxMomentsLagsToCreate"]

MOMENTS CREATION PATH
│
└─ buildModelsInternal[config_Association]
   │
   └─ Phase 4: Moments (if createMoments = True)
      │
      └─ createDatabase[model, momentsFile, splitConfig[config, "Moments"]]
         │  ◄── TERMINAL CONSUMER
         │
         ├─ maxLag = OptionValue["maxMomentsLagsToCreate"]
         │
         └─ Table[uncondCov[...], {T, -maxLag - 1, -seqStart}]
            Table[uncondCov[...], {T, seqStart, maxLag + 1}]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 137 | Default: `"maxMomentsLagsToCreate" -> 8` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 354-359 | `splitConfig[config, "Moments"]` definition |
| Line 355 | Extracts: `"maxMomentsLagsToCreate" -> config["Moments"]["maxMomentsLagsToCreate"]` |

## Intermediate Forwarder

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 1097-1101 | Calls `createDatabase` with `splitConfig[config, "Moments"]` |

## Terminal Consumer

### `createDatabase` in `Kernel/ComputationalEngine/CreateMomentsDatabase.wl`

| Location | What happens |
|----------|--------------|
| Lines 314-318 | Option declarations |
| Line 315 | `"maxMomentsLagsToCreate" -> 8` |
| Line 328 | `maxLag = OptionValue["maxMomentsLagsToCreate"]` |
| Lines 354-355 | Table iterations for lags |

**Usage in Table iterations:**
```wolfram
(* Negative lags *)
tempNeg = Table[{T, uncondCov[v1[t], v2[t + T], model]}, {T, -maxLag - 1, -seqStart}]

(* Positive lags *)
tempPos = Table[{T, uncondCov[v1[t], v2[t + T], model]}, {T, seqStart, maxLag + 1}]
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 137 | Default 8 |
| Config | `splitConfig` | OptionsConfig.wl | 354-359 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Forwarder | `buildModelsInternal` | ManageResources.wl | 1097-1101 | Forwards to createDatabase |
| **Consumer** | `createDatabase` | CreateMomentsDatabase.wl | 314-619 | **Terminal consumer** |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Moments phase - covariance database |
| Default | 8 |
| Impact | Controls temporal extent of moments database |
| Lag range | `-maxLag - 1` to `maxLag + 1` |
| Related option | `startSequenceAtLag` (sequence function start) |
| Consumer count | Single terminal consumer |
````

</details>

<details>
<summary><code>options-forward/paramQuadSolveOptions.md</code></summary>

````markdown
# paramQuadSolveOptions Option

**Location in config:** `config["Symbolic"]["paramQuadSolveOptions"]`
**Default value:** Nested Association with 13 keys (see below)
**Legacy mapping:** None (nested options passed as Association)

## Default Structure

```wolfram
"paramQuadSolveOptions" -> <|
  "DomainOption" -> Reals,
  "Assumptions" -> Automatic,
  "Method" -> Automatic,
  "MonomialOrder" -> Automatic,
  "ValidationOption" -> True,
  "ReturnOption" -> "All",
  "TimeoutOption" -> 600,
  "SimplifyTimeout" -> Automatic,
  "DiagnosticsOption" -> False,
  "OnlyQuadTerms" -> False,
  "SignSymbol" -> Symbol["signA"],
  "GroebnerMemoryFraction" -> 0.5,
  "GroebnerMemoryFloor" -> 1*1024^3,
  "GroebnerMemoryCap" -> 16*1024^3
|>
```

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ buildModels[...] (delegates)

ORCHESTRATION LAYER
│
└─ buildModelsInternal[config_Association]
   │
   └─ splitConfig[config, "Symbolic"]  ◄── EXTRACTS "paramQuadSolveOptions"
      │
      └─ processModels[modelsCatalog, splitConfig_result...]
         │
         └─ solveCoeffsSystem[model, opts...]
            │
            ├─ Extracts: paramQuadSolveOpts = OptionValue["paramQuadSolveOptions"]
            │
            ├─ paramQuadSolve[wcEqns, wcVars, Sequence @@ paramQuadSolveOpts]
            │  └─ Solves wc coefficient system  ◄── TERMINAL CONSUMER
            │
            └─ paramQuadSolve[pdEqns, pdVars, Sequence @@ paramQuadSolveOpts]
               └─ Solves pd coefficient system  ◄── TERMINAL CONSUMER
```

## Entry Points (Public API)

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration in `Options[buildModels]` |
| Line 821 | Pattern: `buildModels[config_Association]` |
| Line 825 | Pattern: `buildModels[opts___?OptionQ]` |
| Lines 822, 826 | Normalizes via `normalizeConfig[]` |

**How received:** Via `OptionsPattern` or config Association
**How forwarded:** Config passed to `buildModelsInternal`

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 78-93 | Default nested Association with 13 keys |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 300-304 | `splitConfig[config, "Symbolic"]` definition |
| Line 303 | Extracts: `"paramQuadSolveOptions" -> config["Symbolic"]["paramQuadSolveOptions"]` |

### `ambiguousOptions` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 200-203 | Maps SignSymbol to correct context (Symbolic vs Compile) |

## Intermediate Forwarders

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 829 | Receives normalized config as parameter |
| Lines 968-970 | Calls `processModels` with `splitConfig[config, "Symbolic"]` |

**How received:** Normalized config Association
**How forwarded:** Via `splitConfig[config, "Symbolic"]`

### `processModels` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Lines 77-79 | `OptionsPattern[{solveCoeffsSystem, ...}]` - inherits options |
| Lines 244-250 | Calls `solveCoeffsSystem` |

**How received:** Via `OptionsPattern` with inheritance from `solveCoeffsSystem`

**⚠️ GAP:** While `processModels` declares `OptionsPattern` with inheritance, at Lines 246-247 it only explicitly forwards `"PdEquations"` to `solveCoeffsSystem`. `paramQuadSolveOptions` is NOT forwarded, so `solveCoeffsSystem` uses its default `{}`, ignoring all 14 configured sub-options. See `options-issues.md` for details.

### `solveCoeffsSystem` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Lines 637-641 | Option declaration: `"paramQuadSolveOptions" -> {}` |
| Line 650 | Extracts: `paramQuadSolveOpts = OptionValue["paramQuadSolveOptions"]` |
| Lines 684-691 | First call to `paramQuadSolve` (wc system) |
| Lines 694-701 | Second call to `paramQuadSolve` (pd system) |

**Forwarding mechanism:**
```wolfram
paramQuadSolve[eqns, vars, Sequence @@ paramQuadSolveOpts]
```

## Terminal Consumer

### `paramQuadSolve` in `Kernel/ComputationalEngine/ParamQuadSolve.wl`

| Location | What happens |
|----------|--------------|
| Lines 70-85 | Option declarations for all 13 sub-options |
| Lines 104-347 | Implementation uses all options via `OptionValue[]` |

**Option declarations:**
```wolfram
paramQuadSolve // Options = {
  "DomainOption" -> Reals,
  "Assumptions" -> Automatic,
  "Method" -> Automatic,
  "MonomialOrder" -> Automatic,
  "ValidationOption" -> True,
  "ReturnOption" -> "All",
  "TimeoutOption" -> 600,
  "SimplifyTimeout" -> Automatic,
  "DiagnosticsOption" -> False,
  "OnlyQuadTerms" -> False,
  "SignSymbol" -> signA,  (* Symbol form *)
  "GroebnerMemoryFraction" -> 0.5,
  "GroebnerMemoryFloor" -> 1*1024^3,
  "GroebnerMemoryCap" -> 16*1024^3
}
```

**Key option extractions (lines 104-121):**
```wolfram
domain = OptionValue["DomainOption"],
assumptions = OptionValue["Assumptions"],
method = OptionValue["Method"],
monomialOrder = OptionValue["MonomialOrder"],
validate = OptionValue["ValidationOption"],
returnOpt = OptionValue["ReturnOption"],
timeout = OptionValue["TimeoutOption"],
simplifyTimeout = OptionValue["SimplifyTimeout"],
diagnostics = OptionValue["DiagnosticsOption"],
onlyQuad = OptionValue["OnlyQuadTerms"],
signHead = OptionValue["SignSymbol"],
memFraction = OptionValue["GroebnerMemoryFraction"],
memFloor = OptionValue["GroebnerMemoryFloor"],
memCap = OptionValue["GroebnerMemoryCap"]
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API, normalizes config |
| Entry | `buildModelsParallel` | ManageResources.wl | 1138-1275 | Parallel variant |
| Config | `defaultConfig` | OptionsConfig.wl | 78-93 | Default nested Association |
| Config | `splitConfig` | OptionsConfig.wl | 300-304 | Extracts Symbolic subsystem options |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 829, 968-970 | Extracts and forwards via splitConfig |
| Forwarder | `processModels` | ProcessModels.wl | 77-79, 244-250 | Forwards via OptionsPattern |
| Forwarder | `solveCoeffsSystem` | ProcessModels.wl | 637-650, 684-701 | Extracts and forwards via Sequence @@ |
| **Consumer** | `paramQuadSolve` | ParamQuadSolve.wl | 70-85, 104-347 | **Terminal consumer** |

## Propagation Paths

### Path A: Via Normalized Config (Recommended)
```
buildModels[<|"Symbolic" -> <|"paramQuadSolveOptions" -> <|"TimeoutOption" -> 1200|>|>|>]
  → normalizeConfig → merges with defaults
  → buildModelsInternal[config]
  → splitConfig[config, "Symbolic"] → "paramQuadSolveOptions" -> <|...|>
  → processModels[..., "paramQuadSolveOptions" -> <|...|>]
  → solveCoeffsSystem extracts via OptionValue
  → paramQuadSolve[eqns, vars, Sequence @@ paramQuadSolveOpts]
  → Each sub-option extracted via OptionValue
```

## Sub-Option Descriptions

| Option | Default | Purpose |
|--------|---------|---------|
| DomainOption | Reals | Domain for Solve (Reals, Complexes) |
| Assumptions | Automatic | Assumptions passed to Solve |
| Method | Automatic | Solve method |
| MonomialOrder | Automatic | Groebner basis monomial ordering |
| ValidationOption | True | Whether to validate solutions |
| ReturnOption | "All" | What to return ("All", "First", etc.) |
| TimeoutOption | 600 | Timeout in seconds |
| SimplifyTimeout | Automatic | Timeout for simplification |
| DiagnosticsOption | False | Enable diagnostic output |
| OnlyQuadTerms | False | Only process quadratic terms |
| SignSymbol | Symbol["signA"] | Symbol for sign variables |
| GroebnerMemoryFraction | 0.5 | Memory fraction for Groebner |
| GroebnerMemoryFloor | 1 GB | Minimum memory for Groebner |
| GroebnerMemoryCap | 16 GB | Maximum memory for Groebner |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Symbolic phase only |
| Impact | Controls polynomial solving algorithm behavior |
| Nested structure | Yes - Association with 13 keys |
| Two invocations | Called twice: once for wc, once for pd coefficients |
| No transformation | Passed unchanged from config to consumer |
| SignSymbol context | Uses Symbol form (not String like Compile subsystem) |
````

</details>

<details>
<summary><code>options-forward/simplifyDownValues.md</code></summary>

````markdown
# simplifyDownValues Option

**Location in config:** `config["Moments"]["simplifyDownValues"]`
**Default value:** `False`
**Legacy mapping:** `"simplifyDownValues" -> {"Moments", "simplifyDownValues"}` in OptionsConfig.wl:176

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ buildModels[...] (delegates)

CONFIGURATION LAYER
│
└─ splitConfig[config, "Moments"]  ◄── EXTRACTS "simplifyDownValues"
   │
   └─ "simplifyDownValues" -> config["Moments"]["simplifyDownValues"]

MOMENTS CREATION PATH
│
└─ buildModelsInternal[config_Association]
   │
   └─ Phase 4: Moments (if createMoments = True)
      │
      └─ createDatabase[model, momentsFile, splitConfig[config, "Moments"]]
         │  ◄── TERMINAL CONSUMER
         │
         └─ If[OptionValue["simplifyDownValues"],
              (* Simplify all DownValues of covLong *)
              ParallelMap[Simplify[#, model["modelAssumptions"]]&, ...]
            ]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 139 | Default: `"simplifyDownValues" -> False` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 354-359 | `splitConfig[config, "Moments"]` definition |
| Line 357 | Extracts: `"simplifyDownValues" -> config["Moments"]["simplifyDownValues"]` |

## Terminal Consumer

### `createDatabase` in `Kernel/ComputationalEngine/CreateMomentsDatabase.wl`

| Location | What happens |
|----------|--------------|
| Lines 314-318 | Option declarations |
| Line 317 | `"simplifyDownValues" -> False` |
| Lines 591-614 | Conditional simplification logic |

**Implementation:**
```wolfram
If[OptionValue["simplifyDownValues"],
  With[{dv = DownValues[Evaluate@covLong]},
    With[{vals = Values@dv, keys = Keys@dv},
      With[{dvValuesSimplify = ParallelMap[
          Simplify[#, model["modelAssumptions"]]&,
          vals,
          DistributedContexts -> All
        ]},
        DownValues[Evaluate@covLong] = Thread[keys -> dvValuesSimplify]
      ]
    ]
  ]
]
```

## Behavior

| simplifyDownValues | Effect |
|--------------------|--------|
| False (default) | DownValues cached as-is (faster creation) |
| True | DownValues simplified with model assumptions (slower, more compact) |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 139 | Default False |
| Config | `splitConfig` | OptionsConfig.wl | 354-359 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Forwarder | `buildModelsInternal` | ManageResources.wl | 1097-1101 | Forwards to createDatabase |
| **Consumer** | `createDatabase` | CreateMomentsDatabase.wl | 591-614 | **Terminal consumer** |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Moments phase - DownValues simplification |
| Default | False |
| When True | ParallelMap[Simplify[...]] on all DownValues |
| Performance | True = slower creation, potentially smaller storage |
| Parallel execution | Uses ParallelMap with DistributedContexts -> All |
| Consumer count | Single terminal consumer |
````

</details>

<details>
<summary><code>options-forward/startSequenceAtLag.md</code></summary>

````markdown
# startSequenceAtLag Option

**Location in config:** `config["Moments"]["startSequenceAtLag"]`
**Default value:** `3`
**Legacy mapping:** `"startSequenceAtLag" -> {"Moments", "startSequenceAtLag"}` in OptionsConfig.wl:175

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ buildModels[...] (delegates)

CONFIGURATION LAYER
│
└─ splitConfig[config, "Moments"]  ◄── EXTRACTS "startSequenceAtLag"
   │
   └─ "startSequenceAtLag" -> config["Moments"]["startSequenceAtLag"]

MOMENTS CREATION PATH
│
└─ buildModelsInternal[config_Association]
   │
   └─ Phase 4: Moments (if createMoments = True)
      │
      └─ createDatabase[model, momentsFile, splitConfig[config, "Moments"]]
         │  ◄── TERMINAL CONSUMER
         │
         ├─ seqStart = OptionValue["startSequenceAtLag"]
         │
         ├─ Table[..., {T, -maxLag - 1, -seqStart}]  (negative lags)
         ├─ Table[..., {T, seqStart, maxLag + 1}]    (positive lags)
         ├─ Do[..., {qInd, seqStart - 1}]           (direct computation)
         └─ Pattern: q /; q >= seqStart             (interpolation boundary)
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 138 | Default: `"startSequenceAtLag" -> 3` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 354-359 | `splitConfig[config, "Moments"]` definition |
| Line 356 | Extracts: `"startSequenceAtLag" -> config["Moments"]["startSequenceAtLag"]` |

## Terminal Consumer

### `createDatabase` in `Kernel/ComputationalEngine/CreateMomentsDatabase.wl`

| Location | What happens |
|----------|--------------|
| Lines 314-318 | Option declarations |
| Line 316 | `"startSequenceAtLag" -> 3` |
| Line 330 | `seqStart = OptionValue["startSequenceAtLag"]` |
| Lines 354-367 | Table ranges and Do loops |

**Usage pattern:**
```wolfram
(* Negative lags - interpolation zone *)
tempNeg = Table[{T, uncondCov[v1[t], v2[t + T], model]}, {T, -maxLag - 1, -seqStart}]

(* Positive lags - interpolation zone *)
tempPos = Table[{T, uncondCov[v1[t], v2[t + T], model]}, {T, seqStart, maxLag + 1}]

(* Direct computation zone: 1 to seqStart - 1 *)
Do[
  covLong[v1, v2, -qInd] = uncondCov[v1[t], v2[t - qInd], model];
  covLong[v1, v2, qInd] = uncondCov[v1[t], v2[t + qInd], model],
  {qInd, seqStart - 1}
]

(* Pattern for interpolation *)
covLong[v1, v2, q_ /; q >= seqStart] = seqfun[tempPos, q, v1, v2]
```

## Computational Impact

| Zone | Lag Range | Computation Method |
|------|-----------|-------------------|
| Direct | `[-(seqStart-1), ..., -1, 0, 1, ..., seqStart-1]` | Direct uncondCov |
| Interpolation (neg) | `[-maxLag-1, ..., -seqStart]` | Sequence function |
| Interpolation (pos) | `[seqStart, ..., maxLag+1]` | Sequence function |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 138 | Default 3 |
| Config | `splitConfig` | OptionsConfig.wl | 354-359 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Forwarder | `buildModelsInternal` | ManageResources.wl | 1097-1101 | Forwards to createDatabase |
| **Consumer** | `createDatabase` | CreateMomentsDatabase.wl | 314-619 | **Terminal consumer** |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Moments phase - covariance database |
| Default | 3 |
| Purpose | Boundary between direct computation and interpolation |
| Trade-off | Smaller = more interpolation error; Larger = more computation |
| Related option | `maxMomentsLagsToCreate` (maximum lag) |
| Consumer count | Single terminal consumer |
````

</details>

---

## options-backward (per-file option inventories / dependencies)

<details>
<summary><code>options-backward/engine-conditional-quadsolve.md</code></summary>

````markdown
# Options Flow: ComputeConditionalExpectations.wl and ParamQuadSolve.wl

This document traces how options flow through functions in the ComputationalEngine files `ComputeConditionalExpectations.wl` and `ParamQuadSolve.wl`.

---

## File: ComputeConditionalExpectations.wl

**Location**: `/Kernel/ComputationalEngine/ComputeConditionalExpectations.wl`

### Public Functions

The public functions `ev`, `var`, `cov`, and `corr` do **not** accept options. They are defined with fixed signatures:

- `ev[expr_, conditionalTime_, model_]`
- `var[expr_, conditionalTime_, model_]`
- `cov[expr1_, expr2_, conditionalTime_, model_]`
- `corr[expr1_, expr2_, conditionalTime_, model_]`

These functions internally call `lagStateVarst` without passing any options, so the helper function uses its default option values.

---

### Function: `lagStateVarst` (Private)

**Signature**: `lagStateVarst[expr_, conditionalTime_, model_, OptionsPattern[]]`

**Options accepted**:
| Option | Default | Description |
|--------|---------|-------------|
| `"MaxIterations"` | `100` | Maximum iterations for `FixedPointList` convergence |
| `"TimeConstraint"` | `30` | Timeout in seconds for `TimeConstrained` |

**Options flow**:

```
lagStateVarst[..., opts]
    |
    +-- "MaxIterations" -> used directly in FixedPointList[..., maxIter]
    |                      (TERMINAL: controls iteration limit)
    |
    +-- "TimeConstraint" -> used directly in TimeConstrained[..., timeLimit]
                           (TERMINAL: controls timeout)
```

**Details**:
- `"MaxIterations"` is retrieved via `OptionValue["MaxIterations"]` and passed to `FixedPointList` as its iteration limit
- `"TimeConstraint"` is retrieved via `OptionValue["TimeConstraint"]` and passed to `TimeConstrained` as the timeout

**Callers**:
- `ev` (same file) - calls without options, uses defaults
- `ComputeUnconditionalExpectations.wl` - calls via `cond\`Private\`lagStateVarst` without options

**Note**: The public functions `ev`, `var`, `cov`, `corr` do not expose these options to users. To use non-default values, one would need to call `lagStateVarst` directly from Private context.

---

## File: ParamQuadSolve.wl

**Location**: `/Kernel/ComputationalEngine/ParamQuadSolve.wl`

### Function: `paramQuadSolve` (Public)

**Signature**: `paramQuadSolve[eqns_List, vars_List, opts : OptionsPattern[{paramQuadSolve}]]`

**Options accepted**:
| Option | Default | Description |
|--------|---------|-------------|
| `"DomainOption"` | `Reals` | Domain for solutions |
| `"Assumptions"` | `Automatic` | User assumptions (combined with defaults) |
| `"Method"` | `Automatic` | Solver method: `Automatic`, `"Sequential"`, or `"SequentialWithGroebner"` |
| `"MonomialOrder"` | `Automatic` | Monomial order for GroebnerBasis |
| `"ValidationOption"` | `True` | Whether to validate solutions |
| `"ReturnOption"` | `"All"` | Which keys to return in result |
| `"TimeoutOption"` | `600` | Overall timeout in seconds |
| `"SimplifyTimeout"` | `Automatic` | Timeout for individual Simplify calls |
| `"DiagnosticsOption"` | `False` | Whether to include diagnostics |
| `"OnlyQuadTerms"` | `False` | Whether to only solve quadratic variables |
| `"SignSymbol"` | `signA` | Symbol head for sign parameters |
| `"GroebnerMemoryFraction"` | `0.5` | Fraction of available memory for Groebner |
| `"GroebnerMemoryFloor"` | `1*1024^3` | Minimum memory limit (1 GB) |
| `"GroebnerMemoryCap"` | `16*1024^3` | Maximum memory limit (16 GB) |

**Options flow**:

```
paramQuadSolve[eqns, vars, opts]
    |
    +-- "DomainOption" -> used directly to determine radicandConditions
    |                     (TERMINAL: controls whether >= 0 conditions are generated)
    |
    +-- "Assumptions" -> buildAssumptions[] -> combined with defaultAssumptions[]
    |       |
    |       +-> passed to Simplify[..., Assumptions -> ass] for coeffMap
    |       +-> passed to sequentialSolve as `ass` parameter
    |       |       |
    |       |       +-> passed to solveLinearFor, quadraticSolveParam, quarticSolveParam
    |       |               |
    |       |               +-> used in PossibleZeroQ[..., Assumptions -> ass]
    |       |               +-> used in Simplify[..., Assumptions -> ass]
    |       |                   (TERMINAL: controls simplification assumptions)
    |       |
    |       +-> expandPatternAssumptions[eqns, ass && signAssumptions] -> fullAss
    |               |
    |               +-> passed to simplifySignMap
    |               +-> passed to simplifyWithDummySubstitution
    |               +-> used in verification (PossibleZeroQ, Simplify)
    |
    +-- "Method" -> determines methodTag and allowGroebner
    |               |
    |               +-> allowGroebner passed to sequentialSolve
    |                   (TERMINAL: controls whether GroebnerBasis is attempted)
    |
    +-- "MonomialOrder" -> gbOrderUsed (defaults to Lexicographic)
    |                       |
    |                       +-> passed to sequentialSolve -> GroebnerBasis
    |                           (TERMINAL: MonomialOrder option of GroebnerBasis)
    |
    +-- "ValidationOption" -> controls whether verification block runs
    |                          (TERMINAL: boolean flag)
    |
    +-- "ReturnOption" -> controls which keys are in final output
    |                      (TERMINAL: filters result Association)
    |
    +-- "TimeoutOption" -> timeout
    |       |
    |       +-> TimeConstrained[sequentialSolve[...], N@timeout]
    |       +-> TimeConstrained[FixedPoint[...], N@timeout]
    |       +-> TimeConstrained[verification[...], N@timeout]
    |       +-> derives simpBudget if "SimplifyTimeout" is Automatic
    |           (TERMINAL: controls overall time limits)
    |
    +-- "SimplifyTimeout" -> simpBudget (derived if Automatic)
    |       |
    |       +-> passed to sequentialSolve as simplifyTC parameter
    |       |       |
    |       |       +-> passed to solveLinearFor, quadraticSolveParam, quarticSolveParam
    |       |               |
    |       |               +-> Simplify[..., TimeConstraint -> simplifyTC]
    |       |                   (TERMINAL: TimeConstraint for Simplify)
    |       |
    |       +-> Simplify[coeffMap, TimeConstraint -> simpBudget]
    |       +-> simplifyWithDummySubstitution[..., TimeConstraint -> simpBudget]
    |       +-> Simplify[radicandConditions, TimeConstraint -> simpBudget]
    |       +-> verification Simplify calls
    |
    +-- "DiagnosticsOption" -> diagnosticsQ
    |                           (TERMINAL: currently unused in main flow)
    |
    +-- "OnlyQuadTerms" -> onlyQuadQ
    |                       |
    |                       +-> selectQuadraticSubset[...] if True
    |                           (TERMINAL: controls equation selection)
    |
    +-- "SignSymbol" -> signHead
    |                    |
    |                    +-> passed to sequentialSolve -> makeSignGenerator[signHead]
    |                        (TERMINAL: determines symbol head for sign variables)
    |
    +-- "GroebnerMemoryFraction" -> gbMemFraction
    |       |
    |       +-> Clip[Round[gbMemFraction * MemoryAvailable[]], ...] -> gbMemLimit
    |           |
    |           +-> passed to sequentialSolve -> MemoryConstrained[GroebnerBasis[...], gbMemLimit]
    |               (TERMINAL: memory limit for GroebnerBasis)
    |
    +-- "GroebnerMemoryFloor" -> gbMemFloor
    |                            |
    |                            +-> used in Clip to set minimum memory limit
    |
    +-- "GroebnerMemoryCap" -> gbMemCap
                               |
                               +-> used in Clip to set maximum memory limit
```

**Called from**:
- `ProcessModels.wl` - `solveCoeffsSystem` calls `paramQuadSolve` with options via `"paramQuadSolveOptions"`

---

### Function: `simplifyWithDummySubstitution` (Public)

**Signature**: `simplifyWithDummySubstitution[expr_, opts:OptionsPattern[{simplifyWithDummySubstitution, Simplify}]]`

**Options accepted**:

Custom options:
| Option | Default | Description |
|--------|---------|-------------|
| `"Assumptions"` | `Automatic` | User assumptions (`Automatic` -> `defaultAssumptions[]`, `True` -> `$Assumptions`) |
| `"Level0Pattern"` | `_Symbol[0] \| _Symbol[_][0]` | Pattern for level-0 symbols to transform |
| `"SimplifyFunction"` | `Simplify` | Function to use (`Simplify` or `FullSimplify`) |

Also accepts all `Simplify` options (passed through via `FilterRules`).

**Options flow**:

```
simplifyWithDummySubstitution[expr, opts]
    |
    +-- "Assumptions" -> ass (after Replace: Automatic -> defaultAssumptions[], True -> $Assumptions)
    |       |
    |       +-> combined with dummyPositiveAss -> augmentedAss
    |           |
    |           +-> Assuming[augmentedAss, simplifyFn[...]]
    |               (TERMINAL: assumptions context for simplification)
    |
    +-- "Level0Pattern" -> level0Pattern
    |                       |
    |                       +-> Cases[expr, level0Pattern, Infinity]
    |                           (TERMINAL: pattern matching for exp transforms)
    |
    +-- "SimplifyFunction" -> simplifyFn
    |                          |
    |                          +-> simplifyFn[expr /. allTransformRules, ...]
    |                              (TERMINAL: determines Simplify vs FullSimplify)
    |
    +-- Simplify options (via FilterRules) -> simplifyOpts
                                               |
                                               +-> simplifyFn[..., Sequence @@ simplifyOpts]
                                                   (TERMINAL: passed to Simplify/FullSimplify)
```

**Called from**:
- `paramQuadSolve` (same file) - with `"Assumptions" -> fullAss`, `TimeConstraint -> simpBudget`
- `ProcessModels.wl` - `solveCoeffsSystem` calls with `"Assumptions" -> True`, `"SimplifyFunction" -> FullSimplify`

---

### Function: `expandPatternAssumptions` (Public)

**Signature**: `expandPatternAssumptions[expr_, ass_]`

**Options accepted**: None (not an options-based function)

This function takes two positional arguments and expands pattern-based assumptions by finding matching instances in the expression.

**Called from**:
- `paramQuadSolve` (same file)
- `ProcessModels.wl` - `solveCoeffsSystem`

---

### Private Helper Functions

The following private helper functions use options indirectly through parameters:

#### `sequentialSolve`
**Signature**: `sequentialSolve[polys_List, vars_List, ass_, signHead_, gbOrder_, allowGroebner_, gbMemLimit_, simplifyTC_: 5]`

Receives option values as positional parameters from `paramQuadSolve`:
- `ass` <- from `"Assumptions"`
- `signHead` <- from `"SignSymbol"`
- `gbOrder` <- from `"MonomialOrder"`
- `allowGroebner` <- from `"Method"`
- `gbMemLimit` <- from `"GroebnerMemory*"` options
- `simplifyTC` <- from `"SimplifyTimeout"`

#### `solveLinearFor`
**Signature**: `solveLinearFor[poly_, v_, ass_, simplifyTC_: 5]`

Uses `ass` for `Simplify[..., Assumptions -> ass, TimeConstraint -> simplifyTC]`

#### `quadraticSolveParam`
**Signature**: `quadraticSolveParam[poly_, v_, signGen_, ass_, simplifyTC_: 5]`

Uses `ass` and `simplifyTC` for multiple `Simplify` calls

#### `quarticSolveParam`
**Signature**: `quarticSolveParam[poly_, v_, signGen_, ass_, simplifyTC_: 5]`

Uses `ass` and `simplifyTC` for multiple `Simplify` calls

#### `simplifySquareRoot`
**Signature**: `simplifySquareRoot[radicand_, ass : Except[_List] : Automatic, tc_: 5]`

Uses `ass` (defaults to `defaultAssumptions[]`) and `tc` for `FullSimplify`

#### `simplifySignMap`
**Signature**: `simplifySignMap[signMap_Association, radMap_Association, ass : Except[_List] : Automatic]`

Calls `simplifySquareRoot` with `ass`

#### `buildAssumptions`
**Signature**: `buildAssumptions[userAss_]`

Combines user assumptions with `defaultAssumptions[]`

#### `defaultAssumptions`
**Signature**: `defaultAssumptions[]`

No options - returns combined assumptions from `EndogenousEq` and `Parameters` packages

---

## Summary: Option Dependency Graph

```
paramQuadSolve
    |
    +-- "Assumptions" -----> buildAssumptions -> sequentialSolve -> {solveLinearFor, quadraticSolveParam, quarticSolveParam}
    |                   \--> expandPatternAssumptions -> simplifySignMap, simplifyWithDummySubstitution, verification
    |
    +-- "SimplifyTimeout" -> simpBudget -> sequentialSolve -> {solveLinearFor, quadraticSolveParam, quarticSolveParam}
    |                              \----> simplifyWithDummySubstitution, verification Simplify calls
    |
    +-- "Method" ----------> allowGroebner -> sequentialSolve -> GroebnerBasis (conditional)
    |
    +-- "MonomialOrder" ---> gbOrderUsed -> sequentialSolve -> GroebnerBasis
    |
    +-- "SignSymbol" ------> signHead -> sequentialSolve -> makeSignGenerator
    |
    +-- "GroebnerMemory*" -> gbMemLimit -> sequentialSolve -> MemoryConstrained[GroebnerBasis]
    |
    +-- "DomainOption" ----> (TERMINAL: radicand conditions)
    +-- "ValidationOption" -> (TERMINAL: verification toggle)
    +-- "ReturnOption" -----> (TERMINAL: output filtering)
    +-- "TimeoutOption" ----> (TERMINAL: TimeConstrained calls)
    +-- "DiagnosticsOption" -> (TERMINAL: unused)
    +-- "OnlyQuadTerms" ----> (TERMINAL: selectQuadraticSubset toggle)

simplifyWithDummySubstitution
    |
    +-- "Assumptions" -----> augmentedAss -> Assuming[...]
    +-- "Level0Pattern" ---> (TERMINAL: pattern matching)
    +-- "SimplifyFunction" -> (TERMINAL: Simplify vs FullSimplify)
    +-- Simplify options ---> FilterRules -> simplifyFn[..., opts]
```

---

## Cross-File Option Flow

### From ProcessModels.wl to ParamQuadSolve.wl

```
solveCoeffsSystem[model, opts]
    |
    +-- "paramQuadSolveOptions" -> paramQuadSolve[..., Sequence @@ paramQuadSolveOpts]
    |
    +-- calls expandPatternAssumptions[sysA, modelAssumptions]
    |
    +-- calls simplifyWithDummySubstitution[solA["Conditions"],
            "Assumptions" -> True,
            "SimplifyFunction" -> FullSimplify,
            Sequence @@ simplifyOpts
          ]
```

This allows users to pass options through `solveCoeffsSystem` to `paramQuadSolve` via the `"paramQuadSolveOptions"` meta-option.
````

</details>

<details>
<summary><code>options-backward/engine-moments-solveeuler.md</code></summary>

````markdown
# Options Flow: CreateMomentsDatabase.wl and SolveEulerEq.wl

This document traces how options flow through functions in these two computational engine files.

---

## File: CreateMomentsDatabase.wl

**Location**: `/Kernel/ComputationalEngine/CreateMomentsDatabase.wl`

This file provides functions for computing unconditional covariances and creating moment databases for model solving.

---

### Function: `uncondCovLongExo`

```wolfram
uncondCovLongExo[model_, expression1_, expression2_, covfun_, opts : OptionsPattern[{uncondCovLongExo}]]
```

**Options accepted**:
- `"IterationLimit"` -> `$IterationLimit/4` (default)

**Options flow**:
- `"IterationLimit"` -> **used directly** in `Block[{$IterationLimit = OptionValue["IterationLimit"]}, ...]` to limit iteration depth when computing covariances (line 198)

**Called by**:
- `uncondVarLongExo` (passes all options through)
- `uncondCovLong` (private function, passes all options through)
- `uncondVarLong` (private function, passes all options through)
- `totCovLong` (passes all options through)

---

### Function: `uncondVarLongExo`

```wolfram
uncondVarLongExo[model_, expression_, covfun_, opts : OptionsPattern[{uncondCovLongExo}]]
```

**Options accepted**:
- Inherits from `uncondCovLongExo`: `"IterationLimit"`

**Options flow**:
- All options -> passed to `uncondCovLongExo[model, expression, expression, covfun, opts]`

---

### Function: `createDatabase`

```wolfram
createDatabase[model_Association, covLongFilename_String, opts : OptionsPattern[{createDatabase, uncondCovLongExo}]]
```

**Options accepted**:
- `"maxMomentsLagsToCreate"` -> `8` (default)
- `"startSequenceAtLag"` -> `3` (default)
- `"simplifyDownValues"` -> `False` (default)
- Inherits from `uncondCovLongExo`: `"IterationLimit"`

**Options flow**:
- `"maxMomentsLagsToCreate"` -> **used directly** as `maxLag` to determine range of lags computed (lines 354-355, 393-394, 425-426)
- `"startSequenceAtLag"` -> **used directly** as `seqStart` to determine where sequence function patterns begin (lines 359-367, 395-404, 427-436)
- `"simplifyDownValues"` -> **used directly** to control whether `DownValues` are simplified with `Simplify` (line 593)
- `uncondCovLongExo` options -> extracted via `FilterRules[Flatten[{opts}], Options[uncondCovLongExo]]` and stored in `uncondCovLongExoOpts`, then passed to `totCovLong` when creating memoized rules (line 588)

**Internal option forwarding chain**:
```
createDatabase
  |-> uncondCovLongExoOpts (filtered)
        |-> totCovLong[..., opts]
              |-> uncondCovLong[..., opts]
                    |-> uncondCovLongExo[..., opts]
                          |-> OptionValue["IterationLimit"] (terminal use)
```

---

### Function: `totCovLong` (Private)

```wolfram
totCovLong[x_, y_, s_, model_Association, fun_, opts : OptionsPattern[{uncondCovLongExo}]]
```

**Options accepted**:
- Inherits from `uncondCovLongExo`: `"IterationLimit"`

**Options flow**:
- All options -> passed to `uncondCovLong[..., opts]`

**Calls (no options)**:
- `uncondE[...]` (from `ComputeUnconditionalExpectations`) - **no options**
- `cov[...]` (from `ComputeConditionalExpectations`) - **no options**
- `ev[...]` (from `ComputeConditionalExpectations`) - **no options**

---

### Function: `uncondCovLong` (Private)

```wolfram
uncondCovLong[model_, expr1_, expr2_, covfun_, opts : OptionsPattern[{uncondCovLongExo}]]
```

**Options accepted**:
- Inherits from `uncondCovLongExo`: `"IterationLimit"`

**Options flow**:
- All options -> passed directly to `uncondCovLongExo[..., opts]`

---

### Function: `uncondVarLong` (Private)

```wolfram
uncondVarLong[model_, expr_, covfun_, opts : OptionsPattern[{uncondCovLongExo}]]
```

**Options accepted**:
- Inherits from `uncondCovLongExo`: `"IterationLimit"`

**Options flow**:
- All options -> passed directly to `uncondVarLongExo[..., opts]`

---

### Functions Without Options

The following functions in this file do **not** accept options:
- `validArgsQ[components_]`
- `powerToProduct[expr_, t_]`
- `plusToList[expr_]`
- `split[expr_]`
- `epsQ[x_]`
- `modelVarQ[x_]`
- `covLongToUncondCov[components_]`
- `ap[expr_, {pos_, q_}]`
- `rp[expr_, {pos_, i_}]`
- `partitionConditions[expr_]`
- `partitionBy[expr_]`
- `categorize[expr_]`
- `splitAndFindSequenceFunction[expr_, q_]`
- `seqfun[list_, q_, v1_, v2_]`

---

## File: SolveEulerEq.wl

**Location**: `/Kernel/ComputationalEngine/SolveEulerEq.wl`

This file provides functions for solving Euler equations to find model coefficients.

---

### Function: `updateCoeffs`

```wolfram
updateCoeffs[args__]
```

**Options accepted** (inherited from `updateCoeffsSol` and `checks`):
- `"initialGuess"` -> `<|"Ewc"->{4},"Epd"->{{4}}|>`
- `"FindRootOptions"` -> `{}`
- `"RecurrenceTableOptions"` -> `{"DependentVariables"->Automatic}`
- `"UpdatePd"` -> `False`
- `"UpdateBond"` -> `False`
- `"UpdateNomBond"` -> `False`
- `"UpdateBonds"` -> `False`
- `"MaxMaturity"` -> `12`
- `"RootSigns"` -> `Automatic`
- `"PrintResidualsNorm"` -> `False`
- `"CheckResiduals"` -> `False`
- `"Tol"` -> `10.^-16`

**Options flow**:
- All options -> parsed via `ArgumentsOptions` with `"ExtraOptions"->{checks, FindRoot, RecurrenceTable}`, then passed to `updateCoeffsSol`

---

### Function: `updateCoeffsSol`

```wolfram
updateCoeffsSol[model_Association, savedKernels_Association, newParameters_List, guessCoeffsSolution_List,
  opts : OptionsPattern[{updateCoeffsSol, solveCoeffRoots, checks, FindRoot, RecurrenceTable}]]
```

**Options accepted**:
- `"initialGuess"` -> `<|"Ewc"->{4},"Epd"->{{4}}|>`
- `"FindRootOptions"` -> `{}`
- `"RecurrenceTableOptions"` -> `{"DependentVariables"->Automatic}`
- `"UpdatePd"` -> `False`
- `"UpdateBond"` -> `False`
- `"UpdateNomBond"` -> `False`
- `"UpdateBonds"` -> `False`
- `"MaxMaturity"` -> `12`
- `"RootSigns"` -> `Automatic`
- Inherits from `solveCoeffRoots` (via `OptionsPattern`)
- Inherits from `checks`: `"PrintResidualsNorm"`, `"CheckResiduals"`, `"Tol"`
- Inherits from `FindRoot`: `MaxIterations`, `AccuracyGoal`, `PrecisionGoal`, etc.
- Inherits from `RecurrenceTable`: `"DependentVariables"`, etc.

**Options flow**:
- `"MaxMaturity"` -> **used directly** for bond computation range
- `"RootSigns"` -> passed to `normalizeRootSigns` then to `updateCoeffsWcPd`
- `"UpdatePd"`, `"UpdateBond"`, `"UpdateNomBond"`, `"UpdateBonds"` -> **used directly** to control what gets computed
- `"PrintResidualsNorm"`, `"CheckResiduals"` -> **used directly** to determine if checks run
- `solveOpts` = `FilterRules[{opts}, Options[updateCoeffsSol]]` -> passed to `computeWcCoeffs` and `computePdCoeffs`
- `checkOpts` = `FilterRules[{opts}, Options[checks]]` -> passed to `checkCoeffs` -> `checks`
- `recurrenceOpts` = `FilterRules[{opts}, Options[RecurrenceTable]]` + `OptionValue["RecurrenceTableOptions"]` -> passed to `updateCoeffsBond`

**Internal option forwarding chain**:
```
updateCoeffsSol
  |-> computeWcCoeffs[..., solveOpts]
  |     |-> updateCoeffsWcPd[..., solveOpts]
  |           |-> solveCoeffRoots[..., solveOpts] (see below)
  |
  |-> computePdCoeffs[..., solveOpts]
  |     |-> updateCoeffsWcPd[..., solveOpts]
  |           |-> solveCoeffRoots[..., solveOpts]
  |
  |-> updateCoeffsBond[..., recurrenceOpts]
  |     |-> RecurrenceTable (via FilterRules)
  |
  |-> checkCoeffs[..., checkOpts]
        |-> checks[..., checkOpts]
              |-> OptionValue["CheckResiduals"] (terminal)
              |-> OptionValue["PrintResidualsNorm"] (terminal)
              |-> OptionValue["Tol"] (terminal)
```

---

### Function: `solveCoeffRoots`

```wolfram
solveCoeffRoots[quadSol_Association, savedKernel_Association, paramsBase_Association,
  signs : ({} | {_Integer ..}) : {}, extraParams_Association : <||>,
  opts : OptionsPattern[{solveCoeffRoots, findRootInterval, extractIntervalsFromReduce, scanAndSolve, fastRoot, FindRoot}]]
```

**Options accepted** (all inherited via `OptionsPattern`):
- From `findRootInterval`: `"CoeffName"`, `"SignSymbol"`, `"Signs"`
- From `extractIntervalsFromReduce`: `"InteriorShrink"`, `"RootUpperBound"`, `"UnboundedPad"`
- From `scanAndSolve`: `"BracketGrid"`, `"Tolerance"`, `"FastRootOptions"`, `"FindRootOptions"`
- From `fastRoot`: `Jacobian`, `Method`, `"SecantBlend"`, `"Return"`, `"FindRootOptions"`
- From `FindRoot`: `MaxIterations`, `AccuracyGoal`, `PrecisionGoal`, `WorkingPrecision`, `StepMonitor`, etc.

**Options flow**:
- `findOpts` = `FilterRules[{opts}, Options[findRootInterval]]` -> passed to `findRootInterval`
- `extractOpts` = `FilterRules[{opts}, Options[extractIntervalsFromReduce]]` -> passed to `extractIntervalsFromReduce`
- `scanOpts` = `FilterRules[{opts}, Join[Options[scanAndSolve], Options[FindRoot], Options[fastRoot]]]` -> passed to `scanAndSolve`

**For 1D case**:
```
solveCoeffRoots (1D)
  |-> findRootInterval[conds, paramsAll, "Signs"->signs, "CoeffName"->cName, "SignSymbol"->sName, findOpts...]
  |     |-> OptionValue["CoeffName"] (terminal)
  |     |-> OptionValue["SignSymbol"] (terminal)
  |     |-> OptionValue["Signs"] (terminal)
  |
  |-> extractIntervalsFromReduce[reduceExpr, coefList, extractOpts...]
  |     |-> OptionValue["InteriorShrink"] (terminal)
  |     |-> OptionValue["RootUpperBound"] (terminal)
  |     |-> OptionValue["UnboundedPad"] (terminal)
  |
  |-> scanAndSolve[f, df, interval, scanOpts...]
        |-> fastRoot[f, interval, Jacobian->df, scanOpts...]
              |-> FindRoot[..., FindRoot options]
```

**For nD case** (Length[coefList] > 1):
```
solveCoeffRoots (nD)
  |-> solveND[f, df, conds, paramsAll, signs, coefList, cName, sName,
              findOpts, extractOpts, scanOpts, quadSol["Solution"], "ReduceTimeLimit"->5.]
        |-> safeReduceCall[..., findOpts, timeout]
        |     |-> findRootInterval[..., findOpts] (with TimeConstrained)
        |
        |-> trySmartIntervals[f, df, reduceExpr, coefList, extractOpts, scanOpts, ...]
        |     |-> extractIntervalsFromReduce[..., extractOpts]
        |     |-> fastRoot[f, {x0, aFinite, bFinite}, Jacobian->df, scanOpts...]
        |
        |-> tryArtificialBox[f, df, coefList, scanOpts, ...]
        |     |-> fastRoot[..., scanOpts]
        |
        |-> nMinimizeFallback[f, coefList, reduceExpr, ...]
              |-> NMinimize[..., Method->"NelderMead"]
```

---

### Function: `solveND`

```wolfram
solveND[f_, df_, conds_, paramsAll_, signs_, coefList_, cName_, sName_,
        findOpts_, extractOpts_, scanOpts_, solTemplate_,
        opts : OptionsPattern[{solveND}]]
```

**Options accepted**:
- `"ReduceTimeLimit"` -> `5.` (default)

**Options flow**:
- `"ReduceTimeLimit"` -> **used directly** as timeout for `safeReduceCall`
- `rub` = `Lookup[extractOpts, "RootUpperBound", 15.]` -> used for bounds
- `pad` = `Lookup[extractOpts, "UnboundedPad", 1.*^5]` -> used for padding
- `acc` = `AccuracyGoal /. scanOpts /. AccuracyGoal -> 8` -> used for tolerance computation

---

### Function: `updateCoeffsBond`

```wolfram
updateCoeffsBond[modelCoeffsSolution_, modelParameters_, newParameters_, maxMaturity_, coeffsWc_,
  opts : OptionsPattern[{RecurrenceTable}]]
```

**Options accepted**:
- All `RecurrenceTable` options

**Options flow**:
- `FilterRules[{opts}, Options[RecurrenceTable]]` -> passed to `RecurrenceTable` calls within the model's coefficient solution expressions

---

### Function: `checks`

```wolfram
checks[eqs_, sol_, params_, newParams_, opts : OptionsPattern[]]
```

**Options accepted**:
- `"PrintResidualsNorm"` -> `False`
- `"CheckResiduals"` -> `False`
- `"Tol"` -> `10.^-16`

**Options flow**:
- `"CheckResiduals"` -> **used directly** to determine whether to abort on large residuals
- `"PrintResidualsNorm"` -> **used directly** to determine whether to print residual norms
- `"Tol"` -> **used directly** as tolerance threshold for residual checking

---

### Function: `solveWcPdRoots`

```wolfram
solveWcPdRoots[model_Association, savedKernelWc_Association, savedKernelPd_Association,
  signsWc_, signsPd_, extraParams_Association : <||>,
  opts : OptionsPattern[solveCoeffRoots]]
```

**Options accepted**:
- All `solveCoeffRoots` options (via inheritance)

**Options flow**:
- `optSeq = FilterRules[{opts}, Options[solveCoeffRoots]]` -> passed to `solveCoeffRoots` for both wc and pd

---

### Function: `getStartingValues`

```wolfram
getStartingValues[ratio_String, infoModel_Association : <||>, opts : OptionsPattern[{getStartingValues}]]
```

**Options accepted**:
- `"initialGuess"` -> `<|"Ewc" -> {4}, "Epd" -> {{4}}|>`

**Options flow**:
- `"initialGuess"` -> **used directly** to extract starting values for root finding

---

### Function: `addCoeffsSolutionN`

```wolfram
addCoeffsSolutionN[model_]
```

**Options accepted**: None (hardcoded options)

**Internal calls with hardcoded options**:
```wolfram
updateCoeffs[model, k,
  "UpdatePd"->True,
  "UpdateBonds"->True,
  "MaxMaturity"->12,
  "RootSigns" -> All
]
```

---

### Function: `flattenCoeffs`

**Options accepted**: None

---

### Function: `flattenCoeffsBundles`

**Options accepted**: None

---

### Functions in FindRootOptim.wl (Called by SolveEulerEq.wl)

These functions are defined in `/Kernel/Tools/FindRootOptim.wl` and are called by `solveCoeffRoots`:

#### `findRootInterval`

```wolfram
findRootInterval[conds_, paramValues_Association, opts : OptionsPattern[{findRootInterval}]]
```

**Options accepted**:
- `"CoeffName"` -> `"A"`
- `"SignSymbol"` -> `"signA"`
- `"Signs"` -> `{}`

**Options flow**:
- All options -> **used directly** for Reduce-based interval computation

---

#### `extractIntervalsFromReduce`

```wolfram
extractIntervalsFromReduce[reduceExpr_, rootVars_, opts : OptionsPattern[{extractIntervalsFromReduce}]]
```

**Options accepted**:
- `"InteriorShrink"` -> `0.001`
- `"RootUpperBound"` -> `15`
- `"UnboundedPad"` -> `1.*^5`

**Options flow**:
- All options -> **used directly** for interval extraction and padding

---

#### `scanAndSolve`

```wolfram
scanAndSolve[f_, df_, {a_, b_}, opts : OptionsPattern[{scanAndSolve, FindRoot, fastRoot}]]
scanAndSolve[f_, {a_, b_}, opts : OptionsPattern[{scanAndSolve, FindRoot, fastRoot}]]
```

**Options accepted**:
- `"BracketGrid"` -> `32`
- `"Tolerance"` -> `Automatic`
- `"FastRootOptions"` -> `{}`
- `"FindRootOptions"` -> `Automatic`
- All `FindRoot` options
- All `fastRoot` options

**Options flow**:
- `"BracketGrid"` -> **used directly** for grid subdivision count
- `"Tolerance"` -> **used directly** for zero-detection tolerance
- `"FindRootOptions"` -> passed to `fastRoot`
- `FilterRules[{opts}, Options[FindRoot]]` -> combined with `"FindRootOptions"` and passed to `fastRoot`
- `FilterRules[{opts}, Options[fastRoot]]` -> passed to `fastRoot`

---

#### `fastRoot`

```wolfram
fastRoot[f_, spec_, opts : OptionsPattern[{fastRoot, FindRoot}]]
```

**Options accepted**:
- `Jacobian` -> `None`
- `Method` -> `Automatic`
- `"SecantBlend"` -> `0.5`
- `"Return"` -> `"Value"`
- `"FindRootOptions"` -> `Automatic`
- All `FindRoot` options

**Options flow**:
- `Jacobian` -> **used directly** to provide derivative function
- `Method` -> **used directly** to select solving method (`"Newton"`, `"Brent"`, `"Secant"`, or `Automatic`)
- `"SecantBlend"` -> **used directly** for initial guess blending
- `"Return"` -> **used directly** to control output format
- `"FindRootOptions"` + `FilterRules[{opts}, Options[FindRoot]]` -> passed to internal `FindRoot` calls

---

## Summary: Complete Option Flow Diagram

```
updateCoeffs (entry point)
  |
  +-> updateCoeffsSol
        |
        +-> [Direct use] "MaxMaturity", "UpdatePd", "UpdateBond", "UpdateNomBond",
        |                "UpdateBonds", "RootSigns", "PrintResidualsNorm", "CheckResiduals"
        |
        +-> computeWcCoeffs/computePdCoeffs -> updateCoeffsWcPd -> solveCoeffRoots
        |     |
        |     +-> findRootInterval (FindRootOptim.wl)
        |     |     +-> [Direct use] "CoeffName", "SignSymbol", "Signs"
        |     |
        |     +-> extractIntervalsFromReduce (FindRootOptim.wl)
        |     |     +-> [Direct use] "InteriorShrink", "RootUpperBound", "UnboundedPad"
        |     |
        |     +-> scanAndSolve (FindRootOptim.wl)
        |           +-> [Direct use] "BracketGrid", "Tolerance"
        |           +-> fastRoot (FindRootOptim.wl)
        |                 +-> [Direct use] Jacobian, Method, "SecantBlend", "Return"
        |                 +-> FindRoot (built-in)
        |                       +-> [Direct use] MaxIterations, AccuracyGoal,
        |                                        PrecisionGoal, StepMonitor, etc.
        |
        +-> updateCoeffsBond
        |     +-> RecurrenceTable (built-in)
        |           +-> [Direct use] "DependentVariables", etc.
        |
        +-> checks
              +-> [Direct use] "PrintResidualsNorm", "CheckResiduals", "Tol"


createDatabase
  |
  +-> [Direct use] "maxMomentsLagsToCreate", "startSequenceAtLag", "simplifyDownValues"
  |
  +-> totCovLong -> uncondCovLong -> uncondCovLongExo
        +-> [Direct use] "IterationLimit"
```

---

## Functions Without Options

### CreateMomentsDatabase.wl
- `validArgsQ`, `powerToProduct`, `plusToList`, `split`, `epsQ`, `modelVarQ`
- `covLongToUncondCov`, `ap`, `rp`, `partitionConditions`, `partitionBy`
- `categorize`, `splitAndFindSequenceFunction`, `seqfun`

### SolveEulerEq.wl
- `signHeadFromExpr`, `safeReduceCall` (options passed through)
- `convertInfinityBounds`, `trySmartIntervals`, `tryArtificialBox`, `nMinimizeFallback`
- `loadModelKernels`, `clearKernelCache`
- `normalizeRootSigns`, `filterSolutions`, `extractSignIndex`
- `computeWcCoeffs`, `computePdCoeffs`, `checkCoeffs` (these forward options but don't declare their own)
- `flattenCoeffs`, `flattenCoeffsBundles`, `flattenCoeffsBundlesForA`

### ComputeConditionalExpectations.wl (called by CreateMomentsDatabase.wl)
- `ev`, `var`, `cov`, `corr` - **no options**
- `lagStateVarst` - has internal options (`"MaxIterations"`, `"TimeConstraint"`) but they are **not exposed** to callers

### ComputeUnconditionalExpectations.wl (called by CreateMomentsDatabase.wl)
- `uncondE`, `uncondVar`, `uncondCov`, `uncondCorr` - **no options**
````

</details>

<details>
<summary><code>options-backward/engine-unconditional-euler.md</code></summary>

````markdown
# Options Flow: ComputeUnconditionalExpectations.wl and CreateEulerEq.wl

This document traces how options flow through functions in the computational engine files for unconditional expectations and Euler equations.

## File: ComputeUnconditionalExpectations.wl

**Location**: `./Kernel/ComputationalEngine/ComputeUnconditionalExpectations.wl`

### Summary

This file contains **no functions that use options** (`OptionsPattern[]`, `OptionValue`, `FilterRules`, etc.). All functions in this file use positional arguments only.

### Functions Analyzed

#### `uncondE[x_, model_]`
- **Options accepted**: None
- **Signature**: `uncondE[x_, model_]`
- **Calls**: `uncondEStep` (no options)
- **Notes**: Public function for unconditional expectations

#### `uncondEStep[expr_, model_]`
- **Options accepted**: None
- **Signature**: `uncondEStep[expr_, model_]`
- **Calls**:
  - `evNoEpsStateVarsProduct` (no options)
  - `cond`Private`lagStateVarst` (from ComputeConditionalExpectations.wl - **has options but not passed here**)
- **Notes**: Internal function that processes expressions through state variable rules. When calling `lagStateVarst`, it uses default options since no options are passed.

#### `evNoEpsStateVarsProduct[expr_, model_, variablesToLag_]`
- **Options accepted**: None
- **Signature**: `evNoEpsStateVarsProduct[expr_, model_, variablesToLag_]`
- **Calls**:
  - `lagStateVarsProduct` (no options)
  - `evNoEps` (no options)
- **Notes**: Internal function for processing products of state variables

#### `evNoEps[model_, variablesToLag_]`
- **Options accepted**: None
- **Signature**: `evNoEps[model_, variablesToLag_]`
- **Returns**: A pattern rule (not a direct function)
- **Notes**: Creates replacement rules for epsilon terms

#### `lagStateVarsProduct[model_, variablesToLag_]`
- **Options accepted**: None
- **Signature**: `lagStateVarsProduct[model_, variablesToLag_]`
- **Returns**: A pattern rule
- **Notes**: Creates replacement rules for lagging state variable products

#### `uncondVar[x_, model_]`
- **Options accepted**: None
- **Signature**: `uncondVar[x_, model_]`
- **Calls**: `uncondE` twice (no options)

#### `uncondCov[x_, y_, model_]`
- **Options accepted**: None
- **Signature**: `uncondCov[x_, y_, model_]`
- **Calls**: `uncondE` three times (no options)

#### `uncondCorr[x_, y_, model_]`
- **Options accepted**: None
- **Signature**: `uncondCorr[x_, y_, model_]`
- **Calls**: `uncondCov`, `uncondVar` (no options)

#### `createSystem[n_, model_]`
- **Options accepted**: None
- **Signature**: `createSystem[n_, model_]`
- **Calls**: `uncondEStep` (no options)
- **Notes**: Creates system of equations for unconditional moments

#### `solveSystem[n_Integer, model_Association, Optional[maxSolveTime_?NumberQ, 60], sys_List:{}]`
- **Options accepted**: None (uses Optional positional argument for maxSolveTime)
- **Signature**: Uses positional argument with default `maxSolveTime = 60`
- **Calls**: `createSystem`, `sol` (no options)
- **Notes**: Solves system with time constraint via positional argument

#### `sol[2, model_, sys_:{}]` and `sol[n_Integer?((#>2) &), model_, sys_]`
- **Options accepted**: None
- **Signature**: Pattern-matched positional arguments
- **Calls**: `createSystem` (no options)
- **Notes**: Recursive solver for moment equations

---

## File: CreateEulerEq.wl

**Location**: `./Kernel/ComputationalEngine/CreateEulerEq.wl`

### Summary

This file contains **no functions that use options** (`OptionsPattern[]`, `OptionValue`, `FilterRules`, etc.). All functions use positional arguments only. However, functions in this file call `lagStateVarst` from ComputeConditionalExpectations.wl indirectly (via `ev`, `var`, `cov`), which does have options.

### Functions Analyzed

#### `eulereq[x_[t_, i___], s_, model_]`
- **Options accepted**: None
- **Signature**: `eulereq[x_[t_, i___], s_, model_]`
- **Calls** (from ComputeConditionalExpectations.wl):
  - `ev[sdf[t], s, model]` - no options passed
  - `var[sdf[t], s, model]` - no options passed
  - `ev[x[t,i], s, model]` - no options passed
  - `var[x[t,i], s, model]` - no options passed
  - `cov[sdf[t], x[t,i], s, model]` - no options passed
- **Options flow**:
  - `ev` -> `lagStateVarst` (uses default options: `"MaxIterations" -> 100`, `"TimeConstraint" -> 30`)
  - `var` -> `ev` -> `lagStateVarst` (uses default options)
  - `cov` -> `ev` -> `lagStateVarst` (uses default options)
- **Notes**: Public function for real Euler equations. Does not expose options for `lagStateVarst` to callers.

#### `nomeulereq[x_[t_, i___], s_, model_]`
- **Options accepted**: None
- **Signature**: `nomeulereq[x_[t_, i___], s_, model_]`
- **Calls** (from ComputeConditionalExpectations.wl):
  - `ev[nomsdf[t], s, model]` - no options passed
  - `var[nomsdf[t], s, model]` - no options passed
  - `ev[x[t,i], s, model]` - no options passed
  - `var[x[t,i], s, model]` - no options passed
  - `cov[nomsdf[t], x[t,i], s, model]` - no options passed
- **Options flow**: Same as `eulereq` - all paths to `lagStateVarst` use default options
- **Notes**: Public function for nominal Euler equations

#### `niceEulerEq[x_[t_, i___], model_, nominalFlag_:False]`
- **Options accepted**: None (uses Optional positional argument for nominalFlag)
- **Signature**: `niceEulerEq[x_[t_, i___], model_, nominalFlag_:False]`
- **Calls**:
  - `eulereq` or `nomeulereq` (based on nominalFlag) - no options
  - `orderingToTarget` - no options
- **Options flow**: Via `eulereq`/`nomeulereq` -> `ev`/`var`/`cov` -> `lagStateVarst` (default options)
- **Notes**: Private function for formatting Euler equations

#### `niceNomEulerEq[x_[t_, i___], model_]`
- **Options accepted**: None
- **Signature**: `niceNomEulerEq[x_[t_, i___], model_]`
- **Calls**: `niceEulerEq[x[t, i], model, True]` - passes `True` for nominalFlag
- **Notes**: Wrapper for nominal Euler equations

#### `orderingToTarget[list_, sourceIds_, targetIds_]`
- **Options accepted**: None
- **Signature**: `orderingToTarget[list_, sourceIds_, targetIds_]`
- **Notes**: Pure utility function for reordering lists

#### `findEulerEqConstants[x_[t_, i___], model_, nominalFlag_:False]`
- **Options accepted**: None (uses Optional positional argument for nominalFlag)
- **Signature**: `findEulerEqConstants[x_[t_, i___], model_, nominalFlag_:False]`
- **Calls**:
  - `niceEulerEq[x[t,i], model, nominalFlag]` - no options
- **Options flow**: Via `niceEulerEq` -> `eulereq`/`nomeulereq` -> `ev`/`var`/`cov` -> `lagStateVarst` (default options)
- **Notes**: Public function for finding Euler equation constants

#### `findBondRecursion[t_, n_, model_]`
- **Options accepted**: None
- **Signature**: `findBondRecursion[t_, n_, model_]`
- **Calls**:
  - `niceEulerEq[bondret[t,n], model]` - no options
  - `niceNomEulerEq[nombondret[t,n], model]` - no options
- **Options flow**: Via `niceEulerEq`/`niceNomEulerEq` -> `eulereq`/`nomeulereq` -> `ev`/`var`/`cov` -> `lagStateVarst` (default options)
- **Notes**: Public function for finding bond recursions

---

## Cross-File Option Dependencies

### Terminal Function with Options

The only function with options that is called (indirectly) from these files is:

#### `lagStateVarst` (ComputeConditionalExpectations.wl)
- **Location**: `./Kernel/ComputationalEngine/ComputeConditionalExpectations.wl`
- **Options**:
  - `"MaxIterations" -> 100` - Maximum iterations for FixedPointList
  - `"TimeConstraint" -> 30` - Timeout in seconds for TimeConstrained
- **Usage**: Controls iteration limits and timeout when converting expressions to state variable form
- **Terminal use**: Uses `OptionValue["MaxIterations"]` and `OptionValue["TimeConstraint"]` directly

### Call Chain Summary

```
ComputeUnconditionalExpectations.wl:
  uncondEStep -> evNoEps -> cond`Private`lagStateVarst (default options)

CreateEulerEq.wl:
  eulereq/nomeulereq -> ev/var/cov -> lagStateVarst (default options)
  niceEulerEq -> eulereq/nomeulereq -> ev/var/cov -> lagStateVarst (default options)
  findEulerEqConstants -> niceEulerEq -> ... -> lagStateVarst (default options)
  findBondRecursion -> niceEulerEq/niceNomEulerEq -> ... -> lagStateVarst (default options)
```

### Note on Option Propagation

Neither file currently propagates options to `lagStateVarst`. This means:
- All calls use default values (`"MaxIterations" -> 100`, `"TimeConstraint" -> 30`)
- Users cannot customize iteration limits or timeouts from the public API of these files
- If customization is needed, it would require adding `OptionsPattern[]` to the call chain
````

</details>

<details>
<summary><code>options-backward/main-longrunrisk.md</code></summary>

````markdown
# Options Flow: LongRunRisk.wl (Main Package File)

This document traces how options flow through functions defined or re-exported in the main package file `/Kernel/LongRunRisk.wl`.

## Overview

The main package file `LongRunRisk.wl` serves primarily as an orchestrator that:
1. Loads dependencies via `Needs` statements
2. Re-exports functions from sub-packages using `reExport`
3. Defines a few wrapper functions (like `UncondCov`, `UncondVar`, `UncondCorr`, `Info`)

Most functions with complex options are defined in the sub-packages and re-exported to the main `FernandoDuarte`LongRunRisk`` context.

---

## File: LongRunRisk.wl

### Functions Defined Directly in This File

#### Function: `UncondCov`
- **Options accepted**: None (no `OptionsPattern[]`)
- **Signature**: `UncondCov[x_, y_, model_]`
- **Options flow**:
  - No options accepted
  - Calls `FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`uncondCovLongExo[model, x, y, covLong]` without passing options

#### Function: `UncondVar`
- **Options accepted**: None
- **Signature**: `UncondVar[x_, model_]`
- **Options flow**:
  - Wrapper that calls `UncondCov[x, x, model]`
  - No options involved

#### Function: `UncondCorr`
- **Options accepted**: None
- **Signature**: `UncondCorr[x_, y_, model_]`
- **Options flow**:
  - Wrapper that calls `UncondCov` and `UncondVar`
  - No options involved

#### Function: `Info`
- **Options accepted**: None
- **Signature**: `Info[models_Association]`
- **Options flow**:
  - Wraps `FernandoDuarte`LongRunRisk`Tools`NiceOutput`info[models]`
  - No options passed

---

### Re-Exported Functions (via `reExport`)

The following functions are re-exported from sub-packages. Their options are defined in the source files and are available when called from the main package context.

#### From `ComputationalEngine`ComputeConditionalExpectations`

Re-exported via: `reExport[#]&/@{"FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"}`

| Source Function | Exported As | Options |
|-----------------|-------------|---------|
| `ev` | `Ev` | None |
| `var` | `Var` | None |
| `cov` | `Cov` | None |
| `corr` | `Corr` | None |

**Note**: The internal helper `lagStateVarst` has options (`"MaxIterations"` and `"TimeConstraint"`), but these are not exposed to the public API.

---

#### From `ComputationalEngine`ComputeUnconditionalExpectations`

| Source Function | Exported As | Options |
|-----------------|-------------|---------|
| `uncondE` | `UncondE` | See source file |

---

#### From `Tools`ManageResources`

Re-exported via: `reExport[FernandoDuarte`LongRunRisk`Tools`ManageResources`buildModels, FernandoDuarte`LongRunRisk`BuildModels]`

| Source Function | Exported As | Options |
|-----------------|-------------|---------|
| `buildModels` | `BuildModels` | Complex nested config (see below) |

##### `BuildModels` Options Flow

**Options accepted** (from `ManageResources.wl`):
```mathematica
Options[buildModels] = {
    "FromScratch" -> False,
    "CompileJacobians" -> False,
    "CreateMoments" -> True,
    "NumKernels" -> Automatic,
    "MaxMaturity" -> 120,
    "Models" -> All,
    "PdEquations" -> "B",
    "FileSuffix" -> "",
    "UpdateManifest" -> True
};
```

**Options flow**:
- `"FromScratch"` -> Controls whether to clean all outputs first
- `"CompileJacobians"` -> Passed to `determineModelStatus` and `createCompiledEq`
- `"CreateMoments"` -> Controls whether to run moments phase
- `"NumKernels"` -> Passed to `setupParallelKernels`
- `"MaxMaturity"` -> Passed to moments database creation via config
- `"Models"` -> Used to filter which models to process
- `"PdEquations"` -> Passed to symbolic/compile phases via `splitConfig`
- `"FileSuffix"` -> Used for checkpoint file naming
- `"UpdateManifest"` -> Controls manifest update at end

The options are normalized via `OptionsConfig`normalizeConfig` and then distributed to various phases via `OptionsConfig`splitConfig`.

---

#### From `Tools`NicePlots`

Re-exported via: `reExport[#]&/@{"FernandoDuarte`LongRunRisk`Tools`NicePlots`"}`

| Source Function | Exported As | Options |
|-----------------|-------------|---------|
| `yieldCurve` | `YieldCurve` | See below |
| `plotCoeffs` | `PlotCoeffs` | See below |

##### `YieldCurve` Options Flow

**Options accepted**:
```mathematica
Options[yieldCurve] = {
    "MaxMaturity" -> 12,
    "MomentFunction" -> uncondE
};
```

**Full signature**: `yieldCurve[model_, newParameters_:{}, coeffsWc_:{}, bondType_:"nombond", opts:OptionsPattern[{yieldCurve, updateCoeffs, FindRoot, RecurrenceTable}]]`

**Options flow**:
- `"MaxMaturity"` -> Used directly to set maturity range for yield curve
- `"MomentFunction"` -> Used directly to compute unconditional expectations
- Options compatible with `updateCoeffs` -> Filtered and passed to `updateCoeffs` via `FilterRules`
- Options compatible with `FindRoot` -> Filtered and passed to `updateCoeffs`
- Options compatible with `RecurrenceTable` -> Filtered and passed to `updateCoeffsBond`

##### `PlotCoeffs` Options Flow

**Options accepted**: `opts: OptionsPattern[]` (passes through to `FindRootPlot`)

**Options flow**:
- All options -> Passed to `ResourceFunction["FindRootPlot"]` via `Flatten @ {opts}`

---

#### From `Tools`TimeAggregation`

Re-exported via: `reExport[#]&/@{"FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"}`

| Source Function | Exported As | Options |
|-----------------|-------------|---------|
| `growth` | `Growth` | See below |

##### `Growth` Options Flow

**Options accepted**:
```mathematica
Options[growth] = {
    "v0" -> Function[{t,j,h,k,v,im}, 0],
    "Order" -> 1
};
```

**Full signature**: `growth[v_Symbol, t_, Optional[im:...], opts:OptionsPattern[{growth, timeSeriesVector, g}]]`

**Options flow**:
- `"v0"` -> Used directly for power series expansion point
- `"Order"` -> Used directly for power series order
- `"TimeAggregation"` (from `timeSeriesVector`) -> Used via `OptionValue`
- `"numPeriods"` (from `timeSeriesVector`) -> Used via `OptionValue`
- `"Variable"` (from `g`) -> Used via `OptionValue` to determine flow/stock/ratio handling

**Internal helper options**:

`timeSeriesVector`:
```mathematica
Options[timeSeriesVector] = {
    "TimeAggregation" -> 1,
    "numPeriods" -> 1
};
```

`g`:
```mathematica
Options[g] = {
    "Variable" -> "Flow"
};
```

Options passed to `gt` are filtered with `FilterRules[{opts}, Except[Options[growth]]]` to separate growth-specific options from those passed downstream.

---

#### From `Tools`ToNumber`

Re-exported via: `reExport[#]&/@{"FernandoDuarte`LongRunRisk`Tools`ToNumber`"}`

| Source Function | Exported As | Options |
|-----------------|-------------|---------|
| `toNum` | `ToNum` | See below |
| `toEquation` | `ToEquation` | None |
| `toExogenousVars` | `ToExogenousVars` | None |
| `toStateVars` | `ToStateVars` | None |

##### `ToNum` Options Flow

**Options accepted**: Inherits from `updateCoeffs`

**Signature variants**:
- `toNum["Rules", model, rest__]`
- `toNum[expr, model, rest__]`
- `toNum[model, rest__]`

**Internal implementation** (`toNumRules`):
```mathematica
toNumRules[
    model_Association,
    Longest[newParameters : {(_Rule)...} : {}, 1],
    Longest[guessCoeffsSolution_List : {}, 2],
    opts : OptionsPattern[{updateCoeffs}]
]
```

**Options flow**:
- Options matching `updateCoeffs` -> Filtered via `FilterRules` and passed to `updateCoeffs`

---

#### From `Tools`VisualizeCoeffs`

Re-exported via: `reExport[#]&/@{"FernandoDuarte`LongRunRisk`Tools`VisualizeCoeffs`"}`

| Source Function | Exported As | Options |
|-----------------|-------------|---------|
| `visualizeCoeffs` | `VisualizeCoeffs` | See below |

##### `VisualizeCoeffs` Options Flow

**Options accepted**:
```mathematica
Options[visualizeCoeffs] = {
    "ShowSelector" -> True,
    "ShowDetails" -> True
};
```

**Options flow**:
- `"ShowSelector"` -> Used directly to control whether coefficient selector panel is shown
- `"ShowDetails"` -> Used directly to control whether bundle details section is shown
- Neither option is passed to other functions

---

#### From `Tools`PipelineMonitor`

Re-exported via: `reExport[FernandoDuarte`LongRunRisk`Tools`PipelineMonitor`checkModels, FernandoDuarte`LongRunRisk`CheckModels]`

| Source Function | Exported As | Options |
|-----------------|-------------|---------|
| `checkModels` | `CheckModels` | See below |

##### `CheckModels` Options Flow

**Options accepted**:
```mathematica
Options[checkModels] = {"AutoBuild" -> Automatic};
```

**Options flow**:
- `"AutoBuild"` -> Used via `resolveAutoBuild` to determine if auto-build should occur
  - `True`: Auto-build without prompts
  - `False`: Never auto-build
  - `Automatic`: Auto-build if `LONGRUNRISK_AUTOBUILD` env var is set or in CI environment
- When building, calls `buildModels["Models" -> modelsToBuild]` without forwarding `"AutoBuild"`

---

## Summary: Options Terminal Points

This section identifies where options are ultimately consumed (terminal use) vs. passed to other functions.

| Function | Option | Terminal Use | Passed To |
|----------|--------|--------------|-----------|
| `BuildModels` | `"FromScratch"` | Yes (controls cleanup) | - |
| `BuildModels` | `"CompileJacobians"` | Partial | `determineModelStatus`, `createCompiledEq` |
| `BuildModels` | `"CreateMoments"` | Yes (controls phase) | - |
| `BuildModels` | `"NumKernels"` | Yes (via `setupParallelKernels`) | `buildModels` (recursive) |
| `BuildModels` | `"MaxMaturity"` | - | Config system -> moments |
| `BuildModels` | `"Models"` | Yes (filtering) | - |
| `BuildModels` | `"PdEquations"` | - | `splitConfig` -> symbolic/compile |
| `BuildModels` | `"FileSuffix"` | Yes (file naming) | - |
| `BuildModels` | `"UpdateManifest"` | Yes (controls update) | - |
| `YieldCurve` | `"MaxMaturity"` | Yes (maturity range) | - |
| `YieldCurve` | `"MomentFunction"` | Yes (moment computation) | - |
| `YieldCurve` | `updateCoeffs` opts | - | `updateCoeffs` |
| `YieldCurve` | `FindRoot` opts | - | `updateCoeffs` |
| `YieldCurve` | `RecurrenceTable` opts | - | `updateCoeffsBond` |
| `PlotCoeffs` | All opts | - | `FindRootPlot` |
| `Growth` | `"v0"` | Yes (expansion point) | - |
| `Growth` | `"Order"` | Yes (series order) | - |
| `Growth` | `"TimeAggregation"` | Yes (via `OptionValue`) | - |
| `Growth` | `"numPeriods"` | Yes (via `OptionValue`) | - |
| `Growth` | `"Variable"` | Yes (via `OptionValue`) | - |
| `ToNum` | `updateCoeffs` opts | - | `updateCoeffs` |
| `VisualizeCoeffs` | `"ShowSelector"` | Yes (UI control) | - |
| `VisualizeCoeffs` | `"ShowDetails"` | Yes (UI control) | - |
| `CheckModels` | `"AutoBuild"` | Yes (controls behavior) | - |

---

## Cross-File Dependencies

Many options flow to functions defined in other files. Key destination files:

1. **`SolveEulerEq.wl`**: Receives options via `updateCoeffs` from `YieldCurve`, `ToNum`
2. **`FindRootOptim.wl`**: Receives compile options from `BuildModels` via config
3. **`CreateMomentsDatabase.wl`**: Receives moments options from `BuildModels` via config
4. **`ProcessModels.wl`**: Receives symbolic options from `BuildModels` via config
5. **`OptionsConfig.wl`**: Normalizes and splits options for `BuildModels`

For detailed options flow in these files, see their respective documentation in `/docs/options/`.
````

</details>

<details>
<summary><code>options-backward/model-catalog-processmodels.md</code></summary>

````markdown
# Options Flow: Catalog.wl and ProcessModels.wl

This document traces how options flow through functions in the `Catalog.wl` and `ProcessModels.wl` files.

---

## File: Catalog.wl

**Location**: `/Kernel/Model/Catalog.wl`

### Overview

The `Catalog.wl` file defines the public symbols `models` and `modelsExtraInfo`. These are pure data structures (Associations) containing model definitions and extra information.

**This file contains NO functions that use options.** It only defines:
- `models`: An Association mapping model names to their properties (parameters, state variables, etc.)
- `modelsExtraInfo`: An Association with additional model information (closed-form coefficients, initial guesses)

No `OptionsPattern[]`, `OptionValue`, or `FilterRules` are used in this file.

---

## File: ProcessModels.wl

**Location**: `/Kernel/Model/ProcessModels.wl`

### Function: `processModels`

```wolfram
processModels[
    modelsCatalog_Association,
    opts:OptionsPattern[{solveCoeffsSystem, updateCoeffs, getStartingValues, FindRoot, RecurrenceTable}]
]
```

- **Options accepted**: Inherits from `solveCoeffsSystem`, `updateCoeffs`, `getStartingValues`, `FindRoot`, `RecurrenceTable`
- **Options flow**:
  - `"PdEquations"` -> extracted via `OptionValue[solveCoeffsSystem, Flatten@{opts}, "PdEquations"]` -> passed to `solveCoeffsSystem`
  - Options for `addCoeffsSolution` -> extracted via `FilterRules[Flatten@{opts}, Options[addCoeffsSolution]]` -> passed to `addCoeffsSolution`
  - Remaining options flow implicitly through the OptionsPattern mechanism

---

### Function: `simplifyCoeffsSystem`

```wolfram
simplifyCoeffsSystem // Options = {
    "SimplifyOptions" -> {TimeConstraint -> {5, 300}}
};

simplifyCoeffsSystem[model_, opts : OptionsPattern[{solveCoeffsSystem, Simplify}]]
```

- **Options accepted**:
  - `"SimplifyOptions"` (own option, default: `{TimeConstraint -> {5, 300}}`)
  - All `Simplify` options (forwarded)
  - All `solveCoeffsSystem` options (for compatibility)

- **Options flow**:
  - `simplifyOpts` constructed from:
    - `FilterRules[Flatten@{opts}, Options[Simplify]]` (Simplify options)
    - `OptionValue["SimplifyOptions"]` (custom simplify options)
  - `simplifyOpts` -> passed to `FullSimplify[e, Sequence @@ simplifyOpts]`
  - **Terminal use**: Options are consumed directly by `FullSimplify` calls

---

### Function: `solveCoeffsSystem`

```wolfram
solveCoeffsSystem // Options = {
    "SimplifyOptions" -> {TimeConstraint -> {5, 300}},
    "paramQuadSolveOptions" -> {},
    "PdEquations" -> "B"  (* "B" | "AB" | "Both" *)
};

solveCoeffsSystem[model_, opts : OptionsPattern[{solveCoeffsSystem, Simplify}]]
```

- **Options accepted**:
  - `"SimplifyOptions"` (default: `{TimeConstraint -> {5, 300}}`)
  - `"paramQuadSolveOptions"` (default: `{}`)
  - `"PdEquations"` (default: `"B"`)
  - All `Simplify` options

- **Options flow**:
  - `simplifyOpts` -> constructed same as `simplifyCoeffsSystem` -> passed to `FullSimplify`, `Simplify`
  - `paramQuadSolveOpts` -> `OptionValue["paramQuadSolveOptions"]` -> passed to `paramQuadSolve` (in ParamQuadSolve.wl)
  - `pdMode` -> `OptionValue["PdEquations"]` -> controls which pd equations to compute

- **Downstream calls**:
  - `paramQuadSolve[sysA, varsA, ..., Sequence @@ paramQuadSolveOpts]` -> **ParamQuadSolve.wl**
  - `simplifyWithDummySubstitution[..., Sequence @@ simplifyOpts]` -> **ParamQuadSolve.wl**
  - `tryTransforms[#, assumeA, Sequence @@ simplifyOpts]` -> internal helper

---

### Function: `tryTransforms`

```wolfram
tryTransforms // Options = {
    "SimplifyOptions" -> {TimeConstraint -> {5,300}}
};

tryTransforms[
    expr_,
    ass : Except[_List] : True,
    transforms : _List | Automatic : Automatic,
    opts : OptionsPattern[{tryTransforms, Simplify}]
]
```

- **Options accepted**:
  - `"SimplifyOptions"` (default: `{TimeConstraint -> {5, 300}}`)
  - All `Simplify` options

- **Options flow**:
  - `simplifyOpts` constructed from:
    - `FilterRules[Flatten@{opts}, Options[Simplify]]`
    - `OptionValue["SimplifyOptions"]`
  - **Terminal use**: `Simplify[expr /. tr, Sequence @@ simplifyOpts]`

---

### Function: `addCoeffsSolution`

```wolfram
Options[addCoeffsSolution] = {
    "MaxMaturity" -> 12,
    "initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>,
    "RootSigns" -> Automatic,
    "FindRootOptions" -> {},
    "RecurrenceTableOptions" -> {},
    "DependentVariables" -> Automatic
};

addCoeffsSolution[
    model_,
    ratio: "bond" | "nombond",
    opts : OptionsPattern[{addCoeffsSolution, updateCoeffs, RecurrenceTable}]
]
```

- **Options accepted**:
  - `"MaxMaturity"` (default: 12)
  - `"initialGuess"` (default: `<|"Ewc" -> {4}, "Epd" -> {{4}}|>`)
  - `"RootSigns"` (default: Automatic)
  - `"FindRootOptions"` (default: `{}`)
  - `"RecurrenceTableOptions"` (default: `{}`)
  - `"DependentVariables"` (default: Automatic)
  - All `updateCoeffs` options
  - All `RecurrenceTable` options

- **Options flow**:
  - `recurrenceTableOpts` constructed from:
    - `FilterRules[Flatten@{opts}, Options[RecurrenceTable]]`
    - `OptionValue[addCoeffsSolution, {"RecurrenceTableOptions"}]`
  - `recurrenceTableOpts` -> embedded into `Inactive[RecurrenceTable][..., recurrenceTableOpts]`
  - **Terminal use**: When `RecurrenceTable` is activated, options are consumed

---

### Helper Functions (No Options)

The following functions in ProcessModels.wl do NOT accept options:

- `safeRest[list_List]` - utility for safe list extraction
- `safeVerification[...]` - converts verification results to boolean list
- `createExogenous[m_]` - adds exogenous variables/equations to models
- `createExogenousNonZero[m_]` - filters out zero exogenous equations
- `createEndogenous[mod_]` - adds endogenous variables/equations
- `addToStateVars[model_]` - creates mapping to state variables
- `addCoeffsSystem[model_]` - creates Euler equations (calls external functions but passes no options)

---

## Options Flow Diagram

```
processModels
    |
    +-- "PdEquations" ---------> solveCoeffsSystem
    |                                |
    |                                +-- "SimplifyOptions" --> FullSimplify (terminal)
    |                                |
    |                                +-- "paramQuadSolveOptions" --> paramQuadSolve (ParamQuadSolve.wl)
    |                                |                                   |
    |                                |                                   +-- (many internal options)
    |                                |
    |                                +-- tryTransforms
    |                                        |
    |                                        +-- "SimplifyOptions" --> Simplify (terminal)
    |
    +-- FilterRules[..., Options[addCoeffsSolution]]
            |
            +-- addCoeffsSolution
                    |
                    +-- "RecurrenceTableOptions" --> RecurrenceTable (terminal)
                    +-- "MaxMaturity" --> used directly
                    +-- "initialGuess" --> used directly (not consumed here)
```

---

## Cross-File Option Dependencies

### ProcessModels.wl -> ParamQuadSolve.wl

The `solveCoeffsSystem` function calls:

```wolfram
paramQuadSolve[sysA, varsA,
    "SignSymbol" -> Symbol["sign"<>SymbolName[coefwc]],
    Assumptions -> assumeA,
    Sequence @@ paramQuadSolveOpts
]
```

`paramQuadSolve` accepts these options (defined in ParamQuadSolve.wl):
- `"DomainOption"` -> Reals
- `"Assumptions"` -> Automatic
- `"Method"` -> Automatic
- `"MonomialOrder"` -> Automatic
- `"ValidationOption"` -> True
- `"ReturnOption"` -> "All"
- `"TimeoutOption"` -> 600
- `"SimplifyTimeout"` -> Automatic
- `"DiagnosticsOption"` -> False
- `"OnlyQuadTerms"` -> False
- `"SignSymbol"` -> signA
- `"GroebnerMemoryFraction"` -> 0.5
- `"GroebnerMemoryFloor"` -> 1*1024^3
- `"GroebnerMemoryCap"` -> 16*1024^3

### ProcessModels.wl -> SolveEulerEq.wl

The `processModels` accepts options from `updateCoeffs` (defined in SolveEulerEq.wl), which inherits from:
- `updateCoeffsSol`
- `checks`
- `solveCoeffRoots`
- `FindRoot`
- `RecurrenceTable`

Key options from `updateCoeffsSol`:
- `"initialGuess"` -> <|"Ewc"->{4},"Epd"->{{4}}|>
- `"FindRootOptions"` -> {}
- `"RecurrenceTableOptions"` -> {"DependentVariables"->Automatic}
- `"UpdatePd"` -> False
- `"UpdateBond"` -> False
- `"UpdateNomBond"` -> False
- `"UpdateBonds"` -> False
- `"MaxMaturity"` -> 12
- `"RootSigns"` -> Automatic

### ProcessModels.wl -> FindRootOptim.wl

Options for `getStartingValues` (in FindRootOptim.wl) are accepted but not explicitly used in ProcessModels.wl.

---

## Summary Table

| Function | Options Defined | Options Inherited From | Passes Options To |
|----------|-----------------|------------------------|-------------------|
| `processModels` | none | solveCoeffsSystem, updateCoeffs, getStartingValues, FindRoot, RecurrenceTable | solveCoeffsSystem, addCoeffsSolution |
| `simplifyCoeffsSystem` | SimplifyOptions | solveCoeffsSystem, Simplify | FullSimplify (terminal) |
| `solveCoeffsSystem` | SimplifyOptions, paramQuadSolveOptions, PdEquations | Simplify | paramQuadSolve, simplifyWithDummySubstitution, tryTransforms, FullSimplify |
| `tryTransforms` | SimplifyOptions | Simplify | Simplify (terminal) |
| `addCoeffsSolution` | MaxMaturity, initialGuess, RootSigns, FindRootOptions, RecurrenceTableOptions, DependentVariables | updateCoeffs, RecurrenceTable | RecurrenceTable (terminal) |
````

</details>

<details>
<summary><code>options-backward/model-parameters-endogenous.md</code></summary>

```markdown
# Options Flow: Parameters.wl and EndogenousEq.wl

## File: Parameters.wl

**Location**: `/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/Parameters.wl`

### Summary

This file defines model parameter symbols for a long-run risk economic model. It contains:

- Usage messages for 70+ parameter symbols (preferences, long-run risk, inflation, consumption growth, volatility, dividends, etc.)
- A `paramList` association organizing parameters by category
- Parameter assumptions (`paramAssumptions`) for mathematical constraints

**No options-related code is present in this file.**

The file does not contain any functions that use:
- `OptionsPattern[]`
- `opts:OptionsPattern[]`
- `OptionValue`
- `FilterRules`
- `Options[]`

All definitions are direct symbol declarations with usage messages or simple variable assignments.

---

## File: EndogenousEq.wl

**Location**: `/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/EndogenousEq.wl`

### Summary

This file defines endogenous equations for the long-run risk model, including:

- Wealth-consumption ratio (`wceq`)
- Price-dividend ratios (`pdeq`)
- Real and nominal bond prices (`bondeq`, `nombondeq`)
- Stochastic discount factors (`sdfeq`, `nomsdfeq`)
- Returns and excess returns (`retceq`, `reteq`, `excretceq`, `excreteq`)
- Bond yields, forward rates, and returns (`bondyieldeq`, `bondfweq`, `bondreteq`, etc.)
- Risk-free rates (`rfeq`, `nomrfeq`)
- Campbell-Shiller approximation constants (`kappa0eq`, `kappa1eq`)

**No options-related code is present in this file.**

The file does not contain any functions that use:
- `OptionsPattern[]`
- `opts:OptionsPattern[]`
- `OptionValue`
- `FilterRules`
- `Options[]`

### Function Definitions

All functions in this file are simple pattern-based definitions without options handling:

| Function | Arguments | Description |
|----------|-----------|-------------|
| `wceq` | `t` | Log wealth-consumption ratio (via UpValues with state variables) |
| `pdeq` | `t, i` | Log price-dividend ratio for stock i |
| `bondeq` | `t, m` | Log real bond price (m-month maturity) |
| `nombondeq` | `t, m` | Log nominal bond price (m-month maturity) |
| `sdfeq` | `t` | Real stochastic discount factor |
| `nomsdfeq` | `t` | Nominal stochastic discount factor |
| `retceq` | `t` | Return on consumption asset |
| `reteq` | `t, i` | Return for stock i |
| `kappa1eq` | `mu` | Campbell-Shiller constant kappa1 |
| `kappa0eq` | `mu` | Campbell-Shiller constant kappa0 |
| `excretceq` | `t` | Excess return on consumption asset |
| `excreteq` | `t, i` | Excess return for stock i |
| `bondyieldeq` | `t, m` | Real bond yield |
| `nombondyieldeq` | `t, m` | Nominal bond yield |
| `bondfweq` | `t, m, h:1` | Real forward rate |
| `nombondfweq` | `t, m, h:1` | Nominal forward rate |
| `bondreteq` | `t, m, h:1` | Real bond return |
| `nombondreteq` | `t, m, h:1` | Nominal bond return |
| `bondfwspreadeq` | `t, m, h:1` | Real forward spread |
| `nombondfwspreadeq` | `t, m, h:1` | Nominal forward spread |
| `bondexcreteq` | `t, m, h:1` | Real bond excess return |
| `nombondexcreteq` | `t, m, h:1` | Nominal bond excess return |
| `rfeq` | `t, h:1` | Real risk-free rate |
| `nomrfeq` | `t, h:1` | Nominal risk-free rate |
| `linearInStateVars` | `stateVars, coeff` | Helper for linear-in-state-vars expressions |

Note: Some functions like `bondfweq[t, m, h:1]` use default argument values (`:1`), but this is Wolfram Language's default argument syntax, not options handling.

---

## Dependencies

EndogenousEq.wl imports the following packages:
- `FernandoDuarte`LongRunRisk`Model`Parameters`` (this file)
- `FernandoDuarte`LongRunRisk`Model`Shocks``
- `FernandoDuarte`LongRunRisk`Model`ExogenousEq``

None of these imports are for options-related functionality.
```

</details>

<details>
<summary><code>options-backward/model-shocks-exogenous.md</code></summary>

```markdown
# Options Flow: Shocks.wl and ExogenousEq.wl

This document analyzes the options handling patterns in the Shocks.wl and ExogenousEq.wl files of the LongRunRisk package.

## File: Shocks.wl

**Path**: `/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/Shocks.wl`

### Summary

**This file contains NO options-related code.**

The file defines two public symbols:
- `rulesE` - Defines the distribution of exogenous shocks
- `eps` - Exogenous shocks symbol

### Function Analysis

#### `rulesE[t_]`

- **Signature**: `rulesE[t_]`
- **Options accepted**: None
- **Options patterns used**: None (no `OptionsPattern[]`, `OptionValue`, or `FilterRules`)
- **Description**: This function takes a single time argument `t` and returns a list of replacement rules for computing expectations of products of exogenous shocks. It uses a `With` block for local constants but does not use any options mechanism.

The file uses:
- `Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"]` for model parameters
- `SetAttributes[$shocks, NHoldAll]` for maintaining integer indices

---

## File: ExogenousEq.wl

**Path**: `/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ExogenousEq.wl`

### Summary

**This file contains NO options-related code.**

The file defines public symbols for exogenous dynamics equations:
- `xeq` - Long-run risk dynamics
- `pieq` - Inflation dynamics
- `pibareq` - Expected inflation dynamics
- `dceq` - Real consumption growth dynamics
- `sgeq` - Nominal-real covariance (NRC) dynamics
- `sxeq` - Stochastic volatility of long-run risk dynamics
- `sceq` - Stochastic volatility of consumption growth dynamics
- `speq` - Stochastic volatility of inflation dynamics
- `ddeq` - Real dividend growth dynamics (for stock i)

### Function Analysis

#### `xeq[t_]`

- **Signature**: `xeq[t_]`
- **Options accepted**: None
- **Description**: Defines the exogenous dynamics of long-run risk as a function of time `t`.

#### `pieq[t_]`

- **Signature**: `pieq[t_]`
- **Options accepted**: None
- **Description**: Defines the exogenous dynamics of inflation.

#### `pibareq[t_]`

- **Signature**: `pibareq[t_]`
- **Options accepted**: None
- **Description**: Defines the exogenous dynamics of expected inflation.

#### `dceq[t_]`

- **Signature**: `dceq[t_]`
- **Options accepted**: None
- **Description**: Defines the exogenous dynamics of real consumption growth.

#### `sgeq[t_]`

- **Signature**: `sgeq[t_]`
- **Options accepted**: None
- **Description**: Defines the exogenous dynamics of the nominal-real covariance (NRC).

#### `sxeq[t_]`

- **Signature**: `sxeq[t_]`
- **Options accepted**: None
- **Description**: Defines the exogenous dynamics of stochastic volatility of long-run risk.

#### `sceq[t_]`

- **Signature**: `sceq[t_]`
- **Options accepted**: None
- **Description**: Defines the exogenous dynamics of stochastic volatility of consumption growth.

#### `speq[t_]`

- **Signature**: `speq[t_]`
- **Options accepted**: None
- **Description**: Defines the exogenous dynamics of stochastic volatility of inflation.

#### `ddeq[t_, i_]`

- **Signature**: `ddeq[t_, i_]`
- **Options accepted**: None
- **Description**: Defines the exogenous dynamics of real dividend growth for stock `i`.

### Dependencies

The file uses:
- `Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"]` for model parameters
- `Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"]` for shock symbols (`eps`)

---

## Conclusion

Both **Shocks.wl** and **ExogenousEq.wl** are purely mathematical definition files that:

1. **Do not use any options mechanisms** - No `OptionsPattern[]`, `OptionValue`, `FilterRules`, or `Options` are present
2. **Define pure mathematical equations** - All functions take only required positional arguments (time `t`, and in one case stock index `i`)
3. **Rely on global parameters** - Model parameters (like `rhox`, `phix`, `muc`, etc.) come from the `Parameters` package rather than being passed as options

These files represent the mathematical specification layer of the model and are designed to be simple, declarative definitions without configuration options. Any customization of the model equations would be done by modifying the parameter values in the `Parameters` package rather than through options passed to these functions.
```

</details>

<details>
<summary><code>options-backward/tools-findroot-dependencies.md</code></summary>

````markdown
# Options Flow: FindRootOptim.wl and Dependencies.wl

This document traces how options flow through functions in the FindRootOptim.wl and Dependencies.wl files.

---

## File: FindRootOptim.wl

### Function: `buildKernel`

**Location:** Lines 83-356

**Options accepted:**
```wolfram
Options = {
    "CoeffName" -> "A",
    "SignSymbol" -> "signA",
    "PerformanceGoal" -> "Speed",           (* "Speed" | "Quality" *)
    "CompileMode" -> "FunctionOnly",        (* "Both" | "FunctionOnly" | "JacobianOnly" *)
    "Compiler" -> "Compile",                (* "Compile" | "FunctionCompile" *)
    "FlattenExpressions" -> Automatic,      (* True | False | Automatic *)
    "AllowCompileDuringCoverage" -> False   (* True to force compilation even during coverage *)
}
```

Also accepts options from: `FunctionCompile`, `Compile`

**Options flow:**

| Option | Flow Path | Terminal Use |
|--------|-----------|--------------|
| `"CoeffName"` | Used directly in `buildKernel` | Determines coefficient variable detection and stored in returned Association |
| `"SignSymbol"` | Used directly in `buildKernel` | Determines sign symbol detection via `signIdxs` helper and stored in returned Association |
| `"PerformanceGoal"` | Used directly in `buildKernel` | Controls `CompilerOptions` for FunctionCompile or `RuntimeOptions` for Compile |
| `"CompileMode"` | Used directly in `buildKernel` | Determines whether to compile function, Jacobian, or both |
| `"Compiler"` | Used directly in `buildKernel` | Selects between `Compile` (C target) and `FunctionCompile` |
| `"FlattenExpressions"` | Used directly in `buildKernel` | Controls whether expressions are flattened via `flattenForCompileBody` before compilation |
| `"AllowCompileDuringCoverage"` | Passed to `compileWithDiagnostics` (internal helper) | Controls whether to skip compilation during coverage mode |
| `FunctionCompile` options | `FilterRules[{opts}, Options[FunctionCompile]]` -> passed to `FunctionCompile` | Terminal: used by `FunctionCompile` system function |
| `Compile` options | `FilterRules[{opts}, Options[Compile]]` -> passed to `Compile` | Terminal: used by `Compile` system function |

---

### Function: `bindUnary`

**Location:** Lines 363-423

**Options accepted:**
```wolfram
Options = {
    "Signs" -> {}
}
```

**Options flow:**

| Option | Flow Path | Terminal Use |
|--------|-----------|--------------|
| `"Signs"` | Used directly in `bindUnary` | Sign values are extracted and packed into the bound function arguments |

---

### Function: `findRootInterval`

**Location:** Lines 430-510

**Options accepted:**
```wolfram
Options = {
    "CoeffName" -> "A",
    "SignSymbol" -> "signA",
    "Signs" -> {}
}
```

**Options flow:**

| Option | Flow Path | Terminal Use |
|--------|-----------|--------------|
| `"CoeffName"` | Used directly in `findRootInterval` | Determines which coefficient head to look for in conditions (e.g., `A[0]`) |
| `"SignSymbol"` | Used directly in `findRootInterval` | Converted to expression via `ToExpression` to create sign substitution rules |
| `"Signs"` | Used directly in `findRootInterval` | Creates substitution rules `signHead[i] -> signs[[i]]` for the `Reduce` call |

---

### Function: `fastRoot`

**Location:** Lines 517-991 (includes helpers and main entry point)

**Options accepted:**
```wolfram
Options = {
    Jacobian        -> None,        (* derivative/Jacobian function *)
    Method          -> Automatic,   (* "Newton" | "Brent" | "Secant" | Automatic *)
    "SecantBlend"   -> 0.5,         (* blend factor for initial guess *)
    "Return"        -> "Value",     (* "Value" | "Rule" *)
    "FindRootOptions" -> Automatic  (* Automatic builds StepMonitor dynamically *)
}
```

Also accepts options from: `FindRoot`

**Options flow:**

| Option | Flow Path | Terminal Use |
|--------|-----------|--------------|
| `Jacobian` | `fastRoot` -> `fastRootCoreNew` | Used to create `dfnum` wrapper; passed to `tryNewton1D`/`tryNewtonND` via Jacobian option to `FindRoot` |
| `Method` | `fastRoot` -> `fastRootCoreNew` | Determines which method functions to include in `tryMethods` list (Newton, Brent, Secant) |
| `"SecantBlend"` | `fastRoot` -> `computeX0`/`computeX0Mixed` | Blend factor between midpoint and secant estimate for automatic x0 |
| `"Return"` | `fastRoot` -> `fastRootCoreNew` | Controls output format: "Value" returns numeric result, "Rule" returns rule list from FindRoot |
| `"FindRootOptions"` | `fastRoot` -> `fastRootCoreNew` -> `makeFindRootOptions` | If Automatic, generates StepMonitor for bounds clipping; otherwise passed through |
| `FindRoot` options | `FilterRules[{opts}, Options[FindRoot]]` -> `FindRoot` calls in `tryNewton1D`, `tryBrent1D`, `trySecant1D`, `tryDefaultFindRoot` | Terminal: used by `FindRoot` system function |

**Internal helper functions called:**
- `parseSpec` (lines 528-583): No options, parses spec format
- `computeX0` (lines 587-631): No explicit options, receives `blend` parameter from `"SecantBlend"`
- `computeX0Mixed` (lines 622-631): No explicit options, receives `blend` parameter
- `validateRoot` (lines 635-663): No options
- `tryNewton1D` (lines 669-679): Receives `findRootOpts` -> passed to `FindRoot`
- `tryNewtonND` (lines 682-695): Receives `findRootOpts` -> passed to `FindRoot`
- `tryBrent1D` (lines 698-703): Receives `findRootOpts` -> passed to `FindRoot`
- `trySecant1D` (lines 706-720): Receives `findRootOpts` and `blend` -> passed to `FindRoot`
- `tryOptimizationND` (lines 723-769): Receives `findRootOpts` -> extracts `AccuracyGoal`, passed to `FindMinimum`/`NMinimize`
- `tryDefaultFindRoot` (lines 772-785): Receives `findRootOpts` -> passed to `FindRoot`
- `tryMethods` (lines 788-800): No options
- `fastRootCoreNew` (lines 804-934): Main implementation, processes all options
- `makeFindRootOptions` (lines 995-1007): No OptionsPattern, creates FindRoot options from bounds

---

### Function: `scanAndSolve`

**Location:** Lines 1015-1179

**Options accepted:**
```wolfram
Options = {
    "BracketGrid" -> 32,
    "Tolerance" -> Automatic,
    "FastRootOptions" -> {},
    "FindRootOptions" -> ("FindRootOptions" /. Options[fastRoot])  (* inherits from fastRoot *)
}
```

Also accepts options from: `FindRoot`, `fastRoot`

**Options flow:**

| Option | Flow Path | Terminal Use |
|--------|-----------|--------------|
| `"BracketGrid"` | Used directly in `scanAndSolve` | Number of subdivisions for grid search (`Subdivide[a, b, bins]`) |
| `"Tolerance"` | Used directly in `scanAndSolve` | Threshold for detecting near-zero values on grid; if Automatic, computed from `AccuracyGoal` |
| `"FastRootOptions"` | Merged into `fastOpts` -> passed to `fastRoot` | Forwarded to `fastRoot` calls |
| `"FindRootOptions"` | Merged into `findRootOpts` AND passed via "FindRootOptions" key to `fastRoot` | Forwarded to `FindRoot` (via `fastRoot`) |
| `FindRoot` options | `FilterRules[{opts}, Options[FindRoot]]` merged into `findRootOpts` -> passed to `fastRoot` | Terminal via `fastRoot` -> `FindRoot` |
| `fastRoot` options | `FilterRules[{opts}, Options[fastRoot]]` merged into `fastOpts` -> passed to `fastRoot` | Terminal via `fastRoot` |

**Variant with derivative (lines 1024-1108):**
- Passes `Jacobian -> dfnum` to `fastRoot`
- Otherwise same option flow

**Variant without derivative (lines 1112-1179):**
- No Jacobian passed
- Otherwise same option flow

---

### Function: `extractIntervalsFromReduce`

**Location:** Lines 1282-1391

**Options accepted:**
```wolfram
Options = {
    "InteriorShrink" -> 0.001,
    "RootUpperBound" -> 15,
    "UnboundedPad" -> 1.*^5
}
```

**Options flow:**

| Option | Flow Path | Terminal Use |
|--------|-----------|--------------|
| `"InteriorShrink"` | Used directly in `extractIntervalsFromReduce` | Amount to shrink interval bounds inward to avoid boundary issues |
| `"RootUpperBound"` | Used directly in `extractIntervalsFromReduce` | Maximum upper bound for intervals (clips `hi` values) |
| `"UnboundedPad"` | Used directly in `extractIntervalsFromReduce` | Padding for extra dimensions when `Length[rootList] > 1` |

---

### Function: `buildEqMapFromModel`

**Location:** Lines 1399-1467

**Options accepted:** None

This is a pure data extraction function with no options.

---

### Function: `createCompiledEq`

**Location:** Lines 1476-1533

**Options accepted:** Inherits from `buildKernel`, `FunctionCompile`, `Compile`

**Options flow:**

| Option | Flow Path | Terminal Use |
|--------|-----------|--------------|
| `buildKernel` options | `FilterRules[{opts}, ...]` -> `buildKernelOpts` -> passed to `buildKernel` | See `buildKernel` options flow above |
| `"CompileMode"` | Extracted directly AND passed to `buildKernel` | Determines file suffix and storage key |
| `"Compiler"` | Extracted for hash AND passed to `buildKernel` | Part of cache hash computation |
| `"FlattenExpressions"` | Extracted for hash AND passed to `buildKernel` | Part of cache hash computation |
| `FunctionCompile` options | `FilterRules` -> passed to `buildKernel` | Terminal via `buildKernel` -> `FunctionCompile` |
| `Compile` options | `FilterRules` -> passed to `buildKernel` | Terminal via `buildKernel` -> `Compile` |

---

### Helper Functions (No Public Options Interface)

The following helper functions are internal and do not expose options:

- `normalizeExp` (lines 1190-1193): Expression normalization
- `flattenForCompileBody` (lines 1205-1263): Expression flattening for compilation
- `signIdxs` (lines 1271-1275): Sign index extraction

---

## File: Dependencies.wl

### Function: `initializeDependencies`

**Location:** Lines 29-32

**Options accepted:** None

**Internal flow:**
```
initializeDependencies[]
    -> installPacletizedResourceFunctions[]  (no options)
    -> installAndConfigureMaTeX[]            (no options)
```

This function coordinates dependency installation but takes no options.

---

### Function: `installPacletizedResourceFunctions`

**Location:** Lines 39-58

**Options accepted:** None

This function has hardcoded behavior with no configurable options.

---

### Function: `installAndConfigureMaTeX`

**Location:** Lines 65-127

**Options accepted:** None

This function has hardcoded paths and behavior with no configurable options. It does call:
- `MaTeX`ConfigureMaTeX[]` - but passes configuration values, not options

---

## Summary

### FindRootOptim.wl Options Summary

| Function | Own Options | Also Accepts From |
|----------|-------------|-------------------|
| `buildKernel` | 7 custom options | `FunctionCompile`, `Compile` |
| `bindUnary` | 1 custom option | - |
| `findRootInterval` | 3 custom options | - |
| `fastRoot` | 5 custom options | `FindRoot` |
| `scanAndSolve` | 4 custom options | `FindRoot`, `fastRoot` |
| `extractIntervalsFromReduce` | 3 custom options | - |
| `buildEqMapFromModel` | None | - |
| `createCompiledEq` | None (inherits) | `buildKernel`, `FunctionCompile`, `Compile` |

### Dependencies.wl Options Summary

| Function | Own Options | Also Accepts From |
|----------|-------------|-------------------|
| `initializeDependencies` | None | - |
| `installPacletizedResourceFunctions` | None | - |
| `installAndConfigureMaTeX` | None | - |

**Dependencies.wl has no options-related code.** All functions have hardcoded behavior.

---

## Options Inheritance Diagram

```
createCompiledEq
    |
    v
buildKernel  <-- FunctionCompile options
    |            Compile options
    v
[Compile / FunctionCompile] (terminal)

scanAndSolve  <-- FindRoot options
    |              fastRoot options
    v
fastRoot  <-- FindRoot options
    |
    +---> tryNewton1D/tryNewtonND ---> FindRoot (terminal)
    +---> tryBrent1D ---------------> FindRoot (terminal)
    +---> trySecant1D --------------> FindRoot (terminal)
    +---> tryOptimizationND --------> FindMinimum/NMinimize (terminal)
    +---> tryDefaultFindRoot -------> FindRoot (terminal)
```
````

</details>

<details>
<summary><code>options-backward/tools-number-plots-reexport.md</code></summary>

````markdown
# Options Flow: ToNumber.wl, NicePlots.wl, ReExport.wl

This document traces how options flow through functions in these three tool files.

---

## File: ToNumber.wl

**Location**: `/Kernel/Tools/ToNumber.wl`

### Function: `toNumRules`

This is the core internal function that handles options.

- **Options accepted**: `OptionsPattern[{updateCoeffs}]`
  - Inherits all options from `updateCoeffs` (defined in `SolveEulerEq.wl`)

- **Options flow**:
  ```
  opts : OptionsPattern[{updateCoeffs}]
    |
    +-> FilterRules[Flatten@{opts}, Flatten[Options/@{updateCoeffs}]]
    |     |
    |     +-> optsUpdateCoeffs (local variable)
    |           |
    |           +-> updateCoeffs[model, kernels, allParams, guessCoeffsSolution,
    |                            "UpdatePd"->True, "UpdateBond"->True, optsUpdateCoeffs]
    |                 |
    |                 +-> (SolveEulerEq.wl) updateCoeffs -> updateCoeffsSol
    |                       |
    |                       +-> Options forwarded to FindRoot, RecurrenceTable, checks
    |                             |
    |                             +-> Terminal uses in Wolfram built-in functions
  ```

- **Terminal destinations**:
  - `updateCoeffs` options -> `updateCoeffsSol` -> various internal functions:
    - `"initialGuess"` -> used directly in `updateCoeffsSol` to set initial FindRoot values
    - `"FindRootOptions"` -> forwarded to `FindRoot` (built-in, terminal)
    - `"RecurrenceTableOptions"` -> forwarded to `RecurrenceTable` (built-in, terminal)
    - `"UpdatePd"`, `"UpdateBond"`, `"UpdateNomBond"`, `"UpdateBonds"` -> used directly in `updateCoeffsSol` to control computation
    - `"MaxMaturity"` -> used directly to control bond recursion depth
    - `"RootSigns"` -> used directly to control sign selection in quadratic solutions
    - `"PrintResidualsNorm"`, `"CheckResiduals"`, `"Tol"` -> used directly in `checks` function

### Function: `toNum` (public wrappers)

Multiple overloads exist but none use OptionsPattern directly. They call `toNumRules` internally.

- **Options accepted**: None directly - these are wrapper functions
- **Options flow**: Delegated to `toNumRules` via `rest__` arguments

### Functions without options

The following functions in ToNumber.wl do NOT use options:
- `toEquation` - No OptionsPattern
- `toExogenousVars` - No OptionsPattern
- `toStateVars` - No OptionsPattern
- `processNewParameters` - No OptionsPattern
- `GlobalProperties` - No OptionsPattern
- `clone` - No OptionsPattern
- `withUserDefs` - No OptionsPattern
- `moms` - No OptionsPattern
- `modelEval` - No OptionsPattern

---

## File: NicePlots.wl

**Location**: `/Kernel/Tools/NicePlots.wl`

### Function: `yieldCurve`

- **Options accepted**: `OptionsPattern[{yieldCurve, updateCoeffs, FindRoot, RecurrenceTable}]`
  - Own options defined: `"MaxMaturity" -> 12`, `"MomentFunction" -> uncondE`
  - Inherits from: `updateCoeffs`, `FindRoot`, `RecurrenceTable`

- **Options flow**:
  ```
  opts : OptionsPattern[{yieldCurve, updateCoeffs, FindRoot, RecurrenceTable}]
    |
    +-> OptionValue[yieldCurve, "MaxMaturity"]
    |     +-> Used directly: controls loop iterations (Table[..., {mm, maxMaturity}])
    |
    +-> OptionValue[yieldCurve, "MomentFunction"]
    |     +-> Used directly: selects moment function (uncondE by default)
    |
    +-> FilterRules[Flatten@{opts}, Join[Options[updateCoeffs], Options[FindRoot], Options[RecurrenceTable]]]
    |     +-> updateOpts
    |           +-> updateCoeffs[model, newParams, {}, Sequence @@ updateOpts]
    |                 +-> (SolveEulerEq.wl) -> updateCoeffsSol
    |                       +-> FindRoot, RecurrenceTable (built-in, terminal)
    |
    +-> FilterRules[Flatten@{opts}, Options[RecurrenceTable]]
          +-> recurrenceOpts
                +-> updateCoeffsBond[..., Sequence @@ recurrenceOpts]
                      +-> RecurrenceTable (built-in, terminal)
  ```

- **Terminal destinations**:
  - `"MaxMaturity"` -> used directly in `yieldCurve` for Table iteration and passed to `updateCoeffsBond`
  - `"MomentFunction"` -> used directly in `yieldCurve` to select moment computation function
  - All `updateCoeffs` options -> forwarded to `updateCoeffs` (see ToNumber.wl documentation above)
  - All `FindRoot` options -> forwarded to `FindRoot` (built-in, terminal)
  - All `RecurrenceTable` options -> forwarded to `RecurrenceTable` (built-in, terminal)

### Function: `plotCoeffs`

- **Options accepted**: `opts: OptionsPattern[]` (bare OptionsPattern with no specification)
  - Accepts any options

- **Options flow**:
  ```
  opts : OptionsPattern[]
    |
    +-> Flatten @ {opts}
          +-> ResourceFunction["FindRootPlot"][Last@eq0, ic0, Flatten @ {opts}]
                +-> (ResourceFunction, external)
                      +-> Terminal: passed to FindRootPlot resource function
  ```

- **Terminal destinations**:
  - All options -> forwarded to `ResourceFunction["FindRootPlot"]` (external resource function, terminal)
  - This resource function likely forwards relevant options to `FindRoot` internally

---

## File: ReExport.wl

**Location**: `/Kernel/Tools/ReExport.wl`

### Summary

**This file contains NO options-related code.**

### Function: `reExport[f_Symbol, g_Symbol]`

- **Options accepted**: None
- **Options flow**: N/A - no options used
- **Description**: Copies definitions from symbol `f` to symbol `g` using `copyDefinitions`

### Function: `reExport[oldContext_String, Optional[newContext_String, ...]]`

- **Options accepted**: None
- **Options flow**: N/A - no options used
- **Description**: Exports all public symbols from one context to another with capitalized names

---

## Summary Table

| File | Function | Has Options | Options Inherited From | Terminal Destinations |
|------|----------|-------------|----------------------|----------------------|
| ToNumber.wl | `toNumRules` | Yes | `updateCoeffs` | `FindRoot`, `RecurrenceTable`, `checks` (internal) |
| ToNumber.wl | `toNum` | No (delegates) | - | Via `toNumRules` |
| ToNumber.wl | Other functions | No | - | - |
| NicePlots.wl | `yieldCurve` | Yes | `yieldCurve`, `updateCoeffs`, `FindRoot`, `RecurrenceTable` | `FindRoot`, `RecurrenceTable`, `updateCoeffsBond` |
| NicePlots.wl | `plotCoeffs` | Yes | (bare OptionsPattern) | `ResourceFunction["FindRootPlot"]` |
| ReExport.wl | `reExport` | No | - | - |

---

## Option Inheritance Chain

```
yieldCurve / toNumRules
    |
    +-> updateCoeffs (SolveEulerEq.wl)
          |
          +-> updateCoeffsSol
          |     +-> "initialGuess" (used directly)
          |     +-> "FindRootOptions" -> FindRoot (built-in)
          |     +-> "RecurrenceTableOptions" -> RecurrenceTable (built-in)
          |     +-> "UpdatePd", "UpdateBond", etc. (used directly)
          |     +-> "MaxMaturity" (used directly)
          |     +-> "RootSigns" (used directly)
          |
          +-> checks
                +-> "PrintResidualsNorm" (used directly)
                +-> "CheckResiduals" (used directly)
                +-> "Tol" (used directly)
```

---

## Cross-File Dependencies

| From File | Function | Calls | In File |
|-----------|----------|-------|---------|
| ToNumber.wl | `toNumRules` | `updateCoeffs` | SolveEulerEq.wl |
| NicePlots.wl | `yieldCurve` | `updateCoeffs` | SolveEulerEq.wl |
| NicePlots.wl | `yieldCurve` | `updateCoeffsBond` | SolveEulerEq.wl |
| NicePlots.wl | `yieldCurve` | `processNewParameters` | ToNumber.wl |
| NicePlots.wl | `plotCoeffs` | `processNewParameters` | ToNumber.wl |
| ReExport.wl | `reExport` | `copyDefinitions` | CopyDefinitions.wl |
| ReExport.wl | `reExport` | `compoundScope` | CompoundScope.wl |
````

</details>

<details>
<summary><code>options-backward/tools-options-resources-pipeline.md</code></summary>

````markdown
# Options Flow: OptionsConfig.wl, ManageResources.wl, PipelineMonitor.wl

This document traces how options flow through the three Tools files and into the broader codebase.

---

## File: OptionsConfig.wl

This file is the **central options configuration system**. It defines the nested config structure and provides utilities for normalizing legacy options and extracting subsystem-specific options.

### Function: defaultConfig

- **Options accepted**: None (returns default configuration)
- **Options flow**: Terminal function - creates the default nested configuration Association with all subsystems (Symbolic, Compile, Numerical, Moments, Parallel, Build)

### Function: normalizeConfig

- **Options accepted**:
  - Already-normalized config Association
  - Legacy flat options list
  - Single rules or sequence of rules
- **Options flow**:
  - If config is already normalized -> merges with `defaultConfig[]` using `mergeNested`
  - If legacy flat options -> translates via `legacyOptionMap` to nested paths, returns merged config
  - Terminal function - produces normalized config for downstream use

### Function: splitConfig

- **Options accepted**:
  - `config` (normalized Association)
  - `subsystem` ("Symbolic", "Compile", "Numerical", "Moments", "Parallel", "Build")
- **Options flow**:
  - Extracts subsystem-specific options as a Sequence of Rules
  - **splitConfig[config, "Symbolic"]** -> Returns: PdEquations, SimplifyOptions, paramQuadSolveOptions
    - Passed to `processModels` (ProcessModels.wl)
  - **splitConfig[config, "Compile"]** -> Returns: CoeffName, SignSymbol, PerformanceGoal, CompileMode, Compiler, RuntimeOptions, CompilationTarget
    - Passed to `createCompiledEq` (FindRootOptim.wl)
  - **splitConfig[config, "Numerical"]** -> Returns: initialGuess, FindRootOptions, RecurrenceTableOptions, MaxMaturity, RootSigns, Signs, UpdatePd, UpdateBond, UpdateNomBond, UpdateBonds, ReduceTimeLimit
    - Extracted but NOT currently used in buildModels pipeline (numerical phase uses default parameters)
  - **splitConfig[config, "Moments"]** -> Returns: maxMomentsLagsToCreate, startSequenceAtLag, simplifyDownValues, IterationLimit
    - Passed to `createDatabase` (CreateMomentsDatabase.wl)
  - **splitConfig[config, "Parallel"]** -> Returns: NumKernels
    - Extracted but config["Parallel"]["NumKernels"] accessed directly
  - **splitConfig[config, "Build"]** -> Returns: Models, FromScratch, CompileJacobians, CreateMoments, MaxMaturity, FileSuffix, UpdateManifest
    - Used directly by buildModelsInternal (values extracted from config)

### Function: validateConfig

- **Options accepted**: config (Association)
- **Options flow**: Terminal function - validates config structure, returns True/False

### Function: isNormalized

- **Options accepted**: config (any)
- **Options flow**: Terminal function - checks if config has required subsystem keys

### Function: generateMigrationReport

- **Options accepted**: None
- **Options flow**: Terminal function - returns report of deprecated options used during session

---

## File: ManageResources.wl

This file orchestrates the model building pipeline, using OptionsConfig for configuration management.

### Function: buildModels

- **Options accepted** (declared):
  - `"FromScratch"` -> False
  - `"CompileJacobians"` -> False
  - `"CreateMoments"` -> True
  - `"NumKernels"` -> Automatic
  - `"MaxMaturity"` -> 120
  - `"Models"` -> All
  - `"PdEquations"` -> "B"
  - `"FileSuffix"` -> ""
  - `"UpdateManifest"` -> True
- **Options flow**:
  - **Pattern 1**: `buildModels[config_Association]` -> normalizes via `normalizeConfig[config]` -> calls `buildModelsInternal`
  - **Pattern 2**: `buildModels[opts___?OptionQ]` -> normalizes via `normalizeConfig[{opts}]` -> calls `buildModelsInternal`

### Function: buildModelsInternal

- **Options accepted**: Normalized config Association (from buildModels)
- **Options flow**:
  - Extracts Build options directly from config: `config["Build"]["FromScratch"]`, `config["Build"]["CompileJacobians"]`, etc.
  - Extracts Parallel options: `config["Parallel"]["NumKernels"]`
  - Extracts Compile options for validation: `config["Compile"]["CompileMode"]`, `config["Compile"]["Compiler"]`

  - **Phase 1 (Symbolic)**:
    - `splitConfig[config, "Symbolic"]` -> passed to `processModels` (ProcessModels.wl)
      - PdEquations -> `solveCoeffsSystem` -> controls which pd equations to compute
      - SimplifyOptions -> `solveCoeffsSystem`, `simplifyCoeffsSystem` -> forwarded to `Simplify`
      - paramQuadSolveOptions -> `paramQuadSolve` (ParamQuadSolve.wl)

  - **Phase 2 (Compile)**:
    - `splitConfig[config, "Compile"]` -> passed to `createCompiledEq` (FindRootOptim.wl)
      - CoeffName -> `buildKernel` -> used for coefficient symbol detection
      - SignSymbol -> `buildKernel` -> used for sign symbol detection
      - PerformanceGoal -> `buildKernel` -> controls optimization level
      - CompileMode -> `buildKernel` -> "FunctionOnly" | "JacobianOnly" | "Both"
      - Compiler -> `buildKernel` -> "Compile" | "FunctionCompile"
      - RuntimeOptions -> `Compile` (Wolfram builtin)
      - CompilationTarget -> `Compile` (Wolfram builtin)

  - **Phase 3 (Numerical)**:
    - Options NOT passed via splitConfig - uses model defaults
    - `addCoeffsSolutionN` called without explicit options (uses defaults from SolveEulerEq.wl)

  - **Phase 4 (Moments)**:
    - `splitConfig[config, "Moments"]` -> passed to `createDatabase` (CreateMomentsDatabase.wl)
      - maxMomentsLagsToCreate -> used directly in moment computation loops
      - startSequenceAtLag -> controls sequence start for moment database
      - simplifyDownValues -> controls whether to simplify computed moments
      - IterationLimit -> forwarded to `uncondCovLongExo` -> used in `Block[{$IterationLimit=...}]`

### Function: buildModelsParallel

- **Options accepted** (declared):
  - `"CreateMoments"` -> True
  - `"NumKernels"` -> Automatic
  - `"FromScratch"` -> False
  - `"PdEquations"` -> "B"
  - Also accepts `buildModels` options via OptionsPattern
- **Options flow**:
  - Filters out options it force-sets: `FileSuffix`, `UpdateManifest`, `CreateMoments`, `FromScratch`, `Models`
  - Remaining options passed to parallel `buildModels` calls
  - Each parallel call uses `"FileSuffix" -> "_" <> modelName` for checkpointing
  - After parallel phase, merges results and optionally runs moments sequentially

### Function: determineModelStatus

- **Options accepted**: compileMode, compilerChoice (passed as arguments, not OptionsPattern)
- **Options flow**:
  - `compileMode`, `compilerChoice` -> passed to `validateCompiledFile` for hash validation
  - Used to determine if models need recompilation

### Function: validateCompiledFile

- **Options accepted**: compileMode (default "FunctionOnly"), compilerChoice (default "Compile"), flattenOpt (default Automatic)
- **Options flow**: Terminal function - validates .mx file against expected hash computed from model and options

### Function: getModelPipelineStatus

- **Options accepted**: None (uses normalizeConfig[{}] internally)
- **Options flow**:
  - Creates default config via `normalizeConfig[{}]`
  - Extracts `config["Compile"]["CompileMode"]` and `config["Compile"]["Compiler"]`
  - Passes to `determineModelStatus` for each model

### Function: checkCatalogChanges

- **Options accepted**: None (or modelsAssoc)
- **Options flow**: Terminal function - no options-related code, computes hashes and validates models

### Function: checkCatalogForUI

- **Options accepted**: None
- **Options flow**: Terminal function - similar to checkCatalogChanges but for UI layer

### Function: updateModelManifest

- **Options accepted**: None (or modelsAssoc)
- **Options flow**: Terminal function - no options-related code

### Function: reformatCatalog

- **Options accepted**: None
- **Options flow**: Terminal function - no options-related code

---

## File: PipelineMonitor.wl

This file provides the user-facing pipeline monitoring UI. It has minimal options handling.

### Function: checkModels

- **Options accepted** (declared):
  - `"AutoBuild"` -> Automatic
- **Options flow**:
  - `"AutoBuild"` -> `resolveAutoBuild` -> determines if auto-build is enabled
    - Checks: Explicit True/False, `LONGRUNRISK_AUTOBUILD` env var, `CI` env var
  - When building, calls `buildModels["Models" -> modelsToBuild]` with no other options
  - Terminal for options - no options forwarded to inner functions

### Function: resolveAutoBuild

- **Options accepted**: opt (the AutoBuild option value)
- **Options flow**: Terminal function - returns True/False based on option value and environment

### Function: loadConfig

- **Options accepted**: None
- **Options flow**: Terminal function - loads user config from file

### Function: showPipelineReport

- **Options accepted**: changes, status, modelsToBuild, autoBuild (passed as arguments)
- **Options flow**:
  - When building, calls `buildModels["Models" -> modelsToBuild]`
  - No additional options forwarded

### Function: showValidationErrors

- **Options accepted**: validation (Association)
- **Options flow**: Terminal function - displays errors, no options

### Function: statusIcon, formatStatusGrid, formatChangeSummary

- **Options accepted**: None
- **Options flow**: Terminal functions - UI formatting only

---

## Complete Options Flow Diagram

```
User calls buildModels[opts...]
    |
    v
normalizeConfig[{opts}] -- merges with defaultConfig[]
    |
    v
buildModelsInternal[config]
    |
    +-- Phase 1: processModels[..., splitConfig[config, "Symbolic"]]
    |       |
    |       +-- PdEquations -> solveCoeffsSystem -> controls which equations
    |       +-- SimplifyOptions -> Simplify (Wolfram builtin)
    |       +-- paramQuadSolveOptions -> paramQuadSolve
    |       +-- addCoeffsSolution uses RecurrenceTableOptions -> RecurrenceTable
    |
    +-- Phase 2: createCompiledEq[..., splitConfig[config, "Compile"]]
    |       |
    |       +-- buildKernel receives all Compile options
    |       +-- Compiler options -> Compile/FunctionCompile (Wolfram builtins)
    |
    +-- Phase 3: addCoeffsSolutionN[model] (NO options passed)
    |       |
    |       +-- Uses defaults from SolveEulerEq.wl
    |       +-- updateCoeffsSol -> FindRoot, RecurrenceTable
    |
    +-- Phase 4: createDatabase[..., splitConfig[config, "Moments"]]
            |
            +-- maxMomentsLagsToCreate -> loop control
            +-- startSequenceAtLag -> sequence start
            +-- simplifyDownValues -> controls simplification
            +-- IterationLimit -> uncondCovLongExo -> Block[$IterationLimit]
```

---

## Notes on Options Gaps

1. **Numerical Phase Gap**: `splitConfig[config, "Numerical"]` exists but is NOT used in `buildModelsInternal`. The numerical phase uses model defaults.

2. **Parallel Phase Gap**: `splitConfig[config, "Parallel"]` exists but `NumKernels` is accessed directly from `config["Parallel"]["NumKernels"]`.

3. **checkModels Simplification**: `checkModels` only passes `"Models"` to `buildModels`, not forwarding other options the user might want to customize.
````

</details>

<details>
<summary><code>options-backward/tools-time-copy-compound.md</code></summary>

````markdown
# Options Flow: TimeAggregation.wl, CopyDefinitions.wl, CompoundScope.wl

## File: TimeAggregation.wl

This file implements time aggregation utilities for computing growth rates of variables over multiple time periods. It contains multiple functions with options.

### Function: `growth`

- **Options accepted**:
  - `"v0"` (default: `Function[{t,j,h,k,v,im},0]`) - function to compute the point around which the power series expansion is performed
  - `"Order"` (default: `1`) - use a power series expansion of this order to compute approximation
  - Also accepts options from `timeSeriesVector` and `g` via `OptionsPattern[{growth,timeSeriesVector,g}]`

- **Options flow**:
  - `"v0"` -> used directly in `growth` to construct `v0args` function for power series expansion point calculation
  - `"Order"` -> used directly in `growth` to control the order of the power series expansion (`O[d]^(n + 1)`)
  - `"TimeAggregation"` -> read via `OptionValue` in `growth`, then passed to `gt` via `optsgt` (filtered to exclude `growth` options)
  - `"numPeriods"` -> read via `OptionValue` in `growth`, then passed to `gt` via `optsgt` (for "Ratio" type, overridden to `1`)
  - `"Variable"` -> read via `OptionValue` in `growth` to determine type ("Flow", "Stock", or "Ratio"), also passed to `gt` via `optsgt`
  - Options flow from `growth` to `gt`:
    - `optsgt = FilterRules[{opts}, Except[Options[growth]]]` (excludes `"v0"` and `"Order"`)
    - `gt[v, t, im, optsgt]` receives filtered options

- **Complete option trace**:
  ```
  growth (accepts options from growth, timeSeriesVector, g)
    |
    +-- "v0" -> TERMINAL: used to compute expansion point in growth
    +-- "Order" -> TERMINAL: used for power series order in growth
    +-- "TimeAggregation" -> passed to gt -> timeSeriesVector -> TERMINAL: controls h parameter
    +-- "numPeriods" -> passed to gt -> timeSeriesVector -> TERMINAL: controls k parameter
    +-- "Variable" -> passed to gt -> g -> TERMINAL: determines variable type handling
  ```

### Function: `g`

- **Options accepted**:
  - `"Variable"` (default: `"Flow"`) - specify if variable is a flow variable, stock variable, or ratio of stock and flow

- **Options flow**:
  - `"Variable"` -> TERMINAL: used directly in `g` via `OptionValue["Variable"]` to determine which calculation to perform:
    - `"Flow"`: computes `s[x1]+f[x2]-f[x3]`
    - `"Stock"`: computes `s[x]` (or recursively calls `g` with truncated input)
    - `"Ratio"`: computes `-f[x2]`
  - When `Length[x]==k*h` and `"Variable"==="Stock"`, returns `s[x]`
  - When `Length[x]==(1+k)*h-1`, uses Switch on type to select computation

### Function: `timeSeriesVector`

- **Options accepted**:
  - `"TimeAggregation"` (default: `1`) - time-aggregate over `h` months
  - `"numPeriods"` (default: `1`) - compute growth rates over `numPeriods` time-aggregated periods

- **Options flow**:
  - `"TimeAggregation"` -> TERMINAL: used directly to compute `h` which determines the time window
  - `"numPeriods"` -> TERMINAL: used directly to compute `k` and subsequently `lastPeriod = (1+k)*h-2` for generating the Table

### Function: `gt`

- **Options accepted**: Options from `timeSeriesVector` and `g` via `OptionsPattern[{timeSeriesVector,g}]`

- **Options flow**:
  - Reads `"TimeAggregation"` and `"numPeriods"` for `h` and `k` parameters
  - `optsTs = FilterRules[{opts}, Options[timeSeriesVector]]` -> passed to `timeSeriesVector`
  - `optsg = FilterRules[{opts}, Options[g]]` -> passed to `g`
  - Calls `g[timeSeriesVector[variable,t,im,optsTs], h, k, optsg]`

- **Complete option trace**:
  ```
  gt (accepts options from timeSeriesVector, g)
    |
    +-- "TimeAggregation" -> read locally AND passed to timeSeriesVector -> TERMINAL
    +-- "numPeriods" -> read locally AND passed to timeSeriesVector -> TERMINAL
    +-- "Variable" -> passed to g -> TERMINAL
  ```

### Function: `f`

- **Options accepted**: None
- This is a helper function that computes a logarithmic sum formula

### Function: `s`

- **Options accepted**: None
- This is a helper function that computes a simple sum (`Plus@@x`)

---

## File: CopyDefinitions.wl

This file provides utilities for copying symbol definitions between symbols or contexts.

### Function: `copyDefinitions`

- **Options accepted**: None
- **Options flow**: N/A

This function uses `SetAttributes[copyDefinitions, HoldAllComplete]` to control evaluation but does not use Wolfram's options pattern. The function operates purely on its positional arguments.

### Function: `symbolQ`

- **Options accepted**: None
- **Options flow**: N/A

This is a helper predicate function with `HoldAllComplete` attribute that checks if an argument is a symbol.

---

## File: CompoundScope.wl

This file implements a compound scoping construct that allows sequential variable assignments where each value can depend on previous values.

### Function: `compoundScope`

- **Options accepted**: None
- **Options flow**: N/A

This function uses `SetAttributes[compoundScope, HoldAll]` to control evaluation but does not use Wolfram's options pattern. It accepts:
- An optional scoping construct (`With`, `Block`, or `Module`, defaulting to `With`)
- A list of assignments or a `CompoundExpression`
- An expression to evaluate

The function processes assignments recursively, wrapping each in the specified scoping construct.

---

## Summary

| File | Functions with Options | Functions without Options |
|------|----------------------|--------------------------|
| TimeAggregation.wl | `growth`, `g`, `timeSeriesVector`, `gt` | `f`, `s` |
| CopyDefinitions.wl | None | `copyDefinitions`, `symbolQ` |
| CompoundScope.wl | None | `compoundScope` |

### Option Dependency Graph for TimeAggregation.wl

```
growth
  |
  +-- owns: "v0", "Order"
  +-- forwards to gt: "TimeAggregation", "numPeriods", "Variable"
        |
        +-- gt
              |
              +-- reads: "TimeAggregation", "numPeriods"
              +-- forwards to timeSeriesVector: "TimeAggregation", "numPeriods"
              |     |
              |     +-- timeSeriesVector (TERMINAL)
              |           uses: "TimeAggregation", "numPeriods"
              |
              +-- forwards to g: "Variable"
                    |
                    +-- g (TERMINAL)
                          uses: "Variable"
```

### Key Observations

- **TimeAggregation.wl** has a well-structured option forwarding pattern where `growth` is the main entry point that accepts all options and forwards appropriate subsets to inner functions using `FilterRules`.

- **CopyDefinitions.wl** and **CompoundScope.wl** do not use the Wolfram Language options pattern (`OptionsPattern[]`, `OptionValue`, etc.). They rely solely on positional arguments and pattern matching.

- All option chains in TimeAggregation.wl terminate within the same file - there are no options passed to functions defined in other files.
````

</details>

<details>
<summary><code>options-backward/tools-visualize-validate-output.md</code></summary>

````markdown
# Options Flow: VisualizeCoeffs.wl, ValidateModels.wl, NiceOutput.wl

This document traces how options flow through functions in the Tools subsystem of the LongRunRisk package.

---

## File: VisualizeCoeffs.wl

**Location**: `/Kernel/Tools/VisualizeCoeffs.wl`

### Function: `visualizeCoeffs`

**Signature**: `visualizeCoeffs[results_List, opts : OptionsPattern[]]`

- **Options accepted**:
  - `"ShowSelector"` (default: `True`) - Controls whether the interactive coefficient selector panel is displayed
  - `"ShowDetails"` (default: `True`) - Controls whether collapsible bundle details are shown

- **Options flow**:
  - `"ShowSelector"` -> used directly in `visualizeCoeffs` via `OptionValue["ShowSelector"]` to conditionally call `coeffSelector[bundles, numStocks]` (line 786)
  - `"ShowDetails"` -> used directly in `visualizeCoeffs` via `OptionValue["ShowDetails"]` to conditionally call `bundleDetails[results]` (line 794)

- **Terminal use**: Both options are consumed directly by `visualizeCoeffs` to control UI element visibility. They are not passed to any inner functions.

### Other Functions (No Options)

The following helper functions in this file do **not** use options:

- `formatValue[val_]` - Formats numeric values to 2 decimal places
- `formatCoeffName[coeff_]` - Formats coefficient names without context
- `extractBundles[results_List]` - Extracts bundles using `flattenCoeffsBundles`
- `getCoeffValue[bundle_List, ...]` - Gets coefficient value from a bundle
- `getNumStocks[results_List]` - Counts number of stocks from results
- `getMaxAIndex[bundle_List]` - Gets max coefficient index for A
- `getMaxBIndex[bundle_List, jVal_Integer]` - Gets max coefficient index for B
- `getMaxRIndex[bundle_List]` - Gets max bond maturity from bundle
- `getBondYields[bundle_List]` - Extracts bond yields from bundle
- `getMaxPIndex[bundle_List]` - Gets max nominal bond maturity
- `getNomBondYields[bundle_List]` - Extracts nominal bond yields
- `inlineBar[val_, minVal_, maxVal_, color_]` - Creates inline bar indicator
- `keyCoeffsGrid[bundles_List, numStocks_Integer]` - Creates key coefficients grid
- `formatSolutionIndices[indices_List]` - Formats solution indices compactly
- `coeffChart[bundles_List, coeff_, chartColor_]` - Builds chart for a single coefficient
- `bondYieldChart[bundles_List]` - Creates bond yield curve chart
- `nomBondYieldChart[bundles_List]` - Creates nominal bond yield curve chart
- `panelDivider[]` - Creates horizontal divider for panel sections
- `coeffSelector[bundles_List, numStocks_Integer]` - Creates coefficient selector UI
- `bundleDetails[results_List]` - Creates bundle details section
- `formatBundleDetail[bundle_List, results_List, bundleIdx_Integer]` - Formats bundle detail
- `bColor[j_Integer]` - Returns color for stock index

---

## File: ValidateModels.wl

**Location**: `/Kernel/Tools/ValidateModels.wl`

### Options Analysis

**This file contains NO options-related code.**

None of the functions in this file use `OptionsPattern[]`, `OptionValue`, `FilterRules`, or define `Options[...]`.

### Public Functions

- `validateModel[model_Association]` - Validates a single model Association against the schema
- `validateCatalog[catalog_Association]` - Validates all models in a catalog Association

### Private Helper Functions

All helper functions are purely functional without options:

- `getExpectedIndexedParamNames[]` - Gets expected indexed parameter names
- `getParamAssumptions[]` - Gets parameter assumptions as a list of conditions
- `getAssumptionParamName[cond_]` - Extracts parameter name from an assumption
- `getAllowedStateVarSymbols[]` - Gets allowed symbol names in state variables
- `extractStateVarSymbols[expr_]` - Extracts all symbol names from state variable expression
- `containsTimeDependency[expr_]` - Checks if expression contains t-dependency
- `numericValueQ[val_]` - Checks if a value is numeric or evaluates to numeric
- `validParamNameQ[name_]` - Checks if parameter name is valid
- `stripParamIndex[sym_]` - Strips index from parameter name
- `getExpectedParamNames[]` - Gets canonical parameter names from `$parameters`
- `validateStructure[model_, modelName_]` - Validates structure against schema
- `validateStateVars[stateVars_, modelName_]` - Validates stateVars list
- `validateParameters[params_, modelName_]` - Validates parameters list
- `issueMessage[error_Association]` - Issues appropriate message for error type

---

## File: NiceOutput.wl

**Location**: `/Kernel/Tools/NiceOutput.wl`

### Function: `numberFormattingTemplate`

**Signature**: `numberFormattingTemplate[num_, opts:OptionsPattern[]]`

- **Options accepted**: Any options compatible with `ToString` (inherited via `OptionsPattern[]` without explicit `Options[numberFormattingTemplate]` definition)

- **Options flow**:
  - All options -> `FilterRules[{opts}, Options[ToString]]` -> passed to `ToString[N@num, InputForm, ..., NumberMarks->False]`

- **Terminal use**: `ToString` (Wolfram Language built-in) - Options are filtered to those valid for `ToString` and passed directly. This is the terminal destination.

- **Note**: This function uses the implicit `OptionsPattern[]` pattern without defining its own `Options[numberFormattingTemplate]`. This means it can accept any options, but only those compatible with `ToString` will have any effect due to `FilterRules`.

### Public Functions (No Options)

- `info[m_Association]` - Displays a table with information for each model
- `formatModels[m_Association]` - Re-writes an association of models as a Cell object
- `toCatalog[m_Association, keysToKeep_List]` - Re-writes an association of models with selected keys

### Private Helper Functions (No Options)

- `createEqTables[m_]` - Adds nicely formatted tables with exogenous equations to each model
- `infoTable[m_]` - Creates OpenerView with model information
- `paramTable[m_]` - Creates table of parameters in a model
- `allParamTable[m_]` - Creates table of all parameters
- `iToNum[s_String]` - Replaces `i` placeholder with integers
- `iToNum[s_String, numStocks_Integer]` - Table version of iToNum
- `modelFormattingTemplate[model_Association, ...]` - Creates Cell object with nice formatting
- `stringFormattingTemplate[str_String, lineLength_Number]` - Formats strings with line breaks
- `normalizeWhitespace[str_String]` - Normalizes whitespace before formatting
- `stripContext[x_]` - Strips context from symbols
- `separator[lineLength_Number]` - Creates separator RowBox

### Associations (No Options)

- `modelToTeX` - Association between Mathematica variables and LaTeX representation
- `TeXToModel` - Reverse of modelToTeX
- `modelToTeXStocks` - Stock-specific parameters mapping
- `modelToTeXNoStocks` - Non-stock parameters mapping

---

## Summary

| File | Functions with Options | Options Pattern |
|------|------------------------|-----------------|
| VisualizeCoeffs.wl | 1 (`visualizeCoeffs`) | Custom options: `"ShowSelector"`, `"ShowDetails"` |
| ValidateModels.wl | 0 | N/A |
| NiceOutput.wl | 1 (`numberFormattingTemplate`) | Implicit (passes to `ToString`) |

### Option Flow Diagrams

#### VisualizeCoeffs.wl
```
visualizeCoeffs
    |
    +-- "ShowSelector" --> [TERMINAL] controls coeffSelector[] call
    |
    +-- "ShowDetails" --> [TERMINAL] controls bundleDetails[] call
```

#### NiceOutput.wl
```
numberFormattingTemplate
    |
    +-- opts --> FilterRules[{opts}, Options[ToString]]
                     |
                     +-- ToString (Wolfram built-in) [TERMINAL]
```
````

</details>

---

