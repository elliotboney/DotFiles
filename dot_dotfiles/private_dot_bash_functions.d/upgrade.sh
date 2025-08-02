#! Update Commands
function _updgandt() {
  _changetitle "$@"
  command_exists growlnotify && growlnotify -t "System Update" -m "$@"
}


# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
function update() {

  if shell_is_osx; then
    # growlnotify
    _updgandt "Running Apple Update"
    sudo softwareupdate -i -a
  fi

  if shell_is_linux; then
    _updgandt "Running Aptitude Update"
    sudo aptitude update
    sudo aptitude safe-upgrade
  fi

  if command_exists brew; then
    _updgandt "Running Brew Update"
    brew update && brew upgrade && brew cleanup
  fi

  if command_exists npm; then
    _updgandt "Running npm Global Update"
    npm update -g
  fi

  if command_exists nvm; then
    _updgandt "Running nvm update"
    cd "${NVM_DIR}"
    git fetch origin
    git checkout $(git describe --abbrev=0 --tags --match "v[0-9]*" origin)
    source "${NVM_DIR}/nvm.sh"
  fi
  if command_exists rvm; then
    _updgandt "Running rvm update"
    rvm get latest
    rvm reload
  fi

  if command_exists gem; then
    _updgandt "Updating Ruby Gems"
    sudo gem update --system
  fi

  if command_exists pear; then
    _updgandt "Updating pear"
    sudo pear upgrade
  fi

  if command_exists phpbrew; then
    _updgandt "Running PHPBrew Update"
    phpbrew self-update
  fi

  if command_exists composer; then
    _updgandt "Running Composer Update"
    composer selfupdate
  fi

    _updgandt "Updates Complete!"

}

