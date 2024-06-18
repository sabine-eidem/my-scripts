#!/bin/bash

# Function to update the system
update_system() {
    echo "Updating system..."
    if ! sudo apt update && sudo apt upgrade -y; then
        echo "Failed to update system. Exiting."
        exit 1
    fi
}

# Function to install essential packages from official repositories
install_official_packages() {
    echo "Installing essential packages from official repositories..."
    if ! sudo apt install -y \
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
        python3-pip \
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
        openssh-client \
        rsync \
        net-tools \
        inetutils-tools \
        iproute2 \
        traceroute \
        nmap \
        network-manager \
        dnsutils \
        whois \
        fish \
        bash \
        zsh \
        fzf \
        ripgrep \
        silversearcher-ag \
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

# Main script logic
main() {
    update_system
    install_official_packages

    echo "Installation complete. Please reboot the system."
}

# Run the main function
main
