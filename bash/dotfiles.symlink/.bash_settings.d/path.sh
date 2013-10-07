# All the different paths for mac
case $(uname -s) in
   Darwin)  #MAC     
      FDK_EXE="/Users/eboney/bin/FDK/Tools/osx"
      export FDK_EXE
      
      
      PATH=$HOME/bin
      PATH=${PATH}:"/usr/local/bin"
      PATH=${PATH}:"/usr/local/sbin"
      PATH=${PATH}:"/usr/local/share/npm/bin"
      PATH=${PATH}:"/usr/local/share/python"
      PATH=${PATH}:$HOME/.rvm/bin # Add RVM to PATH for scripting
      PATH=${PATH}:$HOME/.gem/bin
      # PATH=${PATH}:"/usr/local/lib/python2.7/site-packages"
      PATH=${PATH}:"/usr/local/lib/python3.3/site-packages"
      # 
      PATH=${PATH}:"/usr/local/node/bin"
      PATH=${PATH}:"/bin"
      PATH=${PATH}:"/sbin"
      PATH=${PATH}:"/opt/local/bin"
      PATH=${PATH}:"/opt/local/sbin"
      PATH=${PATH}:"/usr/bin"
      PATH=${PATH}:"/usr/sbin"
      PATH=${PATH}:$HOME/adb/sdk/tools
      PATH=${PATH}:$HOME/Android/sdk/tools

      export node="/usr/local/Cellar/node/0.10.5/bin/node":$PYTHONPATH
      export JAVA_HOME=$(/usr/libexec/java_home)
   ;;
esac

PYTHONPATH="/usr/local/lib/python2.7/site-packages"
PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

      export PATH
      export PYTHONPATH

