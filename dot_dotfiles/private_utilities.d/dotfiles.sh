#! Dotfiles Stuff

# Commits any changes to dotfiles and pushes to the repo
function pushdots() {
  now=$(date +"%m_%d_%Y")
  if [[ -z "$1" ]]; then
    cd ${DOTPATH} && git add -A . && git commit -m "Auto dotfiles push -- $now" && git push && cd -
  else
    cd ${DOTPATH} && git add -A . && git commit -m "$1" && git push && cd -
  fi

}

# Resets local copy of dotfiles and pulls fresh copy
function updatedotfiles() {
  cd ${DOTPATH} && git fetch && git merge && git submodule init && git submodule update && cd - && source $HOME/.zshrc
}

# Add a new file/directory to my Github Dotfiles Repo
function lm () {
  MVFILE=$1

  if [[ -d "${MVFILE}" ]]; then
    MVFILE=$(echo $MVFILE | perl -pe 's|[.\/]+||ig')
    DEST="${DOTPATH}/misc/${MVFILE}.symlink"
    mv "${1}" "${DEST}"
    ln -s "${DEST}" "${HOME}/${1}"
    # echo -e "mv \"${1}\" \"${DEST}\""
    # echo -e "ln -s \"${DEST}\" \"${HOME}/${1}\""
    echo -e "\n\t${White}Moved and created a symlink for: ${BCyan}.${MVFILE}${NC}\n"
  elif [[ -f "${MVFILE}" ]]; then
    MVFILE=${MVFILE:1:${#MVFILE}}
    mv "$1" "${DOTPATH}/misc/${MVFILE}.symlink"
    ln -s "${DOTPATH}/misc/${MVFILE}.symlink" "${HOME}/.${MVFILE}"
    echo -e "\n\t${White}Moved and created a symlink for: ${BCyan}.${MVFILE}${NC}\n"
  else
    echo -e "\n\t${White}Useage: ${BCyan}lm ${LightGray}<file> ${NC}\n"
  fi
}

# Edit Dotfiles in Default Editor
alias editenv="${EDITOR} ${DOTPATH}"

# Edit Dotfiles in SublimeText
alias seditenv="${EDITOR} ${DOTPATH} ~/.zshrc ~/.bashrc"

# Reload shell after changing dotfiles
alias reloadenv='src > /dev/null 2>&1'

# Benchmark ZSH Shell
function benchmarkzsh() {
  /usr/bin/time /usr/local/bin/zsh -i -c exit && /usr/bin/time /usr/local/bin/zsh -i -c exit && /usr/bin/time /usr/local/bin/zsh -i -c exit && /usr/bin/time /usr/local/bin/zsh -i -c exit
}
