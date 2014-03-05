function andrboot(){
  tar -xvf $@ arm11boot mibib oemsbl qcsbl
  tar -H ustar -c arm11boot mibib oemsbl qcsbl > APBOOT.tar
  md5sum -t APBOOT.tar >> APBOOT.tar
  mv APBOOT.tar APBOOT.tar.md5
}

function andrcode(){
  tar -xvf $@ boot.img recovery.img system.rfs
  tar -H ustar -c boot.img recovery.img system.rfs > CODE.tar
  md5sum -t CODE.tar >> CODE.tar
  mv CODE.tar CODE.tar.md5
}

function andrmodem(){
  tar -xvf $@ amss
  tar -H ustar -c amss> MODEM.tar
  md5sum -t MODEM.tar >> MODEM.tar
  mv MODEM.tar MODEM.tar.md5
}

function andrcsc(){
  tar -xvf $@ csc.rfs
  tar -H ustar -c csc.rfs> CSC.tar
  md5sum -t CSC.tar >> CSC.tar
  mv CSC.tar CSC.tar.md5
}

function androidrun(){
  adb shell am start -n $1/$1.MainActivity
}

function adbs(){
  adb shell $@
}

function adbst() {
  adb shell input text $@
}

function adbste() {
  adb shell input text $@ && adb shell input keyevent ENTER
}