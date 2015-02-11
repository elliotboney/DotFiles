#!/usr/bin/env bash
# Enable aliases to be sudo’ed
alias sudo='sudo '


# Generic Colorizer
if $(grc &>/dev/null)
  then
  alias tail="grc tail"
fi
