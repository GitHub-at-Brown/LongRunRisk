# PdEquations Option

**Location in config:** `config["Symbolic"]["PdEquations"]`
**Default value:** `"B"`
**Valid values:** `"B"` | `"AB"` | `"Both"`
**Legacy mapping:** `"PdEquations" -> {"Symbolic", "PdEquations"}` in OptionsConfig.wl:166

## Complete Propagation Tree

```
PUBLIC API ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│     └─ mergeNested[{defaultConfig[], user_config}]
│
└─ buildModelsParallel[models, opts...]
   └─ buildModels[...] (recursive)

ORCHESTRATION LAYER
│
└─ buildModelsInternal[config_Association]
   │
   └─ splitConfig[config, "Symbolic"]  ◄── EXTRACTS "PdEquations"
      │
      └─ processModels[modelsCatalog, splitConfig_result...]
         │
         └─ solveCoeffsSystem[model, "PdEquations" -> value]  ◄── TERMINAL CONSUMER
            │
            ├─ If "B" or "Both": computes eqB0 (pd equations)
            ├─ If "AB" or "Both": computes eqAB0 (pd with wc substituted)
            └─ Stores result in model["coeffsParamQuadSolve"]["pd"]["pdMode"]
```

## Entry Points (Public API)

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration in `Options[buildModels]` |
| Line 575 | `"PdEquations" -> "B"` with comment about valid values |
| Line 821 | Pattern: `buildModels[config_Association]` - receives normalized config |
| Line 825 | Pattern: `buildModels[opts___?OptionQ]` - receives flat legacy options |
| Lines 822, 826 | Normalizes via `normalizeConfig[]` |

**How received:** Via `OptionsPattern` in function definition
**How forwarded:** Config passed to `buildModelsInternal`

### `buildModelsParallel` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 1138-1143 | Option declaration |
| Line 1142 | `"PdEquations" -> "B"` |
| Lines 1193-1199 | Forwards to recursive `buildModels` calls |

**How received:** Via `OptionsPattern` with inheritance from `buildModels`
**How forwarded:** Passed to `buildModels` in parallel table

## Configuration Management Layer

### `normalizeConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 166 | Legacy mapping: `"PdEquations" -> {"Symbolic", "PdEquations"}` |
| Lines 245-292 | Converts legacy flat options to nested config Association |
| Lines 256-258 | Maps legacy option to nested path via `legacyOptionMap` |

**Role:** Converts legacy `"PdEquations" -> value` to `config["Symbolic"]["PdEquations"] -> value`

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 300-304 | `splitConfig[config, "Symbolic"]` definition |
| Line 301 | Extracts: `"PdEquations" -> config["Symbolic"]["PdEquations"]` |

**Role:** Extracts `PdEquations` from nested config and returns as `Sequence` of rules

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 76 | Default: `"PdEquations" -> "B"` inside `"Symbolic"` subsystem |

## Intermediate Forwarders

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 829 | Receives normalized config as parameter |
| Line 970 | Extracts Symbolic options: `splitConfig[config, "Symbolic"]` |
| Line 970 | Passes extracted options to `processModels` |

**How received:** Normalized config Association
**How forwarded:** Via `splitConfig[config, "Symbolic"]` which returns `Sequence` including `"PdEquations" -> value`

### `processModels` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Line 79 | `OptionsPattern[{solveCoeffsSystem, updateCoeffs, ...}]` - inherits options |
| Lines 246-247 | Forwards to `solveCoeffsSystem` |

**Forwarding mechanism:**
```wolfram
solveCoeffsSystem[#,
  "PdEquations" -> OptionValue[solveCoeffsSystem, Flatten@{opts}, "PdEquations"]
]
```

**How received:** Via `OptionsPattern` with inheritance from `solveCoeffsSystem`
**How forwarded:** Explicitly extracts and passes `"PdEquations"` option

## Terminal Consumer

### `solveCoeffsSystem` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Lines 637-641 | Option declaration |
| Line 640 | `"PdEquations" -> "B"` |
| Line 770 | **Direct consumption:** `pdMode = OptionValue["PdEquations"]` |
| Line 776 | Stores value: `solB["pdMode"] = pdMode` |
| Line 779 | `If[MatchQ[pdMode, "B" \| "Both"], ...]` - computes eqB0 |
| Line 791 | `If[MatchQ[pdMode, "AB" \| "Both"], ...]` - computes eqAB0 |

**Usage logic:**
```wolfram
pdMode = OptionValue["PdEquations"];
solB["pdMode"] = pdMode;

If[MatchQ[pdMode, "B" | "Both"],
  (* Compute pd equations without wc coefficient substitution *)
  eqB0 = ...
];

If[MatchQ[pdMode, "AB" | "Both"],
  (* Compute pd equations with wc coefficients substituted *)
  eqAB0 = ...
];
```

## Post-Processing Usage

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 687 | Reads stored `pdMode` from model result for hashing |

```wolfram
pdMode = Lookup[model["coeffsParamQuadSolve"]["pd"], "pdMode", "B"];
```

**Note:** This reads the **stored result** of the option (set in Phase 1), not the option itself. Used for cache validation/hashing.

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Entry | `buildModels` | ManageResources.wl | 575, 821-826 | Public API, normalizes config |
| Entry | `buildModelsParallel` | ManageResources.wl | 1142, 1193-1199 | Parallel variant, forwards to buildModels |
| Config | `defaultConfig` | OptionsConfig.wl | 76 | Default value |
| Config | `normalizeConfig` | OptionsConfig.wl | 166, 245-292 | Legacy option mapping |
| Config | `splitConfig` | OptionsConfig.wl | 300-304 | Extracts Symbolic subsystem options |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 829, 970 | Extracts and forwards via splitConfig |
| Forwarder | `processModels` | ProcessModels.wl | 79, 246-247 | Forwards via OptionValue extraction |
| **Consumer** | `solveCoeffsSystem` | ProcessModels.wl | 640, 770, 776, 779, 791 | **Terminal consumer** |

## Propagation Paths

### Path A: Via Normalized Config (Recommended)
```
buildModels["PdEquations" -> "AB"]
  → normalizeConfig → config["Symbolic"]["PdEquations"] = "AB"
  → buildModelsInternal[config]
  → splitConfig[config, "Symbolic"] → "PdEquations" -> "AB"
  → processModels[..., "PdEquations" -> "AB"]
  → solveCoeffsSystem[..., "PdEquations" -> "AB"]
  → pdMode = "AB" → computes eqAB0
```

### Path B: Via Legacy Flat Options
```
buildModels[PdEquations -> "Both"]  (* legacy style *)
  → normalizeConfig maps to config["Symbolic"]["PdEquations"]
  → [continues as Path A]
```

### Path C: Via Parallel Processing
```
buildModelsParallel[models, "PdEquations" -> "B"]
  → ParallelTable → buildModels for each model
  → [continues as Path A for each model]
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Symbolic phase only |
| Impact | Controls which PD equation systems are solved |
| Persistence | Stored in `model["coeffsParamQuadSolve"]["pd"]["pdMode"]` |
| No runtime switching | Decision made once in Phase 1, embedded in model |
