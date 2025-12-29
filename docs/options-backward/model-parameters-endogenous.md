# Options Flow: Parameters.wl and EndogenousEq.wl

## File: Parameters.wl

**Location**: `/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/Parameters.wl`

### Summary

This file defines model parameter symbols for a long-run risk economic model. It contains:

- Usage messages for 70+ parameter symbols (preferences, long-run risk, inflation, consumption growth, volatility, dividends, etc.)
- A `paramList` association organizing parameters by category
- Parameter assumptions (`paramAssumptions`) for mathematical constraints

**No options-related code is present in this file.**

The file does not contain any functions that use:
- `OptionsPattern[]`
- `opts:OptionsPattern[]`
- `OptionValue`
- `FilterRules`
- `Options[]`

All definitions are direct symbol declarations with usage messages or simple variable assignments.

---

## File: EndogenousEq.wl

**Location**: `/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk/Kernel/Model/EndogenousEq.wl`

### Summary

This file defines endogenous equations for the long-run risk model, including:

- Wealth-consumption ratio (`wceq`)
- Price-dividend ratios (`pdeq`)
- Real and nominal bond prices (`bondeq`, `nombondeq`)
- Stochastic discount factors (`sdfeq`, `nomsdfeq`)
- Returns and excess returns (`retceq`, `reteq`, `excretceq`, `excreteq`)
- Bond yields, forward rates, and returns (`bondyieldeq`, `bondfweq`, `bondreteq`, etc.)
- Risk-free rates (`rfeq`, `nomrfeq`)
- Campbell-Shiller approximation constants (`kappa0eq`, `kappa1eq`)

**No options-related code is present in this file.**

The file does not contain any functions that use:
- `OptionsPattern[]`
- `opts:OptionsPattern[]`
- `OptionValue`
- `FilterRules`
- `Options[]`

### Function Definitions

All functions in this file are simple pattern-based definitions without options handling:

| Function | Arguments | Description |
|----------|-----------|-------------|
| `wceq` | `t` | Log wealth-consumption ratio (via UpValues with state variables) |
| `pdeq` | `t, i` | Log price-dividend ratio for stock i |
| `bondeq` | `t, m` | Log real bond price (m-month maturity) |
| `nombondeq` | `t, m` | Log nominal bond price (m-month maturity) |
| `sdfeq` | `t` | Real stochastic discount factor |
| `nomsdfeq` | `t` | Nominal stochastic discount factor |
| `retceq` | `t` | Return on consumption asset |
| `reteq` | `t, i` | Return for stock i |
| `kappa1eq` | `mu` | Campbell-Shiller constant kappa1 |
| `kappa0eq` | `mu` | Campbell-Shiller constant kappa0 |
| `excretceq` | `t` | Excess return on consumption asset |
| `excreteq` | `t, i` | Excess return for stock i |
| `bondyieldeq` | `t, m` | Real bond yield |
| `nombondyieldeq` | `t, m` | Nominal bond yield |
| `bondfweq` | `t, m, h:1` | Real forward rate |
| `nombondfweq` | `t, m, h:1` | Nominal forward rate |
| `bondreteq` | `t, m, h:1` | Real bond return |
| `nombondreteq` | `t, m, h:1` | Nominal bond return |
| `bondfwspreadeq` | `t, m, h:1` | Real forward spread |
| `nombondfwspreadeq` | `t, m, h:1` | Nominal forward spread |
| `bondexcreteq` | `t, m, h:1` | Real bond excess return |
| `nombondexcreteq` | `t, m, h:1` | Nominal bond excess return |
| `rfeq` | `t, h:1` | Real risk-free rate |
| `nomrfeq` | `t, h:1` | Nominal risk-free rate |
| `linearInStateVars` | `stateVars, coeff` | Helper for linear-in-state-vars expressions |

Note: Some functions like `bondfweq[t, m, h:1]` use default argument values (`:1`), but this is Wolfram Language's default argument syntax, not options handling.

---

## Dependencies

EndogenousEq.wl imports the following packages:
- `FernandoDuarte`LongRunRisk`Model`Parameters`` (this file)
- `FernandoDuarte`LongRunRisk`Model`Shocks``
- `FernandoDuarte`LongRunRisk`Model`ExogenousEq``

None of these imports are for options-related functionality.
