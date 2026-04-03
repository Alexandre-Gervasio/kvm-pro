# 🔧 Como Compilar KVM Pro v1.0.0

## Requisitos Gerais

- **Rust 1.70+** (Download: https://rustup.rs/)
- **Git**
- Para Linux: package development headers

---

## 🐧 Compilar para Linux (Local)

### Step 1: Install Dependencies

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install -y build-essential libevdev-dev pkg-config
```

**Fedora/RHEL:**
```bash
sudo dnf groupinstall -y "Development Tools"
sudo dnf install -y libevdev-devel
```

**Arch Linux:**
```bash
sudo pacman -S base-devel libevdev
```

### Step 2: Clone and Build

```bash
# Clone
git clone https://github.com/Alexandre-Gervasio/kvm-pro.git
cd kvm-pro

# Navigate to core
cd core

# Build release (first build: ~2-5 min, subsequent: ~30 sec)
cargo build --release

# Binary location
./target/release/kvm-pro-server
./target/release/kvm-pro-client
```

### Step 3: Create Portable Package (Optional)

```bash
# Return to project root
cd ..

# Make script executable
chmod +x scripts/portable-build.sh

# Build portable tar.gz (~12 MB uncompressed)
./scripts/portable-build.sh

# Output: dist/kvm-pro-linux.tar.gz
# Can be used on any Linux system without installation
```

---

## 🪟 Compilar para Windows

### Option A: From Linux/WSL (Recommended for Cross-Compilation)

#### Step 1: Install Windows Target

```bash
# Install MinGW (Windows cross-compilation toolchain)
sudo apt-get install -y mingw-w64

# Add Windows target to Rust
rustup target add x86_64-pc-windows-gnu
```

#### Step 2: Build Windows Binary

```bash
cd kvm-pro/core

# Build for Windows (creates .exe)
cargo build --release --target x86_64-pc-windows-gnu

# Binary: ./target/x86_64-pc-windows-gnu/release/kvm-pro-server.exe
# Binary: ./target/x86_64-pc-windows-gnu/release/kvm-pro-client.exe
```

#### Step 3: Create Windows Portable Package

```bash
cd ..

# Make script executable
chmod +x scripts/windows-build.sh

# Build Windows portable ZIP
./scripts/windows-build.sh

# Output: dist/kvm-pro-windows.zip (~25 MB)
```

### Option B: From Windows (Native Compilation)

#### Step 1: Install Rust

Download from https://rustup.rs/ and run installer

#### Step 2: Install Build Tools

**Option 1: Visual Studio Build Tools (Recommended)**
```powershell
# Download from:
# https://visualstudio.microsoft.com/visual-cpp-build-tools/

# During installation, select:
# - Desktop development with C++
# - Windows 10/11 SDK
```

**Option 2: MinGW (Simpler)**
```powershell
# Install MinGW from: https://www.mingw-w64.org/
# Add to PATH after installation
```

#### Step 3: Build

```powershell
# Clone
git clone https://github.com/Alexandre-Gervasio/kvm-pro.git
cd kvm-pro\core

# Build
cargo build --release

# Binary: target/release/kvm-pro-server.exe
```

---

## 🍎 Compilar para macOS

### Step 1: Install Rust
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```

### Step 2: Install Dependencies
```bash
# Xcode command line tools
xcode-select --install

# Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# libevdev (if you want event capture)
# Note: macOS input handling via native APIs would be needed for full implementation
brew install libevdev
```

### Step 3: Build
```bash
cd kvm-pro/core

# Build for your architecture (M1/M2 or Intel)
cargo build --release

# Binary: target/release/kvm-pro-server
```

**Note**: Input capture/injection on macOS requires native Swift/Objective-C integration (not yet implemented in v1.0.0). Current build uses placeholder implementation.

---

## 🔨 Build All Platforms (Automated)

If you have all toolchains installed:

```bash
cd kvm-pro

# Build Linux, Windows, and AppImage
./scripts/release-build.sh

# Output:
# - dist/kvm-pro-linux.tar.gz
# - dist/kvm-pro-windows.zip
# - dist/kvm-pro-linux.AppImage (if appimagetool installed)
```

---

## 💾 Create Linux AppImage (Universal Distribution)

### Step 1: Install appimagetool

```bash
# Download
wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
chmod +x appimagetool-x86_64.AppImage
sudo mv appimagetool-x86_64.AppImage /usr/local/bin/appimagetool

# Verify
appimagetool --version
```

### Step 2: Build AppImage

```bash
cd kvm-pro

# Make script executable
chmod +x scripts/appimage-build.sh

# Build AppImage
./scripts/appimage-build.sh

# Output: dist/kvm-pro-x86_64.AppImage (~20 MB)
# Can be run by: chmod +x dist/kvm-pro-x86_64.AppImage && ./dist/kvm-pro-x86_64.AppImage
```

---

## 🧪 Verify Compilation

### Check Binary Size

```bash
ls -lh dist/
# Or for specific:
ls -lh core/target/release/kvm-pro-server
file core/target/release/kvm-pro-server  # Should show: ELF 64-bit, dynamically linked
```

### Check Dependencies (Linux)

```bash
# Should show: statically linked (0x0) or very minimal dependencies
ldd core/target/release/kvm-pro-server

# For musl (truly portable):
# Should show: "not a dynamic executable" (statically linked)
file core/target/release/kvm-pro-server
```

### Test Execution

```bash
# Run with version flag
./core/target/release/kvm-pro-server --version
# Should output version info

# Run with debug output
RUST_LOG=debug ./core/target/release/kvm-pro-server
# Press Ctrl+C to stop
```

---

## 🚀 Troubleshooting Compilation

### Error: `fatal error: evdev.h: No such file`

**Solution:**
```bash
# Install libevdev development headers
# Ubuntu/Debian:
sudo apt-get install libevdev-dev

# Fedora:
sudo dnf install libevdev-devel

# Then rebuild:
cd core && cargo build --release
```

### Error: `could not compile 'tokio'`

**Solution:**
```bash
# Update Rust
rustup update

# Clean and rebuild
cargo clean
cargo build --release
```

### Error: `error: linker 'x86_64-w64-mingw32-gcc' not found`

**Solution:**
```bash
# Install MinGW
sudo apt-get install mingw-w64

# If still fails, specify target explicitly:
cargo build --release --target x86_64-pc-windows-gnu
```

### Compilation takes forever / runs out of memory

**Solution:**
```bash
# Limit parallel jobs
cargo build --release -j 2

# Or use incremental compilation (slower but uses less memory):
CARGO_INCREMENTAL=1 cargo build --release
```

---

## 📦 Static Linking (Portable Binaries)

### For Linux (musl)

The project is already configured for musl in `.cargo/config.toml`:

```toml
[build]
target = "x86_64-unknown-linux-musl"

[profile.portable]
inherits = "release"
lto = true
strip = true
```

**To use:**
```bash
rustup target add x86_64-unknown-linux-musl
cd core
cargo build --release --target x86_64-unknown-linux-musl
```

### For Windows (MinGW)

Uses static linking automatically with mingw-w64.

---

## 📋 Build Matrix

| Platform | Command | Output | Size | Time |
|----------|---------|--------|------|------|
| **Linux (glibc)** | `cargo build --release` | Binary | 30-40 MB | 60s |
| **Linux (musl)** | `cargo build --release --target x86_64-unknown-linux-musl` | Static binary | 30-40 MB | 90s |
| **Linux (AppImage)** | `./scripts/appimage-build.sh` | .AppImage | 20 MB | 120s |
| **Linux (tar.gz)** | `./scripts/portable-build.sh` | tar.gz | 12 MB | 120s |
| **Windows (MinGW)** | `cargo build --release --target x86_64-pc-windows-gnu` | .exe | 35-40 MB | 90s |
| **Windows (ZIP)** | `./scripts/windows-build.sh` | .zip | 25 MB | 120s |
| **macOS (Intel)** | `cargo build --release` | Binary | 30 MB | 60s |
| **macOS (M1/M2)** | `cargo build --release` | Binary | 30 MB | 60s |

---

## 🔐 Code Signing (Optional, Production)

### Sign Linux Binary

```bash
# Generate key
gpg --gen-key

# Sign binary
gpg --detach-sign kvm-pro-server

# Verify signature
gpg --verify kvm-pro-server.sig kvm-pro-server
```

### Sign Windows Binary

Requires Windows Authenticode certificate (paid or self-signed for testing):

```powershell
# Using self-signed cert (for testing only):
$cert = New-SelfSignedCertificate -Type CodeSigningCert -DnsName "your domain"
Set-AuthenticodeSignature -FilePath .\kvm-pro-server.exe -Certificate $cert
```

---

## 📚 Next Steps

1. **Build successfully?** Test with: `./run-server.sh`
2. **Want to publish?** See [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md)
3. **Contribute?** See [CONTRIBUTING.md](CONTRIBUTING.md)

---

**Need help?** Check errors above or open an issue on GitHub.
