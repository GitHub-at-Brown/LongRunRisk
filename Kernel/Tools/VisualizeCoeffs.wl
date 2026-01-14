(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`VisualizeCoeffs`"];


(* ::Subsection:: *)
(*Public symbols*)


visualizeCoeffs


(* ::Subsubsection:: *)
(*Usage*)


visualizeCoeffs::usage = "visualizeCoeffs[updateCoeffsResult] displays a coefficient-centric comparison view.\n" <>
    "Shows A[0] and B[j][0] values across all solution bundles for easy comparison.\n" <>
    "Includes an interactive selector to compare any coefficient across bundles.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`SolveEulerEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];

(* Symbols from EndogenousEq context - used via With for pattern injection *)
$A = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`A;
$B = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`B;
$R = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`R;
$P = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`P;


(* ::Subsection:: *)
(*Options*)


Options[visualizeCoeffs] = {
    "ShowSelector" -> True,
    "ShowDetails" -> True
};


(* ::Subsection:: *)
(*Color scheme*)


$aColor = RGBColor[0.368, 0.507, 0.71];  (* blue *)
$bColors = {
    RGBColor[0.881, 0.611, 0.142],  (* orange - stock 1 *)
    RGBColor[0.560, 0.692, 0.195],  (* green - stock 2 *)
    RGBColor[0.923, 0.386, 0.209],  (* red - stock 3 *)
    RGBColor[0.528, 0.471, 0.701],  (* purple - stock 4 *)
    RGBColor[0.580, 0.404, 0.741]   (* violet - stock 5 *)
};


bColor[j_Integer] := $bColors[[Mod[j - 1, Length[$bColors]] + 1]];


(* ::Subsection:: *)
(*Helper functions*)


(* Format value to 2 decimal places, show "-" for missing values *)
formatValue[val_?NumericQ] := NumberForm[N[val], {Infinity, 2}];
formatValue[val_] := Style["\[LongDash]", Gray];  (* No solution *)

(* Format coefficient name without context - check Head directly *)
formatCoeffName[coeff_] := Which[
    Head[coeff] === $A,
        "A[" <> ToString[First[coeff]] <> "]",
    Head[Head[coeff]] === $B,
        "B[" <> ToString[First[Head[coeff]]] <> "][" <> ToString[First[coeff]] <> "]",
    True,
        ToString[coeff, InputForm]
];


(* Extract bundles using flattenCoeffsBundles *)
extractBundles[results_List] := Module[{bundles},
    bundles = flattenCoeffsBundles[results];
    (* Each bundle is a flat list of rules *)
    bundles
];


(* Get coefficient value from a bundle (list of rules) - use With to inject symbols *)
With[{A = $A, B = $B},
    getCoeffValue[bundle_List, A[n_Integer]] := A[n] /. bundle;
    getCoeffValue[bundle_List, B[j_Integer][n_Integer]] := B[j][n] /. bundle;
];


(* Count number of stocks from results *)
getNumStocks[results_List] := With[{firstResult = First[results]},
    Length[Keys[firstResult["Stocks"]]]
];


(* Get max coefficient index for A or B - use With to inject symbols *)
With[{A = $A, B = $B},
    getMaxAIndex[bundle_List] := Max[Cases[bundle, (A[n_] -> _) :> n]];
    getMaxBIndex[bundle_List, jVal_Integer] := With[{j = jVal},
        Max[Cases[bundle, (B[j][n_] -> _) :> n]]
    ];
];


(* Get max bond maturity from bundle *)
With[{R = $R},
    getMaxRIndex[bundle_List] := Max[0, Cases[bundle, (R[n_][0] -> _) :> n]];
];


(* Extract bond yields from bundle: yield[n] = -R[n][0]/n *)
With[{R = $R},
    getBondYields[bundle_List] := Module[{maxN, yields},
        maxN = getMaxRIndex[bundle];
        If[maxN == 0, Return[{}]];
        yields = Table[
            {n, -N[(R[n][0] /. bundle) / n]},
            {n, 1, maxN}
        ];
        (* Filter out non-numeric values *)
        Select[yields, NumericQ[#[[2]]] &]
    ];
];


(* Get max nominal bond maturity from bundle *)
With[{P = $P},
    getMaxPIndex[bundle_List] := Max[0, Cases[bundle, (P[n_][0] -> _) :> n]];
];


(* Extract nominal bond yields from bundle: yield[n] = -P[n][0]/n *)
With[{P = $P},
    getNomBondYields[bundle_List] := Module[{maxN, yields},
        maxN = getMaxPIndex[bundle];
        If[maxN == 0, Return[{}]];
        yields = Table[
            {n, -N[(P[n][0] /. bundle) / n]},
            {n, 1, maxN}
        ];
        (* Filter out non-numeric values *)
        Select[yields, NumericQ[#[[2]]] &]
    ];
];


(* Create inline bar indicator *)
inlineBar[val_?NumericQ, minVal_, maxVal_, color_] := Module[
    {width, normalizedVal},
    normalizedVal = If[maxVal == minVal, 0.5, (val - minVal) / (maxVal - minVal)];
    width = Max[2, Round[40 * normalizedVal]];
    Graphics[
        {color, Rectangle[{0, 0}, {width, 8}]},
        ImageSize -> {45, 10},
        PlotRange -> {{0, 45}, {0, 10}},
        ImagePadding -> 0,
        PlotRangePadding -> 0
    ]
];


(* ::Subsection:: *)
(*Key coefficients table*)


(* Transposed layout: bundles as rows, coefficients as columns *)
keyCoeffsGrid[bundles_List, numStocks_Integer] := Module[
    {coeffNames, coeffLabels, headerRow, dataRows, allData, minMaxByCoeff},

    (* Build coefficient names: A[0], B[1][0], B[2][0], ... *)
    coeffNames = Join[{$A[0]}, Table[$B[j][0], {j, numStocks}]];
    coeffLabels = Join[
        {Style["A[0]", Bold, $aColor]},
        Table[Style["B[" <> ToString[j] <> "][0]", Bold, bColor[j]], {j, numStocks}]
    ];

    (* Header row: Solution | A[0] | B[1][0] | B[2][0] | ... *)
    headerRow = Join[{Style["Solution", Bold]}, coeffLabels];

    (* Extract values: allData[[coeff, bundle]] *)
    allData = Table[
        Table[getCoeffValue[bundle, coeff], {bundle, bundles}],
        {coeff, coeffNames}
    ];

    (* Compute min/max for each coefficient (for potential highlighting) *)
    minMaxByCoeff = Table[{Min[col], Max[col]}, {col, allData}];

    (* Build data rows - one row per bundle *)
    dataRows = Table[
        Join[
            {Style[ToString[i], Bold]},
            Table[formatValue[allData[[c, i]]], {c, Length[coeffNames]}]
        ],
        {i, Length[bundles]}
    ];

    (* Wrap in scrollable Pane matching coefficient panel height exactly *)
    Framed[
        Pane[
            Grid[
                Join[{headerRow}, dataRows],
                Alignment -> {Center, Center},
                Spacings -> {1.5, 0.5},
                Frame -> All,
                FrameStyle -> GrayLevel[0.7],
                Background -> {
                    None,
                    Join[{LightGray}, Table[If[OddQ[i], White, GrayLevel[0.97]], {i, Length[bundles]}]]
                },
                ItemStyle -> {Automatic, {Directive[Bold]}}
            ],
            ImageSize -> {Automatic, $coeffPanelHeight - 22},
            Scrollbars -> {False, Automatic},
            Alignment -> {Left, Top}
        ],
        FrameStyle -> GrayLevel[0.8],
        Background -> GrayLevel[0.98],
        FrameMargins -> 10,
        ImageSize -> {Automatic, $coeffPanelHeight}
    ]
];


(* ::Subsection:: *)
(*Coefficient selector*)


(* Format a list of solution indices compactly, e.g., {1,2,3,5,7,8,9} -> "1-3, 5, 7-9" *)
formatSolutionIndices[indices_List] := Module[
    {sorted, runs, formatRun},

    sorted = Sort[indices];
    If[Length[sorted] == 0, Return[""]];

    (* Split into consecutive runs *)
    runs = Split[sorted, #2 == #1 + 1 &];

    (* Format each run *)
    formatRun[run_List] := If[Length[run] == 1,
        ToString[First[run]],
        If[Length[run] == 2,
            ToString[First[run]] <> ", " <> ToString[Last[run]],
            ToString[First[run]] <> "-" <> ToString[Last[run]]
        ]
    ];

    StringRiffle[formatRun /@ runs, ", "]
];


(* Helper to build chart for a single coefficient *)
coeffChart[bundles_List, coeff_, chartColor_] := Module[
    {valuesWithIdx, grouped, uniqueVals, numericGroups},

    (* Get values with their solution indices *)
    valuesWithIdx = MapIndexed[
        {getCoeffValue[#1, coeff], First[#2]} &,
        bundles
    ];

    (* Group by value, keeping track of which solutions have each value *)
    grouped = GatherBy[valuesWithIdx, First];

    (* Extract unique values and their solution indices *)
    uniqueVals = Map[
        {#[[1, 1]], #[[All, 2]]} &,
        grouped
    ];

    (* Filter to only numeric values and sort by value *)
    numericGroups = Select[uniqueVals, NumericQ[First[#]] &];
    numericGroups = SortBy[numericGroups, First];

    If[Length[numericGroups] == 0,
        (* No numeric values *)
        Style["No numeric solutions for " <> formatCoeffName[coeff], Italic, Gray],

        (* Show grouped visualization *)
        Column[{
            Style[formatCoeffName[coeff] <> " — " <>
                  ToString[Length[numericGroups]] <> " unique value(s) across " <>
                  ToString[Length[bundles]] <> " solutions:", Italic],

            (* Bar chart and solutions legend side by side *)
            Row[{
                (* Bar chart with one bar per unique value *)
                BarChart[
                    numericGroups[[All, 1]],
                    ChartLabels -> Placed[
                        Map[
                            Tooltip[
                                formatValue[#[[1]]],
                                "Solutions: " <> formatSolutionIndices[#[[2]]]
                            ] &,
                            numericGroups
                        ],
                        Axis
                    ],
                    ChartStyle -> chartColor,
                    BarOrigin -> Left,
                    ImageSize -> {220, Max[80, Min[300, 25 * Length[numericGroups] + 40]]},
                    LabelStyle -> {FontSize -> 10},
                    Frame -> True,
                    FrameLabel -> {formatCoeffName[coeff], None},
                    PlotLabel -> None
                ],

                Spacer[10],

                (* Legend showing which solutions have each value *)
                Column[{
                    Style["Solutions by value:", Bold, 10],
                    Pane[
                        Grid[
                            Map[
                                {
                                    Style[formatValue[#[[1]]], Bold],
                                    " \[RightArrow] ",
                                    Style[
                                        If[Length[#[[2]]] == Length[bundles],
                                            "all solutions",
                                            formatSolutionIndices[#[[2]]]
                                        ],
                                        Gray
                                    ],
                                    Style[" (" <> ToString[Length[#[[2]]]] <> ")", Lighter[Gray]]
                                } &,
                                numericGroups
                            ],
                            Alignment -> Left,
                            Spacings -> {0.5, 0.3}
                        ],
                        ImageSize -> {Automatic, Min[150, 20 * Length[numericGroups] + 20]},
                        Scrollbars -> {False, Automatic}
                    ]
                }, Spacings -> 0.5]
            }, Alignment -> Top]
        }, Spacings -> 1]
    ]
];


(* Bond yield curve chart - one line per unique A[0] value with checkboxes *)
bondYieldChart[bundles_List] := Module[
    {valuesWithIdx, grouped, numericGroups, yieldData, colors},

    (* Get A[0] values with their bundle indices *)
    valuesWithIdx = MapIndexed[
        {getCoeffValue[#1, $A[0]], First[#2]} &,
        bundles
    ];

    (* Group by A[0] value *)
    grouped = GatherBy[valuesWithIdx, First];

    (* Extract unique A[0] values and their bundle indices *)
    numericGroups = Map[
        {#[[1, 1]], #[[All, 2]]} &,
        grouped
    ];

    (* Filter to only numeric A[0] values *)
    numericGroups = Select[numericGroups, NumericQ[First[#]] &];
    numericGroups = SortBy[numericGroups, First];

    If[Length[numericGroups] == 0,
        Return[Style["No bond data available", Italic, Gray]]
    ];

    (* For each unique A[0], get yields from the first bundle with that A[0] *)
    yieldData = Map[
        Function[{group},
            Module[{a0Val, bundleIdx, yields},
                a0Val = group[[1]];
                bundleIdx = First[group[[2]]];
                yields = getBondYields[bundles[[bundleIdx]]];
                If[Length[yields] == 0, Nothing, {a0Val, yields}]
            ]
        ],
        numericGroups
    ];

    If[Length[yieldData] == 0,
        Return[Style["No bond data available", Italic, Gray]]
    ];

    (* Generate colors for different A[0] values *)
    colors = Table[
        ColorData[97][i],
        {i, Length[yieldData]}
    ];

    (* Interactive chart with checkboxes *)
    DynamicModule[{visible = ConstantArray[True, Length[yieldData]]},
        Column[{
            (* Dynamic plot showing only selected curves *)
            Dynamic[
                Module[{selectedIdx, selectedData, selectedColors},
                    selectedIdx = Flatten[Position[visible, True]];
                    If[Length[selectedIdx] == 0,
                        Style["Select at least one curve", Italic, Gray],
                        selectedData = yieldData[[selectedIdx]];
                        selectedColors = colors[[selectedIdx]];
                        ListLinePlot[
                            Map[#[[2]] &, selectedData],
                            PlotStyle -> selectedColors,
                            PlotMarkers -> Automatic,
                            PlotLabel -> Style["Real Bond Yield Curve", Bold, 10],
                            ImageSize -> {380, 150},
                            Frame -> True,
                            FrameLabel -> {{"Real Yield (-R[n][0]/n)", None}, {"Maturity (n)", None}},
                            LabelStyle -> {FontSize -> 9}
                        ]
                    ]
                ]
            ],

            (* Checkboxes row *)
            Pane[
                Row[
                    MapIndexed[
                        Function[{data, idx},
                            Row[{
                                Checkbox[Dynamic[visible[[First[idx]]]]],
                                Style[
                                    " A[0]=" <> ToString[NumberForm[data[[1]], {Infinity, 2}]],
                                    colors[[First[idx]]],
                                    Bold,
                                    9
                                ]
                            }]
                        ],
                        yieldData
                    ],
                    Spacer[10]
                ],
                ImageSize -> {380, Automatic}
            ]
        }, Spacings -> 0.5]
    ]
];


(* Nominal bond yield curve chart - one line per unique A[0] value with checkboxes *)
nomBondYieldChart[bundles_List] := Module[
    {valuesWithIdx, grouped, numericGroups, yieldData, colors},

    (* Get A[0] values with their bundle indices *)
    valuesWithIdx = MapIndexed[
        {getCoeffValue[#1, $A[0]], First[#2]} &,
        bundles
    ];

    (* Group by A[0] value *)
    grouped = GatherBy[valuesWithIdx, First];

    (* Extract unique A[0] values and their bundle indices *)
    numericGroups = Map[
        {#[[1, 1]], #[[All, 2]]} &,
        grouped
    ];

    (* Filter to only numeric A[0] values *)
    numericGroups = Select[numericGroups, NumericQ[First[#]] &];
    numericGroups = SortBy[numericGroups, First];

    If[Length[numericGroups] == 0,
        Return[Style["No nominal bond data available", Italic, Gray]]
    ];

    (* For each unique A[0], get yields from the first bundle with that A[0] *)
    yieldData = Map[
        Function[{group},
            Module[{a0Val, bundleIdx, yields},
                a0Val = group[[1]];
                bundleIdx = First[group[[2]]];
                yields = getNomBondYields[bundles[[bundleIdx]]];
                If[Length[yields] == 0, Nothing, {a0Val, yields}]
            ]
        ],
        numericGroups
    ];

    If[Length[yieldData] == 0,
        Return[Style["No nominal bond data available", Italic, Gray]]
    ];

    (* Generate colors for different A[0] values *)
    colors = Table[
        ColorData[97][i],
        {i, Length[yieldData]}
    ];

    (* Interactive chart with checkboxes *)
    DynamicModule[{visible = ConstantArray[True, Length[yieldData]]},
        Column[{
            (* Dynamic plot showing only selected curves *)
            Dynamic[
                Module[{selectedIdx, selectedData, selectedColors},
                    selectedIdx = Flatten[Position[visible, True]];
                    If[Length[selectedIdx] == 0,
                        Style["Select at least one curve", Italic, Gray],
                        selectedData = yieldData[[selectedIdx]];
                        selectedColors = colors[[selectedIdx]];
                        ListLinePlot[
                            Map[#[[2]] &, selectedData],
                            PlotStyle -> selectedColors,
                            PlotMarkers -> Automatic,
                            PlotLabel -> Style["Nominal Bond Yield Curve", Bold, 10],
                            ImageSize -> {380, 150},
                            Frame -> True,
                            FrameLabel -> {{"Nominal Yield (-P[n][0]/n)", None}, {"Maturity (n)", None}},
                            LabelStyle -> {FontSize -> 9}
                        ]
                    ]
                ]
            ],

            (* Checkboxes row *)
            Pane[
                Row[
                    MapIndexed[
                        Function[{data, idx},
                            Row[{
                                Checkbox[Dynamic[visible[[First[idx]]]]],
                                Style[
                                    " A[0]=" <> ToString[NumberForm[data[[1]], {Infinity, 2}]],
                                    colors[[First[idx]]],
                                    Bold,
                                    9
                                ]
                            }]
                        ],
                        yieldData
                    ],
                    Spacer[10]
                ],
                ImageSize -> {380, Automatic}
            ]
        }, Spacings -> 0.5]
    ]
];


(* Standard panel size for coefficient charts *)
$coeffPanelWidth = 420;
$coeffPanelHeight = 480;

(* Horizontal divider for panel sections *)
panelDivider[] := Graphics[
    {GrayLevel[0.7], Line[{{0, 0}, {1, 0}}]},
    ImageSize -> {Full, 1},
    AspectRatio -> 1/100,
    PlotRangePadding -> 0
];

coeffSelector[bundles_List, numStocks_Integer] := Module[
    {maxAIdx, maxBIdxs, fixedA0Chart, panelStyle},

    maxAIdx = getMaxAIndex[First[bundles]];
    maxBIdxs = Table[getMaxBIndex[First[bundles], j], {j, numStocks}];

    (* Common panel wrapper for consistent sizing and wrapping alignment *)
    panelStyle[content_] := Pane[
        Framed[
            Pane[content,
                ImageSize -> {$coeffPanelWidth - 22, $coeffPanelHeight - 22},
                Scrollbars -> {False, Automatic},
                Alignment -> {Left, Top}
            ],
            FrameStyle -> GrayLevel[0.8],
            Background -> GrayLevel[0.98],
            FrameMargins -> 10,
            ImageSize -> {$coeffPanelWidth, $coeffPanelHeight}
        ],
        ImageSize -> {$coeffPanelWidth + 10, Automatic},
        BaselinePosition -> Top
    ];

    (* Fixed A[0] chart - always visible *)
    fixedA0Chart = panelStyle[
        Column[{
            (* Top section: coefficient chart *)
            Style["A[0]", Bold, 12, $aColor],
            coeffChart[bundles, $A[0], $aColor],

            (* Divider *)
            Spacer[10],
            panelDivider[],
            Spacer[10],

            (* Bottom section: bond yield curve *)
            bondYieldChart[bundles]
        }, Spacings -> 1]
    ];

    DynamicModule[{coeffType = "B", stockIdx = 1, coeffIdx = 0},
        Column[{
            (* Title *)
            Style["Compare Any Coefficient", Bold, 12],

            (* Side-by-side layout: fixed A[0] on left, selectable on right *)
            (* Pane with flexible width lets Row wrap when container is narrow *)
            Pane[
                Row[{
                    (* Left: Fixed A[0] *)
                    fixedA0Chart,

                    (* Right: Selectable coefficient - use same panelStyle *)
                    panelStyle[
                        Column[{
                            (* Top section: selectors and chart *)
                            Row[{
                                "Select: ",
                                PopupMenu[Dynamic[coeffType], {"A", "B"}],
                                Dynamic[If[coeffType == "B",
                                    Row[{" Stock: ", PopupMenu[Dynamic[stockIdx], Range[numStocks]]}],
                                    ""
                                ]],
                                " Coefficient: ",
                                Dynamic[PopupMenu[
                                    Dynamic[coeffIdx],
                                    Range[0, If[coeffType == "A", maxAIdx, maxBIdxs[[stockIdx]]]]
                                ]]
                            }, Spacer[5]],

                            (* Dynamic chart *)
                            Dynamic[Module[{coeff, chartColor},
                                coeff = If[coeffType == "A", $A[coeffIdx], $B[stockIdx][coeffIdx]];
                                chartColor = If[coeffType == "A", $aColor, bColor[stockIdx]];
                                coeffChart[bundles, coeff, chartColor]
                            ]],

                            (* Divider *)
                            Spacer[10],
                            panelDivider[],
                            Spacer[10],

                            (* Bottom section: nominal bond yield curve *)
                            nomBondYieldChart[bundles]
                        }, Spacings -> 1]
                    ]
                }, Alignment -> Top],
                ImageSize -> {{$coeffPanelWidth, Full}, Automatic}
            ]
        }, Spacings -> 1]
    ]
];


(* ::Subsection:: *)
(*Bundle details section*)


(* Width per solution item for column calculation *)
$solutionItemWidth = 300;

bundleDetails[results_List] := Module[{bundles, numBundles, solutionItems},
    bundles = extractBundles[results];
    numBundles = Length[bundles];

    (* Create individual solution items with fixed width for consistent wrapping *)
    solutionItems = Table[
        Pane[
            OpenerView[{
                Style["Solution " <> ToString[i], Bold],
                formatBundleDetail[bundles[[i]], results, i]
            }, False],
            ImageSize -> {$solutionItemWidth, Automatic},
            Alignment -> {Left, Top},
            BaselinePosition -> Top
        ],
        {i, numBundles}
    ];

    OpenerView[{
        Style["Solution Details (Signs, All Coefficients)", Bold],
        (* Resizable pane with wrapping row - no spacer for consistent column alignment *)
        Pane[
            Row[solutionItems, Alignment -> Top],
            ImageSize -> {{300, Full}, {200, Full}},
            Scrollbars -> Automatic,
            AppearanceElements -> {"ResizeArea"}
        ]
    }, False]
];


formatBundleDetail[bundle_List, results_List, bundleIdx_Integer] := Module[
    {aCoeffs, bCoeffs, numStocks, formatCoeffList},

    numStocks = getNumStocks[results];

    (* Extract A coefficients: rules where head is $A *)
    aCoeffs = Select[bundle, Head[#[[1]]] === $A &];

    (* Extract B[j] coefficients: rules where head is $B[j] *)
    bCoeffs = Table[
        With[{jj = j}, Select[bundle, Head[#[[1]]] === $B[jj] &]],
        {j, numStocks}
    ];

    (* Helper to format a list of coefficient rules as rows *)
    formatCoeffList[rules_List] := If[Length[rules] == 0,
        {{"(none)"}},
        Map[{formatCoeffName[#[[1]]], " = ", formatValue[#[[2]]]} &, rules]
    ];

    Column[{
        (* A coefficients *)
        Style["A Coefficients:", Bold, $aColor],
        Grid[formatCoeffList[aCoeffs], Alignment -> Left, Spacings -> {0.5, 0.3}],

        (* B coefficients per stock *)
        Sequence @@ Table[
            Column[{
                Style["B[" <> ToString[j] <> "] Coefficients:", Bold, bColor[j]],
                Grid[formatCoeffList[bCoeffs[[j]]], Alignment -> Left, Spacings -> {0.5, 0.3}]
            }],
            {j, numStocks}
        ]
    }, Spacings -> 1, Frame -> True, FrameStyle -> GrayLevel[0.85],
       FrameMargins -> 5, Background -> White]
];


(* ::Subsection:: *)
(*Main function*)


visualizeCoeffs[results_List, opts : OptionsPattern[]] := Module[
    {bundles, numStocks, showSelector, showDetails, elements, keyCoeffsPanel, selectorPanel},

    (* Get options *)
    showSelector = OptionValue["ShowSelector"];
    showDetails = OptionValue["ShowDetails"];

    (* Extract data *)
    bundles = extractBundles[results];
    numStocks = getNumStocks[results];

    (* Handle empty results *)
    If[Length[bundles] == 0,
        Return[Style["No solutions found.", Italic, Red]]
    ];

    (* Build key coefficients panel - Spacings -> 1 matches coeffSelector *)
    keyCoeffsPanel = Column[{
        Style["Key Coefficients (A[0], B[j][0])", Bold, 12],
        keyCoeffsGrid[bundles, numStocks]
    }, Spacings -> 1];

    (* Build elements list *)
    elements = {
        (* Title *)
        Style["Coefficient Solutions Comparison", Bold, 14],
        Style[ToString[Length[bundles]] <> " solutions, " <>
              ToString[numStocks] <> " stock(s)", Italic, Gray],
        Spacer[10]
    };

    (* Add key coefficients and selector side by side if selector enabled *)
    If[showSelector,
        selectorPanel = coeffSelector[bundles, numStocks];
        AppendTo[elements, Row[{keyCoeffsPanel, Spacer[20], selectorPanel}, Alignment -> Top]];
        ,
        (* Just key coefficients if selector disabled *)
        AppendTo[elements, keyCoeffsPanel];
    ];

    (* Add bundle details if enabled *)
    If[showDetails,
        AppendTo[elements, Spacer[15]];
        AppendTo[elements, bundleDetails[results]];
    ];

    (* Assemble view with resizable pane *)
    Pane[
        Panel[
            Column[elements, Spacings -> 0.5, Alignment -> Left],
            ImageMargins -> 10,
            FrameMargins -> 15
        ],
        ImageSize -> {{400, Full}, {300, Full}},
        Scrollbars -> Automatic,
        AppearanceElements -> {"ResizeArea"}
    ]
];


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
