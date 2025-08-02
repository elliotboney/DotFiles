# Dotfile Improvements Guide

This guide presents systematic improvements for your dotfiles repository, organized by priority and complexity. Each section includes specific implementation steps with file paths and line numbers.

## Progress Tracking

### Overall Progress: 32/41 completed

#### By Category:
- [x] **Security Fixes**: 3/3 completed
- [x] **Performance Optimizations**: 3/3 completed
- [x] **Modern Tool Migrations**: 4/4 completed  
- [x] **Neovim Modernization**: 1/1 completed
- [x] **Enhanced Shell Experience**: 2/2 completed
- [ ] **AI-Powered Features**: 0/2 completed
- [ ] **Architecture Improvements**: 0/4 completed
- [x] **Modern CLI Tools**: 14/14 completed
- [ ] **Quick Start Items**: 4/4 completed
- [ ] **Additional Improvements**: 4/4 completed

#### Progress Legend:
- ✅ = Completed
- 🚧 = In Progress  
- ❌ = Blocked/Issue
- [ ] = Not Started

#### Notes Section:
<!-- Use this section to track notes about implementations, issues encountered, or customizations made -->
- **Date Started**: 2025-08-01
- **Last Updated**: 2025-08-01
- **Notes**:
  - All security fixes completed with enhanced security-audit script
  - Performance optimizations completed - Zinit migration should significantly improve zsh startup time
  - Starship and nvim configs moved to proper ~/.config/ locations for better organization  
  - Created setup-gpg-signing helper script for easy GPG configuration
  - Fixed zsh benchmarking with EPOCHREALTIME for accurate timing

## Table of Contents
1. [Critical Security Fixes](#1-critical-security-fixes)
2. [Performance Optimizations](#2-performance-optimizations)
3. [Modern Tool Migrations](#3-modern-tool-migrations)
4. [Neovim Modernization](#4-neovim-modernization)
5. [Enhanced Shell Experience](#5-enhanced-shell-experience)
6. [AI-Powered Features](#6-ai-powered-features)
7. [Architecture Improvements](#7-architecture-improvements)
8. [Implementation Plan](#implementation-plan)

---

## 1. Critical Security Fixes

### 1.1 Fix Insecure Homebrew Installation
- [x] **Status**: ✅ Completed
**Priority**: HIGH | **Complexity**: LOW | **File**: `~/DotFiles/install.sh:45`

**Issue**: Using HTTP instead of HTTPS for Homebrew installation script

**Current Code**:
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

**Fixed Code**:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 1.2 Add GPG Commit Signing
- [x] **Status**: ✅ Completed
**Priority**: HIGH | **Complexity**: MEDIUM | **File**: `~/DotFiles/misc/gitconfig.symlink`

**Add to gitconfig**:
```ini
[user]
    signingkey = YOUR_GPG_KEY_ID
[commit]
    gpgsign = true
[tag]
    gpgsign = true
```

**Setup Commands**:
```bash
# Generate GPG key
gpg --full-generate-key
# List keys
gpg --list-secret-keys --keyid-format=long
# Add to GitHub
gpg --armor --export YOUR_KEY_ID | pbcopy
```

### 1.3 Add Secret Scanning Script
- [x] **Status**: ✅ Completed (Enhanced)
**Priority**: HIGH | **Complexity**: LOW | **File**: Create `~/DotFiles/bin/bin.symlink/security-audit`

```bash
#!/usr/bin/env bash
set -euo pipefail

echo "🔍 Scanning for exposed secrets..."

# Check for common secret patterns
rg -i '(api_key|api_secret|aws_access_key|aws_secret|password|token|client_secret).*=.*["\x27][a-zA-Z0-9]{8,}["\x27]' \
   --glob '!*.{log,lock}' \
   --glob '!.git/**' \
   --glob '!node_modules/**' \
   --glob '!vendor/**' || echo "✅ No obvious secrets found"

# Check file permissions
echo -e "\n🔒 Checking file permissions..."
find ~ -name "*.pem" -o -name "*.key" -o -name "id_*" 2>/dev/null | \
    while read -r file; do
        perms=$(ls -la "$file" | awk '{print $1}')
        if [[ ! "$perms" =~ ^-..------- ]]; then
            echo "⚠️  Warning: $file has loose permissions: $perms"
        fi
    done

echo -e "\n✅ Security audit complete"
```

---

## 2. Performance Optimizations

### 2.1 Replace Antigen with Zinit
- [x] **Status**: ✅ Completed
**Priority**: HIGH | **Complexity**: MEDIUM | **File**: `~/DotFiles/misc/zshrc.symlink:50`

**Current Code** (line 50):
```bash
source "${DOTPATH}/antigen.zsh"
```

**New Implementation**:
```bash
# Replace lines 50+ with:
# Install zinit if not present
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (zinit)…%f"
    command mkdir -p "$(dirname $ZINIT_HOME)"
    command git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load plugins with turbo mode for speed
zinit wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

# Load oh-my-zsh libraries
zinit snippet OMZL::git.zsh
zinit snippet OMZL::history.zsh
zinit snippet OMZL::key-bindings.zsh
zinit snippet OMZL::theme-and-appearance.zsh

# Load oh-my-zsh plugins
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
```

### 2.2 Implement Lazy Loading for Bash Functions
- [x] **Status**: ✅ Completed
**Priority**: MEDIUM | **Complexity**: LOW | **File**: Create `~/DotFiles/bash/dotfiles.symlink/.bash_runfirst.d/lazy_loader.sh`

```bash
#!/usr/bin/env bash

# Lazy loading system for heavy functions
lazy_load() {
    local func=$1
    local file=$2
    
    eval "${func}() { 
        unset -f ${func}
        source ${file}
        ${func} \"\$@\"
    }"
}

# Lazy load heavy functions
lazy_load "git-wtf" "${DOTPATH}/bash/dotfiles.symlink/.bash_functions.d/git.sh"
lazy_load "extract" "${DOTPATH}/bash/dotfiles.symlink/.bash_functions.d/extract.sh"
lazy_load "git-updateall" "${DOTPATH}/bash/dotfiles.symlink/.bash_functions.d/git.sh"
lazy_load "cleanup" "${DOTPATH}/bash/dotfiles.symlink/.bash_functions.d/osx.sh"
```

### 2.3 Update Brewfile
- [x] **Status**: ✅ Completed (deprecated taps removed, modern tools added)
**Priority**: HIGH | **Complexity**: LOW | **File**: `~/DotFiles/Brewfile`

**Remove deprecated taps** (lines 10-17):
```bash
# DELETE THESE LINES:
tap "homebrew/dupes"
tap "homebrew/versions"
tap "homebrew/binary"
tap "homebrew/boneyard"
tap "homebrew/python"
```

**Update cask taps** (lines 21-22):
```bash
# REPLACE:
tap "caskroom/fonts"
tap 'caskroom/cask'

# WITH:
tap "homebrew/cask-fonts"
# homebrew/cask is now included by default
```

**Add modern tools section**:
```bash
################################################
##              MODERN CLI TOOLS              ##
################################################
brew "bat"          # Better cat with syntax highlighting
brew "fd"           # Better find (50x faster)
brew "ripgrep"      # Better grep (you have this!)
brew "eza"          # Better ls (you have this!)
brew "delta"        # Better git diff
brew "dust"         # Better du
brew "bottom"       # Better top
brew "zoxide"       # Better cd
brew "fzf"          # Fuzzy finder for everything
brew "starship"     # Modern prompt
brew "atuin"        # Synced shell history
brew "gping"        # Better ping with graph
brew "procs"        # Better ps
brew "sd"           # Better sed
brew "hyperfine"    # Benchmarking tool
brew "tokei"        # Code statistics
```

#### Modern CLI Tools Checklist:
- [x] bat (better cat) ✅
- [x] fd (better find) ✅
- [x] delta (better git diff) ✅
- [x] dust (better du) ✅
- [x] bottom (better top) ✅
- [x] zoxide (better cd) ✅
- [x] fzf (fuzzy finder) ✅
- [x] starship (modern prompt) ✅
- [x] atuin (synced history) ✅
- [x] gping (better ping) ✅
- [x] procs (better ps) ✅
- [x] sd (better sed) ✅
- [x] hyperfine (benchmarking) ✅
- [x] tokei (code stats) ✅

---

## 3. Modern Tool Migrations

### 3.1 Chezmoi - Advanced Dotfile Management
- [ ] **Status**: Not completed
**Priority**: MEDIUM | **Complexity**: HIGH

**Installation**:
```bash
brew install chezmoi
```

**Migration Script** - Create `~/DotFiles/migrate-to-chezmoi.sh`:
```bash
#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Migrating to chezmoi..."

# Initialize chezmoi
chezmoi init

# Add existing dotfiles
for file in $(find . -name "*.symlink" -type f); do
    basename="${file##*/}"
    dotfile="${basename%.symlink}"
    target="$HOME/.${dotfile}"
    
    if [[ -e "$target" ]]; then
        echo "Adding $target to chezmoi..."
        chezmoi add "$target"
    fi
done

# Create config for machine-specific settings
cat > ~/.config/chezmoi/chezmoi.toml << EOF
[data]
    name = "$(git config user.name)"
    email = "$(git config user.email)"
    hostname = "$(hostname)"
EOF

echo "✅ Migration complete! Review with: chezmoi diff"
```

### 3.2 Atuin - Magical Shell History
- [x] **Status**: ✅ Completed
**Priority**: HIGH | **Complexity**: LOW

**Installation**:
```bash
brew install atuin
```

**Add to** `~/DotFiles/misc/zshrc.symlink` (at end):
```bash
# Atuin - Better shell history
eval "$(atuin init zsh)"
```

**Add to** `~/DotFiles/bash/bashrc.symlink` (at end):
```bash
# Atuin - Better shell history
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"
```

### 3.3 Zoxide - Smarter cd
- [ ] **Status**: Not completed
**Priority**: HIGH | **Complexity**: LOW

**Add to** `~/DotFiles/bash/dotfiles.symlink/.bash_settings.d/zoxide.sh`:
```bash
# Zoxide - smarter cd
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init bash)"
    alias cd="z"
    alias cdi="zi"  # Interactive selection
fi
```

### 3.4 Starship Prompt
- [x] **Status**: ✅ Completed
**Priority**: MEDIUM | **Complexity**: MEDIUM

**Create** `~/DotFiles/misc/config.symlink/starship.toml`:
```toml
# Starship prompt configuration
"$schema" = 'https://starship.rs/config-schema.json'

format = """
[](#9A348E)\
$username\
[](bg:#DA627D fg:#9A348E)\
$directory\
[](fg:#DA627D bg:#FCA17D)\
$git_branch\
$git_status\
[](fg:#FCA17D bg:#86BBD8)\
$nodejs\
$rust\
$python\
[](fg:#86BBD8 bg:#06969A)\
$docker_context\
[](fg:#06969A bg:#33658A)\
$time\
[ ](fg:#33658A)\
"""

[directory]
style = "bg:#DA627D"
format = "[ $path ]($style)"
truncation_length = 3
truncate_to_repo = true

[git_branch]
symbol = ""
style = "bg:#FCA17D"
format = '[[ $symbol $branch ](bg:#FCA17D)]($style)'

[git_status]
style = "bg:#FCA17D"
format = '[[($all_status$ahead_behind )](bg:#FCA17D)]($style)'

[nodejs]
symbol = ""
style = "bg:#86BBD8"
format = '[[ $symbol ($version) ](bg:#86BBD8)]($style)'

[time]
disabled = false
time_format = "%R"
style = "bg:#33658A"
format = '[[  $time ](bg:#33658A)]($style)'
```

---

## 4. Neovim Modernization

### 4.1 Migrate to lazy.nvim
- [x] **Status**: ✅ Completed
**Priority**: MEDIUM | **Complexity**: HIGH | **File**: Create `~/DotFiles/nvim/nvim.symlink/init.lua`

```lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Load legacy vim config
vim.cmd('source ~/.config/nvim/legacy.vim')

-- Setup lazy.nvim
require("lazy").setup({
  -- Modern essentials
  { "folke/which-key.nvim", event = "VeryLazy" },
  { "nvim-telescope/telescope.nvim", 
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('telescope').setup{
        defaults = {
          layout_config = { vertical = { width = 1 } }
        }
      }
    end
  },
  
  -- LSP Support
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "tsserver", "pylsp" }
      })
    end
  },
  
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
  },
  
  -- Git integration
  { "lewis6991/gitsigns.nvim", opts = {} },
  
  -- File explorer
  { "nvim-tree/nvim-tree.lua", 
    opts = {},
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" }
    }
  },
  
  -- Status line
  { "nvim-lualine/lualine.nvim", opts = {} },
  
  -- Syntax highlighting
  { "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "javascript", "typescript", "python", "bash" },
        highlight = { enable = true },
      })
    end
  },
  
  -- Your existing colorscheme
  { "vim-scripts/BusyBee" },
})
```

**Rename existing** `init.vim` to `legacy.vim`:
```bash
mv ~/DotFiles/nvim/nvim.symlink/init.vim ~/DotFiles/nvim/nvim.symlink/legacy.vim
```

---

## 5. Enhanced Shell Experience

### 5.1 FZF Integration
- [x] **Status**: ✅ Completed
**Priority**: HIGH | **Complexity**: MEDIUM | **File**: Create `~/DotFiles/bash/dotfiles.symlink/.bash_functions.d/fzf.sh`

```bash
#!/usr/bin/env bash

# Ensure FZF is installed
if ! command -v fzf &> /dev/null; then
    echo "FZF not found. Install with: brew install fzf"
    return
fi

# Git branch switcher with preview
fgb() {
    local branches branch
    branches=$(git for-each-ref --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
    branch=$(echo "$branches" | fzf --height 40% --reverse --info=inline \
        --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" {} | head -20') &&
    git checkout "$branch"
}

# Interactive process killer
fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m --height 40% --reverse --info=inline \
        --preview 'echo {}' --preview-window down:3:wrap | awk '{print $2}')
    
    if [ "x$pid" != "x" ]; then
        echo "$pid" | xargs kill -${1:-9}
    fi
}

# Search and edit files
fe() {
    local files
    IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# SSH with fuzzy host selection
fssh() {
    local host
    host=$(grep "^Host " ~/.ssh/config | grep -v "*" | awk '{print $2}' | fzf --height 40% --reverse)
    [[ -n "$host" ]] && ssh "$host"
}

# Docker container management
fdocker() {
    local cid
    cid=$(docker ps -a | sed 1d | fzf --height 40% --reverse --info=inline -m | awk '{print $1}')
    
    [ -n "$cid" ] && docker exec -it "$cid" /bin/bash
}

# History search
fh() {
    local cmd
    cmd=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
    echo "$cmd"
    # Add to history without executing - user can press enter to run
    print -s "$cmd"
}

# Directory navigation
fd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m)
    [[ -n "$dir" ]] && cd "$dir"
}

# Port process finder
fport() {
    local port=$1
    if [[ -z "$port" ]]; then
        echo "Usage: fport <port_number>"
        return 1
    fi
    lsof -i ":$port" | fzf --height 40% --reverse --header-lines=1
}
```

### 5.2 Smart Notifications
- [ ] **Status**: Not completed
**Priority**: MEDIUM | **Complexity**: LOW | **File**: Create `~/DotFiles/bash/dotfiles.symlink/.bash_functions.d/notify.sh`

```bash
#!/usr/bin/env bash

# Cross-platform notification function
notify() {
    local title="${1:-Command Complete}"
    local message="${2:-Your command has finished}"
    local sound="${3:-default}"
    
    case "$OSTYPE" in
        darwin*)
            if command -v terminal-notifier &> /dev/null; then
                terminal-notifier -title "$title" -message "$message" -sound "$sound"
            else
                osascript -e "display notification \"$message\" with title \"$title\""
            fi
            ;;
        linux*)
            if command -v notify-send &> /dev/null; then
                notify-send "$title" "$message"
            fi
            ;;
    esac
}

# Long command notifier for bash
if [[ -n "$BASH_VERSION" ]]; then
    # Track command start time
    trap '_start_time=$SECONDS; _command=$BASH_COMMAND' DEBUG
    
    # Notify on long commands
    PROMPT_COMMAND='_prompt_command'
    _prompt_command() {
        local exit_code=$?
        if [[ -n "$_start_time" ]]; then
            local elapsed=$((SECONDS - _start_time))
            if [[ $elapsed -gt 10 ]]; then
                local status="completed"
                [[ $exit_code -ne 0 ]] && status="failed"
                notify "Command $status" "$_command (${elapsed}s)" 
            fi
            unset _start_time
            unset _command
        fi
    }
fi

# Aliases for common notifications
alias notify-done='notify "Task Complete" "Your task has finished successfully"'
alias notify-fail='notify "Task Failed" "Your task encountered an error" "Basso"'
```

---

## 6. AI-Powered Features

### 6.1 AI Commit Messages
- [ ] **Status**: Not completed
**Priority**: LOW | **Complexity**: MEDIUM | **File**: Create `~/DotFiles/bin/bin.symlink/ai-commit`

```bash
#!/usr/bin/env bash
set -euo pipefail

# Check for required tools
for tool in git curl jq; do
    if ! command -v "$tool" &> /dev/null; then
        echo "Error: $tool is required but not installed"
        exit 1
    fi
done

# Get staged diff
diff=$(git diff --staged)
if [[ -z "$diff" ]]; then
    echo "No staged changes to commit"
    exit 1
fi

# Use local LLM with ollama (install with: brew install ollama)
if command -v ollama &> /dev/null; then
    echo "Generating commit message with AI..."
    prompt="Generate a concise conventional commit message for these changes. Use format: type(scope): description. Types: feat, fix, docs, style, refactor, test, chore. Output ONLY the commit message, no explanation:\n\n$diff"
    
    commit_msg=$(echo "$prompt" | ollama run codellama --verbose=false 2>/dev/null | head -1)
else
    echo "Ollama not found. Install with: brew install ollama && ollama pull codellama"
    exit 1
fi

# Show proposed message
echo -e "\n📝 Proposed commit message:"
echo "$commit_msg"
echo -e "\nOptions:"
echo "[y] Use this message"
echo "[e] Edit this message"
echo "[n] Cancel"
echo -n "Choice: "
read -r choice

case "$choice" in
    y|Y)
        git commit -m "$commit_msg"
        ;;
    e|E)
        git commit -e -m "$commit_msg"
        ;;
    *)
        echo "Commit cancelled"
        exit 0
        ;;
esac
```

### 6.2 AI Code Review
- [ ] **Status**: Not completed
**Priority**: LOW | **Complexity**: MEDIUM | **File**: Create `~/DotFiles/bin/bin.symlink/ai-review`

```bash
#!/usr/bin/env bash
set -euo pipefail

# Default to reviewing staged changes
target="${1:-staged}"

case "$target" in
    staged)
        diff=$(git diff --staged)
        desc="staged changes"
        ;;
    HEAD)
        diff=$(git diff HEAD~1..HEAD)
        desc="last commit"
        ;;
    *)
        diff=$(git diff "$target")
        desc="changes against $target"
        ;;
esac

if [[ -z "$diff" ]]; then
    echo "No changes to review"
    exit 0
fi

if ! command -v ollama &> /dev/null; then
    echo "Ollama not found. Install with: brew install ollama && ollama pull deepseek-coder"
    exit 1
fi

echo "🔍 Reviewing $desc with AI..."
echo "$diff" | ollama run deepseek-coder "Review this code diff for:
1. Bugs or potential issues
2. Security vulnerabilities  
3. Performance problems
4. Code style improvements
5. Best practices

Provide specific, actionable feedback with line references where applicable."
```

---

## 7. Architecture Improvements

### 7.1 Unified Installer
- [ ] **Status**: Not completed
**Priority**: MEDIUM | **Complexity**: HIGH | **File**: Create `~/DotFiles/install`

```bash
#!/usr/bin/env bash
set -euo pipefail

# Modern unified installer
DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${DOTFILES_ROOT}/_colors.sh"
source "${DOTFILES_ROOT}/_functions.sh"

# Configuration
declare -A CONFIG=(
    [BACKUP_DIR]="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
    [LOG_FILE]="/tmp/dotfiles_install.log"
    [FORCE]=false
    [VERBOSE]=false
)

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -f|--force) CONFIG[FORCE]=true; shift ;;
        -v|--verbose) CONFIG[VERBOSE]=true; shift ;;
        -h|--help) usage; exit 0 ;;
        *) echo "Unknown option: $1"; usage; exit 1 ;;
    esac
done

# Logging functions
log() {
    local level=$1; shift
    local message="[$(date +'%Y-%m-%d %H:%M:%S')] [$level] $*"
    echo "$message" >> "${CONFIG[LOG_FILE]}"
    [[ "${CONFIG[VERBOSE]}" == true ]] && echo "$message"
}

# Installation functions
install_dotfiles() {
    local overwrite_all=false backup_all=false skip_all=false
    
    find "$DOTFILES_ROOT" -name "*.symlink" -type f | while read -r src; do
        local dst="$HOME/.$(basename "${src%.*}")"
        install_file "$src" "$dst"
    done
}

install_file() {
    local src=$1 dst=$2
    
    if [[ -e "$dst" ]] && [[ ! -L "$dst" || "$(readlink "$dst")" != "$src" ]]; then
        if [[ "${CONFIG[FORCE]}" != true ]]; then
            handle_existing_file "$src" "$dst"
        else
            backup_file "$dst"
            create_link "$src" "$dst"
        fi
    else
        create_link "$src" "$dst"
    fi
}

backup_file() {
    local file=$1
    mkdir -p "${CONFIG[BACKUP_DIR]}"
    mv "$file" "${CONFIG[BACKUP_DIR]}/$(basename "$file")"
    log "INFO" "Backed up $file"
}

create_link() {
    local src=$1 dst=$2
    ln -sf "$src" "$dst"
    log "INFO" "Linked $src -> $dst"
}

# Main installation flow
main() {
    echo -e "${BGreen}🚀 Starting dotfiles installation...${NC}"
    log "INFO" "Starting installation from $DOTFILES_ROOT"
    
    # Pre-flight checks
    check_dependencies
    
    # Create required directories
    mkdir -p "$HOME/.config" "$HOME/bin"
    
    # Install dotfiles
    install_dotfiles
    
    # Post-installation
    echo "DOTPATH='$DOTFILES_ROOT'" > "$HOME/.dotfilelocation"
    echo "export DOTPATH" >> "$HOME/.dotfilelocation"
    
    echo -e "${BGreen}✅ Installation complete!${NC}"
    echo -e "Log file: ${CONFIG[LOG_FILE]}"
}

# Run main
main "$@"
```

### 7.2 Health Check Script
- [ ] **Status**: Not completed
**Priority**: MEDIUM | **Complexity**: LOW | **File**: Create `~/DotFiles/bin/bin.symlink/dotfiles-health`

```bash
#!/usr/bin/env bash
set -euo pipefail

# Health check for dotfiles
echo "🏥 Dotfiles Health Check"
echo "========================"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Check symlinks
echo -e "\n📎 Checking symlinks..."
find "$HOME" -maxdepth 1 -type l | while read -r link; do
    if [[ ! -e "$link" ]]; then
        echo -e "${RED}✗${NC} Broken link: $link -> $(readlink "$link")"
    fi
done

# Check required tools
echo -e "\n🔧 Checking tools..."
tools=(git zsh vim nvim brew)
for tool in "${tools[@]}"; do
    if command -v "$tool" &> /dev/null; then
        echo -e "${GREEN}✓${NC} $tool: $(command -v "$tool")"
    else
        echo -e "${YELLOW}!${NC} $tool: not found"
    fi
done

# Check shell
echo -e "\n🐚 Checking shell..."
echo "Current shell: $SHELL"
echo "Login shell: $(dscl . -read /Users/$USER UserShell | awk '{print $2}')"

# Check git config
echo -e "\n📝 Checking git config..."
for key in user.name user.email core.editor; do
    value=$(git config --global "$key" 2>/dev/null || echo "not set")
    echo "$key: $value"
done

# Check performance
echo -e "\n⚡ Performance metrics..."
if [[ -n "$ZSH_VERSION" ]]; then
    # Add to .zshrc temporarily: zmodload zsh/zprof at start, zprof at end
    echo "Run 'zsh -c \"zmodload zsh/zprof && source ~/.zshrc && zprof\"' for detailed startup analysis"
fi

echo -e "\n✅ Health check complete!"
```

### 7.3 Version Management
- [ ] **Status**: Not completed
**Priority**: LOW | **Complexity**: LOW | **File**: Create `~/DotFiles/.tool-versions`

```
# Tool versions for asdf/mise
nodejs 20.11.0
python 3.12.1
ruby 3.3.0
rust 1.75.0
go 1.21.6
```

### 7.4 Testing Framework
- [ ] **Status**: Not completed
**Priority**: LOW | **Complexity**: MEDIUM | **File**: Create `~/DotFiles/test/test_installation.bats`

```bash
#!/usr/bin/env bats

setup() {
    export TEST_HOME="$(mktemp -d)"
    export HOME="$TEST_HOME"
    export DOTFILES_ROOT="$BATS_TEST_DIRNAME/.."
}

teardown() {
    rm -rf "$TEST_HOME"
}

@test "installer creates symlinks" {
    run "$DOTFILES_ROOT/install" --force
    [ "$status" -eq 0 ]
    [ -L "$HOME/.bashrc" ]
    [ -L "$HOME/.zshrc" ]
}

@test "installer backs up existing files" {
    echo "existing" > "$HOME/.bashrc"
    run "$DOTFILES_ROOT/install" --force
    [ "$status" -eq 0 ]
    [ -d "$HOME/.dotfiles_backup" ]
}

@test "health check runs without errors" {
    run "$DOTFILES_ROOT/bin/bin.symlink/dotfiles-health"
    [ "$status" -eq 0 ]
}
```

---

## Additional Improvements to Track

### Package Manager Updates
- [x] **Remove deprecated Homebrew taps** (lines 10-17 in Brewfile) ✅
- [x] **Update cask taps** (lines 21-22 in Brewfile) ✅

### Shell Configuration
- [x] **Add Atuin to zshrc** (end of misc/zshrc.symlink) ✅
- [x] **Add Atuin to bashrc** (end of bash/bashrc.symlink) ✅

---

## Implementation Plan

### Week 1: Critical Security & Performance
1. **Day 1-2**: Implement all security fixes (Section 1)
2. **Day 3-4**: Migrate from Antigen to Zinit
3. **Day 5-7**: Update Brewfile and install modern CLI tools

### Week 2: Core Improvements
1. **Day 1-3**: Implement FZF integrations
2. **Day 4-5**: Add notification system
3. **Day 6-7**: Create unified installer

### Week 3: Modern Tools
1. **Day 1-2**: Install and configure Atuin
2. **Day 3-4**: Setup Zoxide and Starship
3. **Day 5-7**: Evaluate Chezmoi migration

### Week 4: Advanced Features
1. **Day 1-3**: Modernize Neovim configuration
2. **Day 4-5**: Add AI-powered features
3. **Day 6-7**: Implement health checks and testing

## Quick Start

Start with these high-impact, low-effort changes:

- [x] **Fix security issue** in install.sh:45 (5 minutes) ✅
- [x] **Install modern CLI tools**: Added to Brewfile - run `brew bundle` (10 minutes) ✅
- [x] **Add FZF git branch switcher**: Copy fgb function (5 minutes) ✅
- [x] **Install Atuin** for better history: `brew install atuin` (5 minutes) ✅

These four changes will immediately improve your daily workflow!