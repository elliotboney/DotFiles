# sweet moving shit
# @see http://www.mfasold.net/blog/2008/11/moving-or-renaming-multiple-files/
alias mmv='noglob zmv -W'

alias count='ls -1 | wc -l'

# List Folder Sizes
alias lssize='du -h --max-depth=1 . | sort -hr'

# Find top 5 big files
alias findbig="find . -type f -exec ls -s {} \; | sort -n -r | head -5"


# unzip all the files
alias extractall='unzip -o "*.zip" | rmf *.zip'

# grc overides for ls
#   `brew install coreutils`
if command_exists gls; then
   alias ls="ls -hF --group-directories-first --color=always --quoting-style={shell-always,c-maybe}"
   alias la="ls -lAhF --group-directories-first --color=always --quoting-style={shell-always,c-maybe}"
else
   alias ls="ls --color=always -hF --group-directories-first"

fi

alias grep="grep --color=auto"


# Training wheels
alias ln="ln -i"
alias mv="mv -i"
alias ln="ln -i"
alias cp="cp -i"
alias rm="rm -I"
alias chgrp='chgrp --preserve-root'
alias mkdir='mkdir -p'

# List only directories
alias lsd="ls -lF"

# find shit
# Find directories
alias fd='find . -type d -name'
# Find files
alias ff='find . -type f -name'



# History
alias h='history'
alias hgrep="fc -El 0 | grep"

# Navigation
alias ..="cd .."
alias ,,="cd .."
alias ....="cd .. && cd .."

# List the permissions
alias lsperm="/bin/ls -al|awk '{k=0;s=0;for(i=0;i<=8;i++){;k+=((substr(\$1,i+2,1)~/[rwxst]/)*2^(8-i));};j=4;for(i=4;i<=10;i+=3){;s+=((substr(\$1,i,1)~/[stST]/)*j);j/=2;};if(k){;printf(\"${Green}%0o%0o${LightGray} \",s,k);};print;}'"

# Clean directories
alias cleanemptydir='find . -type d -empty -exec rmdir {} \;'