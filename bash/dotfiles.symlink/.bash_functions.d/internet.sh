
# Scan a specified host/up for open ports
portscan() {
  if command_exists nmap; then
    nmap -A -T4 -F "${1}"
  else
    echo -e "${BRed}You need to install nmap!${NC}"
  fi
}

# Put a file on S3
s3put() {
  if [ -z "${1}" ]; then
    echo "Usage: \`s3put filename.txt\`"
    return 1
  fi
  s3cmd put ${1} s3://elliotboney/${1}
}

# Download a directory
downloaddir() {
  wget -q -r -nd -l 3 --no-parent --reject-regex '\?' -R html,txt -b "$@"
}

# Turn a file into a data url
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

# Check cloudflare cache
cf() {
  curl -I "${1}" | grep ".*Cache.*HIT" &> /dev/null
  if [ $? == 0 ]; then
   echo -e "File is ${BGreen}Cached${NC}!"
  else
   echo -e "File is ${BRed}NOT${NC} Cached!"
  fi
}

