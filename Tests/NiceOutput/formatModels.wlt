(* Setup: Load NiceOutput.wl and Catalog *)
Module[{start, d, pacletRoot},
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName], Directory[]];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
    d = DirectoryName[d]];
  pacletRoot = d;
  Off[General::shdw];
  Get[FileNameJoin[{pacletRoot, "Kernel", "Tools", "NiceOutput.wl"}]];
  On[General::shdw];
];

$formatModels = FernandoDuarte`LongRunRisk`Tools`NiceOutput`formatModels;
$toCatalog = FernandoDuarte`LongRunRisk`Tools`NiceOutput`toCatalog;

(* Load catalog for testing with real models *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 10;

(* Create a minimal test model with all required fields *)
$minimalModel = <|
  "TEST" -> <|
    "name" -> "Test Model",
    "shortname" -> "TEST",
    "bibRef" -> "test2024",
    "desc" -> "A minimal test model for verification",
    "enabled" -> True,
    "stateVars" -> {x[t]},
    "parameters" -> {
      delta -> 0.999, psi -> 1.5, gamma -> 10, theta -> -9,
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0,
      phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0,
      phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0,
      phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0078,
      phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0,
      phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 1, vx -> 0, phisxs -> 0,
      Esc -> 1, vc -> 0.987, phiscv -> 0.038,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0,
      phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0,
      phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

(* ============================================================ *)
(* Basic Output Structure Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{result},
    result = $formatModels[$minimalModel];
    Head[result] === BoxData
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "formatModels-returns-BoxData"
]

VerificationTest[
  Module[{result},
    result = $formatModels[$minimalModel];
    !FreeQ[result, RowBox]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "formatModels-contains-RowBox"
]

VerificationTest[
  Module[{result},
    result = $formatModels[$minimalModel];
    !FreeQ[result, "<|"] && !FreeQ[result, "|>"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "formatModels-contains-association-markers"
]

(* ============================================================ *)
(* Content Verification Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{result, strings},
    result = $formatModels[$minimalModel];
    strings = Cases[result, _String, Infinity];
    MemberQ[strings, s_String /; StringContainsQ[s, "TEST"]]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "formatModels-contains-shortname"
]

VerificationTest[
  Module[{result, strings},
    result = $formatModels[$minimalModel];
    strings = Cases[result, _String, Infinity];
    MemberQ[strings, s_String /; StringContainsQ[s, "delta"]] &&
    MemberQ[strings, s_String /; StringContainsQ[s, "gamma"]]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "formatModels-contains-parameters"
]

VerificationTest[
  Module[{result, strings},
    result = $formatModels[$minimalModel];
    strings = Cases[result, _String, Infinity];
    MemberQ[strings, s_String /; StringContainsQ[s, "enabled"]]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "formatModels-contains-enabled-field"
]

VerificationTest[
  Module[{result, strings},
    result = $formatModels[$minimalModel];
    strings = Cases[result, _String, Infinity];
    MemberQ[strings, s_String /; StringContainsQ[s, "0.999"]]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "formatModels-contains-numeric-params"
]

(* ============================================================ *)
(* Multiple Models Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{twoModels, result, strings},
    twoModels = <|
      "M1" -> ReplacePart[$minimalModel["TEST"], "shortname" -> "M1"],
      "M2" -> ReplacePart[$minimalModel["TEST"], "shortname" -> "M2"]
    |>;
    result = $formatModels[twoModels];
    strings = Cases[result, _String, Infinity];
    MemberQ[strings, s_String /; StringContainsQ[s, "M1"]] &&
    MemberQ[strings, s_String /; StringContainsQ[s, "M2"]]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "formatModels-multiple-models"
]

(* ============================================================ *)
(* Long Description Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{longDescModel, result, strings},
    longDescModel = ReplacePart[$minimalModel,
      {"TEST", "desc"} -> "This is a very long description that should definitely trigger line breaks in the formatted output because it exceeds forty characters."];
    result = $formatModels[longDescModel];
    strings = Cases[result, _String, Infinity];
    MemberQ[strings, s_String /; StringContainsQ[s, "\n\t\t\t"]]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "formatModels-long-desc-line-breaks"
]

(* ============================================================ *)
(* Unicode Preservation Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{specialModel, result, strings},
    specialModel = ReplacePart[$minimalModel, {"TEST", "name"} -> "Test with αβγ symbols"];
    result = $formatModels[specialModel];
    strings = Cases[result, _String, Infinity];
    MemberQ[strings, s_String /; StringContainsQ[s, "αβγ"]]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "formatModels-unicode-preserved"
]

(* ============================================================ *)
(* Full Catalog Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{keysToKeep, raw, result},
    keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"};
    raw = $toCatalog[$realModels, keysToKeep];
    result = $formatModels[raw];
    Head[result] === BoxData
  ],
  True,
  TimeConstraint -> 30,
  TestID -> "formatModels-full-catalog"
]

VerificationTest[
  Module[{keysToKeep, raw, result, strings, modelNames},
    keysToKeep = {"name", "shortname", "bibRef", "desc", "enabled", "stateVars", "parameters"};
    raw = $toCatalog[$realModels, keysToKeep];
    result = $formatModels[raw];
    strings = Cases[result, _String, Infinity];
    modelNames = Values[#["shortname"]& /@ raw];
    (* verify all model shortnames are in output *)
    AllTrue[modelNames, MemberQ[strings, s_String /; StringContainsQ[s, #]]&]
  ],
  True,
  TimeConstraint -> 30,
  TestID -> "formatModels-all-models-in-output"
]
