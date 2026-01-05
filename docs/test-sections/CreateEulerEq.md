### CreateEulerEq.wl

- Setup: Load models and define test fixtures
  ```
  longTest = False; (*fast and partial coverage (False) or slow and full coverage (True)*)
  True
  ```
  ```
  FernandoDuarte`LongRunRisk`Models = Get@Get[FileNameJoin[{"FernandoDuarte/LongRunRisk","Models.wl"}]];
  msp=FernandoDuarte`LongRunRisk`Models;
  modBY=msp["BY"];
  modNRC=msp["NRC"];
  modDES=msp["DES"];
  mods={modBY,modNRC,modDES};
  True
  ```

- Setup: Load private functions for testing
  ```
  Needs@context;
  eulereq=FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`eulereq;
  nomeulereq=FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`nomeulereq;
  findEulerEqConstants=FernandoDuarte`LongRunRisk`ComputationalEngine`CreateEulerEq`findEulerEqConstants;

  (*define functions and variables needed for tests below*)
  ee[model_]:={eulereq[retc[t+1],t,model],eulereq[ret[t+1,j],t,model],eulereq[bondret[t+1,m],t,model],nomeulereq[nombondret[t+1,m],t,model]};
  eeAll=ee/@mods;

  coeffWc[model_]:=Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc[i],{i,Length[model["stateVars"][t]]}];
  coeffPd[model_]:=Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd[i],{i,Length[model["stateVars"][t]]}];
  coeffBond[model_]:=Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb[i],{i,Length[model["stateVars"][t]]}];
  coeffNomBond[model_]:=Table[FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb[i],{i,Length[model["stateVars"][t]]}];

  coeffWcAll=coeffWc/@mods;
  coeffPdAll=coeffPd/@mods;
  coeffBondAll=coeffBond/@mods;
  coeffNomBondAll=coeffNomBond/@mods;
  True
  ```

- Symbol `eulereq` should exist (can be found)
  ```
  (*should be true if uncondE can be found*)
  Not[Names["*eulereq"]==={}]
  ```

**Test eulereq, nomeulereq:**

- Euler equations are linear in state variables
  ```
  (*euler eq linear in state variables*)
  And@@(
  Flatten@{
  (Max@Keys@CoefficientRules[#,DeleteDuplicates@Cases[modBY["stateVars"][t],_Symbol[t]^p_.,Infinity]]==1)&/@ee[modBY],
  (Max@Keys@CoefficientRules[#,DeleteDuplicates@Cases[modNRC["stateVars"][t],_Symbol[t]^p_.,Infinity]]==1)&/@ee[modNRC],
  (Max@Keys@CoefficientRules[#,DeleteDuplicates@Cases[modDES["stateVars"][t],_Symbol[t]^p_.,Infinity]]==1)&/@ee[modDES]
  }
  )
  ```

- Euler equations contain all expected coefficients (wc, pd, bond, nombond)
  ```
  (*euler eq has all wc coefficients*)
  And@@Flatten@{
  Table[(Not@FreeQ[eeAll[[;;,1]][[n]],#]&/@coeffWcAll[[n]]),{n,1,Length[mods]}],
  Table[(Not@FreeQ[eeAll[[;;,2]][[n]],#]&/@coeffPdAll[[n]]),{n,1,Length[mods]}],
  Table[(Not@FreeQ[eeAll[[;;,3]][[n]],#]&/@coeffBondAll[[n]]),{n,1,Length[mods]}],
  Table[(Not@FreeQ[eeAll[[;;,4]][[n]],#]&/@coeffNomBondAll[[n]]),{n,1,Length[mods]}]
  }
  ```

**Test findEulerEqConstants:**

- Number of equations for coefficients equals number of state variables plus 1 (for constant term)
  ```
  If[longTest,
  (*number of equations for the coefficients equals number of state variables plus 1 (for the term that does not multiply any state var)*)
  And@@Flatten@{
  (Count[Cases[First@findEulerEqConstants[retc[t],#],0==x__ :> True],True]===Length[#["stateVars"][t]]+1)&/@mods,
  (Count[Cases[First@findEulerEqConstants[ret[t,j],#],0==x__ :> True],True]===Length[#["stateVars"][t]]+1)&/@mods,
  (Count[Cases[First@findEulerEqConstants[bondret[t,m],#],0==x__ :> True],True]===Length[#["stateVars"][t]]+1)&/@mods,
  (Count[Cases[First@findEulerEqConstants[nombondret[t,m],#, True],0==x__ :> True],True]===Length[#["stateVars"][t]]+1)&/@mods
  }
  ,
  True
  ]
  ```

- Equations for coefficients do not contain time variable `t`
  ```
  (*eq for coefficients do not have t*)
  If[longTest,
  And@@Flatten@{
  FreeQ[findEulerEqConstants[retc[t],#],t]&/@mods,
  FreeQ[findEulerEqConstants[ret[t,j],#],t]&/@mods,
  FreeQ[findEulerEqConstants[bondret[t,m],#],t]&/@mods,
  FreeQ[findEulerEqConstants[nombondret[t,m],#, True],t]&/@mods
  }
  ,
  True
  ]
  ```

- Equations are time-invariant (same for any time period)
  ```
  If[longTest,
  (*equations are the same for any time period*)
  And@@Flatten@{
  (findEulerEqConstants[retc[t],#]&/@mods)===(findEulerEqConstants[retc[t+1],#]&/@mods),
  (findEulerEqConstants[ret[t,j],#]&/@mods)===(findEulerEqConstants[ret[t+1,j],#]&/@mods),
  (findEulerEqConstants[bondret[t,m],#]&/@mods)===(findEulerEqConstants[bondret[t+1,m],#]&/@mods),
  (findEulerEqConstants[nombondret[t,m],#, True]&/@mods)===(findEulerEqConstants[nombondret[t+1,m],#, True]&/@mods)
  }
  ,
  True
  ]
  ```

- Unknowns in Euler equation are in context `"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"`
  ```
  If[longTest,
  (*unknowns in Euler eq are in context "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"*)
  {"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"}===DeleteDuplicates@
  Flatten@{Map[Context[Evaluate[#]]&,Flatten@((Flatten@Rest@findEulerEqConstants[retc[t],#])[[;;,0]]&/@mods)],
  Map[Context[Evaluate[#]]&,Flatten@((Flatten@Rest@findEulerEqConstants[ret[t,j],#])[[;;,0,0]]&/@mods)],
  Map[Context[Evaluate[#]]&,Flatten@((Flatten@Rest@findEulerEqConstants[bondret[t,m],#])[[;;,0,0]]&/@mods)],
  Map[Context[Evaluate[#]]&,Flatten@((Flatten@Rest@findEulerEqConstants[nombondret[t,m],#,True])[[;;,0,0]]&/@mods)]
  }
  ,
  True]
  ```

- Each equation evaluates to True or False when evaluated numerically
  ```
  (*each equation evaluates to True or False when evaluated numerically*)
  checkBoolean[model_]:=Module[{e0,e1,e2,e3,e0p,e1p,e2p,e3p},
  e0=findEulerEqConstants[retc[t],model];
  e1=findEulerEqConstants[ret[t,1],model];
  e2=findEulerEqConstants[bondret[t,m],model];
  e3=findEulerEqConstants[nombondret[t,m],model, True];
  e0p=Flatten@{Normal@model["parameters"],Thread[e0[[2]]->4],FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Ewc->4};
  e1p=Flatten@{e0p,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd[_]->4,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`Epd[_]->4};
  e2p=Flatten@{e0p,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb[m_]->4};
  e3p=Flatten@{e0p,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb[m_]->4};
  {e0[[1]]/.e0p,e1[[1]]/.e1p,e2[[1]]/.e2p,e3[[1]]/.e3p}
  ];
  And@@(BooleanQ/@(Flatten@checkBoolean[modBY]))
  ```


---

## WLT Verification Results

**File Verified**: `/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-clean-up/Tests/ComputationalEngine/CreateEulerEq.wlt`

**Verification Date**: 2026-01-05

### Compliance Summary

| Guideline | Status | Notes |
|-----------|--------|-------|
| Use `TestCreate` exclusively (not `VerificationTest`) | PASS | All 17 tests use `TestCreate` |
| Always include third argument for expected messages | PASS | All tests include `{}` as the third argument |
| TestID format: `SymbolName-Scenario-Behavior` | PASS | All TestIDs follow the pattern (e.g., `eulereq-Symbol-Exists`, `findEulerEqConstants-Retc-EquationCount`) |
| BeginTestSection names file being tested | PASS | Uses `"Kernel/ComputationalEngine/CreateEulerEq.wl Tests"` |
| Context isolation with `Begin`/`End` | PASS | Uses `Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`CreateEulerEq`"]` |
| `Needs` statements at beginning of file | PASS | All three `Needs` calls placed immediately after `Begin` |
| Load shared helpers via `$TestFileName` | PASS | Uses `Get[FileNameJoin[{DirectoryName[$TestFileName, 2], "Common.wl"}]]` |
| No `Quiet` in test assertions | PASS | No `Quiet` used in any test assertions |
| No `TimeConstraint`/`MemoryConstraint`/`MetaInformation` | PASS | None of these optional parameters are used |
| No paclet initialization boilerplate | PASS | No `PacletDirectoryLoad` or module blocks for resolving paths |
| Only load contexts actually used | PASS | All `Needs` statements are for contexts whose symbols are used in tests |
| Proper `EndTestSection` and `End` closure | PASS | File ends with `End[]` followed by `EndTestSection[]` |

### Test Coverage

The WLT file contains **17 tests** organized into the following sections:

- **Symbol Existence Tests** (1 test): Verifies `eulereq` symbol can be found
- **Linearity Tests** (1 test): Verifies Euler equations are linear in state variables
- **Coefficient Presence Tests** (4 tests): Verifies equations contain expected wc, pd, bond, and nombond coefficients
- **Equation Count Tests** (4 tests): Verifies correct number of equations for each return type
- **Time Independence Tests** (4 tests): Verifies equations do not contain time variable
- **Time Invariance Tests** (4 tests): Verifies equations are the same for any time period
- **Unknown Context Tests** (1 test): Verifies unknowns are in the correct Private context
- **Numeric Evaluation Tests** (1 test): Verifies equations evaluate to Boolean values

### Overall Assessment

**FULLY COMPLIANT** - The WLT file follows all wolfram-testing skill guidelines. The test file is well-structured with proper context isolation, appropriate `Needs` statements, consistent TestID naming, and no improper message suppression.

