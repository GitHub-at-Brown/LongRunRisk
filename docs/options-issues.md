# Options Issues and Inconsistencies

This document catalogs problems, inconsistencies, unused options, and propagation issues discovered during a thorough options tracing of the codebase. These are documented for future remediation but have not been fixed.

---

## Default Value Mismatches

### Issue: `PerformanceGoal` default mismatch between config and function

**Location:**
- `Kernel/Tools/OptionsConfig.wl:98` — `"PerformanceGoal" -> "Quality"`
- `Kernel/Tools/FindRootOptim.wl:86` — `"PerformanceGoal" -> "Speed"`

**Description:**
The centralized config defaults to `"Quality"` but `buildKernel` function defaults to `"Speed"`. When using `buildModels` with the config system, `"Quality"` is used. When calling `buildKernel` directly without options, `"Speed"` is used.

**Impact:** Inconsistent compilation behavior depending on entry point.

**Recommendation:** Align defaults. If `"Quality"` is preferred, update `buildKernel` default.

---

### Issue: `CompileMode` default mismatch between config and function

**Location:**
- `Kernel/Tools/OptionsConfig.wl:99` — `"CompileMode" -> "Both"`
- `Kernel/Tools/FindRootOptim.wl:87` — `"CompileMode" -> "FunctionOnly"`

**Description:**
The centralized config defaults to `"Both"` (compile function and Jacobian together) but `buildKernel` function defaults to `"FunctionOnly"`.

**Impact:** Similar to above — different behavior depending on entry point.

**Recommendation:** Align defaults.

---

## Options Not in Centralized Config

### Issue: `FlattenExpressions` not in config but used in hash

**Location:**
- `Kernel/Tools/FindRootOptim.wl:89` — `"FlattenExpressions" -> Automatic`
- `Kernel/Tools/FindRootOptim.wl:1488` — used in hash computation

**Description:**
The `FlattenExpressions` option exists in `buildKernel` and is used in the compiled file hash computation, but it is not part of the centralized config system. This means:
1. Users cannot configure it via the config system
2. The default `Automatic` is always used in hash validation
3. If someone calls `buildKernel` directly with a different value, the hash will mismatch

**Impact:** Potential hash mismatch if `buildKernel` is called directly with non-default `FlattenExpressions`.

**Recommendation:** Add `"FlattenExpressions"` to `config["Compile"]` and update `splitConfig`.

---

### Issue: `AllowCompileDuringCoverage` not in config

**Location:**
- `Kernel/Tools/FindRootOptim.wl:90` — `"AllowCompileDuringCoverage" -> False`

**Description:**
This option controls whether compilation is allowed during coverage testing. It's not in the centralized config.

**Impact:** Low — this is a development/testing option.

**Recommendation:** Consider adding to config or leaving as function-level option.

---

## Numerical Phase Not Using Config

### Issue: `splitConfig[config, "Numerical"]` exists but is never used

**Location:**
- `Kernel/Tools/OptionsConfig.wl:320-350` — `splitConfig` implementation for Numerical
- `Kernel/Tools/ManageResources.wl` — numerical phase

**Description:**
The `splitConfig` function has a `"Numerical"` subsystem implementation that extracts all the numerical solving options, but the build pipeline never uses it. The numerical phase calls `addCoeffsSolutionN` which has hardcoded values and doesn't accept options.

**Impact:** Users cannot customize numerical solving options (like `FindRootOptions`, `RootSigns`, etc.) through the `buildModels` config.

**Recommendation:** This appears intentional (`addCoeffsSolutionN` is documented as a convenience wrapper with fixed behavior). However, consider either:
1. Removing `splitConfig[config, "Numerical"]` since it's unused
2. Or creating a configurable numerical phase that uses it

---

## Scan Options Not Propagated

### Issue: `config["Numerical"]["Scan"]` options not used

**Location:**
- `Kernel/Tools/OptionsConfig.wl:119-123` — Scan options defined
- `Kernel/ComputationalEngine/SolveEulerEq.wl` — scanAndSolve usage

**Description:**
The config defines `Scan` options (`FastRootOptions`, `UnboundedPad`, `ScanMethod`) but these are not propagated from the config to the numerical solving functions. The `scanAndSolve` function has its own defaults that are used instead.

**Note:** The `splitConfig[config, "Numerical"]` extracts these but is never called.

**Impact:** Config Scan options are ignored.

**Recommendation:** Either remove from config or wire up propagation if numerical phase becomes configurable.

---

## Type Mismatches

### Issue: `SignSymbol` type differs between contexts

**Location:**
- `Kernel/Tools/OptionsConfig.wl:89` — `"SignSymbol" -> Symbol["signA"]` (actual Symbol)
- `Kernel/Tools/OptionsConfig.wl:97` — `"SignSymbol" -> "signA"` (String)
- `Kernel/ComputationalEngine/ParamQuadSolve.wl:81` — `"SignSymbol" -> signA` (bare Symbol)
- `Kernel/Tools/FindRootOptim.wl:85` — `"SignSymbol" -> "signA"` (String)

**Description:**
The `SignSymbol` option has different types in different contexts:
- Symbolic/paramQuadSolve: expects a Symbol
- Compile/buildKernel: expects a String

**Impact:** Potential type errors if options are passed between contexts without conversion.

**Recommendation:** Standardize on one type and convert as needed at boundaries.

---

## buildModelsParallel Not Using Normalized Config

### Issue: `buildModelsParallel` has its own Options instead of using config

**Location:**
- `Kernel/Tools/ManageResources.wl:1138-1143`

**Description:**
```wolfram
buildModelsParallel // Options = {
    "CreateMoments" -> True,
    "NumKernels" -> Automatic,
    "FromScratch" -> False,
    "PdEquations" -> "B"
};
```

The `buildModelsParallel` function defines its own options rather than using the normalized config system. It also:
1. Uses `OptionsPattern[{buildModelsParallel, buildModels}]` pattern
2. Calls `buildModels` with only a subset of options (line 1263-1267)
3. Does not pass through all config options

**Impact:** Options like `CompileMode`, `Compiler`, `SimplifyOptions` etc. cannot be passed through `buildModelsParallel`.

**Recommendation:** Update `buildModelsParallel` to accept and forward normalized config.

---

## Options Forwarding Incomplete

### Issue: `buildModelsParallel` doesn't forward all options to `buildModels`

**Location:**
- `Kernel/Tools/ManageResources.wl:1263-1267`

**Description:**
When `buildModelsParallel` calls `buildModels` for the moments phase, it only passes:
```wolfram
buildModels[
    "Models" -> {m},
    "CreateMoments" -> True,
    "NumKernels" -> OptionValue["NumKernels"]
]
```

Other options like `PdEquations` are not forwarded.

**Impact:** Moments phase uses default options regardless of what user specified.

**Recommendation:** Forward all relevant options or use the normalized config.

---

## Unused/Dead Options

### Issue: `getStartingValues` options defined but function appears unused

**Location:**
- `Kernel/ComputationalEngine/SolveEulerEq.wl:1001-1003`

**Description:**
```wolfram
getStartingValues // Options = {
    "initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>
};
```

The `getStartingValues` function is defined with options but doesn't appear to be called anywhere in the codebase (based on grep results from earlier session).

**Impact:** Dead code.

**Recommendation:** Remove if truly unused, or implement if intended for future use.

---

## Overlapping Option Names with Different Semantics

### Issue: `FindRootOptions` has different expected shapes

**Location:**
- `Kernel/ComputationalEngine/SolveEulerEq.wl:335` — `"FindRootOptions" -> {}` (expects list)
- `Kernel/Tools/FindRootOptim.wl:522` — `"FindRootOptions" -> Automatic` (accepts Automatic/list/function)

**Description:**
The same option name `FindRootOptions` is used with different expected shapes:
- `updateCoeffsSol`: expects a list of rules
- `fastRoot`/`scanAndSolve`: can be `Automatic`, a list, or a function

**Impact:** Confusion when passing options through multiple layers.

**Recommendation:** Use distinct option names or normalize the expected shape.

---

### Issue: `MaxMaturity` appears in multiple contexts with different defaults

**Location:**
- `Kernel/Tools/OptionsConfig.wl:117` — `config["Numerical"]["MaxMaturity"]` default 12
- `Kernel/Tools/OptionsConfig.wl:150` — `config["Build"]["MaxMaturity"]` default 120
- Multiple function-level defaults of 12

**Description:**
`MaxMaturity` has two different meanings:
1. Numerical context: maximum maturity for bond coefficient solving (default 12)
2. Build context: maximum maturity for moments database (default 120)

The `ambiguousOptions` mapping in OptionsConfig.wl defaults to Numerical context.

**Impact:** User confusion; legacy flat options may go to wrong context.

**Recommendation:** Document clearly; consider renaming to `"NumericalMaxMaturity"` and `"MomentsMaxMaturity"`.

---

## Missing Option Propagation

### Issue: `extractIntervalsFromReduce` has different `UnboundedPad` default than config

**Location:**
- `Kernel/Tools/OptionsConfig.wl:121` — `"UnboundedPad" -> 1000`
- `Kernel/Tools/FindRootOptim.wl:1285` — `"UnboundedPad" -> 1.*^5`

**Description:**
The config has `UnboundedPad -> 1000` but `extractIntervalsFromReduce` has `UnboundedPad -> 1.*^5` (100000). These differ by a factor of 100.

**Impact:** Different behavior depending on whether config options reach the function.

**Recommendation:** Align defaults.

---

## Jacobian Compilation Options

### Issue: Jacobian compilation passes incomplete options (FIXED in recent session)

**Location:**
- `Kernel/Tools/ManageResources.wl:1010-1014`

**Description:**
This was identified and fixed in the recent session. The Jacobian compilation was only passing `"CompileMode" -> "JacobianOnly"` but not `"Compiler" -> compilerChoice`.

**Status:** Fixed by adding `"Compiler" -> compilerChoice` to the Jacobian compilation call.

---

## Hash Validation Options

### Issue: Hash validation was using wrong defaults (FIXED in recent session)

**Location:**
- `Kernel/Tools/ManageResources.wl:735`

**Description:**
This was identified and fixed in the recent session. The `validateCompiledFile` was being called without `compileMode`, `compilerChoice`, `flattenOpt` parameters, causing it to use defaults that didn't match the actual compilation settings.

**Status:** Fixed by threading compile options through `determineModelStatus`.

---

## Documentation/Code Drift

### Issue: `RuntimeOptions` default in code vs. config

**Location:**
- `Kernel/Tools/OptionsConfig.wl:101` — `"RuntimeOptions" -> Automatic` with comment `(*"Speed",*)`

**Description:**
The comment suggests `"Speed"` may have been the previous default or is being considered. Current default is `Automatic`.

**Impact:** Low — just a documentation issue.

**Recommendation:** Remove commented-out alternatives or document why they exist.

---

## Potential Future Issues

### Issue: No validation of option values

**Description:**
While `validateConfig` checks structure, there's no validation of option values. For example:
- `CompileMode` could be set to an invalid string
- `NumKernels` could be negative
- `PerformanceGoal` could be misspelled

**Impact:** Errors surface late in execution rather than at option parsing.

**Recommendation:** Add value validation to `normalizeConfig` or `validateConfig`.

---

### Issue: No mechanism to discover available options

**Description:**
Users must read documentation or source code to know what options are available. There's no `AvailableOptions[]` or similar discovery mechanism.

**Recommendation:** Consider adding `$DefaultConfig` or similar public symbol for discovery.

---

## Summary Table

| Issue | Severity | Status |
| --- | --- | --- |
| PerformanceGoal default mismatch | Medium | Open |
| CompileMode default mismatch | Medium | Open |
| FlattenExpressions not in config | Medium | Open |
| splitConfig["Numerical"] unused | Low | Open (intentional?) |
| Scan options not propagated | Low | Open |
| SignSymbol type mismatch | Low | Open |
| buildModelsParallel not using config | Medium | Open |
| buildModelsParallel incomplete forwarding | Medium | Open |
| getStartingValues unused | Low | Open |
| FindRootOptions shape mismatch | Low | Open |
| MaxMaturity ambiguous | Low | Open (documented) |
| UnboundedPad default mismatch | Low | Open |
| Jacobian compilation options | High | **FIXED** |
| Hash validation options | High | **FIXED** |
