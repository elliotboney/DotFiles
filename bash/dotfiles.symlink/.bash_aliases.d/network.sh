# Network Tricks
alias ports='netstat -tulan -p tcp'
alias download='curl -O'

# IP addresses
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip="ifconfig | grep \"inet \" | grep -v \"127.0\" | cut -d' ' -f 2"



# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""


# One of @janmoesen’s ProTip™s
# for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
#    alias "$method"="lwp-request -m '$method'"
# done

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'

if shell_is_elliot; then
    # Connection for work
    #alias onramp='sudo vpnc ~/Dropbox/myvpn.conf --debug 99 --natt-mode cisco-udp'

    # Connect to boxeebox
    alias boxee='telnet 192.168.1.101 2323'

    # alias profittunnel='ssh -L 3306:profittunnel.cin9lenenfmf.us-east-1.rds.amazonaws.com:3306 profit'
fi
