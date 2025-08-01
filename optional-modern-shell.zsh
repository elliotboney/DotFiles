#!/usr/bin/env zsh

# Optional Modern Shell Enhancements
# Source this file ONLY if you want these features
# Usage: echo 'source ~/DotFiles/optional-modern-shell.zsh' >> ~/.zshrc.local

echo "🚀 Loading optional modern shell enhancements..."

# Atuin - Better shell history (if installed)
if command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init zsh)"
    echo "✅ Atuin (better history) loaded"
else
    echo "⚠️  Atuin not installed. Run: brew install atuin"
fi

# Starship - Modern prompt (if installed)  
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
    echo "✅ Starship (modern prompt) loaded"
else
    echo "⚠️  Starship not installed. Run: brew install starship"
fi

# Modern CLI tool aliases (optional)
if [[ "$1" == "--with-aliases" ]]; then
    echo "✅ Loading modern CLI aliases..."
    
    # Better cat with syntax highlighting
    command -v bat >/dev/null && alias cat='bat'
    
    # Better du with visual disk usage  
    command -v dust >/dev/null && alias du='dust'
    
    # Better top with graphs
    command -v btm >/dev/null && alias top='btm'
    
    # Better ps with tree view
    command -v procs >/dev/null && alias ps='procs'
    
    # Better ping with graphs
    command -v gping >/dev/null && alias ping='gping'
    
    echo "✅ Modern aliases loaded (bat, dust, btm, procs, gping)"
fi

echo "🎉 Optional modern shell setup complete!"
echo ""
echo "💡 To make permanent, add to ~/.zshrc.local:"
echo "   source ~/DotFiles/optional-modern-shell.zsh"
echo ""
echo "💡 For aliases too:"  
echo "   source ~/DotFiles/optional-modern-shell.zsh --with-aliases"