BeginTestSection["options-and-domain"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`options-and-domain`"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

(* Base small system *)
eq$ = {x^2 - 5 == 0, y + 2 x - 3 == 0};
vars$ = {x, y};

(* Clean load: suppress shadow warnings during load and collect messages *)
loadMessages$ = Block[{$MessageList = {}}, Off[General::shdw]; On[General::shdw]; $MessageList];

rBase$ = Quiet[pqs[eq$, vars$, "DomainOption" -> Reals, "ValidationOption" -> True], {Power::infy, Infinity::indet}];
rSeq$ = Quiet[pqs[eq$, vars$, "DomainOption" -> Reals, "ValidationOption" -> False, "Method" -> "Sequential"], {Power::infy, Infinity::indet}];
diagMethodOK$ = rSeq$["Diagnostics"]["Method"] === "Sequential";
rOrder$ = Quiet[pqs[eq$, vars$, "DomainOption" -> Reals, "ValidationOption" -> False, "Method" -> "SequentialWithGroebner", "MonomialOrder" -> DegreeReverseLexicographic], {Power::infy, Infinity::indet}];
diagOrderOK$ = rOrder$["Diagnostics"]["GroebnerMonomialOrder"] === DegreeReverseLexicographic;

(* Sign head rename *)
rSign$ = Quiet[pqs[eq$, vars$, "SignSymbol" -> sg, "DomainOption" -> Reals], {Power::infy, Infinity::indet}];
signHeadOK$ = And @@ (Head /@ Keys[rSign$["SignRootMap"]] === Table[sg, {Length[Keys[rSign$["SignRootMap"]]]}]);

(* Radicand inequality references the sign variable *)
rRad$ = Quiet[pqs[{x^2 - 1 == 0, y^2 - x == 0}, {x, y}, "DomainOption" -> Reals, "ValidationOption" -> False], {Power::infy, Infinity::indet}];
radCondOK$ = Module[{sk = Keys[rRad$["SignRootMap"]]}, MemberQ[rRad$["Conditions"], First[sk] >= 0]];

VerificationTest[loadMessages$ === {}, True, TestID -> "package-load-clean@@Tests/ParamQuadSolve/options-and-domain.wlt:27,1-27,133"]
VerificationTest[AssociationQ[rBase$], True, TestID -> "assoc-r1@@Tests/ParamQuadSolve/options-and-domain.wlt:28,1-28,123"]
VerificationTest[diagMethodOK$, True, TestID -> "method-option-used@@Tests/ParamQuadSolve/options-and-domain.wlt:29,1-29,126"]
VerificationTest[diagOrderOK$, True, TestID -> "monomial-order-recorded@@Tests/ParamQuadSolve/options-and-domain.wlt:30,1-30,130"]
VerificationTest[signHeadOK$, True, TestID -> "signsymbol-head@@Tests/ParamQuadSolve/options-and-domain.wlt:31,1-31,121"]
VerificationTest[radCondOK$, True, TestID -> "radicand-sign-constraint@@Tests/ParamQuadSolve/options-and-domain.wlt:32,1-32,129"]

End[]
EndTestSection[]
