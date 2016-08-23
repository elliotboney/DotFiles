s3put() {
  if [ -z "${1}" ]; then
    echo "Usage: \`s3put filename.txt\`"
    return 1
  fi
  s3cmd put ${1} s3://elliotboney/${1}
}

downloaddir() {
  wget -q -r -nd -l 3 --no-parent --reject-regex '\?' -R html,txt -b "$@"
}

sync () {
rsync -avz --progress -e ssh . "'eboney@$1:`pwd`'"
}

dataurl() {
  local mimeType=$(file -b --mime-type "$1")
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8"
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Create a git.io short URL
gitio() {
  if [ -z "${1}" -o -z "${2}" ]; then
    echo "\n\t${White}Usage: ${Cyan}\`gitio slug url\`\n"
    return 1
  fi
  curl -i http://git.io/ -F "url=${2}" -F "code=${1}"
}

# All the dig info
digga() {
  dig +nocmd "$1" any +multiline +noall +answer
}


# Needs `brew pip install python-googl`
googl() {
  # if [[ 1 == $(python -c 'import pkgutil; print(1 if pkgutil.find_loader("python-googl") else 0)') ]]; then
    python -c 'import googl; print googl.Googl("AIzaSyBmhMHHABhFQH2xz7dvY_3PlQzSOhYCaRI").shorten("'$1'")[u"id"]' | pbcopy
    # echo -e "${BGreen}Copied to clipboard: ${NC}`pbpaste`"
  # else
    # echo -e "\n\t${Red}You need to run ${White}\`brew pip install python-googl\`\n"
  # fi
}


