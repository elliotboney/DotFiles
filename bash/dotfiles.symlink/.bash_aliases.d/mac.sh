# Empty the Trash on all mounted volumes and the main HDD
if shell_is_osx; then
  #? clean up the output of quicklook manage
  alias qlf='qlmanage -p "$@" >& /dev/null'

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

  #delete stuff to trash
  # alias rm='rmtrash';
  # alias rmf='rmtrash -u eboney';

fi