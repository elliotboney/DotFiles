# ---------------------------------
# Path Section
PATH=$PATH:""
if [ -e "/usr/local/Cellar/php56" ] || [ -d "/usr/local/Cellar/php56" ]; then
 PATH=$PATH:"/usr/local/Cellar/php56/$(/bin/ls /usr/local/Cellar/php56 | /usr/bin/awk 'NR==0; END{print}')/bin"
fi
# add all the paths we want to array
paths=(
    "${HOME}/.nvm/current/bin"
    "${HOME}/.yarn/bin"
    "${HOME}/.bin"
    "/usr/local/opt/coreutils/libexec/gnubin"
    "/usr/local/bin"
    "/usr/local/sbin"
    "/usr/local/lib/python2.7/site-packages"
    "${GOROOT}/bin"
    "/opt/bin"
    "/opt/sbin"
    "/bin"
    "/sbin"
    "/usr/bin"
    "/usr/sbin"
    "${HOME}/Code/Android/sdk/tools"
    "${HOME}/Code/Android/sdk/platform-tools"
    )

# iterate through array
for p in "${paths[@]}";
do
    #check if dir exists first
    if [ -e $p ] || [ -d $p ]; then
        #if it does, add to path
        PATH=${PATH}:$p
        # echo $p
    else
        # echo "[X]" $p
    fi
done

# End of Path Section comment block
# ---------------------------------




export PATH

# export HOMEBREW_GITHUB_API_TOKEN="224fed8d55ae34918c145636b0bf498a3698c907"
# export HOMEBREW_GITHUB_API_TOKEN="5a379c311fbd96ef7cd800e7980d135dd9d81797"

if [ -d ${HOME}/bin/FDK/Tools/osx ]; then
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
    # export PYTHONPATH="/usr/local/lib/python2.7/site-packages"
fi