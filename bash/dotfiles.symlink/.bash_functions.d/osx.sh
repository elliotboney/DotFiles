# Remove spotlight indexing for a given index
function spotlightremove() {
  if [[ -z "${1}" ]]; then
    # echo a help message if no port is specified
    echo -e "\n\t${White}Useage: ${BCyan}$(basename "${0}") ${LightGray}<External Drive> ${NC}\n"
    echo -e "\n\t${White}Removed spotlight indexing and such for an external drive ${NC}\n"
  else
    mdutil -i off "${1}"
    cd ${1}
    rm -rf .{,_.}{fseventsd,Spotlight-V*,Trashes}
      mkdir .fseventsd
      touch .fseventsd/no_log .metadata_never_index .Trashes
    cd -
  fi
}

function notify () {
  osascript -e "display notification \"${1}\" with title \"${2:-Terminal}\""
}