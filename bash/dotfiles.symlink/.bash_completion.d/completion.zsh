# @author     Sebastian Tramp <mail@sebastian.tramp.name>
# @license    http://opensource.org/licenses/gpl-license.php
#
# tab completion configuration
#

# add an autoload function path, if directory exists
# http://www.zsh.org/mla/users/2002/msg00232.html
functionsd="$ZSH_CONFIG/functions.d"
if [[ -d "$functionsd" ]] {
    fpath=( $functionsd $fpath )
    autoload -U $functionsd/*(:t)
}

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

# for all completions: color
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# for all completions: selected item
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;30\;44

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
zstyle ':completion:*' cache-path "$ZSH_CACHE"


# ~dirs: reorder output sorting: named dirs over userdirs
zstyle ':completion::*:-tilde-:*:*' group-order named-directories users

# ssh: reorder output sorting: user over hosts
zstyle ':completion::*:ssh:*:*' tag-order "users hosts"

# SSH Completion
zstyle ':completion:*:scp:*' tag-order files 'hosts:-domain:domain'
zstyle ':completion:*:scp:*' group-order files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order 'hosts:-domain:domain'
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr


# kill: advanced kill completion
zstyle ':completion::*:kill:*:*' command 'ps xf -U $USER -o pid,%cpu,cmd'
zstyle ':completion::*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;32'

# rm: advanced completion (e.g. bak files first)
# zstyle ':completion::*:rm:*:*' file-patterns '*.o:object-files:object\ file *(~|.(old|bak|BAK)):backup-files:backup\ files *~*(~|.(o|old|bak|BAK)):all-files:all\ files'

# vi: advanced completion (e.g. tex and rc files first)
zstyle ':completion::*:s:*:*' file-patterns 'Makefile|*(rc|log)|*.(php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3):vi-files:vim\ likes\ these\ files *~(Makefile|*(rc|log)|*.(log|rc|php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3)):all-files:other\ files'

# zstyle ':completion::*:lm:*:*' file-patterns '.*:all-files:other\ files'


zstyle :compinstall filename '~/.zshrc'

function __filter_homebrew {
  if [[ $1 == "" ]]; then
    # cat $HOMEBREW_SEARCH_CACHE_PATH
    brew search
  else;
    brew search $1
  fi
}

_brew() {
  if (( CURRENT == 2 )); then
    compadd list
    compadd install uninstall
    compadd link unlink
    compadd missing prune cleanup
    compadd upgrade update outdated
    compadd info edit options deps uses
    compadd home doctor update search
  elif (( CURRENT >= 3 )); then
    if (( CURRENT == 3 )); then
      if [[ $words[2] == "options" || $words[2] == "info" || $words[2] == "edit" || $words[2] == "options" || $words[2] == "deps" || $words[2] == "uses" || $words[2] == "home" ]]; then
        compadd $(__filter_homebrew ${words[3]})
      fi
    fi

    if [[ $words[2] == "install" ]]; then
      compadd $(__filter_homebrew ${words[-1]})
    elif [[ $words[2] == "uninstall" ]]; then
      compadd $(brew list)
    elif [[ $words[2] == "unlink" ]]; then
      compadd $(brew list)
    elif [[ $words[2] == "cleanup" ]]; then
      compadd $(brew list --versions | grep ' .* ' | awk '{print $1}')
    elif [[ $words[2] == "upgrade" ]]; then
      compadd $(brew outdated | awk '{print $1}')
    fi
  fi
}
compdef _brew brew

_lm() {
if (( CURRENT >= 2 )); then
    compadd $(ls -1a --color=none | grep '^\.' | grep -v '@' | grep -v '/')
  fi
}
compdef _lm lm

# zstyle ':completion:*:*:jp:*:*files' ignored-patterns '*.o'
zstyle ':completion::*:jp:*:*' file-patterns '*.json'

# Match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# vi: advanced completion (e.g. tex and rc files first)
zstyle ':completion::*:s:*:*' file-patterns 'Makefile|*(rc|log)|*.(php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3):vi-files:vim\ likes\ these\ files *~(Makefile|*(rc|log)|*.(log|rc|php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3)):all-files:other\ files'

# _wp() {
#  local -a commands
#   commands=(
#       'cache:Manage the object cache.'
#       'cap:Manage user capabilities.'
#       'cli:Get information about WP-CLI itself.'
#       'comment:Manage comments.'
#       'core:Download, install, update and otherwise manage WordPress proper.'
#       'cron:Manage WP-Cron events and schedules.'
#       'db:Perform basic database operations.'
#       'developer:Developer Plugin commands for WP-CLI.'
#       'eval:Execute arbitrary PHP code after loading WordPress.'
#       'eval-file:Load and execute a PHP file after loading WordPress.'
#       'export:Export content to a WXR file.'
#       'help:Get help on a certain command.'
#       'import:Import content from a WXR file.'
#       'media:Manage attachments.'
#       'menu:List, create, assign, and delete menus'
#       'network:Unknown'
#       'option:Manage options.'
#       'plugin:Manage plugins.'
#       'post:Manage posts.'
#       'rewrite:Manage rewrite rules.'
#       'role:Manage user roles.'
#       'scaffold:Generate code for post types, taxonomies, etc.'
#       'search-replace:Search/replace strings in the database.'
#       'shell:Interactive PHP console.'
#       'sidebar:Manage sidebars.'
#       'site:Perform site-wide operations.'
#       'super-admin:List, add, and remove super admins from a network.'
#       'term:Manage terms.'
#       'theme:Manage themes.'
#       'transient:Manage transients.'
#       'user:Manage users.'
#       'widget:Manage sidebar widgets.'
#   )

#   if (( CURRENT == 2 )); then
#     _describe -t commands 'commands' commands
#   fi

#   return 0
# }
# compdef _wp wp
# # echo "test"
# echo ${BASH_SOURCE:-$0}
# autoload bashcompinit
# bashcompinit
# source DotFiles/bash/wp-completion.bash



autoload -Uz compinit && compinit -D

