# Colors from http://wiki.archlinux.org/index.php/Color_Bash_Prompt
# misc
NO_COLOR='\e[0m' #disable any colors
# regular colors
# # Regular Colors
# Black='\e[0;30m'        # Black
# Red='\e[0;31m'          # Red
# Green='\e[0;32m'        # Green
# Yellow='\e[0;33m'       # Yellow
# Blue='\e[0;34m'         # Blue
# Purple='\e[0;35m'       # Purple
# Cyan='\e[0;36m'         # Cyan
PWhite='\e[38;5;25m'        # PWhite
# emphasized (bolded) colors
# BBlack='\e[1;30m'       # Black
# BRed='\e[1;31m'         # Red
# BGreen='\e[1;32m'       # Green
# BYellow='\e[1;33m'      # Yellow
# BBlue='\e[1;34m'        # Blue
# BPurple='\e[1;35m'      # Purple
PBCyan='\e[1;36m'        # Cyan
# BPWhite='\e[1;37m'       # PWhite
# underlined colors
# UBlack='\e[4;30m'       # Black
# URed='\e[4;31m'         # Red
# UGreen='\e[4;32m'       # Green
# UYellow='\e[4;33m'      # Yellow
# UBlue='\e[4;34m'        # Blue
# UPurple='\e[4;35m'      # Purple
# UCyan='\e[4;36m'        # Cyan
# UPWhite='\e[4;37m'       # PWhite
# background colors
# On_Black='\e[40m'       # Black
# On_Red='\e[41m'         # Red
# ALERT='\e[41m'         # Red
# On_Green='\e[42m'       # Green
# On_Yellow='\e[43m'      # Yellow
# On_Blue='\e[44m'        # Blue
# On_Purple='\e[45m'      # Purple
# On_Cyan='\e[46m'        # Cyan
# On_PWhite='\e[47m'       # PWhite
# High Intensity
PIBlack='\e[0;90m'       # Black
# IRed='\e[0;91m'         # Red
# IGreen='\e[0;32m'       # Green
# IYellow='\e[0;93m'      # Yellow
PIBlue='\e[38;5;45m'        # Blue
# IPurple='\e[0;95m'      # Purple
# ICyan='\e[0;96m'        # Cyan
IPWhite='\e[0;97m'       # PWhite
# Bold High Intensity
BPIBlack='\e[38;5;227m'      # Black
# BIRed='\e[1;91m'        # Red
# BIGreen='\e[1;92m'      # Green
PBIYellow='\e[93m'     # Yellow
# BPIBlue='\e[1;94m'       # Blue
PBIPurple='\e[1;95m'     # Purple
# BICyan='\e[1;96m'       # Cyan
# BIPWhite='\e[1;97m'      # PWhite
# High Intensity backgrounds
# On_PIBlack='\e[0;100m'   # Black
POn_Red='\e[0;101m'     # Red
# On_IGreen='\e\e[0;92m[0;102m'   # Green
# On_IYellow='\e[0;103m'  # Yellow
# On_PIBlue='\e[0;104m'    # Blue
POn_Purple='\e[0;105m'  # Purple
# On_ICyan='\e[0;106m'    # Cyan
# On_IPWhite='\e[0;107m'   # PWhite
#LS_COLORS='di=01;37;44'; export LS_COLORS

# Test connection type:
if [ $(hostname) = "trudg.in" ]; then
   CNX=${POn_Purple}
elif [ -n "$SSH_CLIENT" ]; then
    CNX=${POn_Red}        # Connected on remote machine, via ssh (good).
elif [[ "${DISPLAY%%:0*}" != "" ]]; then
    CNX=${PIBlue}        # Connected on remote machine, not via ssh (bad).
else
    CNX=$PBCyan        # Connected on local machine.
fi

# if [ "\$(type -t __git_ps1)" ]; then # if we're in a Git repo, show current branch
#    BRANCH="\$(__git_ps1 '[ %s ] ')"
# fi


# export PS1="\[$PIBlack\][\[$PWhite\]\u\[$BPIBlack\]@\[${CNX}\]\h\[$PIBlack\]] \[$PBIYellow\]\w\[$IPWhite\] \$ \[$PBIPurple\]${BRANCH}\[$BPIBlack\]: \[$NO_COLOR\]";

# export PS1="\[$PIBlack\][\[$PWhite\]\u\[$BPIBlack\]@\[${CNX}\]\h\[$PIBlack\]] \[$PBIYellow\]\w\[$IPWhite\] \$ \[$PBIPurple\]${BRANCH}\[$BPIBlack\]: \[$NO_COLOR\]";

### This Resets the color after <CR> is pressed
trap 'echo -ne "\x1b[0m"' DEBUG
