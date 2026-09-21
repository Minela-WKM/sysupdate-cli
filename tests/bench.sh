#!/usr/bin/env bash

source lib/utils.sh

LOG_FILE="/dev/null"

test_log_old() {
    for i in {1..1000}; do
        echo -e "test log message $i" | tee -a "$LOG_FILE" > /dev/null
    done
}

test_log_new() {
    for i in {1..1000}; do
        echo -e "test log message $i" > /dev/null
        echo -e "test log message $i" >> "$LOG_FILE"
    done
}

echo "Testing old log function..."
time test_log_old

echo "Testing new log function..."
time test_log_new
