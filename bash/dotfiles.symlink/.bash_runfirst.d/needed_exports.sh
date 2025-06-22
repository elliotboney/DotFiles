# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# source "${DIR}needed_functions.sh"
# Make sublime the default editor unless it's not avail
if [[ -f "/usr/local/bin/subl" ]]; then
  export EDITOR="/usr/local/bin/subl"
else
  export EDITOR="vim"
  alias s="vim"
fi

if [ -f "/usr/local/var/pyenv/bin/pyenv" ]; then
   PATH="/usr/local/var/pyenv/bin":$PATH
fi

if [ -d "/opt/homebrew/bin" ]; then
   PATH="/opt/homebrew/bin":$PATH
fi
