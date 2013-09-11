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
  cd ${DOTPATH}
  # echo `pwd`
  git pull
  reloadenv
}

function tester()
{
  DIR=$(python -c "import os; print os.path.realpath(\"${1}\")")
  echo $DIR
    # resolve_symlink ~/.vim

}