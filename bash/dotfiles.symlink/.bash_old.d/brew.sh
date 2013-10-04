if [ -f /usr/local/bin/brew ]; then
   if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
   fi
fi