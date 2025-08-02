#! SSH Commands

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"


# SSH to the given machine and add your id_rsa.pub or id_dsa.pub to authorized_keys.
function sshkey() {
  if [[ -z "$1" ]]; then
    # echo a help message if no host is specified
    echo -e "\n\t${White}Useage: ${BCyan}$(basename "$0") ${LightGray}<remote host> ${NC}\n"
  else
    ssh $1 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys" < ~/.ssh/id_?sa.pub  # '?sa' is a glob, not a typo!
    echo "sshkey done."
  fi
}

# SSH to give machine and copy private key to it
# I always need this for private dotfiles stuff and github
function privkey() {
  if [[ -z "$1" ]]; then
    # echo a help message if no host is specified
    echo -e "\n\t${White}Useage: ${BCyan}$(basename "$0") ${LightGray}<remote host> ${NC}\n"
  else
  cat ~/.ssh/id_rsa | ssh "${1}" "mkdir ~/.ssh; cat >> ~/.ssh/id_rsa && chmod 0600 ~/.ssh/id_rsa"
  fi
}