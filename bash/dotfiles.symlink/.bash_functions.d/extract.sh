# Shortcut to extract and remove file afterwards
function ex() {
  extract $1
  rmf $1
}

# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Extracts tar.gz files
function tg() {
 tarfile=$1
 shift
 tar -czvf $tarfile $@
}

# OSX: Install a font from a zip
function installfont() {
  FONTFILE=$1
  # unzip -ju $1 -d $(basename "${1}" .zip)
  extract $1 > /dev/null 2>&1
  MYBASENAME=$(basename "${FONTFILE}" .zip)
  # echo ${MYBASENAME}
  cp "${MYBASENAME}"/**/*.[oO][tT][fF] ~/Library/Fonts/ 2>/dev/null
  if [ $? -eq 0 ]; then
    echo -e "\t${BGreen}Installed OTF!${NC}"
    rmf "${FONTFILE}"
    rm -rf "${MYBASENAME}/"
  else
    echo -e "\t${BRed}OTF not found.${NC}"
    cp "${MYBASENAME}"/**/*.[tT][tT][fF] ~/Library/Fonts/ 2>/dev/null
    if [ $? -eq 0 ]; then
      echo -e "\t${BGreen}Installed TTF!${NC}"
      rmf "${FONTFILE}"
      rm -rf "${MYBASENAME}/"
    else
      echo -e "\t${BRed}TTF not found either!${NC}"
    fi
  fi
}

function stpackageextract() {
  filename=$(basename "${1}")
  extension="${filename##*.}"
  filename="${filename%.*}"
  extract_dir="${1:t:r}"

  mv "${1}" "~/Library/Application\ Support/Sublime\ Text\ 3/Packages/${filename}.zip"
  unzip "~/Library/Application\ Support/Sublime\ Text\ 3/Packages/${filename}.zip" -d "~/Library/Application\ Support/Sublime\ Text\ 3/Packages/${filename}" > /dev/null 2>&1
  rm "~/Library/Application\ Support/Sublime\ Text\ 3/Packages/${filename}.zip"
  echo -e "Extracted ${BGreen}${1}${NC} to ${BBlue}~/Library/Application\ Support/Sublime\ Text\ 3/Packages/${filename}${NC}"
  /usr/local/bin/subl "~/Library/Application\ Support/Sublime\ Text\ 3/Packages/${filename}"
}