#!/usr/bin/env bash

set -euo pipefail

# Helper function to print results
function assert_contains() {
    local haystack="$1"
    local needle="$2"
    if [[ "$haystack" != *"$needle"* ]]; then
        echo "FAIL: Expected output to contain '$needle'"
        exit 1
    fi
}

function assert_exit_code() {
    local expected="$1"
    local actual="$2"
    if [[ "$expected" != "$actual" ]]; then
        echo "FAIL: Expected exit code $expected, but got $actual"
        exit 1
    fi
}

# Get the directory of the test script to find logscan.sh correctly
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOGSCAN="$SCRIPT_DIR/logscan.sh"

# 1. Setup temporary log file
TEMP_LOG=$(mktemp)
cat <<EOF > "$TEMP_LOG"
2023-10-27 10:00:01 INFO: System started
2023-10-27 10:01:02 ERROR: Something went wrong
2023-10-27 10:01:02 ERROR: Something went wrong
2023-10-27 10:01:03 ERROR: Another thing went wrong
2023-10-27 10:02:04 WARNING: High memory usage
2023-10-27 10:03:05 DEBUG: Variable x is 10
EOF

echo "--- Running Tests for logscan.sh ---"

# Test 1: No arguments
echo "Test 1: No arguments..."
set +e
OUTPUT=$("$LOGSCAN" 2>&1)
EXIT_CODE=$?
set -e
assert_exit_code 1 "$EXIT_CODE"
assert_contains "$OUTPUT" "Usage:"

# Test 2: Missing file
echo "Test 2: Missing file..."
set +e
OUTPUT=$("$LOGSCAN" non_existent_file.log 2>&1)
EXIT_CODE=$?
set -e
assert_exit_code 1 "$EXIT_CODE"
assert_contains "$OUTPUT" "Error: file 'non_existent_file.log' not found."

# Test 3: Default pattern (ERROR)
echo "Test 3: Default pattern (ERROR)..."
OUTPUT=$("$LOGSCAN" "$TEMP_LOG")
assert_contains "$OUTPUT" "File    : $TEMP_LOG"
assert_contains "$OUTPUT" "Pattern : ERROR"
assert_contains "$OUTPUT" "Total lines : 6"
assert_contains "$OUTPUT" "Matches     : 3"
assert_contains "$OUTPUT" "2 2023-10-27 10:01:02 ERROR: Something went wrong"
assert_contains "$OUTPUT" "1 2023-10-27 10:01:03 ERROR: Another thing went wrong"

# Test 4: Custom pattern (WARNING)
echo "Test 4: Custom pattern (WARNING)..."
OUTPUT=$("$LOGSCAN" "$TEMP_LOG" "WARNING")
assert_contains "$OUTPUT" "Pattern : WARNING"
assert_contains "$OUTPUT" "Matches     : 1"
assert_contains "$OUTPUT" "1 2023-10-27 10:02:04 WARNING: High memory usage"

# Test 5: Pattern not found
echo "Test 5: Pattern not found..."
OUTPUT=$("$LOGSCAN" "$TEMP_LOG" "CRITICAL")
assert_contains "$OUTPUT" "Pattern : CRITICAL"
assert_contains "$OUTPUT" "Matches     : 0"
assert_contains "$OUTPUT" "No matches found."

# Cleanup
rm "$TEMP_LOG"

echo "--- All tests passed! ---"
