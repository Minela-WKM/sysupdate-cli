
# 🚀 sysupdate-cli

> Lightweight DevOps CLI to automate Linux system updates with observability and cross-distro support.

![CI](https://img.shields.io/github/actions/workflow/status/Minela-WKM/sysupdate-cli/ci.yml?branch=main)
![License](https://img.shields.io/github/license/Minela-WKM/sysupdate-cli)
![Bash](https://img.shields.io/badge/Bash-CLI-green)
![Platform](https://img.shields.io/badge/Linux-multi--distro-blue)

---

## Why this project?

System updates on Linux are fragmented across package managers (APT, DNF, YUM, Pacman)  
and lack **standardization, visibility, and automation**.

 **sysupdate-cli** solves this with:

- unified interface
- structured logging (JSON)
- automation-ready design

---

## Features

- 📦 Cross-distro support (apt, dnf, yum, pacman)
- 📊 JSON logging (SIEM-ready)
- 🔍 Check mode (safe inspection)
- 🧪 Dry-run mode (no risk execution)
- 🔊 Verbose / silent modes
- 🧱 Modular architecture
- ⚙️ CI/CD ready (GitHub Actions)

---

## 🎬 Demo

![demo](docs/demo.gif)

---

## ⚙️ Installation

```bash
git clone https://github.com/Minela-WKM/sysupdate-cli.git
cd sysupdate-cli
chmod +x install.sh
./install.sh
````

---

## 🚀 Usage

```bash
sudo sysupdate
sudo sysupdate --verbose
sudo sysupdate --dry-run
sudo sysupdate --check
```

---

## 🧠 Architecture

```text
bin/        → CLI entrypoint  
lib/        → core logic + package managers  
tests/      → validation  
.github/    → CI/CD pipeline  
```

---

## 📊 Example JSON Log

```json
{
  "time": "2026-04-28T10:00:00",
  "level": "info",
  "message": "apt update"
}
```

---

## 🤝 Contributing

PRs welcome. Keep it simple, clean, and production-oriented.

---

## 📄 License

MIT

---

## 👨‍💻 Author

**Lamine DIOP**
Junior DevOps / Software Engineer
