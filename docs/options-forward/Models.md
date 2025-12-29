# Models Option

**Location in config:** `config["Build"]["Models"]`
**Default value:** `All`
**Legacy mapping:** `"Models" -> {"Build", "Models"}` in OptionsConfig.wl:180

## Complete Propagation Tree

```
ENTRY POINTS
│
├─ buildModels[config_Association | opts...]
│  └─ normalizeConfig[config | opts]
│
└─ buildModelsParallel[models, opts...]
   └─ buildModels["Models" -> {m}] for each model

CONFIGURATION LAYER
│
└─ splitConfig[config, "Build"]  ◄── EXTRACTS "Models"
   │
   └─ "Models" -> config["Build"]["Models"]

BUILD ORCHESTRATION
│
└─ buildModelsInternal[config_Association]
   │
   ├─ modelFilter = config["Build"]["Models"]
   │
   ├─ enabledModels = selectEnabledModels[catalogModels]
   │
   └─ If[modelFilter === All,
        enabledModels,
        KeyTake[enabledModels, matching shortnames]
      ]
      │
      ├─ symbolicModels (Phase 1)
      ├─ compileModels (Phase 2)
      ├─ numericalModels (Phase 3)
      └─ momentsModels (Phase 4)
```

## Configuration Management Layer

### `defaultConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Line 146 | Default: `"Models" -> All` |

### `splitConfig` in `Kernel/Tools/OptionsConfig.wl`

| Location | What happens |
|----------|--------------|
| Lines 368-375 | `splitConfig[config, "Build"]` definition |
| Line 370 | Extracts: `"Models" -> config["Build"]["Models"]` |

## Terminal Consumer

### `buildModelsInternal` in `Kernel/Tools/ManageResources.wl`

| Location | What happens |
|----------|--------------|
| Line 836 | `modelFilter = config["Build"]["Models"]` |
| Line 871 | `enabledModels = selectEnabledModels[catalogModels]` |
| Lines 875-878 | Apply filter to enabledModels |

**Filtering logic:**
```wolfram
If[modelFilter === All || modelFilter === "All",
  enabledModels,
  KeyTake[enabledModels,
    Select[Keys[enabledModels],
      MemberQ[ToString /@ Flatten@{modelFilter},
        catalogModels[#]["shortname"]] &
    ]
  ]
]
```

## Model Selection Cascade

| Phase | Selection | Description |
|-------|-----------|-------------|
| 1 | `symbolicModels` | Models requiring symbolic processing |
| 2 | `compileModels` | Symbolic + new compile models |
| 3 | `numericalModels` | Compile + new numerical models |
| 4 | `momentsModels` | Special logic (catalog-changed only) |

## Value Types

| Value | Effect |
|-------|--------|
| `All` | Process all enabled models from Catalog |
| `"All"` | Same as All (string variant) |
| `{"BY", "NRC"}` | Process only specified shortnames |
| `"BY"` | Single model (coerced to list) |

## Summary Table

| Layer | Function | File | Lines | Role |
|-------|----------|------|-------|------|
| Config | `defaultConfig` | OptionsConfig.wl | 146 | Default All |
| Config | `splitConfig` | OptionsConfig.wl | 368-375 | Extraction |
| Entry | `buildModels` | ManageResources.wl | 821-826 | Public API |
| Entry | `buildModelsParallel` | ManageResources.wl | 1145-1275 | Parallel variant |
| **Consumer** | `buildModelsInternal` | ManageResources.wl | 836, 875-878 | **Filtering logic** |

## Key Characteristics

| Aspect | Value |
|--------|-------|
| Scope | Build phase - model selection |
| Default | `All` |
| Impact | Determines which models flow through all 4 phases |
| Cascading | Once selected, model flows through entire pipeline |
| Not forwarded | Downstream functions receive filtered model subsets |
