# # bash completion for the `wp` command

# _wp_complete() {
# 	set cur=${COMP_WORDS[COMP_CWORD]}

# 	IFS=$'\n';  # want to preserve spaces at the end
# 	set opts="$(wp cli completions --line="$COMP_LINE" --point="$COMP_POINT")"

# 	if [[ "$opts" =~ \<file\>\s* ]]
# 	then
# 		COMPREPLY=( $(compgen -f -- $cur) )
# 	elif [[ $opts = "" ]]
# 	then
# 		COMPREPLY=( $(compgen -f -- $cur) )
# 	else
# 		COMPREPLY=( ${opts[*]} )
# 	fi
# }
# complete -o nospace -F _wp_complete wp