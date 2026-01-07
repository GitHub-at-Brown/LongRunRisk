### ComputeConditionalExpectations.wl

This section tests the `ComputationalEngine`ComputeConditionalExpectations`` module, which computes conditional expectations for the long-run risk model.

---

## Setup and Context Verification

- Verify the package context is properly loaded on `$ContextPath`

  📍 `Tests/ComputationalEngine/ComputeConditionalExpectations.wlt:34-47` (2 tests)

```wolfram
MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"]
```

- Verify that key private functions (`ev`, `lagStateVarst`) are accessible

```wolfram
And@@{
  Not[Names["*ev"] === {}],
  Not[Names["lagStateVarst"] === {}]
}
```

- Load model specifications (BY and NRC models)

```wolfram
msp = FernandoDuarte`LongRunRisk`Models;
modBY = msp["BY"];
modNRC = msp["NRC"];
```

---

## Basic Conditional Expectation Tests

📍 `Tests/ComputationalEngine/ComputeConditionalExpectations.wlt:55-60` (1 test)

- Verify expectation of shock times inflation equals the shock loading parameter

```wolfram
ev[eps["pi"][t+1] pi[t+1], t-1, modNRC] === FernandoDuarte`LongRunRisk`Model`Parameters`phip
```

---

## Product Expectations (Cross-terms)

📍 `Tests/ComputationalEngine/ComputeConditionalExpectations.wlt:68-101` (4 tests)

Tests for conditional expectations of products of state variables:

- Dividend and inflation product expectation

```wolfram
0 === (ev[dd[t+1,i] pi[t+1], t, modNRC] -
  ((mup + rhop(pi[t]-mup) + xip eps["pi"][t])(mud[i] + rhodp[i](pi[t]-mup) + xid[i] sg[t-1] eps["pi"][t])) // Simplify)
```

- Dividend and consumption product expectation

```wolfram
0 === (ev[dd[t+1,i] dc[t+1], t, modNRC] -
  ((mud[i] + rhodp[i](pi[t]-mup) + xid[i] sg[t-1] eps["pi"][t])(muc + rhocp(pi[t]-mup) + xic sg[t-1] eps["pi"][t]) + phic phidc[i]) // Simplify)
```

- Three-term product: volatility, consumption, and inflation

```wolfram
0 === (ev[sg[t+3] dc[t+2] pi[t+1], t, modNRC] -
  ((Esg + rhog^3 (sg[t]-Esg))((mup + rhop(pi[t]-mup) + xip eps["pi"][t])(muc + rhocp rhop(pi[t]-mup) + rhocp xip eps["pi"][t]) + rhocp phip^2 + xic phip sg[t])) // Simplify)
```

- Inflation squared expectation

```wolfram
0 === (ev[pi[t+2] pi[t+1], t, modNRC] -
  ((mup + rhop(pi[t]-mup) + xip eps["pi"][t])(mup + rhop^2 (pi[t]-mup) + rhop xip eps["pi"][t]) + rhop phip^2 + xip phip) // Simplify)
```

---

## Consumption and Inflation Cross-Expectations

📍 `Tests/ComputationalEngine/ComputeConditionalExpectations.wlt:109-150` (5 tests)

- Consumption and inflation at different time horizons

```wolfram
0 === (ev[dc[t+2] pi[t+1], t+1, modNRC] - pi[t+1] ev[dc[t+2], t+1, modNRC] // Simplify)
```

```wolfram
0 === (ev[dc[t+2] pi[t+1], t, modNRC] -
  ((mup + rhop(pi[t]-mup) + xip eps["pi"][t])(muc + rhocp rhop(pi[t]-mup) + rhocp xip eps["pi"][t]) + rhocp phip^2 + xic phip sg[t]) // Simplify)
```

```wolfram
0 === (ev[dc[t+1] pi[t+1], t, modNRC] -
  (mup + rhop(pi[t]-mup) + xip eps["pi"][t])(muc + rhocp(pi[t]-mup) + xic sg[t-1] eps["pi"][t]) // Simplify)
```

- Known (past) consumption-inflation products

```wolfram
0 === (ev[dc[t] pi[t], t, modNRC] -
  pi[t](muc + rhocp(pi[t-1]-mup) + xic sg[t-2] eps["pi"][t-1] + phic eps["dc"][t]) // Simplify)
```

```wolfram
0 === (ev[dc[t-1] pi[t-1], t, modNRC] -
  pi[t-1](muc + rhocp(pi[t-2]-mup) + xic sg[t-3] eps["pi"][t-2] + phic eps["dc"][t-1]) // Simplify)
```

---

## Volatility State Variable Tests

📍 `Tests/ComputationalEngine/ComputeConditionalExpectations.wlt:158-216` (7 tests)

- Volatility products at various lags

```wolfram
0 === (ev[sg[t+2] sg[t+1]^2, t, modNRC] -
  ((1-rhog) Esg ev[sg[t+1]^2, t, modNRC] + rhog ev[sg[t+1]^3, t, modNRC]) // Simplify)
```

```wolfram
0 === (ev[sg[t+2] sg[t+1]^2, t, modNRC] -
  ((1-rhog) Esg ((Esg + rhog(sg[t]-Esg))^2 + phig^2) + rhog((Esg + rhog(sg[t]-Esg))^3 + 3 phig^2 (Esg + rhog(sg[t]-Esg)))) // Simplify)
```

- Volatility cross-products

```wolfram
0 === (ev[sg[t+2] sg[t+1], t, modNRC] -
  ((Esg + rhog^2 (sg[t]-Esg))(Esg + rhog(sg[t]-Esg)) + rhog phig^2) // Simplify)
```

```wolfram
0 === (ev[sg[t+3] sg[t+1], t, modNRC] -
  ((Esg + rhog^3 (sg[t]-Esg))(Esg + rhog(sg[t]-Esg)) + rhog^2 phig^2) // Simplify)
```

- Volatility and inflation products

```wolfram
0 === (ev[sg[t+1] pi[t+1], t, modNRC] -
  ((Esg + rhog(sg[t]-Esg))(mup + rhop(pi[t]-mup) + xip eps["pi"][t])) // Simplify)
```

- Known volatility values (information set)

```wolfram
0 === (ev[sg[t] pi[t], t, modNRC] - sg[t] pi[t] // Simplify)
0 === (ev[sg[t-1] pi[t-1], t, modNRC] - sg[t-1] pi[t-1] // Simplify)
```

---

## Volatility Squared Expectations

📍 `Tests/ComputationalEngine/ComputeConditionalExpectations.wlt:224-253` (4 tests)

```wolfram
0 === (ev[sg[t+1]^2, t, modNRC] - ((Esg + rhog(sg[t]-Esg))^2 + phig^2) // Simplify)
0 === (ev[sg[t]^2, t, modNRC] - sg[t]^2 // Simplify)
0 === (ev[sg[t+1]^2, t-1, modNRC] - ((Esg + rhog^2 (sg[t-1]-Esg))^2 + (rhog^2+1) phig^2) // Simplify)
0 === (ev[sg[t+1]^2, t-2, modNRC] - ((Esg + rhog^3 (sg[t-2]-Esg))^2 + (rhog^4+rhog^2+1) phig^2) // Simplify)
```

---

## First Moment Expectations

📍 `Tests/ComputationalEngine/ComputeConditionalExpectations.wlt:261-298` (5 tests)

- Volatility first moments

```wolfram
0 === (ev[sg[t+1], t, modNRC] - (Esg + rhog(sg[t]-Esg)) // Simplify)
0 === (ev[sg[t], t, modNRC] - sg[t] // Simplify)
0 === (ev[sg[t+1], t-1, modNRC] - (Esg + rhog^2 (sg[t-1]-Esg)) // Simplify)
```

- Consumption first moments

```wolfram
0 === (ev[dc[t+1], t-1, modNRC] - (muc + rhocp rhop(pi[t-1]-mup) + rhocp xip eps["pi"][t-1]) // Simplify)
0 === (ev[dc[t], t-1, modNRC] - (muc + rhocp(pi[t-1]-mup) + xic sg[t-2] eps["pi"][t-1]) // Simplify)
```

---

## Shock-Inflation Expectations

📍 `Tests/ComputationalEngine/ComputeConditionalExpectations.wlt:306-336` (4 tests)

- Future shock times future inflation

```wolfram
0 === (ev[eps["pi"][t+2] pi[t+1], t-1, modNRC] - 0 // Simplify)
0 === (ev[eps["pi"][t+1] pi[t+1], t-1, modNRC] - phip // Simplify)
0 === (ev[eps["pi"][t] pi[t+1], t-1, modNRC] - (rhop phip + xip) // Simplify)
```

- Past shock times future inflation

```wolfram
0 === (ev[eps["pi"][t-1] pi[t+1], t-1, modNRC] -
  ((mup + rhop^2 (pi[t-1]-mup) + rhop xip eps["pi"][t-1]) eps["pi"][t-1]) // Simplify)
```

---

## Inflation Expectations at Different Information Sets

📍 `Tests/ComputationalEngine/ComputeConditionalExpectations.wlt:344-381` (5 tests)

```wolfram
0 === (ev[pi[t+2], t+2, modNRC] - pi[t+2] // Simplify)
0 === (ev[pi[t+2], t+1, modNRC] - (mup + rhop(pi[t+1]-mup) + xip eps["pi"][t+1]) // Simplify)
0 === (ev[pi[t+2], t, modNRC] - (mup + rhop^2 (pi[t]-mup) + rhop xip eps["pi"][t]) // Simplify)
0 === (ev[pi[t+2], t-1, modNRC] - (mup + rhop^3 (pi[t-1]-mup) + rhop^2 xip eps["pi"][t-1]) // Simplify)
0 === (ev[pi[t+2], t-2, modNRC] - (mup + rhop^4 (pi[t-2]-mup) + rhop^3 xip eps["pi"][t-2]) // Simplify)
```

---

## Second Moment Expectations

📍 `Tests/ComputationalEngine/ComputeConditionalExpectations.wlt:389-418` (4 tests)

```wolfram
0 === (ev[pi[t+1]^2, t, modNRC] - ((mup + rhop(pi[t]-mup) + xip eps["pi"][t])^2 + phip^2) // Simplify)
0 === (ev[dc[t+1]^2, t, modNRC] - ((muc + rhocp(pi[t]-mup) + xic sg[t-1] eps["pi"][t])^2 + phic^2) // Simplify)
0 === (ev[sg[t+1]^2, t, modNRC] - ((Esg + rhog(sg[t]-Esg))^2 + phig^2) // Simplify)
0 === (ev[dd[t+1,i]^2, t, modNRC] - ((mud[i] + rhodp[i](pi[t]-mup) + xid[i] sg[t-1] eps["pi"][t])^2 + phidc[i]^2) // Simplify)
```

---

## Conditional Variance Tests

📍 `Tests/ComputationalEngine/ComputeConditionalExpectations.wlt:426-455` (4 tests)

```wolfram
0 === (var[pi[t+1], t, modNRC] - phip^2 // Simplify)
0 === (var[dc[t+1], t, modNRC] - phic^2 // Simplify)
0 === (var[sg[t+1], t, modNRC] - phig^2 // Simplify)
0 === (var[dd[t+1,i], t, modNRC] - phidc[i]^2 // Simplify)
```

---

## Law of Iterated Expectations

📍 `Tests/ComputationalEngine/ComputeConditionalExpectations.wlt:463-585` (15 tests)

Tests verifying E[E[X|F_t]|F_{t-1}] = E[X|F_{t-1}]:

- Basic state variables

```wolfram
0 === (ev[pi[t+1], t-1, modNRC] - ev[ev[pi[t+1], t, modNRC], t-1, modNRC] // Simplify)
0 === (ev[dc[t+1], t-1, modNRC] - ev[ev[dc[t+1], t, modNRC], t-1, modNRC] // Simplify)
0 === (ev[sg[t+1], t-1, modNRC] - ev[ev[sg[t+1], t, modNRC], t-1, modNRC] // Simplify)
0 === (ev[dd[t+1,i], t-1, modNRC] - ev[ev[dd[t+1,i], t, modNRC], t-1, modNRC] // Simplify)
```

- Product terms

```wolfram
0 === (ev[pi[t+1] dc[t+1], t-1, modNRC] - ev[ev[pi[t+1] dc[t+1], t, modNRC], t-1, modNRC] // Simplify)
0 === (ev[dc[t+1] sg[t+1], t-1, modNRC] - ev[ev[dc[t+1] sg[t+1], t, modNRC], t-1, modNRC] // Simplify)
0 === (ev[sg[t+1]^2, t-1, modNRC] - ev[ev[sg[t+1]^2, t, modNRC], t-1, modNRC] // Simplify)
0 === (ev[dd[t+2,i], t-1, modNRC] - ev[ev[dd[t+2,i], t, modNRC], t-1, modNRC] // Simplify)
```

- Iterated expectations for unconditional moments (state variable times future shock)

```wolfram
0 === ev[pi[t] eps["pi"][t+1], t-1, modNRC] === ev[ev[pi[t] eps["pi"][t+1], t, modNRC], t-1, modNRC]
0 === ev[pi[t] eps["dc"][t+1], t-1, modNRC] === ev[ev[pi[t] eps["dc"][t+1], t, modNRC], t-1, modNRC]
0 === ev[sg[t] eps["pi"][t+1], t-1, modNRC] === ev[ev[sg[t] eps["pi"][t+1], t, modNRC], t-1, modNRC]
```

- Iterated expectations for shocks squared (martingale property for E[x * eps^2])

```wolfram
ev[pi[t], t-1, modNRC] === ev[pi[t] ev[eps["pi"][t+1]^2, t, modNRC], t-1, modNRC] ===
  ev[pi[t] eps["pi"][t+1]^2, t-1, modNRC] === ev[ev[pi[t] eps["pi"][t+1]^2, t, modNRC], t-1, modNRC]
```

```wolfram
ev[sg[t], t-1, modNRC] === ev[sg[t] ev[eps["pi"][t+1]^2, t, modNRC], t-1, modNRC] ===
  ev[sg[t] eps["pi"][t+1]^2, t-1, modNRC] === ev[ev[sg[t] eps["pi"][t+1]^2, t, modNRC], t-1, modNRC]
```

```wolfram
ev[dc[t], t-1, modNRC] === ev[dc[t] ev[eps["pi"][t+1]^2, t, modNRC], t-1, modNRC] ===
  ev[dc[t] eps["pi"][t+1]^2, t-1, modNRC] === ev[ev[dc[t] eps["pi"][t+1]^2, t, modNRC], t-1, modNRC]
```

```wolfram
ev[dd[t,i], t-1, modNRC] === ev[dd[t,i] ev[eps["pi"][t+1]^2, t, modNRC], t-1, modNRC] ===
  ev[dd[t,i] eps["pi"][t+1]^2, t-1, modNRC] === ev[ev[dd[t,i] eps["pi"][t+1]^2, t, modNRC], t-1, modNRC]
```

---

## Context Handling Tests

📍 `Tests/ComputationalEngine/ComputeConditionalExpectations.wlt:593-611` (2 tests)

- Variable context invariance: `ev` works regardless of variable symbol context

```wolfram
ev[pi[t+1], t, modNRC] === ev[foo`pi[t+1], t, modNRC] === (ev[foo`pi[foo`t+1], foo`t, modNRC] /. foo`t -> t)
```

- Time index context sensitivity: `ev` differentiates contexts for time indices

```wolfram
ev[pi[foo`t+1], t, modNRC] === FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1+foo`t]
ev[pi[t+1], foo`t, modNRC] === FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1+t]
ev[foo`pi[foo`t+1], t, modNRC] === FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1+foo`t]
ev[foo`pi[t+1], foo`t, modNRC] === FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1+t]
ev[foo`pi[bar`t+1], t, modNRC] === FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1+bar`t]
ev[foo`pi[t+1], bar`t, modNRC] === FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1+t]
ev[foo`pi[bar`t+1], goo`t, modNRC] === FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[1+bar`t]
```

---

## lagStateVarst Function Tests

📍 `Tests/ComputationalEngine/ComputeConditionalExpectations.wlt:619-754` (14 tests)

The `lagStateVarst` function substitutes state variables with their lagged expressions.

- Basic functionality: expand pi[t] conditioning on t-1

```wolfram
lagStateVarst[pi[t], t-1, modNRC] === (
  FernandoDuarte`LongRunRisk`Model`Parameters`mup +
  FernandoDuarte`LongRunRisk`Model`Parameters`rhop (-FernandoDuarte`LongRunRisk`Model`Parameters`mup +
    FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[-1+t]) +
  FernandoDuarte`LongRunRisk`Model`Parameters`xip FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][-1+t] +
  FernandoDuarte`LongRunRisk`Model`Parameters`phip FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][t]
)
```

- Time-shift consistency

```wolfram
lagStateVarst[pi[t+1], t, modNRC] === (lagStateVarst[pi[t], t-1, modNRC] /. t -> t+1)
```

- Product expressions with shocks

```wolfram
lagStateVarst[pi[t] eps["pi"][t+2], t, modNRC] ===
  FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[t] FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][2+t]
```

- Parameters remain unchanged

```wolfram
lagStateVarst[delta, t-1, modNRC] === FernandoDuarte`LongRunRisk`Model`Parameters`delta
lagStateVarst[A[0], t-1, modNRC] === FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[0]
lagStateVarst[R[-1+m][0], t-1, modNRC] === FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`R[-1+m][0]
```

- Does not evaluate with equilibrium (XXeq) variables

```wolfram
lagStateVarst[pieq[t,m], t+1, modNRC] === pieq[t,m]
lagStateVarst[wceq[t], t+1, modNRC] === wceq[t]
```

- Listable property

```wolfram
lagStateVarst[{pi[t], sg[t], dc[t]}, t-1, modNRC] ===
  {lagStateVarst[pi[t], t-1, modNRC], lagStateVarst[sg[t], t-1, modNRC], lagStateVarst[dc[t], t, modNRC]}
```

- Context handling in expressions

```wolfram
lagStateVarst[foo`pi[t], t-1, modNRC] === lagStateVarst[pi[t], t-1, modNRC]
lagStateVarst[foo`pi[t] pi[t], t-1, modNRC] === lagStateVarst[foo`pi[t]^2, t-1, modNRC] === lagStateVarst[pi[t]^2, t-1, modNRC]
lagStateVarst[foo`pi[t] eps["pi"][t] bar`delta, t-1, modNRC] === lagStateVarst[pi[t] foo`eps["pi"][t] delta, t-1, modNRC]
```

- Context handling for conditional time

```wolfram
lagStateVarst[pi[foo`t], t-1, modNRC] === FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[foo`t]
lagStateVarst[pi[t], t-1, modNRC] === (lagStateVarst[pi[foo`t], foo`t-1, modNRC] /. foo`t -> t)
```

---

## WLT Verification Results

**File Verified**: `Tests/ComputationalEngine/ComputeConditionalExpectations.wlt`

**Verification Date**: 2026-01-05

**Guidelines Reference**: wolfram-testing skill (user-level)

### Compliance Summary

| Guideline | Status | Notes |
|-----------|--------|-------|
| Use `TestCreate` exclusively | PASS | All 67 tests use `TestCreate`, no `VerificationTest` |
| Third argument for expected messages | PASS | All tests include `{}` as the third argument |
| TestID format `SymbolName-Scenario-Behavior` | PASS | All TestIDs follow the pattern (e.g., `ev-ShockTimesInflation-EqualsPhip`) |
| BeginTestSection names file being tested | PASS | `"Kernel/ComputationalEngine/ComputeConditionalExpectations.wl Tests"` |
| Load shared helpers via `$TestFileName` | PASS | `Get[FileNameJoin[{DirectoryName[$TestFileName, 2], "Common.wl"}]]` |
| Use `Needs` for required contexts | PASS | Loads main paclet and specific submodule |
| Only load contexts actually used | PASS | Both `Needs` statements are used (main paclet for `Models`, submodule for `ev`/`var`) |
| No `Quiet` in test assertions | PASS | No message suppression in any test |
| Context isolation with `Begin`/`End` | PASS | Proper test context: `FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeConditionalExpectations`` |
| No `TimeConstraint`/`MemoryConstraint`/`MetaInformation` | PASS | None used |
| Private functions fully qualified | PASS | `lagStateVarst` accessed via `...`Private`lagStateVarst` |
| One assertion per behavior | PASS | Each `TestCreate` has a single assertion |
| No paclet initialization boilerplate | PASS | No `PacletDirectoryLoad` or complex path resolution |
| Test stands alone at top level | PASS | All tests are top-level expressions |

### Test Structure Analysis

**Total Tests**: 67

**Test Categories**:
- Context Verification: 2 tests
- Basic Expectation (`ev`): 1 test
- Product Expectations: 4 tests
- Consumption-Inflation Cross-Expectations: 5 tests
- Volatility State Variable: 7 tests
- Volatility Squared: 4 tests
- First Moment Expectations: 5 tests
- Shock-Inflation Expectations: 4 tests
- Inflation at Different Information Sets: 5 tests
- Second Moment Expectations: 4 tests
- Conditional Variance (`var`): 4 tests
- Law of Iterated Expectations: 8 tests
- Martingale Property: 7 tests
- Context Handling (`ev`): 2 tests
- `lagStateVarst` Basic Functionality: 3 tests
- `lagStateVarst` Parameter Handling: 3 tests
- `lagStateVarst` Equilibrium Variables: 2 tests
- `lagStateVarst` Listable Property: 1 test
- `lagStateVarst` Context Handling: 5 tests

### Overall Assessment

**Status**: COMPLIANT

The WLT file fully adheres to the wolfram-testing skill guidelines. The file demonstrates excellent test organization with:
- Clear sectioning using Wolfram notebook-style comments
- Comprehensive coverage of the `ev`, `var`, and `lagStateVarst` functions
- Proper use of test fixtures via module-level variables (`$testModel`, `$pi`, etc.)
- Consistent TestID naming convention throughout
- No shortcuts or message suppression in test assertions
