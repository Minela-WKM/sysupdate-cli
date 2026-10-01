run_updates() {
    if [ "$CHECK_MODE" = true ]; then
        run_cmd pacman -Qu || true
        return 0
    fi

    run_cmd pacman -Syu --noconfirm
    run_cmd pacman -Sc --noconfirm
}
