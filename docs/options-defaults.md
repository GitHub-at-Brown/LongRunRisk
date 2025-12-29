# Option Defaults and Inheritance

Package-defined options, their defaults, and where they flow. Built-ins (`FindRoot`, `RecurrenceTable`, `FunctionCompile`, `Compile`, `Simplify`) keep their Mathematica defaults unless noted.

## Centralized Configuration System

The package uses a centralized configuration system defined in `Kernel/Tools/OptionsConfig.wl`. This provides:

- **Normalized config**: All options are organized into subsystem sections
- **Legacy support**: Flat options are automatically mapped to the correct subsystem
- **Structure checks**: `normalizeConfig` merges user config with `defaultConfig[]`; `validateConfig` exists for explicit checks but is not currently called by `buildModels`

### Config Subsystems

```wolfram
config = <|
  "Symbolic"  -> <|...|>,  (* Model processing options *)
  "Compile"   -> <|...|>,  (* Compilation options *)
  "Numerical" -> <|...|>,  (* Numerical solving options *)
  "Moments"   -> <|...|>,  (* Moments database options *)
  "Parallel"  -> <|...|>,  (* Parallel kernel options *)
  "Build"     -> <|...|>   (* Build pipeline options *)
|>
```

### Using the Config System

```wolfram
(* New-style: pass normalized config *)
buildModels[<|"Build" -> <|"Models" -> {"BY"}|>, "Compile" -> <|"CompileMode" -> "Both"|>|>]

(* Legacy: flat options are auto-normalized *)
buildModels["Models" -> {"BY"}, "CompileMode" -> "Both"]
```

---

## Symbolic Subsystem (`config["Symbolic"]`)

Options for model processing, symbolic solving, and simplification.

| Option | Default | Description |
| --- | --- | --- |
| `"PdEquations"` | `"B"` | Which pd equations to compute: `"B"`, `"AB"`, or `"Both"` |
| `"SimplifyOptions"` | `{TimeConstraint -> {5, 300}}` | Options passed to `Simplify`/`FullSimplify` |
| `"paramQuadSolveOptions"` | (nested) | Options for `paramQuadSolve` (see below) |

### paramQuadSolveOptions (nested)

| Option | Default | Description |
| --- | --- | --- |
| `"DomainOption"` | `Reals` | Domain for solving |
| `"Assumptions"` | `Automatic` | Assumptions for solver |
| `"Method"` | `Automatic` | Solver method |
| `"MonomialOrder"` | `Automatic` | Groebner basis monomial order |
| `"ValidationOption"` | `True` | Validate solutions |
| `"ReturnOption"` | `"All"` | What to return |
| `"TimeoutOption"` | `600` | Timeout in seconds |
| `"SimplifyTimeout"` | `Automatic` | Simplification timeout |
| `"DiagnosticsOption"` | `False` | Enable diagnostics |
| `"OnlyQuadTerms"` | `False` | Only solve quadratic terms |
| `"SignSymbol"` | `signA` (Symbol) | Symbol for sign variables |
| `"GroebnerMemoryFraction"` | `0.5` | Fraction of memory for Groebner |
| `"GroebnerMemoryFloor"` | `1*1024^3` | Minimum memory limit (1 GB) |
| `"GroebnerMemoryCap"` | `16*1024^3` | Maximum memory limit (16 GB) |

---

## Compile Subsystem (`config["Compile"]`)

Options for function compilation.

| Option | Default | Description |
| --- | --- | --- |
| `"CoeffName"` | `"A"` | Coefficient variable name |
| `"SignSymbol"` | `"signA"` (String) | Sign symbol name for compilation |
| `"PerformanceGoal"` | `"Quality"` | `"Speed"` or `"Quality"` |
| `"CompileMode"` | `"Both"` | `"Both"`, `"FunctionOnly"`, or `"JacobianOnly"` |
| `"Compiler"` | `"Compile"` | `"Compile"` or `"FunctionCompile"` |
| `"RuntimeOptions"` | `Automatic` | Runtime options for compiled function |
| `"CompilationTarget"` | `"C"` | Compilation target |

Note: during `buildModels` compilation, `createCompiledEq` derives `"CoeffName"`/`"SignSymbol"` per equation from the processed model and passes them explicitly to `buildKernel`, so `config["Compile"]["CoeffName"]` and `config["Compile"]["SignSymbol"]` do not currently affect `buildModels` output.

### buildKernel Additional Options (not in config)

These options exist in `buildKernel` but are not part of the centralized config:

| Option | Default | Description |
| --- | --- | --- |
| `"FlattenExpressions"` | `Automatic` | Whether to flatten expressions before compilation |
| `"AllowCompileDuringCoverage"` | `False` | Allow compilation during coverage testing |

---

## Numerical Subsystem (`config["Numerical"]`)

Options for numerical coefficient solving.

| Option | Default | Description |
| --- | --- | --- |
| `"initialGuess"` | `<\|"Ewc" -> {4}, "Epd" -> {{4}}\|>` | Initial guesses for root finding |
| `"MaxMaturity"` | `12` | Maximum bond maturity for numerical solving |
| `"RootSigns"` | `Automatic` | Sign combinations: `Automatic`, `All`, or list |
| `"Signs"` | `{}` | Explicit sign values |
| `"UpdatePd"` | `False` | Update price-dividend coefficients |
| `"UpdateBond"` | `False` | Update real bond coefficients |
| `"UpdateNomBond"` | `False` | Update nominal bond coefficients |
| `"UpdateBonds"` | `False` | Update all bond coefficients |
| `"ReduceTimeLimit"` | `5.` | Timeout for Reduce calls |

### FindRoot Options (nested at `config["Numerical"]["FindRoot"]`)

| Option | Default | Description |
| --- | --- | --- |
| `"MaxIterations"` | `100` | Max FindRoot iterations |
| `"PrecisionGoal"` | `Automatic` | Precision goal |
| `"AccuracyGoal"` | `Automatic` | Accuracy goal |
| `"WorkingPrecision"` | `MachinePrecision` | Working precision |
| `"Options"` | `{}` | Additional FindRoot options |

### RecurrenceTable Options (nested at `config["Numerical"]["RecurrenceTable"]`)

| Option | Default | Description |
| --- | --- | --- |
| `"DependentVariables"` | `Automatic` | Dependent variables |
| `"Options"` | `{}` | Additional RecurrenceTable options |

### Scan Options (nested at `config["Numerical"]["Scan"]`)

| Option | Default | Description |
| --- | --- | --- |
| `"FastRootOptions"` | `{}` | Options for fastRoot |
| `"UnboundedPad"` | `1000` | Padding for unbounded intervals |
| `"ScanMethod"` | `"Grid"` | Scanning method |

### Checks Options (nested at `config["Numerical"]["Checks"]`)

| Option | Default | Description |
| --- | --- | --- |
| `"PrintResidualsNorm"` | `False` | Print residual norms |
| `"CheckResiduals"` | `False` | Check residuals against tolerance |
| `"Tol"` | `10.^-16` | Tolerance for residual checking |

---

## Moments Subsystem (`config["Moments"]`)

Options for moments database creation.

| Option | Default | Description |
| --- | --- | --- |
| `"maxMomentsLagsToCreate"` | `8` | Maximum lags to create |
| `"startSequenceAtLag"` | `3` | Starting lag for sequences |
| `"simplifyDownValues"` | `False` | Simplify down values |
| `"IterationLimit"` | `$IterationLimit/4` | Iteration limit for covariance computation |

---

## Parallel Subsystem (`config["Parallel"]`)

Options for parallel kernel management.

| Option | Default | Description |
| --- | --- | --- |
| `"NumKernels"` | `Automatic` | Number of parallel kernels: `Automatic`, number, or `None` |

---

## Build Subsystem (`config["Build"]`)

Options for the build pipeline orchestration.

| Option | Default | Description |
| --- | --- | --- |
| `"Models"` | `All` | Models to build: `All` or list of shortnames |
| `"FromScratch"` | `False` | Force complete rebuild |
| `"CompileJacobians"` | `True` | Compile separate Jacobian files |
| `"CreateMoments"` | `True` | Create moments database |
| `"MaxMaturity"` | `120` | Reserved for moments max maturity (currently unused in `buildModels`) |
| `"FileSuffix"` | `""` | Suffix for checkpoint files |
| `"UpdateManifest"` | `True` | Update model manifest |

---

## Function-Level Options (Not in Centralized Config)

These options are defined on individual functions and are not part of the centralized config system.

### Computational Engine

| Function | Option | Default | Description |
| --- | --- | --- | --- |
| `lagStateVarst` | `"MaxIterations"` | `100` | Max iterations for state variable expansion |
| `lagStateVarst` | `"TimeConstraint"` | `30` | Time limit per iteration |
| `simplifyWithDummySubstitution` | `"Assumptions"` | `Automatic` | Assumptions for simplification |
| `simplifyWithDummySubstitution` | `"Level0Pattern"` | `_Symbol[0]\|_Symbol[_][0]` | Pattern for level-0 terms |
| `simplifyWithDummySubstitution` | `"SimplifyFunction"` | `Simplify` | Function to use for simplification |

### FindRoot Optimizer Tools

| Function | Option | Default | Description |
| --- | --- | --- | --- |
| `bindUnary` | `"Signs"` | `{}` | Sign values for binding |
| `findRootInterval` | `"CoeffName"` | `"A"` | Coefficient name |
| `findRootInterval` | `"SignSymbol"` | `"signA"` | Sign symbol name |
| `findRootInterval` | `"Signs"` | `{}` | Sign values |
| `extractIntervalsFromReduce` | `"InteriorShrink"` | `0.001` | Interior shrink factor |
| `extractIntervalsFromReduce` | `"RootUpperBound"` | `15` | Upper bound for roots |
| `extractIntervalsFromReduce` | `"UnboundedPad"` | `1.*^5` | Padding for unbounded intervals |
| `fastRoot` | `Jacobian` | `None` | Jacobian function |
| `fastRoot` | `Method` | `Automatic` | Method: `"Newton"`, `"Brent"`, `"Secant"`, `Automatic` |
| `fastRoot` | `"SecantBlend"` | `0.5` | Blend factor for secant |
| `fastRoot` | `"Return"` | `"Value"` | Return type: `"Value"` or `"Rule"` |
| `fastRoot` | `"FindRootOptions"` | `Automatic` | FindRoot options |
| `scanAndSolve` | `"BracketGrid"` | `32` | Grid size for bracketing |
| `scanAndSolve` | `"Tolerance"` | `Automatic` | Tolerance for near-zero |
| `scanAndSolve` | `"FastRootOptions"` | `{}` | Options for fastRoot |
| `scanAndSolve` | `"FindRootOptions"` | `Automatic` | FindRoot options |

### Model Processing

| Function | Option | Default | Description |
| --- | --- | --- | --- |
| `simplifyCoeffsSystem` | `"SimplifyOptions"` | `{TimeConstraint -> {5, 300}}` | Simplify options |
| `solveCoeffsSystem` | `"SimplifyOptions"` | `{TimeConstraint -> {5, 300}}` | Simplify options |
| `solveCoeffsSystem` | `"paramQuadSolveOptions"` | `{}` | Options for paramQuadSolve |
| `solveCoeffsSystem` | `"PdEquations"` | `"B"` | Which pd equations to compute |
| `tryTransforms` | `"SimplifyOptions"` | `{TimeConstraint -> {5, 300}}` | Simplify options |
| `addCoeffsSolution` | `"MaxMaturity"` | `12` | Maximum maturity |
| `addCoeffsSolution` | `"initialGuess"` | `<\|"Ewc" -> {4}, "Epd" -> {{4}}\|>` | Initial guesses |
| `addCoeffsSolution` | `"RootSigns"` | `Automatic` | Sign combinations |
| `addCoeffsSolution` | `"FindRootOptions"` | `{}` | FindRoot options |
| `addCoeffsSolution` | `"RecurrenceTableOptions"` | `{}` | RecurrenceTable options |
| `addCoeffsSolution` | `"DependentVariables"` | `Automatic` | Dependent variables |

### Coefficient Solving

| Function | Option | Default | Description |
| --- | --- | --- | --- |
| `updateCoeffsSol` | `"initialGuess"` | `<\|"Ewc"->{4},"Epd"->{{4}}\|>` | Initial guesses |
| `updateCoeffsSol` | `"FindRootOptions"` | `{}` | FindRoot options |
| `updateCoeffsSol` | `"RecurrenceTableOptions"` | `{"DependentVariables"->Automatic}` | RecurrenceTable options |
| `updateCoeffsSol` | `"UpdatePd"` | `False` | Update pd coefficients |
| `updateCoeffsSol` | `"UpdateBond"` | `False` | Update bond coefficients |
| `updateCoeffsSol` | `"UpdateNomBond"` | `False` | Update nominal bond coefficients |
| `updateCoeffsSol` | `"UpdateBonds"` | `False` | Update all bond coefficients |
| `updateCoeffsSol` | `"MaxMaturity"` | `12` | Maximum maturity |
| `updateCoeffsSol` | `"RootSigns"` | `Automatic` | Sign combinations |
| `checks` | `"PrintResidualsNorm"` | `False` | Print residual norms |
| `checks` | `"CheckResiduals"` | `False` | Check residuals |
| `checks` | `"Tol"` | `10.^-16` | Tolerance |
| `solveND` | `"ReduceTimeLimit"` | `5.` | Timeout for Reduce |

### Plotting and Visualization

| Function | Option | Default | Description |
| --- | --- | --- | --- |
| `yieldCurve` | `"MaxMaturity"` | `12` | Maximum maturity |
| `yieldCurve` | `"MomentFunction"` | `uncondE` | Moment function to use |

### Time Aggregation

| Function | Option | Default | Description |
| --- | --- | --- | --- |
| `growth` | `"v0"` | `Function[{t,j,h,k,v,im},0]` | Expansion point function |
| `growth` | `"Order"` | `1` | Power series order |
| `timeSeriesVector` | `"TimeAggregation"` | `1` | Months to aggregate |
| `timeSeriesVector` | `"numPeriods"` | `1` | Number of periods |
| `g` | `"Variable"` | `"Flow"` | Variable type: `"Flow"`, `"Stock"`, `"Ratio"` |

### Moments Database

| Function | Option | Default | Description |
| --- | --- | --- | --- |
| `createDatabase` | `"maxMomentsLagsToCreate"` | `8` | Maximum lags |
| `createDatabase` | `"startSequenceAtLag"` | `3` | Starting lag |
| `createDatabase` | `"simplifyDownValues"` | `False` | Simplify down values |
| `uncondCovLongExo` | `"IterationLimit"` | `$IterationLimit/4` | Iteration limit |

### Resource Management (Legacy)

| Function | Option | Default | Description |
| --- | --- | --- | --- |
| `buildModelsParallel` | `"CreateMoments"` | `True` | Create moments |
| `buildModelsParallel` | `"NumKernels"` | `Automatic` | Kernel count |
| `buildModelsParallel` | `"FromScratch"` | `False` | Force rebuild |
| `buildModelsParallel` | `"PdEquations"` | `"B"` | Which pd equations |

---

## Hardcoded Values (Not Configurable)

The following values are hardcoded and cannot be configured:

| Location | Values | Notes |
| --- | --- | --- |
| `addCoeffsSolutionN` | `"UpdatePd"->True`, `"UpdateBonds"->True`, `"MaxMaturity"->12`, `"RootSigns"->All` | Intentional: convenience wrapper with fixed behavior |

---

## Option Flow: Build Pipeline

The `buildModels` function orchestrates the pipeline and uses `splitConfig` to pass appropriate options to each phase:

```
buildModels[config]
├── processModels[..., splitConfig[config, "Symbolic"]]
│   └── solveCoeffsSystem[..., opts] → paramQuadSolve
├── createCompiledEq[..., splitConfig[config, "Compile"]]
│   └── buildKernel[..., opts] → Compile/FunctionCompile
├── addCoeffsSolutionN[...] (uses hardcoded defaults, not config)
│   └── updateCoeffs → updateCoeffsSol → solveCoeffRoots → FindRoot
└── createDatabase[..., splitConfig[config, "Moments"]]
    └── uncondCovLongExo → long-run covariances
```

### Hash Validation

Compiled files are validated using a hash computed from:
```wolfram
Hash[{compileMode, compilerChoice, flattenOpt, pdMode, eqMap}, "Expression"]
```

The `determineModelStatus` function now correctly passes `compileMode` and `compilerChoice` from the config to ensure hash validation matches compilation settings.

---

## Overlapping Option Names

Some option names appear in multiple contexts with different meanings or defaults:

| Option | Contexts | Notes |
| --- | --- | --- |
| `"MaxMaturity"` | Numerical (12), Build (120) | Build value currently unused; Numerical value affects bond solving |
| `"SignSymbol"` | Symbolic (Symbol `signA`), Compile (String `"signA"`) | Different types in different contexts |
| `"FindRootOptions"` | updateCoeffsSol (list), fastRoot/scanAndSolve (Automatic/list/function) | Different expected shapes |
| `"SimplifyOptions"` | Multiple functions | Same default `{TimeConstraint -> {5, 300}}` |

---

## Legacy Option Mapping

The `legacyOptionMap` in OptionsConfig.wl maps flat option names to their nested config paths:

| Flat Option | Config Path |
| --- | --- |
| `"FindRootOptions"` | `{"Numerical", "FindRoot", "Options"}` |
| `"RecurrenceTableOptions"` | `{"Numerical", "RecurrenceTable", "Options"}` |
| `"NumKernels"` | `{"Parallel", "NumKernels"}` |
| `"PdEquations"` | `{"Symbolic", "PdEquations"}` |
| `"CompileMode"` | `{"Compile", "CompileMode"}` |
| `"Compiler"` | `{"Compile", "Compiler"}` |
| `"FromScratch"` | `{"Build", "FromScratch"}` |
| `"Models"` | `{"Build", "Models"}` |
| ... | (see OptionsConfig.wl for complete list) |

### Ambiguous Options

Some options have context-dependent meanings:

| Option | Default Context | Behavior |
| --- | --- | --- |
| `"MaxMaturity"` | Numerical | Maps to `{"Numerical", "MaxMaturity"}` (default 12) |
| `"SignSymbol"` | Symbolic | Maps to `{"Symbolic", "paramQuadSolveOptions", "SignSymbol"}` |
