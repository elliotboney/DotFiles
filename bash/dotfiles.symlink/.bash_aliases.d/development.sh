#########################
#          SSH          #
#########################
alias prod="ssh eboney@173.255.203.251 -p 2222"
alias prodsql="ssh eboney@173.255.197.75"
alias ell='_changetitle elliotboney.com && ssh elliotboney.com'


#########################
#          PHP          #
#########################

alias createdocs='phpdoc -d ./library/ZFDebug -t docs --template clean'


#########################
#         MISC          #
#########################

# Outputs shell colors
alias colortest='for x in 0 1 4 5 7 8; do for i in `seq 30 37`; do for a in `seq 40 47`; do echo -ne "\e[$x;$i;$a""m\\\x1b[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo "";'
