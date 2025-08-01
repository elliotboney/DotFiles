#!/usr/bin/env bash
set -euo pipefail

#
# Install all the things with Homebrew, Casks and a Brewfile
#

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Setting up Homebrew...${NC}"

# Detect OS
OS="$(uname -s)"
if [[ "$OS" != "Darwin" ]]; then
    echo -e "${RED}Error: This script is only for macOS${NC}"
    exit 1
fi

# Detect architecture for Apple Silicon support
ARCH="$(uname -m)"
if [[ "$ARCH" == "arm64" ]]; then
    # Apple Silicon
    BREW_PREFIX="/opt/homebrew"
else
    # Intel
    BREW_PREFIX="/usr/local"
fi

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}Homebrew not found. Installing...${NC}"
    
    # Install Homebrew using the official installer
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for current session
    if [[ -f "$BREW_PREFIX/bin/brew" ]]; then
        eval "$($BREW_PREFIX/bin/brew shellenv)"
    else
        echo -e "${RED}Error: Homebrew installation failed${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}Homebrew installed successfully!${NC}"
else
    echo -e "${GREEN}Homebrew is already installed${NC}"
fi

# Ensure brew is in PATH (especially important for Apple Silicon)
if [[ -f "$BREW_PREFIX/bin/brew" ]] && ! command -v brew &> /dev/null; then
    eval "$($BREW_PREFIX/bin/brew shellenv)"
fi

# Update Homebrew
echo -e "${BLUE}Updating Homebrew...${NC}"
brew update

# Check if Brewfile exists
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$SCRIPT_DIR/Brewfile"

if [[ ! -f "$BREWFILE" ]]; then
    echo -e "${RED}Error: Brewfile not found at $BREWFILE${NC}"
    exit 1
fi

# Install everything in Brewfile
echo -e "${BLUE}Installing packages from Brewfile...${NC}"
brew bundle --file="$BREWFILE"

# Run cleanup
echo -e "${BLUE}Cleaning up...${NC}"
brew cleanup

# Run diagnostics
echo -e "${BLUE}Running brew doctor...${NC}"
if brew doctor; then
    echo -e "${GREEN}Homebrew is ready!${NC}"
else
    echo -e "${YELLOW}Warning: brew doctor reported some issues. You may want to address them.${NC}"
fi

echo -e "${GREEN}Homebrew setup complete!${NC}"

# Show instructions for PATH setup if needed
if [[ "$ARCH" == "arm64" ]] && [[ ! -f "$HOME/.zprofile" ]] || ! grep -q "$BREW_PREFIX/bin/brew" "$HOME/.zprofile" 2>/dev/null; then
    echo -e "${YELLOW}Note: For Apple Silicon Macs, you may need to add Homebrew to your PATH:${NC}"
    echo -e "${BLUE}Add this to your ~/.zprofile or ~/.bash_profile:${NC}"
    echo -e "eval \"\$($BREW_PREFIX/bin/brew shellenv)\""
fi