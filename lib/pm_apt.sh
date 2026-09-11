run_updates() {
    if [ "$CHECK_MODE" = true ]; then
        run_cmd apt list --upgradable
        return 0
    fi

    run_cmd apt update
    run_cmd apt upgrade -y
    run_cmd apt autoremove -y
    run_cmd apt autoclean
}
