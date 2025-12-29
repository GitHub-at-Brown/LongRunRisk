# CoeffName Option

**Location in config:** `config["Compile"]["CoeffName"]`
**Default value:** `"A"`
**Legacy mapping:** `"CoeffName" -> {"Compile", "CoeffName"}` in OptionsConfig.wl:170

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
   └─ splitConfig[config, "Compile"]  ◄── EXTRACTS "CoeffName"
      │
      └─ createCompiledEq[model, resourcesDir, opts...]
         │
         └─ buildKernel[expr, vars, params, "CoeffName" -> value, ...]
            │  ◄── TERMINAL CONSUMER
            ├─ Validates no unexpected coefficient symbols
            └─ Stores in output Association for downstream use

DOWNSTREAM USAGE
│
└─ solveCoeffRoots[..., savedKernel, ...]
   │
   ├─ cName = Lookup[savedKernel, "CoeffName"]
   │
   └─ findRootInterval[..., "CoeffName" -> cName, ...]  ◄── TERMINAL CONSUMER
      └─ Extracts root variable by matching symbol name
```

## Entry Points (Public API)

### `buildModels` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Lines 568-578 | Option declaration in `Options[buildModels]` |
| Line 821 | Pattern: `buildModels[config_Association]` |
| Line 825 | Pattern: `buildModels[opts___?OptionQ]` |

**How received:** Via `OptionsPattern` or config Association
**How forwarded:** Config passed to `buildModelsInternal`

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 96 | Default: `"CoeffName" -> "A"` inside `"Compile"` subsystem |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 308-316 | `splitConfig[config, "Compile"]` definition |
| Line 309 | Extracts: `"CoeffName" -> config["Compile"]["CoeffName"]` |

## Intermediate Forwarders

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 829 | Receives normalized config as parameter |
| Line 998 | Calls `createCompiledEq` with `splitConfig[config, "Compile"]` |

**How forwarded:** Via `splitConfig[config, "Compile"]`

### `createCompiledEq` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 1476-1533 | Function definition |
| Line 1517 | Extracts CoeffName from equation map |
| Line 1518 | Forwards to `buildKernel` with `"CoeffName" -> eqMap[eq]["CoeffName"]` |

**How received:** Via `OptionsPattern[{buildKernel, FunctionCompile, Compile}]`
**How forwarded:** Explicitly passed to `buildKernel`

## Terminal Consumers

### `buildKernel` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Line 83 | Option declaration: `"CoeffName" -> "A"` |
| Line 102 | Extraction: `coeffName = OptionValue["CoeffName"]` |
| Line 133 | Validation: pattern matching for unexpected coeff symbols |
| Line 354 | Storage: `"CoeffName" -> coeffName` in output Association |

**Validation logic:**
```wolfram
Cases[ex0, s_Symbol /; SymbolName[s] === coeffName, Infinity]
```

Used to detect if expression contains coefficient variables that shouldn't be there.

### `findRootInterval` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Line 431 | Option declaration: `"CoeffName" -> "A"` |
| Line 443 | Extraction: `coeffName = OptionValue["CoeffName"]` |
| Lines 456-462 | Root variable extraction via pattern matching |

**Pattern matching logic:**
```wolfram
Cases[condExpr, s_Symbol[0] /; SymbolName[s] === coeffName :> s[0], Infinity]
```

Used to locate the coefficient variable to solve for (e.g., A[0], B[1][0]).

### `solveCoeffRoots` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Line 830 | Retrieves from kernel: `cName = Lookup[savedKernel, "CoeffName"]` |
| Line 862 | Forwards to `findRootInterval[..., "CoeffName" -> cName, ...]` |
| Line 854 | Forwards to `solveND[..., cName, ...]` |

### `solveND` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Lines 212-261 | Function definition |
| Line 245 | Passes `cName` to `safeReduceCall` |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Config | `defaultConfig` | OptionsConfig.wl | 96 | Default value |
| Config | `splitConfig` | OptionsConfig.wl | 308-316 | Extracts Compile options |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 829, 998 | Forwards via splitConfig |
| Forwarder | `createCompiledEq` | FindRootOptim.wl | 1476-1533 | Extracts from eqMap, forwards to buildKernel |
| **Consumer** | `buildKernel` | FindRootOptim.wl | 83, 102, 133, 354 | Validation, storage |
| **Consumer** | `findRootInterval` | FindRootOptim.wl | 431, 443, 456-462 | Root variable extraction |
| Forwarder | `solveCoeffRoots` | SolveEulerEq.wl | 830, 862 | Retrieves from kernel, forwards |
| Consumer | `solveND` | SolveEulerEq.wl | 212-261 | Uses for root-finding |

## Propagation Paths

### Path A: Compilation Phase
```
buildModels["CoeffName" -> "A"]
  → normalizeConfig → config["Compile"]["CoeffName"] = "A"
  → buildModelsInternal[config]
  → splitConfig[config, "Compile"] → "CoeffName" -> "A"
  → createCompiledEq[..., "CoeffName" -> "A", ...]
  → buildKernel[..., "CoeffName" -> "A"]
  → Validates symbols, stores in output Association
```

### Path B: Root-Finding Phase
```
solveCoeffRoots[..., savedKernel, ...]
  → cName = Lookup[savedKernel, "CoeffName"]
  → findRootInterval[..., "CoeffName" -> cName, ...]
  → Extracts root variable by symbol name matching
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Compile and Numerical phases |
| Typical values | `"A"` (wealth-consumption), `"B"` (price-dividend) |
| Purpose | Identifies coefficient variable symbol name |
| Validation | Checks for unexpected coefficient symbols |
| Caching | Stored in kernel Association for reuse |
| Error messages | `buildKernel::badvars`, `findRootInterval::nocoeff` |
