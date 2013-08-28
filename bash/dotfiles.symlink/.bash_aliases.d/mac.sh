# Empty the Trash on all mounted volumes and the main HDD
if shell_is_osx; then
  alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"
fi