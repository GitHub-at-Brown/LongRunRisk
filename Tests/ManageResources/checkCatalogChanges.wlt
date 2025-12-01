(* Setup: Load ManageResources.wl *)
Module[{start, d, pacletRoot},
  start = If[StringQ[$InputFileName] && $InputFileName =!= "",
    DirectoryName[$InputFileName], Directory[]];
  d = start;
  While[! FileExistsQ@FileNameJoin[{d, "PacletInfo.wl"}] && d =!= DirectoryName[d],
    d = DirectoryName[d]];
  pacletRoot = d;
  SetDirectory[pacletRoot];
  Off[General::shdw];
  Get[FileNameJoin[{pacletRoot, "Kernel", "Tools", "ManageResources.wl"}]];
  On[General::shdw];
];

$timeLimit = 30;

(* ============================================================ *)
(* Return Type Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{result, checkCatalogChanges},
    checkCatalogChanges = FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogChanges;
    result = Quiet[checkCatalogChanges[]];
    AssociationQ[result]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "checkCatalogChanges-returns-association"
]

VerificationTest[
  Module[{result, checkCatalogChanges},
    checkCatalogChanges = FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogChanges;
    result = Quiet[checkCatalogChanges[]];
    KeyExistsQ[result, "Changed"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "checkCatalogChanges-has-Changed-key"
]

VerificationTest[
  Module[{result, checkCatalogChanges},
    checkCatalogChanges = FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogChanges;
    result = Quiet[checkCatalogChanges[]];
    KeyExistsQ[result, "New"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "checkCatalogChanges-has-New-key"
]

VerificationTest[
  Module[{result, checkCatalogChanges},
    checkCatalogChanges = FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogChanges;
    result = Quiet[checkCatalogChanges[]];
    KeyExistsQ[result, "Removed"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "checkCatalogChanges-has-Removed-key"
]

VerificationTest[
  Module[{result, checkCatalogChanges},
    checkCatalogChanges = FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogChanges;
    result = Quiet[checkCatalogChanges[]];
    KeyExistsQ[result, "Validation"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "checkCatalogChanges-has-Validation-key"
]

(* ============================================================ *)
(* Value Type Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{result, checkCatalogChanges},
    checkCatalogChanges = FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogChanges;
    result = Quiet[checkCatalogChanges[]];
    ListQ[result["Changed"]]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "checkCatalogChanges-Changed-is-list"
]

VerificationTest[
  Module[{result, checkCatalogChanges},
    checkCatalogChanges = FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogChanges;
    result = Quiet[checkCatalogChanges[]];
    ListQ[result["New"]]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "checkCatalogChanges-New-is-list"
]

VerificationTest[
  Module[{result, checkCatalogChanges},
    checkCatalogChanges = FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogChanges;
    result = Quiet[checkCatalogChanges[]];
    ListQ[result["Removed"]]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "checkCatalogChanges-Removed-is-list"
]

VerificationTest[
  Module[{result, checkCatalogChanges},
    checkCatalogChanges = FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogChanges;
    result = Quiet[checkCatalogChanges[]];
    AssociationQ[result["Validation"]] && KeyExistsQ[result["Validation"], "Valid"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "checkCatalogChanges-Validation-has-Valid-key"
]

(* ============================================================ *)
(* List Content Tests *)
(* ============================================================ *)

VerificationTest[
  Module[{result, checkCatalogChanges},
    checkCatalogChanges = FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogChanges;
    result = Quiet[checkCatalogChanges[]];
    (* Changed models should be strings (model names) *)
    AllTrue[result["Changed"], StringQ]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "checkCatalogChanges-Changed-contains-strings"
]

VerificationTest[
  Module[{result, checkCatalogChanges},
    checkCatalogChanges = FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogChanges;
    result = Quiet[checkCatalogChanges[]];
    (* New models should be strings (model names) *)
    AllTrue[result["New"], StringQ]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "checkCatalogChanges-New-contains-strings"
]

VerificationTest[
  Module[{result, checkCatalogChanges},
    checkCatalogChanges = FernandoDuarte`LongRunRisk`Tools`ManageResources`checkCatalogChanges;
    result = Quiet[checkCatalogChanges[]];
    (* Removed models should be strings (model names) *)
    AllTrue[result["Removed"], StringQ]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "checkCatalogChanges-Removed-contains-strings"
]
