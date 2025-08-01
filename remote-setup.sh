#!/usr/bin/env bash
set -euo pipefail

# Remote setup script for DotFiles
# Usage: curl -fsSL https://raw.githubusercontent.com/elliotboney/DotFiles/master/remote-setup.sh | bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Determine download command
if command -v curl &> /dev/null; then
    DOWNLOAD_CMD="curl -fsSL"
elif command -v wget &> /dev/null; then
    DOWNLOAD_CMD="wget -qO-"
else
    echo -e "${RED}Error: Neither curl nor wget is available. Please install one of them.${NC}"
    exit 1
fi

echo -e "${BLUE}Installing DotFiles...${NC}"

# Set target directory
DOTFILES_DIR="$HOME/DotFiles"

# Check if directory already exists
if [ -d "$DOTFILES_DIR" ]; then
    echo -e "${YELLOW}Warning: $DOTFILES_DIR already exists.${NC}"
    read -p "Do you want to remove it and continue? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Removing existing directory...${NC}"
        rm -rf "$DOTFILES_DIR"
    else
        echo -e "${RED}Installation cancelled.${NC}"
        exit 1
    fi
fi

# Create directory and download
echo -e "${GREEN}Creating directory: $DOTFILES_DIR${NC}"
mkdir -p "$DOTFILES_DIR"

echo -e "${GREEN}Downloading DotFiles...${NC}"
if ! $DOWNLOAD_CMD "https://github.com/elliotboney/DotFiles/tarball/master" | tar -xz -C "$DOTFILES_DIR" --strip-components=1; then
    echo -e "${RED}Error: Failed to download or extract DotFiles.${NC}"
    exit 1
fi

# Check if install.sh exists
if [ -f "$DOTFILES_DIR/install.sh" ]; then
    echo -e "${GREEN}Running installation script...${NC}"
    cd "$DOTFILES_DIR"
    chmod +x install.sh
    ./install.sh
else
    echo -e "${RED}Error: install.sh not found in $DOTFILES_DIR${NC}"
    exit 1
fi

echo -e "${GREEN}Remote setup complete!${NC}"