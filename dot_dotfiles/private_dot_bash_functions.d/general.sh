#! General Stuff
function zshhighlightrules() {
  for KEY in "${(@k)ZSH_HIGHLIGHT_STYLES}"; do
    # Print the KEY value
    echo -e "${DarkGray}export {Gray}\$ZSH_HIGHLIGHT_STYLES${Gray}[${Green}$KEY${Gray}]${DarkGray}=${White}'${ZSH_HIGHLIGHT_STYLES[$KEY]}'${NC}"
  done
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
  ps aux | grep --color=always -i "$@" | grep --color=always -v  grep
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

# Pretty print JSON
function pj() {
  if $(type prettyjson >/dev/null); then
    prettyjson $@
  else
    npm install -g prettyjson && prettyjson $@
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


# Change working directory to the top-most Finder window location
function cdf() { # short for `cdfinder`
cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
}

function pdfremovepassword() {
  CRACKFILE=$1
  # unzip -ju $1 -d $(basename "${1}" .zip)
  MYBASENAME=$(basename "${CRACKFILE}" .pdf)
  gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile="${MYBASENAME}-nopw.pdf" -c .setpdfwrite -f "$1"
}
