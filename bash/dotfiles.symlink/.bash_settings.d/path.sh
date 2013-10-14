# ---------------------------------
# Path Section

# add all the paths we want to array
paths=("$HOME/bin" "/usr/local/opt/coreutils/libexec/gnubin" "/usr/local/bin" "/usr/local/sbin" 
    "/usr/local/share/npm/bin" "/usr/local/share/python" "$HOME/.rvm/bin" "$HOME/.gem/bin" 
    "/usr/local/lib/python2.7/site-packages" "/usr/local/lib/python3.3/site-packages" 
    "${GOROOT}/bin" "/bin" "/sbin" "/opt/local/bin" "/opt/local/sbin" "/usr/bin" "/usr/sbin" 
    "$HOME/adb/sdk/tools" "$HOME/Android/sdk/tools")

# iterate through array
for p in "${paths[@]}";
do
    #check if dir exists first
    if [ -d $p ]; then
        #if it does, add to path
        PATH=$PATH:$p
        echo $p 
    else 
        echo "[X]" $p 
    fi
done

export PATH

# End of Path Section comment block
# ---------------------------------


if [ -d ~/bin/FDK/Tools/osx ]; then
    export FDK_EXE="~/bin/FDK/Tools/osx"
fi

if [ -d /usr/local/go ]; then
    export GOROOT="/usr/local/go"
fi

if [ -d /usr/local/go/bin ]; then
    export GOPATH="/usr/local/go/bin"
fi

if [ -d /usr/local/Cellar/node/0.10.5/bin/node ]; then
    export node="/usr/local/Cellar/node/0.10.5/bin/node"
fi

if [ -d /usr/local/Cellar/node/0.10.5/bin/node ]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
fi

if [ -d /usr/local/Cellar/node/0.10.5/bin/node ]; then
    export PYTHONPATH="/usr/local/lib/python2.7/site-packages"
fi

if [ -d ~/.gem ]; then
export GEM_HOME="~/.gem"
fi 

if [ -f ~/perl5/perlbrew/etc/bashrc ]; then
    source ~/perl5/perlbrew/etc/bashrc
fi

