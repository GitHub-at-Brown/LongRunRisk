You are an agentic coding LLM working in the repo of a Wolfram Language paclet.
Context: tests have already been reorganized into a small set of coherent .wlt files
(e.g. Tests/Unit/*.wlt, Tests/Integration/*.wlt), each containing multiple VerificationTest/TestCreate tests.

GOAL
Create a single INTERACTIVE FRONT END “Testing Notebook” (.nb) that contains ALL tests, organized into
sections mirroring the new .wlt structure. The notebook must be:
- Openable in Mathematica/Wolfram Desktop and immediately usable with the built-in testing UI.
- Reproducible and generated from the .wlt sources (so CI stays anchored to .wlt, notebook stays in sync).
- Validatable headlessly via TestReport on the notebook file.

NON-GOALS
- Do not rewrite the tests or change their semantics.
- Do not replace the .wlt-based CI flow; keep .wlt as the canonical automated-test format.
- Do not require manual notebook editing to keep it up-to-date.

PRIMARY TECH CHOICE
Use ResourceFunction["WLTToNotebook"] to convert .wlt -> Testing Notebook cells, then merge into one master notebook.
This is the clean inverse of the Testing Notebook toolbar “Save As .wlt” feature.

DELIVERABLES (commit to repo)
1) A generated Testing Notebook, e.g.:
   Tests/LongRunRiskTestSuite.nb  (or Tests/Interactive/LongRunRiskTestSuite.nb)
2) A generator script runnable from the command line, e.g.:
   Scripts/GenerateTestNotebook.wls
   - idempotent: running it twice produces identical notebook output (modulo ExpressionUUIDs if unavoidable).
3) A short README snippet / docs note explaining:
   - how to regenerate the notebook
   - how to run tests from it
   - how to run tests headlessly using TestReport

ACCEPTANCE CRITERIA (must all pass)
A) Notebook generation:
   - Running wolframscript -f Scripts/GenerateTestNotebook.wls creates/updates Tests/LongRunRiskTestSuite.nb.
   - Notebook contains ALL tests from all .wlt files under Tests/ (excluding any build artifacts).
   - Notebook sections are grouped by logical category (mirroring folder/file grouping).

B) Interactive behavior (Front End):
   - Opening Tests/LongRunRiskTestSuite.nb shows a Testing Notebook with the test toolbar/docked cell.
   - Clicking Run evaluates setup code (Environ) and runs all tests.
   - All tests succeed in a clean kernel (no leftover globals).

C) Headless behavior:
   - In a fresh kernel session, TestReport["Tests/LongRunRiskTestSuite.nb"] runs and reports AllTestsSucceeded -> True.
   - In the same fresh session, TestReport[listOfWltFiles] also succeeds.

D) CI compatibility:
   - Existing .wlt execution path remains unchanged.
   - If the project uses PacletCICD/TestPaclet, it still finds and runs the .wlt tests as before.

STEP-BY-STEP IMPLEMENTATION PLAN

PHASE 0 — DISCOVERY / INVENTORY (do this first, in code)
1) Determine paclet root directory robustly:
   - Starting from DirectoryName[$InputFileName] (generator script location), walk upward until PacletInfo.wl exists.
   - Store as pacletRoot.

2) Enumerate test files:
   - testFiles = FileNames["*.wlt", FileNameJoin[{pacletRoot, "Tests"}], Infinity]
   - Exclude:
     - build output directories (e.g. build/, target/, .paclet-workflow-values/, etc.)
     - any generated “AllTests.wlt” if you prefer to avoid duplication OR include it only if it is the canonical suite.
   - Sort deterministically (path sort).

3) Identify grouping:
   - Group by the first directory under Tests (e.g. Unit, Integration, Property, etc.).
   - Within each group, order by filename.
   - This grouping must become notebook Sections/Subsections.

PHASE 1 — NOTEBOOK TEMPLATE + PACLET LOADING (Environ cell)
4) Create a base Testing Notebook template:
   Option A (preferred): Generate from the first test file via WLTToNotebook so you inherit correct style/docked UI.
   Option B: Use CreateNotebook["Testing"] if front end available; otherwise embed a minimal template from A.

5) Insert a TOP “Environ” cell (gray background) that prepares the test environment.
   Requirements for setup code:
   - Set pacletRoot dynamically:
       - If NotebookFileName[] is available, derive root from NotebookDirectory[] walking upward to PacletInfo.wl.
       - Fallback: use Directory[] or $InputFileName if running headlessly.
   - Load the paclet FROM SOURCE (dev mode), not a random installed version:
       - PacletDirectoryLoad[pacletRoot];
       - Determine paclet’s primary context from PacletInfo.wl or from Kernel/*.wl and call Needs[thatContext].
   - Ensure deterministic behavior:
       - Optionally set $HistoryLength = 0;
       - Clear/Reset any global symbols that tests might depend on.
   - Do NOT hardcode absolute paths.

PHASE 2 — CONVERT EACH .WLT -> NOTEBOOK CELLS
6) Ensure ResourceFunction["WLTToNotebook"] is available:
   - If ResourceFunction["WLTToNotebook"] does not exist, attempt to load it.
   - If the environment is offline, provide a fallback path:
       Fallback strategy:
       - Parse .wlt as held expressions (do not evaluate tests).
       - Convert each VerificationTest/TestCreate expression into a test cell group.
   - Prefer the ResourceFunction path whenever possible.

7) Convert each test file:
   - nbPart = ResourceFunction["WLTToNotebook"][file]
   - Extract ONLY the test cell groups (and any BeginTestSection-derived structure) from nbPart.
   - Wrap extracted cells under:
       Cell["<relative path or friendly name>", "Section"] (or "Subsection") before the tests from that file.

8) Merge into one master notebook:
   - Notebook cells structure:
       Title cell: “LongRunRisk Test Suite”
       Text cell: “GENERATED FILE — edit .wlt tests, then run Scripts/GenerateTestNotebook.wls”
       (Optional) A small “Table of Contents” cell with buttons linking to each Section.
       Environ cell (setup)
       Then: Section per group; Subsection per file; tests.

9) Keep the notebook “clean”:
   - Ensure no prior results (“Success/Failure” output blocks) are saved into the generated .nb.
   - Avoid evaluating tests during generation.
   - If generation runs in a front end session, explicitly clear test results before saving.

PHASE 3 — SAVE + IDEMPOTENCE
10) Save the notebook deterministically:
   - Export to a fixed path: Tests/LongRunRiskTestSuite.nb
   - Prefer Export[out, nbExpr, "NB"] or Put[nbExpr, out] depending on the structure you build.
   - If notebook diffs are noisy:
       - Consider stripping volatile metadata (ExpressionUUID) only if it does not break Testing Notebook behavior.
       - Document whichever approach you implement.

11) Add a “regenerate” convenience:
   - Either:
     - a button cell in the notebook that runs the generator script (nice UX), OR
     - a documented command in README.

PHASE 4 — VALIDATION (must be part of the agent’s work)
12) Headless validation (scriptable):
   - In generator script (or separate validation script):
       - reportWLT = TestReport[testFiles];
       - reportNB  = TestReport[outputNotebookPath];
       - Assert both report objects indicate all tests succeeded.
   - Exit non-zero if either fails (so CI can gate on it).

13) Front end validation (manual but documentable):
   - Open the notebook and click Run.
   - Confirm summary shows all successes.

PHASE 5 — OPTIONAL: CI “SYNC CHECK”
14) Optional but recommended:
   - Add a CI step that runs Scripts/GenerateTestNotebook.wls and fails if git diff shows changes.
   - This prevents notebook drift from .wlt sources.

IMPLEMENTATION NOTES / TIPS FOR SUCCESS
- Treat .wlt as canonical; notebook is a generated view.
- Preserve TestID options if present (don’t reassign IDs during generation).
- Don’t assume WLTToNotebook supports TestSuite[...] wrapper files; prefer converting leaf .wlt test files.
- Use TestReport as the canonical runner for validation, since it supports both plain files and testing notebooks.

OUTPUT CHECKLIST (what to commit)
- Scripts/GenerateTestNotebook.wls
- Tests/LongRunRiskTestSuite.nb
- Documentation snippet in README or docs/Testing.md describing usage.

When you’re done, show:
- The path to the generated notebook
- The command to regenerate it
- The command to validate it headlessly
- A brief description of notebook organization (sections/files)
