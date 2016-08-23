# Install Grunt plugins and add them as `devDependencies` to `package.json`
# Usage: `gruntinstall contrib-watch contrib-uglify zopfli`
function gruntinstall() {
  if [[ -z "$1" ]]; then
    echo -e "\n\t${BCyan} Useage: ${White}gruntinstall ${Yellow}contrib-watch contrib-uglify zopfli${NC}\n"
  else
    npm install --save-dev ${*/#/grunt-}
  fi
}