# ---------- Replace SpotlightDB with 
function elocate {
  mdfind "kMDItemDisplayName == '$@'wc"; 
}

function crx() {
  cd /Users/eboney/Code/Javascript/mintpal
  php -f update.php 
  push updates.xml /var/www/WordPress/mintpal digitalgrove.org
  cd ..
  # ruby -e "require 'rubygems'; require 'json'; puts JSON[STDIN.read]['version']"
  /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --pack-extension=mintpal --pack-extension-key=mintpal.pem
  /bin/cp -f mintpal.crx ~/Dropbox/ChromeExt/mintpal.crx
  push mintpal.crx /var/www/WordPress/mintpal digitalgrove.org
}

function killallshit {
  killall -m ".*$@.*"
}

function killallshittest {
  killall -ms ".*$@.*"
}