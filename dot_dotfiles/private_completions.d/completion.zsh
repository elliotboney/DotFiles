if [ ! -z "$ZSHRCRUN" ]; then
  return
fi
# load completions system
zmodload -i zsh/complist

# setopt menu_complete   # do not autoselect the first completion entry

# auto rehash commands
# http://www.zsh.org/mla/users/2011/msg00531.html
zstyle ':completion:*' rehash true

# for all completions: menuselection
zstyle ':completion:*' menu select=1

# for all completions: grouping the output
zstyle ':completion:*' group-name ''

# completion of .. directories
zstyle ':completion:*' special-dirs true

# fault tolerance
zstyle ':completion:*' completer _complete _correct _approximate

# (1 error on 3 characters)
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# case insensitivity
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ":completion:*" matcher-list 'm:{A-Zöäüa-zÖÄÜ}={a-zÖÄÜA-Zöäü}'

# for all completions: grouping / headline / ...
zstyle ':completion:*:messages' format $'\e[01;36m -- %d -- \e[00;00m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found -- \e[00;00m'
zstyle ':completion:*:descriptions' format $'\e[01;34m -- %d -- \e[00;00m'
zstyle ':completion:*:corrections' format $'\e[01;36m -- %d -- \e[00;00m'

# statusline for many hits
zstyle ':completion:*:default' select-prompt $'\e[01;35m -- Match %M    %P -- \e[00;00m'

# for all completions: show comments when present
zstyle ':completion:*' verbose yes

# in menu selection strg+space to go to subdirectories
bindkey -M menuselect '^@' accept-and-infer-next-history

# case-insensitive -> partial-word (cs) -> substring completion:
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# caching of completion stuff
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${ZSH_CACHE}"


# ~dirs: reorder output sorting: named dirs over userdirs
zstyle ':completion::*:-tilde-:*:*' group-order named-directories users

# ssh: reorder output sorting: user over hosts
zstyle ':completion::*:ssh:*:*' tag-order "users hosts"

# SSH Completion
zstyle ':completion:*:scp:*' tag-order files 'hosts:-domain:domain'
zstyle ':completion:*:scp:*' group-order files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order 'hosts:-domain:domain'
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr

# RM Stuff
# zstyle ':completion:*:*:rmf:*' file-sort size

# kill: advanced kill completion
zstyle ':completion::*:kill:*:*' command 'ps xf -U $USER -o pid,%cpu,cmd'
zstyle ':completion::*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;32'

# vi: advanced completion (e.g. tex and rc files first)
zstyle ':completion::*:s:*:*' file-patterns 'Makefile|*(rc|log)|*.(php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3):vi-files:vim\ likes\ these\ files *~(Makefile|*(rc|log)|*.(log|rc|php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3)):all-files:other\ files'


zstyle :compinstall filename '${HOME}/.zshrc'

zstyle ':completion::*:kill:*:*' command 'ps xf -U $USER -o pid,%cpu,cmd'


function __filter_homebrew {
  if [[ $1 == "" ]]; then
    # cat $HOMEBREW_SEARCH_CACHE_PATH
    brew search
  else;
    brew search $1
  fi
}

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi


_lm() {
  if (( CURRENT >= 2 )); then
    compadd $(/usr/local/bin/gls -A1F | grep "^\." | grep -v '@' | grep -v 'zcompdump' | grep -v '\.DS_Store' | grep -v '\.dotfilelocation' | grep -v '\.Xauthority' | grep -v '_history' | grep -v '\.local')
  fi
}
compdef _lm lm

# _rmf() {
#   if (( CURRENT >= 2 )); then
#     compadd $(ls -A1FG)
#   fi;
# }
# # compdef _rmf rmf
# compdef _rmf rmf

# zstyle ':completion:*:*:jp:*:*files' ignored-patterns '*.o'
zstyle ':completion::*:pj:*:*' file-patterns '*.json'

# Match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# sublimetext & vi advanced completion (e.g. tex and rc files first)
zstyle ':completion::*:s:*:*' file-patterns 'Makefile|*(rc|log)|*.(php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3):vi-files:vim\ likes\ these\ files *~(Makefile|*(rc|log)|*.(log|rc|php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3)):all-files:other\ files'
zstyle ':completion::*:vim:*:*' file-patterns 'Makefile|*(rc|log)|*.(php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3):vi-files:vim\ likes\ these\ files *~(Makefile|*(rc|log)|*.(log|rc|php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3)):all-files:other\ files'

# for all completions: color
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# for all completions: selected item
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;30\;44

# new
# zstyle ':completion:*' menu select=2 eval "$(dircolors -b)"
# zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")';


autoload -Uz compinit && compinit -u