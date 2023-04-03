BeginTestSection["PacletizeResources"]


VerificationTest[
	Information["MaTeX", LongForm -> False]
	,
	InformationData[
		<|
			"ObjectType" -> "Symbol", "Usage" -> "MaTeX[\"texcode\"] compiles texcode using LaTeX and returns the result as Mathematica graphics.  texcode must be valid inline math-mode LaTeX code.\nMaTeX[expression] converts expression to LaTeX using TeXForm, then compiles it and returns the result.\nMaTeX[{expr1, expr2, \[Ellipsis]}] processes all expressions while running LaTeX only once.  A list of results is returned.",
			"Documentation" -> <|"Local" -> "paclet:MaTeX/ref/MaTeX"|>,
			"OwnValues" -> None, "UpValues" -> None, "DownValues" -> Information`InformationValueForm[
				DownValues, MaTeX`MaTeX, {
					MaTeX`MaTeX[MaTeX`Private`tex:{__String}, MaTeX`Private`opt:OptionsPattern[]] :> Module[{MaTeX`Private`basepreamble, MaTeX`Private`preamble, MaTeX`Private`mag, MaTeX`Private`results, MaTeX`Private`trimmedTeX},
						If[!MaTeX`Private`$configOK,
							MaTeX`Private`checkConfig[];
							Return[$Failed]
						];
						MaTeX`Private`preamble = OptionValue @ "Preamble";
						If[SameQ[MaTeX`Private`preamble, None], MaTeX`Private`preamble = {}];
						If[!VectorQ[MaTeX`Private`preamble, StringQ],
							Message[MaTeX`MaTeX::invopt, "Preamble" -> MaTeX`Private`preamble];
							Return[$Failed]
						];
						MaTeX`Private`basepreamble = OptionValue @ "BasePreamble";
						If[SameQ[MaTeX`Private`basepreamble, None], MaTeX`Private`basepreamble = {}];
						If[!VectorQ[MaTeX`Private`basepreamble, StringQ],
							Message[MaTeX`MaTeX::invopt, "BasePreamble" -> MaTeX`Private`basepreamble];
							Return[$Failed]
						];
						MaTeX`Private`preamble = Join[MaTeX`Private`basepreamble, MaTeX`Private`preamble];
						If[!BooleanQ[OptionValue @ "DisplayStyle"],
							Message[MaTeX`MaTeX::invopt, "DisplayStyle" -> OptionValue["DisplayStyle"]];
							Return[$Failed]
						];
						If[!BooleanQ[OptionValue @ ContentPadding],
							Message[MaTeX`MaTeX::invopt, ContentPadding -> OptionValue[ContentPadding]];
							Return[$Failed]
						];
						If[
							Not[
								And[
									NumericQ[OptionValue @ FontSize],
									TrueQ[Positive @ OptionValue @ FontSize]
								]
							],
							Message[MaTeX`MaTeX::invopt, FontSize -> OptionValue[FontSize]];
							Return[$Failed]
						];
						If[
							Not[
								MatchQ[
									OptionValue @ LineSpacing,
									Condition[
										{MaTeX`Private`mult_, MaTeX`Private`add_},
										And[NumericQ[MaTeX`Private`mult], TrueQ[NonNegative @ MaTeX`Private`mult], NumericQ[MaTeX`Private`add]]
									]
								]
							],
							Message[MaTeX`MaTeX::invopt, LineSpacing -> OptionValue[LineSpacing]];
							Return[$Failed]
						];
						MaTeX`Private`mag = OptionValue @ Magnification;
						If[Not[And[NumericQ[MaTeX`Private`mag], TrueQ[Positive @ MaTeX`Private`mag]]],
							Message[MaTeX`MaTeX::invopt, Magnification -> MaTeX`Private`mag];
							Return[$Failed]
						];
						MaTeX`Private`trimmedTeX = StringTrim[MaTeX`Private`tex, "\n"..];
						Map[MaTeX`Private`checkForCommonErrors, MaTeX`Private`trimmedTeX];
						MaTeX`Private`results = MaTeX`Private`iMaTeX[MaTeX`Private`trimmedTeX,
							MaTeX`Private`preamble, OptionValue @ "DisplayStyle", OptionValue @ FontSize, OptionValue @ ContentPadding,
							OptionValue @ LineSpacing, OptionValue @ "LogFileFunction", OptionValue @ "TeXFileFunction"
						];
						If[Or[SameQ[MaTeX`Private`results, $Failed], TrueQ[Equal[MaTeX`Private`mag, 1]]],
							MaTeX`Private`results,
							Map[
								Function[
									Show[#, ImageSize -> (N[MaTeX`Private`mag] * MaTeX`Private`extractOption[#, ImageSize])]
								],
								MaTeX`Private`results
							]
						]
					],
					MaTeX`MaTeX[{}, MaTeX`Private`opt:OptionsPattern[]] :> {},
					MaTeX`MaTeX[MaTeX`Private`tex_List, MaTeX`Private`opt:OptionsPattern[]] :> MaTeX`MaTeX[Map[MaTeX`Developer`Texify, MaTeX`Private`tex], MaTeX`Private`opt],
					MaTeX`MaTeX[MaTeX`Private`tex_, MaTeX`Private`opt:OptionsPattern[]] :> With[{MaTeX`Private`result = MaTeX`MaTeX[{MaTeX`Private`tex}, MaTeX`Private`opt]},
						If[SameQ[MaTeX`Private`result, $Failed], $Failed, First @ MaTeX`Private`result]
					]
				}
			],
			"SubValues" -> None, "DefaultValues" -> Information`InformationValueForm[
				DefaultValues, MaTeX`MaTeX, {SyntaxInformation[MaTeX`MaTeX] -> {"ArgumentsPattern" -> {_, OptionsPattern[]}}}
			],
			"NValues" -> None, "FormatValues" -> None, "Options" -> {
				"BasePreamble" -> {"\\usepackage{lmodern,exscale}", "\\usepackage{amsmath,amssymb}"},
				"Preamble" -> {},
				"DisplayStyle" -> True, ContentPadding -> True, LineSpacing -> {1.2, 0},
				FontSize -> 12, Magnification -> 1, "LogFileFunction" -> None, "TeXFileFunction" -> None
			},
			"Attributes" -> {},
			"FullName" -> "MaTeX`MaTeX"
		|>,
		False
	]
	,
	{}
	,
	TestID->"PacletizeResources_20230402-XJX9SJ"
]


VerificationTest[
	MaTeX`MaTeX @ "x^2"
	,
	Graphics[
		{
			Thickness @ 0.07473841554559042,
			Style[
				{
					FilledCurve[
						{
							{
								{1, 4, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{0, 1, 0},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{0, 1, 0},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3}
							}
						},
						{
							{
								{6.721879999999999, 7.00469},
								{6.721879999999999, 7.064060000000001},
								{6.673439999999999, 7.112499999999997},
								{6.603129999999999, 7.112499999999997},
								{6.49531, 7.112499999999997},
								{6.48281, 7.051559999999999},
								{6.446879999999999, 6.956250000000001},
								{6.1265600000000004, 5.907810000000001},
								{5.434379999999999, 5.418749999999999},
								{4.89844, 5.418749999999999},
								{4.481249999999999, 5.418749999999999},
								{4.254689999999999, 5.7296900000000015},
								{4.254689999999999, 6.2171899999999996},
								{4.254689999999999, 6.4796900000000015},
								{4.301559999999999, 6.67031},
								{4.49219, 7.4578099999999985},
								{4.90938, 9.07813},
								{5.08906, 9.793750000000003},
								{5.4937499999999995, 10.318799999999998},
								{6.04219, 10.318799999999998},
								{6.042189999999999, 10.318799999999996},
								{6.3999999999999995, 10.318799999999998},
								{6.649999999999999, 10.1641},
								{6.26875, 10.092199999999998},
								{6.1265600000000004, 9.806249999999999},
								{6.1265600000000004, 9.57969},
								{6.1265600000000004, 9.293750000000001},
								{6.351559999999999, 9.19844},
								{6.518750000000001, 9.19844},
								{6.876560000000001, 9.19844},
								{7.126560000000001, 9.507809999999997},
								{7.126560000000001, 9.82969},
								{7.126560000000001, 10.329700000000003},
								{6.55469, 10.5563},
								{6.05469, 10.5563},
								{5.326560000000001, 10.5563},
								{4.921880000000001, 9.842190000000002},
								{4.8140600000000004, 9.615629999999998},
								{4.540629999999999, 10.5094},
								{3.8015600000000003, 10.5563},
								{3.5875000000000004, 10.5563},
								{2.3703099999999995, 10.5563},
								{1.7265599999999992, 8.995310000000002},
								{1.7265599999999992, 8.732809999999999},
								{1.7265599999999992, 8.68594},
								{1.7749999999999997, 8.62656},
								{1.8578099999999997, 8.62656},
								{1.9531299999999998, 8.62656},
								{1.9781299999999995, 8.696879999999998},
								{2.0015599999999996, 8.745310000000002},
								{2.40625, 10.068799999999998},
								{3.2046899999999994, 10.318799999999998},
								{3.5515600000000003, 10.318799999999998},
								{4.0874999999999995, 10.318799999999998},
								{4.195309999999999, 9.817189999999998},
								{4.195309999999999, 9.531249999999998},
								{4.195309999999999, 9.268749999999999},
								{4.1234399999999996, 8.995310000000002},
								{3.97969, 8.42344},
								{3.5749999999999993, 6.790629999999999},
								{3.3953100000000003, 6.074999999999999},
								{3.05, 5.418749999999999},
								{2.4187499999999997, 5.418749999999999},
								{2.35938, 5.418749999999999},
								{2.06094, 5.418749999999999},
								{1.8109399999999998, 5.57344},
								{2.23906, 5.657810000000001},
								{2.33438, 6.01563},
								{2.33438, 6.1578100000000004},
								{2.33438, 6.3968799999999995},
								{2.1562499999999996, 6.539059999999999},
								{1.92969, 6.539059999999999},
								{1.6437499999999998, 6.539059999999999},
								{1.33438, 6.289059999999999},
								{1.33438, 5.907810000000001},
								{1.33438, 5.407810000000001},
								{1.8937499999999998, 5.1812499999999995},
								{2.40625, 5.1812499999999995},
								{2.97813, 5.1812499999999995},
								{3.3843799999999997, 5.63438},
								{3.634379999999999, 6.12188},
								{3.8249999999999993, 5.418749999999999},
								{4.421880000000001, 5.1812499999999995},
								{4.862500000000001, 5.1812499999999995},
								{6.07813, 5.1812499999999995},
								{6.721879999999999, 6.74219},
								{6.721879999999999, 7.00469}
							}
						}
					],
					FilledCurve[
						{
							{
								{0, 2, 0},
								{1, 3, 3},
								{1, 3, 3},
								{0, 1, 0},
								{0, 1, 0},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{1, 3, 3},
								{0, 1, 0},
								{1, 3, 3},
								{0, 1, 0},
								{0, 1, 0}
							}
						},
						{
							{
								{11.3906, 11.6219},
								{11.143799999999999, 11.6219},
								{11.1203, 11.464100000000002},
								{11.0563, 11.065599999999998},
								{10.960899999999999, 10.915599999999998},
								{10.9141, 10.8516},
								{10.3094, 10.8516},
								{10.1828, 10.8516},
								{8.768749999999999, 10.8516},
								{9.840629999999999, 11.8219},
								{9.96875, 11.9406},
								{10.3016, 12.2031},
								{10.4297, 12.3141},
								{10.9219, 12.767199999999997},
								{11.3906, 13.2047},
								{11.3906, 13.9266},
								{11.3906, 14.873399999999997},
								{10.595300000000002, 15.4844},
								{9.60313, 15.4844},
								{8.648439999999999, 15.4844},
								{8.021880000000001, 14.7609},
								{8.021880000000001, 14.054699999999997},
								{8.021880000000001, 13.665599999999998},
								{8.331249999999999, 13.6094},
								{8.442190000000002, 13.6094},
								{8.60938, 13.6094},
								{8.856250000000001, 13.728099999999998},
								{8.856250000000001, 14.029699999999998},
								{8.856250000000001, 14.443800000000003},
								{8.45781, 14.443800000000003},
								{8.362499999999997, 14.443800000000003},
								{8.59375, 15.023399999999995},
								{9.12656, 15.221899999999998},
								{9.51563, 15.221899999999998},
								{10.2547, 15.221899999999998},
								{10.6359, 14.595300000000002},
								{10.6359, 13.9266},
								{10.6359, 13.100000000000001},
								{10.0563, 12.4969},
								{9.117189999999999, 11.5344},
								{8.117189999999999, 10.5016},
								{8.021880000000001, 10.4141},
								{8.021880000000001, 10.398400000000002},
								{8.021880000000001, 10.2},
								{11.160899999999998, 10.2},
								{11.3906, 11.6219}
							}
						}
					]
				},
				Thickness @ 0.07473841554559042
			]
		},
		{
			ImageSize -> {13.376866749688668, 16.368856787048568},
			BaselinePosition -> Scaled[0.3237956353650342],
			ImageSize -> {14., 17.},
			PlotRange -> {{0., 13.38}, {0., 16.37}},
			AspectRatio -> Automatic
		}
	]
	,
	{}
	,
	TestID->"PacletizeResources_20230402-JS6LCB"
]


VerificationTest[
	SameQ[PacletFind @ "MaTeX*", {}]
	,
	False
	,
	{}
	,
	TestID->"PacletizeResources_20230402-DN2754"
]


VerificationTest[
	MemberQ[$ContextPath, "MaTeX`"]
	,
	True
	,
	{}
	,
	TestID->"PacletizeResources_20230402-2PQII2"
]


VerificationTest[
	MemberQ[$Packages, "MaTeX`"]
	,
	True
	,
	{}
	,
	TestID->"PacletizeResources_20230402-VN8KXR"
]


EndTestSection[]
