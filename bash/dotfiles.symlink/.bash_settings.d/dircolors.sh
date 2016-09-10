# Execute dir colors
if  command_exists gdircolors; then
    eval $(/usr/local/bin/gdircolors -b ${HOME}/.dotfiles/.bash_settings.d/dircolors)
else
  if $(dircolors &>/dev/null); then
    eval $(dircolors -b ${HOME}/.dotfiles/.bash_settings.d/dircolors)
  fi
fi

#dircolors -b ~/.dotfiles/.bash_setings.d/dircolors
#eval $(gdircolors -b ~/.dotfiles/.dircolors)
# LS_COLORS='no=00;38;5;233:fi=00;38;5;254:rs=0:di=00;38;5;33:ln=00;38;5;14:mh=00:pi=48;5;230;38;5;214;01:so=48;5;230;38;5;214;01:do=48;5;230;38;5;214;01:bd=48;5;230;38;5;244;01:cd=48;5;230;38;5;244;01:or=48;5;235;38;5;160:su=48;5;160;38;5;230:sg=48;5;214;38;5;230:ca=30;41:tw=48;5;64;38;5;230:ow=48;5;235;38;5;33:st=48;5;33;38;5;230:ex=48;5;233;38;5;83:*.dmg=48;5;235;38;5;61:*.iso=48;5;235;38;5;66:*.tar=00;38;5;61:*.tgz=00;38;5;61:*.tlz=00;38;5;61:*.txz=00;38;5;61:*.zip=00;38;5;61:*.z=00;38;5;61:*.dz=00;38;5;61:*.gz=00;38;5;61:*.lz=00;38;5;61:*.xz=00;38;5;61:*.bz2=00;38;5;61:*.bz=00;38;5;61:*.tbz=00;38;5;61:*.tbz2=00;38;5;61:*.tz=00;38;5;61:*.deb=00;38;5;61:*.rpm=00;38;5;61:*.jar=00;38;5;61:*.rar=00;38;5;61:*.7z=00;38;5;61:*.rz=00;38;5;61:*.apk=00;38;5;61:*.gem=00;38;5;61:*.jpg=00;38;5;214:*.gif=00;38;5;214:*.bmp=00;38;5;214:*.tif=00;38;5;214:*.png=00;38;5;214:*.svg=00;38;5;214:*.pcx=00;38;5;214:*.eps=00;38;5;214:*.ico=00;38;5;214:*.xml=00;38;5;205:*Makefile=00;38;5;205:*Rakefile=00;38;5;205:*build.xml=00;38;5;205:*1=00;38;5;205:*.nfo=00;38;5;205:*README=01;38;5;245:*README.txt=01;38;5;245:*readme.txt=01;38;5;245:*.md=01;38;5;245:*README.markdown=01;38;5;245:*.yml=00;38;5;245:*.cfg=00;38;5;245:*.c=01;38;5;245:*.cpp=01;38;5;245:*.cc=01;38;5;245:*.conf=00;38;5;245:*.ini=00;38;5;245:*.log=00;38;5;240:*.txt=00;38;5;240:*.bak=00;38;5;240:*.aux=00;38;5;240:*.bbl=00;38;5;240:*.blg=00;38;5;240:*~=00;38;5;240:*#=00;38;5;240:*.part=00;38;5;240:*.incomplete=00;38;5;240:*.swp=00;38;5;240:*.tmp=00;38;5;240:*.temp=00;38;5;240:*.o=00;38;5;240:*.pyc=00;38;5;240:*.class=00;38;5;240:*.cache=00;38;5;240:*.aac=00;38;5;166:*.au=00;38;5;166:*.flac=00;38;5;166:*.mp3=00;38;5;166:*.m4a=00;38;5;166:*.mov=00;38;5;166:*.mpg=00;38;5;166:*.mkv=00;38;5;166:*.mp4=00;38;5;166:*.m4v=00;38;5;166:*.vob=00;38;5;166:*.wmv=00;38;5;166:*.avi=00;38;5;166:*.flv=00;38;5;166:*.DS_Store=00;38;5;233:*.bash_history=00;38;5;237:*.hushlogin=00;38;5;237:*.hush_login=00;38;5;237:*.gitignore=00;38;5;237:*.CFUserTextEncoding=00;38;5;232:*.Trash/=00;38;5;232:*.Xauthority=00;38;5;232:*.py=00;38;5;119:*.html=00;38;5;56:*rc=00;38;5;174:*config=00;38;5;174:*.gist-vim=00;38;5;174:*.gitconfig=00;38;5;174:*.viminfo=00;38;5;174:*.functions=00;38;5;174:*.aliases=00;38;5;174:*.bash_prompt=00;38;5;174:*.exports=00;38;5;174:*.path=00;38;5;174:*.vimrc.bundles=00;38;5;174:*.mac=00;38;5;174:*.mac=00;38;5;174:*.dircolors=00;38;5;174:*.completion=00;38;5;174:*.bash_profile=00;38;5;174:*.viminfo=00;38;5;174:*.gitignore_global=00;38;5;174:*.mongorc.js=00;38;5;174:*.hgignore_global=00;38;5;174:*.dbshell=00;38;5;174:*.torrent=00;38;5;245:';
export LS_COLORS
