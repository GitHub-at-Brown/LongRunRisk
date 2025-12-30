(* ::Package:: *)

BeginPackage["LongRunRisk`OptionsValidationRules`"];

$DefaultPacletContext::usage =
  "$DefaultPacletContext is the default context prefix used by InstallOptionsValidationRules.";

InstallOptionsValidationRules::usage =
  "InstallOptionsValidationRules[ctx] registers OptionsValidation CheckOption tests and enables default validation for LongRunRisk option owners. Returns the list of owner symbols that were registered.";

InstallOptionsValidationRules::noload =
  "Could not load OptionsValidation. Install the OptionsValidation paclet, or vendor OptionsValidation.m and ensure it can be loaded with Get[\"`OptionsValidation`\"].";

Begin["`Private`"];

$DefaultPacletContext = "LongRunRisk`";

normalizeCtx[ctx_String] := If[StringEndsQ[ctx, "`"], ctx, ctx <> "`"];

loadOptionsValidation[] := Module[{ok = True},
  Quiet @ Check[Needs["OptionsValidation`"], ok = False];
  If[TrueQ[ok], True,
    ok = True;
    Quiet @ Check[Get["`OptionsValidation`"], ok = False];
    TrueQ[ok]
  ]
];

(* -------------------------- *)
(* Small, reusable predicates *)
(* -------------------------- *)

boolQ[v_] := MatchQ[v, True | False];
autoBoolQ[v_] := MatchQ[v, True | False | Automatic];

posIntQ[v_] := IntegerQ[v] && v > 0;
nonnegIntQ[v_] := IntegerQ[v] && v >= 0;
posRealQ[v_] := NumericQ[v] && v > 0;

real01Q[v_] := NumericQ[v] && 0 <= v <= 1;

stringListQ[v_] := MatchQ[v, {_String ..}];

(* Validate list-of-rules shape (does not check option names are valid for a specific built-in) *)
rulesQ[v_] := MatchQ[v, {(_Rule | _RuleDelayed) ...}];

(* Simplify/Compile option rules: accept Automatic or OptionQ list *)
optRulesOrAutomaticQ[v_] := v === Automatic || OptionQ[v];

(* Signs: a single tuple of +-1 ints (or empty) *)
signTupleQ[t_] := (t === {}) || (MatchQ[t, {_Integer ..}] && AllTrue[t, (# === 1 || # === -1) &]);
signsQ[v_] := signTupleQ[v];

(* RootSigns: Automatic | All | association mapping "wc"/"pd" -> list of sign tuples *)
rootSignsListQ[l_] := MatchQ[l, {__List}] && AllTrue[l, signTupleQ];
rootSignsAssocQ[a_] := AssociationQ[a] && SubsetQ[Keys[a], {"wc", "pd"}] && AllTrue[Values[a], rootSignsListQ];
rootSignsQ[v_] := (v === Automatic) || (v === All) || rootSignsAssocQ[v];

(* initialGuess: association with keys "Ewc" and/or "Epd" *)
initialGuessQ[ig_] := AssociationQ[ig] &&
  SubsetQ[Keys[ig], {"Ewc", "Epd"}] &&
  (!KeyExistsQ[ig, "Ewc"] || MatchQ[ig["Ewc"], {_?NumericQ ..}]) &&
  (!KeyExistsQ[ig, "Epd"] || MatchQ[ig["Epd"], {{_?NumericQ ..} ..}]);

performanceGoalQ[v_] := MatchQ[v, "Speed" | "Quality"];
compileModeQ[v_] := MatchQ[v, "Both" | "FunctionOnly" | "JacobianOnly"];
compilerQ[v_] := MatchQ[v, "Compile" | "FunctionCompile"];
compTargetQ[v_] := MatchQ[v, "C" | "WVM" | "MVM"];

pdEquationsQ[v_] := MatchQ[v, "B" | "AB" | "Both"];
returnOptionQ[v_] := MatchQ[v, "All" | "First" | "Minimal"];

(* ParamQuadSolve knobs: permissive checks where the value space is broad *)
domainOptionQ[v_] := MatchQ[v, Reals | Complexes | Integers | Rationals | Algebraics | Booleans | All | _Symbol];
monomialOrderQ[v_] := MatchQ[v, Automatic | "Lexicographic" | "DegreeLexicographic" | "DegreeReverseLexicographic" | _List | _Association];

(* fastRoot *)
returnTypeQ[v_] := MatchQ[v, "Value" | "Rule"];
scanMethodQ[v_] := MatchQ[v, "Grid"]; (* extend if you add more scan methods *)

(* Time aggregation *)
v0Q[f_] := MatchQ[f, Function[{_, _, _, _, _, _}, _, ___]];
variableQ[v_] := MatchQ[v, "Flow" | "Stock" | "Ratio"];

simplifyFunctionQ[f_] := MatchQ[f, Simplify | FullSimplify | _Function | _Symbol];
momentFunctionQ[m_] := MatchQ[m, _Symbol | _Function];

(* ---------------------------------------------- *)
(* Registration helpers: messages + CheckOption... *)
(* ---------------------------------------------- *)

setOwnerMessages[owner_Symbol] := (
  owner::optx = "Value `2` for option `1` is not valid.";
);

makeCheck[owner_Symbol, name_String, pred_] := (
  OptionsValidation`CheckOption[owner, name] =
    (TrueQ @ pred[#] || (Message[owner::optx, name, HoldForm[#]]; False)) &;
);

makeChecks[owner_Symbol, spec_Association] :=
  KeyValueMap[(makeCheck[owner, #1, #2]) &, spec];

(* -------------------------------------- *)
(* Spec: ownerName -> <|optName -> pred|> *)
(* -------------------------------------- *)

specByOwnerName[] := <|
  "buildModelsInternal" -> <|
    "Models" -> (# === All || stringListQ[#]) &,
    "CompileJacobians" -> boolQ,
    "BuildMaxMaturity" -> posIntQ,
    "FileSuffix" -> StringQ,
    "UpdateManifest" -> boolQ,
    "FromScratch" -> boolQ,
    "CreateMoments" -> boolQ
  |>,
  "setupParallelKernels" -> <|
    "NumKernels" -> (# === Automatic || # === None || posIntQ[#]) &
  |>,
  "checkModels" -> <|
    "AutoBuild" -> autoBoolQ
  |>,
  "solveCoeffsSystem" -> <|
    "PdEquations" -> pdEquationsQ,
    "SimplifyOptions" -> OptionQ
  |>,
  "paramQuadSolve" -> <|
    "DomainOption" -> domainOptionQ,
    "Assumptions" -> (True &),          (* too broad to validate reliably *)
    "Method" -> (True &),               (* too broad to validate reliably *)
    "MonomialOrder" -> monomialOrderQ,
    "ValidationOption" -> boolQ,
    "ReturnOption" -> returnOptionQ,
    "TimeoutOption" -> posRealQ,
    "SimplifyTimeout" -> (# === Automatic || posRealQ[#]) &,
    "DiagnosticsOption" -> boolQ,
    "OnlyQuadTerms" -> boolQ,
    "SymbolicSignSymbol" -> SymbolQ,
    "GroebnerMemoryFraction" -> real01Q,
    "GroebnerMemoryFloor" -> posIntQ,
    "GroebnerMemoryCap" -> posIntQ
  |>,
  "simplifyWithDummySubstitution" -> <|
    "Level0Pattern" -> (True &),         (* any pattern/expression *)
    "SimplifyFunction" -> simplifyFunctionQ
  |>,
  "buildKernel" -> <|
    "CoeffName" -> StringQ,
    "CompileSignSymbol" -> StringQ,
    "PerformanceGoal" -> performanceGoalQ,
    "CompileMode" -> compileModeQ,
    "Compiler" -> compilerQ,
    "RuntimeOptions" -> optRulesOrAutomaticQ,
    "CompilationTarget" -> compTargetQ,
    "FlattenExpressions" -> autoBoolQ,
    "AllowCompileDuringCoverage" -> boolQ
  |>,
  "getStartingValues" -> <|
    "initialGuess" -> initialGuessQ
  |>,
  "updateCoeffsSol" -> <|
    "UpdatePd" -> boolQ,
    "UpdateBond" -> boolQ,
    "UpdateNomBond" -> boolQ,
    "UpdateBonds" -> boolQ,
    "MaxMaturity" -> posIntQ,
    "RootSigns" -> rootSignsQ
  |>,
  "solveCoeffRoots" -> <|
    "Signs" -> signsQ
  |>,
  "solveND" -> <|
    "ReduceTimeLimit" -> posRealQ
  |>,
  "checks" -> <|
    "PrintResidualsNorm" -> boolQ,
    "CheckResiduals" -> boolQ,
    "Tol" -> posRealQ
  |>,
  "fastRoot" -> <|
    "SecantBlend" -> real01Q,
    "ReturnType" -> returnTypeQ
  |>,
  "scanAndSolve" -> <|
    "ScanMethod" -> scanMethodQ,
    "BracketGrid" -> posIntQ,
    "Tolerance" -> (# === Automatic || posRealQ[#]) &
  |>,
  "extractIntervalsFromReduce" -> <|
    "InteriorShrink" -> posRealQ,
    "RootUpperBound" -> posRealQ,
    "UnboundedPad" -> posRealQ
  |>,
  "createDatabase" -> <|
    "maxMomentsLagsToCreate" -> posIntQ,
    "startSequenceAtLag" -> nonnegIntQ,
    "simplifyDownValues" -> boolQ
  |>,
  "uncondCovLongExo" -> <|
    "IterationLimit" -> posIntQ
  |>,
  "lagStateVarst" -> <|
    "MaxIterations" -> posIntQ,
    "TimeConstraint" -> posRealQ
  |>,
  "growth" -> <|
    "v0" -> v0Q,
    "Order" -> posIntQ
  |>,
  "timeSeriesVector" -> <|
    "TimeAggregation" -> posIntQ,
    "numPeriods" -> posIntQ
  |>,
  "g" -> <|
    "Variable" -> variableQ
  |>,
  "visualizeCoeffs" -> <|
    "ShowSelector" -> boolQ,
    "ShowDetails" -> boolQ
  |>,
  "yieldCurve" -> <|
    "MomentFunction" -> momentFunctionQ
  |>
|>;

(* ---------------------------------------------------- *)
(* Public entry point: install all validation definitions *)
(* ---------------------------------------------------- *)

InstallOptionsValidationRules[ctx_String : $DefaultPacletContext] := Module[
  {ctx2, sym, specs, ownerNames, syms, owners},

  If[!TrueQ @ loadOptionsValidation[],
    Message[InstallOptionsValidationRules::noload];
    Return[$Failed];
  ];

  ctx2 = normalizeCtx[ctx];
  sym[name_String] := Symbol[ctx2 <> name];

  specs = specByOwnerName[];
  ownerNames = Keys[specs];

  (* Resolve all owners in the target paclet context *)
  syms = AssociationMap[sym, ownerNames];
  owners = Lookup[syms, ownerNames];

  (* Per-owner message template *)
  Scan[setOwnerMessages, owners];

  (* Register all CheckOption predicates *)
  KeyValueMap[(makeChecks[syms[#1], #2]) &, specs];

  (* Validate any subsequent SetOptions[...] changes to defaults *)
  OptionsValidation`SetDefaultOptionsValidation[
    owners,
    OptionsValidation`CheckedDuplicate -> First,
    OptionsValidation`ChecksStopOnInvalid -> True
  ];

  owners
];

End[]; (* `Private` *)
EndPackage[];
