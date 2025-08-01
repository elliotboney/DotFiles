#!/usr/bin/env bash
set -euo pipefail

# Source helper files
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${DOTFILES_DIR}/_functions.sh"
source "${DOTFILES_DIR}/_colors.sh"

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
  # Add Homebrew to PATH for Apple Silicon Macs
  if [[ -f "/opt/homebrew/bin/brew" ]] && ! command -v brew &> /dev/null; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
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
    echo -e "Zsh is required for these dotfiles. ${BRed}Aborting...${NC}"
    exit 1;
  else
    echo -e "${BGreen}Installing Zsh...${NC}"
    $INSTALLCMD update && $INSTALLCMD install zsh
    APTGET_UPDATE=true
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
    echo -e "${LightGray}Skipping ${BRed}oh-my-zsh${NC}...";
  else
    echo -e "${BGreen}Installing oh-my-zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi
fi


#################################################
#                    neovim                     #
#################################################
printf "Checking for ${BWhite}neovim${NC}..." && sleep .5
if command -v nvim >/dev/null 2>&1; then
  echo -e "${Green}Success!${NC}"
else
  printf "Neovim not found, do you wish to install? ${NC}(${BGreen}Y${NC}/${Red}n${NC})"
  read answer
  if echo "$answer" | grep -iq "^n" ;then
    echo -e "${LightGray}Skipping ${BRed}Neovim${NC}...";
  else
    echo -e "${Green}Installing ${BGreen}Neovim${NC}..."
    if (! $APTGET_UPDATE); then
      $INSTALLCMD update
      APTGET_UPDATE=true
    fi
    $INSTALLCMD install neovim
    echo -e "${Green}Neovim installed!${NC}"
  fi
fi


#################################################
#                      Dotfiles                 #
#################################################

echo "DOTPATH='${DOTFILES_DIR}'" > "${HOME}/.dotfilelocation"
echo "export DOTPATH" >> "${HOME}/.dotfilelocation"

for dir in */; do
  [[ "$dir" == "_*" ]] && continue  # Skip _functions.sh, _colors.sh directories
  echo -e "Processing ${BWhite}${dir}${NC}...";
  cd "${DOTFILES_DIR}/${dir}"
  for toprocess in *symlink; do
    if [[ -d "${toprocess}" ]] || [[ -f "${toprocess}" ]]; then
      printf "\tProcessing ${Blue}${toprocess}${NC}..."
      FSOURCE="$(pwd)/${toprocess}"
#	echo -e "\nFile Source: ${FSOURCE}"
      TARGET="${HOME}/.${toprocess//.symlink}"
      # echo -e "${TARGET}"
      if [[ -f "${TARGET}" ]] || [[ -d "${TARGET}" ]] || [[ -L "${TARGET}" ]]; then
        printf "\n\t${Red}${TARGET}${NC} found, do you want to skip? ${NC}(${BGreen}Y${NC}/${Red}n${NC})"
        read answer
        if echo "$answer" | grep -iq "^n" ;then
          printf "\t${White}Backing ${Blue}${TARGET}${NC} up to ${Purple}${TARGET}.backup${NC}\n";
          mv "${TARGET}" "${TARGET}.backup"
          ln -sf "${FSOURCE}" "${TARGET}" && printf "\t${Green}Linked! ${Blue}${toprocess}${NC} to ${Purple}${TARGET}${NC}...\n"
        else
          printf "\t${LightGray}Skipping ${TARGET}...${NC}\n";
        fi
      else
        ln -sf "${FSOURCE}" "${TARGET}" && printf "\t${Green}Linked! ${Blue}${toprocess}${NC} to ${Purple}${TARGET}${NC}...\n"
      fi
    fi
  done
  cd ..
done

#################################################
#              Installation Complete            #
#################################################
echo -e "\n${BGreen}Installation complete!${NC}"
echo -e "${BWhite}Next steps:${NC}"
echo -e "  1. Restart your terminal or run: ${BGreen}source ~/.zshrc${NC}"
echo -e "  2. Run neovim and install plugins: ${BGreen}nvim +PlugInstall${NC}"
echo -e "  3. Install Homebrew packages: ${BGreen}brew bundle${NC}"
echo -e "\n${BWhite}Enjoy your new dotfiles!${NC}\n"


