# Phase 0: Option Truth Tables

Truth tables showing how options are consumed, forwarded, or ignored across key functions.

## buildModels Options Truth Table

| Option | Consumed | Forwarded | Ignored | Default | Type | Notes |
|--------|----------|-----------|---------|---------|------|-------|
| FromScratch | ✅ line 820 | ❌ | ❌ | False | Boolean | Controls from-scratch rebuild |
| CompileJacobians | ✅ line 821 | ❌ | ❌ | False | Boolean | Whether to compile Jacobians |
| CreateMoments | ✅ line 822 | ❌ | ❌ | True | Boolean | Whether to create moments DBs |
| NumKernels | ✅ line 823 | ❌ | ❌ | Automatic | Automatic\|Integer\|None | Parallel execution control |
| MaxMaturity | ✅ line 824 | ❌ | ❌ | 120 | Integer | For moments/bonds |
| Models | ✅ line 825 | ❌ | ❌ | All | All\|List | Which models to build |
| PdEquations | ❌ | ⚠️ SHOULD → processModels | ✅ | "B" | String | **IGNORED - not forwarded!** |
| FileSuffix | ✅ line 826 | ❌ | ❌ | "" | String | Checkpoint file suffix |
| UpdateManifest | ✅ line 827 | ❌ | ❌ | True | Boolean | Update manifest after build |
| **Compile options** | ❌ | ⚠️ SHOULD → createCompiledEq | ✅ | - | - | **MISSING at line 980** |
| **Moments options** | ❌ | ⚠️ SHOULD → createDatabase | ✅ | - | - | **MISSING at line 1080** |

**Issues:**
- **PdEquations:** Defined in Options but not extracted or forwarded
- **Line 980:** createCompiledEq called without options (should forward Compile/FunctionCompile options)
- **Line 1080:** createDatabase called without options (should forward moments options)

---

## updateCoeffsSol Options Truth Table

| Option | Consumed | Forwarded | Ignored | Default | Type | Notes |
|--------|----------|-----------|---------|---------|------|-------|
| initialGuess | ✅ | ❌ | ❌ | <\|"Ewc"->{4},"Epd"->{{4}}\|> | Association | Initial guess for root finding |
| FindRootOptions | ❌ | ✅ → FindRoot | ❌ | {} | List | Forwarded to FindRoot |
| RecurrenceTableOptions | ❌ | ✅ → RecurrenceTable | ❌ | {"DependentVariables"->Automatic} | List | Forwarded to RecurrenceTable |
| UpdatePd | ✅ | ❌ | ❌ | False | Boolean | Whether to update PD coefficients |
| UpdateBond | ✅ | ❌ | ❌ | False | Boolean | Whether to update bond coefficients |
| UpdateNomBond | ✅ | ❌ | ❌ | False | Boolean | Whether to update nominal bond |
| UpdateBonds | ✅ | ❌ | ❌ | False | Boolean | Whether to update all bonds |
| MaxMaturity | ✅ | ❌ | ❌ | 12 | Integer | Bond maturity (different from buildModels!) |
| RootSigns | ✅ | ❌ | ❌ | Automatic | Automatic\|All\|List | Which sign combinations |

**Notes:**
- MaxMaturity default is **12** here vs **120** in buildModels (different contexts)
- FindRootOptions and RecurrenceTableOptions are forwarding containers

---

## yieldCurve Options Truth Table

| Option | Consumed | Forwarded | Ignored | Default | Type | Notes |
|--------|----------|-----------|---------|---------|------|-------|
| bondType | ✅ | ❌ | ❌ | "nombond" | String | "bond" or "nombond" |
| MaxMaturity | ✅ | ❌ | ❌ | Automatic | Automatic\|Integer | Bond maturity |
| **FindRoot options** | ❌ | ⚠️ Via GLOBAL mutation | ❌ | - | - | **Lines 84-86 SetOptions** |
| **RecurrenceTable options** | ❌ | ⚠️ Via GLOBAL mutation | ❌ | - | - | **Lines 85-86 PrependTo** |

**CRITICAL ISSUE:**
Lines 84-86 mutate global `Options[addCoeffsSolution]`:
```wolfram
SetOptions[...addCoeffsSolution, FilterRules[{opts}, ...addCoeffsSolution]];
PrependTo[Options[...addCoeffsSolution], FilterRules[{opts}, FindRoot]];
PrependTo[Options[...addCoeffsSolution], FilterRules[{opts}, RecurrenceTable]];
```

**Problems:**
- Global state mutation (NOT thread-safe)
- PrependTo accumulates options across calls
- Line 108 restore doesn't undo PrependTo accumulation
- Exception-unsafe (no cleanup if function throws)
- addCoeffsSolution has NO Options definition

---

## processModels Options Truth Table

| Option | Consumed | Forwarded | Ignored | Default | Type | Notes |
|--------|----------|-----------|---------|---------|------|-------|
| PdEquations | ✅ | ✅ → solveCoeffsSystem | ❌ | (from caller) | String | "B", "AB", or "Both" |
| SimplifyOptions | ✅ | ✅ → Simplify | ❌ | (from caller) | List | Simplify options |
| **Other options** | ❌ | ✅ → downstream | ❌ | - | - | Passed through |

**Pattern:** ✅ CORRECT
- No explicit Options definition (doesn't declare defaults)
- Accepts options from downstream functions via OptionsPattern
- Extracts what it needs, forwards the rest
- Follows wolfram-options skill Rule #1

---

## createCompiledEq Options Truth Table

**Expected Options (from signature):**
- buildKernel options
- FunctionCompile options
- Compile options

**Actual at buildModels line 980:**
```wolfram
createCompiledEq[processedModels[shortname], compiledDir]
```
❌ **MISSING:** No options forwarded (only 2 args)

---

## createDatabase Options Truth Table

| Option | Consumed | Forwarded | Ignored | Default | Type | Notes |
|--------|----------|-----------|---------|---------|------|-------|
| maxMomentsLagsToCreate | ✅ | ❌ | ❌ | 8 | Integer | Number of lags to create |
| startSequenceAtLag | ✅ | ❌ | ❌ | 3 | Integer | Starting lag |
| simplifyDownValues | ✅ | ❌ | ❌ | False | Boolean | Whether to simplify |

**Actual at buildModels line 1080:**
```wolfram
createDatabase[processedModels[shortname], momentsFile]
```
❌ **MISSING:** No options forwarded (only 2 args)

---

## Option Name Overlaps

### MaxMaturity
- **updateCoeffsSol:** Default 12 (numerical solution context)
- **buildModels:** Default 120 (moments/build context)
- **Context matters:** Different purposes, needs disambiguation

### FindRootOptions
- **updateCoeffsSol:** List of FindRoot options
- **fastRoot (internal):** Different structure/purpose
- **Needs:** Context-specific naming in config

### Signs vs RootSigns
- **bindUnary:** "Signs" option for sign tuples
- **updateCoeffsSol:** "RootSigns" for which combinations
- **Confusing:** Similar but different purposes

### SignSymbol
- **buildKernel:** String form "signA"
- **paramQuadSolve:** Symbol form signA
- **Type mismatch:** Same name, different types

---

## Summary

### Critical Gaps
1. ✅ **Line 955:** processModels - CORRECT FilterRules pattern
2. ❌ **Line 980:** createCompiledEq - MISSING options
3. ❌ **Line 1080:** createDatabase - MISSING options
4. ❌ **Lines 84-86:** yieldCurve - GLOBAL mutation

### Option Overlaps
- MaxMaturity (2 contexts)
- FindRootOptions (2 contexts)
- Signs/RootSigns (confusing)
- SignSymbol (type mismatch)

### Good Patterns
- buildModels line 955: FilterRules forwarding
- processModels: OptionsPattern delegation
- Most functions follow Wolfram conventions
