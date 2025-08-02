#! Internet Functions

# Scan a specified host/up for open ports
function portscan() {
  if command_exists nmap; then
    nmap -A -T4 -F "${1}"
  else
    echo -e "${BRed}You need to install nmap!${NC}"
  fi
}

# Put a file on S3
function s3put() {
  if [ -z "${1}" ]; then
    echo "Usage: \`s3put filename.txt\`"
    return 1
  fi
  s356cmd put ${1} s3://s3.elliotboney.com/${1}
}

# Download a directory
function downloaddir() {
  wget -q -r -nd -l 3 --no-parent --reject-regex '\?' --reject=html,txt,htm -b "$@"
}

# Turn a file into a data url
function dataurl() {
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


# Benchmark an HTTP server
function benchmarksite() {
    # for i in {1..5}; do
        echo -e "\\\n
        ${LightGray}Benchmark for: ${BGreen}${1}${NC}\\\n\\\n
        Name Lookup:  ${Cyan}%{time_namelookup} \\\n${NC}
        Time to Connect:  ${Cyan}%{time_connect}\\\n${NC}
        Time to Pretransfer:  ${Cyan}%{time_pretransfer}\\\n${NC}
        Time to Start Transfer:  ${Cyan}%{time_starttransfer}\\\n${NC}
        ${DarkGray}----------------------${NC}\\\n
        ${BWhite}TOTAL Time:  ${BCyan}%{time_total}\\\n\\\n" | curl -w "@-" -o /dev/null -s "${1}"
        # done
    }
