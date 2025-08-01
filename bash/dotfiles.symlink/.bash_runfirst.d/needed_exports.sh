# --- Start of VS Code Detection ---
COMMAND_TO_FIND="code"
VSCODE_CANDIDATE_PATH="" # Path returned by 'which'
VSCODE_APP_PATH=""       # Variable to store the validated app path for 'code' if confirmed
VSCODE_TYPE="none"       # Will be "insiders", "regular", or "none"

# 1. Use 'which' to find the command 'code'
VSCODE_CANDIDATE_PATH=$(which "$COMMAND_TO_FIND" 2>/dev/null)

if [ -n "$VSCODE_CANDIDATE_PATH" ]; then
  # echo "DEBUG: 'which $COMMAND_TO_FIND' found: $VSCODE_CANDIDATE_PATH"

  # Attempt to get the real, canonical path, resolving symlinks
  # This uses Python for cross-platform robustness.
  # If python is not available or fails, it falls back to VSCODE_CANDIDATE_PATH
  RESOLVED_PATH=$(python -c "import os, sys; print(os.path.realpath(sys.argv[1]))" "$VSCODE_CANDIDATE_PATH" 2>/dev/null)

  if [ -z "$RESOLVED_PATH" ]; then
    # Python method failed or python not found, use the direct path from which
    # This might happen if python isn't there or if VSCODE_CANDIDATE_PATH is weird
    # echo "DEBUG: Python realpath resolution failed or Python not found. Using direct path."
    RESOLVED_PATH="$VSCODE_CANDIDATE_PATH"
  else
    # echo "DEBUG: Resolved path (after symlinks): $RESOLVED_PATH"
  fi

  # Now check the RESOLVED_PATH for the .app string
  if [[ "$RESOLVED_PATH" == *"Visual Studio Code - Insiders.app"* ]]; then
    # echo "INFO: Found VS Code Insiders."
    VSCODE_APP_PATH="$VSCODE_CANDIDATE_PATH" # Use the original `which` output for EDITOR
    VSCODE_TYPE="insiders"
  elif [[ "$RESOLVED_PATH" == *"Visual Studio Code.app"* ]]; then
    # echo "INFO: Found VS Code (Regular)."
    VSCODE_APP_PATH="$VSCODE_CANDIDATE_PATH" # Use the original `which` output for EDITOR
    VSCODE_TYPE="regular"
  else
    # echo "WARNING: '$COMMAND_TO_FIND' (resolved to '$RESOLVED_PATH')"
    # echo "         does not appear to be from a standard VS Code or VS Code Insiders installation."
  fi
else
  echo "INFO: Command '$COMMAND_TO_FIND' not found in PATH by 'which'."
fi
# --- End of VS Code Detection ---

# --- Set EDITOR based on detection ---
if [ -n "$VSCODE_APP_PATH" ]; then
  # A validated 'code' (VS Code or Insiders) was found
  export EDITOR="$VSCODE_APP_PATH"
  # echo "EDITOR set to: $EDITOR (Type: $VSCODE_TYPE)"
else
  # No validated 'code' found, fall back to nvim
  export EDITOR="nvim"
  alias s="nvim"
  # echo "EDITOR set to: $EDITOR"
  if [ -n "$(which s 2>/dev/null)" ] && [ "$(whence -w s)" = "alias" ]; then
    # echo "Alias 's' set to 'nvim'."
  fi
fi

# You can test with:
# echo "Current EDITOR is: $EDITOR"
# To see if the alias 's' is set when nvim is chosen:
# type s

if [ -f "/usr/local/var/pyenv/bin/pyenv" ]; then
   PATH="/usr/local/var/pyenv/bin":$PATH
fi

if [ -d "/opt/homebrew/bin" ]; then
   PATH="/opt/homebrew/bin":$PATH
fi
