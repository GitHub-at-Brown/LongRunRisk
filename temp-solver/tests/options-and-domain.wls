(* Options API coverage: clean load, Method/MonomialOrder wiring, SignSymbol rename,
   and explicit radicand constraints. *)

Module[{testDir, pkgPath, eq, vars, rBase, rSign, rSeq, rOrder, rRad, signHeadOK,
  loadMessages, diagMethodOK, diagOrderOK, radCondOK},
  testDir = If[StringQ[$InputFileName] && $InputFileName =!= "", DirectoryName[$InputFileName], Directory[]];
  pkgPath = FileNameJoin[{DirectoryName[testDir], "ParamQuadSolve.wl"}];
  loadMessages = Block[{$MessageList = {}}, Get[pkgPath]; $MessageList];

  (* Base small system *)
  eq = {x^2 - 5 == 0, y + 2 x - 3 == 0};
  vars = {x, y};

  rBase = Quiet[ParamQuadSolver`ParamQuadSolve[eq, vars, Domain -> Reals, Validation -> True], {Power::infy, Infinity::indet}];
  rSeq = Quiet[ParamQuadSolver`ParamQuadSolve[eq, vars, Domain -> Reals, Validation -> False, Method -> "Sequential"], {Power::infy, Infinity::indet}];
  diagMethodOK = rSeq["Diagnostics"]["Method"] === "Sequential";
  rOrder = Quiet[ParamQuadSolver`ParamQuadSolve[eq, vars, Domain -> Reals, Validation -> False, Method -> "SequentialWithGroebner", MonomialOrder -> DegreeReverseLexicographic], {Power::infy, Infinity::indet}];
  diagOrderOK = rOrder["Diagnostics"]["GroebnerMonomialOrder"] === DegreeReverseLexicographic;

  (* Sign head rename *)
  rSign = Quiet[ParamQuadSolver`ParamQuadSolve[eq, vars, ParamQuadSolver`SignSymbol -> sg, Domain -> Reals], {Power::infy, Infinity::indet}];
  signHeadOK = And @@ (Head /@ Keys[rSign["SignRootMap"]] === Table[sg, {Length[Keys[rSign["SignRootMap"]]]}]);

  (* Radicand inequality references the sign variable *)
  rRad = Quiet[ParamQuadSolver`ParamQuadSolve[{x^2 - 1 == 0, y^2 - x == 0}, {x, y}, Domain -> Reals, Validation -> False], {Power::infy, Infinity::indet}];
  radCondOK = MemberQ[rRad["Conditions"], ParamQuadSolver`signA[1] >= 0];
  
  Print @ TestReport @ {
    VerificationTest[loadMessages === {}, True, TestID -> "package-load-clean"],
    VerificationTest[AssociationQ[rBase], True, TestID -> "assoc-r1"],
    VerificationTest[diagMethodOK, True, TestID -> "method-option-used"],
    VerificationTest[diagOrderOK, True, TestID -> "monomial-order-recorded"],
    VerificationTest[signHeadOK, True, TestID -> "signsymbol-head"],
    VerificationTest[radCondOK, True, TestID -> "radicand-sign-constraint"]
  };
]
