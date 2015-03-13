# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

alias nhmysql="ssh -f elliot@elliot.nuhabitat.com -L 3307:54.245.117.252:3306 -N"