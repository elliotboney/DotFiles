# For editing/reloading dotfiles
alias editenv="${EDITOR} ${DOTPATH}"
alias seditenv="${EDITOR} ${DOTPATH} ~/.zshrc ~/.bashrc"
alias aeditenv="atom ${DOTPATH}"

# Reload shell after changing dotfiles
alias reloadenv='src > /dev/null 2>&1'

alias benchmarkzsh='/usr/bin/time /usr/local/bin/zsh -i -c exit && /usr/bin/time /usr/local/bin/zsh -i -c exit && /usr/bin/time /usr/local/bin/zsh -i -c exit && /usr/bin/time /usr/local/bin/zsh -i -c exit'