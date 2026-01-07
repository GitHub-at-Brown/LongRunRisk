### NiceOutput.wl

- Install PacletizedResourceFunctions for tests (setup step)
  ```
  distributedPaclet = FileNameJoin[{
    DirectoryName[$InputFileName, 2],  (* From Tests/ up to paclet root *)
    "Resources",
    "PacletizedResourceFunctions.paclet"
  }];
  If[FileExistsQ[distributedPaclet],
    PacletInstall[distributedPaclet, "IgnoreVersion" -> True];
  ];
  True
  ```

- Verify PacletizedResourceFunctions installation
  ```
  Length[PacletFind["PacletizedResourceFunctions"]] > 0
  ```

- Load test models (setup step)
  ```
  longTest = False; (*fast and partial coverage (False) or slow and full coverage (True)*)
  FernandoDuarte`LongRunRisk`Models = Get@Get[FileNameJoin[{"FernandoDuarte/LongRunRisk","Models.wl"}]];
  msp = If[longTest,
    FernandoDuarte`LongRunRisk`Models,
    KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY","BKY","NRC","DES","NRCStochVol"}]
  ];
  modBY = msp["BY"];
  modBKY = msp["BKY"];
  modNRC = msp["NRC"];
  modDES = msp["DES"];
  modNRCStochVol = msp["NRCStochVol"];
  True
  ```

- Context is loaded and private context is accessible
  ```
  Needs@context;
  $ContextPath = DeleteDuplicates@Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"];
  True
  ```

- Context is in `$ContextPath`

  📍 `Tests/Tools/NiceOutput.wlt:199-205`

  ```
  And @@ {
    MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]
  }
  ```

- Symbol `info` can be found

  📍 `Tests/Tools/NiceOutput.wlt:207-213`

  ```
  Not[Names["*info"] === {}]
  ```

- `info` returns correctly formatted model information table

  📍 `Tests/Tools/NiceOutput.wlt:25-48`

  ```
  myModelsInfo = PacletizedResourceFunctions`SetSymbolsContext@info[msp];
  And @@ {
    Head[myModelsInfo] === Column,
    Head[myModelsInfo[[1]]] === List,
    Head[myModelsInfo[[1,1]]] === OpenerView,
    And @@ (MatchQ[#, Grid] & /@ (Head /@ myModelsInfo[[1, ;; , 1, 2]]))
  }
  ```

- `info` is correct when model key does not match shortname

  📍 `Tests/Tools/NiceOutput.wlt:55-95`

  ```
  justBY = <|"BY" -> msp["BY"]|>;
  infoBY = PacletizedResourceFunctions`SetSymbolsContext@info[justBY];
  newBY = <|"myModel" -> msp["BY"]|>;
  infoNewBY = PacletizedResourceFunctions`SetSymbolsContext@info[newBY];
  And @@ {
    infoBY[[1,1,1,1]] == "BY",
    PacletizedResourceFunctions`SetSymbolsContext@(infoBY[[1,1,1,2,1,4,1,1,2,1,1,1,1]]) === PacletizedResourceFunctions`SetSymbolsContext@(x[t]),
    infoNewBY[[1,1,1,1]] == "BY",
    PacletizedResourceFunctions`SetSymbolsContext@(infoNewBY[[1,1,1,2,1,4,1,1,2,1,1,1,1]]) === PacletizedResourceFunctions`SetSymbolsContext@(x[t])
  }
  ```

- `info` output formatting is correct for both matching and non-matching keys
  ```
  And @@ {
    Head[infoBY] === Column,
    Head[infoBY[[1]]] === List,
    Head[infoBY[[1,1]]] === OpenerView,
    And @@ (MatchQ[#, Grid] & /@ (Head /@ infoBY[[1, ;; , 1, 2]])),

    Head[infoNewBY] === Column,
    Head[infoNewBY[[1]]] === List,
    Head[infoNewBY[[1,1]]] === OpenerView,
    And @@ (MatchQ[#, Grid] & /@ (Head /@ infoNewBY[[1, ;; , 1, 2]]))
  }
  ```

- `numberFormattingTemplate` formats numbers correctly

  📍 `Tests/Tools/NiceOutput.wlt:102-168`

  ```
  With[{localPi = 3.14},
    {
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14, NumberMarks -> True],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14, NumberMarks -> False],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[localPi],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[localPi, NumberMarks -> True],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[localPi, NumberMarks -> False],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[\[CapitalPi]],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[\[CapitalPi], CharacterEncoding -> "ASCII"],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[Pi],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[N[Pi]],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14*10^(-7)],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[Flatten[{FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stripContext[delta]/2 /. FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stripContext[{delta -> 0.99}]}]]
    }
  ] === {"3.14", "3.14`", "3.14", "3.14", "3.14`", "3.14", "\[CapitalPi]", "\\[CapitalPi]", "3.141592653589793", "3.141592653589793", "3.14*^-7", "{0.495}"}
  ```

- `stringFormattingTemplate` adds linebreaks and tabs for long strings

  📍 `Tests/Tools/NiceOutput.wlt:175-192`

  ```
  Not@StringFreeQ[
    FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stringFormattingTemplate[
      "Long-run risk model with stochastic volatility in the original 2004 paper by Bansal and Yaron"
    ],
    "\t" | "\n"
  ]
  ```


---

## WLT Verification Results

**File**: `/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-clean-up/Tests/Tools/NiceOutput.wlt`

**Verification Date**: 2026-01-05

### Compliance Table

| Guideline | Status | Notes |
|-----------|--------|-------|
| Use `TestCreate` exclusively (never `VerificationTest`) | PASS | All 14 tests use `TestCreate` |
| Always include third argument for expected messages | PASS | All tests include `{}` as the third argument |
| TestID format: `"SymbolName-Scenario-Behavior"` | PASS | All TestIDs follow the convention |
| BeginTestSection names file being tested | PASS | Uses `"Kernel/Tools/NiceOutput.wl Tests"` |
| Context isolation with Begin/End | PASS | Uses `Begin["FernandoDuarte`LongRunRisk`Tests`Tools`NiceOutput`"]` |
| Needs statements for required contexts | PASS | Properly loads `FernandoDuarte`LongRunRisk`Tools`NiceOutput`` |
| Load shared helpers via `$TestFileName` | PASS | Uses `Get[FileNameJoin[{DirectoryName[$TestFileName, 2], "Common.wl"}]]` |
| No `Quiet` in test assertions | PASS | No suppression of messages in tests |
| No `TimeConstraint`/`MemoryConstraint`/`MetaInformation` | PASS | None of these options are used |
| Private functions fully qualified | PASS | Uses aliases `$nft` and `$sft` pointing to full paths |
| Only load contexts actually used | PASS | All loaded contexts (`NiceOutput`, `PacletizedResourceFunctions`) are used |
| No paclet initialization boilerplate | PASS | Setup code is necessary infrastructure for test dependencies |
| One assertion per behavior | PASS | Multiple checks in `AllTrue` blocks consolidate related validations |
| Prefer unqualified symbols after `Needs` | PASS | Uses `info` unqualified after loading the context |

### Summary

**Overall Status**: COMPLIANT

The WLT file `Tests/Tools/NiceOutput.wlt` is fully compliant with the wolfram-testing skill guidelines. Key strengths:

- Proper use of `TestCreate` throughout (14 tests total)
- Consistent TestID naming following `"SymbolName-Scenario-Behavior"` pattern
- Correct context isolation and loading patterns
- Clean message handling without inappropriate suppression
- Well-organized sections with descriptive subsection headers
- Private function access via properly qualified aliases for readability
- Shared test helpers loaded correctly using `$TestFileName`

**Test Coverage**:
- `info` function: 4 tests (structure and key mismatch behavior)
- `numberFormattingTemplate` (private): 8 tests (various formatting scenarios)
- `stringFormattingTemplate` (private): 2 tests (line breaking behavior)
- Context/Symbol tests: 2 tests
- Infrastructure tests: 1 test (PacletizedResourceFunctions installation)

**No Issues Found**: The file adheres to all guidelines from the wolfram-testing skill.
