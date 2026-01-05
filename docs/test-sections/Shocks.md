### Shocks.wl

#### Package Loading

- Context is on `$ContextPath` after loading
  ```
  MemberQ[$ContextPath, "FernandoDuarte`LongRunRisk`Model`Shocks`"]
  ```

- Symbol `rulesE` should exist (can be found)
  ```
  Not[Names["*rulesE"] === {}]
  ```

---

#### Shock Moments (Standard Normal Properties)

All shocks should have standard normal distribution moments when evaluated with `rulesE[t]`.

- Shocks have zero mean (first moment)
  ```
  And @@ (
    Flatten@{
      Table[
        (eps[f][t] /. rulesE[t]) === 0,
        {f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
      ],
      Table[
        (eps["dd"][t, ii] /. rulesE[t]) === 0,
        {ii, {1, i, j}}
      ]
    }
  )
  ```

- Shocks have variance equal to one (second moment)
  ```
  And @@ (
    Flatten@{
      Table[
        (eps[f][t]^2 /. rulesE[t]) === 1,
        {f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
      ],
      Table[
        (eps["dd"][t, ii]^2 /. rulesE[t]) === 1,
        {ii, {1, i, j}}
      ]
    }
  )
  ```

- Shocks have zero third moment (skewness = 0)
  ```
  And @@ (
    Flatten@{
      Table[
        (eps[f][t]^3 /. rulesE[t]) === 0,
        {f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
      ],
      Table[
        (eps["dd"][t, ii]^3 /. rulesE[t]) === 0,
        {ii, {1, i, j}}
      ]
    }
  )
  ```

- Shocks have fourth moment equal to three (kurtosis of standard normal)
  ```
  And @@ (
    Flatten@{
      Table[
        (eps[f][t]^4 /. rulesE[t]) === 3,
        {f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
      ],
      Table[
        (eps["dd"][t, ii]^4 /. rulesE[t]) === 3,
        {ii, {1, i, j}}
      ]
    }
  )
  ```

---

#### Shock Independence

- Shocks are uncorrelated (cross-products have zero expectation)
  ```
  And @@ (
    Flatten@{
      Table[
        0 === If[f === g, 0, eps[f][t] * eps[g][t] /. rulesE[t]],
        {f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}},
        {g, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
      ],
      Table[
        0 === (eps["dd"][t, ii] * eps[f][t] /. rulesE[t]),
        {ii, {1, i, j}},
        {f, {"x", "pi", "pibar", "sg", "sx", "sc", "sp"}}
      ]
    }
  )
  ```

---

#### Correlation Structure

- `taugd` is correlation between shocks to consumption and dividends
  ```
  With[{tb = Table[
      (eps["dd"][t, ii] * eps["dc"][t]) /. rulesE[t],
      {ii, {1, i, j}}
    ]},
    SameQ[
      {
        Map[SymbolName @* Head, tb],
        Map[
          Composition[
            Function @ If[
              NumberQ[#], ToString @ #, If[Developer`HoldSymbolQ[#], SymbolName @ #, ""]
            ],
            First
          ],
          tb
        ]
      },
      {{"taugd", "taugd", "taugd"}, {"1", "i", "j"}}
    ]
  ]
  ```

---

#### Rule Application Boundaries

Tests confirming that `rulesE[t]` only applies to shocks at time `t`, returning other expressions unevaluated.

- Shocks at different times (t+1) are not evaluated
  ```
  And @@ (
    Flatten@{
      Table[
        (expr /. rulesE[t]) === expr,
        {expr, Table[eps[f][t + 1], {f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}]}
      ],
      Table[
        (expr /. rulesE[t]) === expr,
        {expr, Table[eps[ToExpression@f][t], {f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}]}
      ],
      Table[
        (expr /. rulesE[t]) === expr,
        {expr, {eps["dd"][t + 1, i], eps[dd][t, i]}}
      ]
    }
  )
  ```

- Shocks without time argument are not evaluated
  ```
  And @@ (
    Flatten@{
      Table[
        (expr /. rulesE[t]) === expr,
        {expr, Table[eps[f], {f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}]}
      ],
      Table[
        (eps["dd"] /. rulesE[t]) === eps["dd"],
        {ii, {1, i, j}}
      ]
    }
  )
  ```

- Invalid shock names are not evaluated
  ```
  And @@ (
    Flatten@{
      Table[
        (expr /. rulesE[t]) === expr,
        {expr, Table[eps[f], {f, {"xx", "adc", "p", "rhobar", "ssg", "ssx", "sdc", "spi"}}]}
      ],
      Table[
        (eps["ddd"] /. rulesE[t]) === eps["ddd"],
        {ii, {1, i, j}}
      ]
    }
  )
  ```

- Invalid shock names with various time arguments are not evaluated
  ```
  And @@ (
    Flatten@{
      Table[
        (expr /. rulesE[t]) === expr,
        {expr, Table[eps[f][tt], {f, {"xx", "adc", "p", "rhobar", "ssg", "ssx", "sdc", "spi"}}, {tt, {t + 1, t - 1, s, t + h}}]}
      ],
      Table[
        (expr /. rulesE[t]) === expr,
        {expr, Table[eps["dd"][tt, ii], {ii, {1, i, j}}, {tt, {t + 1, t - 1, s, t + h}}]}
      ]
    }
  )
  ```

---

#### Context Independence

- `rulesE` works for symbols in any context (not just the original)
  ```
  And @@ (
    Flatten@{
      Table[
        (NewContext`eps[f][t] /. rulesE[t]) === 0,
        {f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
      ],
      Table[
        (NewContext`eps["dd"][t, ii] /. rulesE[t]) === 0,
        {ii, {1, i, j}}
      ]
    }
  )
  ```

- `rulesE` works for symbols in original package context
  ```
  And @@ (
    Flatten@{
      Table[
        (FernandoDuarte`LongRunRisk`Model`Shocks`Private`eps[f][t]^2 /. rulesE[t]) === 1,
        {f, {"x", "dc", "pi", "pibar", "sg", "sx", "sc", "sp"}}
      ],
      Table[
        (FernandoDuarte`LongRunRisk`Model`Shocks`Private`eps["dd"][t, ii]^2 /. rulesE[t]) === 1,
        {ii, {1, i, j}}
      ]
    }
  )
  ```
