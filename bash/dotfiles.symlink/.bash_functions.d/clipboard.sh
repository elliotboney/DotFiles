#! Clipboard Stuff
if shell_is_linux; then
      alias pbcopy='xsel --clipboard --input'
      alias pbpaste='xsel --clipboard --output'

      alias xcopy='xsel --primary --input'
      alias xpaste='xsel --primary --output'
fi
