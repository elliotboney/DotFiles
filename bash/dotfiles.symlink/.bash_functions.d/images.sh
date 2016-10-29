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

# Fix all png files in a directory
pngfixall () {
    for f in *.png; do
        pngcrush -rem allb -brute -reduce "${f}" "${f}.new"
        mv "${f}" "${f}.bak"
        mv "${f}.new" "${f}"
    done
}

# Fix all jpeg files in a directory
jpgresizeall () {
    if [[ -z "${1}" ]]; then
        # echo a help message if no port is specified
        echo -e "\n\t${White}Useage: ${BCyan}jpgresizeall ${BPurple}<max width> ${BGreen}<max height> ${NC}\n"
    elif [[ -z "${2}" ]]; then
        # echo a help message if no port is specified
        echo -e "\n\t${White}Useage: ${BCyan}jpgresizeall ${BPurple}<max width> ${BGreen}<max height> ${NC}\n"
    else
        mogrify -resize "${1}x${2}>" *.jpg
    fi
}

# Optimize all jpeg files in a directory
jpgoptimizeall () {
    for f in *.jpg; do
        jpegoptim --max=90 --strip-com "${f}"
    done
}

# Fix rotation of jpg by their EXIF info
fixrotation() {
    for f in *.jpg; do
        jhead -autorot "$1"
    done
}

# Convert mov to a file that can be edited in GoPro studio
movtogpro() {
    INPUTBASE=${1//+(*\/|\.*)}
    echo -e "${Green}Converting ${BCyan}${1} ${Green}to GoPro file ${BPurple}${INPUTBASE}.mp4${NC}"
    ffmpeg -i "${1}" -c copy "${INPUTBASE}.mkv"
    # ffmpeg -i "${1}" -vcodec h264 -acodec aac -strict -2 "${INPUTBASE}.mp4"
}