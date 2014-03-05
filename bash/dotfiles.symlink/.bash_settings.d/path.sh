# ---------------------------------
# Path Section
PATH=""
# add all the paths we want to array
paths=("$HOME/bin" "/usr/local/opt/coreutils/libexec/gnubin" "/usr/local/bin" "/usr/local/sbin"
    "/usr/local/share/npm/bin"  "$HOME/.rvm/bin" "$HOME/.gem/bin"
    "/usr/local/lib/python2.7/site-packages" "/usr/local/lib/python3.3/site-packages"
    "${GOROOT}/bin" "/bin" "/sbin"  "/usr/bin" "/usr/sbin"
    "$HOME/Android/sdk/tools" )

#"/usr/local/share/python"
#"/opt/local/bin" "/opt/local/sbin"

# iterate through array
for p in "${paths[@]}";
do
    #check if dir exists first
    if [ -e $p ] || [ -d $p ]; then
        #if it does, add to path
        PATH=$PATH:$p
        # echo $p
     else
        # echo "[X]" $p
    fi
done

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# PATH="$HOME/.gem/bin":$PATH



# End of Path Section comment block
# ---------------------------------


if [ -e "/usr/local/Cellar/php55" ] || [ -d "/usr/local/Cellar/php55" ]; then
   PATH=$PATH:"/usr/local/Cellar/php55/$(/bin/ls /usr/local/Cellar/php55)/bin"
fi

export PATH

if [ -d ~/bin/FDK/Tools/osx ]; then
    export FDK_EXE="~/bin/FDK/Tools/osx"
fi

if [ -d /usr/local/go ]; then
    export GOROOT="/usr/local/go"
fi

if [ -d /usr/local/go/bin ]; then
    export GOPATH="/usr/local/go/bin"
fi

if [ -d /usr/local/Cellar/node ]; then
    # NODE="$(ls /usr/local/Cellar/node)"
    # which node
    export NODE="/usr/local/Cellar/node/$(ls /usr/local/Cellar/node)bin/node"
fi

if [ -d /usr/libexec/java_home ]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
fi

if [ -d /usr/local/lib/python2.7/site-packages ]; then
    export PYTHONPATH="/usr/local/lib/python2.7/site-packages"
fi

if [ -d ~/.gem ]; then
    # This was unset due to upgrade notes from rvm
    # export GEM_HOME="$HOME/.gem"
fi

if [ -f ~/perl5/perlbrew/etc/bashrc ]; then
    # source ~/perl5/perlbrew/etc/bashrc
fi

