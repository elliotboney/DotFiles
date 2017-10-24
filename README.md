Table of Contents
=================
- [General](#general)
      - [My inspirations](#my-inspirations)
- [Installation](#installation)
  * [Shell Script (New & Preferred)](#shell-script-new--preferred)
  * [Ruby (Old and annoying cause you need ruby on fresh shells)](#ruby-old-and-annoying-cause-you-need-ruby-on-fresh-shells)
  * [Requirements](#requirements)
    + [zsh](#zsh)
        * [OSX](#osx)
        * [Linux](#linux)
        * [Change the shell](#change-the-shell)
    + [oh-my-zsh](#oh-my-zsh)
        * [via curl](#via-curl)
        * [via wget](#via-wget)
- [TODO](#todo)

# General #
What are [dotFiles](http://linux.about.com/cs/linux101/g/dot_file.htm "dotFiles")

The really good bash/zsh aliases, functions, etc are found in bash/dotfiles.symlink/

#### My inspirations ####
- [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
- [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles)
- [skwp/dotfiles](https://github.com/skwp/dotfiles)


# Installation #

This WILL overwrite your existing dotfiles like .bashrc, .zshrc, etc but don't worry, it will make a copy of it as `.filename.pre-oh-my-zsh`

## Shell Script (New & Preferred) ##
```shell
git clone --recurse-submodules --depth 1 https://github.com/elliotboney/DotFiles.git DotFiles
cd DotFiles
./install.sh
```


## Ruby (Old and annoying cause you need ruby on fresh shells) ##
How to install the actual dotfiles.
```shell
git clone --recurse-submodules --depth 1 https://github.com/elliotboney/DotFiles.git DotFiles
cd DotFiles
rake
```


## Requirements ##
On a new debian server, this will install the requirements:
```shell
sudo aptitude update && sudo aptitude install git ruby zsh
```

### zsh ###
Zsh is a shell designed for interactive use, although it is also a powerful scripting language. Many of the useful features of bash, ksh, and tcsh were incorporated into zsh; many original features were added. [Read More](http://zsh.sourceforge.net/)

Install zsh for your OS, then run the chsh command.
##### OSX #####
```shell
brew install zsh
```
##### Linux #####
```shell
sudo aptitude install zsh
```

##### Change the shell #####
```shell
chsh -s zsh
```

### oh-my-zsh ###
A community-driven framework for managing your zsh configuration. Includes 180+ optional plugins (rails, git, OSX, hub, capistrano, brew, ant, php, python, etc), over 120 themes to spice up your morning, and an auto-update tool so that makes it easy to keep up with the latest updates from the community. [http://ohmyz.sh/](http://ohmyz.sh/)

##### via curl
```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
##### via wget
```shell
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```

# TODO #

1. Need to document this better
