# My Scripts Collection

This repository contains a collection of scripts and configuration files for various tasks and setups. It includes scripts for both Ubuntu and Arch-based systems, as well as configuration files for `tmux`, `vim`, and `fish shell`.

## Directory Structure
```
my-scripts/
├── config/
│   ├── tmux/
│   │   └── .tmux.conf
│   ├── vim/
│   │   └── .vimrc
│   └── fish/
│       └── config.fish
├── dangerZone/
    └── reset_customizations.sh
├── scripts/
│   ├── install_arch_cli_tools.sh
│   ├── install_ubuntu_cli_tools.sh
│   └── other_script.sh
└── setup.sh

```




## Setup Instructions

To set up your development environment, simply run the `setup.sh` script. This script will handle everything, including:

- Detecting your Linux distribution (Arch, Manjaro, or Ubuntu).
- Installing essential packages.
- Installing additional packages from the AUR if you are using Arch or Manjaro Linux.
- Backing up any existing configuration files.
- Setting up `tmux`, `vim`, and `fish` configurations.
- Generating and setting up SSH keys.

### Steps to Run the Setup Script

1. **Clone the Repository**:
    ```bash
    git clone https://your-repo-url.git
    cd my-scripts
    ```

2. **Make the Setup Script Executable**:
    ```bash
    chmod +x setup.sh scripts/*.sh
    ```

3. **Run the Setup Script**:
    ```bash
    ./setup.sh
    ```

### What the Setup Script Does

- **Detects Linux Distribution**: Determines if you are using Arch, Manjaro, or Ubuntu.
- **Installs Packages**: Installs essential packages using `pacman` (for Arch and Manjaro) or `apt` (for Ubuntu).
- **Installs AUR Packages**: If using Arch or Manjaro, installs additional packages from the AUR.
- **Backs Up Existing Configurations**: Backs up existing `.tmux.conf`, `.vimrc`, and `config.fish` files.
- **Sets Up Configurations**: Copies new configuration files for `tmux`, `vim`, and `fish`.
- **Sets Up SSH Keys**: Generates SSH keys and adds them to the SSH agent.

### Example Configuration Scripts

- **tmux_script.sh**:
    ```bash
    #!/bin/bash
    echo "Setting up tmux configuration..."
    CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    cp "$CONFIG_DIR/.tmux.conf" "$HOME/.tmux.conf"
    echo "tmux configuration set up successfully."
    ```

- **vim_script.sh**:
    ```bash
    #!/bin/bash
    echo "Setting up vim configuration..."
    CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    cp "$CONFIG_DIR/.vimrc" "$HOME/.vimrc"
    echo "vim configuration set up successfully."
    ```

- **fish_script.sh**:
    ```bash
    #!/bin/bash
    echo "Setting up fish configuration..."
    CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    mkdir -p "$HOME/.config/fish"
    cp "$CONFIG_DIR/config.fish" "$HOME/.config/fish/config.fish"
    echo "fish configuration set up successfully."
    ```

## Reboot

After running the setup script, it is recommended to reboot your system to ensure all changes take effect.

```bash
sudo reboot
