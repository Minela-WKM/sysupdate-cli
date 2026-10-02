## 2026-09-11 - Avoid Subprocesses for File Appending
**Learning:** Piping `echo` to `tee -a file >/dev/null` spawns unnecessary subshells and a `tee` process, which can be computationally expensive (taking around ~3.0s for 1000 iterations compared to ~0.04s for a direct append).
**Action:** Use `>> file` instead of piping to `tee` when only appending to a file without needing standard output visibility.
## 2026-09-11 - Shell Script Subshells & Process Forking in Logging
**Learning:** In Bash, using command substitution like `$(date)` or piping to utilities like `| tee` for frequent logging causes immense overhead due to constant process forking. A pipeline `echo ... | tee ... > /dev/null` spawns at least two processes just to append a line. For high-frequency functions, this can slow down execution dramatically (e.g. from 0.07s to 6.00s for 1000 calls).
**Action:** Replace external commands with Bash built-ins wherever possible in tight loops or frequent calls (like logging). For timestamps, use `printf '%(%Y-%m-%dT%H:%M:%S%z)T' -1` instead of `date`. For file appending, use `>> file` instead of `| tee -a file > /dev/null`.
