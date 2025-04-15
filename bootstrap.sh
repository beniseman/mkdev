#!/bin/bash

echo "🛠️ Setting up your Mac for embedded development..."

# --- Install Homebrew ---
if ! command -v brew &> /dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "✅ Homebrew already installed."
fi

brew update

# --- Install core CLI tools ---
brew install git python

# --- Install GUI apps ---
brew install --cask visual-studio-code
brew install --cask github
brew install --cask arduino  # optional — PlatformIO doesn’t need it, but you might

# --- Install PlatformIO CLI (optional but useful) ---
pip3 install -U platformio

# --- Add code to PATH if not already there ---
if ! command -v code &> /dev/null; then
  echo "❗ Open VS Code, press Cmd+Shift+P and run: 'Shell Command: Install code command in PATH'"
fi

# --- Install PlatformIO VS Code extension ---
code --install-extension platformio.platformio-ide

# --- Clone your project(s) ---
mkdir -p ~/Projects
cd ~/Projects

if [ ! -d "lineScale" ]; then
  git clone https://github.com/beniseman/lineScale.git
fi

echo "✅ All done! Open VS Code and start coding:"
echo "   cd ~/Projects/lineScale && code ."
