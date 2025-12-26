BeginTestSection["validateModel"]

(* Setup: Load ValidateModels package *)
Off[General::shdw];
Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"];
On[General::shdw];

(* Extract private symbols for testing *)
$validateModel = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateModel;
$validateCatalog = FernandoDuarte`LongRunRisk`Tools`ValidateModels`validateCatalog;
$containsTimeDep = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`containsTimeDependency"];
$numericValueQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`numericValueQ"];
$validParamNameQ = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`validParamNameQ"];
$stripParamIndex = ToExpression["FernandoDuarte`LongRunRisk`Tools`ValidateModels`Private`stripParamIndex"];

(* Load catalog for using real models in tests *)
Needs["FernandoDuarte`LongRunRisk`Model`Catalog`"];
$realModels = FernandoDuarte`LongRunRisk`Model`Catalog`models;

$timeLimit = 5;

(* ============================================================ *)
(* Helper Function Tests *)
(* ============================================================ *)

(* === Shared State Setup === *)
$badCatalog = <|
  "BY" -> <|
    "name" -> "Original long-run risk model",
    "shortname" -> "BY",
    "bibRef" -> "BY2004",
    "desc" -> "Long-run risk model with stochastic volatility",
    "enabled" -> True,
    "stateVars" -> {x[t], sx},  (* ERROR: sx without [t] *)
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.979, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.987, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYlowPers" -> <|
    "name" -> "Original long-run risk model but with low persistence",
    "shortname" -> "BYlowPers",
    "bibRef" -> refBY,  (* ERROR: symbol not string *)
    "desc" -> "Long-run risk and stochastic volatility persistance reduced",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.5, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BYverylowPers" -> <|
    "name" -> "Original long-run risk model but with very low persistence",
    "shortname" -> "BYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Long-run risk persistance reduced to rhox=vx=0.1",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.998, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.044, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> epsilon,  (* ERROR: non-numeric value *)
      rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0078, vx -> 0.1, phisxs -> 2.3*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 3, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 4.5, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKY" -> <|
    "name" -> "New calibration of long-run risk model",
    "shortname" -> "BKY",
    "bibRef" -> "BKY2012",
    "desc" -> "Long-run risk model with a new calibration",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0,
      phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYlowPers" -> <|
    "name" -> "Long-run risk model of Bansal, Kiku and Yaron but with low persistence",
    "shortname" -> "BKYlowPers",
    "bibRef" -> "None",
    "desc" -> "Low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.5, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      phipbarxpb -> 0,  (* ERROR: extra parameter not in $parameters *)
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.5, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BKYverylowPers" -> <|
    "name" -> "Long-run risk model with very low persistence",
    "shortname" -> "BKYverylowPers",
    "bibRef" -> "None",
    "desc" -> "Very low persistence variant",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.1, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0, rhoppbar -> 0, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.1, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      taugd -> 0,  (* ERROR: non-indexed taugd while having indexed stock params *)
      mud[1] -> 0.0015, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 2.6, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0
    }
  |>,
  "BKYinf" -> <|
    "name" -> "Similar to Bansal-Kiku-Yaron but with inflation",
    "shortname" -> "BKYinf",
    "bibRef" -> "None",
    "desc" -> "Inflation is persistent",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.998, psi -> -0.108086,  (* ERROR: psi negative, violates psi > 0 *)
      gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.95, rhoxpbar -> 0, phix -> -0.01, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.985, phip -> -0.0004, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> -0.29, rhocpbar -> 0, phic -> 0, phicp -> -0.008, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 7.8*^-23, vx -> 0.979, phisxs -> 0.005,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.001, rhodx[1] -> 7.4, rhodp[1] -> 0.03, phidc[1] -> 0, phidp[1] -> 0.04, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 1*^-8, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> -0.79, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRC" -> <|
    "name" -> "Model with a nominal real covariance (NRC)",
    "shortname" -> "NRC",
    "bibRef" -> "BDRS2020",
    "desc" -> "Model without long-run risk",
    "enabled" -> True,
    "stateVars" -> {-mupx + pi[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], -Esg + sg[t]},  (* ERROR: mupx is invalid symbol *)
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> -0.05, rhocpbar -> 0, phic -> 0.002, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0002, rhodx[1] -> 0, rhodp[1] -> 0.71, phidc[1] -> 0.034, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.31, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCLLR" -> <|
    "name" -> "Same as NRC model but with long-run risk",
    "shortname" -> "NRCLLR",
    "bibRef" -> "None",
    "desc" -> "Long-run risk added",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[t], sg[-1 + t] eps["pi"][t], x[t], sx[t]},
    "parameters" -> {
      delta -> 0.99, psi -> 2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.8, phip -> -0.002, xip -> 0.0007, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1.1, rhocp -> -0.05, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.2, phics -> 0, phicx -> 1.1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.006, rhog -> 0.996, rhogp -> 0, rhogpbar -> 0, phig -> 0.003,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0003, rhodx[1] -> 2.5, rhodp[1] -> -0.23, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0.19, phids[1] -> 0,
      phidxc[1] -> 0.03, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 5.96, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0,
      mud[3] -> 0.0002, rhodx[3] -> 0.5, rhodp[3] -> 0.71, phidc[3] -> 0, phidp[3] -> 0, phidsp[3] -> 0, xid[3] -> -0.31, phids[3] -> 0,
      phidxc[3] -> 0.034, phidcc[3] -> 0, phidpc[3] -> 0, phidpp[3] -> 0, phidxd[3] -> 2, phidcd[3] -> 0, phidpd[3] -> 0, taugd[3] -> 0
    }
  |>,
  "WCratio" -> <|
    "name" -> "Long Run Risk, the Wealth-Consumption Ratio",
    "shortname" -> "WCratio",
    "bibRef" -> "KLNV2010",
    "desc" -> "Long-run risk model with LRR in expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1,
      phicpc -> ab,  (* ERROR: non-numeric value *)
      phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0015, rhodx[1] -> 1.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 6, phidpd[1] -> 0, taugd[1] -> 0.1
    }
  |>,
  "WCratioInf" -> <|
    "name" -> "Same as WCratio model but with real effects of inflation",
    "shortname" -> "WCratioInf",
    "bibRef" -> "None",
    "desc" -> "Inflation predicts consumption growth",
    "enabled" -> True,
    "stateVars" -> {x[t], sc[t], sx[t], -mupbar + pibar[t], -mup + pi[t]},
    "parameters" -> {
      delta -> 0.9987, psi -> 1.5, gamma -> 8, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.991, rhoxpbar -> 0, phix -> 1, phixc -> 0,
      mup -> mupbar, rhoppbar -> 1, rhop -> 0, phip -> 0.0035, xip -> 0, phipc -> 0, phipx -> -2, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0032, rhopbar -> 0.83, rhopbarx -> -0.35, phipbarp -> 1/250000, phipbarc -> 0, phipbarx -> -1, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 1, rhocp -> 0.3, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 1, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.004*Esc, vx -> 0.996, phisxs -> 0.0036,
      Esc -> 0.004, vc -> 0.85, phiscv -> 1.15*^-6,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[0] -> 0.0015, rhodx[0] -> 1.5, rhodp[0] -> 0, phidc[0] -> 0, phidp[0] -> 0, phidsp[0] -> 0, xid[0] -> 0, phids[0] -> 0,
      phidxc[0] -> 0, phidcc[0] -> 0, phidpc[0] -> 0, phidpp[0] -> 0, phidxd[0] -> 0, phidcd[0] -> 6, phidpd[0] -> 0, taugd[0] -> 0.1
    }
  |>,
  "infStochVol" -> <|
    "name" -> "Similar to Bansal, Kiku and Yaron with inflation stochastic volatility",
    "shortname" -> "infStochVol",
    "bibRef" -> "None",
    "desc" -> "Volatility of inflation is different from long-run risk",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mup + pi[t], sp[t]},
    "parameters" -> {
      delta -> 0.9989, psi -> 1.5, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.975, rhoxpbar -> 0, phix -> 0.038, phixc -> 0,
      mup -> 0.003, rhoppbar -> 0, rhop -> 0.98, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0.1, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0.9, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0.5, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0072, vx -> 0.999, phisxs -> 2.8*^-6,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.995, vpp -> 0.1, vppbar -> 0, phispw -> 0.000028,
      mud[2] -> 0.0015, rhodx[2] -> 2.5, rhodp[2] -> -3, phidc[2] -> 0, phidp[2] -> 0, phidsp[2] -> 0, xid[2] -> 0, phids[2] -> 0.1,
      phidxc[2] -> 0, phidcc[2] -> 0, phidpc[2] -> 0, phidpp[2] -> 0, phidxd[2] -> 0, phidcd[2] -> 0, phidpd[2] -> 0, taugd[2] -> 0
    }
  |>,
  "hassel" -> <|
    "name" -> "Hasseltoft's Stocks, Bonds, and Long-Run Consumption Risks",
    "shortname" -> "hassel",
    "bibRef" -> "Ha2012",
    "desc" -> "Expected inflation has no real effects",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t]},
    "parameters" -> {
      delta -> 0.9992, psi -> 2.51, gamma -> 6.78, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.9957, rhoxpbar -> 0, phix -> 0.0248, phixc -> 0,
      mup -> 0.00305, rhoppbar -> 1, rhop -> 0, phip -> 0, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0.584,
      mupbar -> 0, rhopbar -> 0.9851, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1254, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0.0475, phipbarxp -> 0,
      muc -> 0.00268, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.0012, vx -> 0.9968, phisxs -> 6.91*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[j] -> 0.00336, rhodx[j] -> 2.85, rhodp[j] -> 0, phidc[j] -> 0, phidp[j] -> 0, phidsp[j] -> 0, xid[j] -> 0, phids[j] -> 0,
      phidxc[j] -> 0, phidcc[j] -> 0, phidpc[j] -> 0, phidpp[j] -> 0, phidxd[j] -> 3.51, phidcd[j] -> 0, phidpd[j] -> 0, taugd[j] -> 0
    }
  |>,
  "hasselNRC" -> <|
    "name" -> "Similar to model hassel but with an NRC added",
    "shortname" -> "hasselNRC",
    "bibRef" -> "None",
    "desc" -> "NRC modeled as in model NRC",
    "enabled" -> True,
    "stateVars" -> {x[t + s], sx[t]},  (* ERROR: s is invalid symbol in state var *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0, phix -> 0.026, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.001, xip -> 0.0002, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.987, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.127, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.03, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.21, rhog -> 0.999, rhogp -> 0, rhogpbar -> 0, phig -> -0.003,
      Esx -> 0.0017, vx -> 0.996, phisxs -> 3.6*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.002, rhodx[1] -> 1.08, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.2, phids[1] -> 0,
      phidxc[1] -> 2.55, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "BS" -> <|
    "name" -> "A Long-Run Risks Explanation of Predictability Puzzles",
    "shortname" -> "BS",
    "bibRef" -> "BSh2012",
    "desc" -> "Long-run risk depends on expected inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], pibar[t] - mupbar, sx[t], sp[t]},
    "parameters" -> {
      delta -> 0.994, psi -> 1.81, gamma -> 20.9, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.81, rhoxpbar -> -0.047, phix -> 1, phixc -> 0,
      mup -> 9/1000, rhoppbar -> 1, rhop -> 0, phip -> 0.0055, xip -> 0, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.988, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0049, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0.0046, phicp -> 0, phicsp -> 0, xic -> 0, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0, rhog -> 0, rhogp -> 0, rhogpbar -> 0, phig -> 0,
      Esx -> 0.00109, vx -> 0.994, phisxs -> 1.85*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.00111, vp -> 0.979, vpp -> 0.02, vppbar -> 0.03, phispw -> 1.81*^-7,
      mud[1] -> 0.0049, rhodx[1] -> 2.5, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 1/200, phidsp[1] -> 0, xid[1] -> 0, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[2] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "DES" -> <|
    "name" -> "Long-Run Consumption and Inflation Risks in Stock and Bond Returns",
    "shortname" -> "DES",
    "bibRef" -> "des2023stocksbonds",
    "desc" -> "Long-run risk model with real effects of inflation",
    "enabled" -> True,
    "stateVars" -> {x[t], sx[t], -mupbar + pibar[t], sg[-1 + t] eps["pi"][t], eps["pi"][t], ab[t] - Esg + sg[t]},  (* ERROR: ab[t] is invalid symbol *)
    "parameters" -> {
      delta -> 0.9995, psi -> 1.1, gamma -> 10, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0.998, rhoxpbar -> 0.001, phix -> 0.0265, phixc -> 0,
      mup -> 0.0027, rhoppbar -> 1, rhop -> 0, phip -> -0.0011, xip -> 1.81*^-4, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0, rhopbar -> 0.9874, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> -0.1269, phipbarcx -> 0, phipbarpb -> 0, phipbarxb -> -0.1438, phipbarxp -> 0,
      muc -> 0.0015, rhocx -> 1, rhocp -> 0, rhocpbar -> 0, phic -> 0, phicp -> 0, phicsp -> 0, xic -> -0.0334, phics -> 0, phicx -> 1, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> -0.2138, rhog -> 0.9993, rhogp -> 0, rhogpbar -> 0, phig -> -0.0035,
      Esx -> 0.0017, vx -> 0.9961, phisxs -> 3.56*^-7,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0, vp -> 0, vpp -> 0, vppbar -> 0, phispw -> 0,
      mud[1] -> 0.0021, rhodx[1] -> 1.0802, rhodp[1] -> 0, phidc[1] -> 0, phidp[1] -> 0, phidsp[1] -> 0, xid[1] -> -0.147, phids[1] -> 0,
      phidxc[1] -> 2.5496, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>,
  "NRCStochVol" -> <|
    "name" -> "Model with NRC and stochastic volatility of expected inflation",
    "shortname" -> "NRCStochVol",
    "bibRef" -> "n/a",
    "desc" -> "Model without long-run risk with NRC and stochastic vol",
    "enabled" -> True,
    "stateVars" -> {-mup + pi[s], sg[-1 + s] eps["pi"][s], eps["pi"][s], -Esg + sg[s], pibar[s] - mupbar, sp[s]},  (* ERROR: uses s instead of t *)
    "parameters" -> {
      delta -> 0.99, psi -> 1.2, gamma -> 15, theta -> (1 - gamma)/(1 - psi^(-1)),
      rhox -> 0, rhoxpbar -> 0, phix -> 0, phixc -> 0,
      mup -> 0.0033, rhoppbar -> 1.05, rhop -> 0, phip -> 1.1, xip -> 1.1, phipc -> 0, phipx -> 0, phipcx -> 0, phipp -> 0, phipxp -> 0,
      mupbar -> 0.0033, rhopbar -> 0.9, rhopbarx -> 0, phipbarp -> 0, phipbarc -> 0, phipbarx -> 0, phipbarcx -> 0, phipbarpb -> 1.1, phipbarxb -> 0, phipbarxp -> 0,
      muc -> 0.0016, rhocx -> 0, rhocp -> 0.2, rhocpbar -> 0.01, phic -> 0.0021, phicp -> 0.002, phicsp -> 0, xic -> -0.198, phics -> 0, phicx -> 0, phicc -> 0, phicpc -> 0, phicpp -> 0,
      Esg -> 0.000062, rhog -> 0.998, rhogp -> 0, rhogpbar -> 0, phig -> 0.0029,
      Esx -> 0, vx -> 0, phisxs -> 0,
      Esc -> 0, vc -> 0, phiscv -> 0,
      Esp -> 0.01, vp -> 0.9795, vpp -> -7*^-5, vppbar -> 7*^-6, phispw -> 1.81*^-7,
      mud[1] -> 0.0016, rhodx[1] -> 0, rhodp[1] -> 0.2, phidc[1] -> 0.0021, phidp[1] -> 0.002, phidsp[1] -> 0, xid[1] -> -0.198, phids[1] -> 0,
      phidxc[1] -> 0, phidcc[1] -> 0, phidpc[1] -> 0, phidpp[1] -> 0, phidxd[1] -> 0, phidcd[1] -> 0, phidpd[1] -> 0, taugd[1] -> 0
    }
  |>
|>;

VerificationTest[
  Module[{result},
    result = Quiet[$validateModel[$badCatalog["hassel"]]];
    MemberQ[result["Errors"][[All, "Type"]], "BadParamName"]
  ],
  True,
  TimeConstraint -> $timeLimit,
  TestID -> "badCatalog-hassel-symbol-index@@Tests/ValidateModels/validateModel.wlt:1254,1-1262,2"
]

EndTestSection[]
