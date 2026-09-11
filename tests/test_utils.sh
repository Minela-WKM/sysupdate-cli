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
exit 0
