### CreateMomentsDatabase.wl

- Test coverage flag initialization
  ```
  longTest = False; (*fast and partial coverage (False) or slow and full coverage (True)*)
  True
  ```

- Load context and expose private symbols
  ```
  With[{context=context},
    Needs@context;
    $ContextPath = DeleteDuplicates@Prepend[$ContextPath,
      "FernandoDuarte`LongRunRisk`ComputationalEngine`CreateMomentsDatabase`Private`"];
    True
  ]
  ```

- Load models and covariance lookup tables, compute moments and verify all are numeric

  📍 `Tests/ComputationalEngine/CreateMomentsDatabase.wlt:130-285` (16 tests)

  ```
  Off[General::stop];
  If[Not@longTest, Off[FindRoot::cvmit]];

  FernandoDuarte`LongRunRisk`Models = Get@Get[FileNameJoin[{"FernandoDuarte/LongRunRisk","Models.wl"}]];
  Get[FileNameJoin[{"FernandoDuarte/LongRunRisk/MomentsLookupTables","covLongBKY.mx"}]];
  Get[FileNameJoin[{"FernandoDuarte/LongRunRisk/MomentsLookupTables","covLongDES.mx"}]];
  Get[FileNameJoin[{"FernandoDuarte/LongRunRisk/MomentsLookupTables","covLongNRC.mx"}]];
  Get[FileNameJoin[{"FernandoDuarte/LongRunRisk/MomentsLookupTables","covLongNRCStochVol.mx"}]];

  Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
  Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];

  msp = FernandoDuarte`LongRunRisk`Models;
  modBKY = msp["BKY"];
  modNRC = msp["NRC"];
  modDES = msp["DES"];
  modNRCStochVol = msp["NRCStochVol"];
  mods = If[longTest,
    {modBKY, modNRC, modDES, modNRCStochVol},
    {modBKY, modNRC}
  ];

  Do[
    ind = 0; (*counter for Do loop*)
    covLong = Symbol["FernandoDuarte`LongRunRisk`covLong" <> model["shortname"]];

    (*moments without stocks*)
    testMoments = Apply[covLong, Outer[Append, Tuples[exo, {2}], Range[-8,8], 1], {2}];
    testMomentsN = testMoments //. model["params"];

    (*moments with one stock*)
    testMomentsOneStock = Append[#, j] & /@ Flatten@Apply[Inactive[covLong],
      Outer[Append, Tuples[{exo, exoStocks}], Range[-8,8], 1], {2}];
    testMomentsOneStockN = Activate[testMomentsOneStock /. j -> 1] //. model["params"];

    (*moments with two stocks*)
    testMomentsTwoStocks = Map[covLong @@ Join[#, {i, j}] &,
      Outer[Append, Tuples[{exoStocks, exoStocks}], Range[-8,8], 1], {2}];
    testMomentsTwoStocksN = testMomentsTwoStocks /.
      Map[(Thread@Rule[{i, j}, #]) &, Tuples[Range@model["numStocks"], {2}]] //. model["params"];

    (*moments of the form uncondCov[v1 v2, v3] without stocks*)
    testMoments3 = MapApply[covLong[##, 0, 0] &, Groupings[Tuples[exo, {3}], 2]];
    testMoments3N = testMoments3 //. model["params"];

    (*moments of the form uncondCov[v1 v2, v3 v4] without stocks*)
    testMoments4 = MapApply[covLong[##, 0, 0, 0] &, Partition[#, 2] & /@ Tuples[exo, {4}]];
    testMoments4N = testMoments4 //. model["params"];

    (*moments of the form uncondCov[v1 v2, v3] with only stocks*)
    testMomentsStocks3 = Map[covLong @@ Join[#, {0, 0, i, j, k}] &,
      Groupings[Tuples[exoStocks, {3}], 2], {1}];
    testMomentsStocks3N = testMomentsStocks3 /.
      Map[(Thread@Rule[{i, j, k}, #]) &, Tuples[Range@Min[model["numStocks"], 2], {3}]] //. model["params"];

    (*moments of the form uncondCov[v1 v2, v3 v4] with only stocks*)
    testMomentsStocks4 = Map[covLong @@ Join[#, {0, 0, 0, i, j, k, m}] &,
      Partition[#, 2] & /@ Tuples[exoStocks, {4}], {1}];
    testMomentsStocks4N = testMomentsStocks4 /.
      Map[(Thread@Rule[{i, j, k, m}, #]) &, Tuples[Range@Min[model["numStocks"], 2], {4}]] //. model["params"];

    outTests[model["shortname"]][ind] = And @@ {
      And @@ (NumberQ /@ (Flatten@testMomentsN)),
      And @@ (NumberQ /@ (Flatten@testMomentsOneStockN)),
      And @@ (NumberQ /@ (Flatten@testMomentsTwoStocksN)),
      And @@ (NumberQ /@ (Flatten@testMoments3N)),
      And @@ (NumberQ /@ (Flatten@testMoments4N)),
      And @@ (NumberQ /@ (Flatten@testMomentsStocks3N)),
      And @@ (NumberQ /@ (Flatten@testMomentsStocks4N))
    };
    ind = ind + 1;

    If[longTest,
      tuples3q = Groupings[Tuples[exo, {3}], 2];
      ntest = 150; (*can increase for more thorough testing*)
      toEval3q = Extract[tuples3q, Thread[{RandomInteger[Length[tuples3q], ntest]}]];
      testMoments3q = Table[MapApply[covLong[Sequence[##], q1, q2] &, toEval3q],
        {q1, -4, 4}, {q2, 4, 4}];
      testMoments3qN = (Flatten@testMoments3q) //. model["params"];
      outTests[model["shortname"]][ind] = And @@ (NumberQ /@ testMoments3qN);
      ind = ind + 1;

      tuples4q = Partition[#, 2] & /@ Tuples[exo, {4}];
      ntest = 150; (*can increase for more thorough testing*)
      toEval4q = Extract[tuples4q, Thread[{RandomInteger[Length[tuples4q], ntest]}]];
      testMoments4q = Table[MapApply[covLong[Sequence[##], q1, q2, q3] &, toEval4q],
        {q1, -3, 3}, {q2, 3, 3}, {q3, 3, 3}];
      testMoments4qN = (Flatten@testMoments4q) //. model["params"];
      outTests[model["shortname"]][ind] = And @@ (NumberQ /@ testMoments4qN);
      ind = ind + 1;
    ];
    ,
    {model, mods}
  ]; (*Do*)

  noMissingTest = {};
  Do[
    testNumber = Sort@Cases[Keys@SubValues@outTests,
      Verbatim[HoldPattern][outTests[model["shortname"]][i_Integer]] :> i];
    AppendTo[noMissingTest, Range[0, Max[testNumber]] == testNumber];
    ,
    {model, mods}
  ];

  out = And @@ {
    And @@ noMissingTest,
    And @@ Values@SubValues@outTests
  };

  On[General::stop];
  On[FindRoot::cvmit];

  out
  ```


---

**Test Primitives Summary:**

- **Test coverage flag**: Controls whether to run fast partial tests (`longTest = False`) or slow comprehensive tests (`longTest = True`)

- **Context loading**: Loads the `CreateMomentsDatabase` context and exposes private symbols for testing

- **Model and lookup table loading**: Loads model definitions and precomputed covariance lookup tables for BKY, DES, NRC, and NRCStochVol models

- **Moment computation tests** (for each model):
  - Moments without stocks: `covLong[exo1, exo2, lag]` for all pairs of exogenous variables and lags -8 to 8
  - Moments with one stock: `covLong[exo, exoStock, lag, j]` combinations
  - Moments with two stocks: `covLong[exoStock1, exoStock2, lag, i, j]` combinations
  - Three-variable moments without stocks: `covLong[v1, v2, v3, 0, 0]` for product covariances
  - Four-variable moments without stocks: `covLong[v1, v2, v3, v4, 0, 0, 0]` for product covariances
  - Three-variable moments with stocks: `covLong[..., 0, 0, i, j, k]` combinations
  - Four-variable moments with stocks: `covLong[..., 0, 0, 0, i, j, k, m]` combinations

- **Numeric validation**: All computed moments must evaluate to numeric values (`NumberQ`) after parameter substitution

- **Long test mode** (additional tests when `longTest = True`):
  - Extended three-variable moment tests with varying q1, q2 indices
  - Extended four-variable moment tests with varying q1, q2, q3 indices
  - Uses random sampling (ntest = 150) for efficiency

- **Test completeness check**: Verifies no test indices are missing (`noMissingTest`)

- **Final aggregation**: All individual tests must pass for the overall test to pass

## WLT Verification Results

**File verified**: `/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-clean-up/Tests/ComputationalEngine/CreateMomentsDatabase.wlt`

**Verification date**: 2026-01-05

### Compliance Table

| Guideline | Status | Notes |
|-----------|--------|-------|
| Use `TestCreate` exclusively (no `VerificationTest`) | PASS | All tests use `TestCreate` |
| Third argument for expected messages always present | PASS | All `TestCreate` calls include `{}` as third argument |
| TestID format: `"SymbolName-Scenario-Behavior"` | PASS | All 20 TestIDs follow the convention (e.g., `"covLong-BKY-MomentsNoStocksAreNumeric"`) |
| `BeginTestSection` names file being tested | PASS | Uses `"Kernel/ComputationalEngine/CreateMomentsDatabase.wl Tests"` |
| Context isolation with `Begin`/`End` | PASS | Uses `Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateMomentsDatabase`"]` |
| `Needs` statements at file beginning | PASS | All 4 `Needs` calls appear immediately after `Begin` |
| Only load contexts actually used | WARNING | Three contexts loaded but no symbols visibly used: `ComputeUnconditionalExpectations`, `ComputeConditionalExpectations`, `Model`Catalog`. These may be implicit dependencies for lookup tables. |
| No `Quiet` in test assertions | PASS | No `Quiet` usage in the file |
| Load shared helpers via `$TestFileName` | PASS | Uses `Get[FileNameJoin[{DirectoryName[$TestFileName, 2], "Common.wl"}]]` |
| Avoid `TimeConstraint`, `MemoryConstraint`, `MetaInformation` | PASS | None of these options are used |
| No paclet initialization boilerplate | PASS | No `PacletDirectoryLoad` or path-resolution blocks |
| Private function access via full qualification | PASS | Private symbols `exo` and `exoStocks` accessed with full paths |
| No hardcoded numbering in comments | PASS | All comments use descriptive text without numbering |
| One assertion per behavior | PASS | Each `TestCreate` tests a single aspect |
| Clean structure with subsections | PASS | Logical organization with Subsection markers |

### Summary

**Overall Status**: COMPLIANT (with minor observations)

The WLT file `CreateMomentsDatabase.wlt` is well-structured and follows the wolfram-testing skill guidelines. Key strengths:

- Proper use of `TestCreate` with all required arguments
- Consistent TestID naming convention
- Correct context isolation and `Needs` placement
- No message suppression in test assertions
- Private symbols correctly accessed via full qualification
- Clean, readable structure with logical test groupings

**Minor observation**: The file loads three additional contexts (`ComputeUnconditionalExpectations`, `ComputeConditionalExpectations`, `Model`Catalog`) that don't have visibly used symbols in the test code. These appear to be implicit dependencies required for the lookup table symbols (`covLong*`) to function correctly when moments are computed. If these are truly needed as transitive dependencies, consider adding a brief comment explaining why they are loaded.

**Test count**: 20 test cases covering:
- Lookup table existence and symbol definition (2 tests)
- Moments without stocks for BKY and NRC models (2 tests)
- Moments with one stock (2 tests)
- Moments with two stocks (2 tests)
- Three-variable moments (2 tests)
- Four-variable moments (2 tests)
- Stock variable moments for 3 and 4 variables (4 tests)
- Public symbol export verification (3 tests)
- Options validation (1 test)
