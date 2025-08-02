#! Archive Extraction and Creation
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
  MYBASENAME=${FONTFILE%.*}
  # MYBASENAME=$(basename "${FONTFILE}" .rar)
  # echo ${MYBASENAME}
  cp "${MYBASENAME}"/**/*.[oO][tT][fF] ~/Library/Fonts/ 2>/dev/null
  if [ $? -eq 0 ]; then
    echo -e "\t${BGreen}Installed OTF!${NC}"
    rmf "${FONTFILE}"
    rm -rf "${MYBASENAME}/"
  else
    echo -e "\t${BRed}OTF not found in \"${MYBASENAME}\".${NC}"
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

function extract () {
  local remove_archive
  local make_dir
  local success
  local extract_dir
  if (( $# == 0 ))
  then
    cat <<'EOF' >&2
Usage: extract [-option] [file ...]

Options:
    -r, --remove      Remove archive.
    -d, --nomakedir   Don't make a directory from archive name
EOF
  fi
  remove_archive=1
  make_dir=1
  if [[ "$1" = "-r" ]] || [[ "$1" = "--remove" ]]
  then
    remove_archive=0
    shift
  fi
  if [[ "$1" = "-d" ]] || [[ "$1" = "--nomakedir" ]]
  then
    make_dir=0
    shift
  fi
  if [[ "$1" = "-r" ]] || [[ "$1" = "--remove" ]]
  then
    remove_archive=0
    shift
  fi
  while (( $# > 0 ))
  do
    if [[ ! -f "$1" ]]
    then
      echo "extract: '$1' is not a valid file" >&2
      shift
      continue
    fi
    success=0
    extract_dir="${1:t:r}"
    case "$1" in
      (*.tar.gz|*.tgz) (( $+commands[pigz] )) && {
          pigz -dc "$1" | tar xv
        } || tar zxvf "$1" ;;
      (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
      (*.tar.xz|*.txz) tar --xz --help &> /dev/null && tar --xz -xvf "$1" || xzcat "$1" | tar xvf - ;;
      (*.tar.zma|*.tlz) tar --lzma --help &> /dev/null && tar --lzma -xvf "$1" || lzcat "$1" | tar xvf - ;;
      (*.tar) tar xvf "$1" ;;
      (*.gz) (( $+commands[pigz] )) && pigz -d "$1" || gunzip "$1" ;;
      (*.bz2) bunzip2 "$1" ;;
      (*.xz) unxz "$1" ;;
      (*.lzma) unlzma "$1" ;;
      (*.Z) uncompress "$1" ;;
      (*.zip|*.war|*.jar|*.sublime-package|*.ipsw|*.xpi|*.apk)
        (( $make_dir == 0 )) && unzip "$1"
        (( $make_dir == 1 )) && unzip "$1" -d $extract_dir
        ;;
      (*.rar)
        (( $make_dir == 0 )) && unrar x "$1"
        (( $make_dir == 1 )) && unrar x -ad "$1"
        ;;
      (*.7z) 7za x "$1" ;;
      (*.deb) mkdir -p "$extract_dir/control"
        mkdir -p "$extract_dir/data"
        cd "$extract_dir"
        ar vx "../${1}" > /dev/null
        cd control
        tar xzvf ../control.tar.gz
        cd ../data
        extract ../data.tar.*
        cd ..
        rm *.tar.* debian-binary
        cd .. ;;
      (*) echo "extract: '$1' cannot be extracted" >&2
        success=1  ;;
    esac
    (( success = $success > 0 ? $success : $? ))
    (( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
    shift
  done
}