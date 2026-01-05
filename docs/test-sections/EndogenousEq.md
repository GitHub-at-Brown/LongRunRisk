### EndogenousEq.wl

- Symbol `pdeq` should exist (can be found)
  ```
  Not[Names["*pdeq"] === {}]
  ```

For endogenous variables (entries of `$endogenousVars`):
- All exogenous variables are in context `"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"`
  ```
  And @@ ((# ===
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`") & /@
    (Context /@
      Cases[((#[t]) & /@ (Symbol /@ $endogenousVars)),
        var_Symbol?(MemberQ[
            StringDrop[#, -2] & /@
              FernandoDuarte`LongRunRisk`Model`ExogenousEq`$exogenousVars,
            SymbolName[#]] &)[__] :> var, Infinity]))
  ```

- All shocks are in context `"FernandoDuarte`LongRunRisk`Model`Shocks`"`
  ```
  And @@ ((# === "FernandoDuarte`LongRunRisk`Model`Shocks`") & /@ (Context /@
      Cases[((#[t]) & /@ (Symbol /@ $endogenousVars)),
        var_Symbol?(MatchQ[SymbolName[#], "eps"] &)[__][__] :> var, Infinity]))
  ```

- All parameters are in context `"FernandoDuarte`LongRunRisk`Model`Parameters`"`
  ```
  And @@ ((# ===
      "FernandoDuarte`LongRunRisk`Model`Parameters`") & /@ (Context /@
      Cases[((#[t]) & /@ (Symbol /@ $endogenousVars)),
        var_Symbol?(MemberQ[
            FernandoDuarte`LongRunRisk`Model`Parameters`$parameters,
            SymbolName[#]] &) :> var, Infinity]))
  ```

- All endogenous variables are in context `"FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`"`
  ```
  And @@ ((# ===
      "FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`") & /@
    (Context /@
      Cases[((#[t]) & /@ (Symbol /@ $endogenousVars)),
        var_Symbol?(MemberQ[StringDrop[#, -2] & /@ $endogenousVars,
            SymbolName[#]] &)[__] :> var, Infinity]))
  ```

- Equation variables use different contexts for `t` argument (context isolation)
  ```
  And @@ {
    FreeQ[bondyieldeq[t, m], foo`t],
    Not@FreeQ[bondyieldeq[t, m], t],
    FreeQ[bondyieldeq[foo`t, m], t],
    Not@FreeQ[bondyieldeq[foo`t, m], foo`t],
    Not@(foo`bondyieldeq[t, m] === bondyieldeq[t, m]),
    Not@(bondyieldeq[t, m] === bondyieldeq[foo`t, m])
    }
  ```

- Equation variables use different contexts for `m` argument (context isolation)
  ```
  And @@ {
    FreeQ[bondyieldeq[t, m], foo`m],
    Not@FreeQ[bondyieldeq[t, m], m],
    FreeQ[bondyieldeq[t, foo`m], m],
    Not@FreeQ[bondyieldeq[t, foo`m], foo`m],
    Not@(bondyieldeq[t, m] === bondyieldeq[t, foo`m])
    }
  ```

- Default values for optional arguments work correctly
  ```
  And @@ {
    bondfweq[t, m] === bondfweq[t, m, 1],
    bondreteq[t, m] === bondreteq[t, m, 1],
    bondfwspreadeq[t, m] === bondfwspreadeq[t, m, 1],
    bondexcreteq[t, m] === bondexcreteq[t, m, 1]
    }
  ```

For coefficient functions (`coefwc`, `coefpd`, `coefb`, `coefnb`):
- Indices of coefficients are exact integers (not inexact/floating-point numbers)
  - Applies to `coefwc[i]`, `coefpd[i][j]`, `coefb[i][j]`, `coefnb[i][j]`
  - Must remain exact after `N[]` application to the coefficient (not the index)
  ```
  coefwc = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefwc;
  coefpd = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefpd;
  coefb = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefb;
  coefnb = FernandoDuarte`LongRunRisk`Model`EndogenousEq`Private`coefnb;

  (* Test that indices remain exact integers in all coefficient expressions *)
  And @@ Flatten@{
    Not /@ InexactNumberQ /@ Select[Flatten@Cases[ch, x_[i_] :> i], NumberQ],
    Not /@ InexactNumberQ /@ Select[Flatten@Cases[ch, x_[i_][j_] :> {i, j}], NumberQ]
    }
  ```
