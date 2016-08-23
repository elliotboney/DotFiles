# For editing/reloading dotfiles
alias editenv="$EDITOR ~/.dotfiles/"
alias seditenv="$EDITOR ~/Dotfiles && $EDITOR ~/.zshrc && $EDITOR ~/.bashrc"
alias aeditenv="atom ~/.dotfiles"

# Reload shell after changing dotfiles
alias reloadenv='src > /dev/null 2>&1'