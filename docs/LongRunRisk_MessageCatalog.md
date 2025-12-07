# LongRunRisk Paclet Message Catalog

This document catalogs **Wolfram Language messages** (``symbol::tag``) defined in the
`FernandoDuarte/LongRunRisk` paclet repository (GitHub-at-Brown/LongRunRisk) as
seen in the Kernel source files.

The goal is to give a **single place** where you can inspect all messages and
their texts to plan refactors (renaming, rewording, consolidation, localization,
or moving messages into dedicated files).

---

## 1. End‑user API messages (context `FernandoDuarte\`LongRunRisk\``)

These are the messages that belong to the **top‑level paclet context** and form
the primary user‑visible surface.

Most of these symbols are **re‑exported** from sub‑packages using the
`reExport` helper in `Kernel/LongRunRisk.wl`, so their usage messages are
inherited from the underlying implementation. Only messages that are **explicitly
assigned in this repo** are listed verbatim.

### 1.1 Re‑exported symbols (inherit usage)

The following symbols in `FernandoDuarte\`LongRunRisk\`` inherit their `::usage`
messages via `CopyDefinitions` from lower‑level contexts:

- `UncondE`
- `Ev`
- `Var`
- `Cov`
- `Corr`
- `Growth`
- `YieldCurve`
- `PlotCoeffs`
- `VisualizeCoeffs`
- `ToNum`
- `ToEquation`
- `ToExogenousVars`
- `ToStateVars`
- (plus any other symbols re‑exported via `reExport` in `Kernel/LongRunRisk.wl`)

The underlying usage text for these symbols lives in:

- `FernandoDuarte\`LongRunRisk\`ComputationalEngine\`ComputeUnconditionalExpectations\``  
- `FernandoDuarte\`LongRunRisk\`Tools\`TimeAggregation\``  
- `FernandoDuarte\`LongRunRisk\`Tools\`ToNumber\``  
- `FernandoDuarte\`LongRunRisk\`Tools\`VisualizeCoeffs\``  
- `FernandoDuarte\`LongRunRisk\`Tools\`NicePlots\`` (via PacletizedResourceFunctions)

There is **no direct string literal** for these usages in `Kernel/LongRunRisk.wl`;
they are copied at load time.

For refactor purposes, you likely want to treat the usage strings in the
underlying sub‑packages as the *canonical definitions* for these symbols.

### 1.2 Explicit messages in `Kernel/LongRunRisk.wl`

These messages are assigned directly in `Kernel/LongRunRisk.wl`.

#### `UncondCov` (symbol in `FernandoDuarte\`LongRunRisk\``)

- `UncondCov::usage`

  ```wl
  UncondCov::usage =
    StringReplace[
      Information[
        FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondCov,
        "Usage"
      ],
      "uncondCov" -> "UncondCov"
    ];
  ```

  Text is inherited from the underlying `uncondCov` but with the name
  capitalized.

#### `UncondVar`

- `UncondVar::usage`

  ```wl
  UncondVar::usage =
    StringReplace[
      Information[
        FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondVar,
        "Usage"
      ],
      "uncondVar" -> "UncondVar"
    ];
  ```

#### `UncondCorr`

- `UncondCorr::usage`

  ```wl
  UncondCorr::usage =
    StringReplace[
      Information[
        FernandoDuarte`LongRunRisk`ComputationalEngine`ComputeUnconditionalExpectations`uncondCorr,
        "Usage"
      ],
      "uncondCorr" -> "UncondCorr"
    ];
  ```

#### `Info`

Defined via `NiceOutput`:

- `Info::usage`

  ```wl
  Info::usage =
    StringReplace[
      Information[
        FernandoDuarte`LongRunRisk`Tools`NiceOutput`info,
        "Usage"
      ],
      "info" -> "Info"
    ];
  ```

  The base text is given for `info` in `Kernel/Tools/NiceOutput.wl` (see below).

---

## 2. Sub‑package public messages (Model / Tools / ComputationalEngine)

This section lists messages declared in **BeginPackage** sections of sub‑contexts.
They are **not** in the top‑level `LongRunRisk`` context but are still “public”
within their own package contexts.

### 2.1 Model: Shocks (`Kernel/Model/Shocks.wl`)

Context: `FernandoDuarte\`LongRunRisk\`Model\`Shocks\``

Public symbols: `rulesE`, `eps`.

Messages:

- `rulesE::usage`

  > `rulesE[t]` defines the distribution of exogenous shocks by giving replacement
  > rules that compute the unconditional expectation of products of powers of
  > exogenous shocks.

- `eps::usage`

  > Exogenous shocks.

---

### 2.2 Model: Parameters (`Kernel/Model/Parameters.wl`)

Context: `FernandoDuarte\`LongRunRisk\`Model\`Parameters\``.

These are parameter **symbol descriptions**. (The repo also builds a `$parameters`
list using `Names`, but it has no associated messages.)

#### Preferences

- `delta::usage` — "Discount factor."
- `psi::usage` — "Elasticity of intertemporal substitution."
- `gamma::usage` — "Risk aversion coefficient."
- `theta::usage` —  
  "Defined by \[Theta] := (1 - \[Gamma]) / (1 - 1/\[Psi])."

#### Long‑run risk

- `rhox::usage` — "Persistence of long-run risk, AR(1) coefficient."
- `rhoxpbar::usage` — "Exposure of long-run risk to lagged expected inflation."
- `phix::usage` — "Exposure of long-run risk to stochastic volatility of long-run risk and long-run risk shocks."
- `phixc::usage` — "Exposure of long-run risk to stochastic volatility of consumption growth and consumption growth shocks."

#### Inflation

- `mup::usage` — "Mean of inflation rate."
- `rhoppbar::usage` — "Exposure of inflation to lagged expected inflation."
- `rhop::usage` — "Persistence of inflation, AR(1) coefficient."
- `phip::usage` — "Exposure of inflation to inflation shocks."
- `xip::usage` — "Exposure of inflation to lagged inflation shocks."
- `phipc::usage` — "Exposure of inflation to stochastic volatility of consumption growth and consumption growth shocks."
- `phipx::usage` — "Exposure of inflation to stochastic volatility of long-run risk and long-run risk shocks."
- `phipcx::usage` — "Exposure of inflation to stochastic volatility of consumption growth and long-run risk shocks."
- `phipp::usage` — "Exposure of inflation to stochastic volatility of inflation and inflation shocks."
- `phipxp::usage` — "Exposure of inflation to stochastic volatility of long-run risk and inflation shocks."

#### Expected inflation

- `mupbar::usage` — "Mean of expected inflation."
- `rhopbar::usage` — "Persistence of expected inflation, AR(1) coefficient."
- `rhopbarx::usage` — "Exposure of expected inflation to lagged long-run risk."
- `phipbarp::usage` — "Exposure of expected inflation to inflation shocks."
- `phipbarc::usage` — "Exposure of expected inflation to stochastic volatility of consumption growth and consumption growth shocks."
- `phipbarx::usage` — "Exposure of expected inflation to stochastic volatility of long-run risk and long-run risk shocks."
- `phipbarcx::usage` — "Exposure of expected inflation to stochastic volatility of consumption growth and long-run risk shocks."
- `phipbarpb::usage` — "Exposure of expected inflation to stochastic volatility of inflation and expected inflation shocks."
- `phipbarxb::usage` — "Exposure of expected inflation to stochastic volatility of long-run risk and expected inflation shocks."
- `phipbarxp::usage` — "Exposure of expected inflation to stochastic volatility of long-run risk and inflation shocks."

#### Real consumption growth

- `muc::usage` — "Mean of consumption growth."
- `rhocx::usage` — "Exposure of consumption growth to lagged long-run risk."
- `rhocp::usage` — "Exposure of consumption growth to lagged inflation."
- `rhocpbar::usage` — "Exposure of consumption growth to lagged expected inflation."
- `phic::usage` — "Exposure of consumption growth to consumption growth shocks."
- `phicp::usage` — "Exposure of consumption growth to inflation shocks."
- `phicsp::usage` — "Exposure of consumption growth to lagged nominal-real covariance and inflation shocks."
- `xic::usage` — "Exposure of consumption growth to nominal-real covariance two periods ago and lagged inflation shocks."
- `phics::usage` — "Exposure of consumption growth to stochastic volatility of long-run risk and long-run risk shocks."
- `phicx::usage` — "Exposure of consumption growth to stochastic volatility of long-run risk and consumption growth shocks."
- `phicc::usage` — "Exposure of consumption growth to stochastic volatility of consumption growth and consumption growth shocks."
- `phicpc::usage` — "Exposure of consumption growth to stochastic volatility of inflation and consumption growth shocks."
- `phicpp::usage` — "Exposure of consumption growth to stochastic volatility of inflation and inflation shocks."

#### Nominal‑real covariance (NRC)

- `Esg::usage` — "Mean of nominal-real covariance."
- `rhog::usage` — "Persistence of nominal-real covariance, AR(1) coefficient."
- `rhogp::usage` — "Exposure of nominal-real covariance to lagged inflation."
- `rhogpbar::usage` — "Exposure of nominal-real covariance to lagged expected inflation."
- `phig::usage` — "Volatility of nominal-real covariance."

#### Stochastic volatility of long‑run risk

- `Esx::usage` — "Mean of stochastic volatility of long-run risk."
- `vx::usage` — "Persistence of stochastic volatility of long-run risk, AR(1) coefficient."
- `phisxs::usage` — "Volatility of stochastic volatility of long-run risk."

#### Stochastic volatility of consumption growth

- `Esc::usage` — "Mean of stochastic volatility of consumption growth."
- `vc::usage` — "Persistence of stochastic volatility of consumption growth, AR(1) coefficient."
- `phiscv::usage` — "Volatility of stochastic volatility of consumption growth."

#### Stochastic volatility of inflation

- `Esp::usage` — "Mean of stochastic volatility of inflation."
- `vp::usage` — "Persistence of stochastic volatility of inflation, AR(1) coefficient."
- `vpp::usage` — "Exposure of stochastic volatility of inflation to lagged inflation."
- `vppbar::usage` — "Exposure of stochastic volatility of inflation to lagged expected inflation."
- `phispw::usage` — "Volatility of stochastic volatility of inflation."

#### Real dividend growth

- `mud::usage` — "Mean of real dividend growth."
- `rhodx::usage` — "Exposure of dividend growth to lagged long-run risk."
- `rhodp::usage` — "Exposure of dividend growth to lagged inflation."
- `phidc::usage` — "Exposure of dividend growth to consumption growth shocks."
- `phidp::usage` — "Exposure of dividend growth to inflation shocks."
- `phidsp::usage` — "Exposure of dividend growth to lagged nominal-real covariance and inflation shocks."
- `xid::usage` — "Exposure of dividend growth to nominal-real covariance two periods ago and lagged inflation shocks."
- `phids::usage` — "Exposure of dividend growth to stochastic volatility of long-run risk and long-run risk shocks."
- `phidxc::usage` — "Exposure of dividend growth to stochastic volatility of long-run risk and consumption growth shocks."
- `phidcc::usage` — "Exposure of dividend growth to stochastic volatility of consumption growth and consumption growth shocks."
- `phidpc::usage` — "Exposure of dividend growth to stochastic volatility of inflation and consumption growth shocks."
- `phidpp::usage` — "Exposure of dividend growth to stochastic volatility of inflation and inflation shocks."
- `phidxd::usage` — "Exposure of dividend growth to stochastic volatility of long-run risk and dividend growth shocks."
- `phidcd::usage` — "Exposure of dividend growth to stochastic volatility of consumption growth and dividend growth shocks."
- `phidpd::usage` — "Exposure of dividend growth to stochastic volatility of inflation and dividend growth shocks."
- `taugd::usage` — "Correlation between shocks to consumption growth and dividend growth."

---

### 2.3 Model: Exogenous equations (`Kernel/Model/ExogenousEq.wl`)

Context: `FernandoDuarte\`LongRunRisk\`Model\`ExogenousEq\``.

Public exogenous‑equation symbols (end with `eq`):

- `xeq`
- `pieq`
- `pibareq`
- `dceq`
- `sgeq`
- `sxeq`
- `sceq`
- `speq`
- `ddeq`

Messages:

- `xeq::usage`  
  > `xeq[t]` gives the exogenous dynamics of long-run risk.

- `pieq::usage`  
  > `pieq[t]` gives the exogenous dynamics of inflation.

- `pibareq::usage`  
  > `pibareq[t]` gives the exogenous dynamics of expected inflation.

- `dceq::usage`  
  > `dceq[t]` gives the exogenous dynamics of real consumption growth.

- `sgeq::usage`  
  > `sgeq[t]` gives the exogenous dynamics of the nominal-real covariance (NRC).

- `sxeq::usage`  
  > `sxeq[t]` gives the exogenous dynamics of stochastic volatility of long-run risk.

- `sceq::usage`  
  > `sceq[t]` gives the exogenous dynamics of stochastic volatility of real consumption growth.

- `speq::usage`  
  > `speq[t]` gives the exogenous dynamics of long-run risk stochastic volatility of inflation.

- `ddeq::usage`  
  > `ddeq[t, i]` gives the exogenous dynamics of real dividend growth for stock `i`.

Additional public utility:

- `t::usage` (in the ExogenousEq package)

  > `t` denotes time.

There is also a dynamic mechanism that **creates usage messages for corresponding
private exogenous variables** (symbols without the `eq` suffix) by copying and
editing the `eq`-messages. This is done via `AppendTo[Messages[symNew], HoldPattern[MessageName[...]]]`.
Those derived messages are not directly visible in the source as strings.

---

### 2.4 Model: Endogenous equations (`Kernel/Model/EndogenousEq.wl`)

Context: `FernandoDuarte\`LongRunRisk\`Model\`EndogenousEq\``.

Public symbols and their usage messages:

- `rfeq::usage`
  > `rfeq[t]` gives the one-period real risk-free rate at time `t` for loans between `t` and `t + 1`.

- `nomrfeq::usage`
  > `nomrfeq[t]` gives the one-period nominal risk-free rate at time `t` for loans between `t` and `t + 1`.

- `wceq::usage`
  > `wceq[t]` gives the log wealth-consumption ratio at time `t`.

- `pdeq::usage`  
  > `pdeq[t, i]` gives the log price-dividend ratio of stock `i` at time `t`.

- `bondeq::usage`  
  > `bondeq[t, m]` gives the log price of a real `m`‑month maturity discount
  > (zero-coupon) riskless bond at time `t`.

- `nombondeq::usage`  
  > `nombondeq[t, m]` gives the log price of a nominal `m`‑month maturity discount
  > (zero-coupon) riskless bond at time `t`.

- `sdfeq::usage`  
  > `sdfeq[t]` gives the (real) stochastic discount factor at time `t`.

- `nomsdfeq::usage`  
  > `nomsdfeq[t]` gives the nominal stochastic discount factor at time `t`.

- `retceq::usage`  
  > `retceq[t]` gives the return for the asset that pays consumption as dividends
  > each period.

- `reteq::usage`  
  > `reteq[t, i]` gives the return for stock `i`. Stock `i` is defined as the
  > asset that pays dividends `ddeq[i]`.

- `kappa1eq::usage`  
  > `kappa1eq[mu]` is the Campbell–Shiller approximation constant  
  > `kappa1 = Exp[mu]/(Exp[mu] - 1)` where `mu` is the unconditional mean of
  > the log of the approximated variable.

- `kappa0eq::usage`  
  > `kappa0eq[mu]` is the Campbell–Shiller approximation constant  
  > `kappa0 = -Log[Exp[mu] - 1] + Ewc * Exp[mu]/(Exp[mu] - 1)` where `mu` is
  > the unconditional mean of the log of the approximated variable.

- `excretceq::usage`  
  > `excretceq[t]` gives the return for the asset that pays consumption as dividends
  > each period in excess of the risk-free rate.

- `excreteq::usage`  
  > `excreteq[t, i]` gives the return for stock `i` in excess of the risk-free rate.

- `bondyieldeq::usage`  
  > `bondyieldeq[t, m]` gives the log yield of a real `m`‑month maturity discount
  > (zero-coupon) riskless bond at time `t`.

- `nombondyieldeq::usage`  
  > `nombondyieldeq[t, m]` gives the log yield of a nominal `m`‑month maturity
  > discount (zero-coupon) riskless bond at time `t`.

- `bondfweq::usage`  
  (paraphrased) real forward rate between times `t + m - 1` and `t + m`, and with
  optional horizon `h`.

- `nombondfweq::usage`  
  analogous to `bondfweq` for nominal bonds.

- `bondreteq::usage`  
  h‑period real bond holding-period return definitions.

- `nombondreteq::usage`  
  analogous nominal version.

- `bondfwspreadeq::usage`  
  forward rate in excess of corresponding risk-free rate.

- `nombondfwspreadeq::usage`  
  nominal version of forward rate spread.

- `bondexcreteq::usage`, `nombondexcreteq::usage`  
  excess returns for real/nominal bonds vs risk-free rate.

(The file contains long descriptive multiline strings; see
`Kernel/Model/EndogenousEq.wl` for exact wording where needed.)

---

### 2.5 Model: ProcessModels (`Kernel/Model/ProcessModels.wl`)

Context: `FernandoDuarte\`LongRunRisk\`Model\`ProcessModels\``.

Public symbols:

- `processModels`

Messages:

- `processModels::usage`
  > `processModels[modelsCatalog]` performs symbolic processing on models, adding
  > coefficient systems and solutions.

- `processModels::progress`
  > Finished \`1\`.

Internal helper message:

- `addCoeffsSolution::badextrainfo`
  > Closed-form coefficients from extra info did not validate; falling back to all-numerical solve.

---

### 2.6 Model: Catalog (`Kernel/Model/Catalog.wl`)

Context: `FernandoDuarte\`LongRunRisk\`Model\`Catalog\``.

Public symbols:

- `models`
- `modelsExtraInfo`

Messages:

- `models::usage`  
  > Association with the definition and properties of models.

- `modelsExtraInfo::usage`  
  > Additional optional information about model solution, constraints, initial
  > guesses for numerical solvers.

---

### 2.7 Tools: ToNumber (`Kernel/Tools/ToNumber.wl`)

Context: `FernandoDuarte\`LongRunRisk\`Tools\`ToNumber\``.

Public symbols: `toNum`, `toEquation`, `toExogenousVars`, `toStateVars`.

Messages:

- `toNum::usage`

  > `toNum[model]` gives a pure (or "anonymous") function that evaluates its argument
  > numerically using the solution to `model`.  
  > `toNum[expr, model]` evaluates `expr` numerically using the solution to `model`.  
  > `toNum["Rules", model]` gives substitution rules that can be used to evaluate
  > expressions numerically.  
  > `toNum[..., parameters]` uses the parameters provided in the list of rules
  > `parameters`.  
  > `toNum[..., parameters, initialGuess]` provides an initial estimate for the
  > solution of the model.

- `toEquation::usage`

  > `toEquation[model]` gives a pure function that re‑writes its argument in terms
  > of lagged exogenous variables and shocks of `model`.  
  > `toEquation[expr, model]` re‑writes `expr` in terms of lagged exogenous
  > variables and shocks of `model`.

- `toExogenousVars::usage`

  > `toExogenousVars[model]` gives a pure function that re‑writes its argument in
  > terms of the exogenous variables of `model`.  
  > `toExogenousVars[expr, model]` re‑writes its first argument in terms of the
  > exogenous variables of `model`.

- `toStateVars::usage`

  > `toStateVars[model]` gives a pure function that re‑writes its argument in
  > terms of the state variables of `model`.  
  > `toStateVars[expr, model]` re‑writes its first argument in terms of the
  > state variables of `model`.

The helper `processNewParameters` is *not* listed as a public symbol in the
package header but **does** have messages; those are listed in section 3
(Internal / helper messages).

The helper `modelEval` also has a usage message; also listed in section 3.

---

### 2.8 Tools: ValidateModels (`Kernel/Tools/ValidateModels.wl`)

Context: `FernandoDuarte\`LongRunRisk\`Tools\`ValidateModels\``.

Public symbols:

- `validateModel`
- `validateCatalog`

Messages:

- `validateModel::usage`

  > `validateModel[model]` validates a single model `Association` against the
  > schema. Returns a `ValidationResult` association.

- `validateModel::missingKey`

  > `Model "`1`": Missing required key "`2`".`

- `validateModel::wrongType`

  > `Model "`1`": Key "`2`" expected `3`, got `4`.`

- `validateModel::badStateVar`

  > `Model "`1`": Invalid state variable `2`. Expected expression with [t] dependency.`

- `validateModel::badParam`

  > `Model "`1`": Parameter `2` has non-numeric value `3`.`

- `validateModel::duplicateParam`

  > `Model "`1`": Duplicate parameter `2`.`

- `validateModel::missingStockParam`

  > `Model "`1`": Stock `2` is incomplete. Missing: `3`.`

- `validateModel::notRule`

  > `Model "`1`": Parameter entry `2` is not a Rule.`

- `validateModel::badParamName`

  > `Model "`1`": Invalid parameter name `2`.`

- `validateModel::extraParam`

  > `Model "`1`": Extra parameter(s) not in $parameters: `2`. Valid parameters: `3`.`

- `validateModel::missingParam`

  > `Model "`1`": Missing parameter(s) from $parameters: `2`. Valid parameters: `3`.`

- `validateModel::badIndexedParam`

  > `Model "`1`": Indexed parameter `2` is not a valid dividend growth parameter.
  > Valid dividend growth parameters: `3`.`

- `validateModel::indexNotPositive`

  > `Model "`1`": Parameter `2` has non-positive index.`

- `validateModel::indexGap`

  > `Model "`1`": Stock indices are not sequential starting from 1. Found indices: `2`.`

- `validateModel::badAssumption`

  > `Model "`1`": Parameter `2` = `3` violates assumption `4`.`

- `validateModel::badStateVarSymbol`

  > `Model "`1`": State variable `2` contains invalid symbol(s): `3`.`

- `validateCatalog::usage`

  > `validateCatalog[catalog]` validates all models in a catalog `Association`.
  > Returns a `CatalogValidationResult`.

---

### 2.9 Tools: ManageResources (`Kernel/Tools/ManageResources.wl`)

Context: `FernandoDuarte\`LongRunRisk\`Tools\`ManageResources\``.

Public symbols:

- `updateModelManifest`
- `checkCatalogChanges`
- `reformatCatalog`
- `buildModels`
- `buildModelsParallel`

Messages:

#### `updateModelManifest`

- `updateModelManifest::usage`

  > `updateModelManifest[]` generates and saves the `ModelManifest.wl` file.  
  > `updateModelManifest[modelsAssoc]` computes manifest data from the given
  > models association without writing to disk.

- `updateModelManifest::noroot` — "Could not locate paclet root directory."
- `updateModelManifest::nocat` — "Catalog models not found or invalid."
- `updateModelManifest::versionmismatch`  
  > "PacletInfo.wl version `1` differs from installed paclet version `2`; using PacletInfo.wl version."

#### `checkCatalogChanges`

- `checkCatalogChanges::usage`

  > `checkCatalogChanges[]` compares the current Catalog to the saved manifest
  > and reports which models have changed.  
  > `checkCatalogChanges[modelsAssoc]` compares the given models association
  > against the saved manifest, validates changes, but does not reformat.

- `checkCatalogChanges::noroot` — "Could not locate paclet root directory."
- `checkCatalogChanges::nocat` — "Catalog models not found or invalid."
- `checkCatalogChanges::nomanifest` — "ModelManifest.wl not found. Run updateModelManifest[] first."
- `checkCatalogChanges::changed` — "The following models have changed and need updating: `1`."
- `checkCatalogChanges::newmodels` — "New models added to catalog: `1`."
- `checkCatalogChanges::removed` — "Models removed from catalog: `1`."

#### `reformatCatalog`

- `reformatCatalog::usage`

  > `reformatCatalog[]` reformats the models section of `Catalog.wl` using standard
  > formatting, preserving `modelsExtraInfo` unchanged.

- `reformatCatalog::noroot` — "Could not locate paclet root directory."
- `reformatCatalog::nocat` — "Could not locate Catalog.wl or parse its structure."
- `reformatCatalog::convfail` — "Catalog reformatting failed: `1`"
- `reformatCatalog::success` — "Catalog.wl reformatted successfully."

#### `buildModels`

- `buildModels::usage`

  > `buildModels[]` processes enabled models, compiles functions, computes
  > numerical solutions, and creates moments database.

- `buildModels::noroot` — "Could not locate paclet root directory."
- `buildModels::nocat` — "Catalog models not found or invalid."
- `buildModels::start` — "starting build for `1` model(s)."
- `buildModels::processing` — "processing model `1`."
- `buildModels::compiling` — "compiling model `1`."
- `buildModels::numerical` — "computing numerical solutions for `1`."
- `buildModels::moments` — "creating moments database for `1`."
- `buildModels::done` — "build completed for `1` model(s)."
- `buildModels::uptodate` — "all enabled models are up to date."
- `buildModels::skipped` — "skipped `1` (not enabled)."
- `buildModels::kernels` — "launching `1` parallel kernel(s) for moments computation."
- `buildModels::kernelwarmup` — "warming up parallel kernels with PacletizedResourceFunctions..."
- `buildModels::momentscache` — "moments database for `1` is up to date (cache hit)."
- `buildModels::momentscomputing` — "computing moments database for `1`..."
- `buildModels::stage` — "model `1`: starting from `2` stage (`3`)."
- `buildModels::modeluptodate` — "model `1` is up to date."
- `buildModels::checkpoint` — "checkpoint saved after `1` phase."

#### `buildModelsParallel`

- `buildModelsParallel::usage`

  > `buildModelsParallel[models]` runs Symbolic+Compile+Numerical phases in
  > parallel across models, then optionally runs Moments sequentially.  
  > `models` is a list of shortnames like `{"BY", "NRC", "DES"}`.  
  > Options include `"CreateMoments"` (default True) and `"NumKernels"` (default Automatic).

- `buildModelsParallel::launching` — "launching `1` parallel kernel(s) for model builds."
- `buildModelsParallel::parallel` — "running parallel builds for: `1`."
- `buildModelsParallel::merging` — "merging results from parallel builds."
- `buildModelsParallel::moments` — "running moments phase sequentially for `1` model(s)."
- `buildModelsParallel::done` — "parallel build completed for `1` model(s)."

---

### 2.10 Tools: TimeAggregation (`Kernel/Tools/TimeAggregation.wl`)

Context: `FernandoDuarte\`LongRunRisk\`Tools\`TimeAggregation\``.

Public symbol:

- `growth`

Message:

- `growth::usage`

  > `growth[variable, t]` gives the growth rate at time `t` of `variable`.  
  > `growth[variable, t, i]` specifies the stock identifier `i` when `variable`
  > is a stock-related variable such as dividends.  
  > `growth[variable, t, m]` specifies the maturity `m` in months when `variable`
  > is a bond-related variable such as bond yields.

---

### 2.11 Tools: VisualizeCoeffs (`Kernel/Tools/VisualizeCoeffs.wl`)

Context: `FernandoDuarte\`LongRunRisk\`Tools\`VisualizeCoeffs\``.

Public symbol:

- `visualizeCoeffs`

Message:

- `visualizeCoeffs::usage`

  > `visualizeCoeffs[updateCoeffsResult]` displays a coefficient-centric comparison
  > view.  
  > Shows `A[0]` and `B[j][0]` values across all solution bundles for easy
  > comparison.  
  > Includes an interactive selector to compare any coefficient across bundles.  
  > Options:  
  > • `"ShowSelector" -> True` — show interactive coefficient selector  
  > • `"ShowDetails" -> True` — show collapsible bundle details

---

### 2.12 Tools: NiceOutput (`Kernel/Tools/NiceOutput.wl`)

Context: `FernandoDuarte\`LongRunRisk\`Tools\`NiceOutput\``.

Public symbols:

- `info`
- `formatModels`
- `toCatalog`

Messages (public):

- `info::usage`  

  > `info[models]` displays a table with information for each model in the
  > association `models`.

- `formatModels::usage`  

  > `formatModels[models]` re‑writes an association of models as a `Cell` object
  > with nice formatting that can be directly pasted into a notebook.  
  > Additional inline documentation describes creating a notebook and writing
  > formatted cells.

- `toCatalog::usage`  

  > `toCatalog[models, {key_1, key_2, ...}]` re‑writes an association of models
  > so that each model contains only the elements with keys `key_i` and, if
  > `key_i` is `"stateVars"` and has head `Function`, replaces its value by
  > `val_i[t]`.

There are also **helper symbols with usage messages** (`modelToTeX`,
`TeXToModel`, `modelFormattingTemplate`) used internally; see section 3.

---

### 2.12 ComputationalEngine: CreateEulerEq (`Kernel/ComputationalEngine/CreateEulerEq.wl`)

Context: `FernandoDuarte\`LongRunRisk\`ComputationalEngine\`CreateEulerEq\``.

Public symbols:

- `eulereq`
- `nomeulereq`
- `findEulerEqConstants`
- `findBondRecursion`

Messages:

- `eulereq::usage`
  > `eulereq[x[t], s, model]` or `eulereq[x[t,i], s, model]` give the Euler equation
  > for an asset with real return `x[t]` or `x[t, i]` conditional on time `s` for `model`.

- `nomeulereq::usage`
  > `nomeulereq[x[t], s, model]` or `nomeulereq[x[t,i], s, model]` give the Euler equation
  > for an asset with nominal return `x[t]` or `x[t, i]` conditional on time `s` for `model`.

- `findEulerEqConstants::usage`
  > `findEulerEqConstants[x[t], model]` or `findEulerEqConstants[x[t,i], model]` gives
  > a system of equations whose unknowns are the coefficients in front of the state
  > variables for the wealth-consumption or price-dividend ratios.

- `findBondRecursion::usage`
  > `findBondRecursion[t, n, model]` finds the recursions satisfied by the coefficients
  > in front of the state variables for a bond price with maturity `n` at time `t` for `model`.

---

### 2.13 ComputationalEngine: ParamQuadSolve (`Kernel/ComputationalEngine/ParamQuadSolve.wl`)

Context: `FernandoDuarte\`LongRunRisk\`ComputationalEngine\`ParamQuadSolve\``.

Public symbols:

- `paramQuadSolve`
- `expandPatternAssumptions`

Messages:

- `paramQuadSolve::usage`
  > `paramQuadSolve[eqns, vars]` solves a system of polynomial equations, finding
  > solutions for quadratic coefficients appearing in long-run risk models.

- `expandPatternAssumptions::usage`
  > `expandPatternAssumptions[expr, patterns]` expands assumptions containing patterns
  > into explicit form.

- `paramQuadSolve::badmethod`
  > Method -> \`1\` is not supported. Use Automatic, "Sequential", or "SequentialWithGroebner".

- `paramQuadSolve::badorder`
  > MonomialOrder -> \`1\` is not supported by GroebnerBasis.

- `paramQuadSolve::noquad`
  > No quadratic variables detected in the given system; OnlyQuadTerms cannot be applied.

- `paramQuadSolve::nocover`
  > Unable to select a square subsystem covering the quadratic variables.

- `paramQuadSolve::emptyvar`
  > Variables list cannot be empty.

- `paramQuadSolve::emptyeq`
  > Equations list cannot be empty.

- `paramQuadSolve::solvefail`
  > Solver failed or timed out.

---

### 2.14 ComputationalEngine: SolveEulerEq (`Kernel/ComputationalEngine/SolveEulerEq.wl`)

Context: `FernandoDuarte\`LongRunRisk\`ComputationalEngine\`SolveEulerEq\``.

Public symbols (from package header):

- `updateCoeffs`
- `addCoeffsSolutionN`
- `flattenCoeffs`
- `flattenCoeffsBundles`

Messages:

- `updateCoeffs::usage`

  > `updateCoeffs[model]` solves for the coefficients of the wealth-consumption
  > ratio, price-dividend ratio, real bonds, and nominal bonds.  
  > Returns a hierarchical structure: list of A solutions, each containing:  
  > – `IntervalA`, `SignsA`, `SolutionIndexA`, `IntervalIndexA`: metadata  
  > – `A`: coefficient rules for wealth-consumption ratio  
  > – `Stocks`: association of stock `j` → list of B solutions, each with
  >   `IntervalB`, `SignsB`, `B`  
  > – `Bond`, `NomBond`: bond coefficient rules (if computed)  
  > Use `flattenCoeffs[result]` to extract all coefficient rules as a flat list.

- `addCoeffsSolutionN::usage`

  > `addCoeffsSolutionN[model]` computes numerical solutions for all coefficient
  > types (`wc`, `pd`, `bond`, `nombond`) using default parameters and model
  > `extraInfo`.

- `flattenCoeffs::usage`

  > `flattenCoeffs[updateCoeffsResult]` extracts all coefficient rules from the
  > hierarchical structure returned by `updateCoeffs`.  
  > `flattenCoeffs[result, n]` extracts rules from the `n`‑th A solution only.  
  > `flattenCoeffs[result, n, j]` extracts A rules and B rules for stock `j` from
  > the `n`‑th A solution.  
  > `flattenCoeffs[result, n, j, m]` extracts A rules and the `m`‑th B solution
  > for stock `j` from the `n`‑th A solution.

- `flattenCoeffsBundles::usage`

  > `flattenCoeffsBundles[updateCoeffsResult]` returns a list of complete solution
  > bundles. Each bundle is a flat list of rules (A + one B per stock + Bond +
  > NomBond) ready to apply with `/.` (ReplaceAll).  
  > Generates Cartesian product: if stock 1 has 2 B solutions and stock 2 has 3,
  > returns 6 bundles.  
  > `flattenCoeffsBundles[result, n]` returns bundles for the `n`‑th A solution
  > only.

Internal helper messages from this file (e.g. `loadModelKernels::nofile`,
`normalizeRootSigns::badsignidx`) are listed in section 3.

---

### 2.15 ComputationalEngine: CreateMomentsDatabase (`Kernel/ComputationalEngine/CreateMomentsDatabase.wl`)

Context: `FernandoDuarte\`LongRunRisk\`ComputationalEngine\`CreateMomentsDatabase\``.

Public symbols:

- `uncondVarLongExo`
- `uncondCovLongExo`
- `createDatabase`

Messages:

- `uncondVarLongExo::usage`

  > `uncondVarLongExo[toExogenous, expression]` computes the unconditional
  > variance of `expression` using `toExogenous` to map endogenous variables
  > to exogenous variables, and the default covariance function `covLong` to
  > compute covariances of exogenous variables.  
  > `uncondVarLongExo[toExogenous, expression, covfun]` uses the covariance
  > function `covfun`.

- `uncondCovLongExo::usage`

  > `uncondCovLongExo[toExogenous, expression1, expression2]` computes the
  > unconditional covariance of `expression1` and `expression2` using
  > `toExogenous` to map endogenous variables to exogenous variables, and the
  > default covariance function `covLong` to compute covariances of exogenous
  > variables.  
  > `uncondCovLongExo[toExogenous, expression1, expression2, covfun]` computes
  > the unconditional covariance using the covariance function `covfun`.

- `createDatabase::usage`

  > `createDatabase[model_Association, covLongFilename_String]` computes moments
  > for `model`, memoizes the results, and stores them in `covLongFilename`.

---

## 3. Internal / helper messages

This section lists messages that are **not part of the top‑level
`LongRunRisk`` context** and are primarily used for internal logic or helpers.
They may still be public in their own sub‑contexts, but are more “developer”
than “end‑user”.

### 3.1 ToNumber helper messages

Context: `FernandoDuarte\`LongRunRisk\`Tools\`ToNumber\``.

#### `processNewParameters` (helper for parameter validation)

- `processNewParameters::usage`

  > `processNewParameters[newParameters, parameters]` returns a validated list of
  > rules to substitute.

- `processNewParameters::psi`

  > `psi=1` implies a constant wealth-consumption ratio, please choose a different `psi`.

- `processNewParameters::param`

  > `theta` must equal `(1-gamma)/(1-1/psi)`, replacing `theta` by
  > `(1-gamma)/(1-1/psi)=`1`."

- `processNewParameters::theta`

  > "Please provide `psi` or `gamma` with `theta`."

- `processNewParameters::subsetparam`

  > "Parameters `1` in `newParameters` are not a subset of `parameters`."

These messages support the internal parameter‑processing logic used when
constructing new parameter sets.

#### `modelEval` helper

- `modelEval::usage`

  > `modelEval[expr, model]` evaluates moments in `expr` using `model`.  
  > Example text (abridged) shows mapping of `uncondE`, `uncondCov`, `cov`, etc.
  > into model‑based versions.

---

### 3.2 ComputeUnconditionalExpectations helper messages

Context: `FernandoDuarte\`LongRunRisk\`ComputationalEngine\`ComputeUnconditionalExpectations\``.

- `uncondE::nmom`
  > Moment(s) \`1\` not computed. Try increasing maxMoment or maxCrossMoment in llr.wl.

- `createSystem::nomom`
  > Unconditional moments cannot be computed for state variables...

---

### 3.3 ComputeConditionalExpectations helper messages

Context: `FernandoDuarte\`LongRunRisk\`ComputationalEngine\`ComputeConditionalExpectations\``.

- `lagStateVarst::timeout`
  > lagStateVarst timed out after \`1\` seconds. The toStateVars rules may cause infinite recursion.

- `lagStateVarst::maxiter`
  > lagStateVarst exceeded \`1\` iterations without convergence.

---

### 3.4 SolveEulerEq helper messages

Context: `FernandoDuarte\`LongRunRisk\`ComputationalEngine\`SolveEulerEq\``.

#### `loadModelKernels`

- `loadModelKernels::nofile`

  > "Kernel file not found for model `1`. Expected: `2`"

- `loadModelKernels::sysid`

  > "Kernel was compiled on `1` but current system is `2`. Recompile may be needed."

These report problems when loading compiled coefficient data from
`Resources/CompiledFunctions`.

#### `normalizeRootSigns`

- `normalizeRootSigns::badsignidx`

  > "signIndex must be an Association with \"wc\"/\"pd\" keys; got `1` instead."

Used when normalizing the `"RootSigns"` option.

#### `updateCoeffsSol`

- `updateCoeffsSol::badkernels`
  > savedKernels must contain a "kernels" key with "A" and "B" sub-keys. Got: \`1\`

#### `checks`

- `checks::norm`
  > The norm of the residuals (errors) is \`1\`.

- `checks::largeresid`
  > The norm of the residuals (errors) is \`1\`, which is larger than the specified tolerance \`2\`.

- `checks::smallresid`
  > The norm of the residuals (errors) is \`1\`, which is smaller than the specified tolerance \`2\`.

---

### 3.5 CreateMomentsDatabase helper messages

Context: `FernandoDuarte\`LongRunRisk\`ComputationalEngine\`CreateMomentsDatabase\``.

- `createDatabase::done`
  > Finished computing moments for \`1\`.

- `covLongToUncondCov::nind`
  > The number of indices provided in \`1\` must be equal to the number of variables
  > in \`2\` plus the number of stock-related variables in \`2\` that require a stock identifier.

- `seqfun::seqfun`
  > Sequence function not found for uncondCov[\`1\`[t], \`2\`[t+\`3\`]].

---

### 3.6 FindRootOptim helper messages

Context: `FernandoDuarte\`LongRunRisk\`Tools\`FindRootOptim\``.

#### `buildKernel`

- `buildKernel::badvars`
  > Expression contains coefficient variables not listed in vars.

- `buildKernel::unusedvars`
  > Some vars were not found in the expression: \`1\`.

- `buildKernel::badcompilemode`
  > Invalid CompileMode \`1\`. Expected "Both", "FunctionOnly", or "JacobianOnly".

#### `bindUnary`

- `bindUnary::insufficientsigns`
  > Expected at least \`1\` sign values, but got \`2\`.

- `bindUnary::toomanyigns`
  > Expected exactly \`1\` sign values, but got \`2\`.

#### `findRootInterval`

- `findRootInterval::emptyinterval`
  > There are no real solutions for \`1\`. Try changing signs \`2\` or parameters.

- `findRootInterval::nocoeff`
  > Could not locate a root variable for coefficient head \`1\` in the conditions.

#### `extractIntervalsFromReduce`

- `extractIntervalsFromReduce::nointervals`
  > Could not extract any valid intervals from reduced expression \`1\`.

#### `fastRoot`

- `fastRoot::cvmit`
  > Failed to converge within \`1\` iterations starting from x0=\`2\` in bounds [\`3\`, \`4\`].

- `fastRoot::nnum`
  > Function returned non-numeric value \`1\` at x=\`2\`.

- `fastRoot::nobnd`
  > No bounds specified and FindRoot failed from x0=\`1\`.

- `fastRoot::badbnds`
  > Invalid bounds: lower bound \`1\` must be less than upper bound \`2\`.

- `fastRoot::badspec`
  > Invalid spec format \`1\`. Expected scalar, {lo, hi}, {x0, lo, hi}, or nested list.

- `fastRoot::compiled`
  > Function is a CompiledCodeFunction; Newton+Jacobian unavailable, using fallback.

- `fastRoot::baddim`
  > Inconsistent dimensions in spec: \`1\`.

#### `createCompiledEq`

- `createCompiledEq::cachehit`
  > cache hit for model \`1\`; skipping compilation.

- `createCompiledEq::compiling`
  > compiling model \`1\`; this may take a long time.

---

### 3.7 NiceOutput internal helpers

Context: `FernandoDuarte\`LongRunRisk\`Tools\`NiceOutput\``.

These symbols are declared **inside the Private section** but have usage
messages for notebook‑generation helpers.

- `modelToTeX::usage`

  > "Association between the Mathematica variables that represent parameters of
  > the model and their LaTeX representation"

- `TeXToModel::usage`

  > "Association of LaTeX strings for parameters of the model and the name of the
  > corresponding Mathematica variable"

- `modelFormattingTemplate::usage`

  > `modelFormattingTemplate[model]` re‑writes `model` as a `Cell` object with
  > nice formatting. Additional inline instructions describe how to write all
  > models from `Kernel/Model/Catalog.wl` into a notebook using this template.

These helpers are **not exported** via the package’s public symbol list.

---

### 3.8 ExogenousEq dynamic usage messages for private variables

In `Kernel/Model/ExogenousEq.wl`, after defining the public `...eq` symbols,
the code constructs **private exogenous variable symbols** (without the `eq`
suffix) and dynamically attaches usage messages to them:

- Private symbols:  
  e.g. `x`, `pi`, `pibar`, `dc`, `sg`, `sx`, `sc`, `sp`, `dd` in the private
  exogenous context.

- Mechanism:

  ```wl
  AppendTo[
    Messages[symNew],
    HoldPattern[MessageName[symNew,"usage"]] :>
      StringReplace[
        Information[sym,"Usage"],
        {
          SymbolName@sym -> SymbolName@symNew,
          "gives" -> "represents",
          "the exogenous dynamics of" -> ""
        }
      ] /; StringQ[MessageName[sym,"usage"]]
  ];
  ```

This means the **private variables inherit modified usage strings** from their
`...eq` counterparts, with wording changed from “gives the exogenous dynamics
of” to “represents …”.

For refactoring, it may be useful to convert this dynamic pattern into explicit
`::usage` assignments if you want a fully static catalog.

---

## 4. How to use this file for refactoring

- To find all messages associated with *one symbol*, search for the symbol name
  (e.g. `validateModel::`).
- To separate **end‑user API** from **developer/internal**, treat:
  - Section 1 (top‑level `LongRunRisk``) as the *canonical public* API.
  - Sections 2–3 as module‑level and internal messages you may or may not wish
    to expose in documentation.
- To consolidate messages into a dedicated `Messages.wl`:
  - Group by context (e.g. `Model`, `Tools`, `ComputationalEngine`).
  - Move the `symbol::tag = "...";` assignments into that file.
  - Leave this markdown as a historical record or regenerate it after refactor.

This catalog is based purely on **static inspection of the repo**; if new
messages are added or removed, this file should be regenerated accordingly.
