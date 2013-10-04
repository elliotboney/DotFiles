# Use the text that has already been typed as the prefix for searching through
# commands (i.e. more intelligent Up/Down behavior)
# bind '"\e[B"': history-search-forward
# bind '"\e[A"': history-search-backward

#-------- Bindings
bind -r '\C-s'
bind '"\t":menu-complete'  # cycles through possibilities in prompt
bind 'set completion-ignore-case On'
bind 'set mark-symlinked-directories On'