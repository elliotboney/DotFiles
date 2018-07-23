#! My Favorites
# Get free memory
function freemem() {
    echo `top -l 1 | head -n 10 | grep PhysMem`
}

# Get current host related info.
function ii()
{
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "${BRed}Additionnal information:$NC " ; uname -a
    echo -e "${BRed}Users logged on:$NC " ; w -h |
             cut -d " " -f1 | sort | uniq
    echo -e "${BRed}Current date :$NC " ; date
    echo -e "${BRed}Machine stats :$NC " ; uptime
    echo -e "${BRed}Memory stats :$NC " ; freemem
    echo -e "${BRed}Diskspace :$NC " ; df / $HOME
    echo -e "${BRed}Local IP Address :$NC" ; localip
    echo -e "${BRed}Public IP Address :$NC" ; dig +short myip.opendns.com @resolver1.opendns.com
    echo
}