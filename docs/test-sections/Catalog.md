### Catalog.wl
- Symbol models
  - is an association
  - its keys are strings
     ```
     And @@ (StringQ /@ Keys[models])
     ```
For each model (each entry of models)
  - is an association
  ```
   And @@ (MatchQ[
      Association, #] & /@ (Flatten@{Head[models],
       Head[models[#]] & /@ Keys[models]}))
  ```
  - its keys are strings

  - keys are exactly the set {"name", "shortname", "bibRef", "desc", "enabled", "parameters"} (not ordered)
  - "name", "shortname", "bibRef", "desc" are strings
    ```
    And @@ (StringQ /@
    Flatten@({models[#]["name"], models[#]["shortname"], models[#]["bibRef"],
    models[#]["desc"]} & /@ Keys[models]))
    ```
  - "bibRef" is either "None" or "none" or a string matching one of the reference keys in Resources/BibTeX/references.bib
    - For example, des2023stocksbonds is the key of the first entry in Resources/BibTeX/references.bib, so "bibRef" -> "des2023stocksbonds" should pass the test
  - "enabled" in Boolean (True or False)
    ```
    And @@ (BooleanQ /@ Flatten@({models[#]["enabled"]} & /@ Keys[models]))
    ```
  - "stateVars" is a list
  - "parameters" is a list of rules
  - "parameters" evaluates to numbers after applying "parameters" repeatedly to values
    ```
    And @@ (NumberQ /@
    Flatten[(models[#]["parameters"][[;; , 2]] //. models[#]["parameters"]) & /@ Keys[models]])
    ```
  - exogenous variables are in context "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`
    ```
    And @@ ((And @@ ((# ===
                "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`") & /@ \
    (Context /@
              Cases[models[#]["stateVars"],
                var_Symbol?(MemberQ[
                      StringDrop[#, -2] & /@
                      FernandoDuarte`LongRunRisk`Model`ExogenousEq`$\
    exogenousVars, SymbolName[#]] &)[__] :> var, Infinity]))) & /@ Keys[models])
    ```
    - shocks are in context "FernandoDuarte`LongRunRisk`Model`Shocks`
      ```
      And @@ ((And @@ ((# ===
                  "FernandoDuarte`LongRunRisk`Model`Shocks`") & /@ (Context /@
                Cases[models[#]["stateVars"],
                  var_Symbol?(MatchQ[SymbolName[#], "eps"] &)[__][__] :> var,
                  Infinity]))) & /@ Keys[models])
      ```
    - all parameters are in context "FernandoDuarte`LongRunRisk`Model`Parameters`"
      ```
      And @@ ((And @@ ((# ===
                  "FernandoDuarte`LongRunRisk`Model`Parameters`") & /@ (Context /@
                Cases[models[#]["parameters"],
                  var_Symbol?(MemberQ[
                      FernandoDuarte`LongRunRisk`Model`Parameters`$parameters,
                      SymbolName[#]] &) :> var, Infinity]))) & /@ Keys[models])
      ```
    - state variables do not have any endogenous variables
    ```
    And @@ (MatchQ[{}, #] & /@ (Cases[models[#]["stateVars"],
            var_Symbol?(MemberQ[
                  StringDrop[#, -2] & /@
                  FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars,
                  SymbolName[#]] &)[__] :> var, Infinity] & /@ Keys[models]))
    ```
- Symbol modelsExtraInfo
  - is an association

```
 And @@ {
   AllTrue[modelsExtraInfo, AssociationQ],
   AllTrue[modelsExtraInfo[#] & /@ Keys[modelsExtraInfo], AssociationQ]
   }
```
- models in modelsExtraInfo are a subset of those defined in models
```
 And @@ {
   SubsetQ[Keys[models], Keys[modelsExtraInfo]]
   }
```
- if provided, initial guess for Ewc is a vector and for Epd is 2-dimensional array
```
 And @@ (
   Flatten@(
     If[KeyExistsQ[modelsExtraInfo[#], "initialGuess"]
        ,
        {
         If[KeyExistsQ[modelsExtraInfo[#]["initialGuess"], "Ewc"],
          VectorQ["Ewc" /. modelsExtraInfo[#]["initialGuess"]] , True]
         ,
         If[KeyExistsQ[modelsExtraInfo[#]["initialGuess"], "Epd"],
          ArrayQ["Epd" /. modelsExtraInfo[#]["initialGuess"], 2] , True]
         }
        ,
        True
        ] & /@ Keys[modelsExtraInfo]
     )
   )
```
- Load `Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"]`, test that validateCatalog[models]["Valid"] is True

## WLT Verification Results

**File**: `/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-clean-up/Tests/Model/Catalog.wlt`

**Verification Date**: 2026-01-05

### Compliance Summary

| Guideline | Status | Notes |
|-----------|--------|-------|
| Uses `TestCreate` exclusively | PASS | All 21 tests use `TestCreate`, no `VerificationTest` found |
| Third argument for messages | PASS | All tests include `{}` as the third argument for expected messages |
| TestID format | PASS | All TestIDs follow `"SymbolName-Scenario-Behavior"` pattern, adapted appropriately for data structure tests |
| BeginTestSection naming | PASS | `"Kernel/Model/Catalog.wl Tests"` correctly references the file being tested |
| Context isolation | PASS | Uses `Begin["FernandoDuarte`LongRunRisk`Tests`Model`Catalog`"]` and `End[]` |
| Needs statements present | PASS | Loads required contexts at file start |
| Only loads used contexts | PASS | Both `Needs` statements are for contexts actually used (`Catalog` for `models`, `modelsExtraInfo`; `ValidateModels` for `validateCatalog`) |
| Loads shared helpers | PASS | Uses `Get[FileNameJoin[{DirectoryName[$TestFileName, 2], "Common.wl"}]]` |
| No Quiet in test assertions | PASS | No `Quiet` or `Off`/`On` used in test assertions |
| No paclet initialization boilerplate | PASS | No `PacletDirectoryLoad` or complex path resolution blocks |
| Avoids TimeConstraint/MemoryConstraint/MetaInformation | PASS | None of these options are used |
| One assertion per behavior | PASS | Each test validates a single specific property |
| Tests stand alone at top level | PASS | All `TestCreate` calls are at top level, not nested in control structures |

### TestID Verification

All 21 TestIDs follow the recommended pattern:

| TestID | Pattern Compliance |
|--------|-------------------|
| `models-Structure-IsAssociation` | PASS - data structure test |
| `models-Keys-AreStrings` | PASS - data structure test |
| `models-Values-AreAssociations` | PASS - data structure test |
| `models-ModelKeys-AreStrings` | PASS - data structure test |
| `models-RequiredKeys-AllPresent` | PASS - data structure test |
| `models-StringFields-AreStrings` | PASS - field type test |
| `models-BibRef-IsValid` | PASS - validation test |
| `models-Enabled-IsBoolean` | PASS - field type test |
| `models-StateVars-IsList` | PASS - field type test |
| `models-Parameters-IsListOfRules` | PASS - field type test |
| `models-Parameters-EvaluateToNumbers` | PASS - behavior test |
| `models-ExogenousVars-InCorrectContext` | PASS - context test |
| `models-Shocks-InCorrectContext` | PASS - context test |
| `models-Parameters-InCorrectContext` | PASS - context test |
| `models-StateVars-NoEndogenousVars` | PASS - validation test |
| `modelsExtraInfo-Structure-IsAssociation` | PASS - data structure test |
| `modelsExtraInfo-Values-AreAssociations` | PASS - data structure test |
| `modelsExtraInfo-Keys-SubsetOfModels` | PASS - validation test |
| `modelsExtraInfo-Ewc-IsVector` | PASS - field type test |
| `modelsExtraInfo-Epd-Is2DArray` | PASS - field type test |
| `validateCatalog-Models-ReturnsValid` | PASS - function test |

### Structure Verification

- **File header**: Uses Wolfram Language package format with proper section markers
- **BeginTestSection/EndTestSection**: Properly wraps all tests
- **Begin/End context**: Properly isolates test symbols
- **Helper functions**: `initialGuessQ` and `$bibKeys` defined locally for test use
- **Test organization**: Logically grouped by category with subsection markers

### Overall Assessment

**FULLY COMPLIANT** - The test file adheres to all wolfram-testing skill guidelines. The file demonstrates proper:
- Use of `TestCreate` with all required arguments
- Descriptive TestID naming adapted for data structure tests
- Context isolation and proper package loading
- Clean test assertions without message suppression
- Minimal helper functions defined locally
- Logical organization with clear sectioning
