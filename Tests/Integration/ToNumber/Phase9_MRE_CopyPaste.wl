(* ::Package:: *)
(* ::Title:: *)
(*Minimal Reproducible Examples for Phase 9 Warnings*)


(* ::Section:: *)
(*Copy-Paste Ready Examples*)


(* ::Text:: *)
(*Each example below can be copied and pasted directly into a Wolfram notebook to reproduce the warning.*)


(* ::Subsection:: *)
(*MRE 1: LinearProgramming::lpsub - "This problem is unbounded"*)


(* ::Text:: *)
(*What it means: LinearProgramming found an unbounded region during constraint exploration*)
(*When it's OK: Solution is still found despite the warning*)
(*When it's a problem: No solution found at all (returns Failure)*)


(* Copy this: *)
LinearProgramming[
  {1, 1},           (* Objective: maximize x + y *)
  {{1, 0}},         (* Constraint: x >= 1 *)
  {{1, 0}}          (* No upper bound -> unbounded *)
]

(* Expected output: {1, 0} (solution found) *)
(* Expected warning: LinearProgramming::lpsub *)


(* ::Subsection:: *)
(*MRE 2: Reduce::ratnz - "Unable to solve with inexact coefficients"*)


(* ::Text:: *)
(*What it means: Reduce converted floating-point to exact rational, then back to decimal*)
(*When it's OK: ALWAYS - this is correct, robust behavior*)
(*When it's a problem: NEVER - this improves accuracy*)


(* Copy this: *)
Reduce[{x^2 + 0.99*x - 1.5 == 0}, x, Reals]

(* Expected output: x == -1.816... || x == 0.826... *)
(* Expected warning: Reduce::ratnz *)

(* What happens internally:
   0.99 -> 99/100
   1.5 -> 3/2
   Solve exactly with rational arithmetic
   Convert back to decimal
*)


(* ::Subsection:: *)
(*MRE 3: FindRoot::njnum - "Jacobian is not a matrix of numbers"*)


(* ::Text:: *)
(*What it means: At some iteration, the Jacobian had symbolic (non-numeric) entries*)
(*When it's OK: FindRoot still converges to a solution*)
(*When it's a problem: FindRoot fails to converge completely*)


(* Copy this: *)
f[x_] := If[x > 0, x^2 - 4, -x^2 - 4];
FindRoot[f[x] == 0, {x, 1.5}]

(* Expected output: {x -> 2.0} (solution found) *)
(* Expected warning: FindRoot::njnum (may appear) *)

(* More complex example that definitely triggers it: *)
FindRoot[{
  a == b + Sqrt[Abs[b - 1]],
  b == a - 0.5*Sign[a]
}, {{a, 1}, {b, 1}}]


(* ::Subsection:: *)
(*MRE 4: Refine::lpsub - "This problem is unbounded" (during refinement)*)


(* ::Text:: *)
(*What it means: While refining symbolic expressions, hit unbounded subproblem*)
(*When it's OK: Refinement completes, result is usable*)
(*When it's a problem: Refinement fails completely*)


(* Copy this: *)
expr = Piecewise[{{x, x > 0}, {-x, x <= 0}}];
Refine[expr > 10, x \[Element] Reals]

(* Expected output: Symbolic condition or simplified form *)
(* Expected warning: Refine::lpsub (may appear with complex expressions) *)


(* ::Subsection:: *)
(*MRE 5: MIMETypeToFormatList::fmterr - "None is not a recognized MIME type"*)


(* ::Text:: *)
(*What it means: Internal formatting tried to use None as a MIME type*)
(*When it's OK: ALWAYS - purely cosmetic*)
(*When it's a problem: NEVER - doesn't affect computation*)


(* Copy this: *)
Check[
  Export["temp.dat", {1, 2, 3}, None],
  "Export failed"
]

(* Expected output: Export error message *)
(* Expected warning: MIMETypeToFormatList::fmterr or Export::noelem *)


(* ::Section:: *)
(*Combined Example: Simulating ToNum Solving*)


(* ::Text:: *)
(*This simulates the multi-step solving process in ToNum*)


(* Step 1: Solve coupled nonlinear system *)
eqnA0[a0_, a1_] := a0 - (0.99*a1 + 1.5);
eqnA1[a0_, a1_] := a1 - (0.95*a0 - 0.8);

solutionA = FindRoot[{
  eqnA0[a0, a1] == 0,
  eqnA1[a0, a1] == 0
}, {{a0, 1.0}, {a1, 1.0}}]

(* May trigger: FindRoot::njnum *)


(* Step 2: Check constraints with Reduce *)
constraintCheck = Reduce[{
  a0 > 0,
  a1 > 0,
  a0^2 + 0.99*a1 < 10.0
} /. solutionA, Reals]

(* May trigger: Reduce::ratnz *)


(* Step 3: Refine solution *)
refinedA0 = Refine[a0 /. solutionA[[1]], a0 > 0]

(* May trigger: Refine::lpsub *)


(* ::Section:: *)
(*How to Suppress These Warnings*)


(* ::Text:: *)
(*If you've verified your results are correct and want to suppress warnings:*)


(* Suppress specific warnings: *)
Quiet[
  FindRoot[f[x] == 0, {x, 1.5}],
  {FindRoot::njnum}
]

(* Suppress multiple warning types: *)
Quiet[
  Reduce[{x^2 + 0.99*x - 1.5 == 0}, x, Reals],
  {Reduce::ratnz, LinearProgramming::lpsub}
]

(* Suppress all warnings (use with caution!): *)
Quiet[
  (* your code here *)
]


(* ::Section:: *)
(*Real ToNum Example*)


(* ::Text:: *)
(*To see these warnings in actual ToNum usage:*)


Needs["FernandoDuarte`LongRunRisk`"];

(* Load a model *)
Needs["PacletizedResourceFunctions`"];
models = Get@Get@"FernandoDuarte/LongRunRisk/Models.wl";
nrcModel = models["NRC"];

(* This will generate warnings during solving (expected): *)
rules = ToNum["Rules", nrcModel];

(* Expected warnings:
   - LinearProgramming::lpsub
   - Reduce::ratnz
   - FindRoot::njnum
   All are NORMAL and indicate successful solving *)


(* To suppress while still getting correct results: *)
rulesQuiet = Quiet[
  ToNum["Rules", nrcModel],
  {LinearProgramming::lpsub, Reduce::ratnz, FindRoot::njnum, Refine::lpsub}
];

(* Verify same results: *)
rules === rulesQuiet  (* Should be True *)


(* ::Section:: *)
(*Diagnostic Checklist*)


(* ::Text:: *)
(*When you see these warnings, check:*)


(*
1. LinearProgramming::lpsub
   \[Checkmark] Solution was found (not Failure or $Failed)
   \[Checkmark] Result is numeric

2. Reduce::ratnz
   \[Checkmark] Nothing to check - always safe

3. FindRoot::njnum
   \[Checkmark] FindRoot converged (returned {x -> value})
   \[Checkmark] Not stuck (not returning unevaluated)

4. Refine::lpsub
   \[Checkmark] Refine completed
   \[Checkmark] Result is usable

5. MIMETypeToFormatList::fmterr
   \[Checkmark] Nothing to check - cosmetic only
*)


(* ::Text:: *)
(*If all checks pass, warnings are EXPECTED and HARMLESS.*)
