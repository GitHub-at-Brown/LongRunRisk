# MD-to-WLT Conversion Plan

```
================================================================================
                    MARKDOWN TO WLT TEST FILE CONVERSION
================================================================================
INPUT:   docs/test-sections/{Name}.md
OUTPUT:  Tests/{Subfolder}/{Name}.wlt
REFERENCE: Tests/Model/Catalog.wlt
================================================================================
```

## INVARIANTS

| Rule | Value |
|------|-------|
| TestID Format | `SymbolName-Scenario-Behavior` (no numbers) |
| TestCreate Args | 4 arguments: `(expr, expected, {}, TestID)` |
| WLT Structure | `BeginTestSection` ... `EndTestSection` |
| No suppressions | Never use `Quiet[]` in test expressions |

---

## PHASE 1: PATH RESOLUTION

### Subfolder Mapping (LOOKUP TABLE)

| MD File | Subfolder | WLT Path |
|---------|-----------|----------|
| Catalog.md | Model | Tests/Model/Catalog.wlt |
| ExogenousEq.md | Model | Tests/Model/ExogenousEq.wlt |
| EndogenousEq.md | Model | Tests/Model/EndogenousEq.wlt |
| ProcessModels.md | Model | Tests/Model/ProcessModels.wlt |
| Shocks.md | Model | Tests/Model/Shocks.wlt |
| ComputeConditionalExpectations.md | ComputationalEngine | Tests/ComputationalEngine/ComputeConditionalExpectations.wlt |
| ComputeUnconditionalExpectations.md | ComputationalEngine | Tests/ComputationalEngine/ComputeUnconditionalExpectations.wlt |
| CreateEulerEq.md | ComputationalEngine | Tests/ComputationalEngine/CreateEulerEq.wlt |
| CreateMomentsDatabase.md | ComputationalEngine | Tests/ComputationalEngine/CreateMomentsDatabase.wlt |
| SolveEulerEq.md | ComputationalEngine | Tests/ComputationalEngine/SolveEulerEq.wlt |
| NiceOutput.md | Tools | Tests/Tools/NiceOutput.wlt |
| TimeAggregation.md | Tools | Tests/Tools/TimeAggregation.wlt |
| ToNumber.md | Tools | Tests/Tools/ToNumber.wlt |

### DirectoryName Depth Rules

| Common.wl Location | DirectoryName Depth |
|--------------------|---------------------|
| `Tests/Common.wl` (global) | `DirectoryName[$TestFileName, 2]` |
| `Tests/{Subfolder}/Common.wl` | `DirectoryName[$TestFileName, 1]` |

### Step 1.1: Extract paths
```
baseName   = FileBaseName[MD_FILE]        (* e.g., "ProcessModels" *)
subfolder  = LOOKUP_TABLE[baseName]       (* e.g., "Model" *)
wlt_path   = "Tests/{subfolder}/{baseName}.wlt"
```

### Step 1.2: Identify dependencies
- Scan MD code blocks for context references (e.g., `FernandoDuarte`LongRunRisk`Model`Parameters`)
- Build `Needs[]` list from referenced contexts

**CHECKPOINT A:** WLT path resolved AND Needs list determined

---

## PHASE 2: PARSE MARKDOWN

### Step 2.1: Extract test specifications

Parse each MD file to extract:
```
TestSpec := {
    Symbol      -> String,       (* e.g., "$exogenousVars" *)
    Description -> String,       (* e.g., "is a list" *)
    CodeBlock   -> Expression,   (* e.g., ListQ[$exogenousVars] *)
    Category    -> String        (* e.g., "Structure" *)
}
```

### Step 2.2: MD Pattern Recognition

| MD Pattern | Extracted Data |
|------------|----------------|
| `### FileName.wl` | Section header |
| `- Symbol xyz` | Symbol name |
| `- {description}` | Test description |
| ` ``` ... ``` ` | Test expression |
| `For each model...` | Loop indicator → multiple tests |

**CHECKPOINT B:** All code blocks captured with descriptions

---

## PHASE 3: TRANSFORM TO TESTCREATE

### Transformation Rule

**FROM** (Markdown):
```markdown
- {description}
  ```
  {expression}
  ```
```

**TO** (Wolfram):
```wl
TestCreate[
    {expression},
    True,
    {},
    TestID -> "{Symbol}-{Scenario}-{Behavior}"
]
```

### TestID Construction

| Component | Source | Example |
|-----------|--------|---------|
| Symbol | Current symbol being tested | `models`, `$exogenousVars` |
| Scenario | Category/context of test | `Structure`, `Elements`, `Context` |
| Behavior | What is being verified | `IsAssociation`, `AreStrings`, `InPrivate` |

**Examples:**
- `models-Structure-IsAssociation`
- `$exogenousVars-Elements-AreStrings`
- `xeq-Context-InPrivate`
- `modelsExtraInfo-Keys-SubsetOfModels`

---

## PHASE 4: GENERATE WLT FILE

### File Template (EXACT)

```wl
(* ::Package:: *)

(* ::Section:: *)
(*Kernel/{Subfolder}/{Name}.wl Tests*)

BeginTestSection["Kernel/{Subfolder}/{Name}.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`{Subfolder}`{Name}`"]

Needs["FernandoDuarte`LongRunRisk`{Subfolder}`{Name}`"];
(* {additional Needs statements from Step 1.2} *)

(* ::Subsection:: *)
(*Load Test Helpers*)

Get[FileNameJoin[{DirectoryName[$TestFileName, 2], "Common.wl"}]];

(* ::Subsection:: *)
(*Test Helpers*)

(* {local helpers - only if needed for this file} *)

(* ::Subsection:: *)
(*{Symbol} - {Category} Tests*)

(* {TestCreate calls grouped by symbol and category} *)

End[]
EndTestSection[]
```

### Helper Placement Decision Tree

```
Is helper used in multiple files?
├─ NO  → Inline in the .wlt file
└─ YES → Is it used across subfolders?
         ├─ NO  → Tests/{Subfolder}/Common.wl
         └─ YES → Tests/Common.wl (global)
```

| Condition | Location | Action |
|-----------|----------|--------|
| Used in 1 file only | Inline in .wlt | Define in "Test Helpers" subsection |
| Used in 2+ files in same subfolder | `Tests/{Subfolder}/Common.wl` | Create/update subfolder Common.wl |
| Used across subfolders | `Tests/Common.wl` | Add to existing global Common.wl |

---

## PHASE 5: VALIDATE

### Validation Checklist (ALL MUST PASS)

- [ ] All TestIDs follow `Symbol-Scenario-Behavior` pattern (no hard-coded numbers)
- [ ] All TestCreate calls have exactly 4 arguments: `(expr, expected, {}, TestID)`
- [ ] All referenced symbols have corresponding `Needs[]` statements
- [ ] Section headers use `(* ::Section:: *)` / `(* ::Subsection:: *)` format
- [ ] No `Quiet[]` wrapping test expressions
- [ ] DirectoryName depth is correct for Common.wl imports
- [ ] TestIDs are unique within the file

### Run Tests

```bash
wolframscript Tests/RunTests.wls --all
```

**Automated Iteration:**
```bash
/ralph-loop "Fix test failures in [File]" --max-iterations 5 --completion-promise "Tests passed"
```

**CHECKPOINT C:** All checklist items pass AND tests execute successfully

---

## EXECUTION WORKFLOW

```
+------------------------------------------------------------------+
|  INPUT: MD_FILE (e.g., "docs/test-sections/ProcessModels.md")    |
+------------------------------------------------------------------+
                              |
                              v
+------------------------------------------------------------------+
|  PHASE 1: RESOLVE PATHS                                          |
|  - Look up subfolder in mapping table                            |
|  - Construct wlt_path                                            |
|  - Identify Needs[] dependencies                                 |
|  [CHECKPOINT A]                                                  |
+------------------------------------------------------------------+
                              |
                              v
+------------------------------------------------------------------+
|  PHASE 2: PARSE MARKDOWN                                         |
|  - Extract section headers, bullets, code blocks                 |
|  - Build TestSpec list                                           |
|  [CHECKPOINT B]                                                  |
+------------------------------------------------------------------+
                              |
                              v
+------------------------------------------------------------------+
|  PHASE 3: TRANSFORM                                              |
|  - Convert each TestSpec to TestCreate call                      |
|  - Generate TestIDs using Symbol-Scenario-Behavior               |
+------------------------------------------------------------------+
                              |
                              v
+------------------------------------------------------------------+
|  PHASE 4: GENERATE WLT                                           |
|  - Apply file template                                           |
|  - Place helpers per decision tree                               |
|  - Write Tests/{Subfolder}/{Name}.wlt                            |
+------------------------------------------------------------------+
                              |
                              v
+------------------------------------------------------------------+
|  PHASE 5: VALIDATE                                               |
|  - Run validation checklist                                      |
|  - Execute tests                                                 |
|  - Fix failures (use /ralph-loop)                                |
|  [CHECKPOINT C]                                                  |
+------------------------------------------------------------------+
```

---

## EXAMPLE TRANSFORMATION

**FROM** `docs/test-sections/ExogenousEq.md`:
```markdown
- Symbol `$exogenousVars`
  - is a list
    ```
    ListQ[$exogenousVars]
    ```
  - all elements are strings
    ```
    And @@ (StringQ /@ $exogenousVars)
    ```
```

**TO** `Tests/Model/ExogenousEq.wlt`:
```wl
(* ::Subsection:: *)
(*$exogenousVars - Structure Tests*)

TestCreate[
    ListQ[$exogenousVars],
    True,
    {},
    TestID -> "$exogenousVars-Structure-IsList"
]

TestCreate[
    AllTrue[$exogenousVars, StringQ],
    True,
    {},
    TestID -> "$exogenousVars-Elements-AreStrings"
]
```

---

## CRITICAL FILES

| File | Purpose |
|------|---------|
| `docs/test-sections/{Name}.md` | Input: test specifications |
| `Tests/{Subfolder}/{Name}.wlt` | Output: generated test file |
| `Tests/Model/Catalog.wlt` | Reference: well-structured example |
| `Tests/Common.wl` | Global test helpers |
| `Tests/{Subfolder}/Common.wl` | Subfolder-specific helpers (create if needed) |
