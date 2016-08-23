# Updates homebrew stuff
brewu() {
  start_spinner "Updating Brew Sources..."
  brew update
  stop_spinner $?
  start_spinner "Upgrading Brew Packages..."
  brew upgrade --all > /dev/null 2>&1
  stop_spinner $?
  start_spinner "Cleaning Up After Brew"
  brew cleanup > /dev/null 2>&1
  brew prune > /dev/null 2>&1
  stop_spinner $?
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
  if [ -t 0 ]; then # argument
    python -mjson.tool <<< "$*" | pygmentize -l javascript;
  else # pipe
    python -mjson.tool | pygmentize -l javascript;
  fi;
}

# grep processes without showing grep
function psg() {
  # ps aux | grep -P "(?!.*ggrep.*)$@"
  ps aux | grep --color=always -i "$@" | grep --color=always -v  grep
}

# ---------- Replace SpotlightDB with
function elocate {
  mdfind "kMDItemDisplayName == '$@'wc";
}

# function crx() {
  #   cd /Users/eboney/Code/Javascript/mintpal
  #   php -f update.php
  #   push updates.xml /var/www/WordPress/mintpal digitalgrove.org
  #   cd ..
  #   # ruby -e "require 'rubygems'; require 'json'; puts JSON[STDIN.read]['version']"
  #   /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --pack-extension=mintpal --pack-extension-key=mintpal.pem
  #   /bin/cp -f mintpal.crx ~/Dropbox/ChromeExt/mintpal.crx
  #   push mintpal.crx /var/www/WordPress/mintpal digitalgrove.org
  # }

  function killallshit {
   if [[ -z "$1" ]]; then
    # echo a help message if no port is specified
    echo -e "\n\t${White}Useage: ${BCyan}killallshit ${LightGray}<programmatchpattern> ${NC}\n"
  else
    killall -m ".*$@.*"
  fi
}

# Pretty print JSON
function cjson () {
  local url=$(echo $1)
  if [[ "http" == $url[0,4] ]] ; then
    curl --silent $url | python -mjson.tool | pygmentize -O style=monokai -f console256 -g
  else
    cat $url | python -mjson.tool | pygmentize -O style=monokai -f console256 -g
  fi
}

function pj() {
  if $(type prettyjson >/dev/null); then
    prettyjson $@
  else
    npm install -g prettyjson
  fi
}


# `a` with no arguments opens the current directory in Atom Editor, otherwise
# opens the given location
function a() {
  if [ $# -eq 0 ]; then
    atom .;
  else
    atom "$@";
  fi;
}

function changetitle() {
  TITLE=$*;
  echo -ne "\033]0;${TITLE}\007";
}

# Change working directory to the top-most Finder window location
function cdf() { # short for `cdfinder`
cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
}

function crackpdf() {
  CRACKFILE=$1
  # unzip -ju $1 -d $(basename "${1}" .zip)
  MYBASENAME=$(basename "${CRACKFILE}" .pdf)
  gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile="${MYBASENAME}-nopw.pdf" -c .setpdfwrite -f "$1"
}
