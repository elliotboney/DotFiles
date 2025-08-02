#! My Favorites
# Get free memory
function freemem() {
    echo `top -l 1 | head -n 10 | grep PhysMem`
}

# Get current host related info.
function ii()
{
    localip=$(ifconfig | grep "inet " | grep -v "127.0" | cut -d' ' -f 2 | head -1)
    echo -e "\n${BGreen}$HOST                                               ${NC}"
    echo -e "\e[38;5;233m-----------------------------------------------------------"
    echo -e "${BRed}Additionnal information:$NC " ; uname -a
    # echo -e "${BRed}Users logged on:$NC " ; w -h |
             # cut -d " " -f1 | sort | uniq
    # echo -e "${BRed}Current date :$NC " ; date
    echo -e "${BRed}Machine stats :$NC "
    uptime | sed -e 's/^[[:space:]]*//'
    echo -e "${BRed}Memory stats :$NC " ; freemem
    echo -e "${BRed}Diskspace :$NC "
    df -BM ${HOME} || df -BM ${HOME}  #| uniq
    echo -e "${BRed}Local IP Address :$NC"
    echo -e "$localip"
    echo -e "${BRed}Public IP Address :$NC" ; curl ipinfo.io/ip #dig +short myip.opendns.com @resolver1.opendns.com
    echo
}