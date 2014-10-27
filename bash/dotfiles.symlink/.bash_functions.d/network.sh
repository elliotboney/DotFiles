function tunnel () {
    ssh -f eboney@digitalgrove.org -L 2000:google.com:80 -N
}


function ripsite()
{
    httrack "$@" -v -N1004 -s0 -I0 --mirror -F "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.76 Safari/537.36" --clean
    mv index-2.html index.php
    rm -rf hts-cache
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
        unset CURRENT_DIR
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
        unset CURRENT_DIR
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