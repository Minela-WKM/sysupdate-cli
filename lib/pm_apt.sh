run_updates() {
    if [ "$CHECK_MODE" = true ]; then
        DEBIAN_FRONTEND=noninteractive run_cmd apt list --upgradable
        return 0
    fi

    DEBIAN_FRONTEND=noninteractive run_cmd apt update
    DEBIAN_FRONTEND=noninteractive run_cmd apt upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"
    DEBIAN_FRONTEND=noninteractive run_cmd apt autoremove -y
    DEBIAN_FRONTEND=noninteractive run_cmd apt autoclean
}
