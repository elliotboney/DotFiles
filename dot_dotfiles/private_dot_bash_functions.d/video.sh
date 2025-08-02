#! Video Functions
# Encode a file for optimal youtube format
youtubeencode() {
  if [[ -z "$1" ]]; then
    echo -e "\n\t${White} Useage: ${BCyan}$(basename $0) ${Green}<inputfile.mov>${NC}\n"
  else
    filename=$(basename "$1")
    filename="${filename%.*}"
    ffmpeg -i $1 -codec:v libx264 -profile:v high -bf 2 -flags +cgop -c:a aac -b:a 384k -pix_fmt yuv420p -r:a 48000 -movflags faststart -strict experimental "${filename}.mp4"
  fi
}

# Convert mov to a file that can be edited in GoPro studio
movtogpro() {
    INPUTBASE=${1//+(*\/|\.*)}
    echo -e "${Green}Converting ${BCyan}${1} ${Green}to GoPro file ${BPurple}${INPUTBASE}.mp4${NC}"
    ffmpeg -i "${1}" -c copy "${INPUTBASE}.mkv"
    # ffmpeg -i "${1}" -vcodec h264 -acodec aac -strict -2 "${INPUTBASE}.mp4"
}

# Fix out of sync video by X seconds
fixsync() {
  if [[ -z "$1" ]]; then
    echo -e "\n\t${White} Useage: ${BCyan}$(basename $0) ${Green}[movie file] ${Yellow}[delay in seconds]\n"
  else
    ffmpeg -i "$1" -itsoffset $2 -i "$1" -map 0:0 -map 1:1  -acodec copy -vcodec copy "synced.$1"
  fi
}

# Cast to the office
alias castoffice='castnow --device "DaOffice"'

#  Cast to the Living Room
alias castlivingroom='castnow --device "Living Room"'