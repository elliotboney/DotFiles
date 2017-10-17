# Check Redirect
function redirectcheck() {
    if [[ -z "$1" ]]; then
        # echo a help message if no port is specified
        echo -e "\n\t${White}Useage: ${BCyan}redirectcheck ${LightGray}<site> ${NC}\n"
    else
        curl -I $1 | perl -n -e '/^Location: (.*)$/ && print "$1\n"'
    fi
}


# Rip a site
function ripsite() {
    httrack "$@" -v -N1004 -s0 -I0 --mirror -F "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.76 Safari/537.36" --clean
    mv index-2.html index.php
    rm -rf hts-cache
}

# Serve up a directory with a regular http server
function servedir () {
    if [[ -z "$1" ]]; then
        # echo a help message if no port is specified
        echo -e "\n\t${White}Useage: ${BCyan}servedir ${LightGray}<port> ${NC}\n"
    else
        # Uses CURRENT_DIR variable to help idendify in ps aux
        CURRENT_DIR=$(pwd)
        # open Chrome first since http-server waits for manual sigterm
        open -a Google\ Chrome http://localhost:$1
        http-server ${CURRENT_DIR} -p $1
        unset CURRENT_DIR
    fi
}

# Serve up a directory with PHP
function servedirphp () {
    if [[ -z "$1" ]]; then
        # echo a help message if no port is specified
        echo -e "\n\t${White}Useage: ${BCyan}servedir ${LightGray}<port> ${NC}\n"
    else
        # Uses CURRENT_DIR variable to help idendify in ps aux
        CURRENT_DIR=$(pwd)
        # open Chrome first since http-server waits for manual sigterm
        open -a Google\ Chrome http://localhost:$1
        php -S localhost:$1
        unset CURRENT_DIR
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