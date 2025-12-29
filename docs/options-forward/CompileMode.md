# CompileMode Option

**Location in config:** `config["Compile"]["CompileMode"]`
**Default value:** `"Both"`
**Valid values:** `"Both"` | `"FunctionOnly"` | `"JacobianOnly"`
**Legacy mapping:** `"CompileMode" -> {"Compile", "CompileMode"}` in OptionsConfig.wl:169

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
   ├─ compileMode = config["Compile"]["CompileMode"]
   │
   └─ splitConfig[config, "Compile"]  ◄── EXTRACTS "CompileMode"
      │
      ├─ createCompiledEq[..., "CompileMode" -> "Both", ...]
      │  └─ Standard compilation path
      │
      └─ createCompiledEq[..., "CompileMode" -> "JacobianOnly", ...]
         └─ Override for Jacobian-only compilation (line 1013)

      └─ buildKernel[..., "CompileMode" -> value, ...]
         │  ◄── TERMINAL CONSUMER
         │
         └─ Switch[compileMode,
              "FunctionOnly" → {fC, Missing["NotCompiled"]},
              "JacobianOnly" → {Missing["NotCompiled"], dfC},
              "Both" → {fC, dfC}
            ]
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
| Line 99 | Default: `"CompileMode" -> "Both"` |

### `normalizeConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 169 | Legacy mapping: `"CompileMode" -> {"Compile", "CompileMode"}` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 308-316 | `splitConfig[config, "Compile"]` definition |
| Line 312 | Extracts: `"CompileMode" -> config["Compile"]["CompileMode"]` |

## Intermediate Forwarders

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 829 | Receives normalized config as parameter |
| Line 840 | Extracts: `compileMode = config["Compile"]["CompileMode"]` |
| Lines 995-998 | Standard call to `createCompiledEq` with splitConfig |
| Line 1013 | Override call with `"CompileMode" -> "JacobianOnly"` |

**How forwarded:** Via `splitConfig[config, "Compile"]` or explicit override

### `createCompiledEq` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 1476-1533 | Function definition |
| Line 1480 | Extracts: `compileMode = OptionValue["CompileMode"]` |
| Line 1487 | Uses for filename: different suffix for "JacobianOnly" |
| Line 1495 | Uses for cache key |
| Lines 1513-1520 | Forwards to `buildKernel` via `Sequence @@ buildKernelOpts` |

**How received:** Via `OptionsPattern[{buildKernel, FunctionCompile, Compile}]`
**How forwarded:** Via FilterRules to `buildKernel`

## Terminal Consumer

### `buildKernel` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Line 87 | Option declaration: `"CompileMode" -> "FunctionOnly"` |
| Line 105 | Extraction: `compileMode = OptionValue["CompileMode"]` |
| Line 162 | Controls expression flattening (only for "FunctionOnly") |
| Lines 282-350 | Switch statement controls compilation logic |

**Switch logic (lines 282-350):**
```wolfram
Switch[compileMode,
  "FunctionOnly",
    (* Lines 283-310: Compile only function *)
    fC = If[compiler === "FunctionCompile",
      FunctionCompile[...],
      Compile[...]
    ];
    {fC, Missing["NotCompiled"]},

  "JacobianOnly",
    (* Lines 311-325: Compile only jacobian *)
    dfC = If[compiler === "FunctionCompile",
      FunctionCompile[...],
      Compile[...]
    ];
    {Missing["NotCompiled"], dfC},

  "Both",
    (* Lines 326-346: Compile both function and jacobian *)
    fC = ...;
    dfC = ...;
    {fC, dfC},

  _,
    (* Line 348: Invalid value error *)
    Message[buildKernel::badmode, compileMode];
    $Failed
]
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Config | `defaultConfig` | OptionsConfig.wl | 99 | Default "Both" |
| Config | `normalizeConfig` | OptionsConfig.wl | 169 | Legacy mapping |
| Config | `splitConfig` | OptionsConfig.wl | 308-316 | Extracts Compile options |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 840, 998, 1013 | Extracts, forwards, overrides |
| Forwarder | `createCompiledEq` | FindRootOptim.wl | 1480, 1487, 1495 | Filename, caching |
| **Consumer** | `buildKernel` | FindRootOptim.wl | 87, 105, 162, 282-350 | **Terminal consumer** |

## Propagation Paths

### Path A: Standard Compilation (Both)
```
buildModels["CompileMode" -> "Both"]
  → normalizeConfig → config["Compile"]["CompileMode"] = "Both"
  → buildModelsInternal[config]
  → splitConfig[config, "Compile"] → "CompileMode" -> "Both"
  → createCompiledEq[..., "CompileMode" -> "Both", ...]
  → buildKernel[..., "CompileMode" -> "Both"]
  → Switch: compiles both fC and dfC
  → Returns {fC, dfC}
```

### Path B: Jacobian-Only Override
```
buildModelsInternal[config]
  → createCompiledEq[..., "CompileMode" -> "JacobianOnly", ...]
  → buildKernel[..., "CompileMode" -> "JacobianOnly"]
  → Switch: compiles only dfC
  → Returns {Missing["NotCompiled"], dfC}
```

### Path C: Function-Only
```
buildModels["CompileMode" -> "FunctionOnly"]
  → ... → buildKernel[..., "CompileMode" -> "FunctionOnly"]
  → Switch: compiles only fC
  → Expression flattening enabled (line 162)
  → Returns {fC, Missing["NotCompiled"]}
```

## Mode Comparison

| Mode | Function (fC) | Jacobian (dfC) | Flattening | Use Case |
|------|---------------|----------------|------------|----------|
| "Both" | Compiled | Compiled | No | Full numerical solving |
| "FunctionOnly" | Compiled | Missing | Yes | Fast evaluation without derivatives |
| "JacobianOnly" | Missing | Compiled | No | Derivative-only computations |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Compile phase |
| Default | `"Both"` in config, `"FunctionOnly"` in buildKernel |
| Impact | Controls which objects are compiled (function, jacobian, or both) |
| Cache impact | Different modes produce different cache keys |
| Filename impact | "JacobianOnly" uses different file suffix |
| Error handling | Invalid values trigger `buildKernel::badmode` |
| Override pattern | `buildModelsInternal` can override with "JacobianOnly" |
