# MintOS Setup

## Overview
This script automates the installation of common tools and applications I tend to use on a fresh MintOS machine or VM.  

It installs applications via `apt` or Flatpak where appropriate, and ensures Visual Studio Code is installed via `.deb` instead of Flatpak for better native development compatibility.

## What It Installs
- **Node.js** – system-wide installation via `apt`
- **Flox** – downloaded `.deb` package
- **Git** – installed via `apt`
- **GitHub Desktop** – installed via Flatpak
- **Spotify** – installed via Flatpak
- **Visual Studio Code** – installed via `.deb` package from Microsoft


## Why VS Code is NOT Installed via Flatpak
The Flatpak version of VS Code runs in a sandbox, limiting access to system toolchains, `/usr` libraries, and host shells.  
This breaks many native development workflows (e.g., Go, C/C++) and requires duplicate toolchains inside the container.

Reference: [VS Code Flatpak limitations](https://bentsukun.ch/posts/vscode-flatpak/)

# Next steps

- Firefox bookmarks
- Enforce theme
- More testing/refining on mint VMS and physical machines

# usage from a remote machine
`bash <(curl -fsSL https://raw.githubusercontent.com/anguzz/homelab/main/automation/scripts/mint_setup/setup.sh)`
