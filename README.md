# ***deprecated!*** #
## new version is at [elliotboney/dotfiles-chezmoi](https://github.com/elliotboney/dotfiles-chezmoi)







Table of Contents
=================
- [General](#general)
      - [My inspirations](#my-inspirations)
- [Installation](#installation)
  * [Shell Script (New & Preferred)](#shell-script-new--preferred)
  * [Ruby (Old and annoying cause you need ruby on fresh shells)](#ruby-old-and-annoying-cause-you-need-ruby-on-fresh-shells)
  * [Vim](#vim)
  * [Local Dotfiles](#local-dotfiles)
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

My dotfiles to make my life way way easier
![screenshot](https://image.ibb.co/jdYjiG/image.png)

The really good bash/zsh aliases, functions, etc are found in bash/dotfiles.symlink/

#### My inspirations ####
- [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
- [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles)
- [skwp/dotfiles](https://github.com/skwp/dotfiles)


# Installation #

This WILL overwrite your existing dotfiles like .bashrc, .zshrc, etc but don't worry, it will make a copy of it as `.filename.pre-oh-my-zsh`

## Remote Installation ##
Alternatively, you can install this into ~/DotFiles remotely without Git using curl:

```shell
sh -c "`curl -fsSL https://raw.github.com/elliotboney/DotFiles/master/remote-setup.sh`"
```
Or, using wget:
```shell
sh -c "`wget -O - --no-check-certificate https://raw.githubusercontent.com/elliotboney/DotFiles/master/remote-setup.sh`"
```


## Local Installation ##
### Shell Script (New & Preferred) ###
```shell
git clone --recurse-submodules --depth 1 https://github.com/elliotboney/DotFiles.git DotFiles
cd DotFiles
./install.sh
```


### Ruby (Old and annoying cause you need ruby on fresh shells) ###
How to install the actual dotfiles.
```shell
# sudo apt-get install ruby # install ruby if you don't have it
git clone --recurse-submodules --depth 1 https://github.com/elliotboney/DotFiles.git DotFiles
cd DotFiles
rake
```

## Vim ##
I use [dein.vim](https://github.com/Shougo/dein.vim) for vim package management. The first time you open vim, you'll
see a notice about packages not being installed. To install them async, run `:call dein#install()` in vim.

## Local Dotfiles ##
There are a couple of files you can tweak to have local commands and packages setup.

`.zshrc.local` will run last adding any commands you want. It's currently just setup to start or reattach to an existing
screen session over ssh.

`.zshpackages` overrides the default packages for [oh-my-zsh](http://ohmyz.sh/) setup in `.zshrc`

# Requirements #
On a new debian server, this will install the requirements:
```shell
sudo apt-get update && sudo apt-get install git zsh
```

### zsh ###
Zsh is a shell designed for interactive use, although it is also a powerful scripting language. Many of the useful
features of bash, ksh, and tcsh were incorporated into zsh; many original features were added.
[Read More](http://zsh.sourceforge.net/)

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
A community-driven framework for managing your zsh configuration. Includes 180+ optional plugins (rails, git, OSX, hub,
capistrano, brew, ant, php, python, etc), over 120 themes to spice up your morning, and an auto-update tool so that makes
it easy to keep up with the latest updates from the community. [http://ohmyz.sh/](http://ohmyz.sh/)

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
