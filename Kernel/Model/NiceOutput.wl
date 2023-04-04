(* ::Package:: *)

(* ::InheritFromParent:: *)
(**)


BeginPackage["FernandoDuarte`LongRunRisk`Model`NiceOutput`"]

(*
<<FernandoDuarte`LongRunRisk`Subpackage`specifications`; (*to use AddThree inside this file*)
<<FernandoDuarte`LongRunRisk`Subpackage`ToMatlab`; (*to use AddThree inside this file*)
<<FernandoDuarte`LongRunRisk`Subpackage`toMatlabTools`; (*to use AddThree inside this file*)
<<FernandoDuarte`LongRunRisk`Subpackage`MaTeX`; (*to use AddThree inside this file*)
*)

(*<<"ToMatlab`";
<<"toMatlabTools`";
<<"MaTeX`";*)

modelToTeX::usage = "Association between the Mathematica variables that represent parameters of the model and their L AT EX representation";
TeXToModel::usage = "Association of LATEX strings for parameters of the model and the name of the corresponding Mathematica variable";

allParamTable::usage = "allParamTable[m]";
paramTable::usage = "paramTable[m]";
info::usage = "info[m]";

modelFormattingTemplate::usage = "modelFormattingTemplate[model] Re-writes model as a Cell object with nice formatting. 
	To automatically write the output of modelFormattingTemplate[model] into a cell that can be copied and pasted,
	run 
		nb=CreateNotebook[];
		NotebookWrite[nb,modelFormattingTemplate[model]];
	To write all models in Kernel/Model/Catalog.wl using the nice formatting, run
		nb=CreateNotebook[];
		NotebookWrite[nb,modelFormattingTemplate[models[#]]]&/@Keys[models];
"



Begin["`Private`"]


(* mapping between parameter names in Mathematica and their latex representation *)
modelToTeX=<|
	(*"Preferences"*)
	"delta"->"\\delta",
		"psi"->"\\psi",
		"gamma"->"\\gamma",
		"theta"->"\\theta" .
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
		"taugd[1]"->"\\tau_{gd}^{(i)}"
|>;

TeXToModel=Association@Reverse[Normal[modelToTeX],{2}];




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
modelToTeXNoStocks=Complement[modelToTeX,modelToTeXStocks];


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
							MemberQ[Keys[m[assignParam]],#]
							,#,
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
								MatchQ[#,_[i]],
								Table[#,{i,1,m[numStocks]}],
								#
							]/.m[parameters] 
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
							iToNum[modelToTeXStocks,m[numStocks]],
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
		]
	}
]

paramTable[m_]:=Module[
	{
		keysNoStocks,
		mtomNoStocks,
		keysStocks,
		mtomStocks,
		mtom
	},
	keysNoStocks=Complement[Keys[modelToTeXNoStocks],ToString/@(m[assignParam][[;;,1]])];
	mtomNoStocks=Association@Thread[keysNoStocks->(keysNoStocks/.modelToTeXNoStocks)];
	keysStocks=Complement[Keys[modelToTeXStocks],ToString/@(m[assignParamStocks][[;;,1]]/.Verbatim[i_]:>i)];
	mtomStocks=Association@Thread[keysStocks->(keysStocks/.modelToTeXStocks)];
	mtom=Join[mtomNoStocks,mtomStocks];
	
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
						MatchQ[#,_[i]],
						Table[#,{i,1,m[numStocks]}],
						#
					]/.m[parameters] 
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
					iToNum[mtomStocks,m[numStocks]],
					{2}
				]
			]
		]
	}
]

info[m_]:=OpenerView[
	{
		m[shortname],
		Grid[
			Join[
				{{"Model: "<>m[name],SpanFromLeft,SpanFromLeft,SpanFromLeft,SpanFromLeft}},
				{{TextGrid[{{TextCell["Reference: ","Text",FontFamily->"Times"],"\\textcite{"<>m[bibRef]<>"}"(*MaTeX["\\text{\\textcite{"<>m[bibRef]<>"}}","Preamble"->preambleTeX,"DisplayStyle"->True,FontSize->14]*)}}],SpanFromLeft,SpanFromLeft,SpanFromLeft,SpanFromLeft}},
				{{"Description: "<>m[desc],SpanFromLeft,SpanFromLeft,SpanFromLeft,SpanFromLeft}},
				{{m[modelEq],SpanFromLeft,SpanFromLeft,SpanFromLeft,SpanFromLeft}},
				paramTable[m],
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
					(*row 5*)LightGray
				}
			},
			ItemStyle->{
				{},
				{
					(*row 1*)Directive[{"Text",Black,Bold,FontFamily->"Times"}],
					(*row 2*)"Text",
					(*row 3*)"Text",
					(*row 4*)"Text",
					(*row 5*)"Text"
				}
			}
		]
	},
	False(*OpenerView closed*)
]


stringFormattingTemplate[str_String,lineLength_Number:40]:=StringReplace[InsertLinebreaks[StringDelete[str,"\n"],lineLength],"\n"->"\n\t\t\t"];
numberFormattingTemplate[num_,opts:OptionsPattern[]]:=ToString[num,InputForm,FilterRules[{opts},Options[ToString]],NumberMarks->False];

stripContext[x:(_Rule|{_Rule..})]:= Module[{v,i,n}, Cases[x,Rule[(v_Symbol[i_Integer]|v_Symbol),n_]:>Rule[If[i===Sequence,SymbolName[v],SymbolName[v][i]],n],{0,Infinity}]]
stripContext[x_]:= Module[{v,i,n}, Cases[x,(v_Symbol[i_Integer]|v_Symbol):>If[i===Sequence,SymbolName[v],SymbolName[v][i]],{0,Infinity}]]
stripContext[x_?AtomQ]:=stripContext[{x}][[1]]

modelFormattingTemplate[
	name_String,
	shortname_String,
	bibRef_String,
	desc_String,
	stateVars_List,
	parameters:{_Rule..},
	formatStringFun_Function:stringFormattingTemplate,
	formatNumFun_Function:numberFormattingTemplate
]:=Module[
	{
		parametersLocal=stripContext[parameters],
		mudLocal=stripContext[mud],
		formatLocal=Function[x,
			formatNumFun[
			Flatten[{stripContext[x]/.stripContext[parameters]}][[1]]
			]],
		numStocks
	},
	numStocks=Count[parametersLocal, mudLocal[_Integer], Infinity];
	Cell[
		BoxData[
			RowBox[{
				"\t",
				RowBox[{
					shortname," ","->"," ",
					RowBox[{
						"<|","\n","\t\t",
						RowBox[{
						RowBox[{"name"," ","->"," ","\"\<"<>
						formatStringFun[name]<>
						"\>\""}],",","\n","\t\t",
						
						RowBox[{"shortname"," ","->"," ","\"\<"<>
						shortname<>
						"\>\""}],",","\n","\t\t",
						
						RowBox[{"bibRef"," ","->"," ","\"\<"<>
						formatStringFun[bibRef]<>
						"\>\""}],",","\n","\t\t",
						
						RowBox[{"desc"," ","->"," ","\"\<"<>
						formatStringFun[desc]<>
						"\>\""}],",","\n","\t\t",
						
						RowBox[{"stateVars"," ","->"," ",
						ToBoxes[stateVars,StandardForm]
						}],",","\n","\t\t",
						
						RowBox[{
							"parameters"," ","->"," ",
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
					"\n","\t","|>","\n"}](*close association*)
				}](*close association name*)
			}](*close first RowBox*)
		],(*close BoxData*)
	"Input"](*close cell*)
](*close With*)

modelFormattingTemplate[model_Association]:= With[
	{
		keysLocal=stripContext/@{name,shortname,bibRef,desc,stateVars,parameters},
		modelLocal=Thread[(stripContext/@Keys[model])->Values[model]]
	},
	(modelFormattingTemplate[##]&) @@ KeyTake[modelLocal,keysLocal]
]


End[]
EndPackage[]
