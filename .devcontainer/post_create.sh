#!/usr/bin/env bash
# .devcontainer/post-create.sh
set -e

echo "=== Installing Neovim and Build Tools ==="
sudo apt-get update && sudo apt-get install -y software-properties-common build-essential curl unzip
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update && sudo apt-get install -y neovim

echo "=== Installing Bash / DevOps CLI Tools ==="
# Shellcheck for linting, shfmt for formatting
sudo apt-get install -y shellcheck shfmt

echo "=== Setting up Neovim Configuration ==="
# Clone a clean starter config if it doesn't exist, or link yours here
if [ ! -d "$HOME/.config/nvim" ]; then
  mkdir -p "$HOME/.config"
  # Pulling Kickstart.nvim as an ultra-fast, LSP-ready foundation
  git clone https://github.com/nvim-lua/kickstart.nvim.git "$HOME/.config/nvim"
fi

echo "=== Pre-installing Language Servers ==="
# Ensure language servers are globally accessible for Neovim's LSP client
npm install -g bash-language-server
pip3 install pyright black
