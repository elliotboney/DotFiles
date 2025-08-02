#! Android Stuff
# Run an android app from the shell
androidrun(){
  adb shell am start -n $1/$1.MainActivity
}

# execute a shell command on android via ADB
# $ adbs ls
adbs(){
  adb shell $@
}

# Enter text on android device
adbst() {
  adb shell input text $@
}


# Enter text on android phone then press enter key
adbste() {
  adb shell input text $@ && adb shell input keyevent ENTER
}

# Reboot Connected Android Phone
alias rebootdroid='adb shell su -c reboot'

# Mount Connected Android Phone's /system as rw
alias droidrw='adb shell su -c mount -o rw,remount /system'
