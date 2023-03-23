(* ::Package:: *)

(* ::Section:: *)
(*Package Header*)


BeginPackage["FernandoDuarte`LongRunRisk`"];


(* ::Section:: *)
(*Public symbols*)


(* ::Subsubsection:: *)
(*Load subcontexts*)


With[ { mainContext = "FernandoDuarte`LongRunRisk`" },       
        Needs[ mainContext <> "timeAggregation`" -> None ];
] 


(* ::Subsubsection:: *)
(*Introduce public symbols*)


wcAGeq::usage = "Computes approximation of time-aggregated wealth-consumption ratio. Consumption growth approximated around `mu0` with default value 0.0015.";


(* ::Section:: *)
(*Private context*)


Begin["`Private`"];


(* define aliases to reference implementation *)
wcAGeq = FernandoDuarte`LongRunRisk`timeAggregation`Private`wcAGeq


(* ::Section:: *)
(*Package Footer*)


End[];
EndPackage[];
