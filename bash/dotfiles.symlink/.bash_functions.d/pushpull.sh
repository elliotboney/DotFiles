function push () {
  if [[ -z "$1" ]]; then
    echo -e "\n\t${BWhite}Useage: push <local> <remotepath> <sshhost>${NC}"
    echo -e "\texample: push file.txt /home/user sshhost\n"

  else
    echo -e "\n\tpushing ${BCyan}$(basename $1) ${White}to ${BGreen}$2/$(basename $1) ${White}on ${BRed}$3\n"
    cat $1 | ssh $3 "cat > $2/$(basename $1)"
  fi
}

function pull () {
  if [[ -z "$1" ]]; then
    echo -e "\n\t${BWhite}Useage: pull <sshhost> <remotepath> <local>${NC}"
    echo -e "\texample: pull sshhost /var/www/index.php ~/file.txt \n"
  else
    ssh $1 "cat $2" > $3
  fi
}

# function syncstaging() {
#   if [[ -z "$1" ]]; then
#     rsync --exclude .git --exclude languages --exclude .DS_Store -e "ssh" -vz --modify-window=1 --super /private/var/www/wordpress.staging/content/themes/dgbootstrap/ eboney@digitalgrove.org:/var/www/wordpress.staging/content/themes/dgbootstrap/ --dry-run
#     echo -e "\n\tOnly did a ${BRed}DRY RUN ${NC}. To actually sync, do ${BCyan}syncstaging something${NC}\n"
#   else
#     echo -e "\n\t${BCyan}Changing owner to ${BRed} eboney:eboney${NC}\n"
#     ssh -t eboney@digitalgrove.org 'sudo chown -R eboney:eboney /var/www/wordpress.staging/content/themes/dgbootstrap/' > /dev/null 2>&1
#     rsync --exclude .git --exclude languages --exclude .DS_Store --progress -e "ssh" --modify-window=1 -auvz --super /private/var/www/wordpress.staging/content/themes/dgbootstrap/ eboney@digitalgrove.org:/var/www/wordpress.staging/content/themes/dgbootstrap/
#     echo -e "\n\t${BCyan}Changing owner to ${BGreen}www-data:www-data${NC}\n"
#     ssh -t eboney@digitalgrove.org 'sudo chmod -R g+rw /var/www/wordpress.staging/content/themes/dgbootstrap/' > /dev/null 2>&1
#     echo -e "\n\t${BCyan}Setting permissions to ${BGreen}g+rw${NC}\n"
#     ssh -t eboney@digitalgrove.org 'sudo chown -R www-data:www-data /var/www/wordpress.staging/content/themes/dgbootstrap/' > /dev/null 2>&1

#   fi
# }