# RootSigns Option

**Location in config:** `config["Numerical"]["RootSigns"]`
**Default value:** `Automatic`
**Valid values:** `Automatic` | `All` | Custom Association
**Legacy mapping:** `"RootSigns" -> {"Numerical", "RootSigns"}` in OptionsConfig.wl:184

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ updateCoeffs[model, kernels, "RootSigns" -> value, ...]

CONFIGURATION LAYER
│
└─ splitConfig[config, "Numerical"]  ◄── EXTRACTS "RootSigns"
   │
   └─ "RootSigns" -> config["Numerical"]["RootSigns"]

NUMERICAL SOLVING PATH
│
└─ updateCoeffsSol[model, kernels, newParams, guessCoeffs, opts...]
   │
   ├─ rootSigns = OptionValue["RootSigns"]
   │
   └─ normalizeRootSigns[rootSigns, extractSignIndex[kernels]]
      │
      └─ Returns: <|"wc" -> {...}, "pd" -> {...}|>
         │
         ├─ computeWcCoeffs[..., rootSignsNorm, rootSigns, ...]
         │  └─ updateCoeffsWcPd["wc", ...]
         │
         └─ computePdCoeffs[..., rootSignsNorm, rootSigns, ...]
            └─ updateCoeffsWcPd["pd", ...]
               │
               └─ solveCoeffRoots[..., signs, ...]  ◄── TERMINAL CONSUMER
                  │
                  ├─ bindUnary[..., "Signs" -> signs]
                  └─ findRootInterval[..., "Signs" -> signs, ...]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 118 | Default: `"RootSigns" -> Automatic` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 320-350 | `splitConfig[config, "Numerical"]` definition |
| Line 343 | Extracts: `"RootSigns" -> config["Numerical"]["RootSigns"]` |

## Intermediate Forwarders

### `updateCoeffsSol` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 333-349 | Option declarations |
| Line 342 | `"RootSigns" -> Automatic` |
| Line 603 | `rootSigns = OptionValue["RootSigns"]` |
| Line 613 | `normalizeRootSigns[rootSigns, extractSignIndex[kernels]]` |

### `normalizeRootSigns` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 456-502 | Function definition |

**Normalization logic:**
- `Automatic`: Filters to non-empty solutions only
- `All`: Returns all sign combinations including empty ones
- Custom Association: Uses explicit sign combinations provided

**Output format:**
```wolfram
<|"wc" -> {sign_tuples...}, "pd" -> {sign_tuples...}|>
```

### `computeWcCoeffs` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 463-505 | Function definition |
| Receives | `rootSignsNorm` (normalized) and `rootSigns` (original) |
| Forwards | To `updateCoeffsWcPd["wc", ...]` |

### `computePdCoeffs` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 508-543 | Function definition |
| Iterates | Through normalized signs for stock-specific B coefficient computation |

## Terminal Consumer

### `solveCoeffRoots` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 803-904 | Function definition |
| Line 807 | Receives `signs : ({} \| {_Integer ..}) : {}` |
| Line 840 | `bindUnary[..., "Signs" -> signs]` |
| Line 862 | `findRootInterval[..., "Signs" -> signs, ...]` |

**Usage:** Individual sign tuples from normalized RootSigns are passed to root-finding functions.

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 118 | Default Automatic |
| Config | `splitConfig` | OptionsConfig.wl | 343 | Extracts from config |
| Entry | `updateCoeffs` | SolveEulerEq.wl | 765-796 | Wrapper |
| Forwarder | `updateCoeffsSol` | SolveEulerEq.wl | 342, 603, 613 | Extracts and normalizes |
| Processor | `normalizeRootSigns` | SolveEulerEq.wl | 456-502 | Converts to explicit tuples |
| Forwarder | `computeWcCoeffs` | SolveEulerEq.wl | 463-505 | Wealth-consumption path |
| Forwarder | `computePdCoeffs` | SolveEulerEq.wl | 508-543 | Price-dividend path |
| **Consumer** | `solveCoeffRoots` | SolveEulerEq.wl | 803-904 | Uses sign tuples |

## Propagation Paths

### Path A: Automatic (Default)
```
buildModels[]  (* no RootSigns specified *)
  → RootSigns = Automatic
  → normalizeRootSigns filters to non-empty solutions
  → Only valid sign combinations processed
```

### Path B: All
```
updateCoeffs[..., "RootSigns" -> All]
  → normalizeRootSigns returns all sign combinations
  → Including empty solutions
```

### Path C: Custom Association
```
updateCoeffs[..., "RootSigns" -> <|"wc" -> {{1, -1}}, "pd" -> {{1, 1}}|>]
  → Uses explicit sign combinations provided
  → Bypasses automatic detection
```

## Value Behaviors

| Value | Behavior |
|-------|----------|
| `Automatic` | Filters to non-empty solutions only |
| `All` | Returns all sign combinations including empty |
| `<\|...\|>` | Uses explicit sign combinations provided |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Numerical phase - root finding |
| Default | `Automatic` |
| Impact | Controls which square root sign combinations to solve |
| Related option | "Signs" (explicit sign values for individual roots) |
| Sign extraction | Via `extractSignIndex[kernels]` |
