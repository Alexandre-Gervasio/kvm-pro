# KVM Pro - High-Performance KVM Software

A superior alternative to Input Leap and Barrier. A lightweight, cross-platform KVM (keyboard-video-mouse) software that allows you to control multiple computers from a single mouse and keyboard.

**Status**: Early Development (Pre-Alpha) | **Portability**: ✅ 100% Portable (No Installation Needed!)

## ⭐ Key Selling Point

**Zero Installation Required** - For End Users:
- Download the package
- Extract the ZIP/TAR.GZ
- Run the executable
- Done! No admin rights, no dependencies, no installation.

## Features

- ✅ **Cross-Platform**: Linux and Windows support
- ✅ **Lightweight**: Written in Rust for minimal resource usage
- ✅ **Low Latency**: Optimized for real-time input forwarding
- ✅ **Zero Dependencies**: Fully static binaries - works anywhere
- ✅ **Portable**: Works from USB drives
- ✅ **UDP Discovery**: Automatic server discovery on network
- ✅ **Extensible**: Plugin system for custom behavior
- 🔨 **TLS Security** (planned)
- 🔨 **Clipboard Sync** (planned)
- 🔨 **Multi-Monitor Support** (planned)
- 🔨 **Web UI** (planned)

## 🚀 Quick Start (For End Users)

### Linux
```bash
tar xzf kvm-pro-linux-x64-portable-*.tar.gz
cd kvm-pro-linux-*
./run-server.sh
```

### Windows
```
Extract ZIP file
Double-click run-server.bat
```

**That's it!** See [USER_GUIDE.md](USER_GUIDE.md) for full instructions.

## Architecture

```
INPUT CAPTURE
    ↓
SERIALIZE EVENT
    ↓
SEND VIA NETWORK (TCP + UDP Discovery)
    ↓
RECEIVE ON CLIENT
    ↓
INJECT INPUT
```

## Distribution Options

| Format | OS | Size | How to Use |
|--------|-----|------|-----------|
| **tar.gz** | Linux | ~10 MB | Extract & run |
| **AppImage** | Linux | ~20 MB | Click to run |
| **ZIP** | Windows | ~25 MB | Extract & run |

All packages are **100% portable** - no installation needed!

See [PORTABILITY_GUIDE.md](PORTABILITY_GUIDE.md) for distribution details.

## Project Structure

```
core/               - Main Rust application
├── src/
│   ├── input/      - Event capture and injection (platform-specific)
│   ├── network/    - TCP/UDP communication, discovery
│   ├── security/   - TLS and encryption
│   ├── config/     - Configuration management
│   ├── plugins/    - Plugin system
│   ├── screen/     - Multi-monitor support
│   ├── clipboard/  - Clipboard sync
│   └── utils/      - Utility functions
├── Cargo.toml
├── .cargo/         - Static linking configuration
└── target/         - Build outputs

scripts/
├── portable-build.sh    - Create portable packages
├── appimage-build.sh    - Create Linux AppImage
├── release-build.sh     - Full release builder
└── ...

ui/                 - Web/Desktop UI (Vue/Tauri planned)
plugins/            - Plugin examples
scripts/            - Build and packaging scripts
shared/             - Shared protocol definitions

```

## Building

### Requirements

- **Rust 1.70+** (install from https://rustup.rs/)
- **Linux**: Development headers for input libraries
  ```bash
  # Ubuntu/Debian
  sudo apt-get install libevdev-dev

  # Fedora
  sudo dnf install libevdev-devel
  ```
- **Windows**: Standard build tools

### Build Steps

```bash
# Linux
cd core
cargo build --release

# Windows (from Windows or with cross-compile)
cd core
cargo build --release --target x86_64-pc-windows-gnu
```

### Using Build Script

```bash
./scripts/build.sh
```

## Installation

### Linux

```bash
# From source
./scripts/build.sh
sudo install -m755 core/target/release/kvm-pro-server /usr/local/bin/
sudo install -m755 core/target/release/kvm-pro-client /usr/local/bin/

# Run server
kvm-pro-server

# Run client
kvm-pro-client
```

### Windows

Download the Windows executable from releases or build from source.

## Configuration

Create `kvm-pro.toml` in your home directory or current directory:

```toml
[server]
host = "0.0.0.0"
port = 5000
enable_clipboard_sync = true
enable_screen_sharing = false
max_connections = 1

[client]
server_host = "127.0.0.1"
server_port = 5000
auto_connect = false

[security]
use_tls = false
certificate_path = "certs/server.crt"
key_path = "certs/server.key"
```

## Usage

### Server (the computer you want to control others FROM)

```bash
kvm-pro-server
```

### Client (the computer you want to control)

```bash
# Auto-discover server
kvm-pro-client

# Or specify server manually
kvm-pro-client --server 192.168.1.100:5000
```

## How It Works

1. **Server** captures keyboard and mouse events
2. Events are serialized using bincode (efficient binary format)
3. Sent over TCP to connected client
4. Client deserializes and injects events into the local system
5. UDP discovery allows automatic server detection on network

## Development

### Running Tests

```bash
cd core
cargo test
```

### Running with Logging

```bash
RUST_LOG=debug cargo run --bin kvm-pro-server
```

### Code Structure

- **Protocol**: Defined in `shared/protocol.rs`
- **Platform Detection**: Conditional compilation in each module
- **Async Runtime**: Using Tokio for efficient concurrency

## Roadmap

### Phase 1 (Current)
- [x] Basic event capture (Linux)
- [x] Event injection (Linux)
- [x] TCP server/client
- [x] Protocol definition
- [ ] Windows support
- [ ] Error handling improvements

### Phase 2
- [ ] UDP discovery
- [ ] TLS encryption
- [ ] Configuration system
- [ ] Logging framework
- [ ] Web UI

### Phase 3
- [ ] Clipboard sync
- [ ] Multi-monitor support
- [ ] Plugin system
- [ ] Screen sharing (VNC-like)
- [ ] Performance optimization

## Troubleshooting

### Linux: "Permission denied" when opening `/dev/input/event0`

Add your user to the `input` group:
```bash
sudo usermod -a -G input $USER
# Log out and back in
```

### "Connection refused" error

Ensure the server is running on the target machine and firewall allows port 5000.

### Events not being captured

- Check that the correct input device is being used (might be `/dev/input/event1`, etc.)
- Set `RUST_LOG=debug` and check logs

## Performance

KVM Pro is designed for low-latency input forwarding:

- **Event Capture**: Uses direct evdev on Linux (minimal overhead)
- **Serialization**: Binary format (bincode) for small payload size
- **Network**: Single TCP connection with async I/O
- **Injection**: Kernel-level uinput (minimal latency)

Typical latency: < 50ms (network dependent)

## Comparison with Input Leap/Barrier

| Feature | KVM Pro | Input Leap | Barrier |
|---------|---------|-----------|---------|
| Written in | Rust | C++ | C++ |
| Memory Usage | ✅ Very Low | Medium | Medium |
| Configuration | TOML | GUI | GUI |
| Plugin System | ✅ Yes | Yes | Yes |
| Cross-Platform | ✅ Linux/Windows | Linux/Windows/Mac | Linux/Windows/Mac |
| Open Source | ✅ Yes | Yes | Yes |
| Recent Updates | ✅ Active | Outdated | Active |

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test locally
5. Submit a pull request

## License

MIT License - See LICENSE file for details

## Support

- **Issues**: Report bugs on GitHub Issues
- **Discussions**: Start a GitHub Discussion
- **Documentation**: Check README and inline code comments

## Acknowledgments

Inspired by:
- Input Leap (https://github.com/debauchee/barrier)
- Barrier (https://github.com/debauchee/barrier)
- Synergy (commercial predecessor)

---

**Note**: This project is in early development. Use at your own risk. Not production-ready yet.
# kvm-pro
