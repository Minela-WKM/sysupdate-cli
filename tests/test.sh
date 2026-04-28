#!/usr/bin/env bash

echo "Running tests..."

bash -n ../bin/sysupdate
bash -n ../lib/*.sh

echo "Syntax OK"

