findinfiles() 
{
    if [[ -z "$1" ]]; then
        echo -e "\n\t${BCyan} Useage: findinfiles <text to find>\n"
    else
        ggrep --max-count=1 -n -C 1 -r $1 .
    fi

}

findfiles() 
{
    if [[ -z "$1" ]]; then
        echo -e "\n\t${BCyan} Useage: ${White}findfiles ${Yellow}<${LightGray}text to find${Yellow}>\n"
    else
        find . -iname "*$@*" -ls 
    fi
}

findfilesexec() 
{
    if [[ -z "$1" ]]; then
        echo -e "\n\t${BCyan} Useage: ${White}findfilesexec ${Yellow}<${LightGray}text to find${Yellow}> ${Yellow}<${Red}command using '{}' as found file${Yellow}>\n"
    else
        find . -iname "*$1*" -ok ${@:2} \;
    fi
}