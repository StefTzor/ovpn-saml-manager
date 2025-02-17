# OpenVPN SAML Manager

# Repository Structure
ovpn-saml-manager/
├── install.sh
├── vpn-config
├── vpn-connect
├── README.md
├── LICENSE

# install.sh
```bash
#!/bin/bash

# Exit on any error
set -e

# Installation paths
INSTALL_DIR="$HOME/.local/share/openvpn-manager"
BIN_DIR="$HOME/.local/bin"
DESKTOP_DIR="$HOME/.local/share/applications"
CONFIG_DIR="$HOME/.config/openvpn-manager"

# Function to detect package manager and install dependencies
install_dependencies() {
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y openvpn3 kdialog
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y openvpn3-client kde-cli-tools
    elif command -v pacman &> /dev/null; then
        sudo pacman -Sy openvpn3 kdialog
    else
        echo "Unsupported distribution. Install openvpn3 manually."
        exit 1
    fi
}

check_dependencies() {
    if ! command -v openvpn3 &> /dev/null; then
        echo "Installing OpenVPN3..."
        install_dependencies
    fi

    if ! command -v kdialog &> /dev/null; then
        echo "Installing KDialog..."
        install_dependencies
    fi
}

create_directories() {
    mkdir -p "$INSTALL_DIR" "$BIN_DIR" "$DESKTOP_DIR" "$CONFIG_DIR"
}

install_files() {
    cp "$(dirname "$0")/vpn-connect" "$INSTALL_DIR/"
    cp "$(dirname "$0")/vpn-config" "$INSTALL_DIR/"
    chmod +x "$INSTALL_DIR/"*

    cat > "$BIN_DIR/openvpn-manager" << 'EOF'
#!/bin/bash
exec "$HOME/.local/share/openvpn-manager/vpn-connect"
EOF

    cat > "$BIN_DIR/openvpn-manager-config" << 'EOF'
#!/bin/bash
exec "$HOME/.local/share/openvpn-manager/vpn-config"
EOF

    chmod +x "$BIN_DIR/openvpn-manager" "$BIN_DIR/openvpn-manager-config"
}

echo "Checking dependencies..."
check_dependencies

echo "Creating directories..."
create_directories

echo "Installing application files..."
install_files

echo "Installation complete!"
```

# LICENSE (MIT License)
```plaintext
MIT License

Copyright (c) 2025 StefTzor

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction...
```

# README.md
```markdown
# OpenVPN SAML Manager

## Overview
OpenVPN SAML Manager is a lightweight Bash-based tool for easily connecting to OpenVPN Access Servers using SAML authentication, with a simple GUI via KDialog.

## Features
- One-click VPN connection and disconnection
- Secure configuration management
- Status monitoring and detailed session info

## Installation
### Dependencies
- **Kubuntu/Debian-based**: `sudo apt install openvpn3 kdialog`
- **Fedora**: `sudo dnf install openvpn3-client kde-cli-tools`
- **Arch Linux**: `sudo pacman -Sy openvpn3 kdialog`

### Install
```bash
git clone https://github.com/StefTzor/ovpn-saml-manager.git
cd ovpn-saml-manager
chmod +x install.sh
./install.sh
```

## Usage
- **Connect to VPN**: Run `openvpn-manager`
- **Configure VPN Profile**: Run `openvpn-manager-config`

## License
This project is licensed under the MIT License.
