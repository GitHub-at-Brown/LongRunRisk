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
    "Includes an interactive selector to compare any coefficient across bundles.\n" <>
    "Options:\n" <>
    "  \"ShowSelector\" -> True - show interactive coefficient selector\n" <>
    "  \"ShowDetails\" -> True - show collapsible bundle details";


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


(* Format value to 2 decimal places *)
formatValue[val_?NumericQ] := NumberForm[N[val], {Infinity, 2}];
formatValue[val_] := val;

(* Format coefficient name without context - use With to inject symbols *)
With[{A = $A, B = $B},
    formatCoeffName[A[n_]] := "A[" <> ToString[n] <> "]";
    formatCoeffName[B[j_][n_]] := "B[" <> ToString[j] <> "][" <> ToString[n] <> "]";
];
formatCoeffName[other_] := ToString[other];


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


keyCoeffsGrid[bundles_List, numStocks_Integer] := Module[
    {coeffNames, headerRow, dataRows, allData, minMaxByRow},

    (* Build coefficient names: A[0], B[1][0], B[2][0], ... *)
    coeffNames = Join[{$A[0]}, Table[$B[j][0], {j, numStocks}]];

    (* Header row *)
    headerRow = Join[
        {"Coeff"},
        Table[Style["Bundle " <> ToString[i], Bold], {i, Length[bundles]}],
        {""}  (* for bar column *)
    ];

    (* Extract values for each coefficient across all bundles *)
    allData = Table[
        Table[getCoeffValue[bundle, coeff], {bundle, bundles}],
        {coeff, coeffNames}
    ];

    (* Compute min/max for each row for bar scaling *)
    minMaxByRow = Table[{Min[row], Max[row]}, {row, allData}];

    (* Build data rows *)
    dataRows = Table[
        With[{
            coeff = coeffNames[[i]],
            values = allData[[i]],
            minVal = minMaxByRow[[i, 1]],
            maxVal = minMaxByRow[[i, 2]],
            rowColor = If[i == 1, $aColor, bColor[i - 1]]
        },
            Join[
                {Style[formatCoeffName[coeff], Bold, rowColor]},
                Table[formatValue[val], {val, values}],
                {inlineBar[Max[values], minVal, maxVal, rowColor]}
            ]
        ],
        {i, Length[coeffNames]}
    ];

    (* Assemble grid *)
    Grid[
        Join[{headerRow}, dataRows],
        Alignment -> {Center, Center},
        Spacings -> {1.5, 0.8},
        Frame -> All,
        FrameStyle -> GrayLevel[0.7],
        Background -> {
            None,
            Join[{LightGray}, Table[If[OddQ[i], White, GrayLevel[0.95]], {i, Length[coeffNames]}]]
        },
        ItemStyle -> {Automatic, {Directive[Bold]}}
    ]
];


(* ::Subsection:: *)
(*Coefficient selector*)


coeffSelector[bundles_List, numStocks_Integer] := Module[
    {maxAIdx, maxBIdxs},

    maxAIdx = getMaxAIndex[First[bundles]];
    maxBIdxs = Table[getMaxBIndex[First[bundles], j], {j, numStocks}];

    DynamicModule[{coeffType = "A", stockIdx = 1, coeffIdx = 0},
        Column[{
            (* Title *)
            Style["Compare Any Coefficient", Bold, 12],

            (* Selectors row *)
            Row[{
                "Select: ",
                PopupMenu[Dynamic[coeffType], {"A", "B"}],
                Dynamic[If[coeffType == "B",
                    Row[{" Stock: ", PopupMenu[Dynamic[stockIdx], Range[numStocks]]}],
                    ""
                ]],
                " Index: ",
                Dynamic[PopupMenu[
                    Dynamic[coeffIdx],
                    Range[0, If[coeffType == "A", maxAIdx, maxBIdxs[[stockIdx]]]]
                ]]
            }, Spacer[5]],

            (* Bar chart *)
            Dynamic[Module[{coeff, values, maxVal, barData},
                coeff = If[coeffType == "A", $A[coeffIdx], $B[stockIdx][coeffIdx]];
                values = Table[getCoeffValue[bundle, coeff], {bundle, bundles}];
                maxVal = Max[Abs[values]];

                barData = MapIndexed[
                    {First[#2], #1} &,
                    values
                ];

                Column[{
                    Style[formatCoeffName[coeff] <> " across bundles:", Italic],
                    BarChart[
                        values,
                        ChartLabels -> Table["B" <> ToString[i], {i, Length[bundles]}],
                        ChartStyle -> If[coeffType == "A", $aColor, bColor[stockIdx]],
                        BarOrigin -> Left,
                        ImageSize -> {400, Min[200, 25 * Length[bundles]]},
                        LabelStyle -> {FontSize -> 10},
                        Frame -> True,
                        FrameLabel -> {None, formatCoeffName[coeff]},
                        PlotLabel -> None
                    ],
                    (* Value table *)
                    Grid[
                        {Join[{"Bundle"}, Range[Length[bundles]]],
                         Join[{"Value"}, formatValue /@ values]},
                        Frame -> All,
                        FrameStyle -> GrayLevel[0.8],
                        Alignment -> Center,
                        Spacings -> {1, 0.5}
                    ]
                }, Spacings -> 1]
            ]]
        }, Spacings -> 1, Frame -> True, FrameStyle -> GrayLevel[0.8],
           Background -> GrayLevel[0.98], FrameMargins -> 10]
    ]
];


(* ::Subsection:: *)
(*Bundle details section*)


bundleDetails[results_List] := Module[{bundles, numBundles},
    bundles = extractBundles[results];
    numBundles = Length[bundles];

    OpenerView[{
        Style["Bundle Details (Signs, All Coefficients)", Bold],
        Column[
            Table[
                OpenerView[{
                    Style["Bundle " <> ToString[i], Bold],
                    formatBundleDetail[bundles[[i]], results, i]
                }, False],
                {i, numBundles}
            ],
            Spacings -> 0.5
        ]
    }, False]
];


formatBundleDetail[bundle_List, results_List, bundleIdx_Integer] := With[
    {A = $A, B = $B},
    Module[{aCoeffs, bCoeffs, numStocks},
        numStocks = getNumStocks[results];
        aCoeffs = Cases[bundle, (A[_] -> _)];
        bCoeffs = Table[With[{jj = j}, Cases[bundle, (B[jj][_] -> _)]], {j, numStocks}];

    Column[{
        (* A coefficients *)
        Style["A Coefficients:", Bold, $aColor],
        Grid[
            Partition[
                Flatten[{formatCoeffName[#[[1]]], " = ", formatValue[#[[2]]]} & /@ aCoeffs],
                3
            ],
            Alignment -> Left,
            Spacings -> {0.5, 0.3}
        ],

        (* B coefficients per stock *)
        Sequence @@ Table[
            Column[{
                Style["B[" <> ToString[j] <> "] Coefficients:", Bold, bColor[j]],
                Grid[
                    Partition[
                        Flatten[{formatCoeffName[#[[1]]], " = ", formatValue[#[[2]]]} & /@ bCoeffs[[j]]],
                        3
                    ],
                    Alignment -> Left,
                    Spacings -> {0.5, 0.3}
                ]
            }],
            {j, numStocks}
        ]
    }, Spacings -> 1, Frame -> True, FrameStyle -> GrayLevel[0.85],
       FrameMargins -> 5, Background -> White]
    ] (* Module *)
]; (* With *)


(* ::Subsection:: *)
(*Main function*)


visualizeCoeffs[results_List, opts : OptionsPattern[]] := Module[
    {bundles, numStocks, showSelector, showDetails},

    (* Get options *)
    showSelector = OptionValue["ShowSelector"];
    showDetails = OptionValue["ShowDetails"];

    (* Extract data *)
    bundles = extractBundles[results];
    numStocks = getNumStocks[results];

    (* Handle empty results *)
    If[Length[bundles] == 0,
        Return[Style["No solution bundles found.", Italic, Red]]
    ];

    (* Assemble view *)
    Panel[
        Column[{
            (* Title *)
            Style["Coefficient Solutions Comparison", Bold, 14],
            Style[ToString[Length[bundles]] <> " solution bundles, " <>
                  ToString[numStocks] <> " stock(s)", Italic, Gray],

            (* Key coefficients table *)
            Spacer[10],
            Style["Key Coefficients (A[0], B[j][0])", Bold, 12],
            keyCoeffsGrid[bundles, numStocks],

            (* Coefficient selector *)
            If[showSelector,
                Sequence[Spacer[15], coeffSelector[bundles, numStocks]],
                Nothing
            ],

            (* Bundle details *)
            If[showDetails,
                Sequence[Spacer[15], bundleDetails[results]],
                Nothing
            ]
        }, Spacings -> 0.5, Alignment -> Left],

        ImageMargins -> 10,
        FrameMargins -> 15
    ]
];


(* ::Section::Closed:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
