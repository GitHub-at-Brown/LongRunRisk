### ComputeUnconditionalExpectations.wl

This section tests the `ComputeUnconditionalExpectations` module which computes unconditional (long-run) expectations of state variable products in the Long-Run Risk model.

---

#### Setup and Context Loading

- Load test configuration flag (fast vs full coverage)
```wolfram
longTest = False; (*fast and partial coverage (False) or slow and full coverage (True)*)
True
```

- Load required dependencies
```wolfram
Needs["PacletizedResourceFunctions`"];
True
```

- Configure context path for private functions
```wolfram
Needs@context;
$ContextPath = DeleteDuplicates@Prepend[$ContextPath,"FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`Private`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
$ContextPath = DeleteDuplicates@Prepend[$ContextPath,"FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`Private`"];
True
```

- Verify context is loaded
```wolfram
MemberQ[$ContextPath,"FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"]
```

- Verify `uncondE` function is accessible

  📍 `Tests/ComputationalEngine/ComputeUnconditionalExpectations.wlt:35-98` (7 tests for uncondE)

```wolfram
Not[Names["*uncondE"]==={}]
```

---

#### Model Loading

- Load BY and NRC models for testing
```wolfram
FernandoDuarte`LongRunRisk`Models=Get@Get[FileNameJoin[{"FernandoDuarte/LongRunRisk","Models.wl"}]];
msp=FernandoDuarte`LongRunRisk`Models;
modBY=msp["BY"];
modNRC=msp["NRC"];
True
```

---

#### createSystem Tests (Long Test Only)

- Test system of equations for unconditional moments (orders 1-4)
  - Verifies systems are well-formed (no $Failed results)
  - Verifies systems have solutions
  - Verifies solutions are consistent across different moment orders
```wolfram
{nameRules1,system1,unknowns1}=createSystem[1,modNRC];
{nameRules2,system2,unknowns2}=createSystem[2,modNRC];
{nameRules3,system3,unknowns3}=createSystem[3,modNRC];
{nameRules4,system4,unknowns4}=createSystem[4,modNRC];

sol1=Flatten@Solve[system1,unknowns1];
sol2=Flatten@Solve[system2,unknowns2];
sol3=Flatten@Solve[system3,unknowns3];
sol4=Flatten@Solve[system4,unknowns4];

And@@{
  (*system is well-formed*)
  Not[nameRules1===$Failed], Not[system1===$Failed], Not[unknowns1===$Failed],
  Not[nameRules2===$Failed], Not[system2===$Failed], Not[unknowns2===$Failed],
  Not[nameRules3===$Failed], Not[system3===$Failed], Not[unknowns3===$Failed],
  Not[nameRules4===$Failed], Not[system4===$Failed], Not[unknowns4===$Failed],

  (*there is a solution*)
  Not[sol1==={}], Not[sol2==={}], Not[sol3==={}], Not[sol4==={}],

  (*solutions are the same for same moments*)
  MatchQ@@(Intersection[unknowns1,unknowns3]/.{sol1,sol3}),
  MatchQ@@(Intersection[unknowns2,unknowns3]/.{sol2,sol3}),
  MatchQ@@(Intersection[unknowns1,unknowns4]/.{sol1,sol4}),
  MatchQ@@(Intersection[unknowns2,unknowns4]/.{sol2,sol4}),
  MatchQ@@(Intersection[unknowns3,unknowns4]/.{sol3,sol4})
}
```

---

#### Hand-Computed Moment Verification (Long Test Only)

- Verify first and second moments match hand calculations (via createSystem)
```wolfram
And@@{
  (pi1/.sol1)===mup,
  (sg1/.sol1)===Esg,
  FullSimplify@ExpandAll[pi2/.sol2]===FullSimplify@ExpandAll[mup^2+(xip^2+2 rhop xip phip + phip^2)/(1-rhop^2)],
  Simplify[sg2/.sol2]===Simplify[Esg^2+phig^2/(1-rhog^2)],
  Simplify[pi1sg1/.sol2]===Simplify[Esg*mup]
}
```

---

#### uncondE Function Tests

- Verify uncondE gives correct moments (direct computation)
```wolfram
And@@{
  uncondE[pi[t],modNRC]===mup,
  uncondE[sg[t],modNRC]===Esg,
  FullSimplify@ExpandAll[uncondE[pi[t]^2,modNRC]]===FullSimplify@ExpandAll[mup^2+(xip^2+2 rhop xip phip + phip^2)/(1-rhop^2)],
  Simplify[uncondE[sg[t]^2,modNRC]]===Simplify[Esg^2+phig^2/(1-rhog^2)],
  Simplify[uncondE[pi[t]sg[t],modNRC]]===Simplify[Esg*mup]
}
```

- Verify moments can be numerically evaluated (Long Test Only)
```wolfram
And@@{
  And@@(NumberQ/@(Values@sol1//.modNRC["parameters"])),
  And@@(NumberQ/@(Values@sol2//.modNRC["parameters"])),
  And@@(NumberQ/@(Values@sol3//.modNRC["parameters"])),
  And@@(NumberQ/@(Values@sol4//.modNRC["parameters"]))
}
```

---

#### evNoEpsStateVarsProduct Tests

- Test basic functionality of evNoEpsStateVarsProduct
  - Commutativity of arguments
  - Single state variable passthrough
  - Product of state variables
  - Cross-time products with lag substitution
  - Products with shock terms

  📍 `Tests/ComputationalEngine/ComputeUnconditionalExpectations.wlt:151-212` (9 tests)

```wolfram
stateVarsNoEps={sg,pi};
model=modNRC;

And@@{
  evNoEpsStateVarsProduct[pi[t]eps["pi"][t-1],model,stateVarsNoEps]===evNoEpsStateVarsProduct[eps["pi"][t-1]pi[t],model,stateVarsNoEps],
  evNoEpsStateVarsProduct[pi[t],model,stateVarsNoEps]===pi[t],
  evNoEpsStateVarsProduct[pi[t]sg[t],model,stateVarsNoEps]===pi[t] sg[t],
  ExpandAll[evNoEpsStateVarsProduct[pi[t-1]sg[t],model,stateVarsNoEps]]===ExpandAll[(Esg pi[-1+t]-Esg rhog pi[-1+t]+rhog pi[-1+t] sg[-1+t]+phig pi[-1+t] eps["sg"][t])],
  ExpandAll[evNoEpsStateVarsProduct[pi[t]eps["pi"][t],model,stateVarsNoEps]]===ExpandAll[mup eps["pi"][t]-mup rhop eps["pi"][t]+rhop pi[-1+t] eps["pi"][t]+xip eps["pi"][-1+t] eps["pi"][t]+phip eps["pi"][t]^2],
  evNoEpsStateVarsProduct[pi[t]eps["pi"][t+1],model,stateVarsNoEps]===(pi[t] eps["pi"][1+t]),
  ExpandAll[evNoEpsStateVarsProduct[eps["pi"][t]dd[t,i],model,stateVarsNoEps]]===ExpandAll[(dd[t,i] eps["pi"][t])],
  ExpandAll[evNoEpsStateVarsProduct[eps["pi"][t]dd[t,i],model,Append[stateVarsNoEps,dd]]]===ExpandAll[
    mud[i] eps["pi"][t]-mup rhodp[i] eps["pi"][t]+pi[-1+t] rhodp[i] eps["pi"][t]+phidc[i] eps["dc"][t] eps["pi"][t]+sg[-2+t] xid[i] eps["pi"][-1+t] eps["pi"][t]
  ],
  evNoEpsStateVarsProduct[pi[t]eps["pi"][t-1],model,stateVarsNoEps]===evNoEpsStateVarsProduct[eps["pi"][t-1]pi[t],model,stateVarsNoEps],
  evNoEpsStateVarsProduct[pi[t]sg[t-1],model,stateVarsNoEps]===evNoEpsStateVarsProduct[sg[t-1]pi[t],model,stateVarsNoEps]
}
```

---

#### Shock Context Verification

- Verify shocks have correct context ("FernandoDuarte`LongRunRisk`Model`Shocks`")

  📍 `Tests/ComputationalEngine/ComputeUnconditionalExpectations.wlt:241-251`

```wolfram
And@@{
  And@@(MatchQ[#,"FernandoDuarte`LongRunRisk`Model`Shocks`"]&/@(DeleteDuplicates@Cases[evNoEpsStateVarsProduct[pi[t-1]dd[t,i]eps["pi"][t-1],model,Append[stateVarsNoEps,dd]],x_Symbol?(MatchQ[SymbolName[#],"eps"]&)[__][__,___]:>Context@x,Infinity])),
  And@@(MatchQ[#,"FernandoDuarte`LongRunRisk`Model`Shocks`"]&/@(DeleteDuplicates@Cases[evNoEpsStateVarsProduct[pi[t-1]dd[t,i]eps["pi"][t]eps["pi"][t-1],model,Append[stateVarsNoEps,dd]],x_Symbol?(MatchQ[SymbolName[#],"eps"]&)[__][__,___]:>Context@x,Infinity])),
  And@@(MatchQ[#,"FernandoDuarte`LongRunRisk`Model`Shocks`"]&/@(DeleteDuplicates@Cases[evNoEpsStateVarsProduct[pi[t-1]sg[t]dd[t,i]eps["pi"][t-1],model,Append[stateVarsNoEps,dd]],x_Symbol?(MatchQ[SymbolName[#],"eps"]&)[__][__,___]:>Context@x,Infinity]))
}
```

---

#### Time Lag Verification

- Verify variables are lagged to correct time periods

  📍 `Tests/ComputationalEngine/ComputeUnconditionalExpectations.wlt:258-274` (2 tests)

```wolfram
And@@{
  {}===Cases[evNoEpsStateVarsProduct[pi[t]sg[t-1],model,stateVarsNoEps],_Symbol?(MatchQ[SymbolName[#],"pi"]&)[t],Infinity],
  Not[{}===Cases[evNoEpsStateVarsProduct[pi[t]sg[t-1],model,stateVarsNoEps],_Symbol?(MatchQ[SymbolName[#],"sg"]&)[t-1],Infinity]],
  {}===Cases[evNoEpsStateVarsProduct[pi[t]sg[t-1]+pi[t-1]sg[t],model,stateVarsNoEps],_Symbol?(MatchQ[SymbolName[#],"pi"]&)[t],Infinity],
  {}===Cases[evNoEpsStateVarsProduct[pi[t]sg[t-1]+pi[t-1]sg[t],model,stateVarsNoEps],_Symbol?(MatchQ[SymbolName[#],"sg"]&)[t],Infinity],
  Not[{}===Cases[evNoEpsStateVarsProduct[pi[t]sg[t-1]+pi[t-1]sg[t],model,stateVarsNoEps],_Symbol?(MatchQ[SymbolName[#],"pi"]&)[t-1],Infinity]],
  Not[{}===Cases[evNoEpsStateVarsProduct[pi[t]sg[t-1]+pi[t-1]sg[t],model,stateVarsNoEps],_Symbol?(MatchQ[SymbolName[#],"sg"]&)[t-1],Infinity]]
}
```

---

#### Non-State Variable Handling

- Test handling of time-indexed variables that are not state variables
```wolfram
And@@{
  evNoEpsStateVarsProduct[pi[t]foo[t-1],model,stateVarsNoEps]===pi[t]foo[t-1],
  (ExpandAll@evNoEpsStateVarsProduct[eps["pi"][t+1]eps["pi"][t]pi[t],model,stateVarsNoEps])===(ExpandAll@(eps["pi"][t+1]*evNoEpsStateVarsProduct[eps["pi"][t]pi[t],model,stateVarsNoEps]))
}
```

---

#### Irrelevant Variable Handling

- Test that adding irrelevant variables to state variable list does not affect results

  📍 `Tests/ComputationalEngine/ComputeUnconditionalExpectations.wlt:219-234` (2 tests)

```wolfram
And@@{
  evNoEpsStateVarsProduct[pi[t]eps["pi"][t-1],model,Append[stateVarsNoEps,myVariable]]===evNoEpsStateVarsProduct[eps["pi"][t-1]pi[t],model,Append[stateVarsNoEps,dd]],
  evNoEpsStateVarsProduct[pi[t],model,Append[stateVarsNoEps,irrelevantVar]]===pi[t],
  evNoEpsStateVarsProduct[anotherIrrelevantVar pi[t]sg[t],model,Append[stateVarsNoEps,anotherIrrelevantVar]]===anotherIrrelevantVar*pi[t] sg[t]
}
```

---

#### Dividend (dd) Variable Lagging

- Test lagging behavior with dividend variable dd
```wolfram
And@@{
  FreeQ[evNoEpsStateVarsProduct[pi[t-1]dd[t,i],model,Append[stateVarsNoEps,dd]],_Symbol?(MatchQ[SymbolName[#],"dd"]&)[t,i]],
  FreeQ[evNoEpsStateVarsProduct[pi[t]dd[t-1,i],model,Append[stateVarsNoEps,dd]],_Symbol?(MatchQ[SymbolName[#],"pi"]&)[t]],
  FreeQ[evNoEpsStateVarsProduct[pi[t-1]dd[t,i]eps["pi"][t-1],model,Append[stateVarsNoEps,dd]],_Symbol?(MatchQ[SymbolName[#],"dd"]&)[t-1,i]],
  Not@FreeQ[evNoEpsStateVarsProduct[pi[t-1]dd[t,i]eps["pi"][t-1],model,Append[stateVarsNoEps,dd]],_Symbol?(MatchQ[SymbolName[#],"eps"]&)["pi"][t-1]],
  FreeQ[evNoEpsStateVarsProduct[pi[t]dd[t-1,i]eps["pi"][t-1],model,Append[stateVarsNoEps,dd]],_Symbol?(MatchQ[SymbolName[#],"pi"]&)[t,i]],
  (*lag dd and expression has eps["dd"]*)
  FreeQ[evNoEpsStateVarsProduct[pi[t-1]dd[t,i]eps["dd"][t-1,i],model,Append[stateVarsNoEps,dd]],_Symbol?(MatchQ[SymbolName[#],"dd"]&)[t-1,i]],
  Not@FreeQ[evNoEpsStateVarsProduct[pi[t-1]dd[t,i]eps["dd"][t-1,i],model,Append[stateVarsNoEps,dd]],_Symbol?(MatchQ[SymbolName[#],"eps"]&)["dd"][t-1,i]],
  FreeQ[evNoEpsStateVarsProduct[pi[t]dd[t-1,i]eps["dd"][t-1,i],model,Append[stateVarsNoEps,dd]],_Symbol?(MatchQ[SymbolName[#],"pi"]&)[t]],
  Not@FreeQ[evNoEpsStateVarsProduct[pi[t]dd[t-1,i]eps["dd"][t-1,i],model,Append[stateVarsNoEps,dd]],_Symbol?(MatchQ[SymbolName[#],"pi"]&)[_]],
  FreeQ[uncondEStep[dc[t-1]sg[t],modNRC],_Symbol?(MatchQ[SymbolName[#],"dc"]&),Infinity],
  FreeQ[uncondEStep[dc[t-1]sg[t],modNRC],_Symbol?(MatchQ[SymbolName[#],"pi"]&)[t],Infinity]
}
```

---

#### Wealth-Consumption and Price-Dividend Ratio Tests

- Test evNoEpsStateVarsProduct with wc (wealth-consumption) and pd (price-dividend) ratios

  📍 `Tests/ComputationalEngine/ComputeUnconditionalExpectations.wlt:281-319` (4 tests)

```wolfram
And@@{
  evNoEpsStateVarsProduct[wc[t]eps["pi"][t-1],model,stateVarsNoEps]===wc[t] eps["pi"][-1+t],
  Coefficient[evNoEpsStateVarsProduct[wc[t]eps["pi"][t],model,{wc}],pi[t-1]]===rhop A[1] eps["pi"][t],
  DeleteDuplicates@Cases[evNoEpsStateVarsProduct[A[0]wc[t]eps["pi"][t-1],model,stateVarsNoEps],x_Symbol?(MatchQ[SymbolName[#],"A"]&)[_]:>Context@x,Infinity]==={"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"},
  DeleteDuplicates@Cases[evNoEpsStateVarsProduct[A[0]wc[t]eps["pi"][t-1],model,{wc}],x_Symbol?(MatchQ[SymbolName[#],"A"]&)[_]:>Context@x,Infinity]==={"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"},
  evNoEpsStateVarsProduct[pd[t,i]eps["pi"][t-1],model,stateVarsNoEps]===pd[t,i] eps["pi"][-1+t],
  Coefficient[evNoEpsStateVarsProduct[pd[t,i]eps["pi"][t],model,{pd}],pi[t-1]]===rhop B[i][1] eps["pi"][t],
  DeleteDuplicates@Cases[evNoEpsStateVarsProduct[A[0]B[i][1] pd[t,i]eps["pi"][t-1],model,stateVarsNoEps],x_Symbol?(MatchQ[SymbolName[#],"A"]&)[_]:>Context@x,Infinity]==={"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"},
  DeleteDuplicates@Cases[evNoEpsStateVarsProduct[A[0]B[i][1] pd[t,i]eps["pi"][t-1],model,stateVarsNoEps],x_Symbol?(MatchQ[SymbolName[#],"B"]&)[_][_]:>Context@x,Infinity]==={"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"},
  DeleteDuplicates@Cases[evNoEpsStateVarsProduct[A[0]B[i][1] pd[t,i]eps["pi"][t-1],model,{pd}],x_Symbol?(MatchQ[SymbolName[#],"A"]&)[_]:>Context@x,Infinity]==={"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"},
  DeleteDuplicates@Cases[evNoEpsStateVarsProduct[A[0]B[i][1] pd[t,i]eps["pi"][t-1],model,{pd}],x_Symbol?(MatchQ[SymbolName[#],"B"]&)[_][_]:>Context@x,Infinity]==={"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"}
}
```

---

#### Comprehensive Unconditional Moment Tests (Long Test Only)

- Test unconditional moments for wc, pi, sg, dc and cross-moments
```wolfram
And@@{
  Simplify[uncondE[wc[t],modNRC]]===A[0],
  Simplify[uncondE[wc[t],modBY]]===A[0],

  0===Simplify[(uncondE[pi[t]^3,modNRC]uncondE[sg[t],modNRC]-uncondE[pi[t]^3 sg[t],modNRC])],

  0===Simplify[uncondE[pi[t]^3 sg[t],modNRC]-Esg*mup*
    (mup^2 - (3*(phip^2 + 2*phip*rhop*xip + xip^2))/(-1 + rhop^2))],

  Simplify@uncondE[dc[t],modNRC]===muc,

  FullSimplify@Expand@uncondE[dc[t]^2,modNRC]===FullSimplify@Expand@(muc^2+phic^2+2 Esg phip rhocp xic+xic^2 (Esg^2+phig^2/(1-rhog^2)) +(rhocp^2 (phip^2+2 phip rhop xip+xip^2))/(1-rhop^2)),

  FullSimplify@Expand@uncondE[pi[t]dc[t],modNRC]===FullSimplify@Expand@(muc mup+rhocp xip phip+xic rhop phip Esg+xic xip Esg+((rhocp rhop) (xip^2+2 rhop xip phip+phip^2))/(1-rhop^2)),

  FullSimplify@Expand@uncondE[sg[t]dc[t],modNRC]===FullSimplify@Expand@(muc Esg),

  FullSimplify@Expand@uncondE[sg[t]sg[t+1],modNRC]===FullSimplify@Expand@(Esg^2+rhog/(1-rhog^2) phig^2),
  FullSimplify@Expand@uncondE[sg[t]sg[t-1],modNRC]===FullSimplify@Expand@(Esg^2+rhog/(1-rhog^2) phig^2),

  FullSimplify@Expand@uncondE[pi[t]pi[t+1],modNRC]===FullSimplify@Expand@(mup^2+phip xip+(rhop (phip^2+2rhop xip phip+xip^2))/(1-rhop^2)),
  FullSimplify@Expand@uncondE[pi[t]pi[t-1],modNRC]===FullSimplify@Expand@(mup^2+phip xip+(rhop (phip^2+2rhop xip phip+xip^2))/(1-rhop^2)),

  FullSimplify@Expand@uncondE[pi[t]sg[t+1],modNRC]===FullSimplify@Expand@(Esg mup),
  FullSimplify@Expand@uncondE[pi[t-1]dc[t],modNRC]===FullSimplify@Expand@(muc mup +Esg phip xic+(rhocp (phip^2 + 2 phip rhop xip+ xip^2))/(1-rhop^2))
}
```

- Minimal test for fast mode (wc expectations only)
```wolfram
And@@{
  Simplify[uncondE[wc[t],modNRC]]===A[0],
  Simplify[uncondE[wc[t],modBY]]===A[0]
}
```

---

## WLT Verification Results

Verification of `/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-clean-up/Tests/ComputationalEngine/ComputeUnconditionalExpectations.wlt` against wolfram-testing skill guidelines.

### Compliance Table

| Guideline | Status | Notes |
|-----------|--------|-------|
| Use `TestCreate` exclusively (not `VerificationTest`) | PASS | All 26 tests use `TestCreate` |
| Always include third argument for expected messages | PASS | All tests include `{}` as the third argument |
| TestID format: `"SymbolName-Scenario-Behavior"` | PASS | All TestIDs follow the pattern (e.g., `"uncondE-PiFirstMoment-ReturnsMup"`) |
| BeginTestSection names file being tested | PASS | Uses `"Kernel/ComputationalEngine/ComputeUnconditionalExpectations.wl Tests"` |
| Context isolation with Begin/End | PASS | Uses proper test context `FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ComputeUnconditionalExpectations`` |
| Needs statements at file beginning | PASS | Three `Needs` statements placed after `Begin` |
| Load shared helpers via `$TestFileName` | PASS | Uses `Get[FileNameJoin[{DirectoryName[$TestFileName, 2], "Common.wl"}]]` |
| No `Quiet` in test assertions | PASS | No `Quiet` usage in any test assertions |
| No `Off`/`On` for message suppression | PASS | No message suppression mechanisms used |
| Private functions accessed via full qualification | PASS | `evNoEpsStateVarsProduct` accessed via full path including `Private`` |
| Only load contexts actually used | WARNING | `ComputeConditionalExpectations` is loaded but no symbols from it appear to be used directly in tests |
| Avoid `TimeConstraint`, `MemoryConstraint`, `MetaInformation` | PASS | None of these options are used |
| No hard-wired numbering in comments | PASS | Section headers use descriptive names without numbers |
| One assertion per behavior | PASS | Each `TestCreate` tests a single behavior |
| No paclet initialization boilerplate | PASS | No `PacletDirectoryLoad` or complex path-resolution blocks |

### Summary

**Overall Status**: COMPLIANT (with one minor warning)

The WLT file follows all wolfram-testing skill guidelines. The file demonstrates:

- Proper structure with `BeginTestSection`/`EndTestSection` and `Begin`/`End` for context isolation
- Consistent use of `TestCreate` with proper three-argument form
- Well-formatted TestIDs following the `"SymbolName-Scenario-Behavior"` pattern
- Appropriate use of fixtures defined in the test context
- Correct access to private functions via full qualification
- Clean loading of shared test helpers

**Warning**: The `Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"]` statement loads a context whose symbols do not appear to be directly used in the test assertions. This may be an indirect dependency (the module under test may require it) but should be verified. If not needed, consider removing it per the guideline "Only load contexts you actually use."

**Test Count**: 26 tests covering:
- Basic unconditional expectations (`uncondE`)
- Second moments and variance (`uncondVar`)
- Covariance (`uncondCov`)
- Correlation (`uncondCorr`)
- Private helper function `evNoEpsStateVarsProduct` with multiple scenarios
