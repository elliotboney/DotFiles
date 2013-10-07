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