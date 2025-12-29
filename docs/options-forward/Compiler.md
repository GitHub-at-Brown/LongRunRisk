# Compiler Option

**Location in config:** `config["Compile"]["Compiler"]`
**Default value:** `"Compile"`
**Valid values:** `"Compile"` | `"FunctionCompile"`
**Legacy mapping:** `"Compiler" -> {"Compile", "Compiler"}` in OptionsConfig.wl:168

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
   ├─ compilerChoice = config["Compile"]["Compiler"]
   │
   └─ splitConfig[config, "Compile"]  ◄── EXTRACTS "Compiler"
      │
      └─ createCompiledEq[model, resourcesDir, opts...]
         │
         └─ buildKernel[..., "Compiler" -> value, ...]
            │  ◄── TERMINAL CONSUMER
            │
            └─ compileWithDiagnostics[..., useCompiler, ...]
               │
               ├─ If "FunctionCompile": FunctionCompile[...]
               └─ If "Compile": Compile[...]
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
| Line 100 | Default: `"Compiler" -> "Compile"` |

### `normalizeConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 168 | Legacy mapping: `"Compiler" -> {"Compile", "Compiler"}` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 308-316 | `splitConfig[config, "Compile"]` definition |
| Line 313 | Extracts: `"Compiler" -> config["Compile"]["Compiler"]` |

## Intermediate Forwarders

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 829 | Receives normalized config as parameter |
| Line 841 | Extracts: `compilerChoice = config["Compile"]["Compiler"]` |
| Lines 995-998 | Calls `createCompiledEq` with `splitConfig[config, "Compile"]` |
| Line 1014 | Also passes directly as `"Compiler" -> compilerChoice` |

**How forwarded:** Via `splitConfig[config, "Compile"]` or explicit rule

### `createCompiledEq` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 1476-1533 | Function definition |
| Line 1481 | Extracts: `compilerChoice = ("Compiler" /. ...) /. "Compiler" -> "Compile"` |
| Lines 1513-1520 | Forwards to `buildKernel` via `Sequence @@ buildKernelOpts` |

**How received:** Via `OptionsPattern[{buildKernel, FunctionCompile, Compile}]`
**How forwarded:** Via FilterRules to `buildKernel`

## Terminal Consumer

### `buildKernel` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Line 88 | Option declaration: `"Compiler" -> "Compile"` |
| Line 106 | Extraction: `compiler = OptionValue["Compiler"]` |
| Lines 180-199 | Uses compiler value to determine compilation path |
| Line 246 | Passes to `compileWithDiagnostics[..., useCompiler, ...]` |

**Compilation logic:**
```wolfram
Switch[compiler,
  "FunctionCompile",
    FunctionCompile[func, ...],
  "Compile",
    Compile[func, ..., CompilationTarget -> "C", ...]
]
```

### `compileWithDiagnostics` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Line 246 | Receives `useCompiler` parameter |
| Internal | Selects between FunctionCompile and Compile based on useCompiler value |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Config | `defaultConfig` | OptionsConfig.wl | 100 | Default "Compile" |
| Config | `normalizeConfig` | OptionsConfig.wl | 168 | Legacy mapping |
| Config | `splitConfig` | OptionsConfig.wl | 308-316 | Extracts Compile options |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 841, 998, 1014 | Extracts and forwards |
| Forwarder | `createCompiledEq` | FindRootOptim.wl | 1476-1533 | Extracts, forwards to buildKernel |
| **Consumer** | `buildKernel` | FindRootOptim.wl | 88, 106, 180-199 | **Terminal consumer** |
| Internal | `compileWithDiagnostics` | FindRootOptim.wl | 246 | Actual compilation call |

## Propagation Paths

### Path A: Via Normalized Config (Recommended)
```
buildModels["Compiler" -> "FunctionCompile"]
  → normalizeConfig → config["Compile"]["Compiler"] = "FunctionCompile"
  → buildModelsInternal[config]
  → splitConfig[config, "Compile"] → "Compiler" -> "FunctionCompile"
  → createCompiledEq[..., "Compiler" -> "FunctionCompile", ...]
  → buildKernel[..., "Compiler" -> "FunctionCompile"]
  → compiler = "FunctionCompile"
  → FunctionCompile[...]
```

### Path B: Default (Compile)
```
buildModels[]
  → normalizeConfig → config["Compile"]["Compiler"] = "Compile"
  → ... → buildKernel
  → compiler = "Compile"
  → Compile[..., CompilationTarget -> "C", ...]
```

## Compiler Comparison

| Aspect | "Compile" | "FunctionCompile" |
|--------|-----------|-------------------|
| Backend | Traditional Compile | LLVM-based |
| Target | C code generation | Native compilation |
| Speed | Faster compilation | Faster execution |
| Compatibility | All platforms | Limited platforms |
| Error handling | RuntimeOptions | CompilerRuntimeErrorAction |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Compile phase only |
| Default | `"Compile"` |
| Impact | Determines which compilation backend is used |
| Terminal consumer | `buildKernel` (and `compileWithDiagnostics`) |
| Related options | PerformanceGoal, RuntimeOptions, CompilationTarget |
