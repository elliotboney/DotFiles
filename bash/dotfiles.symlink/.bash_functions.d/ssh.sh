
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

######################## For SSH Remote Copy #########################
export LC_SETUP_RC='command -v rclip >/dev/null 2>&1 || { echo "executing"; mkdir -p /usr/local/bin; if [ ! -f /usr/local/bin/rclip ];then wget https://raw.githubusercontent.com/justone/remotecopy/master/remotecopy -P /usr/local/bin/; ln -s /usr/local/bin/remotecopy /usr/local/bin/rclip; chmod +x /usr/local/bin/remotecopy; fi; if [[ \":\$PATH:\" == *\"/usr/local/bin:\"* ]]; then export PATH=/usr/local/bin:$PATH; fi } > /var/log/rclip.log 2>&1 || echo "Some error occured in setting up rclip. check /var/log/rclip.log"'

ssh_function() {
  count="`ps -eaf | grep remotecopyserver | grep -v grep | wc -l`";
  if [ "$count" -eq "0" ]; then
   mkdir -p $HOME/bin;
   if [ ! -f $HOME/bin/remotecopyserver ]; then
    wget https://raw.githubusercontent.com/justone/remotecopy/master/remotecopyserver -P $HOME/bin;
    chmod +x $HOME/bin/remotecopyserver;
  fi;
  nohup $HOME/bin/remotecopyserver &
fi;
ssh_cmd=`which ssh`
PARAMS=""
for PARAM in "$@"
do
  PARAMS="${PARAMS} \"${PARAM}\""
done
bash -c "ssh ${PARAMS} -R 12345:localhost:12345 -t 'echo \$LC_SETUP_RC | sudo bash; bash -l'"
}
alias ssho=`which ssh`
alias ssh=ssh_function
alias ssh2=ssh_function