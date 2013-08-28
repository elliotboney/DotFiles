# # Execute dir colors
# if command_exists gdircolors ; then
#    eval $(gdircolors -b ~/.dotfiles/.bash_setings.d/dircolors)
# else
#    eval $(dircolors -b ~/.dotfiles/.bash_setings.d/dircolors)
# fi

dircolors -b ~/.dotfiles/.bash_setings.d/dircolors
eval $(gdircolors -b ~/.dotfiles/.dircolors)