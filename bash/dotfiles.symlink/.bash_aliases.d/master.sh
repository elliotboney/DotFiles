#!/usr/bin/env bash
# Enable aliases to be sudo’ed
alias sudo='sudo '


# Generic Colorizer
if $(grc &>/dev/null)
  then
  alias tail="grc tail"
fi

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"