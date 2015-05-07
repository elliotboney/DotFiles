#!/usr/bin/env bash
# Enable aliases to be sudo’ed
alias sudo='sudo '


# Generic Colorizer
if $(grc &>/dev/null)
  then
  alias tail="grc tail"
else
  echo -e "${Gray}You should install grc -- sudo aptitude install grc OR brew install grc -- to get sick color outputs"
fi
