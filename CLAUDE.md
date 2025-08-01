# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository that manages configuration files across multiple machines using a symlink-based installation system. Files/directories ending in `.symlink` are automatically linked to the home directory during installation.

## Key Commands

### Installation
```bash
# Primary installation method (recommended)
./install.sh

# Alternative Ruby-based installation
rake install

# Remote installation via curl
curl -fsSL https://raw.githubusercontent.com/[your-github]/DotFiles/master/remote-setup.sh | sh

# Uninstall symlinks and restore backups
rake uninstall
```

### Setup Scripts
```bash
# Install Homebrew packages from Brewfile
./setup_brew.sh

# Configure macOS system preferences
./setup_osx_defaults.sh

# Install additional shell plugins
./setup_plugins.sh

# Install custom zsh plugins
./installzshplugins
```

### Common Development Tasks
```bash
# Update all git repositories in subdirectories
git-updateall

# Check git status across all repos
git-wtf

# Clean up macOS .DS_Store files
cleanup
```

## Architecture & Conventions

### Symlink Convention
Any file or directory ending in `.symlink` gets automatically linked during installation:
- `tool/filename.symlink` → `~/.filename`
- Example: `bash/bashrc.symlink` → `~/.bashrc`

### Directory Structure
- **bash/** - Bash configurations with modular loading system
- **bin/** - Custom command-line utilities (linked to ~/bin)
- **git/** - Git configuration and templates
- **misc/** - Various app configs (eslint, curl, screen, etc.)
- **private/** - Sensitive configs (git submodule, not tracked)
- **vim/** - Vim configuration and plugin management
- **zsh/** - Zsh configuration files
- **zshcustom/** - Custom zsh plugins and themes

### Bash Modular Loading System
The bash configuration uses a sophisticated modular approach:
1. **`.bash_runfirst.d/`** - Critical early initialization
2. **`.bash_settings.d/`** - Environment variables, exports, paths
3. **`.bash_functions.d/`** - Custom function definitions
4. **`.bash_completion.d/`** - Tab completion scripts

### Platform Detection
The system automatically detects and adapts to the platform:
```bash
SHELL_PLATFORM detection:
- 'LINUX' for Linux systems
- 'OSX' for macOS
- 'BSD' for FreeBSD
```

### Plugin Management
- **Vim**: Uses vim-plug (auto-installs on first run)
- **Zsh**: Uses Antigen plugin manager
- **Homebrew**: Managed via Brewfile

## Important Implementation Details

### Installation Process
1. Checks for dependencies (zsh, oh-my-zsh, vim)
2. Traverses all directories for `*.symlink` files
3. Creates symbolic links in home directory
4. Handles conflicts (backup/overwrite/skip)
5. Creates `~/.dotfilelocation` with DOTPATH variable

### Custom Utilities Location
All scripts in `bin/bin.symlink/` are available in PATH after installation.

### Private Configuration
The `private/` directory is a git submodule for sensitive configurations that shouldn't be public.

### Vim Plugin Management
Vim plugins are managed via vim-plug in `vim/vimrc.symlink`. Run `:PlugInstall` in vim after installation.

## Working with This Repository

### Adding Existing Dotfiles from Home Directory

To bring an existing dotfile/directory from your home directory into this repository:

1. **Choose the appropriate directory** based on the tool:
   - `bash/` for bash-related configs
   - `vim/` for vim configs
   - `git/` for git configs
   - `misc/` for most other applications
   - Create a new directory if needed for specific tools

2. **Move the file/directory** and add `.symlink` suffix:
   ```bash
   # For a single file (e.g., ~/.tmux.conf)
   mv ~/.tmux.conf ~/DotFiles/misc/tmux.conf.symlink
   
   # For a directory (e.g., ~/.config/nvim/)
   mv ~/.config/nvim ~/DotFiles/nvim/nvim.symlink
   ```

3. **Run the install script** to create the symlink:
   ```bash
   ./install
   ```
   This will detect the new `.symlink` file and create: `~/.tmux.conf → ~/DotFiles/misc/tmux.conf.symlink`

4. **Verify the symlink**:
   ```bash
   ls -la ~/.tmux.conf
   # Should show: .tmux.conf -> /Users/[username]/DotFiles/misc/tmux.conf.symlink
   ```

#### Examples:

**Adding a simple config file:**
```bash
# Move .wezterm.lua to the repo
mv ~/.wezterm.lua ~/DotFiles/misc/wezterm.lua.symlink
./install
```

**Adding a config directory:**
```bash
# Move entire .config/alacritty directory
mv ~/.config/alacritty ~/DotFiles/misc/config/alacritty.symlink
./install
# Creates: ~/.config/alacritty → ~/DotFiles/misc/config/alacritty.symlink
```

**Adding with custom organization:**
```bash
# Create a new directory for the tool
mkdir ~/DotFiles/tmux
mv ~/.tmux.conf ~/DotFiles/tmux/tmux.conf.symlink
mv ~/.tmux ~/DotFiles/tmux/tmux.symlink
./install
```

### Adding New Configurations
1. Create a directory for the tool if it doesn't exist
2. Add configuration file with `.symlink` suffix
3. Run `./install` to create the symlink

### Modifying Bash Functions
Add new functions to appropriate files in `bash/dotfiles.symlink/.bash_functions.d/`:
- `fs` - Filesystem utilities
- `dev` - Development helpers
- `ai` - AI/ML utilities
- `misc` - General utilities

### Platform-Specific Code
Use the `$SHELL_PLATFORM` variable to add platform-specific behavior:
```bash
if [[ "$SHELL_PLATFORM" == 'OSX' ]]; then
    # macOS specific code
fi
```

### Testing Changes
After making changes:
1. Run `source ~/.bashrc` or `source ~/.zshrc` to reload
2. Test the specific functionality
3. Ensure cross-platform compatibility if applicable
```

## Memory Notes

- **Caution**: DO NOT run the install.sh unless explicitly asked to