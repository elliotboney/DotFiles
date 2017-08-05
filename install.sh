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
    echo -e "Homebrew not found, do you wish to install Homebrew? ${NC}(${BGreen}Y${NC}/${Red}n${NC})"
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
  echo -e "Zsh not found, do you wish to install? ${NC}(${BGreen}Y${NC}/${Red}n${NC})"
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
  echo -e "oh-my-zsh not found, do you wish to install? ${NC}(${BGreen}Y${NC}/${Red}n${NC})"
  read answer
  if echo "$answer" | grep -iq "^n" ;then
    echo -e "${LightGray}Skipping ${BRed}oh-my-zsh{NC}...";
  else
    echo -e "${BGreen}Installing oh-my-zsh...${NC}"
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
  fi
fi


#################################################
#                      vim                      #
#################################################
printf "Checking for ${BWhite}vim${NC}..." && sleep .5
if command -v vim >/dev/null 2>&1; then
  echo -e "${Green}Success!${NC}"
else
  echo -e "Vim not found, do you wish to install? ${NC}(${BGreen}Y${NC}/${Red}n${NC})"
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
    echo -e "${Green}Installing ${BGreen}Vundle Package Manager${NC}..."

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


