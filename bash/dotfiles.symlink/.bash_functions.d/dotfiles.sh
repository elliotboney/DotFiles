function pushdots()   # Get current host related info.
{
    cd ~/Dropbox/DotFiles 
    git add -A . && git commit -m "{$1}" && git push && cd -
}

function updatedotfiles() {
  cd ${DOTPATH} && git reset --hard && git pull && cd - && source $HOME/.bashrc
}