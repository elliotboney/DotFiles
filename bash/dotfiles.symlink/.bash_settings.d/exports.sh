export TERM=xterm-256color

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto"

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# Make vim the default editor
export EDITOR="vim"

# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"