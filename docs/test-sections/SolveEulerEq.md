### SolveEulerEq.wl

This section tests the `ComputationalEngine`SolveEulerEq`` module, which solves Euler equations to compute coefficients for wealth-consumption ratios, price-dividend ratios, and bond prices across different long-run risk models (BY, BKY, NRC, DES, NRCStochVol).

---

## Setup and Configuration

- **Test mode toggle**: Controls fast/partial vs slow/full coverage
```wolfram
longTest = False; (*fast and partial coverage (False) or slow and full coverage (True)*)
True
```

- **Context and dependencies loading**
```wolfram
With[{context=context},
  Needs@context;
  Needs@"PacletizedResourceFunctions`";
  $ContextPath = DeleteDuplicates@Prepend[$ContextPath,"FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`"];
  True
];
```

---

## Model Loading and Helper Functions

- **Load models and suppress messages**
```wolfram
Off[General::stop];
If[Not@longTest, Off[FindRoot::cvmit]];

FernandoDuarte`LongRunRisk`Models =
  Get@Get[FileNameJoin[{"FernandoDuarte/LongRunRisk", "Models.wl"}]];

msp = FernandoDuarte`LongRunRisk`Models;
modBY = msp["BY"];
modBKY = msp["BKY"];
modNRC = msp["NRC"];
modDES = msp["DES"];
modNRCStochVol = msp["NRCStochVol"];

mods = If[longTest,
  {modBY, modBKY, modNRC, modDES, modNRCStochVol},
  {modBKY, modDES}
];
```

- **Function references for testing**
```wolfram
updateCoeffs =
  FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`updateCoeffs;
updateCoeffsSol =
  FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol;
loadModelKernels =
  FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`loadModelKernels;
updateCoeffsBond =
  FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsBond;
```

---

## Coefficient Validation Helper

- **coeffsQ**: Validates coefficient structure (flat list of rules OR Association)
```wolfram
coeffsQ[solIn_, coeffName_, numStateVars_, numAssets_: 0, bond_: 0] := Module[
  {sol = solIn},
  sol = Which[
    AssociationQ[sol], Normal[sol],
    True, sol
  ];
  If[! ListQ[sol], Return[False]];
  And @@ {
    If[numAssets == 0,
      (Sort @ Cases[Keys /@ sol, coeffName[i_Integer] :> i]) === (Range[numStateVars + 1] - 1),
      (Sort @ Tuples[{Range[numAssets] - bond, Range[numStateVars + 1] - 1}]) ===
        (Sort @ Cases[Keys /@ sol, coeffName[i_Integer][j_Integer] :> {i, j}])
    ],
    And @@ (MatchQ[#, coeffName] & /@ Cases[Keys /@ sol, var_[i_Integer][j_Integer] :> var]),
    And @@ (Map[Function[# === Context[coeffName]],
      Cases[Keys /@ sol, var_[i_Integer][j_Integer] :> Context[var]]
    ]),
    If[bond == 1,
      And @@ (Or[NumberQ[#], MatchQ[#, _Missing]] & /@ (Values /@ sol)),
      And @@ (NumberQ /@ (Values /@ sol))
    ]
  }
];
```

---

## Hierarchical Output Extractors

- **firstASol**: Extract first A solution from hierarchical structure
```wolfram
firstASol[res_] := If[
  ListQ[res] && res =!= {} && AssociationQ[First[res]] && KeyExistsQ[First[res], "A"],
  First[res],
  $Failed
];
```

- **wcRulesFirst**: Extract wealth-consumption rules from first solution
```wolfram
wcRulesFirst[res_] := Module[{a = firstASol[res]},
  If[a === $Failed, $Failed, Normal[a["A"]]]
];
```

- **pdRulesFirstBundle**: Extract price-dividend rules for all stocks
```wolfram
pdRulesFirstBundle[res_, numStocks_] := Module[{a = firstASol[res], stocks},
  If[a === $Failed, Return[$Failed]];
  stocks = a["Stocks"];
  If[! AssociationQ[stocks] || stocks === <||>, Return[{}]];
  Flatten@Table[
    If[KeyExistsQ[stocks, j] && ListQ[stocks[j]] && stocks[j] =!= {},
      Normal[stocks[j][[1, "B"]]],
      {}
    ],
    {j, 1, numStocks}
  ]
];
```

---

## Convenience Coefficient Validators

- **Model-specific coefficient validators** (defined per model in loop)
```wolfram
numStateVars = Length[thisModel["stateVars"][t]];
numStocks = thisModel["numStocks"];

coeffsQWcRules[solRules_] :=
  coeffsQ[solRules, FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc, numStateVars];
coeffsQPdRules[solRules_] :=
  coeffsQ[solRules, Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd, numStateVars, numStocks];
coeffsQBondRules[solRules_, maxMaturity_] :=
  coeffsQ[solRules, Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb, numStateVars, maxMaturity + 1, 1];
coeffsQNomBondRules[solRules_, maxMaturity_] :=
  coeffsQ[solRules, Head @ FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb, numStateVars, maxMaturity + 1, 1];
```

---

## Wealth-Consumption Ratio Tests

### updateCoeffs vs updateCoeffsSol Equivalence

- **Test**: Both wrapper functions produce identical A coefficient rules
```wolfram
optsWc = {"FindRootOptions" -> {"MaxIterations" -> 100}};
resWc = Quiet@updateCoeffs[thisModel, Sequence @@ optsWc];
resWcSol = Quiet@updateCoeffsSol[thisModel, savedKernels, {}, {}, Sequence @@ optsWc];

And @@ {
  ListQ[resWc] && resWc =!= {},
  ListQ[resWcSol] && resWcSol =!= {},
  wcRulesFirst[resWc] =!= $Failed,
  wcRulesFirst[resWcSol] =!= $Failed,
  wcRulesFirst[resWc] === wcRulesFirst[resWcSol],
  coeffsQWcRules[wcRulesFirst[resWc]]
}
```

### UpdatePd Option Tests

- **Test**: UpdatePd=False returns only wealth-consumption coefficients
```wolfram
trueA0=thisModel["coeffsSolutionN"][[1]]["A"][A[0]];
intervalRealA0=thisModel["coeffsSolutionN"][[1]]["IntervalA"];
Ewc0 = Mean[{trueA0,Mean[intervalRealA0]}];

trueB0=thisModel["coeffsSolutionN"][[1]]["Stocks",1][[1]]["B"][B[1][0]];
intervalRealB0=thisModel["coeffsSolutionN"][[1]]["Stocks",1][[1]]["IntervalB"];
Epd0 = Mean[{trueB0,Mean[intervalRealB0]}];

resNoPd = Quiet@updateCoeffs[
  thisModel,
  "UpdatePd" -> False,
  "initialGuess" -> <|"Ewc" -> {Ewc0}, "Epd" -> {{Epd0}}|>
];
coeffsQWcRules[wcRulesFirst[resNoPd]]
```

- **Test**: UpdatePd=True returns both WC and PD coefficients
```wolfram
resWcPd = Quiet@updateCoeffs[
  thisModel,
  "UpdatePd" -> True,
  "initialGuess" -> <|"Ewc" -> {Ewc0}, "Epd" -> {{Epd0}}|>
];

coeffsWc = wcRulesFirst[resWcPd];
coeffsPd = pdRulesFirstBundle[resWcPd, numStocks];

coeffsQWcRules[coeffsWc]
```

- **Test**: PD coefficients have expected structure
```wolfram
coeffsQPdRules[coeffsPd]
```

### Initial Guess Interval Forms

- **Test**: Different initial guess formats work correctly
```wolfram
And @@ {
  coeffsQWcRules[
    wcRulesFirst @ Quiet@updateCoeffs[thisModel, "initialGuess" -> <|"Ewc" -> intervalRealA0|>, Sequence @@ optsWc]
  ],
  coeffsQWcRules[
    wcRulesFirst @ Quiet@updateCoeffs[thisModel, "initialGuess" -> <|"Ewc" -> Append[Ewc0,trueA0]|>, Sequence @@ optsWc]
  ]
}
```

---

## Bond Coefficient Tests

### updateCoeffsBond Basic Tests

- **Test**: Real and nominal bond coefficients have expected structure
```wolfram
maxMaturity = 12;
wcCoeffSets = resWc[[All, "A"]];

solBond = updateCoeffsBond[
  thisModel["coeffsSolution"]["bond"],
  thisModel["params"],
  {},
  maxMaturity,
  wcCoeffSets
];
solNomBond = updateCoeffsBond[
  thisModel["coeffsSolution"]["nombond"],
  thisModel["params"],
  {},
  maxMaturity,
  wcCoeffSets
];

And @@ {
  ListQ[solBond] && solBond =!= {},
  ListQ[solNomBond] && solNomBond =!= {},
  And @@ (coeffsQBondRules[Normal[#], maxMaturity] & /@ solBond),
  And @@ (coeffsQNomBondRules[Normal[#], maxMaturity] & /@ solNomBond)
}
```

### Parameter Sensitivity Tests

- **Test**: Changed parameters produce different bond coefficients
```wolfram
newBondParams = {
  FernandoDuarte`LongRunRisk`Model`Parameters`psi ->
    (0.1 + (FernandoDuarte`LongRunRisk`Model`Parameters`psi /. thisModel["params"]))
};

resWcNewBondParams = Quiet@updateCoeffs[thisModel, savedKernels, newBondParams, {}, Sequence @@ optsWc];
wcCoeffSetsNew = resWcNewBondParams[[All, "A"]];

solBondNew = updateCoeffsBond[
  thisModel["coeffsSolution"]["bond"],
  thisModel["params"],
  newBondParams,
  maxMaturity,
  wcCoeffSetsNew
];
solNomBondNew = updateCoeffsBond[
  thisModel["coeffsSolution"]["nombond"],
  thisModel["params"],
  newBondParams,
  maxMaturity,
  wcCoeffSetsNew
];

And @@ {
  And @@ (coeffsQBondRules[Normal[#], maxMaturity] & /@ solBondNew),
  And @@ (coeffsQNomBondRules[Normal[#], maxMaturity] & /@ solNomBondNew),
  Not[solBond === solBondNew],
  Not[solNomBond === solNomBondNew]
}
```

### MaxMaturity Tests

- **Test**: Reduced maxMaturity produces correctly indexed coefficients
```wolfram
maxMaturity = 2;

solBond2 = updateCoeffsBond[
  thisModel["coeffsSolution"]["bond"],
  thisModel["params"],
  {},
  maxMaturity,
  wcCoeffSets
];
solNomBond2 = updateCoeffsBond[
  thisModel["coeffsSolution"]["nombond"],
  thisModel["params"],
  {},
  maxMaturity,
  wcCoeffSets
];

And @@ {
  And @@ (coeffsQBondRules[Normal[#], maxMaturity] & /@ solBond2),
  And @@ (coeffsQNomBondRules[Normal[#], maxMaturity] & /@ solNomBond2),
  And @@ (Range[0, maxMaturity] === (Sort @ DeleteDuplicates @ Cases[Keys @ #, x_[i_][j_] :> i]) & /@ solBond2),
  And @@ (Range[0, maxMaturity] === (Sort @ DeleteDuplicates @ Cases[Keys @ #, x_[i_][j_] :> i]) & /@ solNomBond2)
}
```

---

## Test Coverage Validation

- **Ensure no missing test indices**
```wolfram
noMissingTest = {};
Do[
  testNumber =
    Sort @ Cases[
      Keys @ SubValues @ outTests,
      Verbatim[HoldPattern][outTests[thisModel["shortname"]][i_Integer]] :> i
    ];
  AppendTo[noMissingTest, Range[0, Max[testNumber]] == testNumber];
  ,
  {thisModel, mods}
];

out = And @@ {
  And @@ noMissingTest,
  And @@ Values @ SubValues @ outTests
};
```

---

## Legacy/Alternative Test Block (Commented)

The file also contains a more detailed legacy test block with additional coverage:

### Argument Parsing Tests (longTest only)

- **Test**: Positional arguments parse correctly
```wolfram
newParameters={delta->0.99};
guessCoeffsSolution={A[0]->4.6};
And@@{
  updateCoeffs[thisModel]==updateCoeffs[thisModel,{}]==updateCoeffs[thisModel,{},{}]==updateCoeffs[thisModel,{},{},{}]==updateCoeffsSol[thisModel,{},{}],
  updateCoeffs[thisModel,newParameters]==updateCoeffs[thisModel,newParameters,{}]==updateCoeffs[thisModel,newParameters,{},{}]==updateCoeffsSol[thisModel,newParameters,{}],
  updateCoeffs[thisModel,newParameters, guessCoeffsSolution]==updateCoeffs[thisModel,newParameters, guessCoeffsSolution,{},{}]==updateCoeffsSol[thisModel,newParameters, guessCoeffsSolution]
}
```

### Options Configuration

- **Option combinations for testing**
```wolfram
opts={
  {"initialGuess" -> <|"Ewc"->{4.6},"Epd"->{{5.6}}|>},
  {"PrintResidualsNorm"->False},
  {"MaxIterations"->1},
  {"FindRootOptions"->{"MaxIterations"->1}},
  {"initialGuess" -> <|"Ewc"->{4.6},"Epd"->{{5.6}}|>,"PrintResidualsNorm"->False},
  {"initialGuess" -> <|"Ewc"->{4.6},"Epd"->{{5.6}}|>,"PrintResidualsNorm"->False,"MaxIterations"->1},
  {"initialGuess" -> <|"Ewc"->{4.6},"Epd"->{{5.6}}|>,"MaxIterations"->1},
  {"PrintResidualsNorm"->False,"MaxIterations"->1},
  {"initialGuess" -> <|"Ewc"->{4.6},"Epd"->{{5.6}}|>,"PrintResidualsNorm"->False,"FindRootOptions"->{WorkingPrecision->$MachinePrecision}},
  (* ... more combinations ... *)
};
```

### Wrapper Function Equivalence

- **Test**: updateCoeffs, updateCoeffsSol, and updateCoeffsWc produce same results
```wolfram
optsWc={"MaxIterations"->100};
solWc=updateCoeffs[thisModel,optsWc];

(solWc==updateCoeffsSol[thisModel,{},{},optsWc]==updateCoeffsWc[thisModel["coeffsSolution"]["wc"],thisModel["params"],{},optsWc])
```

### Initial Guess Sensitivity (longTest only)

- **Test**: One iteration stays close to initial guess
```wolfram
solWc1=updateCoeffs[thisModel, "MaxIterations"->1,"initialGuess" -> <|"Ewc"->{3}|>];
solWc2=updateCoeffs[thisModel, "MaxIterations"->1,"initialGuess" -> <|"Ewc"->{1}|>];
(FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[0]/.solWc1) > (FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A[0]/.solWc2)
```

### MaxIterations Option Tests (longTest only)

- **Test**: MaxIterations controls iteration count
```wolfram
m1=Block[{$MessagePrePrint=Sow,$MessageList={}},Reap[Module[{},updateCoeffs[thisModel,"MaxIterations"->1,"initialGuess" -> <|"Ewc"->{4}|>];];$MessageList]];
m2=Block[{$MessagePrePrint=Sow,$MessageList={}},Reap[Module[{},updateCoeffs[thisModel,"MaxIterations"->3,"initialGuess" -> <|"Ewc"->{4}|>];];$MessageList]];
And@@{
  ReleaseHold@Last@m1=={{1}},
  ReleaseHold@Last@m2=={{3}}
}
```

- **Test**: FindRootOptions takes precedence over direct MaxIterations
```wolfram
m1=Block[{$MessagePrePrint=Sow,$MessageList={}},Reap[Module[{},updateCoeffs[thisModel,"MaxIterations"->3,"FindRootOptions"->{"MaxIterations"->1},"initialGuess" -> <|"Ewc"->{4}|>];];$MessageList]];
m2=Block[{$MessagePrePrint=Sow,$MessageList={}},Reap[Module[{},updateCoeffs[thisModel,"FindRootOptions"->{"MaxIterations"->1},"MaxIterations"->3,"initialGuess" -> <|"Ewc"->{4}|>];];$MessageList]];
And@@{
  ReleaseHold@Last@m1=={{3}},
  ReleaseHold@Last@m2=={{3}}
}
```

### PrintResidualsNorm Option Tests (longTest only)

- **Test**: PrintResidualsNorm controls message output
```wolfram
m1=Block[{$MessagePrePrint=Sow,$MessageList={}},Reap[Module[{},updateCoeffs[thisModel,"PrintResidualsNorm"->False];];$MessageList]];
m2=Block[{$MessagePrePrint=Sow,$MessageList={}},Reap[Module[{},updateCoeffs[thisModel,"PrintResidualsNorm"->True];];$MessageList]];
(ReleaseHold@m1=={{},{}})  (* no output *)
(First@m2=={HoldForm@(FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::norm)})
NumberQ@(ReleaseHold@First@Flatten@Last@m2)
```

### CheckResiduals Option Tests (longTest only)

- **Test**: CheckResiduals controls abort on large residuals
```wolfram
c1=Not@TrueQ[CheckAbort[Check[updateCoeffs[thisModel,"CheckResiduals"->False],Abort[],(FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid)],True]];
c2=TrueQ[CheckAbort[Check[updateCoeffs[thisModel,"CheckResiduals"->True],Abort[],(FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid)],True]];
And@@{c1,c2}
```

### Tol Option Tests (longTest only)

- **Test**: Tolerance controls residual checking threshold
```wolfram
c1=Not@TrueQ[CheckAbort[Check[updateCoeffs[thisModel,"CheckResiduals"->True,"Tol"->1],Abort[],(FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid)],True]];
c2=TrueQ[CheckAbort[Check[updateCoeffs[thisModel,"CheckResiduals"->True,"Tol"->10.^-20],Abort[],(FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid)],True]];
And@@{c1,c2}
```

### UpdatePd Option Tests

- **Test**: UpdatePd=False returns only WC coefficients
```wolfram
Ewc0=4.6;
coeffsQWc[updateCoeffs[thisModel,"UpdatePd"->False,"initialGuess" -><|"Ewc"->{Ewc0},"Epd"->{{5.5}}|>]]
```

- **Test**: UpdatePd=True returns both WC and PD coefficients
```wolfram
coeffsWcPd=updateCoeffs[thisModel,"UpdatePd"->True,"initialGuess" -><|"Ewc"->{Ewc0},"Epd"->{{5.5}}|>];
coeffsWc=FilterRules[coeffsWcPd,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc[_Integer]];
coeffsPd=FilterRules[coeffsWcPd,FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd[_Integer]];
coeffsQWc[coeffsWc]
coeffsQPd[coeffsPd]
```

### Options Inheritance Tests (longTest only)

- **Test**: updateCoeffs inherits options from updateCoeffsSol and checks
```wolfram
And@@{
  SubsetQ[Options[updateCoeffs],Options[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`updateCoeffsSol]],
  SubsetQ[Options[updateCoeffs],Options[FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks]]
}
```

### Initial Guess Format Tests

- **Test**: Interval and point+interval initial guess formats work
```wolfram
And@@{
  coeffsQWc[updateCoeffs[thisModel,"initialGuess" -> <|"Ewc"->{1,8}|>]],
  coeffsQWc[updateCoeffs[thisModel,"initialGuess" -> <|"Ewc"->{4,1,8}|>]]
}
```

- **Test**: Approximate and exact numbers produce equivalent results (longTest only)
```wolfram
And@@{
  coeffsQWc[updateCoeffs[thisModel,"initialGuess" -> <|"Ewc"->{4.}|>]]==coeffsQWc[updateCoeffs[thisModel,"initialGuess" -> <|"Ewc"->{4}|>]],
  coeffsQWc[updateCoeffs[thisModel,"initialGuess" -> <|"Ewc"->{1.,8.}|>]]==coeffsQWc[updateCoeffs[thisModel,"initialGuess" -> <|"Ewc"->{1,8}|>]],
  coeffsQWc[updateCoeffs[thisModel,"initialGuess" -> <|"Ewc"->{4.,1.,8.}|>]]==coeffsQWc[updateCoeffs[thisModel,"initialGuess" -> <|"Ewc"->{4,1,8}|>]]
}
```

### Bond Coefficient Tests (Legacy)

- **Test**: Bond coefficients have expected structure
```wolfram
maxMaturity=12;
solBond=updateCoeffsBond[thisModel["coeffsSolution"]["bond"],thisModel["params"],{},maxMaturity,solWc];
solNomBond=updateCoeffsBond[thisModel["coeffsSolution"]["nombond"],thisModel["params"],{},maxMaturity,solWc];
And@@{
  coeffsQBond[solBond,maxMaturity],
  coeffsQNomBond[solNomBond,maxMaturity]
}
```

- **Test**: New parameters change bond coefficients
```wolfram
newBondParams={FernandoDuarte`LongRunRisk`Model`Parameters`psi->(0.1+FernandoDuarte`LongRunRisk`Model`Parameters`psi/.thisModel["params"])};
solWcNewBondParams=updateCoeffs[thisModel,newBondParams,optsWc];
solBondNew=updateCoeffsBond[thisModel["coeffsSolution"]["bond"],thisModel["params"],newBondParams,maxMaturity,solWcNewBondParams];
solNomBondNew=updateCoeffsBond[thisModel["coeffsSolution"]["nombond"],thisModel["params"],newBondParams,maxMaturity,solWcNewBondParams];
And@@{
  coeffsQBond[solBondNew,maxMaturity],
  coeffsQNomBond[solNomBondNew,maxMaturity],
  Not[solBond===solBondNew],
  Not[solNomBond===solNomBondNew]
}
```

- **Test**: maxMaturity affects coefficient ranges
```wolfram
maxMaturity=2;
solBond=updateCoeffsBond[thisModel["coeffsSolution"]["bond"],thisModel["params"],{},maxMaturity,solWc];
solNomBond=updateCoeffsBond[thisModel["coeffsSolution"]["nombond"],thisModel["params"],{},maxMaturity,solWc];
And@@{
  coeffsQBond[solBond,maxMaturity],
  coeffsQNomBond[solNomBond,maxMaturity],
  Range[0,maxMaturity]==(Sort@DeleteDuplicates@Cases[Keys@solBond,x_[i_][j_]:>i]),
  Range[0,maxMaturity]==(Sort@DeleteDuplicates@Cases[Keys@solNomBond,x_[i_][j_]:>i])
}
```

### RecurrenceTable Options (longTest only)

- **Test**: Pass options to RecurrenceTable
```wolfram
solBond=updateCoeffsBond[thisModel["coeffsSolution"]["bond"],thisModel["params"],{},maxMaturity,solWc,"Method"->Automatic,"Precision"->1];
solNomBond=updateCoeffsBond[thisModel["coeffsSolution"]["nombond"],thisModel["params"],{},maxMaturity,solWc,"Method"->Automatic,"Precision"->1];
And@@{
  coeffsQBond[solBond,maxMaturity],
  coeffsQNomBond[solNomBond,maxMaturity]
}
```

### updateCoeffs Bond Integration (longTest only)

- **Test**: updateCoeffs with UpdateBond matches updateCoeffsBond
```wolfram
And@@{
  FilterRules[updateCoeffs[thisModel,"UpdateBond"->True,"MaxMaturity"->maxMaturity],FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb[_]]===
    updateCoeffsBond[thisModel["coeffsSolution"]["bond"],thisModel["params"],{},maxMaturity,solWc],
  FilterRules[updateCoeffs[thisModel,"UpdateNomBond"->True,"MaxMaturity"->maxMaturity],FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb[_]]===
    updateCoeffsBond[thisModel["coeffsSolution"]["nombond"],thisModel["params"],{},maxMaturity,solWc]
}
```

- **Test**: UpdateBonds returns both real and nominal bond coefficients
```wolfram
Sort@FilterRules[updateCoeffs[thisModel,"UpdateBonds"->True,"MaxMaturity"->maxMaturity],FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb[_]|FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb[_]]===
Sort@Join[
  updateCoeffsBond[thisModel["coeffsSolution"]["bond"],thisModel["params"],{},maxMaturity,solWc],
  updateCoeffsBond[thisModel["coeffsSolution"]["nombond"],thisModel["params"],{},maxMaturity,solWc]
]
```

### Bond PrintResidualsNorm Tests (longTest only)

- **Test**: PrintResidualsNorm works for bond updates
```wolfram
m1=Block[{$MessagePrePrint=Sow,$MessageList={}},Reap[updateCoeffs[thisModel,"UpdateBond"->True,"PrintResidualsNorm"->False];$MessageList]];
m2=Block[{$MessagePrePrint=Sow,$MessageList={}},Reap[updateCoeffs[thisModel,"UpdateBond"->True,"PrintResidualsNorm"->True];$MessageList]];
(ReleaseHold@m1=={{},{}})
(MemberQ[ReleaseHold@First@m2,FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::norm])
NumberQ@(ReleaseHold@First@Flatten@Last@m2)
```

### Bond CheckResiduals Tests (longTest only)

- **Test**: CheckResiduals works for bond updates
```wolfram
c1=Not@TrueQ[CheckAbort[Check[updateCoeffs[thisModel,"UpdateBond"->True,"CheckResiduals"->False],Abort[],(FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid)],True]];
c2=TrueQ[CheckAbort[Check[updateCoeffs[thisModel,"UpdateBond"->True,"CheckResiduals"->True],Abort[],(FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid)],True]];
And@@{c1,c2}
```

### Bond Tol Tests (longTest only)

- **Test**: Tolerance works for bond updates
```wolfram
c1=Not@TrueQ[CheckAbort[Check[updateCoeffs[thisModel,"UpdateBond"->True,"CheckResiduals"->True,"Tol"->1],Abort[],(FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid)],True]];
c2=TrueQ[CheckAbort[Check[updateCoeffs[thisModel,"UpdateBond"->True,"CheckResiduals"->True,"Tol"->10.^-20],Abort[],(FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`Private`checks::largeresid)],True]];
And@@{c1,c2}
```
