# Configuration
# -------------
# EXPORT_FUNCTIONS: export SHELL_PLATFORM and shell_is_* functions for use
#                   in other scripts.
EXPORT_FUNCTIONS=true

# Code
# ----
# Avoid recursive invocation
[ -n "$BASHRC_DISPATCH_PID" ] && [ $$ -eq "$BASHRC_DISPATCH_PID" ] && exit
BASHRC_DISPATCH_PID=$$

HOST_NAME=`uname -n`

# Setup the main shell variables and functions
SHELL_PLATFORM='OTHER'
case "$OSTYPE" in
  *'linux'*   ) SHELL_PLATFORM='LINUX' ;;
*'darwin'*  ) SHELL_PLATFORM='OSX' ;;
*'freebsd'* ) SHELL_PLATFORM='BSD' ;;
esac

#if ! type -p shell_is_login ; then
shell_is_linux       () { [[ "$OSTYPE" == *'linux'* ]] ; }
shell_is_osx         () { [[ "$OSTYPE" == *'darwin'* ]] ; }
shell_is_elliot      () { [[ "$HOST_NAME" == *'bigscrit'* ]] ; } #|| "$HOST_NAME" == *'mainpc'* ]] ; }
shell_is_iscrit      () { [[ "$HOST_NAME" == *'bigscrit'* ]] ; }
shell_is_login       () { shopt -q login_shell ; }
shell_is_interactive () { test -n "$PS1" ; }
shell_is_script      () { ! shell_is_interactive ; }
#fi

# Make $BASH_ENV the same in interactive and non-interactive scripts
[ -z "$BASH_ENV" ] && export BASH_ENV="$BASH_SOURCE"

# Export or unset functions and shell variables
#if shell_is_elliot; then
  #echo "shell is elliot"
#fi

if $EXPORT_FUNCTIONS ; then
  fn_cmd='export'
else
  fn_cmd='unset'
fi

$fn_cmd SHELL_PLATFORM
# $fn_cmd -f shell_is_linux
# $fn_cmd -f shell_is_osx
# $fn_cmd -f shell_is_login
# $fn_cmd -f shell_is_interactive
# $fn_cmd -f shell_is_script
# $fn_cmd -f shell_is_elliot
$fn_cmd HOST_NAME

# NEW PART: {{{1
   #export PATH=$PATH:$HOME/bin
# if shell_is_interactive; then

function include_d {
  dir=$1
  if [ -d $HOME/.dotfiles/.$dir.d -a -r $HOME/.dotfiles/.$dir.d -a -x $HOME/.dotfiles/.$dir.d ]; then
   for i in $HOME/.dotfiles/.$dir.d/*sh; do
           # echo $i
           . $i
         done
       fi
     }

     include_d bash_runfirst
     include_d bash_aliases
     include_d bash_functions
     include_d bash_completion
     include_d bash_settings
# }}}
# fi

# Unset local variables
unset fn_cmd
unset EXPORT_FUNCTIONS
unset BASHRC_DISPATCH_PID

# Execute local stuff if it exists
if [ -f ~/.bashrc.local ]
  then
  source ~/.bashrc.local
fi

# Execute local stuff if it exists
# if [ -f ~/.dotfilelocation ]
#   then
#   source ~/.dotfilelocation
# fi

# Node Version Manager
# if [ -f "~/.nvm/nvm.sh" ]; then
#   source ~/.nvm/nvm.sh
# fi

if shell_is_osx; then
  if [ -f "`brew --prefix`/etc/grc.bashrc" ]
    then
    source "`brew --prefix`/etc/grc.bashrc"
  fi
fi

# export PATH="`rvm gemdir 2>/dev/null`/bin:$PATH" # Add RVM to PATH for scripting