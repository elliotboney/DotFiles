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
    cd ${DOTPATH} && git reset --hard && git pull && cd - && source $HOME/.zshrc
}