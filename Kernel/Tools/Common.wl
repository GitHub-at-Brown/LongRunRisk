(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Tools`Common`"]


(* ::Subsection:: *)
(*Public symbols*)


print;


(* ::Subsubsection:: *)
(*Usage*)


print::usage = "print[msg] writes msg to $Output using WriteString.\nOptions:\n  \"Verbose\" -> True|False|\"CI\" (default \"CI\") - controls when printing occurs\n  \"Memory\" -> True|False (default False) - shows memory usage info\n  \"Prefix\" -> String|None (default None) - optional message prefix";


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*print*)


print // Options = {
	"Verbose" -> "CI",
	"Memory" -> False,
	"Prefix" -> None
};


print[msg_String, opts : OptionsPattern[{print}]] := With[
	{
		verbose = OptionValue["Verbose"],
		showMemory = OptionValue["Memory"],
		prefix = OptionValue["Prefix"]
	},
	Module[{shouldPrint, output},
		shouldPrint = Which[
			verbose === "CI", Environment["CI"] === "true",
			verbose === True, True,
			True, False
		];

		If[!shouldPrint, Return[Null]];

		output = StringJoin[
			If[StringQ[prefix], prefix <> " ", ""],
			msg,
			If[showMemory, formatMemoryInfo[], ""]
		];

		WriteString[First@$Output, output <> "\n"]
	]
]


(* ::Subsection:: *)
(*Helper functions*)


(* ::Subsubsection:: *)
(*wolframKernelMemoryGB*)


wolframKernelMemoryGB[] := If[$OperatingSystem === "Windows",
	Missing["NotAvailable"],
	Module[{raw, kb},
		raw = Quiet @ Import["!ps -axo rss,comm | grep -i '[W]olframKernel' | awk '{sum+=$1} END {print sum}'", "String"];
		kb = Quiet @ Check[ToExpression @ StringTrim[raw], $Failed];
		If[NumberQ[kb], N[kb / 1024.^2], Missing["NotAvailable"]]
	]
]


(* ::Subsubsection:: *)
(*formatMemoryInfo*)


formatMemoryInfo[] := Module[{mem = MemoryInUse[], memGB, kernelGB},
	memGB = mem / 1024.^3;
	kernelGB = wolframKernelMemoryGB[];
	StringJoin[
		" | Wolfram Memory: ", ToString @ NumberForm[memGB, {4, 2}], " GB",
		" | Physical RAM: ", If[MissingQ[kernelGB], "N/A", ToString @ NumberForm[kernelGB, {4, 2}] <> " GB"]
	]
]


(* ::Section:: *)
(*End package*)


End[] (*"`Private`"*)


EndPackage[]
