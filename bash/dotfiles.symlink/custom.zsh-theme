# Yay! High voltage and arrows!
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}| %{$reset_color%}%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}⚡%{$fg[green]%}%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="" #%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"

# if [[ `hostname -s` = Elliots-MBP ]]; then
#     PROMPT='%{$fg_no_bold[cyan]%}%n%{$reset_color%}%{$fg[green]%}@%{$reset_color%}%{$terminfo[bold]$fg[green]%}%m%{$reset_color%}%{$fg[red]%}:%{$reset_color%}%{$fg[cyan]%}%0~%{$reset_color%}%{$fg[red]%}|%{$reset_color%}$(git_prompt_info)%{$fg[cyan]%}⇒%{$reset_color%}  '
# else
#     PROMPT='%{$fg[magenta]%}%n%{$reset_color%}%{$fg[cyan]%}@%{$reset_color%}%{$fg[red]%}%m%{$reset_color%}%{$fg[red]%}:%{$reset_color%}%{$fg[cyan]%}%0~%{$reset_color%}%{$fg[red]%}|%{$reset_color%}$(git_prompt_info)%{$fg[cyan]%}⇒%{$reset_color%}  '
# fi
HOST=`hostname -s`
if [ `hostname -s` = "elliot"  ] || [ `hostname -s` = "Elliots-MacBook-Proz" ]; then
  local user='%{$fg[cyan]%}%n%{$fg[cyan]%}@%{$fg[magenta]%}%m%{$reset_color%}%{$fg[yellow]%}:'
  local pwd='%{$fg[green]%}%~%{$reset_color%}'

else
  local user='%{$fg[magenta]%}%n%{$fg[cyan]%}@%{$fg[green]%}%m%{$reset_color%}%{$fg[yellow]%}:'
  local pwd='%{$fg[magenta]%}%~%{$reset_color%}'
fi

# local rvm=''
# if which rvm-prompt &> /dev/null; then
#   rvm='%{$fg[green]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
# else
#   if which rbenv &> /dev/null; then
#     rvm='%{$fg[green]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
#   fi
# fi
local return_code='%(?..%{$fg[red]%}%? ↵%{$reset_color%})'
local git_branch='$(git_prompt_status) %{$reset_color%}$(git_prompt_info)%{$reset_color%}'
local final='%{$fg[cyan]%}⇒%{$reset_color%} '

local git_branch='$(git_prompt_status) %{$reset_color%}$(git_prompt_info)%{$reset_color%}'



PROMPT="${user} ${pwd}${git_branch} ${final} "
RPROMPT="${return_code} ${git_branch}"
#" ${rvm}"
