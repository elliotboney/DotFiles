#export for Atom Editor
export ATOM_REPOS_HOME=~/Code/Atom

# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS="--appdir=/Applications";

export ANDROID_HOME=~/Android/sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# For brew autocompletion
export HOMEBREW_SEARCH_CACHE_PATH=~/.homebrew-search-cache

export TERM=xterm-256color

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline


export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto"

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# Make vim the default editor
export EDITOR="/usr/local/bin/subl"

# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

GREP_COLORS="ms=48;5;199;38;5;255:"
GREP_COLORS=${GREP_COLORS}:"mc=01;33:"
GREP_COLORS=${GREP_COLORS}:"sl=38;5;245:"
GREP_COLORS=${GREP_COLORS}:"cx=38;5;238:"
GREP_COLORS=${GREP_COLORS}:"fn=31:"
GREP_COLORS=${GREP_COLORS}:"ln=32:"
GREP_COLORS=${GREP_COLORS}:"bn=38;5;238:"
GREP_COLORS=${GREP_COLORS}:"se=38;5;238:"



# XDG Base Directory Specification
# http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export ZSH_CONFIG="$XDG_CONFIG_HOME/zsh"
export ZSH_CACHE="$XDG_CACHE_HOME/zsh"
mkdir -p $ZSH_CACHE
