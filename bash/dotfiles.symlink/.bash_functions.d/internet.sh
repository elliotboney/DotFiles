function downloaddir() {
wget -r -l 1 -nd --no-parent "$@" 
}