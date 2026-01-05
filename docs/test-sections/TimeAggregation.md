### TimeAggregation.wl

This module provides time aggregation utilities for converting high-frequency data to lower frequencies (e.g., monthly to quarterly or annual).

---

#### Context Loading and Symbol Availability

- **Context is loaded and on $ContextPath**
```wolfram
MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"]
(* Expected: True *)
```

- **Private symbol `growth` is accessible**
```wolfram
Not[Names["*growth"] === {}]
(* Expected: True *)
```

---

#### Tests for `growth` Function

##### Basic Identity Tests (No Aggregation)

- **growth with default parameters returns identity**
```wolfram
growth[dc, t] == dc[t]
growth[dc, t, "TimeAggregation" -> 1, "numPeriods" -> 1] == dc[t]
```

##### Tent-Shaped Coefficients

- **TimeAggregation=3 produces tent-shaped coefficients**
```wolfram
growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1] ==
  1/3 (dc[-4 + t] + 2 dc[-3 + t] + 3 dc[-2 + t] + 2 dc[-1 + t] + dc[t])
```

- **TimeAggregation=12 produces correct coefficient pattern**
```wolfram
(growth[dc, t, "TimeAggregation" -> 12, "numPeriods" -> 1] /.
  Plus -> List /. Times -> List /. dc[{x__, t}] -> -x /. dc[t] -> 0) ==
  {{1/12, 22}, {1/6, 21}, {1/4, 20}, {1/3, 19}, {5/12, 18}, {1/2, 17},
   {7/12, 16}, {2/3, 15}, {3/4, 14}, {5/6, 13}, {11/12, 12}, 11,
   {11/12, 10}, {5/6, 9}, {3/4, 8}, {2/3, 7}, {7/12, 6}, {1/2, 5},
   {5/12, 4}, {1/3, 3}, {1/4, 2}, {1/6, 1}, {1/12, 0}}
```

##### Expansion Around v0

- **Constant v0 with different argument counts yields same result**
```wolfram
growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1,
  "v0" -> Function[{t, j, h, k, v, im}, 0.0015]] ==
  0.` + 0.3328334585207629` dc[-4 + t] + 0.6661665418542368` dc[-3 + t] +
  dc[-2 + t] + 0.6671665414792372` dc[-1 + t] + 0.33383345814576315` dc[t]

(* Same result for Function with 5, 4, 3, 2, 1, or 0 arguments *)
```

- **v0 as a function of t**
```wolfram
Simplify@growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1,
  "v0" -> Function[{t, j, h, k, v, im}, t]] ==
  1/(1 + E^t + E^(2 t)) (dc[-4 + t] + (1 + E^t) dc[-3 + t] +
    dc[-2 + t] + E^t dc[-2 + t] + E^(2 t) dc[-2 + t] +
    E^t dc[-1 + t] + E^(2 t) dc[-1 + t] + E^(2 t) dc[t])
```

- **v0 as a function of h (aggregation period)**
```wolfram
(* h=12 case uses h12 value, h!=12 uses hnot12 *)
FreeQ[growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1,
  "v0" -> Function[{t, j, h, k, v, im}, If[h == 12, h12, hnot12]]], h12]
(* Expected: True - h=3 so h12 should not appear *)

FreeQ[growth[dc, t, "TimeAggregation" -> 12, "numPeriods" -> 1,
  "v0" -> Function[{t, j, h, k, v, im}, If[h == 12, h12, hnot12]]], hnot12]
(* Expected: True - h=12 so hnot12 should not appear *)
```

##### Constant Term Properties

- **For v0 independent of j, constant term in expansion is 0**
```wolfram
0 === (Coefficient[growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1,
    "v0" -> Function[{t, j, h, k, v, im}, -1/(h + 1)]] /. dc[__] -> dcX, dcX, 0] // FullSimplify)
0 === (Coefficient[growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 3,
    "v0" -> Function[{t, j, h, k, v, im}, h^2]] /. dc[__] -> dcX, dcX, 0] // FullSimplify)
0 === (Coefficient[growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1,
    "v0" -> Function[{t, j, h, k, v, im}, im]] /. dc[__] -> dcX, dcX, 0] // FullSimplify)
0 === (Coefficient[growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 3,
    "v0" -> Function[{t, j, h, k, v, im}, v]] /. dc[__] -> dcX, dcX, 0] // FullSimplify)
0 === (Coefficient[growth[dd, t, i, "TimeAggregation" -> 3, "numPeriods" -> 1,
    "v0" -> Function[{t, j, h, k, v, im}, im]] /. dd[__, i] -> ddX, ddX, 0] // FullSimplify)
```

- **Constant term is 0 for arbitrary functions of h, v, im (not j)**
```wolfram
arbitraryFun1 = Function[{t, j, h, k, v}, Sqrt[h]];
arbitraryFun2 = Function[{t, j, h, k, v}, If[v == dd, Sqrt[h], Cos[h]]];
arbitraryFun3 = Function[{t, j, h, k, v}, -h];
arbitraryFun4 = Function[{t, j, h, k, v}, Sqrt[h] t - k^2];
arbitraryFun5 = Function[{t, j, h, k, v}, If[v == dd, Sqrt[h] Sqrt[t], Exp[t] Cos[h]]];
arbitraryFun6 = Function[{t, j, h, k, v}, -h*t*k];
(* All should give constant term = 0 *)
```

- **Dependence on j implies constant term is NOT necessarily 0**
```wolfram
Not[0 === Coefficient[growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 3,
    "v0" -> Function[{t, j, h, k, v, im}, j]] /. dc[__] -> dcX, dcX, 0] // N]
(* Expected: True *)
```

- **v0 as a function of j**
```wolfram
growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1,
  "v0" -> Function[{t, j}, j]] ==
  (-7 - 3 E^4 + dc[-4 + t] + dc[-3 + t] + E^4 dc[-3 + t])/(1 + E^4 + E^7) +
  dc[-2 + t] + dc[-1 + t] + dc[t] +
  (1 - dc[-1 + t] - dc[t] - E dc[t])/(1 + 2 E) -
  Log[1 + 1/E^7 + 1/E^3] + Log[2 + 1/E]
```

##### v0 as Function of Variable Type (v)

- **v0 responds to variable type**
```wolfram
Not@FreeQ[growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1,
  "v0" -> Function[{t, j, h, k, v, im}, If[v === dc, Edc, 0]]], Edc]
(* Expected: True - dc variable uses Edc *)

FreeQ[growth[pi, t, "TimeAggregation" -> 3, "numPeriods" -> 1,
  "v0" -> Function[{t, j, h, k, v, im}, If[v === dc, Edc, 0]]], Edc]
(* Expected: True - pi variable does not use Edc *)

Not@FreeQ[growth[dd, t, i, "TimeAggregation" -> 12, "numPeriods" -> 1,
  "v0" -> Function[{t, j, h, k, v, im}, If[v === dd, Edd, 0]]], Edd]
(* Expected: True - dd variable uses Edd *)

FreeQ[growth[dc, t, "TimeAggregation" -> 12, "numPeriods" -> 1,
  "v0" -> Function[{t, j, h, k, v, im}, If[v === dd, Edd, 0]]], Edd]
(* Expected: True - dc variable does not use Edd *)
```

##### v0 from Unconditional Moments

- **Using unconditional expectation for v0**
```wolfram
(growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1,
    "v0" -> Function[{t, j, h, k, v, im}, Evaluate@uncondE[dc[t]]]] /.
  uncondE[dc[t]] -> 0) == growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1]
```

##### Periodicity Condition for v0

- **v0(t,i) = v0(t, kh+i) for i=0,...,h-2 implies constant term is 0**
```wolfram
(* h=1, k=1 *)
0 === Coefficient[growth[dc, t, "TimeAggregation" -> 1, "numPeriods" -> 1,
    "v0" -> Function[{t, j, h, k, v, im}, F[t]]] /. dc[__] -> dcX, dcX, 0] // Simplify

(* h=2, k=1 with rulej = {F[0] -> F[2]} *)
0 === Coefficient[growth[dc, t, "TimeAggregation" -> 2, "numPeriods" -> 1,
    "v0" -> Function[{t, j, h, k, v, im}, F[j]]] /. rulej /. dc[__] -> dcX, dcX, 0] // FullSimplify

(* h=3, k=1 with rulej = {F[0] -> F[3], F[1] -> F[4]} *)
0 === Coefficient[growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1,
    "v0" -> Function[{t, j, h, k, v, im}, F[j]]] /. rulej /. dc[__] -> dcX, dcX, 0] // FullSimplify

(* h=4, k=1 with rulej = {F[0] -> F[4], F[1] -> F[5], F[2] -> F[6]} *)
0 === Coefficient[growth[dc, t, "TimeAggregation" -> 4, "numPeriods" -> 1,
    "v0" -> Function[{t, j, h, k, v, im}, F[j]]] /. rulej /. dc[__] -> dcX, dcX, 0] // FullSimplify
```

##### Order Parameter Tests

- **Order parameter controls maximum power in expansion (dc variable)**
```wolfram
Cases[Expand@growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 0],
  coef_. *dc[__]^p_. :> p] === {}
Max@Cases[Expand@growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 1],
  coef_. *dc[__]^p_. :> p] === 1
Max@Cases[Expand@growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 2],
  coef_. *dc[__]^p_. :> p] === 2
Max@Cases[Expand@growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 3],
  coef_. *dc[__]^p_. :> p] === 3
```

- **Order parameter controls maximum power in expansion (dd variable with index)**
```wolfram
Cases[Expand@growth[dd, t, i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 0],
  coef_. *dd[__, i]^p_. :> p] === {}
Max@Cases[Expand@growth[dd, t, i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 1],
  coef_. *dd[__, i]^p_. :> p] === 1
Max@Cases[Expand@growth[dd, t, i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 2],
  coef_. *dd[__, i]^p_. :> p] === 2
Max@Cases[Expand@growth[dd, t, i, "TimeAggregation" -> 3, "numPeriods" -> 1, "Order" -> 3],
  coef_. *dd[__, i]^p_. :> p] === 3
```

---

#### Private Helper Functions

- **Private symbols are accessible**
```wolfram
f = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`f;
g = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g;
s = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`s;
timeSeriesVector = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`timeSeriesVector;
gt = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`gt;
(* Expected: True *)
```

---

#### Tests for `gt` Function

##### Basic gt Tests

- **gt with default and various option forms (h=3, k=2)**
```wolfram
gt[dc, t] == dc[t]

gt[dc, t, {"TimeAggregation" -> 3, "numPeriods" -> 2}] ==
  dc[-5 + t] + dc[-4 + t] + dc[-3 + t] + dc[-2 + t] + dc[-1 + t] + dc[t] -
  Log[1 + E^(-dc[-7 + t] - dc[-6 + t]) + E^-dc[-6 + t]] +
  Log[1 + E^(-dc[-1 + t] - dc[t]) + E^-dc[t]]

gt[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 2] ==
  (* same as above *)
```

- **gt with indexed variable dd**
```wolfram
gt[dd, t, i, {"TimeAggregation" -> 3, "numPeriods" -> 2}] ==
  dd[-5 + t, i] + dd[-4 + t, i] + dd[-3 + t, i] + dd[-2 + t, i] + dd[-1 + t, i] + dd[t, i] -
  Log[1 + E^(-dd[-7 + t, i] - dd[-6 + t, i]) + E^-dd[-6 + t, i]] +
  Log[1 + E^(-dd[-1 + t, i] - dd[t, i]) + E^-dd[t, i]]

(* Same for specific indices i=1 and i=2 *)
```

##### gt with Stock Variable Type

- **gt with Variable->Stock returns simple sum**
```wolfram
gt[dc, t] == dc[t]
gt[dc, t, "Variable" -> "Stock"] == dc[t]
gt[dc, t, "TimeAggregation" -> 3, "Variable" -> "Stock"] == dc[-2 + t] + dc[-1 + t] + dc[t]

gt[dd, t, i, {"numPeriods" -> 2}, "Variable" -> "Stock"] == dd[-1 + t, i] + dd[t, i]
gt[dd, t, i, "Variable" -> "Stock"] == dd[t, i]

gt[dd, t, 1, {"TimeAggregation" -> 3}, "Variable" -> "Stock"] == dd[-2 + t, 1] + dd[-1 + t, 1] + dd[t, 1]
gt[dd, t, 2, "Variable" -> "Stock"] == dd[t, 2]
```

- **gt with combined TimeAggregation and numPeriods for Stock**
```wolfram
gt[dc, t, {"TimeAggregation" -> 3, "numPeriods" -> 2}, "Variable" -> "Stock"] ==
  dc[-5 + t] + dc[-4 + t] + dc[-3 + t] + dc[-2 + t] + dc[-1 + t] + dc[t]

gt[dd, t, i, {"TimeAggregation" -> 3, "numPeriods" -> 2}, "Variable" -> "Stock"] ==
  dd[-5 + t, i] + dd[-4 + t, i] + dd[-3 + t, i] + dd[-2 + t, i] + dd[-1 + t, i] + dd[t, i]
```

---

#### Tests for `g[timeSeriesVector]`

##### Basic g with timeSeriesVector

- **g with timeSeriesVector for flow variables (h=3, k=1)**
```wolfram
g[timeSeriesVector[dc, t, "TimeAggregation" -> 3], 3] ==
  dc[-2 + t] + dc[-1 + t] + dc[t] -
  Log[1 + E^(-dc[-4 + t] - dc[-3 + t]) + E^-dc[-3 + t]] +
  Log[1 + E^(-dc[-1 + t] - dc[t]) + E^-dc[t]]

g[timeSeriesVector[dc, t, "numPeriods" -> 1], 1, 1] == dc[t]

g[timeSeriesVector[dc, t, {"TimeAggregation" -> 3, "numPeriods" -> 1}], 3, 1] ==
  (* same as above flow variable result *)

g[timeSeriesVector[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1], 3, 1] ==
  (* same as above flow variable result *)
```

##### g Returns Unevaluated for Wrong Vector Length

- **g with incorrect vector length returns unevaluated**
```wolfram
g[timeSeriesVector[dc, t], 3] ==
  FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{dc[t]}, 3]

g[timeSeriesVector[dc, t, "TimeAggregation" -> 3][[;; -2]], 3] ==
  FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[
    {dc[t], dc[-1 + t], dc[-2 + t], dc[-3 + t]}, 3]

g[timeSeriesVector[dc, t, "numPeriods" -> 1][[;; -2]], 1, 1] ==
  FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{}, 1, 1]
```

##### g with Variable->Flow

- **Explicit Variable->Flow option**
```wolfram
g[timeSeriesVector[dc, t, "TimeAggregation" -> 3], 3, "Variable" -> "Flow"] ==
  dc[-2 + t] + dc[-1 + t] + dc[t] -
  Log[1 + E^(-dc[-4 + t] - dc[-3 + t]) + E^-dc[-3 + t]] +
  Log[1 + E^(-dc[-1 + t] - dc[t]) + E^-dc[t]]

g[timeSeriesVector[dc, t, "numPeriods" -> 1], 1, 1, "Variable" -> "Flow"] == dc[t]
```

##### g with Variable->Stock

- **Variable->Stock returns simple sum**
```wolfram
g[timeSeriesVector[dc, t, "TimeAggregation" -> 3], 3, "Variable" -> "Stock"] ==
  dc[-2 + t] + dc[-1 + t] + dc[t]

g[timeSeriesVector[dc, t, "numPeriods" -> 1], 1, 1, "Variable" -> "Stock"] == dc[t]

g[timeSeriesVector[dc, t, {"TimeAggregation" -> 3, "numPeriods" -> 1}], 3, 1, "Variable" -> "Stock"] ==
  dc[-2 + t] + dc[-1 + t] + dc[t]
```

- **g with truncated vector for Stock**
```wolfram
g[timeSeriesVector[dc, t], 1, "Variable" -> "Stock"] == dc[t]

g[timeSeriesVector[dc, t, "TimeAggregation" -> 3][[;; 3]], 3, "Variable" -> "Stock"] ==
  dc[-2 + t] + dc[-1 + t] + dc[t]
```

- **g returns unevaluated for wrong length with Stock**
```wolfram
g[timeSeriesVector[dc, t], "Variable" -> "Stock"] ==
  FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[{dc[t]}, "Variable" -> "Stock"]

g[timeSeriesVector[dc, t, "TimeAggregation" -> 3][[;; 4]], 3, "Variable" -> "Stock"] ==
  FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g[
    {dc[t], dc[-1 + t], dc[-2 + t], dc[-3 + t]}, 3, "Variable" -> "Stock"]
```

##### g with Indexed Variables

- **g with dd variable (indexed)**
```wolfram
g[timeSeriesVector[dd, t, i], 1] == dd[t, i]

g[timeSeriesVector[dd, t, i, "TimeAggregation" -> 3], 3] ==
  dd[-2 + t, i] + dd[-1 + t, i] + dd[t, i] -
  Log[1 + E^(-dd[-4 + t, i] - dd[-3 + t, i]) + E^-dd[-3 + t, i]] +
  Log[1 + E^(-dd[-1 + t, i] - dd[t, i]) + E^-dd[t, i]]

g[timeSeriesVector[dd, t, i, "numPeriods" -> 1], 1, 1] == dd[t, i]

g[timeSeriesVector[dd, t, i, {"TimeAggregation" -> 3, "numPeriods" -> 1}], 3, 1] ==
  (* same flow result with dd *)
```

##### g with Bond Returns

- **g with bondret variable**
```wolfram
g[timeSeriesVector[bondret, t, m, "TimeAggregation" -> 3], 3] ==
  bondret[-2 + t, m] + bondret[-1 + t, m] + bondret[t, m] -
  Log[1 + E^(-bondret[-4 + t, m] - bondret[-3 + t, m]) + E^-bondret[-3 + t, m]] +
  Log[1 + E^(-bondret[-1 + t, m] - bondret[t, m]) + E^-bondret[t, m]]

g[timeSeriesVector[bondret, t, m, "numPeriods" -> 1], 1, 1] == bondret[t, m]

g[timeSeriesVector[bondret, t, m, {"TimeAggregation" -> 3, "numPeriods" -> 1}], 3, 1] ==
  (* same flow result with bondret *)
```

---

#### Tests for `timeSeriesVector`

- **timeSeriesVector generates correct lag sequences**
```wolfram
timeSeriesVector[dc, t] == {dc[t]}

timeSeriesVector[dc, t, "TimeAggregation" -> 3] ==
  {dc[t], dc[-1 + t], dc[-2 + t], dc[-3 + t], dc[-4 + t]}

timeSeriesVector[dc, t, "numPeriods" -> 6] ==
  {dc[t], dc[-1 + t], dc[-2 + t], dc[-3 + t], dc[-4 + t], dc[-5 + t]}

timeSeriesVector[dc, t, {"TimeAggregation" -> 12, "numPeriods" -> 3}] ==
  {dc[t], dc[-1 + t], dc[-2 + t], ..., dc[-46 + t]}
  (* 47 elements total for h=12, k=3 *)

timeSeriesVector[dc, t, "TimeAggregation" -> 12, "numPeriods" -> 3] ==
  (* same as list form above *)
```

## WLT Verification Results

Verification of `/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-clean-up/Tests/Tools/TimeAggregation.wlt` against wolfram-testing skill guidelines.

### Compliance Summary

| Guideline | Status | Notes |
|-----------|--------|-------|
| Use `TestCreate` exclusively (not `VerificationTest`) | PASS | All 41 tests use `TestCreate` |
| Always include third argument for expected messages | PASS | All tests include `{}` as third argument |
| TestID format: `SymbolName-Scenario-Behavior` | PASS | All TestIDs follow the convention |
| BeginTestSection names file being tested | PASS | Uses `"Kernel/Tools/TimeAggregation.wl Tests"` |
| Load shared helpers via `$TestFileName` | PASS | Line 16: `Get[FileNameJoin[{DirectoryName[$TestFileName, 2], "Common.wl"}]]` |
| Use `Needs` for required contexts | PASS | Line 10: `Needs["FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"]` |
| Only load contexts actually used | PASS | Only loads TimeAggregation context which is used |
| No `Quiet` in test assertions | PASS | No `Quiet` used anywhere in tests |
| No `TimeConstraint`/`MemoryConstraint`/`MetaInformation` | PASS | None used (as expected) |
| Context isolation with `Begin`/`End` | PASS | Properly wrapped in `Begin["...Tests`Tools`TimeAggregation`"]` and `End[]` |
| Private functions fully qualified | PASS | Private symbols accessed via aliases pointing to fully qualified names |
| One assertion per behavior | PASS | Each test covers a single behavior |
| Fixtures are tiny/inline | PASS | Uses inline construction with `Module` where needed |
| No paclet initialization boilerplate | PASS | No `PacletDirectoryLoad` or path resolution blocks |

### TestID Convention Analysis

All TestIDs follow the `SymbolName-Scenario-Behavior` pattern appropriately:

- **Context tests**: `TimeAggregation-Context-OnContextPath`, `growth-Export-IsPublic`
- **Function tests**: `growth-DefaultParams-ReturnsIdentity`, `gt-ListFormOptions-CorrectResult`
- **Private function tests**: `g-TimeSeriesVectorFlow-CorrectResult`, `timeSeriesVector-Default-SingleElement`

### Private Symbol Access Pattern

The file uses an effective alias pattern for private symbols (lines 24-26):
```wolfram
$g = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`g;
$timeSeriesVector = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`timeSeriesVector;
$gt = FernandoDuarte`LongRunRisk`Tools`TimeAggregation`Private`gt;
```

This is a clean approach that:
- Maintains full qualification requirement for private symbols
- Improves readability throughout tests
- Centralizes the qualified references

### Overall Assessment

**FULLY COMPLIANT** - The WLT file follows all wolfram-testing skill guidelines. The test file demonstrates good practices including proper structure, consistent naming, appropriate use of `Module` for complex assertions, and clean private symbol access patterns.
