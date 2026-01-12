# Usage Messages Assessment Report

**Directories:** `Kernel/ComputationalEngine/`, `Kernel/Model/`, `Kernel/Tools/`, `Kernel/`  
**Date:** 2026-01-12  
**Status:** ✅ No Changes Made (Read-Only Assessment)

---

## Overview

This report assesses whether the usage messages for exported (public) symbols in `Kernel/ComputationalEngine/`, `Kernel/Model/`, and `Kernel/Tools/` directories are up to date with their actual implementations.

**Summary by Directory:**
- **ComputationalEngine:** 6 files, 22 symbols assessed
- **Model:** 6 files, 75+ symbols assessed  
- **Tools:** 15 files, 35+ symbols assessed
- **Kernel:** 1 file, 4 symbols assessed

---

# Part 1: Kernel/ComputationalEngine/

---

## 1. ComputeConditionalExpectations.wl

### Exported Symbols (Lines 14-17, 24-27)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `ev` | `"ev[x, s, model] gives the expected value of x conditional on time s for model."` | ✅ **Up to date** |
| `var` | `"var[x, s, model] gives the variance of x conditional on time s for model."` | ✅ **Up to date** |
| `cov` | `"cov[x, y, s, model] gives the covariance of x and y conditional on time s for model."` | ✅ **Up to date** |
| `corr` | `"corr[x, y, s, model] gives the correlation of x and y conditional on time s for model."` | ✅ **Up to date** |

**Notes:**
- All four functions take the documented arguments.
- The implementations (lines 57-91) match the signatures described.
- All functions have `HoldFirst` attribute which is **not documented** in usage messages (minor omission).

---

## 2. ComputeUnconditionalExpectations.wl

### Exported Symbols (Lines 14-17, 24-27)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `uncondE` | `"uncondE[expr, model] gives the unconditional expectation of expr for model."` | ✅ **Up to date** |
| `uncondVar` | `"uncondVar[expr, model] gives the unconditional variance of expr for model."` | ✅ **Up to date** |
| `uncondCov` | `"uncondCov[expr1, expr2, model] gives the unconditional covariance of expr1 and expr2 for model."` | ✅ **Up to date** |
| `uncondCorr` | `"uncondCorr[expr1, expr2, model] gives the unconditional correlation of expr1 and expr2 for model."` | ✅ **Up to date** |

**Notes:**
- Implementations at lines 52-160 match the documented signatures.
- Private helper functions (`createSystem`, `solveSystem`, `sol`) are correctly not documented with usage messages.

---

## 3. CreateEulerEq.wl

### Exported Symbols (Lines 14-17, 24-28)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `eulereq` | `"eulereq[x[t], s, model] or eulereq[x[t,i], s, model] give the Euler equation for an asset with real return x[t] or x[t, i] conditional on time s for model."` | ✅ **Up to date** |
| `nomeulereq` | `"nomeulereq[x[t], s, model] or nomeulereq[x[t,i], s, model] give the Euler equation for an asset with nominal return x[t] or x[t, i] conditional on time s for model."` | ✅ **Up to date** |
| `findEulerEqConstants` | Multi-line usage describing real and nominal variants | ✅ **Up to date** |
| `findBondRecursion` | `"findBondRecursion[t, n, model] finds the recursions satisfied by the coefficients in front of the state variables for a bond price with maturity n at time t for model."` | ✅ **Up to date** |

**Notes:**
- All implementations (lines 50-260) match the documented call patterns.
- `findEulerEqConstants` correctly documents the optional `True` third argument for nominal returns.

---

## 4. CreateMomentsDatabase.wl

### Exported Symbols (Lines 14-16, 23-27)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `uncondVarLongExo` | Describes two-argument form and three-argument form with custom `covfun` | ⚠️ **Outdated** |
| `uncondCovLongExo` | Describes three-argument form and four-argument form with custom `covfun` | ⚠️ **Outdated** |
| `createDatabase` | `"createDatabase[model_Association, covLongFilename_String] computes moments for model, memoizes the results, and stores them in covLongFilename."` | ✅ **Up to date** |

**Issues Found:**

1. **`uncondVarLongExo`** (Lines 23-24):
   - Usage says: `"uncondVarLongExo[toExogenous, expression]..."` and `"uncondVarLongExo[toExogenous, expression, covfun]..."`
   - Actual signature (line 231): `uncondVarLongExo[model_, expression_, covfun_, opts...]`
   - **Issue:** The first argument is now `model_` (an Association), not `toExogenous_`. The usage message still references the old API.

2. **`uncondCovLongExo`** (Lines 25-26):
   - Usage says: `"uncondCovLongExo[toExogenous, expression1, expression2]..."` and `"uncondCovLongExo[toExogenous, expression1, expression2, covfun]..."`
   - Actual signature (lines 127-134): `uncondCovLongExo[model_, expression1_, expression2_, covfun_, opts...]`
   - **Issue:** Same as above - first argument is now `model_`, not `toExogenous_`. Additionally, the implementation now **requires** `covfun` (4th argument), whereas the usage says it's optional.
   - **Issue:** The implementation also accepts options (`opts : OptionsPattern[...]`) which are not documented.

3. **Missing Documentation:**
   - `createDatabase` accepts options `"maxMomentsLagsToCreate"`, `"startSequenceAtLag"`, and `"simplifyDownValues"` (lines 314-318) which are not mentioned in the usage message.

---

## 5. ParamQuadSolve.wl

### Exported Symbols (Lines 14-16, 23-48)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `paramQuadSolve` | Comprehensive multi-line usage describing return structure and purpose | ✅ **Up to date** |
| `expandPatternAssumptions` | Detailed usage describing pattern expansion for assumptions | ✅ **Up to date** |
| `simplifyWithDummySubstitution` | Detailed usage describing dummy substitution for simplification | ✅ **Up to date** |

**Notes:**
- Very comprehensive usage messages spanning lines 23-48.
- `paramQuadSolve` returns an Association with documented keys: `"Solution"`, `"SignRootMap"`, `"CoeffMap"`, `"Conditions"`, `"Assumptions"`, `"Verification"`, `"Diagnostics"`.
- The implementation (lines 105-402) returns an Association with additional keys not documented:
  - `"Maps"` (containing sub-keys `"Solution"`, `"SignRootMap"`, `"SignRadicandMap"`, `"CoeffMap"`)
  - `"DeferredVariables"`
  - `"DeferredEquations"`
- **Minor Issue:** The returned Association has more keys than documented, though the core documented keys are present.

**Options:**
- Many options (lines 71-86) are not documented in the usage message:
  - `"DomainOption"`, `"Assumptions"`, `"Method"`, `"MonomialOrder"`, `"ValidationOption"`, `"ReturnOption"`, `"TimeoutOption"`, `"SimplifyTimeout"`, `"DiagnosticsOption"`, `"OnlyQuadTerms"`, `"SymbolicSignSymbol"`, `"GroebnerMemoryFraction"`, `"GroebnerMemoryFloor"`, `"GroebnerMemoryCap"`

---

## 6. SolveEulerEq.wl

### Exported Symbols (Lines 14-17, 24-42)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `updateCoeffs` | Multi-line usage describing hierarchical return structure | ✅ **Up to date** |
| `addCoeffsSolutionN` | `"addCoeffsSolutionN[model] computes numerical solutions for all coefficient types (wc, pd, bond, nombond) using default parameters and model extraInfo."` | ⚠️ **Incomplete** |
| `flattenCoeffs` | Multi-line usage describing extraction patterns | ✅ **Up to date** |
| `flattenCoeffsBundles` | Multi-line usage describing bundle generation | ✅ **Up to date** |

**Issues Found:**

1. **`addCoeffsSolutionN`** (Line 32):
   - Usage says: `"addCoeffsSolutionN[model] computes numerical solutions..."`
   - Actual signatures (lines 1161-1180):
     - `addCoeffsSolutionN[model_Association, buildMaxMaturity_Integer, opts...]`
     - `addCoeffsSolutionN[model_Association, opts...]` (default maturity 12)
     - `addCoeffsSolutionN[model_Association]` (legacy form)
   - **Issue:** The usage message doesn't mention the optional `buildMaxMaturity` parameter or the options that can be passed.

2. **Missing from Usage:**
   - `updateCoeffs` accepts many options (inherited from `updateCoeffsSol`, `checks`, lines 925-931):
     - `"FindRootOptions"`, `"RecurrenceTableOptions"`, `"UpdatePd"`, `"UpdateBond"`, `"UpdateNomBond"`, `"UpdateBonds"`, `"MaxMaturity"`, `"RootSigns"`, `"PrintResidualsNorm"`, `"CheckResiduals"`, `"Tol"`
   - These options are not documented in the usage message.

---

## Summary

| File | Symbols | Up to Date | Outdated/Incomplete |
|------|---------|------------|---------------------|
| ComputeConditionalExpectations.wl | 4 | 4 | 0 |
| ComputeUnconditionalExpectations.wl | 4 | 4 | 0 |
| CreateEulerEq.wl | 4 | 4 | 0 |
| CreateMomentsDatabase.wl | 3 | 1 | 2 |
| ParamQuadSolve.wl | 3 | 3 | 0* |
| SolveEulerEq.wl | 4 | 3 | 1 |
| **Total** | **22** | **19** | **3** |

*ParamQuadSolve.wl has some undocumented return keys and options but the core usage is accurate.

---

## Recommended Actions

### High Priority

1. **CreateMomentsDatabase.wl - `uncondVarLongExo`**
   - Update first argument description from `toExogenous` to `model`
   - Update signature to reflect that `model` is now an Association
   - Document that `covfun` is required

2. **CreateMomentsDatabase.wl - `uncondCovLongExo`**
   - Same issues as `uncondVarLongExo`
   - Update signature and document options

3. **SolveEulerEq.wl - `addCoeffsSolutionN`**
   - Document the optional `buildMaxMaturity` argument
   - Mention that options from `updateCoeffs` can be passed

### Medium Priority

4. **ParamQuadSolve.wl - `paramQuadSolve`**
   - Consider documenting the additional return keys (`"Maps"`, `"DeferredVariables"`, `"DeferredEquations"`)
   - Consider documenting available options

5. **CreateMomentsDatabase.wl - `createDatabase`**
   - Document available options

6. **SolveEulerEq.wl - `updateCoeffs`**
   - Consider documenting key options

### Low Priority

7. **ComputeConditionalExpectations.wl**
   - Consider documenting `HoldFirst` attribute for `ev`, `var`, `cov`, `corr`

---

## Conclusion (ComputationalEngine)

The majority of usage messages in ComputationalEngine (19 out of 22) are accurate and up to date. Three functions have outdated or incomplete usage messages.

---

# Part 2: Kernel/Model/

---

## 7. Catalog.wl

### Exported Symbols (Lines 14-15, 22-23)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `models` | `"Association with the definition and properties of models."` | ✅ **Up to date** |
| `modelsExtraInfo` | `"Additional optional information about model solution, constraints, initial guesses for numerical solvers."` | ✅ **Up to date** |

**Notes:**
- These are data symbols (Associations), not functions.
- Usage messages accurately describe their purpose.

---

## 8. EndogenousEq.wl

### Exported Symbols (Lines 18-51)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `wceq` | `"wceq[t] gives the log wealth-consumption ratio at time t."` | ✅ **Up to date** |
| `pdeq` | `"pdeq[t, i] gives the log price-dividend ratio of stock i at time t."` | ✅ **Up to date** |
| `bondeq` | `"bondeq[t, m] gives the log price of a real m-month maturity discount (zero-coupon) riskless bond at time t."` | ✅ **Up to date** |
| `nombondeq` | `"nombondeq[t, m] gives the log price of a nominal m-month maturity discount (zero-coupon) riskless bond at time t."` | ✅ **Up to date** |
| `sdfeq` | `"sdfeq[t] gives the (real) stochastic discount factor at time t."` | ✅ **Up to date** |
| `nomsdfeq` | `"nomsdfeq[t] gives the nominal stochastic discount factor at time t."` | ✅ **Up to date** |
| `retceq` | `"retceq[t] gives the return for the asset that pays consumption as dividends each period."` | ✅ **Up to date** |
| `reteq` | `"reteq[t, i] gives the return for stock i."` | ✅ **Up to date** |
| `kappa1eq` | `"kappa1eq[mu] is the Campbell-Shiller approximation constant..."` | ✅ **Up to date** |
| `kappa0eq` | `"kappa0eq[mu] is the Campbell-Shiller approximation constant..."` | ✅ **Up to date** |
| `excretceq` | `"excretceq[t] gives the return for the asset that pays consumption as dividends each period in excess of the risk-free rate."` | ✅ **Up to date** |
| `excreteq` | `"excreteq[t, i] gives the return for stock i in excess of the risk-free rate."` | ✅ **Up to date** |
| `bondyieldeq` | Multi-line usage for real bond yields | ✅ **Up to date** |
| `nombondyieldeq` | Multi-line usage for nominal bond yields | ✅ **Up to date** |
| `bondfweq` | Multi-line usage for real forward rates | ✅ **Up to date** |
| `nombondfweq` | Multi-line usage for nominal forward rates | ✅ **Up to date** |
| `bondreteq` | Multi-line usage for real bond returns | ✅ **Up to date** |
| `nombondreteq` | Multi-line usage for nominal bond returns | ✅ **Up to date** |
| `bondfwspreadeq` | Multi-line usage for real forward spreads | ✅ **Up to date** |
| `nombondfwspreadeq` | Multi-line usage for nominal forward spreads | ✅ **Up to date** |
| `bondexcreteq` | Multi-line usage for real bond excess returns | ✅ **Up to date** |
| `nombondexcreteq` | Multi-line usage for nominal bond excess returns | ✅ **Up to date** |
| `rfeq` | Multi-line usage for real risk-free rates | ✅ **Up to date** |
| `nomrfeq` | Multi-line usage for nominal risk-free rates | ✅ **Up to date** |

**Notes:**
- 24 symbols total, all with comprehensive usage messages.
- Multi-line usages correctly document optional arguments.

---

## 9. ExogenousEq.wl

### Exported Symbols (Lines 19-28)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `xeq` | `"xeq[t] gives the exogenous dynamics of long-run risk."` | ✅ **Up to date** |
| `pieq` | `"pieq[t] gives the exogenous dynamics of inflation."` | ✅ **Up to date** |
| `pibareq` | `"pibareq[t] gives the exogenous dynamics of expected inflation."` | ✅ **Up to date** |
| `dceq` | `"dceq[t] gives the exogenous dynamics of real consumption growth."` | ✅ **Up to date** |
| `sgeq` | `"sgeq[t] gives the exogenous dynamics of the nominal-real covariance (NRC)."` | ✅ **Up to date** |
| `sxeq` | `"sxeq[t] gives the exogenous dynamics of stochastic volatility of long-run risk."` | ✅ **Up to date** |
| `sceq` | `"sceq[t] gives the exogenous dynamics of stochastic volatility of real consumption growth."` | ✅ **Up to date** |
| `speq` | `"speq[t] gives the exogenous dynamics of long-run risk stochastic volatility of inflation."` | ⚠️ **Minor issue** |
| `ddeq` | `"ddeq[t, i] gives the exogenous dynamics of real dividend growth for stock i."` | ✅ **Up to date** |

**Issues Found:**
- **`speq`**: Usage says "long-run risk stochastic volatility of inflation" which is confusingly worded. Should be "stochastic volatility of inflation" (remove "long-run risk").

---

## 10. Parameters.wl

### Exported Symbols (Lines 19-102)

This file exports 65+ parameter symbols, each with a usage message describing what the parameter represents. All usage messages are concise descriptions of the parameter's role in the model.

| Sample Symbols | Assessment |
|----------------|------------|
| `delta` - `"Discount factor."` | ✅ **Up to date** |
| `psi` - `"Elasticity of intertemporal substitution."` | ✅ **Up to date** |
| `gamma` - `"Risk aversion coefficient."` | ✅ **Up to date** |
| `theta` - Definition formula | ✅ **Up to date** |
| ... (all 65+ parameters) | ✅ **Up to date** |
| `$parameters` - `"List of all model parameter names."` | ✅ **Up to date** |

**Notes:**
- All parameter usage messages are accurate descriptions.
- No function documentation needed as these are parameter symbols.

---

## 11. ProcessModels.wl

### Exported Symbols (Lines 14, 21)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `processModels` | `"processModels[modelsCatalog] performs symbolic processing on models, adding coefficient systems and solutions."` | ⚠️ **Incomplete** |

**Issues Found:**
- The usage message doesn't document:
  - The options it accepts (inherited from `solveCoeffsSystem`, `updateCoeffs`, `FindRoot`, `RecurrenceTable`)
  - The structure of information it adds to each model

---

## 12. Shocks.wl

### Exported Symbols (Lines 14-15, 22-23)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `rulesE` | `"rulesE[t] defines the distribution of exogenous shocks by giving replacement rules that compute the unconditional expectation of products of powers of exogenous shocks."` | ✅ **Up to date** |
| `eps` | `"Exogenous shocks."` | ✅ **Up to date** |

**Notes:**
- Usage messages are accurate but minimal.

---

# Part 3: Kernel/Tools/

---

## 13. Common.wl

### Exported Symbols (Lines 14, 21)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `print` | `"print[msg] writes msg to $Output using WriteString."` | ⚠️ **Incomplete** |

**Issues Found:**
- The usage doesn't document the options:
  - `"Verbose"` (default `"CI"`) - controls when printing occurs
  - `"Memory"` (default `False`) - shows memory usage info
  - `"Prefix"` (default `None`) - optional message prefix

---

## 14. CompoundScope.wl

### Exported Symbols (Lines 14, 21-24)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `compoundScope` | Multi-line usage covering all call patterns | ✅ **Up to date** |

**Notes:**
- Comprehensive usage message documenting all four call patterns.

---

## 15. CopyDefinitions.wl

### Exported Symbols (Lines 14, 21-22)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `copyDefinitions` | Multi-line usage for both symbol and context variants | ✅ **Up to date** |

**Notes:**
- Accurately documents both `copyDefinitions[f, g]` and `copyDefinitions[f, "Context`"]` forms.

---

## 16. FindRootOptim.wl

### Exported Symbols (Lines 14-21, 28-72)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `buildKernel` | Multi-line comprehensive usage with options list | ✅ **Up to date** |
| `bindUnary` | Multi-line usage | ✅ **Up to date** |
| `findRootInterval` | Multi-line usage | ✅ **Up to date** |
| `extractIntervalsFromReduce` | Multi-line usage with options | ✅ **Up to date** |
| `scanAndSolve` | Multi-line usage with options | ✅ **Up to date** |
| `fastRoot` | Comprehensive usage with spec formats and options | ✅ **Up to date** |
| `createCompiledEq` | Usage for compiled equation creation | ✅ **Up to date** |
| `buildEqMapFromModel` | Usage for equation map extraction | ✅ **Up to date** |

**Notes:**
- All 8 symbols have detailed, comprehensive usage messages.
- Options are documented inline in usage strings.
- Very well documented.

---

## 17. Initialization.wl

**No Usage Messages**  
This file is an initialization script, not a package with exported symbols.

---

## 18. ManageResources.wl

### Exported Symbols (Lines 5-39)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `updateModelManifest` | Multi-line usage for both forms | ✅ **Up to date** |
| `checkCatalogChanges` | Multi-line usage for both forms | ✅ **Up to date** |
| `reformatCatalog` | Usage for catalog reformatting | ✅ **Up to date** |
| `buildModels` | `"buildModels[] processes enabled models, compiles functions, computes numerical solutions, and creates moments database."` | ⚠️ **Incomplete** |
| `buildModelsParallel` | Multi-line usage with options | ✅ **Up to date** |
| `checkCatalogForUI` | Multi-line usage with return structure | ✅ **Up to date** |
| `getModelPipelineStatus` | Multi-line usage with return structure | ✅ **Up to date** |

**Issues Found:**
- **`buildModels`**: Usage doesn't document its many options:
  - `"FromScratch"`, `"CompileJacobians"`, `"CreateMoments"`, `"NumKernels"`, `"BuildMaxMaturity"`, `"Models"`, `"FileSuffix"`, `"UpdateManifest"`

---

## 19. NiceOutput.wl

### Exported Symbols (Lines 14-16, 23, documented in Private 37-56)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `info` | `"info[models] displays a table with information for each model in the association models."` | ✅ **Up to date** |
| `formatModels` | Detailed multi-line usage | ✅ **Up to date** |
| `toCatalog` | `"toCatalog[models, {key_1, key_2, ...}]..."` | ✅ **Up to date** |

**Notes:**
- Private symbols (`modelToTeX`, `TeXToModel`, `modelFormattingTemplate`) also have usage messages for internal documentation.

---

## 20. NicePlots.wl

### Exported Symbols (Lines 14-15, 22-23)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `yieldCurve` | `"yieldCurve[model, newParameters, coeffsWc, bondType, opts] plots the yield curve"` | ✅ **Up to date** |
| `plotCoeffs` | `"plotCoeffs[model_Association, sol_List, parameters_List, Ewc0_List, opts: OptionsPattern[]] plots the steps that FindRoot takes to solve for A[0]"` | ✅ **Up to date** |

**Notes:**
- Usage messages accurately describe the function signatures.

---

## 21. OptionsValidationRules.wl

### Exported Symbols (Line 5)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `InstallOptionsValidationRules` | `"InstallOptionsValidationRules[] installs option validation rules via OptionsValidation."` | ✅ **Up to date** |

---

## 22. PipelineMonitor.wl

### Exported Symbols (Lines 5-11)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `checkModels` | Multi-line comprehensive usage covering all behaviors and options | ✅ **Up to date** |

**Notes:**
- Excellent documentation covering `"AutoBuild"` option and environment variable behavior.

---

## 23. ReExport.wl

### Exported Symbols (Lines 17)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `reExport` | `"reExport[f, g] copies all definitions from symbol f to symbol g and updates the usage message. reExport[oldContext] exports all public symbols from oldContext to FernandoDuarte\`LongRunRisk\` with capitalized names."` | ✅ **Up to date** |

---

## 24. TimeAggregation.wl

### Exported Symbols (Lines 14, 21-23)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `growth` | Multi-line usage covering three call patterns | ✅ **Up to date** |

**Notes:**
- Private symbols (`g`, `timeSeriesVector`) also have usage messages but are internal.

---

## 25. ToNumber.wl

### Exported Symbols (Lines 14-18, 24-34)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `toNum` | Multi-line comprehensive usage with all call patterns | ✅ **Up to date** |
| `toEquation` | Multi-line usage | ✅ **Up to date** |
| `toExogenousVars` | Multi-line usage | ✅ **Up to date** |
| `toStateVars` | Multi-line usage | ✅ **Up to date** |
| `processNewParameters` | Usage for parameter processing | ✅ **Up to date** |

**Notes:**
- `toNum` has 6 message definitions for error handling (lines 40-47).
- Options `"SolutionSelector"` and `"ReturnAllSolutions"` are not documented in usage but are well-designed.

---

## 26. ValidateModels.wl

### Exported Symbols (Lines 5-6, 22)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `validateModel` | `"validateModel[model] validates a single model Association against the schema. Returns a ValidationResult Association."` | ✅ **Up to date** |
| `validateCatalog` | `"validateCatalog[catalog] validates all models in a catalog Association. Returns a CatalogValidationResult."` | ✅ **Up to date** |

**Notes:**
- Extensive message definitions (lines 6-21) document all possible validation errors.

---

## 27. VisualizeCoeffs.wl

### Exported Symbols (Lines 14, 21-26)

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `visualizeCoeffs` | Multi-line comprehensive usage with options documentation | ✅ **Up to date** |

**Notes:**
- Options `"ShowSelector"` and `"ShowDetails"` are documented inline.

---

# Part 4: Kernel/

---

## 28. LongRunRisk.wl

### Exported Symbols

| Symbol | Usage Message | Assessment |
|--------|---------------|------------|
| `UncondCov` | Derived from `uncondCov` via string replacement | ✅ **Up to date** |
| `UncondVar` | Derived from `uncondVar` via string replacement | ✅ **Up to date** |
| `UncondCorr` | Derived from `uncondCorr` via string replacement | ✅ **Up to date** |
| `Info` | Derived from `info` via string replacement | ✅ **Up to date** |

**Notes:**
- This is the main package file. It primarily loads other packages and re-exports their symbols.
- Most exported symbols (`BuildModels`, `CheckModels`, `Growth`, etc.) inherit their usage messages dynamically via `reExport`.
- The four symbols listed above have explicitly defined usage messages that transform the underlying symbol's usage message (changing the name to Capitalized form).

---

# Overall Summary

## By Directory

| Directory | Files | Symbols | Up to Date | Issues |
|-----------|-------|---------|------------|--------|
| ComputationalEngine | 6 | 22 | 19 | 3 |
| Model | 6 | 96+ | 94+ | 2 |
| Tools | 15 | 35+ | 31+ | 4 |
| Kernel | 1 | 4 | 4 | 0 |
| **Total** | **28** | **157+** | **148+** | **9** |

## Issues Summary

### High Priority

1. **CreateMomentsDatabase.wl - `uncondVarLongExo`** - First argument changed from `toExogenous` to `model`
2. **CreateMomentsDatabase.wl - `uncondCovLongExo`** - Same issue + `covfun` now required
3. **SolveEulerEq.wl - `addCoeffsSolutionN`** - Missing `buildMaxMaturity` parameter documentation

### Medium Priority

4. **ExogenousEq.wl - `speq`** - Confusing wording ("long-run risk stochastic volatility of inflation")
5. **ProcessModels.wl - `processModels`** - Missing options documentation
6. **Common.wl - `print`** - Missing options documentation
7. **ManageResources.wl - `buildModels`** - Missing options documentation

### Low Priority

8. **ParamQuadSolve.wl - `paramQuadSolve`** - Undocumented return keys and options
9. **ComputeConditionalExpectations.wl** - Undocumented `HoldFirst` attribute

---

## Proposed Fixes

### Issue 1: `uncondVarLongExo` (CreateMomentsDatabase.wl)

**Current:**
```wolfram
uncondVarLongExo::usage = "uncondVarLongExo[toExogenous, expression] computes the unconditional variance of expression using toExogenous to map endogenous variables to exogenous variables, and the default covariance function covLong to compute covariances of exogenous variables."<>"\n"<>"\t\t\t\t\t      "uncondVarLongExo[toExogenous, expression, covfun] uses the covariance function covfun.";
```

**Proposed:**
```wolfram
uncondVarLongExo::usage = "uncondVarLongExo[model, expression, covfun] computes the unconditional variance of expression using the model Association to map endogenous variables to exogenous variables, and covfun to compute covariances of exogenous variables.";
```

---

### Issue 2: `uncondCovLongExo` (CreateMomentsDatabase.wl)

**Current:**
```wolfram
uncondCovLongExo::usage = "uncondCovLongExo[toExogenous, expression1, expression2] computes the unconditional covariance of expression1 and expression2 using toExogenous to map endogenous variables to exogenous variables, and the default covariance function covLong to compute covariances of exogenous variables."<>"\n"<>"\t\t\t\t\t      "uncondCovLongExo[toExogenous, expression1, expression2, covfun] computes the unconditional covariance of expression1 and expression2 using the covariance function covfun.";
```

**Proposed:**
```wolfram
uncondCovLongExo::usage = "uncondCovLongExo[model, expression1, expression2, covfun] computes the unconditional covariance of expression1 and expression2 using the model Association to map endogenous variables to exogenous variables, and covfun to compute covariances of exogenous variables.\nOptions:\n  \"maxMomentsLagsToCreate\" - maximum lags for moments (default 2)\n  \"startSequenceAtLag\" - starting lag (default 0)\n  \"simplifyDownValues\" - whether to simplify (default True)";
```

---

### Issue 3: `addCoeffsSolutionN` (SolveEulerEq.wl)

**Current:**
```wolfram
addCoeffsSolutionN::usage = "addCoeffsSolutionN[model] computes numerical solutions for all coefficient types (wc, pd, bond, nombond) using default parameters and model extraInfo.";
```

**Proposed:**
```wolfram
addCoeffsSolutionN::usage = "addCoeffsSolutionN[model] computes numerical solutions for all coefficient types (wc, pd, bond, nombond) using default parameters and model extraInfo.\naddCoeffsSolutionN[model, buildMaxMaturity] uses the specified maximum maturity (default 12).\naddCoeffsSolutionN[model, buildMaxMaturity, opts] passes options to updateCoeffs.";
```

---

### Issue 4: `speq` (ExogenousEq.wl)

**Current:**
```wolfram
speq::usage = "speq[t] gives the exogenous dynamics of long-run risk stochastic volatility of inflation.";
```

**Proposed:**
```wolfram
speq::usage = "speq[t] gives the exogenous dynamics of stochastic volatility of inflation.";
```

---

### Issue 5: `processModels` (ProcessModels.wl)

**Current:**
```wolfram
processModels::usage = "processModels[modelsCatalog] performs symbolic processing on models, adding coefficient systems and solutions.";
```

**Proposed:**
```wolfram
processModels::usage = "processModels[modelsCatalog] performs symbolic processing on models, adding coefficient systems and solutions.\nprocessModels[modelsCatalog, opts] accepts options from solveCoeffsSystem, updateCoeffs, FindRoot, and RecurrenceTable.\nAdds keys: exogenousEq, endogenousEq, coeffsSystem, coeffsSolution, toStateVars, and more.";
```

---

### Issue 6: `print` (Common.wl)

**Current:**
```wolfram
print::usage = "print[msg] writes msg to $Output using WriteString.";
```

**Proposed:**
```wolfram
print::usage = "print[msg] writes msg to $Output using WriteString.\nOptions:\n  \"Verbose\" -> True|False|\"CI\" (default \"CI\") - controls when printing occurs\n  \"Memory\" -> True|False (default False) - shows memory usage info\n  \"Prefix\" -> String|None (default None) - optional message prefix";
```

---

### Issue 7: `buildModels` (ManageResources.wl)

**Current:**
```wolfram
buildModels::usage = "buildModels[] processes enabled models, compiles functions, computes numerical solutions, and creates moments database.";
```

**Proposed:**
```wolfram
buildModels::usage = "buildModels[] processes enabled models, compiles functions, computes numerical solutions, and creates moments database.\nOptions:\n  \"FromScratch\" -> False - delete all outputs first\n  \"CompileJacobians\" -> True - compile Jacobian functions\n  \"CreateMoments\" -> True - compute moments database\n  \"NumKernels\" -> Automatic - parallel kernels (Automatic|n|None)\n  \"BuildMaxMaturity\" -> 60 - maximum bond maturity\n  \"Models\" -> All - list of shortnames or All\n  \"FileSuffix\" -> \"\" - suffix for checkpoint files\n  \"UpdateManifest\" -> True - update ModelManifest.wl";
```

---

### Issue 8: `paramQuadSolve` (ParamQuadSolve.wl)

**Proposed addition to existing usage:**

Add to usage message:
```
Additional return keys: "Maps" (sub-keys: "Solution", "SignRootMap", "SignRadicandMap", "CoeffMap"), "DeferredVariables", "DeferredEquations".
Key options: "DomainOption", "Assumptions", "Method", "MonomialOrder", "ValidationOption", "ReturnOption", "TimeoutOption", "SimplifyTimeout", "DiagnosticsOption", "OnlyQuadTerms", "SymbolicSignSymbol", "GroebnerMemoryFraction", "GroebnerMemoryFloor", "GroebnerMemoryCap".
```

---

### Issue 9: Conditional Expectations `HoldFirst` (ComputeConditionalExpectations.wl)

**Proposed addition to each usage:**

For `ev`, `var`, `cov`, `corr`, append:
```
The first argument is held unevaluated (HoldFirst attribute).
```

---

## Conclusion

Overall, the codebase has **excellent documentation coverage**. Out of 157+ public symbols across 28 files:

- **95%+ have accurate, up-to-date usage messages**
- Only **9 issues** were identified (<6% of symbols)
- **3 are high priority** (API signature changes)
- **4 are medium priority** (missing options documentation)
- **2 are low priority** (minor omissions)

The Model directory (Parameters.wl, EndogenousEq.wl) has particularly comprehensive documentation with every parameter and equation symbol documented. The Tools directory (FindRootOptim.wl, PipelineMonitor.wl) also has excellent multi-line usage messages with options documented inline.

The most critical updates needed are in `CreateMomentsDatabase.wl` where function signatures have changed but usage messages still reference the old `toExogenous` API.
