#!/usr/bin/env bash

# Get the absolute directory of the script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Source the target file to test it
source "$DIR/../lib/pm_yum.sh"

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

echo "Running tests for pm_yum.sh..."

# Array to capture run_cmd arguments
declare -a RUN_CMD_ARGS=()

# Mock run_cmd
run_cmd() {
    # Store the entire command as a single array element
    RUN_CMD_ARGS+=("$*")
}

# Clear array before test
RUN_CMD_ARGS=()

# Call the function
run_updates

# Assert the number of calls
assert_equal "3" "${#RUN_CMD_ARGS[@]}" "run_updates should call run_cmd exactly 3 times"

# Check each call's arguments
if [ "${#RUN_CMD_ARGS[@]}" -eq 3 ]; then
    assert_equal "yum upgrade -y" "${RUN_CMD_ARGS[0]}" "First command should be 'yum upgrade -y'"
    assert_equal "yum autoremove -y" "${RUN_CMD_ARGS[1]}" "Second command should be 'yum autoremove -y'"
    assert_equal "yum clean all" "${RUN_CMD_ARGS[2]}" "Third command should be 'yum clean all'"
fi

echo "All pm_yum.sh tests passed!"
exit 0
