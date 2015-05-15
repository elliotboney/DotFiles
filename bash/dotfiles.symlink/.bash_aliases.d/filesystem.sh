#folder sizes
alias lssize='du -h --max-depth=1 . | sort -hr'

# for bypassing safety prompt
alias rmf='rm -f'
alias rmrf='rm -rf'

# Find top 5 big files
alias findbig="find . -type f -exec ls -s {} \; | sort -n -r | head -5"


if shell_is_router; then

else
   alias ls="ls --color=always -hF --group-directories-first"
fi
# grc overides for ls
#   `brew install coreutils`
if $(gls &>/dev/null); then
   alias ls="gls -hF --color=always --group-directories-first"
   alias la='gls -lahF --color=always --group-directories-first'
   alias chmod='sudo gchmod'
   alias chown='sudo gchown'
   alias dircolors='gdircolors'
   alias ln="gln"
   alias mv='gmv'
   alias cp='/usr/local/bin/gcp'
   alias find='gfind'
   alias grep='ggrep'
else
   alias grep='grep'
fi

# find shit
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# History
alias h='history'
alias hgrep="fc -El 0 | grep"

# Navigation
alias ..="cd .."
alias ,,="cd .."
alias ....="cd .. && cd .."

# XXX My own mispellings
alias cd..='cd ..'

# Protection
alias chgrp='chgrp --preserve-root'
alias mkdir='mkdir -p'

# List the permissions
alias lsperm="/bin/ls -al|awk '{k=0;s=0;for(i=0;i<=8;i++){;k+=((substr(\$1,i+2,1)~/[rwxst]/)*2^(8-i));};j=4;for(i=4;i<=10;i+=3){;s+=((substr(\$1,i,1)~/[stST]/)*j);j/=2;};if(k){;printf(\"${Green}%0o%0o${DarkGray} \",s,k);};print;}'"

# Clean directories
alias cleanemptydir='find . -type d -empty -exec rmdir {} \;'

# list out directories in the path
# alias path='echo $PATH | tr -s ":" "\n"'