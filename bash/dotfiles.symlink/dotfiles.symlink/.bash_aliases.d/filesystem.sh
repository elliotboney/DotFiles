# for bypassing safety prompt
alias rmf='rm -f'

# Find top 5 big files
alias findbig="find . -type f -exec ls -s {} \; | sort -n -r | head -5"

# ================ OSX Stuff ======================
if shell_is_osx; then
   # OSX Commands {{{2
   alias dircolors='gdircolors'
   alias chmod='gchmod --preserve-root'
   alias chown='gchown'
   alias mv='gmv'
   alias cp='gcp'
   alias ls="gls -hF --color=auto --group-directories-first"
   alias ln="gln"
   ## Colorize the grep command output for ease of use (good for log files) ##
   alias grep='grep --color=auto'
   #}}}
else
   alias grep='grep --color=auto'
   alias ls="ls --color=always -hF"
fi

# List all files colorized in long format, including dot files
alias la='ls -la --group-directories-first'

alias ..="cd .."
alias ....="cd .. && cd .."

# XXX My own mispellings
alias cd..='cd ..'

# Protection {{2
# Parenting changing perms on / #
alias chgrp='chgrp --preserve-root'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
# }}

alias lsmod="ls -al|awk '{k=0;s=0;for(i=0;i<=8;i++){;k+=((substr(\$1,i+2,1)~/[rwxst]/)*2^(8-i));};j=4;for(i=4;i<=10;i+=3){;s+=((substr(\$1,i,1)~/[stST]/)*j);j/=2;};if(k){;printf(\"%0o%0o \",s,k);};print;}'"