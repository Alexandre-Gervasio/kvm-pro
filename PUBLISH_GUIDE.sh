#!/bin/bash
# 🚀 KVM Pro v1.0.0 - Complete Publication & Release Guide

cat << 'EOF'

╔════════════════════════════════════════════════════════════════════════════════╗
║                  🚀 KVM Pro v1.0.0 - HORA DE PUBLICAR!                        ║
║                                                                                ║
║  Você tem tudo pronto. Este guia mostra exatamente como publicar.             ║
╚════════════════════════════════════════════════════════════════════════════════╝

═══════════════════════════════════════════════════════════════════════════════════

📋 CHECKLIST DE PUBLICAÇÃO

✅ Estrutura limpa (pastas vazias removidas)
✅ README.md unificado com ícone
✅ BUILD_GUIDE.md com instruções completas
✅ Código commitado e feito push
✅ Tag v1.0.0 criada e enviada
✅ GitHub Actions configurado
✅ Release script pronto

═══════════════════════════════════════════════════════════════════════════════════

🎯 PASSO A PASSO PARA PUBLICAR

═══════════════════════════════════════════════════════════════════════════════════

## PASSO 1: Criar Personal Access Token no GitHub (5 minutos)

1. Vá para: https://github.com/settings/tokens/new
2. Nome: "KVM Pro Release Token"
3. Selecione os escopos:
   ✓ repo (Full control of private repositories)
   ✓ workflow (Update GitHub Action workflows)
4. Clique "Generate token"
5. COPIE o token (você verá apenas uma vez!)
6. Guarde em segurança

═══════════════════════════════════════════════════════════════════════════════════

## PASSO 2: Criar a Release com o Token (1 minuto)

Em seu terminal:

  # 1. Defina o token como variável de ambiente
     export GITHUB_TOKEN="ghp_seu_token_aqui"

  # 2. Execute o script de release
     chmod +x release-v1.0.0.sh
     ./release-v1.0.0.sh

  # 3. Aguarde a confirmação

═══════════════════════════════════════════════════════════════════════════════════

## PASSO 3: Verificar a Release (1 minuto)

No navegador:

  1. Vá para: https://github.com/Alexandre-Gervasio/kvm-pro/releases
  2. Veja a release v1.0.0 criada
  3. Com descrição, changelog, e links

═══════════════════════════════════════════════════════════════════════════════════

## PASSO 4: GitHub Actions - Compilação Automática (15 minutos)

GitHub Actions vai automaticamente:

  ✅ Carregar código da tag v1.0.0
  ✅ Compilar para Linux (musl static)
  ✅ Compilar para Windows (MinGW static)
  ✅ Criar Linux AppImage
  ✅ Upload dos binários para release

Para acompanhar:
  
  1. Vá para: https://github.com/Alexandre-Gervasio/kvm-pro/actions
  2. Veja o workflow "Release Build" rodando
  3. Aguarde ~15 minutos

═══════════════════════════════════════════════════════════════════════════════════

## PASSO 5: Verificar Binários Publicados (1 minuto)

Após GitHub Actions terminar:

  1. Vá para: https://github.com/Alexandre-Gervasio/kvm-pro/releases/tag/v1.0.0
  2. Role até "Assets"
  3. Você verá:
     ✓ kvm-pro-linux.tar.gz (~12 MB)
     ✓ kvm-pro-windows.zip (~25 MB)
     ✓ kvm-pro-linux.AppImage (~20 MB)
     ✓ SHA256SUMS (checksums)

═══════════════════════════════════════════════════════════════════════════════════

🎯 COMO COMPILAR LOCALMENTE (Opcional)

Se você quiser compilar tudo em seu computador e fazer upload manual:

═══════════════════════════════════════════════════════════════════════════════════

### 📂 Compilar Apenas para Linux

Rápido (glibc):
  cd core
  cargo build --release
  # Binary: core/target/release/kvm-pro-server (~30 MB)

Portável (musl - recomendado):
  rustup target add x86_64-unknown-linux-musl
  cd core
  cargo build --release --target x86_64-unknown-linux-musl
  # Binary: core/target/release/..../kvm-pro-server (~30 MB, totalmente estático)

Package (tar.gz):
  cd ..
  chmod +x scripts/portable-build.sh
  ./scripts/portable-build.sh
  # Output: dist/kvm-pro-linux.tar.gz (~12 MB)

═══════════════════════════════════════════════════════════════════════════════════

### 🪟 Compilar para Windows

De Linux/WSL (recomendado):
  sudo apt-get install -y mingw-w64
  rustup target add x86_64-pc-windows-gnu
  cd core
  cargo build --release --target x86_64-pc-windows-gnu
  # Binary: core/target/x86_64-pc-windows-gnu/release/kvm-pro-server.exe (~35 MB)

Package (ZIP):
  cd ..
  chmod +x scripts/windows-build.sh
  ./scripts/windows-build.sh
  # Output: dist/kvm-pro-windows.zip (~25 MB)

De Windows nativo:
  # Instale Visual Studio Build Tools ou MinGW
  # Depois:
  cd core
  cargo build --release
  # Binary: core/target/release/kvm-pro-server.exe

═══════════════════════════════════════════════════════════════════════════════════

### 🐧 Compilar para Linux AppImage

  sudo apt-get install -y appimagetool
  cd kvm-pro
  chmod +x scripts/appimage-build.sh
  ./scripts/appimage-build.sh
  # Output: dist/kvm-pro-linux.AppImage (~20 MB)

═══════════════════════════════════════════════════════════════════════════════════

### ⚡ Compilar Tudo de Uma Vez (Se tem todas as ferramentas)

  cd kvm-pro
  chmod +x scripts/release-build.sh
  ./scripts/release-build.sh
  
  # Cria:
  # dist/kvm-pro-linux.tar.gz
  # dist/kvm-pro-windows.zip
  # dist/kvm-pro-linux.AppImage

═══════════════════════════════════════════════════════════════════════════════════

📤 UPLOAD MANUAL DE BINÁRIOS (Se não quiser usar GitHub Actions)

1. Compile os binários (veja acima)
2. Vá para: https://github.com/Alexandre-Gervasio/kvm-pro/releases/tag/v1.0.0
3. Clique "Edit Release"
4. Clique "Attach binaries by dropping them here..."
5. Selecione:
   - dist/kvm-pro-linux.tar.gz
   - dist/kvm-pro-windows.zip
   - dist/kvm-pro-linux.AppImage (opcional)
6. Clique "Update Release"

═══════════════════════════════════════════════════════════════════════════════════

🎉 PRONTO! Sua Release Está Publicada!

Usuários podem agora:

  ✅ Linux:
     wget https://github.com/Alexandre-Gervasio/kvm-pro/releases/download/v1.0.0/kvm-pro-linux.tar.gz
     tar xzf kvm-pro-linux.tar.gz
     cd kvm-pro-linux
     ./run-server.sh

  ✅ Windows:
     # Download kvm-pro-windows.zip
     # Extract → Double-click run-server-with-update.bat

  ✅ macOS/Linux:
     # Download kvm-pro-linux.AppImage
     chmod +x kvm-pro-linux.AppImage
     ./kvm-pro-linux.AppImage

═══════════════════════════════════════════════════════════════════════════════════

📊 STATUS FINAL

  ✅ Código: Limpo e pronto
  ✅ Commits: Feitos (2 útimos)
  ✅ Tag: v1.0.0 criada
  ✅ Push: Enviado para GitHub
  ✅ GitHub Actions: Configurado para builds automáticos
  ✅ README: Unificado com ícone e bem estruturado
  ✅ BUILD_GUIDE: Completo com instruções para todas as plataformas
  ✅ Release script: Pronto para publicar
  ✅ Documentação: Completa (12+ arquivos)

═══════════════════════════════════════════════════════════════════════════════════

🚀 Próximas Versões

v1.0.1: Bug fixes (1-2 semanas)
v1.1.0: Windows full impl, TLS (1 mês)
v1.2.0: Clipboard, multi-monitor (2 meses)
v2.0.0: Screen sharing, macOS (3+ meses)

═══════════════════════════════════════════════════════════════════════════════════

Tudo está pronto! Execute o release script e você terá v1.0.0 publicado! 🎉

EOF
