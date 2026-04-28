run_updates() {
    run_cmd dnf upgrade -y
    run_cmd dnf autoremove -y || true
    run_cmd dnf clean all
}