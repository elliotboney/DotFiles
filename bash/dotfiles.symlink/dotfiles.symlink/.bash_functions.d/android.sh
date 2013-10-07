function androidrun(){ 
    adb shell am start -n $1/$1.MainActivity 
}