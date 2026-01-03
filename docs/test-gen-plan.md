# Programmatic Refactoring of Wolfram `.wlt` Tests

This document describes the refactoring of existing Wolfram Language paclet `.wlt` tests using the **`WLTTestRefactor.wl`** package.

## Objective

Refactor existing Wolfram Language `.wlt` test files so that:

1. Each `.wlt` file is no longer handwritten as static tests.
2. Instead, each `.wlt` file is **generated programmatically** by Wolfram Language code.
3. The original test semantics are preserved exactly.
4. All tests have explicit, stable `TestID` values and explicit `TimeConstraint`s.
5. No test logic is converted to string-based representations.
6. All filesystem writes remain strictly inside the repository directory.

The refactoring must use the **`WLTTestRefactor.wl`** package as the primary transformation mechanism.

---

## Global Constraints (Non-Negotiable)

### Filesystem Safety

* **DO NOT** write files outside the repository root.
* All generated files must be placed under:

  ```
  <repo>/Tests/
  <repo>/Tests/Generators/
  ```
* Absolute paths outside the repo are forbidden.
* Temporary directories outside the repo are forbidden.

### Semantic Preservation

* **DO NOT** convert Wolfram expressions into strings.
* **DO NOT** use `ToString`, `InputForm`, `HoldForm // ToString`, or text templating.
* All tests must remain **held Wolfram expressions** (`HoldComplete`, `Hold`, `Unevaluated`).

### Test Meaning

* The evaluated behavior of every test must remain identical.
* Messages, outputs, and comparison semantics must not change unless explicitly configured.
* Existing setup code in `.wlt` files must remain setup code (not embedded inside tests).

---

## Preconditions

Before starting, ensure:

1. `WLTTestRefactor.wl` is available inside the repository.
2. All `.wlt` files currently pass under `TestReport`.
3. The agent has read/write access only to the repository working tree.

---

## High-Level Strategy

For **each existing `.wlt` file**:

1. Read the file as **held expressions**.
2. Produce a **generator `.wl` file** that:

   * Stores those expressions in held form.
   * Reconstructs the `.wlt` file programmatically.
   * Injects `TestID` and `TimeConstraint` deterministically.
3. Use the generator to recreate the original `.wlt`.
4. Verify the regenerated `.wlt` is semantically equivalent.
5. Repeat for all test files.

---

## Step-by-Step Procedure

### Step 1 — Enumerate Test Files

* Recursively find all `.wlt` files under:

  ```
  <repo>/Tests/
  ```
* Exclude:

  * Any directory named `Generators`
  * Any generated artifacts already produced by prior runs

Example selection logic (conceptual):

* Include: `Tests/**/*.wlt`
* Exclude: `Tests/Generators/**`

---

### Step 2 — Create Generator Directory

Ensure the directory exists:

```
<repo>/Tests/Generators/
```

Do **not** create directories elsewhere.

---

### Step 3 — Generate One Generator per `.wlt`

For each file:

* Input:

  ```
  Tests/Foo/BarTests.wlt
  ```

* Output generator:

  ```
  Tests/Generators/Foo/BarTests.wl
  ```

Preserve relative subdirectory structure.

---

### Step 4 — Invoke `WriteWLTGenerator`

For each `.wlt` file, call:

* `WLTTestRefactor\`WriteWLTGenerator`
* Required configuration:

  * Explicit `TimeConstraint` (e.g. 30–120 seconds)
  * Deterministic `TestID` generation
  * Preserve held expressions
  * Overwrite target allowed

**Key rules:**

* Prefer `TestCreate` over `VerificationTest` unless explicitly instructed otherwise.
* Do not inline or simplify expressions.
* Do not reorder setup code relative to tests.

---

### Step 5 — Validate Generator Output

For each generated `.wl` file:

1. Load the generator package.
2. Call its exported `GenerateWLT[]` function.
3. Ensure the regenerated `.wlt` file:

   * Is syntactically valid
   * Contains only Wolfram expressions
   * Has explicit `TestID` and `TimeConstraint` on every test

---

### Step 6 — Semantic Verification

For each regenerated `.wlt` file:

1. Run:

   ```
   TestReport[thatFile]
   ```
2. Compare outcomes with the original:

   * Same pass/fail count
   * Same messages
   * Same outputs
3. Differences are allowed **only** in:

   * `TestID` values
   * Explicit presence of `TimeConstraint`

All other differences are failures.

---

### Step 7 — Commit Structure (Optional)

If committing changes:

* Keep both:

  * Generator `.wl`
  * Generated `.wlt`
* Treat the `.wl` generator as **source of truth**
* The `.wlt` file is a derived artifact

---

## Naming & Identity Rules

### Generator Contexts

* Each generator must define a unique context based on file path.
* Context collisions are forbidden.

### TestID Rules

* `TestID` must be:

  * Deterministic
  * Stable across regenerations
  * Derived from test structure, not line numbers
* Hash-based IDs are acceptable.
* Duplicate tests must be disambiguated predictably.

---

## Prohibited Actions

The agent must **never**:

* Serialize expressions to strings
* Reparse code from text
* Write files to `/tmp`, `$HomeDirectory`, or system temp locations
* Modify production `.wl` code
* Change test ordering
* Introduce global state into tests
* Introduce FrontEnd dependencies

---

## Expected End State

After completion:

```
Tests/
├── Foo/
│   └── BarTests.wlt        # generated
├── Generators/
│   └── Foo/
│       └── BarTests.wl    # source
```

* All tests pass.
* Tests are programmatically generatable.
* Refactoring is repeatable and reviewable.
* Future test evolution happens in `.wl`, not `.wlt`.

---

## Guiding Principle

> Tests in the Wolfram Language are **data**, not scripts.
> This refactoring must preserve that property absolutely.

---

End of instructions.
