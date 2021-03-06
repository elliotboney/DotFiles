#! OSX Stuff

# List all the kexts
alias kextlist="kextstat -kl | awk '{printf \"%i %i %s %s\n\", \$4 / 1024, \$5 / 1024, \$6, \$7}' | sort -nr"


# Empty the Trash on all mounted volumes and the main HDD
if shell_is_osx; then

 # Make a quarantine exception for a DMG
 alias quarantineremove='sudo xattr -r -d com.apple.quarantine'

 # Remove quarantine from everything in downloads
 alias quarantinefixdownloads='/usr/bin/find ~/Downloads -xattrname com.apple.quarantine -exec xattr -r -d com.apple.quarantine {} \;'

  # clean up the output of quicklook manage
  alias qlf='qlmanage -p "$@" >& /dev/null'

  # Clean out the trash
  alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; mkdir ~/.Trash"

  # reload chrome!
  alias chromereload="osascript -e 'tell application \"Google Chrome\" to tell the active tab of its first window to reload'"


  # Kill all the tabs in Chrome to free up memory
  # [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
  alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

  # Intuitive map function
  # For example, to list all directories that contain a certain file:
  # find . -name .gitattributes | map dirname
  alias map="xargs -n1"

  # Fix slow folder populating, see: http://osxdaily.com/2015/04/17/fix-slow-folder-populating-cloudkit-macosx/
  alias fixfinder="rm ~/Library/Caches/CloudKit/CloudKitMetadata*;killall cloudd"
fi

# Updates homebrew stuff
brewu() {
  start_spinner "Updating Brew Sources..."
  brew update
  stop_spinner $?
  start_spinner "Upgrading Brew Packages..."
  brew upgrade --all > /dev/null 2>&1
  stop_spinner $?
  start_spinner "Cleaning Up After Brew"
  brew cleanup > /dev/null 2>&1
  brew prune > /dev/null 2>&1
  stop_spinner $?
}

# Remove spotlight indexing for a given index
function spotlightremove() {
    if [[ -z "${1}" ]]; then
        # echo a help message if no port is specified
        echo -e "\n\t${White}Useage: ${BCyan}$(basename "${0}") ${LightGray}<External Drive> ${NC}\n"
        echo -e "\t${LightGray}Removes spotlight indexing and such for an external drive ${NC}\n"
    else
        mdutil -i off "${1}"
        cd ${1}
        rm -rf .{,_.}{fseventsd,Spotlight-V*,Trashes}
        mkdir .fseventsd
        touch .fseventsd/no_log .metadata_never_index .Trashes
        cd -
    fi
}

# Send a notification using growl or whatever it's called
function notify () {
    if [[ -z "${1}" ]]; then
        # echo a help message if no port is specified
        echo -e "\n\t${White}Useage: ${BCyan}$(basename "${0}") ${LightGray}<notification message> ${NC}\n"
    else
        osascript -e "display notification \"${1}\" with title \"${2:-Terminal}\""
    fi
}