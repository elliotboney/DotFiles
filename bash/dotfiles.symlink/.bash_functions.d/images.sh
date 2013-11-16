function pngfix ()
{
    if [[ -z "$1" ]]; then
        # echo a help message if no port is specified
        echo -e "\n\t${White}Useage: ${BCyan}pngfix ${LightGray}<filename> ${NC}\n"
    else 
        pngcrush -rem allb -brute -reduce $1 $1.new
        mv $1 $1.bak
        mv $1.new $1
    fi
}

function pngfixall () 
{
    for f in *.png
    do
        pngcrush -rem allb -brute -reduce $f $f.new
        mv $f $f.bak
        mv $f.new $f
    done
}