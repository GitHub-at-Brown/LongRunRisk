(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`NiceOutput`"]


(* ::Subsection:: *)
(*Public symbols*)


info


(* ::Subsubsection:: *)
(*Usage*)


info::usage = "info[models] displays a table with information for each model in the association models.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsubsection:: *)
(*Usage*)


modelToTeX::usage = "Association between the Mathematica variables that represent parameters of the model and their LATEX representation";
TeXToModel::usage = "Association of LATEX strings for parameters of the model and the name of the corresponding Mathematica variable";

formatModels::usage = "formatModels[models] Re-writes an association of models as a Cell object with nice formatting
	that can be directly pasted into a notebook. \n
	To automatically write the output of formatModels[models] into a cell in a new notebook that can be copied and pasted,
	run 
		nb=CreateNotebook[];
		modelsRaw = toCatalog[models,{\"name\",\"shortname\",\"bibRef\",\"desc\",\"stateVars\",\"parameters\"}];\[IndentingNewLine]		content=formatModels[modelsRaw];\[IndentingNewLine]		NotebookWrite[nb, content];\[IndentingNewLine]\[IndentingNewLine]		SelectionMove[nb, All, Notebook];\[IndentingNewLine]		FrontEndTokenExecute[nb, \"ClearCellOptions\"];
	The last two lines clear all cell formatting (needed to make the cell executable for some reason).
"
modelFormattingTemplate::usage = "modelFormattingTemplate[model] Re-writes model as a Cell object with nice formatting.
	To automatically write the output of modelFormattingTemplate[model] into a cell that can be copied and pasted,
	run 
		nb=CreateNotebook[];
		NotebookWrite[nb,modelFormattingTemplate[model]];
	To write all models in Kernel/Model/Catalog.wl using the nice formatting, run
		nb=CreateNotebook[];
		NotebookWrite[nb,modelFormattingTemplate[models[#]]]&/@Keys[models];
"

toCatalog::usage = "toCatalog[models, {key_1, key_2, ...}] re-writes an association of models so that each model contains only 
	the elements with keys `keys_i` and, if `key_i` is \"stateVars\" and has head Function, 
	replace its value `val_i` by `val_i[t]`.
"


(* ::Subsection:: *)
(*Load packages*)


<<FernandoDuarte`LongRunRisk`Model`Parameters`;
<<FernandoDuarte`LongRunRisk`Model`Shocks`;
<<FernandoDuarte`LongRunRisk`Model`ExogenousEq`;
$ContextPath=AppendTo[$ContextPath,"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"];
<<FernandoDuarte`LongRunRisk`Model`Catalog`;
<<FernandoDuarte`LongRunRisk`Model`EndogenousEq`;
<<FernandoDuarte`LongRunRisk`Model`ProcessModels`;
<<FernandoDuarte`LongRunRisk`Tools`WriteToMatlab`;
<<PacletizedResourceFunctions`;
<<MaTeX`;


(* ::Subsection::Closed:: *)
(*Helper functions*)


(* ::Subsubsection::Closed:: *)
(*Usage*)





(* ::Subsubsection::Closed:: *)
(*createEqTables*)


createEqTables[m_]:=Module[
	(*adds nicely formatted tables with exogenous equations to each model in m*)
	{
		keys=Keys[m],
		models = KeyMap[Replace[#, Thread[Keys[m]->Values@(#["shortname"]&/@m) ] ]&,m],(*rename Keys to shortname*)
		ContextPath=$ContextPath,
		lhs,
		rhs,
		exoNiceOutput,
		exoNiceOutputN
	},
	(*functions to extract and format left-hand side and right-hand side of equations for exogenous variables*)
	lhs[model_]:=Join[
		Evaluate[Symbol[StringDrop[#,-2]][t]&/@Cases[model["exogenousVars"],Except["ddeq"]]]
		,
		Table[dd[t,j],{j,1,model["numStocks"]}]
	];
	rhs[model_]:=lhs[model]/.Normal@model["exogenousEq"];
	exoNiceOutput=OpenerView[
		{
			"Exogenous variables", 
			Grid[
				Thread[{Thread[lhs[#]==rhs[#]]}],
				Alignment -> Left,
				ItemSize -> {Automatic, 2},
				Frame -> {False, All}, 
				FrameStyle -> Directive[Thin],
				Background->White
			]
		},
	True]&/@ models;
		
	exoNiceOutputN=OpenerView[
		{
			"Exogenous variables evaluated at initial parameter values", 
			Grid[
				Thread[{Thread[lhs[#]==rhs[#]]}]//.#["parameters"],
				Alignment -> Left,
				ItemSize -> {Automatic, 2},
				Frame -> {False, All}, 
				FrameStyle -> Directive[Thin],
				Background->White
			]
		},
	False]&/@ models;

	models=(Append[#, "exogenousEqTable"->exoNiceOutput[#["shortname"]] ]&) /@models;
	models=(Append[#, "exogenousEqTableNumeric"->exoNiceOutputN[#["shortname"]] ]&) /@models;
	
	(*restore $ContextPath to initial state*)
	$ContextPath=ContextPath;

	(*restore original keys and output models*)
	KeyMap[Replace[#,Thread[Keys[models]->keys]]&,models]
];


(* ::Subsection:: *)
(*info*)


info[m_Association] := Column[(infoTable@#&)/@(Values@createEqTables[m])];


(* ::Subsubsection:: *)
(*infoTable*)


bibFile="FernandoDuarte/LongRunRisk/BibTeX/references.bib";


infoTable[m_]:=OpenerView[
	{
		m["shortname"],
		Grid[
			Join[
				{{"Model: "<>StringDelete[StringReplace[m["name"],"\n"->" "],"\t"|"  "],SpanFromLeft,SpanFromLeft,SpanFromLeft,SpanFromLeft}},
				{{Row[{"Reference: ","\\textcite{"<>m["bibRef"]<>"} in ", If[Not[$Failed===FindFile[bibFile]],Hyperlink["references.bib",File@FindFile@bibFile],"Resources/BibTeX/references.bib"  ]}],SpanFromLeft,SpanFromLeft,SpanFromLeft,SpanFromLeft}},(*MaTeX["\\text{\\textcite{"<>m["bibRef"]<>"}}","Preamble"->preambleTeX,"DisplayStyle"->True,FontSize->14]*)
				{{"Description: "<>StringDelete[StringReplace[m["desc"],"\n"->" "],"\t"|"  "],SpanFromLeft,SpanFromLeft,SpanFromLeft,SpanFromLeft}},
				{{m["exogenousEqTable"],SpanFromLeft,SpanFromLeft,SpanFromLeft,SpanFromLeft}},
				{{m["exogenousEqTableNumeric"],SpanFromLeft,SpanFromLeft,SpanFromLeft,SpanFromLeft}},
				{{paramTable[m],SpanFromLeft,SpanFromLeft,SpanFromLeft,SpanFromLeft}},
				{{allParamTable[m],SpanFromLeft,SpanFromLeft,SpanFromLeft,SpanFromLeft}}
			],
			Alignment->Left,
			Spacings->{2,1},
			Frame->All,
			Background->{
				{None,None},
				{
					(*row 1*)White,
					(*row 2*)White,
					(*row 3*)White,
					(*row 4*)White,
					(*row 5*)LightBlue,
					(*row 6*)LightGray
				}
			},
			ItemStyle->{
				{},
				{
					(*row 1*)Directive[{"Text",Black,Bold,FontFamily->"Times"}],
					(*row 2*)"Text",
					(*row 3*)"Text",
					(*row 4*)"Text",
					(*row 5*)"Text",
					(*row 6*)"Text",
					(*row 7*)"Text"
				}
			}
		]
	},
	False(*OpenerView closed*)
]


(* ::Subsubsection:: *)
(*paramTable*)


paramTable[m_]:=Module[
	{
		keysNoStocks,
		mtomNoStocks,
		keysStocks,
		mtomStocks,
		mtom
	},
	keysNoStocks=DeleteCases[Keys[modelToTeXNoStocks],Alternatives@@(ToString/@(m["assignParam"][[;;,1]]/.v_Symbol:>(SymbolName@v)))];
	mtomNoStocks=Association@Thread[keysNoStocks->(keysNoStocks/.modelToTeXNoStocks)];
	keysStocks=DeleteCases[Keys[modelToTeXStocks],Alternatives@@(ToString/@((Keys[m["assignParamStocks"]])/.v_Symbol[Verbatim[Pattern][i_,Blank[]]]:>(SymbolName@v)[SymbolName@i]))];
	mtomStocks=Association@Thread[keysStocks->(keysStocks/.modelToTeXStocks)];
	mtom=Join[mtomNoStocks,mtomStocks];
	OpenerView[
		{
		"Parameters in this model",
			Grid[
				Transpose@{
					Join[
						{"Mathematica"},
						Keys[mtom]
					],
					Join[
						{"LaTeX"},
						Values[mtom]
					],
					Join[
						{"Symbol"},
						MaTeX[Values[mtom],FontSize->16]
					],
					Join[
						{"Initial value"},
						Map[
							If[
								NumberQ[#],
								"-",
								If[
									MatchQ[#,_[SetSymbolsContext[i]]],
									Block[{i=SetSymbolsContext[i]},Table[#/.i->j,{j,1,m["numStocks"]}]],
									#
								] //. SetSymbolsContext[m["parameters"]]
							]&,
							ToExpression/@Keys[mtom]
						]
					],
					Join[
						{"Matlab"},
						Join[
							paramToMatlab/@(ToExpression/@Keys[mtomNoStocks]),
							Apply[
								paramToMatlab[ToExpression[#]]&,
								iToNum[mtomStocks,m["numStocks"]],
								{2}
							]
						]
					]
				},(*Transposed list*)
				Alignment->Left,
				Spacings->{2,1},
				Frame->All,
				Background->{
					{},
					{
						(*row 1*)Darker[Gray],
						(*rest of the rows*){White}
					}
				},
				ItemStyle->{
					{},
					(*row 1*){Directive[{"Text",White}]}
				}
			](*Grid*)
		}
	](*OpenerView*)
](*module*)


(* ::Subsubsection::Closed:: *)
(*allParamTable*)


(* tables to display model properties *)
allParamTable[m_]:=OpenerView[
	{
	"All parameters",
		Grid[
			Transpose@{
				Join[
					{"Mathematica"},
					Keys[modelToTeX]
				],
				Join[
					{"LaTeX"},
					Values[modelToTeX]
				],
				Join[
					{"Symbol"},
					MaTeX[Values[modelToTeX],FontSize->16]
				],
				Join[
					{"Fixed value"},
					Map[
						If[
							MemberQ[Keys[SetSymbolsContext[m["assignParam"]]],#/.(SetSymbolsContext[i]->i_)]
							,"Yes"(*#*),
							"No"
						]&,
						ToExpression/@Keys[modelToTeX]
					]
				],
				Join[
					{"Initial value"},
					Map[
						If[
							NumberQ[#],
							"-",
							If[
								MatchQ[#,_[SetSymbolsContext[i]]],
								Block[{i=SetSymbolsContext[i]},Table[#/.i->j,{j,1,m["numStocks"]}]],
								#
							] //. SetSymbolsContext[m["parameters"]]
						]&,
						ToExpression/@Keys[modelToTeX]
					]
				],
				Join[
					{"Matlab"},
					Join[
						paramToMatlab/@(ToExpression/@Keys[modelToTeXNoStocks]),
						Apply[
							paramToMatlab[ToExpression[#]]&,
							iToNum[modelToTeXStocks,m["numStocks"]],
							{2}
						]
					]
				]
			},
			Alignment->Left,
			Spacings->{2,1},
			Frame->All,
			Background->{
				{},
				(*row 1*){LightGray}
			},
			ItemStyle->{
				{},
				(*row 1*){"Text"}
			}
		](*Grid*)
	}
](*OpenerView*)


(* ::Subsubsection::Closed:: *)
(*iToNum*)


(* replace i by 1, 2, ..., numStocks *)
iToNum[s_String] :=
	StringReplace[
		s, 
		{
			"[i]" -> "[" <> IntegerString[i] <> "]",
			"{(i)}" -> "{(" <> IntegerString[i] <> ")}"
		}
	]

iToNum[s_String, numStocks_Integer] :=
	Table[iToNum[s], {i, 1, numStocks}]

iToNum[s:s1_String -> s2_String, numStocks_Integer:1] :=
	Table[iToNum[s1] -> iToNum[s2], {i, 1, numStocks}]

iToNum[s : <|(_String -> _String)..|>, numStocks_Integer:1] :=
	Map[iToNum[#, numStocks]&, (Normal @ s)]


(* ::Subsection::Closed:: *)
(*modelToTeX*)


(* mapping between parameter names in Mathematica and their latex representation *)
modelToTeX=<|
	(*"Preferences"*)
	"delta"->"\\delta",
		"psi"->"\\psi",
		"gamma"->"\\gamma",
		"theta"->"\\theta",
	(*"Long-run risk"*)
	"rhox"->"\\rho_{x}",
		"rhoxpbar"->"\\rho_{x,\\overline{\\pi}}",
		"phix"->"\\phi_{x}",
		"phixc"->"\\phi_{x,c}",
	(*"Inflation"*)
	"mup"->"\\mu_{\\pi}",
		"rhoppbar"->"\\rho_{\\pi,\\overline{\\pi}}",
		"rhop"->"\\rho_{\\pi}",
		"phip"->"\\phi_{\\pi}",
		"xip"->"\\xi_{\\pi}",
		"phipc"->"\\phi_{\\pi,c}",
		"phipx"->"\\phi_{\\pi,x}",
		"phipcx"->"\\phi_{\\pi,cx}",
		"phipp"->"\\phi_{\\pi,p}",
		"phipxp"->"\\phi_{\\pi,xp}",
	(*"Expected inflation"*)
	"mupbar"->"\\mu_{\\overline{\\pi}}",
		"rhopbar"->"\\rho_{\\overline{\\pi}}",
		"rhopbarx"->"\\rho_{\\overline{\\pi},x}",
		"phipbarp"->"\\phi_{\\overline{\\pi},\\pi}",
		"phipbarc"->"\\phi_{\\overline{\\pi},c}",
		"phipbarx"->"\\phi_{\\overline{\\pi},x}",
		"phipbarcx"->"\\phi_{\\overline{\\pi},cx}",
		"phipbarpb"->"\\phi_{\\overline{\\pi},pb}",
		"phipbarxb"->"\\phi_{\\overline{\\pi},xb}",
		"phipbarxp"->"\\phi_{\\overline{\\pi},xp}",
	(*"Real consumption growth"*)
	"muc"->"\\mu_{c}",
		"rhocx"->"\\rho_{c,x}",
		"rhocp"->"\\rho_{c,\\pi}",
		"phic"->"\\phi_{c}",
		"phicp"->"\\phi_{c,\\pi}",
		"phicsp"->"\\phi_{c,s \\pi}",
		"xic"->"\\xi_{c}",
		"phics"->"\\phi_{c,s}",
		"phicx"->"\\phi_{c,x}",
		"phicc"->"\\phi_{c,c}",
		"phicpc"->"\\phi_{c,pc}",
		"phicpp"->"\\phi_{c,pp}",
	(*"Nominal-real covariance (NRC)"*)
	"Esg"->"\\bar{\\sigma}_{g}",
		"rhog"->"\\rho_{g}",
		"phig"->"\\phi_{g}",
	(*"Stochastic volatility of long-run risk"*)
	"Esx"->"\\bar{\\sigma}_{x}",
		"vx"->"v_{x}",
		"phisxs"->"\\phi_{s,xs}",
	(*"Stochastic volatility of consumption growth"*)
	"Esc"->"\\bar{\\sigma}_{c}",
		"vc"->"v_{c}",
		"phiscv"->"\\phi_{s,cv}",
	(*"Stochastic volatility of inflation"*)
	"Esp"->"\\bar{\\sigma}_{p}",
		"vp"->"v_{p}",
		"vpp"->"v_{\\pi}",
		"vppbar"->"v_{\\bar{\\pi}}",
		"phispw"->"\\phi_{s,pw}",
	(*"Real dividend growth"*)
	"mud[i]"->"\\mu_{d}^{(i)}",
		"rhodx[i]"->"\\rho_{d,x}^{(i)}",
		"rhodp[i]"->"\\rho_{d,\\pi}^{(i)}",		
		"phidc[i]"->"\\phi_{d,c}^{(i)}",
		"phidp[i]"->"\\phi_{d,\\pi}^{(i)}",
		"phidsp[i]"->"\\phi_{d,s\\pi}^{(i)}",
		"xid[i]"->"\\xi_{d}^{(i)}",
		"phids[i]"->"\\phi_{d,s}^{(i)}",
		"phidxc[i]"->"\\phi_{d,xc}^{(i)}",
		"phidcc[i]"->"\\phi_{d,cc}^{(i)}",
		"phidpc[i]"->"\\phi_{d,pc}^{(i)}",
		"phidpp[i]"->"\\phi_{d,pp}^{(i)}",
		"phidxd[i]"->"\\phi_{d,xd}^{(i)}",
		"phidcd[i]"->"\\phi_{d,cd}^{(i)}",
		"phidpd[i]"->"\\phi_{d,pd}^{(i)}",
		"taugd[i]"->"\\tau_{gd}^{(i)}"
|>;


(* ::Subsubsection:: *)
(*TeXToModel*)


TeXToModel=Association@Reverse[Normal[modelToTeX],{2}];


(* ::Subsubsection::Closed:: *)
(*modelToTeXStocks*)


(* split into stock parameters and non-stock parameters *)
modelToTeXStocks=Association@Thread[
	Select[
		Keys[modelToTeX],
		StringMatchQ[___~~"[i]"]
	]
	(*thread*)->
	(
		Select[
			Keys[modelToTeX],
			StringMatchQ[___~~"[i]"]
		]/.modelToTeX
	)
];


(* ::Subsubsection::Closed:: *)
(*modelToTeXNoStocks*)


modelToTeXNoStocks=Complement[modelToTeX,modelToTeXStocks];


(* ::Subsection::Closed:: *)
(*formatModels*)


formatModels[m_Association/; MemberQ[Values[m], _Association]]:=Module[
	{
		modelsMerged,
		notebookContent
	},
	
	modelsMerged=Append[
		modelFormattingTemplate[m[#],True]&/@Most[Keys[m]],
		modelFormattingTemplate[m[Last[Keys[m]]],False]
	]/.Cell[BoxData[contents__],style_]:>contents;
	
	notebookContent=BoxData[
		RowBox[{
			RowBox[{
				"models", " ", "=", " ",
				RowBox[{
					"<|", "\n", "\t", RowBox[modelsMerged], "|>"
				}],
				";"
			}],
			RowBox[{"(*", RowBox[{"end", " ", "models"}], "*)"}],
			" ", "\n"
		}]
	]
];


(* ::Subsubsection::Closed:: *)
(*modelFormattingTemplate*)


modelFormattingTemplate[model_Association, Optional[separate_?BooleanQ,False]]:= (modelFormattingTemplate[##,separate]&) @@ KeyTake[model,{"name","shortname","bibRef","desc","stateVars","parameters"}]


modelFormattingTemplate[
	name_String,
	shortname_String,
	bibRef_String,
	desc_String,
	stateVars_List,
	parameters:{_Rule..},
	Optional[separate_?BooleanQ,False],
	formatStringFun_Function:stringFormattingTemplate,
	formatNumFun_Function:numberFormattingTemplate
]:=Module[
	{
		stateVarsLocal=stateVars /. v_Symbol:>(Symbol@SymbolName@v),
		parametersLocal=stripContext[parameters],
		mudLocal=stripContext[mud],
		formatLocal=Function[x,
			formatNumFun[
			Flatten[{stripContext[x]//.stripContext[parameters]}][[1]]
			]],
		numStocks
	},
	numStocks=Count[parametersLocal, mudLocal[_Integer], Infinity];
	Cell[
		BoxData[
			RowBox[{
				RowBox[{
					"\"\<"<>shortname<>"\>\""," ","->"," ",
					RowBox[{
						"<|","\n","\t\t",
						RowBox[{
						RowBox[{"\"\<name\>\""," ","->"," ","\"\<"<>
						formatStringFun[name]<>
						"\>\""}],",","\n","\t\t",
						
						RowBox[{"\"\<shortname\>\""," ","->"," ","\"\<"<>
						shortname<>
						"\>\""}],",","\n","\t\t",
						
						RowBox[{"\"\<bibRef\>\""," ","->"," ","\"\<"<>
						formatStringFun[bibRef]<>
						"\>\""}],",","\n","\t\t",
						
						RowBox[{"\"\<desc\>\""," ","->"," ","\"\<"<>
						formatStringFun[desc]<>
						"\>\""}],",","\n","\t\t",
						
						RowBox[{"\"\<stateVars\>\""," ","->"," ",
						ToBoxes[stateVarsLocal,StandardForm]
						}],",","\n","\t\t",
						
						RowBox[{
							"\"\<parameters\>\""," ","->"," ",
							RowBox[{
								"{","\n","\t\t\t",
								RowBox[{"(*","\"\<Preferences\>\"","*)"}],"\n",
									"\t\t\t",RowBox[
											 (Join[{
											 RowBox[{"delta"," ","->"," ", formatLocal[delta]}],   ",","\n",
									"\t\t\t\t",RowBox[{"psi",  " ","->"," ", formatLocal[psi]}],   ",","\n",
									"\t\t\t\t",RowBox[{"gamma"," ","->"," ", formatLocal[gamma]}], ",","\n",
									 "\t\t\t\t",RowBox[{"theta"," ","->"," ", formatLocal[theta]}], ",","\n",
									
									"\t\t\t",RowBox[{"(*","\"\<Long-run risk\>\"","*)"}],"\n",
									"\t\t\t",RowBox[{"rhox",    " ","->"," ",   formatLocal[rhox]}],      ",","\n",
									"\t\t\t\t",RowBox[{"rhoxpbar"," ","->"," ",   formatLocal[rhoxpbar]}],",","\n",
									"\t\t\t\t",RowBox[{"phix",    " ","->"," ",   formatLocal[phix]}],    ",","\n",
									"\t\t\t\t",RowBox[{"phixc",   " ","->"," ",   formatLocal[phixc]}],   ",","\n",
									
									"\t\t\t",RowBox[{"(*","\"\<Inflation\>\"","*)"}],"\n",
									"\t\t\t",RowBox[{"mup",     " ","->"," ",  formatLocal[mup]}],     ",","\n",
									"\t\t\t\t",RowBox[{"rhoppbar"," ","->"," ",  formatLocal[rhoppbar]}],",","\n",
									"\t\t\t\t",RowBox[{"rhop",    " ","->"," ",  formatLocal[rhop]}],    ",","\n",
									"\t\t\t\t",RowBox[{"phip",    " ","->"," ",  formatLocal[phip]}],    ",","\n",
									"\t\t\t\t",RowBox[{"xip",     " ","->"," ",  formatLocal[xip]}],     ",","\n",
									"\t\t\t\t",RowBox[{"phipc",   " ","->"," ",  formatLocal[phipc]}],   ",","\n",
									"\t\t\t\t",RowBox[{"phipx",   " ","->"," ",  formatLocal[phipx]}],   ",","\n",
									"\t\t\t\t",RowBox[{"phipcx",  " ","->"," ",  formatLocal[phipcx]}],  ",","\n",
									"\t\t\t\t",RowBox[{"phipp",   " ","->"," ",  formatLocal[phipp]}],   ",","\n",
									"\t\t\t\t",RowBox[{"phipxp",  " ","->"," ",  formatLocal[phipxp]}],  ",","\n",
									
									"\t\t\t",RowBox[{"(*","\"\<Expected inflation\>\"","*)"}],"\n",
									"\t\t\t",RowBox[{"mupbar"," ","->"," ",    formatLocal[mupbar]}],   ",","\n",
									"\t\t\t\t",RowBox[{"rhopbar"," ","->"," ",   formatLocal[rhopbar]}],  ",","\n",
									"\t\t\t\t",RowBox[{"rhopbarx"," ","->"," ",  formatLocal[rhopbarx]}], ",","\n",
									"\t\t\t\t",RowBox[{"phipbarp"," ","->"," ",  formatLocal[phipbarp]}], ",","\n",
									"\t\t\t\t",RowBox[{"phipbarc"," ","->"," ",  formatLocal[phipbarc]}], ",","\n",
									"\t\t\t\t",RowBox[{"phipbarx"," ","->"," ",  formatLocal[phipbarx]}], ",","\n",
									"\t\t\t\t",RowBox[{"phipbarcx"," ","->"," ", formatLocal[phipbarcx]}],",","\n",
									"\t\t\t\t",RowBox[{"phipbarpb"," ","->"," ", formatLocal[phipbarpb]}],",","\n",
									"\t\t\t\t",RowBox[{"phipbarxb"," ","->"," ", formatLocal[phipbarxb]}],",","\n",
									"\t\t\t\t",RowBox[{"phipbarxp"," ","->"," ", formatLocal[phipbarxp]}],",","\n",
									
									"\t\t\t",RowBox[{"(*","\"\<Real consumption growth\>\"","*)"}],"\n",
									"\t\t\t",RowBox[{"muc"," ","->"," ",    formatLocal[muc]}],",","\n",
									"\t\t\t\t",RowBox[{"rhocx"," ","->"," ",  formatLocal[rhocx]}],",","\n",
									"\t\t\t\t",RowBox[{"rhocp"," ","->"," ",  formatLocal[rhocp]}],",","\n",
									"\t\t\t\t",RowBox[{"phic"," ","->"," ",   formatLocal[phic]}],",","\n",
									"\t\t\t\t",RowBox[{"phicp"," ","->"," ",  formatLocal[phicp]}],",","\n",
									"\t\t\t\t",RowBox[{"phicsp"," ","->"," ", formatLocal[phicsp]}],",","\n",
									"\t\t\t\t",RowBox[{"xic"," ","->"," ",    formatLocal[xic]}],",","\n",
									"\t\t\t\t",RowBox[{"phics"," ","->"," ",  formatLocal[phics]}],",","\n",
									"\t\t\t\t",RowBox[{"phicx"," ","->"," ",  formatLocal[phicx]}],",","\n",
									"\t\t\t\t",RowBox[{"phicc"," ","->"," ",  formatLocal[phicc]}],",","\n",
									"\t\t\t\t",RowBox[{"phicpc"," ","->"," ", formatLocal[phicpc]}],",","\n",
									"\t\t\t\t",RowBox[{"phicpp"," ","->"," ", formatLocal[phicpp]}], ",","\n",
									
									"\t\t\t",RowBox[{"(*","\"\<Nominal-real covariance (NRC)\>\"","*)"}],"\n",
									"\t\t\t",RowBox[{"Esg"," ","->"," ",  formatLocal[Esg]}],  ",","\n",
									"\t\t\t\t",RowBox[{"rhog"," ","->"," ",formatLocal[rhog]}],",","\n",
									"\t\t\t\t",RowBox[{"phig"," ","->"," ",formatLocal[phig]}],",","\n",
									
									"\t\t\t",RowBox[{"(*","\"\<Stochastic volatility of long-run risk\>\"","*)"}],"\n",
									"\t\t\t",RowBox[{"Esx"," ","->"," ",   formatLocal[Esx]}],      ",","\n",
									"\t\t\t\t",RowBox[{"vx"," ","->"," ",    formatLocal[vx]}],     ",","\n",
									"\t\t\t\t",RowBox[{"phisxs"," ","->"," ",formatLocal[phisxs]}], ",","\n",
									
									"\t\t\t",RowBox[{"(*","\"\<Stochastic volatility of consumption growth\>\"","*)"}],"\n",
									"\t\t\t",RowBox[{"Esc"," ","->"," ",   formatLocal[Esc]}],    ",","\n",
									"\t\t\t\t",RowBox[{"vc"," ","->"," ",    formatLocal[vc]}],    ",","\n",
									"\t\t\t\t",RowBox[{"phiscv"," ","->"," ",formatLocal[phiscv]}],",","\n",
									
									"\t\t\t",RowBox[{"(*","\"\<Stochastic volatility of inflation\>\"","*)"}],"\n",
									"\t\t\t",RowBox[{"Esp"," ","->"," ",    formatLocal[Esp]}],   ",","\n",
									"\t\t\t\t",RowBox[{"vp"," ","->"," ",     formatLocal[vp]}],   ",","\n",
									"\t\t\t\t",RowBox[{"vpp"," ","->"," ",    formatLocal[vpp]}],   ",","\n",
									"\t\t\t\t",RowBox[{"vppbar"," ","->"," ", formatLocal[vppbar]}],",","\n",
									"\t\t\t\t",RowBox[{"phispw"," ","->"," ", formatLocal[phispw]}],",","\n",
									
									"\t\t\t",RowBox[{"(*","\"\<Real dividend growth\>\"","*)"}],"\n"},
									##]&)@(Flatten@Table[
										{"\t\t\t\t",RowBox[{"(*"," ",RowBox[{"stock"," ",i}]," ","*)"}],  "\n",
										"\t\t\t\t",RowBox[{RowBox[{"mud",     "[",i,"]"}]," ","->"," ", formatLocal[mud[i]]}],     ",","\n",
										"\t\t\t\t\t",RowBox[{RowBox[{"rhodx",  "[",i,"]"}]," ","->"," ",  formatLocal[rhodx[i]]}],  ",","\n",
										"\t\t\t\t\t",RowBox[{RowBox[{"rhodp",  "[",i,"]"}]," ","->"," ",  formatLocal[rhodp[i]]}],  ",","\n",
										"\t\t\t\t\t",RowBox[{RowBox[{"phidc",  "[",i,"]"}]," ","->"," ",  formatLocal[phidc[i]]}],  ",","\n",
										"\t\t\t\t\t",RowBox[{RowBox[{"phidp",  "[",i,"]"}]," ","->"," ",  formatLocal[phidp[i]]}],  ",","\n",
										"\t\t\t\t\t",RowBox[{RowBox[{"phidsp", "[",i,"]"}]," ","->"," ",  formatLocal[phidsp[i]]}], ",","\n",
										"\t\t\t\t\t",RowBox[{RowBox[{"xid",    "[",i,"]"}]," ","->"," ",  formatLocal[xid[i]]}],    ",","\n",
										"\t\t\t\t\t",RowBox[{RowBox[{"phids",  "[",i,"]"}]," ","->"," ",  formatLocal[phids[i]]}],  ",","\n",
										"\t\t\t\t\t",RowBox[{RowBox[{"phidxc", "[",i,"]"}]," ","->"," ",  formatLocal[phidxc[i]]}], ",","\n",
										"\t\t\t\t\t",RowBox[{RowBox[{"phidcc", "[",i,"]"}]," ","->"," ",  formatLocal[phidcc[i]]}], ",","\n",
										"\t\t\t\t\t",RowBox[{RowBox[{"phidpc", "[",i,"]"}]," ","->"," ",  formatLocal[phidpc[i]]}], ",","\n",
										"\t\t\t\t\t",RowBox[{RowBox[{"phidpp", "[",i,"]"}]," ","->"," ",  formatLocal[phidpp[i]]}], ",","\n",
										"\t\t\t\t\t",RowBox[{RowBox[{"phidxd", "[",i,"]"}]," ","->"," ",  formatLocal[phidxd[i]]}], ",","\n",
										"\t\t\t\t\t",RowBox[{RowBox[{"phidcd", "[",i,"]"}]," ","->"," ",  formatLocal[phidcd[i]]}], ",","\n",
										"\t\t\t\t\t",RowBox[{RowBox[{"phidpd", "[",i,"]"}]," ","->"," ",  formatLocal[phidpd[i]]}], ",","\n",
										"\t\t\t\t\t",RowBox[{RowBox[{"taugd",  "[",i,"]"}]," ","->"," ",  formatLocal[taugd[i]]}],If[i<numStocks, ",",""],If[i<numStocks,"\n",""]},
										{i,1,numStocks}
										])
									],(*close RowBox after preferences*)
								"\n","\t\t","}"}](*close parameters List*)
							}](*close parameters RowBox*)
						}],(*close name RowBox*)
					"\n","\t","|>"}](*close association*)
				}],(*close association name*)
				If[separate, ",", ""], "\n", If[separate, separator[], ""], If[separate, "\n\t", ""](*separator between models*)
			}](*close first RowBox*)
		],(*close BoxData*)
	"Input"](*close cell*)
](*close With*)


(* ::Subsubsection::Closed:: *)
(*stringFormattingTemplate*)


stringFormattingTemplate[str_String,lineLength_Number:40]:=StringReplace[InsertLinebreaks[StringDelete[str,"\n"],lineLength],"\n"->"\n\t\t\t"];


(* ::Subsubsection::Closed:: *)
(*numberFormattingTemplate*)


numberFormattingTemplate[num_,opts:OptionsPattern[]]:=ToString[Evaluate[N[num]],InputForm,FilterRules[{opts},Options[ToString]],NumberMarks->False];


(* ::Subsubsection::Closed:: *)
(*stripContext*)


stripContext[x:(_Rule|{_Rule..})]:= Module[
	{v,i,n,q},
	Cases[
		x
		,
		Rule[(v_Symbol[i_Integer]|v_Symbol),n_] :> Rule[If[i===Sequence,SymbolName[v],SymbolName[v][i]],If[NumberQ[n],n,n/.q_Symbol:>Symbol@SymbolName@q]]
		,
		{0,Infinity}
	]
]
stripContext[x_]:= Module[
	{v,i},
	Cases[
		x
		,
		(v_Symbol[i_Integer]|v_Symbol) :> If[i===Sequence,SymbolName[v],SymbolName[v][i]]
		,
		{0,Infinity}
	]
]
stripContext[x_?AtomQ]:=stripContext[{x}][[1]]


(* ::Subsubsection::Closed:: *)
(*separator*)


separator[lineLength_Number:60] := RowBox[{"(*", StringRepeat["*",lineLength-4]<>"*)"}];


(* ::Subsection::Closed:: *)
(*toCatalog*)


toCatalog/:Conditions[
	toCatalog,
	m_Association/; MemberQ[Values[m], _Association],
	keysToKeep_?(VectorQ[#,StringQ]&)
]:= And@@Values@(SubsetQ[#,keysToKeep]&/@(Keys[#]&/@m)) (*keysToKeep exist in each element of m*)


toCatalog[
	m_Association/; MemberQ[Values[m], _Association],
	keysToKeep_?(VectorQ[#,StringQ]&)
]:=With[
	{
		keysNoStateVars = Cases[keysToKeep,Except["stateVars"]],
		t=FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`t
	}
	,
	With[
		{
			stateVarsAssoc=If[
				(*stateVars is in keysToKeep*)
				MemberQ[keysToKeep,"stateVars"],
				(*create association with stateVars as sole key*)
				(
					Association[
						"stateVars"->If[
							(*value of stateVars is a function*)
							Head@#["stateVars"]===Function,
							(*evaluate function at t*)
							#["stateVars"][t],
							(*return value of stateVars unchanged*)
							#["stateVars"]
						]
					]
				)&/@m,
				(*create empty association*)
				<||>&/@m
			]
		},
		MapThread[Join,{stateVarsAssoc,KeyTake[#,keysNoStateVars]&/@m}]
	]
]/;Conditions[toCatalog,m,keysToKeep]


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
