Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`"];

Module[{start, d, pacletRoot},
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName],
    Directory[]
  ];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d], d = DirectoryName[d]];
  pacletRoot = d;
  Off[General::shdw];
  Get[FileNameJoin[{pacletRoot, "Kernel", "ComputationalEngine", "ParamQuadSolve.wl"}]];
  On[General::shdw];
];

pqs = ToExpression["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`Private`paramQuadSolve"];

eqns$ = {
  y^2 - 2 == 0,
  x*y + x - 1 == 0,
  z^2 + z - 3 == 0
};
vars$ = {x, y, z};

res$ = pqs[eqns$, vars$, Validation -> True, Domain -> Reals];

signKeys$ = Keys[res$["SignRootMap"]];
radVals$ = Values[res$["SignRootMap"]];
radSq$ = Simplify[radVals$^2];
rulesFor[v1_, v2_] := Thread[signKeys$ -> {v1, v2}];

VerificationTest[AssociationQ[res$], True, TestID -> "returns-association@@Tests/ParamQuadSolve/two-radicals-bilinear.wlt:32,1-32,136"]
VerificationTest[Length[signKeys$] === 2, True, TestID -> "two-sign-variables@@Tests/ParamQuadSolve/two-radicals-bilinear.wlt:33,1-33,140"]
VerificationTest[Sort[Simplify /@ radSq$] === Sort[{8, 13}], True, TestID -> "radicands-8-and-13@@Tests/ParamQuadSolve/two-radicals-bilinear.wlt:34,1-34,159"]
VerificationTest[
  Module[{heads},
    heads = DeleteDuplicates[Head /@ signKeys$];
    AllTrue[Simplify[res$["Verification"] /. (Alternatives @@ ((#[_]^2) & /@ heads)) -> 1], TrueQ]
  ],
  True,
  TestID -> "verification-all-true@@Tests/ParamQuadSolve/two-radicals-bilinear.wlt:35,1-42,2"
]
VerificationTest[AllTrue[Simplify[eqns$ /. res$["Solution"] /. rulesFor[1, 1]], TrueQ], True, TestID -> "subs-++@@Tests/ParamQuadSolve/two-radicals-bilinear.wlt:43,1-43,175"]
VerificationTest[AllTrue[Simplify[eqns$ /. res$["Solution"] /. rulesFor[1, -1]], TrueQ], True, TestID -> "subs-+-@@Tests/ParamQuadSolve/two-radicals-bilinear.wlt:44,1-44,176"]
VerificationTest[AllTrue[Simplify[eqns$ /. res$["Solution"] /. rulesFor[-1, 1]], TrueQ], True, TestID -> "subs--+@@Tests/ParamQuadSolve/two-radicals-bilinear.wlt:45,1-45,176"]
VerificationTest[AllTrue[Simplify[eqns$ /. res$["Solution"] /. rulesFor[-1, -1]], TrueQ], True, TestID -> "subs----@@Tests/ParamQuadSolve/two-radicals-bilinear.wlt:46,1-46,178"]
VerificationTest[
  Module[{assigns, ourRules, solveRules, sameQ},
    assigns = Tuples[{-1, 1}, Length[signKeys$]];
    ourRules = Map[(res$["Solution"] /. Thread[signKeys$ -> #]) &, assigns];
    solveRules = Solve[eqns$, vars$, Reals];
    sameQ[r1_, r2_] := TrueQ@Simplify[(vars$ /. r1) == (vars$ /. r2)];
    Length[solveRules] == Length[ourRules] && AllTrue[solveRules, ssol |-> AnyTrue[ourRules, sameQ[#, ssol] &]]
  ],
  True, TestID -> "matches-Solve@@Tests/ParamQuadSolve/two-radicals-bilinear.wlt:47,1-56,2"
]

End[];
