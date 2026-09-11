#!/usr/bin/env bash

echo "Running tests..."

# Get the absolute directory of the script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

bash -n "$DIR/../bin/sysupdate"
bash -n "$DIR/../lib/"*.sh

echo "Syntax OK"

bash "$DIR/test_utils.sh"
