js () {
  if [[ -z "$1" ]]; then
    # echo -e "\n\t${BCyan} Useage: findinfiles <text to find>\n"
    s "~/.js/"
  else
    result=$(echo $1 | sed 's/https:\/\///g' | sed 's/http:\/\///g' | sed 's/\///g' | sed 's/www\.//g')

    if [ -f $HOME/.js/css/$result.scss ]; then
      cssfile=$HOME/.js/css/$result.scss
    elif [ -f $HOME/.js/css/$result.css ]; then
      cssfile=$HOME/.js/css/$result.css
    else
      cssfile=$HOME/.js/css/$result.scss
    fi

    subl $HOME/.js/ $cssfile $HOME/.js/$result.js
  fi
}