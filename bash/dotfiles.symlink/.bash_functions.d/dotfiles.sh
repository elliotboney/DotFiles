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
  cd ${DOTPATH} && git reset --hard origin/master && git pull && cd - && source $HOME/.zshrc
}

# Add a new file/directory to my Github Dotfiles Repo
function lm () {
  MVFILE=$1

  if [[ -d "${MVFILE}" ]]; then
    MVFILE=$(echo $MVFILE | perl -pe 's|[.\/]+||ig')
    DEST="${DOTPATH}/misc/${MVFILE}.symlink"
    # mv "${1}" "${DEST}"
    # ln -s "${DEST}" "~/${1}"
    echo -e "mv \"${1}\" \"${DEST}\""
    echo -e "ln -s \"${DEST}\" \"${HOME}/${1}\""
    echo -e "\n\t${White}Moved and created a symlink for: ${BCyan}.${MVFILE}${NC}\n"

  elif [[ -f "${MVFILE}" ]]; then
    MVFILE=${MVFILE:1:${#MVFILE}}
    mv "$1" "${DOTPATH}/misc/${MVFILE}.symlink"
    ln -s "${DOTPATH}/misc/${MVFILE}.symlink" "${HOME}/.${MVFILE}"
  else
    echo -e "\n\t${White}Useage: ${BCyan}lm ${LightGray}<file> ${NC}\n"
  fi
}

