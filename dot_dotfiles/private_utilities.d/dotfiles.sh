#! Dotfiles Stuff

# Commits any changes to dotfiles and pushes to the repo
function pushdots() {
  now=$(date +"%m_%d_%Y")
  if [[ -z "$1" ]]; then
    cd ~/.local/share/chezmoi && git add -A . && git commit -m "Auto dotfiles push -- $now" && git push && cd -
  else
    cd ~/.local/share/chezmoi && git add -A . && git commit -m "$1" && git push && cd -
  fi
}

# Resets local copy of dotfiles and pulls fresh copy
function updatedotfiles() {
  chezmoi update && source $HOME/.zshrc
}

# Add a new file/directory to chezmoi (replaces old symlink system)
function lm () {
  MVFILE=$1

  if [[ -d "${MVFILE}" || -f "${MVFILE}" ]]; then
    # Use chezmoi to add the file/directory
    chezmoi add "${HOME}/${MVFILE}"
    echo -e "\n\t${White}Added to chezmoi: ${BCyan}${MVFILE}${NC}\n"
    echo -e "\t${White}Run 'chezmoi apply' to sync changes${NC}\n"
  else
    echo -e "\n\t${White}Usage: ${BCyan}lm ${LightGray}<file_or_directory> ${NC}\n"
    echo -e "\t${White}Adds file/directory to chezmoi management${NC}\n"
  fi
}

# Edit Dotfiles in Default Editor (chezmoi source directory)
alias editenv="${EDITOR} ${HOME}/.local/share/chezmoi"

# Edit Dotfiles in SublimeText (chezmoi source directory)
alias seditenv="${EDITOR} ${HOME}/.local/share/chezmoi ~/.zshrc ~/.bashrc"

# Reload shell after changing dotfiles
alias reloadenv='src > /dev/null 2>&1'

# Benchmark ZSH Shell
function benchmarkzsh() {
  /usr/bin/time /usr/local/bin/zsh -i -c exit && /usr/bin/time /usr/local/bin/zsh -i -c exit && /usr/bin/time /usr/local/bin/zsh -i -c exit && /usr/bin/time /usr/local/bin/zsh -i -c exit
}
