# LongRunRisk Messages — One Table per Symbol

_Derived mechanically from `LongRunRisk_MessageCatalog.md`. Only messages that appeared as explicit bullet entries (`symbol::tag`) are included here._


## Symbol `Esc`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `Esg`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `Esp`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `Esx`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `TeXToModel`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | "Association of LaTeX strings for parameters of the model and the name of the corresponding Mathematica variable" |

## Symbol `addCoeffsSolution`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `badextrainfo` | Closed-form coefficients from extra info did not validate; falling back to all-numerical solve. |

## Symbol `addCoeffsSolutionN`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `addCoeffsSolutionN[model]` computes numerical solutions for all coefficient types (`wc`, `pd`, `bond`, `nombond`) using default parameters and model `extraInfo`. |

## Symbol `bindUnary`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `bindUnary[kernel, paramValues]` specializes the compiled kernel with numeric parameters, returning a pair of functions {f, df}. |
| `FernandoDuarte\` | `toofewsigns` | Expected at least \`1\` sign values, but got \`2\`. |
| `FernandoDuarte\` | `toomanysigns` | Expected exactly \`1\` sign values, but got \`2\`. |

## Symbol `bondeq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `bondeq[t, m]` gives the log price of a real `m`‑month maturity discount (zero-coupon) riskless bond at time `t`. |

## Symbol `bondexcreteq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `bondfweq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `bondfwspreadeq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `bondreteq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `bondyieldeq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `bondyieldeq[t, m]` gives the log yield of a real `m`‑month maturity discount (zero-coupon) riskless bond at time `t`. |

## Symbol `buildEqMapFromModel`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `buildEqMapFromModel[model]` extracts the equation map from a processed model for use in compilation and hash validation. |

## Symbol `buildKernel`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `buildKernel[expr, vars, params]` compiles expr into a kernel optimized for root-finding. |
| `FernandoDuarte\` | `badvars` | Expression contains coefficient variables not listed in vars. |
| `FernandoDuarte\` | `unusedvars` | Some vars were not found in the expression: \`1\`. |
| `FernandoDuarte\` | `badcompilemode` | Invalid CompileMode \`1\`. Expected "Both", "FunctionOnly", or "JacobianOnly". |

## Symbol `buildModels`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `checkpoint` | _text in main catalog_ |
| `FernandoDuarte\` | `compiling` | _text in main catalog_ |
| `FernandoDuarte\` | `done` | _text in main catalog_ |
| `FernandoDuarte\` | `kernels` | _text in main catalog_ |
| `FernandoDuarte\` | `kernelwarmup` | _text in main catalog_ |
| `FernandoDuarte\` | `modeluptodate` | _text in main catalog_ |
| `FernandoDuarte\` | `moments` | _text in main catalog_ |
| `FernandoDuarte\` | `momentscache` | _text in main catalog_ |
| `FernandoDuarte\` | `momentscomputing` | _text in main catalog_ |
| `FernandoDuarte\` | `nocat` | _text in main catalog_ |
| `FernandoDuarte\` | `noroot` | _text in main catalog_ |
| `FernandoDuarte\` | `numerical` | _text in main catalog_ |
| `FernandoDuarte\` | `processing` | _text in main catalog_ |
| `FernandoDuarte\` | `skipped` | _text in main catalog_ |
| `FernandoDuarte\` | `stage` | _text in main catalog_ |
| `FernandoDuarte\` | `start` | _text in main catalog_ |
| `FernandoDuarte\` | `uptodate` | _text in main catalog_ |
| `FernandoDuarte\` | `usage` | `buildModels[]` processes enabled models, compiles functions, computes numerical solutions, and creates moments database. |

## Symbol `buildModelsParallel`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `done` | _text in main catalog_ |
| `FernandoDuarte\` | `launching` | _text in main catalog_ |
| `FernandoDuarte\` | `merging` | _text in main catalog_ |
| `FernandoDuarte\` | `moments` | _text in main catalog_ |
| `FernandoDuarte\` | `parallel` | _text in main catalog_ |
| `FernandoDuarte\` | `usage` | `buildModelsParallel[models]` runs Symbolic+Compile+Numerical phases in parallel across models, then optionally runs Moments sequentially. `models` is a list of shortnames like `{"BY", "NRC", "DES"}`. Options include `"CreateMoments"` (default True) and `"NumKernels"` (default Automatic). |

## Symbol `checkCatalogChanges`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `changed` | _text in main catalog_ |
| `FernandoDuarte\` | `newmodels` | _text in main catalog_ |
| `FernandoDuarte\` | `nocat` | _text in main catalog_ |
| `FernandoDuarte\` | `nomanifest` | _text in main catalog_ |
| `FernandoDuarte\` | `noroot` | _text in main catalog_ |
| `FernandoDuarte\` | `removed` | _text in main catalog_ |
| `FernandoDuarte\` | `usage` | `checkCatalogChanges[]` compares the current Catalog to the saved manifest and reports which models have changed. `checkCatalogChanges[modelsAssoc]` compares the given models association against the saved manifest, validates changes, but does not reformat. |

## Symbol `checks`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `norm` | The norm of the residuals (errors) is \`1\`. |
| `FernandoDuarte\` | `largeresid` | The norm of the residuals (errors) is \`1\`, which is larger than the specified tolerance \`2\`. |
| `FernandoDuarte\` | `smallresid` | The norm of the residuals (errors) is \`1\`, which is smaller than the specified tolerance \`2\`. |

## Symbol `corr`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `corr[x, y, s, model]` gives the correlation of `x` and `y` conditional on time `s` for `model`. |

## Symbol `cov`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `cov[x, y, s, model]` gives the covariance of `x` and `y` conditional on time `s` for `model`. |

## Symbol `covLongToUncondCov`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `badindexcount` | The number of indices provided in \`1\` must be equal to the number of variables in \`2\` plus the number of stock-related variables in \`2\` that require a stock identifier. |

## Symbol `createCompiledEq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `createCompiledEq[model, dir]` compiles model equations to dir/{shortname}.mx. Returns file path on success. |
| `FernandoDuarte\` | `cachehit` | cache hit for model \`1\`; skipping compilation. |
| `FernandoDuarte\` | `compiling` | compiling model \`1\`; this may take a long time. |

## Symbol `createDatabase`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `createDatabase[model_Association, covLongFilename_String]` computes moments for `model`, memoizes the results, and stores them in `covLongFilename`. |
| `FernandoDuarte\` | `done` | Finished computing moments for \`1\`. |

## Symbol `createSystem`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `nomom` | Unconditional moments cannot be computed for state variables... |

## Symbol `dceq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `dceq[t]` gives the exogenous dynamics of real consumption growth. |

## Symbol `ddeq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `ddeq[t, i]` gives the exogenous dynamics of real dividend growth for stock `i`. |

## Symbol `delta`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `eps`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | Exogenous shocks. |

## Symbol `eulereq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `eulereq[x[t], s, model]` or `eulereq[x[t,i], s, model]` give the Euler equation for an asset with real return `x[t]` or `x[t, i]` conditional on time `s` for `model`. |

## Symbol `ev`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `ev[x, s, model]` gives the expected value of `x` conditional on time `s` for `model`. |

## Symbol `expandPatternAssumptions`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `expandPatternAssumptions[expr, patterns]` expands assumptions containing patterns into explicit form. |

## Symbol `extractIntervalsFromReduce`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `extractIntervalsFromReduce[reduceExpr, rootVar]` converts a Reduce expression into a list of numeric intervals. |
| `FernandoDuarte\` | `nointervals` | Could not extract any valid intervals from reduced expression \`1\`. |

## Symbol `excretceq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `excretceq[t]` gives the return for the asset that pays consumption as dividends each period in excess of the risk-free rate. |

## Symbol `excreteq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `excreteq[t, i]` gives the return for stock `i` in excess of the risk-free rate. |

## Symbol `flattenCoeffs`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `flattenCoeffs[updateCoeffsResult]` extracts all coefficient rules from the hierarchical structure returned by `updateCoeffs`. `flattenCoeffs[result, n]` extracts rules from the `n`‑th A solution only. `flattenCoeffs[result, n, j]` extracts A rules and B rules for stock `j` from the `n`‑th A solution. `flattenCoeffs[result, n, j, m]` extracts A rules and the `m`‑th B solution for stock `j` from the `n`‑th A solution. |

## Symbol `flattenCoeffsBundles`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `flattenCoeffsBundles[updateCoeffsResult]` returns a list of complete solution bundles. Each bundle is a flat list of rules (A + one B per stock + Bond + NomBond) ready to apply with `/.` (ReplaceAll). Generates Cartesian product: if stock 1 has 2 B solutions and stock 2 has 3, returns 6 bundles. `flattenCoeffsBundles[result, n]` returns bundles for the `n`‑th A solution only. |

## Symbol `fastRoot`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `fastRoot[f, spec, opts]` finds a root using a hybrid Newton/Brent/Secant strategy. |
| `FernandoDuarte\` | `noconverge` | Failed to converge within \`1\` iterations starting from x0=\`2\` in bounds [\`3\`, \`4\`]. |
| `FernandoDuarte\` | `nonnumeric` | Function returned non-numeric value \`1\` at x=\`2\`. |
| `FernandoDuarte\` | `nobounds` | No bounds specified and FindRoot failed from x0=\`1\`. |
| `FernandoDuarte\` | `badbounds` | Invalid bounds: lower bound \`1\` must be less than upper bound \`2\`. |
| `FernandoDuarte\` | `badspec` | Invalid spec format \`1\`. Expected scalar, {lo, hi}, {x0, lo, hi}, or nested list. |
| `FernandoDuarte\` | `compiled` | Function is a CompiledCodeFunction; Newton+Jacobian unavailable, using fallback. |
| `FernandoDuarte\` | `baddim` | Inconsistent dimensions in spec: \`1\`. |
| `FernandoDuarte\` | `noautox0` | Cannot compute automatic starting point without bounds. |

## Symbol `findBondRecursion`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `findBondRecursion[t, n, model]` finds the recursions satisfied by the coefficients in front of the state variables for a bond price with maturity `n` at time `t` for `model`. |

## Symbol `findEulerEqConstants`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `findEulerEqConstants[x[t], model]` or `findEulerEqConstants[x[t,i], model]` gives a system of equations whose unknowns are the coefficients in front of the state variables for the wealth-consumption or price-dividend ratios. |

## Symbol `findRootInterval`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `findRootInterval[conds, paramValues]` returns a Reduce expression constraining the root variable. |
| `FernandoDuarte\` | `emptyinterval` | There are no real solutions for \`1\`. Try changing signs \`2\` or parameters. |
| `FernandoDuarte\` | `nocoeff` | Could not locate a root variable for coefficient head \`1\` in the conditions. |

## Symbol `formatModels`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `formatModels[models]` re‑writes an association of models as a `Cell` object with nice formatting that can be directly pasted into a notebook. Additional inline documentation describes creating a notebook and writing formatted cells. |

## Symbol `gamma`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `growth`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `growth[variable, t]` gives the growth rate at time `t` of `variable`. `growth[variable, t, i]` specifies the stock identifier `i` when `variable` is a stock-related variable such as dividends. `growth[variable, t, m]` specifies the maturity `m` in months when `variable` is a bond-related variable such as bond yields. |

## Symbol `Info`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `Info[models]` displays a table with information for each model in the association `models`. (Re-exported from `info` with capitalized name.) |

## Symbol `info`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `info[models]` displays a table with information for each model in the association `models`. |

## Symbol `kappa0eq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `kappa0eq[mu]` is the Campbell–Shiller approximation constant `kappa0 = -Log[Exp[mu] - 1] + Ewc * Exp[mu]/(Exp[mu] - 1)` where `mu` is the unconditional mean of the log of the approximated variable. |

## Symbol `kappa1eq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `kappa1eq[mu]` is the Campbell–Shiller approximation constant `kappa1 = Exp[mu]/(Exp[mu] - 1)` where `mu` is the unconditional mean of the log of the approximated variable. |

## Symbol `lagStateVarst`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `timeout` | lagStateVarst timed out after \`1\` seconds. The toStateVars rules may cause infinite recursion. |
| `FernandoDuarte\` | `maxiter` | lagStateVarst exceeded \`1\` iterations without convergence. |

## Symbol `loadModelKernels`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `nofile` | "Kernel file not found for model `1`. Expected: `2`" |
| `FernandoDuarte\` | `systemidmismatch` | "Kernel was compiled on `1` but current system is `2`. Recompile may be needed." |

## Symbol `modelEval`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `modelEval[expr, model]` evaluates moments in `expr` using `model`. Example text (abridged) shows mapping of `uncondE`, `uncondCov`, `cov`, etc. into model‑based versions. |

## Symbol `modelFormattingTemplate`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `modelFormattingTemplate[model]` re‑writes `model` as a `Cell` object with nice formatting. Additional inline instructions describe how to write all models from `Kernel/Model/Catalog.wl` into a notebook using this template. |

## Symbol `modelToTeX`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | "Association between the Mathematica variables that represent parameters of the model and their LaTeX representation" |

## Symbol `models`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | Association with the definition and properties of models. |

## Symbol `modelsExtraInfo`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | Additional optional information about model solution, constraints, initial guesses for numerical solvers. |

## Symbol `muc`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `mud`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `mup`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `mupbar`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `nombondeq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `nombondeq[t, m]` gives the log price of a nominal `m`‑month maturity discount (zero-coupon) riskless bond at time `t`. |

## Symbol `nombondexcreteq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `nombondexcreteq[t, m]` gives the log holding period excess return from buying a nominal `m`‑month maturity discount (zero-coupon) riskless bond at time `t - 1` and selling it as an (`m - 1`)‑month maturity riskless bond at time `t`, in excess of the one-period nominal risk-free rate. |

## Symbol `nombondfweq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `nombondfwspreadeq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `nombondreteq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `nombondyieldeq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `nombondyieldeq[t, m]` gives the log yield of a nominal `m`‑month maturity discount (zero-coupon) riskless bond at time `t`. |

## Symbol `niceEulerEq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `timevars` | Time-dependent variables \`1\` found in Euler equation coefficients. |
| `FernandoDuarte\` | `statevars` | Solution not found: state variables \`1\` found in Euler equation coefficients. Consider including additional or different state variables for model \`2\` in `Kernel/Model/Catalog.wl`. |

## Symbol `nomeulereq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `nomeulereq[x[t], s, model]` or `nomeulereq[x[t,i], s, model]` give the Euler equation for an asset with nominal return `x[t]` or `x[t, i]` conditional on time `s` for `model`. |

## Symbol `nomrfeq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `nomrfeq[t]` gives the one-period nominal risk-free rate at time `t` for loans between `t` and `t + 1`. |

## Symbol `nomsdfeq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `nomsdfeq[t]` gives the nominal stochastic discount factor at time `t`. |

## Symbol `normalizeRootSigns`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `badsignidx` | "signIndex must be an Association with \"wc\"/\"pd\" keys; got `1` instead." |

## Symbol `paramQuadSolve`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `paramQuadSolve[eqns, vars]` solves a system of polynomial equations, finding solutions for quadratic coefficients appearing in long-run risk models. |
| `FernandoDuarte\` | `badmethod` | Method -> \`1\` is not supported. Use Automatic, "Sequential", or "SequentialWithGroebner". |
| `FernandoDuarte\` | `badorder` | MonomialOrder -> \`1\` is not supported by GroebnerBasis. |
| `FernandoDuarte\` | `noquad` | No quadratic variables detected in the given system; OnlyQuadTerms cannot be applied. |
| `FernandoDuarte\` | `nocover` | Unable to select a square subsystem covering the quadratic variables. |
| `FernandoDuarte\` | `emptyvar` | Variables list cannot be empty. |
| `FernandoDuarte\` | `emptyeq` | Equations list cannot be empty. |
| `FernandoDuarte\` | `solvefail` | Solver failed or timed out. |

## Symbol `pdeq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `pdeq[t, i]` gives the log price-dividend ratio of stock `i` at time `t`. |

## Symbol `phic`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phicc`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phicp`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phicpc`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phicpp`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phics`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phicsp`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phicx`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phidc`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phidcc`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phidcd`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phidp`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phidpc`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phidpd`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phidpp`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phids`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phidsp`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phidxc`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phidxd`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phig`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phip`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phipbarc`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phipbarcx`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phipbarp`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phipbarpb`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phipbarx`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phipbarxb`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phipbarxp`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phipc`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phipcx`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phipp`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phipx`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phipxp`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phiscv`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phispw`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phisxs`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phix`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `phixc`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `pibareq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `pibareq[t]` gives the exogenous dynamics of expected inflation. |

## Symbol `pieq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `pieq[t]` gives the exogenous dynamics of inflation. |

## Symbol `plotCoeffs`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `plotCoeffs[model_Association, sol_List, parameters_List, Ewc0_List, opts]` plots the steps that `FindRoot` takes to solve for `A[0]` in the coefficient system. Forwards options to the underlying `FindRootPlot` resource function. |

## Symbol `PlotCoeffs`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `PlotCoeffs[model_Association, sol_List, parameters_List, Ewc0_List, opts]` plots the steps that `FindRoot` takes to solve for `A[0]`. (Re-exported from `plotCoeffs` with capitalized name.) |

## Symbol `processNewParameters`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `param` | `theta` must equal `(1-gamma)/(1-1/psi)`, replacing `theta` by `(1-gamma)/(1-1/psi)=`1`." |
| `FernandoDuarte\` | `psi` | `psi=1` implies a constant wealth-consumption ratio, please choose a different `psi`. |
| `FernandoDuarte\` | `subsetparam` | "Parameters `1` in `newParameters` are not a subset of `parameters`." |
| `FernandoDuarte\` | `theta` | "Please provide `psi` or `gamma` with `theta`." |
| `FernandoDuarte\` | `usage` | `processNewParameters[newParameters, parameters]` returns a validated list of rules to substitute. |

## Symbol `processModels`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `processModels[modelsCatalog]` performs symbolic processing on models, adding coefficient systems and solutions. |
| `FernandoDuarte\` | `progress` | Finished \`1\`. |

## Symbol `psi`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `reformatCatalog`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `convfail` | _text in main catalog_ |
| `FernandoDuarte\` | `nocat` | _text in main catalog_ |
| `FernandoDuarte\` | `noroot` | _text in main catalog_ |
| `FernandoDuarte\` | `success` | _text in main catalog_ |
| `FernandoDuarte\` | `usage` | `reformatCatalog[]` reformats the models section of `Catalog.wl` using standard formatting, preserving `modelsExtraInfo` unchanged. |

## Symbol `retceq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `retceq[t]` gives the return for the asset that pays consumption as dividends each period. |

## Symbol `reteq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `reteq[t, i]` gives the return for stock `i`. Stock `i` is defined as the asset that pays dividends `ddeq[i]`. |

## Symbol `rfeq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `rfeq[t]` gives the one-period real risk-free rate at time `t` for loans between `t` and `t + 1`. |

## Symbol `rhocp`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `rhocpbar`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `rhocx`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `rhodp`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `rhodx`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `rhog`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `rhogp`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `rhogpbar`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `rhop`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `rhopbar`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `rhopbarx`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `rhoppbar`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `rhox`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `rhoxpbar`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `rulesE`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `rulesE[t]` defines the distribution of exogenous shocks by giving replacement rules that compute the unconditional expectation of products of powers of exogenous shocks. |

## Symbol `scanAndSolve`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `scanAndSolve[f, {min, max}]` finds roots of f[x] in the range by grid subdivision. |

## Symbol `sceq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `sceq[t]` gives the exogenous dynamics of stochastic volatility of real consumption growth. |

## Symbol `sdfeq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `sdfeq[t]` gives the (real) stochastic discount factor at time `t`. |

## Symbol `seqfun`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `seqfun` | Sequence function not found for uncondCov[\`1\`[t], \`2\`[t+\`3\`]]. |

## Symbol `sgeq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `sgeq[t]` gives the exogenous dynamics of the nominal-real covariance (NRC). |

## Symbol `speq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `speq[t]` gives the exogenous dynamics of long-run risk stochastic volatility of inflation. |

## Symbol `sxeq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `sxeq[t]` gives the exogenous dynamics of stochastic volatility of long-run risk. |

## Symbol `t`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `t` denotes time. |

## Symbol `taugd`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `theta`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `toCatalog`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `toCatalog[models, {key_1, key_2, ...}]` re‑writes an association of models so that each model contains only the elements with keys `key_i` and, if `key_i` is `"stateVars"` and has head `Function`, replaces its value by `val_i[t]`. |

## Symbol `toEquation`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `toEquation[model]` gives a pure function that re‑writes its argument in terms of lagged exogenous variables and shocks of `model`. `toEquation[expr, model]` re‑writes `expr` in terms of lagged exogenous variables and shocks of `model`. |

## Symbol `toExogenousVars`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `toExogenousVars[model]` gives a pure function that re‑writes its argument in terms of the exogenous variables of `model`. `toExogenousVars[expr, model]` re‑writes its first argument in terms of the exogenous variables of `model`. |

## Symbol `toNum`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `toNum[model]` gives a pure (or "anonymous") function that evaluates its argument numerically using the solution to `model`. `toNum[expr, model]` evaluates `expr` numerically using the solution to `model`. `toNum["Rules", model]` gives substitution rules that can be used to evaluate expressions numerically. `toNum[..., parameters]` uses the parameters provided in the list of rules `parameters`. `toNum[..., parameters, initialGuess]` provides an initial estimate for the solution of the model. |

## Symbol `toStateVars`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `toStateVars[model]` gives a pure function that re‑writes its argument in terms of the state variables of `model`. `toStateVars[expr, model]` re‑writes its first argument in terms of the state variables of `model`. |

## Symbol `UncondCorr`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `UncondCorr[expr1, expr2, model]` gives the unconditional correlation of `expr1` and `expr2` for `model`. (Re-exported from `uncondCorr` with capitalized name.) |

## Symbol `uncondCorr`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `uncondCorr[expr1, expr2, model]` gives the unconditional correlation of `expr1` and `expr2` for `model`. |

## Symbol `UncondCov`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `UncondCov[expr1, expr2, model]` gives the unconditional covariance of `expr1` and `expr2` for `model`. (Re-exported from `uncondCov` with capitalized name.) |

## Symbol `uncondCov`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `uncondCov[expr1, expr2, model]` gives the unconditional covariance of `expr1` and `expr2` for `model`. |

## Symbol `uncondCovLongExo`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `uncondCovLongExo[toExogenous, expression1, expression2]` computes the unconditional covariance of `expression1` and `expression2` using `toExogenous` to map endogenous variables to exogenous variables, and the default covariance function `covLong` to compute covariances of exogenous variables. `uncondCovLongExo[toExogenous, expression1, expression2, covfun]` computes the unconditional covariance using the covariance function `covfun`. |

## Symbol `uncondE`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `uncondE[expr, model]` gives the unconditional expectation of `expr` for `model`. |
| `FernandoDuarte\` | `nmom` | Moment(s) \`1\` not computed. Try increasing `maxMoment` or `maxCrossMoment` in `llr.wl`. |

## Symbol `UncondVar`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `UncondVar[expr, model]` gives the unconditional variance of `expr` for `model`. (Re-exported from `uncondVar` with capitalized name.) |

## Symbol `uncondVar`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `uncondVar[expr, model]` gives the unconditional variance of `expr` for `model`. |

## Symbol `uncondVarLongExo`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `uncondVarLongExo[toExogenous, expression]` computes the unconditional variance of `expression` using `toExogenous` to map endogenous variables to exogenous variables, and the default covariance function `covLong` to compute covariances of exogenous variables. `uncondVarLongExo[toExogenous, expression, covfun]` uses the covariance function `covfun`. |

## Symbol `updateCoeffs`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `updateCoeffs[model]` solves for the coefficients of the wealth-consumption ratio, price-dividend ratio, real bonds, and nominal bonds. Returns a hierarchical structure: list of A solutions, each containing: – `IntervalA`, `SignsA`, `SolutionIndexA`, `IntervalIndexA`: metadata – `A`: coefficient rules for wealth-consumption ratio – `Stocks`: association of stock `j` → list of B solutions, each with `IntervalB`, `SignsB`, `B` – `Bond`, `NomBond`: bond coefficient rules (if computed) Use `flattenCoeffs[result]` to extract all coefficient rules as a flat list. |

## Symbol `updateCoeffsSol`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `badkernelstructure` | savedKernels must contain a "kernels" key with "A" and "B" sub-keys. Got: \`1\`. |

## Symbol `updateModelManifest`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `nocat` | _text in main catalog_ |
| `FernandoDuarte\` | `noroot` | _text in main catalog_ |
| `FernandoDuarte\` | `usage` | `updateModelManifest[]` generates and saves the `ModelManifest.wl` file. `updateModelManifest[modelsAssoc]` computes manifest data from the given models association without writing to disk. |
| `FernandoDuarte\` | `versionmismatch` | "PacletInfo.wl version `1` differs from installed paclet version `2`; using PacletInfo.wl version." |

## Symbol `validateCatalog`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `validateCatalog[catalog]` validates all models in a catalog `Association`. Returns a `CatalogValidationResult`. |

## Symbol `validateModel`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `badAssumption` | `Model "`1`": Parameter `2` = `3` violates assumption `4`.` |
| `FernandoDuarte\` | `badIndexedParam` | `Model "`1`": Indexed parameter `2` is not a valid dividend growth parameter. Valid dividend growth parameters: `3`.` |
| `FernandoDuarte\` | `badParam` | `Model "`1`": Parameter `2` has non-numeric value `3`.` |
| `FernandoDuarte\` | `badParamName` | `Model "`1`": Invalid parameter name `2`.` |
| `FernandoDuarte\` | `badStateVar` | `Model "`1`": Invalid state variable `2`. Expected expression with [t] dependency.` |
| `FernandoDuarte\` | `badStateVarSymbol` | `Model "`1`": State variable `2` contains invalid symbol(s): `3`.` |
| `FernandoDuarte\` | `duplicateParam` | `Model "`1`": Duplicate parameter `2`.` |
| `FernandoDuarte\` | `extraParam` | `Model "`1`": Extra parameter(s) not in $parameters: `2`. Valid parameters: `3`.` |
| `FernandoDuarte\` | `indexGap` | `Model "`1`": Stock indices are not sequential starting from 1. Found indices: `2`.` |
| `FernandoDuarte\` | `indexNotPositive` | `Model "`1`": Parameter `2` has non-positive index.` |
| `FernandoDuarte\` | `missingKey` | `Model "`1`": Missing required key "`2`".` |
| `FernandoDuarte\` | `missingParam` | `Model "`1`": Missing parameter(s) from $parameters: `2`. Valid parameters: `3`.` |
| `FernandoDuarte\` | `missingStockParam` | `Model "`1`": Stock `2` is incomplete. Missing: `3`.` |
| `FernandoDuarte\` | `notRule` | `Model "`1`": Parameter entry `2` is not a Rule.` |
| `FernandoDuarte\` | `usage` | `validateModel[model]` validates a single model `Association` against the schema. Returns a `ValidationResult` association. |
| `FernandoDuarte\` | `wrongType` | `Model "`1`": Key "`2`" expected `3`, got `4`.` |

## Symbol `var`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `var[x, s, model]` gives the variance of `x` conditional on time `s` for `model`. |

## Symbol `vc`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `visualizeCoeffs`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `visualizeCoeffs[updateCoeffsResult]` displays a coefficient-centric comparison view. Shows `A[0]` and `B[j][0]` values across all solution bundles for easy comparison. Includes an interactive selector to compare any coefficient across bundles. Options: • `"ShowSelector" -> True` — show interactive coefficient selector • `"ShowDetails" -> True` — show collapsible bundle details |

## Symbol `vp`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `vpp`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `vppbar`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `vx`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `wceq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `wceq[t]` gives the log wealth-consumption ratio at time `t`. |

## Symbol `xeq`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `xeq[t]` gives the exogenous dynamics of long-run risk. |

## Symbol `xic`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `xid`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `xip`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | _text in main catalog_ |

## Symbol `yieldCurve`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `yieldCurve[model, newParameters, coeffsWc, bondType, opts]` plots the yield curve implied by `model`. `bondType` selects real vs nominal bonds and `opts` are forwarded to coefficient solvers and `FindRoot`/`RecurrenceTable` as appropriate. |

## Symbol `YieldCurve`

| Context | Tag | Message text |
| --- | --- | --- |
| `FernandoDuarte\` | `usage` | `YieldCurve[model, newParameters, coeffsWc, bondType, opts]` plots the yield curve implied by `model`. (Re-exported from `yieldCurve` with capitalized name.) |