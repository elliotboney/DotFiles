# Show apps that use internet connection at the moment.
alias listinternetapps='lsof -P -i -n'

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Show Used Ports
alias ports='netstat -tulan -p tcp'

# Download a file
alias download='curl -O'

## IP addresses
# Get Public IP address
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
# Get Local IP address
alias localip="ifconfig | grep \"inet \" | grep -v \"127.0\" | cut -d' ' -f 2"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"

# Dump HTTP traffic
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|(GET|POST) \/.*\""

#% Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'

# Edit Hosts
alias hosts='sudo $EDITOR /etc/hosts'

# Ban an ip address using iptables IP
function banip() {
    if [[ -z "$1" ]]; then
        # echo a help message if no ip is specified
        echo -e "\n\t${White}Useage: ${BCyan}$(basename "${0}") ${LightGray}<ip> ${NC}\n"
    else
        sudo ufw deny from $1
    fi
}

# Remove a ban from iptables by ip address
function unbanip() {
    if [[ -z "$1" ]]; then
        # echo a help message if no ip is specified
        echo -e "\n\t${White}Useage: ${BCyan}$(basename "${0}") ${LightGray}<ip> ${NC}\n"
    else
        sudo iptables -D INPUT -s $1 -j DROP
    fi
}

# Check Redirect
function redirectcheck() {
    if [[ -z "$1" ]]; then
        # echo a help message if no site is specified
        echo -e "\n\t${White}Useage: ${BCyan}$(basename "${0}") ${LightGray}<site> ${NC}\n"
    else
        curl -I $1 | perl -n -e '/^Location: (.*)$/ && print "$1\n"'
    fi
}


# Rip a site
function ripsite() {
    if [[ -z "$1" ]]; then
        # echo a help message if no port is specified
        echo -e "\n\t${White}Useage: ${BCyan}$(basename "${0}") ${LightGray}<site> ${NC}\n"
    else
        httrack "$@" -v -N1004 -s0 -I0 --mirror -F "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.76 Safari/537.36" --clean
        mv index-2.html index.php
        rm -rf hts-cache
    fi
}

# Serve up a directory with a regular http server
function servedir () {
    if command_exists http-server; then
        if [[ -z "$1" ]]; then
            # echo a help message if no port is specified
            echo -e "\n\t${White}Useage: ${BCyan}$(basename "${0}") ${LightGray}<port> ${NC}\n"
        else
            # Uses CURRENT_DIR variable to help idendify in ps aux
            CURRENT_DIR=$(pwd)
            # open Chrome first since http-server waits for manual sigterm
            open -a Google\ Chrome http://localhost:$1
            http-server ${CURRENT_DIR} -p $1
            unset CURRENT_DIR
        fi
    else
            echo -e "\n\t${Red}You need to run ${BRed}npm install -g http-server${NC}\n"

    fi
}

# Serve up a directory with PHP
function servedirphp () {
    if [[ -z "$1" ]]; then
        # echo a help message if no port is specified
        echo -e "\n\t${White}Useage: ${BCyan}$(basename "${0}") ${LightGray}   <port> ${NC}\n"
    else
        # Uses CURRENT_DIR variable to help idendify in ps aux
        CURRENT_DIR=$(pwd)
        # open Chrome first since http-server waits for manual sigterm
        open -a Google\ Chrome http://localhost:$1
        php -S localhost:$1
        unset CURRENT_DIR
    fi
}

# Clean up all the extra screen sessions
alias cleanscreen="screen -ls | cut -d. -f1 | awk '{print $1}' | awk '{print $1}'| xargs -I{} screen -S {} -X quit"

