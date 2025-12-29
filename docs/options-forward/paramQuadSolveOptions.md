# paramQuadSolveOptions Option

**Location in config:** `config["Symbolic"]["paramQuadSolveOptions"]`
**Default value:** Nested Association with 13 keys (see below)
**Legacy mapping:** None (nested options passed as Association)

## Default Structure

```wolfram
"paramQuadSolveOptions" -> <|
  "DomainOption" -> Reals,
  "Assumptions" -> Automatic,
  "Method" -> Automatic,
  "MonomialOrder" -> Automatic,
  "ValidationOption" -> True,
  "ReturnOption" -> "All",
  "TimeoutOption" -> 600,
  "SimplifyTimeout" -> Automatic,
  "DiagnosticsOption" -> False,
  "OnlyQuadTerms" -> False,
  "SignSymbol" -> Symbol["signA"],
  "GroebnerMemoryFraction" -> 0.5,
  "GroebnerMemoryFloor" -> 1*1024^3,
  "GroebnerMemoryCap" -> 16*1024^3
|>
```

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
   └─ splitConfig[config, "Symbolic"]  ◄── EXTRACTS "paramQuadSolveOptions"
      │
      └─ processModels[modelsCatalog, splitConfig_result...]
         │
         └─ solveCoeffsSystem[model, opts...]
            │
            ├─ Extracts: paramQuadSolveOpts = OptionValue["paramQuadSolveOptions"]
            │
            ├─ paramQuadSolve[wcEqns, wcVars, Sequence @@ paramQuadSolveOpts]
            │  └─ Solves wc coefficient system  ◄── TERMINAL CONSUMER
            │
            └─ paramQuadSolve[pdEqns, pdVars, Sequence @@ paramQuadSolveOpts]
               └─ Solves pd coefficient system  ◄── TERMINAL CONSUMER
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
| Lines 78-93 | Default nested Association with 13 keys |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 300-304 | `splitConfig[config, "Symbolic"]` definition |
| Line 303 | Extracts: `"paramQuadSolveOptions" -> config["Symbolic"]["paramQuadSolveOptions"]` |

### `ambiguousOptions` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 200-203 | Maps SignSymbol to correct context (Symbolic vs Compile) |

## Intermediate Forwarders

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 829 | Receives normalized config as parameter |
| Lines 968-970 | Calls `processModels` with `splitConfig[config, "Symbolic"]` |

**How received:** Normalized config Association
**How forwarded:** Via `splitConfig[config, "Symbolic"]`

### `processModels` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Lines 77-79 | `OptionsPattern[{solveCoeffsSystem, ...}]` - inherits options |
| Lines 244-250 | Calls `solveCoeffsSystem` |

**How received:** Via `OptionsPattern` with inheritance from `solveCoeffsSystem`
**How forwarded:** Via OptionsPattern mechanism

### `solveCoeffsSystem` in `Kernel/Model/ProcessModels.wl`

| Location | What happens |
|----------|--------------|
| Lines 637-641 | Option declaration: `"paramQuadSolveOptions" -> {}` |
| Line 650 | Extracts: `paramQuadSolveOpts = OptionValue["paramQuadSolveOptions"]` |
| Lines 684-691 | First call to `paramQuadSolve` (wc system) |
| Lines 694-701 | Second call to `paramQuadSolve` (pd system) |

**Forwarding mechanism:**
```wolfram
paramQuadSolve[eqns, vars, Sequence @@ paramQuadSolveOpts]
```

## Terminal Consumer

### `paramQuadSolve` in `Kernel/ComputationalEngine/ParamQuadSolve.wl`

| Location | What happens |
|----------|--------------|
| Lines 70-85 | Option declarations for all 13 sub-options |
| Lines 104-347 | Implementation uses all options via `OptionValue[]` |

**Option declarations:**
```wolfram
paramQuadSolve // Options = {
  "DomainOption" -> Reals,
  "Assumptions" -> Automatic,
  "Method" -> Automatic,
  "MonomialOrder" -> Automatic,
  "ValidationOption" -> True,
  "ReturnOption" -> "All",
  "TimeoutOption" -> 600,
  "SimplifyTimeout" -> Automatic,
  "DiagnosticsOption" -> False,
  "OnlyQuadTerms" -> False,
  "SignSymbol" -> signA,  (* Symbol form *)
  "GroebnerMemoryFraction" -> 0.5,
  "GroebnerMemoryFloor" -> 1*1024^3,
  "GroebnerMemoryCap" -> 16*1024^3
}
```

**Key option extractions (lines 104-121):**
```wolfram
domain = OptionValue["DomainOption"],
assumptions = OptionValue["Assumptions"],
method = OptionValue["Method"],
monomialOrder = OptionValue["MonomialOrder"],
validate = OptionValue["ValidationOption"],
returnOpt = OptionValue["ReturnOption"],
timeout = OptionValue["TimeoutOption"],
simplifyTimeout = OptionValue["SimplifyTimeout"],
diagnostics = OptionValue["DiagnosticsOption"],
onlyQuad = OptionValue["OnlyQuadTerms"],
signHead = OptionValue["SignSymbol"],
memFraction = OptionValue["GroebnerMemoryFraction"],
memFloor = OptionValue["GroebnerMemoryFloor"],
memCap = OptionValue["GroebnerMemoryCap"]
```

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API, normalizes config |
| Entry | `buildModelsParallel` | ManageResources.wl | 1138-1275 | Parallel variant |
| Config | `defaultConfig` | OptionsConfig.wl | 78-93 | Default nested Association |
| Config | `splitConfig` | OptionsConfig.wl | 300-304 | Extracts Symbolic subsystem options |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 829, 968-970 | Extracts and forwards via splitConfig |
| Forwarder | `processModels` | ProcessModels.wl | 77-79, 244-250 | Forwards via OptionsPattern |
| Forwarder | `solveCoeffsSystem` | ProcessModels.wl | 637-650, 684-701 | Extracts and forwards via Sequence @@ |
| **Consumer** | `paramQuadSolve` | ParamQuadSolve.wl | 70-85, 104-347 | **Terminal consumer** |

## Propagation Paths

### Path A: Via Normalized Config (Recommended)
```
buildModels[<|"Symbolic" -> <|"paramQuadSolveOptions" -> <|"TimeoutOption" -> 1200|>|>|>]
  → normalizeConfig → merges with defaults
  → buildModelsInternal[config]
  → splitConfig[config, "Symbolic"] → "paramQuadSolveOptions" -> <|...|>
  → processModels[..., "paramQuadSolveOptions" -> <|...|>]
  → solveCoeffsSystem extracts via OptionValue
  → paramQuadSolve[eqns, vars, Sequence @@ paramQuadSolveOpts]
  → Each sub-option extracted via OptionValue
```

## Sub-Option Descriptions

| Option | Default | Purpose |
|--------|---------|---------|
| DomainOption | Reals | Domain for Solve (Reals, Complexes) |
| Assumptions | Automatic | Assumptions passed to Solve |
| Method | Automatic | Solve method |
| MonomialOrder | Automatic | Groebner basis monomial ordering |
| ValidationOption | True | Whether to validate solutions |
| ReturnOption | "All" | What to return ("All", "First", etc.) |
| TimeoutOption | 600 | Timeout in seconds |
| SimplifyTimeout | Automatic | Timeout for simplification |
| DiagnosticsOption | False | Enable diagnostic output |
| OnlyQuadTerms | False | Only process quadratic terms |
| SignSymbol | Symbol["signA"] | Symbol for sign variables |
| GroebnerMemoryFraction | 0.5 | Memory fraction for Groebner |
| GroebnerMemoryFloor | 1 GB | Minimum memory for Groebner |
| GroebnerMemoryCap | 16 GB | Maximum memory for Groebner |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Symbolic phase only |
| Impact | Controls polynomial solving algorithm behavior |
| Nested structure | Yes - Association with 13 keys |
| Two invocations | Called twice: once for wc, once for pd coefficients |
| No transformation | Passed unchanged from config to consumer |
| SignSymbol context | Uses Symbol form (not String like Compile subsystem) |
