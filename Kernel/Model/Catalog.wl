(* ::Package:: *)

(* ::Section:: *)
(*Begin package*)


BeginPackage["FernandoDuarte`LongRunRisk`Model`Catalog`"]


(* ::Subsection:: *)
(*Public symbols*)


models
modelsExtraInfo


(* ::Subsubsection:: *)
(*Usage*)


models::usage= "Association with the definition and properties of models.";
modelsExtraInfo::usage= "Additional optional information about model solution, constraints, initial guesses for numerical solvers.";


(* ::Section:: *)
(*Code*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Package dependencies*)


Needs["FernandoDuarte`LongRunRisk`Model`Parameters`"];
Needs["FernandoDuarte`LongRunRisk`Model`Shocks`"];
Needs["FernandoDuarte`LongRunRisk`Model`ExogenousEq`"];
Needs["FernandoDuarte`LongRunRisk`Model`EndogenousEq`"];
$ContextPath=AppendTo[
	$ContextPath,
	"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"
];


(* ::Subsection:: *)
(*models*)


models = <|
	"BY" -> <|
		"name" -> "Original long-run risk model",
		"shortname" -> "BY",
		"bibRef" -> "BY2004",
		"desc" -> "Long-run risk model with stochastic
			volatility in the original 2004 paper by
			Bansal and Yaron",
		"enabled" -> True,
		"stateVars" -> {x[t], sx[t]},
		"parameters" -> {
			(*"Preferences"*)
			delta -> 0.998,
				psi -> 1.5,
				gamma -> 10,
				theta -> (1 - gamma)/(1 - psi^(-1)),
			(*"Long-run risk"*)
			rhox -> 0.979,
				rhoxpbar -> 0,
				phix -> 0.044,
				phixc -> 0,
			(*"Inflation"*)
			mup -> 0,
				rhoppbar -> 0,
				rhop -> 0,
				phip -> 0,
				xip -> 0,
				phipc -> 0,
				phipx -> 0,
				phipcx -> 0,
				phipp -> 0,
				phipxp -> 0,
			(*"Expected inflation"*)
			mupbar -> 0,
				rhopbar -> 0,
				rhopbarx -> 0,
				phipbarp -> 0,
				phipbarc -> 0,
				phipbarx -> 0,
				phipbarcx -> 0,
				phipbarpb -> 0,
				phipbarxb -> 0,
				phipbarxp -> 0,
			(*"Real consumption growth"*)
			muc -> 0.0015,
				rhocx -> 1,
				rhocp -> 0,
				rhocpbar -> 0,
				phic -> 0,
				phicp -> 0,
				phicsp -> 0,
				xic -> 0,
				phics -> 0,
				phicx -> 1,
				phicc -> 0,
				phicpc -> 0,
				phicpp -> 0,
			(*"Nominal-real covariance (NRC)"*)
			Esg -> 0,
				rhog -> 0,
				rhogp -> 0,
				rhogpbar -> 0,
				phig -> 0,
			(*"Stochastic volatility of long-run risk"*)
			Esx -> 0.0078,
				vx -> 0.987,
				phisxs -> 2.3*^-6,
			(*"Stochastic volatility of consumption growth"*)
			Esc -> 0,
				vc -> 0,
				phiscv -> 0,
			(*"Stochastic volatility of inflation"*)
			Esp -> 0,
				vp -> 0,
				vpp -> 0,
				vppbar -> 0,
				phispw -> 0,
			(*"Real dividend growth"*)
				(* stock 1 *)
				mud[1] -> 0.0015,
					rhodx[1] -> 3,
					rhodp[1] -> 0,
					phidc[1] -> 0,
					phidp[1] -> 0,
					phidsp[1] -> 0,
					xid[1] -> 0,
					phids[1] -> 0,
					phidxc[1] -> 0,
					phidcc[1] -> 0,
					phidpc[1] -> 0,
					phidpp[1] -> 0,
					phidxd[1] -> 4.5,
					phidcd[1] -> 0,
					phidpd[1] -> 0,
					taugd[1] -> 0
		}
	|>,
(**********************************************************)
	"BYlowPers" -> <|
		"name" -> "Original long-run risk model but with
			low persistence",
		"shortname" -> "BYlowPers",
		"bibRef" -> "None",
		"desc" -> "Long-run risk and stochastic volatility
			persistance reduced to rhox=vx=0.5",
		"enabled" -> False,
		"stateVars" -> {x[t], sx[t]},
		"parameters" -> {
			(*"Preferences"*)
			delta -> 0.998,
				psi -> 1.5,
				gamma -> 10,
				theta -> (1 - gamma)/(1 - psi^(-1)),
			(*"Long-run risk"*)
			rhox -> 0.5,
				rhoxpbar -> 0,
				phix -> 0.044,
				phixc -> 0,
			(*"Inflation"*)
			mup -> 0,
				rhoppbar -> 0,
				rhop -> 0,
				phip -> 0,
				xip -> 0,
				phipc -> 0,
				phipx -> 0,
				phipcx -> 0,
				phipp -> 0,
				phipxp -> 0,
			(*"Expected inflation"*)
			mupbar -> 0,
				rhopbar -> 0,
				rhopbarx -> 0,
				phipbarp -> 0,
				phipbarc -> 0,
				phipbarx -> 0,
				phipbarcx -> 0,
				phipbarpb -> 0,
				phipbarxb -> 0,
				phipbarxp -> 0,
			(*"Real consumption growth"*)
			muc -> 0.0015,
				rhocx -> 1,
				rhocp -> 0,
				rhocpbar -> 0,
				phic -> 0,
				phicp -> 0,
				phicsp -> 0,
				xic -> 0,
				phics -> 0,
				phicx -> 1,
				phicc -> 0,
				phicpc -> 0,
				phicpp -> 0,
			(*"Nominal-real covariance (NRC)"*)
			Esg -> 0,
				rhog -> 0,
				rhogp -> 0,
				rhogpbar -> 0,
				phig -> 0,
			(*"Stochastic volatility of long-run risk"*)
			Esx -> 0.0078,
				vx -> 0.5,
				phisxs -> 2.3*^-6,
			(*"Stochastic volatility of consumption growth"*)
			Esc -> 0,
				vc -> 0,
				phiscv -> 0,
			(*"Stochastic volatility of inflation"*)
			Esp -> 0,
				vp -> 0,
				vpp -> 0,
				vppbar -> 0,
				phispw -> 0,
			(*"Real dividend growth"*)
				(* stock 1 *)
				mud[1] -> 0.0015,
					rhodx[1] -> 3,
					rhodp[1] -> 0,
					phidc[1] -> 0,
					phidp[1] -> 0,
					phidsp[1] -> 0,
					xid[1] -> 0,
					phids[1] -> 0,
					phidxc[1] -> 0,
					phidcc[1] -> 0,
					phidpc[1] -> 0,
					phidpp[1] -> 0,
					phidxd[1] -> 4.5,
					phidcd[1] -> 0,
					phidpd[1] -> 0,
					taugd[1] -> 0
		}
	|>,
(**********************************************************)
	"BYverylowPers" -> <|
		"name" -> "Original long-run risk model but with
			very low persistence",
		"shortname" -> "BYverylowPers",
		"bibRef" -> "None",
		"desc" -> "Long-run risk and stochastic volatility
			persistance reduced to rhox=vx=0.1",
		"enabled" -> False,
		"stateVars" -> {x[t], sx[t]},
		"parameters" -> {
			(*"Preferences"*)
			delta -> 0.998,
				psi -> 1.5,
				gamma -> 10,
				theta -> (1 - gamma)/(1 - psi^(-1)),
			(*"Long-run risk"*)
			rhox -> 0.1,
				rhoxpbar -> 0,
				phix -> 0.044,
				phixc -> 0,
			(*"Inflation"*)
			mup -> 0,
				rhoppbar -> 0,
				rhop -> 0,
				phip -> 0,
				xip -> 0,
				phipc -> 0,
				phipx -> 0,
				phipcx -> 0,
				phipp -> 0,
				phipxp -> 0,
			(*"Expected inflation"*)
			mupbar -> 0,
				rhopbar -> 0,
				rhopbarx -> 0,
				phipbarp -> 0,
				phipbarc -> 0,
				phipbarx -> 0,
				phipbarcx -> 0,
				phipbarpb -> 0,
				phipbarxb -> 0,
				phipbarxp -> 0,
			(*"Real consumption growth"*)
			muc -> 0.0015,
				rhocx -> 1,
				rhocp -> 0,
				rhocpbar -> 0,
				phic -> 0,
				phicp -> 0,
				phicsp -> 0,
				xic -> 0,
				phics -> 0,
				phicx -> 1,
				phicc -> 0,
				phicpc -> 0,
				phicpp -> 0,
			(*"Nominal-real covariance (NRC)"*)
			Esg -> 0,
				rhog -> 0,
				rhogp -> 0,
				rhogpbar -> 0,
				phig -> 0,
			(*"Stochastic volatility of long-run risk"*)
			Esx -> 0.0078,
				vx -> 0.1,
				phisxs -> 2.3*^-6,
			(*"Stochastic volatility of consumption growth"*)
			Esc -> 0,
				vc -> 0,
				phiscv -> 0,
			(*"Stochastic volatility of inflation"*)
			Esp -> 0,
				vp -> 0,
				vpp -> 0,
				vppbar -> 0,
				phispw -> 0,
			(*"Real dividend growth"*)
				(* stock 1 *)
				mud[1] -> 0.0015,
					rhodx[1] -> 3,
					rhodp[1] -> 0,
					phidc[1] -> 0,
					phidp[1] -> 0,
					phidsp[1] -> 0,
					xid[1] -> 0,
					phids[1] -> 0,
					phidxc[1] -> 0,
					phidcc[1] -> 0,
					phidpc[1] -> 0,
					phidpp[1] -> 0,
					phidxd[1] -> 4.5,
					phidcd[1] -> 0,
					phidpd[1] -> 0,
					taugd[1] -> 0
		}
	|>,
(**********************************************************)
	"BKY" -> <|
		"name" -> "New calibration of long-run risk model",
		"shortname" -> "BKY",
		"bibRef" -> "BKY2012",
		"desc" -> "Long-run risk model with a new
			calibration that matches moments better
			than the original 2004 calibration",
		"enabled" -> True,
		"stateVars" -> {x[t], sx[t]},
		"parameters" -> {
			(*"Preferences"*)
			delta -> 0.9989,
				psi -> 1.5,
				gamma -> 10,
				theta -> (1 - gamma)/(1 - psi^(-1)),
			(*"Long-run risk"*)
			rhox -> 0.975,
				rhoxpbar -> 0,
				phix -> 0.038,
				phixc -> 0,
			(*"Inflation"*)
			mup -> 0,
				rhoppbar -> 0,
				rhop -> 0,
				phip -> 0,
				xip -> 0,
				phipc -> 0,
				phipx -> 0,
				phipcx -> 0,
				phipp -> 0,
				phipxp -> 0,
			(*"Expected inflation"*)
			mupbar -> 0,
				rhopbar -> 0,
				rhopbarx -> 0,
				phipbarp -> 0,
				phipbarc -> 0,
				phipbarx -> 0,
				phipbarcx -> 0,
				phipbarpb -> 0,
				phipbarxb -> 0,
				phipbarxp -> 0,
			(*"Real consumption growth"*)
			muc -> 0.0015,
				rhocx -> 1,
				rhocp -> 0,
				rhocpbar -> 0,
				phic -> 0,
				phicp -> 0,
				phicsp -> 0,
				xic -> 0,
				phics -> 0,
				phicx -> 1,
				phicc -> 0,
				phicpc -> 0,
				phicpp -> 0,
			(*"Nominal-real covariance (NRC)"*)
			Esg -> 0,
				rhog -> 0,
				rhogp -> 0,
				rhogpbar -> 0,
				phig -> 0,
			(*"Stochastic volatility of long-run risk"*)
			Esx -> 0.0072,
				vx -> 0.999,
				phisxs -> 2.8000000000000003*^-6,
			(*"Stochastic volatility of consumption growth"*)
			Esc -> 0,
				vc -> 0,
				phiscv -> 0,
			(*"Stochastic volatility of inflation"*)
			Esp -> 0,
				vp -> 0,
				vpp -> 0,
				vppbar -> 0,
				phispw -> 0,
			(*"Real dividend growth"*)
				(* stock 1 *)
				mud[1] -> 0.0015,
					rhodx[1] -> 2.5,
					rhodp[1] -> 0,
					phidc[1] -> 0,
					phidp[1] -> 0,
					phidsp[1] -> 0,
					xid[1] -> 0,
					phids[1] -> 0,
					phidxc[1] -> 2.6,
					phidcc[1] -> 0,
					phidpc[1] -> 0,
					phidpp[1] -> 0,
					phidxd[1] -> 5.96,
					phidcd[1] -> 0,
					phidpd[1] -> 0,
					taugd[1] -> 0
		}
	|>,
(**********************************************************)
	"BKYlowPers" -> <|
		"name" -> "Long-run risk model of Bansal, Kiku and
			Yaron but with low persistence",
		"shortname" -> "BKYlowPers",
		"bibRef" -> "None",
		"desc" -> "Long-run risk and stochastic volatility
			persistance reduced to rhox=vx=0.5",
		"enabled" -> False,
		"stateVars" -> {x[t], sx[t]},
		"parameters" -> {
			(*"Preferences"*)
			delta -> 0.9989,
				psi -> 1.5,
				gamma -> 10,
				theta -> (1 - gamma)/(1 - psi^(-1)),
			(*"Long-run risk"*)
			rhox -> 0.5,
				rhoxpbar -> 0,
				phix -> 0.038,
				phixc -> 0,
			(*"Inflation"*)
			mup -> 0,
				rhoppbar -> 0,
				rhop -> 0,
				phip -> 0,
				xip -> 0,
				phipc -> 0,
				phipx -> 0,
				phipcx -> 0,
				phipp -> 0,
				phipxp -> 0,
			(*"Expected inflation"*)
			mupbar -> 0,
				rhopbar -> 0,
				rhopbarx -> 0,
				phipbarp -> 0,
				phipbarc -> 0,
				phipbarx -> 0,
				phipbarcx -> 0,
				phipbarpb -> 0,
				phipbarxb -> 0,
				phipbarxp -> 0,
			(*"Real consumption growth"*)
			muc -> 0.0015,
				rhocx -> 1,
				rhocp -> 0,
				rhocpbar -> 0,
				phic -> 0,
				phicp -> 0,
				phicsp -> 0,
				xic -> 0,
				phics -> 0,
				phicx -> 1,
				phicc -> 0,
				phicpc -> 0,
				phicpp -> 0,
			(*"Nominal-real covariance (NRC)"*)
			Esg -> 0,
				rhog -> 0,
				rhogp -> 0,
				rhogpbar -> 0,
				phig -> 0,
			(*"Stochastic volatility of long-run risk"*)
			Esx -> 0.0072,
				vx -> 0.5,
				phisxs -> 2.8*^-6,
			(*"Stochastic volatility of consumption growth"*)
			Esc -> 0,
				vc -> 0,
				phiscv -> 0,
			(*"Stochastic volatility of inflation"*)
			Esp -> 0,
				vp -> 0,
				vpp -> 0,
				vppbar -> 0,
				phispw -> 0,
			(*"Real dividend growth"*)
				(* stock 1 *)
				mud[1] -> 0.0015,
					rhodx[1] -> 2.5,
					rhodp[1] -> 0,
					phidc[1] -> 0,
					phidp[1] -> 0,
					phidsp[1] -> 0,
					xid[1] -> 0,
					phids[1] -> 0,
					phidxc[1] -> 2.6,
					phidcc[1] -> 0,
					phidpc[1] -> 0,
					phidpp[1] -> 0,
					phidxd[1] -> 5.96,
					phidcd[1] -> 0,
					phidpd[1] -> 0,
					taugd[1] -> 0
		}
	|>,
(**********************************************************)
	"BKYverylowPers" -> <|
		"name" -> "Long-run risk model of Bansal, Kiku and
			Yaron but with very low persistence",
		"shortname" -> "BKYverylowPers",
		"bibRef" -> "None",
		"desc" -> "Long-run risk and stochastic volatility
			persistance reduced to rhox=vx=0.1",
		"enabled" -> False,
		"stateVars" -> {x[t], sx[t]},
		"parameters" -> {
			(*"Preferences"*)
			delta -> 0.9989,
				psi -> 1.5,
				gamma -> 10,
				theta -> (1 - gamma)/(1 - psi^(-1)),
			(*"Long-run risk"*)
			rhox -> 0.1,
				rhoxpbar -> 0,
				phix -> 0.038,
				phixc -> 0,
			(*"Inflation"*)
			mup -> 0,
				rhoppbar -> 0,
				rhop -> 0,
				phip -> 0,
				xip -> 0,
				phipc -> 0,
				phipx -> 0,
				phipcx -> 0,
				phipp -> 0,
				phipxp -> 0,
			(*"Expected inflation"*)
			mupbar -> 0,
				rhopbar -> 0,
				rhopbarx -> 0,
				phipbarp -> 0,
				phipbarc -> 0,
				phipbarx -> 0,
				phipbarcx -> 0,
				phipbarpb -> 0,
				phipbarxb -> 0,
				phipbarxp -> 0,
			(*"Real consumption growth"*)
			muc -> 0.0015,
				rhocx -> 1,
				rhocp -> 0,
				rhocpbar -> 0,
				phic -> 0,
				phicp -> 0,
				phicsp -> 0,
				xic -> 0,
				phics -> 0,
				phicx -> 1,
				phicc -> 0,
				phicpc -> 0,
				phicpp -> 0,
			(*"Nominal-real covariance (NRC)"*)
			Esg -> 0,
				rhog -> 0,
				rhogp -> 0,
				rhogpbar -> 0,
				phig -> 0,
			(*"Stochastic volatility of long-run risk"*)
			Esx -> 0.0072,
				vx -> 0.1,
				phisxs -> 2.8*^-6,
			(*"Stochastic volatility of consumption growth"*)
			Esc -> 0,
				vc -> 0,
				phiscv -> 0,
			(*"Stochastic volatility of inflation"*)
			Esp -> 0,
				vp -> 0,
				vpp -> 0,
				vppbar -> 0,
				phispw -> 0,
			(*"Real dividend growth"*)
				(* stock 1 *)
				mud[1] -> 0.0015,
					rhodx[1] -> 2.5,
					rhodp[1] -> 0,
					phidc[1] -> 0,
					phidp[1] -> 0,
					phidsp[1] -> 0,
					xid[1] -> 0,
					phids[1] -> 0,
					phidxc[1] -> 2.6,
					phidcc[1] -> 0,
					phidpc[1] -> 0,
					phidpp[1] -> 0,
					phidxd[1] -> 5.96,
					phidcd[1] -> 0,
					phidpd[1] -> 0,
					taugd[1] -> 0
		}
	|>,
(**********************************************************)
	"BKYinf" -> <|
		"name" -> "Similar to Bansal-Kiku-Yaron but with
			inflation",
		"shortname" -> "BKYinf",
		"bibRef" -> "None",
		"desc" -> "Inflation is persistent and predicts
			consumption growth (without
			time-variation, without NRC)",
		"enabled" -> False,
		"stateVars" -> {x[t], sx[t], -mup + pi[t]},
		"parameters" -> {
			(*"Preferences"*)
			delta -> 0.998,
				psi -> 0.108086466108274,
				gamma -> 1 - theta + theta/psi,
				theta -> -0.0319364382914013,
			(*"Long-run risk"*)
			rhox -> 0.95,
				rhoxpbar -> 0,
				phix -> -0.0100455931054077,
				phixc -> 0,
			(*"Inflation"*)
			mup -> 0.0028955730909963,
				rhoppbar -> 0,
				rhop -> 0.985,
				phip -> -0.00043247571691955,
				xip -> 0,
				phipc -> 0,
				phipx -> 0,
				phipcx -> 0,
				phipp -> 0,
				phipxp -> 0,
			(*"Expected inflation"*)
			mupbar -> 0,
				rhopbar -> 0,
				rhopbarx -> 0,
				phipbarp -> 0,
				phipbarc -> 0,
				phipbarx -> 0,
				phipbarcx -> 0,
				phipbarpb -> 0,
				phipbarxb -> 0,
				phipbarxp -> 0,
			(*"Real consumption growth"*)
			muc -> 0.00157399080415904,
				rhocx -> 1,
				rhocp -> -0.292835401816459,
				rhocpbar -> 0,
				phic -> 0,
				phicp -> -0.00822757941067304,
				phicsp -> 0,
				xic -> 0,
				phics -> 0,
				phicx -> 1,
				phicc -> 0,
				phicpc -> 0,
				phicpp -> 0,
			(*"Nominal-real covariance (NRC)"*)
			Esg -> 0,
				rhog -> 0,
				rhogp -> 0,
				rhogpbar -> 0,
				phig -> 0,
			(*"Stochastic volatility of long-run risk"*)
			Esx -> 7.83587415060296*^-23,
				vx -> 0.979,
				phisxs -> 0.00530944692661557,
			(*"Stochastic volatility of consumption growth"*)
			Esc -> 0,
				vc -> 0,
				phiscv -> 0,
			(*"Stochastic volatility of inflation"*)
			Esp -> 0,
				vp -> 0,
				vpp -> 0,
				vppbar -> 0,
				phispw -> 0,
			(*"Real dividend growth"*)
				(* stock 1 *)
				mud[1] -> 0.00107967475744456,
					rhodx[1] -> 7.44835878922388,
					rhodp[1] -> 0.0347877157464962,
					phidc[1] -> 0,
					phidp[1] -> 0.0375725143683261,
					phidsp[1] -> 0,
					xid[1] -> 0,
					phids[1] -> 0,
					phidxc[1] -> 1.*^-8,
					phidcc[1] -> 0,
					phidpc[1] -> 0,
					phidpp[1] -> 0,
					phidxd[1] -> -0.794376370651053,
					phidcd[1] -> 0,
					phidpd[1] -> 0,
					taugd[1] -> 0
		}
	|>,
(**********************************************************)
	"NRC" -> <|
		"name" -> "Model with a nominal real covariance
			(NRC)",
		"shortname" -> "NRC",
		"bibRef" -> "BDRS2020",
		"desc" -> "Model without long-run risk. Inflation
			shocks predict consumption growth with
			time-varying sign given by the NRC",
		"enabled" -> True,
		"stateVars" -> {-mup + pi[t], sg[-1 + t]*eps["pi"][t], eps["pi"][t], -Esg + sg[t], -Esg^2 - phig^2/(1 - rhog^2) + sg[t]^2},
		"parameters" -> {
			(*"Preferences"*)
			delta -> 0.99,
				psi -> 2,
				gamma -> 15,
				theta -> (1 - gamma)/(1 - psi^(-1)),
			(*"Long-run risk"*)
			rhox -> 0,
				rhoxpbar -> 0,
				phix -> 0,
				phixc -> 0,
			(*"Inflation"*)
			mup -> 0.00327532,
				rhoppbar -> 0,
				rhop -> 0.79917,
				phip -> -0.0024624,
				xip -> 0.00073007,
				phipc -> 0,
				phipx -> 0,
				phipcx -> 0,
				phipp -> 0,
				phipxp -> 0,
			(*"Expected inflation"*)
			mupbar -> 0,
				rhopbar -> 0,
				rhopbarx -> 0,
				phipbarp -> 0,
				phipbarc -> 0,
				phipbarx -> 0,
				phipbarcx -> 0,
				phipbarpb -> 0,
				phipbarxb -> 0,
				phipbarxp -> 0,
			(*"Real consumption growth"*)
			muc -> 0.0016426,
				rhocx -> 0,
				rhocp -> -0.0521066,
				rhocpbar -> 0,
				phic -> 0.00204654,
				phicp -> 0,
				phicsp -> 0,
				xic -> -0.198287,
				phics -> 0,
				phicx -> 0,
				phicc -> 0,
				phicpc -> 0,
				phicpp -> 0,
			(*"Nominal-real covariance (NRC)"*)
			Esg -> -0.00624,
				rhog -> 0.996289,
				rhogp -> 0,
				rhogpbar -> 0,
				phig -> 0.002927236529485,
			(*"Stochastic volatility of long-run risk"*)
			Esx -> 0,
				vx -> 0,
				phisxs -> 0,
			(*"Stochastic volatility of consumption growth"*)
			Esc -> 0,
				vc -> 0,
				phiscv -> 0,
			(*"Stochastic volatility of inflation"*)
			Esp -> 0,
				vp -> 0,
				vpp -> 0,
				vppbar -> 0,
				phispw -> 0,
			(*"Real dividend growth"*)
				(* stock 1 *)
				mud[1] -> 0.000171798971158204,
					rhodx[1] -> 0,
					rhodp[1] -> 0.709922405282179,
					phidc[1] -> 0.033700231996206,
					phidp[1] -> 0,
					phidsp[1] -> 0,
					xid[1] -> -0.307616182414513,
					phids[1] -> 0,
					phidxc[1] -> 0,
					phidcc[1] -> 0,
					phidpc[1] -> 0,
					phidpp[1] -> 0,
					phidxd[1] -> 0,
					phidcd[1] -> 0,
					phidpd[1] -> 0,
					taugd[1] -> 0,
				(* stock 2 *)
				mud[2] -> 0.005964299279041,
					rhodx[2] -> 0,
					rhodp[2] -> 0.698934055063512,
					phidc[2] -> -0.051654152930244,
					phidp[2] -> 0,
					phidsp[2] -> 0,
					xid[2] -> 0.108236851752829,
					phids[2] -> 0,
					phidxc[2] -> 0,
					phidcc[2] -> 0,
					phidpc[2] -> 0,
					phidpp[2] -> 0,
					phidxd[2] -> 0,
					phidcd[2] -> 0,
					phidpd[2] -> 0,
					taugd[2] -> 0,
				(* stock 3 *)
				mud[3] -> 0.000344066546708281,
					rhodx[3] -> 0,
					rhodp[3] -> -0.234446726759537,
					phidc[3] -> 0.031806774038977,
					phidp[3] -> 0,
					phidsp[3] -> 0,
					xid[3] -> 0.194175986681852,
					phids[3] -> 0,
					phidxc[3] -> 0,
					phidcc[3] -> 0,
					phidpc[3] -> 0,
					phidpp[3] -> 0,
					phidxd[3] -> 0,
					phidcd[3] -> 0,
					phidpd[3] -> 0,
					taugd[3] -> 0
		}
	|>,
(**********************************************************)
	"NRCLLR" -> <|
		"name" -> "Same as NRC model but with long-run risk",
		"shortname" -> "NRCLLR",
		"bibRef" -> "None",
		"desc" -> "Long-run risk added with same
			qualitative properties as in
			Bansal-Yaron (but different parameters)",
		"enabled" -> False,
		"stateVars" -> {-mup + pi[t], sg[-1 + t]*eps["pi"][t], eps["pi"][t], -Esg + sg[t], -Esg^2 - phig^2/(1 - rhog^2) + sg[t]^2, x[t], sx[t]},
		"parameters" -> {
			(*"Preferences"*)
			delta -> 0.99,
				psi -> 2,
				gamma -> 15,
				theta -> (1 - gamma)/(1 - psi^(-1)),
			(*"Long-run risk"*)
			rhox -> 0.975,
				rhoxpbar -> 0,
				phix -> 0.038,
				phixc -> 0,
			(*"Inflation"*)
			mup -> 0.00327532,
				rhoppbar -> 0,
				rhop -> 0.79917,
				phip -> -0.0024624,
				xip -> 0.00073007,
				phipc -> 0,
				phipx -> 0,
				phipcx -> 0,
				phipp -> 0,
				phipxp -> 0,
			(*"Expected inflation"*)
			mupbar -> 0,
				rhopbar -> 0,
				rhopbarx -> 0,
				phipbarp -> 0,
				phipbarc -> 0,
				phipbarx -> 0,
				phipbarcx -> 0,
				phipbarpb -> 0,
				phipbarxb -> 0,
				phipbarxp -> 0,
			(*"Real consumption growth"*)
			muc -> 0.0016426,
				rhocx -> 1.1,
				rhocp -> -0.0521066,
				rhocpbar -> 0,
				phic -> 0,
				phicp -> 0,
				phicsp -> 0,
				xic -> -0.198287,
				phics -> 0,
				phicx -> 1.1,
				phicc -> 0,
				phicpc -> 0,
				phicpp -> 0,
			(*"Nominal-real covariance (NRC)"*)
			Esg -> -0.00624,
				rhog -> 0.996289,
				rhogp -> 0,
				rhogpbar -> 0,
				phig -> 0.002927236529485,
			(*"Stochastic volatility of long-run risk"*)
			Esx -> 0.0072,
				vx -> 0.999,
				phisxs -> 2.8*^-6,
			(*"Stochastic volatility of consumption growth"*)
			Esc -> 0,
				vc -> 0,
				phiscv -> 0,
			(*"Stochastic volatility of inflation"*)
			Esp -> 0,
				vp -> 0,
				vpp -> 0,
				vppbar -> 0,
				phispw -> 0,
			(*"Real dividend growth"*)
				(* stock 1 *)
				mud[1] -> 0.000344066546708281,
					rhodx[1] -> 2.5,
					rhodp[1] -> -0.234446726759537,
					phidc[1] -> 0,
					phidp[1] -> 0,
					phidsp[1] -> 0,
					xid[1] -> 0.194175986681852,
					phids[1] -> 0,
					phidxc[1] -> 0.031806774038977,
					phidcc[1] -> 0,
					phidpc[1] -> 0,
					phidpp[1] -> 0,
					phidxd[1] -> 5.96,
					phidcd[1] -> 0,
					phidpd[1] -> 0,
					taugd[1] -> 0,
				(* stock 2 *)
				mud[2] -> 0.005964299279041,
					rhodx[2] -> 2,
					rhodp[2] -> 0.698934055063512,
					phidc[2] -> 0,
					phidp[2] -> 0,
					phidsp[2] -> 0,
					xid[2] -> 0.108236851752829,
					phids[2] -> 0,
					phidxc[2] -> -0.051654152930244,
					phidcc[2] -> 0,
					phidpc[2] -> 0,
					phidpp[2] -> 0,
					phidxd[2] -> 3,
					phidcd[2] -> 0,
					phidpd[2] -> 0,
					taugd[2] -> 0,
				(* stock 3 *)
				mud[3] -> 0.000171798971158204,
					rhodx[3] -> 0.5,
					rhodp[3] -> 0.709922405282179,
					phidc[3] -> 0,
					phidp[3] -> 0,
					phidsp[3] -> 0,
					xid[3] -> -0.307616182414513,
					phids[3] -> 0,
					phidxc[3] -> 0.033700231996206,
					phidcc[3] -> 0,
					phidpc[3] -> 0,
					phidpp[3] -> 0,
					phidxd[3] -> 2,
					phidcd[3] -> 0,
					phidpd[3] -> 0,
					taugd[3] -> 0
		}
	|>,
(**********************************************************)
	"WCratio" -> <|
		"name" -> "Long Run Risk, the Wealth-Consumption
			Ratio, and the Temporal Pricing of Risk",
		"shortname" -> "WCratio",
		"bibRef" -> "KLNV2010",
		"desc" -> "Long-run risk model with long-run risk
			in expected inflation and no real
			effects of inflation",
		"enabled" -> False,
		"stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
		"parameters" -> {
			(*"Preferences"*)
			delta -> 0.9987,
				psi -> 1.5,
				gamma -> 8,
				theta -> (1 - gamma)/(1 - psi^(-1)),
			(*"Long-run risk"*)
			rhox -> 0.991,
				rhoxpbar -> 0,
				phix -> 1,
				phixc -> 0,
			(*"Inflation"*)
			mup -> mupbar,
				rhoppbar -> 1,
				rhop -> 0,
				phip -> 0.0035,
				xip -> 0,
				phipc -> 0,
				phipx -> -2,
				phipcx -> 0,
				phipp -> 0,
				phipxp -> 0,
			(*"Expected inflation"*)
			mupbar -> 0.0032,
				rhopbar -> 0.83,
				rhopbarx -> -0.35,
				phipbarp -> 1/250000,
				phipbarc -> 0,
				phipbarx -> -1,
				phipbarcx -> 0,
				phipbarpb -> 0,
				phipbarxb -> 0,
				phipbarxp -> 0,
			(*"Real consumption growth"*)
			muc -> 0.0016,
				rhocx -> 1,
				rhocp -> 0,
				rhocpbar -> 0,
				phic -> 0,
				phicp -> 0,
				phicsp -> 0,
				xic -> 0,
				phics -> 0,
				phicx -> 0,
				phicc -> 1,
				phicpc -> 0,
				phicpp -> 0,
			(*"Nominal-real covariance (NRC)"*)
			Esg -> 0,
				rhog -> 0,
				rhogp -> 0,
				rhogpbar -> 0,
				phig -> 0,
			(*"Stochastic volatility of long-run risk"*)
			Esx -> 0.004*Esc,
				vx -> 0.996,
				phisxs -> 0.0036,
			(*"Stochastic volatility of consumption growth"*)
			Esc -> 0.004,
				vc -> 0.85,
				phiscv -> 1.1499999999999996*^-6,
			(*"Stochastic volatility of inflation"*)
			Esp -> 0,
				vp -> 0,
				vpp -> 0,
				vppbar -> 0,
				phispw -> 0,
			(*"Real dividend growth"*)
				(* stock 1 *)
				mud[1] -> 0.0015,
					rhodx[1] -> 1.5,
					rhodp[1] -> 0,
					phidc[1] -> 0,
					phidp[1] -> 0,
					phidsp[1] -> 0,
					xid[1] -> 0,
					phids[1] -> 0,
					phidxc[1] -> 0,
					phidcc[1] -> 0,
					phidpc[1] -> 0,
					phidpp[1] -> 0,
					phidxd[1] -> 0,
					phidcd[1] -> 6,
					phidpd[1] -> 0,
					taugd[1] -> 0.1
		}
	|>,
(**********************************************************)
	"WCratioInf" -> <|
		"name" -> "Same as WCratio model but with real
			effects of inflation",
		"shortname" -> "WCratioInf",
		"bibRef" -> "None",
		"desc" -> "Inflation predicts consumption growth
			(without time-variation, without NRC)",
		"enabled" -> False,
		"stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
		"parameters" -> {
			(*"Preferences"*)
			delta -> 0.9987,
				psi -> 1.5,
				gamma -> 8,
				theta -> (1 - gamma)/(1 - psi^(-1)),
			(*"Long-run risk"*)
			rhox -> 0.991,
				rhoxpbar -> 0,
				phix -> 1,
				phixc -> 0,
			(*"Inflation"*)
			mup -> mupbar,
				rhoppbar -> 1,
				rhop -> 0,
				phip -> 0.0035,
				xip -> 0,
				phipc -> 0,
				phipx -> -2,
				phipcx -> 0,
				phipp -> 0,
				phipxp -> 0,
			(*"Expected inflation"*)
			mupbar -> 0.0032,
				rhopbar -> 0.83,
				rhopbarx -> -0.35,
				phipbarp -> 1/250000,
				phipbarc -> 0,
				phipbarx -> -1,
				phipbarcx -> 0,
				phipbarpb -> 0,
				phipbarxb -> 0,
				phipbarxp -> 0,
			(*"Real consumption growth"*)
			muc -> 0.0016,
				rhocx -> 1,
				rhocp -> 0.3,
				rhocpbar -> 0,
				phic -> 0,
				phicp -> 0,
				phicsp -> 0,
				xic -> 0,
				phics -> 0,
				phicx -> 0,
				phicc -> 1,
				phicpc -> 0,
				phicpp -> 0,
			(*"Nominal-real covariance (NRC)"*)
			Esg -> 0,
				rhog -> 0,
				rhogp -> 0,
				rhogpbar -> 0,
				phig -> 0,
			(*"Stochastic volatility of long-run risk"*)
			Esx -> 0.004*Esc,
				vx -> 0.996,
				phisxs -> 0.0036,
			(*"Stochastic volatility of consumption growth"*)
			Esc -> 0.004,
				vc -> 0.85,
				phiscv -> 1.1499999999999996*^-6,
			(*"Stochastic volatility of inflation"*)
			Esp -> 0,
				vp -> 0,
				vpp -> 0,
				vppbar -> 0,
				phispw -> 0,
			(*"Real dividend growth"*)
				(* stock 1 *)
				mud[1] -> 0.0015,
					rhodx[1] -> 1.5,
					rhodp[1] -> 0,
					phidc[1] -> 0,
					phidp[1] -> 0,
					phidsp[1] -> 0,
					xid[1] -> 0,
					phids[1] -> 0,
					phidxc[1] -> 0,
					phidcc[1] -> 0,
					phidpc[1] -> 0,
					phidpp[1] -> 0,
					phidxd[1] -> 0,
					phidcd[1] -> 6,
					phidpd[1] -> 0,
					taugd[1] -> 0.1
		}
	|>,
(**********************************************************)
	"infStochVol" -> <|
		"name" -> "Similar to Bansal, Kiku and Yaron but
			adding inflation that has stochastic
			volatility",
		"shortname" -> "infStochVol",
		"bibRef" -> "None",
		"desc" -> "Volatility of inflation is different
			from volatility of long-run risk and
			depends on inflation levels",
		"enabled" -> False,
		"stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
		"parameters" -> {
			(*"Preferences"*)
			delta -> 0.9989,
				psi -> 1.5,
				gamma -> 10,
				theta -> (1 - gamma)/(1 - psi^(-1)),
			(*"Long-run risk"*)
			rhox -> 0.975,
				rhoxpbar -> 0,
				phix -> 0.038,
				phixc -> 0,
			(*"Inflation"*)
			mup -> 0.00327532,
				rhoppbar -> 0,
				rhop -> 0.98,
				phip -> 0,
				xip -> 0,
				phipc -> 0,
				phipx -> 0,
				phipcx -> 0,
				phipp -> 0.1,
				phipxp -> 0,
			(*"Expected inflation"*)
			mupbar -> 0,
				rhopbar -> 0,
				rhopbarx -> 0,
				phipbarp -> 0,
				phipbarc -> 0,
				phipbarx -> 0,
				phipbarcx -> 0,
				phipbarpb -> 0,
				phipbarxb -> 0,
				phipbarxp -> 0,
			(*"Real consumption growth"*)
			muc -> 0.0015,
				rhocx -> 1,
				rhocp -> 0.9,
				rhocpbar -> 0,
				phic -> 0,
				phicp -> 0,
				phicsp -> 0,
				xic -> 0,
				phics -> 0.5,
				phicx -> 0,
				phicc -> 0,
				phicpc -> 0,
				phicpp -> 0,
			(*"Nominal-real covariance (NRC)"*)
			Esg -> 0,
				rhog -> 0,
				rhogp -> 0,
				rhogpbar -> 0,
				phig -> 0,
			(*"Stochastic volatility of long-run risk"*)
			Esx -> 0.0072,
				vx -> 0.999,
				phisxs -> 2.8*^-6,
			(*"Stochastic volatility of consumption growth"*)
			Esc -> 0,
				vc -> 0,
				phiscv -> 0,
			(*"Stochastic volatility of inflation"*)
			Esp -> 0.01,
				vp -> 0.995,
				vpp -> 0.1,
				vppbar -> 0,
				phispw -> 0.000028,
			(*"Real dividend growth"*)
				(* stock 1 *)
				mud[1] -> 0.0015,
					rhodx[1] -> 2.5,
					rhodp[1] -> -3,
					phidc[1] -> 0,
					phidp[1] -> 0,
					phidsp[1] -> 0,
					xid[1] -> 0,
					phids[1] -> 0.1,
					phidxc[1] -> 0,
					phidcc[1] -> 0,
					phidpc[1] -> 0,
					phidpp[1] -> 0,
					phidxd[1] -> 0,
					phidcd[1] -> 0,
					phidpd[1] -> 0,
					taugd[1] -> 0
		}
	|>,
(**********************************************************)
	"hassel" -> <|
		"name" -> "Hasseltoft's Stocks, Bonds, and Long-Run
			Consumption Risks",
		"shortname" -> "hassel",
		"bibRef" -> "Ha2012",
		"desc" -> "Expected inflation has no real effects
			but its shock is correlated with
			long-run risk shocks",
		"enabled" -> False,
		"stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
		"parameters" -> {
			(*"Preferences"*)
			delta -> 0.9992,
				psi -> 2.51,
				gamma -> 6.78,
				theta -> (1 - gamma)/(1 - psi^(-1)),
			(*"Long-run risk"*)
			rhox -> 0.9957,
				rhoxpbar -> 0,
				phix -> 0.0248,
				phixc -> 0,
			(*"Inflation"*)
			mup -> 0.00305,
				rhoppbar -> 1,
				rhop -> 0,
				phip -> 0,
				xip -> 0,
				phipc -> 0,
				phipx -> 0,
				phipcx -> 0,
				phipp -> 0,
				phipxp -> 0.584,
			(*"Expected inflation"*)
			mupbar -> 0,
				rhopbar -> 0.9851,
				rhopbarx -> 0,
				phipbarp -> 0,
				phipbarc -> 0,
				phipbarx -> -0.1254,
				phipbarcx -> 0,
				phipbarpb -> 0,
				phipbarxb -> 0.0475,
				phipbarxp -> 0,
			(*"Real consumption growth"*)
			muc -> 0.00268,
				rhocx -> 1,
				rhocp -> 0,
				rhocpbar -> 0,
				phic -> 0,
				phicp -> 0,
				phicsp -> 0,
				xic -> 0,
				phics -> 0,
				phicx -> 1,
				phicc -> 0,
				phicpc -> 0,
				phicpp -> 0,
			(*"Nominal-real covariance (NRC)"*)
			Esg -> 0,
				rhog -> 0,
				rhogp -> 0,
				rhogpbar -> 0,
				phig -> 0,
			(*"Stochastic volatility of long-run risk"*)
			Esx -> 0.0012,
				vx -> 0.9968,
				phisxs -> 6.91*^-7,
			(*"Stochastic volatility of consumption growth"*)
			Esc -> 0,
				vc -> 0,
				phiscv -> 0,
			(*"Stochastic volatility of inflation"*)
			Esp -> 0,
				vp -> 0,
				vpp -> 0,
				vppbar -> 0,
				phispw -> 0,
			(*"Real dividend growth"*)
				(* stock 1 *)
				mud[1] -> 0.00336,
					rhodx[1] -> 2.85,
					rhodp[1] -> 0,
					phidc[1] -> 0,
					phidp[1] -> 0,
					phidsp[1] -> 0,
					xid[1] -> 0,
					phids[1] -> 0,
					phidxc[1] -> 0,
					phidcc[1] -> 0,
					phidpc[1] -> 0,
					phidpp[1] -> 0,
					phidxd[1] -> 3.51,
					phidcd[1] -> 0,
					phidpd[1] -> 0,
					taugd[1] -> 0
		}
	|>,
(**********************************************************)
	"hasselNRC" -> <|
		"name" -> "Similar to model hassel but with an NRC
			added",
		"shortname" -> "hasselNRC",
		"bibRef" -> "None",
		"desc" -> "NRC modeled as in model NRC (inflation
			shocks predict consumption in
			time-varying way)",
		"enabled" -> False,
		"stateVars" -> {x[t], sx[t], -mupbar + pibar[t], -mup + pi[t], sg[-1 + t]*eps["pi"][t], eps["pi"][t], -Esg + sg[t], -Esg^2 - phig^2/(1 - rhog^2) + sg[t]^2},
		"parameters" -> {
			(*"Preferences"*)
			delta -> 0.9995,
				psi -> 1.1,
				gamma -> 10,
				theta -> (1 - gamma)/(1 - psi^(-1)),
			(*"Long-run risk"*)
			rhox -> 0.99799425434403,
				rhoxpbar -> 0,
				phix -> 0.0264662768420059,
				phixc -> 0,
			(*"Inflation"*)
			mup -> 0.0026783333333333333,
				rhoppbar -> 1,
				rhop -> 0,
				phip -> -0.00113036349091719,
				xip -> 0.000180772046045595,
				phipc -> 0,
				phipx -> 0,
				phipcx -> 0,
				phipp -> 0,
				phipxp -> 0,
			(*"Expected inflation"*)
			mupbar -> 0,
				rhopbar -> 0.987407719234994,
				rhopbarx -> 0,
				phipbarp -> 0,
				phipbarc -> 0,
				phipbarx -> -0.126859368214192,
				phipbarcx -> 0,
				phipbarpb -> 0,
				phipbarxb -> 0,
				phipbarxp -> 0,
			(*"Real consumption growth"*)
			muc -> 0.0015254166666666667,
				rhocx -> 1,
				rhocp -> 0,
				rhocpbar -> 0,
				phic -> 0,
				phicp -> 0,
				phicsp -> 0,
				xic -> -0.0333902612981879,
				phics -> 0,
				phicx -> 1,
				phicc -> 0,
				phicpc -> 0,
				phicpp -> 0,
			(*"Nominal-real covariance (NRC)"*)
			Esg -> -0.213776184026323,
				rhog -> 0.999320612198705,
				rhogp -> 0,
				rhogpbar -> 0,
				phig -> -0.00284672153301256,
			(*"Stochastic volatility of long-run risk"*)
			Esx -> 0.00170641799681817,
				vx -> 0.996121051830535,
				phisxs -> 3.56237083131304*^-7,
			(*"Stochastic volatility of consumption growth"*)
			Esc -> 0,
				vc -> 0,
				phiscv -> 0,
			(*"Stochastic volatility of inflation"*)
			Esp -> 0,
				vp -> 0,
				vpp -> 0,
				vppbar -> 0,
				phispw -> 0,
			(*"Real dividend growth"*)
				(* stock 1 *)
				mud[1] -> 0.002051583333333333,
					rhodx[1] -> 1.08018432018336,
					rhodp[1] -> 0,
					phidc[1] -> 0,
					phidp[1] -> 0,
					phidsp[1] -> 0,
					xid[1] -> -0.19702972082852,
					phids[1] -> 0,
					phidxc[1] -> 2.54962331798982,
					phidcc[1] -> 0,
					phidpc[1] -> 0,
					phidpp[1] -> 0,
					phidxd[1] -> 0,
					phidcd[1] -> 0,
					phidpd[1] -> 0,
					taugd[1] -> 0
		}
	|>,
(**********************************************************)
	"BS" -> <|
		"name" -> "A Long-Run Risks Explanation of
			Predictability Puzzles in Bond and
			Currency Markets",
		"shortname" -> "BS",
		"bibRef" -> "BSh2012",
		"desc" -> "Long-run risk depends on expected
			inflation, expected inflation is
			persistent",
		"enabled" -> False,
		"stateVars" -> {x[t], -mupbar + pibar[t], sx[t], sp[t]},
		"parameters" -> {
			(*"Preferences"*)
			delta -> 0.994,
				psi -> 1.81,
				gamma -> 20.9,
				theta -> (1 - gamma)/(1 - psi^(-1)),
			(*"Long-run risk"*)
			rhox -> 0.81,
				rhoxpbar -> -0.047,
				phix -> 1,
				phixc -> 0,
			(*"Inflation"*)
			mup -> 9/1000,
				rhoppbar -> 1,
				rhop -> 0,
				phip -> 0.0055,
				xip -> 0,
				phipc -> 0,
				phipx -> 0,
				phipcx -> 0,
				phipp -> 0,
				phipxp -> 0,
			(*"Expected inflation"*)
			mupbar -> 0,
				rhopbar -> 0.988,
				rhopbarx -> 0,
				phipbarp -> 0,
				phipbarc -> 0,
				phipbarx -> 0,
				phipbarcx -> 0,
				phipbarpb -> 1,
				phipbarxb -> 0,
				phipbarxp -> 0,
			(*"Real consumption growth"*)
			muc -> 0.004900000000000001,
				rhocx -> 1,
				rhocp -> 0,
				rhocpbar -> 0,
				phic -> 0.0046,
				phicp -> 0,
				phicsp -> 0,
				xic -> 0,
				phics -> 0,
				phicx -> 0,
				phicc -> 0,
				phicpc -> 0,
				phicpp -> 0,
			(*"Nominal-real covariance (NRC)"*)
			Esg -> 0,
				rhog -> 0,
				rhogp -> 0,
				rhogpbar -> 0,
				phig -> 0,
			(*"Stochastic volatility of long-run risk"*)
			Esx -> 0.00109,
				vx -> 0.994,
				phisxs -> 1.85*^-7,
			(*"Stochastic volatility of consumption growth"*)
			Esc -> 0,
				vc -> 0,
				phiscv -> 0,
			(*"Stochastic volatility of inflation"*)
			Esp -> 0.00111,
				vp -> 0.979,
				vpp -> 0.02,
				vppbar -> 0.03,
				phispw -> 1.81*^-7,
			(*"Real dividend growth"*)
				(* stock 1 *)
				mud[1] -> 0.004900000000000001,
					rhodx[1] -> 2.5,
					rhodp[1] -> 0,
					phidc[1] -> 0,
					phidp[1] -> 1/200,
					phidsp[1] -> 0,
					xid[1] -> 0,
					phids[1] -> 0,
					phidxc[1] -> 0,
					phidcc[1] -> 0,
					phidpc[1] -> 0,
					phidpp[1] -> 0,
					phidxd[1] -> 0,
					phidcd[1] -> 0,
					phidpd[1] -> 0,
					taugd[1] -> 0
		}
	|>,
(**********************************************************)
	"DES" -> <|
		"name" -> "Long-Run Consumption and Inflation Risks
			in Stock and Bond Returns of Duarte,
			Elias and Szymanowska",
		"shortname" -> "DES",
		"bibRef" -> "des2023stocksbonds",
		"desc" -> "Long-run risk model with real effects of
			inflation",
		"enabled" -> True,
		"stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t]*eps["pi"][t], eps["pi"][t], -Esg + sg[t], -Esg^2 - phig^2/(1 - rhog^2) + sg[t]^2},
		"parameters" -> {
			(*"Preferences"*)
			delta -> 0.9995,
				psi -> 1.1,
				gamma -> 10,
				theta -> (1 - gamma)/(1 - psi^(-1)),
			(*"Long-run risk"*)
			rhox -> 0.998,
				rhoxpbar -> 0.001,
				phix -> 0.0265,
				phixc -> 0,
			(*"Inflation"*)
			mup -> 0.0027,
				rhoppbar -> 1,
				rhop -> 0,
				phip -> -0.0011,
				xip -> 0.000181,
				phipc -> 0,
				phipx -> 0,
				phipcx -> 0,
				phipp -> 0,
				phipxp -> 0,
			(*"Expected inflation"*)
			mupbar -> 0,
				rhopbar -> 0.9874,
				rhopbarx -> 0,
				phipbarp -> 0,
				phipbarc -> 0,
				phipbarx -> -0.1269,
				phipbarcx -> 0,
				phipbarpb -> 0,
				phipbarxb -> -0.1438,
				phipbarxp -> 0,
			(*"Real consumption growth"*)
			muc -> 0.0015,
				rhocx -> 1,
				rhocp -> 0,
				rhocpbar -> 0,
				phic -> 0,
				phicp -> 0,
				phicsp -> 0,
				xic -> -0.0334,
				phics -> 0,
				phicx -> 1,
				phicc -> 0,
				phicpc -> 0,
				phicpp -> 0,
			(*"Nominal-real covariance (NRC)"*)
			Esg -> -0.2138,
				rhog -> 0.9993,
				rhogp -> 0,
				rhogpbar -> 0,
				phig -> -0.0035,
			(*"Stochastic volatility of long-run risk"*)
			Esx -> 0.0017,
				vx -> 0.9961,
				phisxs -> 3.56*^-7,
			(*"Stochastic volatility of consumption growth"*)
			Esc -> 0,
				vc -> 0,
				phiscv -> 0,
			(*"Stochastic volatility of inflation"*)
			Esp -> 0,
				vp -> 0,
				vpp -> 0,
				vppbar -> 0,
				phispw -> 0,
			(*"Real dividend growth"*)
				(* stock 1 *)
				mud[1] -> 0.0021,
					rhodx[1] -> 1.0802,
					rhodp[1] -> 0,
					phidc[1] -> 0,
					phidp[1] -> 0,
					phidsp[1] -> 0,
					xid[1] -> -0.147,
					phids[1] -> 0,
					phidxc[1] -> 2.5496,
					phidcc[1] -> 0,
					phidpc[1] -> 0,
					phidpp[1] -> 0,
					phidxd[1] -> 0,
					phidcd[1] -> 0,
					phidpd[1] -> 0,
					taugd[1] -> 0
		}
	|>,
(**********************************************************)
	"NRCStochVol" -> <|
		"name" -> "Model with a nominal real covariance
			(NRC) and stochastic volatility of
			expected inflation",
		"shortname" -> "NRCStochVol",
		"bibRef" -> "n/a",
		"desc" -> "Model without long-run risk. Inflation
			shocks predict consumption growth with
			time-varying sign given by the NRC and
			expected inflation has stochastic
			volatility",
		"enabled" -> True,
		"stateVars" -> {-mup + pi[t], sg[-1 + t]*eps["pi"][t], eps["pi"][t], -Esg + sg[t], (phip^2*rhogp^2 + Esp^2*phipbarpb^2*rhogpbar^2 - phip^2*rhog*rhogp^2*rhopbar + Esp^2*phipbarpb^2*rhog*rhogpbar^2*rhopbar - phip^2*rhogp^2*rhopbar^2 + phip^2*rhog*rhogp^2*rhopbar^3 + phig^2*(-1 + rhog*rhopbar)*(-1 + rhopbar^2) - Esg^2*(-1 + rhog^2)*(-1 + rhog*rhopbar)*(-1 + rhopbar^2) + 2*Esp^2*phipbarpb^2*rhog*rhogp*rhogpbar*rhoppbar + 2*Esp^2*phipbarpb^2*rhogp*rhogpbar*rhopbar*rhoppbar + Esp^2*phipbarpb^2*rhogp^2*rhoppbar^2 + Esp^2*phipbarpb^2*rhog*rhogp^2*rhopbar*rhoppbar^2 + 2*phip*rhog*rhogp^2*(-1 + rhog*rhopbar)*(-1 + rhopbar^2)*xip + rhogp^2*(-1 + rhog*rhopbar)*(-1 + rhopbar^2)*xip^2)/((-1 + rhog^2)*(-1 + rhog*rhopbar)*(-1 + rhopbar^2)) + sg[t]^2, -mupbar + pibar[t], sp[t]},
		"parameters" -> {
			(*"Preferences"*)
			delta -> 0.99,
				psi -> 1.2,
				gamma -> 15,
				theta -> (1 - gamma)/(1 - psi^(-1)),
			(*"Long-run risk"*)
			rhox -> 0,
				rhoxpbar -> 0,
				phix -> 0,
				phixc -> 0,
			(*"Inflation"*)
			mup -> 0.0033,
				rhoppbar -> 1.05,
				rhop -> 0,
				phip -> 1.1,
				xip -> 1.1,
				phipc -> 0,
				phipx -> 0,
				phipcx -> 0,
				phipp -> 0,
				phipxp -> 0,
			(*"Expected inflation"*)
			mupbar -> 0.0033,
				rhopbar -> 0.9,
				rhopbarx -> 0,
				phipbarp -> 0,
				phipbarc -> 0,
				phipbarx -> 0,
				phipbarcx -> 0,
				phipbarpb -> 1.1,
				phipbarxb -> 0,
				phipbarxp -> 0,
			(*"Real consumption growth"*)
			muc -> 0.0016,
				rhocx -> 0,
				rhocp -> 0.2,
				rhocpbar -> 0.01,
				phic -> 0.0021,
				phicp -> 0.002,
				phicsp -> 0,
				xic -> -0.198,
				phics -> 0,
				phicx -> 0,
				phicc -> 0,
				phicpc -> 0,
				phicpp -> 0,
			(*"Nominal-real covariance (NRC)"*)
			Esg -> 0.000062,
				rhog -> 0.998,
				rhogp -> 0,
				rhogpbar -> 0,
				phig -> 0.0029,
			(*"Stochastic volatility of long-run risk"*)
			Esx -> 0,
				vx -> 0,
				phisxs -> 0,
			(*"Stochastic volatility of consumption growth"*)
			Esc -> 0,
				vc -> 0,
				phiscv -> 0,
			(*"Stochastic volatility of inflation"*)
			Esp -> 0.01,
				vp -> 0.9795,
				vpp -> -7/100000,
				vppbar -> 7/1000000,
				phispw -> 1.81*^-7,
			(*"Real dividend growth"*)
				(* stock 1 *)
				mud[1] -> 0.0016,
					rhodx[1] -> 0,
					rhodp[1] -> 0.2,
					phidc[1] -> 0.0021,
					phidp[1] -> 0.002,
					phidsp[1] -> 0,
					xid[1] -> -0.198,
					phids[1] -> 0,
					phidxc[1] -> 0,
					phidcc[1] -> 0,
					phidpc[1] -> 0,
					phidpp[1] -> 0,
					phidxd[1] -> 0,
					phidcd[1] -> 0,
					phidpd[1] -> 0,
					taugd[1] -> 0
		}
	|>
|>;(*end models*)


(* ::Subsection:: *)
(*modelsExtraInfo*)


(* ::Code::Initialization::"Tags"-><|"UppercaseParameter" -> <||>|>:: *)
modelsExtraInfo = <|
	"BY" -> <|
		"coeffs" ->
		<|
			"bond" -> With[
				{
					A = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc,
					R = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb[[0]],
					n = FernandoDuarte`LongRunRisk`Model`ProcessModels`Private`n
				},
				{
					R[n_][1] :> ((-1 + rhox^n)*(-((1 + E^A[0])*theta) + psi*(-1 + theta)*(1 - A[1] + E^A[0]*(1 + (-1 + rhox)*A[1]))))/((1 + E^A[0])*psi*(-1 + rhox)),
					R[n_][2] :> ((1 + E^A[0])^2*theta^2*(-2*phix^2*rhox^(2 + n)*(-1 + vx) + phix^2*rhox^(1 + 2*n)*(-1 + vx) + 2*phix^2*rhox^n*(-1 + vx)*vx - phix^2*rhox^(2*n)*(-1 + vx)*vx + rhox^5*(-1 + vx^n) - rhox^4*(2 + vx)*(-1 + vx^n) + rhox^3*(1 + phix^2 + vx)*(-1 + vx^n) + vx*(-((1 + phix^2)*vx) + phix^2*vx^n + vx^(1 + n)) + rhox*((1 + phix^2)*vx + 2*vx^2 + phix^2*vx^n - (1 + 2*phix^2)*vx^(1 + n) -   2*vx^(2 + n)) + rhox^2*((-1 + phix^2)*vx - vx^2 - 2*phix^2*vx^n + (1 + phix^2)*vx^(1 + n) + vx^(2 + n))) - 2*(1 + E^A[0])*psi*(-1 + theta)*theta*((1 + E^A[0])*rhox^5*(-1 + vx^n) - (1 + E^A[0])*rhox^4*(2 + vx)*(-1 + vx^n) + phix^2*rhox^(2 + n)*(-1 + vx)*(E^A[0]*(-2 + A[1]) + 2*(-1 + A[1])) - phix^2*rhox^n*(-1 + vx)*vx*(E^A[0]*(-2 + A[1]) + 2*(-1 + A[1])) + rhox*(2*(1 + E^A[0])*vx^2 - 2*(1 + E^A[0])*vx^(2 + n) + vx*(1 + E^A[0]*(1 + phix^2) - phix^2*(-1 + A[1])) + vx^(1 + n)*(-1 + E^A[0]*(-1 + phix^2*(-2 + A[1])) + 2*phix^2*(-1 + A[1])) - (1 + E^A[0])*phix^2*vx^n*(-1 + A[1])) + (1 + E^A[0])*phix^2*rhox^(2*n)*(-1 + vx)*vx*(-1 + A[1]) - E^A[0]*phix^2*rhox^(3 + n)*(-1 + vx)*A[1] + E^A[0]*phix^2*rhox^(2 + 2*n)*(-1 + vx)*A[1] + E^A[0]*phix^2*rhox^(1 + n)*(-1 + vx)*vx*A[1] + vx*((1 + E^A[0])*vx^(1 + n) + phix^2*vx^n*(1 + E^A[0] - A[1]) - vx*(1 + phix^2 + E^A[0]*(1 + phix^2) - phix^2*A[1])) - phix^2*rhox^(1 + 2*n)*(-1 + vx)*(-1 + A[1] + E^A[0]*(-1 + (1 + vx)*A[1])) + rhox^2*(-((1 + E^A[0])*vx^2) + (1 + E^A[0])*vx^(2 + n) + 2*(1 + E^A[0])*phix^2*vx^n*(-1 + A[1]) + vx*(-1 + phix^2 + E^A[0]*(-1 + phix^2) - phix^2*A[1]) + vx^(1 + n)*(1 + phix^2 - phix^2*A[1] + E^A[0]*(1 + phix^2 - 2*phix^2*A[1]))) + rhox^3*((-1 + vx^n)*(1 + vx - phix^2*(-1 + A[1])) + E^A[0]*((1 + vx)*(-1 + vx^n) + phix^2*(-1 + vx^n - vx^n*A[1] + vx^(1 + n)*A[1])))) + psi^2*(-1 + theta)*(2*(1 + E^A[0])*phix^2*rhox^(2 + n)*(-1 + theta)*(-1 + vx)*(1 + E^A[0] - A[1])*(-1 + A[1]) - 2*(1 + E^A[0])*phix^2*rhox^n*(-1 + theta)*(-1 + vx)*vx*(1 + E^A[0] - A[1])*(-1 + A[1]) - (1 + E^A[0])^2*phix^2*rhox^(2*n)*(-1 + theta)*(-1 + vx)*vx*(-1 + A[1])^2 - 2*E^A[0]*phix^2*rhox^(3 + n)*(-1 + theta)*(-1 + vx)*(1 + E^A[0] - A[1])*A[1] + 2*E^A[0]*phix^2*rhox^(1 + n)*(-1 + theta)*(-1 + vx)*vx*(1 + E^A[0] - A[1])*A[1] + E^(2*A[0])*phix^2*rhox^(3 + 2*n)*(-1 + theta)*(-1 + vx)*A[1]^2 + (1 + E^A[0])*phix^2*rhox^(1 + 2*n)*(-1 + theta)*(-1 + vx)*(-1 + A[1])*(-1 + A[1] + E^A[0]*(-1 + A[1] + 2*vx*A[1])) - E^A[0]*phix^2*rhox^(2 + 2*n)*(-1 + theta)*(-1 + vx)*A[1]*(2*(-1 + A[1]) + E^A[0]*(-2 + (2 + vx)*A[1])) + (1 + E^A[0])*rhox^5*(-1 + vx^n)*(-1 + theta - 2*A[2] + E^A[0]*(-1 + theta + 2*(-1 + vx)*A[2])) - (1 + E^A[0])*rhox^4*(2 + vx)*(-1 + vx^n)*(-1 + theta - 2*A[2] + E^A[0]*(-1 + theta + 2*(-1 + vx)*A[2])) + rhox^2*(-2*(1 + E^A[0])^2*phix^2*(-1 + theta)*vx^n*(-1 + A[1])^2 - (1 + E^A[0])*vx^2*(-1 + E^A[0]*(-1 + theta) + theta - 2*A[2]) + vx^(1 + n)*(-1 + theta + phix^2*(-1 + theta)*(-1 + A[1])^2 + E^(2*A[0])*(-1 + theta + phix^2*(-1 + theta)*(1 - 4*A[1] + A[1]^2) - 2*A[2]) + 2*E^A[0]*(-1 + theta + phix^2*(-1 + theta)*(1 - 3*A[1] + 2*A[1]^2) - 2*A[2]) - 2*A[2]) + vx^(2 + n)*(-1 + theta + E^(2*A[0])*(-1 + theta)*(1 + phix^2*A[1]^2) + 2*E^A[0]*(-1 + theta - A[2]) - 2*A[2]) - 2*E^A[0]*(1 + E^A[0])*vx^3*A[2] + 2*E^A[0]*(1 + E^A[0])*vx^(3 + n)*A[2] + vx*(1 - theta + phix^2*(-1 + theta)*(-1 + A[1])^2 - 2*E^A[0]*(-1 + theta + phix^2*(-1 + theta)*(-1 + A[1]) - 2*A[2]) + 2*A[2] + E^(2*A[0])*(1 + phix^2*(-1 + theta) - theta + 2*A[2]))) + vx*(-((1 + E^A[0])*phix^2*(-1 + theta)*vx^n*(-1 + A[1])*(1 - A[1] + E^A[0]*(1 + A[1]))) + vx^(1 + n)*(-1 + theta + 2*E^A[0]*(-1 + theta - 2*A[2]) + E^(2*A[0])*(-1 + theta - phix^2*A[1]^2 + phix^2*theta*A[1]^2 - 2*A[2]) - 2*A[2]) - 2*E^A[0]*(1 + E^A[0])*vx^2*A[2] + 2*E^A[0]*(1 + E^A[0])*vx^(2 + n)*A[2] + vx*(1 - theta - phix^2*(-1 + theta)*(-1 + A[1])^2 + 2*A[2] + E^(2*A[0])*(1 - phix^2*(-1 + theta) - theta + 2*A[2]) + 2*E^A[0]*(1 - theta + phix^2*(-1 + theta)*(-1 + A[1]) + 2*A[2]))) + rhox*((1 + E^A[0])^2*phix^2*(-1 + theta)*vx^n*(-1 + A[1])^2 + 2*(1 + E^A[0])*vx^2*(-1 + theta + E^A[0]*(-1 + theta - A[2]) - 2*A[2]) + 4*E^A[0]*(1 + E^A[0])*vx^3*A[2] - 4*E^A[0]*(1 + E^A[0])*vx^(3 + n)*A[2] + vx*(-1 + theta + phix^2*(-1 + theta)*(-1 + A[1])^2 + E^(2*A[0])*(-1 + phix^2*(-1 + theta) + theta - 2*A[2]) - 2*A[2] - 2*E^A[0]*(1 - theta + phix^2*(-1 + theta)*(-1 + A[1]) + 2*A[2])) + vx^(1 + n)*(1 - theta - 2*phix^2*(-1 + theta)*(-1 + A[1])^2 - 2*E^A[0]*(-1 + theta + phix^2*(-1 + theta)*(2 - 3*A[1] + A[1]^2) - 2*A[2]) + 2*A[2] + E^(2*A[0])*(1 - theta + phix^2*(-1 + theta)*(-2 + 2*A[1] + A[1]^2) + 2*A[2])) + 2*vx^(2 + n)*(1 - theta + 2*A[2] + E^(2*A[0])*(1 + phix^2*A[1]^2 - theta*(1 + phix^2*A[1]^2) + A[2]) + E^A[0]*(2 - 2*theta + 3*A[2]))) + rhox^3*((-1 + vx^n)*(phix^2*(-1 + theta)*(-1 + A[1])^2 + (1 + vx)*(-1 + theta - 2*A[2])) - 2*E^A[0]*(phix^2*(-1 + theta)*(-1 + A[1])*(-1 - vx^n*(-1 + A[1]) + vx^(1 + n)*A[1]) - (1 + vx)*(-1 + vx^n)*(-1 + theta + (-2 + vx)*A[2])) + E^(2*A[0])*((-phix^2)*(-1 + theta)*(1 - vx^n*(-1 + A[1])^2 + vx^(1 + n)*(-2 + A[1])*A[1]) + (1 + vx)*(-1 + vx^n)*(-1 + theta + 2*(-1 + vx)*A[2])))))/(2*(1 + E^A[0])^2*psi^2*(-1 + rhox)^2*(rhox - vx)*(rhox^2 - vx)*(-1 + vx))
				}
			],
			"nombond" -> With[
				{
					A = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc,
					P = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb[[0]],
					n = FernandoDuarte`LongRunRisk`Model`ProcessModels`Private`n
				},
				{
					P[n_][1] :> ((-1 + rhox^n)*(-((1 + E^A[0])*theta) + psi*(-1 + theta)*(1 - A[1] + E^A[0]*(1 + (-1 + rhox)*A[1]))))/((1 + E^A[0])*psi*(-1 + rhox))
				}
			]
		|>
	|>,
(**********************************************************)
	"BKY" -> <|
		"coeffs" ->
		<|
			"bond" -> With[
				{
					A = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc,
					R = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb[[0]],
					n = FernandoDuarte`LongRunRisk`Model`ProcessModels`Private`n
				},
				{
					R[n_][1] :> ((-1 + rhox^n)*(-((1 + E^A[0])*theta) + psi*(-1 + theta)*(1 - A[1] + E^A[0]*(1 + (-1 + rhox)*A[1]))))/((1 + E^A[0])*psi*(-1 + rhox)),
					R[n_][2] :> ((1 + E^A[0])^2*theta^2*(-2*phix^2*rhox^(2 + n)*(-1 + vx) + phix^2*rhox^(1 + 2*n)*(-1 + vx) + 2*phix^2*rhox^n*(-1 + vx)*vx - phix^2*rhox^(2*n)*(-1 + vx)*vx + rhox^5*(-1 + vx^n) - rhox^4*(2 + vx)*(-1 + vx^n) + rhox^3*(1 + phix^2 + vx)*(-1 + vx^n) + vx*(-((1 + phix^2)*vx) + phix^2*vx^n + vx^(1 + n)) + rhox*((1 + phix^2)*vx + 2*vx^2 + phix^2*vx^n - (1 + 2*phix^2)*vx^(1 + n) -   2*vx^(2 + n)) + rhox^2*((-1 + phix^2)*vx - vx^2 - 2*phix^2*vx^n + (1 + phix^2)*vx^(1 + n) + vx^(2 + n))) - 2*(1 + E^A[0])*psi*(-1 + theta)*theta*((1 + E^A[0])*rhox^5*(-1 + vx^n) - (1 + E^A[0])*rhox^4*(2 + vx)*(-1 + vx^n) + phix^2*rhox^(2 + n)*(-1 + vx)*(E^A[0]*(-2 + A[1]) + 2*(-1 + A[1])) - phix^2*rhox^n*(-1 + vx)*vx*(E^A[0]*(-2 + A[1]) + 2*(-1 + A[1])) + rhox*(2*(1 + E^A[0])*vx^2 - 2*(1 + E^A[0])*vx^(2 + n) + vx*(1 + E^A[0]*(1 + phix^2) - phix^2*(-1 + A[1])) + vx^(1 + n)*(-1 + E^A[0]*(-1 + phix^2*(-2 + A[1])) + 2*phix^2*(-1 + A[1])) - (1 + E^A[0])*phix^2*vx^n*(-1 + A[1])) + (1 + E^A[0])*phix^2*rhox^(2*n)*(-1 + vx)*vx*(-1 + A[1]) - E^A[0]*phix^2*rhox^(3 + n)*(-1 + vx)*A[1] + E^A[0]*phix^2*rhox^(2 + 2*n)*(-1 + vx)*A[1] + E^A[0]*phix^2*rhox^(1 + n)*(-1 + vx)*vx*A[1] + vx*((1 + E^A[0])*vx^(1 + n) + phix^2*vx^n*(1 + E^A[0] - A[1]) - vx*(1 + phix^2 + E^A[0]*(1 + phix^2) - phix^2*A[1])) - phix^2*rhox^(1 + 2*n)*(-1 + vx)*(-1 + A[1] + E^A[0]*(-1 + (1 + vx)*A[1])) + rhox^2*(-((1 + E^A[0])*vx^2) + (1 + E^A[0])*vx^(2 + n) + 2*(1 + E^A[0])*phix^2*vx^n*(-1 + A[1]) + vx*(-1 + phix^2 + E^A[0]*(-1 + phix^2) - phix^2*A[1]) + vx^(1 + n)*(1 + phix^2 - phix^2*A[1] + E^A[0]*(1 + phix^2 - 2*phix^2*A[1]))) + rhox^3*((-1 + vx^n)*(1 + vx - phix^2*(-1 + A[1])) + E^A[0]*((1 + vx)*(-1 + vx^n) + phix^2*(-1 + vx^n - vx^n*A[1] + vx^(1 + n)*A[1])))) + psi^2*(-1 + theta)*(2*(1 + E^A[0])*phix^2*rhox^(2 + n)*(-1 + theta)*(-1 + vx)*(1 + E^A[0] - A[1])*(-1 + A[1]) - 2*(1 + E^A[0])*phix^2*rhox^n*(-1 + theta)*(-1 + vx)*vx*(1 + E^A[0] - A[1])*(-1 + A[1]) - (1 + E^A[0])^2*phix^2*rhox^(2*n)*(-1 + theta)*(-1 + vx)*vx*(-1 + A[1])^2 - 2*E^A[0]*phix^2*rhox^(3 + n)*(-1 + theta)*(-1 + vx)*(1 + E^A[0] - A[1])*A[1] + 2*E^A[0]*phix^2*rhox^(1 + n)*(-1 + theta)*(-1 + vx)*vx*(1 + E^A[0] - A[1])*A[1] + E^(2*A[0])*phix^2*rhox^(3 + 2*n)*(-1 + theta)*(-1 + vx)*A[1]^2 + (1 + E^A[0])*phix^2*rhox^(1 + 2*n)*(-1 + theta)*(-1 + vx)*(-1 + A[1])*(-1 + A[1] + E^A[0]*(-1 + A[1] + 2*vx*A[1])) - E^A[0]*phix^2*rhox^(2 + 2*n)*(-1 + theta)*(-1 + vx)*A[1]*(2*(-1 + A[1]) + E^A[0]*(-2 + (2 + vx)*A[1])) + (1 + E^A[0])*rhox^5*(-1 + vx^n)*(-1 + theta - 2*A[2] + E^A[0]*(-1 + theta + 2*(-1 + vx)*A[2])) - (1 + E^A[0])*rhox^4*(2 + vx)*(-1 + vx^n)*(-1 + theta - 2*A[2] + E^A[0]*(-1 + theta + 2*(-1 + vx)*A[2])) + rhox^2*(-2*(1 + E^A[0])^2*phix^2*(-1 + theta)*vx^n*(-1 + A[1])^2 - (1 + E^A[0])*vx^2*(-1 + E^A[0]*(-1 + theta) + theta - 2*A[2]) + vx^(1 + n)*(-1 + theta + phix^2*(-1 + theta)*(-1 + A[1])^2 + E^(2*A[0])*(-1 + theta + phix^2*(-1 + theta)*(1 - 4*A[1] + A[1]^2) - 2*A[2]) + 2*E^A[0]*(-1 + theta + phix^2*(-1 + theta)*(1 - 3*A[1] + 2*A[1]^2) - 2*A[2]) - 2*A[2]) + vx^(2 + n)*(-1 + theta + E^(2*A[0])*(-1 + theta)*(1 + phix^2*A[1]^2) + 2*E^A[0]*(-1 + theta - A[2]) - 2*A[2]) - 2*E^A[0]*(1 + E^A[0])*vx^3*A[2] + 2*E^A[0]*(1 + E^A[0])*vx^(3 + n)*A[2] + vx*(1 - theta + phix^2*(-1 + theta)*(-1 + A[1])^2 - 2*E^A[0]*(-1 + theta + phix^2*(-1 + theta)*(-1 + A[1]) - 2*A[2]) + 2*A[2] + E^(2*A[0])*(1 + phix^2*(-1 + theta) - theta + 2*A[2]))) + vx*(-((1 + E^A[0])*phix^2*(-1 + theta)*vx^n*(-1 + A[1])*(1 - A[1] + E^A[0]*(1 + A[1]))) + vx^(1 + n)*(-1 + theta + 2*E^A[0]*(-1 + theta - 2*A[2]) + E^(2*A[0])*(-1 + theta - phix^2*A[1]^2 + phix^2*theta*A[1]^2 - 2*A[2]) - 2*A[2]) - 2*E^A[0]*(1 + E^A[0])*vx^2*A[2] + 2*E^A[0]*(1 + E^A[0])*vx^(2 + n)*A[2] + vx*(1 - theta - phix^2*(-1 + theta)*(-1 + A[1])^2 + 2*A[2] + E^(2*A[0])*(1 - phix^2*(-1 + theta) - theta + 2*A[2]) + 2*E^A[0]*(1 - theta + phix^2*(-1 + theta)*(-1 + A[1]) + 2*A[2]))) + rhox*((1 + E^A[0])^2*phix^2*(-1 + theta)*vx^n*(-1 + A[1])^2 + 2*(1 + E^A[0])*vx^2*(-1 + theta + E^A[0]*(-1 + theta - A[2]) - 2*A[2]) + 4*E^A[0]*(1 + E^A[0])*vx^3*A[2] - 4*E^A[0]*(1 + E^A[0])*vx^(3 + n)*A[2] + vx*(-1 + theta + phix^2*(-1 + theta)*(-1 + A[1])^2 + E^(2*A[0])*(-1 + phix^2*(-1 + theta) + theta - 2*A[2]) - 2*A[2] - 2*E^A[0]*(1 - theta + phix^2*(-1 + theta)*(-1 + A[1]) + 2*A[2])) + vx^(1 + n)*(1 - theta - 2*phix^2*(-1 + theta)*(-1 + A[1])^2 - 2*E^A[0]*(-1 + theta + phix^2*(-1 + theta)*(2 - 3*A[1] + A[1]^2) - 2*A[2]) + 2*A[2] + E^(2*A[0])*(1 - theta + phix^2*(-1 + theta)*(-2 + 2*A[1] + A[1]^2) + 2*A[2])) + 2*vx^(2 + n)*(1 - theta + 2*A[2] + E^(2*A[0])*(1 + phix^2*A[1]^2 - theta*(1 + phix^2*A[1]^2) + A[2]) + E^A[0]*(2 - 2*theta + 3*A[2]))) + rhox^3*((-1 + vx^n)*(phix^2*(-1 + theta)*(-1 + A[1])^2 + (1 + vx)*(-1 + theta - 2*A[2])) - 2*E^A[0]*(phix^2*(-1 + theta)*(-1 + A[1])*(-1 - vx^n*(-1 + A[1]) + vx^(1 + n)*A[1]) - (1 + vx)*(-1 + vx^n)*(-1 + theta + (-2 + vx)*A[2])) + E^(2*A[0])*((-phix^2)*(-1 + theta)*(1 - vx^n*(-1 + A[1])^2 + vx^(1 + n)*(-2 + A[1])*A[1]) + (1 + vx)*(-1 + vx^n)*(-1 + theta + 2*(-1 + vx)*A[2])))))/(2*(1 + E^A[0])^2*psi^2*(-1 + rhox)^2*(rhox - vx)*(rhox^2 - vx)*(-1 + vx))
				}
			],
			"nombond" -> With[
				{
					A = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc,
					P = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb[[0]],
					n = FernandoDuarte`LongRunRisk`Model`ProcessModels`Private`n
				},
				{
					P[n_][1] :> ((-1 + rhox^n)*(-((1 + E^A[0])*theta) + psi*(-1 + theta)*(1 - A[1] + E^A[0]*(1 + (-1 + rhox)*A[1]))))/((1 + E^A[0])*psi*(-1 + rhox))
				}
			]
		|>
	|>,
(**********************************************************)
	"NRC" -> <|
		"coeffs" ->
		<|
			"bond" -> With[
				{
					A = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc,
					R = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb[[0]],
					n = FernandoDuarte`LongRunRisk`Model`ProcessModels`Private`n
				},
				{
					R[n_][1] :> -(((-1 + rhop^n)*(gamma*(-1 + psi)*rhocp + A[1] -      gamma*psi*A[1] + E^A[0]*(gamma*(-1 + psi)*rhocp +        (-1 + gamma*psi)*(-1 + rhop)*A[1])))/   ((1 + E^A[0])*(-1 + psi)*(-1 + rhop))),
					R[n_][2] :> UnitStep[-1+n]*(-((theta*xic)/psi)+(-1+theta)*(xic-A[2])),
					R[n_][3] :> (-(1/((1 + E^A[0])*(-1 + psi)*(-1 + rhop)*rhop)))*  (rhop^n*xip*(gamma*(-1 + psi)*rhocp + A[1] - gamma*psi*A[1] + E^A[0]*(gamma*(-1 + psi)*rhocp + (-1 + gamma*psi)*(-1 + rhop)*A[1]))*UnitStep[-1 + n] + rhop*(xip*A[1] - (1 + E^A[0])*(-1 + rhop)*A[3] + gamma*((1 + E^A[0])*(-1 + psi)*rhocp*xip - psi*xip*A[1] + (1 + E^A[0])*psi*(-1 + rhop)*A[3]))*(-1 + UnitStep[-n]))
				}
			],
			"nombond" -> With[
				{
					A = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc,
					P = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb[[0]],
					n = FernandoDuarte`LongRunRisk`Model`ProcessModels`Private`n
				},
				{
					P[n_][1] :> -(((-1 + rhop^n)*((-gamma)*rhocp + gamma*psi*rhocp - rhop + psi*rhop + A[1] - gamma*psi*A[1] + E^A[0]*((-1 + psi)*(gamma*rhocp + rhop) + (-1 + gamma*psi)*(-1 + rhop)*A[1])))/((1 + E^A[0])*(-1 + psi)*(-1 + rhop))),
					P[n_][2] :> UnitStep[-1+n]*(-((theta*xic)/psi)+(-1+theta)*(xic-A[2])),
					P[n_][3] :> (-(1/((1 + E^A[0])*(-1 + psi)*(-1 + rhop)*rhop)))*(rhop^n*xip*((-gamma)*rhocp + gamma*psi*rhocp - rhop + psi*rhop + A[1] - gamma*psi*A[1] + E^A[0]*((-1 + psi)*(gamma*rhocp + rhop) + (-1 + gamma*psi)*(-1 + rhop)*A[1]))*UnitStep[-1 + n] + rhop*(xip*(-1 + psi - gamma*rhocp + E^A[0]*(-1 + psi)*(1 + gamma*rhocp) + gamma*psi*(rhocp - A[1]) + A[1]) + (1 + E^A[0])*(-1 + gamma*psi)*(-1 + rhop)*A[3])*(-1 + UnitStep[-n]))
				}
			]
		|>,
		"modelAssumptions" -> 
		<|
			"nombond" -> 
				With[
					{
						A = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc,
						P = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb[[0]],
						n = FernandoDuarte`LongRunRisk`Model`ProcessModels`Private`n
					},
					n>0
				]
		|>
	|>,
(**********************************************************)
	"NRCLLR" -> <|
		"coeffs" ->
		<|
			"bond" -> With[
				{
					A = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc,
					R = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb[[0]],
					n = FernandoDuarte`LongRunRisk`Model`ProcessModels`Private`n
				},
				{
					R[n_][1] :> -(((-1 + rhop^n)*(gamma*(-1 + psi)*rhocp + A[1] -      gamma*psi*A[1] + E^A[0]*(gamma*(-1 + psi)*rhocp +        (-1 + gamma*psi)*(-1 + rhop)*A[1])))/   ((1 + E^A[0])*(-1 + psi)*(-1 + rhop))),
					R[n_][2] :> UnitStep[-1+n]*(-((theta*xic)/psi)+(-1+theta)*(xic-A[2])),
					R[n_][3] :> (-(1/((1 + E^A[0])*(-1 + psi)*(-1 + rhop)*rhop)))*  (rhop^n*xip*(gamma*(-1 + psi)*rhocp + A[1] - gamma*psi*A[1] + E^A[0]*(gamma*(-1 + psi)*rhocp + (-1 + gamma*psi)*(-1 + rhop)*A[1]))*UnitStep[-1 + n] + rhop*(xip*A[1] - (1 + E^A[0])*(-1 + rhop)*A[3] + gamma*((1 + E^A[0])*(-1 + psi)*rhocp*xip - psi*xip*A[1] + (1 + E^A[0])*psi*(-1 + rhop)*A[3]))*(-1 + UnitStep[-n]))
				}
			],
			"nombond" -> With[
				{
					A = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc,
					P = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb[[0]],
					n = FernandoDuarte`LongRunRisk`Model`ProcessModels`Private`n
				},
				{
					P[n_][1] :> -(((-1 + rhop^n)*((-gamma)*rhocp + gamma*psi*rhocp - rhop + psi*rhop + A[1] - gamma*psi*A[1] + E^A[0]*((-1 + psi)*(gamma*rhocp + rhop) + (-1 + gamma*psi)*(-1 + rhop)*A[1])))/((1 + E^A[0])*(-1 + psi)*(-1 + rhop))),
					P[n_][2] :> UnitStep[-1+n]*(-((theta*xic)/psi)+(-1+theta)*(xic-A[2])),
					P[n_][3] :> (-(1/((1 + E^A[0])*(-1 + psi)*(-1 + rhop)*rhop)))*(rhop^n*xip*((-gamma)*rhocp + gamma*psi*rhocp - rhop + psi*rhop + A[1] - gamma*psi*A[1] + E^A[0]*((-1 + psi)*(gamma*rhocp + rhop) + (-1 + gamma*psi)*(-1 + rhop)*A[1]))*UnitStep[-1 + n] + rhop*(xip*(-1 + psi - gamma*rhocp + E^A[0]*(-1 + psi)*(1 + gamma*rhocp) + gamma*psi*(rhocp - A[1]) + A[1]) + (1 + E^A[0])*(-1 + gamma*psi)*(-1 + rhop)*A[3])*(-1 + UnitStep[-n]))
				}
			]
		|>,
		"modelAssumptions" -> <|
			"nombond" -> 
				With[
					{
						A = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc,
						P = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb[[0]],
						n = FernandoDuarte`LongRunRisk`Model`ProcessModels`Private`n
					},
					n>0
				]
		|>
	|>
|>;(*end modelsExtraInfo*)


(* ::Section:: *)
(*End package*)


End[] (*"`Private`"*)


EndPackage[]