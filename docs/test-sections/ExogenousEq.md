### ExogenousEq.wl

- Symbol `xeq` should exist (can be found) 📍 `Tests/Model/ExogenousEq.wlt:25-30`
  ```
  Not[Names["*xeq"] === {}]
  ```

For exogenous variables (entries of `$exogenousVars`):
- All exogenous variables are in context `"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"` (individual checks) ⚠️ MISSING FROM WLT
  ```
  And @@ {
    MemberQ[DeleteDuplicates@(Context /@ Cases[xeq[t],
      var_Symbol?(MatchQ[SymbolName[#], "x"] &)[___] :> var, Infinity]),
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],
    MemberQ[DeleteDuplicates@(Context /@ Cases[pieq[t],
      var_Symbol?(MatchQ[SymbolName[#], "pi"] &)[___] :> var, Infinity]),
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],
    MemberQ[DeleteDuplicates@(Context /@ Cases[pibareq[t],
      var_Symbol?(MatchQ[SymbolName[#], "pibar"] &)[___] :> var, Infinity]),
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],
    MemberQ[DeleteDuplicates@(Context /@ Cases[sgeq[t],
      var_Symbol?(MatchQ[SymbolName[#], "sg"] &)[___] :> var, Infinity]),
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],
    MemberQ[DeleteDuplicates@(Context /@ Cases[sxeq[t],
      var_Symbol?(MatchQ[SymbolName[#], "sx"] &)[___] :> var, Infinity]),
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],
    MemberQ[DeleteDuplicates@(Context /@ Cases[sceq[t],
      var_Symbol?(MatchQ[SymbolName[#], "sc"] &)[___] :> var, Infinity]),
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],
    MemberQ[DeleteDuplicates@(Context /@ Cases[speq[t],
      var_Symbol?(MatchQ[SymbolName[#], "sp"] &)[___] :> var, Infinity]),
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],

    Not[{} === Cases[Symbol /@ Names["FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*"],
      var_Symbol?(MatchQ[SymbolName[#], "dc"] &) :> var, Infinity]],
    Not[{} === Cases[Symbol /@ Names["FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*"],
      var_Symbol?(MatchQ[SymbolName[#], "dd"] &) :> var, Infinity]],
    MemberQ[DeleteDuplicates@(Context /@ Cases[
      Symbol /@ Names["FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*"],
      var_Symbol?(MatchQ[SymbolName[#], "dc"] &) :> var, Infinity]),
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],
    MemberQ[DeleteDuplicates@(Context /@ Cases[
      Symbol /@ Names["FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*"],
      var_Symbol?(MatchQ[SymbolName[#], "dd"] &) :> var, Infinity]),
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]
    }
  ```

- All exogenous variables are in context `"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"` (generic check) ⚠️ MISSING FROM WLT
  ```
  And @@ ((# ===
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`") & /@
    (Context /@ Cases[(#[t]) & /@ (Symbol /@ $exogenousVars),
      var_Symbol?(MemberQ[StringDrop[#, -2] & /@ $exogenousVars,
          SymbolName[#]] &)[__] :> var, Infinity]))
  ```

- All shocks are in context `"FernandoDuarte`LongRunRisk`Model`Shocks`"` ⚠️ MISSING FROM WLT
  ```
  And @@ ((# === "FernandoDuarte`LongRunRisk`Model`Shocks`") & /@
    (Context /@ Cases[(#[t]) & /@ (Symbol /@ $exogenousVars),
      var_Symbol?(MatchQ[SymbolName[#], "eps"] &)[__][__] :> var, Infinity]))
  ```

- All parameters are in context `"FernandoDuarte`LongRunRisk`Model`Parameters`"` ⚠️ MISSING FROM WLT
  ```
  And @@ ((# ===
      "FernandoDuarte`LongRunRisk`Model`Parameters`") & /@
    (Context /@ Cases[(#[t]) & /@ (Symbol /@ $exogenousVars),
      var_Symbol?(MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters,
          SymbolName[#]] &) :> var, Infinity]))
  ```

- Equation variables use different contexts for `t` argument (context isolation) 📍 `Tests/Model/ExogenousEq.wlt:107-112`
  ```
  And @@ {
    FreeQ[xeq[t], foo`t],
    Not@FreeQ[xeq[t], t],
    FreeQ[xeq[foo`t], t],
    Not@FreeQ[xeq[foo`t], foo`t],
    Not@(foo`xeq[t] === xeq[t]),
    Not@(xeq[t] === xeq[foo`t])
    }
  ```

## WLT Verification Results

**File verified:** `/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-clean-up/Tests/Model/ExogenousEq.wlt`

**Verification date:** 2026-01-05

### Compliance Table

| Guideline | Status | Notes |
|-----------|--------|-------|
| Use `TestCreate` exclusively (never `VerificationTest`) | PASS | All 22 tests use `TestCreate` |
| Always include third argument for expected messages | PASS | All tests include `{}` as third argument |
| TestID format `"SymbolName-Scenario-Behavior"` | PASS | All TestIDs follow the pattern |
| BeginTestSection names file being tested | PASS | `"Kernel/Model/ExogenousEq.wl Tests"` |
| Context isolation with `Begin`/`End` | PASS | Uses `Begin["FernandoDuarte`LongRunRisk`Tests`Model`ExogenousEq`"]` |
| Load shared helpers via `$TestFileName` | PASS | `Get[FileNameJoin[{DirectoryName[$TestFileName, 2], "Common.wl"}]]` |
| Use `Needs` for required contexts | PASS | Two `Needs` statements at file start |
| Only load contexts actually used | PASS | Both `ExogenousEq` and `Parameters` are used |
| No `Quiet` in test assertions | PASS | No suppression of messages in tests |
| No `Off`/`On` in test assertions | PASS | No message toggling present |
| Avoid `TimeConstraint`/`MemoryConstraint`/`MetaInformation` | PASS | None present |
| No hardwired numbering in comments | PASS | Uses descriptive section headers |
| Prefer unqualified symbols after `Needs` | PASS | Symbols like `$exogenousVars`, `xeq` used unqualified |
| One assertion per behavior | PASS | Each test verifies a single behavior |

### Summary

The WLT file `Tests/Model/ExogenousEq.wlt` is **fully compliant** with the wolfram-testing skill guidelines.

**Strengths:**
- Clean structure with proper sectioning using Wolfram Language comment markers
- Comprehensive test coverage including symbol existence, context verification, and isolation tests
- Well-designed helper function (`headSymbolInContextQ`) for reusable context checking
- TestIDs are descriptive and follow the `SymbolName-Scenario-Behavior` convention consistently
- Proper use of `Module` for complex tests with local variables

**Test Count:** 22 tests covering:
- Symbol existence (1 test)
- `$exogenousVars` structure (3 tests)
- Individual context verification (11 tests)
- Generic context tests (3 tests)
- Context isolation behavior (6 tests)
