# SimplifyOptions Option

**Location in config:** `config["Symbolic"]["SimplifyOptions"]`
**Default value:** `{TimeConstraint -> {5, 300}}`
**Legacy mapping:** `"SimplifyOptions" -> {"Symbolic", "SimplifyOptions"}` in OptionsConfig.wl:167

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
   └─ splitConfig[config, "Symbolic"]  ◄── EXTRACTS "SimplifyOptions"
      │
      └─ processModels[modelsCatalog, splitConfig_result...]
         │
         ├─ simplifyCoeffsSystem[...]  ◄── TERMINAL CONSUMER
         │  └─ FullSimplify[..., Sequence @@ simplifyOpts]
         │
         └─ solveCoeffsSystem[...]  ◄── TERMINAL CONSUMER
            │
            ├─ Simplify[solA["Solution"], Sequence @@ simplifyOpts]
            ├─ Simplify[solB["Solution"], Sequence @@ simplifyOpts]
            ├─ FullSimplify[eqA0Unsimplified, Sequence @@ simplifyOpts]
            ├─ FullSimplify[eqB0, Sequence @@ simplifyOpts]
            │
            └─ tryTransforms[..., Sequence @@ simplifyOpts]  ◄── TERMINAL CONSUMER
               └─ Simplify[expr /. tr, Sequence @@ simplifyOpts]
```

## Entry Points (Public API)

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration in `Options[buildModels]` |
| Line 821 | Pattern: `buildModels[config_Association]` |
| Line 825 | Pattern: `buildModels[opts___?OptionQ]` |
| Lines 822, 826 | Normalizes via `normalizeConfig[]` |

**How received:** Via `OptionsPattern` in function definition
**How forwarded:** Config passed to `buildModelsInternal`

### `buildModelsParallel` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 1138-1143 | Option declaration |
| Lines 1193-1199 | Forwards to recursive `buildModels` calls |

**How received:** Via `OptionsPattern` with inheritance from `buildModels`
**How forwarded:** Passed to `buildModels` in parallel table

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 77 | Default: `"SimplifyOptions" -> {TimeConstraint -> {5, 300}}` |

### `normalizeConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 167 | Legacy mapping: `"SimplifyOptions" -> {"Symbolic", "SimplifyOptions"}` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 300-304 | `splitConfig[config, "Symbolic"]` definition |
| Line 302 | Extracts: `"SimplifyOptions" -> config["Symbolic"]["SimplifyOptions"]` |

## Intermediate Forwarders

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 829 | Receives normalized config as parameter |
| Line 970 | Extracts Symbolic options: `splitConfig[config, "Symbolic"]` |

**How received:** Normalized config Association
**How forwarded:** Via `splitConfig[config, "Symbolic"]`

### `processModels` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Line 79 | `OptionsPattern[{solveCoeffsSystem, updateCoeffs, ...}]` - inherits options |
| Line 246 | Forwards to `solveCoeffsSystem` |

**How received:** Via `OptionsPattern` with inheritance from `solveCoeffsSystem`
**How forwarded:** Via OptionsPattern mechanism to downstream functions

## Terminal Consumers

### `simplifyCoeffsSystem` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Lines 556-558 | Option declaration: `"SimplifyOptions" -> {TimeConstraint -> {5, 300}}` |
| Lines 563-566 | Extracts options into `simplifyOpts` |
| Line 587 | `FullSimplify[e, Sequence @@ simplifyOpts]` (for solA) |
| Line 596 | `FullSimplify[e, Sequence @@ simplifyOpts]` (for solB) |

**Option extraction pattern:**
```wolfram
simplifyOpts = Flatten[{
  Evaluate @ FilterRules[Flatten@{opts}, Options[Simplify]],
  Evaluate @ OptionValue["SimplifyOptions"]
}]
```

### `solveCoeffsSystem` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Lines 637-641 | Option declaration: `"SimplifyOptions" -> {TimeConstraint -> {5, 300}}` |
| Lines 646-649 | Extracts options into `simplifyOpts` |
| Line 728 | `Simplify[solA["Solution"], Sequence @@ simplifyOpts]` |
| Line 729 | `Simplify[solB["Solution"], Sequence @@ simplifyOpts]` |
| Line 759 | `FullSimplify[eqA0Unsimplified, Sequence @@ simplifyOpts]` |
| Line 784 | `FullSimplify[eqB0, Sequence @@ simplifyOpts]` |
| Line 796 | `FullSimplify[eqB0/.solA["Solution"], Sequence @@ simplifyOpts]` |
| Lines 733-734 | Forwards to `tryTransforms` |

**Option extraction pattern:**
```wolfram
simplifyOpts = Flatten[{
  Evaluate @ FilterRules[Flatten@{opts}, Options[Simplify]],
  Evaluate @ OptionValue["SimplifyOptions"]
}]
```

### `tryTransforms` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Lines 825-827 | Option declaration: `"SimplifyOptions" -> {TimeConstraint -> {5, 300}}` |
| Lines 847-850 | Extracts options into `simplifyOpts` |
| Lines 860-863 | `Simplify[expr /. tr, Sequence @@ simplifyOpts]` |

**Option extraction pattern:**
```wolfram
simplifyOpts = Flatten[{
  Evaluate @ FilterRules[Flatten@{opts}, Options[Simplify]],
  Evaluate @ OptionValue["SimplifyOptions"]
}]
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API, normalizes config |
| Entry | `buildModelsParallel` | ManageResources.wl | 1138-1275 | Parallel variant |
| Config | `defaultConfig` | OptionsConfig.wl | 77 | Default value |
| Config | `normalizeConfig` | OptionsConfig.wl | 167 | Legacy option mapping |
| Config | `splitConfig` | OptionsConfig.wl | 300-304 | Extracts Symbolic subsystem options |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 829, 970 | Extracts and forwards via splitConfig |
| Forwarder | `processModels` | ProcessModels.wl | 79, 246 | Forwards via OptionsPattern |
| **Consumer** | `simplifyCoeffsSystem` | ProcessModels.wl | 556-558, 563-566, 587, 596 | Passes to FullSimplify |
| **Consumer** | `solveCoeffsSystem` | ProcessModels.wl | 637-649, 728-796 | Passes to Simplify/FullSimplify |
| **Consumer** | `tryTransforms` | ProcessModels.wl | 825-863 | Passes to Simplify |

## Built-in Functions That Receive This Option

| Function | File | Lines |
|----------|------|-------|
| `Simplify` | ProcessModels.wl | 728, 729, 863 |
| `FullSimplify` | ProcessModels.wl | 587, 596, 759, 784, 796 |

## Propagation Paths

### Path A: Via Normalized Config (Recommended)
```
buildModels["SimplifyOptions" -> {TimeConstraint -> {10, 600}}]
  → normalizeConfig → config["Symbolic"]["SimplifyOptions"] = {...}
  → buildModelsInternal[config]
  → splitConfig[config, "Symbolic"] → "SimplifyOptions" -> {...}
  → processModels[..., "SimplifyOptions" -> {...}]
  → solveCoeffsSystem / simplifyCoeffsSystem / tryTransforms
  → Simplify[..., TimeConstraint -> {10, 600}]
```

### Path B: Via Legacy Flat Options
```
buildModels[SimplifyOptions -> {TimeConstraint -> {10, 600}}]
  → normalizeConfig maps to config["Symbolic"]["SimplifyOptions"]
  → [continues as Path A]
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Symbolic phase only |
| Impact | Controls timeout for Simplify/FullSimplify operations |
| Multiple consumers | Yes - 3 functions consume this option |
| Option merging | Combines with any direct Simplify options via FilterRules |
| Default TimeConstraint | `{5, 300}` (5 seconds per sub-expression, 300 total) |
