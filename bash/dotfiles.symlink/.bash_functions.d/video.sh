function youtubeencode {
  if [[ -z "$1" ]]; then
    echo -e "\n\t${White} Useage: ${BCyan}$(basename $0) ${Green}inputfile.mov ${Yellow}outputfile.mp4\n"
  # elif [[ -z "$2" ]]; then
    # echo -e "\n\t${BRed} Missing filename ${BWhite}(e.g. output.mp4)"
    # echo -e "\n\t${White} Useage: ${BCyan}$(basename $0) ${Green}inputfile.mov ${Yellow}outputfile.mp4\n"

  else
    filename=$(basename "$1")
    filename="${filename%.*}"
    # echo "${filename}.m4a"
    ffmpeg -i $1 -c:v libx264 -profile:v high  -c:a aac -b:a 96k -strict experimental "${filename}.m4a"
  fi
}

function fixsync {
  if [[ -z "$1" ]]; then
    echo -e "\n\t${White} Useage: ${BCyan}$(basename $0) ${Green}[movie file] ${Yellow}[delay in seconds]\n"
  else
    ffmpeg -i "$1" -itsoffset $2 -i "$1" -map 0:0 -map 1:1  -acodec copy -vcodec copy "synced.$1"
  fi
}