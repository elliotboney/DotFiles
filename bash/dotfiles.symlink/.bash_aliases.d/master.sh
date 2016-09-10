# Enable aliases to be sudo’ed
alias sudo='sudo '


# Generic Colorizer
if $(type grc >/dev/null); then
  alias tail="grc tail"
#   # alias cat="grcat ~/.grc/grc.conf"
# else
#   echo -e "${Gray}You should install grc -- sudo aptitude install grc OR brew install grc -- to get sick color outputs"
fi
