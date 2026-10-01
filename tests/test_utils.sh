#!/usr/bin/env bash

# Get the absolute directory of the script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Source the utils file to test it
source "$DIR/../lib/utils.sh"

# Simple assertion function
assert_equal() {
    local expected="$1"
    local actual="$2"
    local message="$3"

    if [ "$expected" == "$actual" ]; then
        echo "✅ PASS: $message"
    else
        echo "❌ FAIL: $message (Expected: $expected, Got: $actual)"
        exit 1
    fi
}

echo "Running tests for parse_args..."

# Test 1: No arguments
parse_args
assert_equal "false" "$VERBOSE" "No arguments: VERBOSE should be false"
assert_equal "false" "$DRY_RUN" "No arguments: DRY_RUN should be false"
assert_equal "false" "$CHECK_MODE" "No arguments: CHECK_MODE should be false"

# Test 2: --verbose argument
parse_args --verbose
assert_equal "true" "$VERBOSE" "--verbose: VERBOSE should be true"
assert_equal "false" "$DRY_RUN" "--verbose: DRY_RUN should be false"
assert_equal "false" "$CHECK_MODE" "--verbose: CHECK_MODE should be false"

# Test 3: --dry-run argument
parse_args --dry-run
assert_equal "false" "$VERBOSE" "--dry-run: VERBOSE should be false"
assert_equal "true" "$DRY_RUN" "--dry-run: DRY_RUN should be true"
assert_equal "false" "$CHECK_MODE" "--dry-run: CHECK_MODE should be false"

# Test 4: --check argument
parse_args --check
assert_equal "false" "$VERBOSE" "--check: VERBOSE should be false"
assert_equal "false" "$DRY_RUN" "--check: DRY_RUN should be false"
assert_equal "true" "$CHECK_MODE" "--check: CHECK_MODE should be true"

# Test 5: Multiple arguments
parse_args --verbose --dry-run
assert_equal "true" "$VERBOSE" "Multiple args: VERBOSE should be true"
assert_equal "true" "$DRY_RUN" "Multiple args: DRY_RUN should be true"
assert_equal "false" "$CHECK_MODE" "Multiple args: CHECK_MODE should be false"

# Test 6: Unknown argument (should be ignored, default state maintained for matched variables)
parse_args --unknown-arg
assert_equal "false" "$VERBOSE" "Unknown arg: VERBOSE should be false"
assert_equal "false" "$DRY_RUN" "Unknown arg: DRY_RUN should be false"
assert_equal "false" "$CHECK_MODE" "Unknown arg: CHECK_MODE should be false"

echo "All parse_args tests passed!"

echo "Running tests for log_json..."

# Setup temporary log file
export JSON_LOG="/tmp/sysupdate_test.json"
rm -f "$JSON_LOG"

# Test 7: Normal message
log_json "info" "Normal message"
last_line=$(tail -n 1 "$JSON_LOG")
if [[ "$last_line" == *"\"message\":\"Normal message\""* ]]; then
    echo "✅ PASS: Normal message logging"
else
    echo "❌ FAIL: Normal message logging (Got: $last_line)"
    exit 1
fi

# Test 8: Message with double quotes
log_json "warn" 'Message with "quotes"'
last_line=$(tail -n 1 "$JSON_LOG")
if [[ "$last_line" == *"\"message\":\"Message with \\\"quotes\\\"\""* ]]; then
    echo "✅ PASS: Message with double quotes logging"
else
    echo "❌ FAIL: Message with double quotes logging (Got: $last_line)"
    exit 1
fi

# Test 9: Message with backslashes
log_json "error" 'Path C:\Windows\System32'
last_line=$(tail -n 1 "$JSON_LOG")
if [[ "$last_line" == *"\"message\":\"Path C:\\\\Windows\\\\System32\""* ]]; then
    echo "✅ PASS: Message with backslashes logging"
else
    echo "❌ FAIL: Message with backslashes logging (Got: $last_line)"
    exit 1
fi

# Test 10: Message with control characters (newline, tab, carriage return)
log_json "info" $'Line 1\nLine 2\tTabbed\rReturn'
last_line=$(tail -n 1 "$JSON_LOG")
if [[ "$last_line" == *"\"message\":\"Line 1\\nLine 2\\tTabbed\\rReturn\""* ]]; then
    echo "✅ PASS: Message with control characters logging"
else
    echo "❌ FAIL: Message with control characters logging (Got: $last_line)"
    exit 1
fi

# Cleanup
rm -f "$JSON_LOG"

echo "All log_json tests passed!"

exit 0
