function pushdots()   # Get current host related info.
{
    now=$(date +"%m_%d_%Y")
    if [[ -z "$1" ]]; then
        cd ${DOTPATH} && git add -A . && git commit -m "Auto dotfiles push -- $now" && git push && cd -
    else
        cd ${DOTPATH} && git add -A . && git commit -m "$1" && git push && cd -
    fi

}

function updatedotfiles() {
    cd ${DOTPATH} && git reset --hard origin/master && git pull && cd - && source $HOME/.zshrc
}

function lm () {
  MVFILE=$1
  MVFILE=${MVFILE:1:${#MVFILE}}
  # return
   # ${DIR:1:${#DIR}}
 if [[ -z "$1" ]]; then
        # echo a help message if no port is specified
        echo -e "\n\t${White}Useage: ${BCyan}lm ${LightGray}<file> ${NC}\n"
  else
      # cd ${DOTPATH} && git add -A . && git commit -m "$1" && git push && cd -
      mv "$1" ${DOTPATH}/misc/${MVFILE}.symlink
      ln -s ${DOTPATH}/misc/${MVFILE}.symlink ~/.${MVFILE}
    echo -e "\n\t${White}Moved and created a symlink for: ${BCyan}.${MVFILE}${NC}\n"

  fi
}

