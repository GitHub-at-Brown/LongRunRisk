#!/bin/bash
# Generate coverage report for LongRunRisk paclet
# Runs Wolfram coverage analysis and generates HTML report via lcov/genhtml
#
# Usage: ./generate-coverage-report.sh [--mode=Auto|Baseline|Execution] [--verbose]
#
# Modes:
#   Auto      - Try execution coverage, fall back to baseline if it fails (default)
#   Baseline  - Only generate baseline coverage (code structure, no execution)
#   Execution - Attempt execution coverage, fail if it doesn't work

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PACLET_ROOT="$(dirname "$SCRIPT_DIR")"
COVERAGE_DIR="$PACLET_ROOT/build/coverage"

# === Parse arguments ===
MODE="Auto"
VERBOSE=""
for arg in "$@"; do
    case $arg in
        --mode=*)
            MODE="${arg#*=}"
            ;;
        --verbose|-v)
            VERBOSE="--verbose"
            ;;
    esac
done

# Validate mode
if [[ ! "$MODE" =~ ^(Auto|Baseline|Execution)$ ]]; then
    echo "Error: Invalid mode '$MODE'. Use Auto, Baseline, or Execution."
    exit 1
fi

echo "=== LongRunRisk Coverage Report Generator ==="
echo "Mode: $MODE"
echo ""

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

# === Run Wolfram coverage script ===
echo "Running coverage analysis..."
wolframscript "$PACLET_ROOT/Tests/RunCoverage.wls" --mode="$MODE" $VERBOSE

# === Check if coverage data exists ===
if [[ ! -f "$COVERAGE_DIR/baseline.lcov" ]]; then
    echo ""
    echo "Error: No coverage files generated."
    exit 1
fi

# === Generate HTML report ===
# Check if real execution coverage data exists (DA: lines indicate execution counts)
if grep -q "^DA:" "$COVERAGE_DIR/tests.lcov" 2>/dev/null; then
    echo ""
    echo "Execution coverage data found. Generating HTML report..."
    REPORT_TITLE="LongRunRisk Coverage"
else
    echo ""
    echo "Baseline coverage only. Generating HTML report..."
    REPORT_TITLE="LongRunRisk Coverage (Baseline)"
fi

check_command lcov "lcov"
check_command genhtml "lcov"

# Combine LCOV files
lcov --ignore-errors empty,corrupt \
     -a "$COVERAGE_DIR/baseline.lcov" \
     -a "$COVERAGE_DIR/tests.lcov" \
     -o "$COVERAGE_DIR/combined.lcov" 2>/dev/null || true

# Generate HTML report
genhtml --ignore-errors empty,corrupt,category \
        --num-spaces 4 \
        --title "$REPORT_TITLE" \
        "$COVERAGE_DIR/combined.lcov" \
        -o "$COVERAGE_DIR/html" 2>/dev/null || true

echo ""
echo "Coverage report generated at: $COVERAGE_DIR/html/index.html"

# Print summary if available
if [[ -f "$COVERAGE_DIR/combined.lcov" ]]; then
    lcov --ignore-errors empty,corrupt --summary "$COVERAGE_DIR/combined.lcov" 2>/dev/null || true
fi

# Open report (platform-specific, not in CI)
if [[ -z "${CI:-}" ]] && [[ -f "$COVERAGE_DIR/html/index.html" ]]; then
    REPORT_PATH="$COVERAGE_DIR/html/index.html"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        open "$REPORT_PATH"
    elif [[ "$OSTYPE" == "linux-gnu"* ]] && command -v xdg-open &> /dev/null; then
        xdg-open "$REPORT_PATH"
    else
        echo "Open $REPORT_PATH in your browser to view the report."
    fi
fi
