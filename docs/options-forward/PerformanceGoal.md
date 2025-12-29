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
