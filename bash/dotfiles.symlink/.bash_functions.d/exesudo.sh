#! Sudo Stuff
# Wrap a command in sudo
sudowrap () {
    local c="" t="" parse=""
    local -a opt
    #parse sudo args
    OPTIND=1
    i=0
    while getopts xVhlLvkKsHPSb:p:c:a:u: t; do
        if [ "$t" = x ]; then
            parse=true
        else
            opt[$i]="-$t"
            let i++
            if [ "$OPTARG" ]; then
                opt[$i]="$OPTARG"
                let i++
            fi
        fi
    done
    shift $(( $OPTIND - 1 ))
    if [ $# -ge 1 ]; then
        c="$1";
        shift;
        case $(type -t "$c") in
        "")
            echo No such command "$c"
            return 127
            ;;
        alias)
            c="$(type "$c")"
            # Strip "... is aliased to `...'"
            c="${c#*\`}"
            c="${c%\'}"
            ;;
        function)
            c="$(type "$c")"
            # Strip first line
            c="${c#* is a function}"
            c="$c;\"$c\""
            ;;
        *)
            c="\"$c\""
            ;;
        esac
        if [ -n "$parse" ]; then
            # Quote the rest once, so it gets processed by bash.
            # Done this way so variables can get expanded.
            while [ -n "$1" ]; do
                c="$c \"$1\""
                shift
            done
        else
            # Otherwise, quote the arguments. The echo gets an extra
            # space to prevent echo from parsing arguments like -n
            while [ -n "$1" ]; do
                t="${1//\'/\'\\\'\'}"
                c="$c '$t'"
                shift
            done
        fi
        echo sudo "${opt[@]}" -- bash -xvc \""$c"\" >&2
        command sudo "${opt[@]}" bash -xvc "$c"
    else
        echo sudo "${opt[@]}" >&2
        command sudo "${opt[@]}"
    fi
}

# Allow sudowrap to be used in subshells
function exesudo () {
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
    #
    # LOCAL VARIABLES:
    #
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

    #
    # I use underscores to remember it's been passed
    local _funcname_="$1"

    local params=( "$@" )               ## array containing all params passed here
    local tmpfile="/dev/shm/$RANDOM"    ## temporary file
    local filecontent                   ## content of the temporary file
    local regex                         ## regular expression
    local func                          ## function source


    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
    #
    # MAIN CODE:
    #
    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

    #
    # WORKING ON PARAMS:
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    #
    # Shift the first param (which is the name of the function)
    unset params[0]              ## remove first element
    # params=( "${params[@]}" )     ## repack array


    #
    # WORKING ON THE TEMPORARY FILE:
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    content="#!/bin/bash\n\n"

    #
    # Write the params array
    content="${content}params=(\n"

    regex="\s+"
    for param in "${params[@]}"
    do
        if [[ "$param" =~ $regex ]]
            then
                content="${content}\t\"${param}\"\n"
            else
                content="${content}\t${param}\n"
        fi
    done

    content="$content)\n"
    echo -e "$content" > "$tmpfile"

    #
    # Append the function source
    echo "#$( type "$_funcname_" )" >> "$tmpfile"

    #
    # Append the call to the function
    echo -e "\n$_funcname_ \"\${params[@]}\"\n" >> "$tmpfile"


    #
    # DONE: EXECUTE THE TEMPORARY FILE WITH SUDO
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    sudo bash "$tmpfile"
    rm "$tmpfile"
}