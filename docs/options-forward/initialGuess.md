# initialGuess Option

**Location in config:** `config["Numerical"]["initialGuess"]`
**Default value:** `<|"Ewc" -> {4}, "Epd" -> {{4}}|>`
**Legacy mapping:** `"initialGuess" -> {"Numerical", "initialGuess"}` in OptionsConfig.wl:183

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
├─ toNum[model, opts...]
│  └─ Direct usage via model["extraInfo"]["initialGuess"]
│
└─ updateCoeffs[model, kernels, opts...]
   └─ Direct option forwarding

ORCHESTRATION LAYER
│
└─ buildModelsInternal[config_Association]
   │
   └─ splitConfig[config, "Numerical"]  ◄── EXTRACTS "initialGuess"
      │
      └─ (options forwarded to numerical solving functions)

NUMERICAL SOLVING PATH
│
└─ updateCoeffs[model, kernels, newParams, opts...]
   │
   └─ updateCoeffsSol[model, kernels, newParams, opts...]
      │
      └─ getStartingValues[infoModel, opts...]  ◄── TERMINAL CONSUMER
         │
         ├─ Extracts "Ewc" and "Epd" initial guesses
         └─ Returns starting values for root finding
```

## Default Structure

```wolfram
"initialGuess" -> <|
  "Ewc" -> {4},       (* Initial guess for wealth-consumption ratio *)
  "Epd" -> {{4}}      (* Initial guess for price-dividend ratios *)
|>
```

## Entry Points (Public API)

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration in `Options[buildModels]` |
| Line 821 | Pattern: `buildModels[config_Association]` |

**How received:** Via config Association
**How forwarded:** Via `splitConfig[config, "Numerical"]`

### `toNum` in `Kernel/Tools/ToNumber.wl`

| Location | What happens |
|----------|--------------|
| Lines 64-98 | Function definition |
| Line 65 | Checks `model["extraInfo"]["initialGuess"]` |

**How received:** Via model's extraInfo or options
**How used:** Directly passed to `updateCoeffs`

### `updateCoeffs` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 765-796 | Function definition |
| Lines 765-771 | Inherits options from `updateCoeffsSol` |

**How received:** Via `OptionsPattern`
**How forwarded:** To `updateCoeffsSol`

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 105 | Default: `"initialGuess" -> <\|"Ewc" -> {4}, "Epd" -> {{4}}\|>` |

### `normalizeConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 183 | Legacy mapping: `"initialGuess" -> {"Numerical", "initialGuess"}` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Line 321 | Extracts: `"initialGuess" -> config["Numerical"]["initialGuess"]` |

## Intermediate Forwarders

### `updateCoeffsSol` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 333-349 | Option declarations |
| Lines 575-690 | Function implementation |
| Line 617 | FilterRules extracts options |

**How received:** Via `OptionsPattern[{updateCoeffsSol, solveCoeffRoots, checks, FindRoot, RecurrenceTable}]`
**How forwarded:** To `getStartingValues` and other solving functions

## Terminal Consumer

### `getStartingValues` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 1001-1029 | Function definition |
| Lines 1001-1003 | Option declaration: `"initialGuess" -> <\|"Ewc" -> {4}, "Epd" -> {{4}}\|>` |
| Line 1013 | Extraction: `OptionValue[getStartingValues, Flatten @ {opts}, {"initialGuess"}]` |
| Lines 1023-1024 | Fallback to `infoModel["initialGuess"]` |

**Usage:**
- Extracts "Ewc" initial guess for wealth-consumption ratio solving
- Extracts "Epd" initial guesses for price-dividend ratio solving
- Returns starting values for numerical root finding

## Model-Specific Overrides

### `Catalog.wl` - Model Extra Info

| Model | Location | initialGuess Value |
|-------|----------|-------------------|
| CEE | Lines 1816-1819 | `<\|"Ewc" -> {6.25}, "Epd" -> {{5.5}}\|>` |
| BKY | Lines 1847-1850 | `<\|"Ewc" -> {1, 15}, "Epd" -> {{4}}\|>` |
| NRC | Lines 1893-1896 | `<\|"Ewc" -> {4.6}, "Epd" -> {{4.7}, {6.2}, {5.5}}\|>` |
| NRCLLR | Lines 1938-1941 | `<\|"Ewc" -> {4.6}, "Epd" -> {{6}, {7}, {4.6}}\|>` |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Entry | `toNum` | ToNumber.wl | 64-98 | Direct API |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Direct API |
| Config | `defaultConfig` | OptionsConfig.wl | 105 | Default value |
| Config | `normalizeConfig` | OptionsConfig.wl | 183 | Legacy mapping |
| Config | `splitConfig` | OptionsConfig.wl | 320-350 | Extracts Numerical options |
| Data | `modelsExtraInfo` | Catalog.wl | Various | Model-specific overrides |
| Forwarder | `updateCoeffsSol` | SolveEulerEq.wl | 333-690 | Passes to getStartingValues |
| **Consumer** | `getStartingValues` | SolveEulerEq.wl | 1001-1029 | **Terminal consumer** |

## Propagation Paths

### Path A: Configuration-driven
```
buildModels[<|"Numerical" -> <|"initialGuess" -> <|"Ewc" -> {5}|>|>|>]
  → normalizeConfig → merges with defaults
  → splitConfig[config, "Numerical"] → "initialGuess" -> <|...|>
  → updateCoeffs → updateCoeffsSol → getStartingValues
  → Uses provided initial guess
```

### Path B: Model-specific override
```
toNum[model, ...]
  → model["extraInfo"]["initialGuess"] → <|"Ewc" -> {6.25}|>
  → updateCoeffs[..., "initialGuess" -> model["extraInfo"]["initialGuess"]]
  → getStartingValues uses model-specific values
```

### Path C: Default fallback
```
updateCoeffs[model, kernels, params]  (* no initialGuess specified *)
  → updateCoeffsSol → getStartingValues
  → Falls back to infoModel["initialGuess"]
  → Falls back to default <|"Ewc" -> {4}, "Epd" -> {{4}}|>
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase |
| Structure | Association with "Ewc" and "Epd" keys |
| "Ewc" | List of initial guesses for wealth-consumption ratio |
| "Epd" | List of lists for price-dividend ratios |
| Override priority | User options > Model extraInfo > Default config |
| Model customization | 4 models have custom initialGuess values |
| Terminal consumer | `getStartingValues` |
