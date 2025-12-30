# Compiled Functions in Wolfram Language

## Overview

This document covers the behavior of compiled functions, automatic fallback mechanisms, and patterns for user-controlled execution.

## Compile (Classic System)

### Basic Usage

```wolfram
cf = Compile[{{x, _Real}}, x^2 + 1];
cf[3.0]  (* Returns 10. *)
```

### Structure of CompiledFunction

A `CompiledFunction` has 8 parts:

| Part | Contents |
|------|----------|
| 1 | Version info |
| 2 | Argument types |
| 3-6 | Internal bytecode/registers |
| **7** | **Original `Function` expression** |
| 8 | Evaluation mode |

Extract original function:
```wolfram
cf = Compile[{x}, x^2 + 1];
originalFunc = cf[[7]];  (* or cf[[-2]] *)
originalFunc[3]  (* Returns 10 - uncompiled evaluation *)
```

### Automatic Fallback

By default, when a compiled function receives arguments it can't handle (e.g., symbolic), it falls back to the stored Wolfram Language expression:

```wolfram
cf = Compile[{x}, x^2 + 1];
cf[y]  (* Warning message, then returns 1 + y^2 *)
```

### Controlling Fallback with RuntimeOptions

Prevent automatic fallback:
```wolfram
cf = Compile[{{x, _Real}}, x^2 + 1,
  RuntimeOptions -> {"EvaluateSymbolically" -> False}
];
cf[y]  (* Returns unevaluated - no fallback *)
```

Other useful RuntimeOptions:
- `"RuntimeErrorHandler"` - Custom error handling
- `"CatchMachineOverflow"` - Handle numeric overflow
- `"CatchMachineUnderflow"` - Handle numeric underflow

## FunctionCompile (Newer LLVM-Based System)

Available in Wolfram Language 12.1+. Uses LLVM for compilation.

### Basic Usage

```wolfram
fcf = FunctionCompile[Function[{Typed[x, "Real64"]}, x^2 + 1]];
fcf[3.0]  (* Returns 10. *)
```

### Key Differences from Compile

| Feature | Compile | FunctionCompile |
|---------|---------|-----------------|
| Returns | `CompiledFunction` | `CompiledCodeFunction` |
| Stores original expression | Yes (Part 7) | No |
| Automatic fallback | Yes (configurable) | No |
| Compilation backend | Wolfram VM | LLVM |
| Performance | Good | Better |
| Type system | Basic | Rich (Typed expressions) |

### No Automatic Fallback

```wolfram
fcf = FunctionCompile[Function[{Typed[x, "Real64"]}, x^2 + 1]];
fcf[y]  (* FAILS - no fallback mechanism *)
```

## User-Controlled Compiled vs Uncompiled Execution

### Pattern 1: Extract from CompiledFunction

```wolfram
cf = Compile[{x}, x^2 + 1];

(* Use compiled *)
cf[3.0]

(* Use uncompiled *)
cf[[7]][3.0]
```

### Pattern 2: Explicit Option Control

```wolfram
(* Store both versions *)
myFuncWL = Function[{x}, x^2 + 1];
myFuncCompiled = Compile[{{x, _Real}}, x^2 + 1];

(* Define with option *)
Options[myFunc] = {UseCompiled -> True};

myFunc[x_?NumericQ, opts:OptionsPattern[]] :=
  If[TrueQ[OptionValue[UseCompiled]],
    myFuncCompiled[x],
    myFuncWL[x]
  ];

myFunc[x_, opts:OptionsPattern[]] := myFuncWL[x];  (* symbolic *)

(* Usage *)
myFunc[3.0]                      (* compiled *)
myFunc[3.0, UseCompiled -> False] (* uncompiled *)
myFunc[y]                        (* symbolic, uses WL version *)
```

### Pattern 3: Multiple Dispatch Definitions

```wolfram
myFuncWL = Function[{x}, x^2 + 1];
myFuncCompiled = Compile[{{x, _Real}}, x^2 + 1];

myFunc[x_?NumericQ, "Compiled" -> True] := myFuncCompiled[x]
myFunc[x_, "Compiled" -> False] := myFuncWL[x]
myFunc[x_?NumericQ] := myFuncCompiled[x]  (* default: compiled *)
myFunc[x_] := myFuncWL[x]  (* fallback: symbolic *)
```

## Application to LongRunRisk Package

For compiled equation functions in this package, consider:

1. **Store both versions** during compilation
2. **Provide option** like `UseCompiled -> True|False`
3. **Default to compiled** for numeric inputs
4. **Fallback to symbolic** for debugging or when needed

Example integration:
```wolfram
Options[evaluateModel] = {
  UseCompiled -> True,
  (* other options *)
};

evaluateModel[params_Association, opts:OptionsPattern[]] := Module[
  {compiled, uncompiled, useCompiled},
  useCompiled = OptionValue[UseCompiled];
  compiled = model["CompiledFunction"];
  uncompiled = model["SymbolicFunction"];  (* or compiled[[7]] *)

  If[TrueQ[useCompiled],
    compiled @@ Values[params],
    uncompiled @@ Values[params]
  ]
]
```

## References

- [Compile documentation](https://reference.wolfram.com/language/ref/Compile.html)
- [CompiledFunction](https://reference.wolfram.com/language/ref/CompiledFunction.html)
- [FunctionCompile](https://reference.wolfram.com/language/ref/FunctionCompile.html)
- [RuntimeOptions](https://reference.wolfram.com/language/Compile/ref/RuntimeOptions.html)
