# Kernel

## Model

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


---

### ExogenousEq.wl

- Symbol `xeq` should exist (can be found)
  ```
  Not[Names["*xeq"] === {}]
  ```

For exogenous variables (entries of `$exogenousVars`):
- All exogenous variables are in context `"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"` (individual checks)
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

- All exogenous variables are in context `"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"` (generic check)
  ```
  And @@ ((# ===
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`") & /@
    (Context /@ Cases[(#[t]) & /@ (Symbol /@ $exogenousVars),
      var_Symbol?(MemberQ[StringDrop[#, -2] & /@ $exogenousVars,
          SymbolName[#]] &)[__] :> var, Infinity]))
  ```

- All shocks are in context `"FernandoDuarte`LongRunRisk`Model`Shocks`"`
  ```
  And @@ ((# === "FernandoDuarte`LongRunRisk`Model`Shocks`") & /@
    (Context /@ Cases[(#[t]) & /@ (Symbol /@ $exogenousVars),
      var_Symbol?(MatchQ[SymbolName[#], "eps"] &)[__][__] :> var, Infinity]))
  ```

- All parameters are in context `"FernandoDuarte`LongRunRisk`Model`Parameters`"`
  ```
  And @@ ((# ===
      "FernandoDuarte`LongRunRisk`Model`Parameters`") & /@
    (Context /@ Cases[(#[t]) & /@ (Symbol /@ $exogenousVars),
      var_Symbol?(MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters,
          SymbolName[#]] &) :> var, Infinity]))
  ```

- Equation variables use different contexts for `t` argument (context isolation)
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


---

### EndogenousEq.wl

- Symbol `pdeq` should exist (can be found)
  ```
  Not[Names["*pdeq"] === {}]
  ```

For endogenous variables (entries of `$endogenousVars`):
- All exogenous variables are in context `"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"`
  ```
  And @@ ((# ===
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`") & /@
    (Context /@
      Cases[((#[t]) & /@ (Symbol /@ $endogenousVars)),
        var_Symbol?(MemberQ[
            StringDrop[#, -2] & /@
              FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars,
            SymbolName[#]] &)[__] :> var, Infinity]))
  ```

- All shocks are in context `"FernandoDuarte`LongRunRisk`Model`Shocks`"`
  ```
  And @@ ((# === "FernandoDuarte`LongRunRisk`Model`Shocks`") & /@ (Context /@
      Cases[((#[t]) & /@ (Symbol /@ $endogenousVars)),
        var_Symbol?(MatchQ[SymbolName[#], "eps"] &)[__][__] :> var, Infinity]))
  ```

- All parameters are in context `"FernandoDuarte`LongRunRisk`Model`Parameters`"`
  ```
  And @@ ((# ===
      "FernandoDuarte`LongRunRisk`Model`Parameters`") & /@ (Context /@
      Cases[((#[t]) & /@ (Symbol /@ $endogenousVars)),
        var_Symbol?(MemberQ[
            FernandoDuarte`LongRunRisk`Model`Parameters`$parameters,
            SymbolName[#]] &) :> var, Infinity]))
  ```

- All endogenous variables are in context `"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"`
  ```
  And @@ ((# ===
      "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`") & /@
    (Context /@
      Cases[((#[t]) & /@ (Symbol /@ $endogenousVars)),
        var_Symbol?(MemberQ[StringDrop[#, -2] & /@ $endogenousVars,
            SymbolName[#]] &)[__] :> var, Infinity]))
  ```

- Equation variables use different contexts for `t` argument (context isolation)
  ```
  And @@ {
    FreeQ[bondyieldeq[t, m], foo`t],
    Not@FreeQ[bondyieldeq[t, m], t],
    FreeQ[bondyieldeq[foo`t, m], t],
    Not@FreeQ[bondyieldeq[foo`t, m], foo`t],
    Not@(foo`bondyieldeq[t, m] === bondyieldeq[t, m]),
    Not@(bondyieldeq[t, m] === bondyieldeq[foo`t, m])
    }
  ```

- Equation variables use different contexts for `m` argument (context isolation)
  ```
  And @@ {
    FreeQ[bondyieldeq[t, m], foo`m],
    Not@FreeQ[bondyieldeq[t, m], m],
    FreeQ[bondyieldeq[t, foo`m], m],
    Not@FreeQ[bondyieldeq[t, foo`m], foo`m],
    Not@(bondyieldeq[t, m] === bondyieldeq[t, foo`m])
    }
  ```

- Default values for optional arguments work correctly
  ```
  And @@ {
    bondfweq[t, m] === bondfweq[t, m, 1],
    bondreteq[t, m] === bondreteq[t, m, 1],
    bondfwspreadeq[t, m] === bondfwspreadeq[t, m, 1],
    bondexcreteq[t, m] === bondexcreteq[t, m, 1]
    }
  ```

For coefficient functions (`coefwc`, `coefpd`, `coefb`, `coefnb`):
- Indices of coefficients are exact integers (not inexact/floating-point numbers)
  - Applies to `coefwc[i]`, `coefpd[i][j]`, `coefb[i][j]`, `coefnb[i][j]`
  - Must remain exact after `N[]` application to the coefficient (not the index)
  ```
  coefwc = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc;
  coefpd = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd;
  coefb = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb;
  coefnb = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb;

  (* Test that indices remain exact integers in all coefficient expressions *)
  And @@ Flatten@{
    Not /@ InexactNumberQ /@ Select[Flatten@Cases[ch, x_[i_] :> i], NumberQ],
    Not /@ InexactNumberQ /@ Select[Flatten@Cases[ch, x_[i_][j_] :> {i, j}], NumberQ]
    }
  ```


---

### ProcessModels.wl

#### Package Loading and Context Setup

- Load LongRunRisk and ProcessModels packages
  ```wolfram
  Needs@"FernandoDuarte`LongRunRisk`";
  Needs@context;
  True
  ```

- Load Catalog package
  ```wolfram
  Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
  True
  ```

- Set up test mode flag
  ```wolfram
  longTest = False; (*fast and partial coverage (False) or slow and full coverage (True)*)
  True
  ```

#### Context Path Verification

- Verify required contexts are in `$ContextPath`
  ```wolfram
  And@@{
    MemberQ[$ContextPath,"FernandoDuarte`LongRunRisk`Model`Catalog`"],
    MemberQ[$ContextPath,"FernandoDuarte`LongRunRisk`Model`ProcessModels`"]
  }
  ```

- Verify `processModels` and `models` symbols can be found
  ```wolfram
  And@@{Not[Names["*processModels"]==={}], Not[Names["*models"]==={}]}
  ```

#### Model Loading and Setup

- Load models from Models.wl and set up test subsets
  ```wolfram
  Needs["PacletizedResourceFunctions`"];
  FernandoDuarte`LongRunRisk`Models=Get@Get[FileNameJoin[{"FernandoDuarte/LongRunRisk","Models.wl"}]];
  modelsTest=If[longTest,
    FernandoDuarte`LongRunRisk`Model`Catalog`models,
    KeyTake[FernandoDuarte`LongRunRisk`Model`Catalog`models,{"BY","BKY","NRC"}]
  ];
  modelsP=If[longTest,
    FernandoDuarte`LongRunRisk`Models,
    KeyTake[FernandoDuarte`LongRunRisk`Models,{"BY","BKY","NRC"}]
  ];
  True
  ```

#### Basic Structure Tests

- Model keys are strings
  ```wolfram
  And@@(StringQ/@Keys[modelsP])
  ```

- String fields have correct type
  ```wolfram
  And@@(StringQ/@Flatten@({modelsP[#]["name"], modelsP[#]["shortname"], modelsP[#]["bibRef"], modelsP[#]["desc"], modelsP[#]["exogenousVars"], modelsP[#]["endogenousVars"]}&/@Keys[modelsP]))
  ```

- Parameters evaluate to numbers
  ```wolfram
  And@@{
    And@@(NumberQ/@Flatten[Values[Association@modelsTest[#]["parameters"]//.modelsTest[#]["parameters"]//N]&/@(Keys@modelsTest)]),
    And@@(NumberQ/@Flatten[Values[Association@modelsP[#]["parameters"]//.modelsP[#]["parameters"]//N]&/@(Keys@modelsP)])
  }
  ```

- Known models can be found
  ```wolfram
  And@@{
    And@@(MemberQ[Keys[modelsTest],#]&/@{"BY","BKY"}),
    And@@(MemberQ[Keys[modelsP],#]&/@(Keys@modelsP))
  }
  ```

- Models and modelsP are associations
  ```wolfram
  And@@{
    AllTrue[modelsTest,AssociationQ],
    AllTrue[modelsP,AssociationQ],
    AllTrue[modelsTest[#]&/@Keys[modelsTest],AssociationQ],
    AllTrue[modelsP[#]&/@Keys[modelsP],AssociationQ]
  }
  ```

#### Variable Exclusion Tests

- `"stateVars"` and `"exogenousEq"` should not contain endogenous variables
  ```wolfram
  And@@{
    And@@(MatchQ[{},#]&/@(Cases[modelsP[#]["stateVars"],var_Symbol?(MemberQ[StringDrop[#,-2]&/@FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars,SymbolName[#]]&)[__]:>var,Infinity]&/@Keys[modelsP])),
    And@@(MatchQ[{},#]&/@(Cases[modelsP[#]["exogenousEq"],var_Symbol?(MemberQ[StringDrop[#,-2]&/@FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars,SymbolName[#]]&)[__]:>var,Infinity]&/@Keys[modelsP]))
  }
  ```

#### StateVars Function Structure

- `stateVars` are functions of one variable (time)
  ```wolfram
  And@@{
    And@@(MatchQ[Function,#]&/@(Head/@((modelsP[#]["stateVars"])&/@Keys[modelsP]))),
    And@@(MatchQ[List,#]&/@(Head/@((modelsP[#]["stateVars"][t])&/@Keys[modelsP]))),
    And@@(MatchQ[1,#]&/@(Length/@((modelsP[#]["stateVars"][[1]])&/@Keys[modelsP]))),
    And@@(MatchQ["t",#]&/@((SymbolName@@modelsP[#]["stateVars"][[1]])&/@Keys[modelsP]))
  }
  ```

#### Numeric Field Tests

- `numStocks` is a number
  ```wolfram
  And@@(NumberQ/@(modelsP[#]["numStocks"]&/@(Keys@modelsP)))
  ```

#### Coefficient Solution Tests

- A and B coefficients are always numeric
  ```wolfram
  And@@Flatten[(
    NumberQ/@Flatten[Values/@{modelsP[#]["coeffsSolutionN"][[1,"A"]],
    modelsP[#]["coeffsSolutionN"][[1,"Stocks",1,1,"B"]]}]
  )&/@Keys[modelsP]]
  ```

- Bond and NomBond values are either numeric or `Missing["Overflow"]` sentinel
  ```wolfram
  And@@Flatten[(
    Map[(NumberQ[#] || MatchQ[#, _Missing]) &,
    Flatten[Values/@{modelsP[#]["coeffsSolutionN"][[1,"Bond"]],
    modelsP[#]["coeffsSolutionN"][[1,"NomBond"]]}]]
  )&/@Keys[modelsP]]
  ```


---

### Shocks.wl

#### Package Loading

- Context is on `$ContextPath` after loading
  ```
  MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Shocks`"]
  ```

- Symbol `rulesE` should exist (can be found)
  ```
  Not[Names["*rulesE"] === {}]
  ```

#### Shock Moments (Standard Normal Properties)

- Shocks have zero mean (first moment)
  ```
  And @@ (
    Flatten@{
      Table[(eps[f][t] /. rulesE[t]) === 0,
        {f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}],
      Table[(eps["dd"][t, ii] /. rulesE[t]) === 0, {ii, {1, i, j}}]
    }
  )
  ```

- Shocks have variance equal to one (second moment)
  ```
  And @@ (
    Flatten@{
      Table[(eps[f][t]^2 /. rulesE[t]) === 1,
        {f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}],
      Table[(eps["dd"][t, ii]^2 /. rulesE[t]) === 1, {ii, {1, i, j}}]
    }
  )
  ```

- Shocks have fourth moment equal to three (kurtosis of standard normal)
  ```
  And @@ (
    Flatten@{
      Table[(eps[f][t]^4 /. rulesE[t]) === 3,
        {f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}],
      Table[(eps["dd"][t, ii]^4 /. rulesE[t]) === 3, {ii, {1, i, j}}]
    }
  )
  ```

#### Shock Independence

- Shocks are uncorrelated (cross-products have zero expectation)
  ```
  And @@ (
    Flatten@{
      Table[0 === If[f === g, 0, eps[f][t] * eps[g][t] /. rulesE[t]],
        {f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}},
        {g, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}],
      Table[0 === (eps["dd"][t, ii] * eps[f][t] /. rulesE[t]),
        {ii, {1, i, j}}, {f, {"x", "pi", "pibar", "sg", "sx", "sc", "sp"}}]
    }
  )
  ```

#### Context Independence

- `rulesE` works for symbols in any context
  ```
  And @@ (
    Flatten@{
      Table[(NewContext`eps[f][t] /. rulesE[t]) === 0,
        {f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}],
      Table[(NewContext`eps["dd"][t, ii] /. rulesE[t]) === 0, {ii, {1, i, j}}]
    }
  )
  ```


---

## ComputationalEngine

### ComputeConditionalExpectations.wl

#### Setup and Context Verification

- Verify the package context is properly loaded
  ```wolfram
  MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"]
  ```

- Verify key private functions are accessible
  ```wolfram
  And@@{Not[Names["*ev"] === {}], Not[Names["lagStateVarst"] === {}]}
  ```

#### Basic Conditional Expectation Tests

- Expectation of shock times inflation equals the shock loading parameter
  ```wolfram
  ev[eps["pi"][t+1] pi[t+1], t-1, modNRC] === FernandoDuarte`LongRunRisk`Model`Parameters`phip
  ```

#### Law of Iterated Expectations

- E[E[X|F_t]|F_{t-1}] = E[X|F_{t-1}]
  ```wolfram
  0 === (ev[pi[t+1], t-1, modNRC] - ev[ev[pi[t+1], t, modNRC], t-1, modNRC] // Simplify)
  0 === (ev[dc[t+1], t-1, modNRC] - ev[ev[dc[t+1], t, modNRC], t-1, modNRC] // Simplify)
  0 === (ev[sg[t+1], t-1, modNRC] - ev[ev[sg[t+1], t, modNRC], t-1, modNRC] // Simplify)
  ```

#### Conditional Variance Tests

  ```wolfram
  0 === (var[pi[t+1], t, modNRC] - phip^2 // Simplify)
  0 === (var[dc[t+1], t, modNRC] - phic^2 // Simplify)
  0 === (var[sg[t+1], t, modNRC] - phig^2 // Simplify)
  ```


---

### ComputeUnconditionalExpectations.wl

#### Setup and Context Loading

- Verify context is loaded
  ```wolfram
  MemberQ[$ContextPath,"FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"]
  ```

- Verify `uncondE` function is accessible
  ```wolfram
  Not[Names["*uncondE"]==={}]
  ```

#### uncondE Function Tests

- Verify uncondE gives correct moments
  ```wolfram
  And@@{
    uncondE[pi[t],modNRC]===mup,
    uncondE[sg[t],modNRC]===Esg,
    Simplify[uncondE[pi[t]sg[t],modNRC]]===Simplify[Esg*mup]
  }
  ```


---

### CreateEulerEq.wl

- Symbol `eulereq` should exist
  ```
  Not[Names["*eulereq"]==={}]
  ```

- Euler equations are linear in state variables
  ```
  And@@(Flatten@{
    (Max@Keys@CoefficientRules[#,DeleteDuplicates@Cases[modBY["stateVars"][t],_Symbol[t]^p_.,Infinity]]==1)&/@ee[modBY],
    (Max@Keys@CoefficientRules[#,DeleteDuplicates@Cases[modNRC["stateVars"][t],_Symbol[t]^p_.,Infinity]]==1)&/@ee[modNRC]
  })
  ```

- Euler equations contain all expected coefficients
  ```
  And@@Flatten@{
    Table[(Not@FreeQ[eeAll[[;;,1]][[n]],#]&/@coeffWcAll[[n]]),{n,1,Length[mods]}],
    Table[(Not@FreeQ[eeAll[[;;,2]][[n]],#]&/@coeffPdAll[[n]]),{n,1,Length[mods]}]
  }
  ```


---

### CreateMomentsDatabase.wl

- All computed moments evaluate to numeric values after parameter substitution
  ```wolfram
  And @@ {
    And @@ (NumberQ /@ (Flatten@testMomentsN)),
    And @@ (NumberQ /@ (Flatten@testMomentsOneStockN)),
    And @@ (NumberQ /@ (Flatten@testMomentsTwoStocksN))
  }
  ```


---

### SolveEulerEq.wl

#### Coefficient Validation

- A and B coefficients have expected structure and are numeric
  ```wolfram
  coeffsQWcRules[wcRulesFirst[resWc]]
  coeffsQPdRules[coeffsPd]
  ```

#### Bond Coefficient Tests

- Real and nominal bond coefficients have expected structure
  ```wolfram
  And @@ {
    ListQ[solBond] && solBond =!= {},
    ListQ[solNomBond] && solNomBond =!= {},
    And @@ (coeffsQBondRules[Normal[#], maxMaturity] & /@ solBond),
    And @@ (coeffsQNomBondRules[Normal[#], maxMaturity] & /@ solNomBond)
  }
  ```

- Changed parameters produce different bond coefficients
  ```wolfram
  And @@ {
    Not[solBond === solBondNew],
    Not[solNomBond === solNomBondNew]
  }
  ```


---

## Tools

### NiceOutput.wl

- Context is in `$ContextPath`
  ```
  MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]
  ```

- Symbol `info` can be found
  ```
  Not[Names["*info"] === {}]
  ```

- `info` returns correctly formatted model information table
  ```
  myModelsInfo = PacletizedResourceFunctions`SetSymbolsContext@info[msp];
  And @@ {
    Head[myModelsInfo] === Column,
    Head[myModelsInfo[[1]]] === List,
    Head[myModelsInfo[[1,1]]] === OpenerView
  }
  ```


---

### TimeAggregation.wl

- Context is loaded and on $ContextPath
  ```wolfram
  MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"]
  ```

- Private symbol `growth` is accessible
  ```wolfram
  Not[Names["*growth"] === {}]
  ```

#### Tests for `growth` Function

- growth with default parameters returns identity
  ```wolfram
  growth[dc, t] == dc[t]
  growth[dc, t, "TimeAggregation" -> 1, "numPeriods" -> 1] == dc[t]
  ```

- TimeAggregation=3 produces tent-shaped coefficients
  ```wolfram
  growth[dc, t, "TimeAggregation" -> 3, "numPeriods" -> 1] ==
    1/3 (dc[-4 + t] + 2 dc[-3 + t] + 3 dc[-2 + t] + 2 dc[-1 + t] + dc[t])
  ```


---

### ToNumber.wl

#### Setup and Dependencies

- Load required packages
  ```wolfram
  Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`"];
  Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeConditionalExpectations`"];
  Needs["FernandoDuarte`LongRunRisk`Tools`TimeAggregation`"];
  Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
  ```

#### toNum Function Tests

- `toNum[thisModel]` returns a Function
  ```wolfram
  Head@toNum[thisModel] === Function
  ```

- Numerical evaluation of expressions
  ```wolfram
  NumericQ /@ Flatten@{
    ((e1//tn)//.numModel),
    (((uncondE/@e1)//tn)//.numModel),
    (((ev[#,t-1]&/@e1)//tn)//.numModel)
  }
  ```

#### processNewParameters Function Tests

- Old and new parameters are equal
  ```wolfram
  And@@Simplify@{
    And@@(NumberQ/@Values@procP),
    (Sort@Keys@procP) === (Sort@Keys@newP),
    SubsetQ[Keys@p, Keys@procP]
  }
  ```

- psi=1 in new parameters aborts
  ```wolfram
  checkAbrt[processNewParameters[{delta->0.9, psi->1}, p]]
  ```

- Solve for theta from {gamma, psi}
  ```wolfram
  RealAbs[(theta/.procP)-(-3)] < $MachineEpsilon
  ```


---

