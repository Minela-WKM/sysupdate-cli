run_updates() {
    if [ "$CHECK_MODE" = true ]; then
        run_cmd yum check-update || true
        return 0
    fi

    run_cmd yum upgrade -y
    run_cmd yum autoremove -y || true
    run_cmd yum clean all
}