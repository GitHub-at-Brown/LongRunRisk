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

- Models and modelsP are associations, and each model is also an association
  ```wolfram
  And@@{
    AllTrue[modelsTest,AssociationQ],
    AllTrue[modelsP,AssociationQ],
    AllTrue[modelsTest[#]&/@Keys[modelsTest],AssociationQ],
    AllTrue[modelsP[#]&/@Keys[modelsP],AssociationQ]
  }
  ```

#### Context Verification for Variables

For exogenous variables (all in `"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"`):

- Verify context for `"stateVars"`, `"modelAssumptions"`, `"exogenousEq"`, and `"endogenousEq"`
  ```wolfram
  If[longTest,
    And@@{
      And@@((And@@((#==="FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`")&/@(Context/@Cases[modelsP[#]["stateVars"],var_Symbol?(MemberQ[StringDrop[#,-2]&/@FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars,SymbolName[#]]&)[__]:>var,Infinity])))&/@Keys[modelsP]),
      And@@((And@@((#==="FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`")&/@(Context/@Cases[modelsP[#]["modelAssumptions"],var_Symbol?(MemberQ[StringDrop[#,-2]&/@FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars,SymbolName[#]]&)[__]:>var,Infinity])))&/@Keys[modelsP]),
      And@@((And@@((#==="FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`")&/@(Context/@Cases[modelsP[#]["exogenousEq"],var_Symbol?(MemberQ[StringDrop[#,-2]&/@FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars,SymbolName[#]]&)[__]:>var,Infinity])))&/@Keys[modelsP]),
      And@@((And@@((#==="FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`")&/@(Context/@Cases[modelsP[#]["endogenousEq"],var_Symbol?(MemberQ[StringDrop[#,-2]&/@FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars,SymbolName[#]]&)[__]:>var,Infinity])))&/@Keys[modelsP])
    },
    True
  ]
  ```

For shocks (all in `"FernandoDuarte`LongRunRisk`Model`Shocks`"`):

- Verify context for shocks in `"stateVars"`, `"modelAssumptions"`, `"exogenousEq"`, and `"endogenousEq"`
  ```wolfram
  If[longTest,
    And@@{
      And@@((And@@((#==="FernandoDuarte`LongRunRisk`Model`Shocks`")&/@(Context/@Cases[modelsP[#]["stateVars"],var_Symbol?(MatchQ[SymbolName[#],"eps"]&)[__][__]:>var,Infinity])))&/@Keys[modelsP]),
      And@@((And@@((#==="FernandoDuarte`LongRunRisk`Model`Shocks`")&/@(Context/@Cases[modelsP[#]["modelAssumptions"],var_Symbol?(MatchQ[SymbolName[#],"eps"]&)[__][__]:>var,Infinity])))&/@Keys[modelsP]),
      And@@((And@@((#==="FernandoDuarte`LongRunRisk`Model`Shocks`")&/@(Context/@Cases[modelsP[#]["exogenousEq"],var_Symbol?(MatchQ[SymbolName[#],"eps"]&)[__][__]:>var,Infinity])))&/@Keys[modelsP]),
      And@@((And@@((#==="FernandoDuarte`LongRunRisk`Model`Shocks`")&/@(Context/@Cases[modelsP[#]["endogenousEq"],var_Symbol?(MatchQ[SymbolName[#],"eps"]&)[__][__]:>var,Infinity])))&/@Keys[modelsP])
    },
    True
  ]
  ```

For parameters (all in `"FernandoDuarte`LongRunRisk`Model`Parameters`"`):

- Verify context for parameters in `"parameters"`, `"stateVars"`, `"modelAssumptions"`, `"exogenousEq"`, and `"endogenousEq"`
  ```wolfram
  If[longTest,
    And@@{
      And@@((And@@((#==="FernandoDuarte`LongRunRisk`Model`Parameters`")&/@(Context/@Cases[modelsP[#]["parameters"],var_Symbol?(MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters,SymbolName[#]]&):>var,Infinity])))&/@Keys[modelsP]),
      And@@((And@@((#==="FernandoDuarte`LongRunRisk`Model`Parameters`")&/@(Context/@Cases[modelsP[#]["stateVars"],var_Symbol?(MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters,SymbolName[#]]&):>var,Infinity])))&/@Keys[modelsP]),
      And@@((And@@((#==="FernandoDuarte`LongRunRisk`Model`Parameters`")&/@(Context/@Cases[modelsP[#]["modelAssumptions"],var_Symbol?(MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters,SymbolName[#]]&):>var,Infinity])))&/@Keys[modelsP]),
      And@@((And@@((#==="FernandoDuarte`LongRunRisk`Model`Parameters`")&/@(Context/@Cases[modelsP[#]["exogenousEq"],var_Symbol?(MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters,SymbolName[#]]&):>var,Infinity])))&/@Keys[modelsP]),
      And@@((And@@((#==="FernandoDuarte`LongRunRisk`Model`Parameters`")&/@(Context/@Cases[modelsP[#]["endogenousEq"],var_Symbol?(MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters,SymbolName[#]]&):>var,Infinity])))&/@Keys[modelsP])
    },
    True
  ]
  ```

For endogenous variables (all in `"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"`):

- Verify context for endogenous variables in `"modelAssumptions"` and `"endogenousEq"`
  ```wolfram
  If[longTest,
    And@@{
      And@@((And@@((#==="FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`")&/@(Context/@Cases[modelsP[#]["modelAssumptions"],var_Symbol?(MemberQ[StringDrop[#,-2]&/@FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars,SymbolName[#]]&)[__]:>var,Infinity])))&/@Keys[modelsP]),
      And@@((And@@((#==="FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`")&/@(Context/@Cases[modelsP[#]["endogenousEq"],var_Symbol?(MemberQ[StringDrop[#,-2]&/@FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars,SymbolName[#]]&)[__]:>var,Infinity])))&/@Keys[modelsP])
    },
    True
  ]
  ```

For coefficients (wc, pd, bond ratios in `"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"`):

- Verify context for coefficient symbols
  ```wolfram
  If[longTest,
    coefs=Alternatives@@SymbolName/@{FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc, Head@FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd, Head@FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb, Head@FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb};
    And@@((#==="FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`")&/@Flatten@(Cases[modelsP[#]["modelAssumptions"],(var_Symbol?(MatchQ[SymbolName[#],coefs]&)|var_Symbol?(MatchQ[SymbolName[#],coefs]&)[__]):>Context[var],Infinity]&/@Keys[modelsP])),
    True
  ]
  ```

#### Variable Exclusion Tests

- `"stateVars"` and `"exogenousEq"` should not contain endogenous variables
  ```wolfram
  And@@{
    And@@(MatchQ[{},#]&/@(Cases[modelsP[#]["stateVars"],var_Symbol?(MemberQ[StringDrop[#,-2]&/@FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars,SymbolName[#]]&)[__]:>var,Infinity]&/@Keys[modelsP])),
    And@@(MatchQ[{},#]&/@(Cases[modelsP[#]["exogenousEq"],var_Symbol?(MemberQ[StringDrop[#,-2]&/@FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars,SymbolName[#]]&)[__]:>var,Infinity]&/@Keys[modelsP]))
  }
  ```

#### Model Key and Shortname Preservation

- Keys and shortname are preserved after processing
  ```wolfram
  And@@{
    SubsetQ[Keys[modelsTest], Keys[modelsP]],
    SubsetQ[modelsTest[#]["shortname"]&/@Keys[modelsTest], modelsP[#]["shortname"]&/@Keys[modelsP]]
  }
  ```

#### StateVars Function Structure

- `stateVars` are functions of one variable (time)
  ```wolfram
  And@@{
    And@@(MatchQ[Function,#]&/@(Head/@((modelsP[#]["stateVars"])&/@Keys[modelsP]))),
    And@@(MatchQ[List,#]&/@(Head/@((modelsP[#]["stateVars"][t])&/@Keys[modelsP]))),
    And@@(MatchQ[1,#]&/@(Length/@((modelsP[#]["stateVars"][[1]])&/@Keys[modelsP]))),
    And@@(MatchQ["t",#]&/@((SymbolName@@modelsP[#]["stateVars"][[1]])&/@Keys[modelsP])),
    ((modelsP[#]["stateVars"][FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t])&/@Keys[modelsP])===((modelsTest[#]["stateVars"])&/@Keys[modelsP])
  }
  ```

#### Numeric Field Tests

- `numStocks` is a number
  ```wolfram
  And@@(NumberQ/@(modelsP[#]["numStocks"]&/@(Keys@modelsP)))
  ```

#### Hand-Written Expression Comparison (NRC Model)

- Compare processed model output to known correct expressions
  ```wolfram
  modelPNRC=modelsP["NRC"];
  And@@{
    (pi[myContext`t]/.Normal@modelPNRC["exogenousEq"])===(FernandoDuarte`LongRunRisk`Model`Parameters`mup+FernandoDuarte`LongRunRisk`Model`Parameters`rhop (-FernandoDuarte`LongRunRisk`Model`Parameters`mup+FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[-1+myContext`t])+FernandoDuarte`LongRunRisk`Model`Parameters`xip FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][-1+myContext`t]+FernandoDuarte`LongRunRisk`Model`Parameters`phip FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][myContext`t]),
    (eps["dc"][t]/.modelPNRC["exogenousEq"])===eps["dc"][t],
    (dd[t,i]/.Normal@modelPNRC["exogenousEq"])===(FernandoDuarte`LongRunRisk`Model`Parameters`mud[i]+(-FernandoDuarte`LongRunRisk`Model`Parameters`mup+FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[-1+t]) FernandoDuarte`LongRunRisk`Model`Parameters`rhodp[i]+FernandoDuarte`LongRunRisk`Model`Parameters`phidc[i] FernandoDuarte`LongRunRisk`Model`Shocks`eps["dc"][t]+FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[-2+t] FernandoDuarte`LongRunRisk`Model`Parameters`xid[i] FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][-1+t]),
    (wc[t]/.Normal@modelPNRC["endogenousEq"])===(FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[0]+FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[1] (-FernandoDuarte`LongRunRisk`Model`Parameters`mup+FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[t])+FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[4] (-FernandoDuarte`LongRunRisk`Model`Parameters`Esg+FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[t])+FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[5] (-FernandoDuarte`LongRunRisk`Model`Parameters`Esg^2-FernandoDuarte`LongRunRisk`Model`Parameters`phig^2/(1-FernandoDuarte`LongRunRisk`Model`Parameters`rhog^2)+FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[t]^2)+FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[3] FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][t]+FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[2] FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[-1+t] FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][t]),
    (pd[t,i]/.Normal@modelPNRC["endogenousEq"])===(FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[i][0]+(-FernandoDuarte`LongRunRisk`Model`Parameters`mup+FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`pi[t]) FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[i][1]+(-FernandoDuarte`LongRunRisk`Model`Parameters`Esg+FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[t]) FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[i][4]+(-FernandoDuarte`LongRunRisk`Model`Parameters`Esg^2-FernandoDuarte`LongRunRisk`Model`Parameters`phig^2/(1-FernandoDuarte`LongRunRisk`Model`Parameters`rhog^2)+FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[t]^2) FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[i][5]+FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`sg[-1+t] FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[i][2] FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][t]+FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B[i][3] FernandoDuarte`LongRunRisk`Model`Shocks`eps["pi"][t]),
    (bondexcret[t,i]/.Normal@modelPNRC["endogenousEq"])===(FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondret[t,i,1]-FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bondyield[-1+t,1]),
    (bondexcret[t,i]/.Normal@modelPNRC["endogenousEq"]/.Normal@modelPNRC["endogenousEq"])===(FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[-1+t,1]-FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[-1+t,i]+FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`bond[t,-1+i])
  }
  ```

#### Endogenous Variable Full Expansion Tests

For `wc[t]` after repeated substitution:

- Endogenous variables mapped repeatedly using `"endogenousEq"` have no endogenous variables and correct contexts
  ```wolfram
  And@@{
    And@@(MatchQ[{},#]&/@(Cases[wc[t]//.Normal@modelsP[#]["endogenousEq"],var_Symbol?(MemberQ[StringDrop[#,-2]&/@FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars,SymbolName[#]]&)[__]:>var,Infinity]&/@Keys[modelsP])),
    And@@(MatchQ[#,"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&/@(Flatten@(Cases[wc[t]//.Normal@modelsP[#]["endogenousEq"],var_Symbol?(MemberQ[StringDrop[#,-2]&/@FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars,SymbolName[#]]&)[__]:>Context@var,Infinity]&/@Keys[modelsP]))),
    And@@(MatchQ[#,"FernandoDuarte`LongRunRisk`Model`Parameters`"]&/@(Flatten@(Cases[wc[t]//.Normal@modelsP[#]["endogenousEq"],var_Symbol?(MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters,SymbolName[#]]&):>Context@var,Infinity]&/@Keys[modelsP]))),
    And@@(MatchQ[#,"FernandoDuarte`LongRunRisk`Model`Shocks`"]&/@(Flatten@(Cases[wc[t]//.Normal@modelsP[#]["endogenousEq"],var_Symbol?(MatchQ[SymbolName[#],"eps"]&)[__][__]:>Context@var,Infinity]&/@Keys[modelsP])))
  }
  ```

For `bondexcret[t,i]` after repeated substitution:

- Endogenous variables mapped repeatedly using `"endogenousEq"` have no endogenous variables and correct contexts
  ```wolfram
  And@@{
    And@@(MatchQ[{},#]&/@(Cases[bondexcret[t,i]//.Normal@modelsP[#]["endogenousEq"],var_Symbol?(MemberQ[StringDrop[#,-2]&/@FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars,SymbolName[#]]&)[__]:>var,Infinity]&/@Keys[modelsP])),
    And@@(MatchQ[#,"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]&/@(Flatten@(Cases[bondexcret[t,i]//.Normal@modelsP[#]["endogenousEq"],var_Symbol?(MemberQ[StringDrop[#,-2]&/@FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars,SymbolName[#]]&)[__]:>Context@var,Infinity]&/@Keys[modelsP]))),
    And@@(MatchQ[#,"FernandoDuarte`LongRunRisk`Model`Parameters`"]&/@(Flatten@(Cases[bondexcret[t,i]//.Normal@modelsP[#]["endogenousEq"],var_Symbol?(MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters,SymbolName[#]]&):>Context@var,Infinity]&/@Keys[modelsP]))),
    And@@(MatchQ[#,"FernandoDuarte`LongRunRisk`Model`Shocks`"]&/@(Flatten@(Cases[bondexcret[t,i]//.Normal@modelsP[#]["endogenousEq"],var_Symbol?(MatchQ[SymbolName[#],"eps"]&)[__][__]:>Context@var,Infinity]&/@Keys[modelsP])))
  }
  ```

#### Equation Key Structure

- Keys in `exogenousEq` and `endogenousEq` are `PatternTest` expressions
  ```wolfram
  And@@{
    AllTrue[Head/@(Keys@modelsP["BKY"]["exogenousEq"]), MatchQ[#,PatternTest]&],
    AllTrue[Head/@(Keys@modelsP["BKY"]["endogenousEq"]), MatchQ[#,PatternTest]&]
  }
  ```

#### Equation Evaluation Tests

- `exogenousEq` and `endogenousEq` evaluate expressions that are exogenous or endogenous variables
  ```wolfram
  And@@{
    And@@(Not/@((Head[dc[t]]===Head[(dc[t]/.Normal[Join[modelsP[#]["exogenousEq"],modelsP[#]["endogenousEq"]]])])&/@Keys[modelsP])),
    And@@(Not/@((Head[dd[t,i]]===Head[(dd[t,i]/.Normal[Join[modelsP[#]["exogenousEq"],modelsP[#]["endogenousEq"]]])])&/@Keys[modelsP])),
    And@@(Not/@((Head[wc[t]]===Head[(wc[t]/.Normal[Join[modelsP[#]["exogenousEq"],modelsP[#]["endogenousEq"]]])])&/@Keys[modelsP])),
    And@@(Not/@((Head[sdf[t]]===Head[(sdf[t]/.Normal[Join[modelsP[#]["exogenousEq"],modelsP[#]["endogenousEq"]]])])&/@Keys[modelsP])),
    And@@(Not/@((Head[bondyield[t]]===Head[(bondyield[t]/.Normal[Join[modelsP[#]["exogenousEq"],modelsP[#]["endogenousEq"]]])])&/@Keys[modelsP]))
  }
  ```

- `exogenousEq` and `endogenousEq` do not evaluate expressions that are neither exogenous nor endogenous variables
  ```wolfram
  And@@{
    And@@((Head[notVar[t]]===Head[(notVar[t]/.Normal[Join[modelsP[#]["exogenousEq"],modelsP[#]["endogenousEq"]]])])&/@Keys[modelsP])
  }
  ```

#### Model Renaming Tests

- Shortname different from model key is handled correctly
  ```wolfram
  If[longTest,
    modelBY=modelsTest["BY"];
    modelBKY=modelsTest["BKY"];
    modelBKYP=processModels[<|"BKY"->modelBKY|>];
    modelBYP=processModels[<|"BY"->modelBY|>];
    newModels=<|"myModel"->modelBKY,"BY"->modelBY|>;
    newModelsSameName=<|"BY"->modelBY|>;
    newModelsRename=<|"myModel"->modelBY|>;
    newModelsP=processModels[newModels];
    newModelsSameNameP=processModels[newModelsSameName];
    newModelsRenameP=processModels[newModelsRename];
    And@@{
      KeyDrop[#,"coeffsSolution"]&@newModelsP["myModel"]===KeyDrop[#,"coeffsSolution"]&@modelBKYP["BKY"],
      KeyDrop[#,"coeffsSolution"]&@newModelsP["BY"]===KeyDrop[#,"coeffsSolution"]&@modelBYP["BY"],
      KeyDrop[#,"coeffsSolution"]&@newModelsSameNameP["BY"]===KeyDrop[#,"coeffsSolution"]&@modelBYP["BY"],
      KeyDrop[#,"coeffsSolution"]&@newModelsRenameP["myModel"]===KeyDrop[#,"coeffsSolution"]&@modelBYP["BY"]
    },
    True
  ]
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

## WLT Verification Results

**File Verified**: `/Users/fduarte/Library/CloudStorage/Dropbox-Personal/MyPackages/LongRunRisk-clean-up/Tests/Model/ProcessModels.wlt`

**Verification Date**: 2026-01-05

### Compliance Table

| Guideline | Status | Notes |
|-----------|--------|-------|
| Use `TestCreate` exclusively (no `VerificationTest`) | PASS | All 22 tests use `TestCreate` |
| Third argument for expected messages | PASS | All tests include `{}` for expected messages |
| TestID format `"SymbolName-Scenario-Behavior"` | PASS | All TestIDs follow the convention (e.g., `"processModels-Keys-AreStrings"`) |
| `BeginTestSection` names file being tested | PASS | Uses `"Kernel/Model/ProcessModels.wl Tests"` |
| Context isolation with `Begin`/`End` | PASS | Uses `Begin["FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels`"]` |
| Load shared helpers via `$TestFileName` | PASS | Uses `Get[FileNameJoin[{DirectoryName[$TestFileName, 2], "Common.wl"}]]` |
| `Needs` statements at beginning | PASS | All 6 `Needs` statements placed after `Begin` |
| Only load contexts actually used | PASS | All loaded contexts are used in tests |
| No `Quiet` in test assertions | PASS | No `Quiet` calls found |
| No `VerificationTest` usage | PASS | Zero occurrences |
| Avoid `TimeConstraint`/`MemoryConstraint`/`MetaInformation` | PASS | None used |
| One assertion per behavior | PASS | Each test focuses on a single behavior |
| Proper `EndTestSection[]` closure | PASS | File ends with `End[]` and `EndTestSection[]` |
| No paclet initialization boilerplate | PASS | No `PacletDirectoryLoad` or complex path-resolution blocks |

### Detailed Analysis

#### Structure (Excellent)
- File follows the standard WLT structure with proper sectioning
- Test context is properly isolated in `FernandoDuarte`LongRunRisk`Tests`Model`ProcessModels``
- Clear subsection organization using Wolfram notebook-style comments

#### Package Loading (Correct)
- All required packages loaded via `Needs`:
  - `FernandoDuarte`LongRunRisk`Model`ProcessModels`` (primary target)
  - `FernandoDuarte`LongRunRisk`Model`Catalog``
  - `FernandoDuarte`LongRunRisk`Model`ExogenousEq``
  - `FernandoDuarte`LongRunRisk`Model`EndogenousEq``
  - `FernandoDuarte`LongRunRisk`Model`Parameters``
  - `FernandoDuarte`LongRunRisk`Model`Shocks``
  - `PacletizedResourceFunctions``

#### TestID Quality (Good)
All TestIDs follow the `"SymbolName-Scenario-Behavior"` pattern:
- `processModels-Keys-AreStrings`
- `processModels-StringFields-AreStrings`
- `processModels-Parameters-EvaluateToNumbers`
- `processModels-StateVars-AreFunction`
- `processModels-Coefficients-AB-AreNumeric`
- etc.

#### Test Coverage
- Basic structure tests (5 tests)
- StateVars function structure tests (5 tests)
- Numeric field tests (1 test)
- Variable exclusion tests (2 tests)
- Model key/shortname preservation tests (1 test)
- Equation key structure tests (2 tests)
- Equation evaluation tests (2 tests)
- Coefficient solution tests (2 tests)

**Total: 22 tests**

### Minor Observations

1. **Private symbol access**: Test on line 158 uses full qualification for private symbol `FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t` - this is correct per guidelines when accessing private symbols.

2. **Test setup uses global variables**: `$modelsTest`, `$modelsP`, and `endoVarBaseNames` are defined in setup section and reused across tests. This is acceptable as they are prefixed with `$` indicating test-scoped variables.

3. **Resource loading pattern**: The file uses `Get[Get[FileNameJoin[...]]]` pattern to load Models.wl, which is a valid approach for accessing paclet resources.

### Summary

**Overall Compliance: FULLY COMPLIANT**

The WLT file `Tests/Model/ProcessModels.wlt` fully adheres to the wolfram-testing skill guidelines. All 14 compliance items pass. The file demonstrates best practices for Wolfram Language unit testing including:
- Exclusive use of `TestCreate`
- Proper context isolation
- Clean package loading without suppression
- Descriptive TestID naming
- No use of deprecated or discouraged patterns
