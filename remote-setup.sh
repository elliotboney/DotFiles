#!/usr/bin/env bash

# [[ -x `command -v wget` ]] && CMD="wget --no-check-certificate -O -"
# [[ -x `command -v curl` ]] >/dev/null 2>&1 && CMD="curl -#L"

# if [ -z "$CMD" ]; then
#   echo "No curl or wget available. Aborting."
# else
  echo "Installing DotFiles"
  mkdir -p "$HOME/DotFiles" && \
  eval "curl https://github.com/elliotboney/DotFiles/tarball/master | tar -xzv -C ~/.DotFiles --strip-components=1 --exclude='{.gitignore}'"
  . "$HOME/DotFiles/setup"
# fi