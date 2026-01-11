# Master Refactor Plan: ToNumber.wl

## Document Status
- **Version:** 1.1
- **Date:** 2026-01-11
- **Last Updated:** 2026-01-11 (Post-Test Validation)
- **Sources:** Codex Analysis, Gemini Analysis, Claude Analysis, **Test Validation**
- **API Contract:** NO CHANGES to public API

---

## Test Validation Summary

Bug coverage tests were added to `Tests/Tools/ToNumber.wlt` and executed. Results:

| Suspected Bug | Test Result | Status |
|---------------|-------------|--------|
| `===` vs `==` in SignsA/SignsB comparison | **4 TESTS FAILED** | **CONFIRMED** |
| SubsetQ argument reversal | 3 tests passed | **DISPROVED** |
| SolutionIndexB unused | Test passed (identical results with/without) | **CONFIRMED** |
| Object identity comparison issue | Test passed | **DISPROVED** |

**Key Finding:** The primary bug requiring immediate fix is the `===` vs `==` comparison operator issue in selector matching (Lines 408, 409, 423).

---

## Executive Summary

This plan transforms `ToNumber.wl` from a 745-line monolithic file with organic complexity into a modular, maintainable package. The refactoring is divided into 6 phases, each independently testable, with the option to stop after any phase while leaving the codebase in a better state.

---

## Guiding Principles

1. **Single Source of Truth:** Each concept defined once
2. **Explicit Over Magic:** Pattern matching over metaprogramming
3. **Fail Fast:** `Failure` objects over `Abort[]`
4. **Flat Over Nested:** Early returns over arrow code
5. **Incremental Progress:** Each phase delivers value independently

---

## Phase 0: Bug Fixes (Pre-Refactoring)

**Objective:** Fix confirmed bugs before structural changes.

### Tasks

#### 0.1 ~~Fix SubsetQ Argument Order~~ - DISPROVED
~~**Location:** Line 370~~

**Status:** Test validation showed partial selectors work correctly. The SubsetQ logic is NOT reversed. No fix needed.

#### 0.2 Fix Selector Comparison Operators - CONFIRMED
**Locations:** Lines 408, 409, 423
**Test Evidence:** 4 bug coverage tests failed, confirming this issue.

```wolfram
(* BEFORE - fails on {1} vs {1.} *)
aSol["SignsA"] === selector["SignsA"]

(* AFTER - numeric equality *)
aSol["SignsA"] == selector["SignsA"]
```

**Failing Tests:**
- `[toNum/BugCoverage] SignsA with Real values matches Integer solutions`
- `[toNum/BugCoverage] SignsB with Real values matches Integer solutions`
- `[toNum/BugCoverage] User-constructed SignsA pattern works`
- `[toNum/BugCoverage] User-constructed Real SignsA pattern works`

#### 0.3 Add Missing B Solutions Error Message - RECOMMENDED
**Location:** After line 48
```wolfram
toNum::nobsolutions = "No valid B solutions found for one or more stocks. The model may be unsolvable with the given parameters.";
```
Then update `flattenCoeffsFromSelected` (lines 490-492) to use this message.

**Status:** Not yet validated by tests, but improves user experience.

#### 0.4 Remove or Implement SolutionIndexB - CONFIRMED UNUSED
**Test Evidence:** Test `[toNum/BugCoverage] SolutionIndexB currently ignored` passed, confirming identical results with/without SolutionIndexB.

**Decision Required:** Either:
- Remove from `validKeys` at line 366 (simpler)
- Implement filtering logic in `selectByAssociation` (if needed)

**Recommendation:** Remove for now, add back when implemented.

### Validation
- Run existing tests: `Tests/Tools/ToNumber.wlt`
- Run bug coverage tests: Filter for `BugCoverage` in TestID
- After fix: All 4 failing comparison tests should pass

---

## Phase 1: Extract Core Helpers

**Objective:** Eliminate DRY violations by extracting shared logic.

### Tasks

#### 1.1 Create `applyRules` Helper
```wolfram
(* Single source of truth for rule application *)
applyRules[expr_, rules_, maxIter_:10] :=
    FixedPoint[ReplaceAll[#, rules] &, expr, maxIter]
```

Replace usages at lines 125, 147, 168.

#### 1.2 Create `makeFailure` Helper
```wolfram
(* Standardized failure creation *)
makeFailure[tag_String, msgTemplate_, params_List:{}] :=
    Failure[tag, <|"MessageTemplate" -> msgTemplate, "MessageParameters" -> params|>]
```

Replace all inline `Failure[...]` constructions.

#### 1.3 Create `buildASolutionAssoc` Helper
```wolfram
(* Single source for A solution association structure *)
buildASolutionAssoc[aSol_, stocks_] := Association[
    "IntervalA" -> aSol["IntervalA"],
    "SignsA" -> aSol["SignsA"],
    "SolutionIndexA" -> aSol["SolutionIndexA"],
    "IntervalIndexA" -> aSol["IntervalIndexA"],
    "A" -> aSol["A"],
    "Stocks" -> stocks,
    If[!MissingQ[aSol["Bond"]], "Bond" -> aSol["Bond"], Nothing],
    If[!MissingQ[aSol["NomBond"]], "NomBond" -> aSol["NomBond"], Nothing]
]
```

Replace duplicated construction at lines 345-357 and 430-439.

#### 1.4 Create `isHierarchicalResult` Helper
```wolfram
(* Clear predicate for result type *)
isHierarchicalResult[result_] :=
    MatchQ[result, {__Association} /; KeyExistsQ[First[result], "A"]]
```

Replace inline check at line 120.

### Validation
- All existing tests pass
- Code is shorter but behavior identical

---

## Phase 2: Simplify Metaprogramming

**Objective:** Replace opaque metaprogramming with explicit pattern matching.

### Tasks

#### 2.1 Replace `modelEval` Implementation

**Delete:** Lines 555-652 (GlobalProperties, clone, withUserDefs, moms)

**New Implementation:**
```wolfram
(* Moment symbols that need model injection *)
$MomentSymbols = {
    uncondE, uncondVar, uncondCov, uncondCorr,
    ev, var, cov, corr,
    FernandoDuarte`LongRunRisk`UncondE,
    FernandoDuarte`LongRunRisk`UncondVar,
    FernandoDuarte`LongRunRisk`UncondCov,
    FernandoDuarte`LongRunRisk`UncondCorr,
    FernandoDuarte`LongRunRisk`Ev,
    FernandoDuarte`LongRunRisk`Var,
    FernandoDuarte`LongRunRisk`Cov,
    FernandoDuarte`LongRunRisk`Corr
};

(* Simple pattern-based model injection *)
modelEval[expr_, model_] := expr /.
    (f_ /; MemberQ[$MomentSymbols, f])[args___] :> f[args, model]
```

**Lines Removed:** ~100
**Lines Added:** ~20
**Net Reduction:** ~80 lines

### Validation
- Test with expressions containing moment functions
- Verify `uncondE[x[t]]` becomes `uncondE[x[t], model]`

---

## Phase 3: Refactor Parameter Processing

**Objective:** Decompose `processNewParameters` into focused helpers.

### Tasks

#### 3.1 Extract `splitParamKey` Helper
```wolfram
(* Parse symbol into {context, name, index} *)
splitParamKey[sym_Symbol] := {Context[sym], SymbolName[sym]}
splitParamKey[sym_Symbol[idx_Integer]] := {Context[sym], SymbolName[sym], idx}
```

#### 3.2 Extract `normalizeParamKeys` Helper
```wolfram
(* Apply key splitting to association *)
normalizeParamKeys[params_] := KeyMap[splitParamKey, Association[params]]
```

#### 3.3 Extract `validateParamSubset` Helper
```wolfram
(* Validate new params are subset of base params *)
validateParamSubset[newNorm_, baseNorm_] := Module[{newKeys, baseKeys, invalid},
    newKeys = Map[Rest, Keys[newNorm]];  (* Drop context *)
    baseKeys = Map[Rest, Keys[baseNorm]];
    invalid = Select[newKeys, !MemberQ[baseKeys, #] &];
    If[invalid =!= {},
        Message[processNewParameters::subsetparam, invalid];
        makeFailure["InvalidParameters", processNewParameters::subsetparam, {invalid}],
        Success["Validation", <|"ValidatedParams" -> newNorm|>]
    ]
]
```

#### 3.4 Extract `enforceGammaPsiTheta` Helper
```wolfram
(* Handle gamma/psi/theta constraints *)
enforceGammaPsiTheta[paramsNorm_] := Module[{gamma, psi, theta, count, result},
    (* Extract string-keyed values *)
    gamma = Lookup[KeyMap[#[[2]]&, paramsNorm], "gamma", Missing[]];
    psi = Lookup[KeyMap[#[[2]]&, paramsNorm], "psi", Missing[]];
    theta = Lookup[KeyMap[#[[2]]&, paramsNorm], "theta", Missing[]];

    (* Check psi=1 *)
    If[!MissingQ[psi] && N[psi] === 1.,
        Message[processNewParameters::psi];
        Return[makeFailure["InvalidPsi", processNewParameters::psi, {}]]
    ];

    count = Count[{gamma, psi, theta}, _?(!MissingQ[#]&)];

    Switch[count,
        3, (* All provided - validate theta *)
            With[{computedTheta = (1 - gamma)/(1 - 1/psi)},
                If[RealAbs[theta - computedTheta] >= $MachineEpsilon,
                    Message[processNewParameters::param, computedTheta]
                ];
                KeyDrop[paramsNorm, _?(#[[2]] === "theta" &)]
                    ~Join~ <|{"Global`", "theta"} -> computedTheta|>
            ],
        2, (* Two provided - solve for third *)
            (* ... solve logic ... *)
            paramsNorm,
        1, (* One provided *)
            If[!MissingQ[theta],
                Message[processNewParameters::theta];
                makeFailure["MissingParams", processNewParameters::theta, {}],
                paramsNorm
            ],
        _, (* Zero or other *)
            paramsNorm
    ]
]
```

#### 3.5 Extract `reconcileContexts` Helper
```wolfram
(* Map normalized keys back to original contexts *)
reconcileContexts[processedNorm_, baseParams_] := Module[{baseSplit, positions},
    baseSplit = normalizeParamKeys[baseParams];
    positions = Position[Rest /@ Keys[baseSplit], #]& /@ (Rest /@ Keys[processedNorm]);
    Thread[Extract[Keys[Association[baseParams]], Flatten[positions, 1]] -> Values[processedNorm]]
]
```

#### 3.6 Rewrite `processNewParameters`
```wolfram
processNewParameters[newParams_, baseParams_] := Module[{newNorm, baseNorm, validated, constrained},
    If[newParams === {}, Return[{}]];

    newNorm = normalizeParamKeys[newParams /. Join[newParams, baseParams]];
    baseNorm = normalizeParamKeys[baseParams /. baseParams];

    validated = validateParamSubset[newNorm, baseNorm];
    If[FailureQ[validated], Return[validated]];

    constrained = enforceGammaPsiTheta[newNorm];
    If[FailureQ[constrained], Return[constrained]];

    reconcileContexts[constrained, baseParams]
]
```

**Key Change:** Replace `Abort[]` with `Return[Failure[...]]`

### Validation
- Test psi=1 returns Failure (not Abort)
- Test theta without gamma/psi returns Failure
- Test valid parameters work unchanged

---

## Phase 4: Simplify Dispatch Mechanism

**Objective:** Replace fragile pattern matching with explicit dispatcher.

### Tasks

#### 4.1 Create Internal Dispatcher
```wolfram
(* Clear, explicit dispatch based on first argument *)
iToNumDispatch["Rules", model_, args___] := toNumRules[model, args];
iToNumDispatch[expr_, model_, args___] := toNumEvaluate[expr, model, args];
```

#### 4.2 Simplify Public `toNum` Definitions
```wolfram
(* Pattern 1: Rules extraction *)
toNum["Rules", model_Association, rest___] := iToNumDispatch["Rules", model, rest];

(* Pattern 2: Curried form *)
toNum[model_Association] := Function[{expr}, toNum[expr, model]];

(* Pattern 3: Expression evaluation - single unified pattern *)
toNum[expr_, model_Association, rest___] /; expr =!= "Rules" :=
    iToNumDispatch[expr, model, rest];
```

#### 4.3 Create `toNumEvaluate` Internal Function
```wolfram
toNumEvaluate[expr_, model_, newParams_:{}, opts:OptionsPattern[{toNumRules, updateCoeffs}]] :=
    Module[{rules, allParams, transformed},
        rules = toNumRules[model, newParams, opts];
        If[FailureQ[rules], Return[rules]];

        allParams = Join[
            model["params"],
            processNewParameters[newParams, model["params"]]
        ] // Normal // Association // Normal;

        transformed = toEquation[expr, model];

        If[isHierarchicalResult[rules],
            evaluateExprHierarchical[transformed, model, rules, allParams],
            applyRules[transformed, rules]
        ]
    ]
```

### Validation
- `toNum["Rules", model]` works
- `toNum[expr, model]` works
- `toNum[model][expr]` works
- No infinite recursion

---

## Phase 5: Extract to Separate Files

**Objective:** Split into logical modules for maintainability.

### Target Structure
```
Kernel/Tools/ToNumber.wl           (Public shell - ~50 lines)
Kernel/Tools/ToNumber/
├── Dispatch.wl                    (toNum, iToNumDispatch - ~40 lines)
├── Rules.wl                       (toNumRules, selectAndFormat - ~80 lines)
├── Selectors.wl                   (selectSolutions, selectBy* - ~150 lines)
├── Evaluation.wl                  (evaluateExprHierarchical, helpers - ~60 lines)
├── Parameters.wl                  (processNewParameters, helpers - ~80 lines)
├── ModelTransform.wl              (toEquation, toExogenousVars, etc - ~50 lines)
└── Helpers.wl                     (applyRules, makeFailure, etc - ~30 lines)
```

### Tasks

#### 5.1 Create Directory Structure
```
mkdir -p Kernel/Tools/ToNumber
```

#### 5.2 Create `ToNumber.wl` (Public Shell)
```wolfram
(* ::Package:: *)

BeginPackage["FernandoDuarte`LongRunRisk`Tools`ToNumber`"]

(* Public symbols *)
toNum
toEquation
toExogenousVars
toStateVars
processNewParameters

(* Usage messages *)
toNum::usage = "..."
(* ... other usage messages ... *)

(* Error messages *)
toNum::badselector = "..."
(* ... other error messages ... *)

Begin["`Private`"]

(* Load sub-modules in dependency order *)
Get["FernandoDuarte`LongRunRisk`Tools`ToNumber`Helpers`"]
Get["FernandoDuarte`LongRunRisk`Tools`ToNumber`Parameters`"]
Get["FernandoDuarte`LongRunRisk`Tools`ToNumber`ModelTransform`"]
Get["FernandoDuarte`LongRunRisk`Tools`ToNumber`Selectors`"]
Get["FernandoDuarte`LongRunRisk`Tools`ToNumber`Evaluation`"]
Get["FernandoDuarte`LongRunRisk`Tools`ToNumber`Rules`"]
Get["FernandoDuarte`LongRunRisk`Tools`ToNumber`Dispatch`"]

End[]

EndPackage[]
```

#### 5.3 Create Sub-Module Template
Each sub-module follows this pattern:
```wolfram
(* ::Package:: *)

(* Internal module - loaded by ToNumber.wl *)

(* Dependencies *)
Needs["FernandoDuarte`LongRunRisk`..."]

(* Private implementations *)
functionName[args_] := ...
```

### Load Order Dependencies
```
Helpers.wl        (no dependencies)
    ↓
Parameters.wl     (depends on Helpers)
    ↓
ModelTransform.wl (depends on Helpers)
    ↓
Selectors.wl      (depends on Helpers)
    ↓
Evaluation.wl     (depends on Helpers, Selectors)
    ↓
Rules.wl          (depends on Helpers, Selectors, Evaluation, Parameters)
    ↓
Dispatch.wl       (depends on Rules, Evaluation, ModelTransform)
```

### Validation
- Package loads without errors
- All public functions accessible
- All existing tests pass

---

## Phase 6: Final Cleanup

**Objective:** Polish and document.

### Tasks

#### 6.1 Add Internal Documentation
- Document each sub-module's purpose
- Add function-level comments for complex helpers
- Document load order in main file

#### 6.2 Remove Dead Code
- Delete any unreachable code paths
- Remove commented-out code blocks

#### 6.3 Consistent Naming
- All private helpers use camelCase
- All predicates start with `is` or `has`
- All validators return `Success`/`Failure`

#### 6.4 Final Test Pass
- Run full test suite
- Manual testing of edge cases
- Performance comparison (before/after)

---

## Implementation Schedule

| Phase | Effort | Risk | Dependencies |
|-------|--------|------|--------------|
| Phase 0 | Low | Low | None |
| Phase 1 | Low | Low | Phase 0 |
| Phase 2 | Medium | Medium | Phase 1 |
| Phase 3 | Medium | Medium | Phase 1 |
| Phase 4 | Medium | High | Phase 1, 2, 3 |
| Phase 5 | High | Medium | Phase 4 |
| Phase 6 | Low | Low | Phase 5 |

**Recommended Approach:** Complete Phases 0-3 first. These deliver the most value with least risk. Phases 4-6 can be done later as needed.

---

## Success Metrics

1. **Code Reduction:** Target 20% fewer lines while preserving functionality
2. **Test Coverage:** All existing tests pass, new edge case tests added
3. **Cyclomatic Complexity:** Reduce max nesting from 6+ to 3
4. **DRY Score:** Zero duplicated logic blocks
5. **Debugging Ease:** Any function traceable in single file

---

## Rollback Plan

Each phase produces a working state. If issues arise:
1. `git revert` to previous phase
2. Investigate failure
3. Fix and re-attempt

The phased approach ensures the codebase is never in a broken state.

---

## Appendix: File Line Count Targets

| File | Current | Target | Reduction |
|------|---------|--------|-----------|
| ToNumber.wl | 745 | 50 | -695 |
| ToNumber/Dispatch.wl | - | 40 | - |
| ToNumber/Rules.wl | - | 80 | - |
| ToNumber/Selectors.wl | - | 150 | - |
| ToNumber/Evaluation.wl | - | 60 | - |
| ToNumber/Parameters.wl | - | 80 | - |
| ToNumber/ModelTransform.wl | - | 50 | - |
| ToNumber/Helpers.wl | - | 30 | - |
| **Total** | **745** | **540** | **-205 (28%)** |
