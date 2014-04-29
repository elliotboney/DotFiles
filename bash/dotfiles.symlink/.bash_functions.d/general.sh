# ---------- Replace SpotlightDB with 
function elocate {
  mdfind "kMDItemDisplayName == '$@'wc"; 
}

function crx() {
  /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --pack-extension=$@ --pack-extension-key=$@.pem
  cp $@.crx ~/Dropbox/ChromeExt/
}

function killallshit {
  killall -m ".*$@.*"
}

function killallshittest {
  killall -ms ".*$@.*"
}