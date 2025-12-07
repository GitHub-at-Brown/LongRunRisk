# LongRunRisk Messages by Wolfram Language Context

_Derived mechanically from `LongRunRisk_MessageCatalog.md`. Only messages that appeared as explicit bullet entries (`symbol::tag`) are included here._


## Context `FernandoDuarte\`

### Symbol `Esc`

- `Esc::usage` — _[text in main catalog]_
### Symbol `Info`

- `Info::usage` — _[text in main catalog]_
### Symbol `Esg`

- `Esg::usage` — _[text in main catalog]_
### Symbol `Esp`

- `Esp::usage` — _[text in main catalog]_
### Symbol `Esx`

- `Esx::usage` — _[text in main catalog]_
### Symbol `UncondCorr`

- `UncondCorr::usage` — _[text in main catalog]_

### Symbol `UncondCov`

- `UncondCov::usage` — _[text in main catalog]_

### Symbol `UncondVar`

- `UncondVar::usage` — _[text in main catalog]_

### Symbol `YieldCurve`

- `YieldCurve::usage` — _[text in main catalog]_

### Symbol `PlotCoeffs`

- `PlotCoeffs::usage` — _[text in main catalog]_
### Symbol `TeXToModel`

- `TeXToModel::usage` — "Association of LaTeX strings for parameters of the model and the name of the corresponding Mathematica variable"
### Symbol `addCoeffsSolution`

- `addCoeffsSolution::badextrainfo` — Closed-form coefficients from extra info did not validate; falling back to all-numerical solve.

### Symbol `addCoeffsSolutionN`

- `addCoeffsSolutionN::usage` — `addCoeffsSolutionN[model]` computes numerical solutions for all coefficient types (`wc`, `pd`, `bond`, `nombond`) using default parameters and model `extraInfo`.

### Symbol `bindUnary`

- `bindUnary::usage` — `bindUnary[kernel, paramValues]` specializes the compiled kernel with numeric parameters, returning a pair of functions {f, df}.
- `bindUnary::toofewsigns` — Expected at least \`1\` sign values, but got \`2\`.
- `bindUnary::toomanysigns` — Expected exactly \`1\` sign values, but got \`2\`.

### Symbol `bondeq`

- `bondeq::usage` — `bondeq[t, m]` gives the log price of a real `m`‑month maturity discount (zero-coupon) riskless bond at time `t`.
### Symbol `bondexcreteq`

- `bondexcreteq::usage` — _[text in main catalog]_
### Symbol `bondfweq`

- `bondfweq::usage` — _[text in main catalog]_
### Symbol `bondfwspreadeq`

- `bondfwspreadeq::usage` — _[text in main catalog]_
### Symbol `bondreteq`

- `bondreteq::usage` — _[text in main catalog]_
### Symbol `bondyieldeq`

- `bondyieldeq::usage` — `bondyieldeq[t, m]` gives the log yield of a real `m`‑month maturity discount (zero-coupon) riskless bond at time `t`.
### Symbol `buildEqMapFromModel`

- `buildEqMapFromModel::usage` — `buildEqMapFromModel[model]` extracts the equation map from a processed model for use in compilation and hash validation.

### Symbol `buildKernel`

- `buildKernel::usage` — `buildKernel[expr, vars, params]` compiles expr into a kernel optimized for root-finding.
- `buildKernel::badvars` — Expression contains coefficient variables not listed in vars.
- `buildKernel::unusedvars` — Some vars were not found in the expression: \`1\`.
- `buildKernel::badcompilemode` — Invalid CompileMode \`1\`. Expected "Both", "FunctionOnly", or "JacobianOnly".

### Symbol `buildModels`

- `buildModels::checkpoint` — _[text in main catalog]_
- `buildModels::compiling` — _[text in main catalog]_
- `buildModels::done` — _[text in main catalog]_
- `buildModels::kernels` — _[text in main catalog]_
- `buildModels::kernelwarmup` — _[text in main catalog]_
- `buildModels::modeluptodate` — _[text in main catalog]_
- `buildModels::moments` — _[text in main catalog]_
- `buildModels::momentscache` — _[text in main catalog]_
- `buildModels::momentscomputing` — _[text in main catalog]_
- `buildModels::nocat` — _[text in main catalog]_
- `buildModels::noroot` — _[text in main catalog]_
- `buildModels::numerical` — _[text in main catalog]_
- `buildModels::processing` — _[text in main catalog]_
- `buildModels::skipped` — _[text in main catalog]_
- `buildModels::stage` — _[text in main catalog]_
- `buildModels::start` — _[text in main catalog]_
- `buildModels::uptodate` — _[text in main catalog]_
- `buildModels::usage` — `buildModels[]` processes enabled models, compiles functions, computes numerical solutions, and creates moments database.
### Symbol `buildModelsParallel`

- `buildModelsParallel::done` — _[text in main catalog]_
- `buildModelsParallel::launching` — _[text in main catalog]_
- `buildModelsParallel::merging` — _[text in main catalog]_
- `buildModelsParallel::moments` — _[text in main catalog]_
- `buildModelsParallel::parallel` — _[text in main catalog]_
- `buildModelsParallel::usage` — `buildModelsParallel[models]` runs Symbolic+Compile+Numerical phases in parallel across models, then optionally runs Moments sequentially. `models` is a list of shortnames like `{"BY", "NRC", "DES"}`. Options include `"CreateMoments"` (default True) and `"NumKernels"` (default Automatic).
### Symbol `checks`

- `checks::norm` — The norm of the residuals (errors) is \`1\`.
- `checks::largeresid` — The norm of the residuals (errors) is \`1\`, which is larger than the specified tolerance \`2\`.
- `checks::smallresid` — The norm of the residuals (errors) is \`1\`, which is smaller than the specified tolerance \`2\`.

### Symbol `checkCatalogChanges`

- `checkCatalogChanges::changed` — _[text in main catalog]_
- `checkCatalogChanges::newmodels` — _[text in main catalog]_
- `checkCatalogChanges::nocat` — _[text in main catalog]_
- `checkCatalogChanges::nomanifest` — _[text in main catalog]_
- `checkCatalogChanges::noroot` — _[text in main catalog]_
- `checkCatalogChanges::removed` — _[text in main catalog]_
- `checkCatalogChanges::usage` — `checkCatalogChanges[]` compares the current Catalog to the saved manifest and reports which models have changed. `checkCatalogChanges[modelsAssoc]` compares the given models association against the saved manifest, validates changes, but does not reformat.
### Symbol `corr`

- `corr::usage` — `corr[x, y, s, model]` gives the correlation of `x` and `y` conditional on time `s` for `model`.

### Symbol `cov`

- `cov::usage` — `cov[x, y, s, model]` gives the covariance of `x` and `y` conditional on time `s` for `model`.

### Symbol `covLongToUncondCov`

- `covLongToUncondCov::badindexcount` — The number of indices provided in \`1\` must be equal to the number of variables in \`2\` plus the number of stock-related variables in \`2\` that require a stock identifier.

### Symbol `createCompiledEq`

- `createCompiledEq::usage` — `createCompiledEq[model, dir]` compiles model equations to dir/{shortname}.mx. Returns file path on success.
- `createCompiledEq::cachehit` — cache hit for model \`1\`; skipping compilation.
- `createCompiledEq::compiling` — compiling model \`1\`; this may take a long time.

### Symbol `createDatabase`

- `createDatabase::usage` — `createDatabase[model_Association, covLongFilename_String]` computes moments for `model`, memoizes the results, and stores them in `covLongFilename`.
- `createDatabase::done` — Finished computing moments for \`1\`.

### Symbol `createSystem`

- `createSystem::nomom` — Unconditional moments cannot be computed for state variables...
### Symbol `dceq`

- `dceq::usage` — `dceq[t]` gives the exogenous dynamics of real consumption growth.
### Symbol `ddeq`

- `ddeq::usage` — `ddeq[t, i]` gives the exogenous dynamics of real dividend growth for stock `i`.
### Symbol `delta`

- `delta::usage` — _[text in main catalog]_
### Symbol `eps`

- `eps::usage` — Exogenous shocks.

### Symbol `eulereq`

- `eulereq::usage` — `eulereq[x[t], s, model]` or `eulereq[x[t,i], s, model]` give the Euler equation for an asset with real return `x[t]` or `x[t, i]` conditional on time `s` for `model`.

### Symbol `niceEulerEq`

- `niceEulerEq::timevars` — Time-dependent variables \`1\` found in Euler equation coefficients.
- `niceEulerEq::statevars` — Solution not found: state variables \`1\` found in Euler equation coefficients. Consider including additional or different state variables for model \`2\` in `Kernel/Model/Catalog.wl`.

### Symbol `ev`

- `ev::usage` — `ev[x, s, model]` gives the expected value of `x` conditional on time `s` for `model`.

### Symbol `expandPatternAssumptions`

- `expandPatternAssumptions::usage` — `expandPatternAssumptions[expr, patterns]` expands assumptions containing patterns into explicit form.

### Symbol `extractIntervalsFromReduce`

- `extractIntervalsFromReduce::usage` — `extractIntervalsFromReduce[reduceExpr, rootVar]` converts a Reduce expression into a list of numeric intervals.
- `extractIntervalsFromReduce::nointervals` — Could not extract any valid intervals from reduced expression \`1\`.
### Symbol `excretceq`

- `excretceq::usage` — `excretceq[t]` gives the return for the asset that pays consumption as dividends each period in excess of the risk-free rate.
### Symbol `excreteq`

- `excreteq::usage` — `excreteq[t, i]` gives the return for stock `i` in excess of the risk-free rate.
### Symbol `flattenCoeffs`

- `flattenCoeffs::usage` — `flattenCoeffs[updateCoeffsResult]` extracts all coefficient rules from the hierarchical structure returned by `updateCoeffs`. `flattenCoeffs[result, n]` extracts rules from the `n`‑th A solution only. `flattenCoeffs[result, n, j]` extracts A rules and B rules for stock `j` from the `n`‑th A solution. `flattenCoeffs[result, n, j, m]` extracts A rules and the `m`‑th B solution for stock `j` from the `n`‑th A solution.
### Symbol `flattenCoeffsBundles`

- `flattenCoeffsBundles::usage` — `flattenCoeffsBundles[updateCoeffsResult]` returns a list of complete solution bundles. Each bundle is a flat list of rules (A + one B per stock + Bond + NomBond) ready to apply with `/.` (ReplaceAll). Generates Cartesian product: if stock 1 has 2 B solutions and stock 2 has 3, returns 6 bundles. `flattenCoeffsBundles[result, n]` returns bundles for the `n`‑th A solution only.
### Symbol `fastRoot`

- `fastRoot::usage` — `fastRoot[f, spec, opts]` finds a root using a hybrid Newton/Brent/Secant strategy.
- `fastRoot::noconverge` — Failed to converge within \`1\` iterations starting from x0=\`2\` in bounds [\`3\`, \`4\`].
- `fastRoot::nonnumeric` — Function returned non-numeric value \`1\` at x=\`2\`.
- `fastRoot::nobounds` — No bounds specified and FindRoot failed from x0=\`1\`.
- `fastRoot::badbounds` — Invalid bounds: lower bound \`1\` must be less than upper bound \`2\`.
- `fastRoot::badspec` — Invalid spec format \`1\`. Expected scalar, {lo, hi}, {x0, lo, hi}, or nested list.
- `fastRoot::compiled` — Function is a CompiledCodeFunction; Newton+Jacobian unavailable, using fallback.
- `fastRoot::baddim` — Inconsistent dimensions in spec: \`1\`.
- `fastRoot::noautox0` — Cannot compute automatic starting point without bounds.

### Symbol `findBondRecursion`

- `findBondRecursion::usage` — `findBondRecursion[t, n, model]` finds the recursions satisfied by the coefficients in front of the state variables for a bond price with maturity `n` at time `t` for `model`.

### Symbol `findEulerEqConstants`

- `findEulerEqConstants::usage` — `findEulerEqConstants[x[t], model]` or `findEulerEqConstants[x[t,i], model]` gives a system of equations whose unknowns are the coefficients in front of the state variables for the wealth-consumption or price-dividend ratios.

### Symbol `findRootInterval`

- `findRootInterval::usage` — `findRootInterval[conds, paramValues]` returns a Reduce expression constraining the root variable.
- `findRootInterval::emptyinterval` — There are no real solutions for \`1\`. Try changing signs \`2\` or parameters.
- `findRootInterval::nocoeff` — Could not locate a root variable for coefficient head \`1\` in the conditions.

### Symbol `formatModels`

- `formatModels::usage` — `formatModels[models]` re‑writes an association of models as a `Cell` object with nice formatting that can be directly pasted into a notebook. Additional inline documentation describes creating a notebook and writing formatted cells.
### Symbol `gamma`

- `gamma::usage` — _[text in main catalog]_
### Symbol `growth`

- `growth::usage` — `growth[variable, t]` gives the growth rate at time `t` of `variable`. `growth[variable, t, i]` specifies the stock identifier `i` when `variable` is a stock-related variable such as dividends. `growth[variable, t, m]` specifies the maturity `m` in months when `variable` is a bond-related variable such as bond yields.
### Symbol `info`

- `info::usage` — `info[models]` displays a table with information for each model in the association `models`.
### Symbol `kappa0eq`

- `kappa0eq::usage` — `kappa0eq[mu]` is the Campbell–Shiller approximation constant `kappa0 = -Log[Exp[mu] - 1] + Ewc * Exp[mu]/(Exp[mu] - 1)` where `mu` is the unconditional mean of the log of the approximated variable.
### Symbol `kappa1eq`

- `kappa1eq::usage` — `kappa1eq[mu]` is the Campbell–Shiller approximation constant `kappa1 = Exp[mu]/(Exp[mu] - 1)` where `mu` is the unconditional mean of the log of the approximated variable.

### Symbol `lagStateVarst`

- `lagStateVarst::timeout` — lagStateVarst timed out after \`1\` seconds. The toStateVars rules may cause infinite recursion.
- `lagStateVarst::maxiter` — lagStateVarst exceeded \`1\` iterations without convergence.

### Symbol `loadModelKernels`

- `loadModelKernels::nofile` — "Kernel file not found for model `1`. Expected: `2`"
- `loadModelKernels::systemidmismatch` — "Kernel was compiled on `1` but current system is `2`. Recompile may be needed."
### Symbol `modelEval`

- `modelEval::usage` — `modelEval[expr, model]` evaluates moments in `expr` using `model`. Example text (abridged) shows mapping of `uncondE`, `uncondCov`, `cov`, etc. into model‑based versions.
### Symbol `modelFormattingTemplate`

- `modelFormattingTemplate::usage` — `modelFormattingTemplate[model]` re‑writes `model` as a `Cell` object with nice formatting. Additional inline instructions describe how to write all models from `Kernel/Model/Catalog.wl` into a notebook using this template.
### Symbol `modelToTeX`

- `modelToTeX::usage` — "Association between the Mathematica variables that represent parameters of the model and their LaTeX representation"
### Symbol `models`

- `models::usage` — Association with the definition and properties of models.
### Symbol `modelsExtraInfo`

- `modelsExtraInfo::usage` — Additional optional information about model solution, constraints, initial guesses for numerical solvers.
### Symbol `muc`

- `muc::usage` — _[text in main catalog]_
### Symbol `mud`

- `mud::usage` — _[text in main catalog]_
### Symbol `mup`

- `mup::usage` — _[text in main catalog]_
### Symbol `mupbar`

- `mupbar::usage` — _[text in main catalog]_
### Symbol `nombondeq`

- `nombondeq::usage` — `nombondeq[t, m]` gives the log price of a nominal `m`‑month maturity discount (zero-coupon) riskless bond at time `t`.

### Symbol `nombondexcreteq`

- `nombondexcreteq::usage` — `nombondexcreteq[t, m]` gives the log holding period excess return from buying a nominal `m`‑month maturity discount (zero-coupon) riskless bond at time `t - 1` and selling it as an (`m - 1`)‑month maturity riskless bond at time `t`, in excess of the one-period nominal risk-free rate.

### Symbol `nombondfweq`

- `nombondfweq::usage` — _[text in main catalog]_
### Symbol `nombondfwspreadeq`

- `nombondfwspreadeq::usage` — _[text in main catalog]_
### Symbol `nombondreteq`

- `nombondreteq::usage` — _[text in main catalog]_
### Symbol `nombondyieldeq`

- `nombondyieldeq::usage` — `nombondyieldeq[t, m]` gives the log yield of a nominal `m`‑month maturity discount (zero-coupon) riskless bond at time `t`.

### Symbol `nomeulereq`

- `nomeulereq::usage` — `nomeulereq[x[t], s, model]` or `nomeulereq[x[t,i], s, model]` give the Euler equation for an asset with nominal return `x[t]` or `x[t, i]` conditional on time `s` for `model`.

### Symbol `nomrfeq`

- `nomrfeq::usage` — `nomrfeq[t]` gives the one-period nominal risk-free rate at time `t` for loans between `t` and `t + 1`.

### Symbol `nomsdfeq`

- `nomsdfeq::usage` — `nomsdfeq[t]` gives the nominal stochastic discount factor at time `t`.
### Symbol `normalizeRootSigns`

- `normalizeRootSigns::badsignidx` — "signIndex must be an Association with \"wc\"/\"pd\" keys; got `1` instead."
### Symbol `paramQuadSolve`

- `paramQuadSolve::usage` — `paramQuadSolve[eqns, vars]` solves a system of polynomial equations, finding solutions for quadratic coefficients appearing in long-run risk models.
- `paramQuadSolve::badmethod` — Method -> \`1\` is not supported. Use Automatic, "Sequential", or "SequentialWithGroebner".
- `paramQuadSolve::badorder` — MonomialOrder -> \`1\` is not supported by GroebnerBasis.
- `paramQuadSolve::noquad` — No quadratic variables detected in the given system; OnlyQuadTerms cannot be applied.
- `paramQuadSolve::nocover` — Unable to select a square subsystem covering the quadratic variables.
- `paramQuadSolve::emptyvar` — Variables list cannot be empty.
- `paramQuadSolve::emptyeq` — Equations list cannot be empty.
- `paramQuadSolve::solvefail` — Solver failed or timed out.

### Symbol `pdeq`

- `pdeq::usage` — `pdeq[t, i]` gives the log price-dividend ratio of stock `i` at time `t`.
### Symbol `phic`

- `phic::usage` — _[text in main catalog]_
### Symbol `phicc`

- `phicc::usage` — _[text in main catalog]_
### Symbol `phicp`

- `phicp::usage` — _[text in main catalog]_
### Symbol `phicpc`

- `phicpc::usage` — _[text in main catalog]_
### Symbol `phicpp`

- `phicpp::usage` — _[text in main catalog]_
### Symbol `phics`

- `phics::usage` — _[text in main catalog]_
### Symbol `phicsp`

- `phicsp::usage` — _[text in main catalog]_
### Symbol `phicx`

- `phicx::usage` — _[text in main catalog]_
### Symbol `phidc`

- `phidc::usage` — _[text in main catalog]_
### Symbol `phidcc`

- `phidcc::usage` — _[text in main catalog]_
### Symbol `phidcd`

- `phidcd::usage` — _[text in main catalog]_
### Symbol `phidp`

- `phidp::usage` — _[text in main catalog]_
### Symbol `phidpc`

- `phidpc::usage` — _[text in main catalog]_
### Symbol `phidpd`

- `phidpd::usage` — _[text in main catalog]_
### Symbol `phidpp`

- `phidpp::usage` — _[text in main catalog]_
### Symbol `phids`

- `phids::usage` — _[text in main catalog]_
### Symbol `phidsp`

- `phidsp::usage` — _[text in main catalog]_
### Symbol `phidxc`

- `phidxc::usage` — _[text in main catalog]_
### Symbol `phidxd`

- `phidxd::usage` — _[text in main catalog]_
### Symbol `phig`

- `phig::usage` — _[text in main catalog]_
### Symbol `phip`

- `phip::usage` — _[text in main catalog]_
### Symbol `phipbarc`

- `phipbarc::usage` — _[text in main catalog]_
### Symbol `phipbarcx`

- `phipbarcx::usage` — _[text in main catalog]_
### Symbol `phipbarp`

- `phipbarp::usage` — _[text in main catalog]_
### Symbol `phipbarpb`

- `phipbarpb::usage` — _[text in main catalog]_
### Symbol `phipbarx`

- `phipbarx::usage` — _[text in main catalog]_
### Symbol `phipbarxb`

- `phipbarxb::usage` — _[text in main catalog]_
### Symbol `phipbarxp`

- `phipbarxp::usage` — _[text in main catalog]_
### Symbol `phipc`

- `phipc::usage` — _[text in main catalog]_
### Symbol `phipcx`

- `phipcx::usage` — _[text in main catalog]_
### Symbol `phipp`

- `phipp::usage` — _[text in main catalog]_
### Symbol `phipx`

- `phipx::usage` — _[text in main catalog]_
### Symbol `phipxp`

- `phipxp::usage` — _[text in main catalog]_
### Symbol `phiscv`

- `phiscv::usage` — _[text in main catalog]_
### Symbol `phispw`

- `phispw::usage` — _[text in main catalog]_
### Symbol `phisxs`

- `phisxs::usage` — _[text in main catalog]_
### Symbol `phix`

- `phix::usage` — _[text in main catalog]_
### Symbol `phixc`

- `phixc::usage` — _[text in main catalog]_
### Symbol `pibareq`

- `pibareq::usage` — `pibareq[t]` gives the exogenous dynamics of expected inflation.
### Symbol `pieq`

- `pieq::usage` — `pieq[t]` gives the exogenous dynamics of inflation.
### Symbol `processNewParameters`

- `processNewParameters::param` — `theta` must equal `(1-gamma)/(1-1/psi)`, replacing `theta` by `(1-gamma)/(1-1/psi)=`1`."
- `processNewParameters::psi` — `psi=1` implies a constant wealth-consumption ratio, please choose a different `psi`.
- `processNewParameters::subsetparam` — "Parameters `1` in `newParameters` are not a subset of `parameters`."
- `processNewParameters::theta` — "Please provide `psi` or `gamma` with `theta`."
- `processNewParameters::usage` — `processNewParameters[newParameters, parameters]` returns a validated list of rules to substitute.
### Symbol `processModels`

- `processModels::usage` — `processModels[modelsCatalog]` performs symbolic processing on models, adding coefficient systems and solutions.
- `processModels::progress` — Finished \`1\`.

### Symbol `psi`

- `psi::usage` — _[text in main catalog]_
### Symbol `reformatCatalog`

- `reformatCatalog::convfail` — _[text in main catalog]_
- `reformatCatalog::nocat` — _[text in main catalog]_
- `reformatCatalog::noroot` — _[text in main catalog]_
- `reformatCatalog::success` — _[text in main catalog]_
- `reformatCatalog::usage` — `reformatCatalog[]` reformats the models section of `Catalog.wl` using standard formatting, preserving `modelsExtraInfo` unchanged.
### Symbol `retceq`

- `retceq::usage` — `retceq[t]` gives the return for the asset that pays consumption as dividends each period.
### Symbol `reteq`

- `reteq::usage` — `reteq[t, i]` gives the return for stock `i`. Stock `i` is defined as the asset that pays dividends `ddeq[i]`.

### Symbol `rfeq`

- `rfeq::usage` — `rfeq[t]` gives the one-period real risk-free rate at time `t` for loans between `t` and `t + 1`.

### Symbol `rhocp`

- `rhocp::usage` — _[text in main catalog]_
### Symbol `rhocpbar`

- `rhocpbar::usage` — _[text in main catalog]_
### Symbol `rhocx`

- `rhocx::usage` — _[text in main catalog]_
### Symbol `rhodp`

- `rhodp::usage` — _[text in main catalog]_
### Symbol `rhodx`

- `rhodx::usage` — _[text in main catalog]_
### Symbol `rhog`

- `rhog::usage` — _[text in main catalog]_
### Symbol `rhogp`

- `rhogp::usage` — _[text in main catalog]_
### Symbol `rhogpbar`

- `rhogpbar::usage` — _[text in main catalog]_
### Symbol `rhop`

- `rhop::usage` — _[text in main catalog]_
### Symbol `rhopbar`

- `rhopbar::usage` — _[text in main catalog]_
### Symbol `rhopbarx`

- `rhopbarx::usage` — _[text in main catalog]_
### Symbol `rhoppbar`

- `rhoppbar::usage` — _[text in main catalog]_
### Symbol `rhox`

- `rhox::usage` — _[text in main catalog]_
### Symbol `rhoxpbar`

- `rhoxpbar::usage` — _[text in main catalog]_
### Symbol `rulesE`

- `rulesE::usage` — `rulesE[t]` defines the distribution of exogenous shocks by giving replacement rules that compute the unconditional expectation of products of powers of exogenous shocks.

### Symbol `scanAndSolve`

- `scanAndSolve::usage` — `scanAndSolve[f, {min, max}]` finds roots of f[x] in the range by grid subdivision.

### Symbol `sceq`

- `sceq::usage` — `sceq[t]` gives the exogenous dynamics of stochastic volatility of real consumption growth.
### Symbol `sdfeq`

- `sdfeq::usage` — `sdfeq[t]` gives the (real) stochastic discount factor at time `t`.

### Symbol `seqfun`

- `seqfun::seqfun` — Sequence function not found for uncondCov[\`1\`[t], \`2\`[t+\`3\`]].

### Symbol `sgeq`

- `sgeq::usage` — `sgeq[t]` gives the exogenous dynamics of the nominal-real covariance (NRC).
### Symbol `speq`

- `speq::usage` — `speq[t]` gives the exogenous dynamics of long-run risk stochastic volatility of inflation.
### Symbol `sxeq`

- `sxeq::usage` — `sxeq[t]` gives the exogenous dynamics of stochastic volatility of long-run risk.

### Symbol `t`

- `t::usage` — `t` denotes time.
### Symbol `taugd`

- `taugd::usage` — _[text in main catalog]_
### Symbol `theta`

- `theta::usage` — _[text in main catalog]_
### Symbol `toCatalog`

- `toCatalog::usage` — `toCatalog[models, {key_1, key_2, ...}]` re‑writes an association of models so that each model contains only the elements with keys `key_i` and, if `key_i` is `"stateVars"` and has head `Function`, replaces its value by `val_i[t]`.

### Symbol `toEquation`

- `toEquation::usage` — `toEquation[model]` gives a pure function that re‑writes its argument in terms of lagged exogenous variables and shocks of `model`. `toEquation[expr, model]` re‑writes `expr` in terms of lagged exogenous variables and shocks of `model`.
### Symbol `toExogenousVars`

- `toExogenousVars::usage` — `toExogenousVars[model]` gives a pure function that re‑writes its argument in terms of the exogenous variables of `model`. `toExogenousVars[expr, model]` re‑writes its first argument in terms of the exogenous variables of `model`.
### Symbol `toNum`

- `toNum::usage` — `toNum[model]` gives a pure (or "anonymous") function that evaluates its argument numerically using the solution to `model`. `toNum[expr, model]` evaluates `expr` numerically using the solution to `model`. `toNum["Rules", model]` gives substitution rules that can be used to evaluate expressions numerically. `toNum[..., parameters]` uses the parameters provided in the list of rules `parameters`. `toNum[..., parameters, initialGuess]` provides an initial estimate for the solution of the model.
### Symbol `toStateVars`

- `toStateVars::usage` — `toStateVars[model]` gives a pure function that re‑writes its argument in terms of the state variables of `model`. `toStateVars[expr, model]` re‑writes its first argument in terms of the state variables of `model`.

### Symbol `uncondCorr`

- `uncondCorr::usage` — `uncondCorr[expr1, expr2, model]` gives the unconditional correlation of `expr1` and `expr2` for `model`.

### Symbol `uncondCov`

- `uncondCov::usage` — `uncondCov[expr1, expr2, model]` gives the unconditional covariance of `expr1` and `expr2` for `model`.

### Symbol `uncondCovLongExo`

- `uncondCovLongExo::usage` — `uncondCovLongExo[toExogenous, expression1, expression2]` computes the unconditional covariance of `expression1` and `expression2` using `toExogenous` to map endogenous variables to exogenous variables, and the default covariance function `covLong` to compute covariances of exogenous variables. `uncondCovLongExo[toExogenous, expression1, expression2, covfun]` computes the unconditional covariance using the covariance function `covfun`.

### Symbol `uncondE`

- `uncondE::usage` — `uncondE[expr, model]` gives the unconditional expectation of `expr` for `model`.
- `uncondE::nmom` — Moment(s) \`1\` not computed. Try increasing `maxMoment` or `maxCrossMoment` in `llr.wl`.

### Symbol `uncondVar`

- `uncondVar::usage` — `uncondVar[expr, model]` gives the unconditional variance of `expr` for `model`.

### Symbol `uncondVarLongExo`

- `uncondVarLongExo::usage` — `uncondVarLongExo[toExogenous, expression]` computes the unconditional variance of `expression` using `toExogenous` to map endogenous variables to exogenous variables, and the default covariance function `covLong` to compute covariances of exogenous variables. `uncondVarLongExo[toExogenous, expression, covfun]` uses the covariance function `covfun`.
### Symbol `updateCoeffs`

- `updateCoeffs::usage` — `updateCoeffs[model]` solves for the coefficients of the wealth-consumption ratio, price-dividend ratio, real bonds, and nominal bonds. Returns a hierarchical structure: list of A solutions, each containing: – `IntervalA`, `SignsA`, `SolutionIndexA`, `IntervalIndexA`: metadata – `A`: coefficient rules for wealth-consumption ratio – `Stocks`: association of stock `j` → list of B solutions, each with `IntervalB`, `SignsB`, `B` – `Bond`, `NomBond`: bond coefficient rules (if computed) Use `flattenCoeffs[result]` to extract all coefficient rules as a flat list.

### Symbol `updateCoeffsSol`

- `updateCoeffsSol::badkernelstructure` — savedKernels must contain a "kernels" key with "A" and "B" sub-keys. Got: \`1\`.

### Symbol `updateModelManifest`

- `updateModelManifest::nocat` — _[text in main catalog]_
- `updateModelManifest::noroot` — _[text in main catalog]_
- `updateModelManifest::usage` — `updateModelManifest[]` generates and saves the `ModelManifest.wl` file. `updateModelManifest[modelsAssoc]` computes manifest data from the given models association without writing to disk.
- `updateModelManifest::versionmismatch` — "PacletInfo.wl version `1` differs from installed paclet version `2`; using PacletInfo.wl version."
### Symbol `validateCatalog`

- `validateCatalog::usage` — `validateCatalog[catalog]` validates all models in a catalog `Association`. Returns a `CatalogValidationResult`.
### Symbol `validateModel`

- `validateModel::badAssumption` — `Model "`1`": Parameter `2` = `3` violates assumption `4`.`
- `validateModel::badIndexedParam` — `Model "`1`": Indexed parameter `2` is not a valid dividend growth parameter. Valid dividend growth parameters: `3`.`
- `validateModel::badParam` — `Model "`1`": Parameter `2` has non-numeric value `3`.`
- `validateModel::badParamName` — `Model "`1`": Invalid parameter name `2`.`
- `validateModel::badStateVar` — `Model "`1`": Invalid state variable `2`. Expected expression with [t] dependency.`
- `validateModel::badStateVarSymbol` — `Model "`1`": State variable `2` contains invalid symbol(s): `3`.`
- `validateModel::duplicateParam` — `Model "`1`": Duplicate parameter `2`.`
- `validateModel::extraParam` — `Model "`1`": Extra parameter(s) not in $parameters: `2`. Valid parameters: `3`.`
- `validateModel::indexGap` — `Model "`1`": Stock indices are not sequential starting from 1. Found indices: `2`.`
- `validateModel::indexNotPositive` — `Model "`1`": Parameter `2` has non-positive index.`
- `validateModel::missingKey` — `Model "`1`": Missing required key "`2`".`
- `validateModel::missingParam` — `Model "`1`": Missing parameter(s) from $parameters: `2`. Valid parameters: `3`.`
- `validateModel::missingStockParam` — `Model "`1`": Stock `2` is incomplete. Missing: `3`.`
- `validateModel::notRule` — `Model "`1`": Parameter entry `2` is not a Rule.`
- `validateModel::usage` — `validateModel[model]` validates a single model `Association` against the schema. Returns a `ValidationResult` association.
- `validateModel::wrongType` — `Model "`1`": Key "`2`" expected `3`, got `4`.`

### Symbol `var`

- `var::usage` — `var[x, s, model]` gives the variance of `x` conditional on time `s` for `model`.

### Symbol `vc`

- `vc::usage` — _[text in main catalog]_
### Symbol `visualizeCoeffs`

- `visualizeCoeffs::usage` — `visualizeCoeffs[updateCoeffsResult]` displays a coefficient-centric comparison view. Shows `A[0]` and `B[j][0]` values across all solution bundles for easy comparison. Includes an interactive selector to compare any coefficient across bundles. Options: • `"ShowSelector" -> True` — show interactive coefficient selector • `"ShowDetails" -> True` — show collapsible bundle details

### Symbol `yieldCurve`

- `yieldCurve::usage` — `yieldCurve[model, newParameters, coeffsWc, bondType, opts]` plots the yield curve.

### Symbol `plotCoeffs`

- `plotCoeffs::usage` — `plotCoeffs[model_Association, sol_List, parameters_List, Ewc0_List, opts: OptionsPattern[]]` plots the steps that `FindRoot` takes to solve for `A[0]`.
### Symbol `vp`

- `vp::usage` — _[text in main catalog]_
### Symbol `vpp`

- `vpp::usage` — _[text in main catalog]_
### Symbol `vppbar`

- `vppbar::usage` — _[text in main catalog]_
### Symbol `vx`

- `vx::usage` — _[text in main catalog]_
### Symbol `wceq`

- `wceq::usage` — `wceq[t]` gives the log wealth-consumption ratio at time `t`.
### Symbol `xeq`

- `xeq::usage` — `xeq[t]` gives the exogenous dynamics of long-run risk.
### Symbol `xic`

- `xic::usage` — _[text in main catalog]_
### Symbol `xid`

- `xid::usage` — _[text in main catalog]_
### Symbol `xip`

- `xip::usage` — _[text in main catalog]_
