#!/usr/bin/env bash

# Lazy loading system for heavy functions
# This improves shell startup time by only loading functions when first used

lazy_load() {
    local func=$1
    local file=$2
    
    # Create a wrapper function that loads the real function on first use
    eval "${func}() { 
        unset -f ${func}
        if [[ -f \"${file}\" ]]; then
            source \"${file}\"
            if declare -F \"${func}\" >/dev/null; then
                \"${func}\" \"\$@\"
            else
                echo \"Error: Function '${func}' not found in ${file}\" >&2
                return 1
            fi
        else
            echo \"Error: File '${file}' not found\" >&2
            return 1
        fi
    }"
}

# Lazy load heavy functions (only if files exist)
if [[ -f "${HOME}/.dotfiles/utilities.d/git.sh" ]]; then
    lazy_load "git-wtf" "${HOME}/.dotfiles/utilities.d/git.sh"
    lazy_load "git-updateall" "${HOME}/.dotfiles/utilities.d/git.sh"
fi

if [[ -f "${HOME}/.dotfiles/utilities.d/filesystem.sh" ]]; then
    lazy_load "extract" "${HOME}/.dotfiles/utilities.d/filesystem.sh"
fi

if [[ -f "${HOME}/.dotfiles/utilities.d/general.sh" ]]; then
    lazy_load "cleanup" "${HOME}/.dotfiles/utilities.d/general.sh"
fi

# Add more lazy-loaded functions here as needed
# Example:
# lazy_load "heavy_function" "${HOME}/.dotfiles/utilities.d/heavy.sh"