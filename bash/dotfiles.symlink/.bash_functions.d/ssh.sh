
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