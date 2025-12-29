# MaxMaturity Option (Build Subsystem)

**Location in config:** `config["Build"]["MaxMaturity"]`
**Default value:** `120`
**Legacy mapping:** Ambiguous - see OptionsConfig.wl:196-199

## Disambiguation

There are TWO MaxMaturity options in different subsystems:

| Subsystem | Default | Purpose |
|-----------|---------|---------|
| **Build** | 120 | Upper bound for bond coefficient generation during builds |
| Numerical | 12 | Used by SolveEulerEq for numerical solutions |

This document covers the **Build** subsystem version.

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ Forwards via filteredOpts to buildModels

CONFIGURATION LAYER
│
├─ Ambiguous option handling (OptionsConfig.wl:196-199)
│  └─ "MaxMaturity" -> <|
│       "Numerical" -> {"Numerical", "MaxMaturity"},
│       "Build" -> {"Build", "MaxMaturity"}
│     |>
│
└─ splitConfig[config, "Build"]  ◄── EXTRACTS "MaxMaturity"
   │
   └─ "MaxMaturity" -> config["Build"]["MaxMaturity"]

BUILD ORCHESTRATION
│
└─ buildModelsInternal[config_Association]
   │
   └─ maxMaturity = config["Build"]["MaxMaturity"]  (line 835)
      │
      └─ (Variable bound but NOT forwarded to downstream functions)

NUMERICAL PHASE (where maxMaturity is actually used)
│
└─ addCoeffsSolutionN[model]  (SolveEulerEq.wl:1036-1046)
   │
   └─ updateCoeffs[..., "MaxMaturity" -> 12, ...]  ◄── HARD-CODED
      │
      └─ updateCoeffsSol[..., "MaxMaturity" -> 12, ...]
         │
         ├─ updateCoeffsBond[..., maxMaturity, ...]  ◄── TERMINAL CONSUMER
         └─ checkCoeffs[..., maxMaturity, ...]       ◄── TERMINAL CONSUMER
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 150 | Default: `"MaxMaturity" -> 120` (in Build subsystem) |

### Ambiguous Option Handling in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 196-199 | Distinguishes Build vs Numerical MaxMaturity |

```wolfram
"MaxMaturity" -> <|
  "Numerical" -> {"Numerical", "MaxMaturity"},  (* default: 12 *)
  "Build" -> {"Build", "MaxMaturity"}           (* default: 120 *)
|>
```

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 368-377 | `splitConfig[config, "Build"]` definition |
| Line 374 | Extracts: `"MaxMaturity" -> config["Build"]["MaxMaturity"]` |

## Entry Points

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration: `"MaxMaturity" -> 120` |
| Lines 821-826 | Entry patterns (config or legacy options) |

## Build Orchestration

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 835 | `maxMaturity = config["Build"]["MaxMaturity"]` |

**Critical Finding:** The extracted `maxMaturity` variable is bound in the `With` clause but is NOT forwarded to downstream numerical functions.

## Terminal Consumers (in SolveEulerEq.wl)

### `updateCoeffsBond` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 697-712 | Function definition |
| Line 707 | Uses maxMaturity in bond template evaluation |

### `checkCoeffs` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 500-514 | Function definition |
| Line 509 | `Table[..., {n, 1, maxMaturity}]` for "bond" |
| Line 512 | `Table[..., {n, 1, maxMaturity}]` for "nombond" |

## Critical Architecture Issue

**The Build subsystem's MaxMaturity (120) is NOT propagated to the numerical phase.**

### Evidence

`addCoeffsSolutionN` in SolveEulerEq.wl (lines 1036-1046):
```wolfram
addCoeffsSolutionN[model_] := Module[{k},
  k = loadModelKernels[model["shortname"]];
  updateCoeffs[
    model,
    k,
    "UpdatePd" -> True,
    "UpdateBonds" -> True,
    "MaxMaturity" -> 12,        (* <-- HARD-CODED, ignores Build config *)
    "RootSigns" -> All
  ]
]
```

### Implications

| Setting | Effect |
|---------|--------|
| `config["Build"]["MaxMaturity"] = 200` | No effect - bond coefficients computed to 12 years |
| Actual behavior | Always uses MaxMaturity = 12 from hard-coded value |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 150 | Default 120 |
| Config | Ambiguous handling | OptionsConfig.wl | 196-199 | Disambiguation |
| Config | `splitConfig` | OptionsConfig.wl | 368-377 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 568-578, 821-826 | Public API |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 835 | Extracts but doesn't forward |
| Hard-coded | `addCoeffsSolutionN` | SolveEulerEq.wl | 1036-1046 | Uses MaxMaturity=12 |
| Consumer | `updateCoeffsBond` | SolveEulerEq.wl | 697-712 | Bond template evaluation |
| Consumer | `checkCoeffs` | SolveEulerEq.wl | 500-514 | Bond equation validation |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Build phase - bond coefficient range |
| Default | `120` years |
| Actual effect | **None** - value not propagated to consumers |
| Gap | Missing link between buildModelsInternal and addCoeffsSolutionN |
| Hard-coded override | `addCoeffsSolutionN` uses 12 years |
| Status | Configuration value appears unused in current pipeline |
