#! Image Functions

# Get dimensions of an image
dimensions() {
    # echo -e "${1}"
    for file in ${@}; do
        # echo -e ""
        dimension=$(file "${file}" | grep -o "[0-9]\+x[0-9]\+" | sed -n '2p')
        echo "${file}: ${Green}${dimension}${NC}"

    done
}

# Fix a png file with pngcrush
pngfix () {
    if [[ -z "$1" ]]; then
        # echo a help message if no file is specified
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
    elif [[ -z "${3}" ]]; then
        zip -9 -q backup.zip *.jpg
        mogrify -resize "${1}x${2}>" *.jpg
    else
        zip -9 -q backup.zip *.jpg
        mogrify -resize "${1}x${2}>" "${3}"
    fi
}

# Fix all jpeg files in a directory
jpgresize () {
    if [[ -z "${1}" ]]; then
        # echo a help message if no port is specified
        echo -e "\n\t${White}Useage: ${BCyan}jpgresize ${BPurple}<max width> ${BGreen}<max height> ${BYellow}<file(s)>${NC}\n"
    elif [[ -z "${2}" ]]; then
        # echo a help message if no port is specified
        echo -e "\n\t${White}Useage: ${BCyan}jpgresize ${BPurple}<max width> ${BGreen}<max height> ${BYellow}<file(s)>${NC}\n"
    elif [[ -z "${3}" ]]; then
        # echo a help message if no port is specified
        echo -e "\n\t${White}Useage: ${BCyan}jpgresize ${BPurple}<max width> ${BGreen}<max height> ${BYellow}<file(s)>${NC}\n"
    else
        zip -9 -q backup.zip *.jpg
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


# Fix all png files in a directory
trimwhitespace () {
    for f in *.jpg; do
        INPUTBASE=${f//+(*\/|\.*)}
        convert "${f}" -trim +repage "${f}"
    done
}

# Name Images by Time Shot
alias jpgnames='jhead -n%Y%m%d-%H%M%S *.jpg'

# Make some thumbnails
alias makethumbs='mogrify -resize 480x480 -format jpg -quality 65 -path thumbnails *.jpg'

# Copy Addie's pics to dropbox
alias addiepics="mv /Volumes/DSC_FATDISK/DCIM/100IMAGE/*.jpg ~/Dropbox/Pics/Addie\'s\ Camera/"