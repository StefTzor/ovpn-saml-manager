# install.sh
#!/bin/bash

# Exit on any error
set -e

# Installation paths
INSTALL_DIR="$HOME/.local/share/openvpn-manager"
BIN_DIR="$HOME/.local/bin"
DESKTOP_DIR="$HOME/.local/share/applications"
CONFIG_DIR="$HOME/.config/openvpn-manager"

# Function to detect package manager and install openvpn3
install_openvpn3() {
    if command -v apt-get &> /dev/null; then
        # For Ubuntu/Debian
        sudo apt-get update
        sudo apt-get install -y openvpn3 kdialog
    elif command -v dnf &> /dev/null; then
        # For Fedora
        sudo dnf install -y openvpn3-client kde-cli-tools
    elif command -v pacman &> /dev/null; then
        # For Arch Linux
        sudo pacman -Sy openvpn3 kdialog
    else
        echo "Unsupported distribution. Please install openvpn3 manually."
        exit 1
    fi
}

# Check for required dependencies
check_dependencies() {
    if ! command -v openvpn3 &> /dev/null; then
        echo "Installing OpenVPN3..."
        install_openvpn3
    fi

    if ! command -v kdialog &> /dev/null; then
        echo "KDialog not found. Installing..."
        install_openvpn3
    fi
}

# Create all necessary directories
create_directories() {
    mkdir -p "$INSTALL_DIR" "$BIN_DIR" "$DESKTOP_DIR" "$CONFIG_DIR"
}

# Install application files
install_files() {
    # Copy scripts to installation directory
    cp "$(dirname "$0")/vpn-connect" "$INSTALL_DIR/"
    cp "$(dirname "$0")/vpn-config" "$INSTALL_DIR/"
    chmod +x "$INSTALL_DIR/"*

    # Create wrapper script for vpn-connect
    cat > "$BIN_DIR/openvpn-manager" << 'EOF'
#!/bin/bash
exec "$HOME/.local/share/openvpn-manager/vpn-connect"
EOF

    # Create wrapper script for vpn-config
    cat > "$BIN_DIR/openvpn-manager-config" << 'EOF'
#!/bin/bash
exec "$HOME/.local/share/openvpn-manager/vpn-config"
EOF

    chmod +x "$BIN_DIR/openvpn-manager" "$BIN_DIR/openvpn-manager-config"

    # Create desktop entry
    cat > "$DESKTOP_DIR/openvpn-manager.desktop" << EOF
[Desktop Entry]
Name=OpenVPN Manager
Comment=Manage OpenVPN connections with SAML authentication
Exec=$BIN_DIR/openvpn-manager
Icon=network-vpn
Type=Application
Categories=Network;
Terminal=false
X-KDE-StartupNotify=true

[Desktop Action Configure]
Name=Configure VPN Profile
Exec=$BIN_DIR/openvpn-manager-config
Icon=configure
EOF

    chmod +x "$DESKTOP_DIR/openvpn-manager.desktop"
}

# Main installation process
echo "Checking dependencies..."
check_dependencies

echo "Creating directories..."
create_directories

echo "Installing application files..."
install_files

echo "Installation completed successfully!"
echo "You can now launch OpenVPN Manager from your application menu"
echo "or run 'openvpn-manager' from the terminal."
