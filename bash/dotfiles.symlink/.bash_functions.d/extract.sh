# me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"

##################
#  extract files eg: ex tarball.tar#
##################
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)  tar xvjf $1 && cd    $(basename "$1" .tar.bz2) ;;
      *.tar.gz)   tar xvzf $1 && cd    $(basename "$1" .tar.gz) ;;
      *.tar.xz)   tar Jxvf $1 && cd    $(basename "$1" .tar.xz) ;;
      *.bz2)      bunzip2 $1 && cd     $(basename "$1" /bz2) ;;
      *.rar)      unrar x $1 && cd     $(basename "$1" .rar) ;;
      *.gz)       gunzip $1 && cd      $(basename "$1" .gz) ;;
      *.tar)      tar xvf $1 && cd     $(basename "$1" .tar) ;;
      *.tbz2)     tar xvjf $1 && cd    $(basename "$1" .tbz2) ;;
      *.tgz)      tar xvzf $1 && cd    $(basename "$1" .tgz) ;;
      *.zip)      unzip $1 && cd       $(basename "$1" .zip) ;;
      *.Z)        uncompress $1 && cd  $(basename "$1" .Z) ;;
      *.7z)       7z x $1 && cd        $(basename "$1" .7z) ;;
      *)          echo "don't know how to extract '$1'..." ;;
    esac
  else
    echo "'$1' is not a file type specified in '$me'!"
  fi
}

#Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() {  "${1%%/}.zip" "$1" ; }

#tar.gz
tg() {
   tarfile=$1
   shift
   tar -czvf $tarfile $@
}