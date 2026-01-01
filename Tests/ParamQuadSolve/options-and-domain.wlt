BeginTestSection["options-and-domain Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`optionsAndDomain`"]

Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];
On[General::shdw];

pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

(* Clean load check *)
loadMessages = Block[{$MessageList = {}}, Off[General::shdw]; On[General::shdw]; $MessageList];

VerificationTest[
  loadMessages === {},
  True,
  {},
  TestID -> "package-load-clean@@Tests/ParamQuadSolve/options-and-domain.wlt:13,1-18,2"
]

VerificationTest[
  Module[{x, y, eq, vars, rBase},
    eq = {x^2 - 5 == 0, y + 2 x - 3 == 0};
    vars = {x, y};
    rBase = Quiet[pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> True], {Power::infy, Infinity::indet}];
    AssociationQ[rBase]
  ],
  True,
  {},
  TestID -> "assoc-r1@@Tests/ParamQuadSolve/options-and-domain.wlt:20,1-30,2"
]

VerificationTest[
  Module[{x, y, eq, vars, rSeq, diagMethodOK},
    eq = {x^2 - 5 == 0, y + 2 x - 3 == 0};
    vars = {x, y};
    rSeq = Quiet[pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False, "Method" -> "Sequential"], {Power::infy, Infinity::indet}];
    diagMethodOK = rSeq["Diagnostics"]["Method"] === "Sequential";
    diagMethodOK
  ],
  True,
  {},
  TestID -> "method-option-used@@Tests/ParamQuadSolve/options-and-domain.wlt:32,1-43,2"
]

VerificationTest[
  Module[{x, y, eq, vars, rOrder, diagOrderOK},
    eq = {x^2 - 5 == 0, y + 2 x - 3 == 0};
    vars = {x, y};
    rOrder = Quiet[pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False, "Method" -> "SequentialWithGroebner", "MonomialOrder" -> DegreeReverseLexicographic], {Power::infy, Infinity::indet}];
    diagOrderOK = rOrder["Diagnostics"]["GroebnerMonomialOrder"] === DegreeReverseLexicographic;
    diagOrderOK
  ],
  True,
  {},
  TestID -> "monomial-order-recorded@@Tests/ParamQuadSolve/options-and-domain.wlt:45,1-56,2"
]

VerificationTest[
  Module[{x, y, sg, eq, vars, rSign, signHeadOK},
    eq = {x^2 - 5 == 0, y + 2 x - 3 == 0};
    vars = {x, y};
    rSign = Quiet[pqs[eq, vars, "SymbolicSignSymbol" -> sg, "DomainOption" -> Reals], {Power::infy, Infinity::indet}];
    signHeadOK = And @@ (Head /@ Keys[rSign["SignRootMap"]] === Table[sg, {Length[Keys[rSign["SignRootMap"]]]}]);
    signHeadOK
  ],
  True,
  {},
  TestID -> "symbolicsignsymbol-head@@Tests/ParamQuadSolve/options-and-domain.wlt:58,1-69,2"
]

VerificationTest[
  Module[{x, y, eq, vars, rRad, radCondOK},
    eq = {x^2 - 1 == 0, y^2 - x == 0};
    vars = {x, y};
    rRad = Quiet[pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False], {Power::infy, Infinity::indet}];
    radCondOK = Module[{sk = Keys[rRad["SignRootMap"]]}, MemberQ[rRad["Conditions"], First[sk] >= 0]];
    radCondOK
  ],
  True,
  {},
  TestID -> "radicand-sign-constraint@@Tests/ParamQuadSolve/options-and-domain.wlt:71,1-82,2"
]

End[]
EndTestSection[]
