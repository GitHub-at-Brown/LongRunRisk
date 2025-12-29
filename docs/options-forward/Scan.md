# Scan Options

**Location in config:** `config["Numerical"]["Scan"]`
**Default value:** Nested Association (see below)
**Note:** These options are defined in defaultConfig but NOT currently extracted in splitConfig

## Default Structure

```wolfram
"Scan" -> <|
  "FastRootOptions" -> {},
  "UnboundedPad" -> 1000,
  "ScanMethod" -> "Grid"
|>
```

## Configuration Gap

**Important:** The Scan options are defined in `defaultConfig` but are NOT extracted in `splitConfig[config, "Numerical"]`. This means they must be passed directly via options rather than through the buildModels configuration system.

## Complete Propagation Tree

```
ENTRY POINTS (Direct Option Passing Only)
│
├─ scanAndSolve[f, {min, max}, "FastRootOptions" -> {...}, ...]
│
└─ extractIntervalsFromReduce[conds, params, "UnboundedPad" -> n, ...]

ACTUAL USAGE PATH (not from config)
│
└─ solveCoeffRoots[quadSol, kernel, paramsBase, signs, extraParams, opts...]
   │
   ├─ scanOpts = FilterRules[opts, Join[Options[scanAndSolve], Options[FindRoot], Options[fastRoot]]]
   │
   └─ scanAndSolve[First@*f, #, Sequence @@ scanOpts]
      │
      ├─ OptionValue["FastRootOptions"]
      │
      └─ fastRoot[..., Sequence @@ fastOpts]  ◄── TERMINAL CONSUMER
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 119-123 | Default nested structure defined |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | **DOES NOT extract Scan options** |

**Gap:** The splitConfig function for "Numerical" does not include Scan options, creating a disconnect between configuration and usage.

## Direct Usage (Functions That Declare These Options)

### `scanAndSolve` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 1015-1020 | Option declarations |
| Line 1019 | `"FastRootOptions" -> {}` |
| Line 1146 | `OptionValue["FastRootOptions"]` |

### `extractIntervalsFromReduce` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 1282-1286 | Option declarations |
| Line 1284 | `"UnboundedPad" -> 1.*^5` (default different from config!) |
| Line 1297 | `OptionValue["UnboundedPad"]` |

## Intermediate Forwarders

### `solveCoeffRoots` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 803-904 | Function definition |
| Lines 834-837 | Extracts scanOpts via FilterRules |
| Line 867 | `scanAndSolve[..., Sequence @@ scanOpts]` |

### `solveND` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 212-219 | Function definition |
| Line 219 | Accesses UnboundedPad from extractOpts |

### `trySmartIntervals` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 102-141 | Function definition |
| Line 118 | `convertInfinityBounds[a, b, pad]` |

## Terminal Consumers

### `fastRoot` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 517-525 | Option declarations |
| Usage | Receives FastRootOptions from scanAndSolve |

### `convertInfinityBounds` (Internal Helper)

Receives the UnboundedPad value and applies it to convert infinite bounds to finite ones.

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 119-123 | Defines defaults (NOT EXTRACTED) |
| **Gap** | `splitConfig` | OptionsConfig.wl | 320-350 | **Missing extraction** |
| Declares | `scanAndSolve` | FindRootOptim.wl | 1015-1020 | FastRootOptions |
| Declares | `extractIntervalsFromReduce` | FindRootOptim.wl | 1282-1286 | UnboundedPad |
| Forwarder | `solveCoeffRoots` | SolveEulerEq.wl | 834-867 | FilterRules extraction |
| **Consumer** | `fastRoot` | FindRootOptim.wl | 517-525 | FastRootOptions |

## Propagation Paths

### Path A: Direct Option Passing (Working)
```
solveCoeffRoots[..., "FastRootOptions" -> {...}, ...]
  → scanOpts = FilterRules[opts, Options[scanAndSolve]]
  → scanAndSolve[..., Sequence @@ scanOpts]
  → fastRoot[..., Sequence @@ fastOpts]
```

### Path B: Configuration (NOT WORKING)
```
buildModels[<|"Numerical" -> <|"Scan" -> <|"FastRootOptions" -> {...}|>|>|>]
  → normalizeConfig
  → splitConfig[config, "Numerical"]
  → **Scan options NOT extracted**
  → Options lost!
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - root scanning |
| Config gap | Defined but not extracted in splitConfig |
| Workaround | Pass options directly to updateCoeffs/solveCoeffRoots |
| FastRootOptions | Controls fast root-finding algorithm |
| UnboundedPad | Converts infinite bounds to finite (default 1000 in config, 1e5 in function) |
| ScanMethod | Grid-based scanning method |

## Note on Default Discrepancy

The `UnboundedPad` has different defaults:
- In `defaultConfig`: `1000`
- In `extractIntervalsFromReduce`: `1.*^5` (100,000)

Since the config value is not extracted, the function default (1e5) is used.
