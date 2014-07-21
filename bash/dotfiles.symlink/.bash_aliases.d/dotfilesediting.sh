# For editing/reloading dotfiles
alias editenv='vim ~/.dotfiles/'
alias seditenv="subl ~/.dotfiles && subl ~/.zshrc"
alias aeditenv="atom ~/.dotfiles"


alias editalias='subl . $HOME/.dotfiles/.bash_aliases.d'
alias reloadenv='source $HOME/.zshrc'

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"
