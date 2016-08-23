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

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'

# Edit Hosts
alias hosts='sudo $EDITOR /etc/hosts'


