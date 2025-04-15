#!/bin/bash

echo "🛠️ Setting up your Mac for PlatformIO + VS Code development..."

# --- Install Homebrew ---
if ! command -v brew &> /dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "✅ Homebrew already installed."
fi

brew update

# --- Install Git ---
if ! command -v git &> /dev/null; then
  echo "🔧 Installing Git..."
  brew install git
else
  echo "✅ Git already installed."
fi

# --- Install Python ---
if ! command -v python3 &> /dev/null; then
  echo "🐍 Installing Python..."
  brew install python
else
  echo "✅ Python already installed."
fi

# --- Install VS Code ---
if [ ! -d "/Applications/Visual Studio Code.app" ]; then
  echo "🧠 Installing Visual Studio Code..."
  brew install --cask visual-studio-code
else
  echo "✅ VS Code already installed."
fi

# --- Install GitHub Desktop (optional) ---
if [ ! -d "/Applications/GitHub Desktop.app" ]; then
  echo "🐙 Installing GitHub Desktop..."
  brew install --cask github
else
  echo "✅ GitHub Desktop already installed."
fi

# --- Install Arduino IDE (optional) ---
if [ ! -d "/Applications/Arduino.app" ]; then
  echo "🔌 Installing Arduino IDE..."
  brew install --cask arduino
else
  echo "✅ Arduino IDE already installed."
fi

# --- Install PlatformIO CLI (optional for command-line use) ---
if ! command -v pio &> /dev/null; then
  echo "📦 Installing PlatformIO CLI via pip..."
  pip3 install --user -U platformio
else
  echo "✅ PlatformIO CLI already installed."
fi

# --- Launch VS Code to initialize extension system ---
echo "🚀 Launching VS Code once to initialize its configuration..."
open -a "Visual Studio Code"

echo "⏳ Waiting 10 seconds..."
sleep 10

# --- Ensure 'code' CLI is available ---
if ! command -v code &> /dev/null; then
  echo "❗ VS Code CLI not found."
  echo "   Open VS Code → Cmd+Shift+P → 'Shell Command: Install code command in PATH'"
  echo "   Then re-run this script to auto-install the PlatformIO extension."
  exit 1
fi

# --- Install PlatformIO VS Code extension ---
if ! code --list-extensions | grep -q platformio.platformio-ide; then
  echo "🧩 Installing PlatformIO extension for VS Code..."
  code --install-extension platformio.platformio-ide
else
  echo "✅ PlatformIO VS Code extension already installed."
fi

# --- Clone your project (lineScale) ---
mkdir -p ~/Projects
cd ~/Projects

if [ ! -d "lineScale" ]; then
  echo "📥 Cloning your lineScale project..."
  git clone https://github.com/beniseman/lineScale.git
else
  echo "✅ Project 'lineScale' already exists."
fi

echo "🎉 Setup complete! Open your project with:"
echo "   code ~/Projects/lineScale"
