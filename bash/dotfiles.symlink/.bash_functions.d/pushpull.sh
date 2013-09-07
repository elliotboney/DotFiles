function pushimage () {
  cat $1 | ssh profit "cat > /var/www/images/$1"
}

function pushcss () {
  cat $1 | ssh profit "cat > /var/www/css/$1"
}

function pushjs () {
  cat $1 | ssh profit "cat > /var/www/js/$1"
}

function push () {
  if [[ -z "$var" ]]; then
    echo -e "\n\t${BWhite}Useage: push <local> <remotepath> <sshhost>${NC}"
    echo -e "\texample: push file.txt /home/user sshhost\n"
  else 
    cat $1 | ssh $3 "cat > $2/$1"
  fi
}

function pull () {
  if [[ -z "$var" ]]; then
    echo -e "\n\t${BWhite}Useage: pull <sshhost> <remotepath> <local>${NC}"
    echo -e "\texample: pull sshhost /var/www/index.php ~/file.txt \n"
  else 
    ssh $1 "cat $2" > $3
  fi
}
