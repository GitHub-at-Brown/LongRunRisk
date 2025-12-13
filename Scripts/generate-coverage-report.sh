#!/bin/bash
# Generate coverage report for LongRunRisk paclet
# Runs Wolfram coverage analysis and generates HTML report via lcov/genhtml
#
# NOTE: Coverage tracking is currently disabled due to a bug in the Wolfram
# Instrumentation paclet that crashes when code uses Compile/FunctionCompile.
# This script runs tests and generates placeholder coverage files.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PACLET_ROOT="$(dirname "$SCRIPT_DIR")"
COVERAGE_DIR="$PACLET_ROOT/build/coverage"

# === Dependency checks ===
check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo "Error: $1 is not installed."
        echo "  macOS: brew install $2"
        echo "  Ubuntu: apt-get install $2"
        exit 1
    fi
}

check_command wolframscript "wolfram-engine"

# lcov/genhtml only needed if coverage is actually being collected
# (currently disabled due to Instrumentation bug)
# check_command lcov "lcov"
# check_command genhtml "lcov"

# === Run Wolfram tests (coverage collection disabled) ===
echo "Running tests..."
wolframscript "$PACLET_ROOT/Tests/RunCoverage.wls"

# === Check if real coverage data exists ===
# When coverage is enabled, files will have DA: (data) lines
if [[ -f "$COVERAGE_DIR/baseline.lcov" ]] && grep -q "^DA:" "$COVERAGE_DIR/baseline.lcov" 2>/dev/null; then
    echo ""
    echo "Coverage data found. Generating HTML report..."

    check_command lcov "lcov"
    check_command genhtml "lcov"

    # Combine LCOV files
    lcov --ignore-errors empty,corrupt \
         -a "$COVERAGE_DIR/baseline.lcov" \
         -a "$COVERAGE_DIR/tests.lcov" \
         -o "$COVERAGE_DIR/combined.lcov"

    # Generate HTML report
    genhtml --ignore-errors empty,corrupt \
            --num-spaces 4 \
            --title "LongRunRisk Coverage" \
            "$COVERAGE_DIR/combined.lcov" \
            -o "$COVERAGE_DIR/html"

    echo ""
    echo "Coverage report generated at: $COVERAGE_DIR/html/index.html"

    # Print summary
    lcov --ignore-errors empty,corrupt --summary "$COVERAGE_DIR/combined.lcov"

    # Open report (platform-specific)
    if [[ -z "${CI:-}" ]]; then
        REPORT_PATH="$COVERAGE_DIR/html/index.html"
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open "$REPORT_PATH"
        elif [[ "$OSTYPE" == "linux-gnu"* ]] && command -v xdg-open &> /dev/null; then
            xdg-open "$REPORT_PATH"
        else
            echo "Open $REPORT_PATH in your browser to view the report."
        fi
    fi
else
    echo ""
    echo "Note: Line-level coverage is disabled (Instrumentation paclet bug with Compile)."
    echo "Tests completed. Skipping HTML report generation."
fi
