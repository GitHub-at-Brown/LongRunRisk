### NiceOutput.wl

- Install PacletizedResourceFunctions for tests (setup step)
  ```
  distributedPaclet = FileNameJoin[{
    DirectoryName[$InputFileName, 2],  (* From Tests/ up to paclet root *)
    "Resources",
    "PacletizedResourceFunctions.paclet"
  }];
  If[FileExistsQ[distributedPaclet],
    PacletInstall[distributedPaclet, "IgnoreVersion" -> True];
  ];
  True
  ```

- Verify PacletizedResourceFunctions installation
  ```
  Length[PacletFind["PacletizedResourceFunctions"]] > 0
  ```

- Load test models (setup step)
  ```
  longTest = False; (*fast and partial coverage (False) or slow and full coverage (True)*)
  FernandoDuarte`LongRunRisk`Models = Get@Get[FileNameJoin[{"FernandoDuarte/LongRunRisk","Models.wl"}]];
  msp = If[longTest,
    FernandoDuarte`LongRunRisk`Models,
    KeyTake[FernandoDuarte`LongRunRisk`Models, {"BY","BKY","NRC","DES","NRCStochVol"}]
  ];
  modBY = msp["BY"];
  modBKY = msp["BKY"];
  modNRC = msp["NRC"];
  modDES = msp["DES"];
  modNRCStochVol = msp["NRCStochVol"];
  True
  ```

- Context is loaded and private context is accessible
  ```
  Needs@context;
  $ContextPath = DeleteDuplicates@Prepend[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`"];
  True
  ```

- Context is in `$ContextPath`
  ```
  And @@ {
    MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]
  }
  ```

- Symbol `info` can be found
  ```
  Not[Names["*info"] === {}]
  ```

- `info` returns correctly formatted model information table
  ```
  myModelsInfo = PacletizedResourceFunctions`SetSymbolsContext@info[msp];
  And @@ {
    Head[myModelsInfo] === Column,
    Head[myModelsInfo[[1]]] === List,
    Head[myModelsInfo[[1,1]]] === OpenerView,
    And @@ (MatchQ[#, Grid] & /@ (Head /@ myModelsInfo[[1, ;; , 1, 2]]))
  }
  ```

- `info` is correct when model key does not match shortname
  ```
  justBY = <|"BY" -> msp["BY"]|>;
  infoBY = PacletizedResourceFunctions`SetSymbolsContext@info[justBY];
  newBY = <|"myModel" -> msp["BY"]|>;
  infoNewBY = PacletizedResourceFunctions`SetSymbolsContext@info[newBY];
  And @@ {
    infoBY[[1,1,1,1]] == "BY",
    PacletizedResourceFunctions`SetSymbolsContext@(infoBY[[1,1,1,2,1,4,1,1,2,1,1,1,1]]) === PacletizedResourceFunctions`SetSymbolsContext@(x[t]),
    infoNewBY[[1,1,1,1]] == "BY",
    PacletizedResourceFunctions`SetSymbolsContext@(infoNewBY[[1,1,1,2,1,4,1,1,2,1,1,1,1]]) === PacletizedResourceFunctions`SetSymbolsContext@(x[t])
  }
  ```

- `info` output formatting is correct for both matching and non-matching keys
  ```
  And @@ {
    Head[infoBY] === Column,
    Head[infoBY[[1]]] === List,
    Head[infoBY[[1,1]]] === OpenerView,
    And @@ (MatchQ[#, Grid] & /@ (Head /@ infoBY[[1, ;; , 1, 2]])),

    Head[infoNewBY] === Column,
    Head[infoNewBY[[1]]] === List,
    Head[infoNewBY[[1,1]]] === OpenerView,
    And @@ (MatchQ[#, Grid] & /@ (Head /@ infoNewBY[[1, ;; , 1, 2]]))
  }
  ```

- `numberFormattingTemplate` formats numbers correctly
  ```
  With[{localPi = 3.14},
    {
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14, NumberMarks -> True],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14, NumberMarks -> False],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[localPi],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[localPi, NumberMarks -> True],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[localPi, NumberMarks -> False],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[\[CapitalPi]],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[\[CapitalPi], CharacterEncoding -> "ASCII"],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[Pi],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[N[Pi]],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[3.14*10^(-7)],
      FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`numberFormattingTemplate[Flatten[{FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stripContext[delta]/2 /. FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stripContext[{delta -> 0.99}]}]]
    }
  ] === {"3.14", "3.14`", "3.14", "3.14", "3.14`", "3.14", "\[CapitalPi]", "\\[CapitalPi]", "3.141592653589793", "3.141592653589793", "3.14*^-7", "{0.495}"}
  ```

- `stringFormattingTemplate` adds linebreaks and tabs for long strings
  ```
  Not@StringFreeQ[
    FernandoDuarte`LongRunRisk`Tools`NiceOutput`Private`stringFormattingTemplate[
      "Long-run risk model with stochastic volatility in the original 2004 paper by Bansal and Yaron"
    ],
    "\t" | "\n"
  ]
  ```


---
