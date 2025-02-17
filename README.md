# OpenVPN SAML Manager for Linux

A GUI tool for managing OpenVPN connections with SAML authentication support. This application provides a user-friendly interface for connecting to OpenVPN Access Servers using the OpenVPN 3 client.

## Features

- Simple GUI interface for OpenVPN connections
- SAML authentication support
- Easy profile configuration
- Connection status monitoring
- Session details viewer
- System tray integration
- Cross-distribution compatibility

## System Requirements

### Supported Distributions
- Ubuntu/Kubuntu (Tested on Kubuntu with KDE Plasma)
- Debian-based distributions
- Fedora
- Arch Linux
- Other Linux distributions with OpenVPN3 support

### Dependencies
- OpenVPN3 (`openvpn3`)
- KDE Plasma Desktop Environment
- KDialog (`kdialog`)
- Bash shell
- OpenVPN Access Server profile (`.ovpn` file)

## Installation

### Automatic Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/StefTzor/ovpn-saml-manager.git
   cd ovpn-saml-manager
   ```

2. Run the installer:
   ```bash
   ./install.sh
   ```

   The installer will:
   - Check and install required dependencies
   - Create necessary directories
   - Set up the application structure
   - Create desktop entries
   - Configure initial VPN profile

### Manual Installation

1. Ensure OpenVPN3 is installed on your system:

   For Ubuntu/Debian:
   ```bash
   sudo apt-get update
   sudo apt-get install openvpn3
   ```

   For Fedora:
   ```bash
   sudo dnf install openvpn3-client
   ```

   For Arch Linux:
   ```bash
   sudo pacman -Sy openvpn3
   ```

2. Install KDialog if not already installed:

   For Ubuntu/Debian:
   ```bash
   sudo apt-get install kdialog
   ```

   For Fedora:
   ```bash
   sudo dnf install kde-cli-tools
   ```

   For Arch Linux:
   ```bash
   sudo pacman -S kdialog
   ```

3. Clone the repository and set up manually:
   ```bash
   git clone https://github.com/StefTzor/ovpn-saml-manager.git
   cd ovpn-saml-manager
   mkdir -p ~/.local/share/ovpn-saml-manager
   mkdir -p ~/.local/bin
   mkdir -p ~/.local/share/applications
   mkdir -p ~/.config/ovpn-saml-manager
   cp vpn-connect vpn-config ~/.local/share/ovpn-saml-manager/
   chmod +x ~/.local/share/ovpn-saml-manager/*
   ```

## Usage

### First Time Setup

1. Launch OpenVPN Manager from your application menu or run:
   ```bash
   ovpn-saml-manager
   ```

2. On first launch, you'll be prompted to configure your VPN profile
3. Select your `.ovpn` profile file when prompted
4. The application will save your configuration

### Daily Use

1. Launch OpenVPN Manager from your application menu or terminal
2. Use the GUI to:
   - Connect to VPN
   - Disconnect from VPN
   - View connection details
   - Reconfigure VPN profile

### SAML Authentication

When connecting to a SAML-enabled OpenVPN server:
1. Click "Connect VPN"
2. Your default web browser will open with the SAML authentication page
3. Complete the authentication process
4. Return to OpenVPN Manager to see your connection status

## File Locations

- Application files: `~/.local/share/ovpn-saml-manager/`
- Configuration: `~/.config/ovpn-saml-manager/`
- Desktop entry: `~/.local/share/applications/ovpn-saml-manager.desktop`
- Executable links: `~/.local/bin/ovpn-saml-manager`

## Troubleshooting

### Common Issues

1. **OpenVPN Manager doesn't launch**
   - Ensure all dependencies are installed
   - Check if KDE Plasma is running
   - Verify file permissions

2. **Cannot connect to VPN**
   - Verify your `.ovpn` profile is valid
   - Check your internet connection
   - Ensure OpenVPN3 service is running

3. **SAML authentication fails**
   - Check your browser's popup settings
   - Verify your credentials
   - Ensure your system time is correct

### Debug Logs

For troubleshooting, you can run OpenVPN Manager from the terminal to see debug output:
```bash
ovpn-saml-manager
```

You can also check OpenVPN3 logs:
```bash
openvpn3 log --session-path <session-path>
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- OpenVPN team for OpenVPN3
- KDE team for KDialog and Plasma desktop environment

## Contact

Project Link: [https://github.com/StefTzor/ovpn-saml-manager](https://github.com/StefTzor/ovpn-saml-manager)
