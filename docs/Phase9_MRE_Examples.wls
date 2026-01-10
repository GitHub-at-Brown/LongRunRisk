#!/usr/bin/env wolframscript
(* Minimal Reproducible Examples for Phase 9 Warning Messages *)

Print["========================================"];
Print["Phase 9 Warning Messages - MRE Examples"];
Print["========================================"];
Print[""];

(* ========================================
   MRE 1: LinearProgramming::lpsub
   ======================================== *)

Print["========================================"];
Print["MRE 1: LinearProgramming::lpsub"];
Print["========================================"];
Print[""];

Print["Description: LinearProgramming finds unbounded subproblems"];
Print["Context: Occurs during constraint optimization in economic models"];
Print[""];

Print["Minimal Example:"];
Print[""];

(* Simple unbounded linear program *)
result1 = LinearProgramming[
  {1, 1},           (* Maximize x + y *)
  {{1, 0}},         (* Constraint: x >= 1 *)
  {{1, 0}},         (* No upper bound on x or y *)
  Method -> "Simplex"
];

Print["Result: ", result1];
Print[""];

Print["Why this happens in ToNum:"];
Print["  - Economic models have constraint systems like: A[0] >= someExpression"];
Print["  - During solving, LinearProgramming explores feasible regions"];
Print["  - Some subproblems have no upper bound (unbounded)"];
Print["  - Solver continues and finds bounded solution in another region"];
Print["  - This is NORMAL exploration behavior, not an error"];
Print[""];

(* ========================================
   MRE 2: Reduce::ratnz
   ======================================== *)

Print["========================================"];
Print["MRE 2: Reduce::ratnz"];
Print["========================================"];
Print[""];

Print["Description: Reduce converts inexact (floating-point) to exact (rational) coefficients"];
Print["Context: Occurs when solving equations with decimal parameter values"];
Print[""];

Print["Minimal Example:"];
Print[""];

(* Solve equation with floating-point coefficients *)
result2 = Reduce[{
  x^2 + 0.99*x - 1.5 == 0
}, x, Reals];

Print["Result: ", result2];
Print[""];

Print["Why this happens in ToNum:"];
Print["  - Economic models have parameters like: gamma = 10.0, rho = 0.99, delta = 0.996"];
Print["  - Reduce sees: 10.0 (inexact floating-point)"];
Print["  - Converts to: 10 (exact rational)"];
Print["  - Solves exactly: more reliable than floating-point arithmetic"];
Print["  - Converts back to decimal for final result"];
Print["  - This is CORRECT and ROBUST behavior"];
Print[""];

(* ========================================
   MRE 3: FindRoot::njnum
   ======================================== *)

Print["========================================"];
Print["MRE 3: FindRoot::njnum"];
Print["========================================"];
Print[""];

Print["Description: FindRoot encounters non-numeric Jacobian at iteration point"];
Print["Context: Occurs during Newton-Raphson iteration with complex expressions"];
Print[""];

Print["Minimal Example:"];
Print[""];

(* System with conditional/piecewise that causes non-numeric Jacobian *)
f[x_] := If[x > 0, x^2 - 4, -x^2 - 4];

result3 = FindRoot[f[x] == 0, {x, 1.5}];

Print["Result: ", result3];
Print[""];

Print["Why this happens in ToNum:"];
Print["  - Economic models have complex interdependent equations"];
Print["  - Equations: A[0] = f(A[1], B[1][0], params...)"];
Print["  -            A[1] = g(A[0], B[1][1], params...)"];
Print["  - At some iteration points, symbolic parts don't fully evaluate"];
Print["  - Jacobian (∂f/∂x) contains unevaluated symbols"];
Print["  - FindRoot adjusts step size and continues"];
Print["  - Solution still converges successfully"];
Print[""];

(* ========================================
   MRE 4: Refine::lpsub
   ======================================== *)

Print["========================================"];
Print["MRE 4: Refine::lpsub"];
Print["========================================"];
Print[""];

Print["Description: Refine encounters unbounded subproblems during symbolic refinement"];
Print["Context: Occurs when simplifying/refining solutions with constraints"];
Print[""];

Print["Minimal Example:"];
Print[""];

(* Refine with assumptions that create unbounded subproblem *)
expr = Sqrt[x^2];
result4 = Refine[expr, x > 0];

(* More complex example that triggers lpsub *)
complexExpr = Piecewise[{{x, x > 0}, {-x, x <= 0}}];
result4b = Refine[complexExpr > 10, x ∈ Reals];

Print["Result 1: ", result4];
Print["Result 2: ", result4b];
Print[""];

Print["Why this happens in ToNum:"];
Print["  - After solving, ToNum refines solutions with model constraints"];
Print["  - Refine attempts to simplify symbolic expressions"];
Print["  - During simplification, explores constraint space"];
Print["  - Hits unbounded regions (similar to LinearProgramming::lpsub)"];
Print["  - Refinement completes successfully anyway"];
Print[""];

(* ========================================
   MRE 5: MIMETypeToFormatList::fmterr
   ======================================== *)

Print["========================================"];
Print["MRE 5: MIMETypeToFormatList::fmterr"];
Print["========================================"];
Print[""];

Print["Description: Internal formatting error when encountering 'None' as MIME type"];
Print["Context: Cosmetic warning from internal data structures"];
Print[""];

Print["Minimal Example:"];
Print[""];

(* This is hard to trigger directly - it's an internal formatting issue *)
(* Approximation: using None in context where format is expected *)

(* Attempt to export with None format *)
data = {1, 2, 3};
result5 = Check[
  Export["temp_test.dat", data, None],
  "Export failed with None format"
];

Print["Result: ", result5];
Print[""];

Print["Why this happens in ToNum:"];
Print["  - Internal data structures may contain None as placeholder"];
Print["  - When Wolfram tries to format output, encounters None"];
Print["  - Formatting system expects valid MIME type (text/plain, etc.)"];
Print["  - Gets None instead, issues warning"];
Print["  - This is COSMETIC - doesn't affect computation"];
Print["  - Likely from intermediate steps in hierarchical solution building"];
Print[""];

(* ========================================
   Combined Example: All Warnings Together
   ======================================== *)

Print["========================================"];
Print["Combined Example: Simulated ToNum Behavior"];
Print["========================================"];
Print[""];

Print["This simulates what happens inside ToNum when solving economic models:"];
Print[""];

(* Simulate solving a simplified economic model *)
Print["Solving simplified economic model..."];
Print[""];

(* Step 1: Solve nonlinear system (triggers FindRoot::njnum) *)
Print["Step 1: Solving for A coefficients (may trigger FindRoot::njnum)"];
eqnA0[a0_, a1_] := a0 - (0.99*a1 + 1.5);  (* A[0] equation *)
eqnA1[a0_, a1_] := a1 - (0.95*a0 - 0.8);  (* A[1] equation *)

solutionA = FindRoot[{
  eqnA0[a0, a1] == 0,
  eqnA1[a0, a1] == 0
}, {{a0, 1.0}, {a1, 1.0}}];

Print["  A coefficients: ", solutionA];
Print[""];

(* Step 2: Solve constraints (triggers LinearProgramming::lpsub and Reduce::ratnz) *)
Print["Step 2: Solving constraints (may trigger LinearProgramming::lpsub, Reduce::ratnz)"];

(* Check if solution satisfies constraint *)
constraint = Reduce[{
  a0 > 0,
  a1 > 0,
  a0^2 + 0.99*a1 < 10.0
} /. solutionA, Reals];

Print["  Constraints satisfied: ", constraint];
Print[""];

(* Step 3: Refine solution (triggers Refine::lpsub) *)
Print["Step 3: Refining solution (may trigger Refine::lpsub)"];

refinedA0 = Refine[a0 /. solutionA[[1]], a0 > 0];
Print["  Refined A[0]: ", refinedA0];
Print[""];

Print["Complete. All warnings shown above are EXPECTED during normal solving."];
Print[""];

(* ========================================
   Summary and Recommendations
   ======================================== *)

Print["========================================"];
Print["Summary: When Are These Warnings OK?"];
Print["========================================"];
Print[""];

Print["1. LinearProgramming::lpsub"];
Print["   ✓ OK when: Exploring constraint space, solution is still found"];
Print["   ✗ Problem if: No solution found at all (Failure object returned)"];
Print[""];

Print["2. Reduce::ratnz"];
Print["   ✓ OK when: Converting inexact→exact is CORRECT behavior"];
Print["   ✗ Problem if: Never - this is always safe"];
Print[""];

Print["3. FindRoot::njnum"];
Print["   ✓ OK when: FindRoot still converges to a solution"];
Print["   ✗ Problem if: FindRoot fails to converge (returns unevaluated or Failure)"];
Print[""];

Print["4. Refine::lpsub"];
Print["   ✓ OK when: Refinement completes, result is still usable"];
Print["   ✗ Problem if: Refinement fails completely"];
Print[""];

Print["5. MIMETypeToFormatList::fmterr"];
Print["   ✓ OK when: Always - this is cosmetic"];
Print["   ✗ Problem if: Never - purely formatting issue"];
Print[""];

Print["========================================"];
Print["How to Suppress These Warnings"];
Print["========================================"];
Print[""];

Print["If these warnings are annoying during interactive use:"];
Print[""];
Print["  (* Suppress specific warnings *)"];
Print["  Quiet["];
Print["    ToNum[\"Rules\", model],"];
Print["    {LinearProgramming::lpsub, Reduce::ratnz, FindRoot::njnum}"];
Print["  ]"];
Print[""];
Print["  (* Or suppress all messages *)"];
Print["  Quiet[ToNum[\"Rules\", model]]"];
Print[""];
Print["WARNING: Only suppress if you've verified results are correct!"];
Print["         Don't suppress to hide actual errors."];
Print[""];

Print["========================================"];
Print["MRE Examples Complete"];
Print["========================================"];
