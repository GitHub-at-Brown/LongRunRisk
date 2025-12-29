# Signs Option

**Location in config:** `config["Numerical"]["Signs"]`
**Default value:** `{}`
**Legacy mapping:** `"Signs" -> {"Numerical", "Signs"}` in OptionsConfig.wl:185

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ solveCoeffRoots[..., signs, ...]
   └─ Direct parameter

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]  ◄── EXTRACTS "Signs"
   │
   └─ "Signs" -> config["Numerical"]["Signs"]

NUMERICAL SOLVING PATH
│
└─ solveCoeffRoots[quadSol, kernel, paramsBase, signs, extraParams, opts...]
   │
   ├─ bindUnary[kernel, paramsAll, "Signs" -> signs]  ◄── TERMINAL CONSUMER
   │  │
   │  └─ signs = OptionValue["Signs"]
   │     └─ Binds sign values into compiled kernel
   │
   └─ findRootInterval[conds, paramsAll, "Signs" -> signs, ...]  ◄── TERMINAL CONSUMER
      │
      └─ signs = OptionValue["Signs"]
         └─ Creates signsRule: Table[signHead[i] -> signs[[i]], ...]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 124 | Default: `"Signs" -> {}` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Line 344 | Extracts: `"Signs" -> config["Numerical"]["Signs"]` |

## Terminal Consumers

### `bindUnary` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 363-424 | Function definition |
| Lines 363-365 | Option declaration: `"Signs" -> {}` |
| Line 374 | `signs = OptionValue["Signs"]` |
| Lines 396-407 | Validates and processes signs array |
| Lines 415-420 | Creates specialized functions with signs bound |

**Validation:**
- Checks length matches expected count (maxIdx from kernel)
- Each element must be ±1
- Returns error message if validation fails

### `findRootInterval` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 430-510 | Function definition |
| Lines 430-434 | Option declaration: `"Signs" -> {}` |
| Line 445 | `signs = OptionValue["Signs"]` |
| Line 470-472 | Creates signsRule substitution table |

**Usage:**
```wolfram
signsRule = Table[signHead[i] -> signs[[i]], {i, Length@signs}]
```

### `solveCoeffRoots` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 803-904 | Function definition |
| Line 807 | Receives `signs : ({} \| {_Integer ..}) : {}` as parameter |
| Line 840 | `bindUnary[savedKernel, paramsAll, "Signs" -> signs]` |
| Line 862 | `findRootInterval[..., "Signs" -> signs, ...]` |
| Line 874 | Creates signsRule for analytical substitution |

### `safeReduceCall` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 85-91 | Helper function |
| Line 88 | `findRootInterval[..., "Signs" -> signs, ...]` |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 124 | Default {} |
| Config | `splitConfig` | OptionsConfig.wl | 344 | Extracts from config |
| **Consumer** | `bindUnary` | FindRootOptim.wl | 363-424 | Binds to compiled kernel |
| **Consumer** | `findRootInterval` | FindRootOptim.wl | 430-510 | Creates substitution rules |
| Orchestrator | `solveCoeffRoots` | SolveEulerEq.wl | 803-904 | Forwards to consumers |
| Wrapper | `safeReduceCall` | SolveEulerEq.wl | 85-91 | Timeout wrapper |

## Propagation Paths

### Path A: Configuration-driven
```
buildModels[<|"Numerical" -> <|"Signs" -> {1, -1}|>|>]
  → normalizeConfig → merges with defaults
  → splitConfig[config, "Numerical"] → "Signs" -> {1, -1}
  → (flows through options to solveCoeffRoots)
```

### Path B: Direct Parameter (solveCoeffRoots)
```
solveCoeffRoots[quadSol, kernel, params, {1, -1}, ...]
  → bindUnary[..., "Signs" -> {1, -1}]
  → Binds signA[1] -> 1, signA[2] -> -1
```

### Path C: Forwarded via RootSigns
```
RootSigns -> Automatic
  → normalizeRootSigns extracts sign combinations
  → solveCoeffRoots called for each combination
  → Signs passed as individual tuples
```

## Relationship with RootSigns

| Aspect | Signs | RootSigns |
|--------|-------|-----------|
| Level | Low-level (individual tuple) | High-level (combination selection) |
| Default | `{}` | `Automatic` |
| Usage | Direct sign values | Selection mode |
| Consumer | bindUnary, findRootInterval | normalizeRootSigns |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - root finding |
| Default | `{}` (empty list - no signs) |
| Valid values | List of -1 and 1 |
| Validation | Length must match sign count in kernel |
| Purpose | Selects square root branches (±√x) |
| Related option | RootSigns (high-level selection) |
| Error handling | Messages for length mismatch or invalid values |
