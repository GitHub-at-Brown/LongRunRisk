BeginTestSection["options-and-domain Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ParamQuadSolve`optionsAndDomain`"]

(* --- merged from: options-and-domain_test1.wlt --- *)
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

VerificationTest[loadMessages$ === {}, True, TestID -> "package-load-clean@@Tests/ParamQuadSolve/options-and-domain.wlt:31,1-31,140"]

(* --- merged from: options-and-domain_test2.wlt --- *)
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

VerificationTest[AssociationQ[rBase$], True, TestID -> "assoc-r1@@Tests/ParamQuadSolve/options-and-domain.wlt:60,1-60,130"]

(* --- merged from: options-and-domain_test3.wlt --- *)
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

VerificationTest[diagMethodOK$, True, TestID -> "method-option-used@@Tests/ParamQuadSolve/options-and-domain.wlt:89,1-89,133"]

(* --- merged from: options-and-domain_test4.wlt --- *)
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

VerificationTest[diagOrderOK$, True, TestID -> "monomial-order-recorded@@Tests/ParamQuadSolve/options-and-domain.wlt:118,1-118,137"]

(* --- merged from: options-and-domain_test5.wlt --- *)
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

VerificationTest[signHeadOK$, True, TestID -> "signsymbol-head@@Tests/ParamQuadSolve/options-and-domain.wlt:147,1-147,128"]

(* --- merged from: options-and-domain_test6.wlt --- *)
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

VerificationTest[radCondOK$, True, TestID -> "radicand-sign-constraint@@Tests/ParamQuadSolve/options-and-domain.wlt:176,1-176,136"]

End[]
EndTestSection[]
