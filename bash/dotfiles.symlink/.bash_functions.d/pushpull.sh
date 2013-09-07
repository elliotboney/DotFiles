function pushimage () {
  cat $1 | ssh profit "cat > /var/www/images/$1"
}