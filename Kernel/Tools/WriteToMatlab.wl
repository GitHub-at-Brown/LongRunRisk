(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`WriteToMatlab`"]


(* ::Subsection:: *)
(*Public symbols*)


paramToMatlab


(* ::Subsubsection:: *)
(*Usage*)


paramToMatlab::usage = "paramToMatlab[param] converts param into a Matlab-compatible variable name."


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


ToMatlab::usage ="ToMatlab[expr] converts the expression  expr  into matlab syntax and returns it as a String.\nToMatlab[expr, name]  returns an assignment of  expr  into  name as a String. name can be also a more complicated string, e.g., ToMatlab[If[t,a,b],\"function y=iffun(t,a,b)\\ny\"].\nThe special symbol Colon can be used to denote the matlab colon operator :, and Colon[a,b] for a:b, Colon[a,b,c] for a:b:c.\nSee also  WriteMatlab  and  PrintMatlab.\nAll functions accept an optional last argument that is the maximum line width."
WriteMatlab::usage ="WriteMatlab[expr, file] or WriteMatlab[expr, file, name] Writes the  expr  in matlab form into the given file. The second form makes this an assignment into the variable  name.\nExample: f = OpenWrite[\"file.m\"]; WriteMatlab[Cos[x]-x, f, y]; Close[f];\nThe file argument can also be a String that gives the name of the file: WriteMatlab[Cos[x]-x, \"file.m\", y]; achieves the same result as the previous example (but this limits one expression per file).\nSee also  ToMatlab  and  PrintMatlab."
PrintMatlab::usage ="PrintMatlab[expr] or PrintMatlab[expr, name] is like  ToMatlab but instead of returning the String, it is printed on the screen. See also  ToMatlab  and  WriteMatlab."
RulesToMatlab::usage ="RulesToMatlab[rules] where rules is from Solve or NSolve converts the rules into individual assignment statements."


(* ::Subsection:: *)
(*WriteMatlab*)


WriteMatlab[e_, file_OutputStream] :=
    (WriteString[file, ToMatlab[e,72]];)

WriteMatlab[e_, file_OutputStream, name_] :=
    (WriteString[file, ToMatlab[e,name,72]];)	    /; (!NumberQ[name])

WriteMatlab[e_, file_String] :=
    (Block[{f = OpenWrite[file]},
	WriteString[f, ToMatlab[e,72]];
	Close[f];];)

WriteMatlab[e_, file_String, name_] :=
    (Block[{f = OpenWrite[file]},
	WriteString[f, ToMatlab[e,name,72]];
	Close[f];];)	    /; (!NumberQ[name])

WriteMatlab[e_, file_OutputStream, margin_Integer] :=
    (WriteString[file, ToMatlab[e,margin]];)

WriteMatlab[e_, file_OutputStream, name_, margin_Integer] :=
    (WriteString[file, ToMatlab[e,name,margin]];)

WriteMatlab[e_, file_String, margin_Integer] :=
    (Block[{f = OpenWrite[file]},
	WriteString[f, ToMatlab[e,margin]];
	Close[f];];)

WriteMatlab[e_, file_String, name_, margin_Integer] :=
    (Block[{f = OpenWrite[file]},
	WriteString[f, ToMatlab[e,name,margin]];
	Close[f];];)



PrintMatlab[e_] := 
    (Print[ToMatlab[e, 60]];)

PrintMatlab[e_, name_] := 
    (Print[ToMatlab[e, name, 60]];)	    /; (!NumberQ[name])

PrintMatlab[e_, margin_Integer] := 
    (Print[ToMatlab[e, margin]];)

PrintMatlab[e_, name_, margin_Integer] := 
    (Print[ToMatlab[e, name, margin]];)



ToMatlab[e_] := foldlines[ToMatlabaux[e] <> ";\n"]

ToMatlab[e_, name_] :=
    ToMatlabaux[name] <> "=" <> foldlines[ToMatlabaux[e] <> ";\n"]   /; 
		(!NumberQ[name])

ToMatlab[e_, margin_Integer] :=
    Block[{s},
	SetMargin[margin];
	s = foldlines[ToMatlabaux[e] <> ";\n"];
	RestoreMargin[];
	s]

ToMatlab[e_, name_, margin_Integer] :=
    Block[{s},
	SetMargin[margin];
	s = ToMatlabaux[name] <> "=" <> foldlines[ToMatlabaux[e] <> ";\n"];
	RestoreMargin[];
	s]



RulesToMatlab[l_List] :=
    If[Length[l] === 0,
	"",
	Block[{s = RulesToMatlab[ l[[1]] ]},
	    Do[s = s <> RulesToMatlab[ l[[i]] ], {i, 2, Length[l]}];
	    s]]

RulesToMatlab[Rule[x_, a_]]:=
	ToMatlab[a, ToMatlab[x] // StringDrop[#, -2]&] 


(*** Numbers and strings *****************************************************)

ToMatlabaux[s_String] := s

ToMatlabaux[n_Integer] :=
    If[n >= 0, ToString[n], "(" <> ToString[n] <> ")"]

(*ToMatlabaux[r_Rational] := 
    "(" <> ToMatlabaux[Numerator[r]] <> "/" <>
           ToMatlabaux[Denominator[r]] <> ")"*)

ToMatlabaux[r_Rational] := 
    "(" <> ToString[Numerator[r]] <> "/" <>
           ToString[Denominator[r]] <> ")"


numDigits=28;

ToMatlabaux[r_Real] := 
    Block[{a = MantissaExponent[r]},
        If[r >= 0,
            ToString[NumberForm[N[a[[1]],numDigits],numDigits]] <> "E" <> ToString[NumberForm[a[[2]],numDigits]],
            "(" <> ToString[NumberForm[N[a[[1]],numDigits],numDigits]] <> "E" <> ToString[NumberForm[a[[2]],numDigits]]<>")"]
            ]

ToMatlabaux[I] := "sqrt(-1)";

ToMatlabaux[c_Complex] :=
    "(" <>
    If[Re[c] === 0,
        "",
        ToMatlabaux[Re[c]] <> "+"] <>
    If[Im[c] === 1,
        "sqrt(-1)",
        "sqrt(-1)*" <> ToMatlabaux[Im[c]] ] <> ")"



(*** Lists, vectors and matrices *********************************************)


numberMatrixQ[m_] := MatrixQ[m] && (And @@ Map[numberListQ,m])

numberListQ[l_] := ListQ[l] && (And @@ Map[NumberQ,l])


numbermatrixToMatlab[m_] :=
    Block[{i, s=""}, 
	For[i=1, i<=Length[m], i++,
	    s = s <> numbermatrixrow[m[[i]]];    
	    If[i < Length[m], s = s <> ";"]
	    ];
	s]

numbermatrixrow[l_] :=
    Block[{i, s=""},
	For[i=1, i<=Length[l], i++, 
	    s = s <> ToMatlabaux[l[[i]]];
	    If[i < Length[l], s = s <> ","]];
	s]


ToMatlabaux[l_List /; MatrixQ[l]] :=
    If[numberMatrixQ[l],
	"[" <> numbermatrixToMatlab[l] <> "]",
	"[" <> matrixToMatlab[l] <> "]"]

matrixToMatlab[m_] :=
    If[Length[m] === 1, 
        ToMatlabargs[m[[1]]],
        ToMatlabargs[m[[1]]] <> ";" <>
            matrixToMatlab[ argslistdrop[m] ] ]

ToMatlabaux[l_List] := "[" <> ToMatlabargs[l] <> "]"



(*** Symbols *****************************************************************)

ToMatlabaux[Colon] = ":"
ToMatlabaux[Sign] = "sign"
ToMatlabaux[Abs] = "abs"
ToMatlabaux[Min] = "min"
ToMatlabaux[Max] = "max"
ToMatlabaux[Sin] = "sin"
ToMatlabaux[Cos] = "cos"
ToMatlabaux[Tan] = "tan"
ToMatlabaux[Cot] = "cot"
ToMatlabaux[Csc] = "csc"
ToMatlabaux[Sec] = "sec"
ToMatlabaux[ArcSin] = "asin"
ToMatlabaux[ArcCos] = "acos"
ToMatlabaux[ArcTan] = "atan"
ToMatlabaux[ArcCot] = "acot"
ToMatlabaux[ArcCsc] = "acsc"
ToMatlabaux[ArcSec] = "asec"
ToMatlabaux[Sinh] := "sinh"
ToMatlabaux[Cosh] := "cosh"
ToMatlabaux[Tanh] := "tanh"
ToMatlabaux[Coth] := "coth"
ToMatlabaux[Csch] := "csch"
ToMatlabaux[Sech] := "sech"
ToMatlabaux[ArcSinh] := "asinh"
ToMatlabaux[ArcCosh] := "acosh"
ToMatlabaux[ArcTanh] := "atanh"
ToMatlabaux[ArcCoth] := "acoth"
ToMatlabaux[ArcCsch] := "acsch"
ToMatlabaux[ArcSech] := "asech"
ToMatlabaux[Log] := "log"
ToMatlabaux[Exp] := "exp"
ToMatlabaux[MatrixExp] := "expm"
ToMatlabaux[Pi] := "pi"
ToMatlabaux[E] := "exp(1)"
ToMatlabaux[True] := "1"
ToMatlabaux[False] := "0"
ToMatlabaux[Re] := "real"
ToMatlabaux[Im] := "imag"

ToMatlabaux[e_Symbol] := ToString[e]



(*** Relational operators ****************************************************)

ToMatlabaux[e_ /; Head[e] === Equal] :=
    ToMatlabrelop[ argslist[e], "=="]
ToMatlabaux[e_ /; Head[e] === Unequal] :=
    ToMatlabrelop[ argslist[e], "~="]
ToMatlabaux[e_ /; Head[e] === Less] :=
    ToMatlabrelop[ argslist[e], "<"]
ToMatlabaux[e_ /; Head[e] === Greater] :=
    ToMatlabrelop[ argslist[e], ">"]
ToMatlabaux[e_ /; Head[e] === LessEqual] :=
    ToMatlabrelop[ argslist[e], "<="]
ToMatlabaux[e_ /; Head[e] === GreaterEqual] :=
    ToMatlabrelop[ argslist[e], ">="]
ToMatlabaux[e_ /; Head[e] === And] :=
    ToMatlabrelop[ argslist[e], "&"]
ToMatlabaux[e_ /; Head[e] === Or] :=
    ToMatlabrelop[ argslist[e], "|"]
ToMatlabaux[e_ /; Head[e] === Not] :=
    "~(" <> ToMatlabaux[e[[1]]] <> ")"

ToMatlabrelop[e_, o_] :=
    If[Length[e] === 1, 
        "(" <> ToMatlabaux[e[[1]]] <> ")",
        "(" <> ToMatlabaux[e[[1]]] <> ")" <> o <>
         ToMatlabrelop[ argslistdrop[e], o] ]

relopQ[e_] := MemberQ[{Equal, Unequal, Less, Greater, LessEqual,
    GreaterEqual, And, Or, Not}, Head[e]]



(*** Addition, multiplication and powers *************************************)

ToMatlabaux[e_ /; Head[e] === Plus] :=
    If[relopQ[e[[1]]],
        "(" <> ToMatlabaux[e[[1]]] <> ")",
        ToMatlabaux[e[[1]]] ] <>
    "+" <>
        If[Length[e] === 2,
            If[relopQ[e[[2]]],
                "(" <> ToMatlabaux[e[[2]]] <> ")",
                ToMatlabaux[e[[2]]] ],
            ToMatlabaux[ dropfirst[e] ]]

ToMatlabaux[e_ /; Head[e] === Times] :=
    If[Head[e[[1]]] === Plus,
        "(" <> ToMatlabaux[e[[1]]] <> ")",
        ToMatlabaux[e[[1]]] ] <>
    ".*" <>
        If[Length[e] === 2,
            If[Head[e[[2]]] === Plus,
                "(" <> ToMatlabaux[e[[2]]] <> ")",
                ToMatlabaux[e[[2]]] ],
            ToMatlabaux[ dropfirst[e] ]]

ToMatlabaux[e_ /; Head[e] === Power] :=
    If[Head[e[[1]]] === Plus || Head[e[[1]]] === Times || Head[e[[1]]] === Power,
        "(" <> ToMatlabaux[e[[1]]] <> ")",
        ToMatlabaux[e[[1]]] ] <>
    ".^" <>
        If[Length[e] === 2,
            If[Head[e[[2]]] === Plus || Head[e[[2]]] === Times || Head[e[[2]]] === Power,
                "(" <> ToMatlabaux[e[[2]]] <> ")",
                ToMatlabaux[e[[2]]] ],
            ToMatlabaux[ dropfirst[e] ]]



(*** Special cases of functions **********************************************)

ToMatlabaux[Rule[_,r_]] := ToMatlabaux[r]

ToMatlabaux[Log[10, z_]] := "log10(" <> ToMatlabaux[z] <> ")"
ToMatlabaux[Log[b_, z_]] :=
    "log(" <> ToMatlabaux[z] <> ")./log(" <> ToMatlabaux[b] <> ")"

ToMatlabaux[Power[e_, 1/2]] := "sqrt(" <> ToMatlabaux[e] <> ")"
ToMatlabaux[Power[E, z_]] := "exp(" <> ToMatlabaux[z] <> ")"

ToMatlabaux[If[test_, t_, f_]] :=
    Block[{teststr = ToMatlabaux[test]},
        "((" <> teststr <> ").*(" <> ToMatlabaux[t] <> ")+(~("
             <> teststr <> ")).*(" <> ToMatlabaux[f] <> "))"]

ToMatlabaux[e__ /; (Head[e] === Max || Head[e] == Min)] :=
    ToMatlabaux[Head[e]] <> "(" <>
        If[ Length[e] === 2,
            ToMatlabargs[e] <> ")",
            ToMatlabaux[e[[1]]] <> "," <> ToMatlabaux[dropfirst[e]] <> ")"]

ToMatlabaux[Colon[a_,b_]] :=
    "((" <> ToMatlabaux[a] <> "):(" <> ToMatlabaux[b] <> "))"
ToMatlabaux[Colon[a_,b_,c_]] :=
    "((" <> ToMatlabaux[a] <> "):(" <> ToMatlabaux[b] <> 
        "):(" <> ToMatlabaux[c] <> "))"



(*** General functions *******************************************************)

ToMatlabaux[e_] :=
    ToMatlabaux[Head[e]] <> "(" <>
        ToMatlabargs[ argslist[e] ] <> ")"

ToMatlabargs[e_] :=
    If[Length[e] === 1, 
        ToMatlabaux[e[[1]]],
        ToMatlabaux[e[[1]]] <> "," <>
            ToMatlabargs[ argslistdrop[e] ] ]



(*** Argument lists **********************************************************)

(*** argslist returns a List of the arguments ***)
argslist[e_] :=
    Block[{ARGSLISTINDEX}, Table[ e[[ARGSLISTINDEX]],
        {ARGSLISTINDEX, 1, Length[e]}]]

(*** argslistdrop returns a List of all arguments except the first one ***)
argslistdrop[e_] :=
    Block[{ARGSLISTINDEX}, Table[ e[[ARGSLISTINDEX]], 
        {ARGSLISTINDEX, 2, Length[e]}]]

(*** dropfirst is like argslistdrop but retains the original Head ***)
dropfirst[e_] :=
    e[[ Block[{i}, Table[i, {i,2,Length[e]}]] ]]



(*** Folding long lines ******************************************************)

MARGIN = 66
MARGINS = {}

SetMargin[m_] := (MARGINS = Prepend[MARGINS, MARGIN]; MARGIN = m; MARGINS)

RestoreMargin[] := 
    If[Length[MARGINS] > 0,
	MARGIN = MARGINS[[1]];
	MARGINS = Drop[MARGINS, 1]]		

foldlines[s_String] :=
    Block[{cut, sin=s, sout=""},
	While[StringLength[sin] >= MARGIN, 
	    cut = findcut[sin];
	    If[cut > 0,		
		sout = sout <> StringTake[sin,cut] <> " ...\n  ";
		sin = StringDrop[sin,cut],
		(* else *)
		sout = sout <> StringTake[sin,MARGIN];
		sin = StringDrop[sin,MARGIN]]];
	sout <> sin]

findcut[s_String] :=
    Block[{i=MARGIN}, 
        While[i > 0 && !MemberQ[{";", ",", "(", "*"}, StringTake[s,{i}]],i--];
        (*While[i > 0 && !MemberQ[{";", ",", "(", ")", "+", "*", " "}, StringTake[s,{i}]],i--];*)
        i]


greekToMatlab::usage = "greekToMatlab is a list of rules that changes Greek letters into strings suitable for a Matlab variable name.";
subscriptToMAtlab::usage = "subscriptToMAtlab is a list of rules that changes subscripts into strings suitable for a Matlab variable name.";
iToMatlab::usage = "iToMatlab[x] gives a list of rules that replaces variable in x with subindex [i] into a string suitable for a Matlab variable name.";
toMatlabCell::usage = "toMatlabCell[x] converts brackets of x into curly brackets after applying ToMatlab.
					   toMatlabCell[x,numLines] inserts a linebreak after writing numLines characters, default value is 8000.
";
toMatlabStringCell::usage = "toMatlabStringCell[x] converts brackets of x into curly brackets after applying ToMatlab and then surrounds each element of the cell by single quotes so that Matlab reads them as strings.
							 toMatlabStringCell[x,numLines] inserts a linebreak after writing numLines characters, default value is 8000.
";
toMatlabSignsReplace::usage = "toMatlabSignsReplace[s] transforms the substring `signsX' of the string s into the string `signs(X)' whenever X is a sequence of DigitCharacters.";
kappaToMatlab::usage= "kappaToMatlab is a list of rules that changes kappa into a string that Matlab understands.";
nToMatlab::usage= "nToMatlab[x] converts \"\\b[n]\\b\" in Mathematica's string x to (1:max_maturity.real) for use in Matlab.";
nomnToMatlab::usage="nomnToMatlab[x] converts \"\\b[n]\\b\" in Mathematica's string x to (1:max_maturity.nom) for use in Matlab.";
vectorize::usage= "vectorize[list,symbolsToVectorize,repMat] for expressions in list free of any elements of the list symbolsToVectorize, change to a Matlab vector of dimension 1-by-repMat with repMat repeated entries.
				   vectorize[..., numLines] inserts a linebreak after writing numLines characters, default value is 1000.
";


(* rules to convert mathematica variables into suitable Matlab variable names *)

(* LettersAndLetterLikeForms.nb not shipped since Mathematica 12.2 *)
(*nb=Get[FindFile[File["FernandoDuarte/LongRunRisk/LettersAndLetterLikeForms.nb"]]];(*Get@"LettersAndLetterLikeForms.nb";*)
letters=Cases[nb,StyleBox[s_String,"TR"]:>s,{-2}];
*)
letters = {"\[Alpha]","\[Beta]","\[Gamma]","\[Delta]","\[Epsilon]","\[CurlyEpsilon]","\[Zeta]","\[Eta]","\[Theta]","\[CurlyTheta]","\[Iota]","\[Kappa]","\[CurlyKappa]","\[Lambda]","\[Mu]","\[Nu]","\[Xi]","\[Omicron]","\[Pi]","\[CurlyPi]","\[Rho]","\[CurlyRho]","\[Sigma]","\[FinalSigma]","\[Tau]","\[Upsilon]","\[Phi]","\[CurlyPhi]","\[Chi]","\[Psi]","\[Omega]","\[Digamma]","\[Koppa]","\[Stigma]","\[Sampi]","\[CapitalAlpha]","\[CapitalBeta]","\[CapitalGamma]","\[CapitalDelta]","\[CapitalEpsilon]","\[CapitalZeta]","\[CapitalEta]","\[CapitalTheta]","\[CapitalIota]","\[CapitalKappa]","\[CapitalLambda]","\[CapitalMu]","\[CapitalNu]","\[CapitalXi]","\[CapitalOmicron]","\[CapitalPi]","\[CapitalRho]","\[CapitalSigma]","\[CapitalTau]","\[CapitalUpsilon]","\[CurlyCapitalUpsilon]","\[CapitalPhi]","\[CapitalChi]","\[CapitalPsi]","\[CapitalOmega]","\[CapitalDigamma]","\[CapitalKoppa]","\[CapitalStigma]","\[CapitalSampi]","\[Pi]","\[Pi]","\[Pi]","\[Pi]","\[CapitalSigma]","\[CapitalPi]","\[Epsilon]","\[Element]","\[Mu]","\[CapitalUpsilon]","\[FinalSigma]","\[Digamma]","\[Koppa]","\[Stigma]","\[Sampi]"};
letters=DeleteCases[letters,"\[Pi]"|"\[Element]"];(*reserved Symbols*)names=StringTake[ToString@FullForm@#,{4,-3}]&/@letters;
greekToMatlab=MapThread[Symbol@#->Symbol@ToLowerCase@#2&,{letters,names}];

subscriptToMatlab:=Subscript[a_,b__]->Hold[ToString[a]<>"_"<>ToString[b]];

iToMatlab[x_]:=x/.(c_[i_Integer]->Hold[ToString[c]<>ToString[i]]);
toMatlabSignsReplace[s_]:=StringReplace[s,"signs"~~a:DigitCharacter..:>"signs("~~ToString[a]~~")"]

(*apply rules greekToMatlab,  subscriptToMAtlab, iToMatlab in that order"*)
paramToMatlab[x_]:=ReleaseHold[iToMatlab[(x/.kappaToMatlab/.subscriptToMatlab /.greekToMatlab/.Sign->sign//ReleaseHold)]];

(* adapt ToMatlab to cell arrays *)
toMatlabCell[x_,numLines_:8000]:=StringReplace[ToMatlab[x,numLines],"["~~a__~~"]"->"{"~~a~~"}"];
toMatlabStringCell[x_,numLines_:8000]:=StringReplace[toMatlabCell[x,numLines],{"\n"->"","..."->"",Whitespace->"",","->"','","{"->"{'","}"->"'}"}];

(* rule to write kappas in Matlab friendly way *)
kappaToMatlab={Subscript[\[Kappa],B_,C_][D_.]:>StringJoin@@ToString/@{kappa,B,C,D},Subscript[\[Kappa],B_]:>StringJoin@@ToString/@{kappa,B}};
kappaDef:=(toParameters/.kappaToMatlab)/.Rule->Equal;

(* rule to write coefficients wtih subscripts in Matlab vector notation *)
coeffToMatlab[coeff_,index_] ={Subscript[coeff,a_][index+lag_]:>ToString[coeff]<>"_vector("<>ToString[a+1]<>",1:end" <>ToString[lag]<>")",Subscript[coeff,a_][index]:>ToString[coeff]<>"_vector("<>ToString[a+1]<>",2:end)"};
nToMatlab[x_String]:=StringReplace[x,RegularExpression["\\b[n]\\b"]->"(1:max_maturity.real)"];
nomnToMatlab[x_String]:=StringReplace[x,RegularExpression["\\b[n]\\b"]->"(1:max_maturity.nom)"];

findIndexI[list_]:=DeleteDuplicates[Cases[list,Rule[z_[j_],q_]:>z[i]]]
stockParamVectorToMatlab[stockParameterList_]=(p_/;MemberQ[stockParameterList,p]:>StringDrop[ToMatlab[paramToMatlab[p]],-2]<>"_vector(1,1:end)")


(* for expressions in list free of any elements of the list symbolsToVectorize change to a matlab vector of dimension 1-by-repMat with repMat repeated entries *)
vectorize[list_List,symbolsToVectorize_List,repMat_String,numLines_:1000]:=MapAt[Replace[#,x_:>"repmat("<>StringDrop[ToMatlab[paramToMatlab[x],numLines],-2]<>",1,"<>repMat<>")"]&,list,Position[Map[FreeQ[#,Alternatives@@symbolsToVectorize  ]&,list],True]];


(* ::Section:: *)
(*End package*)


End[]; (*"`Private`"*)


EndPackage[];
