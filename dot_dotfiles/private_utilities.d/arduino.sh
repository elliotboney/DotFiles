function aneta8program() {
  if [[ -z "$1" ]]; then
    echo -e "\n\t${White}Useage: ${BCyan}$(basename "${0}") ${LightGray}<firmware file.hex> ${NC}\n"

  else
    avrdude -c usbasp -p atmega1284p -v -v -v -U flash:w:${1}
  fi
}