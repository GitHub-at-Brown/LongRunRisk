(* ::Package:: *)

(* ::Section:: *)
(*Paclet/PacletizeResources Tests*)


BeginTestSection["Paclet/PacletizeResources Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`Paclet`PacletizeResources`"]

Needs["FernandoDuarte`LongRunRisk`"];
Needs["PacletizedResourceFunctions`"];


(* ::Subsection:: *)
(*Paclet Loading Tests*)


(* Test: Paclet loads successfully without errors *)
TestCreate[
	MemberQ[$Packages, "FernandoDuarte`LongRunRisk`"],
	True,
	{},
	TestID -> "[Paclet] Main paclet loads successfully"
]


(* ::Subsection:: *)
(*MaTeX Paclet Tests*)


(* Test: MaTeX paclet is installed and found *)
TestCreate[
	PacletFind["MaTeX"] =!= {},
	True,
	{},
	TestID -> "[MaTeX] Paclet is installed and found"
]

(* Test: MaTeX context is loaded in $Packages *)
TestCreate[
	MemberQ[$Packages, "MaTeX`"],
	True,
	{},
	TestID -> "[MaTeX] Context is in $Packages after loading"
]

(* Test: MaTeX paclet version is 1.7.10 *)
TestCreate[
	FirstCase[PacletFind["MaTeX"], p_ :> p["Version"], Missing["NotFound"]],
	"1.7.10",
	{},
	TestID -> "[MaTeX] Paclet version is 1.7.10"
]


(* ::Subsection:: *)
(*PacletizedResourceFunctions Paclet Tests*)


(* Test: PacletizedResourceFunctions paclet is installed and found *)
TestCreate[
	PacletFind["PacletizedResourceFunctions"] =!= {},
	True,
	{},
	TestID -> "[PacletizedResourceFunctions] Paclet is installed and found"
]


(* ::Subsection:: *)
(*Pacletized Resource Functions Tests*)


(* Test: NeedsDefinitions symbol is available *)
TestCreate[
	NameQ["PacletizedResourceFunctions`NeedsDefinitions"],
	True,
	{},
	TestID -> "[NeedsDefinitions] Pacletized resource function symbol is available"
]

(* Test: DefinitionData symbol is available *)
TestCreate[
	NameQ["PacletizedResourceFunctions`DefinitionData"],
	True,
	{},
	TestID -> "[DefinitionData] Pacletized resource function symbol is available"
]

(* Test: SetSymbolsContext symbol is available *)
TestCreate[
	NameQ["PacletizedResourceFunctions`SetSymbolsContext"],
	True,
	{},
	TestID -> "[SetSymbolsContext] Pacletized resource function symbol is available"
]


End[]
EndTestSection[]
