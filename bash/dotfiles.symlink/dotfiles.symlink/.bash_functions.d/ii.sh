# Normal Colors
Black='\x1b[0;30m'        # Black
Red='\x1b[0;31m'          # Red
Green='\x1b[0;32m'        # Green
Yellow='\x1b[0;33m'       # Yellow
Blue='\x1b[0;34m'         # Blue
Purple='\x1b[0;35m'       # Purple
Cyan='\x1b[0;36m'         # Cyan
White='\x1b[0;37m'        # White

# Bold
BBlack='\x1b[1;30m'       # Black
BRed='\x1b[1;31m'         # Red
BGreen='\x1b[1;32m'       # Green
BYellow='\x1b[1;33m'      # Yellow
BBlue='\x1b[1;34m'        # Blue
BPurple='\x1b[1;35m'      # Purple
BCyan='\x1b[1;36m'        # Cyan
BWhite='\x1b[1;37m'       # White

# Background
On_Black='\x1b[40m'       # Black
On_Red='\x1b[41m'         # Red
On_Green='\x1b[42m'       # Green
On_Yellow='\x1b[43m'      # Yellow
On_Blue='\x1b[44m'        # Blue
On_Purple='\x1b[45m'      # Purple
On_Cyan='\x1b[46m'        # Cyan
On_White='\x1b[47m'       # White

NC="\x1b[m"               # Color Reset

export BBlue;
export BBlack;
export BRed;

function ii()   # Get current host related info.
{
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "${BRed}Additionnal information:$NC " ; uname -a
    echo -e "${BRed}Users logged on:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "${BRed}Current date :$NC " ; date
    echo -e "${BRed}Machine stats :$NC " ; uptime
    echo -e "${BRed}Memory stats :$NC " ; free
    echo -e "${BRed}Diskspace :$NC " ; mydf / $HOME
    echo -e "${BRed}Local IP Address :$NC" ; localip
    echo -e "${BRed}Public IP Address :$NC" ; ip
#    echo -e "${BRed}Open connections :$NC "; netstat -an -p tcp;
    echo
}