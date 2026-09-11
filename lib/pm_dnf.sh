run_updates() {
    if [ "$CHECK_MODE" = true ]; then
        run_cmd dnf check-update || true
        return 0
    fi

    run_cmd dnf upgrade -y
    run_cmd dnf autoremove -y || true
    run_cmd dnf clean all
}
