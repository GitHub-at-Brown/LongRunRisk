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

(* Base small system *)
eq$ = {x^2 - 5 == 0, y + 2 x - 3 == 0};
vars$ = {x, y};

(* Clean load: suppress shadow warnings during load and collect messages *)
loadMessages$ = Block[{$MessageList = {}}, Off[General::shdw]; On[General::shdw]; $MessageList];

rBase$ = Quiet[pqs[eq$, vars$, Domain -> Reals, Validation -> True], {Power::infy, Infinity::indet}];
rSeq$ = Quiet[pqs[eq$, vars$, Domain -> Reals, Validation -> False, Method -> "Sequential"], {Power::infy, Infinity::indet}];
diagMethodOK$ = rSeq$["Diagnostics"]["Method"] === "Sequential";
rOrder$ = Quiet[pqs[eq$, vars$, Domain -> Reals, Validation -> False, Method -> "SequentialWithGroebner", MonomialOrder -> DegreeReverseLexicographic], {Power::infy, Infinity::indet}];
diagOrderOK$ = rOrder$["Diagnostics"]["GroebnerMonomialOrder"] === DegreeReverseLexicographic;

(* Sign head rename *)
rSign$ = Quiet[pqs[eq$, vars$, SignSymbol -> sg, Domain -> Reals], {Power::infy, Infinity::indet}];
signHeadOK$ = And @@ (Head /@ Keys[rSign$["SignRootMap"]] === Table[sg, {Length[Keys[rSign$["SignRootMap"]]]}]);

(* Radicand inequality references the sign variable *)
rRad$ = Quiet[pqs[{x^2 - 1 == 0, y^2 - x == 0}, {x, y}, Domain -> Reals, Validation -> False], {Power::infy, Infinity::indet}];
radCondOK$ = Module[{sk = Keys[rRad$["SignRootMap"]]}, MemberQ[rRad$["Conditions"], First[sk] >= 0]];

VerificationTest[loadMessages$ === {}, True, TestID -> "package-load-clean@@Tests/ParamQuadSolve/options-and-domain.wlt:39,1-39,134"]
VerificationTest[AssociationQ[rBase$], True, TestID -> "assoc-r1@@Tests/ParamQuadSolve/options-and-domain.wlt:40,1-40,124"]
VerificationTest[diagMethodOK$, True, TestID -> "method-option-used@@Tests/ParamQuadSolve/options-and-domain.wlt:41,1-41,127"]
VerificationTest[diagOrderOK$, True, TestID -> "monomial-order-recorded@@Tests/ParamQuadSolve/options-and-domain.wlt:42,1-42,131"]
VerificationTest[signHeadOK$, True, TestID -> "signsymbol-head@@Tests/ParamQuadSolve/options-and-domain.wlt:43,1-43,122"]
VerificationTest[radCondOK$, True, TestID -> "radicand-sign-constraint@@Tests/ParamQuadSolve/options-and-domain.wlt:44,1-44,130"]

End[];
