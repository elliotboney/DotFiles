#!/usr/bin/env zsh

# Optional FZF Functions
# Source this file ONLY if you want these interactive functions
# Usage: source ~/DotFiles/optional-fzf-functions.zsh

if ! command -v fzf >/dev/null 2>&1; then
    echo "⚠️  FZF not installed. Run: brew install fzf"
    return 1
fi

echo "🔍 Loading optional FZF functions..."

# Git branch switcher with preview
fgb() {
    local branches branch
    branches=$(git for-each-ref --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
    branch=$(echo "$branches" | fzf --height 40% --reverse --info=inline \
        --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" {} | head -20') &&
    git checkout "$branch"
}

# Interactive process killer
fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m --height 40% --reverse --info=inline \
        --preview 'echo {}' --preview-window down:3:wrap | awk '{print $2}')
    
    if [ "x$pid" != "x" ]; then
        echo "$pid" | xargs kill -${1:-9}
    fi
}

# Search and edit files
fe() {
    local files
    IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Fuzzy directory changer (renamed to avoid conflicts)
fcd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m)
    [[ -n "$dir" ]] && cd "$dir"
}

# History search
fh() {
    local cmd
    cmd=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
    echo "$cmd"
    # Add to history without executing - user can press enter to run
    print -s "$cmd"
}

echo "✅ FZF functions loaded: fgb, fkill, fe, fcd, fh"
echo ""
echo "💡 Usage examples:"
echo "   fgb     - Interactive git branch switcher"
echo "   fkill   - Interactive process killer"  
echo "   fe      - Fuzzy file finder and editor"
echo "   fcd     - Fuzzy directory changer"
echo "   fh      - Search command history"