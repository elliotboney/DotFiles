function pushdots()   # Get current host related info.
{
    echo -e "\nMoving to DotFiles"
    cd ~/Dropbox/DotFiles
    git add -A
    git commit -m "$1"
#     echo -e "${BRed}Additionnal information:$NC " ; uname -a
#     echo -e "${BRed}Users logged on:$NC " ; w -hs |
#              cut -d " " -f1 | sort | uniq
#     echo -e "${BRed}Current date :$NC " ; date
#     echo -e "${BRed}Machine stats :$NC " ; uptime
#     echo -e "${BRed}Memory stats :$NC " ; free
#     echo -e "${BRed}Diskspace :$NC " ; mydf / $HOME
#     echo -e "${BRed}Local IP Address :$NC" ; localip
#     echo -e "${BRed}Public IP Address :$NC" ; ip
# #    echo -e "${BRed}Open connections :$NC "; netstat -an -p tcp;
#     echo
}