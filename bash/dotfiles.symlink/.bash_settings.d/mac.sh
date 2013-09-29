if shell_is_osx; then
    
    # if SublimeText exists but there is no link to bin, make one
    [ -f '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' ] && [ ! \( -e '/usr/local/bin/subl' \) ] && ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
fi