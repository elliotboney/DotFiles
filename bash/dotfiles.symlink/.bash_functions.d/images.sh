# Fix a png file with pngcrush
pngfix () {
    if [[ -z "$1" ]]; then
        # echo a help message if no port is specified
        echo -e "\n\t${White}Useage: ${BCyan}pngfix ${LightGray}<filename> ${NC}\n"
    else
        pngcrush -rem allb -brute -reduce $1 $1.new
        mv $1 $1.bak
        mv $1.new $1
    fi
}

pngfixall () {
    for f in *.png; do
        pngcrush -rem allb -brute -reduce $f $f.new
        mv $f $f.bak
        mv $f.new $f
    done
}

jpgresizeall () {
    for f in *.jpg; do
        convert $f -resize "$1" $f.new
        mv -i $f $f.bak
        mv -i $f.new $f
    done
}

# Fix rotation of jpg by their EXIF info
fixrotation() {
    for f in *.jpg; do
        jhead -autorot "$1"
    done
}