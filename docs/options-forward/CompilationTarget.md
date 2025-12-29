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
