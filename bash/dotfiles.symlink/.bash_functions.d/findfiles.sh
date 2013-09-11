findinfiles() 
{
    if [[ -z "$1" ]]; then
        echo 'Useage: findinfiles "text to find" /path/here'
    else
        ggrep --max-count=1 -n -C 1 -r "$1" $2
    fi

}