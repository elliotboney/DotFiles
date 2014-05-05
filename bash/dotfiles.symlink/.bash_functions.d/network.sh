function tunnel () {
    ssh -f user@personal-server.com -L 2000:personal-server.com:25 -N
}


function ripsite()
{
    httrack "$@" -v -N1004 -s0 -Q --get-files -I0 
}

function servedir ()
{
    if [[ -z "$1" ]]; then
        # echo a help message if no port is specified
        echo -e "\n\t${White}Useage: ${BCyan}servedir ${LightGray}<port> ${NC}\n"
    else
        # Uses CURRENT_DIR variable to help idendify in ps aux
        CURRENT_DIR=`pwd`
        # open Chrome first since http-server waits for manual sigterm
        open -a Google\ Chrome http://localhost:$1
        http-server ${CURRENT_DIR} -p $1
    fi
}

function servedirphp ()
{
    if [[ -z "$1" ]]; then
        # echo a help message if no port is specified
        echo -e "\n\t${White}Useage: ${BCyan}servedir ${LightGray}<port> ${NC}\n"
    else
        # Uses CURRENT_DIR variable to help idendify in ps aux
        CURRENT_DIR=`pwd`
        # open Chrome first since http-server waits for manual sigterm
        open -a Google\ Chrome http://localhost:$1
        php -S localhost:$1
    fi
}

# SSH to the given machine and add your id_rsa.pub or id_dsa.pub to authorized_keys.
function sshkey {
    if [[ -z "$1" ]]; then
        # echo a help message if no port is specified
        echo -e "\n\t${White}Useage: ${BCyan}sshkey ${LightGray}<remote host> ${NC}\n"
    else
        ssh $1 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys" < ~/.ssh/id_?sa.pub  # '?sa' is a glob, not a typo!
        echo "sshkey done."
    fi
}