## 2026-09-11 - Avoid Subprocesses for File Appending
**Learning:** Piping `echo` to `tee -a file >/dev/null` spawns unnecessary subshells and a `tee` process, which can be computationally expensive (taking around ~3.0s for 1000 iterations compared to ~0.04s for a direct append).
**Action:** Use `>> file` instead of piping to `tee` when only appending to a file without needing standard output visibility.
