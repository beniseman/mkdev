#!/bin/bash

echo "🛠️ Setting up your Mac for PlatformIO + VS Code..."

# --- Install Homebrew ---
if ! command -v brew &> /dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "✅ Homebrew already installed."
fi

brew update

# --- Install CLI tools ---
brew install git python

# --- Install GUI apps ---
brew install --cask visual-studio-code
brew install --cask github

# --- Install PlatformIO CLI (optional, VS Code handles it too) ---
pip3 install -U platformio

# --- Install PlatformIO extension in VS Code ---
code --install-extension platformio.platformio-ide

# --- Optional: Clone your project(s) ---
mkdir -p ~/Projects
cd ~/Projects
git clone https://github.com/beniseman/lineScale.git

echo "✅ Done! Open VS Code, load your project folder, and you're good to go."
