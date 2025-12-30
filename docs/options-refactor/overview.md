Here’s a concrete strategy that fits what you asked for **and** matches the conventions in `wolfram-options.zip` (declare only what you own; accept/forward via `OptionsPattern[{...}]`; cache with `With`; forward with `FilterRules[Flatten@{opts}, Options[child]]`; inject with `Sequence @@ ...`).

I’m going to describe it in terms of (a) **rules you enforce everywhere**, (b) a **package-level structure** that makes the rules easy to maintain, and (c) the **specific option “problem children”** you called out (`SignSymbol`, `MaxMaturity`, `Signs`, `FromScratch`, `CreateMoments`) and how to resolve them cleanly with *no backwards compatibility*.

---

## 1) The invariant you enforce: “one option name → one consumer”

### Definition (what counts as “owner”)

An option name `opt` is **owned by exactly one function symbol** `f` in the entire paclet, where:

* `f` is the **only** place that calls `OptionValue[opt]` (or otherwise *interprets* that option’s value).
* Everyone else either:

  * **forwards** `opt` unchanged (i.e., `FilterRules[..., Options[f]]`); or
  * **maps** from a different option into `f`’s option (i.e., wrapper owns `BuildMaxMaturity` and constructs `"MaxMaturity"->...` explicitly); or
  * passes a **positional/structural argument** (inline-style) so downstream code never sees the option at all.

This matches your clarified “inline F2/F3 inside F1” rule: if you want to treat downstream code as “not an owner”, it cannot be calling `OptionValue` for that option.

---

## 2) Single source of truth: defaults live only on the owner symbol

Your choice “A” means:

* The default value for an option appears **only** in `Options[owner]`.
* No “central config” is authoritative for defaults.
* Wrappers do **not** redefine child options in their `Options[...]`.

This is also why you should lean away from a “global defaultConfig[] association” approach going forward: it’s inherently a second source of truth and it’s the root cause of the drift flagged in your `options-issues.md`.

---

## 3) Passing options through without redefining them

You already have the right standard (from `wolfram-options.zip`). The enforcement version is:

* **Every wrapper signature** should be:

```wl
parent[args___, opts : OptionsPattern[{parent, child1, child2, FindRoot, ...}]] := ...
```

* **Every forwarding site** uses:

```wl
childOpts = Evaluate @ FilterRules[Flatten@{opts}, Options[child]];
child[args, Sequence @@ childOpts]
```

* If you merge defaults with user overrides in a list, put **user rules first** so they win, because `OptionValue` uses the *first* specification when duplicates exist. ([Wolfram Documentation][1])

That “first wins” fact is crucial for getting precedence exactly right, and it’s consistent with your `InheritOptions` implementation (which uses `DeleteDuplicatesBy[..., First]`).

---

## 4) What to do with overlapping options: only 3 allowed patterns

When you discover that option name `X` is consumed in more than one place, you only allow one of:

### Pattern A — Split the option name (rename)

Create `XSomething` and `XOther` so each is consumed by one function.

### Pattern B — Bundle the option (sub-association / keyed rules)

Keep the external name `X`, but make its value a container keyed by the “real owner”, e.g.

* `X -> <|"f2" -> v2, "f3" -> v3|>` or `X -> {"f2" -> v2, "f3" -> v3}`

Then each function consumes only its own key.
This is your “bundled ownership” allowance.

### Pattern C — Inline (one upstream owner)

Upstream function reads `OptionValue[X]` once and passes the interpreted result as a positional/structural argument so downstream code never calls `OptionValue[X]`.

---

## 5) Concrete re-org proposal: make “owners” explicit, and make wrappers dumb

### A) Classify your functions into two roles

1. **Owner (consumer) functions**

   * Have `Options[owner] = {...}`
   * Call `OptionValue[...]`
   * Are the *only* place that interprets their owned options

2. **Wrapper / orchestrator / pipeline functions**

   * Have **only orchestration options** (and possibly mapping options like `BuildMaxMaturity`)
   * Do not call `OptionValue` for options they don’t own
   * Only forward options using `FilterRules`

This single change eliminates most of the “overlapping owners” in your `options-ownership.md` almost mechanically.

---

## 6) Specific fixes for the options you explicitly decided on

### 6.1 `Signs` → owned by `solveCoeffRoots` (inline-style)

Your analysis currently flags multiple owners (`solveCoeffRoots`, `bindUnary`, `findRootInterval`). You want **one owner** with no need to distinguish different values.

**Make this true in code by design:**

* `solveCoeffRoots`:

  * keeps option `"Signs"` (or whatever final name you choose)
  * reads it once (`signSpec = OptionValue["Signs"]`)
  * converts it into a canonical internal form (e.g., list of sign vectors / an association keyed by variable)
  * passes the canonical form as an **argument** downstream

* `bindUnary` and `findRootInterval`:

  * **remove** `"Signs"` from their owned options
  * do **not** call `OptionValue["Signs"]`
  * accept `signs_` (or `signData_`) as a positional argument

Result:

* Only `solveCoeffRoots` consumes `"Signs"` (satisfies “single owner”)
* You still get full configurability from upstream calls (everything can pass `"Signs"->...` into `solveCoeffRoots` via `OptionsPattern[{..., solveCoeffRoots, ...}]`)

---

### 6.2 `FromScratch` → single option

Currently it’s owned in more than one build function.

**Make one orchestrator the only owner.** In practice:

* Choose **one** entry function that truly decides “from scratch” (e.g., `buildModelsInternal` or your top `buildModels`).
* That function owns `"FromScratch"` and calls `OptionValue` on it.
* Every other function receives a boolean `fromScratch_True|False` argument (or a small “build plan” association that includes it) and never reads the option.

This avoids the “two entry points both consuming it” problem.

---

### 6.3 `CreateMoments` → single option

Same solution as `FromScratch`:

* Single orchestrator owns it
* Everyone else receives a boolean argument or a structured “plan”
* No other function calls `OptionValue["CreateMoments"]`

---

### 6.4 `SignSymbol` → split (because the types/semantics differ)

Your own `options-issues.md` notes the dual type is intentional: Symbolic wants a `Symbol`, compile wants a `String`.

So do what you said: **split**.

My strong recommendation (because it eliminates ambiguity *and* stays readable):

* **Symbolic** (owned by `paramQuadSolve` or inside the `paramQuadSolveOptions` bundle):

  * Name: `"SignVariableSymbol"` (value is a `Symbol`)
* **Compile** (owned by `buildKernel`):

  * Name: `"SignVariableName"` (value is a `String`)

This is clearer than keeping the same name with two types.

If you really want to keep a “simple user-facing” name, then keep `"SignSymbol"` only for whichever side is *user-facing*, and rename the other to the more explicit internal name. But since you explicitly said “split it”, I’d just rename both to semantically correct names and be done.

---

### 6.5 `MaxMaturity` → split into exactly the two you specified (build vs toNum/yieldCurve)

The cleanest way to achieve your split **and** keep a single consumer for each option name is:

#### Option 1: build pipeline max maturity

* New option name: `"BuildMaxMaturity"`
* Owner: `buildModelsInternal` (the orchestration function)
* Used for: everything in your first tree:

  * `buildModels → buildModelsInternal`
  * `processModels → addCoeffsSolution`
  * `addCoeffsSolutionN → updateCoeffs → updateCoeffsSol`

**Key implementation detail:** downstream functions must *not* consume `"BuildMaxMaturity"`.
Instead, `buildModelsInternal` uses it to *construct explicit arguments* / mapped options.

#### Option 2: numerical / user-facing max maturity

* Keep simple user-facing name: `"MaxMaturity"`
* Owner: **pick exactly one** function that truly interprets it (best candidate is `updateCoeffsSol`)
* Used for: your second tree

  * `toNum → toNumRules → updateCoeffs → updateCoeffsSol`
  * `yieldCurve → updateCoeffs → updateCoeffsSol`

**How do `toNum` and `yieldCurve` avoid becoming owners?**

* They should *not* call `OptionValue["MaxMaturity"]`.
* They accept it via `OptionsPattern[{..., updateCoeffsSol, ...}]` and forward it.
* If they need a length for plotting/tables, they use:

  * data length from the returned structure, or
  * a value returned by `updateCoeffsSol` (e.g., include `"MaxMaturityUsed" -> maxMaturity` in the result association)

That way, `yieldCurve` participates in the dependency tree without consuming the option.

This exactly matches your intent: two different max-maturity knobs for two usage contexts, but **each option name has exactly one consumer**.

---

## 7) Remove the “central config system” as a source of truth (recommended)

Your current `options-defaults.md` / `options-issues.md` show the config layer is where a lot of drift and “dead option” behavior comes from (e.g., ignored `MaxMaturity` in Build, missing forwarding for `paramQuadSolveOptions`, etc.).

Since you want:

* no backward compatibility,
* simplest code,
* single source of truth = `Options[owner]`,

…then the simplest path is:

* Stop treating `defaultConfig[]` / `normalizeConfig` as authoritative.
* Make `buildModels[...]` a normal options-taking function:

  * `buildModels[args..., opts:OptionsPattern[{buildModels, buildModelsInternal, processModels, solveCoeffsSystem, paramQuadSolve, buildKernel, updateCoeffsSol, ...}]] := ...`

Now configuration is just “normal Wolfram options”.

If you still want a *structured* user experience (because there are many knobs), keep structure as **values** (bundles), not as a parallel defaults system. For example:

* `"FindRootOptions" -> {...}`
* `"paramQuadSolveOptions" -> <|...|>` or `{...}`

Those are fine because they are owned options on some function, not global defaults.

---

## 8) OptionsValidation integration that won’t fight the option system

You asked to use **OptionsValidation only**, no ErrorTools. That’s a good fit and it *won’t* get in the way if you keep it in one of two roles:

### Recommended role: validate at the boundary (public entry points + owners)

For each **public entry** and each **owner function**:

1. Keep the normal signature:

```wl
f[args___, opts : OptionsPattern[{f, child1, child2, ...}]] := Module[...]
```

2. At the very top, do:

```wl
If[!ValidOptionsQ[{f}][opts], Return[$Failed]];
```

3. Define `CheckOption[f, "optName"] = testFunction;` for your owned options.

This gives you:

* messages on invalid values,
* `$Failed` early,
* and it doesn’t change how option passing/forwarding works.

### Alternative role: `ValidOptionsPattern` instead of `OptionsPattern`

This is stricter (pattern won’t match), and I usually reserve it for “internal API / developer-facing” functions. If you want built-in-like behavior (messages + failure), the “boundary check + Return[$Failed]” approach tends to feel more natural.

Also: keep `CheckedDuplicate -> First` to match `OptionValue`’s semantics (first occurrence wins). ([Wolfram Documentation][1])

### Also do this (low effort, big win)

Call:

* `SetDefaultOptionsValidation[{list of public symbols}]`

so that `SetOptions[f, ...]` can’t corrupt your defaults.

---

## 9) A maintainable code layout for the refactor

To keep things sane long-term, I’d organize option management into **three paclet files** (even if the functions live elsewhere):

### `Kernel/Options/Defaults.wl`

* Contains only `Options[sym] = {...}` for owner symbols (and orchestration options).
* No forwarding logic.
* No central association.

### `Kernel/Options/Validation.wl`

* Contains only OptionsValidation rules:

  * `CheckOption[owner, "Opt"] = ...`
  * `CheckOptionRelations[owner] = ...` where needed
  * `SetDefaultOptionsValidation[...]` for the public API surface

### `Kernel/Options/Forwarding.wl` (optional)

* Tiny helpers that standardize forwarding:

  * `forward[opts_, child_] := Evaluate @ FilterRules[Flatten@{opts}, Options[child]]`
  * (and any “merge bundle + direct” helper you like)

This keeps “what options exist”, “what values are allowed”, and “how options move” separated and prevents accidental duplication.

---

## 10) A refactor checklist that directly matches your analysis outputs

Use your generated reports (`options-ownership.md`, `options-flow.md`, `options-issues.md`) as acceptance tests:

### Ownership acceptance tests

* Every option name appears in exactly one `Options[owner]`.
* Exactly one function calls `OptionValue["thatOption"]`.
* Every other occurrence is forwarding-only or mapped-from-another-option.

### Forwarding acceptance tests

* If `A` calls `B` and should accept `B`’s options, then:

  * `A` has `OptionsPattern[{A, B}]`
  * The call site uses `FilterRules[Flatten@{opts}, Options[B]]`
  * `A` does **not** declare any of `Options[B]` in `Options[A]`

### Precedence acceptance tests

* Direct user options beat bundled defaults because user rules are earlier. ([Wolfram Documentation][1])
* Bundled defaults beat the child’s own defaults (because they are explicitly passed).

---

## Summary of the concrete “fix plan” for your named decisions

* **`Signs`**: only `solveCoeffRoots` reads it; downstream gets positional `signData`.
* **`FromScratch`**: only one orchestrator reads it; downstream gets positional flag/plan.
* **`CreateMoments`**: same as FromScratch.
* **`SignSymbol`**: split into two options with two names + two owners, matching two semantics and two types.
* **`MaxMaturity`**:

  * `"BuildMaxMaturity"` owned by `buildModelsInternal`
  * `"MaxMaturity"` owned by `updateCoeffsSol`
  * wrappers (`toNum`, `yieldCurve`, `processModels`, …) forward but do not consume

This gives you:

1. **single source of truth** (defaults live only on owner symbols)
2. **single owner per option name** (by construction)
3. **pass-through for nested options** (no redeclaration; only `OptionsPattern` + `FilterRules`)
4. broadly matches the “Wolfram options” guidelines you uploaded.

If you want, in the next step I can take your current option list (from your `options-ownership.md`) and propose **an explicit new option table**: *old name → new name → owner → public/internal → notes*, including the exact renames for the multi-owner set.

[1]: https://reference.wolfram.com/language/ref/OptionValue.html?utm_source=chatgpt.com "OptionValue - Wolfram Language Documentation"
