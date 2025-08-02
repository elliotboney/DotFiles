# Openscad #
export OPENSCADPATH="${HOME}/Documents/OpenSCAD/libraries"

export HOMEBREW_NO_ENV_HINTS=true
export PNPM_HOME="${HOME}/.pnpm"

#
# ZSH Custom Stuff
#
if [ -z ${ZSH_HIGHLIGHT_STYLES+x} ]; then
  # zsh highlight stuff isn't set
  declare -a ZSH_HIGHLIGHT_STYLES
  typeset -gA ZSH_HIGHLIGHT_STYLES
fi
export ZSH_HIGHLIGHT_STYLES[path]='fg=33,underline'
export ZSH_HIGHLIGHT_STYLES[path_pathseperator]='fg=33,underline,bold'
# command separation tokens (;, &&)
export ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=bold'
export ZSH_HIGHLIGHT_STYLES[globbing]='fg=cyan'
# rando
export GIT_EXECUTABLE=$(which git)

# Plotting Stuff
export MPLBACKEND="module://itermplot"
export ITERMPLOT=rv

export COMPOSER_HOME="${HOME}/.composer"

# for use in my grunt stuff, etc
export ENVIRONMENT="elliot"

export DEVKITPRO="${HOME}/devkitPro"
export DEVKITPPC="${DEVKITPRO}//devkitPPC"

# pyenv stuff
export PYENV_ROOT=/usr/local/var/pyenv
if command_exists pyenv; then eval "$(pyenv init -)"; fi

  # ignore annoying https warnings
PYTHONWARNINGS="ignore:Unverified HTTPS request"


# for nvm
export NVM_SYMLINK_CURRENT=true

# if command_exists vimpager; then
  #   export PAGER=/usr/local/bin/vimpager
  #   export VIMPAGER_RC=${HOME}/.vimpagerrc
  #   alias less="$PAGER -c \"set number\""
  #   alias zless=$PAGER
  # fi

  export NVM_DIR="${HOME}/.nvm"

  #export for Atom Editor
  export ATOM_REPOS_HOME=${HOME}/Code/Atom

  # Link Homebrew casks in `/Applications` rather than `${HOME}/Applications`
  export HOMEBREW_CASK_OPTS="--appdir=/Applications";


  # For brew autocompletion
  export HOMEBREW_SEARCH_CACHE_PATH=${HOME}/.homebrew-search-cache

  export TERM=xterm-256color

  # Less Colors for Man Pages
  export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
  export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
  export LESS_TERMCAP_me=$'\E[0m'           # end mode
  export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
  export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
  export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
  export LESS_TERMCAP_ue=$'\E[0m'           # end underline

  export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"

  # Always enable colored `grep` output
  # export GREP_OPTIONS="--color=auto"

  # Prefer US English and use UTF-8
  export LANG="en_US"
  export LC_ALL="en_US.UTF-8"

  # Make some commands not show up in history
  export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

  GREP_COLORS="ms=48;5;199;38;5;255:"
  GREP_COLORS=${GREP_COLORS}:"mc=01;33:"
  GREP_COLORS=${GREP_COLORS}:"sl=38;5;245:"
  GREP_COLORS=${GREP_COLORS}:"cx=38;5;238:"
  GREP_COLORS=${GREP_COLORS}:"fn=31:"
  GREP_COLORS=${GREP_COLORS}:"ln=32:"
  GREP_COLORS=${GREP_COLORS}:"bn=38;5;238:"
  export GREP_COLORS=${GREP_COLORS}:"se=38;5;238:"



  # XDG Base Directory Specification
  # http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
  export XDG_CONFIG_HOME="$HOME/.config"
  export XDG_CACHE_HOME="$HOME/.cache"
  export ZSH_CONFIG="$XDG_CONFIG_HOME/zsh"
  export ZSH_CACHE="$XDG_CACHE_HOME/zsh"
  mkdir -p $ZSH_CACHE



  ## zsh Search stuff
  export ZSHSELECT_BOLD="1"                   # The interface will be drawn in bold font. Use "0" for no bold
export ZSHSELECT_COLOR_PAIR="green/black"   # Draw in white foreground, black background. Try e.g.: "white/green"
export ZSHSELECT_BORDER="1"                 # No border around interface, Use "1" for the border
export ZSHSELECT_ACTIVE_TEXT="reverse"      # Mark current element with reversed text. Use "underline" for marking with underline
export ZSHSELECT_START_IN_SEARCH_MODE="1"   # Starts Zsh-Select with searching active. "0" will not invoke searching at start.
