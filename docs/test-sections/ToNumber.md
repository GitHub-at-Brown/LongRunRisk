### ToNumber.wl

This section tests the `Tools`ToNumber` module, which provides numerical evaluation capabilities for model expressions.

---

#### Setup and Dependencies

- Load required packages and suppress common messages

```wolfram
Off[General::stop];
Off[FindRoot::lstol];

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];

FernandoDuarte`LongRunRisk`Models = Get@Get[FileNameJoin[{"FernandoDuarte/LongRunRisk","Models.wl"}]];
msp = FernandoDuarte`LongRunRisk`Models;
modBY = msp["BY"];
modBKY = msp["BKY"];
modNRC = msp["NRC"];
modDES = msp["DES"];
modNRCStochVol = msp["NRCStochVol"];
```

---

#### Test Expressions

- Define expressions to test across multiple models

```wolfram
expr[t_,m_,i_,mu_] := {
  wc[t], pd[t,i], bond[t,m], nombond[t,m], bondexcret[t,m], bondfw[t,m],
  bondfwspread[t,m], bondret[t,m], bondyield[t,m], excretc[t], excret[t,i],
  kappa0[mu], kappa1[mu], nombondexcret[t,m], nombondfw[t,m], nombondfwspread[t,m],
  nombondret[t,m], nombondyield[t,m], nomrf[t], nomsdf[t], retc[t], ret[t,i],
  rf[t], sdf[t], pi[t], dc[t],
  growth[dc,t,"TimeAggregation"->2,"numPeriods"->1],
  growth[dd,t,1,"TimeAggregation"->2],
  AA dc[t+1]excret[t,1],
  AA excret[t,1]+BB nombondyield[t,2]
};
ee = expr[t,3,1,1];
e1 = ee[[1;;3]];
e2 = ee[[1;;2]];
```

---

#### Options List for Testing

- Various option combinations for `toNum`

```wolfram
optsList = {
  {},
  {maxMaturity->6},
  {"FindRootOptions"->{MaxIterations->100}},
  {MaxIterations->100},
  {"initialGuess" -> <|"Ewc"->{4},"Epd"->{{4}}|>},
  {"initialGuess" -> <|"Ewc"->{4},"Epd"->{{4}}|>,MaxIterations->100},
  {"initialGuess" -> <|"Ewc"->{4},"Epd"->{{4}}|>,"FindRootOptions"->{MaxIterations->100}},
  {maxMaturity->6,"initialGuess" -> <|"Ewc"->{4},"Epd"->{{4}}|>,MaxIterations->100},
  {"PrintResidualsNorm"->True},
  {"CheckResiduals"->True,"Tol"->1},
  {"CheckResiduals"->True,"Tol"->10.^-20},
  {"PrintResidualsNorm"->True,maxMaturity->6,"initialGuess" -> <|"Ewc"->{4},"Epd"->{{4}}|>,MaxIterations->100},
  {"RecurrenceTableOptions"->{"DependentVariables"->Automatic}},
  {DependentVariables->Automatic}
};
```

---

#### toNum Function Tests ⚠️ MISSING FROM WLT

- **Test: `toNum[thisModel]` returns a Function**

```wolfram
tn = toNum[thisModel];
Head@tn === Function
```

- **Test: Numerical evaluation of expressions**

```wolfram
NumericQ /@ Flatten@{
  ((e1//tn)//.numModel),
  (((uncondE/@e1)//tn)//.numModel),
  (((uncondVar/@e1)//tn)//.numModel),
  (((ev[#,t-1]&/@e1)//tn)//.numModel),
  (((var[#,t-1]&/@e1)//tn)//.numModel)
}
```

- **Test: `toNum[expression, thisModel]` form**

```wolfram
NumericQ /@ Flatten@{
  ((toNum[e1,thisModel])//.numModel),
  (((toNum[uncondE/@e1,thisModel]))//.numModel),
  (((toNum[uncondVar/@e1,thisModel]))//.numModel),
  (((toNum[ev[#,t-1]&/@e1,thisModel]))//.numModel),
  (((toNum[var[#,t-1]&/@e1,thisModel]))//.numModel)
}
```

- **Test: `toNum["Rules", thisModel]` form with `toEquation`**

```wolfram
NumericQ /@ Flatten@{
  ((toEquation[e1,thisModel])//.numModel),
  (((toEquation[uncondE/@e1,thisModel]))//.numModel),
  (((toEquation[uncondVar/@e1,thisModel]))//.numModel),
  (((toEquation[ev[#,t-1]&/@e1,thisModel]))//.numModel),
  (((toEquation[var[#,t-1]&/@e1,thisModel]))//.numModel)
} //. toNum["Rules",thisModel]
```

---

#### Options Handling Tests ⚠️ MISSING FROM WLT

- **Test: "UpdatePd" and "UpdateBonds" options (always ignored)**

```wolfram
NumericQ /@ Flatten@{
  pd[t,1]//toNum[thisModel,"UpdatePd"->False]//.numModel,
  toNum[pd[t,1],thisModel,"UpdatePd"->False]//.numModel,
  toEquation[pd[t,1],thisModel]//.toNum["Rules",thisModel,"UpdatePd"->False]//.numModel,

  {bondyield[t,2],nombondyield[t,3]}//toNum[thisModel,"UpdateBonds"->False]//.numModel,
  toNum[{bondyield[t,2],nombondyield[t,3]},thisModel,"UpdateBonds"->False]//.numModel,
  toEquation[{bondyield[t,2],nombondyield[t,3]},thisModel]//.toNum["Rules",thisModel,"UpdateBonds"->False]//.numModel
}
```

---

#### New Parameters and Initial Guess Tests ⚠️ MISSING FROM WLT

- **Test: Pass new parameters**

```wolfram
newParameters = {delta->0.99};
exprNewParam = uncondE[wc[t]];

exprNewParam//toNum[thisModel,newParameters]//.numModel
toNum[exprNewParam,thisModel,newParameters]//.numModel
toEquation[exprNewParam,thisModel]//.toNum["Rules",thisModel,newParameters]//.numModel
```

- **Test: Pass initial guess for coefficients**

```wolfram
guessCoeffsSolution = {A[0]->4.6};

exprNewParam//toNum[thisModel,{},guessCoeffsSolution]//.numModel
toNum[exprNewParam,thisModel,{},guessCoeffsSolution]//.numModel
toEquation[exprNewParam,thisModel]//.toNum["Rules",thisModel,{},guessCoeffsSolution]//.numModel
```

- **Test: Pass both new parameters and initial guess**

```wolfram
exprNewParam//toNum[thisModel,newParameters,guessCoeffsSolution]//.numModel
toNum[exprNewParam,thisModel,newParameters,guessCoeffsSolution]//.numModel
toEquation[exprNewParam,thisModel]//.toNum["Rules",thisModel,newParameters,guessCoeffsSolution]//.numModel
```

- **Test: New parameters, guess, and options combined**

```wolfram
optNewParam = {"initialGuess" -> <|"Ewc"->{4},"Epd"->{{4}}|>,MaxIterations->100};

exprNewParam//toNum[thisModel,newParameters,Sequence@@optNewParam]//.numModel
exprNewParam//toNum[thisModel,{},guessCoeffsSolution,Sequence@@optNewParam]//.numModel
exprNewParam//toNum[thisModel,newParameters,guessCoeffsSolution,Sequence@@optNewParam]//.numModel
```

---

### processNewParameters Function Tests ✅ IMPLEMENTED IN WLT

📍 **Location**: `Tests/Tools/ToNumber.wlt:48-388`

#### Helper Functions for Testing

```wolfram
(* Returns True if evaluation of expr returns $Aborted *)
SetAttributes[checkAbrt, HoldAll];
checkAbrt[expr_] := TrueQ@Quiet[
  AbortProtect[
    CheckAbort[expr, True]
  ]
];

(* Returns True if msg issued when expr is evaluated *)
SetAttributes[checkMsg, HoldAll];
checkMsg[expr_, msg_] :=
  CheckAbort[
    Quiet[
      AbortProtect[
        c = Check[expr;, True, msg];
      ];
    ];
    TrueQ@c
    ,
    TrueQ@c
  ];
```

---

#### Test: Old and new parameters are equal

📍 `Tests/Tools/ToNumber.wlt:48-101` (5 tests)

```wolfram
p = {delta->0.998`, Esx->0.0078`, gamma->10, muc->0.0015`, phisxs->2.3`*^-6,
     phix->0.044`, psi->1.5`, rhox->0.979`, theta->(1-gamma)/(1-1/psi),
     vx->0.987`, mud[1]->0.0015`, phidxd[1]->4.5`, rhodx[1]->3};
newP = {delta->0.998`, Esx->0.0078`, gamma->10, muc->0.0015`, phisxs->2.3`*^-6,
        phix->0.044`, psi->1.5`, rhox->0.979`, theta->(1-gamma)/(1-1/psi),
        vx->0.987`, mud[1]->0.0015`, phidxd[1]->4.5`, rhodx[1]->3};

procP = processNewParameters[newP, p];

And@@Simplify@{
  (* Values are numbers *)
  And@@(NumberQ/@Values@procP),
  (* Parameters in processed list are same as in new parameters *)
  (Sort@Keys@procP) === (Sort@Keys@newP),
  (* Parameters in processed list are subset of old parameters *)
  SubsetQ[Keys@p, Keys@procP],
  (* Not aborted *)
  Not@checkAbrt[processNewParameters[newP, p]]
}
```

---

#### Test: New parameters are subset of old parameters

📍 `Tests/Tools/ToNumber.wlt:108-140` (3 tests)

```wolfram
p = {delta->0.998`, Esx->0.0078`, gamma->10, muc->0.0015`, phisxs->2.3`*^-6,
     phix->0.044`, psi->1.5`, rhox->0.979`, theta->(1-gamma)/(1-1/psi),
     vx->0.987`, mud[1]->0.0015`, phidxd[1]->4.5`, rhodx[1]->3};
newP = {delta->0.9, Esx->1};

procP = processNewParameters[newP, p];

And@@Simplify@{
  And@@(NumberQ/@Values@procP),
  Sort@Keys@procP === Sort@Keys@newP,
  SubsetQ[Keys@p, Keys@procP],
  Not@checkAbrt[processNewParameters[newP, p]]
}
```

---

#### Test: New parameters is empty

📍 `Tests/Tools/ToNumber.wlt:147-155` (1 test)

```wolfram
p = {delta->0.998`, Esx->0.0078`, gamma->10, muc->0.0015`, phisxs->2.3`*^-6,
     phix->0.044`, psi->1.5`, rhox->0.979`, theta->(1-gamma)/(1-1/psi),
     vx->0.987`, mud[1]->0.0015`, phidxd[1]->4.5`, rhodx[1]->3};
newP = {};

procP = processNewParameters[newP, p];

And@@Simplify@{
  And@@(NumberQ/@Values@procP),
  Sort@Keys@procP === Sort@Keys@newP,
  SubsetQ[Keys@p, Keys@procP],
  Not@checkAbrt[processNewParameters[newP, p]]
}
```

---

#### Test: New parameters are NOT a subset of old parameters (should abort)

📍 `Tests/Tools/ToNumber.wlt:162-181` (2 tests)

```wolfram
p = {delta->0.998`, Esx->0.0078`, gamma->10, muc->0.0015`, phisxs->2.3`*^-6,
     phix->0.044`, psi->1.5`, rhox->0.979`, theta->(1-gamma)/(1-1/psi),
     vx->0.987`, mud[1]->0.0015`, phidxd[1]->4.5`, rhodx[1]->3};
newP = {delta->0.9, Esx->1, phip->3};

And@@Simplify@{
  (* Aborts *)
  checkAbrt[processNewParameters[newP, p]],
  (* With message subsetparam *)
  checkMsg[processNewParameters[newP, p],
           FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::subsetparam]
}
```

---

#### Test: psi=1 in new parameters aborts

📍 `Tests/Tools/ToNumber.wlt:188-217` (3 tests)

```wolfram
p = {delta->0.998`, Esx->0.0078`, gamma->10, muc->0.0015`, phisxs->2.3`*^-6,
     phix->0.044`, psi->1.5`, rhox->0.979`, theta->(1-gamma)/(1-1/psi),
     vx->0.987`, mud[1]->0.0015`, phidxd[1]->4.5`, rhodx[1]->3};
newP = {delta->0.9, Esx->1, psi->1};

And@@Simplify@{
  checkAbrt[processNewParameters[newP, p]],
  checkMsg[processNewParameters[newP, p],
           FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::psi]
}
```

---

#### Test: psi=1. (numeric) in new parameters also aborts

📍 `Tests/Tools/ToNumber.wlt:209-217` (included in psi=1 tests)

```wolfram
newP = {delta->0.9, Esx->1, psi->1.};

And@@Simplify@{
  checkAbrt[processNewParameters[newP, p]],
  checkMsg[processNewParameters[newP, p],
           FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::psi]
}
```

---

#### Test: gamma, psi, theta relationship (theta exactly correct)

📍 `Tests/Tools/ToNumber.wlt:224-242` (2 tests)

When all three are provided and theta = (1-gamma)/(1-1/psi), no message is issued.

```wolfram
p = {delta->0.998`, Esx->0.0078`, gamma->10, muc->0.0015`, phisxs->2.3`*^-6,
     phix->0.044`, psi->1.5`, rhox->0.979`, theta->(1-gamma)/(1-1/psi),
     vx->0.987`, mud[1]->0.0015`, phidxd[1]->4.5`, rhodx[1]->3};
newP = {gamma->10, theta->(1-gamma)/(1-1/psi), psi->1.5`};

procP = processNewParameters[newP, p];

And@@Simplify@{
  And@@(NumberQ/@Values@procP),
  Sort@Keys@procP === Sort@Keys@newP,
  SubsetQ[Keys@p, Keys@procP],
  Not@checkAbrt[processNewParameters[newP, p]]
}
```

---

#### Test: gamma, psi, theta relationship (theta NOT exactly correct)

📍 `Tests/Tools/ToNumber.wlt:244-269` (2 tests)

When theta is provided but doesn't match the formula, a message is issued and theta is recalculated.

```wolfram
newP = {gamma->10, theta->3.23`, psi->1.5`};

procP = Quiet[processNewParameters[newP, p],
              FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::param];

And@@Simplify@{
  And@@(NumberQ/@Values@procP),
  Sort@Keys@procP === Sort@Keys@newP,
  SubsetQ[Keys@p, Keys@procP],
  Not@checkAbrt[processNewParameters[newP, p]],
  checkMsg[processNewParameters[newP, p],
           FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::param],
  (* Theta has correct value *)
  Chop@RealAbs[(theta/.procP)-(-27.)] < $MachineEpsilon
}
```

---

#### Test: Solve for gamma from {psi, theta}

📍 `Tests/Tools/ToNumber.wlt:276-297` (2 tests)

```wolfram
newP = {psi->2, theta->-3.`};
procP = processNewParameters[newP, p];

And@@Simplify@{
  And@@(NumberQ/@Values@procP),
  Sort@Keys@procP === Sort[Join[{gamma}, Keys@newP]],
  SubsetQ[Keys@p, Keys@procP],
  Not@checkAbrt[processNewParameters[newP, p]],
  (* Gamma has correct value *)
  Chop@RealAbs[(gamma/.procP)-(2.5)] < $MachineEpsilon
}
```

---

#### Test: Solve for theta from {gamma, psi}

📍 `Tests/Tools/ToNumber.wlt:299-310` (1 test)

```wolfram
newP = {psi->2, gamma->2.5};
procP = processNewParameters[newP, p];

And@@Simplify@{
  And@@(NumberQ/@Values@procP),
  Sort@Keys@procP === Sort[Join[{theta}, Keys@newP]],
  SubsetQ[Keys@p, Keys@procP],
  Not@checkAbrt[processNewParameters[newP, p]],
  (* Theta has correct value *)
  RealAbs[(theta/.procP)-(-3)] < $MachineEpsilon
}
```

---

#### Test: Solve for psi from {gamma, theta}

📍 `Tests/Tools/ToNumber.wlt:312-323` (1 test)

```wolfram
newP = {gamma->2.5, theta->-3.`};
procP = processNewParameters[newP, p];

And@@Simplify@{
  And@@(NumberQ/@Values@procP),
  Sort@Keys@procP === Sort[Join[{psi}, Keys@newP]],
  SubsetQ[Keys@p, Keys@procP],
  Not@checkAbrt[processNewParameters[newP, p]],
  (* Psi has correct value *)
  RealAbs[(psi/.procP)-(2)] < $MachineEpsilon
}
```

---

#### Test: theta provided without gamma or psi aborts

📍 `Tests/Tools/ToNumber.wlt:330-349` (2 tests)

```wolfram
newP = {delta->0.9, Esx->1, theta->1.};

And@@Simplify@{
  checkAbrt[processNewParameters[newP, p]],
  checkMsg[processNewParameters[newP, p],
           FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::theta]
}
```

---

#### Test: processNewParameters preserves contexts of old parameters

📍 `Tests/Tools/ToNumber.wlt:356-388` (2 tests)

```wolfram
p = {context1`delta->0.998`, context1`Esx->0.0078`, foo`gamma->10, muc->0.0015`,
     phisxs->2.3`*^-6, phix->0.044`, psi->1.5`, rhox->0.979`,
     theta->(1-gamma)/(1-1/psi), vx->0.987`, mud[1]->0.0015`,
     phidxd[1]->4.5`, rhodx[1]->3};
newP = {context2`delta->0.9, Esx->1, bar`gamma->2};

procP = processNewParameters[newP, p];

And@@Simplify@{
  (* Contexts of newP do not match those in old parameters in p *)
  KeyTake[p, Keys@newP] === <||>,
  (* Contexts of procP match those in old parameters in p *)
  (Context/@Keys@procP) === Context/@(Keys@KeyTake[p, Keys@procP])
}
```

## WLT Verification Results

Verification of `/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-clean-up/Tests/Tools/ToNumber.wlt` against wolfram-testing skill guidelines.

### Compliance Table

| Guideline | Status | Notes |
|-----------|--------|-------|
| Use `TestCreate` exclusively (no `VerificationTest`) | PASS | All 25 tests use `TestCreate` |
| Always include third argument for expected messages | PASS | All tests include `{}` as third argument |
| TestID format: `"SymbolName-Scenario-Behavior"` | PASS | All TestIDs follow the pattern (e.g., `"processNewParameters-EqualParameters-ValuesAreNumbers"`) |
| BeginTestSection names file being tested | PASS | Uses `"Kernel/Tools/ToNumber.wl Tests"` |
| Context isolation with Begin/End | PASS | Properly wrapped in `Begin["FernandoDuarte`LongRunRisk`Tests`Tools`ToNumber`"]` and `End[]` |
| Use `Needs` for required contexts | PASS | Has `Needs["FernandoDuarte`LongRunRisk`Tools`ToNumber`"]` |
| Load shared helpers via `$TestFileName` | PASS | Uses `Get[FileNameJoin[{DirectoryName[$TestFileName, 2], "Common.wl"}]]` |
| Only load contexts actually used | PASS | Only loads the ToNumber context which is used |
| No `TimeConstraint`/`MemoryConstraint`/`MetaInformation` | PASS | None present |
| No paclet initialization boilerplate | PASS | No `PacletDirectoryLoad` or complex path resolution |
| Prefer unqualified symbols after `Needs` | PASS | Uses `processNewParameters` unqualified |
| Full qualification for message names | PASS | Uses full paths like `FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::subsetparam` |
| No `Quiet` in test assertions | ISSUE | `Quiet` used in helper functions `checkAbrt` (line 33) and `checkMsg` (lines 39-43), and in test assertion (line 242) |

### Issues Found

**Issue: Use of `Quiet` in test helpers and assertions**

The file uses `Quiet` in ways that could mask test failures:

1. **Line 33** - `checkAbrt` helper:
   ```wolfram
   checkAbrt[expr_] := TrueQ @ Quiet @ CheckAbort[expr, True];
   ```

2. **Lines 37-47** - `checkMsg` helper uses `Quiet` around the expression being tested:
   ```wolfram
   checkMsg[expr_, msg_] := Module[{c},
       CheckAbort[
           Quiet[
               AbortProtect[
                   c = Check[expr;, True, msg];
               ];
           ];
           ...
   ```

3. **Lines 242-243** - Direct use of `Quiet` in a test assertion:
   ```wolfram
   procP = Quiet[processNewParameters[newP, p],
       FernandoDuarte`LongRunRisk`Tools`ToNumber`processNewParameters::param];
   ```

**Recommendation**: The helper functions `checkAbrt` and `checkMsg` are designed to check for aborts and specific messages, so the use of `Quiet` is somewhat intentional to avoid side effects. However, per the wolfram-testing guidelines, this pattern could mask unexpected issues. Consider:
- For message testing, use the third argument of `TestCreate` to specify expected messages instead of helper functions with `Quiet`
- For abort testing, consider restructuring to avoid `Quiet` or document why it's necessary for these specific test helpers

### Summary

The WLT file is **largely compliant** with the wolfram-testing skill guidelines. It follows best practices for:
- Test structure and organization
- TestID naming conventions
- Context isolation
- Package loading
- Helper file inclusion

The main area for improvement is the use of `Quiet` in test helper functions and one test assertion, which could potentially mask unexpected failures. This is a **minor issue** since the helpers are specifically designed to test abort and message behavior, but it diverges from the strict guideline of "never suppress messages in test assertions."

**Overall Assessment**: 12/13 guidelines fully compliant (92%)
