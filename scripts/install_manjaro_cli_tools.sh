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

# Function to update the system
update_system() {
    echo "Updating system..."
    if ! sudo pacman -Syu --noconfirm; then
        echo "Failed to update system. Exiting."
        exit 1
    fi
}

# Function to install essential packages from official repositories
install_official_packages() {
    echo "Installing essential packages from official repositories..."
    if ! sudo pacman -S --noconfirm \
        git \
        vim \
        nano \
        emacs \
        tmux \
        screen \
        gcc \
        clang \
        make \
        cmake \
        python3 \
        nodejs \
        npm \
        python-pip \
        cargo \
        htop \
        btop \
        procps \
        du \
        df \
        free \
        iostat \
        sysstat \
        lsblk \
        fdisk \
        blkid \
        parted \
        curl \
        wget \
        openssh \
        rsync \
        net-tools \
        inetutils \
        iproute2 \
        traceroute \
        nmap \
        networkmanager \
        bind-tools \
        whois \
        fish \
        bash \
        zsh \
        fzf \
        ripgrep \
        the_silver_searcher \
        bat \
        exa \
        tldr \
        jq \
        yq \
        ncdu \
        neofetch \
        man-db; then
        echo "Failed to install packages from official repositories. Exiting."
        exit 1
    fi
}

# Function to install additional packages from AUR
install_aur_packages() {
    echo "Installing AUR helper..."
    git clone https://aur.archlinux.org/yay.git
    if [ $? -ne 0 ]; then
        echo "Failed to clone yay repository. Exiting."
        exit 1
    fi
    cd yay
    if ! makepkg -si --noconfirm; then
        echo "Failed to install yay. Exiting."
        exit 1
    fi
    cd ..
    rm -rf yay

    echo "Installing AUR packages..."
    if ! yay -S --noconfirm btop wttr; then
        echo "Failed to install packages from AUR. Exiting."
        exit 1
    fi
}

# Main script logic
main() {
    update_system
    install_official_packages
    install_aur_packages

    echo "Installation complete. Please reboot the system."
}

# Run the main function
main
