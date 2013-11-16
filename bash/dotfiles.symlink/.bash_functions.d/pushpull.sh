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

function syncstaging() {
  if [[ -z "$1" ]]; then
    rsync --exclude .git --exclude .php --exclude languages --exclude .ai --exclude .DS_Store -e "ssh" -vz --modify-window=1 --super /private/var/www/wordpress.staging/content/themes/dgbootstrap/ eboney@digitalgrove.org:/var/www/wordpress.staging/content/themes/dgbootstrap/ --dry-run
    echo -e "\n\tOnly did a ${BRed}DRY RUN ${NC}. To actually sync, do ${BCyan}syncstaging something${NC}\n"
  else 
    rsync --exclude .git --exclude .php --exclude languages --exclude .ai --exclude .DS_Store -e "ssh" -avz --super /private/var/www/wordpress.staging/content/themes/dgbootstrap/ eboney@digitalgrove.org:/var/www/wordpress.staging/content/themes/dgbootstrap/
  fi
}