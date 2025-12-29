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
