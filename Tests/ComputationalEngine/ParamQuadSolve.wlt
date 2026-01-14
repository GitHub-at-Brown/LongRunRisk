(* ::Package:: *)

(* ::Section:: *)
(*Kernel/ComputationalEngine/ParamQuadSolve.wl Tests*)


BeginTestSection["Kernel/ComputationalEngine/ParamQuadSolve.wl Tests"]
Begin["FernandoDuarte`LongRunRisk`Tests`ComputationalEngine`ParamQuadSolve`"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


(* ::Subsection:: *)
(*Load Test Helpers*)


Get @ FileNameJoin[{DirectoryName[$TestFileName, 2], "TestHelpers.wl"}];
Get @ FileNameJoin[{DirectoryName[$TestFileName, 1], "CETestHelpers.wl"}];


(* ::Subsection:: *)
(*Setup - Alias for paramQuadSolve*)


$pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;


(* ::Subsection:: *)
(*Setup - Seven-by-Seven System Fixture*)


(* Variables for the seven-by-seven system *)
$7x7vars = {A[1], A[2], A[3], A[4], A[5], A[6], A[7]};

(* Seven-by-seven equation system from LongRunRisk model *)
$7x7sys = {
	0 == ((1 - gamma) (-1 + psi) rhocp)/((1 - 1/psi) psi) -
		((1 - gamma) A[1])/(1 - 1/psi) +
		(E^A[0] (1 - gamma) vpp A[7])/((1 + E^A[0]) (1 - 1/psi)),
	0 == ((1 - gamma) (-1 + psi) xic)/((1 - 1/psi) psi) -
		((1 - gamma) A[2])/(1 - 1/psi),
	0 == (E^A[0] (1 - gamma) xip A[1])/((1 + E^A[0]) (1 - 1/psi)) -
		((1 - gamma) A[3])/(1 - 1/psi),
	0 == (E^(2 A[0]) (1 - gamma)^2 phip A[1] A[2])/((1 + E^A[0])^2 (1 - 1/psi)^2) +
		A[2] ((E^A[0] (1 - gamma)^2 phicp (-1 + psi))/((1 + E^A[0]) (1 - 1/psi)^2 psi) +
			(E^(2 A[0]) (1 - gamma)^2 A[3])/((1 + E^A[0])^2 (1 - 1/psi)^2)) -
		(2 E^A[0] Esg (1 - gamma) (-1 + rhog) rhog A[5])/((1 + E^A[0]) (1 - 1/psi)) -
		(4 E^(2 A[0]) Esg (1 - gamma)^2 phig^2 (-1 + rhog) rhog A[5]^2)/((1 + E^A[0])^2 (1 - 1/psi)^2) +
		A[4] (((1 - gamma) (-1 + E^A[0] (-1 + rhog)))/((1 + E^A[0]) (1 - 1/psi)) +
			(2 E^(2 A[0]) (1 - gamma)^2 phig^2 rhog A[5])/((1 + E^A[0])^2 (1 - 1/psi)^2)),
	0 == (E^(2 A[0]) (1 - gamma)^2 A[2]^2)/(2 (1 + E^A[0])^2 (1 - 1/psi)^2) +
		((1 - gamma) (-1 + E^A[0] (-1 + rhog^2)) A[5])/((1 + E^A[0]) (1 - 1/psi)) +
		(2 E^(2 A[0]) (1 - gamma)^2 phig^2 rhog^2 A[5]^2)/((1 + E^A[0])^2 (1 - 1/psi)^2),
	0 == ((1 - gamma) (-1 + psi) rhocpbar)/((1 - 1/psi) psi) +
		(E^A[0] (1 - gamma) rhoppbar A[1])/((1 + E^A[0]) (1 - 1/psi)) +
		((1 - gamma) (-1 + E^A[0] (-1 + rhopbar)) A[6])/((1 + E^A[0]) (1 - 1/psi)) +
		(E^A[0] (1 - gamma) vppbar A[7])/((1 + E^A[0]) (1 - 1/psi)),
	0 == (E^(2 A[0]) (1 - gamma)^2 phipbarpb^2 A[6]^2)/(2 (1 + E^A[0])^2 (1 - 1/psi)^2) +
		((1 - gamma) (-1 + E^A[0] (-1 + vp)) A[7])/((1 + E^A[0]) (1 - 1/psi))
};

(* Numeric parameter values *)
$7x7params = {
	gamma -> 0.3, psi -> 1.5, A[0] -> 0.8,
	rhocp -> 0.2, xic -> 0.1, xip -> 0.15,
	phip -> 0.5, phicp -> 0.4, Esg -> 0.7,
	rhog -> 0.2, phig -> 0.3,
	rhocpbar -> 0.25, rhoppbar -> 0.2, rhopbar -> 0.1,
	vpp -> 0.4, vppbar -> 0.35, phipbarpb -> 0.6, vp -> 0.2
};

(* Numeric system *)
$7x7sysN = ($7x7sys /. $7x7params);


(* ::Subsection:: *)
(*Setup - Computed Results for Seven-by-Seven Tests*)


$7x7res = $pqs[$7x7sysN, $7x7vars, "ValidationOption" -> False, "DomainOption" -> Reals];
$7x7signKeys = Keys[$7x7res["SignRootMap"]];
$7x7assigns = Tuples[{-1, 1}, Length[$7x7signKeys]];
$7x7pkgSolRules = Map[($7x7res["Solution"] /. Thread[$7x7signKeys -> #]) &, $7x7assigns];
$7x7pkgVals = ($7x7vars /. FixedPoint[(# /. #) &, #]) & /@ $7x7pkgSolRules // N;

(* Residual computation helper *)
$7x7eqResidualVec[vVals_] := Module[{lhsMinusRhs, rules},
	rules = Thread[$7x7vars -> vVals];
	lhsMinusRhs = (#[[1]] - #[[2]] /. rules) & /@ ($7x7sysN /. Equal -> List);
	Chop[N[lhsMinusRhs, 30]]
];
$7x7residualsPkg = $7x7eqResidualVec /@ $7x7pkgVals;

(* Manual sequential Solve path to cross-check number of solutions *)
$7x7manualSols = Module[{sol2, sol3, sol1, sol7, eq6sub, sol6, sol7full, sol1full, sol3full, eq5sub, sol5, eq4sub, sol4},
	sol2 = Solve[$7x7sysN[[2]], A[2]][[1]];
	sol3 = Solve[$7x7sysN[[3]], A[3]][[1]];
	sol1 = Solve[$7x7sysN[[1]], A[1]][[1]];
	sol7 = Solve[$7x7sysN[[7]], A[7]][[1]];
	eq6sub = $7x7sysN[[6]] /. sol1 /. sol7;
	sol6 = Solve[eq6sub, A[6]];
	eq5sub = $7x7sysN[[5]] /. sol2;
	sol5 = Solve[eq5sub, A[5]];
	Flatten[Table[
		(
			sol7full = sol7 /. sol6[[i]];
			sol1full = sol1 /. sol7full;
			sol3full = sol3 /. sol1full;
			eq4sub = $7x7sysN[[4]] /. sol2 /. sol3full /. sol1full /. sol5[[j]];
			sol4 = Solve[eq4sub, A[4]][[1]];
			Join[sol1full, sol2, sol3full, sol4, sol5[[j]], sol6[[i]], sol7full]
		)
	, {i, Length[sol6]}, {j, Length[sol5]}], 1]
];
$7x7manualVals = ($7x7vars /. FixedPoint[(# /. #) &, #]) & /@ $7x7manualSols // N;
$7x7residualsMan = $7x7eqResidualVec /@ $7x7manualVals;


(* ::Section:: *)
(*Basic Tests*)


(* ::Subsection:: *)
(*paramQuadSolve - Returns Association*)


(* Test: Basic 2x2 system returns Association *)
TestCreate[
	Module[{x, y, eqns, vars, res},
		eqns = {x^2 - 5 == 0, y + 2 x - 3 == 0};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		AssociationQ[res]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Basic two-variable system returns Association"
]


(* Test: Verification passes for all branches *)
TestCreate[
	Module[{x, y, eqns, vars, res},
		eqns = {x^2 - 5 == 0, y + 2 x - 3 == 0};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		AllTrue[Flatten@res["Verification"], TrueQ]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Basic two-variable system verifies all branches"
]


(* Test: Solution with sign +1 satisfies equations *)
TestCreate[
	Module[{x, y, eqns, vars, res, signSym},
		eqns = {x^2 - 5 == 0, y + 2 x - 3 == 0};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signSym = First[Keys[res["SignRootMap"]]];
		AllTrue[Simplify[eqns /. res["Solution"] /. signSym -> 1], TrueQ]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Solution with positive sign satisfies equations"
]


(* Test: Solution with sign -1 satisfies equations *)
TestCreate[
	Module[{x, y, eqns, vars, res, signSym},
		eqns = {x^2 - 5 == 0, y + 2 x - 3 == 0};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signSym = First[Keys[res["SignRootMap"]]];
		AllTrue[Simplify[eqns /. res["Solution"] /. signSym -> -1], TrueQ]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Solution with negative sign satisfies equations"
]


(* Test: Discriminant equals expected value *)
TestCreate[
	Module[{x, y, eqns, vars, res, signSym, rad},
		eqns = {x^2 - 5 == 0, y + 2 x - 3 == 0};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signSym = First[Keys[res["SignRootMap"]]];
		rad = res["SignRootMap"][signSym];
		Simplify[rad^2 == 20]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Basic two-variable discriminant equals expected value"
]


(* Test: Solutions match Solve results *)
TestCreate[
	Module[{x, y, eqns, vars, res, signSym, signs, ourRules, solveRules, sameQ},
		eqns = {x^2 - 5 == 0, y + 2 x - 3 == 0};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signSym = First[Keys[res["SignRootMap"]]];
		signs = {1, -1};
		ourRules = (res["Solution"] /. signSym -> #) & /@ signs;
		solveRules = Solve[eqns, vars, Reals];
		sameQ[r1_, r2_] := TrueQ@Simplify[(vars /. r1) == (vars /. r2)];
		Length[solveRules] == Length[ourRules] && AllTrue[solveRules, ssol |-> AnyTrue[ourRules, sameQ[#, ssol] &]]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Basic two-variable solutions match Solve"
]


(* ::Section:: *)
(*Parametric Coefficient Tests*)


(* ::Subsection:: *)
(*paramQuadSolve - Parametric Quadratic System*)


(* Test: Parametric quadratic system returns Association *)
TestCreate[
	Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, res},
		params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
		eqns = {
			((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
			(c21 x + c23 x^2 - c24 y == y - 3 x) /. params
		};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		AssociationQ[res]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Parametric quadratic system returns Association"
]


(* Test: Parametric quadratic system has one sign variable *)
TestCreate[
	Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, res, signKeys},
		params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
		eqns = {
			((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
			(c21 x + c23 x^2 - c24 y == y - 3 x) /. params
		};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signKeys = Keys[res["SignRootMap"]];
		Length[signKeys] === 1
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Parametric quadratic system has one sign variable"
]


(* Test: Parametric quadratic system produces two branches *)
TestCreate[
	Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, res, signKeys, assigns, ourRules},
		params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
		eqns = {
			((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
			(c21 x + c23 x^2 - c24 y == y - 3 x) /. params
		};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signKeys = Keys[res["SignRootMap"]];
		assigns = Tuples[{-1, 1}, Length[signKeys]];
		ourRules = Map[(res["Solution"] /. Thread[signKeys -> #]) &, assigns];
		Length[ourRules] === 2
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Parametric quadratic system produces two branches"
]


(* Test: Parametric quadratic all branches satisfy equations *)
TestCreate[
	Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, res, signKeys, assigns, ourRules},
		params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
		eqns = {
			((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
			(c21 x + c23 x^2 - c24 y == y - 3 x) /. params
		};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signKeys = Keys[res["SignRootMap"]];
		assigns = Tuples[{-1, 1}, Length[signKeys]];
		ourRules = Map[(res["Solution"] /. Thread[signKeys -> #]) &, assigns];
		And @@ (AllTrue[Simplify[eqns //. #], TrueQ] & /@ ourRules)
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Parametric quadratic all branches satisfy equations"
]


(* Test: Parametric quadratic solution count matches Solve *)
TestCreate[
	Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, res, signKeys, assigns, ourRules, solveRules},
		params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
		eqns = {
			((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
			(c21 x + c23 x^2 - c24 y == y - 3 x) /. params
		};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signKeys = Keys[res["SignRootMap"]];
		assigns = Tuples[{-1, 1}, Length[signKeys]];
		ourRules = Map[(res["Solution"] /. Thread[signKeys -> #]) &, assigns];
		solveRules = Solve[eqns, vars];
		Length[solveRules] == Length[ourRules]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Parametric quadratic solution count matches Solve"
]


(* Test: Parametric quadratic solutions match Solve *)
TestCreate[
	Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, res, signKeys, assigns, ourRules, solveRules, sameQ},
		params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
		eqns = {
			((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
			(c21 x + c23 x^2 - c24 y == y - 3 x) /. params
		};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signKeys = Keys[res["SignRootMap"]];
		assigns = Tuples[{-1, 1}, Length[signKeys]];
		ourRules = Map[(res["Solution"] /. Thread[signKeys -> #]) &, assigns];
		solveRules = Solve[eqns, vars];
		sameQ[r1_, r2_] := Quiet[Chop[N[(vars //. r1) - (vars //. r2), 50]] == ConstantArray[0, Length[vars]]];
		AllTrue[solveRules, ssol |-> AnyTrue[ourRules, sameQ[#, ssol] &]]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Parametric quadratic solutions match Solve"
]


(* ::Subsection:: *)
(*paramQuadSolve - Coupled Quartic System*)


(* Test: Coupled quartic system returns Association *)
TestCreate[
	Module[{x, y, vv, params, eqns, vars, res},
		params = {vv -> 3/5};
		eqns = {(vv x^2 + y == -3) /. params, (x - y^2 == 0)};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		AssociationQ[res]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Coupled quartic system returns Association"
]


(* Test: Coupled quartic system has two sign variables *)
TestCreate[
	Module[{x, y, vv, params, eqns, vars, res, signKeys},
		params = {vv -> 3/5};
		eqns = {(vv x^2 + y == -3) /. params, (x - y^2 == 0)};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signKeys = Keys[res["SignRootMap"]];
		Length[signKeys] === 2
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Coupled quartic system has two sign variables"
]


(* Test: Coupled quartic system produces four branches *)
TestCreate[
	Module[{x, y, vv, params, eqns, vars, res, signKeys, assigns, ourRules},
		params = {vv -> 3/5};
		eqns = {(vv x^2 + y == -3) /. params, (x - y^2 == 0)};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signKeys = Keys[res["SignRootMap"]];
		assigns = Tuples[{-1, 1}, Length[signKeys]];
		ourRules = Map[(res["Solution"] /. Thread[signKeys -> #]) &, assigns];
		Length[ourRules] === 4
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Coupled quartic system produces four branches"
]


(* Test: Coupled quartic all branches satisfy equations *)
TestCreate[
	Module[{x, y, vv, params, eqns, vars, res, signKeys, assigns, ourRules},
		params = {vv -> 3/5};
		eqns = {(vv x^2 + y == -3) /. params, (x - y^2 == 0)};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signKeys = Keys[res["SignRootMap"]];
		assigns = Tuples[{-1, 1}, Length[signKeys]];
		ourRules = Map[(res["Solution"] /. Thread[signKeys -> #]) &, assigns];
		And @@ (AllTrue[Simplify[eqns //. #], TrueQ] & /@ ourRules)
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Coupled quartic all branches satisfy equations"
]


(* Test: Coupled quartic solution count matches Solve *)
TestCreate[
	Module[{x, y, vv, params, eqns, vars, res, signKeys, assigns, ourRules, solveRules},
		params = {vv -> 3/5};
		eqns = {(vv x^2 + y == -3) /. params, (x - y^2 == 0)};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signKeys = Keys[res["SignRootMap"]];
		assigns = Tuples[{-1, 1}, Length[signKeys]];
		ourRules = Map[(res["Solution"] /. Thread[signKeys -> #]) &, assigns];
		solveRules = Solve[eqns, vars];
		Length[solveRules] == Length[ourRules]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Coupled quartic solution count matches Solve"
]


(* Test: Coupled quartic solutions match Solve *)
TestCreate[
	Module[{x, y, vv, params, eqns, vars, res, signKeys, assigns, ourRules, solveRules, sameQ},
		params = {vv -> 3/5};
		eqns = {(vv x^2 + y == -3) /. params, (x - y^2 == 0)};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signKeys = Keys[res["SignRootMap"]];
		assigns = Tuples[{-1, 1}, Length[signKeys]];
		ourRules = Map[(res["Solution"] /. Thread[signKeys -> #]) &, assigns];
		solveRules = Solve[eqns, vars];
		sameQ[r1_, r2_] := Quiet[Chop[N[(vars //. r1) - (vars //. r2), 50]] == ConstantArray[0, Length[vars]]];
		AllTrue[solveRules, ssol |-> AnyTrue[ourRules, sameQ[#, ssol] &]]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Coupled quartic solutions match Solve"
]


(* ::Section:: *)
(*Seven-by-Seven System Tests*)


(* ::Subsection:: *)
(*paramQuadSolve - Seven-by-Seven System*)


(* Test: Seven-by-seven system returns Association *)
TestCreate[
	AssociationQ[$7x7res],
	True,
	{},
	TestID -> "[paramQuadSolve] Seven-by-seven system returns Association"
]


(* Test: Seven-by-seven system has two sign variables *)
TestCreate[
	Length[$7x7signKeys] === 2,
	True,
	{},
	TestID -> "[paramQuadSolve] Seven-by-seven system has two sign variables"
]


(* Test: Seven-by-seven system produces four branches *)
TestCreate[
	Length[$7x7pkgVals] === 4,
	True,
	{},
	TestID -> "[paramQuadSolve] Seven-by-seven system produces four branches"
]


(* Test: Manual solution also produces four branches *)
TestCreate[
	Length[$7x7manualVals] === 4,
	True,
	{},
	TestID -> "[paramQuadSolve] Seven-by-seven manual solution produces four branches"
]


(* ::Section:: *)
(*Bilinear Handling Tests*)


(* ::Subsection:: *)
(*paramQuadSolve - Bilinear Systems*)


(* Test: Bilinear system stays linear after substitution *)
TestCreate[
	Module[{x, y, eqns1, vars1, res1, steps1, sol},
		eqns1 = {x*y - 1 == 0, y - 2 == 0};
		vars1 = {x, y};
		res1 = $pqs[eqns1, vars1];
		steps1 = res1["Diagnostics"]["Steps"];
		sol = res1["Solution"];
		AssociationQ[res1] &&
		Sort[sol] === Sort[{x -> 1/2, y -> 2}] &&
		FreeQ[steps1, {"quadratic", _}] &&
		FreeQ[steps1, {"quartic", _}]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Bilinear system reduces to linear"
]


(* Test: Mixed quadratic-linear system with parameter dependence *)
TestCreate[
	Module[{x, y, z, eqns2, vars2, res2, sol, signMap, conds, yRule, xRule},
		eqns2 = {x^2 + y == 1, y + z == 2};
		vars2 = {x, y};
		res2 = $pqs[eqns2, vars2];
		sol = res2["Solution"];
		signMap = res2["SignRootMap"];
		conds = res2["Conditions"];
		yRule = SelectFirst[sol, #[[1]] === y &];
		xRule = SelectFirst[sol, #[[1]] === x &];
		AssociationQ[res2] &&
		Simplify[yRule[[2]] == 2 - z] &&
		Length[Keys[signMap]] >= 1 &&
		Module[{sk = First[Keys[signMap]]}, Simplify[signMap[sk]^2 == 4*(z - 1)]] &&
		MemberQ[conds, z >= 1]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Mixed quadratic-linear has parameter-dependent conditions"
]


(* ::Subsection:: *)
(*paramQuadSolve - Two Radicals Bilinear*)


(* Test: Two radicals bilinear system returns Association *)
TestCreate[
	Module[{x, y, z, eqns, vars, res},
		eqns = {y^2 - 2 == 0, x*y + x - 1 == 0, z^2 + z - 3 == 0};
		vars = {x, y, z};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		AssociationQ[res]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Two radicals bilinear returns Association"
]


(* Test: Two radicals bilinear system has two sign variables *)
TestCreate[
	Module[{x, y, z, eqns, vars, res, signKeys},
		eqns = {y^2 - 2 == 0, x*y + x - 1 == 0, z^2 + z - 3 == 0};
		vars = {x, y, z};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signKeys = Keys[res["SignRootMap"]];
		Length[signKeys] === 2
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Two radicals bilinear has two sign variables"
]


(* Test: Two radicals bilinear system radicands are 8 and 13 *)
TestCreate[
	Module[{x, y, z, eqns, vars, res, signKeys, radVals, radSq},
		eqns = {y^2 - 2 == 0, x*y + x - 1 == 0, z^2 + z - 3 == 0};
		vars = {x, y, z};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signKeys = Keys[res["SignRootMap"]];
		radVals = Values[res["SignRootMap"]];
		radSq = Simplify[radVals^2];
		Sort[Simplify /@ radSq] === Sort[{8, 13}]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Two radicals bilinear radicands are 8 and 13"
]


(* Test: Two radicals bilinear system verification passes *)
TestCreate[
	Module[{x, y, z, eqns, vars, res, signKeys, heads},
		eqns = {y^2 - 2 == 0, x*y + x - 1 == 0, z^2 + z - 3 == 0};
		vars = {x, y, z};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signKeys = Keys[res["SignRootMap"]];
		heads = DeleteDuplicates[Head /@ signKeys];
		AllTrue[Simplify[res["Verification"] /. (Alternatives @@ ((#[_]^2) & /@ heads)) -> 1], TrueQ]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Two radicals bilinear verification passes"
]


(* Test: Two radicals bilinear signs ++ satisfy equations *)
TestCreate[
	Module[{x, y, z, eqns, vars, res, signKeys, rulesFor},
		eqns = {y^2 - 2 == 0, x*y + x - 1 == 0, z^2 + z - 3 == 0};
		vars = {x, y, z};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signKeys = Keys[res["SignRootMap"]];
		rulesFor[v1_, v2_] := Thread[signKeys -> {v1, v2}];
		AllTrue[Simplify[eqns /. res["Solution"] /. rulesFor[1, 1]], TrueQ]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Two radicals signs ++ satisfy equations"
]


(* Test: Two radicals bilinear signs +- satisfy equations *)
TestCreate[
	Module[{x, y, z, eqns, vars, res, signKeys, rulesFor},
		eqns = {y^2 - 2 == 0, x*y + x - 1 == 0, z^2 + z - 3 == 0};
		vars = {x, y, z};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signKeys = Keys[res["SignRootMap"]];
		rulesFor[v1_, v2_] := Thread[signKeys -> {v1, v2}];
		AllTrue[Simplify[eqns /. res["Solution"] /. rulesFor[1, -1]], TrueQ]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Two radicals signs +- satisfy equations"
]


(* Test: Two radicals bilinear signs -+ satisfy equations *)
TestCreate[
	Module[{x, y, z, eqns, vars, res, signKeys, rulesFor},
		eqns = {y^2 - 2 == 0, x*y + x - 1 == 0, z^2 + z - 3 == 0};
		vars = {x, y, z};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signKeys = Keys[res["SignRootMap"]];
		rulesFor[v1_, v2_] := Thread[signKeys -> {v1, v2}];
		AllTrue[Simplify[eqns /. res["Solution"] /. rulesFor[-1, 1]], TrueQ]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Two radicals signs -+ satisfy equations"
]


(* Test: Two radicals bilinear signs -- satisfy equations *)
TestCreate[
	Module[{x, y, z, eqns, vars, res, signKeys, rulesFor},
		eqns = {y^2 - 2 == 0, x*y + x - 1 == 0, z^2 + z - 3 == 0};
		vars = {x, y, z};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signKeys = Keys[res["SignRootMap"]];
		rulesFor[v1_, v2_] := Thread[signKeys -> {v1, v2}];
		AllTrue[Simplify[eqns /. res["Solution"] /. rulesFor[-1, -1]], TrueQ]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Two radicals signs -- satisfy equations"
]


(* Test: Two radicals bilinear solutions match Solve *)
TestCreate[
	Module[{x, y, z, eqns, vars, res, signKeys, assigns, ourRules, solveRules, sameQ},
		eqns = {y^2 - 2 == 0, x*y + x - 1 == 0, z^2 + z - 3 == 0};
		vars = {x, y, z};
		res = $pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals];
		signKeys = Keys[res["SignRootMap"]];
		assigns = Tuples[{-1, 1}, Length[signKeys]];
		ourRules = Map[(res["Solution"] /. Thread[signKeys -> #]) &, assigns];
		solveRules = Solve[eqns, vars, Reals];
		sameQ[r1_, r2_] := TrueQ@Simplify[(vars /. r1) == (vars /. r2)];
		Length[solveRules] == Length[ourRules] && AllTrue[solveRules, ssol |-> AnyTrue[ourRules, sameQ[#, ssol] &]]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Two radicals bilinear solutions match Solve"
]


(* ::Section:: *)
(*Diagnostics Step Tests*)


(* ::Subsection:: *)
(*paramQuadSolve - Steps Linear and Quadratic*)


(* Test: Diagnostics steps include quadratic step for x *)
TestCreate[
	Module[{x, y, eq, vars, r, steps},
		eq = {x^2 - 5 == 0, y + 2 x - 3 == 0};
		vars = {x, y};
		r = $pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False];
		steps = r["Diagnostics"]["Steps"];
		MemberQ[steps, {"quadratic", x}]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Diagnostics include quadratic step for x"
]


(* Test: Diagnostics steps include linear step for y *)
TestCreate[
	Module[{x, y, eq, vars, r, steps},
		eq = {x^2 - 5 == 0, y + 2 x - 3 == 0};
		vars = {x, y};
		r = $pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False];
		steps = r["Diagnostics"]["Steps"];
		MemberQ[steps, {"linear", y}] || MemberQ[steps, {"linear2", y}]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Diagnostics include linear step for y"
]


(* ::Section:: *)
(*Edge Cases - No Solution and Degenerate*)


(* ::Subsection:: *)
(*paramQuadSolve - No Solution*)


(* Test: Inconsistent system returns Association *)
TestCreate[
	Module[{x, y, eq, vars, r},
		eq = {x == 0, x == 1, y == 0};
		vars = {x, y};
		r = $pqs[eq, vars, "ValidationOption" -> True];
		AssociationQ[r]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Inconsistent system returns Association"
]


(* Test: Inconsistent system signals no solution *)
TestCreate[
	Module[{x, y, eq, vars, r, leftover, ver},
		eq = {x == 0, x == 1, y == 0};
		vars = {x, y};
		r = $pqs[eq, vars, "ValidationOption" -> True];
		leftover = r["Diagnostics"]["LeftoverEquations"];
		ver = r["Verification"];
		Length[leftover] >= 1 || AnyTrue[Flatten@ver, FalseQ]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Inconsistent system signals no solution"
]


(* ::Subsection:: *)
(*paramQuadSolve - Degenerate Discriminant*)


(* Test: Degenerate discriminant produces at least one rule set *)
TestCreate[
	Module[{x, y, eq, vars, r, signs, rules},
		eq = {x^2 + 2 x + 1 == 0, y == x + 1};
		vars = {x, y};
		r = $pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> True];
		signs = Keys[r["SignRootMap"]];
		rules = If[Length[signs] == 0, {r["Solution"]}, (r["Solution"] /. Thread[signs -> #]) & /@ Tuples[{-1, 1}, Length[signs]]];
		Length[rules] >= 1
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Degenerate discriminant produces rules"
]


(* Test: Degenerate discriminant collapses to single unique x *)
TestCreate[
	Module[{x, y, eq, vars, r, signs, rules, tuples, uniqueX},
		eq = {x^2 + 2 x + 1 == 0, y == x + 1};
		vars = {x, y};
		r = $pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> True];
		signs = Keys[r["SignRootMap"]];
		rules = If[Length[signs] == 0, {r["Solution"]}, (r["Solution"] /. Thread[signs -> #]) & /@ Tuples[{-1, 1}, Length[signs]]];
		tuples = N[(vars /. #) & /@ rules, 30];
		uniqueX = DeleteDuplicates[tuples[[All, 1]], (Abs[#1 - #2] < 1.*^-12) &];
		Length[uniqueX] == 1
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Degenerate discriminant collapses branches"
]


(* ::Section:: *)
(*Groebner Basis Fallback Tests*)


(* ::Subsection:: *)
(*paramQuadSolve - GB Fallback*)


(* Test: Coupled circle system uses GB fallback *)
TestCreate[
	Module[{x, y, eq, vars, r, steps, lastVar},
		eq = {x^2 + y^2 == 1, x^2 + 2 y^2 == 2};
		vars = {x, y};
		r = $pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False];
		steps = r["Diagnostics"]["Steps"];
		lastVar = vars[[-1]];
		MemberQ[steps, {"quadraticGB", lastVar}]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Coupled circle system uses GB fallback"
]


(* Test: GB fallback creates sign variable *)
TestCreate[
	Module[{x, y, eq, vars, r},
		eq = {x^2 + y^2 == 1, x^2 + 2 y^2 == 2};
		vars = {x, y};
		r = $pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False];
		Length[Keys[r["SignRootMap"]]] >= 1
	],
	True,
	{},
	TestID -> "[paramQuadSolve] GB fallback creates sign variable"
]


(* ::Section:: *)
(*Propagation Tests*)


(* ::Subsection:: *)
(*paramQuadSolve - Variable Propagation*)


(* Test: RHS is free of unknown variables after propagation *)
TestCreate[
	Module[{x, y, z, eq, vars, r, rhs},
		eq = {x == 1, y == x + 1, z == y + 1};
		vars = {x, y, z};
		r = $pqs[eq, vars, "ValidationOption" -> False];
		rhs = r["Solution"][[All, 2]];
		FreeQ[rhs, Alternatives @@ vars]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Solution RHS is free of unknown variables"
]


(* ::Section:: *)
(*Denominator Preprocessing Tests*)


(* ::Subsection:: *)
(*paramQuadSolve - Preprocess Denominators*)


(* Test: psi denominator condition added *)
TestCreate[
	Module[{x, y, a, b, psi, eq, vars, r, conds, condExpr, hasPsiDen},
		eq = {x == a/(1 - 1/psi), y == b/(1 + Exp[A[0]])};
		vars = {x, y};
		r = $pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False];
		conds = r["Conditions"];
		condExpr = And @@ conds;
		hasPsiDen = Simplify[condExpr /. psi -> 1] === False;
		hasPsiDen
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Adds psi denominator condition"
]


(* Test: Exp denominator condition added *)
TestCreate[
	Module[{x, y, a, b, psi, eq, vars, r, conds, condExpr, hasExpDen},
		eq = {x == a/(1 - 1/psi), y == b/(1 + Exp[A[0]])};
		vars = {x, y};
		r = $pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False];
		conds = r["Conditions"];
		condExpr = And @@ conds;
		hasExpDen = Simplify[condExpr /. Exp[A[0]] -> -1] === False;
		hasExpDen
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Adds Exp denominator condition"
]


(* Test: CoeffMap present in result *)
TestCreate[
	Module[{x, y, a, b, psi, eq, vars, r, coeffKeysOK},
		eq = {x == a/(1 - 1/psi), y == b/(1 + Exp[A[0]])};
		vars = {x, y};
		r = $pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False];
		coeffKeysOK = AssociationQ[r["Maps"]["CoeffMap"]] && Length[r["Maps"]["CoeffMap"]] >= 1;
		coeffKeysOK
	],
	True,
	{},
	TestID -> "[paramQuadSolve] CoeffMap present in result"
]


(* Test: No dummy variables in solution *)
TestCreate[
	Module[{x, y, a, b, psi, eq, vars, r, noDummyInSol},
		eq = {x == a/(1 - 1/psi), y == b/(1 + Exp[A[0]])};
		vars = {x, y};
		r = $pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False];
		noDummyInSol = FreeQ[r["Solution"], _Symbol?(StringMatchQ[SymbolName[#], "c$*"] &)];
		noDummyInSol
	],
	True,
	{},
	TestID -> "[paramQuadSolve] No dummy variables in solution"
]


(* ::Section:: *)
(*Radicand Condition Tests*)


(* ::Subsection:: *)
(*paramQuadSolve - Radicand Conditions Negative*)


(* Test: No nord warning for negative radicand system *)
TestCreate[
	Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, r},
		params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
		eqns = {
			((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
			(c21 x + c23 x^2 - c24 y == y - 3 x) /. params
		};
		vars = {x, y};
		r = Quiet@Check[$pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals], "fail", GreaterEqual::nord];
		r =!= "fail"
	],
	True,
	{},
	TestID -> "[paramQuadSolve] No nord warning for negative radicand"
]


(* Test: False condition present for negative radicand *)
TestCreate[
	Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, r, conds},
		params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
		eqns = {
			((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
			(c21 x + c23 x^2 - c24 y == y - 3 x) /. params
		};
		vars = {x, y};
		r = Quiet@Check[$pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals], "fail", GreaterEqual::nord];
		conds = If[r === "fail", {}, r["Conditions"]];
		MemberQ[conds, False]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] False condition for negative radicand"
]


(* Test: SignRadicandMap present in diagnostics *)
TestCreate[
	Module[{x, y, c11, vv, c12, c13, c14, c21, c23, c24, params, eqns, vars, r, radMap},
		params = {c11 -> 3/5, vv -> 4/7, c12 -> 5/3, c13 -> 7/5, c14 -> 9/4, c21 -> -2/5, c23 -> 3/4, c24 -> 2/3};
		eqns = {
			((c11 + vv/2) x^2 + c12 y == c13 x - 3 + c14) /. params,
			(c21 x + c23 x^2 - c24 y == y - 3 x) /. params
		};
		vars = {x, y};
		r = Quiet@Check[$pqs[eqns, vars, "ValidationOption" -> True, "DomainOption" -> Reals], "fail", GreaterEqual::nord];
		radMap = If[r === "fail", <||>, r["Diagnostics"]["SignRadicandMap"]];
		AssociationQ[radMap]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] SignRadicandMap present in diagnostics"
]


(* ::Section:: *)
(*Assumptions Tests*)


(* ::Subsection:: *)
(*paramQuadSolve - Assumptions Return*)


(* Test: Assumptions key exists when no assumptions provided *)
TestCreate[
	Module[{x, y, eqns, vars, res},
		eqns = {x^2 == 1, y == x + 1};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> False];
		KeyExistsQ[res, "Assumptions"]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Assumptions key exists by default"
]


(* Test: Default assumptions include delta gamma psi *)
TestCreate[
	Module[{x, y, eqns, vars, res, ass},
		eqns = {x^2 == 1, y == x + 1};
		vars = {x, y};
		res = $pqs[eqns, vars, "Assumptions" -> Automatic, "ValidationOption" -> False];
		ass = res["Assumptions"];
		StringContainsQ[ToString[ass, InputForm], "delta"] &&
		StringContainsQ[ToString[ass, InputForm], "gamma"] &&
		StringContainsQ[ToString[ass, InputForm], "psi"]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Default assumptions include delta gamma psi"
]


(* Test: Omitted assumptions uses defaults *)
TestCreate[
	Module[{x, y, eqns, vars, res, ass},
		eqns = {x^2 == 1, y == x + 1};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> False];
		ass = res["Assumptions"];
		StringContainsQ[ToString[ass, InputForm], "delta"] &&
		StringContainsQ[ToString[ass, InputForm], "gamma"] &&
		StringContainsQ[ToString[ass, InputForm], "psi"]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Omitted assumptions uses defaults"
]


(* Test: Sign constraints added for quadratics *)
TestCreate[
	Module[{x, y, a, b, eqns, vars, res, ass},
		eqns = {x^2 == a, y == x + b};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> False];
		ass = res["Assumptions"];
		StringContainsQ[ToString[ass, InputForm], "signA[1]^2 == 1"]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Adds sign constraints for quadratics"
]


(* Test: Custom assumptions combined with defaults *)
TestCreate[
	Module[{x, y, a, b, eqns, vars, customAss, res, ass, assStr},
		eqns = {x^2 == a, y == x + b};
		vars = {x, y};
		customAss = a > 0 && b > 0;
		res = $pqs[eqns, vars, "Assumptions" -> customAss, "ValidationOption" -> False];
		ass = res["Assumptions"];
		assStr = ToString[ass, InputForm];
		(* Module renames a to a$nnn, so check for pattern a$digits > 0 *)
		StringContainsQ[assStr, RegularExpression["a\\$\\d+ > 0"]] &&
		StringContainsQ[assStr, RegularExpression["b\\$\\d+ > 0"]] &&
		StringContainsQ[assStr, "delta"] &&
		StringContainsQ[assStr, "gamma"]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Custom assumptions combined with defaults"
]


(* Test: No sign constraints when no quadratics *)
TestCreate[
	Module[{x, y, eqns, vars, res, ass},
		eqns = {x == 1, y == x + 1};
		vars = {x, y};
		res = $pqs[eqns, vars, "ValidationOption" -> False];
		ass = res["Assumptions"];
		!StringContainsQ[ToString[ass, InputForm], "signA"]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] No sign constraints when no quadratics"
]


(* Test: Multiple sign constraints for multiple quadratics *)
TestCreate[
	Module[{x, y, z, a, b, eqns, vars, res, ass},
		eqns = {x^2 == a, y^2 == b, z == x + y};
		vars = {x, y, z};
		res = $pqs[eqns, vars, "ValidationOption" -> False];
		ass = res["Assumptions"];
		StringContainsQ[ToString[ass, InputForm], "signA[1]^2 == 1"] &&
		StringContainsQ[ToString[ass, InputForm], "signA[2]^2 == 1"]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Multiple sign constraints for multiple quadratics"
]


(* Test: Assumptions used in verification *)
TestCreate[
	Module[{x, y, a, b, eqns, vars, customAss, res},
		eqns = {x^2 == a, y == x + b};
		vars = {x, y};
		customAss = a > 0 && Element[a, Reals] && Element[b, Reals];
		res = $pqs[eqns, vars, "Assumptions" -> customAss, "ValidationOption" -> True];
		AssociationQ[res] && KeyExistsQ[res, "Verification"]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Assumptions used in verification"
]


(* Test: Assumptions with OnlyQuadTerms option *)
TestCreate[
	Module[{x, y, z, eqns, vars, res, ass},
		eqns = {x^2 == 1, y^2 == 4, z == 5};
		vars = {x, y, z};
		res = $pqs[eqns, vars, "OnlyQuadTerms" -> True, "ValidationOption" -> False];
		ass = res["Assumptions"];
		AssociationQ[res] &&
		KeyExistsQ[res, "Assumptions"] &&
		StringContainsQ[ToString[ass, InputForm], "signA"]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Assumptions work with OnlyQuadTerms option"
]


(* ::Section:: *)
(*OnlyQuadTerms Option Tests*)


(* ::Subsection:: *)
(*paramQuadSolve - OnlyQuadTerms Option*)


(* Test: OnlyQuadTerms rejects partial coverage *)
TestCreate[
	Module[{x, y, z},
		$pqs[{x^2 + y^2 + z^2 == 3, x^2 + 2 x - 1 == 0}, {x, y, z}, "OnlyQuadTerms" -> True] === $Failed
	],
	True,
	{FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve::nocover},
	TestID -> "[paramQuadSolve] OnlyQuadTerms rejects partial coverage"
]


(* Test: OnlyQuadTerms covers all variables *)
TestCreate[
	Module[{x, y, z, eqns, vars, res, solvedVars, diagnostics},
		eqns = {x^2 - 1 == 0, y^2 - 4 == 0, z^2 - 9 == 0};
		vars = {x, y, z};
		res = $pqs[eqns, vars, "OnlyQuadTerms" -> True];
		solvedVars = Sort[res["Diagnostics"]["SolvedQuadraticVariables"]];
		diagnostics = res["Diagnostics"];
		AssociationQ[res] &&
		solvedVars === {x, y, z} &&
		diagnostics["DeferredVariables"] === {}
	],
	True,
	{},
	TestID -> "[paramQuadSolve] OnlyQuadTerms covers all variables"
]


(* Test: OnlyQuadTerms defers non-quadratic equations *)
TestCreate[
	Module[{x, y, z, eqns, vars, res, deferredEqns, deferredVars},
		eqns = {x^2 == 1, x^2 + y == 2, y + z == 1};
		vars = {x, y, z};
		res = $pqs[eqns, vars, "OnlyQuadTerms" -> True];
		deferredEqns = res["DeferredEquations"];
		deferredVars = res["DeferredVariables"];
		AssociationQ[res] &&
		res["Solution"][[All, 1]] === {x} &&
		Length[deferredEqns] == 2 &&
		Sort[deferredVars] === {y, z}
	],
	True,
	{},
	TestID -> "[paramQuadSolve] OnlyQuadTerms defers non-quadratic equations"
]


(* Test: OnlyQuadTerms rejects no quadratics *)
TestCreate[
	Module[{x, y},
		$pqs[{x + y == 1}, {x, y}, "OnlyQuadTerms" -> True] === $Failed
	],
	True,
	{FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve::noquad},
	TestID -> "[paramQuadSolve] OnlyQuadTerms rejects system with no quadratics"
]


(* ::Section:: *)
(*Options and Domain Tests*)


(* ::Subsection:: *)
(*paramQuadSolve - Options*)


(* Test: Method option Sequential is recorded *)
TestCreate[
	Module[{x, y, eq, vars, rSeq, diagMethodOK},
		eq = {x^2 - 5 == 0, y + 2 x - 3 == 0};
		vars = {x, y};
		rSeq = Quiet[$pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False, "Method" -> "Sequential"], {Power::infy, Infinity::indet}];
		diagMethodOK = rSeq["Diagnostics"]["Method"] === "Sequential";
		diagMethodOK
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Method Sequential is recorded in diagnostics"
]


(* Test: MonomialOrder option is recorded *)
TestCreate[
	Module[{x, y, eq, vars, rOrder, diagOrderOK},
		eq = {x^2 - 5 == 0, y + 2 x - 3 == 0};
		vars = {x, y};
		rOrder = Quiet[$pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False, "Method" -> "SequentialWithGroebner", "MonomialOrder" -> DegreeReverseLexicographic], {Power::infy, Infinity::indet}];
		diagOrderOK = rOrder["Diagnostics"]["GroebnerMonomialOrder"] === DegreeReverseLexicographic;
		diagOrderOK
	],
	True,
	{},
	TestID -> "[paramQuadSolve] MonomialOrder is recorded in diagnostics"
]


(* Test: SymbolicSignSymbol option sets head *)
TestCreate[
	Module[{x, y, sg, eq, vars, rSign, signHeadOK},
		eq = {x^2 - 5 == 0, y + 2 x - 3 == 0};
		vars = {x, y};
		rSign = Quiet[$pqs[eq, vars, "SymbolicSignSymbol" -> sg, "DomainOption" -> Reals], {Power::infy, Infinity::indet}];
		signHeadOK = And @@ (Head /@ Keys[rSign["SignRootMap"]] === Table[sg, {Length[Keys[rSign["SignRootMap"]]]}]);
		signHeadOK
	],
	True,
	{},
	TestID -> "[paramQuadSolve] SymbolicSignSymbol sets sign variable head"
]


(* Test: Radicand sign constraint added to conditions *)
TestCreate[
	Module[{x, y, eq, vars, rRad, radCondOK},
		eq = {x^2 - 1 == 0, y^2 - x == 0};
		vars = {x, y};
		rRad = Quiet[$pqs[eq, vars, "DomainOption" -> Reals, "ValidationOption" -> False], {Power::infy, Infinity::indet}];
		radCondOK = Module[{sk = Keys[rRad["SignRootMap"]]}, MemberQ[rRad["Conditions"], First[sk] >= 0]];
		radCondOK
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Radicand sign constraint in conditions"
]


(* ::Section:: *)
(*Orphan Variable Avoidance Tests*)


(* ::Subsection:: *)
(*paramQuadSolve - Orphan Variable Avoidance*)


(* Test: Simple case avoids orphaned variable *)
TestCreate[
	Module[{eqns, vars, res, selectedEqs, deferredEqs},
		(* System where eq 3 has orphaned variable w *)
		eqns = {
			x^2 == 1,           (* eq 1: has x *)
			y^2 == 4,           (* eq 2: has y *)
			x^2 + y + w == 0,   (* eq 3: has x, y, w (w is orphaned) *)
			z == 5              (* eq 4: has z *)
		};
		vars = {x, y, z, w};
		res = $pqs[eqns, vars, "OnlyQuadTerms" -> True];
		deferredEqs = res["Diagnostics"]["DeferredEquationsIndices"];
		selectedEqs = Complement[Range[4], deferredEqs];

		(* Should select eqs 1, 2 (avoid eq 3 with orphaned w) *)
		(* Should defer eqs 3, 4 so w can be solved from deferred system *)
		AssociationQ[res] &&
		Sort[selectedEqs] === {1, 2} &&
		MemberQ[deferredEqs, 3] &&
		MemberQ[res["DeferredVariables"], w]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Simple case avoids orphaned variable"
]


(* Test: Prefers equations with no orphans *)
TestCreate[
	Module[{eqns, vars, res, selectedEqs, deferredEqs},
		eqns = {
			a^2 == 1,         (* eq 1: quadratic in a *)
			a^2 + b^2 == 2,   (* eq 2: quadratic in a, b *)
			b^2 + c == 3,     (* eq 3: quadratic in b, linear in c (c orphaned if selected) *)
			d == 4            (* eq 4: linear in d *)
		};
		vars = {a, b, c, d};
		res = $pqs[eqns, vars, "OnlyQuadTerms" -> True];
		selectedEqs = Complement[Range[4], res["Diagnostics"]["DeferredEquationsIndices"]];
		deferredEqs = res["Diagnostics"]["DeferredEquationsIndices"];

		(* Should select eqs 1, 2 (both have no orphans) *)
		(* Should defer eq 3 so c can be solved *)
		AssociationQ[res] &&
		Sort[selectedEqs] === {1, 2} &&
		MemberQ[deferredEqs, 3] &&
		MemberQ[res["DeferredVariables"], c]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] Prefers equations with no orphans"
]


(* Test: LongRunRisk equation 4 is deferred *)
TestCreate[
	Module[{sys, vars, res, deferredEqs},
		sys = {
			0 == ((1 - gamma) (-1 + psi) rhocp)/((1 - 1/psi) psi) -
				((1 - gamma) A[1])/(1 - 1/psi) +
				(E^A[0] (1 - gamma) vpp A[7])/((1 + E^A[0]) (1 - 1/psi)),
			0 == ((1 - gamma) (-1 + psi) xic)/((1 - 1/psi) psi) -
				((1 - gamma) A[2])/(1 - 1/psi),
			0 == (E^A[0] (1 - gamma) xip A[1])/((1 + E^A[0]) (1 - 1/psi)) -
				((1 - gamma) A[3])/(1 - 1/psi),
			0 == (E^(2 A[0]) (1 - gamma)^2 phip A[1] A[2])/((1 + E^A[0])^2 (1 - 1/psi)^2) +
				A[2] ((E^A[0] (1 - gamma)^2 phicp (-1 + psi))/((1 + E^A[0]) (1 - 1/psi)^2 psi) +
					(E^(2 A[0]) (1 - gamma)^2 A[3])/((1 + E^A[0])^2 (1 - 1/psi)^2)) -
				(2 E^A[0] Esg (1 - gamma) (-1 + rhog) rhog A[5])/((1 + E^A[0]) (1 - 1/psi)) -
				(4 E^(2 A[0]) Esg (1 - gamma)^2 phig^2 (-1 + rhog) rhog A[5]^2)/((1 + E^A[0])^2 (1 - 1/psi)^2) +
				A[4] (((1 - gamma) (-1 + E^A[0] (-1 + rhog)))/((1 + E^A[0]) (1 - 1/psi)) +
					(2 E^(2 A[0]) (1 - gamma)^2 phig^2 rhog A[5])/((1 + E^A[0])^2 (1 - 1/psi)^2)),
			0 == (E^(2 A[0]) (1 - gamma)^2 A[2]^2)/(2 (1 + E^A[0])^2 (1 - 1/psi)^2) +
				((1 - gamma) (-1 + E^A[0] (-1 + rhog^2)) A[5])/((1 + E^A[0]) (1 - 1/psi)) +
				(2 E^(2 A[0]) (1 - gamma)^2 phig^2 rhog^2 A[5]^2)/((1 + E^A[0])^2 (1 - 1/psi)^2),
			0 == ((1 - gamma) (-1 + psi) rhocpbar)/((1 - 1/psi) psi) +
				(E^A[0] (1 - gamma) rhoppbar A[1])/((1 + E^A[0]) (1 - 1/psi)) +
				((1 - gamma) (-1 + E^A[0] (-1 + rhopbar)) A[6])/((1 + E^A[0]) (1 - 1/psi)) +
				(E^A[0] (1 - gamma) vppbar A[7])/((1 + E^A[0]) (1 - 1/psi)),
			0 == (E^(2 A[0]) (1 - gamma)^2 phipbarpb^2 A[6]^2)/(2 (1 + E^A[0])^2 (1 - 1/psi)^2) +
				((1 - gamma) (-1 + E^A[0] (-1 + vp)) A[7])/((1 + E^A[0]) (1 - 1/psi))
		};
		vars = {A[1], A[2], A[3], A[4], A[5], A[6], A[7]};

		res = $pqs[sys, vars, "OnlyQuadTerms" -> True];
		deferredEqs = res["Diagnostics"]["DeferredEquationsIndices"];

		(* Equation 4 contains A[4] which appears nowhere else *)
		(* The orphan count fix should defer equation 4 *)
		(* This ensures A[4] can be solved from the deferred system *)
		AssociationQ[res] &&
		MemberQ[deferredEqs, 4] &&
		MemberQ[res["DeferredVariables"], A[4]] &&
		!FreeQ[res["DeferredEquations"][[Position[deferredEqs, 4][[1, 1]]]], A[4]]
	],
	True,
	{},
	TestID -> "[paramQuadSolve] LongRunRisk equation 4 with A[4] is deferred"
]


(* Test: No orphans in deferred variables *)
TestCreate[
	Module[{sys, vars, res, deferredEqs, deferredVars, varsInDeferredEqs, orphanedVars},
		sys = {
			0 == ((1 - gamma) (-1 + psi) rhocp)/((1 - 1/psi) psi) -
				((1 - gamma) A[1])/(1 - 1/psi) +
				(E^A[0] (1 - gamma) vpp A[7])/((1 + E^A[0]) (1 - 1/psi)),
			0 == ((1 - gamma) (-1 + psi) xic)/((1 - 1/psi) psi) -
				((1 - gamma) A[2])/(1 - 1/psi),
			0 == (E^A[0] (1 - gamma) xip A[1])/((1 + E^A[0]) (1 - 1/psi)) -
				((1 - gamma) A[3])/(1 - 1/psi),
			0 == (E^(2 A[0]) (1 - gamma)^2 phip A[1] A[2])/((1 + E^A[0])^2 (1 - 1/psi)^2) +
				A[2] ((E^A[0] (1 - gamma)^2 phicp (-1 + psi))/((1 + E^A[0]) (1 - 1/psi)^2 psi) +
					(E^(2 A[0]) (1 - gamma)^2 A[3])/((1 + E^A[0])^2 (1 - 1/psi)^2)) -
				(2 E^A[0] Esg (1 - gamma) (-1 + rhog) rhog A[5])/((1 + E^A[0]) (1 - 1/psi)) -
				(4 E^(2 A[0]) Esg (1 - gamma)^2 phig^2 (-1 + rhog) rhog A[5]^2)/((1 + E^A[0])^2 (1 - 1/psi)^2) +
				A[4] (((1 - gamma) (-1 + E^A[0] (-1 + rhog)))/((1 + E^A[0]) (1 - 1/psi)) +
					(2 E^(2 A[0]) (1 - gamma)^2 phig^2 rhog A[5])/((1 + E^A[0])^2 (1 - 1/psi)^2)),
			0 == (E^(2 A[0]) (1 - gamma)^2 A[2]^2)/(2 (1 + E^A[0])^2 (1 - 1/psi)^2) +
				((1 - gamma) (-1 + E^A[0] (-1 + rhog^2)) A[5])/((1 + E^A[0]) (1 - 1/psi)) +
				(2 E^(2 A[0]) (1 - gamma)^2 phig^2 rhog^2 A[5]^2)/((1 + E^A[0])^2 (1 - 1/psi)^2),
			0 == ((1 - gamma) (-1 + psi) rhocpbar)/((1 - 1/psi) psi) +
				(E^A[0] (1 - gamma) rhoppbar A[1])/((1 + E^A[0]) (1 - 1/psi)) +
				((1 - gamma) (-1 + E^A[0] (-1 + rhopbar)) A[6])/((1 + E^A[0]) (1 - 1/psi)) +
				(E^A[0] (1 - gamma) vppbar A[7])/((1 + E^A[0]) (1 - 1/psi)),
			0 == (E^(2 A[0]) (1 - gamma)^2 phipbarpb^2 A[6]^2)/(2 (1 + E^A[0])^2 (1 - 1/psi)^2) +
				((1 - gamma) (-1 + E^A[0] (-1 + vp)) A[7])/((1 + E^A[0]) (1 - 1/psi))
		};
		vars = {A[1], A[2], A[3], A[4], A[5], A[6], A[7]};

		res = $pqs[sys, vars, "OnlyQuadTerms" -> True];
		deferredEqs = res["DeferredEquations"];
		deferredVars = res["DeferredVariables"];

		(* Find all variables that appear in deferred equations *)
		varsInDeferredEqs = Union[Flatten[
			Cases[deferredEqs, A[i_] :> A[i], Infinity]
		]];

		(* Variables in deferred vars but NOT in deferred equations are orphaned *)
		orphanedVars = Complement[deferredVars, varsInDeferredEqs];

		(* The orphan count fix ensures no orphaned variables *)
		AssociationQ[res] &&
		orphanedVars === {}
	],
	True,
	{},
	TestID -> "[paramQuadSolve] No orphaned variables in deferred set"
]


End[]
EndTestSection[]
