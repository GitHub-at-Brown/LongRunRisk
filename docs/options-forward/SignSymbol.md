# SignSymbol Option

**Location in config:** `config["Compile"]["SignSymbol"]`
**Default value:** `"signA"` (string)
**Also exists at:** `config["Symbolic"]["paramQuadSolveOptions"]["SignSymbol"]` as `Symbol["signA"]`
**Legacy mapping:** `"SignSymbol" -> {"Compile", "SignSymbol"}` in OptionsConfig.wl:170 (ambiguous option)

## Type Duality

This option exists in **two forms** depending on context:

| Context | Location | Type | Default |
|---------|----------|------|---------|
| Compile | `config["Compile"]["SignSymbol"]` | String | `"signA"` |
| Symbolic | `config["Symbolic"]["paramQuadSolveOptions"]["SignSymbol"]` | Symbol | `Symbol["signA"]` |

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ buildModels[...] (delegates)

COMPILE SUBSYSTEM PATH
│
└─ buildModelsInternal[config_Association]
   │
   └─ splitConfig[config, "Compile"]  ◄── EXTRACTS "SignSymbol" (string)
      │
      └─ createCompiledEq[model, resourcesDir, opts...]
         │
         └─ buildKernel[..., "SignSymbol" -> "signA", ...]
            │  ◄── TERMINAL CONSUMER
            └─ signSym = OptionValue["SignSymbol"]
               └─ idx = signIdxs[ex0, signSym]

SYMBOLIC SUBSYSTEM PATH
│
└─ buildModelsInternal[config_Association]
   │
   └─ splitConfig[config, "Symbolic"]  ◄── EXTRACTS paramQuadSolveOptions
      │
      └─ processModels → solveCoeffsSystem
         │
         └─ paramQuadSolve[..., "SignSymbol" -> Symbol["signA"], ...]
            │  ◄── TERMINAL CONSUMER
            └─ signHead = OptionValue["SignSymbol"]
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 89 | Symbolic: `"SignSymbol" -> Symbol["signA"]` inside paramQuadSolveOptions |
| Line 97 | Compile: `"SignSymbol" -> "signA"` |

### `ambiguousOptions` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 200-203 | Maps SignSymbol to correct context based on subsystem |

```wolfram
ambiguousOptions = <|
  "SignSymbol" -> <|
    "Symbolic" -> {"Symbolic", "paramQuadSolveOptions", "SignSymbol"},
    "Compile" -> {"Compile", "SignSymbol"}
  |>
|>;
```

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 310 | Compile: `"SignSymbol" -> config["Compile"]["SignSymbol"]` |
| Line 303 | Symbolic: Included in `"paramQuadSolveOptions"` extraction |

## Terminal Consumers (Compile Subsystem)

### `buildKernel` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Line 85 | Option declaration: `"SignSymbol" -> "signA"` |
| Line 103 | Extraction: `signSym = OptionValue["SignSymbol"]` |
| Line 140 | Usage: `idx = signIdxs[ex0, signSym]` |
| Line 354 | Storage: `"SignSymbol" -> signSym` in output Association |

**Purpose:** Detects sign indices in compiled expressions (e.g., signA[1], signA[2]).

### `findRootInterval` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Line 432 | Option declaration: `"SignSymbol" -> "signA"` |
| Line 444 | Extraction: `signSym = OptionValue["SignSymbol"]` |
| Line 469 | Conversion: `signHead = ToExpression[signSym]` |

**Purpose:** Converts string to symbol for pattern matching in root-finding.

## Terminal Consumer (Symbolic Subsystem)

### `paramQuadSolve` in `Kernel/ComputationalEngine/ParamQuadSolve.wl`

| Location | What happens |
|----------|--------------|
| Line 81 | Option declaration: `"SignSymbol" -> signA` (symbol, not string) |
| Line 117 | Extraction: `signHead = OptionValue["SignSymbol"]` |

**Purpose:** Uses symbol directly for creating sign variables (signA[k]) in parametric solutions.

## Intermediate Forwarders

### `solveCoeffRoots` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Line 831 | Retrieves: `sName = Lookup[savedKernel, "SignSymbol"]` |
| Line 862 | Forwards: `findRootInterval[..., "SignSymbol" -> sName, ...]` |

### `safeReduceCall` in `Kernel/ComputationalEngine/SolveEulerEq.wl`

| Location | What happens |
|----------|--------------|
| Line 88 | Forwards to `findRootInterval[..., "SignSymbol" -> sName, ...]` |

### `buildEqMapFromModel` in `Kernel/Tools/FindRootOptim.wl`

| Location | What happens |
|----------|--------------|
| Lines 1439, 1449, 1461 | Generates SignSymbol values for equation maps |

## Summary Table

| Layer | Function | File | Lines | Role | Type |
|-------|----------|------|-------|------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 89, 97 | Default values | Symbol/String |
| Config | `ambiguousOptions` | OptionsConfig.wl | 200-203 | Context mapping | N/A |
| Config | `splitConfig` | OptionsConfig.wl | 303, 310 | Extraction | Both |
| Orchestrator | `buildModelsInternal` | ManageResources.wl | 829, 998 | Forwards | Both |
| Forwarder | `createCompiledEq` | FindRootOptim.wl | 1476-1533 | Forwards to buildKernel | String |
| **Consumer** | `buildKernel` | FindRootOptim.wl | 85, 103, 140, 354 | Sign index detection | String |
| **Consumer** | `findRootInterval` | FindRootOptim.wl | 432, 444, 469 | Pattern matching | String |
| Forwarder | `solveCoeffRoots` | SolveEulerEq.wl | 831, 862 | Retrieves, forwards | String |
| **Consumer** | `paramQuadSolve` | ParamQuadSolve.wl | 81, 117 | Sign variables | Symbol |

## Propagation Paths

### Path A: Compile Subsystem (String Form)
```
buildModels["SignSymbol" -> "signB"]
  → normalizeConfig → config["Compile"]["SignSymbol"] = "signB"
  → buildModelsInternal[config]
  → splitConfig[config, "Compile"] → "SignSymbol" -> "signB"
  → createCompiledEq → buildKernel
  → signSym = OptionValue["SignSymbol"] → "signB"
  → signIdxs[expr, "signB"] detects signB[1], signB[2], etc.
```

### Path B: Symbolic Subsystem (Symbol Form)
```
buildModels[<|"Symbolic" -> <|"paramQuadSolveOptions" -> <|"SignSymbol" -> signB|>|>|>]
  → normalizeConfig → merges with defaults
  → splitConfig[config, "Symbolic"]
  → solveCoeffsSystem → paramQuadSolve
  → signHead = OptionValue["SignSymbol"] → signB (symbol)
  → Creates signB[k] variables in parametric solutions
```

### Path C: Root-Finding (String to Symbol Conversion)
```
solveCoeffRoots[..., savedKernel, ...]
  → sName = Lookup[savedKernel, "SignSymbol"] → "signA" (string)
  → findRootInterval[..., "SignSymbol" -> "signA", ...]
  → signHead = ToExpression[signSym] → signA (symbol)
  → Creates rules: signA[1] -> +1, signA[2] -> -1, etc.
```

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Type duality | String in Compile, Symbol in Symbolic |
| Default values | `"signA"` (Compile), `Symbol["signA"]` (Symbolic) |
| Ambiguous option | Handled by `ambiguousOptions` in OptionsConfig.wl |
| Primary usage | Detecting/creating sign variables like signA[1], signA[2] |
| Conversion | `ToExpression[signSym]` converts string to symbol when needed |
| Caching | Stored in kernel Association for reuse |
