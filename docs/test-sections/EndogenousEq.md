### EndogenousEq.wl

- Symbol `pdeq` should exist (can be found)
  ```
  Not[Names["*pdeq"] === {}]
  ```

For endogenous variables (entries of `$endogenousVars`):
- All exogenous variables are in context `"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"`
  ```
  And @@ ((# ===
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`") & /@
    (Context /@
      Cases[((#[t]) & /@ (Symbol /@ $endogenousVars)),
        var_Symbol?(MemberQ[
            StringDrop[#, -2] & /@
              FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars,
            SymbolName[#]] &)[__] :> var, Infinity]))
  ```

- All shocks are in context `"FernandoDuarte`LongRunRisk`Model`Shocks`"`
  ```
  And @@ ((# === "FernandoDuarte`LongRunRisk`Model`Shocks`") & /@ (Context /@
      Cases[((#[t]) & /@ (Symbol /@ $endogenousVars)),
        var_Symbol?(MatchQ[SymbolName[#], "eps"] &)[__][__] :> var, Infinity]))
  ```

- All parameters are in context `"FernandoDuarte`LongRunRisk`Model`Parameters`"`
  ```
  And @@ ((# ===
      "FernandoDuarte`LongRunRisk`Model`Parameters`") & /@ (Context /@
      Cases[((#[t]) & /@ (Symbol /@ $endogenousVars)),
        var_Symbol?(MemberQ[
            FernandoDuarte`LongRunRisk`Model`Parameters`$parameters,
            SymbolName[#]] &) :> var, Infinity]))
  ```

- All endogenous variables are in context `"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"`
  ```
  And @@ ((# ===
      "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`") & /@
    (Context /@
      Cases[((#[t]) & /@ (Symbol /@ $endogenousVars)),
        var_Symbol?(MemberQ[StringDrop[#, -2] & /@ $endogenousVars,
            SymbolName[#]] &)[__] :> var, Infinity]))
  ```

- Equation variables use different contexts for `t` argument (context isolation)
  ```
  And @@ {
    FreeQ[bondyieldeq[t, m], foo`t],
    Not@FreeQ[bondyieldeq[t, m], t],
    FreeQ[bondyieldeq[foo`t, m], t],
    Not@FreeQ[bondyieldeq[foo`t, m], foo`t],
    Not@(foo`bondyieldeq[t, m] === bondyieldeq[t, m]),
    Not@(bondyieldeq[t, m] === bondyieldeq[foo`t, m])
    }
  ```

- Equation variables use different contexts for `m` argument (context isolation)
  ```
  And @@ {
    FreeQ[bondyieldeq[t, m], foo`m],
    Not@FreeQ[bondyieldeq[t, m], m],
    FreeQ[bondyieldeq[t, foo`m], m],
    Not@FreeQ[bondyieldeq[t, foo`m], foo`m],
    Not@(bondyieldeq[t, m] === bondyieldeq[t, foo`m])
    }
  ```

- Default values for optional arguments work correctly
  ```
  And @@ {
    bondfweq[t, m] === bondfweq[t, m, 1],
    bondreteq[t, m] === bondreteq[t, m, 1],
    bondfwspreadeq[t, m] === bondfwspreadeq[t, m, 1],
    bondexcreteq[t, m] === bondexcreteq[t, m, 1]
    }
  ```

For coefficient functions (`coefwc`, `coefpd`, `coefb`, `coefnb`):
- Indices of coefficients are exact integers (not inexact/floating-point numbers)
  - Applies to `coefwc[i]`, `coefpd[i][j]`, `coefb[i][j]`, `coefnb[i][j]`
  - Must remain exact after `N[]` application to the coefficient (not the index)
  ```
  coefwc = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc;
  coefpd = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd;
  coefb = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb;
  coefnb = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb;

  (* Test that indices remain exact integers in all coefficient expressions *)
  And @@ Flatten@{
    Not /@ InexactNumberQ /@ Select[Flatten@Cases[ch, x_[i_] :> i], NumberQ],
    Not /@ InexactNumberQ /@ Select[Flatten@Cases[ch, x_[i_][j_] :> {i, j}], NumberQ]
    }
  ```

## WLT Verification Results

**File**: `/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-clean-up/Tests/Model/EndogenousEq.wlt`

**Verification Date**: 2026-01-05

### Compliance Table

| Guideline | Status | Notes |
|-----------|--------|-------|
| Uses `TestCreate` exclusively (no `VerificationTest`) | PASS | All 15 tests use `TestCreate` |
| Third argument for expected messages always present | PASS | All tests include `{}` for expected messages |
| TestID format: `"SymbolName-Scenario-Behavior"` | PASS | All TestIDs follow the pattern (e.g., `"pdeq-Existence-CanBeFound"`, `"$endogenousVars-ExogenousVars-InCorrectContext"`) |
| BeginTestSection names file being tested | PASS | `"Kernel/Model/EndogenousEq.wl Tests"` correctly references source file |
| Proper context isolation with `Begin`/`End` | PASS | Uses `Begin["FernandoDuarte`LongRunRisk`Tests`Model`EndogenousEq`"]` and `End[]` |
| `Needs` statements for required contexts | PASS | Loads `EndogenousEq`, `ExogenousEq`, `Parameters`, and `Shocks` contexts |
| Only loads contexts actually used | PASS | All four loaded contexts are used in the tests |
| Load shared helpers via `$TestFileName` | PASS | `Get[FileNameJoin[{DirectoryName[$TestFileName, 2], "Common.wl"}]]` |
| No `Quiet` in test assertions | PASS | No `Quiet` usage found anywhere in the file |
| No `Off`/`On` to suppress messages | PASS | No `Off`/`On` usage found |
| No `TimeConstraint`/`MemoryConstraint`/`MetaInformation` | PASS | None of these options used |
| No paclet initialization boilerplate | PASS | No `PacletDirectoryLoad` or path resolution blocks |
| Proper access to private functions (full qualification) | PASS | Private symbols like `Private`A`, `Private`B`, etc. are fully qualified |
| No hard-wired numbering in comments | PASS | Uses descriptive section headers without numbers |

### Summary

The file `Tests/Model/EndogenousEq.wlt` is **fully compliant** with the wolfram-testing skill guidelines.

**Strengths**:
- Clean structure with proper `BeginTestSection`/`EndTestSection` and `Begin`/`End` blocks
- All tests use `TestCreate` with the required three positional arguments
- TestIDs are descriptive and follow the `SymbolName-Scenario-Behavior` pattern
- Proper use of `Module` and `With` for lexical scoping
- Private symbols are correctly accessed via full qualification
- No message suppression in test assertions

**Test Coverage** (15 tests total):
- Symbol existence tests (1 test)
- Context validation tests (4 tests)
- Context isolation tests (2 tests)
- Default argument tests (1 test)
- Formula logic tests (4 tests)
- Coefficient index tests (4 tests - tests A, B, R, P coefficients)
