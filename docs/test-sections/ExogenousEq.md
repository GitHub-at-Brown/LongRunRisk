### ExogenousEq.wl

- Symbol `xeq` should exist (can be found)
  ```
  Not[Names["*xeq"] === {}]
  ```

For exogenous variables (entries of `$exogenousVars`):
- All exogenous variables are in context `"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"` (individual checks)
  ```
  And @@ {
    MemberQ[DeleteDuplicates@(Context /@ Cases[xeq[t],
      var_Symbol?(MatchQ[SymbolName[#], "x"] &)[___] :> var, Infinity]),
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],
    MemberQ[DeleteDuplicates@(Context /@ Cases[pieq[t],
      var_Symbol?(MatchQ[SymbolName[#], "pi"] &)[___] :> var, Infinity]),
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],
    MemberQ[DeleteDuplicates@(Context /@ Cases[pibareq[t],
      var_Symbol?(MatchQ[SymbolName[#], "pibar"] &)[___] :> var, Infinity]),
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],
    MemberQ[DeleteDuplicates@(Context /@ Cases[sgeq[t],
      var_Symbol?(MatchQ[SymbolName[#], "sg"] &)[___] :> var, Infinity]),
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],
    MemberQ[DeleteDuplicates@(Context /@ Cases[sxeq[t],
      var_Symbol?(MatchQ[SymbolName[#], "sx"] &)[___] :> var, Infinity]),
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],
    MemberQ[DeleteDuplicates@(Context /@ Cases[sceq[t],
      var_Symbol?(MatchQ[SymbolName[#], "sc"] &)[___] :> var, Infinity]),
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],
    MemberQ[DeleteDuplicates@(Context /@ Cases[speq[t],
      var_Symbol?(MatchQ[SymbolName[#], "sp"] &)[___] :> var, Infinity]),
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],

    Not[{} === Cases[Symbol /@ Names["FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*"],
      var_Symbol?(MatchQ[SymbolName[#], "dc"] &) :> var, Infinity]],
    Not[{} === Cases[Symbol /@ Names["FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*"],
      var_Symbol?(MatchQ[SymbolName[#], "dd"] &) :> var, Infinity]],
    MemberQ[DeleteDuplicates@(Context /@ Cases[
      Symbol /@ Names["FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*"],
      var_Symbol?(MatchQ[SymbolName[#], "dc"] &) :> var, Infinity]),
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"],
    MemberQ[DeleteDuplicates@(Context /@ Cases[
      Symbol /@ Names["FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`*"],
      var_Symbol?(MatchQ[SymbolName[#], "dd"] &) :> var, Infinity]),
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"]
    }
  ```

- All exogenous variables are in context `"FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`"` (generic check)
  ```
  And @@ ((# ===
      "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`") & /@
    (Context /@ Cases[(#[t]) & /@ (Symbol /@ $exogenousVars),
      var_Symbol?(MemberQ[StringDrop[#, -2] & /@ $exogenousVars,
          SymbolName[#]] &)[__] :> var, Infinity]))
  ```

- All shocks are in context `"FernandoDuarte`LongRunRisk`Model`Shocks`"`
  ```
  And @@ ((# === "FernandoDuarte`LongRunRisk`Model`Shocks`") & /@
    (Context /@ Cases[(#[t]) & /@ (Symbol /@ $exogenousVars),
      var_Symbol?(MatchQ[SymbolName[#], "eps"] &)[__][__] :> var, Infinity]))
  ```

- All parameters are in context `"FernandoDuarte`LongRunRisk`Model`Parameters`"`
  ```
  And @@ ((# ===
      "FernandoDuarte`LongRunRisk`Model`Parameters`") & /@
    (Context /@ Cases[(#[t]) & /@ (Symbol /@ $exogenousVars),
      var_Symbol?(MemberQ[FernandoDuarte`LongRunRisk`Model`Parameters`$parameters,
          SymbolName[#]] &) :> var, Infinity]))
  ```

- Equation variables use different contexts for `t` argument (context isolation)
  ```
  And @@ {
    FreeQ[xeq[t], foo`t],
    Not@FreeQ[xeq[t], t],
    FreeQ[xeq[foo`t], t],
    Not@FreeQ[xeq[foo`t], foo`t],
    Not@(foo`xeq[t] === xeq[t]),
    Not@(xeq[t] === xeq[foo`t])
    }
  ```
