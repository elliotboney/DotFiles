function downloaddir() {
wget -r -l 1 -nd --no-parent -b "$@" 
}

function sync () {
rsync -avz --progress -e ssh . "'eboney@$1:`pwd`'"
}