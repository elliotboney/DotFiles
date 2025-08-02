###############################################################################
# _contains()
#
# Usage:
#   _contains <item> <list>
#
# Example:
#   _contains "$item" "${list[*]}"
#
# Returns:
#   0  If the item is included in the list.
#   1  If not.
_contains() {
  local _test_list=(${*:2})
  for __test_element in "${_test_list[@]:-}"
  do
    if [[ "${__test_element}" == "${1}" ]]; then
      return 0
    fi
  done
  return 1
}




###############################################################################
#  iTerm 2 Stuff
###############################################################################

# Change title of tab
function _changetitle() {
  TITLE=$*;
  echo -ne "\033]0;${TITLE}\007";
}


# Send growl alert in iterm
function _igrowl() {
  growlnotify -t "Shell Message" -m "${@}"
}

# another growl notify
function gn {
    /usr/local/bin/growlnotify Finished -m "$@"
}

# Send a growl notification when a long task is done
function long {
  shopt -s expand_aliases
  source ~/.bashrc
  $@
  /usr/local/bin/growlnotify Finished -m 'Done'
}

# Change tab colors
function tabcolor() {
  if [ $# -eq 0 ]; then
    echo -e "\033]6;1;bg;*;default\a\c"
  else
    echo -e "\033]6;1;bg;red;brightness;${1}\a\c"
    echo -e "\033]6;1;bg;green;brightness;${2}\a\c"
    echo -e "\033]6;1;bg;blue;brightness;${3}\a\c"
  fi
}

# Annotate something
function annotate() {
  echo -e "\033]1337;AddAnnotation=${@}\a\c"
}

# Bounces the dock icon
function bounce-dock() {
  echo -e "\033]1337;RequestAttention=${@}\a\c"
}


# Clears all Scrollback History
function cls() {
  echo -e "\033]1337;ClearScrollback\a\c"
}