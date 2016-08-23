# Run an android app from the shell
androidrun(){
  adb shell am start -n $1/$1.MainActivity
}

# execute a shell command on android via ADB
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