Yes — I created a **single self‑contained `.wl` package file** that:

* loads `OptionsValidation` (via `Needs["OptionsValidation`"]`, and falls back to `Get["`OptionsValidation`"]`if you vendor`OptionsValidation.m`)
* registers **all `CheckOption[...] = ...` value tests** for the *true option owners* we identified
* calls `SetDefaultOptionsValidation[...]` for those owners (so `SetOptions[owner, ...]` gets validated too)
* is written so you can **install the rules for any paclet context** (defaults to `"LongRunRisk`"`)

📄 **Download:** [LongRunRisk-OptionsValidationRules.wl](sandbox:/mnt/data/LongRunRisk-OptionsValidationRules.wl)

---

## How to use it in your paclet

Load it once (e.g. from `Kernel/init.m` or your main package file), then run the installer:

```wl
Get["/path/to/LongRunRisk-OptionsValidationRules.wl"];

LongRunRisk`OptionsValidationRules`InstallOptionsValidationRules["LongRunRisk`"];
(* If your paclet context differs, pass it here instead. *)
```

It returns the list of owner symbols it registered.

---

## What’s included / covered

The file installs `CheckOption` rules for these (owners):

* `buildModelsInternal` (e.g. `"Models"`, `"CompileJacobians"`, `"BuildMaxMaturity"`, `"FromScratch"`, …)
* `setupParallelKernels` (`"NumKernels"`)
* `solveCoeffsSystem` (`"PdEquations"`, `"SimplifyOptions"`)
* `paramQuadSolve` (domain/memory/return controls + `"SymbolicSignSymbol"`)
* `simplifyWithDummySubstitution` (`"Level0Pattern"`, `"SimplifyFunction"`)
* `buildKernel` (compile controls + `"CompileSignSymbol"`)
* `getStartingValues` (`"initialGuess"`)
* `updateCoeffsSol` (`"MaxMaturity"`, `"RootSigns"`, update flags)
* `solveCoeffRoots` (`"Signs"` as a ±1 tuple)
* `solveND`, `checks`
* `fastRoot`, `scanAndSolve`, `extractIntervalsFromReduce`
* `createDatabase`, `uncondCovLongExo`, `lagStateVarst`
* `growth`, `timeSeriesVector`, `g`
* `visualizeCoeffs`, `yieldCurve`, `checkModels`

It also sets a standard invalid‑value message on each owner (`owner::optx`).

---

## Assumptions this file matches

This file matches the **post‑refactor option names** we discussed:

* `"BuildMaxMaturity"` (build/process max maturity split)
* `"SymbolicSignSymbol"` vs `"CompileSignSymbol"` (split from `SignSymbol`)
* `fastRoot` uses `"ReturnType"` (not `"Return"`)

If you decide on different final names, tell me what you chose and I’ll regenerate the file accordingly (same structure, just rename the option keys and predicates).
