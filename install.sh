#!/usr/bin/env bash
#
source _functions.sh
source _colors.sh

SHELL_PLATFORM='OTHER'
INSTALLCMD="sudo apt-get"

case "$OSTYPE" in
  *'linux'*   ) SHELL_PLATFORM='LINUX' ;;
*'darwin'*  ) SHELL_PLATFORM='OSX' ;;
*'freebsd'* ) SHELL_PLATFORM='BSD' ;;
esac

#if ! type -p shell_is_login ; then
shell_is_linux       () { [[ "$OSTYPE" == *'linux'* ]] ; }
shell_is_osx         () { [[ "$OSTYPE" == *'darwin'* ]] ; }

if (shell_is_osx); then
  INSTALLCMD="brew"
fi

APTGET_UPDATE=false

echo -e ""
#################################################
#                   Homebrew                    #
#################################################
if (shell_is_osx); then
  printf "Checking for ${BWhite}Homebrew${NC}..." && sleep .5
  if (! command_exists brew); then
    printf "Homebrew not found, do you wish to install Homebrew? ${NC}(${BGreen}Y${NC}/${Red}n${NC})"
    read answer
    if echo "$answer" | grep -iq "^n" ;then
      echo -e "Skipping homebrew..."
    else
      echo -e "${BGreen}Installing Homebrew...${NC}"
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
  else
    echo -e "${Green}Success!${NC}"
  fi
fi

#################################################
#                      Zsh                      #
#################################################
printf "Checking for ${BWhite}zsh${NC}..." && sleep .5
if command -v zsh >/dev/null 2>&1; then
  echo -e "${Green}Success!${NC}"
else
  printf "Zsh not found, do you wish to install? ${NC}(${BGreen}Y${NC}/${Red}n${NC})"
  read answer
  if echo "$answer" | grep -iq "^n" ;then
    echo -e"Zsh is required for these dotfiles. ${BRed}Aborting...";
    exit 1;
  else
    echo -e "${BGreen}Installing Zsh...${NC}"
    $INSTALLCMD update && $INSTALLCMD install zsh
    APTGET_UPDATE = true
  fi
fi

#################################################
#                      oh-my-zsh                #
#################################################
printf "Checking for ${BWhite}oh-my-zsh${NC}..." && sleep .5
if [ -d "${HOME}/.oh-my-zsh" ]; then
  echo -e "${Green}Success!${NC}"
else
  printf "oh-my-zsh not found, do you wish to install? ${NC}(${BGreen}Y${NC}/${Red}n${NC})"
  read answer
  if echo "$answer" | grep -iq "^n" ;then
    echo -e "${LightGray}Skipping ${BRed}oh-my-zsh{NC}...";
  else
    echo -e "${BGreen}Installing oh-my-zsh...${NC}"
    installohmyzsh
  fi
fi


#################################################
#                      vim                      #
#################################################
printf "Checking for ${BWhite}vim${NC}..." && sleep .5
if command -v vim >/dev/null 2>&1; then
  echo -e "${Green}Success!${NC}"
else
  printf "Vim not found, do you wish to install? ${NC}(${BGreen}Y${NC}/${Red}n${NC})"
  read answer
  if echo "$answer" | grep -iq "^n" ;then
    echo -e "${LightGray}Skipping ${BRed}Vim${NC}...";
  else
    echo -e "${Green}Installing ${BGreen}Vim${NC}..."
    if (! APTGET_UPDATE); then
      $INSTALLCMD update
      APTGET_UPDATE = true
    fi
    $INSTALLCMD install vim
    echo -e "${Green}Installing ${BGreen}Vundle Package Manager${NC}...${NC}"

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  fi
fi


#################################################
#                      Dotfiles                 #
#################################################
for dir in */; do
  echo -e "Processing ${BWhite}${dir}${NC}...";
  cd ${dir}
  for toprocess in *symlink; do
    if [[ -d "${toprocess}" ]] || [[ -f "${toprocess}" ]]; then
      printf "\tProcessing ${Blue}${toprocess}${NC}..."
      TARGET="${HOME}/.${toprocess//.symlink}"
      # echo -e "${TARGET}"
      if [[ -f "${TARGET}" ]] || [[ -d "${TARGET}" ]] || [[ -L "${TARGET}" ]]; then
        printf "\n\t${Red}${TARGET}${NC} found, do you want to skip? ${NC}(${BGreen}Y${NC}/${Red}n${NC})"
        read answer
        if echo "$answer" | grep -iq "^n" ;then
          printf "\t${White}Backing ${Blue}${TARGET}${NC} up to ${Purple}${TARGET}.pre-oh-my-zsh${NC}\n";
          mv "${TARGET}" "${TARGET}.pre-oh-my-zsh${NC}"
          printf "\t${Green}Linked! ${Blue}${toprocess}${NC} to ${Purple}${TARGET}${NC}...\n"
          ln -sr "${toprocess}" "${TARGET}" && printf "\t${Green}Linked! ${Blue}${toprocess}${NC} to ${Purple}${TARGET}${NC}..."
        else
          printf "\t${LightGray}Skipping ${TARGET}...${NC}\n";
        fi
      else
        ln -sr "${toprocess}" "${TARGET}" &&
        printf "\t${Green}Linked! ${Blue}${toprocess}${NC} to ${Purple}${TARGET}${NC}...\n"
      fi
    fi
  done
  cd ..
done



installohmyzsh() {
  # Use colors, but only if connected to a terminal, and that terminal
  # supports them.
  if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
  fi

  # Only enable exit-on-error after the non-critical colorization stuff,
  # which may fail on systems lacking tput or terminfo
  set -e

  CHECK_ZSH_INSTALLED=$(grep /zsh$ /etc/shells | wc -l)
  if [ ! $CHECK_ZSH_INSTALLED -ge 1 ]; then
    printf "${YELLOW}Zsh is not installed!${NORMAL} Please install zsh first!\n"
    exit
  fi
  unset CHECK_ZSH_INSTALLED

  if [ ! -n "$ZSH" ]; then
    ZSH=~/.oh-my-zsh
  fi

  if [ -d "$ZSH" ]; then
    printf "${YELLOW}You already have Oh My Zsh installed.${NORMAL}\n"
    printf "You'll need to remove $ZSH if you want to re-install.\n"
    exit
  fi

  # Prevent the cloned repository from having insecure permissions. Failing to do
  # so causes compinit() calls to fail with "command not found: compdef" errors
  # for users with insecure umasks (e.g., "002", allowing group writability). Note
  # that this will be ignored under Cygwin by default, as Windows ACLs take
  # precedence over umasks except for filesystems mounted with option "noacl".
  umask g-w,o-w

  printf "${BLUE}Cloning Oh My Zsh...${NORMAL}\n"
  hash git >/dev/null 2>&1 || {
    echo "Error: git is not installed"
    exit 1
  }
  # The Windows (MSYS) Git is not compatible with normal use on cygwin
  if [ "$OSTYPE" = cygwin ]; then
    if git --version | grep msysgit > /dev/null; then
      echo "Error: Windows/MSYS Git is not supported on Cygwin"
      echo "Error: Make sure the Cygwin git package is installed and is first on the path"
      exit 1
    fi
  fi
  env git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $ZSH || {
    printf "Error: git clone of oh-my-zsh repo failed\n"
    exit 1
  }


  printf "${BLUE}Looking for an existing zsh config...${NORMAL}\n"
  if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
    printf "${YELLOW}Found ~/.zshrc.${NORMAL} ${GREEN}Backing up to ~/.zshrc.pre-oh-my-zsh${NORMAL}\n";
    mv ~/.zshrc ~/.zshrc.pre-oh-my-zsh;
  fi

  printf "${BLUE}Using the Oh My Zsh template file and adding it to ~/.zshrc${NORMAL}\n"
  cp $ZSH/templates/zshrc.zsh-template ~/.zshrc
  sed "/^export ZSH=/ c\\
  export ZSH=$ZSH
  " ~/.zshrc > ~/.zshrc-omztemp
  mv -f ~/.zshrc-omztemp ~/.zshrc

  # If this user's login shell is not already "zsh", attempt to switch.
  TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
  if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
    # If this platform provides a "chsh" command (not Cygwin), do it, man!
    if hash chsh >/dev/null 2>&1; then
      printf "${BLUE}Time to change your default shell to zsh!${NORMAL}\n"
      chsh -s $(grep /zsh$ /etc/shells | tail -1)
    # Else, suggest the user do so manually.
    else
      printf "I can't change your shell automatically because this system does not have chsh.\n"
      printf "${BLUE}Please manually change your default shell to zsh!${NORMAL}\n"
    fi
  fi

  printf "${GREEN}"
  echo '         __                                     __   '
  echo '  ____  / /_     ____ ___  __  __   ____  _____/ /_  '
  echo ' / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \ '
  echo '/ /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / / '
  echo '\____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/  '
  echo '                        /____/                       ....is now installed!'
  echo ''
  echo ''
  echo 'Please look over the ~/.zshrc file to select plugins, themes, and options.'
  echo ''
  echo 'p.s. Follow us at https://twitter.com/ohmyzsh.'
  echo ''
  echo 'p.p.s. Get stickers and t-shirts at http://shop.planetargon.com.'
  echo ''
  printf "${NORMAL}"
}



