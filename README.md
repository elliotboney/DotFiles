Table of Contents
=================
  * [General](#general)
    * [My inspirations](#my-inspirations)
  * [Installation](#installation)
    * [zsh](#zsh)
      * [OSX](#osx)
      * [Linux](#linux)
      * [Change the shell](#change-the-shell)
    * [oh-my-zsh](#oh-my-zsh)
      * [via curl](#via-curl)
      * [via wget](#via-wget)
    * [Dotfiles](#dotfiles)
  * [TODO](#todo)

# General #
What are [dotFiles](http://linux.about.com/cs/linux101/g/dot_file.htm "dotFiles")

The really good bash/zsh aliases, functions, etc are found in bash/dotfiles.symlink/

#### My inspirations ####
- [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
- [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles)
- [skwp/dotfiles](https://github.com/skwp/dotfiles)


# Installation #

## zsh ##
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

## oh-my-zsh ##
A community-driven framework for managing your zsh configuration. Includes 180+ optional plugins (rails, git, OSX, hub, capistrano, brew, ant, php, python, etc), over 120 themes to spice up your morning, and an auto-update tool so that makes it easy to keep up with the latest updates from the community. [http://ohmyz.sh/](http://ohmyz.sh/)

##### via curl
```shell
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
```
##### via wget
```shell
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
```


## Dotfiles ##
How to install the actual dotfiles.
```shell
git clone git@github.com:elliotboney/DotFiles.git DotFiles
cd DotFiles
rake
```



# TODO #

1. Need to document this better
