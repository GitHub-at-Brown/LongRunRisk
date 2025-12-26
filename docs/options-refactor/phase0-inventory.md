# Phase 0: Options Inventory

Current state of options system before refactoring.

## Entry Points and Option Flow

### buildModels (ManageResources.wl:567-1150)

**Options Definition (lines 567-577):**
```wolfram
buildModels // Options = {
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

**Signature (line 818):**
```wolfram
buildModels[opts : OptionsPattern[{buildModels,
  FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels,
  FernandoDuarte`LongRunRisk`Tools`FindRootOptim`createCompiledEq}]]
```

**Options Consumed Locally:**
- `"FromScratch"` (line 820) - Controls whether to delete all outputs and rebuild
- `"CompileJacobians"` (line 821) - Whether to compile Jacobian-only functions
- `"CreateMoments"` (line 822) - Whether to create moments databases
- `"NumKernels"` (line 823) - Number of parallel kernels
- `"MaxMaturity"` (line 824) - Maximum maturity for moments/bonds
- `"Models"` (line 825) - Which models to build
- `"FileSuffix"` (line 826) - Suffix for checkpoint files
- `"UpdateManifest"` (line 827) - Whether to update ModelManifest.wl

**Options Forwarded:**
- ✅ **Line 955:** processModels - CORRECTLY forwards with FilterRules pattern
  ```wolfram
  FilterRules[Flatten @ {opts}, Options[FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels]]
  ```
- ❌ **Line 980:** createCompiledEq - MISSING option forwarding (only 2 args passed)
- ❌ **Line 1080:** createDatabase - MISSING option forwarding (only 2 args passed)

**Options Ignored:**
- `"PdEquations"` (line 574) - Defined but NOT extracted locally, SHOULD forward to processModels

---

### updateCoeffsSol (SolveEulerEq.wl:333)

**Options Definition (line 333):**
```wolfram
updateCoeffsSol // Options = {
  "initialGuess" -> <|"Ewc" -> {4}, "Epd" -> {{4}}|>,
  "FindRootOptions" -> {},
  "RecurrenceTableOptions" -> {"DependentVariables" -> Automatic},
  "UpdatePd" -> False,
  "UpdateBond" -> False,
  "UpdateNomBond" -> False,
  "UpdateBonds" -> False,
  "MaxMaturity" -> 12,
  "RootSigns" -> Automatic
};
```

**Options Consumed:**
- All options consumed locally for controlling coefficient solution computation
- `"FindRootOptions"` and `"RecurrenceTableOptions"` forwarded to respective built-in functions

**Options Forwarded:**
- FindRoot options (via "FindRootOptions")
- RecurrenceTable options (via "RecurrenceTableOptions")

---

### yieldCurve (NicePlots.wl:46-115)

**Options Definition (line 46):**
```wolfram
yieldCurve // Options = {
  "bondType" -> "nombond",
  "MaxMaturity" -> Automatic
};
```

**CRITICAL ISSUE (lines 84-86):**
```wolfram
SetOptions[FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution, ...];
PrependTo[Options[FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution], ...];
PrependTo[Options[FernandoDuarte`LongRunRisk`Model`ProcessModels`addCoeffsSolution], ...];
```

**Problem:** Global mutation of `Options[addCoeffsSolution]` using SetOptions and PrependTo
- NOT thread-safe
- NOT exception-safe
- Line 108 attempts restore but doesn't properly undo PrependTo accumulation
- Blocks parallel execution

**Additionally:** `addCoeffsSolution` has NO Options definition (verified in ProcessModels.wl)

---

### processModels (ProcessModels.wl)

**No explicit Options definition found** - accepts options from downstream functions

**Signature Pattern:**
```wolfram
processModels[modelsCatalog_Association,
  opts : OptionsPattern[{solveCoeffsSystem, updateCoeffs, getStartingValues, FindRoot, RecurrenceTable}]]
```

**Options Consumed:**
- `"PdEquations"` - Extracted with OptionValue
- `"SimplifyOptions"` - Extracted with OptionValue

**Options Forwarded:**
- All options passed through to `solveCoeffsSystem`, `updateCoeffs`, etc.

**Pattern:** ✅ CORRECT - accepts downstream function options without declaring them in own Options

---

### createCompiledEq (FindRootOptim.wl:1478+)

**Signature:**
```wolfram
createCompiledEq[model_Association, resourcesCompiledDir_String,
  opts : OptionsPattern[{buildKernel, FunctionCompile, Compile}]]
```

**Options:** Accepts buildKernel, FunctionCompile, and Compile options

**Issue:** buildModels line 980 calls this with only 2 args - options NOT forwarded

---

### createDatabase (CreateMomentsDatabase.wl:314-324)

**Options Definition (lines 314-318):**
```wolfram
createDatabase // Options = {
  "maxMomentsLagsToCreate" -> 8,
  "startSequenceAtLag" -> 3,
  "simplifyDownValues" -> False
};
```

**Signature (lines 321-324):**
```wolfram
createDatabase[
  model_Association,
  covLongFilename_String,
  opts : OptionsPattern[{createDatabase, uncondCovLongExo}]
]
```

**Issue:** buildModels line 1080 calls this with only 2 args - options NOT forwarded

---

## Good Patterns Identified

### Pattern 1: FilterRules for Option Forwarding (buildModels line 955)

```wolfram
processModels[
  KeyTake[catalogModels, {modelKey}],
  FilterRules[Flatten @ {opts}, Options[FernandoDuarte`LongRunRisk`Model`ProcessModels`processModels]]
]
```

**Why it's good:**
- Explicitly filters options for target function
- Uses `Options[targetFunc]` to get valid option names
- Safe and explicit option forwarding

### Pattern 2: OptionsPattern with Multiple Functions (processModels)

```wolfram
opts : OptionsPattern[{solveCoeffsSystem, updateCoeffs, getStartingValues, FindRoot, RecurrenceTable}]
```

**Why it's good:**
- Accepts options from multiple downstream functions
- Doesn't duplicate their defaults (follows wolfram-options skill Rule #1)
- Clean delegation pattern

---

## Summary Statistics

**Total Functions with Options:** 20+

**Critical Issues Found:**
1. yieldCurve global mutation (3 SetOptions/PrependTo calls)
2. buildModels missing option forwarding (2 call sites)
3. addCoeffsSolution missing Options definition

**Good Patterns:**
1. buildModels line 955 FilterRules pattern
2. processModels OptionsPattern delegation
3. Most functions follow Wolfram Options conventions
