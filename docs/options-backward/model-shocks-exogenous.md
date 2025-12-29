# Options Flow: Shocks.wl and ExogenousEq.wl

This document analyzes the options handling patterns in the Shocks.wl and ExogenousEq.wl files of the LongRunRisk package.

## File: Shocks.wl

**Path**: `/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/Shocks.wl`

### Summary

**This file contains NO options-related code.**

The file defines two public symbols:
- `rulesE` - Defines the distribution of exogenous shocks
- `eps` - Exogenous shocks symbol

### Function Analysis

#### `rulesE[t_]`

- **Signature**: `rulesE[t_]`
- **Options accepted**: None
- **Options patterns used**: None (no `OptionsPattern[]`, `OptionValue`, or `FilterRules`)
- **Description**: This function takes a single time argument `t` and returns a list of replacement rules for computing expectations of products of exogenous shocks. It uses a `With` block for local constants but does not use any options mechanism.

The file uses:
- `Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"]` for model parameters
- `SetAttributes[$shocks, NHoldAll]` for maintaining integer indices

---

## File: ExogenousEq.wl

**Path**: `/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/ExogenousEq.wl`

### Summary

**This file contains NO options-related code.**

The file defines public symbols for exogenous dynamics equations:
- `xeq` - Long-run risk dynamics
- `pieq` - Inflation dynamics
- `pibareq` - Expected inflation dynamics
- `dceq` - Real consumption growth dynamics
- `sgeq` - Nominal-real covariance (NRC) dynamics
- `sxeq` - Stochastic volatility of long-run risk dynamics
- `sceq` - Stochastic volatility of consumption growth dynamics
- `speq` - Stochastic volatility of inflation dynamics
- `ddeq` - Real dividend growth dynamics (for stock i)

### Function Analysis

#### `xeq[t_]`

- **Signature**: `xeq[t_]`
- **Options accepted**: None
- **Description**: Defines the exogenous dynamics of long-run risk as a function of time `t`.

#### `pieq[t_]`

- **Signature**: `pieq[t_]`
- **Options accepted**: None
- **Description**: Defines the exogenous dynamics of inflation.

#### `pibareq[t_]`

- **Signature**: `pibareq[t_]`
- **Options accepted**: None
- **Description**: Defines the exogenous dynamics of expected inflation.

#### `dceq[t_]`

- **Signature**: `dceq[t_]`
- **Options accepted**: None
- **Description**: Defines the exogenous dynamics of real consumption growth.

#### `sgeq[t_]`

- **Signature**: `sgeq[t_]`
- **Options accepted**: None
- **Description**: Defines the exogenous dynamics of the nominal-real covariance (NRC).

#### `sxeq[t_]`

- **Signature**: `sxeq[t_]`
- **Options accepted**: None
- **Description**: Defines the exogenous dynamics of stochastic volatility of long-run risk.

#### `sceq[t_]`

- **Signature**: `sceq[t_]`
- **Options accepted**: None
- **Description**: Defines the exogenous dynamics of stochastic volatility of consumption growth.

#### `speq[t_]`

- **Signature**: `speq[t_]`
- **Options accepted**: None
- **Description**: Defines the exogenous dynamics of stochastic volatility of inflation.

#### `ddeq[t_, i_]`

- **Signature**: `ddeq[t_, i_]`
- **Options accepted**: None
- **Description**: Defines the exogenous dynamics of real dividend growth for stock `i`.

### Dependencies

The file uses:
- `Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"]` for model parameters
- `Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"]` for shock symbols (`eps`)

---

## Conclusion

Both **Shocks.wl** and **ExogenousEq.wl** are purely mathematical definition files that:

1. **Do not use any options mechanisms** - No `OptionsPattern[]`, `OptionValue`, `FilterRules`, or `Options` are present
2. **Define pure mathematical equations** - All functions take only required positional arguments (time `t`, and in one case stock index `i`)
3. **Rely on global parameters** - Model parameters (like `rhox`, `phix`, `muc`, etc.) come from the `Parameters` package rather than being passed as options

These files represent the mathematical specification layer of the model and are designed to be simple, declarative definitions without configuration options. Any customization of the model equations would be done by modifying the parameter values in the `Parameters` package rather than through options passed to these functions.
