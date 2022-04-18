# Android Tools
export ANDROID_HOME="${HOME}/Code/Android/sdk"
# ---------------------------------
# Path Section
if command_exists brew; then
    PATH="$(brew --prefix coreutils)/bin":$PATH
    # PATH=$PATH:"$(brew --prefix homebrew/core/php@7.4)/bin"
    # PATH="$(brew --prefix homebrew/core/php@8.0)/bin"
fi

if [ -f "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc" ]; then
    source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi

# PATH=$PATH:""
if [ -e "/usr/local/Cellar/php" ] || [ -d "/usr/local/Cellar/php" ]; then
 PATH=$PATH:"/usr/local/Cellar/php/$(/bin/ls /usr/local/Cellar/php/ | /usr/bin/awk 'NR==0; END{print}')/bin"
 # PATH=$PATH:"/usr/local/Cellar/php@7.4/7.4.24/bin"
fi
# add all the paths we want to array
paths=(
    "${HOME}/.nvm/current/bin"
    "${HOME}/.yarn/bin"
    "${HOME}/.bin"
    "${HOME}/Library/Haskell/bin"
    "${HOME}/Dropbox/3D/Firmware/Marlin/buildroot/bin"
    "${HOME}/.composer/vendor/bin"
    "${HOME}/.config/composer/vendor/bin"
    "/Library/Frameworks/Mono.framework/Versions/Current/bin/"
    "/usr/local/opt/coreutils/libexec/gnubin"
    "/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin"
    "/Users/eboney/Library/Python/3.9/bin"
    "/usr/local/bin"
    "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin"
    "/usr/local/sbin"
    # "/usr/local/lib/python2.7/site-packages"
    "${GOROOT}/bin"
    "/opt/bin"
    "/opt/sbin"
    "/bin"
    "/sbin"
    "/usr/bin"
    "/usr/sbin"
    "${ANDROID_HOME}/tools"
    "${ANDROID_HOME}/platform-tools"
    )

# iterate through array
for p in "${paths[@]}";
do
    #check if dir exists first
    if [ -e $p ] || [ -d $p ]; then
        #if it does, add to path
        PATH="${PATH}:${p}"
        # echo -e "${BGreen}${p}"
    else
        # echo -e "${BRed}[X] ${p}"
    fi
done

# End of Path Section comment block
# ---------------------------------


export PATH

if [ -d ${HOME}/bin/FDK/Tools/osx ]; then
    export FDK_EXE="~/bin/FDK/Tools/osx"
fi

if [ -d /usr/local/go ]; then
    export GOROOT="/usr/local/go"
fi

if [ -d /usr/local/go/bin ]; then
    export GOPATH="/usr/local/go/bin"
fi

# if [ -d /usr/local/Cellar/node ]; then
    # NODE="$(ls /usr/local/Cellar/node)"
    # which node
    # export NODE="/usr/local/Cellar/node/$(ls /usr/local/Cellar/node)bin/node"
# fi

if [ -d /usr/libexec/java_home ]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
fi

if [ -d /usr/local/lib/python2.7/site-packages ]; then
    # export PYTHONPATH="/usr/local/lib/python2.7/site-packages"
fi