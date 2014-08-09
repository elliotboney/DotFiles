# me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"

##################
#  extract files eg: ex tarball.tar#
##################
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)  tar -jxvf $1                        ;;
      *.tar.gz)   tar -zxvf $1                        ;;
      *.bz2)      bunzip2 $1                          ;;
      *.dmg)      hdiutil mount $1                    ;;
      *.gz)       gunzip $1                           ;;
      *.tar)      tar -xvf $1                         ;;
      *.tbz2)     tar -jxvf $1                        ;;
      *.tgz)      tar -zxvf $1                        ;;
      *.zip)      unzip $1                            ;;
      *.ZIP)      unzip $1                            ;;
      *.pax)      cat $1 | pax -r                     ;;
      *.pax.Z)    uncompress $1 --stdout | pax -r     ;;
      *.sublime-package)      unzip $1 && cd       $(basename "$1" .sublime-package) ;;
      *.Z)        uncompress $1 && cd  $(basename "$1" .Z) ;;
      *.7z)       7z x $1 && cd        $(basename "$1" .7z) ;;
      *.jar)      jar xf $1 && cd $(basename "$1" .jar) ;;
      *.rar)      unrar x $1 && cd $(basename "$1" .rar) ;;

      *)          echo "don't know how to extract '$1'..." ;;
    esac
  else
    echo "'$1' is not a file type specified in '$me'!"
fi
}

#Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

#tar.gz
tg() {
 tarfile=$1
 shift
 tar -czvf $tarfile $@
}

function installfont() {
  unzip -ju $1 -d $(basename "$1" .zip)
  for F in $(basename "$1" .zip)/*.ttf
    do
      mv $F ~/Library/Fonts/ 2>/dev/null
  done
  for F in $(basename "$1" .zip)/*.otf
    do
      mv $F ~/Library/Fonts/ 2>/dev/null
  done
  # rm -rf $(basename "$1" .zip)*
}