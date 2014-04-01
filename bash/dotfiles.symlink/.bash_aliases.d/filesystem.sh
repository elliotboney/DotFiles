# for bypassing safety prompt
alias rmf='rm -f'
alias rmrf='rm -rf'

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Find top 5 big files
alias findbig="find . -type f -exec ls -s {} \; | sort -n -r | head -5"

# ================ OSX Stuff ======================
if shell_is_osx; then
   # OSX Commands {{{2
   alias dircolors='gdircolors'
   alias chmod='sudo gchmod'
   alias chown='sudo gchown'
   alias mv='gmv'
   alias cp='gcp'
   alias ls="gls -hF --color=always --group-directories-first"
   alias ln="gln"
   ## Colorize the grep command output for ease of use (good for log files) ##
   alias grep='ggrep --color=auto'
   alias igrep='ggrep -i --color=auto'
   alias find='gfind'
   #}}}
else
   alias grep='grep --color=never'
   alias ls="ls --color=always -hF --group-directories-first"
fi

# List all files colorized in long format, including dot files
alias la='ls -la --group-directories-first'
alias lg='ls | ggrep -i --color=never'
alias lag='la | ggrep -i --color=never'

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

alias lsperm="/bin/ls -al|awk '{k=0;s=0;for(i=0;i<=8;i++){;k+=((substr(\$1,i+2,1)~/[rwxst]/)*2^(8-i));};j=4;for(i=4;i<=10;i+=3){;s+=((substr(\$1,i,1)~/[stST]/)*j);j/=2;};if(k){;printf(\"%0o%0o \",s,k);};print;}'"
