#!/bin/bash

# Function to display a message and run a command
run_command() {
    local cmd="$1"
    echo "Running: $cmd"
    if ! eval "$cmd"; then
        echo "Error: Command failed - $cmd"
        exit 1
    fi
}

# Function to detect the Linux distribution
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    else
        echo "unknown"
    fi
}

# Function to back up existing configuration files
backup_file() {
    local file="$1"
    if [ -e "$file" ]; then
        local backup="${file}.bak.$(date +%Y%m%d%H%M%S)"
        mv "$file" "$backup"
        echo "Backed up $file to $backup"
    fi
}

# Install essential packages
install_packages() {
    local packages=(git vim nano emacs tmux screen gcc clang make cmake python3 nodejs npm python3-pip cargo htop btop procps du df free iostat sysstat lsblk fdisk blkid parted curl wget openssh-client rsync net-tools inetutils-tools iproute2 traceroute nmap network-manager dnsutils whois fish bash zsh fzf ripgrep silversearcher-ag bat exa tldr jq yq ncdu neofetch man-db)

    case "$distro" in
        arch)
            run_command "sudo pacman -S --noconfirm ${packages[@]}"
            ;;
        ubuntu)
            run_command "sudo apt install -y ${packages[@]}"
            ;;
        *)
            echo "Unsupported Linux distribution: $distro"
            exit 1
            ;;
    esac
}

# Install AUR packages for Arch Linux
install_aur_packages() {
    if [ "$distro" = "arch" ]; then
        run_command "git clone https://aur.archlinux.org/yay.git"
        cd yay
        run_command "makepkg -si --noconfirm"
        cd ..
        rm -rf yay
        run_command "yay -S --noconfirm btop wttr"
    fi
}

# Setup tmux configuration
setup_tmux() {
    echo "Setting up tmux configuration..."
    backup_file "$HOME/.tmux.conf"
    cp "$CONFIG_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
    echo "tmux configuration set up successfully."
}

# Setup vim configuration
setup_vim() {
    echo "Setting up vim configuration..."
    backup_file "$HOME/.vimrc"
    cp "$CONFIG_DIR/vim/.vimrc" "$HOME/.vimrc"
    echo "vim configuration set up successfully."
}

# Setup fish configuration
setup_fish() {
    echo "Setting up fish configuration..."
    mkdir -p "$HOME/.config/fish"
    backup_file "$HOME/.config/fish/config.fish"
    cp "$CONFIG_DIR/fish/config.fish" "$HOME/.config/fish/config.fish"
    echo "fish configuration set up successfully."
}

# Setup SSH keys
setup_ssh() {
    echo "Setting up SSH keys..."
    run_command "ssh-keygen -t rsa -b 4096 -C 'your_email@example.com' -f $HOME/.ssh/id_rsa -N ''"
    run_command "eval \$(ssh-agent -s)"
    run_command "ssh-add $HOME/.ssh/id_rsa"
    echo "SSH keys set up successfully."
}

# Main script logic
main() {
    CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/config"
    SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/scripts"

    # Detect the Linux distribution
    distro=$(detect_distro)
    echo "Detected Linux distribution: $distro"

    # Navigate to the scripts directory and run the relevant OS install script
    case "$distro" in
        arch)
            run_command "bash $SCRIPTS_DIR/install_arch_cli_tools.sh"
            ;;
        ubuntu)
            run_command "bash $SCRIPTS_DIR/install_ubuntu_cli_tools.sh"
            ;;
        *)
            echo "Unsupported Linux distribution: $distro"
            exit 1
            ;;
    esac

    # Run setup steps
    install_packages
    install_aur_packages
    setup_tmux
    setup_vim
    setup_fish
    setup_ssh

    echo "All setup steps completed successfully. Please reboot the system if necessary."
}

# Run the main function
main
