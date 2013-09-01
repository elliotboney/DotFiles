# From
# http://whereswalden.com/2009/10/23/pbcopy-and-pbpaste-for-linux/
case $(uname -s) in
   Darwin)  #MAC
   ;;
   Linux)
      
      alias pbcopy='xsel --clipboard --input'
      alias pbpaste='xsel --clipboard --output'

      alias xcopy='xsel --primary --input'
      alias xpaste='xsel --primary --output'

   ;;
esac
