run_updates() {
    run_cmd yum upgrade -y
    run_cmd yum autoremove -y || true
    run_cmd yum clean all
}