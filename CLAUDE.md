# Project-Specific Claude Rules

## Testing Protocol

**CRITICAL**: When running tests for this project, ALWAYS follow this protocol to prevent hanging:

1. Run ONE single test at a time (NOT one file, NOT multiple tests)
2. Save output to a file (redirect/pipe the output)
3. Do NOT read output directly from the test command
4. Read the output from the file after the test completes

Example:
```bash
# Run single test and save output
wolframscript -c 'TestReport["Tests/Tools/ToNumber.wlt", "TestID" -> "specific-test-id"]' > test_output.txt 2>&1

# Then read the output
cat test_output.txt
```

This approach prevents Claude Code from hanging when running tests.
