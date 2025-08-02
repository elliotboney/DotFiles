#! Shortcuts

# Open up custom DotJS stuff for a specific site
# Example `js http://www.instructables.com/`
js () {
  if [[ -z "$1" ]]; then
    s "~/.js/"
  else
    result=$(echo $1 | sed 's/https:\/\///g' | sed 's/http:\/\///g' | sed 's/\///g' | sed 's/www\.//g')

    if [ -f $HOME/.js/css/$result.scss ]; then
      cssfile=$HOME/.js/css/$result.scss
    elif [ -f $HOME/.js/css/$result.css ]; then
      cssfile=$HOME/.js/css/$result.css
    else
      cssfile=$HOME/.js/css/$result.scss
    fi

    subl $HOME/.js/ $cssfile $HOME/.js/$result.js
  fi
}

# Dropbox
alias db="cd ~/Dropbox"
# Downloads
alias d="cd ~/Downloads"
# Desktop
alias dt="cd ~/Desktop"
# Git Directory
alias g="cd ~/Git"
# Neovim Shortcut
alias v="nvim"
# Sublime Text
alias s="subl"
# Sublime Text Packages
alias st3="cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/"

# WWW Shortcuts
alias www="cd /var/www"
# Edit my Dotjs Code
alias dotjs='s ~/Code/dotjs/'

