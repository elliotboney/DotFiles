# Network Tricks
alias ports='netstat -tulan -p tcp'
alias download='curl -O'

# IP addresses
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip='ipconfig getifaddr en1'

# Connect to boxeebox
alias boxee='telnet 192.168.2.101 2323'

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
   alias "$method"="lwp-request -m '$method'"
done

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'