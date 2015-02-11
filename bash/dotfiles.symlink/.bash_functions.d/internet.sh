function downloaddir() {
  wget -q -r -nd -l 3 --no-parent --reject-regex '\?' -R html,txt -b "$@"
}

function sync () {
rsync -avz --progress -e ssh . "'eboney@$1:`pwd`'"
}

function dataurl() {
  local mimeType=$(file -b --mime-type "$1")
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8"
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Create a git.io short URL
function gitio() {
  if [ -z "${1}" -o -z "${2}" ]; then
    echo "Usage: \`gitio slug url\`"
    return 1
  fi
  curl -i http://git.io/ -F "url=${2}" -F "code=${1}"
}

# All the dig info
function digga() {
  dig +nocmd "$1" any +multiline +noall +answer
}


