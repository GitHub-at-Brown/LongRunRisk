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
