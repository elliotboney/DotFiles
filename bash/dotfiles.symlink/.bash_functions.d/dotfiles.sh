function pushdots()   # Get current host related info.
{
    echo -e "\nMoving to DotFiles"
    cd ~/Dropbox/DotFiles
    git add -A .
    git commit -m "{$1}"
    git push
    cl
}

function updatedotfiles() {
  cd ${DOTPATH} && git pull && cd - && source $HOME/.bashrc
}