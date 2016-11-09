# Name Images by Time Shot
alias jpgnames='jhead -n%Y%m%d-%H%M%S *.jpg'

# Make some thumbnails
alias makethumbs='mogrify -resize 480x480 -format jpg -quality 65 -path thumbnails *.jpg'

alias addiepics="mv /Volumes/DSC_FATDISK/DCIM/100IMAGE/*.jpg ~/Dropbox/Pics/Addie\'s\ Camera/"