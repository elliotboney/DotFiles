#folder sizes
alias lssize='du -h --max-depth=1 . | sort -hr'

# for bypassing safety prompt
alias rmf='rm -f'
alias rmrf='rm -rf'

# Find top 5 big files
alias findbig="find . -type f -exec ls -s {} \; | sort -n -r | head -5"


alias ls="ls --color=always -hF --group-directories-first"

# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
   then
   alias ls="gls -hF --color=always --group-directories-first"
   alias la='gls -lahF --color=always --group-directories-first'
   alias chmod='sudo gchmod'
   alias chown='sudo gchown'
   alias dircolors='gdircolors'
   alias ln="gln"
   alias mv='gmv'
   alias cp='/usr/local/bin/gcp'
   alias find='gfind'
fi

# Navigation
alias ..="cd .."
alias ,,="cd .."
alias ....="cd .. && cd .."

# XXX My own mispellings
alias cd..='cd ..'

# Protection {{2
# Parenting changing perms on / #
alias chgrp='chgrp --preserve-root'
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
alias mkdir='mkdir -p'
# }}

# List the permissions
alias lsperm="/bin/ls -al|awk '{k=0;s=0;for(i=0;i<=8;i++){;k+=((substr(\$1,i+2,1)~/[rwxst]/)*2^(8-i));};j=4;for(i=4;i<=10;i+=3){;s+=((substr(\$1,i,1)~/[stST]/)*j);j/=2;};if(k){;printf(\"%0o%0o \",s,k);};print;}'"

alias cleanemptydir='find . -type d -empty -exec rmdir {} \;'

# list out directories in the path
alias path='echo $PATH | tr -s ":" "\n"'